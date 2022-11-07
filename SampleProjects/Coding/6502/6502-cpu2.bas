namespace cpu

  type CpuFlags
    union
      type
        Carry     : 1 as ubyte
        Zero      : 1 as ubyte
        Interrupt : 1 as ubyte
        Decimal   : 1 as ubyte
        Break     : 1 as ubyte
        One       : 1 as ubyte
        oVerflow  : 1 as ubyte
        Negative  : 1 as ubyte
      end type
      bFlags as ubyte
    end union
  end type 
    
  #define LazyFlagsNZ
  #ifdef LazyFlagsNZ
    '#define LazyFlagsC
  #endif
  
  type CpuCore
    as ubyte  RegA,RegX,RegY,RegSP
    as CpuFlags RegP
    as ubyte  bOpcode 
    as ushort RegPC , wMemAddr
    as ubyte bBreak , bDone , bDebug , bRun , bSleep
    as ulong iCyclesMS = 2^10
    #ifdef LazyFlagsNZ
      as ulong iLFResuNZ, iLfResuC    
    #endif
  end type
  
  static shared as CpuCore g_tCpu
  
  #define _Begin with g_tCpu
  #define _End end with
  
  sub ResetCPU( tCpu as CpuCore )
    with tCpu
      if .iCyclesMS = 0 then .iCyclesMS = 2^8
      .RegA = 0 : .RegX = 0 : .RegY = 0
      .RegSP = &hFF : .RegPC = &h600 
      .RegP = type(0,0,0,1,0,1,0,0)
      #ifdef LazyFlagsNZ
        .iLFResuNZ = 1 : .iLfResuC = 0
      #endif
    end with
  end sub
  sub ShowCPU( tCpu as CpuCore )
    var iRow = csrlin() , iCol = pos()
    var iConW = width2(), iConH = hiword(iConW) 
    iConW = loword(iConW)
    #ifdef __FB_NDS__
      view print 1 to 24 : color 14,1 : locate 1,1
    #else
      view print : color 14,1 : locate 1,1
    #endif
    with tCpu 
      #define f(_f,_c) iif(.RegP._f,asc(_c)-32,asc(_c))
      dim as zstring*512 zCpu = any
      #ifdef __FB_NDS__
        var iLen = sprintf(zCpu,"A%02X X%02X Y%02X S%02X PC%04X %c%c%c1%c%c%c%c", _
        .RegA , .RegX , .RegY , .RegSP , .RegPC , f(Negative,"n") , f(oVerflow,"v") , _
        f(Break,"b") , f(Decimal,"d") ,  f(Interrupt,"i") , f(Zero,"z") , f(Carry,"c") )    
      #else
        var iLen = sprintf(zCpu,"A=$%02X  X=$%02X  Y=$%02X  SP=$01%02X  PC=$%04X  P=$%02X (%c%c%c1%c%c%c%c) %s", _
        .RegA , .RegX , .RegY , .RegSP , .RegPC , .RegP.bFlags , f(Negative,"n") , f(oVerflow,"v") , _
        f(Break,"b") , f(Decimal,"d") ,  f(Interrupt,"i") , f(Zero,"z") , f(Carry,"c") , str(uTotalCycles2) )    
      #endif
      (@zCpu)[iLen] = space(loword(width2())-iLen)
      printf(zCpu)
    end with  
    
    #ifdef __FB_NDS__
      view print 3 to 13
    #else
      view print 3 to iConH-1
    #endif

    
    locate iRow,iCol : color 7,0  
  end sub
  
  #ifdef CpuNotifyRead
    #define NotifyRead8(_uaddr) g_bMemChg(_uaddr) = -2
    #define NotifyRead16(_uaddr) Write16Ex(g_bMemChg,_uaddr,&hFEFE)
  #else
    #define NotifyRead8(_uaddr) rem
    #define NotifyRead16(_uaddr) rem
  #endif
  #ifdef CpuNotifyWrite
    #define NotifyWrite8(_uaddr) g_bMemChg(_uaddr) = 2
    #define NotifyWrite16(_uaddr) Write16Ex(g_bMemChg,_uAddr,&h0202)
  #else
    #define NotifyWrite8(_uaddr) rem
    #define NotifyWrite16(_uaddr) rem
  #endif    

  function ReadByte( uAddr as long ) as ubyte  
    if uAddr = &hFE then return rand()    
    NotifyRead8(uAddr)
    return g_bMemory(uAddr)
  end function

  #ifdef CpuNotifyRead  
    function ReadWord( uAddr as long ) as ulong      
      NotifyRead16(uAddr)
      return culng(Read16(uAddr))
    end function    
    #define ReadByteFast ReadByte
  #else
    #define ReadWord( _uAddr ) culng(Read16(_uAddr))
    #define ReadByteFast( _uAddr ) g_bMemory(_uAddr) 
  #endif

  sub WriteByte( uAddr as long , bValue as ubyte )
    if uAddr = &hFE then 'align to next X ms
      static as double dDelay 
      if g_tCpu.bDebug then
        dDelay = timer
      else        
        #ifdef __FB_NDS__
        if bValue = 16 then
          screensync
          dDelay = timer
          g_tCpu.bBreak = 1
          g_tCpu.bSleep = 1
        else 
        #endif
        if abs(timer-dDelay) > ((bValue*2)/1000) then
          dDelay = timer
        else
          while (timer-dDelay) < (bValue/1000)
            sleep 1, 1
          wend
          dDelay += (bValue/1000)
        end if
        #ifdef __FB_NDS__
        end if
        #endif
        g_tCpu.bBreak = 1
        g_tCpu.bSleep = 1
      end if
    end if
    g_bMemory(uAddr) = bValue
    NotifyWrite8(uAddr)
  end sub
  #define WriteWord( _uAddr , _wValue ) Write16(_uAddr,_wValue) : NotifyWrite16(_uAddr)
  #define WriteByteFast( _uAddr , _uVal ) g_bMemory(_uAddr) = (_uVal) : NotifyWrite8(_uAddr)
  
  #define ReadByteOpcode ReadByteFast
  #define WriteByteOpcode WriteByteFast
  
  #define FlagVar( _Name ) .RegP._Name
  #define GetFlag( _Name ) .RegP._Name
  #define SetFlag( _Name )   .RegP._Name = 1
  #define ClearFlag( _Name ) .RegP._Name = 0
  #define CalcFlag_Negative( _Val ) .RegP.Negative = (((_Val) shr 7) and 1)
  #define CalcFlag_Zero( _Val )     .RegP.Zero     = (cubyte(_Val)=0)
  #define CalcFlag_Carry( _Val )    .RegP.Carry    = ((_Val)>255)
  #define CalcFlag_XCarry( _Val )   .RegP.Carry    = ((_Val)<=255)  
  #define CalcFlag_oVerFlow( _Val ) .RegP.oVerflow = (clng(_Val)<-128) or (clng(_Val)>127)
  #define CalcFlag_oVerFlow6( _Val ) .RegP.oVerflow = (((_Val) shr 6) and 1)
  
  #macro CalcFlags_NZ(_Val) 
    CalcFlag_Negative( _Val )
    CalcFlag_Zero( _Val )
  #endmacro
  #macro CalcFlags_NZC(_Val) 
    CalcFlag_Negative( _Val )
    CalcFlag_Zero( _Val )
    CalcFlag_Carry( _Val )
  #endmacro
  #macro CalcFlags_NZCV(_Val) 
    CalcFlag_Negative( _Val )
    CalcFlag_Zero( _Val )
    CalcFlag_Carry( _Val )
    CalcFlag_oVerFlow( _Val )
  #endmacro
  #macro CalcFlags_CV(_Val)
    CalcFlag_Carry( _Val )
    CalcFlag_oVerFlow( _Val )
  #endmacro
  
  #macro fnAddr_imm8()   'immediate byte right after opcode
    dim as long wMemAddr = .RegPC : .RegPC += 1    
  #endmacro
  #macro fnAddr_z8()     'zero page (imm 8bit) address right after opcode
    dim as long wMemAddr = ReadByteFast(.RegPC) : .RegPC += 1
  #endmacro
  #macro fnAddr_i8X()   'zero page (imm 8bit) address plus X (unsigned, wrap 8)
    dim as long wMemAddr = (ReadByteFast(.RegPC)+.RegX) and &hFF : .RegPC += 1
  #endmacro
  #macro fnAddr_i8Y()   'zero page (imm 8bit) address plus Y (unsigned, wrap 8)
    dim as long wMemAddr = (ReadByteFast(.RegPC)+.RegY) and &hFF : .RegPC += 1
  #endmacro
  #macro fnAddr_i16X()   '(imm 16bit) address plus X (unsigned)
    dim as long wMemAddr = (ReadWord(.RegPC)+.RegX) and &hFFFF : .RegPC += 2    
  #endmacro
  #macro fnAddr_i16Y()   '(imm 16bit) address plus Y (unsigned)
    dim as long wMemAddr = (ReadWord(.RegPC)+.RegY) and &hFFFF : .RegPC += 2    
  #endmacro
  #macro fnAddr_r16()    'PC plus imm8 (signed)    
    dim as long wMemAddr = (1+.RegPC+cbyte(ReadByteFast(.RegPC))) and &hFFFF : .RegPC += 1
  #endmacro
  #macro fnAddr_ind8X()  'indirect (16bit address at zero page (imm 8bit) plus X) (unsigned)
    dim as long wMemAddr = ReadWord(((ReadByteFast(.RegPC)+.RegX) and &hFF)) : .RegPC += 1    
  #endmacro
  #macro fnAddr_ind8Y()  'indirect (16bit address at zero page (imm 8bit)) plus Y (unsigned)
    dim as long wMemAddr = (ReadWord(ReadByteFast(.RegPC))+.RegY) and &hFFFF : .RegPC += 1
  #endmacro
  #macro fnAddr_ind16()  'indirect (16bit address) (unsigned)
    dim as long wMemAddr = ReadWord(ReadByteFast(.RegPC)) : .RegPC += 2
  #endmacro
  #macro fnAddr_a16()    '(imm 16bit) address
    dim as long wMemAddr = ReadWord(.RegPC) : .RegPC += 2    
  #endmacro
  
  #macro ForEachOpcode( _Act ) 
    _Act(BRK,_none) _Act(ORA,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ORA,_z8)   _Act(ASL,_z8)   _Act(z,__x_) _
    _Act(PHP,_none) _Act(ORA,_imm8)  _Act(ASLA,_Acc) _Act(z,__x_) _Act(z,__x_)     _Act(ORA,_a16)  _Act(ASL,_a16)  _Act(z,__x_) _
    _Act(BPL,_r16)  _Act(ORA,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ORA,_i8X)  _Act(ASL,_i8X)  _Act(z,__x_) _
    _Act(CLC,_none) _Act(ORA,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ORA,_i16X) _Act(ASL,_i16X) _Act(z,__x_) _
    _Act(JSR,_a16)  _Act(AND,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(BIT,_z8)    _Act(AND,_z8)   _Act(ROL,_z8)   _Act(z,__x_) _
    _Act(PLP,_none) _Act(AND,_imm8)  _Act(ROLA,_Acc) _Act(z,__x_) _Act(BIT,_a16)   _Act(AND,_a16)  _Act(ROL,_a16)  _Act(z,__x_) _
    _Act(BMI,_r16)  _Act(AND,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(AND,_i8X)  _Act(ROL,_i8X)  _Act(z,__x_) _
    _Act(SEC,_none) _Act(AND,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(AND,_i16X) _Act(ROL,_i16X) _Act(z,__x_) _
    _Act(RTI,_none) _Act(EOR,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(EOR,_z8)   _Act(LSR,_z8)   _Act(z,__x_) _
    _Act(PHA,_none) _Act(EOR,_imm8)  _Act(LSRA,_Acc) _Act(z,__x_) _Act(JMP,_a16)   _Act(EOR,_a16)  _Act(LSR,_a16)  _Act(z,__x_) _
    _Act(BVC,_r16)  _Act(EOR,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(EOR,_i8X)  _Act(LSR,_i8X)  _Act(z,__x_) _
    _Act(CLI,_none) _Act(EOR,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(EOR,_i16X) _Act(LSR,_i16X) _Act(z,__x_) _
    _Act(RTS,_none) _Act(ADC,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ADC,_z8)   _Act(ROR,_z8)   _Act(z,__x_) _
    _Act(PLA,_none) _Act(ADC,_imm8)  _Act(RORA,_Acc) _Act(z,__x_) _Act(JMP,_ind16) _Act(ADC,_a16)  _Act(ROR,_a16)  _Act(z,__x_) _
    _Act(BVS,_r16)  _Act(ADC,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ADC,_i8X)  _Act(ROR,_i8X)  _Act(z,__x_) _
    _Act(SEI,_none) _Act(ADC,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(ADC,_i16X) _Act(ROR,_i16X) _Act(z,__x_) _
    _Act(z,__x_)    _Act(STA,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(STY,_z8)    _Act(STA,_z8)   _Act(STX,_z8)   _Act(z,__x_) _
    _Act(DEY,_none) _Act(z,__x_)     _Act(TXA,_none) _Act(z,__x_) _Act(STY,_a16)   _Act(STA,_a16)  _Act(STX,_a16)  _Act(z,__x_) _
    _Act(BCC,_r16)  _Act(STA,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(STY,_i8X)   _Act(STA,_i8X)  _Act(STX,_i8Y)  _Act(z,__x_) _
    _Act(TYA,_none) _Act(STA,_i16Y)  _Act(TXS,_none) _Act(z,__x_) _Act(z,__x_)     _Act(STA,_i16X) _Act(z,__x_)    _Act(z,__x_) _
    _Act(LDY,_imm8) _Act(LDA,_ind8X) _Act(LDX,_imm8) _Act(z,__x_) _Act(LDY,_z8)    _Act(LDA,_z8)   _Act(LDX,_z8)   _Act(z,__x_) _
    _Act(TAY,_none) _Act(LDA,_imm8)  _Act(TAX,_none) _Act(z,__x_) _Act(LDY,_a16)   _Act(LDA,_a16)  _Act(LDX,_a16)  _Act(z,__x_) _
    _Act(BCS,_r16)  _Act(LDA,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(LDY,_i8X)   _Act(LDA,_i8X)  _Act(LDX,_i8Y)  _Act(z,__x_) _
    _Act(CLV,_none) _Act(LDA,_i16Y)  _Act(TSX,_none) _Act(z,__x_) _Act(LDY,_i16X)  _Act(LDA,_i16X) _Act(LDX,_i16Y) _Act(z,__x_) _
    _Act(CPY,_imm8) _Act(CMP,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(CPY,_z8)    _Act(CMP,_z8)   _Act(DEC,_z8)   _Act(z,__x_) _
    _Act(INY,_none) _Act(CMP,_imm8)  _Act(DEX,_none) _Act(z,__x_) _Act(CPY,_a16)   _Act(CMP,_a16)  _Act(DEC,_a16)  _Act(z,__x_) _
    _Act(BNE,_r16)  _Act(CMP,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(CMP,_i8X)  _Act(DEC,_i8X)  _Act(z,__x_) _
    _Act(CLD,_none) _Act(CMP,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(CMP,_i16X) _Act(DEC,_i16X) _Act(z,__x_) _
    _Act(CPX,_imm8) _Act(SBC,_ind8X) _Act(z,__x_)    _Act(z,__x_) _Act(CPX,_z8)    _Act(SBC,_z8)   _Act(INC,_z8)   _Act(z,__x_) _
    _Act(INX,_none) _Act(SBC,_imm8)  _Act(NOP,_none) _Act(z,__x_) _Act(CPX,_a16)   _Act(SBC,_a16)  _Act(INC,_a16)  _Act(z,__x_) _
    _Act(BEQ,_r16)  _Act(SBC,_ind8Y) _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(SBC,_i8X)  _Act(INC,_i8X)  _Act(z,__x_) _
    _Act(SED,_none) _Act(SBC,_i16Y)  _Act(z,__x_)    _Act(z,__x_) _Act(z,__x_)     _Act(SBC,_i16X) _Act(INC,_i16X) _Act(z,__x_)
  #endmacro
  
  '--------------- OPCODES --------------
  sub fnOpcode_Unimplemented()
    _Begin  
      color 12 : puts("Unimplemented opcode: " & hex(.bOpcode,2) & " > '"+g_zDism(.bOpcode)+"'")
      .bBreak = 1
    _End
  end sub
  sub fnOpcode__x_()
    _Begin      
      color 12 : puts("Illegal opcode: " & hex(.bOpcode,2))
      .bBreak = 1
    _End
  end sub
  
  rem ---------------- flags ------------
    #macro fnOpcode_CLC() 'Clear Carry
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'CLC (CLear Carry)              $18
      'SEC (SEt Carry)                $38
      'CLI (CLear Interrupt)          $58
      'SEI (SEt Interrupt)            $78
      'CLV (CLear oVerflow)           $B8
      'CLD (CLear Decimal)            $D8
      'SED (SEt Decimal)              $F8
      
      ClearFlag(Carry)
      
    #endmacro
    #macro fnOpcode_SEC() 'Set Carry
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'SEC (SEt Carry)                $38
      
      SetFlag(Carry)    
      
      
    #endmacro
    #macro fnOpcode_CLI() 'Clear Interrupt
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'CLI (CLear Interrupt)          $58
      
      ClearFlag(Interrupt)
      
    #endmacro
    #macro fnOpcode_SEI() 'Set Carry
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'SEI (SEt Interrupt)            $78
      
      SetFlag(Interrupt)    
      
    #endmacro
    #macro fnOpcode_CLV() 'Clear Overflow
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'CLV (CLear oVerflow)           $B8
      
      ClearFlag(oVerflow)
      
    #endmacro
    #macro fnOpcode_CLD() 'Clear Decimal
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'CLD (CLear Decimal)            $D8
      
      
      ClearFlag(Decimal)    
      
      
    #endmacro
    #macro fnOpcode_SED() 'Set Decimal
      
      'Flag (Processor Status) Instructions
      'Affect Flags: as noted  
      'These instructions are implied mode, have a length of one byte and require two machine cycles.  
      
      'MNEMONIC                       HEX
      'SED (SEt Decimal)              $F8
          
      SetFlag(Decimal)
      
    #endmacro
  rem ---------------- load -------------
    #macro fnOpcode_LDA() 'load A from immediate or memory
      
      'LDA (LoaD Accumulator)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     LDA #$44      $A9  2   2
      'Zero Page     LDA $44       $A5  2   3
      'Zero Page,X   LDA $44,X     $B5  2   4
      'Absolute      LDA $4400     $AD  3   4
      'Absolute,X    LDA $4400,X   $BD  3   4+
      'Absolute,Y    LDA $4400,Y   $B9  3   4+
      'Indirect,X    LDA ($44,X)   $A1  2   6
      'Indirect,Y    LDA ($44),Y   $B1  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByte(wMemAddr)
        .RegA = .iLFResuNZ
      #else
        .RegA = ReadByte(wMemAddr)    
        CalcFlags_NZ( .RegA )
      #endif
      
    #endmacro
    #macro fnOpcode_LDX() 'load X from immediate or memory
      
      'LDX (LoaD X register)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     LDX #$44      $A2  2   2
      'Zero Page     LDX $44       $A6  2   3
      'Zero Page,Y   LDX $44,Y     $B6  2   4
      'Absolute      LDX $4400     $AE  3   4
      'Absolute,Y    LDX $4400,Y   $BE  3   4+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByte(wMemAddr)
        .RegX = .iLFResuNZ
      #else
        .RegX = ReadByte(wMemAddr)    
        CalcFlags_NZ( .RegX )      
      #endif
      
    #endmacro
    #macro fnOpcode_LDY() 'load Y from immediate or memory
      
      'LDY (LoaD Y register)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     LDY #$44      $A0  2   2
      'Zero Page     LDY $44       $A4  2   3
      'Zero Page,X   LDY $44,X     $B4  2   4
      'Absolute      LDY $4400     $AC  3   4
      'Absolute,X    LDY $4400,X   $BC  3   4+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByte(wMemAddr)    
        .RegY = .iLFResuNZ
      #else
        .RegY = ReadByte(wMemAddr)    
        CalcFlags_NZ( .RegY )
      #endif
      
    #endmacro
  rem ---------------- save -------------
    #macro fnOpcode_STA() 'store A to memory
      
      'STA (STore Accumulator)
      'Affects Flags: none
    
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     STA $44       $85  2   3
      'Zero Page,X   STA $44,X     $95  2   4
      'Absolute      STA $4400     $8D  3   4
      'Absolute,X    STA $4400,X   $9D  3   5
      'Absolute,Y    STA $4400,Y   $99  3   5
      'Indirect,X    STA ($44,X)   $81  2   6
      'Indirect,Y    STA ($44),Y   $91  2   6
      
      WriteByte(wMemAddr,.RegA)
      
    #endmacro
    #macro fnOpcode_STX() 'store X to memory
      
      'STX (STore X register)
      'Affects Flags: none
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     STX $44       $86  2   3
      'Zero Page,Y   STX $44,Y     $96  2   4
      'Absolute      STX $4400     $8E  3   4
      
          
            
        WriteByte(wMemAddr,.RegX)        
      
      
    #endmacro
    #macro fnOpcode_STY() 'store Y to memory
      
      'STY (STore Y register)
      'Affects Flags: none
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     STY $44       $84  2   3
      'Zero Page,X   STY $44,X     $94  2   4
      'Absolute      STY $4400     $8C  3   4
      
      WriteByte(wMemAddr,.RegY)        
      
      
    #endmacro
  rem -------------- register -----------
    #macro fnOpcode_TAX() 'transfer A to X
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'TAX (Transfer A to X)    $AA
      'TXA (Transfer X to A)    $8A
      'DEX (DEcrement X)        $CA
      'INX (INcrement X)        $E8
      'TAY (Transfer A to Y)    $A8
      'TYA (Transfer Y to A)    $98
      'DEY (DEcrement Y)        $88
      'INY (INcrement Y)        $C8
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegA
        .RegX = .RegA
      #else
        .RegX = .RegA
        CalcFlags_NZ( .RegX )
      #endif
      
    #endmacro
    #macro fnOpcode_TXA() 'transfer X to A
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'TXA (Transfer X to A)    $8A
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegX
        .RegA = .RegX
      #else
        .RegA = .RegX
        CalcFlags_NZ( .RegA )
      #endif
      
      
    #endmacro
    #macro fnOpcode_DEX() 'DEcrement X
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'DEX (DEcrement X)        $CA
      
      #ifdef LazyFlagsNZ
        .RegX -= 1
        .iLFResuNZ = .RegX
      #else                
        .RegX -= 1
        CalcFlags_NZ( .RegX )
      #endif
      
    #endmacro
    #macro fnOpcode_INX() 'INcrement X
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'INX (INcrement X)        $E8
      
      #ifdef LazyFlagsNZ
        .RegX += 1
        .iLFResuNZ = .RegX
      #else
        .RegX += 1
        CalcFlags_NZ( .RegX )
      #endif
      
    #endmacro
    #macro fnOpcode_TAY() 'transfer A to Y
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'TAY (Transfer A to Y)    $A8    
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegA
        .RegY = .RegA
      #else
        .RegY = .RegA
        CalcFlags_NZ( .RegY )
      #endif
      
    #endmacro
    #macro fnOpcode_TYA() 'transfer Y to A
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'TYA (Transfer Y to A)    $98
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegY
        .RegA = .RegY
      #else      
        .RegA = .RegY
        CalcFlags_NZ( .RegA )
      #endif
      
    #endmacro
    #macro fnOpcode_DEY() 'DEcrement Y
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'DEY (DEcrement Y)        $88    
      
      #ifdef LazyFlagsNZ
        .RegY -= 1
        .iLFResuNZ = .RegY
      #else     
        .RegY -= 1
        CalcFlags_NZ( .RegY )
      #endif
      
    #endmacro
    #macro fnOpcode_INY() 'INcrement Y
      
      'Register Instructions
      'Affect Flags: N Z
      
      'These instructions are implied mode, have a length of one byte and require two machine cycles.
      
      'MNEMONIC                 HEX
      'INY (INcrement Y)        $C8
      #ifdef LazyFlagsNZ
        .RegY += 1
        .iLFResuNZ = .RegY
      #else
        .RegY += 1
        CalcFlags_NZ( .RegY )
      #endif
      
    #endmacro
  rem --------------  memory ------------
    #macro fnOpcode_INC() 'Increment memory
      
      'INC (INCrement memory)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     INC $44       $E6  2   5
      'Zero Page,X   INC $44,X     $F6  2   6
      'Absolute      INC $4400     $EE  3   6
      'Absolute,X    INC $4400,X   $FE  3   7
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr)+1
        WriteByteOpcode(wMemAddr,.iLFResuNZ)
      #else
        dim as ubyte Resu = ReadByteOpcode(wMemAddr)+1
        WriteByteOpcode(wMemAddr,Resu)
        CalcFlags_NZ(Resu)
      #endif      
      
    #endmacro
    #macro fnOpcode_DEC() 'Increment memory
      
      'INC (INCrement memory)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     INC $44       $E6  2   5
      'Zero Page,X   INC $44,X     $F6  2   6
      'Absolute      INC $4400     $EE  3   6
      'Absolute,X    INC $4400,X   $FE  3   7
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr)-1
        WriteByteOpcode(wMemAddr,.iLFResuNZ)
      #else
        dim as ubyte Resu = ReadByteOpcode(wMemAddr)-1
        WriteByteOpcode(wMemAddr,Resu)
        CalcFlags_NZ(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_BIT() 'Bit Test memory
      
      'BIT (test BITs)
      'Affects Flags: N V Z

      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     BIT $44       $24  2   3
      'Absolute      BIT $4400     $2C  3   4

      'BIT sets the Z flag as though the value in the address tested were ANDed with the accumulator. 
      'The N and V flags are set to match bits 7 and 6 respectively in the value stored at the tested address.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr)
        CalcFlag_Overflow6(.iLFResuNZ)
        if (.RegA and .iLFResuNZ)=0 then .iLFResuNZ = 0 'hack
      #else
        var bResu = ReadByteOpcode(wMemAddr)
        CalcFlag_Zero(.RegA and bResu)
        CalcFlag_Negative(bResu)        
        CalcFlag_Overflow6(bResu)
      #endif      
      
    #endmacro
  rem ---------------- math -------------
    #macro fnOpcode_ADC() 'ADC A with memory or imm
      
      'ADC (ADd with Carry)
      'Affects Flags: N V Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     ADC #$44      $69  2   2
      'Zero Page     ADC $44       $65  2   3
      'Zero Page,X   ADC $44,X     $75  2   4
      'Absolute      ADC $4400     $6D  3   4
      'Absolute,X    ADC $4400,X   $7D  3   4+
      'Absolute,Y    ADC $4400,Y   $79  3   4+
      'Indirect,X    ADC ($44,X)   $61  2   6
      'Indirect,Y    ADC ($44),Y   $71  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegA + ReadByteOpcode(wMemAddr) + GetFlag(Carry)
        .RegA = .iLFResuNZ
        CalcFlags_CV(.iLFResuNZ)
      #else
        dim as ulong Resu = .RegA + ReadByteOpcode(wMemAddr) + GetFlag(Carry)      
        .RegA = Resu
        CalcFlags_NZCV(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_SBC() 'SBC A with memory or imm
      
      'SBC (SuBtract with Carry)
      'Affects Flags: N V Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     SBC #$44      $E9  2   2
      'Zero Page     SBC $44       $E5  2   3
      'Zero Page,X   SBC $44,X     $F5  2   4
      'Absolute      SBC $4400     $ED  3   4
      'Absolute,X    SBC $4400,X   $FD  3   4+
      'Absolute,Y    SBC $4400,Y   $F9  3   4+
      'Indirect,X    SBC ($44,X)   $E1  2   6
      'Indirect,Y    SBC ($44),Y   $F1  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegA - (ReadByteOpcode(wMemAddr) + (1-GetFlag(Carry)))
        .RegA = .iLFResuNZ
        CalcFlag_XCarry(.iLFResuNZ)
        CalcFlag_oVerflow( .iLFResuNZ )
      #else
        dim as ulong Resu = .RegA - (ReadByteOpcode(wMemAddr) + (1-GetFlag(Carry)))
        .RegA = Resu
        CalcFlags_NZ(Resu)
        CalcFlag_XCarry(Resu)
        CalcFlag_oVerflow( Resu )
      #endif
      
    #endmacro
    #macro fnOpcode_CMP() 'Compare A with memory or imm
      
      'CMP (CoMPare accumulator)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     CMP #$44      $C9  2   2
      'Zero Page     CMP $44       $C5  2   3
      'Zero Page,X   CMP $44,X     $D5  2   4
      'Absolute      CMP $4400     $CD  3   4
      'Absolute,X    CMP $4400,X   $DD  3   4+
      'Absolute,Y    CMP $4400,Y   $D9  3   4+
      'Indirect,X    CMP ($44,X)   $C1  2   6
      'Indirect,Y    CMP ($44),Y   $D1  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegA - ReadByte(wMemAddr)
        CalcFlag_XCarry(.iLFResuNZ)
      #else
        dim as ulong Resu = .RegA - ReadByte(wMemAddr)
        CalcFlags_NZ(Resu)
        CalcFlag_XCarry(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_CPX() 'Compare X with memory or imm
      
      'CPX (ComPare X register)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     CPX #$44      $E0  2   2
      'Zero Page     CPX $44       $E4  2   3
      'Absolute      CPX $4400     $EC  3   4
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegX - ReadByte(wMemAddr)
        CalcFlag_XCarry(.iLFResuNZ)
      #else
        dim as ulong Resu = .RegX - ReadByte(wMemAddr)
        CalcFlags_NZ(Resu)
        CalcFlag_XCarry(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_CPY() 'Compare Y with memory or imm
      
      'CPY (ComPare Y register)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     CPY #$44      $C0  2   2
      'Zero Page     CPY $44       $C4  2   3
      'Absolute      CPY $4400     $CC  3   4
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = .RegY - ReadByte(wMemAddr)
        CalcFlag_XCarry(.iLFResuNZ)
      #else
        dim as ulong Resu = .RegY - ReadByte(wMemAddr)
        CalcFlags_NZ(Resu)
        CalcFlag_XCarry(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_AND() 'AND with memory or imm
      
      'AND (bitwise AND with accumulator)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     AND #$44      $29  2   2
      'Zero Page     AND $44       $25  2   3
      'Zero Page,X   AND $44,X     $35  2   4
      'Absolute      AND $4400     $2D  3   4
      'Absolute,X    AND $4400,X   $3D  3   4+
      'Absolute,Y    AND $4400,Y   $39  3   4+
      'Indirect,X    AND ($44,X)   $21  2   6
      'Indirect,Y    AND ($44),Y   $31  2   5+
      
      '+ add 1 cycle if page boundary crossed
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr) and .RegA
        .RegA = .iLFResuNZ
      #else
        .RegA = ReadByteOpcode(wMemAddr) and .RegA
        CalcFlags_NZ(.RegA)
      #endif
      
    #endmacro
    #macro fnOpcode_ORA() 'ORA with memory or imm
      
      'ORA (bitwise OR with Accumulator)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     ORA #$44      $09  2   2
      'Zero Page     ORA $44       $05  2   3
      'Zero Page,X   ORA $44,X     $15  2   4
      'Absolute      ORA $4400     $0D  3   4
      'Absolute,X    ORA $4400,X   $1D  3   4+
      'Absolute,Y    ORA $4400,Y   $19  3   4+
      'Indirect,X    ORA ($44,X)   $01  2   6
      'Indirect,Y    ORA ($44),Y   $11  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr) or .RegA
        .RegA = .iLFResuNZ
      #else
        .RegA = ReadByteOpcode(wMemAddr) or .RegA      
        CalcFlags_NZ(.RegA)
      #endif
      
    #endmacro
    #macro fnOpcode_EOR() 'XOR with memory or imm
      
      'EOR (bitwise Exclusive OR)
      'Affects Flags: N Z
      
      'MODE           SYNTAX       HEX LEN TIM
      'Immediate     EOR #$44      $49  2   2
      'Zero Page     EOR $44       $45  2   3
      'Zero Page,X   EOR $44,X     $55  2   4
      'Absolute      EOR $4400     $4D  3   4
      'Absolute,X    EOR $4400,X   $5D  3   4+
      'Absolute,Y    EOR $4400,Y   $59  3   4+
      'Indirect,X    EOR ($44,X)   $41  2   6
      'Indirect,Y    EOR ($44),Y   $51  2   5+
      
      '+ add 1 cycle if page boundary crossed
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr) xor .RegA      
        .RegA = .iLFResuNZ
      #else
        .RegA = ReadByteOpcode(wMemAddr) xor .RegA      
        CalcFlags_NZ(.RegA)
      #endif
      
    #endmacro
  rem --------------- branch ------------
    #macro fnOpcode_BPL() 'Branch if Negative Clear (plus)
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BPL (Branch on PLus)           $10
      'BMI (Branch on MInus)          $30
      'BVC (Branch on oVerflow Clear) $50
      'BVS (Branch on oVerflow Set)   $70
      'BCC (Branch on Carry Clear)    $90
      'BCS (Branch on Carry Set)      $B0
      'BNE (Branch on Not Equal)      $D0
      'BEQ (Branch on EQual)          $F0
      
      #ifdef LazyFlagsNZ
        if (.iLFResuNZ and (1 shl 7))=0 then .RegPC = wMemAddr
      #else
        if FlagVar(Negative)=0 then .RegPC = wMemAddr
      #endif
      
    #endmacro
    #macro fnOpcode_BMI() 'Branch if Negative Set (minus)
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BMI (Branch on MInus)          $30
      
      #ifdef LazyFlagsNZ
        if (.iLFResuNZ and (1 shl 7)) then .RegPC = wMemAddr
      #else
        if FlagVar(Negative) then .RegPC = wMemAddr
      #endif
      
    #endmacro
    #macro fnOpcode_BVC() 'Branch if oVerflow Clear
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BVC (Branch on oVerflow Clear) $50
      
      if FlagVar(Overflow)=0 then .RegPC = wMemAddr
      
    #endmacro
    #macro fnOpcode_BVS() 'Branch if oVerflow Set
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BVS (Branch on oVerflow Set)   $70
      
      if FlagVar(oVerflow) then .RegPC = wMemAddr
      
    #endmacro
    #macro fnOpcode_BCC() 'Branch if Carry Clear
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BCC (Branch on Carry Clear)    $90
      
      if FlagVar(Carry)=0 then .RegPC = wMemAddr
      
    #endmacro
    #macro fnOpcode_BCS() 'Branch if Carry Set
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BCS (Branch on Carry Set)      $B0
      
      if FlagVar(Carry) then .RegPC = wMemAddr
      
    #endmacro
    #macro fnOpcode_BNE() 'Branch if Zero Clear (Not Equal)
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BNE (Branch on Not Equal)      $D0
      
      #ifdef LazyFlagsNZ
        if (.iLFResuNZ and &hFF) then .RegPC = wMemAddr
      #else
        if FlagVar(Zero)=0 then .RegPC = wMemAddr
      #endif
      
    #endmacro
    #macro fnOpcode_BEQ() 'Branch if Zero Set  (Equal)
      
      'Branches are dependant on the status of the flag bits when the op code is encountered.
      'A branch not taken requires two machine cycles. Add one if the branch is taken 
      'and add one more if the branch crosses a page boundary.
    
      'MNEMONIC                       HEX
      'BEQ (Branch on EQual)          $F0
      
      #ifdef LazyFlagsNZ
        if (.iLFResuNZ and &hFF)=0 then .RegPC = wMemAddr
      #else
        if FlagVar(Zero) then .RegPC = wMemAddr
      #endif
      
    #endmacro  
    #macro fnOpcode_JMP() 'Jump to location
      
      'JMP (JuMP)
      'Affects Flags: none
      
      'MODE           SYNTAX       HEX LEN TIM
      'Absolute      JMP $5597     $4C  3   3
      'Indirect      JMP ($5597)   $6C  3   5
      
      .RegPC = wMemAddr
      
    #endmacro  
    #macro fnOpcode_JSR() 'Jump to Subroutine
      
      'JSR (Jump to SubRoutine)
      'Affects Flags: none
      
      'MODE           SYNTAX       HEX LEN TIM
      'Absolute      JSR $5597     $20  3   6
      
      .RegSP -= 2
      WriteWord((&h100+.RegSP),.RegPC-1)
      .RegPC = wMemAddr
      
    #endmacro
    #macro fnOpcode_RTS() 'Return from Subroutine
      
      'Affects Flags: none
  
      'MODE           SYNTAX       HEX LEN TIM
      'Implied       RTS           $60  1   6
            
      if .RegSP = &hFF then
        color 14 : puts("Stack is empty!")
        .bBreak = 1 : exit sub
      end if
      .RegPC = ReadWord((&h100+.RegSP))+1
      .RegSP += 2
      
    #endmacro
    
  rem --------------- shift -------------
    #macro fnOpcode_ASLA() 'Arithmetic Shift Left Accumulator
      
      'ASL (Arithmetic Shift Left)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Accumulator   ASL A         $0A  1   2
      
      'ASL shifts all bits left one position. 0 is shifted into bit 0 and the original bit 7 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = culng(.RegA) shl 1
        CalcFlag_Carry(.iLFResuNZ)
        .RegA = .iLFResuNZ
      #else 
        var Resu = culng(.RegA) shl 1
        .RegA = Resu
        CalcFlags_NZC(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_ASL() 'Arithmetic Shift Left Memory
      
      'ASL (Arithmetic Shift Left)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     ASL $44       $06  2   5
      'Zero Page,X   ASL $44,X     $16  2   6
      'Absolute      ASL $4400     $0E  3   6
      'Absolute,X    ASL $4400,X   $1E  3   7
      
      'ASL shifts all bits left one position. 0 is shifted into bit 0 and the original bit 7 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = culng(ReadByteOpcode(wMemAddr)) shl 1
        WriteByteOpcode(wMemAddr,.iLFResuNZ)
        CalcFlag_Carry(.iLFResuNZ)
      #else 
        var Resu = culng(ReadByteOpcode(wMemAddr)) shl 1
        WriteByteOpcode(wMemAddr,Resu)
        CalcFlags_NZC(Resu)
      #endif
      
    #endmacro    
    #macro fnOpcode_LSRA() 'Shift Right Accumulator
      
      'LSR (Logical Shift Right)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Accumulator   LSR A         $4A  1   2
      
      'LSR shifts all bits right one position. 0 is shifted into bit 7 
      'and the original bit 0 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = (.RegA shr 1)
        GetFlag(Carry) = (.RegA and 1)
        .RegA = .iLFResuNZ
      #else            
        GetFlag(Carry) = (.RegA and 1)
        .RegA = (.RegA shr 1)      
        CalcFlags_NZ(.RegA)
      #endif      
      
    #endmacro
    #macro fnOpcode_LSR() 'Shift Right
      
      'LSR (Logical Shift Right)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     LSR $44       $46  2   5
      'Zero Page,X   LSR $44,X     $56  2   6
      'Absolute      LSR $4400     $4E  3   6
      'Absolute,X    LSR $4400,X   $5E  3   7
      
      'LSR shifts all bits right one position. 0 is shifted into bit 7 
      'and the original bit 0 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = ReadByteOpcode(wMemAddr)
        GetFlag(Carry) = (.iLFResuNZ and 1)
        .iLFResuNZ = (.iLFResuNZ shr 1)
        WriteByteOpcode(wMemAddr,.iLFResuNZ)      
      #else            
        var Resu = ReadByteOpcode(wMemAddr)
        GetFlag(Carry) = (Resu and 1)
        Resu = (Resu shr 1)
        WriteByteOpcode(wMemAddr,Resu)      
        CalcFlags_NZ(Resu)
      #endif
      
    #endmacro    
    #macro fnOpcode_RORA() 'Rotate Right (trough carry) Accumulator
      
      'ROR (ROtate Right)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Accumulator   ROR A         $6A  1   2
      
      'ROR shifts all bits right one position. The Carry is shifted into bit 7 
      'and the original bit 0 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = (.RegA shr 1) or (GetFlag(Carry) shl 7)      
        GetFlag(Carry) = (.RegA and 1)
        .RegA = .iLFResuNZ
      #else      
        var Src = .RegA
        .RegA = (.RegA shr 1) or (GetFlag(Carry) shl 7)      
        GetFlag(Carry) = (Src and 1)
        CalcFlags_NZ(.RegA)
      #endif
      
    #endmacro
    #macro fnOpcode_ROR() 'Rotate Right (trough carry)
      
      'ROR (ROtate Right)
      'Affects Flags: N Z C
      
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     ROR $44       $66  2   5
      'Zero Page,X   ROR $44,X     $76  2   6
      'Absolute      ROR $4400     $6E  3   6
      'Absolute,X    ROR $4400,X   $7E  3   7
      
      'ROR shifts all bits right one position. The Carry is shifted into bit 7 
      'and the original bit 0 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        var Src = ReadByteOpcode(wMemAddr)
        .iLFResuNZ = (Src shr 1) or (GetFlag(Carry) shl 7)
        WriteByteOpcode(wMemAddr,.iLFResuNZ)
        GetFlag(Carry) = (Src and 1)
      #else
        var Src = ReadByteOpcode(wMemAddr)
        var Resu = (Src shr 1) or (GetFlag(Carry) shl 7)
        WriteByteOpcode(wMemAddr,Resu)
        GetFlag(Carry) = (Src and 1)
        CalcFlags_NZ(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_ROLA() 'Rotate Left (trough carry) accumulator
      
      'ROL (ROtate Left)
      'Affects Flags: N Z C
  
      'MODE           SYNTAX       HEX LEN TIM
      'Accumulator   ROL A         $2A  1   2
  
      'ROL shifts all bits left one position. The Carry is shifted into bit 0 
      'and the original bit 7 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = (culng(.RegA) shl 1) or GetFlag(Carry)
        .RegA = .iLFResuNZ
        CalcFlag_Carry(.iLFResuNZ)
      #else
        var Resu = (culng(.RegA) shl 1) or GetFlag(Carry)
        .RegA = Resu
        CalcFlags_NZC(Resu)
      #endif
      
    #endmacro
    #macro fnOpcode_ROL() 'Rotate Left (trough carry)
      
      'ROL (ROtate Left)
      'Affects Flags: N Z C
  
      'MODE           SYNTAX       HEX LEN TIM
      'Zero Page     ROL $44       $26  2   5
      'Zero Page,X   ROL $44,X     $36  2   6
      'Absolute      ROL $4400     $2E  3   6
      'Absolute,X    ROL $4400,X   $3E  3   7
  
      'ROL shifts all bits left one position. The Carry is shifted into bit 0 
      'and the original bit 7 is shifted into the Carry.
      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = (culng(ReadByteOpcode(wMemAddr)) shl 1) or GetFlag(Carry)
        WriteByteOpcode(wMemAddr,.iLFResuNZ)
        CalcFlag_Carry(.iLFResuNZ)
      #else
        var Resu = (culng(ReadByteOpcode(wMemAddr)) shl 1) or GetFlag(Carry)
        WriteByteOpcode(wMemAddr,Resu)
        CalcFlags_NZC(Resu)
      #endif
      
    #endmacro
  rem --------------- stack -------------
    #macro fnOpcode_TXS() 'transfer X to SP
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'TXS (Transfer X to Stack ptr)   $9A  2
      'TSX (Transfer Stack ptr to X)   $BA  2
      'PHA (PusH Accumulator)          $48  3
      'PLA (PuLl Accumulator)          $68  4
      'PHP (PusH Processor status)     $08  3
      'PLP (PuLl Processor status)     $28  4
      
      .RegSP = .RegX
      
      
    #endmacro
    #macro fnOpcode_TSX() 'transfer SP to X
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'TSX (Transfer Stack ptr to X)   $BA  2
      
      .RegX = .RegSP
      
      
    #endmacro
    #macro fnOpcode_PHA() 'Push Accumulator 
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'PHA (PusH Accumulator)          $48  3
      'PLA (PuLl Accumulator)          $68  4
      'PHP (PusH Processor status)     $08  3
      'PLP (PuLl Processor status)     $28  4
      
      .RegSP -= 1
      WriteByteFast((&h100+.RegSP),.RegA)
      
    #endmacro
    #macro fnOpcode_PLA() 'Pull Accumulator 
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'PLA (PuLl Accumulator)          $68  4
      
      .RegA = ReadByteFast((&h100+.RegSP))
      .RegSP += 1
      
    #endmacro
    #macro fnOpcode_PHP() 'Push Processor status (flags)
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'PHP (PusH Processor status)     $08  3
      
      .RegSP -= 1
      #ifdef LazyFlagsNZ
        CalcFlags_NZ(.iLFResuNZ)
      #endif
      WriteByteFast((&h100+.RegSP),.RegP.bFlags)
      
    #endmacro
    #macro fnOpcode_PLP() 'Pull Processor status (flags)
      
      'Stack Instructions
      'These instructions are implied mode, have a length of one byte 
      'and require machine cycles as indicated. 
      'The "PuLl" operations are known as "POP" on most other microprocessors.
      'With the 6502, the stack is always on page one ($100-$1FF) and works top down.
  
      'MNEMONIC                        HEX TIM
      'PLP (PuLl Processor status)     $28  4
      
      .RegP.bFlags = ReadByteFast((&h100+.RegSP))      
      #ifdef LazyFlagsNZ
        .iLFResuNZ = iif( FlagVar(Zero) , 0 , FlagVar(Negative) shl 7 )
      #endif
      .RegSP += 1
      
    #endmacro
  rem --------------- other -------------
    #macro fnOpcode_BRK()            
      if 0 then '.bDebug then 
        if g_bBreakPoint = .RegPC-1 then 
          .bBreak = 1 : g_bBreakPoint = -1
        else
          g_bBreakPoint = .RegPC-1 : .RegPC -= 1       
        end if
      else
        .bBreak = 1
      end if
    #endmacro
    #macro fnOpcode_NOP()
      rem nope...
    #endmacro
  rem -----------------------------------
  
  #macro _GenerateFunction(_op,_addr)
    :    
    '#print _op
    #if #_addr <> "__x_"
    sub fnOpcode_##_op##_addr()
      _Begin
        #if #_addr <> "_none" and #_addr <> "_Acc"
          fnAddr##_addr()
        #endif
        fnOpcode_##_op()
      _End
    end sub
    #endif    
    :
  #endmacro
  #define fnOpcode_z__x_ fnOpcode__x_
  #define fnOpcode_RTI fnOpcode_Unimplemented
  ForEachOpcode( _GenerateFunction )  
  #undef _GenerateFunction
    
  #define _DeclOp(_op,_addr) @fnOpcode_##_op##_addr, 
  static shared as sub() g_fnOpcode(256) = { ForEachOpcode(_DeclOp) 0 }
  #undef _DeclOp
  
  
  
end namespace
