#define fbc -s gui 
'Res/DuckHunt.rc

#define __FB_NITRO__
'#define __FB_FAT__

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#Include "Modules\fmod.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
#include "fmod.bi"
chdir "NitroFiles/"
#endif

#define SC2X_X 256
#define SC2X_Y 192

#ifdef __FB_NDS__
  #define bpp 8
  #define iScale 1
#else
  #define bpp 8
  #define iScale 2
#endif

#if iScale=2
  #include "MyTDT/Scale2x.bas"
  #include "hq2x.bi"
#endif
#ifdef __FB_WIN32__
#include "windows.bi"
#include "win\mmsystem.bi"
#include "debug.inc"
TimeBeginPeriod(0)
#endif

#if iScale=2
#if bpp=8
using bpp8
#else
using bpp16
#endif
#endif

const PI = atn(1)/45

dim shared as fb.image ptr Back1,Back2,Title,Grap,Buff,Pal,Ducks
dim shared as FSOUND_SAMPLE ptr sndBark,sndBegin,sndBegin2,sndCount,sndCrash,sndFall,sndFlap
dim shared as FSOUND_SAMPLE ptr sndLaugh,sndOver1,sndOver2,sndShot,sndThrow,sndTitle,sndTum
dim shared as FSOUND_SAMPLE ptr sndCatch,sndRound,sndGood

dim shared as integer iSound=1,iFull=0
dim shared as integer iMethod=iif(bpp=16,2,0),iVsync=1,iSleep=1,iForceUp=1
dim shared as integer iMX,iMY,iMB,iKey
dim shared as integer chShoot=-1
dim shared as string sTitle

#if iScale=1
iMethod=0
#endif
#ifdef __FB_NDS__
iSleep=0:iVsync=1
#endif

if FSOUND_Init(22050,8,FSOUND_INIT_GLOBALFOCUS or FSOUND_INIT_DONTLATENCYADJUST) = 0 then
  puts("Failed to INIT sound... proceeding without sound."): iSound=0
end if

' ************************** Constants *****************************
#if 1 
  ' ************************** Sound Constants *****************************
  const _Snd16Once_ = (FSOUND_NORMAL or FSOUND_LOOP_OFF)
  const _Snd16Loop_ = (FSOUND_NORMAL or FSOUND_LOOP_NORMAL)
  const _Snd8Once_  = (FSOUND_8BITS or FSOUND_UNSIGNED or FSOUND_MONO or FSOUND_LOOP_OFF)
  const _Snd8Loop_  = (FSOUND_8BITS or FSOUND_UNSIGNED or FSOUND_MONO or FSOUND_LOOP_NORMAL)
  
  ' *************************** Sound Macros *******************************
  #macro LoadGrap(pTarget,sName,iWidth,iHeight)
  pTarget = ImageCreate(iWidth,iHeight)
  if pTarget=0 then puts("Failed to Create Image :(")
  puts sName: bload sName,pTarget
  #endmacro
  #macro LoadSound(pTgt,sFile,iFmt)
  if iSound then 
    puts sFile: pTgt = FSOUND_Sample_Load(FSOUND_FREE,sFile,iFmt,0,0)
    if pTgt = 0 then puts("Failed to Load Sample :(")
  end if
  #endmacro
  ' ************************ Game Keys Mapping *****************************
  #ifdef __FB_NDS__  
    #define _KeyBack_ -fb.SC_ButtonB
    #define _KeyUP_   -fb.SC_ButtonUP
    #define _KeyDown_ -fb.SC_ButtonDown
    #define _KeyAct_  -fb.SC_ButtonA,-fb.SC_ButtonStart
  #else
    #define _KeyBack_ 27,-asc("k") 'ESC
    #define _KeyUP_   -fb.SC_UP    'UP
    #define _KeyDown_ -fb.SC_Down  'DOWN
    #define _KeyAct_  13           'ENTER
  #endif
#endif
scope ' ****************** Loading Sound Effects/Music *************************
  LoadSound(sndBark  ,"Sound/Bark.wav"  ,_Snd16Once_)
  LoadSound(sndBegin ,"Sound/Begin.wav" ,_Snd16Once_)
  LoadSound(sndBegin2,"Sound/Begin2.wav",_Snd16Once_)
  LoadSound(sndCatch ,"Sound/Catch.wav" ,_Snd16Once_)
  LoadSound(sndCount ,"Sound/Count.wav" ,_Snd16Once_)  
  LoadSound(sndCrash ,"Sound/Crash.wav" ,_Snd16Once_)
  LoadSound(sndFall  ,"Sound/Fall.wav"  ,_Snd16Once_)
  LoadSound(sndFlap  ,"Sound/Flap.wav"  ,_Snd16Loop_)
  LoadSound(sndGood  ,"Sound/Good.wav"  ,_Snd16Once_)
  LoadSound(sndLaugh ,"Sound/Laugh.wav" ,_Snd16Once_)
  LoadSound(sndOver1 ,"Sound/Over1.wav" ,_Snd16Once_)
  LoadSound(sndOver2 ,"Sound/Over2.wav" ,_Snd16Once_)
  LoadSound(sndRound ,"Sound/Round.wav" ,_Snd16Once_)
  LoadSound(sndShot  ,"Sound/Shot.wav"  ,_Snd16Once_)
  LoadSound(sndThrow ,"Sound/Throw.wav" ,_Snd16Once_)
  LoadSound(SndTitle ,"Sound/Title.wav" ,_Snd16Once_)
  LoadSound(sndTum   ,"Sound/Tum.wav"   ,_Snd16Once_)
end scope

#ifdef __FB_NDS__
if multikey(fb.SC_ButtonX)=0 then 
  Printf(!"Using Hardware Acceleration\n")
  gfx.GfxDriver = gfx.gdOpenGL
else
  Printf(!"Using Software Rendering\n")
end if
#endif

randomize()
screenres SC2X_X*iScale,SC2X_Y*iScale,bpp,,fb.GFX_NO_SWITCH or fb.GFX_HIGH_PRIORITY
#if iScale=2
Buff = ImageCreate(256,192)
#endif
setmouse SC2X_X\iScale,SC2X_Y\iScale,0,0

scope ' ************************** Loading Images ******************************
  LoadGrap(Back1,"Grap/Back1.bmp",256,192)
  LoadGrap(Back2,"Grap/Back2.bmp",256,192)
  LoadGrap(Title,"Grap/Title.bmp",192, 96)
  LoadGrap( Grap,"Grap/Graps.bmp",256,256)
  LoadGrap(Ducks,"Grap/Ducks.bmp",256,256)
  LoadGrap(  Pal,"Grap/Pal16.bmp",256,  1)
end scope


' ===========================================================================================
' =============================== Draw Text/Symbols on screen ===============================
' ===========================================================================================
sub DrwTxt(iX as integer,iY as integer,iColor as integer,sText as string,iCenter as integer=0)
  var iYStart = (iColor mod 3)*16
  var iLen = len(sText)  
  if iCenter then iY -= 4: iX -= len(sText)*4
  if iY <= -8 or iY >= SC2X_Y then exit sub
  if iX <= -(iLen*8) or iX >= SC2X_X then exit sub
  var sUTXT = ucase$(sText)
  for CNT as integer = 0 to iLen-1
    var iChar = sUTXT[CNT]
    if iChar <= asc(" ") or iChar > asc("Z") then 
      iX += 8
    else
      var iOY = iYStart+(cint(iChar-asc("0")) shr 5)*8
      var iOX = ((iChar-asc("0")) and 31)*8
      put Buff,(iX,iY),Grap,(iOX,iOY)-(iOX+7,iOY+7),pset
      iX += 8
    end if
    if iX >= Sc2X_X then exit sub
  next CNT
end sub
' ===========================================================================================
' ============================ Draw Score Points Numbers On Screen ==========================
' ===========================================================================================
sub DrwNum(iX as integer,iY as integer,iNumber as integer,iCenter as integer=0)
  var sText = str(iNumber),iLen = len(sText)  
  if iCenter then iY -= 4: iX -= len(sText)*2
  if iY <= -4 or iY >= SC2X_Y then exit sub
  if iX <= -(iLen*4) or iX >= SC2X_X then exit sub  
  for CNT as integer = 0 to iLen-1
    var iChar = sText[CNT]
    if iChar < asc("0") or iChar > asc("9") then 
      iX += 4
    else      
      var iOX = ((iChar-asc("0"))*4)+136
      put Buff,(iX,iY),Grap,(iOX,8)-(iOX+3,15),trans
      iX += 4
    end if
    if iX >= Sc2X_X then exit sub
  next CNT
end sub
' ===========================================================================================
' ================================ Read Keyboard/Mouse Input ================================
' ===========================================================================================
function ReadInput(byref MX as integer=0,byref MY as integer=0,byref MB as integer=0,byref iKey as integer=0) as integer
  dim as integer NX,NY,NB
  static as integer LBut,RBut,OX,OY,iSwitch
  static as single fXScale=1,fYScale=1
  getmouse NX,NY,,NB:MB=0
  if NB<>-1 then 
    OX=(NX\iScale)*fXScale:OY=(NY\iScale)*fYScale
    if (NB and 1)<>0 and LBut=0 then MB=+1:LBut=1
    if (NB and 1)=0 and LBut<>0 then MB=-1:LBut=0
    if (NB and 2)<>0 and RBut=0 then MB=+2:RBut=1
    if (NB and 2)=0 and RBut<>0 then MB=-2:RBut=0
  else
    LBut=0
  end if
  MX=OX:MY=OY
  
  #ifndef __FB_NDS__
  if multikey(fb.SC_ALT) andalso multikey(fb.SC_ENTER) then iSwitch=1
  if (multikey(fb.SC_ALT) or multikey(fb.SC_ENTER))=0 andalso iSwitch=1 then      
    static as integer iLeft,iTop    
    iFull xor= 1: iSwitch=0
    if iFull then
      screencontrol(fb.GET_WINDOW_POS,iLeft,iTop)
      #ifdef __FB_WIN32__
        dim as hwnd fbWnd
        screencontrol(fb.GET_WINDOW_HANDLE,*cast(uinteger ptr,@fbWnd))
        var hMonitor = MonitorFromWindow(fbWnd, MONITOR_DEFAULTTONEAREST)
        screenres SC2X_X*iScale,SC2X_Y*iScale,bpp,,fb.GFX_NO_SWITCH or fb.GFX_HIGH_PRIORITY or fb.GFX_NO_FRAME        
        screencontrol(fb.GET_WINDOW_HANDLE,*cast(uinteger ptr,@fbWnd))
        dim as MONITORINFO CurMonitor = type(sizeof(MONITORINFO))
        GetMonitorInfo(hMonitor,@CurMonitor)
        with CurMonitor.RcMonitor
          SetWindowPos(fbWnd,HWND_TOPMOST,.left,.top,.right-.left,.bottom-.top,0)
          fXScale = (SC2X_X*iScale)/(.right-.left)
          fyScale = (SC2X_Y*iScale)/(.bottom-.top)          
        end with
      #else
        fXScale=1:fYScale=1
        screenres SC2X_X*iScale,SC2X_Y*iScale,bpp,,fb.GFX_FULLSCREEN or fb.GFX_HIGH_PRIORITY
      #endif      
      setmouse NX,NY,0,1      
    else
      #if 0
      #ifdef __FB_WIN32__
      dim fbWnd as hwnd,fbRect as rect
      screencontrol(fb.GET_WINDOW_HANDLE,*cast(uinteger ptr,@fbWnd))
      GetWindowRect(fbWnd,@fbRect)
      iLeft = ((fbRect.Left+fbRect.Right)\2)-((SC2X_X*iScale)\2)
      iTop = ((fbRect.Top+fbRect.Bottom)\2)-((SC2X_Y*iScale)\2)      
      #endif
      #endif
      screenres SC2X_X*iScale,SC2X_Y*iScale,bpp,,fb.GFX_NO_SWITCH or fb.GFX_HIGH_PRIORITY      
      setmouse NX,NY,0,0: screencontrol(fb.SET_WINDOW_POS,iLeft,iTop)
      fXScale=1:fYScale=1
    end if
    if Bpp=8 then bload "Grap/Pal16.bmp"
    
  end if
  #endif
  
  var sKey = inkey()
  if len(sKey) then
    iKey = sKey[0]
    if iKey=255 then iKey = -sKey[1]        
    select case iKey
    #if iScale=2
    case -fb.SC_F1: iMethod = (iMethod+1) mod iif(bpp=16,3,2): iForceUp = 1    
    #endif
    #ifdef __FB_NDS__
    case -fb.SC_ButtonL: iVsync xor= 1: iForceUp = 1
    case -fb.SC_ButtonR: iSleep xor= 1: iForceUp = 1
    #else
    case -fb.SC_F2: iVsync xor= 1: iForceUp = 1  
    case -fb.SC_F3: iSleep xor= 1: iForceUp = 1
    #endif
    end select
    return iKey
  end if
end function
' ===========================================================================================
' ========================== Update Screen and Sync to next frame ===========================
' ===========================================================================================
#ifdef __FB_WIN32__
sub UpdateTitle(hwnd as any ptr ptr)
  do
    sleepex 100,1    
    'if isWindow(*hwnd)=0 then exit sub
    SetWindowText(*hwnd,strptr(sTitle))
  loop
end sub
#endif
sub UpdateScreen()  
  
  #if iScale=1
    #ifdef __FB_NDS__
      if gfx.GfxDriver = gfx.gdOpenGL then
        flip
        if iVsync then screensync
      else
        if iVsync then screensync
      end if
    #else
      if iVsync then screensync
    #endif    
  #endif
  
  static iFps as integer, dTimer as double  
  iFps += 1
  if abs(timer-dTimer) >= .5 orelse iForceUp then    
    sTitle = "Duck Hunt (" & fix(iFps/(timer-dTimer)) & " fps)" 
    select case iMethod
    case 1: sTitle += " sc2x"
    case 2: sTitle += " hq2x"
    end select
    if iVsync then sTitle += " sync"
    if iSleep then sTitle += " slp"
    #ifdef __FB_WIN32__
    static as any ptr pThread
    static as hwnd fbWnd
    screencontrol(fb.GET_WINDOW_HANDLE,*cast(uinteger ptr,@fbWnd))      
    if pThread=0 then      
      pThread = ThreadCreate(cast(any ptr,@UpdateTitle),@fbWnd)
    end if
    #else
      #ifdef __FB_NDS__
        printf(!"%s\r",left$(sTitle+space(16),31))
      #else
        WindowTitle(sTitle)
      #endif
    #endif
    dTimer = timer: iFps=0: iForceUp = 0
  end if
      
  #if iScale=2
    if iSleep then sleep 1,1
    screenlock
    #if bpp=8    
      select case iMethod
      case 0   : resize2x(Buff+1,screenptr)
      case else: scale2x(Buff+1,screenptr)
      end select    
    #else
    select case iMethod
    case 0: resize2x(Buff+1,screenptr)
    case 1: scale2x(Buff+1,screenptr)
    case 2: HQ2X_16(Buff+1,screenptr,SC2X_X,SC2X_Y,SC2X_X*4)
    end select
    #endif        
    if iVsync then screensync
    screenunlock  
  #else       
    if iSleep then sleep 1,1    
  #endif
end sub
' ===========================================================================================
' ====================================== Game Main Menu =====================================
' ===========================================================================================
function MainMenu() as integer
  var dTitleMusic=timer,chTitleMusic=-1,iScore=0
  var iBgColor=point(1,0,pal)
  static as integer iOpt=0,iOnce=0
  do
    #if iScale=1
    screenlock
    #endif
    if iOnce=0 then      
      iOnce=1: put (0,0),Ducks,pset
      put(0,0),Back1,pset
      put(0,0),Back2,pset
    end if
    line Buff,(0,0)-(256,192),iBgColor,bf
    put Buff,(32,6),Title,pset
    DrwTxt(64 ,112,0,"GAME A   1 DUCK")
    DrwTxt(64 ,128,0,"GAME B   2 DUCKS")
    DrwTxt(64 ,144,0,"GAME C   CLAY SHOOTING")
    DrwTxt(128,168,1,"TOP SCORE = "+right$("0000000" & iScore,7),1)
    DrwTxt(128,184,2,"?2014 MYSOFT CORPORATION",1)
    DrwTxt(48 ,112+iOpt*16,2,"@")    
    static as integer iC
    var iW = (iC+iMX+iMY and 1)*16: iC xor= 1
    put Buff,(iMX-8,iMY-8),Grap,(224+iW,128)-(224+15+iW,128+15),trans    
    #if iScale=1
    screenunlock
    #endif    
    UpdateScreen()    
    iScore += &h111211
    
    ' *** Music Event ***
    if timer>dTitleMusic then 
      dTitleMusic += 45
      chTitleMusic = FSOUND_PlaySound(FSOUND_FREE,SndTitle)  
    end if
    
    ' *** Keyboard ***
    if ReadInput(iMX,iMY,iMB,iKey) then
      select case iKey
      case _KeyBack_   'Quit Game
        iOpt = -1: exit do
      case _KeyUP_     'Menu UP
        iOpt = (iOpt+2) mod 3
      case _KeyDown_   'Menu Down
        iOpt = (iOpt+1) mod 3
      case _KeyAct_    'Menu Select
        exit do        
      end select
    end if       
    
    ' *** Mouse ***
    static as integer iOX,iOY
    if iMX <> iOX or iMY <> iOY then
      iOX=iMX:iOY=iMY
      if iMY > 108 and iMY <= 156 then iOpt = (iMY-108)\18
    end if
    if iMB < 0 then      
      if iMB = -2 then
        static as double dLastBut        
        if abs(timer-dLastBut) < 1/3 then iOpt=-1:exit do
        dLastBut = timer: continue do
      end if
      chShoot = FSOUND_PlaySound(FSOUND_FREE,SndShot)  
      sleep 100,1
      for CNT as integer = 0 to 2
        var dTemp = timer
        line Buff,(0,0)-(256,192),point(1+((CNT and 1)*19),0,pal),bf
        UpdateScreen()
        while abs(timer-dTemp) < 1/30
          sleep 1,1
        wend        
      next CNT
      exit do
    end if
    
  loop
  
  if chTitleMusic >= 0 then 
    FSOUND_StopSound(chTitleMusic) : chTitleMusic=-1
  end if
  
  return iOpt
end function
' ===========================================================================================
' ================================ Game Modes A/B (1/2 ducks) ===============================
' ===========================================================================================
type DuckStruct 
  as single fX,fY,fSX,fSY  'Position + Movement            
  as single fSpd           'Duck Dynamic Speed             
  as short iL,iT,iR,iB     'Sprite Coordinates             
  as short iBX,iBY         'Base Animation                 
  as short iStatus,iAng    'Current Action / Angle         
  as short iAnim,iFrames   'Animation Frame / Left Counter 
  as short iScX,iScY       'Hit Position                   
  as short iValue,iColor   'Score Value / Duck Color       
  as integer iValueFrame   'iValueFrame (vanish timer)     
end type
sub UpdateDuckAngle(tDuck as DuckStruct)
  with tDuck
    select case .iAng
    case -22.5 to 22.5   'Up
      .iBX = 0: .iBY = 192
      if .iColor = 1 then .iBX = 96  '(+96)
      if .iColor = 2 then .iBY = 224 '(+32)
    case  -67.5 to -22.5 'Left Up
      .iBX = 0: .iBY =  0+64*.iColor
    case   22.5 to  67.5 'Right Up
      .iBX = 0: .iBY = 32+64*.iColor
    case  -180  to -67.5 'Left Rest
      .iBX = 96: .iBY = 64*.iColor
    case   67.5 to  180  'Right Rest
      .iBX = 96: .iBY = 32+64*.iColor
    end select  
  end with
end sub
sub GameAB(iDucks as integer)    
  'iDucks += 7
  var iBgColor=point(10,0,pal),iBlack=point(1,0,pal),iWhite=point(20,0,pal)
  var iDog=1,iTile=0,iFrames=7,iLeft=0  
  var iDogL=iTile*56,iDogT=48,iDogR=iDogL+55,iDogB=48+47
  var iScore=0,iOldScore=-1,iBonus=0,iOver=0,iReqDucks=6,iShot=3
  var chBark=-1,chFlap=-1,chMusicStart=-1,chLaugh=-1
  var chCatch=-1,chRound=-1,chGood=-1,iBlank=-1
  var iRound=1,iFly=0,iDogPri=1,iDuckMeter=0,iFrameCount=0
  if iSound then chMusicStart=FSOUND_PlaySound(FSOUND_FREE,SndBegin)
  dim as double dSync = timer,dFly
  dim as single fJump=0,fSide=0,fDogX=0,fDogY=105,fDuckSpd=1+(1-iDucks)+abs(iRound)/5  
  dim iPrevDuck(9) as integer,tDuck(9) as DuckStruct,chFall(9) as integer
  dim as string sScore
    
  do
    #if iScale=1
    screenlock
    #endif
    if iBlank = -1 then 'Normal Scenery
      ' Clear Background (blue/red)
      line Buff,(0,0)-(256,119),iBgColor,bf
      line Buff,(20,172)-(176,188),iBgColor,bf
      ' Limit Required Ducks Line Markers
      if iReqDucks < 10 then
        line Buff,(92+iReqDucks*8,180)-(99+9*8,187),iBlack,bf
      end if    
      ' Draw Red(hit) Duck Markers
      for CNT as integer = 0 to 9
        var iX = iPrevDuck(CNT)*8+136
        if iDog=9 andalso (iFrameCount and 31) > 15 then iX = 136
        put Buff,(92+CNT*8,172),Grap,(iX,24)-(iX+7,24+7),pset
      next CNT
      ' Draw Ducks and the blink active ducks
      for CNT as integer = 0 to iDucks
        with tDuck(CNT)
          if .iValueFrame > 0 then 
            DrwNum(.iScX,.iScY,.iValue,1)
            if abs(iFrameCount-.iValueFrame) > 120 then .iValueFrame = 0            
          end if
          if .iStatus > 0 then             
            put Buff,(.fX,.fY),Ducks,(.iL,.iT)-(.iR,.iB),trans
            if .iStatus < 3 then 
              if (iFrameCount and 31) > 15 then
                put Buff,(92+(iDuckMeter+CNT)*8,172),Grap,(128,24)-(128+7,24+7),pset
              end if
            else
              put Buff,(92+(iDuckMeter+CNT)*8,172),Grap,(144,24)-(144+7,24+7),pset
            end if
          end if
        end with
      next CNT
      ' Draw Dog (LO Priority) (2 parts if iDog=7-8
      if cuint(iDog-1) < = 6 andalso iDogPri=0 then
        put Buff,(fDogX,fDogY),Grap,(iDogL,iDogT)-(iDogR,iDogB),trans
        if cuint(iDog-6)<2 then        
          var iDogL = (((iTile and &h2000)=0) and 64)+32,iDogR=iDogL+31
          put Buff,(fDogX+32,fDogY),Grap,(iDogL,iDogT)-(iDogR,iDogB),trans
        end if
      end if
      ' Draw Background transparently
      put Buff,(  4,  3),Back1,(  4,  3)-( 73,110),trans
      put Buff,(192, 86),Back1,(192, 86)-(223,110),trans
      put Buff,(  0,111),Back1,(  0,111)-(255,119),trans
      put Buff,(  0,120),Back1,(  0,120)-(255,171),pset
      put Buff,(  0,172),Back1,(  0,172)-(255,191),trans
      ' Draw Round Number
      scope
        var sRound = "R=" & abs(iRound),iSz=len(sRound)
        line Buff,(33-iSz*4,163-4)-(33+iSz*4,163+4),iBlack,bf
        DrwTxt(34,164,1,sRound,1)      
      end scope
      ' Limit Bullet Left Marker
      if iShot < 3 then
        line Buff,(22+iShot*8,172)-(28+2*8,179),iBlack,bf
        if iShot=0 andalso (iFrameCount mod 31) < 16 then
          line Buff,(22,180)-(45,188),iBlack,bf
        end if
      end if
      ' Draw Dog (HI Priority)
      if iDog andalso iDogPri then
        put Buff,(fDogX,fDogY),Grap,(iDogL,iDogT)-(iDogR,iDogB),trans
      end if
      ' Draw Round Sign (begin of the round only)
      if iRound > 0 then
        DrwTxt(128,40,2,"#$$$$$%",1)
        DrwTxt(128,48,2,"&'''''(",1)      
        DrwTxt(128,56,2,"&'''''(",1)      
        DrwTxt(128,64,2,")*****+",1)
        DrwTxt(128,46,2," ROUND ",1)
        DrwTxt(128,58,2,"" & iRound,1)
      end if
      ' Draw Bonus Sign (end of round if all ducks hit)
      if iBonus > 0 then
        DrwTxt(128,40,2,"#$$$$$$$%",1)
        DrwTxt(128,48,2,"&'''''''(",1)      
        DrwTxt(128,56,2,"&'''''''(",1)      
        DrwTxt(128,64,2,")*******+",1)
        DrwTxt(128,46,2," PERFECT> ",1)
        DrwTxt(128,58,2,"" & iBonus,1)
      end if
      ' Draw Game Over Sign
      if iDuckMeter < 0 then
        DrwTxt(128,40,2,"#$$$$$$$$$%",1)
        DrwTxt(128,48,2,"&'''''''''(",1)      
        DrwTxt(128,56,2,"&'''''''''(",1)      
        DrwTxt(128,64,2,")*********+",1)
        DrwTxt(128,52,2," GAME OVER ",1)        
      end if
      ' Draw Score
      if iScore <> iOldScore then
        sScore = right$("000000" & iScore,7)
      end if
      DrwTxt(186,171,2,sScore)
      ' Draw Aim Cursor
      if iDog=0 then 
        static as integer iC
        var iW = (iC+iMX+iMY and 1)*16: iC xor= 1
        put Buff,(iMX-8,iMY-8),Grap,(224+iW,128)-(224+15+iW,128+15),trans    
      end if
      ' Calculate / Draw Fly-Away sign (seconds after)
      if iFly then                     'Flying Timeout/Message
        if iFly < 0 andalso abs(timer-dFly) > 5-(abs(iRound)\20) then        
          for CNT as integer = 0 to iDucks 
            if cuint(tDuck(CNT).iStatus-1) < 2 then
              iFly = 1: iBgColor = point(18,0,pal)
              exit for
            end if
          next CNT
        end if
        if iFly > 0 then
          DrwTxt(128,40,2,"#$$$$$$$$%",1)
          DrwTxt(128,48,2,"&FLY'AWAY(",1)              
          DrwTxt(128,56,2,")********+",1)          
        end if
      end if
    else 'Scenery for Light Shot
      line Buff,(0,0)-(255,191),iBlack,bf
      with tDuck(iBlank)
        if .iStatus > 0 then 
          line Buff,(.fX,.fY)-(.fX+(.iR-.iL),.fY+(.iB-.iT)),iWhite,bf
        end if
      end with      
    end if
    #if iScale=1
    screenunlock
    #endif
    UpdateScreen()
        
    if abs(timer-dSync) > 2 then dSync = timer    
    while (timer-dSync) >= 1/60      'Per Frame Actions
      dSync += 1/60      
      if iBlank <> -1 then iBlank += 1: if iBlank > iDucks then iBlank = -1
      iFrames -= 1: iFrameCount += 1
      if iFrames <=0 then              'Dog Actions
        select case iDog
        case  1 'Walking
          iTile = (iTile+1) and 3
          iDogL=iTile*56:iDogT=48:iDogR=iDogL+55:iDogB=iDogT+47
          fDogX += 2 : iFrames = 7          
          if abs(fDogX-32)<=2 or abs(fDogX-64)<=2 then            
            if iTile=3 then
              iTile = 4: iFrames = 9: iDog=2 '7
              iDogL=168:iDogT=48+(iTile and 1)*48
              iDogR=iDogL+55:iDogB=48+47
            end if
          end if            
        case  2 'Sniff
          iTile += 1: iFrames = 9
          iDogL=168:iDogT=48+((iTile and 1)*48)
          iDogR=iDogL+55:iDogB=iDogT+47
          if iTile=(4+7) then
            iTile = 0: iFrames = 7: iDog=iif(fDogX>60,3,1)
            iDogL=iTile*56:iDogT=48: fDogX += 2
            iDogR=iDogL+55:iDogB=iDogT+47: iRound = -abs(iRound)
          end if
        case  3 'Jumping
          select case iTile
          case 0 'Found
            iDogL=0+iTile*56:iDogT=96
            iDogR=iDogL+55:iDogB=iDogT+47
            iTile+=1: iFrames = 18
          case 1 'Barking
            iDogL=0+iTile*56:iDogT=96
            iDogR=iDogL+55:iDogB=iDogT+47
            if fJump = 0 then
              if iSound then chBark = FSOUND_PlaySound(FSOUND_FREE,SndBark)
              fJump = -3: fSide = 2
            end if
            if fSide > 0 then fSide -= .03 else fSide = 0
            fJump += .1: iFrames = 1
            fDogX += fSide: fDogY += fJump
            if fJump >= 0 then iTile += 1
          case 2 'Jumping
            iDogL=0+iTile*56:iDogT=96
            iDogR=iDogL+55:iDogB=iDogT+47
            iFrames = 1: iDogPri = 0
            if fSide > 0 then fSide -= .03 else fSide = 0
            fJump += .1: iFrames = 1
            fDogX += fSide: fDogY += fJump
            if fJump >= 3 then iTile += 1: iFrames = 30+rnd*30            
          case 3 'Add Ducks
            if iSound then chFlap = FSOUND_PlaySound(FSOUND_FREE,SndFlap)
            iDog=0: dFly = timer: iFly = -1: iLeft=iDucks+1: iShot = 3
            for CNT as integer = 0 to iDucks
              with tDuck(CNT)              
                .fX = 64+rnd*128: .fY = 115: .iValue = 0
                .fSpd = fDuckSpd+rnd*(((.iColor xor 1)+1)*(abs(iRound)/3)*.15)
                do
                  .iAng = -60+cint(rnd*120)                  
                loop while abs(.iAng) <= 22.5                
                .fSX = sin(.iAng*PI)*.fSpd: .fSY = -cos(.iAng*PI)*.fSpd
                .iL=.iBX: .iR = .iL+31 : .iT=.iBY: .iB = .iT+31
                .iColor = int(rnd*(iif(iDucks=0,2,3))) : .iFrames=3: .iAnim = 0: .iStatus = 1 'Flying
                UpdateDuckAngle(tDuck(CNT))
              end with
            next CNT
          end select
        case  4 'Laughing Up
          if iTile = -1 andalso iSound then chLaugh = FSOUND_PlaySound(FSOUND_FREE,SndLaugh)
          iTile += 1: iFrames = 1
          if .fDogY > 80 andalso (iTile mod 5) then fDogY -= 1
          iDogL = 224: iDogT = 48+(((iTile\5) and 1)*40)
          iDogR = iDogL+31: iDogB = iDogT+39
          if iTile = 90 and iDuckMeter >= 0 then iDog += 1
          if iTile = 220 and iDuckMeter < 0 then exit do
        case  5 'Laughing Down
          iTile += 1: iFrames = 1
          if .fDogY >= 120 then 
            iDog=3: iTile=3: iFrames = 30+rnd*30
            if chLaugh>=0 then FSOUND_StopSound(chLaugh):chLaugh=-1
            if iDuckMeter >= 10 then iFrames=1:iDog = 8: continue while
          elseif (iTile mod 5) then 
            fDogY += 1
          end if
          iDogL = 224: iDogT = 48+(((iTile\5) and 1)*40)
          iDogR = iDogL+31: iDogB = iDogT+39
        case  6 'Showing Ducks UP
          if (iTile and &h8000) andalso iSound then             
            chCatch = FSOUND_PlaySound(FSOUND_FREE,SndCatch)            
          end if          
          iTile = (iTile and (not &h8000))+1: iFrames = 1
          if .fDogY > 80 then fDogY -= 2
          iDogT = 144: iDogB = iDogT+39
          iDogL = ((iTile and &h4000)=0) and 64: iDogR=iDogL+31
          'iDogR = iDogL+31: iDogB = iDogT+39
          if (iTile and &h1FFF) = 40 then iDog += 1
        case  7 'Showing Duck Down
          iTile += 1: iFrames = 1
          if .fDogY >= 120 then 
            iDog=3: iTile=3: iFrames = 30+rnd*30
            if chCatch>=0 then FSOUND_StopSound(chCatch):chCatch=-1
            if iDuckMeter >= 10 then iFrames=1:iDog = 8: continue while
          else
            fDogY += 2
          end if
          iDogT = 144: iDogB = iDogT+39
          iDogL = ((iTile and &h4000)=0) and 64: iDogR=iDogL+31
        case  8 'Missed Ducks
          dim as integer iCNT,iTOT
          for CNT as integer = 0 to 9
            iTOT -= iPrevDuck(CNT)<>0 
          next CNT          
          for iCNT = 0 to 8
            if iPrevDuck(iCNT)=0 andalso iPrevDuck(iCNT+1) then
              swap iPrevDuck(iCNT),iPrevDuck(iCNT+1): iTOT = -1
            end if
          next iCNT
          if iTOT = -1 then
            if iSound then FSOUND_PlaySound(FSOUND_FREE,SndCount)
            iFrames=16:continue while
          end if
          if iTOT < iReqDucks then
            iDuckMeter=-1: iFrames=115
            if iSound then
              chRound = FSOUND_PlaySound(FSOUND_FREE,SndOver1)
            end if
            iDog += 1: continue while
          end if          
          iFrames=240: iDog += 1
          if iSound then
            chRound = FSOUND_PlaySound(FSOUND_FREE,SndRound)
          end if
        case  9 'End Round Music
          if chRound >= 0 then FSOUND_StopSound(chRound):chRound=-1
          if iDuckMeter < 0 then
            if iSound then
              chRound = FSOUND_PlaySound(FSOUND_FREE,SndOver2)
              fDogX = 128-16: fDogY = 120
              iFrames = 30: iDog = 4: iTile = 0 'Laughing UP
              continue while
            end if
          end if            
          dim as integer iCNT,iTOT
          for iCNT as integer = 0 to 9
            iTOT -= iPrevDuck(iCNT)<>0 
          next iCNT
          if iTOT=10 then 
            iFrames=130: iBonus=10000
            if iSound then chGood = FSOUND_PlaySound(FSOUND_FREE,SndGood)
          else
            iFrames=1: iBonus=0  
          end if
          iDog += 1
        case 10 'Next Round
          if iBonus then iScore += iBonus
          iFrames=1:iBonus=0:iDog = 8 'After Round
          iRound = abs(iRound)+1: fDogX = 56: iDog = 1: iDogPri = 1
          fJump=0:fSide=0:fDogY=105:fDuckSpd=1+abs(iRound)/5
          iReqDucks=6+((abs(iRound)-1)\10):iDuckMeter=0:iShot=3
          iFrames=7:iLeft=0:iBgColor=point(10,0,pal)
          iDogL=iTile*56:iDogT=48:iDogR=iDogL+55:iDogB=48+47
          for iCNT as integer = 0 to 9
            iPrevDuck(iCNT)=0
          next iCNT
          continue while          
        end select          
      end if
      for CNT as integer = 0 to iDucks 'Ducks Actions
        with tDuck(CNT)
          if .iStatus <= 0 then continue for          
          select case .iStatus          
          case 1 'Fyling
            var iNew = 0
            .fX += .fSX: .fY += .fSY
            if .fSX < 0 and .fX <= 0 then .fX = 0: .fSX = abs(.fSX): iNew = 1
            if .fSY < 0 and .fY <= 0 then .fY = 0: .fSY = abs(.fSY): iNew = 1
            if .fSX > 0 and .fX >=(255-32) then .fX = (255-32): .fSX = -abs(.fSX): iNew = 1
            if .fSY > 0 and .fY >=(111-32) then .fY = (111-32): .fSY = -abs(.fSY): iNew = 1
            if .fY < (111-32) andalso cint(rnd*256) = 128  then 
              do
                iNew=2: .iAng = -180+cint(rnd*360)
              loop while abs(.iAng-0) <= 12.5 or abs(abs(.iAng)-180) <= 12.5
              .fSX = sin(.iAng*PI)*.fSpd: .fSY = -cos(.iAng*PI)*.fSpd
            end if
            if iShot = 0 then
              iNew=2: .iAng = 0: .fSX=0: .fSY = -.fSpd: .iStatus = 2
            end if
            if iFly > 0 then .iStatus = 2 'Leaving
            if iNew > 0 then 
              if iNew=1 then .iAng = atan2(.fSX,-.fSY)/PI              
              .iFrames = 0: UpdateDuckAngle(tDuck(CNT))
            end if
            .iFrames -= 1          
            if .iFrames <= 0 then
              .iAnim = (.iAnim+1) mod 3
              .iL = .iBX+.iAnim*32: .iR = .iL+31
              .iT = .iBY          : .iB = .iT+31
              if .iAnim=2 then .iFrames = 5 else .iFrames = 3
            end if
          case 2 'Leaving
            .fX += .fSX: .fY += .fSY: .iFrames -= 1          
            if .fSY > 0 and .fY >=(111-32) then 
              .fY = (111-32): .fSY = -abs(.fSY)
              .iFrames = 0: UpdateDuckAngle(tDuck(CNT))
            end if
            if .iFrames <= 0 then
              .iAnim = (.iAnim+1) mod 3
              .iL = .iBX+.iAnim*32: .iR = .iL+31
              .iT = .iBY          : .iB = .iT+31
              if .iAnim=2 then .iFrames = 5 else .iFrames = 3
            end if
            if .fX <= -32 or .fX >= 256 or .fY <= -32 then 
              .iStatus = 0:  iLeft -= 1 'No Duck...
              if iLeft <= 0 then 
                if chFlap >= 0 then FSOUND_StopSound(chFlap):chFlap=-1
                iFly = 0: iBgColor=point(10,0,pal)
                fDogX = 0: iFrames = 0: iTile = 0
                for iCNT as integer = 0 to iDucks
                  if tDuck(iCNT).iValue then 
                    iFrames += 1: fDogX += tDuck(iCNT).iScX: iTile = iCnt
                  end if
                next iCNT
                if iFrames = 0 then
                  fDogX = 128-16: fDogY = 120
                  iFrames = 30: iDog = 4: iTile = -1 'Laughing UP
                else
                  fDogX \= iFrames: fDogY = 120
                  if fDogX < 48 then fDogX = 48 else if fDogX > 128 then fDogX = 128
                  if iFrames > 1 then 
                    iTile = &h8000+&h4000+&h2000
                  elseif tDuck(iTile).iScX < 128 then
                    iTile = &h8000+&h4000
                  else
                    iTile = &h8000+&h2000
                  end if
                  iFrames = 30: iDog = 6: 'Laughing UP
                end if
                iDuckMeter += (iDucks+1)
              end if
            end if
          case 3 'Falling
            .iFrames -= 1
            if .iFrames <=0 then
              if .iAnim = -1 then 
                .iL += 32: .iR += 32: .iFrames = 1                
                if iSound then chFall(CNT)=FSOUND_PlaySound(FSOUND_FREE,SndFall)
              end if              
              static as short iMov(7) = {1,-1,1,-1,-1,1,-1,1}
              .iAnim += 1: .fX += iMov(.iAnim and 7): .fY += 2
              if (.iAnim mod 5)=0 then .iT xor= 32: .iB = .iT+31
              if .fY >= 114 then 
                if chFall(CNT) >=0 then FSOUND_StopSound(chFall(CNT)):chFall(CNT)=-1
                if iSound then FSOUND_PlaySound(FSOUND_FREE,SndTum)
                .iStatus = 0:  iLeft -= 1 'No Duck...
                if iLeft <= 0 then 
                  if chFlap >= 0 then FSOUND_StopSound(chFlap):chFlap=-1
                  iFly = 0: iBgColor=point(10,0,pal)
                  fDogX = 0: iFrames = 0: iTile = 0
                  for iCNT as integer = 0 to iDucks
                    if tDuck(iCNT).iValue then 
                      iFrames += 1: fDogX += tDuck(iCNT).iScX: iTile = iCnt
                    end if
                  next iCNT
                  fDogX \= iFrames: fDogY = 120
                  if fDogX < 48 then fDogX = 48 else if fDogX > 128 then fDogX = 128
                  if iFrames > 1 then 
                    iTile = &h8000+&h4000+&h2000
                  elseif tDuck(iTile).iScX < 128 then
                    iTile = &h8000+&h4000
                  else
                    iTile = &h8000+&h2000
                  end if
                  iFrames = 30: iDog = 6: 'Laughing UP
                  iDuckMeter += (iDucks+1)
                end if
              end if
              var iCNT = -1
              for iCNT = iDucks to 0 step-1
                if cuint(tDuck(iCNT).iStatus-1) < 2 then exit for
              next iCNT
              if iCNT < 0 andalso chFlap >=0 then
                FSOUND_StopSound(chFlap):chFlap=-1 
              end if                
            end if
          end select
        end with
      next CNT
    wend
    
    ' *** Input ***
    if ReadInput(iMX,iMY,iMB,iKey) then          
      select case iKey      
      case _KeyBack_
        exit do
      end select
    end if 
    if iMB < 0 then
      if iMB = -2 then
        static as double dLastBut        
        if abs(timer-dLastBut) < 1/3 then exit do
        dLastBut = timer: continue do
      end if            
      if iDog=0 andalso iShot then
        iShot -= 1: iBlank = 0
        for CNT as integer = 0 to iDucks
          with tDuck(CNT)
            if iMX >= .fX-4 and iMY >= .fY-4 then
              if iMX < .fX+35 and iMY < .fY+35 then
                if cuint(.iStatus-1) < 2 then
                  .iScX = .fX+16: .iScY = .fY+8
                  static as short iVal(...) = {2,1,3}
                  .iValue = iVal(.iColor)*(500+(300*((abs(iRound)-1)\5)))
                  .iValueFrame = iFrameCount
                  iPrevDuck(iDuckMeter+CNT) = 1: .iStatus = 3 'Fall
                  .iL = 192: .iT = ((.iAng>0) and 32)+(.iColor*64)
                  .iR = .iL+31: .iB = .iT+31: .iFrames = 24: .iAnim = -1
                  iScore += .iValue: exit for
                end if
              end if
            end if
          end with
        next CNT      
        'if chShoot then FSOUND_StopSound(chShoot)
        if iSound then chShoot=FSOUND_PlaySound(FSOUND_FREE,SndShot)
      end if
    end if
    
  loop
  
  if chMusicStart >= 0 then FSOUND_StopSound(chMusicStart):chMusicStart=-1
  if ChShoot      >= 0 then FSOUND_StopSound(chShoot)     :chShoot=-1
  if chBark       >= 0 then FSOUND_StopSound(chBark)      :chBark=-1
  if chFlap       >= 0 then FSOUND_StopSound(chFlap)      :chFlap=-1 
  if chLaugh      >= 0 then FSOUND_StopSound(chLaugh)     :chLaugh=-1
  if chCatch      >= 0 then FSOUND_StopSound(chCatch)     :chCatch=-1
  if chRound      >= 0 then FSOUND_StopSound(chRound)     :chRound=-1
  if chGood       >= 0 then FSOUND_StopSound(chGood)      :chGood=-1
  for CNT as integer = 0 to 9
    if chFall(CNT) >=0 then FSOUND_StopSound(chFall(CNT)) :chFall(CNT)=-1
  next CNT
end sub
' ===========================================================================================
' ================================ Game Mode C (Clay Shooting) ==============================
' ===========================================================================================
sub GameC()
  var Score=0
  var chMusicStart=FSOUND_PlaySound(FSOUND_FREE,SndBegin2)
  do
    #if iScale=1
    screenlock
    #endif
    line Buff,(0,0)-(256,192),point(10,0,pal),bf
    put Buff,(0,0),Back2,trans
    
    static as integer iC
    var iW = (iC+iMX+iMY and 1)*16: iC xor= 1
    put Buff,(iMX-8,iMY-8),Grap,(224+iW,128)-(224+15+iW,128+15),trans
    
    #if iScale=1
    screenunlock
    #endif
    
    UpdateScreen()
    
    if ReadInput(iMX,iMY,iMB,iKey) then    
      select case iKey      
      case _KeyBack_        
        exit do
      end select
    end if
    
    if iMB < 0 then
      if iMB = -2 then
        static as double dLastBut        
        if abs(timer-dLastBut) < 1/3 then exit do
        dLastBut = timer: continue do
      end if
    end if
   
  loop
  
  if chMusicStart >=0 then 
    FSOUND_StopSound(chMusicStart): chMusicStart=-1
  end if
  
end sub

' ************************** Game Main Loop ******************************
do
  select case MainMenu()
  case 0
    GameAB(1-1)
  case 1
    GameAB(2-1)
  case 2
    GameC()
  case else
    exit do
  end select
loop

