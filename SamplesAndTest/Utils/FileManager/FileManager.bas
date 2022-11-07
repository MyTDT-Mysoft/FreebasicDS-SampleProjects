#define xfbc -s gui

dim shared as short iFontSz(255)

#define SC2X_X 256
#define SC2X_Y 192


#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#define bpp 8
#else
#include "fbgfx.bi"
#include "crt.bi"
#include "MyTDT\scale2x.bas"
#include "hq2x.bi"
chdir exepath+"/NitroFiles"
#define bpp 16
#endif

#include "vbcompat.bi"
#include "ModulesFileManager\LinkedList.bas"

const ScrWid=SC2X_X,ScrHei=SC2X_Y
const MidX=ScrWid shr 1,MidY=ScrHei shr 1
const iListMax = 1023

#if bpp=16
type pixel as ushort
const _Shadow50_ = &b1111011111011110
#ifdef Scale2xLoaded
using bpp16
#endif
#else
type pixel as ubyte
const _Shadow50_ = &b11011010
#ifdef Scale2xLoaded
using bpp8
#endif
#endif

dim shared as fb.image ptr gBuff,gFont,gTheme,gPalette
dim shared sLines(iListMax) as string
dim shared as string sDirTag,sDirTag2,sFoldSplit
dim shared as integer iLineMax = ((192-8) shr 3)-1
dim shared as ulong iPal(255)
dim shared as pixel ptr pPal,pScr
dim shared as ItemList tWinLeft

dim shared as integer iLocked,iMove,iBut,iOMY,iOMR
dim shared as integer MX,MY,MR,MB,NX,NY,NR,NB
dim shared as integer iScroll,iSelect,iOffset
dim shared as integer iDelay,iOffWay,iOldCur=-1
dim shared as double MoveTMR,ClickTMR,CurTMR

with tWinLeft
  .X1 = 0: .Y1 = 0
  .X2 = 255: .Y2 = 191
  .iLineMax = (((.Y2-.Y1)-8) shr 3)
end with

function ImageLoad(sFile as string) as fb.image ptr
  var f = freefile(),iWid=0,iHei=0
  if open(sFile for binary access read as #f) then
    color 12: printf(!"Failed to load '%s'\n",sFile)
    sleep: end
  end if
  get #f,19,iWid : get #f,,iHei : close #f  
  var pImg = ImageCreate(iWid,iHei)
  if pImg = 0 then
    color 12: printf("Failed to allocate memory for '%s'\n",sFile)
    sleep: end
  end if
  bload sFile,pImg : return pImg  
end function
sub DrawText(iPX as integer,iPY as integer,sText as string,iColor as ulong=0)
  var pSrc = cast(pixel ptr,gFont+1)
  var pTgt = cast(pixel ptr,gBuff+1)
  if gBuff=0 then pTgt=screenptr
  pTgt += iPY*ScrWid+iPX
  for CNT as integer = 0 to len(sText)-1
    var iChar = sText[CNT],iZ = iFontSz(iChar)    
    if iPX+(iZ+2) >= SC2X_X then exit sub
    var pIn=pSrc+((iChar shr 4) shl 10)+((iChar and 15) shl 3)        
    for iX as integer = 0 to iZ
      if pIn[iX+000] then pTgt[iX+0000] = iColor
      if pIn[iX+128] then pTgt[iX+0256] = iColor
      if pIn[iX+256] then pTgt[iX+0512] = iColor
      if pIn[iX+384] then pTgt[iX+0768] = iColor
      if pIn[iX+512] then pTgt[iX+1024] = iColor
      if pIn[iX+640] then pTgt[iX+1280] = iColor
      if pIn[iX+768] then pTgt[iX+1536] = iColor
    next iX    
    iPX += (iZ+2): pTGT += (iZ+2)
  next CNT
end sub
function TextSize(sText as string) as integer
  dim as integer iSize = 0
  for CNT as integer = 0 to len(sText)-1
    iSize += ( iFontSz( sText[CNT] ) +2 )
  next CNT
  return iSize
end function
sub TextPadd(sText as string,iSize as integer,iAlign as integer=0)  
  var TagSz=TextSize(sText),TagDiff=iSize-TagSz,TagEx=0
  if iAlign = 1 then TagEx=TagDiff and 1: TagDiff shr= 1  
  var Tag32=TagDiff\5,Tag31=0,Tag30=0,iTmp=Tag32*5  
  while (TagDiff-iTmp) >= 3
    iTmp += 3: Tag31 += 1
  wend
  while iTmp < TagDiff
    iTmp += 2: Tag30 += 1
  wend
  while iTmp > TagDiff
    if Tag32 then 
      Tag32 -= 1: Tag30 += 2: iTmp -= 1
    elseif Tag31 then
      Tag31 -= 1: Tag30 += 1: iTmp -= 1
    else
      printf(!"Error!!!\n"): exit while
    end if
  wend
  var sTemp = string$(Tag32,32)+string$(Tag31,31)+string$(Tag30,30)
  select case iAlign
  case 0 'Left
    sText += sTemp
  case 1 'Center
    sText = sTemp+sText+sTemp
    while TagEx    
      if Tag32 then sText[0] = 29 : exit while     
      if Tag31 then sText[Tag32] = 28 : exit while
      if Tag30 then sText[Tag32+Tag31] = 31: TagEx=0    
    wend
  case 2 'Right
    sText = sTemp+sText
  end select  
  var iChk=TextSize(sText)
  if iChk <> iSize then
    printf(!"[%s]%i/%i(%i,%i,%i)\n",sText,iChk,iSize,Tag32,Tag31,Tag30)
  end if  
  'printf(!"%i %i %i %i %i\n[%s]\n",iSize,TagSz,TagDiff,iTmp,TextSize(sTemp),sText)
end sub
sub EnumPath(sBaseDir as string,iRecursive as integer=0)
  color 11:printf("List:")
  color 7:printf(!"'%s'\n",sBaseDir)
  if len(sDirTag)=0 then
    sDirTag = "<DIR>" : TextPadd(sDirTag,36,0)
    sDirTag2 = !"<UP\9Dir>" : TextPadd(sDirTag2,36,0)
  end if
  'printf(!"Lines=%i\r",iTotLines)
  var iDirStart=iTotLines+1,iFileEnd=0
  var iFileStart=iTotLines+1,iAttrib=0  
  var sText = dir$(sBaseDir+"*",fbNormal or fbDirectory,@iAttrib)
  while len(sText)  
    if sText <> "." and iTotLines < iListMax then    
      iTotLines += 1
      if (iAttrib and fbDirectory) then      
        var iAddPosi = iFileStart
        if iDirStart <> iFileStart then
          var sTemp = lcase$(sText)
          for iAddPosi = iDirStart to iFileStart-1
            if sTemp < lcase$(sLines(iAddPosi)) then exit for
          next iAddPosi
        end if
        for CNT as integer = iTotLines-1 to iAddPosi step -1
          sLines(CNT+1) = sLines(CNT)
        next CNT
        sLines(iAddPosi) = sText 'sDirTag+!"\9\9"+sText+"/"
        iFileStart += 1
      else
        var iAddPosi = iTotLines
        if iFileStart <> iTotLines then
          var sTemp = lcase$(sText)
          for iAddPosi = iFileStart to iTotLines-1
            if sTemp < lcase$(sLines(iAddPosi)) then exit for
          next iAddPosi
        end if        
        for CNT as integer = iTotLines-1 to iAddPosi step -1
          sLines(CNT+1) = sLines(CNT)
        next CNT        
        sLines(iAddPosi) = sText 'sSize+!"\9\9"+sText
      end if
    end if
    sText = dir$(@iAttrib)
  wend
  iFileEnd = iTotLines
  for CNT as integer = iDirStart to iFileStart-1
    if iRecursive and iTotLines<(iListMax-2) then       
      var iPathLine = iTotLines+2
      sLines(iTotLines+1)="":sLines(iTotlines+3)=""
      sLines(iPathLine)=sBaseDir+sLines(CNT)+sFoldSplit
      iTotLines += 3: EnumPath(sLines(iPathLine),iRecursive)
      if sLines(iPathLine)[0] = asc(".") then
        sLines(iPathLine) = mid$(sLines(iPathLine),2)
      end if      
    end if
    iTotFolders += 1
    if sLines(CNT) = ".." then
      sLines(CNT) = sDirTag2+!"\9\9"+sLines(CNT)
    else
      sLines(CNT) = sDirTag+!"\9\9"+sLines(CNT)+sFoldSplit
    end if
  next CNT
  for CNT as integer = iFileStart to iFileEnd
    var iSize = FileLen(sBaseDir+sLines(CNT))
    var sSize = string$(15,0)
    if iSize < 1000^1 then
      sprintf(sSize,"%ib",iSize)
    elseif iSize < 1000^2 then
      sprintf(sSize,"%.2fk",iSize/1024)
    elseif iSize < 1000^3 then
      sprintf(sSize,"%.2fm",iSize/(1024^2))
    else
      sprintf(sSize,"%.2fg",iSize/(1024^3))
    end if    
    sSize = *cptr(zstring ptr,strptr(sSize))
    TextPadd(sSize,36,2): iTotFiles += 1    
    sLines(CNT) = sSize+!"\9\9"+sLines(CNT)
  next CNT
end sub
sub SetHeader(iBaseLine as integer,sHeader as string)
  #ifdef __FB_NDS__
  SLines(iBaseLine+1) = !"\5 FAT1:"+sHeader+" "
  #else
  SLines(iBaseLine+1) = !"\5 "+sHeader+" "
  #endif
  var iSz1 = TextSize(SLines(iBaseLine+1))
  Var iSz2 = TextSize(!"\6")
  Var iSz3 = TextSize(!"\1")
  var iSz4 = TextSize(!" ")
  Var iMul = ((iSz1-iSz3)+(iSz2-1))\(iSz2)
  if cuint(((iMul*iSz2+iSz3)-(iSz1))-1) < 2 then
    cptr(uinteger ptr,@SLines(iBaseLine+1))[1] -= 1
  end if    
  sLines(iBaseLine+0) = !"\1"+String$(iMul,6)+!"\2"
  sLines(iBaseLine+2) = !"\3"+String$(iMul,6)+!"\4"
  TextPadd(sLines(iBaseLine+1),iMul*iSz2+iSz3)
  sLines(iBaseLine+1) += !"\5"
end sub
sub DrawTooltip(iTipX as integer,iTipY as integer,sTipText as string)
  var iTipSz = TextSize(sTipText)
  if iTipX < 3 then iTipX = 3
  if iTipY < 3 then iTipY = 3
  if (iTipX+iTipSz+5) > 252 then iTipx=252-iTipSz-5    
  line gBuff,(iTipX+1,iTipY+1)-(iTipX+iTipSz+3,iTipY+11),iPal(254),bf
  line gBuff,(iTipX,iTipY)-(iTipX+iTipSz+4,iTipY+12),iPal(0),b
  DrawText(iTipX+3,iTipY+3,sTipText,pPal[0])    
  var pPixV = pScr+((iTipY+1)*256)+(iTipX+iTipSz+5)
  var pPixH = pScr+((iTipY+13)*256)+(iTipX+1)
  for CNT as integer = 0 to 11
    *pPixV = (*pPixV and _Shadow50_) shr 1: pPixV += 256
  next CNT
  for CNT as integer = 0 to iTipSz+4
    pPixH[CNT] = (pPixH[CNT] and _Shadow50_) shr 1
  next CNT
end sub
function UpdateWindow(pHandle as ItemList ptr) as integer
  if pHandle=0 then exit sub
  
  with *pHandle
    
    dim as integer Y=4,iLine,iCurPos=(.iCur-.iAtuLine)
    
    line gBuff,(.X1,.Y1)-(.X2,.Y2),-1,bf
    if cuint(iCurPos) <= iLineMax then
      line gBuff,(0,3+iCurPos*8)-(255,iCurPos*8+11),iPal(1),bf
    end if
    for iLine = iAtuLine to (iAtuLine+iLineMax)
      if iLine > iTotLines then exit for
      if iLine = iCur then 
        DrawText(2,Y,mid$(sLines(iLine),iOffset+1),pPal[252])      
      else
        DrawText(2,Y,sLines(iLine),pPal[0])
      end if
      Y += 8: if Y > (ScrHei-8) then exit for
    next iLine
      
    if iLine > iTotLines then iLine = iTotLines
    'printf(!"\r       \r%ins",cint((timer-sTimer)*10000))
    
    if iAtuline < 0 then iAtuline += 1
    if iLine > iTotLines then iAtuLine -= 1
    if iAtuLine >= 0 and iLine <= iTotLines then
  end with
end function
  
#ifdef Scale2xLoaded
screenres ScrWid*2,ScrHei*2,bpp
gBuff = ImageCreate(SC2X_X,SC2X_Y,-1)
#else
screenres ScrWid,ScrHei,bpp
gBuff = 0: line(0,0)-(SC2X_X,SC2X_Y),-1,bf
#endif

gFont = ImageLoad("font.bmp")
gTheme = ImageLoad("theme.bmp")
gPalette = ImageLoad("palette.bmp")
pPal = cast(pixel ptr,gPalette+1): pPal[0] = 0
if pPal[1]=1 then palette 0,0
for CNT as integer = 0 to 255
  iPal(CNT) = point(CNT and 31,CNT shr 5,gPalette)
next CNT

#ifdef __FB_NDS__
if fatInitDefault() = 0 then
  printf(!"Failed to init fat...\n")
  printf(!"Listing NitroFS :(\n")
end if
#endif

scope 'Getting Font Char Sz
  var pPix = cast(pixel ptr,gFont+1)
  dim as integer Y,X,PX,PY
  for Y = 0 to 255 step 16
    for PY = 0 to 7
      for X = 0 to 15
        for PX=0 to 7
          if *pPix andalso PX > iFontSz(Y+X) then iFontSz(Y+X) = PX
          pPix += 1
        next PX
      next X
    next PY
  next Y
  iFontSz(32) = 3 : iFontSz(31) = 1 : iFontSz(30) = 0
  iFontSz(29) = 4 : iFontSz(28) = 2
end scope

#ifdef __FB_NDS__
var sDir = ""
#else
var sDir = exepath
#endif

sFoldSplit = "/"
for CNT as integer = 0 to len(sDir)
  select case sDir[CNT] 
  case asc("/"): exit for
  case asc("\"): sFoldSplit[0] = asc("\")
  end select
next CNT
sDir += sFoldSplit

iAtuLine=0:iTotLines=2:EnumPath(sDir,0)
if iLineMax > iTotLines then iLineMax = iTotLines
SetHeader(0,sDir):iCur=3

'printf(!"Lines=%i\nFiles=%i\nFolders=%i\n",iTotLines,iTotFiles,iTotFolders)

#ifdef __FB_NDS__
#define _KeyUp_     -fb.SC_ButtonUP
#define _KeyDown_   -fb.SC_ButtonDown
#define _KeyQuit_   -fb.SC_ButtonStart
#define _KeyPgUp_   -fb.SC_ButtonL
#define _KeyPgDn_   -fb.SC_ButtonR
#define _KeySelect_ -fb.SC_ButtonA
#define _KeyUpDir_  -fb.SC_ButtonB
#else
#define _KeyUp_     -fb.SC_UP
#define _KeyDown_   -fb.SC_Down
#define _KeyQuit_   27,-asc("k")
#define _KeyPgUp_   -fb.SC_PageUp
#define _KeyPgDn_   -fb.SC_PageDown
#define _KeySelect_ 13
#define _KeyUpDir_  8
#endif

if gBuff=0 then pScr=screenptr else pScr=cast(any ptr,gBuff+1)

do
    
  
  if iLocked=0 then screenlock: iLocked=1
  
  var sTimer = timer  
    
  var iToUpdate = UpdateWindow(@tWinLeft)
  DrawToolTip(MX,MY-16,str$(MX) & "," & str$(MY)& " Hi Quadrescence, i'm a tooltip!")  
    
  if iToUpdate then
    'if abs(iMove) < 5 then
    #ifndef Scale2xLoaded
    if iLocked then screenunlock:iLocked=0
    sleep 1,1: screensync
    #else  
    #if bpp=8
    Resize2x(gBuff+1,screenptr)
    'Scale2x(gBuff+1,screenptr)
    #else
    hq2x_16(gBuff+1,screenptr,256,192,256*4)
    'rgb2x(gBuff+1,screenptr)
    #endif
    sleep 1,1: screensync
    if iLocked then screenunlock:iLocked=0
    #endif
    'end if
  else
    if iLocked then screenunlock:iLocked=0
  end if  
  
  do
    var sKey = inkey$
    if len(sKey) = 0 then exit do
    var iChar = cint(sKey[0])    
    if iChar=255 then iChar = -cint(sKey[1])    
    select case iChar
    case _KeyUpDir_  : iSelect = -1
    case _KeySelect_ : iSelect = 1
    case _KeyUp_     : iMove = -1      
    case _KeyPgUp_ 
      iMove = -(iLine-iAtuLine)
      if iAtuLine > 0 then iScroll = 1
    case _KeyDown_   : iMove = 1      
    case _KeyPgDn_ 
      iMove = (iLine-iAtuLine)
      if iAtuLine < (iTotLines-iLineMax) then iScroll = 1
    case _KeyQuit_   : exit do,do
    end select
  loop
  
  getmouse NX,NY,NR,NB
  if NB <> -1 then
    #ifdef Scale2xLoaded
    MX=NX shr 1:MY=(NY shr 1)
    MR=NR:MB=NB    
    #else
    MX=NX:MY=NY:MB=NB
    #endif
  end if  
  if (MB and 1) then
    if iBut=0 then
      iBut=1:iOMY=MY:MoveTMR=timer
      if MY >= 4 and MY < 188 then        
        iCurPos = ((MY-4) shr 3): var iCur2 = iAtuLine+iCurPos
        if iCur=iCur2 and (timer-ClickTMR) < 1/3 then iSelect = 1
        CLickTMR = timer: iCur = iCur2
      end if
    elseif iBut=1 and abs(iOMY-MY) >= 4 then
      iMove = sgn(iOMY-MY): iOMY -= iMove shl 2
      if iMove < 0 and iAtuLine <= 0 then iMove = 0
      if iMove > 0 and iAtuLine >= (iTotLines-iLineMax) then iMove = 0
      if iMove then iScroll = 1
      MoveTMR=timer
    else
      var fTMY = (((1-((abs(MY-MidY))/MidY))+(1/60))^2)
      if abs(timer-MoveTMR) > .5+fTMY then        
        iBut=2:MoveTMR += fTMY: iMove = sgn(MidY-MY)
      end if      
    end if
  else
    iBut=0
    if iOMR <> MR then
      iMove = sgn(iOMR-MR)*3
      iOMR = MR: iScroll = 1      
    end if
  end if
  
  if iMove then
    var iSum = iif(abs(iMove)<5,abs(iMove),5)
    if abs(iMove) <= 1 then iSum = 1    
    if iMove < 0 then 
      iMove += iSum
      if iAtuLine > 0 or iCurPos > 0 then         
        if iScroll or iCurPos <= 0 then 
          iAtuLine -= iSum: iCur -= iSum
        else 
          iCur -= iSum: iCurPos -= iSum
        end if
      end if
    end if
    if iMove > 0 then 
      iMove -= iSum
      if iLine < iTotLines or iCurPos < iLineMax then 
        if iScroll or iCurPos >= (iLineMax) then
          iAtuLine += iSum: iCur += iSum
        else 
          iCur += iSum: iCurPos += iSum
        end if
      end if
    end if
  else    
    '
  end if
    
  if iAtuLine < 0 then iAtuLine = 0: iMove = 0
  if iAtuLine > (iTotLines-iLineMax) then iAtuLine = (iTotLines-iLineMax): iMove = 0
  if iAtuLine <= 0 then
    if iCurPos < 0 then iCur = iAtuLine
  end if
  if iAtuLine >= (iTotLines-iLineMax) then
    if iCurPos > iLineMax then iCur = iAtuLine+iLineMax
  end if
  if iMove = 0 then iScroll = 0
  
  if iSelect then    
    var sSel = sLines(iAtuLine+iCurPos)
    if iSelect<0 then sSel = sDirTag+!"\9\9.."    
    var iPos = instr(1,sSel,!"\9\9")
    if iPos and sSel[0]=sDirTag[0] then
      sSel = mid$(sSel,iPos+2)
      if sSel = ".." then
        var iSz = -1
        for CNT as integer = 0 to len(sDir)-2
          if sDir[CNT] = sFoldSplit[0] then iSz = CNT
        next CNT
        if iSz <> -1 then
          sSel = mid$(sDir,iSz+2): iSelect = -1
          sDir = left$(sDir,iSz+1)
        else
          iSelect = 0
        end if
      else
        sDir += sSel
      end if      
      iTotFiles=0:iTotFolders=0
      iCur=0:iCurPos=0: iAtuLine=0            
      for iTotLines = iTotLines to 3 step -1
        sLines(iTotLines) = ""
      next iTotLines
      EnumPath(sDir,0): iCur = 3
      iLineMax = ((192-8) shr 3)-1
      if iSelect < 0 then
        for CNT as integer = 3 to 2+iTotFolders
          if right$(sLines(CNT),len(sSel)) = sSel then
            iCur = CNT: iAtuLine = iCur-(iLineMax shr 1)
            if iAtuLine < 0 then iAtuLine = 0
          end if
        next CNT
      end if
      SetHeader(0,sDir): iOldCur = -1
      if iLineMax > iTotLines then iLineMax = iTotLines
    end if
    iSelect = 0
  end if
    
  if iCur <> iOldCur then 
    iOldCur = iCur: CurTMR = timer: iOffWay = 0: iOffset = 0
  end if
  if (timer-CurTMR) > 1 then
    iDelay += 1
    if iDelay = 5 then
      iDelay = 0
      if iOffWay=0 then
        if TextSize(mid$(sLines(iCur),iOffset+1)) < (256-4) then
          iOffWay = 1: CurTMR = timer
        else
          iOffset += 1
        end if
      else 'if OffWay=1 then
        if iOffset <= 0 then
          iOffWay = 0: CurTMR = timer
        else
          iOffset -= 1
        end if
      end if
    end if
  end if
  
loop
