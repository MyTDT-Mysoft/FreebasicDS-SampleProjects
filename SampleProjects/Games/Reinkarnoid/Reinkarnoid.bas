#define fbc -s console Files\hq2x16.o

'#inclib "hq2x"
'declare sub HQ2X_16 (INBUFFER as any ptr,OUTBUFFER as any ptr,XRES as uinteger,YRES as uinteger,PITCH as uinteger)

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#include "Modules/fmod.bas"
#else
#define SC2X_X 256
#define SC2X_Y 192
#include "MyTDT\Scale2x.bas"
#ifdef __FB_WIN32__
#include "Files\hq2x.bi"
#endif
#ifndef __FB_DOS__
#include "fmod.bi"
#endif
#include "fbgfx.bi"
#include "crt.bi"
chdir exepath+"/NitroFiles/"
'chdir exepath+"/NitroF~1/"
#endif

#ifdef __FB_WIN32__
#include "windows.bi"
#define Render_OpenGL
#include "MyTDT\OpenGL.bas"
#endif

#include "Files\Types.bas"
#include "Files\Rounds.bas"

declare function ConvertPassword(CP1,CP2,CP3,CP4,CP5,as integer) as uinteger
declare function DrwTxt(as integer,as integer,as string,as uinteger=rgb(255,255,255)) as integer
declare sub LoadMap(as integer, as integer=0)
declare sub DrawMap() 
declare sub UpdatePowerUp()
declare sub NewPowerUp(as integer,as integer)
declare sub DrawBall(as integer)
declare function BallCollision(as integer) as integer
declare sub LaserUpdate(NUM as integer)
declare sub DrawHud()
declare sub DrawStars()
declare function DrawSprites() as integer
declare sub UpdateAndSync()
declare sub ShipBreaks(as integer=0)
declare sub Screenlock2()
declare sub Screenunlock2()
declare sub UpdateAliens()
declare sub InGame()
declare sub Intro(as integer=0)
declare sub CreateStars()
declare sub SaveCpu()
declare sub LoadConfig()
declare sub SaveConfig()
declare sub VideoInit()

#ifdef __FB_DOS__
dim shared as integer xxx=0
#define FSOUND_Init(p1,p2,p3) 0
#define FSOUND_Sample_Load(p1,p2,p3,p4,p5) 0
#define FSOUND_Sample_SetDefaults(p1,p2,p3,p4,p5) xxx=0
#define FSOUND_PlaySound(p1,p2) xxx=0
#define FSound_StopSound(p1) xxx=0
#define FSOUND_Sample_Free(p1) xxx=0
#define FSOUND_SetVolume(p1,p2) xxx=0
#define FSOUND_SAMPLE any
#endif

'175
dim shared as any ptr Grap,Back,Font,Buff,Scr,InTitle,Explode
dim shared as any ptr Stars,Doh,Buff2,Scr2,Aliens
dim shared as byte ScrDouble,NoSound,ScrRender,ScrFilter
dim shared as byte sndVol,DSIsTop = 1
dim shared as FSOUND_SAMPLE ptr sndSpark,sndBrick,sndHit,sndHit2
dim shared as FSOUND_SAMPLE ptr sndLaser,sndBounce,sndWarp,sndDoh
dim shared as FSOUND_SAMPLE ptr sndRound,sndGameOver,sndDohHit
dim shared as FSOUND_SAMPLE ptr sndDohBreak,sndShipBrk,sndAlienBrk
dim shared as FSOUND_SAMPLE ptr MusTheme,MusStory,sndVoice
dim shared as FSOUND_SAMPLE ptr VocBeam,VocCatch,vocDup,vocExt
dim shared as FSOUND_SAMPLE ptr vocPlus,vocLaser,vocSlow
dim shared as string FileName

scope 'Init
  printf(!"Starting...\n")
  LoadConfig()  
  VideoInit()  
  #ifdef __FB__LINUX__
  FSOUND_SetOutput(FSOUND_OUTPUT_ALSA)
  if FSOUND_Init(44100,16,0) = 0 then 
    FSOUND_SetOutput(FSOUND_OUTPUT_OSS)
    if FSOUND_Init(44100,16,0) = 0 then 
      NoSound = 1
    end if
  end if
  #else
  if FSOUND_Init(44100,16,0) = 0 then NoSound = 1
  #endif
  
  printf(!"Loading Sounds...\n")
  #macro LoadSound(sndTarget,sndName,sndFlags)
  sndTarget    = FSOUND_Sample_Load(FSOUND_FREE,sndName,FSOUND_NORMAL or sndFlags,0,0)
  if sndTarget = 0 then Fail=1: printf "Failed to load: " sndName !"\n"
  #endmacro
  if NoSound = 0 then  
    #ifdef __FB_NDS__
    dim as integer Snd = (*cptr(uinteger ptr,&h4000500)) and &h7F
    *cptr(uinteger ptr,&h4000500) = Snd or ((SndVol shl 5)-(sndVol shl 2))
    #else
    FSOUND_SetSFXMasterVolume((sndVol shl 6)-(sndVol shl 2))
    #endif
    dim as integer Fail
    LoadSound(sndSpark   ,"Sounds/Eletric.wav"   ,FSOUND_LOOP_OFF)
    LoadSound(sndBrick   ,"Sounds/Brick.wav"     ,FSOUND_LOOP_OFF)
    LoadSound(sndHit     ,"Sounds/Hit3.wav"      ,FSOUND_LOOP_OFF)
    LoadSound(sndHit2    ,"Sounds/Hit4.wav"      ,FSOUND_LOOP_OFF)
    LoadSound(sndDoh     ,"Sounds/Doh.wav"       ,FSOUND_LOOP_OFF)
    LoadSound(sndDohHit  ,"Sounds/DohHit.wav"    ,FSOUND_LOOP_OFF)
    LoadSound(sndDohBreak,"Sounds/DohBreak.wav"  ,FSOUND_LOOP_OFF)
    LoadSound(sndLaser   ,"Sounds/Laser.wav"     ,FSOUND_LOOP_OFF)
    LoadSound(sndBounce  ,"Sounds/Bounce2.wav"   ,FSOUND_LOOP_OFF)
    LoadSound(sndWarp    ,"Sounds/Warp.wav"      ,FSOUND_LOOP_BIDI)  
    LoadSound(sndShipBrk ,"Sounds/ShipBreak.wav" ,FSOUND_LOOP_OFF)
    LoadSound(sndAlienBrk,"Sounds/AlienBreak.wav",FSOUND_LOOP_OFF)  
    LoadSound(VocBeam    ,"Voices/BeamUp.wav"    ,FSOUND_LOOP_OFF)
    LoadSound(VocCatch   ,"Voices/Catch.wav"     ,FSOUND_LOOP_OFF)
    LoadSound(VocDup     ,"Voices/Duplicate.wav" ,FSOUND_LOOP_OFF)
    LoadSound(VocExt     ,"Voices/Extend.wav"    ,FSOUND_LOOP_OFF)
    LoadSound(VocLaser   ,"Voices/LaserGun.wav"    ,FSOUND_LOOP_OFF)
    LoadSound(VocPlus    ,"Voices/ExtraLife.wav" ,FSOUND_LOOP_OFF)
    LoadSound(VocSlow    ,"Voices/SlowDown.wav"  ,FSOUND_LOOP_OFF)   
    LoadSound(sndRound   ,"Music/105-Begin.wav"  ,FSOUND_LOOP_OFF)
    LoadSound(sndGameOver,"Music/98-GameOver.wav",FSOUND_LOOP_OFF)  
    if Fail then Sleep
  end if
  
  printf(!"Loading Graphics...\n")
  Font = ImageCreate(64,64): Explode = Font
  Grap = ImageCreate(64,64)
  Back = ImageCreate(256,192)
  
  Stars = ImageCreate(256,256,rgb(0,0,0))
  Doh = ImageCreate(128,128)
  Aliens = ImageCreate(128,64)
  
  FileName = "InTitle.bmp": printf FileName & !"\n"
  if InTitle then bload FileName,InTitle
  FileName = "Font.bmp": printf FileName & !"\n"
  bload FileName,Font
  FileName = "Aliens.bmp": printf FileName & !"\n"
  bload FileName,Aliens
  
  printf !"Game Start...\n"
end scope

const ShipY = 175
dim shared as short CurrentLevel=1,RoundPieces=0
dim shared as short MapStart,MapSize,RoundAlpha=0
dim shared as double Sync
dim shared LevelMap(15,10) as RoundData, MapAlpha(15,10) as single
dim shared MapShake(15,10) as byte
dim shared tBall(15) as BallData, tPowerUp(7) as PowerUpData
dim shared as short ShipX=95,ShipSz=12,ShipLives=3
dim shared as short SkipFrame,SkipFrame2,FrameWrap,Difficulty
dim shared as short ShipBreak=-1,ShipOffX=0,IgnoreButton,xDIFF
dim shared as short OldShipType, OldShipSz, ShipType, ShipFrames
dim shared as short AutoCatch,ExitWarp,WarpOffset,GameOn
dim shared as short DohX,DohY,DohFlash,DohLives,AlienCount
dim shared as short NewAlienLeft,NewAlienRight,IsPause
dim shared as single BallSpeed
dim shared as short BallCount = 1, BallCatch = 0, BallSmooth = 1
dim shared as short ShowRound=511,LockMouse=1,iButDown,UseMouse=1,OldMX
dim shared as integer iMX,iMY,iMB,iNX,iNY,iNB
dim shared as integer ShowScore,NewScore,ScoreBonus,LastScore
dim shared as short PowerUpRate,PowerUpCheck,FirstCatch,CatchOffset
dim shared as short LaserX(3),LaserY(3),LaserOffset(3),LastLaser
dim shared as single WarpAngle(8) = {0.1,1.2,1.9,2.8,4,5.3,6.1,7}
dim shared as string Key,sOldCode
dim shared as single StarAng(15),StarSpd(15),StarOffX,StarOffY
dim shared as Fragment tDohBlow(11,7),tDohShot(2)
dim shared tAlien(7) as AlienStruct , AlienSz(3) as short = {6,7,5,7}
dim shared as single MinSpeed=1.501,MouseAdjustX,MouseAdjustY
dim shared as HighScoreStruct HighScore

randomize()
ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,sOldCode,0)
#define FullFrames

do
  
  CurrentLevel=1:RoundPieces=0:MapStart=0:MapSize=0:RoundAlpha=0
  ShipLives=3:ShipX=95:ShipSz=12:SkipFrame=0:SkipFrame2=0:Difficulty=0
  ShipBreak=-1:ShipOffX=0:IgnoreButton=0:xDIFF=0:OldShipType=0:OldShipSz=0
  ShipType=0:ShipFrames=0:AutoCatch=0:ExitWarp=0:WarpOffset=0:GameOn=0
  DohX=0:DohY=0:DohFlash=0:DohLives=0:AlienCount=0:IsPause=0:BallCatch=0
  NewAlienLeft=-1:NewAlienRight=0:BallSpeed=0:BallCount=1:BallSmooth=1
  ShowRound=511:LockMouse=1:iButDown=0:UseMouse=1:OldMX=0:LastScore=0
  iMX=0:iMY=0:iMB=0:iNX=0:iNY=0:iNB=0:ShowScore=0:NewScore=0:ScoreBOnus=0
  PowerUpRate=0:PowerUpCheck=0:FirstCatch=0:CatchOffset=0:StarOffY=0  
  
  Intro()
  #ifdef __FB_NDS__
  lcdMainOnTop()
  #endif
  InGame() 
  
loop

sub Intro(IntroMode as integer=0)    
  dim as any ptr White  
  White = ImageCreate(512,512,rgb(255,255,255))
  #ifdef __FB_NDS__
  put(0,0),Back,alpha,1  
  put(0,0),Stars,alpha,1
  put(0,0),Font,alpha,1
  put(0,0),White,alpha,1
  line(0,0)-(255,191),0,bf
  White = reallocate(White,1024)
  flip: screensync  
  lcdMainOnBottom()  
  #endif
  
  AlienCount = 7: GameOn = 0
  for CNT as integer = 0 to AlienCount
    dim as integer AlienType = CNT and 3    
    with tAlien(CNT)
      .iFrame = 0
      .iOldFrame = 0
      .fX = 16+rnd*224
      .fY = 16+rnd*160
      .iType = AlienType shl 3
      .iLast = AlienSz(AlienType)
      .iSpd = ((AlienType and 1) xor 1)            
      .fAng = (rnd*360)*PI
      .fSX = sin(.fAng)/4
      .fSY -= cos(.fAng)/4
    end with    
  next CNT
  
  while len(inkey)
    sleep 0,1
  wend
  dim as integer IntroFrames=0,MusChan(1),ChanNum '1024
  dim pMenu as zstring ptr ptr
  dim as short MenuCount,MenuSelect,MenuChoose
  dim as integer BlackFrame,KeyFrame
  dim as short StarX,StarY,NewHighScore
  dim as single MenuOffset,MenuTarget
  dim as zstring ptr MainMenu(...) = { _
  @"Main Menu",@"New Game",@"Continue",@"HighScores",@"Options",@"Quit"}
  dim as zstring ptr NewGameMenu(...) = { _
  @"Select Difficulty",@" Easy ",@"Medium",@" Hard "}
  dim as zstring ptr ContinueMenu(...) = { _
  @"Enter Continue Code",@"#3F7FFF|" }  
  #ifndef __FB_NDS__  
  dim as zstring ptr OptionsMenu(...) = { _
  @"Options",@"Video Scale",@"Video Render", _
  @"Video Filter", @"Volume Levels" }
  dim as zstring ptr VideoScaleMenu(...) = { _
  @"Video Scale",@"1x 256x192",@"2x 512x384",@"4x 1024x768" }
  dim as zstring ptr VideoRenderMenu(...) = { _
  @"Video Render", @"GDI Window", @"GDI Fullscreen", _
  @"OpenGL Window",@"OpenGL Maximum", _
  @"DDraw Window",@"DDraw Maximum" }  
  dim as zstring ptr VideoFilterMenu(...) = { _
  @"Video Filter", @"Resize2x-4x", @"HQ2x-4x", @"Rgb2x-4x" }  
  #else
  dim as zstring ptr OptionsMenu(...) = { _
  @"Options",@"Volume Levels",@"Screen Select" }  
  dim as zstring ptr ScreenSelectMenu(...) = { _
  @"Screen Select",@"Top Screen",@"Bottom Screen" }
  #endif
  dim as zstring ptr VolumeLevelsMenu(...) = { _
  @"Volume Levels",@"Mute",@"Low",@"Medium",@"High",@"Full"}
  
  dim as string EpiText,TextTemp
  dim as string TextBuff,TextBuff2
  static as string*8 CurColor(7) = { _
  "#000000|","#00FF00|","#FFFF00|","#0000FF|", _
  "#FF0000|","#FFFFFF|","#00FFFF|","#FF7F3F|" }
  
  pMenu = @MainMenu(0): MenuCount = 4
  MenuTarget = 0: MenuSelect = 0: MenuOffset = -256
  
  #ifdef __FB_NDS__
  #define KeyUp()     fb.SC_ButtonUP  , fb.SC_ButtonL
  #define KeyDown()   fb.SC_ButtonDown, fb.SC_ButtonR
  #define KeyChoose() Key[0] = 13 or Key[1] = fb.SC_ButtonStart or Key[1] = fb.SC_ButtonA
  #define KeyBack()   Key[0] = 27 or Key[1] = fb.SC_ButtonSelect or Key[1] = fb.SC_ButtonB        
  #define KeyBackSpace() 8,-fb.SC_ButtonX
  #else
  #define KeyUp()     fb.SC_UP
  #define KeyDown()   fb.SC_Down
  #define KeyChoose() Key[0] = 13
  #define KeyBack()   Key[0] = 27
  #define KeyBackSpace() 8
  #endif
  
  do    
    dim as string Key = inkey$
    if len(Key) andalso Key[1] = asc("k") then end
    
    screenlock2    
    
    select case IntroMode
    case 0 'Intro/Menu
      select case IntroFrames
      case 0 to 255      'Background IN
        if IntroFrames = 0 then
          FileName = "Arcade.bmp": printf FileName & !"\n"
          bload FileName,Stars  
          FileName = "Logo.bmp": printf FileName & !"\n"  
          line Back,(0,0)-(255,191),rgb(255,255,255),bf
          bload FileName,Back
        end if
        dim as integer Temp = IntroFrames+(IntroFrames shr 1)
        if Temp > 253 then IntroFrames=384
        line Buff,(0,0)-(255,191),rgb(0,0,0),bf
        put Buff,(0,0),Stars,(0,0)-(255,191),alpha,Temp
        if len(Key) then IntroFrames=255
      case 256 to 511    'Background Wait
        put Buff,(0,0),Stars,(0,0)-(255,191),pset      
        if len(Key) then IntroFrames=511
      case 512 to 639    'Mysoft Logo IN
        put Buff,(0,0),Stars,(0,0)-(255,191),pset
        put Buff,(0,49),Back,(0,0)-(255,92),alpha,(IntroFrames-512) shl 1      
        if len(Key) then IntroFrames=639
      case 640 to 959    'Logo Wait
        put Buff,(0,0),Stars,(0,0)-(255,191),pset
        put Buff,(0,49),Back,(0,0)-(255,92),trans
        if len(Key) then IntroFrames=959
      case 960 to 1023   'Screen White IN
        put Buff,(0,0),Stars,(0,0)-(255,191),trans
        put Buff,(0,49),Back,(0,0)-(255,92),trans
        put Buff,(0,0),White,(0,0)-(255,191),Alpha,(IntroFrames-960) shl 2
        if len(Key) then IntroFrames=1023
      case 1024 to 1279  'Menu Appearing
        if IntroFrames = 1024 then
          CreateStars()
          FileName = "Title.bmp": printf FileName & !"\n"
          bload FileName,Back
          scope
            dim as integer Fail
            if NoSound=0 then
              MusTheme = FSOUND_Sample_Load(FSOUND_FREE,"Music/104-Theme.wav",FSOUND_NORMAL or FSOUND_LOOP_OFF,0,0)
              if MusTheme = 0 then Fail=1:print "Failed to load: " "Music/104-Theme.wav"    
            end if
            if Fail then Sleep          
          end scope                
        end if
        if IntroFrames = 1136 then
          if MusTheme then 
            FSOUND_Sample_SetDefaults(MusTheme,-1,255,128,-1)
            MusChan(0) = FSOUND_PlaySound(FSOUND_FREE,MusTheme)
          end if
        end if
        dim as integer OffX = -128+(sin(IntroFrames*(1/256)))*128
        dim as integer OffY = -128+(cos(IntroFrames*(1/220)))*128
        for Y as integer = OffY to 255 step 256
          for X as integer = OffX to 255 step 256
            put Buff,(X,Y),Stars,pset
          next X
        next Y
        UpdateAliens()
        dim as integer Temp = cos((IntroFrames-1024)*(PI*(90/256))+.5)*184
        if Temp < 0 then Temp = 0      
        put Buff,(8,8+Temp),Back,(0,0)-(239,38),trans      
        put Buff,(0,0),White,(0,0)-(255,191),Alpha,(1279-IntroFrames)
        if len(Key) then 
          if IntroFrames < 1136 then IntroFrames = 1135 else IntroFrames=1279
        end if
      case else          'Menu Controls
        scope 'Menu Anim
          if IntroFrames=1280 then        
            #ifndef __FB_NDS__
            line White,(0,0)-(255,191),rgb(0,0,0),bf
            #endif
            BlackFrame = 0
          end if      
          if ((IntroFrames-1136) and 511)=0 andalso MusTheme then
            ChanNum xor= 1
            FSOUND_Sample_SetDefaults(MusTheme,-1,180,128,-1)
            MusChan(ChanNum) = FSOUND_PlaySound(FSOUND_FREE,MusTheme)        
          end if
          dim as integer OffX = -128+(sin(IntroFrames*(1/256)))*128
          dim as integer OffY = -128+(cos(IntroFrames*(1/220)))*128
          for Y as integer = OffY to 255 step 256
            for X as integer = OffX to 255 step 256
              put Buff,(X,Y),Stars,pset
            next X
          next Y
          UpdateAliens()
          put Buff,(8,8),Back,(0,0)-(239,38),trans            
        end scope
        scope 'Menu Draw
          dim as string TempMenu = **pMenu
          var X = (128-(len(TempMenu) shl 2))-MenuOffset
          DrwTxt(X,75,TempMenu,rgb(0,255,0))
          if iButDown = 1 and MenuChoose = 0 then
            if iMX >= X and iMY >= 75 then
              if iMY <= 82 and iMX <= X+(len(TempMenu) shl 3) then                
                if sndHit then
                  FSOUND_Sample_SetDefaults(sndHit,-1,64,128,-1)
                  FSOUND_PlaySound(FSOUND_FREE,sndHit)        
                end if
                MenuSelect = -1:MenuChoose = 1: MenuTarget = 256
              end if
            end if
          end if
          
          for CNT as integer = 0 to MenuCount
            dim as short X=90+MenuOffset,Y=100+CNT*15
            dim as uinteger iColor = rgb(255,255,255)
            if MenuSelect = CNT then
              iColor = rgb(63,127,255): X += sin(IntroFrames/8)*4
            end if
            if abs(MenuOffset-MenuTarget) > .1 then 
              if CNT = 0 then
                dim as single NewOffset = ((MenuOffset*7)+MenuTarget)*(1/8)
                if abs(NewOffset-MenuOffset) < .1 then 
                  Menuoffset=MenuTarget 
                else 
                  MenuOffset=NewOffset        
                end if
              end if
              Y += sin(MenuOffset/(32+CNT))*12
            end if
            dim as string sTemp = *(pMenu[CNT+1])
            if MenuCount > 0 then
              if iButDown = 1 and MenuChoose = 0 then
                if iMX >= X and iMY >= Y then
                  if iMY <= Y+7 then
                    if iMX <= X+(len(sTemp) shl 3) then
                      if MenuSelect = CNT then
                        if sndBounce then
                          FSOUND_Sample_SetDefaults(sndBounce,-1,64,128,-1)
                          FSOUND_PlaySound(FSOUND_FREE,sndBounce)        
                        end if                    
                        MenuChoose = 1: MenuTarget = 256                    
                      else
                        if sndBrick then
                          FSOUND_Sample_SetDefaults(sndBrick,-1,64,128,-1)
                          FSOUND_PlaySound(FSOUND_FREE,sndBrick)        
                        end if
                        MenuSelect = CNT
                      end if                  
                    end if
                  end if
                end if
              end if
              DrwTxt(X,Y,sTemp,iColor)
            else
              X = 128+MenuOffset-((len(sTemp)+2) shl 2)
              sTemp += CurColor((IntroFrames shr 2) and 7)               
              DrwTxt(X,Y,sTemp,rgb(255,255,255))
              if len(TextBuff2) then
                dim as integer iSz = len(TextBuff2)
                for CNT as integer = 0 to iSz-1
                  if TextBuff2[CNT] = asc("#") then iSz -= 7
                next CNT
                X = 128+MenuOffset-(Isz shl 2)
                Y = 100+(CNT+2)*15
                DrwTxt(X,Y,TextBuff2,rgb(255,255,255))
              end if
            end if          
          next CNT
        end scope        
        scope 'Menu Specials
          select case pMenu
          case @ContinueMenu(0)
            if len(Key) then
              dim as integer iKey
              if len(Key)=1 then iKey = Key[0] else iKey = -Key[1]
              select case iKey
              case KeyBackSpace()
                if len(TextBuff) then
                  TextBuff2 = ""
                  if len(TextBuff) <> 5 then
                    TextBuff = left(TextBuff,len(TextBuff)-1)
                  else
                    TextBuff = left(TextBuff,len(TextBuff)-2)
                  end if
                end if
              case asc("A") to asc("Z"), asc("0") to asc("9")
                if len(TextBuff) < 9 then TextBuff += Key
                if len(TextBuff) = 4 then TextBuff += "-"
              case asc("a") to asc("z")
                Key[0] xor= 32
                if len(TextBuff) < 9 then TextBuff += Key
                if len(TextBuff) = 4 then TextBuff += "-"
              end select
              ContinueMenu(1) = strptr(TextBuff)
              if len(TextBuff) = 9 then
                dim as integer iScore
                dim as short iDiff,iLevel,iLives                
                if ConvertPassword(iScore,iDiff,iLevel,iLives,TextBuff,1) then
                  TextBuff2 = "#FF0000Invalid Code"
                else
                  TextBuff2 = "#3FFF7FLevel " & iLevel & " - " & trim$(*NewGameMenu(iDiff+1))
                end if
              end if
            end if
          end select
        end scope        
        scope 'Menu Controls
          getmouse iNX,iNY,,iNB
          #ifndef __FB_NDS__
          if ScrRender=3 or ScrRender=5 then 
            iNX *= MouseAdjustX: iNY *= MouseAdjustY
          end if
          #endif
          if iNB <> -1 then            
            iMX = iNX shr ScrDouble
            iMY = iNY shr ScrDouble
            iMB = iNB
          end if
          if iButDown > 0 then iButDown = -1
          if (iMB and 1) then            
            if iButDown = 0 then iButDown = 1
          else
            iButDown = 0
          end if
          
          if MenuChoose = 0 then          
            if len(Key) then 
              select case Key[1]
              case KeyUp()
                if sndBrick then
                  FSOUND_Sample_SetDefaults(sndBrick,-1,64,128,-1)
                  FSOUND_PlaySound(FSOUND_FREE,sndBrick)        
                end if
                if MenuSelect = 0 then MenuSelect=MenuCount else MenuSelect -= 1
              case KeyDown()
                FSOUND_Sample_SetDefaults(sndBrick,-1,64,128,-1)
                FSOUND_PlaySound(FSOUND_FREE,sndBrick)        
                if MenuSelect = MenuCount then MenuSelect=0 else MenuSelect += 1
              end select
              if KeyChoose() then
                if sndBounce then
                  FSOUND_Sample_SetDefaults(sndBounce,-1,64,128,-1)
                  FSOUND_PlaySound(FSOUND_FREE,sndBounce)        
                end if
                MenuChoose = 1: MenuTarget = 256
              elseif KeyBack() then
                if sndHit then
                  FSOUND_Sample_SetDefaults(sndHit,-1,64,128,-1)
                  FSOUND_PlaySound(FSOUND_FREE,sndHit)        
                end if
                MenuSelect = -1:MenuChoose = 1: MenuTarget = 256
              end if
            end if
          end if
        end scope        
        scope 'Menu Selection
          if BlackFrame then
            
            #ifdef __FB_NDS__          
            if len(Key)=0 andalso fb.KeyboardIsON then
              dim as integer CNT
              for CNT=-255 to 255
                if multikey(CNT) then exit for
              next CNT
              if CNT>255 then
                fb.KeyboardIsON = 0    
                lcdMainOnBottom()
              end if          
            end if
            #endif
            
            if (IntroFrames-BlackFrame) > 127 then 
              if MusTheme then
                if MusChan(0) then FSound_StopSound(MusChan(0))
                if MusChan(1) then FSound_StopSound(MusChan(1))
                FSOUND_Sample_Free(MusTheme)
              end if
              if MenuChoose = -2 then
                IntroFrames = 0: IntroMode = 1: continue do
              elseif MenuChoose = -3 then
                IntroFrames = 0: IntroMode = 3: continue do
              else              
                exit do
              end if
            end if
            #ifdef __FB_NDS__
            gfx.TextureColor = 0
            put Buff,(0,0),White,(0,0)-(255,191),alpha,(IntroFrames-BlackFrame) shl 1
            gfx.TextureColor = -1
            #else
            put Buff,(0,0),White,(0,0)-(255,191),alpha,(IntroFrames-BlackFrame) shl 1
            #endif
          else
            if abs(MenuOffset-256) < .1 then            
              select case pMenu
              case @MainMenu(0)      '------ Main Menu ------
                select case MenuSelect
                case 0    'New Game
                  pMenu = @NewGameMenu(0): MenuCount = 2: MenuSelect = 1
                case 1    'Continue
                  pMenu = @ContinueMenu(0)
                  TextBuff = sOldCode : MenuCount = 0: MenuSelect = 0
                  ContinueMenu(1) = strptr(TextBuff)                  	
                  if len(TextBuff) = 9 then
                    dim as integer iScore
                    dim as short iDiff,iLevel,iLives                
                    if ConvertPassword(iScore,iDiff,iLevel,iLives,TextBuff,1) then
                      TextBuff2 = "#FF0000Invalid Code"
                    else
                      TextBuff2 = "#3FFF7FLevel " & iLevel & " - " & trim$(*NewGameMenu(iDiff+1))
                    end if
                  end if
                  #ifdef __FB_NDS__                  
                  for CNT as integer = 0 to 24: print: next
                  fb_ShowKeyboard():fb.KeyboardIsON = 1
                  lcdMainOnTop(): locate 1,1
                  #endif
                case 2    'HighScores
                  BlackFrame = IntroFrames: MenuChoose = -3                  
                case 3    'Options
                  #ifdef __FB_NDS__
                  pMenu = @OptionsMenu(0): MenuCount = 1
                  #else
                  pMenu = @OptionsMenu(0): MenuCount = 3
                  #endif
                  MenuSelect = 0
                case -1,4 'Quit
                  end
                end select
              case @NewGameMenu(0)     '---- New Game Menu ----
                select case MenuSelect
                case 0 'Easy
                  MinSpeed=1.501: Difficulty = 0: BlackFrame = IntroFrames: MenuChoose = -2
                  ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,sOldCode,0)
                case 1 'Medium
                  MinSpeed=1.751: Difficulty = 1: BlackFrame = IntroFrames: MenuChoose = -2
                  ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,sOldCode,0)
                case 2 'Hard
                  MinSpeed=2.001: Difficulty = 2: BlackFrame = IntroFrames: MenuChoose = -2
                  ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,sOldCode,0)
                case -1'Back
                  pMenu = @MainMenu(0): MenuCount = 4: MenuSelect = 1
                end select
              case @ContinueMenu(0)    '---- Continue Menu ----
                select case MenuSelect                            
                case -1   'Back
                  pMenu = @MainMenu(0): MenuCount = 4: MenuSelect = 1
                  #ifdef __FB_NDS__
                  fb_HideKeyboard(): fb.KeyboardIsON = 0
                  lcdMainOnBottom()
                  #endif
                case else 'Check password?
                  if Len(TextBuff) = 9 then
                    if ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,TextBuff,1) = 0 then
                      BlackFrame = IntroFrames: MenuChoose = -4
                      pMenu = @NewGameMenu(0): MenuCount = 2: MenuSelect = Difficulty
                      TextBuff2 = "#00FFFFReady": sOldCode = TextBuff
                      select case Difficulty
                      case 0: MinSpeed=1.501
                      case 1: MinSpeed=1.751
                      case 2: MinSpeed=2.001
                      end select
                      #ifdef __FB_NDS__
                      fb_HideKeyboard()
                      #endif
                    end if
                  end if        
                end select
              case @OptionsMenu(0)     '---- Options  Menu ----
                #ifndef __FB_NDS__
                select case MenuSelect
                case -1   'Back
                  pMenu = @MainMenu(0): MenuCount = 4
                  MenuSelect = 3: SaveConfig()
                case 0    'Video Scale
                  pMenu = @VideoScaleMenu(0)
                  MenuCount = 2: MenuSelect = ScrDouble
                case 1    'Video Render
                  pMenu = @VideoRenderMenu(0)
                  MenuCount = 5: MenuSelect = scrRender
                case 2    'Video Filter
                  pMenu = @VideoFilterMenu(0)
                  MenuCount = 2: MenuSelect = scrFilter
                case 3    'Volume Levels
                  pMenu = @VolumeLevelsMenu(0)
                  MenuCount = 4: MenuSelect = sndVol
                end select
                #else
                select case MenuSelect
                case -1   'Back
                  pMenu = @MainMenu(0): MenuCount = 4: MenuSelect = 3
                  SaveConfig()
                case 0    'Volume Levels
                  pMenu = @VolumeLevelsMenu(0)
                  MenuCount = 4: MenuSelect = sndVol
                case 1    'Screen Select
                  pMenu = @ScreenSelectMenu(0): MenuCount = 1
                  MenuSelect = DSisTOP xor 1
                end select
                #endif
                #ifndef __FB_NDS__
              case @VideoScaleMenu(0)    '---- Video Scale  Menu ----
                select case MenuSelect
                case -1     'Back
                  pMenu = @OptionsMenu(0): MenuCount = 3: MenuSelect = 0
                case 0 to 2 'Size Selected
                  ScrDouble = MenuSelect: VideoInit()
                end select
              case @VideoRenderMenu(0)   '---- Video Render Menu ----
                select case MenuSelect
                case -1     'Back
                  pMenu = @OptionsMenu(0): MenuCount = 3: MenuSelect = 1
                case 0 to 5 'Render Selected
                  ScrRender = MenuSelect: VideoInit()
                end select
              case @VideoFilterMenu(0)   '---- Video Filter Menu ----
                select case MenuSelect
                case -1     'Back
                  pMenu = @OptionsMenu(0)
                  MenuCount = 3: MenuSelect = 2
                case 0 to 2 'Filter Selected
                  ScrFilter = MenuSelect
                end select
                #else
              case @ScreenSelectMenu(0)
                select case MenuSelect
                case -1   'Back
                  pMenu = @OptionsMenu(0): MenuCount = 1: MenuSelect = 1
                case 0,1  'Screen Selected
                  DSisTop = MenuSelect xor 1
                end select
                #endif
              case @VolumeLevelsMenu(0)
                select case MenuSelect
                case -1     'Back
                  pMenu = @OptionsMenu(0): MenuCount = 3
                  #ifdef __FB_NDS__
                  MenuSelect = 0
                  #else
                  MenuSelect = 3
                  #endif
                case 0 to 4 'Volume Selected
                  sndVol = MenuSelect
                  #ifdef __FB_NDS__
                  dim as integer Snd = (*cptr(uinteger ptr,&h4000500)) and &h7F
                  *cptr(uinteger ptr,&h4000500) = Snd or ((SndVol shl 5)-(sndVol shl 2))
                  #else
                  FSOUND_SetSFXMasterVolume((sndVol shl 6)-(sndVol shl 2))
                  #endif
                end select
              end select            
              if MenuChoose >= -1 then
                MenuOffset = -256: MenuTarget = 0: MenuChoose = 0
              end if              
            end if 
          end if
          
        end scope
      end select      
    case 1 'Epilogue
      if len(EpiText) = 0 then EpiText = _
      "The era, and time of this story#" _
      "is unknown After the mothership#" _
      "arkanoid was destroyed a craft#"  _
      "VAUS scrambled away from it.#"    _
      "But only to be trapped in space#" _
      "by someone."
      #define MotherShip back
      select case IntroFrames
      case 0 to 127        
        if IntroFrames=0 then
          dim as integer Fail
          if NoSound = 0 then
            MusStory = FSOUND_Sample_Load(FSOUND_FREE,"Music/92-Epilogue.wav",FSOUND_NORMAL or FSOUND_LOOP_NORMAL,0,0)
            if MusStory = 0 then Fail=1:print "Failed to load: " "Music/92-Epilogue.wav"
            FSOUND_Sample_SetDefaults(MusStory,-1,180,0,-1)
            MusChan(0) = FSOUND_PlaySound(FSOUND_FREE,MusStory)
          end if
          FileName = "Mothership.bmp": printf FileName & !"\n"
          bload FileName,MotherShip
          CreateStars()
          #ifndef __FB_NDS__
          line White,(0,0)-(255,191),rgb(0,0,0),bf
          #endif
        end if
        StarX = (StarX+1) and 255: StarY = (StarY-1) and 255        
        for Y as integer = -StarY to 255 step 256
          for X as integer = -StarX to 255 step 256
            put Buff,(X,Y),Stars,pset
          next X
        next Y
        dim as integer Offset = sin(IntroFrames/32)*3
        put Buff,(40+Offset,80+Offset),MotherShip,(0,0)-(175,94),trans
        #ifdef __FB_NDS__
        gfx.TextureColor = 0
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        gfx.TextureColor = -1
        #else
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        #endif
        if len(Key) then IntroFrames=127
      case 128 to (20*62)+127
        '19*60
        if IntroFrames = 128 then
          if NoSound = 0 then
            SndVoice = FSOUND_Sample_Load(FSOUND_FREE,"Voices/Story.wav",FSOUND_NORMAL or FSOUND_LOOP_OFF,0,0)
            if SndVoice = 0 then print "Failed to load: " "Voices/Story.wav"        
            if SndVoice then 
              FSOUND_Sample_SetDefaults(SndVoice,-1,255,255,-1)
              MusChan(1) = FSOUND_PlaySound(FSOUND_FREE,SndVoice)
            end if
          end if
        end if
        StarX = (StarX+1) and 255: StarY = (StarY-1) and 255        
        for Y as integer = -StarY to 255 step 256
          for X as integer = -StarX to 255 step 256
            put Buff,(X,Y),Stars,pset
          next X
        next Y
        dim as integer Offset = sin(IntroFrames/32)*3
        put Buff,(40+Offset,80+Offset),MotherShip,(0,0)-(175,94),trans
        dim as integer LenX = (IntroFrames-128)*(len(EpiText)/(17*59))
        dim as integer LineCount,LinePos(7),LineSize(7),Posi
        TextTemp = left$(EpiText,LenX+1): LinePos(0) = 1
        do
          Posi = instr(LinePos(LineCount),TextTemp,"#")
          if Posi then
            LineSize(LineCount) = (Posi-LinePos(LineCount))
            LineCount += 1: LinePos(LineCount) = Posi+1
          else
            LineSize(LineCount) = (len(TextTemp)-LinePos(LineCount))+1
            exit do
          end if
        loop
        Posi = LineCount-2: if Posi < 0 then Posi = 0
        dim as integer PosY = 8
        for CNT as integer = Posi to LineCount
          DrwTxt(4,PosY,mid$(TextTemp,LinePos(CNT),LineSize(CNT)),rgb(85,85,255))
          Posy += 12
        next CNT
        
        if IntroFrames >= (20*62) then
          dim as integer iAlpha = (IntroFrames-(20*62)) shl 1
          #ifdef __FB_NDS__
          gfx.TextureColor = 0
          put Buff,(0,0),White,(0,0)-(255,191),alpha,iAlpha
          gfx.TextureColor = -1
          #else
          put Buff,(0,0),White,(0,0)-(255,191),alpha,iAlpha
          #endif
          if SndVoice then
            FSOUND_SetVolume(MusChan(1),(255-iAlpha)*(180/255))
          end if
        end if        
        if len(Key) andalso IntroFrames < (20*62) then           
          IntroFrames=(20*62)-1
          if SndVoice then FSound_StopSound(MusChan(1))
        end if        
      case else
        if MusStory then FSound_StopSound(MusChan(0)):FSOUND_Sample_Free(MusStory):MusStory=0
        if SndVoice then FSound_StopSound(MusChan(1)):FSOUND_Sample_Free(SndVoice):SndVoice=0
        exit do
      end select
    case 2 'Ending
      if len(EpiText) = 0 then EpiText = _
      "The dimension controlling fort#"  _
      "DOH has now been destroyed and#"  _
      "time started flowing backwards.#" _
      "VAUS managed to escape from the#" _
      "Distorted Space. But the voyage#" _
      "of ARKANOID in the galaxy has#"   _
      "only now started."
      #define MotherShip back
      select case IntroFrames
      case 0 to 127        
        if IntroFrames=0 then
          dim as integer Fail
          if NoSound = 0 then
            MusStory = FSOUND_Sample_Load(FSOUND_FREE,"Music/92-Epilogue.wav",FSOUND_NORMAL or FSOUND_LOOP_NORMAL,0,0)
            if MusStory = 0 then Fail=1:print "Failed to load: " "Music/92-Epilogue.wav"
            FSOUND_Sample_SetDefaults(MusStory,-1,180,0,-1)
            MusChan(0) = FSOUND_PlaySound(FSOUND_FREE,MusStory)
          end if
          FileName = "Mothership.bmp": printf FileName & !"\n"
          bload FileName,MotherShip
          CreateStars()
          #ifndef __FB_NDS__
          line White,(0,0)-(255,191),rgb(0,0,0),bf
          #endif
        end if
        StarX = (StarX+1) and 255: StarY = (StarY-1) and 255        
        for Y as integer = -StarY to 255 step 256
          for X as integer = -StarX to 255 step 256
            put Buff,(X,Y),Stars,pset
          next X
        next Y
        dim as integer Offset = sin(IntroFrames/32)*3
        put Buff,(40+Offset,80+Offset),MotherShip,(0,0)-(175,94),trans
        #ifdef __FB_NDS__
        gfx.TextureColor = 0
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        gfx.TextureColor = -1
        #else
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        #endif
        if len(Key) then IntroFrames=127
      case 128 to (24*62)+127
        '19*60
        if IntroFrames = 128 then
          if NoSound = 0 then
            SndVoice = FSOUND_Sample_Load(FSOUND_FREE,"Voices/Ending.wav",FSOUND_NORMAL or FSOUND_LOOP_OFF,0,0)
            if SndVoice = 0 then print "Failed to load: " "Voices/Ending.wav"        
            if SndVoice then 
              FSOUND_Sample_SetDefaults(SndVoice,-1,255,255,-1)
              MusChan(1) = FSOUND_PlaySound(FSOUND_FREE,SndVoice)
            end if
          end if
        end if
        StarX = (StarX+1) and 255: StarY = (StarY-1) and 255        
        for Y as integer = -StarY to 255 step 256
          for X as integer = -StarX to 255 step 256
            put Buff,(X,Y),Stars,pset
          next X
        next Y
        dim as integer Offset = sin(IntroFrames/32)*3
        put Buff,(40+Offset,80+Offset),MotherShip,(0,0)-(175,94),trans
        dim as integer LenX = (IntroFrames-128)*(len(EpiText)/(21*59))
        dim as integer LineCount,LinePos(7),LineSize(7),Posi
        TextTemp = left$(EpiText,LenX+1): LinePos(0) = 1
        do
          Posi = instr(LinePos(LineCount),TextTemp,"#")
          if Posi then
            LineSize(LineCount) = (Posi-LinePos(LineCount))
            LineCount += 1: LinePos(LineCount) = Posi+1
          else
            LineSize(LineCount) = (len(TextTemp)-LinePos(LineCount))+1
            exit do
          end if
        loop
        Posi = LineCount-2: if Posi < 0 then Posi = 0
        dim as integer PosY = 8
        for CNT as integer = Posi to LineCount
          DrwTxt(4,PosY,mid$(TextTemp,LinePos(CNT),LineSize(CNT)),rgb(85,85,255))
          Posy += 12
        next CNT
        
        if IntroFrames >= (24*62) then
          dim as integer iAlpha = (IntroFrames-(24*62)) shl 1
          #ifdef __FB_NDS__
          gfx.TextureColor = 0
          put Buff,(0,0),White,(0,0)-(255,191),alpha,iAlpha
          gfx.TextureColor = -1
          #else
          put Buff,(0,0),White,(0,0)-(255,191),alpha,iAlpha
          #endif
          if SndVoice then
            FSOUND_SetVolume(MusChan(1),(255-iAlpha)*(180/255))
          end if
        end if        
        if len(Key) andalso IntroFrames < (24*62) then           
          IntroFrames=(24*62)-1
          if SndVoice then FSound_StopSound(MusChan(1))
        end if        
      case else
        if MusStory then FSound_StopSound(MusChan(0)):FSOUND_Sample_Free(MusStory):MusStory=0
        if SndVoice then FSound_StopSound(MusChan(1)):FSOUND_Sample_Free(SndVoice):SndVoice=0
        exit do
      end select      
    case 3 'HighScores
      if IntroFrames = 0 then
        CreateStars()
        FileName = "Title.bmp": printf FileName & !"\n"
        bload FileName,Back
        scope
          dim as integer Fail
          if NoSound=0 then
            MusTheme = FSOUND_Sample_Load(FSOUND_FREE,"Music/104-Theme.wav",FSOUND_NORMAL or FSOUND_LOOP_OFF,0,0)
            if MusTheme = 0 then Fail=1:print "Failed to load: " "Music/104-Theme.wav"    
          end if
          if Fail then Sleep          
        end scope
        #ifndef __FB_NDS__
        line White,(0,0)-(255,191),rgb(0,0,0),bf
        #endif
        for NewHighScore = 0 to 4
          if HighScore.sName(NewHighScore)[0] = asc("!") then exit for
        next NewHighScore
        TextBuff = "": BlackFrame = 0
        #ifdef __FB_NDS__
        if NewHighScore < 5 then                            
          for CNT as integer = 0 to 24: print: next          
          fb_ShowKeyboard():fb.KeyboardIsON = 1
          lcdMainOnTop(): locate 1,1
        end if
        #endif          
      end if
      if ((IntroFrames) and 511)=0 andalso MusTheme then
        ChanNum xor= 1
        FSOUND_Sample_SetDefaults(MusTheme,-1,180,128,-1)
        MusChan(ChanNum) = FSOUND_PlaySound(FSOUND_FREE,MusTheme)        
      end if        
      dim as integer OffX = -128+(sin(IntroFrames*(1/256)))*128
      dim as integer OffY = -128+(cos(IntroFrames*(1/220)))*128
      for Y as integer = OffY to 255 step 256
        for X as integer = OffX to 255 step 256
          put Buff,(X,Y),Stars,pset
        next X
      next Y
      UpdateAliens()        
      put Buff,(8,8),Back,(0,0)-(239,38),trans      
      
      DrwTxt(20,74,"Name",rgb(63,127,255))
      DrwTxt(108,74,"Round",rgb(63,127,255))
      DrwTxt(196,74,"Score",rgb(63,127,255))
      with HighScore
        for CNT as integer = 0 to 4            
          dim as uinteger iColor = rgb(255,255,255)
          dim as string TextTemp
          if CNT <> NewHighScore then
            TextTemp = .sName(CNT)
            TextTemp = left$(TextTemp,10)
          else
            iColor = rgb(255,127,63)
            TextTemp = TextBuff
            TextTemp += CurColor((IntroFrames shr 2) and 7)
          end if
          DrwTxt(20,94+(CNT shl 4),TextTemp,iColor)
          TextTemp = str$(.iLevel(CNT))            
          DrwTxt(124-((len(TextTemp)-1) shl 2),94+(CNT shl 4),TextTemp,iColor)
          TextTemp = str$(.iScore(CNT))
          TextTemp = string$(6-len(TextTemp),"0")+TextTemp
          DrwTxt(192,94+(CNT shl 4),TextTemp,iColor)
        next CNT
      end with
      
      if NewHighScore <= 4 then
        if len(Key) then '1AOW-6JX0
          dim as integer iKey
          if len(Key)=1 then iKey = Key[0] else iKey = -Key[1]
          #define asc_DOTS asc(":")
          select case iKey
          case 13
            if len(TextBuff) then
              HighScore.sName(NewHighScore) = string$(16,0)
              HighScore.sName(NewHighScore) = TextBuff
              NewHighScore = 5
              #ifdef __FB_NDS__              
              fb_HideKeyboard(): KeyFrame = IntroFrames
              #endif              
            end if
          case KeyBackSpace()
            if len(TextBuff) then              
              TextBuff = left(TextBuff,len(TextBuff)-1)              
            end if
          case asc("0") to asc("9"),asc_DOTS,asc("-")
            if len(TextBuff) < 10 then TextBuff += Key
          case asc("A") to asc("Z"),asc(" ")
            if len(TextBuff) < 10 then TextBuff += Key            
          case asc("a") to asc("z"),asc("."),asc(",")
            if len(TextBuff) < 10 then TextBuff += Key          
          end select
        end if
      else
        if IntroFrames > 127 then
          #ifdef __FB_NDS__          
          if len(Key)=0 andalso fb.KeyboardIsON then
            dim as integer CNT
            for CNT=-255 to 255
              if multikey(CNT) then exit for
            next CNT
            if CNT>255 then
              fb.KeyboardIsON = 0    
              lcdMainOnBottom()
            end if          
          end if
          #endif
          if BlackFrame=0 andalso len(Key)>0 then
            BlackFrame = IntroFrames
          end if
        end if
      end if
      
      if IntroFrames < 127 then
        #ifdef __FB_NDS__
        gfx.TextureColor = 0
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        gfx.TextureColor = -1
        #else
        put Buff,(0,0),White,(0,0)-(255,191),alpha,255-(IntroFrames shl 1)
        #endif
      else
        if BlackFrame then
          dim as integer TempFrame = (IntroFrames-BlackFrame)
          if TempFrame > 127 then             
            if MenuChoose = -3 then
              pMenu = @MainMenu(0): MenuCount = 4
              MenuTarget = 0: MenuSelect = 2: MenuOffset = -256
              MenuChoose = 0: BlackFrame = 0
              IntroFrames = 1280: IntroMode = 0: continue do
            else
              if MusTheme then
                if MusChan(0) then FSound_StopSound(MusChan(0))
                if MusChan(1) then FSound_StopSound(MusChan(1))
                FSOUND_Sample_Free(MusTheme)
              end if
              exit do
            end if
          end if
          #ifdef __FB_NDS__
          gfx.TextureColor = 0
          put Buff,(0,0),White,(0,0)-(255,191),alpha,TempFrame shl 1
          gfx.TextureColor = -1
          #else
          put Buff,(0,0),White,(0,0)-(255,191),alpha,TempFrame shl 1
          #endif
        end if            
      end if    
      if len(Key) then 
        if IntroFrames < 127 then IntroFrames = 127
      end if
    end select
    
    IntroFrames += 1
    #ifndef __FB_NDS__
    UpdateAndSync()  
    screenunlock2
    #else  
    screenunlock2
    UpdateAndSync()
    #endif
    
    SaveCpu()
    
  loop 'until multikey(fb.SC_ESCAPE)
  if White then ImageDestroy(White)  
  
  screenunlock2
  UpdateAndSync()
  do
    if len(inkey) = 0 then exit do  
    screensync
  loop
  
  #ifdef __FB_NDS__          
  do
    if fb.KeyboardIsON = 0 then exit do
    if len(Key)=0 then
      dim as integer CNT
      for CNT=-255 to 255
        if multikey(CNT) then exit for
      next CNT
      if CNT>255 then
        fb.KeyboardIsON = 0    
        lcdMainOnBottom()
        exit do
      end if          
    end if
    screensync
  loop
  #endif
  
  
end sub

sub InGame()
  
  #ifdef __FB_NDS__  
  if DSIsTop then
    lcdMainOnTop()
  else
    lcdMainOnBottom()
  end if
  #endif
  
  tBall(0) = type(0,0,135+rnd*90)
  LoadMap(CurrentLevel,1)
  
  for Y as integer = 0 to 15
    for X as integer = 0 to 10
      MapAlpha(Y,X) = .5+(rnd*.5)
    next X
  next Y
  for CNT as integer = 0 to 15
    StarAng(CNT) = rnd(PI*360)
    StarSpd(CNT) = (-1+rnd*2)/128
  next CNT
  
  FileName = "Graphics.bmp": printf FileName & !"\n"
  bload FileName,Grap  
  FileName = "InGame.bmp": printf FileName & !"\n"
  bload FileName,Back
  CreateStars()
  
  setmouse ,,0,1: screensync
  Sync = timer: GameOn = 1
  
  put Buff,(0,0),Back,pset
  
  do
    
    iMB = 0: FrameWrap += 1
    getmouse iNX,iNY,,iNB
    #ifndef __FB_NDS__
    if ScrRender=3 or ScrRender=5 then 
      iNX *= MouseAdjustX: iNY *= MouseAdjustY
    end if
    #endif
    if LockMouse andalso iNB <> -1 then    
      xDIFF += abs((iNX shr ScrDouble)-(OldMX shr ScrDouble))
      if xDIFF > 32 then 
        if UseMouse=0 then 
          UseMouse=1
          if scrRender=3 or scrRender=5 then
            #ifdef __FB_WIN32__
            SetCursorPos((iMX shl scrDouble)/MouseAdjustX,iNY/MouseAdjustY)
            #endif
          else
            setmouse iMX shl scrDouble,iNY
          end if
        end if
        IgnoreButton = 1: xDIFF = 0
      end if
      if UseMouse then
        iMX = iNX shr ScrDouble: iMY = iNY shr ScrDouble
        iMB = iNB
        if iMX < 9 then 
          iMX = 9
          if scrRender=3 or scrRender=5 then
            #ifdef __FB_WIN32__
            SetCursorPos((iMX shl scrDouble)/MouseAdjustX,iNY/MouseAdjustY)
            #endif
          else
            setmouse iMX shl scrDouble,iNY
          end if
        elseif iMX > 184 then
          iMX = 184
          if scrRender=3 or scrRender=5 then
            #ifdef __FB_WIN32__
            SetCursorPos((iMX shl scrDouble)/MouseAdjustX,iNY/MouseAdjustY)
            #endif
          else
            setmouse iMX shl scrDouble,iNY
          end if
        end if    
      end if
      OldMX = iNX
    end if
    
    ShipX = (iMX+ShipX*3) shr 2  
    if ShipX < (8+ShipSz) then ShipX = (8+ShipSz)
    if ShipX > (184-ShipSz) then ShipX = (184-ShipSz)
    
    if BallCatch >= 0 then
      with tBall(BallCatch)
        .sX = ((.sX+ShipX+CatchOffset) shr 1) xor 1
        .sY = 175-3
      end with
      if FirstCatch then
        CatchOffset += FirstCatch
        if abs(CatchOffset) >= ShipSz then
          FirstCatch = -sgn(CatchOffset)
        end if
      end if
    end if
    
    screenlock2
    #ifdef FullFrames
    put Buff,(0,0),Back,pset
    #else
    if (FrameWrap and 63)=1 then
      put Buff,(0,0),Back,pset
    end if
    #endif
    
    if SkipFrame2=0 then DrawStars()
    UpdatePowerUp()
    UpdateAliens()
    DrawMap()
    
    #ifdef FullFrames
    DrawHud()
    #else
    if ShowRound >0 or (FrameWrap and 1)=1 then
      DrawHud()
    end if
    #endif
    
    if RoundAlpha < 510 then RoundAlpha += 5 
    if ScoreBonus then ScoreBonus -= 1
    
    for CNT as integer = 0 to 2
      if LaserY(CNT) > 0 then
        dim as integer LX = LaserX(CNT)-ShipSz+5
        dim as integer LY = LaserY(CNT)-LaserOffset(CNT)
        line buff,(LX,LY)-(LX,LY+5),rgb(255,85,85)
        LX = LaserX(CNT)+ShipSz-5
        LY = LaserY(CNT)+LaserOffset(CNT)
        line buff,(LX,LY)-(LX,LY+5),rgb(255,85,85)
        LaserUpdate(CNT)    
      end if
    next CNT
    
    select case DrawSprites()
    case -1: screenunlock2: exit do
    case  1: screenunlock2: continue do
    end select
    
    if ShowRound = 0 then    
      for CNT as integer = 0 to BallCount-1    
        DrawBall(CNT)      
        ' Verify Ball Collision
        if BallCatch <> CNT then
          if BallCollision(CNT) then
            screenunlock2: continue do
          end if
        end if                
      next CNT
    end if
    
    if SkipFrame = 0 then
      for CNT as integer = 0 to ShipLives-2
        put Buff,(16+(CNT shl 4),186),Grap,(43,21)-(54,23),pset
      next CNT
      DrwTxt(207,2,left$(str$(BallSpeed)+".00",4),rgb(0,255,255))
    end if
    
    do
      
      #ifndef __FB_NDS__
      UpdateAndSync()  
      screenunlock2
      #else  
      screenunlock2
      UpdateAndSync()  
      #endif
      
      SaveCpu()
      
      Key = inkey$()
      if len(Key) then
        select case Key[1]
        case asc("k")
          end
          #ifdef __FB_NDS__
        case fb.SC_ButtonUP
          'CurrentLevel += 1: LoadMap(CurrentLevel)
          'continue do
        case fb.SC_ButtonA
          if isPause then 
            ShipLives=0: ShowRound = 0: isPause = 0
            LockMouse = 0: setmouse ,,1,0
            Buff=0: bload "InGame.bmp",Back: continue do
          end if
        case fb.SC_ButtonB
          if isPause then 
            isPause = 0:Buff=0
            bload "InGame.bmp",Back
          end if
        case fb.SC_ButtonSELECT
          'BallSmooth xor= 1
          DSIsTop xor= 1
          if DSIsTop then
            lcdMainOnTop()
          else
            lcdMainOnBottom()
          end if
        case fb.SC_BUTTONSTART        
          IsPause xor= 1
          if IsPause then          
            Buff=Back: put Buff,(0,0),Back,pset
            continue do,do          
          else
            Buff=0: bload "InGame.bmp",Back
          end if
          #endif
        end select
        select case Key[0]
        case 9      
          'CurrentLevel += 1: LoadMap(CurrentLevel)
          'continue do
        case 13          
          '#ifndef Render_OpenGL
          'BallSmooth xor= 1
          '#endif
        case 27
          'LockMouse xor= 1
          'if LockMouse then setmouse ,,0,1 else setmouse ,,1,0
          IsPause xor= 1        
          if IsPause then setmouse ,,1,0 else setmouse ,,0,1
        case asc("Y"),asc("y")
          if isPause then 
            ShipLives=0: ShowRound = 0: isPause = 0
            LockMouse = 0: setmouse ,,1,0
          end if
        case asc("N"),asc("n")
          if isPause then isPause = 0        
          LockMouse = 1: setmouse ,,0,1
        end select
      end if
      
    loop While IsPause
    
    #ifndef __FB_NDS__
    IgnoreButton = 0
    if multikey(fb.SC_SPACE) or multikey(fb.SC_ENTER) then iMB = 1  
    if (iMB and 1) then 
      if iButDown = 0 then iButDown = 1
    else
      if iButDown then iButDown = 0
    end if
    #else
    if multikey(fb.SC_ButtonL) or multikey(fb.SC_ButtonR) then 
      IgnoreButton=0:iMB = 1
    end if
    if (iMB and 1) then 
      if iButDown then iButDown = 0: IgnoreButton = 0   
    else
      if iButDown = 0 then iButDown = 1
    end if
    #endif
    
    #ifndef __FB_NDS__
    #define KeyLeft() (multikey(fb.SC_LEFT) or multikey(fb.SC_A))
    #define KeyRight() (multikey(fb.SC_RIGHT) or multikey(fb.SC_D))
    #else
    #define KeyLeft() (multikey(fb.SC_ButtonLEFT) or multikey(fb.SC_ButtonY))
    #define KeyRight() (multikey(fb.SC_ButtonRIGHT) or multikey(fb.SC_ButtonA))
    #endif
    if KeyLeft() then 
      if iMX > 9 then 
        dim as integer TempSpeed = -int(-BallSpeed)
        if TempSpeed < 3 then TempSpeed = 3
        iMX -= TempSpeed: UseMouse = 0
      end if
    elseif KeyRight() then  
      if iMX < 184 then 
        dim as integer TempSpeed = -int(-BallSpeed)
        if TempSpeed < 3 then TempSpeed = 3
        IMX += TempSpeed: UseMouse = 0
      end if      
    end if
    
    if LastLaser then LastLaser -= 1  
    if iButDown = 1 and RoundAlpha >= 510 and IgnoreButton = 0 then    
      xDIFF = 0
      if ShowRound then 
        ShowRound = 0
      else
        if ShipType = 1 and LastLaser=0 and BallCatch < 0 then        
          for CNT as integer = 0 to 2
            if LaserY(CNT) <= 0 then
              if sndLaser then FSOUND_PlaySound(FSOUND_FREE,sndLaser)
              LaserX(CNT) = ShipX
              LaserY(CNT) = ShipY
              LaserOffset(CNT) = -4+int(rnd*9)        
              LastLaser = 10
              exit for
            end if
          next CNT
        end if      
        if BallCatch >=0 and RoundAlpha >= 510 then 
          if FirstCatch then
            with tBall(BallCatch)
              .sAng = 180-(((.sX-ShipX)/ShipSz)*70)
            end with
            FirstCatch = 0          
          end if        
          BallCatch = -1        
        end if      
      end if
      iButDown = -1
    end if
    
    if multikey(fb.SC_BACKSPACE) then
      ShipLives=0: ShowRound = 0
      LockMouse = 0: setmouse ,,1,0
    end if
    
  loop
  
  for CNT as integer = 0 to 255
    if multikey(CNT) then 
      sleep 1,1:screensync:CNT = -1
    end if
  next CNT
  
  while inkey$ <> ""
    sleep 1,1: screensync
  wend
  
  SkipFrame=0:SkipFrame2=0
  #ifndef __FB_NDS__
  put Back,(0,0),Buff,pset
  #else
  Buff = 0
  #endif
  line Stars,(0,0)-(255,191),rgb(0,0,0),bf
  if DohFlash > -16384 then    
    if sndGameOver then FSound_PlaySound(FSOUND_FREE,sndGameOver)
    FrameWrap = 0
  else
    FrameWrap = 1
  end if
  do
    screenlock2    
    put Buff,(0,0),Back,pset
    static as uinteger iColor,iSwap
    iSwap += 1
    if (iSwap and 15) > 7 then iColor = rgb(0,255,0) else iColor = rgb(255,0,0)
    if DohFlash >-16384 then DrwTxt(60,137,"Game Over",iColor)
    if FrameWrap then Put Buff,(0,0),Stars,(0,0)-(255,191),Alpha,FrameWrap
    UpdateAndSync()
    screenunlock2
    SaveCpu()
    if FrameWrap then FrameWrap += (1-(DohFlash>-16384)):GameOn=0
    if FrameWrap=0 andalso len(inkey$) then FrameWrap = 1
  loop until FrameWrap>255
  
  if DohFlash <=-16384 then Intro(2)
  for CNT as integer = 0 to 4
    if NewScore > HighScore.iScore(CNT) then 
      if CNT < 4 then
        for idx as integer = 4 to CNT+1 step -1
          HighScore.iScore(idx) = HighScore.iScore(idx-1)
          HighScore.iLevel(idx) = HighScore.iLevel(idx-1)
          HighScore.sName(idx)  = HighScore.sName(idx-1)
        next idx   
      end if
      HighScore.iScore(CNT) = NewScore
      HighScore.iLevel(CNT) = CurrentLevel
      HighScore.sName(CNT) = "!"
      Intro(3): SaveConfig()
      exit for
    end if
  next CNT
  
end sub

'===================================================================================
'===================================================================================
'===================================================================================

#ifndef __FB_NDS__
function AlphaBlend(InColor as uinteger, BackColor as uinteger,iColor as any ptr) as uinteger
  if (inColor and &hFFFFFF) = rgba(255,0,255,0) then return BackColor
  return InColor and cuint(iColor)
end function
#endif

function DrwTxt(iPX as integer,iPY as integer,zText as string,iColor as uinteger=rgb(255,255,255)) as integer
  if SkipFrame then return 0
  dim as integer Char,xStart=iPX,OrgColor = iColor
  #ifdef __FB_NDS__
  #define RR ((iColor and &hF8) shl 7)
  #define GG ((iColor and &hF800) shr 6)
  #define BB ((iColor and &hF80000) shr 19)
  iColor = RR or GG or BB or &h8000
  #endif
  for CNT as integer = 0 to len(zText)-1
    if iPX > 256 then exit for
    Char = zText[CNT]
    select case Char
    case asc("a") to asc("z")
      Char -= (asc("a")-14)
    case asc("A") to asc("Z")
      Char -= (asc("A")-14)
    case asc("0") to asc("9")
      Char -= (asc("0")-1)
    case asc(".")
      Char = 11
    case asc(",")
      Char = 12
    case 13,10
      Char = 13
    case asc("#")
      iColor = valint("&h"+mid$(zText,CNT+2,6))
      #ifdef __FB_NDS__
      iColor = RR or GG or BB or &h8000
      #else
      iColor or= &hFF000000
      #endif
      CNT += 6: continue for
    case asc("-")
      line Buff,(iPX+2,iPY+4)-(iPX+5,iPY+4),OrgColor
      iPX += 8: continue for
    case asc(":")
    line Buff,(iPX+3,iPY+3)-(iPX+3,iPY+3),OrgColor
    line Buff,(iPX+3,iPY+6)-(iPX+3,iPY+6),OrgColor
    iPX += 8: continue for
  case asc("|")
    Char = 0
    'line Buff,(iPX+3,iPY+0)-(iPX+3,iPY+7),OrgColor
  case else
    iPX += 8: continue for
  end select
  dim as integer iCX=(Char and 7) shl 3,iCY=(Char shr 3) shl 3    
  #ifdef __FB_NDS__
  gfx.TextureColor = iColor
  put Buff,(iPX,iPY+2),Font,(iCX,iCY)-(iCX+7,iCY+7),trans
  gfx.TextureColor = -1
  #else
  'line Buff,(iPX,iPY)-(iPX+7,iPY+7),iColor,bf
  put Buff,(iPX,iPY),Font,(iCX,iCY)-(iCX+7,iCY+7),Custom,@AlphaBlend,cast(any ptr,iColor)
  #endif
  iPX += 8
next CNT
return iPX-xStart
end function

function ConvertPassword(CP1,CP2,CP3,CP4,CP5,Operation as integer) as uinteger  
  dim TempPass as PasswordStruct,sChar as string = " "
  dim as string Chars = "ZA0YBX1CWD2VE3UF4TG5SH6RI7QJ8PKO9LNM"
  dim as uinteger TempHash,NumBase = len(Chars)
  dim as uinteger Posi,Temp,iPower,iMix,iOld
  
  with TempPass
    if Operation = 0 then '---- Encode -----
      .Score      = iScore shr 5
      .Difficulty = iDifficulty
      .Level      = (iLevel+2)\5
      .Lives      = iLives
      .Noise      = rnd*8
      TempHash = (((((.Score shl 1)+.Difficulty) shl 1)+.Level) shl 1)+.Lives
      TempHash xor= ((TempHash shr 20) and &b11111)
      TempHash xor= ((TempHash shr 15) and &b11111)
      TempHash xor= ((TempHash shr 10) and &b11111)
      TempHash xor= ((TempHash shr  5) and &b11111)
      TempHash and= &b11111
      .Hash = TempHash
      TempHash = TempHash or (TempHash shl 5)
      TempHash or= (TempHash shl 10)
      TempHash or= ((TempHash shl 20) and &h00FFFFFF)            
      .iEncoded xor= TempHash      
      TempHash = .Noise or (.Noise shl 3)
      TempHash or= (TempHash shl 6)
      TempHash or= (TempHash shl 12) or (TempHash shl 24)
      TempHash and= &b00011111111111111111111111111111
      .iEncoded xor= TempHash
      
      sCode = "    -    ": Posi = 0: Temp = .iEncoded : iOld = 0
      for CNT as integer = 0 to 7
        dim as integer Char = ((Temp) mod NumBase)
        iMix = CNT xor (iOld and 7)
        Char += iMix-(((Char+iMix)>=NumBase) and NumBase)  
        sCode[Posi] = Chars[Char]: iOld = Char
        Temp \= NumBase: Posi += 1-(CNT=3)
      next CNT
      
      return 0
      
    else                 '---- Decode -----
      
      if len(sCode) <> 9 orelse sCode[4] <> asc("-") then return -1
      Temp=0: iPower = 1: Posi = 0: iOld = 0
      for CNT as integer = 0 to 7
        sChar[0] = sCode[Posi]
        dim as integer Char = instr(1,Chars,sChar)-1  
        iMix = CNT xor (iOld and 7): iOld = Char
        Char -= iMix-((Char<iMix) and NumBase)
        Temp += Char*iPower: iPower *= NumBase: Posi += 1-(CNT=3)
      next CNT
      
      .iEncoded = Temp
      TempHash = .Noise or (.Noise shl 3)
      TempHash or= (TempHash shl 6)
      TempHash or= (TempHash shl 12) or (TempHash shl 24)
      TempHash and= &b00011111111111111111111111111111
      .iEncoded xor= TempHash      
      TempHash = .Hash
      TempHash = TempHash or (TempHash shl 5)
      TempHash or= (TempHash shl 10)
      TempHash or= ((TempHash shl 20) and &h00FFFFFF)
      .iEncoded xor= TempHash      
      
      TempHash = (((((.Score shl 1)+.Difficulty) shl 1)+.Level) shl 1)+.Lives
      TempHash xor= ((TempHash shr 20) and &b11111)
      TempHash xor= ((TempHash shr 15) and &b11111)
      TempHash xor= ((TempHash shr 10) and &b11111)
      TempHash xor= ((TempHash shr  5) and &b11111)
      TempHash and= &b11111      
      if TempHash <> .Hash then return -2
      if .Lives > 6 then return -3      
      if .Difficulty > 2 then return -4
      dim TempScore as uinteger, TempDiff as ushort
      dim as integer TempLevel,TempLives
      TempScore = cint(.Score) shl 4
      if TempScore > 999999 then return -5
      TempDiff = .Difficulty
      TempLevel = (cint(.Level)-1)*5
      if TempLevel < 0 then TempLevel = 1 else TempLevel += 3
      if TempLevel > 33 then return -6
      TempLives = .Lives
      
      iScore = TempScore: iDifficulty = TempDiff
      iLevel = TempLevel: iLives = TempLives
      return 0
      
    end if
  end with
  
end function

sub LoadMap(MapNum as integer,IgnoreScore as integer=0)  
  put Buff,(0,0),Back,pset
  DohFlash = 0
  if MapNum > 32 then
    MapNum = 33: CurrentLevel = 33: DohLives = 16+(Difficulty shl 3)
    MapStart = 36: MapSize = 0: RoundPieces = 0    
    FileName = "Doh.bmp": printf FileName & !"\n"
    bload FileName,Doh
  else
    dim as integer iPX,iPY = 25+(MapStartLine(MapNum) shl 3)-8
    dim as ubyte ptr pLevel = cast(any ptr,RoundMap(MapNum))
    dim as ubyte ptr pRound = cast(any ptr,@LevelMap(0,0))
    dim as integer PowerUps
    MapStart = iPY: MapSize = 0: RoundPieces = 0
    
    do
      if *pLevel=0 then exit do
      iPY += 8: iPX = 9: MapSize += 1
      for CNT as integer = 0 to 10
        dim as integer Block = *pLevel-asc("0")
        if Block >= 0 then
          dim as integer iGY = (Block shl 3)-Block
          if Block = 8 then 
            *pRound = (Block or ((2+(CNT shr 3)) shl 4))
            RoundPieces += 1
          else
            *pRound = (Block or (((Block=7) and 15) shl 4))
            RoundPieces -= (Block<>7)
            if Block <> 7 then PowerUps += 1
          end if
        else
          *pRound = 255
        end if
        iPX += 16: pLevel += 1: pRound += 1
      next CNT
    loop
    PowerUpRate = PowerUps\8
    if PowerUpRate < 1 then PowerUpRate = 1
    PowerUpCheck = rnd*PowerUpRate
  end if
  
  NewAlienLeft=-1:NewAlienRight=-1:AlienCount=2
  RoundAlpha=0 : ShowRound= 511 : BallCatch = 0
  BallCatch = 0: BallSpeed /= 1.4: FirstCatch = 1
  if BallSpeed < (MinSpeed+.25) then BallSpeed = MinSpeed+.25
  if IgnoreScore=0 then 
    NewScore += (1000+(Difficulty shl 8))*(CurrentLevel*(1/8))
    if (NewScore and 15) then NewScore = (NewScore or 15)+1
  end if
  if ((CurrentLevel+2) mod 5) = 0 then
    ConvertPassword(NewScore,Difficulty,CurrentLevel,ShipLives,sOldCode,0)
  end if
  AutoCatch = 0 : ExitWarp = 0 : BallCount = 1
  WarpOffset = 0: ShipBreak = -1
  for CNT as integer = 0 to 3
    dim as integer AlienType = (CurrentLevel-2) and 3
    if CurrentLevel = 33 then AlienType = CNT
    with tAlien(CNT)
      .iFrame = -400 shl CNT
      .iOldFrame = 0: .fX = 0: .fY = 0
      .iType = AlienType shl 3
      .iLast = AlienSz(AlienType)
      .iSpd = ((AlienType and 1) xor 1)      
      'printf !"%i %i %i \n",.iType,.iLast,.iSpd
    end with
    LaserY(CNT) = 0
  next CNT
  for CNT as integer = 0 to 7    
    tPowerUp(CNT).iPosY = 0
  next CNT  
  if ShipType <> 0 then
    ShipFrames = 255
    OldShipType = ShipType: OldShipSz = ShipSz
    ShipType = 0: ShipSz = 12
  end if    
  
end sub

sub DrawMap()  
  if CurrentLevel < 33 then
    if SkipFrame2=0 then
      if RoundAlpha < 510 then
        dim as integer iPX,iPY = MapStart
        dim as integer iGY,iAlpha,Block
        for iLines as integer = 0 to MapSize-1      
          iPY += 8: iPX = 9
          for CNT as integer = 0 to 10
            Block = LevelMap(iLines,CNT).Kind
            if Block < 9 then
              iGY = (Block shl 3)-Block
              iAlpha = RoundAlpha*MapAlpha(iLines,CNT)-(rnd*32)
              if iAlpha > 255 then iAlpha = 255
              if iAlpha < 0 then iAlpha = 0
              if MapShake(iLines,CNT) then
                MapShake(iLines,CNT) -= 1
                #ifdef __FB_NDS__
                gfx.TextureColor = rgb15((iAlpha shr 3),(iAlpha shr 3),(iAlpha shr 3))
                put Buff,(iPX-2+int(rnd*5),iPY),Grap,(0,iGY)-(14,iGY+6),pset
                gfx.TextureColor = -1
                #else
                put Buff,(iPX-2+int(rnd*5),iPY),Grap,(0,iGY)-(14,iGY+6),alpha,iAlpha
                #endif
              else
                #ifdef __FB_NDS__
                gfx.TextureColor = rgb15((iAlpha shr 3),(iAlpha shr 3),(iAlpha shr 3))
                put Buff,(iPX,iPY),Grap,(0,iGY)-(14,iGY+6),pset
                gfx.TextureColor = -1
                #else
                put Buff,(iPX,iPY),Grap,(0,iGY)-(14,iGY+6),alpha,iAlpha
                #endif
              end if
            end if
            iPX += 16
          next CNT
        next iLines
      else
        dim as integer iGY,Block,iPX,iPY = MapStart
        for iLines as integer = 0 to MapSize-1      
          iPY += 8: iPX = 9
          for CNT as integer = 0 to 10
            Block = LevelMap(iLines,CNT).Kind
            if Block < 9 then
              iGY = (Block shl 3)-Block
              if MapShake(iLines,CNT) then
                MapShake(iLines,CNT) -= 1
                put Buff,(iPX-2+int(rnd*5),iPY),Grap,(0,iGY)-(14,iGY+6),pset
              else
                put Buff,(iPX,iPY),Grap,(0,iGY)-(14,iGY+6),pset
              end if
            end if
            iPX += 16
          next CNT
        next iLines
      end if
    end if
  else    
    static as single Angle 
    if DohFlash <= 0 and DohLives>0 then Angle += 1/128
    DohX = 64+sin(Angle)*12
    DohY = MapStart-cos(Angle)*7
    if RoundAlpha < 510 then
      dim as integer iAlpha = (RoundAlpha shr 1) + sin(Angle*24)*24
      if iAlpha < 0 then iAlpha = 0 else if iAlpha > 255 then iAlpha = 255      
      if SkipFrame2 = 0 then
        put Buff,(DohX,DohY),Doh,(0,0)-(63,94),alpha,iAlpha
      end if
    else
      static as integer DohFrame
      if ShowRound = 0 then        
        DohFrame += 1: if DohFrame = 64 then DohFrame = -64
      else
        DohFrame = -128: DohFlash = 0
        for CNT as integer = 0 to 2
          tDohShot(CNT).iPY = 0
        next CNT
      end if
      dim as integer DohMorph = abs(DohFrame)
      DohFlash -= 1      
      if DohLives > 0 then
        if SkipFrame2 = 0 then
          if DohFlash > 0 and ((DohFlash shr 2) and 1)=1 then
            put Buff,(DohX,DohY),Doh,(64,0)-(127,94),trans
          else
            put Buff,(DohX,DohY),Doh,(0,0)-(63,94),trans
          end if
        end if
      else
        if DohFlash >= -32 then
          if SkipFrame2 = 0 then
            put Buff,(DohX,DohY),Doh,(64,0)-(127,94),alpha,192
          end if
        else
          dim as integer ReadyCNT = 12*8          
          for Y as integer = 0 to 11
            for X as integer = 0 to 7
              dim as integer TX = X shl 3, TY = Y shl 3
              with tDohBlow(Y,X)
                if .iLvl < 4 then
                  dim as integer YT = 96+(.iLvl shl 3)
                  if SkipFrame2 = 0 then
                    put Doh,(64+TX,TY),Doh,(32,YT)-(39,YT+7),trans
                    dim as ushort ptr DohPix = Doh+sizeof(fb.image)
                    for YY as integer = 0 to 7
                      for XX as integer = 0 to 7
                        dim as integer id = ((TY+YY) shl 7)+(TX+XX)
                        if (DohPix[id] and &h7FFF) = 0 then DohPix[id] = *DohPix
                      next XX
                    next YY                    
                  end if
                end if
              end with
            next X
          next Y
          for Y as integer = 0 to 11
            for X as integer = 0 to 7
              dim as integer TX = X shl 3, TY = Y shl 3
              with tDohBlow(Y,X)
                if .iLvl < 0 then
                  dim as integer PX = (DohX+TX)+sin(.sAng)*.sDst
                  dim as integer PY = (DohY+TY)+cos(.sAng)*.sDst
                  .sDst += .sSpd
                  if PX < 9 or PY < 6 or PX > 175 or PY > 183 then 
                    if PX < 9 then PX = 9 else if PX > 175 then PX = 175
                    if PY < 6 then PY = 6 else if PY > 183 then PY = 183
                    .iLvl = 0: .iPnX = PX: .iPnY = PY
                  end if
                  if SkipFrame2 = 0 then
                    put Buff,(PX,PY),Doh,(64+TX,TY)-(71+TX,7+TY),trans
                  end if
                else
                  if .iLvl < 4 then
                    dim as integer YT = 96+(.iLvl shl 3)
                    if SkipFrame2 = 0 then                      
                      put Buff,(.iPnX,.iPnY),Doh,(64+TX,TY)-(71+TX,7+TY),trans
                    end if
                    if (DohFlash and 3)=0 then .iLvl += 1
                  else
                    ReadyCNT -= 1
                  end if
                end if
              end with
            next X
          next Y
          if ReadyCNT <= 0 then
            if DohFlash > -16384 then
              DohFlash = -16384: ShipLives=0: ShowRound = 0
              LockMouse = 0: setmouse ,,1,0
            end if            
          end if
        end if
        if DohFlash > 0 then 
          if SkipFrame2 = 0 then
            put Buff,(DohX-2+rnd*5,DohY),Doh,(0,0)-(63,94),alpha,(DohFlash*1.33)
          end if
        elseif DohFlash=-32 then
          NewScore *= 1.25
          for Y as integer = 0 to 11
            for X as integer = 0 to 7
              dim as integer TempX = int(rnd*4) shl 3              
              if SkipFrame2 = 0 then
                put Doh,(64+(X shl 3),Y shl 3),Doh,(TempX,120)-(TempX+7,127),trans
              end if
              with tDohBlow(Y,X)
                .sAng = -.5+atan2(X-4,Y-6)+rnd
                .sSpd = .75+rnd*2: .sDst = 0: .iLvl = -1                
              end with
            next X
          next Y
          for iAlien as integer = 0 to 2
            tAlien(iAlien).iFrame = 10
            tAlien(iAlien).FrameStep = 0
          next iAlien
          dim as ushort ptr DohPix = Doh+sizeof(fb.image)
          for CNT as integer = 0 to (128*96)-1
            if (DohPix[CNT] and &h7FFF) = 0 then DohPix[CNT] = *DohPix
          next CNT
          FSOUND_PlaySound(FSOUND_FREE,sndDohBreak)
        end if
      end if
      if DohLives > 0 then
        if DohMorph <= 25 then      
          if DohMorph < 10 then
            if SkipFrame2 = 0 then
              put Buff,(DohX+15,DohY+55),Doh,(0,96)-(31,119),trans
            end if
            if DohMorph = 0 then 
              dim as integer StX = DohX+31, StY = DohY+67
              dim as single BaseAng = atan2(ShipX-StX,177-StY)
              for CNT as integer = -1 to 1
                with tDohShot(CNT+1)
                  .sANG = BaseAng + (CNT*.25)
                  .sPX = StX: .sPY = StY
                  .iLvl = 3+CNT*3: .sSpd = 1.5+rnd*.4                  
                end with
              next CNT
            end if
          else
            if SkipFrame2 = 0 then
              put Buff,(DohX+15,DohY+55),Doh,(0,96)-(31,119),alpha,255-(DohMorph*10)
            end if
          end if      
        end if
      end if
    end if
  end if
end sub

sub UpdatePowerUp()
  for CNT as integer = 0 to 7
    with tPowerUp(CNT)
      if .iPosY then
        #if 1
        'def __FB_NDS__        
        dim as integer UpClip,DownClip
        if .iScroll < 0 then UpClip = -.iScroll else UpClip = 0
        if .iScroll > 0 then DownClip = .iScroll else DownClip = 0
        put Buff,(.iPosX-8,.iPosY-4),Grap,(15,.iKindY)-(29,.iKindY+6),pset
        if UpClip < 7 and DownClip < 7 then
          put Buff,(.iPosX-3,(.iPosY-4)+(((.iScroll)>=0) and (.iScroll))),_
          Grap,(30,.iKindY+UpClip)-(35,(.iKindY+6)-DownClip),trans
        end if
        #else
        put PowerBuf,(0,0),Grap,(15,.iKindY)-(29,.iKindY+6),pset
        put PowerBuf,(4+(.iWait and 1),.iScroll),Grap,(30,.iKindY)-(35,.iKindY+6),trans
        put Buff,(.iPosX-8,.iPosY-4),PowerBuf,pset
        #endif
        
        .iWait -= 1
        if (.iWait and 1) then 
          .iPosY += 1: if .iPosY > 192 then .iPosy=0
          if (.iPosY+3) >= 173 and (.iPosy-4) <= 177 then            
            if (.iPosX+7) >= (ShipX-ShipSz) then
              if (.iPosX-8) <= (ShipX+ShipSz) then
                select case .iKindY\7
                case 0 '(S)lowDown 
                  if VocSlow then FSOUND_PlaySound(FSOUND_FREE,VocSlow)
                  BallSpeed /= (1.5-(Difficulty*.066))
                  if BallSpeed < MinSpeed then BallSpeed = MinSpeed
                case 1 '(E)xtend
                  if VocExt then FSOUND_PlaySound(FSOUND_FREE,VocExt)
                  if ShipType <> 2 then
                    ShipFrames = 255
                    OldShipType = ShipType: OldShipSz = ShipSz
                    ShipType = 2: ShipSz = 18
                  end if
                case 2 '(C)catch   
                  if VocCatch then FSOUND_PlaySound(FSOUND_FREE,VocCatch)
                  AutoCatch = 1
                case 3 '(L)aser
                  if VocLaser then FSOUND_PlaySound(FSOUND_FREE,VocLaser)
                  if ShipType <> 1 then
                    ShipFrames = 255
                    OldShipType = ShipType: OldShipSz = ShipSz
                    ShipType = 1: ShipSz = 12
                  end if
                case 4 '(B)eam Out 
                  if vocBeam then FSOUND_PlaySound(FSOUND_FREE,VocBeam)
                  ExitWarp = 1
                case 5 '(D)uplicate
                  if VocDup then FSOUND_PlaySound(FSOUND_FREE,VocDup)
                  dim as integer NewBall = BallCount
                  for CNT as integer = 0 to BallCount-1
                    if NewBall<16 then
                      tBall(NewBall) = tBall(CNT)
                      tBall(NewBall).sAng = (tBall(NewBall).sAng-45) mod 360
                      NewBall += 1:BallCount += 1
                    end if
                    if NewBall<16 then
                      tBall(NewBall) = tBall(CNT)
                      tBall(NewBall).sAng = (tBall(NewBall).sAng+45) mod 360
                      NewBall += 1:BallCount += 1
                    end if
                  next CNT
                  
                case 6 '(P)lusLife 
                  if VocPlus then FSOUND_PlaySound(FSOUND_FREE,VocPlus)
                  if ShipLives < 6 then ShipLives += 1
                end select
                
                .iPosy = 0
              end if
            end if
          end if            
        end if
        if .iWait = 0 then
          .iWait = 4: .iScroll += 1
          if .iScroll >= 10 then .iScroll = -8
        end if
      end if
    end with
  next CNT
end sub

sub UpdateAliens()
  if NewAlienLeft  >= 0 then line Buff,( 48,0)-( 72,6),rgb(0,0,0),bf
  if NewAlienRight >= 0 then line Buff,(120,0)-(144,6),rgb(0,0,0),bf  
  'printf !"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"  
  'printf(!"%i %i \n",NewAlienLeft,NewAlienRight)
  for CNT as integer = 0 to AlienCount
    with tAlien(CNT)
      'printf(!"%5i %2i %3.2f %3.2f\n",.iFrame,.iSpd,.fX,.fY)      
      if .iFrame >= 0 then        
        dim Frame as integer,pGrap as any ptr = Aliens        
        if .iOldFrame >= 10 then
          Frame = .iOldFrame+14: pGrap = Font
        else
          Frame = .iOldFrame+.iType: pGrap = Aliens
        end if
        dim as integer PX = (Frame and 7) shl 4
        dim as integer PY = (Frame shr 3) shl 4          
        dim as integer iX = int(.fX)-8, iY = int(.fY)-8
        if GameOn then          
          dim as integer CheckX,CheckY,CheckZ
          for iTY as integer = 2 to 13 step (13-2)
            for iTX as integer = 2 to 13 step (13-2)
              dim as integer iGX = ((iX+iTX)-9) shr 4
              if iGX >= 0 and iGX < 11 then
                dim as integer iGY = ((iY+iTY)-(MapStart+8)) shr 3          
                if iGY >=0 and iGY < MapSize then
                  if LevelMap(iGY,iGX).Kind < 9 then
                    CheckX += sgn(iTX-8):CheckY += sgn(iTY-8):CheckZ = 1                  
                  end if
                end if
              end if
            next iTX
          next iTY
          if CheckZ then
            if sgn(CheckX) = sgn(.fSX) then .fSX = -.fSX
            if sgn(CheckY) = sgn(.fSY) then .fSY = -.fSY          
          end if
        end if
        put Buff,(iX,iY),pGrap,(PX,PY)-(PX+15,PY+15),trans
        if .iOldFrame <> .iFrame then          
          if .iFrame >= 10 then            
            pGrap = Font
            if .iFrame > 13 then Frame=27 else Frame = .iFrame+14
          else
            Frame = .iFrame+.iType: pGrap = Aliens
          end if          
          PX = (Frame and 7) shl 4: PY = (Frame shr 3) shl 4
          put Buff,(iX,iY),pGrap,(PX,PY)-(PX+15,PY+15),alpha,.FrameStep
        end if
        'printf(!"%i %i %i \n",.iOldFrame,.iFrame,Frame)
        .FrameStep += 15
        if .iFrame < 10 then 
          .fX += .fSX: .fY += .fSY          
        end if
        if .FrameStep >= 255 then
          dim as short NewAng
          .iOldFrame = .iFrame: .FrameStep = 0
          if .iFrame >= 10 then
            .iFrame += 1
            if .iFrame > 13 then
              .iFrame = -180: .iOldFrame = 0: .fX = 0: .fY = 0
              .iSpd = (((.iType shr 3) and 1) xor 1)
              if NewAlienLeft = CNT then NewAlienLeft = -1
              if NewAlienRight = CNT then NewAlienRight = -1
            end if          
          else
            if NewAlienLeft = CNT or NewAlienRight = CNT then
              if .fY > 16 then 
                .fY = 17: .fAng = ((180-60)+(rnd*120))*PI: NewAng = 1
                if NewAlienLeft  = CNT then 
                  NewAlienLeft  = -1
                else 
                  NewAlienRight = -1
                end if
              end if
            else
              if GameOn then
                if .fX <=  17 then .fX =  18: .fAng = (( 90-60)+(rnd*120))*PI: NewAng = 1
                if .fY <=  16 then .fY =  17: .fAng = ((180-60)+(rnd*120))*PI: NewAng = 1
                if .fX >= 161 then .fX = 160: .fAng = ((270-60)+(rnd*120))*PI: NewAng = 1
                if .fY >= 167 then .fY = 168: .fAng = ((  0-60)+(rnd*120))*PI: NewAng = 1
              else
                if .fX <   8 then .fAng = (( 90-60)+(rnd*120))*PI: NewAng = 1
                if .fY <   8 then .fAng = ((180-60)+(rnd*120))*PI: NewAng = 1
                if .fX > 248 then .fAng = ((270-60)+(rnd*120))*PI: NewAng = 1
                if .fY > 184 then .fAng = ((  0-60)+(rnd*120))*PI: NewAng = 1
              end if
              if NewAng=0 andalso int(rnd*100) = 50 then 
                .fAng = (rnd*360)*PI: NewAng = 1
              end if
            end if          
            if .iSpd then
              if .iFrame = 0 and .iSpd <= -1 then
                if .iSpd = -1 then 
                  .iSpd = -10 
                else
                  .iSpd += 1: if .iSpd = -1 then .iSpd = 1
                end if
              elseif .iFrame = .iLast and .iSpd >= 1 then
                if .iSpd = 1 then 
                  .iSpd = 10
                else
                  .iSpd -= 1: if .iSpd = 1 then .iSpd = -1
                end if
              else
                .iFrame += .iSpd
                if NewAng=0 andalso int(rnd*10) = 5 then 
                  .iSpd = -sgn(.iSpd): .fAng += 180: NewAng = 1
                end if
              end if          
            else
              .iFrame += 1: if .iFrame > .iLast then .iFrame = 0
            end if        
            if GameOn then
              if NewAng then .fSX = sin(.fAng)/4: .fSY -= cos(.fAng)/4
            else
              if NewAng then .fSX = sin(.fAng)/2: .fSY -= cos(.fAng)/2
            end if
          end if
        end if      
      else
        .iFrame += 1
        if .iFrame = 0 then
          if DohFlash > -16384 then
            if NewAlienLeft = -1 and NewAlienRight=-1 then
              if int(rnd*2) then
                NewAlienLeft=CNT:.fX=60
              else
                NewAlienRight = CNT:.fX=136
              end if
            elseif NewAlienLeft = -1 and NewAlienRight<>-1 then
              NewAlienLeft=CNT:.fX=60
            elseif NewAlienRight= -1 then
              NewAlienRight=CNT:.fX=136
            else
              .iFrame -= 30
            end if          
            if .iFrame = 0 then
              .iFrame=1:.iOldFrame=0:.FrameStep = 0
              .fY=-10:.fSX=0:.fSY=1/8:.fAng = 180
            end if
          else
            .iFrame = -1
          end if        
        end if
      end if
    end with
  next CNT
end sub

sub NewPowerUp(iPosX as integer,iPosY as integer)  
  for CNT as integer = 0 to 7
    with tPowerUp(CNT)
      if .iPosY = 0 then        
        .iPosX = iPosX : .iPosY = iPosY
        .iWait=4 : .iScroll=-8
        dim as integer NewKind
        for Tries as integer = 0 to 9
          if CurrentLevel < 10 then
            NewKind = rnd*100
            select case NewKind
            case  0 to 21
              NewKind = 0*7
            case 22 to 43
              NewKind = 2*7
            case 44 to 61
              NewKind = 1*7
            case 62 to 78
              NewKind = 3*7
            case 79 to 95
              NewKind = 5*7
            case 96 to 99
              NewKind = 4*7
            end select            
          else
            NewKind = rnd*100
            select case NewKind
            case  0 to 17
              NewKind = 0*7
            case 18 to 35
              NewKind = 2*7
            case 36 to 45
              NewKind = 1*7
            case 46 to 62
              NewKind = 3*7
            case 63 to 80
              NewKind = 5*7
            case 81 to 95
              NewKind = 6*7
            case 96 to 99
              NewKind = 4*7'
            end select            
          end if
          for CNT as integer = 0 to 7
            if tPowerUp(CNT).iPosY then               
              if tPowerUp(CNT).iKindY = NewKind then continue for,for
            end if
          next CNT
          exit for
        next Tries
        .iKindY = NewKind
        exit for 
      end if
    end with
  next CNT
end sub

sub DrawBall(CNT as integer)
  with tBall(CNT)
    'Draw Ball / Ball Shadows
    dim as integer iPX = int(.sX)-2,iPY = int(.sY)-2
    #ifndef __FB_NDS__
    dim as integer BallShadows = (.sX + .sY)\3
    if BallShadows > 5 then BallShadows = 5
    for CNT as integer = BallShadows to 0 step-1
      if .ioldX(CNT) then
        dim as integer AlphaVal = 255 shr ((CNT shr 1)+1)
        dim as integer iTX = ((.iOldX(CNT)+iPX) shr 1)
        dim as integer iTY = ((.iOldY(CNT)+iPY) shr 1)
        put Buff,(iTX,iTY),Grap,(37,21)-(41,25),alpha,AlphaVal
        .iOldX(CNT) = .iOldX(CNT-1)
        .iOldY(CNT) = .iOldY(CNT-1)
      end if
    next CNT
    #endif
    .iOldX(0) = iPX: .iOldY(0) = iPY
    put Buff,(iPX,iPY),Grap,(37,21)-(41,25),pset
  end with    
end sub

function BallCollision(CNT as integer) as integer
  static as integer FrameWrap
  FrameWrap += 1
  
  with tBall(CNT)
    dim as single sSX = sin(.sAng*PI),sSY = cos(.sAng*PI)
    dim as integer FineTune = (-int(-abs(sSX*BallSpeed)))*2+1,NewAng
    dim as integer FineTune2 = (-int(-abs(sSY*BallSpeed)))*2+1
    if FineTune2 > FineTune then swap FineTune,FineTune2
    #ifdef __FB_NDS__
    FineTune /= BallCount
    if FineTune < 3 then FineTune = 3
    #endif
    dim as single FineMath = 1/(FineTune)
    dim as integer BounceSound
    for iTune as integer = 0 to FineTune-1            
      .sX += sSX*BallSpeed*FineMath
      .sY += sSY*BallSpeed*FineMath
      if .sX < 11 then .sX = 11+(11-.sX): sSX = -sSX: NewAng = 1: BounceSound = 1
      if .sX > 181 then .sX = 181-(.sX-181): sSX = -sSX: NewAng = 1: BounceSound = 1
      if .sY < 9 then .sY = 9+(9-.sY): sSY = -sSY: NewAng = 1: BounceSound = 1      
      if iTune = 0 then
        for iAlien as integer = 0 to 3
          if cuint(tAlien(iAlien).iFrame) < 10 then
            dim as single X = tAlien(iAlien).fX
            if abs(X-.sX) < 7 then
              dim as single Y = tAlien(iAlien).fY
              if abs(Y-.sY) < 7 then
                if sndAlienBrk then
                  FSOUND_Sample_SetDefaults(sndAlienBrk,-1,127,(X-9)*(255/174),-1)
                  FSOUND_PlaySound(FSOUND_FREE,sndAlienBrk)
                end if
                tAlien(iAlien).iFrame = 10
                tAlien(iAlien).FrameStep = 0
                .sAng = ((atan2((.sX-X),(.sY-Y))*InvPI) mod 360)
                sSX = sin(.sAng*PI): sSY = cos(.sAng*PI)
                NewAng = 0: NewScore += (32+(Difficulty shl 3))*(1+(ScoreBonus*(1/512)))
                if ScoreBonus < 32 then ScoreBonus = 32 else ScoreBonus += 16
                if BallSpeed > MinSpeed+.25 then BallSpeed *= .99
              end if
            end if
          end if
        next iAlien
      end if
      if sSY >= 0 then
        if abs(.sX-ShipX) < ShipSz then
          if .sY > 173 and .sY < 182 then                 
            NewAng = 0: .sAng = 180-(((.sX-ShipX)/ShipSz)*70): BounceSound = 1
            #ifdef __FB_NDS__
            #define NoCatchDown() (multikey(fb.SC_BUTTONL) or multikey(fb.SC_BUTTONR))
            if AutoCatch andalso NoCatchDown()=0 then 
              if BallCatch=-1 then 
                BallCatch = CNT: CatchOffset = .sX-ShipX
              end if
            end if
            #else
            if AutoCatch andalso (iMB and 1)=0 then 
              if BallCatch=-1 then 
                BallCatch = CNT: CatchOffset = .sX-ShipX
              end if
            end if
            #endif
          end if 
        end if
        if .sY > 185 then                
          tBall(CNT) = type(0,0,135+rnd*90,{0,0,0,0,0,0},{0,0,0,0,0,0})
          swap tBall(CNT),tBall(BallCount-1)
          if BallCatch = (BallCount-1) then BallCatch = CNT
          NewAng = 0: BallCount -= 1
          if BallCount=0 then 'Reset PowerUps when life is lost
            NewAng = 0: ShipBreaks()            
          else
            CNT -= 1
          end if
        end if
      end if
      if BounceSound andalso sndBounce then 
        FSOUND_Sample_SetDefaults(sndBounce,-1,64,(.Sx-9)*(255/175),-1)
        FSOUND_PlaySound(FSOUND_FREE,sndBounce)
      end if 
      if NewAng = 0 then
        if CurrentLevel < 33 then          
          for CheckY as integer = -2 to 2
            for CheckX as integer = -2 to 2
              dim as integer isX,isY
              if abs(CheckX) = 2 and abs(CheckY) <> 2 then isX = 1
              if abs(CheckY) = 2 and abs(CheckX) <> 2 then isY = 1
              if isX or isY then
                dim as integer GridX=int((.sX-9)+CheckX) shr 4
                dim as integer GridY=int((.sY-(MapStart+8))+CheckY) shr 3
                if GridY >= 0 and GridY < MapSize then            
                  select case LevelMap(GridY,GridX).Kind
                  case 0 to 6,8                  
                    if LevelMap(GridY,GridX).Stat then                    
                      if sndBrick then 
                        FSOUND_Sample_SetDefaults(sndBrick,-1,255/LevelMap(GridY,GridX).Stat,GridX*(255/10),-1)
                        FSOUND_PlaySound(FSOUND_FREE,sndBrick)
                      end if
                      LevelMap(GridY,GridX).Stat -= 1
                      MapShake(GridY,GridX) = 10
                      NewScore += (15+(Difficulty shl 2))*(1+(ScoreBonus*(1/512)))
                      if ScoreBonus < 64 then ScoreBonus = 64 else ScoreBonus += 24
                    else
                      if rnd > .5 then
                        if sndHit then 
                          FSOUND_Sample_SetDefaults(sndHit,-1,255,GridX*(255/10),-1)
                          FSOUND_PlaySound(FSOUND_FREE,sndHit)
                        end if
                      else
                        if sndHit2 then 
                          FSOUND_Sample_SetDefaults(sndHit2,-1,255,GridX*(255/10),-1)
                          FSOUND_PlaySound(FSOUND_FREE,sndHit2)
                        end if
                      end if
                      if LevelMap(GridY,GridX).Block <> 8 then
                        'if int(rnd*1.3) then
                        PowerUpCheck += 1
                        if PowerUpCheck >= PowerUpRate then
                          PowerUpCheck=0
                          NewPowerUp(17+(GridX shl 4),MapStart+10+(GridY shl 3))
                        end if
                        'end if
                      end if
                      LevelMap(GridY,GridX).Block = 15                          
                      NewScore += (35+(Difficulty shl 3))*(1+(ScoreBonus*(1/512)))
                      RoundPieces -= 1
                      if ScoreBonus < 128 then
                        ScoreBonus = 128
                      else
                        ScoreBonus += 48
                      end if
                      if RoundPieces = 0 then 'Reset Power Ups when advincg level
                        CurrentLevel += 1: LoadMap(CurrentLevel)
                        return 1
                      end if
                    end if
                    NewAng = 1: if isX then sSX = -sSX else sSY = -sSY
                    .sX += sSX*BallSpeed*FineMath
                    .sY += sSY*BallSpeed*FineMath
                    exit for,for
                  case 7
                    if FrameWrap >= 7 then
                      if sndSpark then FSOUND_PlaySound(FSOUND_FREE,sndSpark)
                    end if
                    NewAng = 1: MapShake(GridY,GridX) = 10                  
                    if isX then 
                      sSX = -sSX: .sX += sSX*BallSpeed*FineMath
                    else 
                      sSY = -sSY: .sY += sSY*BallSpeed*FineMath
                    end if                  
                    exit for,for
                  end select
                end if 
              end if
            next CheckX
          next CheckY 
        else
          if .sX >= DohX and .Sy >= DohY then
            if .sX < (DohX+64) and .sY < (DohY+96) and DohLives>0 then
              dim as integer X = int(.sX-DohX), Y = int(.sY-DohY)
              dim as ushort ptr DohPix = Doh+sizeof(fb.image)
              if DohPix[(Y shl 7)+X] <> *DohPix then
                X = dohX+32: Y = dohY+48
                .sAng = ((atan2((.sX-X),(.sY-Y))*InvPI) mod 360)              
                sSX = sin(.sAng*PI): sSY = cos(.sAng*PI)
                NewAng = 0
                if DohFlash <= 0 then 
                  DohFlash = 16                  
                  if sndDohHit then                    
                    FSOUND_Sample_SetDefaults(sndDohHit,-1,255,(.Sx-9)*(255/175),-1)
                    FSOUND_PlaySound(FSOUND_FREE,sndDohHit)
                  end if
                  DohLives -= 1
                  if DohLives <= 0 then 
                    BallCount = 0: DohFlash = 192
                    FSOUND_Sample_SetDefaults(sndDoh,-1,127,(.Sx-9)*(255/175),-1)
                    if sndDoh then FSound_PlaySound(FSOUND_FREE,sndDoh)
                  end if                  
                end if
                .sX += sSX*BallSpeed*FineMath
                .sY += sSY*BallSpeed*FineMath
                if FrameWrap >= 16-(Difficulty shl 1) then
                  BallSpeed *= ((1+(.001*Difficulty))+(1/(BallSpeed*BallSpeed*8)))
                  FrameWrap = 0: 
                  if BallSpeed > 4+Difficulty then BallSpeed = 4+Difficulty
                end if
                exit for
              end if
            end if
          end if
        end if
      end if
      if NewAng then
        .sAng = ((atan2(sSX,sSY)*InvPI) mod 360)
        if FrameWrap >= 16 then
          BallSpeed *= (1+(.001*Difficulty)+(1/(BallSpeed*BallSpeed*80))): FrameWrap = 0
          if BallSpeed > 4+Difficulty then BallSpeed = 4+Difficulty
        end if
      end if          
    next iTune  
    if CurrentLevel < 33 then        
      .sAng -= (1/32)-rnd*(1/64) '(1/1024)
    end if
    if abs(90-(.sAng mod 90)) < 10 then .sAng -= 17
    return 0
  end with
  
end function

sub LaserUpdate(NUM as integer)
  dim as integer GridX,GridY
  LaserY(NUM) -= 7
  for Grids as integer = 0 to 1    
    if Grids=0 then
      GridX = (LaserX(NUM)-ShipSz+5-9) shr 4
      GridY = ((LaserY(NUM)-LaserOffset(NUM))-(MapStart+8)) shr 3
    else
      GridX = (LaserX(NUM)+ShipSz-5-9) shr 4
      GridY = ((LaserY(NUM)+LaserOffset(NUM))-(MapStart+8)) shr 3
    end if    
    if GridY >= 0 and GridY < MapSize then            
      select case LevelMap(GridY,GridX).Kind
      case 0 to 6,8
        LaserY(NUM) = 0
        if LevelMap(GridY,GridX).Stat then
          if sndBrick then 
            FSOUND_Sample_SetDefaults(sndBrick,-1,255/LevelMap(GridY,GridX).Stat,GridX*(255/10),-1)
            FSOUND_PlaySound(FSOUND_FREE,sndBrick)
          end if
          LevelMap(GridY,GridX).Stat -= 1
          MapShake(GridY,GridX) = 10
          NewScore += (15+(Difficulty shl 2))*(1+(ScoreBonus*(1/128)))
        else
          if rnd > .5 then
            if sndHit then 
              FSOUND_Sample_SetDefaults(sndHit,-1,255,GridX*(255/10),-1)
              FSOUND_PlaySound(FSOUND_FREE,sndHit)
            end if
          else
            if sndHit2 then 
              FSOUND_Sample_SetDefaults(sndHit2,-1,255,GridX*(255/10),-1)
              FSOUND_PlaySound(FSOUND_FREE,sndHit2)
            end if
          end if
          if LevelMap(GridY,GridX).Block <> 8 then            
            PowerUpCheck += 1
            if PowerUpCheck >= PowerUpRate then
              PowerUpCheck=0
              NewPowerUp(17+(GridX shl 4),MapStart+10+(GridY shl 3))
            end if            
          end if
          LevelMap(GridY,GridX).Block = 15                          
          NewScore += (35+(Difficulty shl 3))*(1+(ScoreBonus*(1/128)))
          RoundPieces -= 1                    
          if RoundPieces = 0 then 'Reset Power Ups when advincg level
            CurrentLevel += 1: LoadMap(CurrentLevel)                      
          end if
        end if                  
      case 7                  
        if sndSpark then FSOUND_PlaySound(FSOUND_FREE,sndSpark)
        MapShake(GridY,GridX) = 10
        LaserY(NUM) = 0
      end select
    end if
  next Grids
  
end sub

sub DrawHud()
  if NewScore > 999999 then NewScore = 999999
  if ShowScore < NewScore then 
    select case (NewScore-ShowScore)
    case    0 to   29: ShowScore +=   1
    case   30 to  199: ShowScore +=   3
    case  200 to  499: ShowScore +=   7
    case  500 to  999: ShowScore +=  13
    case 1000 to 2999: ShowScore +=  17
    case 3000 to 3999: ShowScore +=  77
    case     else    : ShowScore +=  531
    end select    
    if (NewScore-LastScore) > 24768 then
      if ShipLives < 6 then ShipLives += 1
      LastScore = NewScore
    end if
  end if  
  dim as string Score = str$(ShowScore)
  Score = string$(6-len(Score),"0")+Score
  DrwTxt(199,44,Score)
  Score = str$(HighScore.iScore(0))
  Score = string$(6-len(Score),"0")+Score
  DrwTxt(199,67,Score,rgb(255,255,0))
  if ShowRound then
    if (ShowRound and 1) and ShowRound < 384 then
      static as integer RoundChan
      if sndRound then 
        if RoundChan then FSound_StopSound(RoundChan)
        RoundChan = FSound_PlaySound(FSOUND_FREE,sndRound)        
      end if
      ShowRound += 1
    end if
    ShowRound -= 2: ShipBreak = -1
  end if
  if CurrentLevel < 10 then
    DrwTxt(219,90,str$(CurrentLevel))
    if ShowRound then 
      DrwTxt(68,137,"Round " & CurrentLevel)
      dim as uinteger TempColor = rgb(0,0,255)
      if (FrameWrap and 1) then TempColor = rgb(0,255,255)
      if ((CurrentLevel+2) mod 5)=0 then DrwTxt(36,146,"Code: "+sOldCode,TempColor)
    end if
  else
    DrwTxt(215,90,str$(CurrentLevel))
    if ShowRound then 
      DrwTxt(64,137,"Round " & CurrentLevel)
      dim as uinteger TempColor = rgb(0,0,255)
      if (FrameWrap and 1) then TempColor = rgb(0,255,255)
      if ((CurrentLevel+2) mod 5)=0 then DrwTxt(36,146,"Code: "+sOldCode,TempColor)
    end if
  end if 
  
  'static as single TitleAngle
  'TitleAngle += 1/64
  'const Dist = (96-64) shr 1
  'dim as integer Start = Dist+(sin(TitleAngle)*Dist)
  'put Buff,(192,11),InTitle,(Start,0)-(Start+63,14),pset
  
end sub

sub DrawStars()
  dim as single SpdX,SpdY
  for CNT as integer = 0 to 15
    SpdX += sin(StarAng(CNT)): SpdY -= cos(StarAng(CNT))
    StarAng(CNT) += StarSpd(CNT)
    if StarAng(CNT) < 0 then 
      StarAng(CNT) += PI*360
    elseif StarAng(CNT) >= PI*360 then
      StarAng(CNT) -= PI*360
    end if
  next CNT    
  SpdX /= 16: SpdY /= 16
  if SpdX=0 then SpdX = .03
  if SpdY=0 then SpdY = .03
  while sqr((SpdX*SpdX)+(SpdY*SpdY)) < .5
    SpdX *= 1.1: SpdY *= 1.1
  wend    
  StarOffX += SpdX: StarOffY += SpdY
  if RoundAlpha < 510 then
    StarOffY -= (510-RoundAlpha)/64
  end if
  if StarOffX < 0 then StaroffX += 256 else if StarOffX >= 256 then StarOffX -= 256
  if StarOffY < 0 then StaroffY += 256 else if StarOffY >= 256 then StarOffY -= 256  
  
  for Y as integer= 0 to 256 step 256
    for X as integer= 0 to 256 step 256
      dim as integer PosX = -StarOffX+X
      dim as integer PosY = -StarOffY+Y
      dim as integer StX=any,StY=any
      if PosX < 0 then StX = -PosX:PosX=0
      if PosY < 0 then StY = -PosY:PosY=0        
      dim as integer EndX=any,EndY=any
      if X = 0 then EndX = 174+StX else EndX = 174-PosX: StX = 0
      if Y = 0 then EndY = 185+StY else EndY = 185-PosY: StY = 0
      if EndX > 255 then EndX = 255
      if EndY > 255 then EndY = 255        
      if PosX < 174 and PosY < 185 then
        if EndX > 0 and EndY > 0 then
          put Buff,(9+PosX,6+PosY),Stars,(StX,StY)-(EndX,EndY),pset
        end if
      end if
    next X
  next Y
end sub

function DrawSprites() as integer
  static as integer WarpSound
  static as integer FrameWrap  
  FrameWrap += 1
  
  if ShipLives<=0 then
    #ifdef __FB_NDS__
    if abs(NewScore-ShowScore) <= 1 andalso Buff=0 then 
      Buff = Back: put Buff,(0,0),Back,pset: return 0
    end if
    #endif
    if NewScore=ShowScore then return -1
    return 0
  end if  
  
  if ExitWarp then
    put Buff,(184,172),Back,(184,172)-(192,192),pset
    line Buff,(184,172)-(192,192),rgb(0,0,0),bf
    if WarpOffset then      
      put Buff,(191,172),Back,(191,172)-(222,187),pset
      ShipX = (184-ShipSz)+WarpOffset
      ExitWarp xor= 2
      if (ExitWarp and 2) then WarpOffset += 1
      if WarpOffset > (ShipSz*2)+10 then
        CurrentLevel += 1: LoadMap(CurrentLevel)
        return 1
      end if
    end if
  end if  
  
  if ShipFrames <= 0 and ShipBreak > = 0 then
    for CNT as integer = 0 to 1
      pset Grap,(39+ShipBreak,rnd*7),rgba(255,0,255,0)
    next CNT
    for CNT as integer = 0 to 1
      pset Grap,(38+ShipBreak,rnd*7),rgba(255,0,255,0)
    next CNT    
    pset Grap,(37+ShipBreak,rnd*7),rgba(255,0,255,0)    
    pset Grap,(36+ShipBreak,rnd*7),rgba(255,0,255,0)
    line Grap,(35+ShipBreak,0)-(35+ShipBreak,6),rgba(255,0,255,0)
    if (ShipBreak and 1) then ShipOffX -= 1
    ShipBreak += 1    
    if ShipBreak = 1 andalso sndShipBrk then
      FSOUND_PlaySound(FSOUND_FREE,sndShipBrk)
    end if    
    if ShipBreak > 40 then
      ShipBreak = -1: ShipBreaks(1)
      bload "Graphics.bmp",Grap
    end if    
  end if
  
  
  if ShipFrames then  
    select case OldShipType
    case 0
      put Buff,(ShipX-OldShipSz,ShipY),Grap,(37,0)-(61,5),alpha,ShipFrames
    case 1
      put Buff,(ShipX-OldShipSz,ShipY),Grap,(37,7)-(61,13),alpha,ShipFrames
    case 2
      put Buff,(ShipX-OldShipSz,ShipY),Grap,(37,0)-(41,5),alpha,ShipFrames
      put Buff,(ShipX-OldShipSz+5,ShipY),Grap,(37,14)-(63,19),alpha,ShipFrames
      put Buff,(ShipX+OldShipSz-5,ShipY),Grap,(57,0)-(61,5),alpha,ShipFrames
    end select
    select case ShipType
    case 0
      put Buff,(ShipX-ShipSz,ShipY),Grap,(37,0)-(61,5),alpha,255-ShipFrames
    case 1
      put Buff,(ShipX-ShipSz,ShipY),Grap,(37,7)-(61,13),alpha,255-ShipFrames
    case 2
      put Buff,(ShipX-ShipSz,ShipY),Grap,(37,0)-(41,5),alpha,255-ShipFrames
      put Buff,(ShipX-ShipSz+5,ShipY),Grap,(37,14)-(63,19),alpha,255-ShipFrames
      put Buff,(ShipX+ShipSz-5,ShipY),Grap,(57,0)-(61,5),alpha,255-ShipFrames      
    end select
    ShipFrames -= 5: if ShipFrames < 0 then ShipFrames = 0
  else
    select case ShipType
    case 0
      put Buff,(ShipX-ShipSz+ShipOffX,175),Grap,(37,0)-(61,5),trans
    case 1
      put Buff,(ShipX-ShipSz+ShipOffX,175),Grap,(37,7)-(61,13),trans
    case 2
      put Buff,(ShipX-ShipSz+ShipOffX,175),Grap,(37,0)-(41,5),trans
      put Buff,(ShipX-ShipSz+5+ShipOffX,175),Grap,(37,14)-(63,19),trans
      put Buff,(ShipX+ShipSz-5+ShipOffX,175),Grap,(57,0)-(61,5),trans
    end select
  end if
  
  if ExitWarp then
    if WarpSound = 0 then
      if sndWarp then
        FSOUND_Sample_SetDefaults(sndWarp,-1,127,255,-1)
        WarpSound = FSOUND_PlaySound(FSOUND_FREE,sndWarp)+1
      end if
    end if
    if ShipX >= (183-ShipSz) and WarpOffset=0 then WarpOffset = 1: BallCount = 0        
    dim as integer WarpNum=1,NewX,OldX = 188    
    for CNT as integer = 0 to 19 step 3
      if CNT >= 16 then
        NewX = 188
      else
        NewX = 188+sin(WarpAngle(WarpNum))*3
      end if
      WarpAngle(WarpNum) += .3
      line Buff,(376-OldX,172+CNT)-(376-NewX,172+CNT+2),rgb(44,44,127)
      line Buff,(OldX,172+CNT)-(NewX,172+CNT+2),rgb(85,85,255)      
      WarpNum += 1: OldX = NewX
    next CNT
    if WarpOffset then      
      put Buff,(191,172),Back,(191,172)-(191+ShipSz*2,187),pset
    end if  
  elseif WarpSound then
    FSOUND_StopSound(WarpSound-1)
    WarpSound = 0
  end if
  
  if CurrentLevel=33 then
    for CNT as integer = 0 to 2
      with tDohShot(CNT)        
        if .iPY then
          dim as integer TX = ((.iLvl and 3) shl 4)+64
          dim as integer TY = ((.iLvl shr 2) shl 4)+96         
          .sPX += sin(.sAng)*.sSpd: .sPY += cos(.sAng)*.sSpd          
          dim as integer iTX = .sPX, iTY = .sPY
          put buff,(iTX-8,iTY-8),Doh,(TX,TY)-(TX+15,TY+15),trans          
          if (FrameWrap and 3) = 0 then .iLvl = (.iLvl+1) and 7
          if iTX < 16 or iTX > 177 or iTY > 200 then .sPY = 0
          if (iTY+6) >= ShipY then
            if (iTX+6) >= (ShipX-ShipSZ) then
              if (iTX-6) <= (ShipX+ShipSZ) and (iTY-6) <= (ShipY+6) then            
                ShipBreaks()                
              end if
            end if
          end if          
        end if
      end with
    next CNT
  end if
  
end function

sub UpdateAndSync()
  static as double fpsTIMER
  static as integer FPS,FPS2
  FPS += 1
  if abs(timer-fpsTIMER) > 1 then
    printf(!"%i / %i  \r",FPS2,FPS)
    FPS2 = 0: FPS=0 : fpsTIMER = timer
  end if
  
  if isPause then
    static as short iSwap
    dim as uinteger iColor,iPause
    iSwap += 1
    if (iSwap and 4) then iColor = rgb(255,255,0) else iColor=rgb(0,255,255)
    if (iSwap and 32) then iPause = rgb(255,0,0) else iPause = rgb(0,0,0)
    #ifdef __FB_NDS__
    if Buff then put (0,0),Buff,pset:Buff = 0    
    DrwTxt(25,165,"A quit, B continue",rgb(0,255,0))
    DrwTxt(25,165,"A       B",iColor)
    dim as uinteger TempColor = rgb(0,0,255)
    if (iSwap and 1) then TempColor = rgb(0,255,255)
    DrwTxt(36,146,"Code: "+sOldCode,TempColor)
    DrwTxt(72,155,"PAUSED",iPause):Buff = Back
    #else        
    DrwTxt(25,165,"Y quit, N continue",rgb(0,255,0))
    DrwTxt(25,165,"Y       N",iColor)
    dim as uinteger TempColor = rgb(0,0,255)
    if (iSwap and 1) then TempColor = rgb(0,255,255)
    DrwTxt(36,146,"Code: "+sOldCode,TempColor)
    DrwTxt(72,155,"PAUSED",iPause)
    #endif
  end if
  
  if SkipFrame then exit sub else FPS2 += 1
  
  screenlock
  #ifndef __FB_NDS__
  if ScrDouble then    
    'bpp16.resize2x(Buff+sizeof(fb.image),screenptr)
    dim as integer TempFilter = ScrFilter
    if ScrDouble=2 then If ScrFilter <> 1 then TempFilter = 0
    select case TempFilter
    case 0
      bpp16.resize2x(Buff+sizeof(fb.image),Scr+sizeof(fb.image))
    case 1      
      #ifdef HQ2X_16
      HQ2X_16(Buff+sizeof(fb.image),Scr+sizeof(fb.image),256,192,256*4)
      #else
      bpp16.scale2x(Buff+sizeof(fb.image),Scr+sizeof(fb.image))  
      #endif
    case 2
      bpp16.rgb2x(Buff+sizeof(fb.image),Scr+sizeof(fb.image))  
    end select
    if ScrDouble=2 then
      if GameOn then put Scr,(192*2,10*2),InTitle,pset      
      #macro DoFilter4x(FuncName)
      put scr2,(0,0),Scr,(0,0)-(255,191),pset
      FuncName(scr2+sizeof(fb.image),Buff2+sizeof(fb.image))
      put (0,0),Buff2,pset
      put scr2,(0,0),Scr,(256,0)-(511,191),pset
      FuncName(scr2+sizeof(fb.image),Buff2+sizeof(fb.image))
      put (512,0),Buff2,pset
      put scr2,(0,0),Scr,(0,192)-(255,383),pset
      FuncName(scr2+sizeof(fb.image),Buff2+sizeof(fb.image))
      put (0,384),Buff2,pset
      put scr2,(0,0),Scr,(256,192)-(511,383),pset
      FuncName(scr2+sizeof(fb.image),Buff2+sizeof(fb.image))
      put (512,384),Buff2,pset
      #endmacro
      select case ScrFilter
      case 0
        DoFilter4x(bpp16.Resize2x)
      case 1
        #if 0 'def HQ2X_16
        HQ2X_16(Scr+sizeof(fb.image),screenptr,512,384,512*4)
        #else
        DoFilter4x(bpp16.Scale2x)
        #endif
      case 2
        DoFilter4x(bpp16.rgb2x)
      end select
    else      
      put(0,0),Scr,pset 'alpha,128
      if GameOn then put(192*2,10*2),InTitle,pset
    end if
  end if  
  #ifdef RenderOGL
  screensync
  #else
  if BallSmooth then screensync
  #endif
  #else  
  flip
  if BallSmooth then screensync
  #endif
  screenunlock
  
end sub

sub ShipBreaks(iMode as integer=0)
  if iMode = 0 then
    for CNT as integer = 0 to 3
      LaserY(CNT) = 0
    next CNT
    for CNT as integer = 0 to 7
      tPowerUp(CNT).iPosY = 0
    next CNT
    for CNT as integer = 0 to 2
      tDohShot(CNT).iPY = 0
    next CNT
    BallCatch = 0:FirstCatch = 1
    AutoCatch = 0 : ExitWarp = 0 : BallCount = 0
    if ShipType <> 0 then
      ShipFrames = 120
      OldShipType = ShipType: OldShipSz = ShipSz
      ShipType = 0: ShipSz = 12
    end if
    ShipBreak = 0: ShipOffX = 0
  else    
    ShipLives -= 1:BallCatch = 0:FirstCatch = 1
    if ShipLives < 0 then ShipLives = 0
    BallCount = -(ShipLives<>0): ShipOffX = 0
    ShowRound = ((ShipLives>0) and 255): BallSpeed /= 1.3  
    if ShipLives=0 then LockMouse=0:setmouse ,,1,0
    if BallSpeed < (MinSpeed+.3) then BallSpeed = (MinSpeed+.3)
  end if
end sub

sub LoadConfig()
  dim as SaveStruct SaveData
  dim as integer LoadFailed
  printf(!"Loading Data... ",sizeof(SaveStruct))
  
  #ifdef __FB_NDS__
  if fatInitDefault()=0 then 
    printf !"\nFailed to switch to FAT system."
    LoadFailed = 1
  else
    dim as file ptr fTest = fopen("Reinkarnoid.sav","r")
    if fTest = 0 then
      printf !"\nFailed... to Open .sav file": LoadFailed = 1
    else
      fread(@SaveData,sizeof(SaveData),1,fTest)
      fClose(fTest)
    end if
    if nitroFSInit()=0 then
      printf !"\nFailed to switch back to NitroFS.\n"
      sleep: end
    end if
  end if
  #else
  dim as integer SaveFile = FreeFile()
  open exepath+"/Reinkarnoid.sav" for binary access read as #SaveFile
  get #SaveFile,1,SaveData
  close #SaveFile
  #endif
  
  if LoadFailed=0 then
    with SaveData
      dim as integer TempHash,OldHash
      .iRandom xor= &hFF884422
      .iHash xor= .iRandom
      for CNT as integer = 0 to 125
        .iData(CNT) xor= .iRandom
        OldHash = TempHash
        TempHash += (CNT+.iData(CNT))
        .iData(CNT) xor= OldHash
      next CNT
      if TempHash = .iHash then
        HighScore = .ScoreData
        ScrDouble = .ScrDouble
        ScrRender = .RenderType
        sndVol    = .SoundVol
        #ifdef __FB_NDS__
        DsIsTop   = .ScaleType
        #else
        ScrFilter = .ScaleType
        #endif
        if ScrDouble < 0 or ScrDouble > 2 then ScrDouble = 1
        if ScrRender < 0 or ScrRender > 5 then ScrRender = 4
        if ScrFilter < 0 or ScrFilter > 2 then ScrFilter = 0
        if DsIsTop   < 0 or DsIsTop   > 1 then DsIsTop   = 1        
        if SndVol    < 0 or SndVol    > 4 then SndVol    = 4
      else 
        LoadFailed = 1
      end if
      if LoadFailed then
        printf(!"\nSave file corrupted...")
      end if
    end with
  end if
  
  if LoadFailed then
    #ifdef __FB_NDS__
    ScrDouble = 0: ScrRender = 4: SndVol = 4: DsIsTop = 1
    #else
    ScrDouble = 1: ScrRender = 4: ScrFilter = 0: SndVol = 4
    #endif    
    with HighScore
      .sName(0) = "Freebasic": .iLevel(0) = 7: .iScore(0) = 23000
      .sName(1) = "Mysoft"   : .iLevel(1) = 6: .iScore(1) = 16384
      .sName(2) = "MyTDT"    : .iLevel(2) = 4: .iScore(2) = 12350
      .sName(3) = "Beta"     : .iLevel(3) = 3: .iScore(3) = 8000
      .sName(4) = "Doh"      : .iLevel(4) = 1: .iScore(4) = 4500
    end with
    printf(!"\nDefault config loaded...\n")
    SaveConfig()
  else
    printf(!"Done...\n")
  end if
  
end sub

sub SaveConfig()
  dim as SaveStruct SaveData  
  printf(!"Saving Data... ")    
  
  with SaveData
    .iRandom   = rnd*&hFFFFFF
    .iHash = 0
    .ScoreData  = HighScore
    .ScrDouble  = ScrDouble
    .RenderType = ScrRender
    #ifdef __FB_NDS__
    .ScaleType  = DSiStop
    #else
    .ScaleType  = ScrFilter
    #endif
    .SoundVol   = sndVol
    for CNT as integer = 0 to 125
      .iData(CNT) xor= .iHash
      .iHash += (CNT+.iData(CNT))
      .iData(CNT) xor= .iRandom
    next CNT
    .iHash xor= .iRandom
    .iRandom xor= &hFF884422
  end with
  
  #ifdef __FB_NDS__
  if fatInitDefault()=0 then 
    printf !"\nFailed to switch to FAT system.\n"
    exit sub
  end if
  dim as file ptr fTest = fopen("Reinkarnoid.sav","w")
  if fTest = 0 then
    printf !"\nFailed... to Open .sav file\n"
    exit sub
  else
    fwrite(@SaveData,sizeof(SaveData),1,fTest)
    fClose(fTest)
  end if
  if nitroFSInit()=0 then
    printf !"\nFailed to switch back to NitroFS.\n"
    sleep: end
  end if
  #else
  dim as integer SaveFile = FreeFile()
  open exepath+"/Reinkarnoid.sav" for binary access write as #SaveFile
  put #SaveFile,1,SaveData
  close #SaveFile
  #endif
  
  printf !"Done!\n"
  
end sub

sub CreateStars()
  line Stars,(0,0)-(255,255),rgb(0,0,0),bf
  for CNT as integer = 0 to 1000
    dim as integer Bright = 32+rnd*192,iColor=any
    #ifdef __FB_NDS__
    dim as integer X = rnd*256, Y = rnd*256
    #define RandColor ((Bright-16+rnd*32) shr 2)
    dim as integer iR = ((Bright-16+rnd*32) shr 3)
    dim as integer iG = ((Bright-16+rnd*32) shr 3)
    dim as integer iB = ((Bright-16+rnd*32) shr 3)
    iColor = iR or (iG shl 5) or (iB shl 10) or &h8000
    dim as ushort ptr pStars = Stars+Sizeof(fb.image)
    pStars[(Y shl 8)+X] = iColor
    #else
    iColor = rgb(Bright-16+rnd*32,Bright-16+rnd*32,Bright-16+rnd*32)
    pset Stars,(rnd*256,rnd*256),iColor
    #endif
  next CNT  
end sub

sub VideoInit()
  
  #ifdef Render_OpenGL
  ogl.UseOpenGL=0
  #endif
  
  #ifdef __FB_NDS__
  ScrDouble=0: gfx.GfxDriver = gfx.gdOpenGL
  screenres 256,192,16
  if screenptr = 0 then
    printf(!"Failed to initialize graphics...\n")
    sleep: end
  end if
  #else  
  screen 0
  dim as integer iFlag = 0, iDdrawFull = 0
  select case ScrRender 
  case 0 'GDI Windowed
    ScreenControl(fb.SET_DRIVER_NAME,"GDI")
  case 1 'GDI FullScreen
    ScreenControl(fb.SET_DRIVER_NAME,"GDI"): iFlag = fb.gfx_fullscreen
  case 2 'OpenGL Windowed
    ScreenControl(fb.SET_DRIVER_NAME,"Default")
    #ifdef Render_OpenGL
    ogl.UseOpenGL=1
    #endif
  case 3 'OpenGL Full Desktop
    ScreenControl(fb.SET_DRIVER_NAME,"Default"):iFlag = fb.gfx_no_frame
    #ifdef Render_OpenGL
    ogl.UseOpenGL=1
    #endif
  case 4 'DirectDraw Windowed
    ScreenControl(fb.SET_DRIVER_NAME,"DirectX")
  case 5 'DirectDraw Full Desktop
    ScreenControl(fb.SET_DRIVER_NAME,"DirectX")
    iFlag = fb.gfx_no_frame: iDdrawFull = 1
  end select
  
  dim as integer ScrX,ScrY
  screeninfo ScrX,ScrY
  
  if ScrDouble=2 then
    if ScrX <= 1034 or ScrY <= 778 then iFlag or= fb.gfx_no_frame
    #ifdef Render_OpenGL
    if ogl.UseOpengl then
      screenres 1023,767,16,,iFlag or fb.gfx_high_priority
    else
      screenres 1024,768,16,,iFlag or fb.gfx_high_priority 
    end if
    #else
    screenres 1024,768,16,,iFlag or fb.gfx_high_priority 
    #endif
    if (iFlag and fb.gfx_no_frame) then      
      if ScrRender<>3 and ScrRender<>5 then
        screencontrol(fb.SET_WINDOW_POS,(ScrX-1024) shr 1,(ScrY-768) shr 1)
      end if
    end if  
  elseif ScrDouble then
    screenres 512,384,16,,iFlag or fb.gfx_high_priority
  else
    screenres 256,192,16,,iFlag or fb.gfx_high_priority  
    'view screen (0,0)-(255,191)  
  end if
  
  if ScrRender=3 or ScrRender=5 then          
    #ifdef __FB_WIN32__    
    dim as integer GfxHandle
    ScreenControl(fb.GET_WINDOW_HANDLE,GfxHandle)
    SetWindowPos(cast(hwnd,GfxHandle),HWND_TOPMOST,0,0,ScrX,ScrY,null)
    MouseAdjustX = (256 shl ScrDouble)/ScrX
    MouseAdjustY = (192 shl ScrDouble)/ScrY
    if ScrRender=3 then glViewport(0,0,ScrX,ScrY)    
    #endif
  end if
  if screenptr = 0 then
    printf(!"Failed to start screen..."): end
  end if
  windowtitle "Reinkarnoid v1.0 by: Mysoft"
  open cons for output as #99
  #endif
  
  #ifdef __FB_NDS__
  Buff = 0
  #else
  if ScrDouble then 
    if Buff=0 then Buff = ImageCreate(256,192) 
    if InTitle = 0 then InTitle = ImageCreate(128,30)
    if Scr=0 then Scr = ImageCreate(512,384)    
    if ScrDouble = 2 then
      Buff2 = ImageCreate(512,384)
      Scr2 = ImageCreate(256,192)
    else
      if Buff2 then ImageDestroy(Buff2):Buff2 = 0
      if Scr2 then ImageDestroy(Scr2):Scr2 = 0
    end if
  else 
    if Buff then ImageDestroy(Buff): Buff = 0
    if InTitle then ImageDestroy(InTitle): InTitle = 0
    if Scr then ImageDestroy(scr): Scr = 0
    '#ifndef __FB_NDS__
    'Buff = ImageCreate(256,192) 
    '#endif
  end if
  #endif
  
end sub

dim shared as integer IsLocked
sub Screenlock2()    
  if IsLocked=0 then screenlock: IsLocked = 1  
end sub
sub Screenunlock2()
  if isLocked then screenunlock: IsLocked = 0  
end sub

sub SaveCpu()
  #ifndef __FB_NDS__
  if BallSmooth then
    while abs(timer-Sync) < 1/60    
      #ifndef __FB_NDS__
      sleep 1,1
      #endif
    wend        
    SkipFrame = 0: SkipFrame2 = 0
    if abs(timer-Sync) > 1 then 
      Sync = timer
    else
      Sync += 1/60  
      if abs(timer-Sync) >= 1/60 then 
        'SkipFrame2 = 1: SkipFrame = 1
      end if  
    end if
  else
    SkipFrame2=0:SkipFrame=0:Sync=timer
  end if
  #endif
end sub

'The era, and time of this  story is unknown. 
'After the mothership arkanoid was destroyed, 
'a craft!; VALS  scrambled away from it. 
'But only to be trapped in space by someone.

'THE DIMENSION CONTROLLING FORT "DOH" HAS NOW BEEN DESTROYED
'AND TIME STARTED FLOWING BACKWARDS "VAUS" MANAGED TO ESCAPE
'FROM DISTORTED SPACE. BUT THE VOYAGE OF "ARKANOID" IN THE 
'GALAXY HAS ONLY NOW STARTED.

'1AOW-6JX0