#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
#include "fbgfx.bi"
open cons for output as #99
namespace fb 
enum              'Extra enumerated keys
  SC_BUTTONA = 128
  SC_BUTTONB = 127
  SC_BUTTONSELECT = 126
  SC_BUTTONSTART = 125
  SC_BUTTONRIGHT = 124
  SC_BUTTONLEFT = 123
  SC_BUTTONUP = 122
  SC_BUTTONDOWN = 121
  SC_BUTTONR = 120
  SC_BUTTONL = 119
  SC_BUTTONX = 118
  SC_BUTTONY = 117
  SC_BUTTONTOUCH = 116
  SC_BUTTONLID = 115
end enum  
end namespace
chdir exepath+"/NitroFiles"
#endif

using fb

#define SC2X_X 256
#define SC2X_Y 192
#define SC2X_P 512
#define MYBPP 8
#define RenderOpenGL

' ************ User Defined Types ********
enum 
  SS_INTRO = 1
  SS_E1P1
  SS_E1P2
  SS_E1BOSS
end enum

type MAP_STRUCT
  ID as ushort
  PX as ushort
  PY as ubyte
  CL as ubyte
  HP as ubyte
  SP as ubyte
end type

#define MySound
#define MyDebug

#ifdef MySound
#ifdef __FB_NDS__
#include "Modules\fmod.bas"
#else
#include "fmod.bi"
#endif
#endif
#include "Modules\gfxUtil.bas"

' ************ Some Defines ************
#define InMap(ID) cptr(MAP_STRUCT ptr,@MAP[ID])
#define Percent(A,B,P,M) ((A)+(((B)-(A))/(M))*(P))
#define Pset8(PX,PY,PC) cptr(ubyte ptr,PAGPTR)[((cint(PY)*SC2X_X)+cint(PX))] = (PC)
#define Point8(PX,PY) cptr(ubyte ptr,PAGPTR)[((cint(PY)*SC2X_X)+cint(PX))]

' ************ Declarations *************
declare sub GetMetric(IDAD as any ptr,byref TX as integer,byref TY as integer)
declare sub DrwBigOTxt(X as integer,Y as integer,TEXTO as string,FIXO as integer=0,Target as any ptr=0)
declare sub DrwBigTTxt(X as integer,Y as integer,TEXTO as string,FIXO as integer=0,Target as any ptr=0)
declare function GetX(IDAD as any ptr) as integer
declare function GetY(IDAD as any ptr) as integer
declare function drwtext(TEXTO as string,PX as integer,PY as integer,byval COR as byte,Target as any ptr=0) as integer
declare function drwtranstext(TEXTO as string,PX as integer,PY as integer,byval COR as byte,ExtraSpace as integer=0,Target as any ptr=0) as integer
declare function ImageLoad(FILENAME as string,BMPPAL as any ptr=0) as any ptr
declare sub sync ()
declare sub drawnumber (NUMERO as integer,POSX as integer,POSY as integer,Target as any ptr=0)
declare sub showfase(FASE as integer )
declare function startfase(FASE as integer) as integer
declare function quit() as integer
declare function intro() as integer
declare sub showintrop (isP as integer=0)
declare sub showintrot()
declare function showsetup() as integer
declare function showcontinue() as integer
declare sub highscores ( )
declare sub setupcard ()
declare sub StartMusic(MUSIC as integer)
declare sub StopMusic()

' *************** VARIAVEIS ***************
dim shared as any ptr BMBUFF(0) 're
dim shared as any ptr SONGFILE
dim shared as integer PLAYSONG
dim shared as integer WAVES(8),SOUND(8)
dim shared as any ptr BSLCODE
dim shared as uinteger BSLEND,BMBYTES,BMNCH
dim shared as integer HCON,FADE,COUNT,FASECOUNT
dim shared as integer ARQDAT,IDMUSICWAVE,UPCUR
dim shared as short SYNAUTO=-1,SYNCM
'dim shared as ubyte CHARS(2,255,180)
'dim shared as integer BIGFONT(3,71,4*17+8)
dim shared as fb.image ptr CHARS(2)
dim shared as fb.image ptr BIGFONT(3)
dim shared as ubyte ASCTF(255),FONTSPC(255),BIGSPC(71),OLDOPT
dim shared as single ST,STX(100),STS(100),STNX
dim shared as single FPTIM,FPMAX,BT
dim shared as short STY(100),STC(100),FPS,TextSwap
dim shared as short TouchDown,TouchBack
dim shared as short STA(100),DODOUBLE,FADESPD,OPT,PAG
dim shared as short OTEMP,OSOUND,OMUSIC,OFULL,OPRIORITY
dim shared as any ptr NUMS(9),ScrBuff
dim shared as integer ORGARY(255),BLKPAL(255),HIDARY(255)
dim shared as string CODE,TECLA,UTEC,MENU(5)
dim shared as any ptr MYBUFF,TEMP,PAGPTR,ORGPAL,HIDPAL
ORGPAL = @ORGARY(0):HIDPAL = @HIDARY(0)
'0 = (normal sync)
'1 = (normal sync+sleep)
'2 = (timer sync)
'3 = (timer/sleep sync)
'4 = (timer sync + sleep)
'5 = (sleep sync)
'6 = (no sync)

CODE = "MYSOFT-CODIGO"
MENU(0) = "Introduction"
MENU(1) = "Begin"
MENU(2) = "Continue"
MENU(3) = "High Scores"
MENU(4) = "Setup"
MENU(5) = "Quit"

#ifdef MySound
if FSOUND_Init(44100, 32, 0) = 0 then 
  print "Error on sound start..."
end if
' ********** Setando Thread *********
#endif

' ********* Carregando OpÁıes do Arquivo de configuraÁıes ************
scope
  ARQDAT = freefile
  if open("Xatax.dat" for binary access read as #ARQDAT)=0 then
    #ifdef MyDebug
    print  "Loading Config..."
    #endif    
    get #ARQDAT,2,*cptr(byte ptr,@OTEMP)
    get #ARQDAT,3,*cptr(byte ptr,@OSOUND)
    get #ARQDAT,4,*cptr(byte ptr,@OMUSIC)
    get #ARQDAT,5,*cptr(byte ptr,@OPT)
    get #ARQDAT,6,*cptr(byte ptr,@SYNCM)
    get #ARQDAT,7,*cptr(byte ptr,@DODOUBLE)
    get #ARQDAT,8,*cptr(byte ptr,@OFULL)
    get #ARQDAT,9,*cptr(byte ptr,@OPRIORITY)
    close #ARQDAT
  else  
    #ifdef MyDebug
    print  "Invalid Config, default set..."
    #endif    
    OTEMP =-1:OSOUND =-1:OMUSIC=-1:OPT=-1
    SYNCM =-1:DODOUBLE =-1:OFULL =-1:OPRIORITY =-1
  end if
  
  open "Xatax.dat" for binary as #ARQDAT
  
  ' **** Alterando configuraÁıes por diferenÁa de SO *****
  #ifndef MySound
  OSOUND=0:OMUSIC=0
  put #ARQDAT,3,cbyte(OSOUND)
  put #ARQDAT,4,OMUSIC
  #endif
  OPRIORITY=-1:OPT=-1
  
  ' **** Verificando configuraÁıes v·lidas ****
  
  if OSOUND < 0 or OSOUND > 10 then
    OSOUND=10
    put #ARQDAT,3,cbyte(OSOUND)
  end if
  if OMUSIC < 0 or OMUSIC > 10 then
    OMUSIC=10
    put #ARQDAT,4,cbyte(OMUSIC)
  end if
  if OPT < 0 or OPT > 2 then 
    OPT = 0
    put #ARQDAT,5,cbyte(OPT)
  end if
  if SYNCM < 0 or SYNCM > 7 then
    SYNCM = 0
    put #ARQDAT,6,cbyte(SYNCM)
  end if
  if DODOUBLE < 0 or DODOUBLE > 2 then
    DODOUBLE = 0
    put #ARQDAT,7,cbyte(DODOUBLE)
  end if
  if OFULL<0 or OFULL>1 then
    OFULL = 0
    put #ARQDAT,8,cbyte(OFULL)
  end if
  if OPRIORITY <0 or OPRIORITY>2 then
    OPRIORITY=1
    put #ARQDAT,9,cbyte(OPRIORITY)
  end if
  close #ARQDAT
end scope

#ifdef RenderOpenGL
gfx.GfxDriver = gfx.gdOpenGL
#endif
screenres 256,192,8
PAGPTR = screenptr
#ifdef RenderOpenGL
ScrBuff = gfx.scr
#else
ScrBuff = 0
#endif

' ********** Auto Detectando MÈtodo de SYNC funcionando *********
if SYNCM = 7 then SYNCM = 0
TEMP = ImageCreate(256,192)

' ************** Carregando Fontes de tela ***************

#if 0
scope 'Generating Fonts
  bload "Graph/Menu.bmp"  
  dim as ubyte ptr TCHARS = allocate(((3)*(256)*(181))*sizeof(ubyte))  
  open "Fonte.bin" for binary access read as #1
  get #1,1,*cptr(ubyte ptr,TCHARS),lof(1)-256
  get #1,,*cptr(ubyte ptr,@FONTSPC(0)),256
  close #1
  
  for CNT2 as integer = 0 to 2    
    CHARS(CNT2) = ImageCreate(16*8,6*8)    
    if CHARS(CNT2) = 0 then 
      print "Failed to create CHARS(" & CNT2 & ") buffer"
      sleep:end
    end if
    for CNT as integer = 0 to 255
      dim as fb.image ptr TempIMG = cptr(fb.image ptr,TCHARS+((CNT2*256*181)+(CNT*181)))
      dim as integer WID = TempIMG->width, HEI = TempIMG->height
      if WID andalso HEI then
        dim as integer CX = (CNT and 15) shl 3
        dim as integer CY = ((CNT shr 4)-2) shl 3      
        put CHARS(CNT2),(CX,CY),TempIMG,(0,0)-(7,7),pset
      end if
    next CNT
        
    bsave "Font\ChrFnt" & CNT2 & ".bmp",CHARS(CNT2)
    put(0,0),CHARS(CNT2),pset: sleep
    
  next CNT2    
  
  deallocate(TCHARS): 
  dim as integer ptr TBIGFONT = allocate(((4)*(72)*(4*17+9))*sizeof(integer))
    
  open "BigFont.bin" for binary access read as #1
  get #1,1,*cptr(ubyte ptr,@ASCTF(0)),256
  get #1,,*cptr(ubyte ptr,TBIGFONT),lof(1)-256
  close #1
  
  for CNT2 as integer = 0 to 3        
    BIGFONT(CNT2) = ImageCreate(8*16,9*16)    
    if BIGFONT(CNT2) = 0 then 
      print "Failed to create BIGFONT(" & CNT2 & ") buffer"
      sleep:end
    end if
    
    for CNT as integer = 0 to 71
      const hsz = (4*17+9)
      dim as fb.image ptr TempIMG = cptr(fb.image ptr,TBIGFONT+((CNT2*72*hsz)+(CNT*hsz)))
      dim as integer WID = TempIMG->width, HEI = TempIMG->height
      if WID > 0 andalso HEI > 0 then                       
        if WID>16 then WID=16
        if HEI>16 then HEI=16 
        dim as integer CX = (CNT and 7) shl 4
        dim as integer CY = (CNT shr 3) shl 4     
        if CNT2=0 then BIGSPC(CNT)=WID        
        put BIGFONT(CNT2),(CX,CY),TempIMG,(0,0)-(WID-1,HEI-1),pset
      end if      
    next CNT
    
    bsave "Font\BigFnt" & CNT2 & ".bmp",BIGFONT(CNT2)
    put(0,0),BIGFONT(CNT2),pset: sleep
    
  next CNT2
  
  dim as integer MyFile = freefile()
  open "Font\Font.sz" for binary access write as #MyFile
  put #MyFile,1,*cptr(ubyte ptr,@FONTSPC(0)),256
  put #MyFile,,*cptr(ubyte ptr,@ASCTF(0)),256
  put #MyFile,,*cptr(ubyte ptr,@BIGSPC(0)),72
  close #MyFile
  
  deallocate(TBIGFONT)
  
  
end scope
#else
scope 'Loading Fonts
  for CNT2 as integer = 0 to 2    
    CHARS(CNT2) = ImageCreate(16*8,6*8)    
    if CHARS(CNT2) = 0 then 
      print "Failed to create CHARS(" & CNT2 & ") buffer"
      sleep:end
    end if    
    bload "Font/ChrFnt" & CNT2 & ".bmp",CHARS(CNT2),HIDPAL
  next CNT2
  for CNT2 as integer = 0 to 3        
    BIGFONT(CNT2) = ImageCreate(8*16,9*16)    
    if BIGFONT(CNT2) = 0 then 
      print "Failed to create BIGFONT(" & CNT2 & ") buffer"
      sleep:end
    end if
    bload "Font/BigFnt" & CNT2 & ".bmp",BIGFONT(CNT2),HIDPAL
  next CNT2
  dim as integer MyFile = freefile()
  open "Font/Font.sz" for binary access read as #MyFile
  get #MyFile,1,*cptr(ubyte ptr,@FONTSPC(0)),256
  get #MyFile,,*cptr(ubyte ptr,@ASCTF(0)),256
  get #MyFile,,*cptr(ubyte ptr,@BIGSPC(0)),72
  close #MyFile
end scope
#endif

line(0,0)-(255,191),0,bf:flip:screensync
bload "Graph/Score.bmp",TEMP,HIDPAL
for COUNT = 0 to 9
  NUMS(COUNT) = ImageCreate(6,7)  
  put NUMS(COUNT),(0,0),TEMP,(0,COUNT*8)-(5,COUNT*8+6),pset  
next COUNT

'//////////////////////////
'ShowFase(1)
'do
'  #ifdef MySound      
'  StartMusic(SS_E1P1)        
'  #endif
'loop until startfase(1)    
'end
'\\\\\\\\\\\\\\\\\\\\\\\\\\

' *************************************************
' ************ Mysoft Corporation Logo ************
' *************************************************

line(0,0)-(255,191),0,bf:flip:screensync
bload "Graph/Mysoft.bmp",TEMP,ORGPAL
palette using BLKPAL
put(0,0),TEMP,pset

FADE = 0
do
  palfade ORGPAL,FADE,0,255  
  FADE = FADE + 1  
  #ifdef RenderOpenGL
  put(0,0),TEMP,pset
  flip
  #endif
  sync   
  TECLA = inkey$
loop until len(TECLA) or FADE=100

if FADE = 100 then 
  for COUNT = 0 to 250
    TECLA = inkey$:sync
    if len(TECLA) then exit for
  next COUNT
end if
if len(TECLA)=2 andalso TECLA[1]=asc("k") then end
do
  palfade ORGPAL,FADE,0,255
  FADE = FADE - 1  
  #ifdef RenderOpenGL
  put(0,0),TEMP,pset
  flip
  #endif
  sync
loop while FADE >= 0
line(0,0)-(255,191),0,bf
#ifdef RenderOpenGL
flip
#endif
screensync

' ********************************************
' *************** XATAX TITLE ****************
' ********************************************

TECLA = inkey$
for COUNT=0 to 100
  STX(COUNT) = rnd * 256
  STY(COUNT) = rnd * 192
  STS(COUNT) = .1 + rnd * 1
  STA(COUNT) = 0
  STC(COUNT) = 168 + rnd * 12
next COUNT
line(0,0)-(255,191),0,bf:screensync
bload "Graph/Title.bmp",TEMP,ORGPAL
palette using BLKPAL
#ifdef MySound
StartMusic(SS_INTRO)
#endif
screensync

put ScrBuff,(0,0),TEMP,pset
FADE = 1: FADESPD = 1
do  
  screenlock
  palfade ORGPAL,FADE,0,255
  FADE = FADE + FADESPD
  if FADE > 100 then FADE = 100  
  TECLA = inkey$
  if len(TECLA)=2 andalso TECLA[1] = asc("k") then end
  if len(TECLA) then FADESPD = -1
  
  for COUNT=0 to 100     
    STNX = STX(COUNT) - STS(COUNT)
    if STNX<0 then STNX = 255
    if STA(COUNT) and STX(COUNT)<>STNX then
      STA(COUNT) = 0
      Pset8(STX(COUNT),STY(COUNT),0)
    end if
    if point8(STNX,STY(COUNT))=0 then
      pset8(STNX,STY(COUNT),STC(COUNT))
      STA(COUNT) = 1
    end if
    STX(COUNT)=STNX    
  next COUNT    
  screenunlock
  
  #ifdef RenderOpenGL      
  put(0,0),ScrBuff,pset
  flip
  #endif
  
  sync
loop until FADE < 1
line(0,0)-(255,191),0,bf:flip:screensync

' ********************************************
' ************** MENU PRINCIPAL **************
' ********************************************
OPT = 1
OLDOPT = 1
do 
  line(0,0)-(255,191),0,bf
  'redim CURSOR(400) as ushort, CURBACK(5,400) as ushort
  'redim SELOPT(5,1000) as ushort
  dim as any ptr CURSOR,CURBACK(5),SELOPT(5)
  TECLA = inkey$
  for COUNT=0 to 100
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 192
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1 + rnd * 6
  next COUNT  
  CURSOR = ImageLoad("Graph/Menus.bmp")
  bload "Graph/Menu.bmp",TEMP,ORGPAL
  palette using BLKPAL      
  FADE = 1:FADESPD = 1:UPCUR=1  
  FPTIM = timer:FPMAX=60
  
  do
    screenlock
    
    PAG = 1-PAG    
    if PAG then
      line ScrBuff,(0,0)-(40,10),0,bf
      'drwtext(mid$(str$(FPMAX),1,4),0,0,1)      
      PalRotate ORGPAL,1,8,15
    end if
    
    palfade ORGPAL,FADE,0,255
    FADE = FADE + FADESPD    
    if FADE > 100 then 
      FADE = 100
    else      
      #ifdef MySound
      if FADESPD < 0 and OPT=1 then
        if PLAYSONG then FSOUND_SetVolume(PLAYSONG,Percent(0,(OMUSIC*25.5),FADE,100))        
        'Fbs_Set_StreamVolume()
      end if
      #endif
    end if
    TECLA = inkey$+chr$(255)
    UTEC = ucase$(TECLA)
    if FADESPD > -1 then
      COUNT =0
      if UTEC[0] = asc("I") then OPT = 0:UPCUR =1
      if UTEC[0] = asc("B") then OPT = 1:UPCUR =1
      if UTEC[0] = asc("C") then OPT = 2:UPCUR =1
      if UTEC[0] = asc("H") then OPT = 3:UPCUR =1
      if UTEC[0] = asc("S") then OPT = 4:UPCUR =1
      if UTEC[0] = asc("Q") then OPT = 5:UPCUR =1
      if ((TECLA[1] = fb.SC_UP) or (TECLA[1] = fb.SC_BUTTONUP)) and OPT>0 then 
        OPT = OPT - 1:UPCUR =-1
      elseif ((TECLA[1] = fb.SC_DOWN) or (TECLA[1] = fb.SC_BUTTONDOWN)) and OPT<5 then 
        OPT = OPT + 1:UPCUR =-1      
      end if
      
      dim as integer MX,MY,MB,CNOPT
      getmouse MX,MY,,MB
      if MB<>-1 and (MB and 1) then 'Multikey(fb.SC_BUTTONTOUCH) then        
        for CNOPT = 0 to 5
          if MX > 64 and MX < 192 then
            if MY > (41+CNOPT*20) and MY < (61+CNOPT*20) then
              if TouchDown=0 andalso OPT=CNOPT then FADESPD = -1
              if OPT <> CNOPT then OPT=CNOPT:UPCUR=-1
              TouchBack = 0
              exit for
            end if
          end if
        next CNOPT
        if TouchDown=0 andalso TouchBack then
          TouchBack=0: OPT=5: UPCUR=-1: FADESPD = -1
        end if
        if CNOPT > 5 then TouchBack = 1
        if TouchDown=0 then TouchDown = 1
      else
        TouchDown = 0
      end if
      
    end if
    if UPCUR then
      UPCUR = 0
      'screenlock
      put ScrBuff,(0,0),TEMP,pset
      drwtext(mid$(str$(FPMAX),1,4),0,0,1,ScrBuff)
      'put(90,44+OLDOPT*20),CURBACK(OLDOPT), pset
      put ScrBuff,(58,40+OPT*20),CURSOR,trans
      for COUNT = 0 to 5          
        if OPT = COUNT then
          DrwBigTTxt 88,41+COUNT*20,"#1"+MENU(COUNT),,ScrBuff
        else
          dim as string Temp
          Temp = left$(MENU(COUNT),1)+"#2"+mid$(MENU(COUNT),2)          
          DrwBigTTxt 88,41+COUNT*20,Temp,,ScrBuff
        end if
      next COUNT
      'screenunlock
      'put(120,45+OPT*20),SELOPT(OPT),trans
      OLDOPT = OPT
      for COUNT = 0 to 50
        STA(COUNT) = 0
      next COUNT
    end if
    if TECLA[1] = asc("k") then end
    if TECLA[0] = 13 then FADESPD = -1
    if TECLA[1] = fb.SC_BUTTONSELECT then FADESPD = -1
    if TECLA[1] = fb.SC_BUTTONA then FADESPD = -1
    for COUNT = 0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT
    screenunlock
    #ifdef RenderOpenGL    
    put(0,0),ScrBuff,pset    
    flip
    #endif
    sync
    FPS += 1
    if (timer-FPTIM) >= .5 then      
      FPMAX = FPS*2:FPS = 0: FPTIM = timer      
    end if    
  loop until FADE < 1  
  
  ' ////// ESCOLHENDO OP«¬O DO MENU \\\\\\
  line(0,0)-(255,191),0,bf:screensync
  select case OPT
  case 0
    do
      COUNT = intro()
      if COUNT = -1 then ShowIntrop
      if COUNT = 0 then ShowIntrot
    loop until COUNT = 1  
  case 1
    #ifdef MySound
    StopMusic()
    #endif
    ShowFase(1)
    do
      #ifdef MySound      
      StartMusic(SS_E1P1)        
      #endif
    loop until startfase(1)    
    #ifdef MySound      
    StopMusic()
    StartMusic(SS_INTRO)
    if PLAYSONG then FSOUND_SetVolume(PLAYSONG,OMUSIC*25.5)    
    #endif        
  case 2
    COUNT = ShowContinue()
  case 3
    HighScores()
  case 4
    do
      COUNT = ShowSetup()
      'if COUNT then SetupCard()
    loop while COUNT
  case 5
    if quit() then exit do
  end select  
loop
end

' ******************************************************************
' ********************** CHECK FOR COLLISION ***********************
' ******************************************************************
function Collision(OBJA as any ptr, OAX as integer, OAY as integer, OBJB as any ptr, OBX as integer, OBY as integer,USEALPHA as integer=0) as integer
  
  static as integer COLLI,TX,TY,RESULT,IBPP=1
  static as integer OASX,OASY,OBSX,OBSY
  static as integer OAXX,OAYY,OBXX,OBYY
  static as integer APIT,BPIT,XCNT,YCNT
  static as any ptr ASTRT,BSTRT,CSTRT
  
  if OBJA=0 or OBJB=0 then return 0
  
  const MaximumAlpha = 32 'Max alpha value that will be considered transparent
  const HeaderSize = sizeof(fb.image) 'size of the image header (if any) (32 bytes for fbgfx)
  with *cptr(fb.image ptr,OBJA)
    OASX = .width-1  'width of the object A minus one
    OASY = .height-1 'height of the object A minus one  
    APIT = .PITCH    'width*BPP object A (16 byte granularity for fbgfx)
  end with
  with *cptr(fb.image ptr,OBJB)
    OBSX = .width-1 'width of the object B minus one
    OBSY = .height-1 'height of the object B minus one
    BPIT = .PITCH 'width*BPP object B (16 byte granularity for fbgfx) 
  end with
  
  OAXX = OAX+OASX:OAYY = OAY+OASY
  OBXX = OBX+OBSX:OBYY = OBY+OBSY  
  
  do    
    if OAX >= OBX and OAX <= OBXX then
      ' ********** 11 ***********
      if OAY >= OBY and OAY <= OBYY then 
        if OBXX > OAXX then TX = OAXX else TX = OBXX
        if OBYY > OAYY then TY = OAYY else TY = OBYY        
        ASTRT = OBJA + HeaderSize 
        BSTRT = OBJB + HeaderSize + _
        ((OAX-OBX) shl IBPP) + ((OAY-OBY)*BPIT)
        XCNT = (TX-OAX)+1:YCNT = (TY-OAY)+1
        APIT -= ((TX-OAX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((TX-OAX) shl IBPP)+(1 shl IBPP)        
        RESULT = 11: exit do
      end if
      ' ********** >12< ***********
      if OAYY >= OBY and OAYY <= OBYY then 
        if OBXX > OAXX then TX = OAXX else TX = OBXX        
        ASTRT = OBJA + HeaderSize + ((OBY-OAY)*APIT)
        BSTRT = OBJB + HeaderSize + ((OAX-OBX) shl IBPP)
        XCNT = (TX-OAX)+1:YCNT = (OAYY-OBY)+1
        APIT -= ((TX-OAX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((TX-OAX) shl IBPP)+(1 shl IBPP)        
        RESULT = 12: exit do
      end if
      ' *********** 13 *************
      if OAY <= OBY and OAYY >= OBYY then
        ASTRT = OBJA + HeaderSize + ((OBY-OAY)*APIT)
        BSTRT = OBJB + HeaderSize + ((OAX-OBX) shl IBPP)
        XCNT = (OBXX-OAX)+1:YCNT = OBSY+1
        APIT -= ((OBXX-OAX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OBXX-OAX) shl IBPP)+(1 shl IBPP)        
        RESULT = 13: exit do
      end if
    end if
    
    if OAXX >= OBX and OAXX <= OBXX then
      ' *********** <21> *************
      if OAY >= OBY and OAY <= OBYY then 
        if OBYY > OAYY then TY = OAYY else TY = OBYY        
        ASTRT = OBJA + HeaderSize + ((OBX-OAX) shl IBPP)
        BSTRT = OBJB + HeaderSize + ((OAY-OBY)*BPIT)
        XCNT = (OAXX-OBX)+1:YCNT = (TY-OAY)+1
        APIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)        
        RESULT = 21: exit do
      end if
      ' *********** <22> ************
      if OAYY >= OBY and OAYY <= OBYY then
        ASTRT = OBJA + HeaderSize + _
        ((OASY-(OAYY-OBY))*APIT) + _
        ((OASX-(OAXX-OBX)) shl IBPP)
        BSTRT = OBJB + HeaderSize
        XCNT = (OAXX-OBX)+1:YCNT = (OAYY-OBY)+1
        APIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)        
        RESULT = 22: exit do
        ' *********** <23> ************
      end if
      if OAY <= OBY and OAYY >= OBYY then
        ASTRT = OBJA + HeaderSize + _
        ((OBY-OAY)*APIT) + ((OBX-OAX) shl IBPP)
        BSTRT = OBJB + HeaderSize
        XCNT = (OAXX-OBX)+1:YCNT = OBSY+1
        APIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OAXX-OBX) shl IBPP)+(1 shl IBPP)        
        RESULT = 23: exit do
      end if
    end if
    
    if OAX <= OBX and OAXX >= OBXX then
      ' ********** <31> *************
      if OAY >= OBY and OAY <= OBYY then
        ASTRT = OBJA + HeaderSize + ((OBX-OAX) shl IBPP)
        BSTRT = OBJB + HeaderSize  + ((OAY-OBY)*BPIT)
        XCNT = OBSX+1:YCNT = (OBYY-OAY)+1
        APIT -= ((OBSX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OBSX) shl IBPP)+(1 shl IBPP)        
        RESULT = 31: exit do
      end if
      ' ********** <32> *************
      if OAYY >= OBY and OAYY <= OBYY then 
        ASTRT = OBJA + HeaderSize + _
        ((OBY-OAY)*APIT) + ((OBX-OAX) shl IBPP)
        BSTRT = OBJB + HeaderSize
        XCNT = OBSX+1:YCNT = (OAYY-OBY)+1
        APIT -= ((OBSX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OBSX) shl IBPP)+(1 shl IBPP)        
        RESULT = 32: exit do
      end if
      ' ********** <33> *************
      if OAY <= OBY and OAYY >= OBYY then
        ASTRT = OBJA + HeaderSize + _
        ((OBY-OAY)*APIT) + ((OBX-OAX) shl IBPP)
        BSTRT = OBJB + HeaderSize
        XCNT = OBSX+1:YCNT = OBSY+1
        APIT -= ((OBSX) shl IBPP)+(1 shl IBPP)
        BPIT -= ((OBSX) shl IBPP)+(1 shl IBPP)        
        RESULT = 33: exit do
      end if
    end if
    return 0    
  loop   
  
  return 1
  
end function

' ******************************************************************
' ********************* FUN«√O DE INICIO DO JOGO *******************
' ******************************************************************
function startfase(FASE as integer) as integer  
  
  startfase = 0
  
  'redim as any ptr DRUM(16)
  dim as integer DRUM_U = 16
  dim as any ptr ptr DRUM = callocate(sizeof(any ptr)*(DRUM_U+1))  
  'redim as ulongint MAP(1)
  dim as integer MAP_U = 1
  dim as ulongint ptr MAP = callocate(sizeof(ulongint)*(MAP_U+1))
  dim as integer PAG,BITPOS,PROTP,SCORE=42437
  dim as integer BUT_CTRL,BITBIT,BUT_PLUS,BUT_MINUS
  dim as integer BULLETYPE=1,MISSIL,FPAVERAGE
  dim as integer BUT_ESC,XX,YY,XA,XB,YA,YB,YO,XO
  dim as integer MYFILE,MAXMAP,MAPLNT,XLT,XRT
  dim as integer CENX,CENM,STARM,TMPVOL,EXPLODED
  dim as integer TMPX,TMPY,CNT,MAXOBJ,FPCNT,NCOUNT
  dim as single BITPX,BITPY,NAVEX=100,NAVEY=100
  dim as single NAVSPY,NAVSPX,FPSMAX,BT,FPTIM,CT,LASTSHOT
  dim as short BMBP,BUT_ALT,BOMBS=5,SHIPS=4
  dim as short DO_SYNC=1,MAXPAL=0
  dim as short PROTE=1500,PROTN
  redim as integer EXPX(150),EXPY(150),EXPT(150)
  redim as integer BULX(30),BULY(30),BULT(30)  
  redim as integer MIST(200),MISX(200),MISY(200)
  redim as integer MISA(130),BLUEPTR(255),CIANPTR(255)
  redim as short BULARCO(120),BULARCOB(120)  
  dim as string TECLA,KEY,ANTPAL
  dim as any ptr QUITG,PROTNAV,SHIP,MYBOX,GFXB
  dim as any ptr PROTBAR,BOMB,MISS(6)
  dim as any ptr BLUEPAL,CIANPAL,PTRA,PTRB
  redim as any ptr BULLET(8),NAVE(4),GBIT(11)
  redim as any ptr EXPLO(27)
  'redim as any ptr OBJECTS(16)
  dim as integer OBJECTS_U = 16
  dim as any ptr ptr OBJECTS = callocate((OBJECTS_U+1)*sizeof(any ptr))
  
  '#define AddObject(OBJPTR) OBJECTS(MAXOBJ)=(OBJPTR):MAXOBJ+=1:if MAXOBJ=ubound(OBJECTS) then redim preserve OBJECTS(MAXOBJ+16)
  #define AddObject(OBJPTR) OBJECTS[MAXOBJ]=(OBJPTR):MAXOBJ+=1:if MAXOBJ=OBJECTS_U then OBJECTS_U+=16:OBJECTS=reallocate(OBJECTS,(OBJECTS_U+1)*sizeof(typeof(*OBJECTS)))
  
  BLUEPAL=@BLUEPTR(0):CIANPAL=@CIANPTR(0)
  BITBIT = 1:MISSIL = 1
  
  for COUNT = 0 to 30
    BULT(COUNT) = -1
  next COUNT
  for COUNT = 0 to 150
    EXPT(COUNT) = -1
  next COUNT
  line(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 100
    STX(COUNT) = rnd * 255
    STY(COUNT) = rnd * 191
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 103 + rnd * 12
  next COUNT
  
  ' \\\\\\\\\\\\\\\\\\ CAPTURANDO GRAFICOS /////////////////
  FADE = 1    
  QUITG = ImageLoad("Graph/Quit.bmp",BLUEPAL):AddObject(QUITG)
  PROTNAV = ImageLoad("Graph/Protnav.bmp",CIANPAL):AddObject(PROTNAV)
  SHIP = ImageLoad("Graph/Ship.bmp"):AddObject(SHIP)
  BULLET(0) = ImageLoad("Graph/Bullet2.bmp"):AddObject(BULLET(0))
  BULLET(1) = ImageLoad("Graph/Bullet3.bmp"):AddObject(BULLET(1))
  BULLET(2) = ImageLoad("Graph/Bullet6.bmp"):AddObject(BULLET(2))
  BULLET(3) = ImageLoad("Graph/Bullet5.bmp"):AddObject(BULLET(3))
  BULLET(4) = ImageLoad("Graph/Bullet4.bmp"):AddObject(BULLET(4))
  PROTBAR = ImageLoad("Graph/Protbar.bmp"):AddObject(PROTBAR)
  BOMB = ImageLoad("Graph/Bomb.bmp"):AddObject(BOMB)
  GFXB = ImageLoad("Graph/NorExp.bmp")  
  for COUNT = 0 to 13
    EXPLO(COUNT) = ImageCreate(29,29):AddObject(EXPLO(COUNT))
    'get GFXB,(0,COUNT*30)-(28,COUNT*30+28),EXPLO(COUNT)
    put EXPLO(COUNT),(0,0),GFXB,(0,COUNT*30)-(28,COUNT*30+28),pset
  next COUNT    
  ImageDestroy(GFXB)
  GFXB = ImageLoad("Graph/SmlExp.bmp")    
  for COUNT = 0 to 13
    EXPLO(COUNT+14) = ImageCreate(15,14):AddObject(EXPLO(COUNT+14))
    'get GFXB,(0,COUNT*15)-(14,COUNT*15+13),EXPLO(COUNT+14)
    put EXPLO(COUNT+14),(0,0),GFXB,(0,COUNT*15)-(14,COUNT*15+13),pset
  next COUNT  
  ImageDestroy(GFXB)
  bload "Graph/Nave.bmp",TEMP,HIDPAL  
  for COUNT = 0 to 6    
    MISS(COUNT) = ImageCreate(7,8):AddObject(MISS(COUNT))
    'get BULLET(4),(0,COUNT*8)-(6,COUNT*8+7),MISS(COUNT)
    put MISS(COUNT),(0,0),BULLET(4),(0,COUNT*8)-(6,COUNT*8+7),pset
  next COUNT    
  for COUNT = 0 to 3
    BULLET(COUNT+5) = ImageCreate(13,9):AddObject(BULLET(COUNT+5))
    'get BULLET(2),(0,COUNT*10)-(12,COUNT*10+8),BULLET(COUNT+5)
    put BULLET(COUNT+5),(0,0),BULLET(2),(0,COUNT*10)-(12,COUNT*10+8),pset
  next COUNT    
  for COUNT = 0 to 4
    NAVE(COUNT) = ImageCreate(32,13):AddObject(NAVE(COUNT))
    'get TEMP,(0,COUNT*13)-(31,COUNT*13+12),NAVE(COUNT)
    put NAVE(COUNT),(0,0),TEMP,(0,COUNT*13)-(31,COUNT*13+12),pset
  next COUNT  
  bload "Graph/Bit.bmp",TEMP,HIDPAL  
  for COUNT = 0 to 11
    GBIT(COUNT) = ImageCreate(11,10): AddObject(GBIT(COUNT))
    'get TEMP,(0,COUNT*10)-(10,COUNT*10+8),GBIT(COUNT)
    put GBIT(COUNT),(0,0),TEMP,(0,COUNT*10)-(10,COUNT*10+8),pset
  next COUNT  
  bload "Graph/Nlevel.bmp",TEMP,ORGPAL  
  MYBOX = ImageLoad("Graph/Fase1/Drums.bmp",ORGPAL)
  Palcopy CIANPAL,ORGPAL,1,7
  
  ' ************************ Carregando DRUMS *************************
  GetMetric(MYBOX,XX,YY)
  XA=1:YA=1:YO=1:XO=400
  do
    XB=XA
    ' *** Detectando prÛximo Y ***
    while point(XB,YA,MYBOX) <> 63
      'while cptr(ubyte ptr,MYBOX)[YA*XX+XB] <> 63      
      XB += 1    
      if XB>=XX then exit do
    wend
    do
      YB=YA  
      ' *** Detectando prÛximo X ***
      while point(XA,YB,MYBOX) <> 63
        'while cptr(ubyte ptr,MYBOX)[YB*XX+XA] <> 63        
        YB += 1      
        if YB>=YY then exit do
      wend        
      ' *** Adicionando Objeto ***
      DRUM[0]+=1
      if cint(DRUM[0])>DRUM_U then 'ubound(DRUM)
        DRUM_U=(cint(DRUM[0])):DRUM = reallocate(DRUM,(DRUM_U+1)*sizeof(typeof(*DRUM)))
        if DRUM = 0 then print "Failed to reallocate drum object"
        'redim preserve DRUM(DRUM(0)+16)
      end if
      DRUM[cint(DRUM[0])] = ImageCreate(XB-XA,YB-YA)
      'get MYBOX,(XA,YA)-(XB-1,YB-1),DRUM[cint(DRUM[0])]
      put DRUM[cint(DRUM[0])],(0,0),MYBOX,(XA,YA)-(XB-1,YB-1),pset
      YA=YB+1    
      'loop until YA>=YY orelse cptr(ubyte ptr,MYBOX)[YA*XA+XB]=63
    loop until point(XA,YA,MYBOX)=63 or YA>=YY
    XA=XB+1:YA=1
    'loop until XA>=XX orelse cptr(ubyte ptr,MYBOX)[YA*XA+XB]=63
  loop until point(XA,YA,MYBOX)=63 or XA>=XX
  ImageDestroy(MYBOX)
  
  ' *********************** Carregar Mapa ***********************
  MYFILE = freefile
  if Open("Fase1.dat" for binary access read as #MYFILE)=0 then    
    get #MYFILE,1,MAPLNT
    get #MYFILE,,MAXMAP
    'redim preserve as ulongint MAP(MAXMAP+1)
    MAP_U = (MAXMAP+11): MAP = reallocate(MAP,((MAP_U+1)*sizeof(typeof(*MAP))))
    if DRUM = 0 then print "Failed to reallocate map object"
    'get #MYFILE,,MAP()
    get #MYFILE,,*cptr(ubyte ptr,MAP),((MAP_U+1)*sizeof(typeof(*MAP)))
    close #MYFILE
    for COUNT = 0 to MAXMAP
      InMap(COUNT)->PY -= 4
    next COUNT
  else
    print "Could not load MAP....": MYFILE = 0
  end if  
  
  for COUNT = 1 to DRUM_U 'ubound(DRUM)
    if DRUM[COUNT]=0 then print "Failed to load drum #" & COUNT
  next COUNT  
  for COUNT = 0 to MAXOBJ-1
    'if OBJECTS[COUNT] then print "Failed to load object #" & COUNT
  next COUNT
  
  dim as single FrameTime = timer  
  do
    
    while (timer-FrameTime) > 1/60
      FrameTime += 1/70
      if MYFILE=0 then exit do      
      ' ******************* EFEITO BOMBA ************
      if BMBP > -1 then
        cptr(uinteger ptr,ORGPAL)[0] = rgba(BMBP,0,0,0)        
        BMBP -= 1
      end if      
      ' \\\\\\\\\\\\\\\\\\\ FADING DA PALETA ///////////////////////
      if EXPLODED > 128 then FADE -= 1
      if CENX > 3420 then FADE -= 1
      if len(TECLA) andalso TECLA[0] = asc("Y") then FADE -= 2
      if FADE < 100 then
        if PAG then FADE += 1
        palfade ORGPAL,FADE,0,255
      else
        palset ORGPAL,0,255      
      end if
      PAG = 1 - PAG      
      ' \\\\\\\\\\\\\\\\\ ATUALIZA«¬O E SINCRONISMO /////////////////
      CENM += 1
      if CENM = 3 then
        CENM = 0: CENX += 1
        ' ////////////// RotaÁ„o da Paleta \\\\\\\\\\\\
        'PALROTATE ORGPAL,1,11,18      
        if PROTE > 0 then
          PALROTATE ORGPAL,1,1,7        
        end if      
      end if      
      '\\\\\\\\\\\\\\ CALCULA AS ESTRELAS ///////////////
      STARM += 1
      if STARM = 6 then
        STARM = 0
        for COUNT=100 to 0 step -1
          STX(COUNT) -= 1
          if STX(COUNT)<0 then STX(COUNT) = 255
        next COUNT
      end if      
      ' \\\\\\\\\\\\\\\ CALCULA OS MISSEIS //////////////
      for COUNT = 0 to 100
        if MIST(COUNT) then
          if MISA(COUNT) > 0 then MISA(COUNT) -= 1
          if MISA(COUNT) = 0 then
            'if (abs(MIST(COUNT))-1) < 7 then
            '  put(MISX(COUNT),MISY(COUNT)),MISS(abs(MIST(COUNT))-1),trans
            'end if
            MISX(COUNT) += 3
            MISY(COUNT) += 3 * sgn(MIST(COUNT))
            if MISX(COUNT) > 256 then MIST(COUNT) = 0
            if MISY(COUNT) > 192 or MISY(COUNT) < 0 then MIST(COUNT) = 0
          end if
        end if
      next COUNT    
      ' \\\\\\\\\\\\\\\\\\ CALCULA O BIT ///////////////
      if BITBIT then
        if PAG then BITPOS += 1: if BITPOS > 17 then BITPOS = 0      
      end if    
      ' \\\\\\\\\\\\\\\ CALCULA AS BALAS //////////////   
      for COUNT = 0 to 30
        if BULT(COUNT) <> -1 then
          if BULT(COUNT) < 4 then
            if BULT(COUNT) = 2 then
              BULARCOB(COUNT) += 1
              if BULARCOB(COUNT) = 2 then
                BULARCOB(COUNT) = 0
                BULARCO(COUNT) += 1
                if BULARCO(COUNT) = 3 then BULARCO(COUNT) = -3
              end if          
            end if
            BULX(COUNT) += 5
            if BULX(COUNT) > 255 then BULT(COUNT) = -1
          end if
        end if
      next COUNT    
      ' \\\\\\\\\\\\\\\\\\ CALCULA A NAVE //////////////////
      NCOUNT = NAVSPY * 2
      if NCOUNT < -2 then NCOUNT = -2
      if NCOUNT > 2 then NCOUNT = 2    
      if EXPLODED then      
        EXPLODED += 1
        if CENM = 0 then NAVEX -= 1
      else
        NAVEX += NAVSPX: NAVEY += NAVSPY        
        if NAVEX < 0 then NAVEX = 0
        if NAVEX > 224 then NAVEX = 224
        if NAVEY < 12 then NAVEY = 12
        if NAVEY > 178 then NAVEY = 178
        NAVSPX /= 1.1
        NAVSPY /= 1.1
      end if    
      ' \\\\\\\\\\\\\\\\ EFEITO PROTE«√O ////////////////
      if PROTE > 0 then
        if PROTE < 400 then PROTP = PROTP + 1
        if PROTP = 6 then PROTP = 0      
      end if      
      ' \\\\\\\\\\\\\\\\\ CALCULA EXPLOSAO /////////////////
      for COUNT = 0 to 150
        if EXPT(COUNT) >= 0 then        
          if EXPT(COUNT) < 100 then
            put(EXPX(COUNT)-CENX,EXPY(COUNT)),EXPLO(EXPT(COUNT)),trans        
            if PAG then
              EXPT(COUNT) += 1
              if EXPT(COUNT) = 14 then EXPT(COUNT) = -1
              if EXPT(COUNT) = 28 then EXPT(COUNT) = -1
            end if        
          else
            EXPT(COUNT) -= 100
          end if
        end if
      next COUNT
      ' \\\\\\\\\\\\\\\\\ TECLAS DE COMANDO /////////////////
      if FADE > 30 and EXPLODED = 0 then
        dim as integer AutoLeft,AutoRight,AutoUp,AutoDown
        dim as integer MX,MY,MB
        static as integer NX,NY,NB
        static as single LastClick
        
        getmouse MX,MY,,MB      
        if MB <> -1 andalso (MB and 1) then
          if MY > 10 then
            NX = MX: NY = MY: NB = MB
          end if
          LastClick = timer
        else
          if abs(timer-LastClick) > 1/4 then
            NB = 0
          end if
        end if
        
        if (NB and 1) then
          dim as integer iNAVEX=NAVEX+16,iNAVEY=NAVEY+8,HalfX,HalfY
          dim as integer AbsX=abs(MX-iNAVEX),absY=abs(MY-iNAVEY)
          if absX > absY then 
            HalfX=1:HalfY=(FPCNT and 1)
          else
            HalfY=1:HalfX=(FPCNT and 1)
          end if
          if absX > 4 then
            if MX > iNAVEX then AutoRight = 1 and HalfX
            if MX < iNAVEX then AutoLeft = 1 and HalfX
          end if
          if absY > 4 then
            if MY > iNAVEY then AutoDown = 1 and HalfY
            if MY < iNAVEY then AutoUp = 1 and HalfY
          end if
        end if
        
        #define ButtonLeft() (multikey(SC_LEFT) or multikey(SC_BUTTONLEFT) or AutoLeft)
        #define ButtonRight() (multikey(SC_RIGHT) or multikey(SC_BUTTONRIGHT) or AutoRight)
        #define ButtonUp() (multikey(SC_UP) or multikey(SC_BUTTONUP) or AutoUp)
        #define ButtonDown() (multikey(SC_DOWN) or multikey(SC_BUTTONDOWN) or AutoDown)
        #define ButtonShot() (multikey(SC_CONTROL) or multikey(SC_BUTTONA))
        if ButtonLeft() then
          if NAVSPX > -1.4 then NAVSPX -= .2
          if BITPX < 30 then BITPX += 1
          if ButtonUp() = 0 and ButtonDown() = 0 then BITPY -= sgn(BITPY)
        end if
        if ButtonRight() then
          if NAVSPX < 1.4 then NAVSPX += .2
          if BITPX > -20 then BITPX -= 1
          if ButtonUp() = 0 and ButtonDown() = 0 then BITPY -= sgn(BITPY)
        end if
        if ButtonUp() then
          if BITPY < 15 then BITPY += 1
          if NAVSPY > -1.2 then NAVSPY -= .2
          if ButtonLeft() = 0 and ButtonRight() = 0 then BITPX -= sgn(BITPX)
        end if
        if ButtonDown() then
          if BITPY > -15 then BITPY -= 1
          if NAVSPY < 1.2 then NAVSPY += .2
          if ButtonLeft() = 0 and ButtonRight() = 0 then BITPX -= sgn(BITPX)
        end if
        if ButtonShot() =0 then BUT_CTRL = 0
        
        static as integer TouchStatus
        if MB>0 then
          if MY <= 10 then TouchStatus += 1
          TouchStatus += 1
        else
          TouchStatus = 0
        end if        
        ' ///////////// TELA CTRL (atirar) \\\\\\\\\\\\\\\\\
        if (ButtonShot() or (TouchStatus=1)) and BUT_CTRL = 0 then
          if abs(FPCNT-LASTSHOT) > 8 then
            LASTSHOT = FPCNT
            ' ******** BULLETS *******
            COUNT = 0
            while BULT(COUNT) <> -1
              COUNT += 1
            wend
            BULARCO(COUNT) = 0
            BULARCOB(COUNT) = -3
            BULX(COUNT) = NAVEX + 30
            BULY(COUNT) = NAVEY + 5
            BULT(COUNT) = BULLETYPE
            while BULT(COUNT) <> -1
              COUNT += 1
            wend
            ' ******* BITBULLETS *******
            if BITBIT then
              while BULT(COUNT) <> -1
                COUNT += 1
              wend
              BULARCO(COUNT) = 0
              BULARCOB(COUNT) = -3
              BULX(COUNT) = NAVEX+BITPX+5
              BULY(COUNT) = NAVEY+BITPY+3
              BULT(COUNT) = BULLETYPE
            end if
            '****** MISSEIS ******
            if MISSIL then
              if MISSIL = 1 then MISSIL = 2 else MISSIL = 1
              COUNT = 0
              for BUT_CTRL = 0 to 6
                while MIST(COUNT) <> 0
                  COUNT += 1
                wend
                if BUT_CTRL =0 then
                  if MISSIL = 1 then
                    MIST(COUNT) = -1
                  else
                    MIST(COUNT) = 2
                  end if
                else
                  if MISSIL = 1 then
                    MIST(COUNT) = -2-BUT_CTRL
                  else
                    MIST(COUNT) = 2+BUT_CTRL
                  end if
                end if
                MISA(COUNT) = BUT_CTRL * 3
                MISX(COUNT) = NAVEX + 5
                MISY(COUNT) = NAVEY + 5
              next BUT_CTRL
              '****** BIT MISSEIS ******
              for BUT_CTRL = 0 to 6
                while MIST(COUNT) <> 0
                  COUNT += 1
                wend
                if BUT_CTRL =0 then
                  if MISSIL = 1 then 
                    MIST(COUNT) = -1
                  else
                    MIST(COUNT) = 2
                  end if
                else
                  if MISSIL = 1 then
                    MIST(COUNT) = -2-BUT_CTRL
                  else
                    MIST(COUNT) = 2+BUT_CTRL
                  end if
                end if
                MISA(COUNT) = BUT_CTRL * 3
                MISX(COUNT) = NAVEX + BITPX + 2
                MISY(COUNT) = NAVEY + BITPY + 2
              next BUT_CTRL
            end if
            BUT_CTRL = 1
          end if
        end if
        
        ' **************** Some Tests *************
        if (multikey(SC_EQUALS) or multikey(SC_BUTTONX)) = 0 then BUT_PLUS = 0
        if (multikey(SC_EQUALS) or multikey(SC_BUTTONX)) and BUT_PLUS = 0 then
          if BULLETYPE < 3 then BULLETYPE += 1
          BUT_PLUS = 1
        end if
        if (multikey(SC_MINUS) or multikey(SC_BUTTONY)) = 0 then BUT_MINUS = 0
        if (multikey(SC_MINUS) or multikey(SC_BUTTONY)) and BUT_MINUS = 0 then
          if BULLETYPE > 0 then BULLETYPE -= 1
          BUT_MINUS = 1
        end if
        
        ' ************ Bomba ******************
        #define ButtonBomb() (multikey(SC_ALT) or multikey(SC_BUTTONB))
        if ButtonBomb() = 0 then BUT_ALT = 0
        if ButtonBomb() and BUT_ALT = 0 and BOMBS > 0 then 
          BOMBS -= 1:BMBP = 48:BUT_ALT = 1
        end if
        
      end if
      
      KEY = inkey$
      if len(KEY) then
        if KEY[1] = asc("k") then end
        if (KEY[1] = SC_BUTTONR) then DO_SYNC = 1 - DO_SYNC
        if (KEY[0] = 13) or (KEY[1]=SC_BUTTONL) then     
          'DO_SYNC = 1 - DO_SYNC
          dim as integer EXPCNT=0,STCNT = 0
          for COUNT = 0 to 150
            if EXPT(COUNT) <> -1 then EXPCNT += 1
          next COUNT          
          if EXPCNT < 15 then
            for CNT = 0 to 140
              for FNE as integer = STCNT to 150
                if EXPT(FNE) = -1 then
                  if rnd > .5 then
                    EXPT(FNE) = 14+(CNT shr 2)*400
                    EXPX(FNE) = CENX+110+rnd*100
                    EXPY(FNE) = 70+rnd*60
                  else
                    EXPT(FNE) = (CNT shr 2)*400
                    EXPX(FNE) = CENX+110+rnd*100
                    EXPY(FNE) = 70+rnd*60
                  end if
                  STCNT=FNE+1:exit for
                end if
              next FNE
            next CNT
          end if
        end if
      end if
      #define ButtonStart() (multikey(SC_ESCAPE) or multikey(SC_BUTTONSTART))
      if ButtonStart() = 0 then BUT_ESC = 0
      if ButtonStart() and BUT_ESC = 0 and PAG = 0 and FADE = 100 then
        BUT_ESC=1:TMPVOL=OMUSIC:OMUSIC=0
        PALCOPY BLUEPAL,ORGPAL,1,7
        #ifdef MySound
        if PLAYSONG then FSOUND_SetVolume(PLAYSONG, 0)
        #endif
        put (0,51),QUITG,trans
        TECLA = ucase$(inkey$)        
        do
          TECLA = ucase$(inkey$)
          PalRotate(ORGPAL,1,1,7)          
          palset ORGPAL,0,255
          #ifdef RenderOpenGL
          put (0,51),QUITG,trans
          flip
          #endif
          sync:sync
          if len(TECLA) then
            if TECLA[0] = 27 or TECLA[1] = SC_BUTTONSTART then TECLA = "N"
            if TECLA[0] = asc("N") or TECLA[1] = SC_BUTTONB then TECLA = "N"
            if TECLA[0] = asc("Y") or TECLA[1] = SC_BUTTONA then TECLA = "Y"            
            if TECLA[0] = asc("Y") or TECLA[0] = asc("N") then exit do
          end if
        loop         
        while multikey(SC_BUTTONSTART) or multikey(SC_BUTTONA) or multikey(SC_BUTTONB)
          sleep 1,1
        wend
        FrameTime = timer        
        palcopy CIANPAL,ORGPAL,1,7
        OMUSIC=TMPVOL
        if len(TECLA) andalso TECLA[0] = asc("N") then
          #ifdef MySound
          if PLAYSONG then FSOUND_SetVolume(PLAYSONG,(OMUSIC*25.5))
          #endif
        end if
      end if
      
    wend
    
    ' ==============================================================================
    ' ==============================================================================
    ' ==============================================================================
    ' ==============================================================================
    
    screenlock
    
    ' \\\\\\\\\\\\\\\\\\\ LIMPA A TELA /////////////////
    line(0,10)-(255,191),0,bf    
    ' *********** Desenha o mapa **********
    COUNT=0:XLT = CENX-100:XRT = CENX+256
    while InMap(COUNT)->PX < XLT and COUNT<=MAXMAP
      COUNT += 1
    wend    
    while InMap(COUNT)->PX <= XRT and COUNT<=MAXMAP
      if InMap(COUNT)->ID <= cint(DRUM[0]) then
        TMPX = InMap(COUNT)->PX-CENX
        TMPY = InMap(COUNT)->PY
        PTRA = DRUM[InMap(COUNT)->ID]
        Put(TMPX,TMPY),PTRA,pset
        
        ' ******* Checa colis„o nave/mapa ********
        if PROTE > 0 andalso Collision(PROTNAV,NAVEX-3,NAVEY-2,PTRA, TMPX,TMPY) > 0 then
          PROTE = 0          
        end if        
        CNT = NAVSPY * 2
        if CNT < -2 then CNT = -2
        if CNT > 2 then CNT = 2
        if EXPLODED = 0 andalso Collision(NAVE(2+CNT),NAVEX,NAVEY,PTRA, TMPX,TMPY) > 0  then
          EXPLODED = 1: BITBIT = 0          
          for CNT = 0 to 12
            for FNE as integer = 0 to 150
              if EXPT(FNE) = -1 then
                if rnd >= .5 then
                  EXPT(FNE) = 14+CNT*400
                  EXPX(FNE) = CENX+((NAVEX-8)+rnd*32)
                  EXPY(FNE) = (NAVEY-7)+rnd*14
                else
                  EXPT(FNE) = CNT*400
                  EXPX(FNE) = CENX+((NAVEX-16)+rnd*32)
                  EXPY(FNE) = (NAVEY-14)+rnd*14
                end if
                exit for
              end if
            next FNE
          next CNT
          
        end if
        
        ' ******* Checa colis„o bala/mapa ********
        for CNT  = 0 to 30          
          if BULT(CNT) <> -1 and BULT(CNT) < 4 then
            if BULT(CNT) = 2 then 
              PTRB = BULLET(5+abs(BULARCO(CNT)))
            else
              PTRB = BULLET(BULT(CNT))
            end if            
            if Collision(PTRB,BULX(CNT),BULY(CNT),PTRA, TMPX,TMPY) > 0 then
              BULT(CNT) = -1
            end if
          end if
        next CNT
        
        ' ******* Checa colis„o mÌssil/mapa ********
        for CNT = 0 to 100
          if MIST(CNT) <> 0 and MISA(CNT) = 0 then
            PTRB = MISS(abs(MIST(CNT))-1)            
            if Collision(PTRB,MISX(CNT),MISY(CNT),PTRA, TMPX,TMPY) > 0 then              
              if abs(MIST(CNT)) < 3  then
                ' *** nova explos„o ***
                for FNE as integer = 0 to 150
                  if EXPT(FNE) = -1 then
                    EXPT(FNE) = 14
                    EXPX(FNE) = CENX+(MISX(CNT)-4)
                    EXPY(FNE) = MISY(CNT)-4
                    exit for
                  end if
                next FNE
              end if
              MIST(CNT) = 0
            end if
          end if
        next CNT
        
      end if
      COUNT += 1
    wend    
    ' \\\\\\\\\\\\\\\\\\\\\ ESTRELAS ///////////////////
    for COUNT=100 to 0 step -1      
      if point8(STX(COUNT),STY(COUNT)) = 0 then
        pset8(STX(COUNT),STY(COUNT),STC(COUNT))
      end if
    next COUNT    
    ' ***************** DESENHA OS MISSEIS **************
    for COUNT = 0 to 100
      if MIST(COUNT) then      
        if MISA(COUNT) = 0 then
          if (abs(MIST(COUNT))-1) < 7 then
            put(MISX(COUNT),MISY(COUNT)),MISS(abs(MIST(COUNT))-1),trans
          end if
        end if
      end if
    next COUNT    
    ' \\\\\\\\\\\\\\\\\\ COLOCA O BIT ///////////////
    if BITBIT then
      if BITPOS < 11 then 
        put(NAVEX+BITPX,NAVEY+BITPY),GBIT(BITPOS),trans
      else
        put(NAVEX+BITPX,NAVEY+BITPY),GBIT(11),trans
      end if
    end if    
    ' \\\\\\\\\\\\\\\ DESENHA AS BALAS //////////////   
    for COUNT = 0 to 30
      if BULT(COUNT) <> -1 then
        if BULT(COUNT) < 4 then
          if BULT(COUNT) = 2 then             
            put(BULX(COUNT),BULY(COUNT)),BULLET(5+abs(BULARCO(COUNT))),trans            
          else 
            put(BULX(COUNT),BULY(COUNT)),BULLET(BULT(COUNT)),trans
          end if
        end if
      end if
    next COUNT    
    ' **** desenha a nave ****
    if EXPLODED < 16 then put(NAVEX,NAVEY),NAVE(2+NCOUNT),trans    
    ' **** desenha a proteÁ„o ****
    if PROTE >0 and PROTP < 3 then put (NAVEX - 3, NAVEY - 2),PROTNAV,trans    
    ' ***** Coloca as explosıes *****
    for COUNT = 0 to 150
      if EXPT(COUNT) >= 0 then        
        if EXPT(COUNT) < 100 then
          put(EXPX(COUNT)-CENX,EXPY(COUNT)),EXPLO(EXPT(COUNT)),trans        
        end if
      end if
    next COUNT    
    ' //////////////// PAINEL DE STATUS \\\\\\\\\\\\\\\
    line(0,0)-(255,10),0,bf
    for COUNT = 1 to SHIPS
      put (254-COUNT*14, 2),SHIP,pset
    next COUNT
    for COUNT = 1 to BOMBS
      put (187-COUNT * 10, 2),BOMB,pset
    next COUNT
    if PROTE > 0 then
      PROTN = int(PROTE / 30) + 67
      line (67, 2)-( PROTN, 2), 166 '
      line (67, 3)-( PROTN, 3), 164 '
      line (67, 4)-( PROTN, 4), 163 '
      line (67, 5)-( PROTN, 5), 161 '
      line (67, 6)-( PROTN, 6), 163 '
      line (67, 7)-( PROTN, 7), 164 '
      line (67, 8)-( PROTN, 8), 166 '
      line (PROTN + 1, 2)-(118, 2), 111 '
      line (PROTN + 1, 3)-(118, 3), 106 '
      line (PROTN + 1, 4)-(118, 4), 101 '
      line (PROTN + 1, 5)-(118, 5), 96 '
      line (PROTN + 1, 6)-(118, 6), 101 '
      line (PROTN + 1, 7)-(118, 7), 106 '
      line (PROTN + 1, 8)-(118, 8), 111 '
      put (60,2),PROTBAR,trans
      if PAG then PROTE -= 1
    end if
    drawnumber SCORE,1,1
    drwtranstext mid$(str$(FPSMAX),1,4),0,184,2
    drwtranstext mid$(str$(CENX),1,5),0,10,2
    
    screenunlock
    
    FPS += 1: FPCNT += 1
    
    if (timer-FPTIM)>.5 then
      FPSMAX = FPS*2
      FPS = 0
      if abs(timer-FPTIM)>1 then
        FPTIM = timer
      else
        FPTIM += .5
      end if
    end if    
    
    #ifdef RenderOpenGL    
    flip
    #endif
    
    #ifdef __FB_NDS__
    if DO_SYNC then sync else fb_DoVsyncCallBack()
    #else
    if DO_SYNC then sync 
    #endif
    
  loop until FADE < 1
  
  for COUNT = 1 to DRUM_U 'ubound(DRUM)
    ImageDestroy(DRUM[COUNT])
  next COUNT  
  for COUNT = 0 to MAXOBJ-1
    Imagedestroy(OBJECTS[COUNT])
  next COUNT
  #ifdef MySound
  if PLAYSONG then FSOUND_SetVolume(PLAYSONG,(OMUSIC*25.5))
  #endif
  
  'erase DRUM,MAP  
  deallocate(DRUM):deallocate(MAP):deallocate(OBJECTS)
  
  if len(TECLA) and TECLA[0] = asc("Y") then return -1
  if CENX > 3420 and EXPLODED=0 then return 1
  return 0
  
end function
' ******************************************************************
' ********************* SUB DE INTRO DA FASE *** *******************
' ******************************************************************

sub showfase (FASE as integer)  
  dim as any ptr LVL(1)
  dim as integer PAG,FADESPD
  dim as string TECLA
  
  ' ************ Graficos E Etc... ***********
  screenlock
  line(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 192
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 168 + rnd * 12
  next COUNT  
  bload "Graph/Nlevel.bmp",TEMP,ORGPAL
  LVL(0) = ImageCreate(60,39)
  put LVL(0),(0,0),TEMP,(0,0)-(59,38),pset
  LVL(1) = ImageCreate(60,39)
  put LVL(1),(0,0),TEMP,(0,39)-(59,77),pset
  'palget @ORGPAL,0,255
  bload "Graph/Level.bmp",TEMP,HIDPAL
  palfade ORGPAL,0,0,255  
  put scrbuff,(0,0),TEMP,pset
  
  ' *************** EspecÌfico da Fase ***************
  
  select case FASE
  case 1
    put scrbuff,(132-32,80),LVL(0),trans
  case 2
    put scrbuff,(121-32,80),LVL(0),trans
    put scrbuff,(143-32,80),LVL(0),trans
  case 3
    put scrbuff,(110-32,80),LVL(0),trans
    put scrbuff,(132-32,80),LVL(0),trans
    put scrbuff,(154-32,80),LVL(0),trans
  case 4
    put scrbuff,(103-32,80),LVL(0),trans
    put scrbuff,(163-32,80),LVL(1),trans
  case 5
    put scrbuff,(140-32,80),LVL(1),trans
  case 6
    put scrbuff,(126-32,80),LVL(1),trans
    put scrbuff,(145-32,80),LVL(0),trans
  case 7
    put scrbuff,(113-32,80),LVL(1),trans
    put scrbuff,(132-32,80),LVL(0),trans
    put scrbuff,(154-32,80),LVL(0),trans
  case 8
    put scrbuff,(101-32,80),LVL(1),trans
    put scrbuff,(120-32,80),LVL(0),trans
    put scrbuff,(142-32,80),LVL(0),trans
    put scrbuff,(164-32,80),LVL(0),trans
  end select
  screenunlock
  FADE = 1
  FADESPD = 1
  
  ' ********************* Inicio do Fade ******************
  
  while len(inkey$)
    rem
  wend
  
  do
    screenlock
    palfade ORGPAL,FADE,0,255
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,11,18
      'ORGPAL = left$(ORGPAL,33)+mid$(ORGPAL,37,21)+mid$(ORGPAL,34,3)+mid$(orgpal,58)    
    end if
    TECLA = inkey$
    if len(TECLA) then
      if TECLA[1] = asc("k") then end      
      FADESPD = -1
    end if
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT 
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif
    sync
    
  loop until FADE < 1
  ImageDestroy(LVL(0)):ImageDestroy(LVL(1))
  line(0,0)-(255,191),0,bf:screensync
end sub

' ********************************************************************
' *************************  Menu Quit *******************************
' ********************************************************************

function quit() as integer
  dim FADESPD as short,PAG as integer,OPT as integer
  dim as string TECLA,TMPCLA,UTECLA
  dim as any ptr CURSOR
  
  ' ******************* Gr·ficos e talz *******************
  screenlock
  line(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 191
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1 + rnd * 6
  next COUNT  
  OPT = 1
  CURSOR = ImageLoad("Graph/Menus.bmp")
  Bload "Graph/Menue.bmp",TEMP,ORGPAL
  'palget @ORGPAL,0,255
  palfade ORGPAL,0,0,255
  put ScrBuff,(0,0),TEMP,pset
  line ScrBuff,(0,179)-(255,191),0,bf  
  DrwTransText "Type Y or N, then press ENTER.",31,183,0,,ScrBuff
  DrwBigTTxt 4,65,"#1Are you sure you want to quit?",,ScrBuff
  DrwBigTTxt 122,100,"Y#2es",,ScrBuff
  DrwBigTTxt 122,122,"#1No",,ScrBuff
  put ScrBuff,(93,121),CURSOR,trans
  screenunlock
  FADE = 1
  FADESPD = 1
  
  ' ********************* Inicio do Fade *********************
  do
    
    screenlock
    
    palfade ORGPAL,FADE,0,255
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15
    end if
    TECLA = inkey$+chr$(255)
    UTECLA = ucase$(TECLA)
    if FADESPD > -1 then
      if FADESPD=0 then COUNT = -1 else COUNT = 0
      if TECLA[1] = fb.SC_UP or TECLA[1] = fb.SC_BUTTONUP then
        if OPT>0 then OPT = OPT - 1:COUNT = -1
      elseif TECLA[1] = fb.SC_DOWN or TECLA[1] = fb.SC_BUTTONDOWN then 
        if OPT<1 then OPT = OPT + 1:COUNT = -1
      end if
      if UTECLA[0] = asc("Y") then OPT = 0:COUNT =-1
      if UTECLA[0] = asc("N") then OPT = 1:COUNT =-1
      
      if Multikey(fb.SC_BUTTONTOUCH) then        
        dim as integer MX,MY,CNOPT
        getmouse MX,MY
        for CNOPT = 0 to 1
          if MX > 80 and MX < (256-80) then
            if MY > (100+CNOPT*22) and MY < (122+CNOPT*22) then
              if TouchDown=0 andalso OPT=CNOPT then FADESPD = -1
              if OPT <> CNOPT then OPT=CNOPT:COUNT=-1
              TouchBack = 0
              exit for
            end if
          end if
        next CNOPT
        if TouchDown=0 andalso TouchBack then
          TouchBack=0: OPT=1: COUNT =-1: FADESPD = -1
        end if
        if CNOPT > 1 then TouchBack = 1
        if TouchDown=0 then TouchDown = 1
      else
        TouchDown = 0
      end if
            
      ' ************ Altera Cursor ************  
      if COUNT then
        screenlock
        put ScrBuff,(0,0),TEMP,pset
        line ScrBuff,(0,179)-(255,191),0,bf
        DrwTransText "Type Y or N, then press ENTER.",31,183,0,,ScrBuff
        DrwBigTTxt 4,65,"#1Are you sure you want to quit?",,ScrBuff
        if OPT = 0 then
          DrwBigTTxt 122,100,"#1Yes",,ScrBuff
          DrwBigTTxt 122,122,"N#2o",,ScrBuff
          put ScrBuff,(93,99),CURSOR,trans
        end if
        if OPT = 1 then
          DrwBigTTxt 122,100,"Y#2es",,ScrBuff
          DrwBigTTxt 122,122,"#1No",,ScrBuff
          put ScrBuff,(93,121),CURSOR,trans
        end if
        screenunlock
        for COUNT = 0 to 50
          STA(COUNT) = 0
        next COUNT
      end if
    end if
    if FADESPD = 0 then FADESPD = -1
    if TECLA[1] = asc("k") then end
    if TECLA[0] = 13 then FADESPD = -1
    if TECLA[1] = fb.SC_BUTTONA then FADESPD = -1
    if TECLA[1] = fb.SC_BUTTONSELECT then FADESPD = -1
    if TECLA[1] = fb.SC_BUTTONSTART then OPT=1:FADESPD = 0
    if TECLA[1] = fb.SC_BUTTONB then OPT=1:FADESPD = 0
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT  
    
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif
    
    sync
  loop until FADE < 1
  
  line(0,0)-(255,191),0,bf:screensync
  if OPT = 0 then quit = -1  
  if OPT = 1 then quit = 0  
end function

' ********************************************************************
' *************************** Desenha o Texto ************************
' ********************************************************************

function drwtext(TEXTO as string,PX as integer,PY as integer,byval COR as byte,Target as any ptr=0) as integer
  static CHAR as ubyte
  static CHARLNT as integer
  for COUNT = 0 to len(TEXTO)-1
    if PX>255 then return -1
    CHAR = TEXTO[COUNT]
    if CHAR<32 or CHAR>127 then CHAR = asc("?")
    dim as integer CX = (CHAR and 15) shl 3
    dim as integer CY = ((CHAR shr 4)-2) shl 3
    if COR < 3 then put Target,(PX,PY),CHARS(COR),(CX,CY)-(CX+7,CY+7),pset
    PX += FONTSPC(CHAR)
    CHARLNT += FONTSPC(CHAR)
  next COUNT
  drwtext = CHARLNT
end function

function drwtranstext(TEXTO as string,PX as integer,PY as integer,byval COR as byte,ExtraSpace as integer=0,Target as any ptr=0) as integer
  dim CHAR as ubyte
  dim CHARLNT as integer, TEMPLNT as integer
  if TEXTSWAP then
    for COUNT = 0 to len(TEXTO)-1
      if PX>255 then return -1
      CHAR = TEXTO[COUNT]
      if CHAR<32 or CHAR>127 then CHAR = asc("?")
      TEMPLNT = (FONTSPC(CHAR)+ExtraSpace)
      dim as integer CX = (CHAR and 15) shl 3
      dim as integer CY = ((CHAR shr 4)-2) shl 3
      if COR < 3 then put Target,(PX,PY),CHARS(COR),(CX,CY)-(CX+(TEMPLNT-2),CY+7),trans
      PX += TEMPLNT: CHARLNT += TEMPLNT
    next COUNT
  else
    for COUNT = 0 to len(TEXTO)-1
      if PX>255 then return -1
      CHAR = TEXTO[COUNT]
      if CHAR<32 or CHAR>127 then CHAR = asc("?")
      TEMPLNT = (FONTSPC(CHAR)+ExtraSpace)
      dim as integer CX = (CHAR and 15) shl 3
      dim as integer CY = ((CHAR shr 4)-2) shl 3
      if COR < 3 then 
        put Target,(PX+1,PY),CHARS(COR),(CX-ExtraSpace,CY)-(CX+(TEMPLNT-1),CY+7),trans
      end if
      PX += TEMPLNT: CHARLNT += TEMPLNT
    next COUNT
  end if
  drwtranstext = CHARLNT
end function

' ********************************************************************
' ************************* Menu introduÁ„o **************************
' ********************************************************************

function intro() as integer  
  dim FADESPD as short,PAG as integer,OPT as integer
  dim as string TECLA,UTECLA
  dim as any ptr CURSOR
  
  ' ***************** Graficos E talz ****************
  screenlock
  line(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 192
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1+rnd*6
  next COUNT  
  OPT = 0  
  CURSOR = ImageLoad("Graph/Menus.bmp") ',@CURSOR(0)
  bload "Graph/Menue.bmp",TEMP,ORGPAL  
  palfade ORGPAL,0,0,255
  put scrbuff,(0,0),TEMP,pset
  line scrbuff,(0,179)-(255,191),0,bf
  DrwTransText "Use ÄÅ/ENTER to select. ESC to cancel.",6,183,0,,scrbuff
  DrwBigTTxt 4 ,54,"Introduction",,scrbuff
  DrwBigTTxt 49,83,"#1Playing the game...",,scrbuff
  DrwBigTTxt 49,104, "T#2ime of the XATAX...",,scrbuff
  put scrbuff,(22,84),CURSOR,trans
  screenunlock
  FADE = 1
  FADESPD = 1
  
  ' *************** InÌcio do loop de fade *****************
  do
    screenlock
    palfade ORGPAL,FADE,0,255
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15
    end if
    TECLA = inkey$
    UTECLA = ucase$(TECLA)
    if FADESPD > -1 then
      COUNT = 0
      if len(TECLA) then
        if UTECLA[0] = asc("P") then OPT = 0:COUNT =-1
        if UTECLA[0] = asc("T") then OPT = 1:COUNT =-1
        if TECLA[1] = fb.SC_UP or TECLA[1] = fb.SC_BUTTONUP then
          if OPT>0 then OPT = OPT - 1:COUNT =-1
        end if
        if TECLA[1] = fb.SC_DOWN or TECLA[1] = fb.SC_BUTTONDOWN then
          if OPT<1 then OPT = OPT + 1:COUNT =-1
        end if
      end if
      
      if Multikey(fb.SC_BUTTONTOUCH) then        
        dim as integer MX,MY,CNOPT
        getmouse MX,MY
        for CNOPT = 0 to 1
          if MX > 48 and MX < (256-48) then
            if MY > (83+CNOPT*21) and MY < (104+CNOPT*21) then
              if TouchDown=0 andalso OPT=CNOPT then FADESPD = -1
              if OPT <> CNOPT then OPT=CNOPT:COUNT=-1
              TouchBack = 0
              exit for
            end if
          end if
        next CNOPT
        if TouchDown=0 andalso TouchBack then
          TouchBack=0: OPT=2: FADESPD = -1
        end if
        if CNOPT > 1 then TouchBack = 1
        if TouchDown=0 then TouchDown = 1
      else
        TouchDown = 0
      end if
      
      ' *************** Muda Cursor ****************    
      if COUNT then        
        put scrbuff,(0,0),TEMP,pset
        line scrbuff,(0,179)-(255,191),0,bf
        DrwTransText "Use ÄÅ/ENTER to select. ESC to cancel.",6,183,0,,scrbuff
        DrwBigTTxt 4,54,"Introduction",,scrbuff
        if OPT = 0 then
          DrwBigTTxt 49,83,"#1Playing the game...",,scrbuff
          DrwBigTTxt 49,104, "T#2ime of the XATAX...",,scrbuff
          put scrbuff,(22,84),CURSOR,trans
        end if
        if OPT = 1 then
          DrwBigTTxt 49,83,"P#2laying the game...",,scrbuff
          DrwBigTTxt 49,104, "#1Time of the XATAX...",,scrbuff
          put scrbuff,(22,104),CURSOR,trans
        end if  
        for COUNT = 0 to 50
          STA(COUNT) = 0
        next COUNT        
      end if
    end if
    if len(TECLA) then
      if TECLA[1] = asc("k") then end
      if TECLA[0] = 27 then FADESPD = -1: OPT = 2
      if TECLA[1] = fb.SC_BUTTONSTART then FADESPD = -1: OPT = 2
      if TECLA[1] = fb.SC_BUTTONB then FADESPD = -1: OPT = 2    
      if TECLA[0] = 13 then FADESPD = -1
      if TECLA[1] = fb.SC_BUTTONA then FADESPD = -1
      if TECLA[1] = fb.SC_BUTTONSELECT then FADESPD = -1
    end if
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT    
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif
    sync
    
  loop until FADE < 1  
  
  if OPT = 0 then intro = -1
  if OPT = 1 then intro = 0
  if OPT = 2 then intro = 1
  Line(0,0)-(255,191),0,bf:screensync
end function

' ********************************************************************
' ******************* Mostrar introduÁ„o P ***************************
' ********************************************************************

sub showintrop (isP as integer=0)
  static LIN(126) as string
  dim as integer LINC(126),LINX(126)
  dim as any ptr ICONS
  dim as string IMPRIMIR,TECLA
  dim as integer PXT,FADESPD,PAG,MOST,X,PX,PY
  dim as integer COMANDO,SABER,IMAGEM,ATUCHAR
  dim as integer DoSwap,SwapCNT,LineCNT
  dim as fb.image ptr ScrHack,OldScr,NewScr
  
  ' **************** texto Da introduÁ„o ***************  
  MOST = 0
  if Isp=0 then
    LineCNT = 114
    LIN(0) = "%C2Commands": LINX(0) = 132
    LIN(1) = "": LINX(1) = 8
    LIN(2) = "%C1Xatax is a fast action arcade games. You must": LINX(2) = 8
    LIN(3) = "%C1use your quick reflexes to shoot and destroy": LINX(3) = 8
    LIN(4) = "%C1air and ground enemies. You can use your": LINX(4) = 8
    LIN(5) = "%C1keyboard or your joystick to play this game. If": LINX(5) = 8
    LIN(6) = "%C1you are using a joystick, you must configure it": LINX(6) = 8
    LIN(7) = "%C1in the Setup option at the Main Menu.": LINX(7) = 8
    LIN(8) = "": LINX(8) = 8
    LIN(9) = "%C1If you are using a keyboard, the following keys": LINX(9) = 8
    LIN(10) = "%C1are used to control your ship:": LINX(10) = 8
    LIN(11) = "": LINX(11) = 8
    LIN(12) = "%C0CTRL - fires your weapon(s)": LINX(12) = 32
    LIN(13) = "%C0ALT - releases a bomb": LINX(13) = 32
    LIN(14) = "%C0UP ARROW - moves the ship up": LINX(14) = 32
    LIN(15) = "%C0DOWN ARROW - moves the ship down": LINX(15) = 32
    LIN(16) = "%C0RIGHT ARROW - moves the ship forward": LINX(16) = 32
    LIN(17) = "%C0LEFT ARROW - moves the ship backwards": LINX(17) = 32
    LIN(18) = "": LINX(18) = 8
    LIN(19) = "%C1To manuever the ship in a diagonal fashion, you": LINX(19) = 8
    LIN(20) = "%C1can press a combination of keys. Press the UP": LINX(20) = 8
    LIN(21) = "%C1ARROW with the RIGHT or LEFT ARROW, or DOWN": LINX(21) = 8
    LIN(22) = "%C1ARROW with the RIGHT or LEFT ARROW.": LINX(22) = 8
    LIN(23) = "": LINX(23) = 8
    LIN(24) = "%C1Other keys during game play are:": LINX(24) = 8
    LIN(25) = "": LINX(25) = 8
    LIN(26) = "%C0ESC - quit the game or restart the level": LINX(26) = 32
    LIN(27) = "%C0SPACEBAR - temporarily pause the game": LINX(27) = 32
    LIN(28) = "": LINX(28) = 8
    LIN(29) = "%C1If you are using a joystick, you have at least": LINX(29) = 8
    LIN(30) = "%C1two fire buttons. During the game play, one will": LINX(30) = 8
    LIN(31) = "%C1fire your weapon(s) and other will drop a": LINX(31) = 8
    LIN(32) = "%C1bomb. During the menu screens, one will act as": LINX(32) = 8
    LIN(33) = "%C1an ENTER key and the other as the ESC key.": LINX(33) = 8
    LIN(34) = "": LINX(34) = 8
    LIN(35) = "%C2Pellets": LINX(35) = 138
    LIN(36) = "": LINX(36) = 8
    LIN(37) = "%C1During the game certain enemies that are": LINX(37) = 8
    LIN(38) = "%C1destroyed will leave behind different power": LINX(38) = 8
    LIN(39) = "%C1pellets. If you collect these pellets, they will": LINX(39) = 8
    LIN(40) = "%C1add or change your ship's weapon to make your": LINX(40) = 8
    LIN(41) = "%C1ship stronger.": LINX(41) = 8  
    LIN(42) = "": LINX(42) = 8  
    LIN(43) = "": LINX(43) = 8  
    LIN(44) = "%I1%C0Power Up %C1- When you first start the game": LINX(44) = 33
    LIN(45) = "%C1your ship will have the standard weapon. As you": LINX(45) = 8  
    LIN(46) = "%C1collect Power Up pellets, your weapon will": LINX(46) = 8
    LIN(47) = "%C1transform to a more powerful weapon.": LINX(47) = 8  
    LIN(48) = "": LINX(48) = 8  
    LIN(49) = "": LINX(49) = 8  
    LIN(50) = "%I2%C0Rapid Fire %C1- The Rapid Fire pellet will allow": LINX(50) = 33
    LIN(51) = "%C1your ship to shoot continuously by simply": LINX(51) = 8
    LIN(52) = "%C1pressing and holding down the CTRL key.": LINX(52) = 8
    LIN(53) = "": LINX(53) = 8
    LIN(54) = "": LINX(54) = 8
    LIN(55) = "%I3%C0Missiles %C1- The Missiles pellet will give your": LINX(55) = 33
    LIN(56) = "%C1ship missiles. The missiles will fire in 45 and": LINX(56) = 8
    LIN(57) = "%C1315 degree angles.": LINX(57) = 8
    LIN(58) = "": LINX(58) = 8
    LIN(59) = "": LINX(59) = 8
    LIN(60) = "%I4%C0Extra Life %C1- The Extra Life pellet will give": LINX(60) = 33
    LIN(61) = "%C1you an extra life, the maximum number of extra": LINX(61) = 8
    LIN(62) = "%C1lives you can have is 4.": LINX(62) = 8
    LIN(63) = "": LINX(63) = 8
    LIN(64) = "": LINX(64) = 8
    LIN(65) = "%I5%C0Shields %C1- The Shields pellet will protect you": LINX(65) = 33
    LIN(66) = "%C1from enemy fire for a limited period of time": LINX(66) = 8
    LIN(67) = "%C1within a level. When you have shields, you can": LINX(67) = 8
    LIN(68) = "%C1note the strength by looking at the bar next": LINX(68) = 8
    LIN(69) = "%C1to the score. This bar will only appear when": LINX(69) = 8
    LIN(70) = "%C1you have shields. If you are hit by enemy fire,": LINX(70) = 8
    LIN(71) = "%C1it reduces your shields 25 percent. If you": LINX(71) = 8
    LIN(72) = "%C1collide with an enemy, your shields are removed.": LINX(72) = 8
    LIN(73) = "": LINX(73) = 8
    LIN(74) = "": LINX(74) = 8
    LIN(75) = "%I6%C0Pod %C1- When you pick up Pod pellet, you": LINX(75) = 33
    LIN(76) = "%C1will have a ""helper"" that will follow your ship.": LINX(76) = 8
    LIN(77) = "%C1It has the same weapons as your ship and is": LINX(77) = 8
    LIN(78) = "%C1almost insdestructable. The pod itself is not": LINX(78) = 8
    LIN(79) = "%C1affected when hit by enemy fire or collisions": LINX(79) = 8
    LIN(80) = "%C1with the ground. The only way you can lose ": LINX(80) = 8
    LIN(81) = "%C1your pod is if your main ship is hit by enemy": LINX(81) = 8
    LIN(82) = "%C1fire.": LINX(82) = 8
    LIN(83) = "": LINX(83) = 8
    LIN(84) = "": LINX(84) = 8
    LIN(85) = "%I7%C0Bomb %C1- You can collect the bomb pellet by": LINX(85) = 33
    LIN(86) = "%C1destroying various ground enemies. You can": LINX(86) = 8
    LIN(87) = "%C1hold a maximum of 5 bombs.": LINX(87) = 8
    LIN(88) = "": LINX(88) = 8
    LIN(89) = "%C1There are various ways you can lose your": LINX(89) = 8
    LIN(90) = "%C1ship. If you move your ship and collide with the": LINX(90) = 8
    LIN(91) = "%C1ground, you will automatically die. If you have": LINX(91) = 8
    LIN(92) = "%C1the standard weapon configuration and you are": LINX(92) = 8
    LIN(93) = "%C1hit by an enemy fire, you will lose your life. If": LINX(93) = 8
    LIN(94) = "%C1you have collected several pellets, every enemy": LINX(94) = 8
    LIN(95) = "%C1fire that hits you will decrease your strength.": LINX(95) = 8
    LIN(96) = "": LINX(96) = 8
    LIN(97) = "%C2Game Code": LINX(97) = 128
    LIN(98) = "": LINX(98) = 8
    LIN(99) = "%C1At the beginning of each level, you will notice a": LINX(99) = 8
    LIN(100) = "%C1code at the bottom of the level intro screen.": LINX(100) = 8
    LIN(101) = "%C1This code allows you to restore your game at": LINX(101) = 8
    LIN(102) = "%C1the level at a later time. If you died at Level": LINX(102) = 8
    LIN(103) = "%C13, and you did not want to start the game from": LINX(103) = 8
    LIN(104) = "%C1the beginning, you can use the game code. By": LINX(104) = 8
    LIN(105) = "%C1selecting the Continue option in the Main Menu": LINX(105) = 8
    LIN(106) = "%C1and typing in your game code for the desired": LINX(106) = 8
    LIN(107) = "%C1level, you can restore your game from the": LINX(107) = 8
    LIN(108) = "%C1beginning of that particular level.": LINX(108) = 8
    LIN(109) = "": LINX(109) = 8
    LIN(110) = "%C1NOTE: Game codes have a random factor added": LINX(110) = 8
    LIN(111) = "%C1to them for encryption purposes. There are": LINX(111) = 8
    LIN(112) = "%C1many game codes for the same game state, so": LINX(112) = 8
    LIN(113) = "%C1don't be surprised when it changes.": LINX(113) = 8
    LIN(114) = "": LINX(114) = 8
    LIN(115) = "%C2Restarting a Level": LINX(115) = 100
    LIN(116) = "": LINX(116) = 8
    LIN(117) = "%C1During the game you can restart the level by": LINX(117) = 8
    LIN(118) = "%C1pressing ESC and then pressing the F10 key.": LINX(118) = 8
    LIN(119) = "%C1This will restore the game from beginning": LINX(119) = 8
    LIN(120) = "%C1of the current level. It resets the weapons,": LINX(120) = 8
    LIN(121) = "%C1number of lives, bombs and score. This acts": LINX(121) = 8
    LIN(122) = "%C1like a quick game code and functions very": LINX(122) = 8
    LIN(123) = "%C1similary. Simply put, it places the game back": LINX(123) = 8
    LIN(124) = "%C1to the stage it was at the very first time you": LINX(124) = 8
    LIN(125) = "%C1reached the level.": LINX(125) = 8
  else
    ' ******************* Texto da opÁ„o *********************
    LineCNT = 78
    LIN(0) = "%C2Time of the Xatax...": LINX(0) = 102
    LIN(1) = "": LINX(1) = 8
    LIN(2) = "%C1No one know how or when the Xatax was": LINX(2) = 8
    LIN(3) = "%C1created or from where it comes. The": LINX(3) = 8
    LIN(4) = "%C1importance of these issues have been minimized": LINX(4) = 8
    LIN(5) = "%C1since the beginning of the destruction of the": LINX(5) = 8
    LIN(6) = "%C1Alliance. The primary concern is survival. With": LINX(6) = 8
    LIN(7) = "%C1only seven of the hundred plus guilds in the": LINX(7) = 8
    LIN(8) = "%C1Alliance remaining, hope seems to be fading as": LINX(8) = 8
    LIN(9) = "%C1consumption draws near.": LINX(9) = 8
    LIN(10) = "": LINX(10) = 8
    LIN(11) = "%C1Since the end of the interguild War, in the": LINX(11) = 8
    LIN(12) = "%C1early 2200's, peace has reigned for over two": LINX(12) = 8
    LIN(13) = "%C1hundred years. Our leaders said we would never": LINX(13) = 8
    LIN(14) = "%C1need our weapons again... they said if we": LINX(14) = 8
    LIN(15) = "%C1removed the means to make war, then there": LINX(15) = 8
    LIN(16) = "%C1would be no more wars... they said all of": LINX(16) = 8
    LIN(17) = "%C1these things, and now they are dead": LINX(17) = 8
    LIN(18) = "": LINX(18) = 8
    LIN(19) = "%C1We were so foolish. Time grows short!": LINX(19) = 8
    LIN(20) = "": LINX(20) = 8
    LIN(21) = "%C1I will say what i know about the Xatax, but": LINX(21) = 8
    LIN(22) = "%C1that knowledge is limited and comes from the": LINX(22) = 8
    LIN(23) = "%C1few that have survived and the guilds that": LINX(23) = 8
    LIN(24) = "%C1were consumed. Like lambs to the slaughter,": LINX(24) = 8
    LIN(25) = "%C1defenseless and naive, we stood by and allowed": LINX(25) = 8
    LIN(26) = "%C1the Xatax to consume guild after guild.": LINX(26) = 8
    LIN(27) = "": LINX(27) = 8
    LIN(28) = "%C1Contact was first made with the Xatax in the": LINX(28) = 8
    LIN(29) = "%C1year 2437 by an intergalactic exploration": LINX(29) = 8
    LIN(30) = "%C1craft from the Ventoran Guild. We welcomed": LINX(30) = 8
    LIN(31) = "%C1and embraced the Xatax, anxious to have it": LINX(31) = 8
    LIN(32) = "%C1join the Alliance. Little did we know that the": LINX(32) = 8
    LIN(33) = "%C1Xatax does not care about alliances, peace or": LINX(33) = 8
    LIN(34) = "%C1even war... all it does is consume... al it cares": LINX(34) = 8
    LIN(35) = "%C1about is consumption.": LINX(35) = 8
    LIN(36) = "": LINX(36) = 8
    LIN(37) = "%C1The ventorians were the third guild to fall,": LINX(37) = 8
    LIN(38) = "%C1first were the Deagonions, next the": LINX(38) = 8
    LIN(39) = "%C1Tyroplians, and the consumption continued. The": LINX(39) = 8
    LIN(40) = "%C1Xatax swept across our galaxy, consuming and": LINX(40) = 8
    LIN(41) = "%C1mutating with each guild that stood in its way.": LINX(41) = 8
    LIN(42) = "%C1It stripped the planets of all theis useful": LINX(42) = 8
    LIN(43) = "%C1resources, leaving only a wasteland from a": LINX(43) = 8
    LIN(44) = "%C1bountifil world. No one knows for sure what": LINX(44) = 8
    LIN(45) = "%C1happened to the inhabitants, all we know is": LINX(45) = 8
    LIN(46) = "%C1that with each fallen guild, the Xatax changed.": LINX(46) = 8
    LIN(47) = "": LINX(47) = 8
    LIN(48) = "%C1The Xatax mutates in a sense, creating new": LINX(48) = 8
    LIN(49) = "%C1warriors out of the minds of the people. The": LINX(49) = 8
    LIN(50) = "%C1new creatures seem to represent thing from": LINX(50) = 8
    LIN(51) = "%C1history, technology, and even the imagination": LINX(51) = 8
    LIN(52) = "%C1of the guilds, Making it twisted, in a warped": LINX(52) = 8
    LIN(53) = "%C1and unconscionable fashion.": LINX(53) = 8
    LIN(54) = "": LINX(54) = 8
    LIN(55) = "%C1Where does the endless consumption of Xatax": LINX(55) = 8
    LIN(56) = "%C1come from? it appears to be nothing more than": LINX(56) = 8
    LIN(57) = "%C1huge cylindrical metal drums. Our scientists": LINX(57) = 8
    LIN(58) = "%C1suspect that the Xatax creates these drums": LINX(58) = 8
    LIN(59) = "%C1out of the minerals from the destroyed guilds.": LINX(59) = 8
    LIN(60) = "%C1It stores and later processes these minerals": LINX(60) = 8
    LIN(61) = "%C1into more bio-mechanical creatures. How can we": LINX(61) = 8
    LIN(62) = "%C1stop this thing! Its unyielding hunger seems": LINX(62) = 8
    LIN(63) = "%C1insatiable. With no emotion, no thought, just": LINX(63) = 8
    LIN(64) = "%C1pure desire to consume.": LINX(64) = 8
    LIN(65) = "": LINX(65) = 8
    LIN(66) = "%C1What is the bio-mechanical nature of the": LINX(66) = 8
    LIN(67) = "%C1Xatax? While i cannot confirm this, i fell that": LINX(67) = 8
    LIN(68) = "%C1the Xatax uses the living portions of a planet": LINX(68) = 8
    LIN(69) = "%C1just like it does the minerals... it uses them to": LINX(69) = 8
    LIN(70) = "%C1grow.": LINX(70) = 8
    LIN(71) = "": LINX(71) = 8
    LIN(72) = "%C1I am now about to embark upon that will most": LINX(72) = 8
    LIN(73) = "%C1likely be a suicide mission. As the remaining": LINX(73) = 8
    LIN(74) = "%C1guilds evacuate their planets, i have been": LINX(74) = 8
    LIN(75) = "%C1chosen to go forth to try and stop the": LINX(75) = 8
    LIN(76) = "%C1mindless destruction of our worlds. I will fly": LINX(76) = 8
    LIN(77) = "%C1the X72, a two hundred year old fighter": LINX(77) = 8
    LIN(78) = "%C1ressurrected by our scientists from the": LINX(78) = 8
    LIN(79) = "%C1interguild Museum located on Terra. Our": LINX(79) = 8
    LIN(80) = "%C1scientists have modified this perfectly": LINX(80) = 8
    LIN(81) = "%C1preserved fighter to mimic Xatax's own": LINX(81) = 8
    LIN(82) = "%C1characteristic of consumption. The revived X72": LINX(82) = 8
    LIN(83) = "%C1has limited ability to consume and gain power": LINX(83) = 8
    LIN(84) = "%C1as it battles forward.": LINX(84) = 8
    LIN(85) = "": LINX(85) = 8
    LIN(86) = "%C1If any life form is able to extract this": LINX(86) = 8
    LIN(87) = "%C1information from this drone, heed this warning!": LINX(87) = 8
    LIN(88) = "": LINX(88) = 8
    LIN(89) = "%C2...end data upload, authority Krozious One.": LINX(89) = 24
  end if
  for COUNT = 0 to 125
    if LINX(COUNT) > 80 then LINX(COUNT) -= 32 else LINX(COUNT) -= 6
  next COUNT
  
  #ifdef __FB_NDS__
  OldScr = gfx.scr: NewScr = ImageCreate(256,192)  
  #endif
  
  '******************* Captura Gr·ficos e talz ******************
  line(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 192
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1+rnd*6
  next COUNT
  ICONS = ImageLoad("Graph/Inticos.bmp")    
  bload "Graph/Menue.bmp",TEMP,ORGPAL    
  palfade ORGPAL,0,0,255  
  screenlock  
  for CNT as integer = 0 to 1
    TextSwap = CNT
    #ifdef __FB_NDS__
    if CNT = 0 then      
      gfx.ScrPtr = OldScr+1: gfx.Scr = OldScr: PAGPTR = gfx.ScrPtr
    else
      gfx.ScrPtr = NewScr+1: gfx.Scr = NewScr: PAGPTR = gfx.ScrPtr
    end if
    #ifdef RenderOpenGL      
    scrbuff = gfx.scr
    #endif
    #endif
    
    put scrbuff,(0,0),TEMP,pset
    line scrbuff,(0,187-8)-(255,199-8),0,bf
    DrwText "Use ÄÅ PgUp/PgDn to view ESC when done.",1,191-8,0,scrbuff
    for X=MOST to 11
      COMANDO = instr(1,LIN(X),"%")
      ATUCHAR = 1
      PXT = LINX(X)
      while COMANDO
        SABER = COMANDO
        if LIN(X)[SABER] = asc("C") then
          IMPRIMIR = mid$(LIN(X),ATUCHAR,COMANDO-ATUCHAR)
          PXT += drwtranstext(IMPRIMIR,PXT,38+(10*X),LINC(X),-1,scrbuff)
          LINC(X) = valint(mid$(LIN(X),SABER+2,1))
          ATUCHAR = SABER + 3
          COMANDO = instr(SABER+3,LIN(X),"%")
        end if
      wend
      IMPRIMIR = mid$(LIN(X),ATUCHAR,COMANDO-ATUCHAR)
      PXT += drwtranstext(IMPRIMIR,PXT,38+(10*X),LINC(X),-1,scrbuff)
    next X
  next CNT
  screenunlock
  TextSwap = 1:SwapCNT = 2  
  ' ********************* InÌcio do loop de fade *************  
  FADE = 1
  FADESPD = 1
  do    
    palfade ORGPAL,FADE,0,255    
    screenlock
    
    #ifdef __FB_NDS__
    if TextSwap then
      gfx.ScrPtr = OldScr+1: gfx.Scr = OldScr: PAGPTR = gfx.ScrPtr
    else
      gfx.ScrPtr = NewScr+1: gfx.Scr = NewScr: PAGPTR = gfx.ScrPtr
    end if
    #ifdef RenderOpenGL      
    scrbuff = gfx.scr
    #endif
    #endif
    
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15      
    end if
    TECLA = inkey$
    COUNT =0
    if len(TECLA) then
      if (TECLA[1] = fb.SC_UP or TECLA[1] = fb.SC_BUTTONUP) and MOST>0 then 
        MOST = MOST - 1:COUNT =-1
      elseif (TECLA[1] = fb.SC_DOWN or TECLA[1] = fb.SC_BUTTONDOWN) and MOST<LineCNT then 
        MOST = MOST + 1:COUNT =-1
      elseif (TECLA[1] = fb.SC_PAGEUP or TECLA[1] = fb.SC_BUTTONL) and MOST>0 then
        MOST = MOST - 11
        if MOST < 0 then MOST = 0
        COUNT =-1
      elseif (TECLA[1] = fb.SC_DOWN or TECLA[1] = fb.SC_BUTTONR) and MOST<LineCNT then
        MOST = MOST + 11
        if MOST > LineCNT then MOST = LineCNT
        COUNT =-1
      end if
    end if
    TEXTSWAP xor= 1
    if COUNT = -1 then SwapCNT=0
    if SwapCNT < 2 then COUNT = -1
    if COUNT then
      SwapCNT += 1
      '********************** Atualiza Tela (cursor) ******************
      #ifdef DmaCopy
      dim as any ptr PagArea = TEMP+sizeof(fb.image)+(28*256)
      DC_FlushRange(PagArea, 256*130)
      DmaCopy(PagArea,PAGPTR+28*256,256*130)
      #else
      put scrbuff,(0,38),TEMP,(0,28)-(255,28+130),pset
      #endif
      'line(0,187-8)-(255,199-8),0,bf
      'DrwTransText "Use ÄÅ PgUp/PgDn to view ESC when done.",4,191-8,0
      for X=MOST to 11+MOST
        COMANDO = instr(1,LIN(X),"%")
        ATUCHAR = 1
        PXT = LINX(X)
        while COMANDO
          SABER = COMANDO
          if LIN(X)[SABER] = asc("C") then
            IMPRIMIR = mid$(LIN(X),ATUCHAR,COMANDO-ATUCHAR)
            PXT += drwtranstext(IMPRIMIR,PXT,38+(10*(X-MOST)),LINC(X),-1,scrbuff)
            LINC(X) = valint(mid$(LIN(X),SABER+2,1))
            ATUCHAR = SABER + 3
            COMANDO = instr(SABER+3,LIN(X),"%")
          end if
          if LIN(X)[SABER] = asc("I") then
            IMAGEM = valint(mid$(LIN(X),SABER+2,1))            
            put scrbuff,(4,40+(10*(X-MOST-1))),ICONS,(0,(IMAGEM-1)*16)-(18,(IMAGEM-1)*16+14),trans
            if X=MOST then line(4,29)-(23,37),0,bf
            ATUCHAR = SABER + 3
            COMANDO = instr(SABER+3,LIN(X),"%")
          end if
        wend
        IMPRIMIR = mid$(LIN(X),ATUCHAR,COMANDO-ATUCHAR)
        PXT += drwtranstext(IMPRIMIR,PXT,38+(10*(X-MOST)),LINC(X),-1,scrbuff)
      next X      
      for COUNT = 0 to 50
        if STY(COUNT) >= 38 and STY(COUNT) <= (38+120) then STA(COUNT) = 0
      next COUNT
    end if
    if len(TECLA) then
      if TECLA[1] = asc("k") then end
      if TECLA[0] = 27 then FADESPD = -1
      if TECLA[1] = fb.SC_BUTTONSTART then FADESPD = -1
      if TECLA[1] = fb.SC_BUTTONB then FADESPD = -1    
    end if
    if SwapCNT = 2 then
      for COUNT=0 to 50      
        STNX = STX(COUNT) - STS(COUNT)
        if STNX<0 then STNX = 255      
        if STA(COUNT) and STX(COUNT)<>STNX then
          STA(COUNT) = 0
          PAGPTR = OldScr+1:pset8(STX(COUNT),STY(COUNT),0)
          PAGPTR = NewScr+1:pset8(STX(COUNT),STY(COUNT),0)
        end if
        dim as integer A,B
        PAGPTR = OldScr+1: A = point8(STNX,STY(COUNT))
        PAGPTR = NewScr+1: B = point8(STNX,STY(COUNT))        
        if A=0 and B=0 then
          PAGPTR = OldScr+1:pset8(STNX,STY(COUNT),STC(COUNT))
          PAGPTR = NewScr+1:pset8(STNX,STY(COUNT),STC(COUNT))
          STA(COUNT) = 1
        end if
        STX(COUNT)=STNX
      next COUNT
    end if
    #ifdef __FB_NDS__
    PAGPTR = gfx.ScrPtr
    #else
    PAGPTR = screenptr
    #endif
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif    
    sync  
    
  loop until FADE < 2 andalso TextSwap
  
  screenlock
  #ifdef __FB_NDS__
  gfx.ScrPtr = OldScr+1: gfx.Scr = OldScr:
  PAGPTR = gfx.ScrPtr:ImageDestroy(NewScr)
  #ifdef RenderOpenGL      
  ScrBuff = gfx.scr    
  #endif
  #endif
  ImageDestroy(ICONS):ICONS=0:NewScr=0
  screenunlock
end sub

' ******************************************************************
' ********************* SUB QUE ESCREVE NA TELA ********************
' ******************************************************************

sub drawnumber (NUMERO as integer,POSX as integer,POSY as integer,Target as any ptr=0)
  dim SNUM as string, CHAR as ubyte
  SNUM = str$(NUMERO)
  for COUNT = 0 to len(SNUM)-1
    CHAR = SNUM[COUNT]
    if CHAR>47 and CHAR<58 then
      put Target,(POSX,POSY),NUMS(CHAR-48),pset
    end if
    POSX=POSX+8
  next COUNT
end sub

' ********************************************************************
' ******************** Intro - Time of the xatax *********************
' ********************************************************************

sub showintrot ( )  
  ShowIntroP(1)  
end sub

' ********************************************************************
' *************************** Menu Continue **************************
' ********************************************************************

function showcontinue() as integer    
  dim FADESPD as short,PAG as integer
  dim MCUR as integer, NTCL as integer
  dim PXT as integer, CUR as short,KeyShow as short
  dim DIMIN as integer, CTAM as integer  
  dim as string TECLA,TMPCODE
  dim as any ptr CUCOL',CT(2),
  
  ' ****************** Captura Gr·ficos *************  
  screenlock
  line(0,0)-(255,191),0,bf:screensync
  TMPCODE = CODE
  for COUNT=0 to 50
    STX(COUNT) = rnd * 255
    STY(COUNT) = rnd * 191
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1 + rnd * 6
  next COUNT
  'CT(1) = ImageLoad("Graph/Cont1.bmp") ',@CT(1,0),HIDPAL
  'CT(2) = ImageLoad("Graph/Cont0.bmp") ',@CT(2,0),HIDPAL
  bload "Graph/Menue.bmp",TEMP,ORGPAL
  'palget @ORGPAL,0,255
  palfade ORGPAL,0,0,255
  
  ' ***************** Tela Principal *****************
  put scrbuff,(0,0),TEMP,pset
  line scrbuff,(0,183)-(255,191),0,bf
  'put(27,191),CT(1),trans
  drwtranstext "Enter a game code press ESC to cancel.",4,183,0,,scrbuff
  DrwBigTTxt 4,50,"Continue",,scrbuff
  drwtranstext "Type the code to continue your game:",10,76,1,,scrbuff
  drwtranstext "(Note: You are given a game code at",17,116,1,,scrbuff
  drwtranstext "the beginning of each level)",42,126,1,,scrbuff
  #ifdef __FB_NDS__
  put TEMP,(0,0),scrbuff,pset
  #else
  get (0,0)-(255,191),TEMP
  #endif
  PXT = drwtranstext(TMPCODE,0,0,3,,scrbuff)
  CUR = PXT shr 1    
  drwtranstext TMPCODE,128-CUR,100,2,,scrbuff
  CUCOL = ImageCreate(1,6)  
  screenunlock
  FADE = 1:FADESPD = 1:MCUR = 1:DIMIN = 0
  
  while len(Inkey$)
    rem
  wend
  #ifdef __FB_NDS__
  lcdMainOnTop()
  #endif
  
  do
    screenlock
    MCUR = (MCUR + 1) and 31
    if MCUR < 16 then
      put scrbuff,(129+CUR,99),TEMP,(47,16)-(47,24),pset
    else
      put scrbuff,(129+CUR,99),TEMP,(129+CUR,100)-(129+CUR,108),pset
    end if
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15
    end if
    TECLA = inkey$
    if FADESPD > -1 then
      COUNT = 0
      CTAM = len(TMPCODE)
      if CTAM < 13 then
        if len(TECLA) andalso TECLA[0] > 31 and TECLA[0] <= 127 then 
          TMPCODE += ucase$(TECLA):COUNT = -1
        end if
      end if
      if CTAM > 0 then
        if len(TECLA) andalso TECLA[0] = 8 then 
          TMPCODE = left$(TMPCODE,len(TMPCODE)-1)
          COUNT = -1
        end if
      end if    
      if COUNT then
        ' *********** Altera Cursor **************
        put scrbuff,(0,99),TEMP,(0,99)-(255,107),pset
        PXT = drwtranstext(TMPCODE,0,0,3,,scrbuff)
        CUR = PXT shr 1
        drwtranstext(TMPCODE,128-CUR,100,2,,scrbuff)
        for COUNT=0 to 50
          if STY(COUNT) >=100 and STY(COUNT) <= 106 then STA(COUNT) = 0
        next COUNT        
      end if
    end if
    if len(TECLA) then
      if TECLA[1] = asc("k") then end
      if TECLA[0] = 27 or TECLA[1] = fb.SC_BUTTONSTART or TECLA[1] = fb.SC_BUTTONB then 
        FADESPD = -1: showcontinue = 0        
      end if    
      if TECLA[0] = 13 or TECLA[1] = fb.SC_BUTTONSELECT or TECLA[1] = fb.SC_BUTTONA then 
        FADESPD = -1: showcontinue = -1: CODE=TMPCODE        
      end if
    end if
    
    #ifdef __FB_NDS__
    if FADESPD < 0 andalso KeyShow then      
      fb_HideKeyboard(): KeyShow = 0
    end if
    #endif
    
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT    
    palfade ORGPAL,FADE,0,255
    screenunlock
    FADE = FADE + FADESPD
    if FADE > 100 then 
      FADE = 100
      #ifdef __FB_NDS__
      if KeyShow = 0 then
        fb_ShowKeyboard():fb.KeyboardIsON = 1
        KeyShow = 1
      end if
      #endif
    end if
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif    

    sync
    
  loop until FADE < 1
  Line(0,0)-(255,191),0,bf:screensync
  #ifdef __FB_NDS__
  lcdMainOnBottom():fb.KeyboardIsON = 0
  #endif
  
end function

' ********************************************************************
' ************************** Setup Menu ******************************
' ********************************************************************

function showsetup () as integer
  dim as short ODIFF,FADESPD
  static as integer OPT=0
  dim as integer ARQDAT,PAG,UPCUR,TLNT
  dim as string TECLA,TMPCLA,TEXTO
  static as string MENU(4),DIFF(2)
  dim as integer DOPT(4)
  dim as any ptr CURSOR
  MENU(0) = "Difficulty"
  MENU(1) = "Config Sound"
  MENU(2) = "Sound Volume"
  MENU(3) = "Music Volume"
  MENU(4) = "Advanced"
  DIFF(0) = "Easy"
  DIFF(1) = "Normal"
  DIFF(2) = "Hard"  
  ' ********** Le Dados do arquivo Xatax.DAT ************
  ARQDAT = freefile
  open "Xatax.dat" for binary as #ARQDAT
  get #ARQDAT,1,*cptr(ubyte ptr,@ODIFF)
  get #ARQDAT,2,*cptr(ubyte ptr,@OTEMP)
  get #ARQDAT,3,*cptr(ubyte ptr,@OSOUND)
  get #ARQDAT,4,*cptr(ubyte ptr,@OMUSIC) 
  close #ARQDAT
  if ODIFF < 0 or ODIFF > 2 then ODIFF = 1
  if OTEMP < 0 or OTEMP > 1 then OTEMP = 1
  if OSOUND < 0 or OSOUND > 10 then OSOUND = 10
  if OMUSIC < 0 or OMUSIC > 10 then OMUSIC = 10
  #ifndef MySound
  DOPT(2)=1:DOPT(3)=1
  OMUSIC=0:OSOUND=0
  #endif
  #ifdef __FB_NDS__
  DOPT(1)=1:DOPT(4) = 1
  #endif
  ' **************** Capturando Gr·ficos ***************
  screenlock  
  line scrbuff,(0,0)-(255,191),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 255
    STY(COUNT) = rnd * 191
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1+rnd*6
  next COUNT
  CURSOR = ImageLoad("Graph/Menus.bmp")  
  bload "Graph/Menue.bmp",TEMP,ORGPAL
  palfade ORGPAL,0,0,255  
  screenunlock
  UPCUR = 1:FADE = 1:FADESPD = 1  
  ' **************** Loop De Fade *****************  
  do    
    screenlock
    palfade ORGPAL,FADE,0,255
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15
    end if
    TMPCLA = inkey$
    TECLA = ucase$(TMPCLA)
    if FADESPD > -1 then      
      ' ********* Detectando teclas de movimento do cursor ***********
      for COUNT = 0 to 4
        TLNT = (OPT+COUNT) mod 5
        if len(TECLA) then
          if TECLA[0] = ( MENU(TLNT)[0] and (not 32)) and DOPT(TLNT)=0 then
            OPT = TLNT:UPCUR = -1:exit for
          end if
        end if
      next COUNT
      if len(TMPCLA) then
        if TMPCLA[1] = fb.SC_UP or TMPCLA[1] = fb.SC_BUTTONUP then 
          dim as integer OldOpt = OPT
          do
            OPT -= 1: if OPT < 0 then OPT = OldOpt: exit do
          loop while DOPT(OPT)
          if OPT <> OldOpt then UPCUR = -1
        elseif TMPCLA[1] = fb.SC_DOWN or TMPCLA[1] = fb.SC_BUTTONDOWN then
          dim as integer OldOpt = OPT
          do
            OPT += 1: if OPT > 4 then OPT = OldOpt: exit do
          loop while DOPT(OPT)
          if OPT <> OldOpt then UPCUR = -1          
        end if
        if TMPCLA[1] = asc("k") then end
      end if
      
      dim as integer MX,MY,MB,CNOPT
      getmouse MX,MY,,MB
      if MB<>-1 and (MB and 1) then
        for CNOPT = 0 to 4
          if MX > 48 and MX < 192 then
            if MY > (51+CNOPT*20) and MY < (71+CNOPT*20) then
              if DOPT(CNOPT)=0 then
                if TouchDown=0 andalso OPT=CNOPT then TECLA = chr$(13)
                if OPT <> CNOPT then OPT=CNOPT:UPCUR=-1
                TouchBack = 0
                exit for
              end if
            end if
          end if
        next CNOPT
        if TouchDown=0 andalso TouchBack then
          TouchBack=0: SHOWSETUP=0: FADESPD = -1
        end if
        if CNOPT > 4 then TouchBack = 1
        if TouchDown=0 then TouchDown = 1
      else
        TouchDown = 0
      end if      
      
      if UPCUR then 
        ' *************** Atualizando Painel de setup ***************
        put scrbuff,(0,0),TEMP,pset
        line scrbuff,(0,183)-(255,191),0,bf
        DrwTransText "Use ÄÅ/ENTER to select, ESC to return.",4,183,0,,scrbuff
        DrwBigTTxt 4,54,"Setup",,scrbuff
        for COUNT = 0 to 4
          if OPT = COUNT then
            DrwBigTTxt 113-32,51+COUNT*20,"#1"+MENU(COUNT),,scrbuff
          else
            if DOPT(COUNT) then
              DrwBigTTxt 113-32,51+COUNT*20,"#3"+MENU(COUNT),,scrbuff
            else
              dim as string Temp 
              Temp = left$(MENU(COUNT),1)+"#2"+mid$(MENU(COUNT),2)
              DrwBigTTxt 113-32,51+COUNT*20,Temp,,scrbuff
            end if
          end if
        next COUNT
        put scrbuff,(85-32,50+20*OPT),CURSOR,trans        
        ' ***** Status OpÁ„o 0 *****
        TEXTO = DIFF(ODIFF):TLNT=0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGSPC(ASCTF(TEXTO[COUNT]))
        next COUNT
        if DOPT(0) then TEXTO = "#3"+TEXTO
        DrwBigTTxt (265-48)-(TLNT shr 1),51,TEXTO,,scrbuff
        ' ***** Status OpÁ„o 2 *****
        if OSOUND = 0 then 
          TEXTO = "Off"
        elseif OSOUND = 10 then
          TEXTO = "Max"
        else          
          TEXTO = str$(OSOUND*10)+"%"
        end if
        TLNT=0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGSPC(ASCTF(TEXTO[COUNT]))
        next COUNT
        if DOPT(2) then TEXTO = "#3"+TEXTO
        DrwBigTTxt (265-48)-(TLNT shr 1),91,TEXTO,,scrbuff
        ' ***** Status OpÁ„o 3 *****
        if OMUSIC = 0 then 
          TEXTO = "Off"
        elseif OMUSIC = 10 then
          TEXTO = "Max"
        else          
          TEXTO = str$(OMUSIC*10)+"%"
        end if
        TLNT=0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGSPC(ASCTF(TEXTO[COUNT]))
        next COUNT
        if DOPT(3) then TEXTO = "#3"+TEXTO
        DrwBigTTxt (265-48)-(TLNT shr 1),111,TEXTO,,scrbuff       
        for COUNT = 0 to 50
          STA(COUNT) = 0
        next COUNT        
        UPCUR = 0
      end if      
    end if
    if len(TMPCLA) then
      if TECLA[0] = 27 then FADESPD = -1: SHOWSETUP = 0
      if TECLA[1] = fb.SC_BUTTONB then FADESPD = -1: SHOWSETUP = 0
      if TECLA[1] = fb.SC_BUTTONSTART then FADESPD = -1: SHOWSETUP = 0
      #define QRet TECLA[0] = 13 or TECLA[1] = fb.SC_BUTTONA or TECLA[1] = fb.SC_BUTTONSELECT
      #define QLeft TECLA[1] = fb.SC_LEFT or TECLA[1] = fb.SC_BUTTONLEFT
      #define QRight TECLA[1] = fb.SC_RIGHT or TECLA[1] = fb.SC_BUTTONRIGHT
      if QRet or Qleft or Qright then        
        ' //////////// Atualizando OpÁıes \\\\\\\\\\\\\\\\
        if DOPT(OPT)=0 then
          select case OPT
          ' ******** AlteraÁ„o na dificuldade ***********
          case 0
            if QRet then
              ODIFF += 1:if ODIFF > 2 then ODIFF = 0
            end if
            if QLeft then
              if ODIFF > 0 then ODIFF -= 1
            end if
            if QRight then
              if ODIFF < 2 then ODIFF += 1
            end if
          case 1
            if QRet then
              SHOWSETUP=-1
              FADESPD=-1
            end if
            ' ******** AlteraÁ„o no volume do som ********
          case 2
            if QRet then
              OSOUND += 1:if OSOUND>10 then OSOUND=0
            elseif QLeft then
              if OSOUND > 0 then OSOUND -= 1
            elseif QRight then
              if OSOUND < 10 then OSOUND += 1
            end if
            ' ********** AlteraÁ„o no volume da m˙sica ********
          case 3
            if QRet then
              #ifdef MySound
              if OMUSIC = 0 then
                OMUSIC=1
                StartMusic(SS_INTRO)
              else
                OMUSIC += 1:if OMUSIC > 10 then OMUSIC = 0
              end if
              #endif            
              #ifdef Mysound
              if OMUSIC = 0 then
                StopMusic
              else
                if PLAYSONG then FSOUND_SetVolume(PLAYSONG,OMUSIC*25.5)
              end if
              #endif
            end if
            if QLeft then
              if OMUSIC > 0 then OMUSIC -= 1
              #ifdef Mysound
              if OMUSIC = 0 then
                StopMusic
              else
                if PLAYSONG then FSOUND_SetVolume(PLAYSONG,OMUSIC*25.5)
              end if
              #endif
            end if
            if QRight then
              #ifdef MySound
              if OMUSIC = 0 then
                OMUSIC = 1
                StartMusic(SS_INTRO)
              else
                if OMUSIC < 10 then OMUSIC += 1
              end if
              #endif
              
              #ifdef MySound            
              if PLAYSONG then FSOUND_SetVolume(PLAYSONG,(OMUSIC*25.5))
              #endif            
            end if
          case 4
            if QRet then
              SHOWSETUP = -1
              FADESPD = -1
            end if
          end select
        end if
        UPCUR = 1      
      end if
    end if
    ' **************** Movimento das Estrelas *****************
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif    
    sync
    
  loop until FADE < 1  
  
  ' ************ Gravando InformaÁıes no arquivo ****************
  ARQDAT = freefile
  open "Xatax.dat" for binary as #ARQDAT
  put #ARQDAT,1,cbyte(ODIFF)
  put #ARQDAT,2,cbyte(OTEMP)
  put #ARQDAT,3,cbyte(OSOUND)
  put #ARQDAT,4,cbyte(OMUSIC)
  close #ARQDAT
  
  ImageDestroy(CURSOR)
  Line(0,0)-(255,191),0,bf:screensync
  
end function

' ********************************************************************
' ************************ Setup Menu CARD ***************************
' ********************************************************************
#if 0
sub setupcard ()  
  dim as double BT,CT,FPTIM  
  dim as byte ORENDER,OSYNC,ODOUBLE,FADESPD
  static as integer OPT
  dim as integer ARQDAT,PAG,FPSMAX,FPAVERAGE
  dim as integer MAXCOUNT,UPCUR,TLNT,DOPT(4)
  dim as integer NUOPT
  dim as string TECLA,TEXTO,TMPCLA,MENU(4)
  dim as string RENDER(2),PRIORITY(2)
  dim as string SYNCD(7),DOUBLET(2)
  dim as any ptr CURSOR
  MENU(0)="Render":MENU(1)="Vsync":MENU(2)="Screensize"
  MENU(3)="Fullscreen":MENU(4)="Priority"
  RENDER(0)="Default":RENDER(1)="GDI":RENDER(2)="DirectX"
  SYNCD(0)="Vsync":SYNCD(1)="Vsync:Sleep":SYNCD(2)="Timer"
  SYNCD(3)="Timer:Sleep":SYNCD(4)="Sleep Time"
  SYNCD(5)="Vsync Time":SYNCD(6)="Just Sleep":SYNCD(7)="Auto"
  PRIORITY(0)="Idle":PRIORITY(1)="Normal":PRIORITY(2)="High"
  DOUBLET(0)="Normal":DOUBLET(1)="Double":DOUBLET(2)="Scale2x"
  
  ' *************** Lendo InformaÁıes do arquivo DAT *************
  ARQDAT = freefile
  open "Xatax.dat" for binary as #ARQDAT
  get #ARQDAT,5,ORENDER
  get #ARQDAT,6,OSYNC
  get #ARQDAT,7,ODOUBLE
  get #ARQDAT,8,OFULL
  get #ARQDAT,9,OPRIORITY
  close #ARQDAT  
  if ORENDER < 0 or ORENDER > 2 then ORENDER=0
  if OSYNC < 0 or OSYNC > 7 then OSYNC = 0
  if ODOUBLE < 0 or ODOUBLE > 2 then ODOUBLE = 0
  if OFULL < 0 or OFULL > 1 then OFULL=0
  if OPRIORITY < 0 and OPRIORITY > 2 then OPRIORITY=1
  #ifndef __FB_WIN32__
  DOPT(0)=1:DOPT(4)=0
  OPRIORITY=1:ORENDER=0
  #endif
  
  ' ***************** Capturando Gr·ficos ******************
  line(0,0)-(319,199),0,bf:screensync
  for COUNT=0 to 50
    STX(COUNT) = rnd * 320
    STY(COUNT) = rnd * 200
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1 + rnd * 6
  next COUNT  
  CURSOR = ImageLoad("Graph/Menus.bmp")  
  bload "Graph/Menue.bmp",TEMP,ORGPAL  
  palfade ORGPAL,0,0,255:NUOPT=5
  UPCUR = 1:FADE = 1:FADESPD = 1  
  
  ' ********************** Inicio do LooP FADE ****************
  do
    palfade ORGPAL,FADE,0,255
    'screenlock
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then
      PalRotate ORGPAL,1,8,15      
    end if
    TMPCLA = inkey$
    TECLA = ucase$(TMPCLA)
    if FADESPD > -1 then
      for COUNT = 1 to NUOPT-1
        TLNT = (OPT+COUNT) mod NUOPT
        if TECLA = ucase$(left$(MENU(TLNT),1)) and DOPT(TLNT)=0 then
          OPT = TLNT:UPCUR = -1:exit for
        end if
      next COUNT
      if mid$(TMPCLA,2,1) = "H" and OPT>0 then OPT = OPT - 1:UPCUR=-1
      if mid$(TMPCLA,2,1) = "P" and OPT<(NUOPT-1) then OPT = OPT + 1:UPCUR=-1
      if mid$(TMPCLA,2,1) = "k" then end
      if UPCUR then
        ' ****************** Atualizando Painel **************
        put(0,0),TEMP,pset
        line(0,187)-(319,199),0,bf
        DrwTransText "Use ÄÅ to select, then ENTER. Press ESC to return",2,192,0
        DrwBigTTxt 11,47,"Advanced"
        DrwBigTTxt 31,63,"Setup"        
        for COUNT = 0 to NUOPT-1
          if OPT = COUNT then
            DrwBigTTxt 123,55+COUNT*20,"#1"+MENU(COUNT)
          else
            if DOPT(COUNT) then
              DrwBigTTxt 123,55+COUNT*20,"#3"+MENU(COUNT)
            else
              DrwBigTTxt 123,55+COUNT*20,left$(MENU(COUNT),1)+"#2"+mid$(MENU(COUNT),2)
            end if
          end if
        next COUNT        
        put(95,54+20*OPT),CURSOR,trans
        ' ****** OpÁ„o 1 *******
        TEXTO = RENDER(ORENDER):TLNT=0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGFONT(0,ASCTF(TEXTO[COUNT]),2)
        next COUNT
        if DOPT(0) then TEXTO = "#3"+TEXTO
        DrwBigTTxt 265-(TLNT shr 1),55,TEXTO
        ' ****** OpÁ„o 2 *******
        TEXTO = SYNCD(OSYNC):TLNT=0
        if OSYNC = 7 then TEXTO += "("+str$(SYNAUTO)+")"
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGFONT(0,ASCTF(TEXTO[COUNT]),2)
        next COUNT
        if DOPT(1) then TEXTO = "#3"+TEXTO
        DrwBigTTxt 265-(TLNT shr 1),75,TEXTO
        ' ***** OpÁ„o 3 ******
        TEXTO = DOUBLET(ODOUBLE)        
        TLNT = 0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGFONT(0,ASCTF(TEXTO[COUNT]),2)
        next COUNT
        if DOPT(2) then TEXTO = "#3"+TEXTO
        DrwBigTTxt 265-(TLNT shr 1),95,TEXTO
        ' ***** OpÁ„o 4 *****
        if OFULL then TEXTO = "Yes" else TEXTO = "No"
        TLNT = 0
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGFONT(0,ASCTF(TEXTO[COUNT]),2)
        next COUNT
        if DOPT(2) then TEXTO = "#3"+TEXTO
        DrwBigTTxt 265-(TLNT shr 1),115,TEXTO
        ' ***** OpÁ„o 5 *****
        TEXTO = PRIORITY(OPRIORITY):TLNT=0        
        for COUNT = 0 to len(TEXTO)-1
          TLNT += BIGFONT(0,ASCTF(TEXTO[COUNT]),2)
        next COUNT
        if DOPT(1) then TEXTO = "#3"+TEXTO
        DrwBigTTxt 265-(TLNT shr 1),135,TEXTO
        ' *** Clear Start Update ***
        for COUNT = 0 to 50
          STA(COUNT) = 0
        next COUNT        
        UPCUR = 0
      end if        
    end if
    if TECLA = chr$(27) then FADESPD = -1
    if TECLA = chr$(13) or mid$(TECLA,2,1)="K" or mid$(TECLA,2,1) ="M" then 
      
      ' ********************* Atualizando OpÁıes ******************
      if DOPT(OPT)=0 then
        select case OPT      
        ' ////////////////// Render Method \\\\\\\\\\\\\\\\\\\
        case 0
          COUNT = 0
          if TECLA = chr$(13) then
            ORENDER += 1:if ORENDER > 2 then ORENDER = 0
            COUNT = 1
          end if
          if mid$(TECLA,2,1)="K" then
            if ORENDER > 0 then ORENDER -= 1:COUNT = 1
          end if
          if mid$(TECLA,2,1)="M" then
            if ORENDER < 2 then ORENDER += 1:COUNT = 1
          end if
          if COUNT then
            'screenunlock
            if ORENDER = 0 then setenviron "fbgfx="
            if ORENDER = 1 then setenviron "fbgfx=gdi"
            if ORENDER = 2 then setenviron "fbgfx=Directx"
            screen 0
            sleep 1000,1
            screen 13+((DODOUBLE<>0) and 4),8,3,MYFLAGS or (GFX_FULLSCREEN and (OFULL<>0)),60
            if OFULL then sleep 1000,1
            for COUNT = 0 to 2
              screenset COUNT
              PAGZ(COUNT) = screenptr
            next COUNT
            screenset 0,2 and (ODOUBLE<>0)
            'screenlock
            UPCUR = 1
          end if
          
          ' ///////////////// MÈtodo de Sincronismo \\\\\\\\\\\\\\\\\
        case 1
          COUNT = 0
          if TECLA = chr$(13) and OSYNC = 7 then
            COUNT = 1:SYNAUTO=-1:UPCUR=1
          end if
          if mid$(TECLA,2,1)="K" then
            if OSYNC > 0 then OSYNC -= 1
            SYNCM = OSYNC:COUNT = 1:UPCUR=1
          end if
          if mid$(TECLA,2,1)="M" then
            if OSYNC < 7 then 
              OSYNC += 1:COUNT = 1:UPCUR=1
              SYNCM = OSYNC
            end if
          end if
          if COUNT and OSYNC = 7 and SYNAUTO > -1 then SYNCM = SYNAUTO
          
          ' /////////////// Autodetectando Melhor MÈtodo \\\\\\\\\\\\\\\\\
          if COUNT and OSYNC = 7 and SYNAUTO < 0 then          
            if DODOUBLE then DOUBLESCREEN
            for SYNCM = 5 to 3 step - 1
              FPS = 0
              BT = timer
              do
                SYNC
                FPS += 1
              loop until (timer-BT) >= 1
              if FPS > 52 and FPS < 75 then SYNAUTO=SYNCM:goto _SCDECSUCCESS_
            next SYNCM
            for SYNCM = 1 to -1 step -1
              if SYNCM =-1 then SYNCM = 2
              FPS = 0
              BT = timer
              do
                SYNC
              loop until (timer-BT) >= 1
              if FPS > 50 then SYNAUTO=SYNCM:goto _SCDECSUCCESS_
            next SYNCM
            SYNCM = 6
            _SCDECSUCCESS_:
          end if
          
          ' //////////////////// Double Screen \\\\\\\\\\\\\\\\\\
        case 2
          COUNT = 0
          if TECLA = chr$(13) then            
            ODOUBLE += 1: if ODOUBLE = 3 then ODOUBLE = 0
            UPCUR=1
            if ODOUBLE <= 1 then COUNT = 2 else COUNT = 1
          end if
          if mid$(TECLA,2,1)="K" then
            if ODOUBLE > 0 then 
              if ODOUBLE = 1 then COUNT = 2 else COUNT = 1
              ODOUBLE -= 1:UPCUR=1
            end if
          end if
          if mid$(TECLA,2,1)="M" then
            if ODOUBLE < 2 then
              if ODOUBLE = 0 then COUNT = 2 else COUNT = 1
              ODOUBLE += 1:UPCUR=1
            end if
          end if
          if COUNT then
            'screenunlock
            DODOUBLE = ODOUBLE
            if COUNT = 2 then 
              screen 0
              sleep 1000,1
              screen 13+((DODOUBLE<>0) and 4),8,3,MYFLAGS or (GFX_FULLSCREEN and (OFULL<>0)),60              
              if OFULL then sleep 1000,1
            end if
            for COUNT = 0 to 2
              screenset COUNT
              PAGZ(COUNT) = screenptr            
            next COUNT
            screenset 0,2 and (DODOUBLE<>0)
            'screenlock
          end if
          ' *********** FullScreen **********
        case 3
          COUNT = 0
          if TECLA = chr$(13) then
            OFULL = OFULL xor 1
            COUNT = 1
          elseif mid$(TECLA,2,1)="K" then
            if OFULL > 0 then OFULL=0:COUNT=1
          elseif mid$(TECLA,2,1)="M" then
            if OFULL < 1 then OFULL=1:COUNT=1
          end if
          if COUNT then
            'screenunlock
            UPCUR=1
            DODOUBLE = ODOUBLE
            screen 0
            sleep 1000,1
            screen 13+((DODOUBLE<>0) and 4),8,3,MYFLAGS or (GFX_FULLSCREEN and (OFULL<>0)),60
            if OFULL then sleep 1000,1
            for COUNT = 0 to 2
              screenset COUNT
              PAGZ(COUNT) = screenptr            
            next COUNT
            screenset 0,2 and (DODOUBLE<>0)
            'screenlock
          end if 
        case 4
          COUNT = 0
          if TECLA = chr$(13) then
            OPRIORITY = (OPRIORITY+1) mod 3
            COUNT = 1:UPCUR=1
          elseif mid$(TECLA,2,1)="K" then
            if OPRIORITY > 0 then OPRIORITY-=1:COUNT=1:UPCUR=1
          elseif mid$(TECLA,2,1)="M" then
            if OPRIORITY < 2 then OPRIORITY+=1:COUNT=1:UPCUR=1
          end if
          if COUNT then
            #ifdef __FB_WIN32__
            if OPRIORITY=0 then 
              SetPriorityClass(GetCurrentProcess(),IDLE_PRIORITY_CLASS)              
            elseif OPRIORITY=1 then
              SetPriorityClass(GetCurrentProcess(),NORMAL_PRIORITY_CLASS)
            else
              SetPriorityClass(GetCurrentProcess(),HIGH_PRIORITY_CLASS)
            end if
            #endif
          end if
        end select      
      end if
    end if
    
    
    ' *************** Estrelas ***************    
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 319
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset(STX(COUNT),STY(COUNT)),0
      end if
      if point(STNX,STY(COUNT))=0 then
        pset(STNX,STY(COUNT)),STC(COUNT)
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT
    
    ' ****************** Mostra FPS *******************
    FPSMAX += 1
    if abs(timer-CT)>.5 then            
      FPS=FPSMAX*2:FPSMAX=0
      CT = timer
    end if    
    line (0,0)-(32,10),0,bf
    DrwText str$(FPS),0,0,1
    'screenunlock
    if DODOUBLE then doublescreen
    sync
  loop until FADE < 1  
  
  ' **************** Salvando AlteraÁıes ***************
  ARQDAT = freefile
  open "Xatax.dat" for binary as #ARQDAT
  put #ARQDAT,5,ORENDER
  put #ARQDAT,6,OSYNC
  put #ARQDAT,7,ODOUBLE
  put #ARQDAT,8,OFULL
  put #ARQDAT,9,OPRIORITY
  close #ARQDAT
  Line(0,0)-(319,199),0,bf:screensync
end sub
#endif
' ******************************************************************
' *********************** High Scores Menu *************************
' ******************************************************************

sub highscores()
  dim as integer FADESPD,PAG,X,TAM,SCORE,ARQDAT
  dim NOME as zstring * 11
  dim as string TECLA,TMPCLA
  
  ' ******************** Capturando Gr·ficos ******************
  screenlock
  line(0,0)-(255,191),0,bf
  for COUNT=0 to 50
    STX(COUNT) = rnd * 256
    STY(COUNT) = rnd * 192
    STS(COUNT) = .1 + rnd * 1
    STA(COUNT) = 0
    STC(COUNT) = 1+rnd*6
  next COUNT
  bload "Graph/Menue.bmp",TEMP,ORGPAL  
  palfade ORGPAL,0,0,255
  put scrbuff,(0,0),TEMP,pset
  
  while len(inkey$)
    'nada
  wend
  
  ' ************** Mostrando atÈ 10 scores na tela *****************
  ARQDAT = freefile
  open "Xatax.dat" for binary access read as #ARQDAT
  get #ARQDAT,21,*cptr(ubyte ptr,strptr(NOME)),10
  get #ARQDAT,36,SCORE
  if SCORE > 0 then
    drwtranstext(NOME,16,49,1,,scrbuff)
    TAM = drwtranstext(str$(SCORE),0,0,3,,scrbuff)
    drwtranstext(str$(SCORE),240-TAM,49,1,,scrbuff)
  end if
  for X = 1 to 9
    get #ARQDAT,21+(X*19),*cptr(ubyte ptr,strptr(NOME)),10
    get #ARQDAT,36+(X*19),SCORE
    if SCORE > 0 then
      drwtranstext(NOME,16,49+(X*10),0,,scrbuff)
      TAM = drwtranstext(str$(SCORE),0,0,3,,scrbuff)
      drwtranstext(str$(SCORE),240-TAM,49+(X*10),0,,scrbuff)      
    end if
  next X
  close ARQDAT
  screenunlock
  FADE = 1
  FADESPD = 1  
  ' ******************* Inicio do Loop de FADE *****************
  do
    palfade ORGPAL,FADE,0,255
    screenlock
    FADE = FADE + FADESPD
    if FADE > 100 then FADE = 100
    PAG = 1-PAG
    if PAG = 0 then 
      PalRotate ORGPAL,1,8,15      
    end if
    TECLA = inkey$
    if len(TECLA)>1 and TMPCLA[1] = asc("k") then end
    if len(TECLA) then FADESPD = -1
    for COUNT=0 to 50
      STNX = STX(COUNT) - STS(COUNT)
      if STNX<0 then STNX = 255
      if STA(COUNT) and STX(COUNT)<>STNX then
        STA(COUNT) = 0
        pset8(STX(COUNT),STY(COUNT),0)
      end if
      if point8(STNX,STY(COUNT))=0 then
        pset8(STNX,STY(COUNT),STC(COUNT))
        STA(COUNT) = 1
      end if
      STX(COUNT)=STNX
    next COUNT
    screenunlock
    
    #ifdef RenderOpenGL      
    put(0,0),ScrBuff,pset
    flip
    #endif    
    sync
    
  loop until FADE < 1
  Line(0,0)-(255,191),0,bf:screensync
end sub

' ******************************************************************

function ImageLoad(FILENAME as string,BMPPAL as any ptr=0) as any ptr
  dim as integer HFILE,TX,TY,BPP,TMP
  dim as fb.image ptr TMPIMG
  HFILE = Freefile()    
  if open(FILENAME for binary as #HFILE) then
    #ifdef MyDebug
    print "ERROR: File Not Found "+FILENAME
    #endif      
    return 0
  end if    
  get #HFILE,19,TX
  get #HFILE,,TY
  get #HFILE,29,BPP
  close #HFILE
  TMPIMG = ImageCreate(TX,TY)
  if BMPPAL = 0 then BMPPAL = callocate(256*4):TMP=1
  if BMPPAL = cast(any ptr,-1) then
    bload FILENAME,TMPIMG
  else
    bload FILENAME,TMPIMG,BMPPAL
  end if
  if TMP=1 then deallocate(BMPPAL)
  return TMPIMG  
end function

' ***************************************************************************

function GetY(IDAD as any ptr) as integer
  if IDAD then
    if *cptr(ubyte ptr,IDAD) = 7 then
      return *(cptr(integer ptr,IDAD)+3)
    else
      return *(cptr(ushort ptr,IDAD)+1)
    end if
  end if
end function
function GetX(IDAD as any ptr) as integer
  if IDAD then
    if *cptr(ubyte ptr,IDAD) = 7 then
      return *(cptr(integer ptr,IDAD)+2)
    else
      return *(cptr(ushort ptr,IDAD)) shr 3
    end if
  end if
end function

sub GetMetric(IDAD as any ptr,byref TX as integer,byref TY as integer)
  if IDAD then
    if *cptr(ubyte ptr,IDAD) = 7 then    
      TX = *(cptr(integer ptr,IDAD)+2)
      TY = *(cptr(integer ptr,IDAD)+3)
    else
      TX = *(cptr(ushort ptr,IDAD)) shr 3
      TY = *(cptr(ushort ptr,IDAD)+1)
    end if
  else
    TX = 0:TY = 0
  end if
end sub

sub DrwBigOTxt(X as integer,Y as integer,TEXTO as string,FIXO as integer=0,Target as any ptr=0)
  dim as ubyte CHAR,SPAC,COR=0
  for COUNT as integer=0 to len(TEXTO)-1
    CHAR = TEXTO[COUNT]
    if CHAR<32 or CHAR>127 then CHAR = asc("?")
    if COR = 255 then
      COR = (CHAR-48) and 3
    elseif CHAR=32 then
      if FIXO then
        line Target,(X,Y)-(X+FIXO,Y+17),0,bf
        X += FIXO
      else
        line Target,(X,Y)-(X+5,Y+17),0,bf
        X += 5
      end if      
    elseif CHAR=35 then      
      COR = 255 
    else
      CHAR = ASCTF(CHAR):SPAC = BIGSPC(CHAR)
      dim as integer CX = (CHAR and 7) shl 4
      dim as integer CY = (CHAR shr 3) shl 4
      if FIXO>SPAC then
        line Target,(X,Y)-(X+FIXO,Y+17),0,bf
        put Target,(X+((FIXO-SPAC) shr 1),Y),BIGFONT(COR),(CX,CY)-(CX+SPAC-1,CY+15),pset 'FIXFIX
      else
        put Target,(X,Y),BIGFONT(COR),(CX,CY)-(CX+SPAC-1,CY+15),pset 'FIXFIX
      end if
      if FIXO then        
        X += FIXO
      else
        X += SPAC 
        line Target,(X,Y)-(X,Y+17),0,bf
        X += 1
      end if
    end if      
  next COUNT
end sub

sub DrwBigTTxt(X as integer,Y as integer,TEXTO as string,FIXO as integer=0,Target as any ptr=0)
  dim as short CHAR,SPAC,COR=0  
  for COUNT as integer=0 to len(TEXTO)-1
    CHAR = TEXTO[COUNT]
    if CHAR<32 or CHAR>127 then CHAR = asc("?")
    if COR = 255 then
      COR = (CHAR-48) and 3
    elseif CHAR=32 then
      if FIXO then        
        X += FIXO
      else        
        X += 5
      end if      
    elseif CHAR=35 then      
      COR = 255 
    else
      CHAR = ASCTF(CHAR):SPAC = BIGSPC(CHAR)
      dim as integer CX = (CHAR and 7) shl 4
      dim as integer CY = (CHAR shr 3) shl 4      
      if FIXO>SPAC then        
        put Target,(X+((FIXO-SPAC) shr 1),Y),BIGFONT(COR),(CX,CY)-(CX+15,CY+15),trans 'FIXFIX
      else
        put Target,(X,Y),BIGFONT(COR),(CX,CY)-(CX+SPAC-1,CY+15),trans 'FIXFIX
      end if
      if FIXO then        
        X += FIXO
      else
        X += SPAC+1
      end if
    end if      
  next COUNT
end sub

#ifdef MySound

sub StartMusic(MUSIC as integer)
  
  dim as string MYFILE
  
  select case MUSIC
  case SS_INTRO
    MYFILE = "Music/intro.wav"    
  case SS_E1P1
    MYFILE = "Music/epi1p1.wav"  
  case SS_E1P2
    MYFILE = "Music/epi1p2.wav"    
  case SS_E1BOSS
    MYFILE = "Music/epi1boss.wav"    
  end select    
  
  if PLAYSONG then
    FSOUND_StopSound(PLAYSONG)
    FSOUND_Sample_Free(SONGFILE)
  end if
  if OMUSIC = 0 then
    SONGFILE = 0
    PLAYSONG = 0
  else
    SONGFILE = FSOUND_Sample_Load(FSOUND_FREE,strptr(MYFILE),FSOUND_LOOP_NORMAL,0,0)
    PLAYSONG = FSOUND_PlaySound(FSOUND_FREE,SONGFILE)
    if PLAYSONG then FSOUND_SetVolume(PLAYSONG,OMUSIC*25.5)    
  end if  
  
end sub

sub StopMusic()
  FSOUND_StopSound(PLAYSONG)
  FSOUND_Sample_Free(SONGFILE)
  PLAYSONG = 0
  SONGFILE = 0
end sub

#endif

' ********************************************************************
' ************************* Sincronismo de fps ***********************
' ********************************************************************

sub MicroDelay(DELAY as integer,FORCED as integer=1)  
  for CNT as integer = 1 to DELAY
    sleep(0)
  next CNT
end sub

sub sync()  
  
  #ifdef __FB_NDS__
  screensync
  exit sub
  #else  
  SYNCM=4
  select case SYNCM
  case 0  
    MicroDelay(1)
    screensync
  case 1
    sleep 1
    screensync
  case 2  
    while (timer-ST) < 1/60
      MicroDelay(1)
    wend
    if (timer-ST) > 1/5 then
      ST = timer
    else
      ST += 1/60
    end if
  case 3  
    sleep 1
    while (timer-ST) < 1/70
    wend
    if (timer-ST) > 1/5 then
      ST = timer
    else
      ST += 1/70
    end if
  case 4      
    if abs(timer-ST) > 1 then ST=timer
    while (timer-ST) < 1/60
      sleep 1
    wend  
    ST = timer-((timer-ST)-(1/60))
    'while (timer-ST) < 1/60
    '  sleep 1
    'wend
    'ST = timer
  case 5  
    dim SYNCMM as integer
    SYNCMM =  15 - ((timer-ST)*1000)
    if SYNCMM < 0 then SYNCMM = 0
    if SYNCMM > 15 then SYNCMM = 15
    sleep SYNCMM shr 1
    screensync
    ST = timer
  case else
    MicroDelay(1)
    'sleep 1
  end select
  #endif
  
end sub

sleep