#ifdef __FB_NDS__
#define __FB_NITRO__
'#define __FB_PRECISE_TIMER__
#define __FB_GFX_NO_GL_RENDER__
#define __FB_GFX_NO_16BPP__
#define __FB_GFX_NO_OLD_HEADER__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#include "Modules\fmod.bas"
#else
width 32,24
chdir exepath+"/NitroFiles/"
#include "fbgfx.bi"
#include "fmod.bi"
#include "crt.bi"
#endif

type RGBPAL
  R as integer
  G as integer
  B as integer
end type
type PALCYC
  Reverse as byte
  Rate as integer
  Low as integer
  High as integer
  Count as single
end type

dim shared as string SPATH
dim shared as zstring ptr SCENE(...) = { _
@"V08AM"   ,@"V08.wav"     ,@"  Jungle Waterfall - Morning ", _
@"V29"     ,@"V29.wav"     ,@"        Seascape - Day       ", _
@"V19"     ,@"V19.wav"     ,@"  Mountain Stream - Morning  ", _
@"V26SNOW" ,@"V05RAIN.wav" ,@"     Winter Forest - Snow    ", _
@"V08RAIN" ,@"V08RAIN.wav" ,@"   Jungle Waterfall - Rain   ", _
@"V14"     ,@"V14.wav"     ,@"     Mountain Storm - Day    ", _
@"V30"     ,@"V30.wav"     ,@"       Deep Forest - Day     ", _
@"V04"     ,@"V04.wav"     ,@"     Highland Ruins - Rain   ", _
@"V07"     ,@"V07.wav"     ,@"       Rough Seas - Day      ", _
@"V20"     ,@"V20.wav"     ,@"      Crystal Caves - Day    ", _
@"V05RAIN" ,@"V05RAIN.wav" ,@" Haunted Castle Ruins - Rain ", _
@"V08PM"   ,@"V08.wav"     ,@"  Jungle Waterfall - Night   ", _
@"V16RAIN" ,@"V16RAIN.wav" ,@"      Mirror Pond - Rain     ", _
@"V19AURA" ,@"V19.wav"     ,@"   Mountain Stream - Night   ", _
@"CORAL"   ,@"CORAL.wav"   ,@"        Aquarius - Day       ", _
@"V15"     ,@"V15.wav"     ,@"     Harbor Town - Night     ", _
@"V30RAIN" ,@"V30RAIN.wav" ,@"      Deep Forest - Rain     ", _
@"V02"     ,@"V02.wav"     ,@"   Mountain Fortress - Dusk  ", _
@"V28"     ,@"V28.wav"     ,@"    Water City Gates - Fog   ", _
@"V29PM"   ,@"V29.wav"     ,@"       Seascape - Sunset     ", _
@"V16"     ,@"V16.wav"     ,@"     Mirror Pond - Morning   ", _
@"V01"     ,@"V29.wav"     ,@"      Island Fires - Dusk    ", _
@"V09"     ,@"V09.wav"     ,@"       Forest Edge - Day     ", _
@"V16PM"   ,@"V16.wav"     ,@"    Mirror Pond - Afternoon  ", _
@"V08"     ,@"V08.wav"     ,@" Jungle Waterfall - Afternoon", _
@"V03"     ,@"V03.wav"     ,@"    Swamp Cathedral - Day    ", _
@"V05HAUNT",@"V05HAUNT.wav",@" Haunted Castle Ruins - Night", _
@"V10"     ,@"V10.wav"     ,@"       Deep Swamp - Day      ", _
@"V11AM"   ,@"V02.wav"     ,@"    Approaching Storm - Day  ", _
@"V13"     ,@"V13.wav"     ,@"      Pond Ripples - Dawn    ", _
@"V17"     ,@"V17.wav"     ,@"        Ice Wind - Day       ", _
@"V19PM"   ,@"V19.wav"     ,@"  Mountain Stream - Afternoon", _
@"V25HEAT" ,@"V25HEAT.wav" ,@"    Desert Heat Wave - Day   ", _
@"V27"     ,@"V25HEAT.wav" ,@"   Magic Marsh Cave - Night  ", _
@"V29FOG"  ,@"V29.wav"     ,@"        Seascape - Fog       "}

dim shared as byte SMOOTH=1,OPT
dim MYPAL(255) as RGBPAL,MYCYC(15) as PALCYC
dim as double TMR,SPD=1,VOL=.5
dim as integer SCENEOFF,SCENENUM,SCENEMAX = (ubound(SCENE)\3)
dim as integer OffX,OffY,iZOOM=1,MaxX,MaxY,HoldX,HoldY
dim as integer MX,MY,MB,NX,NY,NB,BHold
dim shared as zstring ptr OnOff(1) = {@"Off",@"On "}

FSOUND_Init(44100,4,0)
screenres 256,192,8
SPATH = "Scenes/"

dim as fb.image ptr MyIMG2,MyIMG = ImageCreate(640,480)
dim as any ptr SmallA = ImageCreate(320,240)
dim as any ptr SmallB = ImageCreate(320,240)

do
  SCENEOFF = SCENENUM*3  
  dim as double TMRA,TMRB,TMRC
  
  scope 
    TMRA = timer
    dim as integer MYFILE = freefile()    
    bload SPATH+*SCENE(SCENEOFF)+".bmp",MyIMG,@MYPAL(0)
    if open(SPATH+*SCENE(SCENEOFF)+".pal" for binary access read as #MYFILE)=0 then
      get #MYFILE,1,MYPAL(0),256
      get #MYFILE,,MYCYC(0),16
      close #MYFILE
    end if
    TMRA = (timer-TMRA)*1000
    TMRB = timer
    dim as ubyte ptr pA = cast(any ptr,MyIMG+1)
    dim as ubyte ptr pB = SmallA+sizeof(fb.image)
    dim as ubyte ptr pC = SmallB+sizeof(fb.image)
    dim as integer X,Y
    for Y = 0 to 479
      if (Y and 1) then 
        for X = 1 to 639 step 2
          *pB = pA[X]: pB += 1
        next X
      else
        for X = 0 to 639 step 2
          *pC = pA[X]: pC += 1
        next X
      end if
      pA += 640
    next Y
    TMRB = (timer-TMRB)*1000
  end scope
  
  TMRC = timer
  dim as FSOUND_SAMPLE ptr SndMusic
  dim as integer MusicChan  
  SndMusic = FSOUND_Sample_Load(FSOUND_FREE,"Sound/"+*SCENE(SCENEOFF+1),FSOUND_NORMAL or FSOUND_LOOP_NORMAL,0,0)
  MusicChan = FSOUND_PlaySound(FSOUND_FREE,SndMusic)  
  line(0,0)-(255,191),0,bf
  for CNT as integer = 0 to 255
    with MYPAL(CNT)
      palette CNT,.R,.G,.B
    end with
  next CNT  
  TMRC = (timer-TMRC)*1000
  
  if iZoom then 
    OffX= 32:OffY= 24:MaxX= 64:Maxy= 48
  else
    OffX=192:OffY=144:MaxX=384:MaxY=288
  end if
  
  dim as double TMR = timer
  dim as integer FPS,Update = -1
  
  do  
    
    if Update then            
      Update = 0
      dim as string Temp = !"[------------------------------]\n"
      Temp[1+((SCENENUM*29)\SCENEMAX)]=asc("#")
      printf(!"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%s",Temp)      
      printf(!"Scenery Load: %04.3f ms\n",TMRA)
      printf(!"Image Resize: %04.3f ms\n",TMRB)
      printf(!"  Music Load: %04.3f ms\n\n",TMRC)
      Printf(!"[%s ]\n",SCENE(SCENEOFF+2))
      printf(!"Zoom: %s Smooth: %s Speed: %1.1f\n",OnOff(iZoom),OnOff(Smooth),SPD)      
      printf(!"           FPS: 60\r")
      if MusicChan then
        FSOUND_SetFrequency(MusicCHan,16000*SPD)
      end if
    end if
    
    screenlock
    
    for CNT as integer = 0 to 15
      dim as RGBPAL TMPATT
      with MYCYC(CNT)
        if .Low<>0 and .High<>0 and .Rate>0 then
          dim as integer VMAX = (.High-.Low)          
          .Count += iif(.Reverse,1,-1)*(.Rate/16384)*SPD
          if .Count < 0 then .Count += (VMAX)
          if .Count >= VMAX then .Count -= (VMAX)
          for ATT as integer = 0 to VMAX
            dim as single TMP = .Low+.Count+ATT
            dim as integer VLOW = .Low+ATT,TMP2 = int(TMP)+1
            if TMP>=.High then TMP-=(VMAX) else if TMP<.Low then TMP+=(VMAX)
            if TMP2>=.High then TMP2-=(VMAX) else if TMP2<.Low then TMP2+=(VMAX)
            with MYPAL(int(TMP))
              dim as integer RR,GG,BB
              dim as single PCT = TMP-int(TMP)
              if SMOOTH then
                RR = (.R*(1-PCT))+(MYPAL(TMP2).R*PCT)
                GG = (.G*(1-PCT))+(MYPAL(TMP2).G*PCT)
                BB = (.B*(1-PCT))+(MYPAL(TMP2).B*PCT)              
              else
                RR = .R:GG = .G: BB = .B
              end if
              Palette VLOW,RR,GG,BB
            end with
          next ATT        
        end if
      end with
    next CNT    
    
    if iZoom then
      static as short iSwap
      iSwap xor= 1: if iSwap then MyImg2 = SmallA else MyImg2 = SmallB
    else
      MyImg2 = MyImg
    end if
    
    put(-OffX,-OffY),MyImg2,pset
    #ifndef __FB_NDS__
    sleep 1,1
    #endif
    screensync
    
    screenunlock
    
    getmouse NX,NY,,NB
    if NB <> -1 then MX = NX: MY = NY: MB = NB
    
    if (MB and 1) then
      if BHold = 0 then
        BHold = 1: HoldX = MX: HoldY = MY
      else
        if HoldX <> MX or HoldY <> MY then
          OffX -= (MX-HoldX): OffY -= (MY-HoldY)
          if OffX < 0 then OffX = 0
          if OffY < 0 then OffY = 0
          if OffX > MaxX then OffX = MaxX
          if OffY > MaxY then OffY = MaxY
          HoldX = MX: HoldY = MY
        end if
      end if
    else
      if BHold = 1 then BHold = 0
    end if
    
    
    #ifdef __FB_NDS__      
    if multikey(FB.SC_ButtonA) then sleep 100,1
    #endif
    do
      dim as string KEY = inkey$
      if len(KEY) then        
        #ifdef __FB_NDS__      
        #define KeyNext()   KEY[1] = FB.SC_ButtonR or KEY[1] = FB.SC_ButtonDown
        #define KeyPrev()   KEY[1] = FB.SC_ButtonL or KEY[1] = FB.SC_ButtonUp
        #define VolUp()     0
        #define VolDown()   0
        #define SpdDown()   KEY[1] = FB.SC_ButtonLeft
        #define SpdUp()     KEY[1] = FB.SC_ButtonRight
        #define KeyExit()   0
        #define KeyZoom()   KEY[1] = FB.SC_ButtonStart or KEY[1] = FB.SC_ButtonX
        #define KeySmooth() KEY[1] = FB.SC_ButtonSelect or KEY[1] = FB.SC_ButtonY
        #else
        #define KeyNext()   KEY[1] = FB.SC_PAGEDOWN or KEY[1] = FB.SC_DOWN
        #define KeyPrev()   KEY[1] = FB.SC_PAGEUP or KEY[1] = FB.SC_UP
        #define VolUp()     KEY[0] = asc("=") or KEY[0] = asc("+")
        #define VolDown()   KEY[0] = asc("-") or KEY[0] = asc("_")
        #define SpdDown()   KEY[1] = FB.SC_LEFT
        #define SpdUp()     KEY[1] = FB.SC_RIGHT
        #define KeyExit()   KEY[0] = 27 or KEY[1] = asc("k")
        #define KeyZoom()   KEY[0] = 9
        #define KeySmooth() KEY[0] = 13
        #endif        
        if     KeyNext()   then
          if SCENENUM < SCENEMAX then SCENENUM += 1: exit do,do
        elseif KeyPrev()   then
          if SCENENUM > 0 then SCENENUM -= 1: exit do,do
        elseif VolUp()     then
          if VOL < 1 then VOL += .1: if VOL > 1 then VOL=1
        elseif VolDown()   then 
          if VOL > 0 then VOL -= .1: if VOL < 0 then VOL=0
        elseif SpdUp()     then
          if SPD < 4 then SPD += .1: Update = 1
        elseif SpdDown()   then
          if SPD > 1/4 then SPD -= .1: Update = 1
        elseif KeyExit()   then                
          exit do,do,do
        elseif KeyZoom()   then
          iZoom xor= 1: Update = 1
          if iZoom then 
            OffX= 32:OffY= 24:MaxX= 64:Maxy= 48
          else
            OffX=192:OffY=144:MaxX=384:MaxY=288
          end if        
        elseif KeySmooth() then        
          Smooth xor= 1: Update = 1        
        end if
      else
        exit do
      end if
    loop
    FPS += 1
    if (timer-TMR) >= 1 then
      printf(!"           FPS: %i \r",FPS): FPS = 0: TMR += 1
    end if
    
  loop  
  
  FSound_StopSound(MusicChan)  
  FSOUND_Sample_Free(SndMusic): SndMusic=0
  
loop

