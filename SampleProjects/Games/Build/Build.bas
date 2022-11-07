#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
#include "fbgfx.bi"
chdir "NitroFiles/"
#endif

#ifdef __FB_WIN32__
#include "windows.bi"
SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS)
#endif

type SectorWall
  as integer X1,Y1,X2,Y2,COUNT
end type

type SectorCast
  as integer PT,SP,C2,M2,KI,WAL
end type

declare sub RayTrace(COUNT as integer)

dim shared as ubyte ATUMASK
dim shared as any ptr VidSeg,RealAdr

' *********** Matrizes Extras ***************
dim shared as ubyte COR
dim shared as any ptr ImgFundo,ImgBar,ImgWeapon,ImgCross,ImgTile,ImgPic
dim shared as any ptr ImgBuff,pPic
#ifdef __FB_NDS__
dim shared as single TMR,UPF,TMRSCL,FPSUM,BACKX,CtlTimer
#else
dim shared as double TMR,UPF,TMRSCL,FPSUM,BACKX,CtlTimer
#endif
dim shared as short FPSHW,AFOR,BFOR,CFOR
dim shared as short QUACOUNT,COUNTAND3,COUNTME,COUNTMA
dim shared as integer FPS

const RESX = 256, RESY = 192
const HALFRESX = RESX shr 1
const QUARESX = RESX shr 2
const HALFRESY = RESY shr 1
const SCRBYTES = ((RESX*(RESY-1)) shr 2) - 1
const SCREND = RESX*RESY
const SCRSCALE = RESY / 200
screenres RESX,RESY,8

' ************ Matrizes do build *************
const NumLines = 25
dim shared as string Tecla
dim shared as SectorCast SectorLine(NUMLINES)
'dim shared as integer PT(NUMLINES), SP(NUMLINES)
'dim shared as integer M2(NUMLINES), C2(NUMLINES)
'dim shared as integer KI(NUMLINES), WAL(NUMLINES)
dim shared as integer SINTABLE(2048),TANTABLE(1024)
dim shared as integer MASK(4)
dim shared as integer HEIGHT(RESX),LINUM(RESX),KIND(RESX)
dim shared as integer RADARANG(RESX)
dim shared as integer Z,POSX,POSY,ANG,COUNT,PICPLC,LINESATONCE
dim shared as integer IF0,ZX,YC0,ANGLE,QUAD
dim shared as integer X1,Y1,X2,Y2
dim shared as integer M0,M1,M2A,C0,C1,DIVIT
dim shared as integer X,Y
dim shared as integer NEWX,NEWY

dim shared as SectorWall WallData(NumLines-1) = { _
(285,040,360,140,0),(360,140,410,140,0), _
(410,140,470,040,0),(470,040,360,040,0), _
(360,040,285,040,3),(285,040,215,070,3), _
(215,070,170,110,3),(170,110,140,170,3), _
(140,170,140,230,3),(140,230,170,290,3), _
(170,290,215,330,3),(215,330,285,360,3), _
(285,360,360,360,3),(360,360,470,360,2), _
(470,360,410,260,2),(410,260,360,260,2), _
(360,260,285,360,2),(240,240,240,260,1), _
(240,260,260,260,1),(260,260,260,240,1), _
(260,240,240,240,1),(240,140,240,160,1), _
(240,160,260,160,1),(260,160,260,140,1), _
(260,140,240,140,1) }

' *************** Tables *******************
for Z = 0 to 1023
  SINTABLE(Z) = 32000 * sin(Z * 3.141592 / 1024)
  if Z <> 512 then TANTABLE(Z) = 65536 * tan(Z * 3.141592 / 1024)
next Z
for Z = 1024 to 2047
  SINTABLE(Z) = -SINTABLE(Z - 1024)
next Z
for Z = 0 to (HALFRESX-1)
  RADARANG(Z) = (atn((Z - HALFRESX) / HALFRESX) * 1024 / 3.141592) '+ 1
next Z
for Z = HALFRESX to RESX-1
  RADARANG(Z) = -RADARANG((RESX-1) - Z)
next Z


' ************** Tiles ****************
ImgFundo  = ImageCreate(512,100):bload "Grap/Fundo.bmp",ImgFundo
ImgBar    = ImageCreate(320, 48):bload "Grap/Bar.bmp",ImgBar
ImgWeapon = ImageCreate( 76, 94):bload "Grap/Weapon.bmp",ImgWeapon
ImgCross  = ImageCreate( 16, 16):bload "Grap/Cross.bmp",ImgCross

ImgPic = ImageCreate(64,256): pPic = ImgPic+sizeof(fb.image)
ImgTile = ImageCreate(64,64): ImgBuff = 0
bload "Grap/Tile0.bmp",ImgTile: put ImgPic,(0,  0),ImgTile,pset
bload "Grap/Tile1.bmp",ImgTile: put ImgPic,(0, 64),ImgTile,pset
bload "Grap/Tile2.bmp",ImgTile: put ImgPic,(0,128),ImgTile,pset
bload "Grap/Tile3.bmp",ImgTile: put ImgPic,(0,192),ImgTile,pset

for Z = 0 to NumLines - 1
  with WallData(Z)    
    Y1 = (.Y1 + 40) * ResY/480: Y2 = (.Y2 + 40) * ResY/480
    X1 = .X1 * (ResX/640) : X2 = .X2 * (ResX/640)
    line(X1,Y1)-(X2,Y2),1
    line(X1-3,Y1-3)-(X1+3,Y1+3),144,b
    line(X1-3,Y1-3)-(X1+3,Y1+3),144,b
  end with
next Z

sleep

for Z = 0 to NUMLINES - 1
  with WallData(Z)    
    X1 = .X1: Y1 = .Y1: X2 = .X2: Y2 = .Y2
    'WAL(Z) = .Count*4096
    SectorLine(Z).WAL = .Count*4096
    if abs(X1 - X2) >= abs(Y1 - Y2) then
      if X1 > X2 then swap X1, X2: swap Y1, Y2
      SectorLine(Z).M2 = (65536 * (Y2 - Y1)) / (X2 - X1)
      SectorLine(Z).C2 = (X1 * SectorLine(Z).M2) \ 65536 - Y1
      SectorLine(Z).KI = 0
      SectorLine(Z).PT = X1
      SectorLine(Z).SP = X2 - X1
    else
      if Y1 > Y2 then swap X1, X2: swap Y1, Y2
      SectorLine(Z).M2 = (65536 * (X2 - X1)) / (Y2 - Y1)
      SectorLine(Z).C2 = (Y1 * SectorLine(Z).M2) \ 65536 - X1
      SectorLine(Z).KI = 1
      SectorLine(Z).PT = Y1
      SectorLine(Z).SP = Y2 - Y1
    end if
  end with
next Z

POSX = 700
POSY = 200
ANG = 1024

TMR = timer
UPF = timer
CtlTimer = timer

do  
  for COUNT = 0 to RESX
    KIND(COUNT) = -1
  next COUNT
  for COUNT = 0 to RESX step 8
    RayTrace(COUNT)
  next COUNT
  #if 1
  for COUNT = 4 to RESX step 8
    COUNTME = COUNT - 4
    COUNTMA = COUNT + 4
    if KIND(COUNTME) = KIND(COUNTMA) then
      HEIGHT(COUNT) = (HEIGHT(COUNTME) + HEIGHT(COUNTMA)) shr 1
      LINUM(COUNT) = ((LINUM(COUNTME) + LINUM(COUNTMA)) shr 1) and &hFFC0
      KIND(COUNT) = KIND(COUNTME)
    else
      RayTrace(COUNT)
    end if
  next COUNT
  for COUNT = 2 to RESX step 4
    COUNTME = COUNT - 2
    COUNTMA = COUNT + 2
    if KIND(COUNTME) = KIND(COUNTMA) then
      HEIGHT(COUNT) = (HEIGHT(COUNTME) + HEIGHT(COUNTMA)) shr 1
      LINUM(COUNT) = ((LINUM(COUNTME) + LINUM(COUNTMA)) shr 1) and &hFFC0
      KIND(COUNT) = KIND(COUNTME)
    else
      RayTrace(COUNT)
    end if
  next COUNT
  for COUNT = 1 to RESX step 2
    COUNTME = COUNT - 1
    COUNTMA = COUNT + 1
    if KIND(COUNTME) = KIND(COUNTMA) then
      HEIGHT(COUNT) = (HEIGHT(COUNTME) + HEIGHT(COUNTMA)) shr 1
      LINUM(COUNT) = ((LINUM(COUNTME) + LINUM(COUNTMA)) shr 1) and &hFFC0
      KIND(COUNT) = KIND(COUNTME)
    else
      RayTrace(COUNT)
    end if
  next COUNT
  #endif
  
  screenlock
  
  put ImgBuff,(0-((ANG shr 1) and 511),0),ImgFundo,pset
  put ImgBuff,(512-((ANG shr 1) and 511),0),ImgFundo,pset
  'line ImgBuff,(0,0)-(RESX,HALFRESY-1),213,BF  
  line ImgBuff,(0,HALFRESY)-(RESX-1,RESY-1),22,BF
  
  VidSeg = screenptr
  
  for Count as integer = 0 to ResX-1
    
    QuaCount = Count shr 2    
    PICPLC = LINUM(COUNT)   
    IF0 = HEIGHT(COUNT) 
    if IF0 > 4096 then IF0 = 0
    
    ' ************ Pontos Invisíveis ****************
    'AFOR = 100 - (IF0 shr 1)    
    'for ZX = 1 to AFOR
    'if ZZ > 15920 then exit for
    'Dot ZZ + QUACOUNT, 6
    'Dot (15920 - ZZ) + QUACOUNT, 8
    'ZZ = ZZ + 80
    'next ZX
    
    ' ************ Pontos de WALLS diminuir *********
    dim as integer ZZ = QUARESX * (HALFRESY - (IF0 shr 1) ) + QUACOUNT
    dim as ubyte ptr InPtr = pPic+PICPLC
    dim as ubyte ptr OutPtr = VidSeg+(ZZ shl 2)+(Count and 3)
    if cuint(IF0) < 64 then
      IF0 = IF0 shl 2: AFOR = PICPLC + 63          
      for ZX = PICPLC to AFOR                
        YC0 = (YC0 + IF0) and 255: InPtr += 1
        if YC0 < IF0 then
          *OutPtr = *inptr
          ZZ += QUARESX: OutPtr += ResX
          if ZZ > SCRBYTES then exit for
        end if
      next ZX
      IF0 = 0
    else ' *********** Pontos de WALLS aumentar ************
      YC0 = 32    
      for ZX = 1 to IF0 
        if cuint(ZZ) < SCRBYTES then *OutPtr = *inptr
        ZZ += QuaResX: OutPtr += ResX
        YC0 += 64: if YC0 >= IF0 then 
        YC0 -= IF0: InPtr += 1
      end if
    next ZX
  end if  
  
next Count

' ************* OVERLAY *************
put ImgBuff,(HalfResx-5,HalfResy-5),ImgCross,trans
put ImgBuff,(HalfResX+20,106),ImgWeapon,trans
'put ImgBuff,(-32,ResY-48),ImgBar,pset

' ************* Sincronizar *************
screenunlock    

static as double fptimer
FPS += 1
if abs(timer-fptimer) >= 1 then
  fptimer = timer: printf(!"fps: %i  \r",FPS)
  FPS =0 
end if
'while (timer-TMR) < 1/60
'  sleep 1,1
'wend

TMRSCL = 1
TMR=timer

#ifdef __FB_NDS__
#define KeyLeft() (multikey(fb.SC_ButtonLEFT))
#define KeyRight() (multikey(fb.SC_ButtonRIGHT))
#define KeyUp() (multikey(fb.SC_ButtonUP))
#define KeyDown() (multikey(fb.SC_ButtonDOWN))
#else
#define KeyLeft() (multikey(fb.SC_LEFT))
#define KeyRight() (multikey(fb.SC_RIGHT))
#define KeyUp() (multikey(fb.SC_UP))
#define KeyDown() (multikey(fb.SC_DOWN))
#endif

while (timer-CtlTimer) >= 1/60
  ' **** LEFT ****
  if KeyLeft() then 
    BACKX -= TMRSCL * 8
    ANG = (ANG - (16*TMRSCL)) and 2047      
  end if
  ' **** RIGHT ****
  if KeyRight() then 
    BACKX += TMRSCL * 8
    ANG = (ANG + (16*TMRSCL)) and 2047      
  end if
  ' **** UP *****
  if KeyUp() then 
    POSX = POSX + (8*TMRSCL) * cos(ANG * 3.141592 / 1024)
    POSY = POSY + (8*TMRSCL) * sin(ANG * 3.141592 / 1024)      
  end if
  ' **** DOWN *****
  if KeyDown() then 
    POSX = POSX - (8*TMRSCL) * cos(ANG * 3.141592 / 1024)
    POSY = POSY - (8*TMRSCL) * sin(ANG * 3.141592 / 1024)      
  end if    
  if multikey(fb.SC_ESCAPE) then end  
  CtlTimer += 1/60
wend

loop 
end

' *************************************************************************
' ************************** RAY TRACER ALGORITMO *************************
' *************************************************************************
#if 1
sub RayTrace(COUNT as integer)
  ANGLE = ANG + radarang(COUNT)
  QUAD = ((ANGLE and 2047) shr 9)
  M0 = tantable(ANGLE and 1023)
  M1 = tantable((2560 - ANGLE) and 1023) 
  x = 65535: y = 65535
  C0 = POSY - ((POSX * M0) shr 16)
  C1 = POSX - ((POSY * M1) shr 16) 
  dim as SectorCast ptr pSec = @SectorLine(0)
  for Z = 0 to NUMLINES - 1    
      if pSec->KI = 0 then
        DIVIT = (pSec->M2 - M0) shr 1
        if DIVIT then
          newx = (((C0 + pSec->C2) shl 15) \ DIVIT)          
          newy = (((M0 shr 8) * ((newx - POSX)) shr 8) + POSY)
          if newx >= pSec->PT and newx <= pSec->PT + pSec->SP then
            if abs(newx - POSX + newy - POSY) < abs(x - POSX + y - POSY) then
              if ((QUAD and 2) = 0) = (newy > POSY) then
                if (((QUAD + 1) and 2) = 0) = (newx > POSX) then
                  x = newx: y = newy
                  LINUM(COUNT) = pSec->WAL + (((x - pSec->PT) shl 6) \ pSec->SP) shl 6
                  KIND(COUNT) = Z
                end if
              end if
            end if
          end if
        end if
      else
        DIVIT = (pSec->M2 - M1) shr 1
        if DIVIT <> 0 then
          newy = ((C1 + pSec->C2) shl 15) \ DIVIT
          newx = ((M1 shr 8) * (newy - POSY)) shr 8 + POSX
          if newy >= pSec->PT and newy <= pSec->PT + pSec->SP then
            if abs(newx - POSX + newy - POSY) < abs(x - POSX + y - POSY) then
              if ((QUAD and 2) = 0) = (newy > POSY) then
                if (((QUAD + 1) and 2) = 0) = (newx > POSX) then
                  x = newx: y = newy
                  LINUM(COUNT) = pSec->WAL + (((y - pSec->PT) shl 6) \ pSec->SP) shl 6
                  KIND(COUNT) = Z
                end if
              end if
            end if
          end if
        end if
      end if    
    pSec += 1
  next Z
  HEIGHT(COUNT) = 0
  if x <> 65535 then
    IF0 = ((x - POSX) * sintable((2560 - ANG) and 2047) + (y - POSY) * sintable(ANG)) shr 13
    if IF0 then HEIGHT(COUNT) = (40960 \ IF0) * SCRSCALE
  end if
end sub
#endif

