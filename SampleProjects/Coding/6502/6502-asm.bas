'#define ShowOrgLines
'#define DebugCompilation
'#define DebugLabelFix
'#define IgnoreLinesWithoutCode

'#define UseLocalObj

#include "crt.bi"

#macro ClearStruct( _var )
  scope
    dim as typeof(_var) __temp__##_var
    _var = __temp__##_var
  end scope
#endmacro

type LabelStruct 
  sName as zstring*56
  uAddr as long
  b16   as ubyte
end type
type ParserStruct
  sCode as string
  as long iLineNum,iCodeSz,iPos,iTotalSz
  as long iTokenStart = -1, iLineStart = 0, iChar
  as long iTokenNum , iHadLabel
  as long uAddress = &h600
  as long uAddressMin = &h600
end type
type PatchStruct  
  iLabel     as ushort
  iLine      as ushort
  uAddress   as ushort
  bAbs       as byte
  bHi        as byte
end type
type BlockStruct
  uBegin as ushort
  uEnd   as ushort
end type

#ifdef __FB_NDS__
  static shared as LabelStruct g_tLabel(511)
  static shared as PatchStruct g_tPatch(511)
  static shared as BlockStruct g_tBlock(63)
#else
  redim shared as LabelStruct g_tLabel(15)
  redim shared as PatchStruct g_tPatch(15)
  redim shared as BlockStruct g_tBlock(15)
#endif
dim shared as long g_iLabelsCount , g_iPatchCount , g_iBlockCount

static shared as ubyte g_bMemory(65536-1) = any
static shared as byte g_bMemChg(65536-1) = any
static shared as long g_lPosition(65536-1) = any
static shared as long g_lLineIndex(65536-1) = any
static shared as ushort g_wLineAddr(65536-1) = any
static shared as ParserStruct g_tParser

#ifdef AlignedOnly
  #define Write16( _addr , _val ) g_bMemory( _addr ) = ((_val) and &hFF) : g_bMemory( (_addr)+1 ) = (((_val) shr 8) and &hFF)
  #define Write16Ex( _arr , _addr , _val ) _arr( _addr ) = ((_val) and &hFF) : _arr( (_addr)+1 ) = ((culng(_val) shr 8) and &hFF)
  #define Read16( _addr ) ((clng(g_bMemory((_addr)+1))*256)+g_bMemory(_addr))
#else
  #define Write16( _addr , _val ) *cptr(ushort ptr,@g_bMemory( _addr )) = (_val)
  #define Write16Ex( _arr , _addr , _val ) *cptr(ushort ptr,@_arr( _addr )) = (_val)
  #define Read16( _addr ) (*cptr(ushort ptr,@g_bMemory( _addr )))
#endif

function GetLabel( sLabel as string , byref iAddr as long = 0 ) as long
  var sLabelL = lcase(sLabel)
  for N as long = 0 to g_iLabelsCount-1
    'color 14 : printf(!"#%i='%s'%s'\n",N,g_tLabel(N).sName,sLabelL):sleep
    if sLabelL = g_tLabel(N).sName then 
      'if g_tLabel(N).uAddr = -1 then return -1
      iAddr = g_tLabel(N).uAddr      
      'color 10: puts("!")
      return N
    end if
  next N
  return -1
end function
function AddLabel( sLabel as string , uAddr as long , b16 as byte = true ) as long
  dim as long iExistAddr
  var iIdx = GetLabel( sLabel , iExistAddr )
  if iIdx < 0 then    
    #ifndef __FB_NDS__
    if g_iLabelsCount = ubound(g_tLabel) then
      redim preserve g_tLabel( ((g_iLabelsCount+1)*2)-1 )
    end if
    #endif    
    g_tLabel(g_iLabelsCount).sName = lcase(sLabel)
    'color 11:printf(!"#%i='%s'\n",g_iLabelsCount,g_tLabel(g_iLabelsCount).sName):sleep
    g_tLabel(g_iLabelsCount).uAddr = uAddr
    g_tLabel(g_iLabelsCount).b16 = b16
    g_iLabelsCount += 1
    
    return g_iLabelsCount-1
  end if
  if uAddr >= 0 orelse iExistAddr < 0 then
    g_tLabel(iIdx).uAddr = uAddr
    g_tLabel(iIdx).b16 = b16
    return iIdx
  end if
  return -1
end function
function AddPatch( tPatch as PatchStruct ) as long
  #ifndef __FB_NDS__
  if g_iPatchCount = ubound(g_tPatch) then
    redim preserve g_tPatch( ((g_iPatchCount+1)*2)-1 )
  end if
  #endif
  g_tPatch(g_iPatchCount) = tPatch
  g_iPatchCount += 1
  return g_iPatchCount-1
end function
function AddBlock( uBegin as long , uEnd as long ) as long
  #ifndef __FB_NDS__
  if g_iBlockCount = ubound(g_tBlock) then
    redim preserve g_tBlock( ((g_iBlockCount+1)*2)-1 )
  end if
  #endif
  'print hex$(uBegin),hex$(uEnd)
  memset( @g_bMemChg(uBegin) , 2 , uEnd-uBegin )
  g_tBlock(g_iBlockCount).uBegin = uBegin
  g_tBlock(g_iBlockCount).uEnd   = uEnd
  g_iBlockCount += 1
  return g_iBlockCount-1
end function

#ifdef UseLocalObj
  #define _tParser_ tParser
  #define _tParser tParser as ParserStruct
  #define _tParserAnd_ tParser as ParserStruct ,
  #define tParserAnd_ tParser ,
  #define _Begin with tParser
  #define _End end with
#else
  #define _tParser_ 
  #define _tParser 
  #define _tParserAnd_ 
  #define tParserAnd_
  #define _Begin with g_tParser
  #define _End end with
#endif

type OpcodeFunction as function ( _tParserAnd_ iOpcodeIndex as long ) as long
type AddrModes
  bInherent    as ubyte 'fixed / no parameters
  bAccumulator as ubyte 'accumulator 
  bImmediate   as ubyte 'immediate value
  bZeroPage    as ubyte 'zero page 8bit
  bZeroPageX   as ubyte 'zero page 8bit + X (8bit wrap)
  bAbsolute    as ubyte '16bit absolute
  bAbsoluteX   as ubyte '16bit absolute + X
  bAbsoluteY   as ubyte '16bit absolute + Y
  bIndirect    as ubyte '16bit [8bit]
  bIndirectX   as ubyte '16bit [8bit+X]
  bIndirectY   as ubyte '16bit [8bit]+Y
end type
type OpcodeStruct
  zName    as zstring*8
  tOpcodes as AddrModes
  fnEval   as OpcodeFunction
end type

function NoMoreParms_( _tParser ) as long
  _Begin
    do
      select case .sCode[.iPos]
      case asc(";"),13,10,0 : return 1
      case 9,32
      case else
        color 12: printf(!"ERROR: bad character after opcode '%c'\n",(.sCode[.iPos]))
        return -1
      end select
      .iPos += 1
    loop
  _End  
end function
#define NoMoreParms() NoMoreParms_( _tParser_ )
sub EndOfLine_( _tParser )
  _Begin
    while .sCode[.iPos] andalso .sCode[.iPos] <> 10 
      .iPos += 1
    wend   
    .iPos -= 1
  _End
end sub
#define EndOfLine() EndOfLine_( _tParser_ ) 

function op___( _tParserAnd_ iOpcodeIndex as long ) as long
  color 12: printf(!"ERROR: opcode not implemented\n")
  return -1
end function  
declare function    opNop( _tParserAnd_ iOpcodeIndex as long   ) as long 'no parameter opcodes
declare function    opMod( _tParserAnd_ iOpcodeIndex as long   ) as long 'normal addressing behavior?
declare function    opJmp( _tParserAnd_ iOpcodeIndex as long   ) as long 'jump addressing behavior?
declare function DeclByte( _tParserAnd_ iOpcodeIndex as long=-1) as long 'declare byte directive
declare function DefConst( _tParserAnd_ iOpcodeIndex as long=-1) as long 'define a constant

'         Fix  Acc  Imm  ZP   ZpX  Abs  AbsX AbsY Ind  IndX IndY   Func     
#define _NoOpcode_ -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 
static shared as OpcodeStruct tOpcode(...) = { _
  ("ADC",( -1 , -1 ,&h69,&h65,&h75,&h6D,&h7D,&h79, -1 ,&h61,&h71),@opMod), _
  ("AND",( -1 , -1 ,&h29,&h25,&h35,&h2D,&h3D,&h39, -1 ,&h21,&h31),@opMod), _
  ("ASL",( -1 ,&h0A, -1 ,&h06,&h16,&h0E,&h1E, -1 , -1 , -1 , -1 ),@opMod), _
  ("BCC",( -1 , -1 ,&h90, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BCS",( -1 , -1 ,&hB0, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BEQ",( -1 , -1 ,&hF0, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BIT",( -1 , -1 , -1 ,&h24, -1 ,&h2C, -1 , -1 , -1 , -1 , -1 ),@opMod), _
  ("BMI",( -1 , -1 ,&h30, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BNE",( -1 , -1 ,&hD0, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BPL",( -1 , -1 ,&h10, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BRK",(&h00, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("BVC",( -1 , -1 ,&h50, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("BVS",( -1 , -1 ,&h70, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  ("CLC",(&h18, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("CLD",(&hD8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("CLI",(&h58, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("CLV",(&hB8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  _ '     Fix  Acc  Imm  ZP   ZpX  Abs  AbsX AbsY Ind  IndX IndY   Func       
  ("CMP",( -1 , -1 ,&hC9,&hC5,&hD5,&hCD,&hDD,&hD9, -1 ,&hC1,&hD1),@opMod), _
  ("CPX",( -1 , -1 ,&hE0,&hE4, -1 ,&hEC, -1 , -1 , -1 , -1 , -1 ),@opMod), _
  ("CPY",( -1 , -1 ,&hC0,&hC4, -1 ,&hCC, -1 , -1 , -1 , -1 , -1 ),@opMod), _
  ("DEC",( -1 , -1 , -1 ,&hC6,&hD6,&hCE,&hDE, -1 , -1 , -1 , -1 ),@opMod), _
  ("DEX",(&hCA, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("DEY",(&h88, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("EOR",( -1 , -1 ,&h49,&h45,&h55,&h4D,&h5D,&h59, -1 ,&h41,&h51),@opMod), _
  ("INC",( -1 , -1 , -1 ,&hE6,&hF6,&hEE,&hFE, -1 , -1 , -1 , -1 ),@opMod), _
  ("INX",(&hE8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("INY",(&hC8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("JMP",( -1 , -1 , -1 , -1 , -1 ,&h4C, -1 , -1 ,&h6C, -1 , -1 ),@opJmp), _
  ("JSR",( -1 , -1 , -1 , -1 , -1 ,&h20, -1 , -1 , -1 , -1 , -1 ),@opJmp), _
  _ '     Fix  Acc  Imm  ZP   ZpX  Abs  AbsX AbsY Ind  IndX IndY   Func       
  ("LDA",( -1 , -1 ,&hA9,&hA5,&hB5,&hAD,&hBD,&hB9, -1 ,&hA1,&hB1),@opMod), _  
  ("LDX",( -1 , -1 ,&hA2,&hA6,&hB6,&hAE, -1 ,&hBE, -1 , -1 , -1 ),@opMod), _
  ("LDY",( -1 , -1 ,&hA0,&hA4,&hB4,&hAC,&hBC, -1 , -1 , -1 , -1 ),@opMod), _
  ("LSR",( -1 ,&h4A, -1 ,&hA6,&h56,&h4E,&h5E, -1 , -1 , -1 , -1 ),@opMod), _
  ("NOP",(&hEA, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("ORA",( -1 , -1 ,&h09,&h05,&h15,&h0D,&h1D,&h19, -1 ,&h01,&h11),@opMod), _ 
  ("PHA",(&h48, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("PHP",(&h08, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("PLA",(&h68, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("PLP",(&h28, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("ROL",( -1 ,&h2A, -1 ,&h26,&h36,&h2E,&h3E, -1 , -1 , -1 , -1 ),@opMod), _
  ("ROR",( -1 ,&h6A, -1 ,&h66,&h76,&h6E,&h7E, -1 , -1 , -1 , -1 ),@opMod), _
  ("RTI",(&h40, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("RTS",(&h60, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  _ '     Fix  Acc  Imm  ZP   ZpX  Abs  AbsX AbsY Ind  IndX IndY   Func       
  ("SBC",( -1 , -1 ,&hE9,&hE5,&hF5,&hED,&hFD,&hF9, -1 ,&hE1,&hF1),@opMod), _
  ("SEC",(&h38, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("SED",(&hF8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("SEI",(&h78, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("STA",( -1 , -1 , -1 ,&h85,&h95,&h8D,&h9D,&h99, -1 ,&h81,&h91),@opMod), _
  ("STX",( -1 , -1 , -1 ,&h86,&h96,&h8E, -1 , -1 , -1 , -1 , -1 ),@opMod), _ 'its ZpY for this one
  ("STY",( -1 , -1 , -1 ,&h84,&h94,&h8C, -1 , -1 , -1 , -1 , -1 ),@opMod), _
  ("TAX",(&hAA, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("TAY",(&hA8, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("TSX",(&hBA, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("TXA",(&H8A, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("TXS",(&h9A, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _
  ("TYA",(&h98, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ),@opNop), _           
  ("DCB"   ,( _NoOpcode_ ), @DeclByte ) , _
  ("DEFINE",( _NoOpcode_ ), @DefConst ) }
rem ---------------------------------------------------------------------------
#undef _NoOpcode_

function ProcessEOL_( _tParser ) as long  
  _Begin    
    .sCode[.iPos-1] = 0
    'color 8 : print *cast(zstring ptr,strptr(.sCode)+.iLineStart)    
    #ifdef ShowOrgLines    
      #ifdef IgnoreLinesWithoutCode
        if .iHadLabel orelse .iTokenNum then        
      #endif          
      if .iTokenNum then locate csrlin()-1,32 else locate ,32
      color 8 : puts(left(*cast(zstring ptr,strptr(.sCode)+.iLineStart),(width2() and &hFF)-32))
      '.sCode[.iPos-1] = .iChar
      #ifdef IgnoreLinesWithoutCode
        end if
      #endif            
    #endif
    #ifdef DebugCompilation
      'if .iTokenNum then sleep
    #endif
    
    g_lLineIndex(.iLineNum) = .iLineStart
    'andalso g_lPosition(.uAddress) < 0
    'if .iTokenNum then 
      g_lPosition(.uAddress) = .iLineNum+1
    'end if
    .iLineNum += 1      : .iTokenStart = -1
    .iLineStart = .iPos : .iTokenNum = 0    : .iHadLabel = 0
    g_wLineAddr(.iLineNum) = .uAddress
    if .iChar=0 then return 0
    return 1
  _End
end function
#define ProcessEOL() ProcessEOL_( _tParser_ )
sub ProcessError_( _tParser )
  _Begin
    printf(!"'%c'\n",.iChar)
    if .iTokenNum=0 then      
      puts("S/N Error")
      EndOfLine() ': ProcessEOL()
      .sCode[.iPos] = 0
      color 8 : puts(*cast(zstring ptr,strptr(.sCode)+.iLineStart))
      .sCode[.iPos] = .iChar
    end if
  _End
end sub
#define ProcessError() ProcessError_( _tParser_ ) 

function NextChar_( _tParser ) as ubyte
  _Begin
    do
      .iChar = .sCode[.iPos]
      select case .iChar
      case 32,9
      case else
        return .iChar
      end select
      .iPos += 1
    loop
  _End
end function
#define NextChar() NextChar_( _tParser_ )
#define ReadChar() clng(.sCode[.iPos]) : .iPos += 1
#define GetChr()  clng(.sCode[.iPos])

function TranslateAddressing( _tParserAnd_ iOpcodeIndex as long , bJump as bool = false ) as long
  
  'Immediate     ADC #$44      $69  2   2
  'Zero Page     ADC $44       $65  2   3
  'Zero Page,X   ADC $44,X     $75  2   4
  'Absolute      ADC $4400     $6D  3   4
  'Absolute,X    ADC $4400,X   $7D  3   4+
  'Absolute,Y    ADC $4400,Y   $79  3   4+
  'Indirect,X    ADC ($44,X)   $61  2   6
  'Indirect,Y    ADC ($44),Y   $71  2   5+
  
  dim as byte bImm,bHex,bHi,bAddr,bDigCnt,bIndi,bReg  
  dim as long uVal, iChar
  dim as string sParam
      
  _Begin
    var pOp = @tOpcode(iOpcodeIndex)
    do
      iChar = ReadChar()
      select case iChar
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_") 'is it a label or A(ccumulator)?
        'grab remainder of the label
        var pzStart = cast(zstring ptr,@.sCode[.iPos-1])
        do
          iChar = ReadChar()
          select case iChar
          case asc("A") to asc("Z"),asc("a") to asc("z")
          case asc("0") to asc("9"),asc("_") : rem ok
          case else : exit do
          end select
        loop        
        .iPos -= 1
        .sCode[.iPos]=0 : sParam = *pzStart 
        .sCode[.iPos]=iChar 
        exit do
      case asc("(")                                        'indirect?
        if bIndi=0 andalso bImm=0 andalso bAddr=0 then
          bIndi = 1
        else
          color 12 : puts("Syntax Error, found '('") : return -1
        end if
      case asc("#")                                        'immediate?
        if bIndi then color 12 : puts("ERROR: expected address found #"): return -1
        if bImm = 0 then
          bImm = 1
        else
          color 12 : puts("ERROR: expected immediate... found #"): return -1
        end if
      case asc("0") to asc("9"),asc("-"),asc("+")          'adddress or immediate (DEC)
        var iNum = 0 , iSgn = 1 : bDigCnt = 0
        do
          if iNum > 65535 then
            color 12 : puts("Number too big")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")
            iNum = (iNum*10)+iChar-asc("0")    : bDigCnt += 1
          case 13,10,0,32,9                      'end of token
            .iPos -= 1
            exit do
          case asc(","),asc(";"),asc(")")        'end of token
            .iPos -= 1
          case else                              'invalid char
            color 12 : printf("Invalid decimal caracter '")
            if iChar < 32 or iChar > 127 then printf("0x%02X'",iChar) else printf(!"%c'",iChar)
            return -1
          end select
          iChar = ReadChar()
          '.iPos += 1 : iChar = GetChr()
        loop        
        uVal = iNum*iSgn
        if bImm=0 then bAddr = 1
        exit do
      case asc("$")                                        'address (HEX)?
        var iNum = 0 , iSgn = 1 : bDigCnt = 0        
        iChar = NextChar()
        do 
          if iNum > 65535 then
            color 12 : puts("Number too big")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")               'digit 0-9
            iNum = (iNum shl 4)+iChar-asc("0")    : bDigCnt += 1
          case asc("A") to asc("F")               'digit A-F
            iNum = (iNum shl 4)+iChar-asc("A")+10 : bDigCnt += 1
          case asc("a") to asc("f")               'digit a-f
            iNum = (iNum shl 4)+iChar-asc("a")+10 : bDigCnt += 1
          case 13,10,0,32,9                       'end of token
            '.iPos -= 1 : 
            exit do
          case asc(","),asc(")"),asc(";")
            '.iPos -= 1 : 
            exit do
          case else
            color 12 : printf("Invalid Hex caracter '")
            if iChar < 32 or iChar > 127 then printf !"0x%02X'",iChar else printf !"%c'",iChar
            return -1
          end select
          .iPos += 1 : iChar = GetChr()
        loop  
        uVal = iNum*iSgn : bHex = 1
        if bImm=0 then bAddr = 1
        exit do
      case asc("<")                                        'lo address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found <"): return -1
          else
            bHi = -1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case asc(">")                                        'hi address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found >"): return -1
          else
            bHi = 1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case 32,9    'skip spaces/tabs
      case 13,10,0,asc("'"),asc(";") 'eol
        exit do
      case else
        color 12 : printf(!"Syntax Error found '%c'\n",iChar) : return -1
      end select
    loop    
    
    #if 0
      bAccumulator as ubyte 'accumulator 
      bImmediate   as ubyte 'immediate value
      bZeroPage    as ubyte 'zero page 8bit
      bZeroPageX   as ubyte 'zero page 8bit + X (8bit wrap)
      bAbsolute    as ubyte '16bit absolute
      bAbsoluteX   as ubyte '16bit absolute + X
      bAbsoluteY   as ubyte '16bit absolute + Y
      bIndirect    as ubyte '16bit [8bit]
      bIndirectX   as ubyte '16bit [8bit+X]
      bIndirectY   as ubyte '16bit [8bit]+Y
    #endif
    
    dim as byte bOpcode = 0
    
    if len(sParam) then 
      #define IsRegA (len(sParam) andalso (sParam[0] and (not &h20)) = asc("A"))
      bOpcode = pOp->tOpcodes.bAccumulator      
      if IsRegA andalso bOpcode<>-1 then
        bReg = asc("A")
      else
        var iN = GetLabel(sParam,uVal)
        if iN<0 orelse uVal = -1 then
          uVal = 0
          dim as PatchStruct tPatch = any          
          tPatch.iLine      = .iLineNum+1
          tPatch.iLabel     = AddLabel(sParam,-1)          
          tPatch.uAddress   = .uAddress+1
          tPatch.bAbs       = pOp->tOpcodes.bAbsolute
          tPatch.bHi        = bHi          
          AddPatch( tPatch )
          'color 13 : puts("Adding label to late list...")
          bDigCnt = 4
        else
          bDigCnt = iif(g_tLabel(iN).b16,4,2) 
        end if
        if bJump then bImm = 0 
        bAddr = 1 : bHex=1 : 
      end if
    elseif bImm=0 andalso bAddr=0 then      
      bOpcode = pOp->tOpcodes.bAccumulator
      if bOpcode = -1 then 
        color 12 : puts("ERROR: Incomplete instruction"): return -1
      end if
      bReg = asc("A")
    end if
    
    if bHi > 0 then uVal = (uVal shr 8) and &hFF : bDigCnt = 2
    if bHi < 0 then uVal and= &hFF               : bDigCnt = 2
    
    
    if bJump then
      bOpcode = pOp->tOpcodes.bImmediate
      if bOpcode = -1 then bOpcode = iif(bIndi,pOp->tOpcodes.bIndirect,pOp->tOpcodes.bAbsolute)
      if (bImm=0 andalso bAddr=0) then
        color 12 : puts("Expected address or label for jump instruction"): return -1
      end if
      if bOpcode = -1 then
        color 12 : puts("Invalid address mode for this instruction"): return -1
      end if
    elseif bImm then 
      if uVal < -128 orelse uVal > 255 then
        color 12 : puts("Overflow byte immediate"): return -1
      end if
      bOpcode = pOp->tOpcodes.bImmediate
      if bOpcode = -1 then
        color 12 : puts("Immediate number not valid for this instruction"): return -1
      end if
    elseif bAddr then      
      if iChar = asc(")") then
        if bIndi=0 then color 12: puts("Bad addressing mode"): return -1
        .iPos += 1 : iChar = NextChar() : bIndi=2
      end if
      if iChar = asc(",") then '2nd parameter can be X or Y        
        .iPos += 1 : iChar = NextChar() and (not &h20)' : .iPos += 1
        'print iChar,chr(iChar),GetChr(),chr(GetChr())
        if iChar = asc("X") orelse iChar = asc("Y") then
          bReg = iChar
        else
          color 12: puts("Bad addressing mode"): return -1
        end if        
      end if
      
      #define Is16BitOpcode (pOp->tOpcodes.bZeroPage=&hFF)
      #define Is16BitValue ((bHex andalso bDigCnt>2) orelse (bDigCnt > 3 orelse uVal < -128 orelse uVal > 255))
      if bIndi then
        if (uVal < -128 orelse uVal > 255) then color 12 : puts("Indirect mode must use zero page (8bit) adressing"): return -1                        
        bOpcode = -2
        dim as zstring ptr pzMode = any 
        'print chr(bReg),bIndi
        if bReg = asc("X") andalso bIndi=1 then          
          bOpcode = pOp->tOpcodes.bIndirectX
          pzMode = @"[addr+X]"
        elseif bReg = asc("Y") andalso bIndi=2 then          
          bOpcode = pOp->tOpcodes.bIndirectY
          pzMode = @"[addr]+Y"
        else
          color 12: puts("Bad syntax for addressing mode"): return -1
        end if        
        if bOpcode = -1 then
          color 12 : printf(!"%s Indirect Addressing not valid for this instruction\n",pzMode): return -1
        end if
      elseif Is16BitOpcode orelse Is16BitValue then '16 bit
        dim as zstring ptr pzMode = @"Absolute"
        if bReg = asc("X") then
          bOpcode = pOp->tOpcodes.bAbsoluteX : pzMode = @"Absolute with X"
        elseif bReg = asc("Y") then
          bOpcode = pOp->tOpcodes.bAbsoluteY : pzMode = @"Absolute with Y"
        else
          bOpcode = pOp->tOpcodes.bAbsolute
        end if
        if bOpcode = -1 then
          color 12 : printf(!"%s Absolute Addressing not valid for this instruction\n",pzMode): return -1
        end if
      else '8bit
        dim as zstring ptr pzMode = @"Zero Page"
        if bReg = asc("X") then
          bOpcode = pOp->tOpcodes.bZeroPageX : pzMode = @"Zero Page with X"
        elseif bReg = asc("Y") then
          color 12: puts("Bad addressing mode"): return -1
        else
          bOpcode = pOp->tOpcodes.bZeroPage
        end if
        if bOpcode = -1 then
          color 12 : printf(!"%s Addressing not valid for this instruction\n",pzMode): return -1
        end if      
      end if
    end if
    
    #ifdef DebugCompilation
      color 7 : printf("%04X ",.uAddress)
      color 10: printf(!"%02X %s ",bOpcode,tOpcode( iOpcodeIndex ).zName)
    #endif
    g_bMemory( .uAddress ) = bOpcode : .uAddress += 1
        
    if bJump then 'len(sParam) then
      '.uAddress
      if pOp->tOpcodes.bAbsolute <> &hFF andalso bHi=0 then
        Write16( .uAddress , uVal ) : .uAddress += 2
      elseif pOp->tOpcodes.bImmediate <> &hFF then        
        g_bMemory( .uAddress ) = uVal-(.uAddress+1) : .uAddress += 1
      end if      
    elseif bAddr orelse bImm then 
      if bHex then
        if bDigCnt > 2 then 
          Write16( .uAddress , uVal ) : .uAddress += 2
        else
          g_bMemory( .uAddress ) = uVal : .uAddress += 1
        end if
      else
        if bDigCnt > 3 orelse uVal>255 then 
          Write16( .uAddress , uVal ) : .uAddress += 2
        else 
          g_bMemory( .uAddress ) = uVal : .uAddress += 1
        end if
      end if    
    end if
    
    #ifdef DebugCompilation
      if bReg = asc("A") then
        color 10 : puts("A")
      elseif bJump then
        color 14: printf(!"%04X %c\n",hex$(uVal and &hFFFF,4),iif(uVal andalso uVal<.uAddress,asc("^"),asc("v"))
      elseif bAddr orelse bImm then 
        'color 7 : print hex$(.uAddress,4);" "; 
        color 3
        if bHex then          
          if bDigCnt > 2 then printf(!"0x%04X\n",uVal and &hFFFF) else printf(!"0x%02X\n",uVal and &hFF)
        else        
          if bDigCnt > 3 orelse uVal>255 then printf(!"%05i\n",(uVal and &hFFFF)) else printf(!"%03i\n",(uVal and &hFF))
        end if    
      else
        puts("????")
      end if
    #endif
    
    'end?
    'while .sCode[.iPos] andalso .sCode[.iPos] <> 10 : .iPos += 1 : wend
    
  _End
end function

function    opNop( _tParserAnd_ iOpcodeIndex as long ) as long 'no parameter opcodes
  _Begin    
    var bOpcode = tOpcode( iOpcodeIndex ).tOpcodes.bInherent    
    #ifdef DebugCompilation
      color 7 : printf("%04X ",.uAddress,4)
      color 10: printf("%02X %s",bOpcode,tOpcode( iOpcodeIndex ).zName)
    #endif
    g_bMemory( .uAddress ) = bOpcode
    .uAddress += 1 : return NoMoreParms()  
  _End
end function
function    opMod( _tParserAnd_ iOpcodeIndex as long ) as long
  _Begin
    return TranslateAddressing( tParserAnd_ iOpcodeIndex )
  _End
end function
function    opJmp( _tParserAnd_ iOpcodeIndex as long ) as long
  _Begin
    return TranslateAddressing( tParserAnd_ iOpcodeIndex , true )
  _End
end function
function DeclByte( _tParserAnd_ iOpcodeIndex as long = -1 ) as long 'dcb
  dim as byte bImm,bHex,bHi,bDigCnt,bLab
  dim as long uVal,uCnt
  dim as string sParam
    
  _Begin
    do 'grab define value
      var iChar = ReadChar()
      select case iChar
      case asc("""")
        do
          iChar = ReadChar()
          select case iChar
          case 13,10,0
            .iPos -= 1: exit do
          case asc("""")
            exit do          
          case else 
            g_bMemory( .uAddress ) = iChar : .uAddress += 1 : uCnt += 1 
          end select
        loop
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_") 'is it a label?
        'grab remainder of the label
        var pzStart = cast(zstring ptr,@.sCode[.iPos-1])
        do
          iChar = ReadChar()
          select case iChar
          case asc("A") to asc("Z"),asc("a") to asc("z")
          case asc("0") to asc("9"),asc("_") : rem ok
          case else : exit do
          end select
        loop                
        .iPos -= 1 : bImm = 1 : bLab = 1
        .sCode[.iPos]=0 : sParam = *pzStart 
        .sCode[.iPos]=iChar
      case asc("#")                                        'immediate?
        if bImm = 0 then
          bImm = 1
        else
          color 12 : puts("ERROR: expected immediate... found #"): return -1
        end if
      case asc("0") to asc("9"),asc("-"),asc("+")          'immediate (DEC)
        var iNum = 0 , iSgn = 1 : bDigCnt = 0
        do
          if iNum > 65535 then
            color 12 : puts("number too big!")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")
            iNum = (iNum*10)+iChar-asc("0")    : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")    'end of token
            .iPos -= 1
            exit do
          case else                              'invalid char
            color 12 : printf("Invalid decimal caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          iChar = ReadChar()
        loop
        uVal = iNum*iSgn : bImm=1        
      case asc("$")                                        'address (HEX)?
        var iNum = 0 , iSgn = 1 : bDigCnt = 0        
        iChar = NextChar()
        do 
          if iNum > 65535 then
            color 12 : puts("Number too big")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")               'digit 0-9
            iNum = (iNum shl 4)+iChar-asc("0")    : bDigCnt += 1
          case asc("A") to asc("F")               'digit A-F
            iNum = (iNum shl 4)+iChar-asc("A")+10 : bDigCnt += 1
          case asc("a") to asc("f")               'digit a-f
            iNum = (iNum shl 4)+iChar-asc("a")+10 : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")     'end of token
            '.iPos -= 1 
            exit do          
          case else
            color 12 : printf("Invalid Hex caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          .iPos += 1 : iChar = GetChr()
        loop  
        uVal = iNum*iSgn : bHex = 1 : bImm = 1
      case asc("<")                                        'lo address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found <"): return -1
          else
            bHi = -1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case asc(">")                                        'hi address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found >"): return -1
          else
            bHi = 1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case 32,9    'skip spaces/tabs
      case 13,10,0,asc(";"),asc(",")              'eol
        g_lPosition(.uAddress) = .iLineNum+1
        if bImm = 0 andalso uCnt=0 then color 12 : puts("Expected immediate") : return -1        
        #ifdef DebugCompilation
          if uCnt = 0 then 
            color 7 : printf("%04X ",.uAddress)
            color 11: printf("%s ",tOpcode( iOpcodeIndex ).zName)
          end if
        #endif
        if bLab then color 6 else color 3
        if bHi > 0 then uVal = (uVal shr 8)
        #ifdef DebugCompilation
          if bHex then         
            printf ("0x%02X",uVal and &hFF)
          else
            printf ("%i",uVal)
          end if
        #endif
        g_bMemory( .uAddress ) = uVal : .uAddress += 1 : uCnt += 1 
        if iChar<>asc(",") then 
          #ifdef DebugCompilation
            puts("") 
          #endif
          return uCnt
        end if
        #ifdef DebugCompilation
          color 7 : printf(",")
        #endif
        bImm=0 : bHex=0 : bHi=0 : bDigCnt=0 : bLab = 0
      end select
    loop    
    puts("! ? ? ? ? !")
  _End
end function
function DefConst( _tParserAnd_ iOpcodeIndex as long = -1 ) as long 'define
  dim as byte bImm,bHex,bHi,bDigCnt,bLab
  dim as long uVal
  dim as string sParam,sDefName
  
  _Begin  
    do 'grab define name
      var iChar = ReadChar()
      select case iChar
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_") 'is it a label?
        'grab remainder of the label
        var pzStart = cast(zstring ptr,@.sCode[.iPos-1])
        do
          iChar = ReadChar()
          select case iChar
          case asc("A") to asc("Z"),asc("a") to asc("z")
          case asc("0") to asc("9"),asc("_") : rem ok
          case else : exit do
          end select
        loop        
        .iPos -= 1 : .sCode[.iPos]=0 
        sDefName = *pzStart : .sCode[.iPos]=iChar
      case 32,9
        if len(sDefName) then exit do
      case else
        color 12 : puts("ERROR: expected define name") : return -1
      end select
    loop  
  
    do 'grab define value
      var iChar = ReadChar()
      select case iChar
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_") 'is it a label?
        'grab remainder of the label
        var pzStart = cast(zstring ptr,@.sCode[.iPos-1])
        do
          iChar = ReadChar()
          select case iChar
          case asc("A") to asc("Z"),asc("a") to asc("z")
          case asc("0") to asc("9"),asc("_") : rem ok
          case else : exit do
          end select
        loop        
        .iPos -= 1 : bImm = 1 : bLab = 1
        .sCode[.iPos]=0 : sParam = *pzStart 
        .sCode[.iPos]=iChar
      case asc("#")                                        'immediate?
        if bImm = 0 then
          bImm = 1
        else
          color 12 : puts("ERROR: expected immediate... found #"): return -1
        end if
      case asc("0") to asc("9"),asc("-"),asc("+")          'immediate (DEC)
        var iNum = 0 , iSgn = 1 : bDigCnt = 0
        do
          if iNum > 65535 then
            color 12 : puts("number too big!")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")
            iNum = (iNum*10)+iChar-asc("0")    : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")    'end of token
            .iPos -= 1
            exit do
          case else                              'invalid char
            color 12 : printf("Invalid decimal caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          iChar = ReadChar()
        loop
        uVal = iNum*iSgn : bImm=1        
      case asc("$")                                        'address (HEX)?
        var iNum = 0 , iSgn = 1 : bDigCnt = 0        
        iChar = NextChar()
        do 
          if iNum > 65535 then
            color 12 : puts("Number too big")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")               'digit 0-9
            iNum = (iNum shl 4)+iChar-asc("0")    : bDigCnt += 1
          case asc("A") to asc("F")               'digit A-F
            iNum = (iNum shl 4)+iChar-asc("A")+10 : bDigCnt += 1
          case asc("a") to asc("f")               'digit a-f
            iNum = (iNum shl 4)+iChar-asc("a")+10 : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")     'end of token
            '.iPos -= 1 
            exit do          
          case else
            color 12 : printf("Invalid Hex caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          .iPos += 1 : iChar = GetChr()
        loop  
        uVal = iNum*iSgn : bHex = 1 : bImm = 1
      case asc("<")                                        'lo address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found <"): return -1
          else
            bHi = -1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case asc(">")                                        'hi address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found >"): return -1
          else
            bHi = 1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case 32,9    'skip spaces/tabs
      case 13,10,0,asc(";")                                'eol
        .iPos -= 1
        if bLab then
          if GetLabel( sParam , uVal ) < 0 orelse uVal < 0 then
            color 12 : puts("Label not found (forward labels not supported for ORG)") : return -1
          end if
          bImm = 1 : bHex = 1
        end if
        if bImm = 0 andalso bLab=0 then color 12 : puts("Expected constant value") : return -1                
        if bHi then if bHi > 0 then uVal = (uVal shr 8) else uVal and= &hFF        
        #define Is16Bit iif(bHex,bDigCnt>2,bDigCnt>3 orelse uVal<-128 orelse uVal>255)        
        return AddLabel( sDefName , uVal , Is16Bit )
      end select
    loop
  _End
end function

function FindOpCode( sOpcode as string ) as long  
  
  '*** guaranteed to be aligned... so its fine! ***
  var OpcodeU = *cptr(long ptr,strptr(sOpcode)) and (not &h20202020)
  for N as long = 0 to ubound(tOpcode)
    if OpcodeU = *cptr(long ptr,@tOpcode(N).zName) then return N
  next N
  
  return -1
end function
function ProcessOpcode_( _tParser ) as long
  _Begin
    'print "(";
    g_lPosition(.uAddress) = .iLineNum+1
    .sCode[.iPos-1] = 0
    var sOpcode = *cast(zstring ptr,strptr(.sCode)+.iTokenStart)    
    var iOpcode = FindOpCode( sOpcode )
    'print "'"+sOpcode+"'"
    .sCode[.iPos-1] = .iChar
    'print ")";
    if iOpcode < 0 then
      color 12: puts("ERROR: unrecognized opcode")
      return iOpcode
    end if
    'print ".";
    'color 7 : print hex$(.uAddress,4);" ";
    'color 10: print sOpcode
    .iTokenStart = -1 : .iTokenNum += 1    
    if tOpcode(iOpcode).fnEval( tParserAnd_ iOpcode) < 0 then return -1    
    return iOpcode    
  _End
end function
#define ProcessOpcode() ProcessOpcode_( _tParser_ )
function ProcessLabel_( _tParser ) as long
  _Begin
    .sCode[.iPos-1] = 0
    var sLabel = *cast(zstring ptr,strptr(.sCode)+.iTokenStart)
    if AddLabel(sLabel,.uAddress) < 0 then
      color 12: puts("ERROR: Label already exist")
      return 0
    end if
    #ifdef DebugCompilation
      color 7 : printf("%04X ",.uAddress,4)
      color 14 : printf("%s:",sLabel)
    #endif
    .sCode[.iPos-1] = .iChar
    .iTokenStart = -1 : .iTokenNum += 1
    .iHadLabel = 1
  _End
  return 1
end function
#define ProcessLabel() ProcessLabel_( _tParser_ )
function ProcessNewOrg_( _tParser ) as long  
  dim as byte bImm,bHex,bHi,bDigCnt,bLab
  dim as long uVal
  dim as string sParam
  
  _Begin    
    do
      var iChar = ReadChar()
      select case iChar
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_") 'is it a label?
        'grab remainder of the label
        var pzStart = cast(zstring ptr,@.sCode[.iPos-1])
        do
          iChar = ReadChar()
          select case iChar
          case asc("A") to asc("Z"),asc("a") to asc("z")
          case asc("0") to asc("9"),asc("_") : rem ok
          case else : exit do
          end select
        loop        
        .iPos -= 1 : bImm = 1 : bLab = 1
        .sCode[.iPos]=0 : sParam = *pzStart 
        .sCode[.iPos]=iChar
      case asc("#")                                        'immediate?
        if bImm = 0 then
          bImm = 1
        else
          color 12 : puts("ERROR: expected immediate... found #"): return -1
        end if
      case asc("0") to asc("9"),asc("-"),asc("+")          'immediate (DEC)
        var iNum = 0 , iSgn = 1 : bDigCnt = 0
        do
          if iNum > 65535 then
            color 12 : puts("number too big!")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")
            iNum = (iNum*10)+iChar-asc("0")    : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")    'end of token
            .iPos -= 1
            exit do
          case else                              'invalid char
            color 12 : printf("Invalid decimal caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          iChar = ReadChar()
        loop
        uVal = iNum*iSgn : bImm=1        
      case asc("$")                                        'address (HEX)?
        var iNum = 0 , iSgn = 1 : bDigCnt = 0        
        iChar = NextChar()
        do 
          if iNum > 65535 then
            color 12 : puts("Number too big")
            return -1
          end if
          select case iChar
          case asc("-")
            if bDigCnt = 0 then 
              iSgn = -iSgn
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("+")
            if bDigCnt = 0 then 
              iSgn = 1
            else
              color 12 : puts("Expressions not supported yet.")
              return -1
            end if
          case asc("0") to asc("9")               'digit 0-9
            iNum = (iNum shl 4)+iChar-asc("0")    : bDigCnt += 1
          case asc("A") to asc("F")               'digit A-F
            iNum = (iNum shl 4)+iChar-asc("A")+10 : bDigCnt += 1
          case asc("a") to asc("f")               'digit a-f
            iNum = (iNum shl 4)+iChar-asc("a")+10 : bDigCnt += 1
          case 13,10,0,32,9,asc(","),asc(";")     'end of token
            '.iPos -= 1 
            exit do          
          case else
            color 12 : printf("Invalid Hex caracter '")
            if iChar < 32 or iChar > 127 then printf(!"0x%02X'",iChar) else printf("%c'",iChar)
            return -1
          end select
          .iPos += 1 : iChar = GetChr()
        loop  
        uVal = iNum*iSgn : bHex = 1 : bImm = 1
      case asc("<")                                        'lo address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found <"): return -1
          else
            bHi = -1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case asc(">")                                        'hi address (immediate)
        if bImm then
          if bHi then
            color 12 : puts("ERROR: expected label... found >"): return -1
          else
            bHi = 1
          end if
        else
          color 12 : puts("ERROR: a # must precede < or > for lo/hi offset"): return -1
        end if
      case 32,9    'skip spaces/tabs
      case 13,10,0,asc(";")                                'eol
        .iPos -= 1
        if bLab then
          if GetLabel( sParam , uVal ) < 0 orelse uVal < 0 then
            color 12 : puts("Label not found (forward labels not supported for ORG)") : return -1
          end if
          bImm = 1 : bHex = 1
        end if
        if bImm = 0 andalso bLab=0 then color 12 : puts("Expected new org address") : return -1        
        if uVal < 0 then color 12 : puts("Invalid new org address") : return -1
        if bHi then if bHi > 0 then uVal = (uVal shr 8) else uVal and= &hFF
        #if 0
          #ifdef DebugCompilation          
            color 11: printf("*= ")
          #endif
          #ifdef DebugCompilation
            if bLab then color 14 else color 15
            if bHex then         
              printf("0x%02X",uVal)
            else
              printf("%i",uVal)
            end if
          #endif        
        #endif
        if .uAddress <> .uAddressMin then 
          AddBlock(.uAddressMin,.uAddress)
          .iTotalSz += .uAddress-.uAddressMin
        end if
        .uAddress = uVal : .uAddressMin = uVal        
        return .uAddress
      end select
    loop
  _End
end function
#define ProcessNewOrg() ProcessNewOrg_( _tParser_ )

#define ShowError() .iPos -= 1 : while .sCode[.iPos] andalso .sCode[.iPos] <> 10 : .iPos += 1 : wend : .sCode[.iPos] = 0 : color 8 : puts(*cast(zstring ptr,strptr(.sCode)+.iLineStart)) : .sCode[.iPos] = .iChar

function Assemble( sFile as string , iOutput as byte = 0 ) as bool export
  
  #define tParser g_tParser
  
  #ifdef __FB_NDS__
    clear( g_bMemory(0) , 0 , 65536 )
    clear( g_bMemChg(0) , 0 , 65536 )
  #else
    erase g_bMemory : erase g_bMemChg
  #endif  
  
  ClearStruct( g_tParser )  
  clear( g_lPosition(0) , -1 , 65536*sizeof(long) )
  
  #ifndef __FB_NDS__
    redim g_tLabel(15) : redim g_tPatch(15) : redim g_tBlock(15)
  #endif
  g_iLabelsCount = 0 : g_iPatchCount = 0  : g_iBlockCount = 0
  
  with tParser
    .uAddress = &h600
    .uAddressMin = &h600
    .iTokenStart = -1
  end with
  
  var f = freefile()
  if open(sFile for binary access read as #f) then
    color 12 : printf !"File '%s' not found\n",sFile : return 0
  end if
   
    
  tParser.iCodeSz = lof(f) 
  tParser.sCode = string(tParser.iCodeSz+2,0)  
  get #f,,*cast(ubyte ptr,strptr(tParser.sCode)),tParser.iCodeSz
  close #f  
  
  tParser.sCode[tParser.iCodeSz] = asc(!"\r")
  tParser.sCode[tParser.iCodeSz+1] = asc(!"\n")
  
  var iError = 1  
  g_lPosition(tParser.uAddress) = tParser.iLineNum
  
  do    
    with tParser
      .iChar = ReadChar()
      select case .iChar
      case asc(":")
        if .iTokenNum=0 andalso .iTokenStart >= 0 then
          ProcessLabel()
        else
          ProcessError() : sleep : exit do
        end if
      case asc(";")
        while .sCode[.iPos] andalso .sCode[.iPos] <> 10 
          .iPos += 1
        wend
        '.iPos -= 1  
      case 13,10,0 'end of line/program
        if .iTokenStart >= 0 then if ProcessOpcode() < 0 then ShowError() : exit do
        if .iChar=13 andalso .sCode[.iPos]=10 then .iPos += 1 : .iChar = 10
        if .iChar=0 then iError=0
        if ProcessEOL()=0 then exit do
      case 32,9
        if .iTokenStart >= 0 then 
          if ProcessOpcode() < 0 then ShowError() : exit do
          while .sCode[.iPos] andalso .sCode[.iPos] <> 10 : .iPos += 1 : wend : .iPos -= 1  
        end if  
      case asc("A") to asc("Z"),asc("a") to asc("z"),asc("_")
        if .iTokenStart < 0 then .iTokenStart = .iPos-1    
      case asc("0") to asc("9")
        if .iTokenStart < 0 then ProcessError() : sleep : exit do      
      case asc("*")      
        if .iTokenStart >= 0 then ProcessError() : exit do      
        if GetChr() = asc("=") then ProcessNewOrg() else ProcessError() : exit do      
      case else
        ProcessError() : exit do
      end select
    end with
  loop
  
  var iLine = g_tParser.iLineNum+1
  if iError = 0 then  
    for N as long = 0 to g_iPatchCount-1
      with g_tPatch(N)
        var uAddr = clng(g_tLabel(.iLabel).uAddr)
        if uAddr < 0 then
          color 12: printf(!"ERROR: label '%s' not found\n",g_tLabel(.iLabel).sName)
          iLine = .iLine : iError = 1 : exit for
        end if
        #ifdef DebugLabelFix
          printf(!"%i %04X %04X\n",.bAbs,.uAddress+2,uAddr)
        #endif
        if .bHi then
          g_bMemory(.uAddress) = iif(.bHi>0,(uAddr shr 8),(uAddr and &hFF))
        elseif .bAbs <> -1 then
          Write16( .uAddress , uAddr )          
        else
          g_bMemory(.uAddress) = uAddr-(.uAddress+1)      
        end if
      end with
    next N
  end if
  
  if g_tParser.uAddress <> g_tParser.uAddressMin then 
    AddBlock(g_tParser.uAddressMin,g_tParser.uAddress)
    g_tParser.iTotalSz += g_tParser.uAddress-g_tParser.uAddressMin
  end if
  
  color 15
  if iError then
    printf(!"At Line %i\n",iLine)
  else
    
    #macro ShowOutput()
      for M as long = 0 to g_iBlockCount-1
        dim as long uBegin = g_tBlock(M).uBegin, N
        #ifdef OutputAsm
          if M orelse uBegin <> &h600 then                  
            color 14: printf(!"\n*=%i",M)
          end if
        #endif            
        for N = uBegin to g_tBlock(M).uEnd-1
          #ifdef OutputHex
          var bShowHdr = (((N-uBegin) and 15)=0)
          #endif
          #ifdef OutputAsm
          var bShowHdr = (((N-uBegin) mod 12)=0)
          #endif
          #ifdef OutputHex
            if bShowHdr then color 7 : printf(!"\n%04X: ",cint(N)): color 15
            printf("%02X",(g_bMemory(N))): if ((N-uBegin) and 1) then printf(" ")
          #endif
          #ifdef OutputAsm
            if bShowHdr then 
              color 10 : printf(!"\ndcb "): color 15
            else
              printf(",")
            end if            
            printf "$%02X",(g_bMemory(N))
          #endif
        next N
        #ifdef OutputHex
        if ((N-uBegin) and 1) then printf "-- "
        #endif
      next M
    #endmacro
    
    if iOutput = 1 then
      #define OutputHex
      ShowOutput()
      puts("")
    elseif iOutput = 2 then      
      #define OutputAsm
      ShowOutput()
      puts("")
    end if
    
    return true
    
  end if  
  
  return false
end function

#undef _tParser
#undef _tParser
#undef _tParserAnd_
#undef tParserAnd_
#undef _Begin
#undef _End
