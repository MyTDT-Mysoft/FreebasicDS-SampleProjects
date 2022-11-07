#ifdef __FB_NDS__
type glList as uinteger ptr
namespace Pack
dim shared as glList  CurrentPackedList
dim shared as integer CurrentPackedMax
dim shared as integer PackCount,CmdPos
dim shared as integer LastVecX , LastVecY , LastVecZ

#define CPP CurrentPackedCommand
#define CPL CurrentPackedList
#define cpm CurrentPackedMax

#macro WriteCommand(CmdNum)
if PackCount > 24 then 
  PackCount=0: CmdPos = *CPL: *CPL += 1
end if
if PackCount then
  CPL[CmdPos] or= (CmdNum) shl PackCount
  PackCount += 8
else
  CPL[CmdPos] = (CmdNum)
  PackCount = 8
end if  
#endmacro

#macro ReserveWords(WordNum)
if (*CPL+(WordNum+1)) >= cpm then  
  cpm += 256: CPL = Reallocate(CPL, cpm shl 2)
end if
#endmacro

'====================================================================
'====================================================================
'====================================================================
'--------------------------------------------------------------------
sub DmaReady()
  dim as integer DMACR = &h40000B8
  asm
    0: ldr r0, $DMACR
    ldr r1,[r0]
    ands r1, r1
    bmi 0b
  end asm
end sub
'--------------------------------------------------------------------
sub CallList alias "CallList__FB__INLINE__"(pList as glList,Async as integer=0)
  
  'if pList = 0 then end
  
  dim as u32 count = *pList
  var pList2 = cptr(glList,memuncached(pList))  
  
  if (count and &h8000) then
    count and= (not &h8000)
    const Parm1 = POLY_ALPHA(31) or Poly_ID(0) or POLY_FORMAT_LIGHT0 or _
    POLY_FOG or POLY_ALPHADEPTH_UPDATE or POLY_FARPLANE_RENDER
    const Parm2 = POLY_ALPHA(31) or POLY_CULL_NONE or POLY_FORMAT_LIGHT0 or _ 
    POLY_FARPLANE_RENDER or POLY_ALPHADEPTH_UPDATE or POLY_FOG or Poly_ID(0)    
    var iParm = iif(iSwapFrame,Parm2,Parm1)
    var pListOffs = pList+count+1
    for CNT as integer = 0 to 31
      var iOff = cint(pListOffs[CNT])
      if iOff < 0 then exit for
      pList2[iOff] = iParm      
    next CNT    
  end if
    
  pList += 1
  
  'send the packed list asynchronously via DMA to the FIFO
  DMA_SRC(0) = cast(u32,pList)
  DMA_DEST(0) = &h4000400
  DMA_CR(0) = DMA_FIFO or count
  
  if Async = 0 then
    dim as integer DMACR = &h40000B8
    asm
      ldr r0, $DMACR
      0: ldr r1,[r0]
      ands r1, r1
      bmi 0b
    end asm
  end if
  
      
end sub
'--------------------------------------------------------------------
function NewList() as uinteger ptr  
  CPL = allocate(1024): cpm = 256: CPL[0] = 2
  LastVecX = -65536 : LastVecY = -65536 : LastVecZ = -65536
  PackCount=0: CmdPos = 1
  return CPL
end function
'--------------------------------------------------------------------
sub EndList()
  CPL = Reallocate(CPL, (*CPL) shl 2)
  DC_FlushRange(CPL, (*CPL) shl 2)
  *CPL -= 1  
  'static as integer CPTOT
  'CPTOT += *CPL
  'print hex$(CPL),*CPL,CPTOT shl 2: sleep 100
  LastVecX = -65536 : LastVecY = -65536 : LastVecZ = -65536
  CurrentPackedMax = 0: CurrentPackedList = 0
  PackCount=0: CmdPos = 1
end sub
'--------------------------------------------------------------------
sub Begin(PolyType as integer)
  'print "glBegin": sleep 100
  ReserveWords(2)
  WriteCommand(FIFO_BEGIN)
  CPL[*CPL] = PolyType
  *CPL += 1
end sub
'--------------------------------------------------------------------
function Color3f( fRed as single , fGreen as single , fBlue as single ) as integer
  'print "glColor3f": sleep 100
  dim as ushort Color16 = _
  ((fRed)*31.49)+(((fGreen)*31.49) shl 5)+(((fBlue)*31.49) shl 10)
  ReserveWords(2)
  WriteCommand(FIFO_COLOR)
  CPL[*CPL] = Color16
  *CPL += 1
  return Color16
end function
'--------------------------------------------------------------------
sub LightColori( iColor16 as integer )
   'print "glLightColor": sleep 100
  ReserveWords(2)
  WriteCommand(FIFO_LIGHT_COLOR)
  CPL[*CPL] = (iColor16 and &h7FFF)
  *CPL += 1
end sub
'--------------------------------------------------------------------
sub Colori( iColor16 as integer )
  'print "glColor": sleep 100
  ReserveWords(2)
  WriteCommand(FIFO_COLOR)
  CPL[*CPL] = (iColor16 and &h7FFF)
  *CPL += 1
end sub
'--------------------------------------------------------------------
sub Normal3f( fX as single, fY as single , fZ as single )
  ReserveWords(2)
  WriteCommand(FIFO_NORMAL)
  CPL[*CPL] = NORMAL_PACK(floattov10(fX), floattov10(fY), floattov10(fZ))
  *CPL += 1
end sub
'--------------------------------------------------------------------
sub Normali( iNormal32 as integer )
  ReserveWords(2)
  WriteCommand(FIFO_NORMAL)
  CPL[*CPL] = iNormal32
  *CPL += 1
end sub  
'--------------------------------------------------------------------
sub Vertex3v16( iVertX as short , iVertY as short , iVertZ as short )
  #define FIFO_VERTEX_DIFF			REG2ID(pGFX_VERTEX_DIFF)
  ReserveWords(3)
  
  if iVertX = LastVecX then    
    WriteCommand(FIFO_VERTEX_YZ)
    CPL[*CPL] = cuint(iVertY) or (cuint(iVertZ) shl 16)
    *CPL += 1
  elseif iVertY = LastVecY then
    WriteCommand(FIFO_VERTEX_XZ)
    CPL[*CPL+1] = cuint(iVertX) or (cuint(iVertZ) shl 16)
    *CPL += 1
  elseif iVertZ = LastVecZ then
    WriteCommand(FIFO_VERTEX_XY)
    CPL[*CPL] = cuint(iVertX) or (cuint(iVertY) shl 16)
    *CPL += 1
  else        
    dim as uinteger iX = abs(iVertX-LastVecX) < (1 shl 12)
    dim as uinteger iY = abs(iVertY-LastVecY) < (1 shl 12)
    dim as uinteger iZ = abs(iVertZ-LastVecZ) < (1 shl 12)
    if (iX and iY and iZ) then 
      iX = ((iVertX-LastVecX) shr 3) and ((1 shl 10)-1)
      iY = ((iVertY-LastVecY) shr 3) and ((1 shl 10)-1)
      iZ = ((iVertZ-LastVecZ) shr 3) and ((1 shl 10)-1)
      WriteCommand(FIFO_VERTEX_DIFF)
      CPL[*CPL] = iX or (iY shl 10) or (iZ shl 20)
      *CPL += 1
    else
      '#define LessPrecision
      #ifdef LessPrecision
      dim as uinteger iX = (cuint(ivertX shr 6) and ((1 shl 10)-1)) shl 0
      dim as uinteger iY = (cuint(ivertY shr 6) and ((1 shl 10)-1)) shl 10
      dim as uinteger iZ = (cuint(ivertZ shr 6) and ((1 shl 10)-1)) shl 20
      WriteCommand(FIFO_VERTEX10)
      CPL[*CPL] = iX or iY or iZ
      *CPL += 1
      #else
      dim as uinteger iX = (cuint(ivertX) and ((1 shl 16)-1)) shl 0
      dim as uinteger iY = (cuint(ivertY) and ((1 shl 16)-1)) shl 16
      dim as uinteger iZ = (cuint(ivertZ) and ((1 shl 16)-1)) shl 0
      WriteCommand(FIFO_VERTEX16)
      CPL[*CPL] = iX or iY
      CPL[*CPL+1] = iZ
      *CPL += 2
      #endif
    end if    
  end if
end sub
'--------------------------------------------------------------------
function GetOffset() as integer
  return *CPL
end function
'--------------------------------------------------------------------
sub Finish()
  exit sub
  ReserveWords(2)
  WriteCommand(FIFO_END)
  *CPL += 1
end sub
'--------------------------------------------------------------------
sub PolyFmt( iParameters as integer )
  ReserveWords(2)
  WriteCommand(FIFO_POLY_FORMAT)
  CPL[*CPL] = iParameters
  *CPL += 1
end sub
'====================================================================
'====================================================================
'====================================================================
#undef ReserveWords
#undef CPL
#undef cpm
end namespace
#else
type glList as uinteger
#endif