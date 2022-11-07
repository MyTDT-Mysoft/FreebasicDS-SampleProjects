#define fbc -fpu sse

#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  '#define __FB_GFX_NO_GL_RENDER__
  '#define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define __FB_CALLBACKS_
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"  
#else
  #include "fbgfx.bi"
  #include "crt.bi"
  chdir "NitroFiles/"
  open cons for output as #99
#endif

'#define SoundEnabled

#include "fbgfx.bi"
#include "dir.bi"
#ifdef SoundEnabled
#include "fmod.bi"
#endif
#include "src/global_structures.bi"
#include "src/3dmath.bi"
#include "src/3dmath.bas"
#include "src/model_module.bi"
#include "src/model_module.bas"

#ifndef fbnormal
#define fbnormal &h21
#endif

print "1"

randomize()

#define SHIFTS   8
type iPixel as uinteger

type Maze_Header_Struct 
    iWidth               as integer   'width(X) of maze
    iLength              as integer   'length(Z) of maze
    door_positionF       as Vector3Df 'where the door for the ghost cage is located
    char_positionsF (4)  as Vector3Df 'starting positions for characters 
    fCharSpeed      (4)  as float     'speed of character movement
    fWaitTime       (4)  as float     'how long they will wait in the cage
    fScareTime      (4)  as float     'how long they stay edible
end type    

type Maze_Struct
    iTile  as short 
    nTrans as number
    Model  as Model3D ptr  
end type

type Character_Struct
    Position         as Vector3D
    Last_Position    as Vector3D
    Start_Position   as Vector3D
    Targ_Position    as Vector3D
    iAngle           as integer
    iTarg_Angle      as integer
    iGo_Direction    as integer
    nScalar          as number
    nSpeed           as number
    nTurnSpeed       as number
    nAnimation       as number
    iAnimation_Inc   as integer
    iAnimation_Speed as integer
    nRadius          as number
    iMood            as integer
    iScore           as uinteger
    nGBoxTime        as number
    nIn_gBoxTime     as number
    nScaredTime      as number
    nIn_ScaredTime  as number
    iDied            as integer
    zname            as zstring ptr
end type

type Path_Struct
    iCs          as integer
    iPx          as integer
    iPz          as integer
    iF           as integer
    iG           as integer
    iH           as integer
    iP           as integer
end type

type OpenList_Struct
    iX   as integer
    iZ   as integer
end type

declare sub FindPath (pCharsI as const Character_Struct ptr, byref ReturnUDT as Vector3D )
declare sub Rest_Positions( )
declare sub Init_Characters( )
declare sub Ghost_Logic( s_Ltime as number)
declare function Find_Angle( nX1 as const number, nY1 as const number, nX2 as const number, nY2 as const number ) as integer
declare function Check_Wall_Collision( byref Cam as Vector3D, n_Radius as const number, Model as const Model3D ptr, byref tTrans as Vector3D ) as integer
declare sub Model_Transform( Model as Model3D ptr, pnM as number ptr, piFcnt as integer ptr, byref Camera as Vector3D, byref Light_Position as Vector3D, nColor_Mult as number, nDepth_Offset as const number )
declare sub Buffer_Render( piFCnt as integer ptr )
declare function Sort cdecl (elm1 as any ptr, elm2 as any ptr ) as integer
declare sub DJ_triangle(d as ushort ptr,p as vector2dInt ptr, c as iPixel,b as const iPixel=0, u as const integer=0 )
declare sub Load_SFX( )
declare sub Intro()
declare sub New_Screen_Res( W as const integer,H as const integer,tFlags as const integer )
declare sub Navigate_Menu(Direction as const integer, Menu_Level as integer ptr, Menu_Highlight as const integer )
declare sub Build_Menu_Array(Menu() as string, Menu_Level as const integer )
declare sub Get_File_List( filespec as const string, attrib as const integer, Array() as string, Offset as const integer )
declare function Get_File_Cnt( filespec as const string, attrib as const integer ) as integer
declare sub Save_Maze( Filename as const string, byref Header as Maze_Header_Struct )
'Declare Sub Load_Maze( Byref Filename As String, Byref Header As Maze_Header_Struct, Maze() As Maze_Struct )
declare sub Load_Maze( Filename as const string, byref Header as Maze_Header_Struct )

#macro WaitForKeyRelease(MultiKeys)
do
    'ScreenControl FB.POLL_EVENTS,1
    if (MultiKeys)=0 then exit do
    flip: screensync
loop
#endmacro

enum
    MENU_TOP
    MENU_NEW_GAME
    MENU_LOAD_USER_MAZE
    MENU_LOAD_USER_MAZE1
    MENU_GFX
    MENU_GFX_SUB1
    MENU_GFX_SUB2
    MENU_GFX_SUB3
    MENU_SFX
    MENU_SFX_SUB1
    MENU_SFX_SUB2
    MENU_HIGH_SCORES
    MENU_CONTROLS
    MENU_QUIT
end enum

enum
    MOOD_COMPLACENT
    MOOD_PISSED
    MOOD_STRATEGIZE
    MOOD_SCARED
    MOOD_GOHOME
    MOOD_WAITING
end enum

enum
    SONG_NORMAL
    SONG_ACTION
    SONG_MENU
end enum

enum
    GO_NONE
    GO_UP
    GO_DOWN
    GO_LEFT
    GO_RIGHT
end enum

const OpenL = 1, CloseL = -1, Nul = 0
dim shared as integer SCR_WIDTH, SCR_HEIGHT
dim shared as integer SCR_WD2, SCR_HD2
dim shared as integer Flags, iLENS
dim shared as integer Control_Scheme = 2
dim shared as integer Song_Type, Last_Song_Type, Play_Music = 1, Play_Sounds = 1
dim shared as integer DO_FIND_PATH

dim as string Menu()

redim Menu( 7 )
Menu(0) = "MAIN MENU"
Menu(1) = "NEW GAME"
Menu(2) = "LOAD USER MAZE"
Menu(3) = "GFX OPTIONS"
Menu(4) = "SFX OPTIONS"
Menu(5) = "HIGH SCORES"
Menu(6) = "CONTROLS"
Menu(7) = "QUIT"

#ifdef __FB_NDS__
gfx.GfxDriver = gfx.gdOpenGL
#endif

print "2"

New_Screen_Res( 256, 192, FB.GFX_WINDOWED )

print "3"

const MAX_MAZE_MODELS = 5
const MAX_PAC_MODELS = 10
const MAX_GHOST_MODELS = 60
const MAX_SOUNDS = 6
const MAX_TEXT_FX = 5

dim as integer iSyncOn = 1, iMenu_Highlight, iMenu_Level = MENU_TOP
dim shared as integer iWireFrame = 0, iRender_Shadows = 1, iGame_On
dim shared as integer iTotal_Pellets, iPellets_Eaten, iDo_Chomp
dim shared as integer iAte_Em, iRand_Text_Id, iMenu_Active = true, iExit_Game = False
dim as integer iMusic_Volume = 35, iSFX_Volume = 255
dim as integer iDraw_Dist = 15, iGhosts_Scared
dim shared as Model3D ptr ptr Maze_Models
dim shared as Model3D ptr ptr Pac_Models
dim shared as Model3D ptr ptr Ghost_Models
dim shared as Model3D ptr Collision_Cube
dim shared as number ptr inverse_pnM
dim as Vector3D CamPos, Look, Last_Pac_Position
dim as Vector3D Cam_Targ = ( ToFixedi(50), ToFixedi(50), ToFixedi(50) ), Look_Targ
dim as number  nZoom = ToFixedi(1), nColorMult = ToFixedi(1), nKeyDelay
dim as number nNTime, nDemoTime, nStoppedTime
dim as string FPS_Time
dim as integer iFPS, iDemo_Targ_Index
dim as Vector3D Light_Position = ( ToFixed(-29.86316), ToFixedi(120), ToFixed(40.00959) )
dim shared as OpenList_Struct Door_Position
dim as string Text_Fx(MAX_TEXT_FX )
redim shared rBuffer(5000) as sortstuff
dim  as integer iMenu_Position = 1, iIntro_Started
dim as integer iFcnt
dim shared as integer iUboundMaze1,iUboundMaze2
#ifdef SoundEnabled
dim shared Sfx( MAX_SOUNDS ) as FSound_Sample ptr
dim shared song as FSOUND_Stream ptr
dim as integer iFree_Channel, iChomp_Channel
#endif

dim shared as double dTempTmr,dRenderTime,dGeometryTime,dOtherTime

#ifdef UseFixedPoint
dim shared as NumberSmall AcosTab(-FixMul to FixMul)
for CNT as integer = -FixMul to FixMul  
  AcosTab(CNT) = ToFixed((acos(ToFloat(CNT))*-.35)+1)
next CNT
#endif

Text_Fx(1) = "N00B!!!11~"
Text_Fx(2) = "STFU!!!11"
Text_Fx(3) = "ROFL!!!111"
Text_Fx(4) = "HAXORED!!!"
Text_Fx(5) = "PWNAGE!!!111"

Maze_Models  = callocate( MAX_MAZE_MODELS  * sizeof(Model3d))
if Maze_Models = 0 then print "Failed to allocate maze models"
Pac_Models   = callocate( MAX_PAC_MODELS   * sizeof(Model3d))
if Maze_Models = 0 then print "Failed to allocate pacman models"
Ghost_Models = callocate( MAX_GHOST_MODELS * sizeof(Model3d))
if Maze_Models = 0 then print "Failed to ghost models"

inverse_pnM = allocate( MAT_SIZE )

print "3"

Load_Obj( "Models/Floor.obj", Maze_Models[0], 1 )
Load_Obj( "Models/Pellet.obj",  Maze_Models[1], 1 )
Load_Obj( "Models/Power_Pellet.obj",  Maze_Models[2], 1 )
Load_Obj( "Models/Wall.obj",  Maze_Models[3], 1 )
Load_Obj( "Models/Bars.obj",  Maze_Models[4], 1 )
Load_Obj( "Models/Collision_Cube.obj",  Collision_Cube, 1 )

print "4"

#ifdef __FB_NDS__
iRender_Shadows = 0
#endif

for i as integer = 1 to MAX_PAC_MODELS
    dim as string fName
    if i<10 then
        fname = "Models/Pac_" & "00" & i & ".obj"
    else
        fname = "Models/Pac_" & "0" & i & ".obj"
    end if  
    Load_Obj( fname, Pac_Models[i-1], 1 )
next

print "5"

'just loading the same model over and over and changing the color depening on which character it is.
dim as integer i = 0
for ni as integer = 0 to MAX_GHOST_MODELS - 1
    i+=1
    if i>10 then i = 1
    dim as string fName
    
    if ni<50 then
        if i<10 then
            fname = "Models/Ghost_" & "00" & i & ".obj"
        else
            fname = "Models/Ghost_" & "0" & i & ".obj"
        end if
    else
        if i<10 then
            fname = "Models/Eyes_" & "00" & i & ".obj"
        else
            fname = "Models/Eyes_" & "0" & i & ".obj"
        end if
    end if
    
    if ni<>(i-1) then
        Ghost_Models[ni] = Ghost_Models[i-1]
    else
        Load_Obj( fname, Ghost_Models[ni], 1 )
    end if
    
    dim as integer Change_Color
    dim as RGBInt New_Color
    
    select case as const ni
        case 0 to 9
        case 10 to 19
            New_Color = type(  0,255,  0)
            Change_Color = true
        case 20 to 29
            New_Color = type(  0,  0,255)
            Change_Color = true
        case 30 to 39
            New_Color = type(255,105,180)
            Change_Color = true
        case 40 to 49
            New_Color = type(255,255,255)
            Change_Color = true
    end select
    
    if Change_Color <> 0 then
        for ci as integer = 0 to Ghost_Models[ni]->iMax_triangles - 1
            if Ghost_Models[ni]->triangles[ci].col.iR = 255 then
                if Ghost_Models[ni]->triangles[ci].col.iG = 0 then
                    if Ghost_Models[ni]->triangles[ci].col.iB = 0 then
                        Ghost_Models[ni]->triangles[ci].col = New_Color
                    end if
                end if
            end if
        next
    end if
    
next

print "6"

dim as number ptr pnMatrix = callocate( MAT_SIZE )

d3Matrix_Load_Identity( pnMatrix )

dim shared as Maze_Header_Struct Header
dim shared as Maze_Struct Maze(21,21)
dim shared Valid_Index as OpenList_Struct ptr,iUbound_ValidIndex as integer
dim shared as Character_Struct Chars(4)
dim shared as Character_Struct Hero
dim shared as integer iUbound_Chars = 4

print "7"

Load_Maze( "Data/Levels/Level_001.maz", Header )

print "8"

Init_characters( )

dim as integer iZStart
dim as integer iZEnd
dim as integer iXStart
dim as integer iXEnd

dim as number nLastLoop
dim as number nLTime, nLoopTime
dim as number nFrequency = ToFixed(1/60),nOrgFreq=nFrequency
dim shared as number nDiedTime,nThisTime, nPauseTime
nThisTime = toFixed(sTimer())


#ifdef SoundEnabled
if( FSOUND_GetVersion() < FMOD_VERSION ) then
    'Not sure what to do here.
    'try to just run without sound.
end if
FSOUND_SetMinHardwareChannels( 16 )
if( FSOUND_Init(44100, 1, 0) = FALSE ) then
    'Not sure what to do here.
    'try to just run without sound.
end if
Load_Sfx( )
song = FSOUND_Stream_Open( "Data/Sfx/pacsong.ogg", FSOUND_LOOP_NORMAL, 0, 0 )
dim as integer playsong
if song = 0 then
    dim as uinteger errsound = FSound_GetError()
    print "FMOD error #" &errsound
    print "Running without sound."
    sleep 5000
else    
    playsong = 1
end if

playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
Last_Song_Type = SONG_NORMAL
Song_Type = SONG_MENU
FSOUND_SetVolume ( playsong, Music_Volume )
FSOUND_SetSFXMasterVolume( Sfx_Volume )
#endif

print "9"

Intro()

#ifdef SoundEnabled
Free_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(2), 0, 0 )
FSOUND_3D_SetAttributes( Free_Channel, 0, 0 )
#endif

nThisTime = ToFixed(sTimer())
nPauseTime = nThisTime+ToFixed(5)
nStoppedTime = nThisTime
nLastLoop = nThisTime
Rest_Positions( )

cls

#define StartTime() dTempTmr = sTimer()
#define MeasureTime(TimeVar) TimeVar = sTimer()-dTempTmr

do  
    
    #ifdef __FB_NDS__
    locate 1,1    
    printf(!"   Other Time: %i ms    \n",cint(dOtherTime*1000))
    printf(!"Geometry Time: %i ms    \n",cint(dGeometryTime*1000))
    printf(!"  Render Time: %i ms    \n",cint(dRenderTime*1000))  
    'printf(!"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    #endif  
    
    'Light_Position = type( tofixed(50*sin(timer)), 50, tofixed(50*sin(timer*2.5)))
    
    StartTime()    
    nThisTime = ToFixed(sTimer())
    nLTime = nThisTime-nLastLoop
    if nLTime > ToFixed(.1) then  nLTime = ToFixed(.1)
    nLastLoop = nThisTime
    
    if iMenu_Active = 0 then
        if nColorMult < ToFixedi(1) then
            nColorMult += nLTime
            if nColorMult > ToFixedi(1) then nColorMult = ToFixedi(1)
        end if
        
        if iGhosts_Scared then
            dim as integer SCount
            var pChar = @Chars(0)
            for i as integer = 1 to (iUbound_Chars)
                pChar += 1
                if (pChar->iMood)<>MOOD_SCARED then SCount+=1        
            next
            
            if SCount = (iUbound_Chars) then
                iGhosts_Scared = False
                Song_Type = SONG_NORMAL
                if Play_Music then
                    #ifdef SoundEnabled
                    FSOUND_Stream_Close( song )
                    song = FSOUND_Stream_Open( "Data/Sfx/Pacsong.ogg", FSOUND_LOOP_NORMAL, 0, 0 )
                    playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
                    FSOUND_SetVolume ( playsong, Music_Volume )    
                    #endif
                end if
            end if
        end if
        
        'Repeat it to make that part work at 60 fps always
        
        nLoopTime += nLTime
        DO_FIND_PATH = -1
        
        do while nLoopTime > ToFixedi(0)
            
            'Frequency = lTime
            Maze(Door_Position.iX, Door_Position.iZ).nTrans = abs(ToFixed(sin(ToFloat(nThisTime))*1.5))
            
            if iGame_On and iAte_Em = 0 then        
                if Hero.iDied then
                    Hero.iAngle += ToCint((1080*nFrequency))
                    Hero.nScalar -= (FixMulFixSmall(ToFixed(.6),nFrequency))
                    nZoom -= (5*nFrequency)
                    if Hero.nScalar<ToFixedi(0) then Hero.nScalar = ToFixedi(0)
                    if nThisTime >= nDiedTime then
                        nZoom = ToFixedi(1)
                        Hero.iDied = 0
                        nPauseTime = nThisTime+ToFixedi(3)
                        iGame_On = False
                        Hero.nScalar = ToFixedi(1)
                        Hero.iAngle = 0
                        if Play_Sounds then
                            #ifdef SoundEnabled
                            Free_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(2), 0, 0 )
                            FSOUND_3D_SetAttributes( Free_Channel, @Hero.Position.X, 0 )
                            #endif
                        end if
                        if Play_Music then
                            #ifdef SoundEnabled
                            playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
                            FSOUND_SetVolume ( playsong, Music_Volume )
                            #endif
                        end if
                        Rest_Positions( )
                        Song_Type = SONG_NORMAL
                    end if
                else    
                    
                    ' Pacestein movement
                    Last_Pac_Position = Hero.Position
                    iDo_Chomp = False
                    select case as const Control_Scheme
                        case 1
                            if UpIsPressed() then
                                dim as number nHeroSpeed = FixedMulFixed(nFrequency,Hero.nSpeed)
                                Hero.Position.nX -= (FixedMulFixed(ToFixed(sin(Hero.iAngle*sPid180)),nHeroSpeed))
                                Hero.Position.nZ -= (FixedMulFixed(ToFixed(cos(Hero.iAngle*sPid180)),nHeroSpeed))
                            end if
                            
                            if DownIsPressed() then
                                dim as number nHeroSpeed = FixedMulFixed(nFrequency,Hero.nSpeed)
                                Hero.Position.nX += (FixedMulFixed(ToFixed(sin(Hero.iAngle*sPid180)),nHeroSpeed))
                                Hero.Position.nZ += (FixedMulFixed(ToFixed(cos(Hero.iAngle*sPid180)),nHeroSpeed))
                            end if
                            
                            
                            if LeftIsPressed() then
                                Hero.iAngle -= ToCint(FixedMulFixed(Hero.nTurnSpeed,nFrequency))
                                if Hero.iAngle<0 then Hero.iAngle = 360+Hero.iAngle
                            end if
                            
                            if RightIsPressed() then
                                Hero.iAngle += ToCint(FixedMulFixed(Hero.nTurnSpeed,nFrequency))
                                if Hero.iAngle>360 then Hero.iAngle = Hero.iAngle-360
                            end if
                            
                        case 2
                            dim as Vector3DInt cpos
                            cpos.iX = ToCint(Hero.Position.nX)
                            cpos.iZ = ToCint(Hero.Position.nZ)
                            
                            if UpIsPressed() or Hero.iGo_Direction = GO_UP then
                                Hero.iGo_Direction = GO_UP
                                if abs(ToFixedi(cpos.iX) - Hero.Position.nX) <= ToFixed(.1) then
                                    if abs(ToFixedi(cpos.iZ) - Hero.Position.nZ) <= ToFixed(.1) then
                                        if Maze(cpos.iX, cpos.iZ-1).iTile <>3 then
                                            Hero.iTarg_Angle = 0
                                        end if
                                    end if
                                end if
                            end if
                            
                            if DownIsPressed() or Hero.iGo_Direction = GO_DOWN then
                                Hero.iGo_Direction = GO_DOWN
                                if abs(ToFixedi(cpos.iX) - Hero.Position.nX) <= ToFixed(.1) then
                                    if abs(ToFixedi(cpos.iZ) - Hero.Position.nZ) <= ToFixed(.1) then
                                        if Maze(cpos.iX, cpos.iZ+1).iTile <> 3 then
                                            Hero.iTarg_Angle = 180
                                        end if
                                    end if
                                end if
                            end if
                            
                            if LeftIsPressed() or Hero.iGo_Direction = GO_LEFT then
                                Hero.iGo_Direction = GO_LEFT
                                if abs(ToFixedi(cpos.iX) - Hero.Position.nX) <= ToFixed(.1) then
                                    if abs(ToFixedi(cpos.iZ) - Hero.Position.nZ) <= ToFixed(.1) then
                                        if Maze(cpos.iX+1, cpos.iZ).iTile <>3 then
                                            Hero.iTarg_Angle = 270
                                        end if
                                    end if
                                end if    
                            end if
                            
                            if RightIsPressed() or Hero.iGo_Direction = GO_RIGHT then
                                Hero.iGo_Direction = GO_RIGHT
                                if abs(ToFixedi(cpos.iX) - Hero.Position.nX) <= ToFixed(.1) then
                                    if abs(ToFixedi(cpos.iZ) - Hero.Position.nZ) <= ToFixed(.1) then
                                        if Maze(cpos.iX-1, cpos.iZ).iTile <> 3 then
                                            Hero.iTarg_Angle = 90
                                        end if
                                    end if
                                end if
                            end if
                            
                            Hero.iAngle = Hero.iTarg_Angle
                            var nTempSpeed = FixedMulFixed(nFrequency , Hero.nSpeed)
                            Hero.Position.nX -= FixedMulFixed(ToFixed(sin(Hero.iAngle*sPid180)),nTempSpeed)
                            Hero.Position.nZ -= FixedMulFixed(ToFixed(cos(Hero.iAngle*sPid180)),nTempSpeed)
                            
                    end select
                    
                    ' Pacestein collision 
'                    iZStart = ToCint(Hero.Position.nZ)-1
'                    iZEnd   = ToCint(Hero.Position.nZ)+1
'                    iXStart = ToCint(Hero.Position.nX)-1
'                    iXEnd   = ToCint(Hero.Position.nX)+1
'                    if iZStart<1 then iZStart=1
'                    if iXStart<1 then iXStart=1
'                    if iZEnd>iUboundMaze2 then iZEnd = iUboundMaze2
'                    if iXEnd>iUboundMaze1 then iXEnd = iUboundMaze1
                    'for Z as integer = iZStart to iZEnd
                    '  for X as integer = iXStart to iXEnd
                    '    if Maze(X,Z).iTile > 2 then
                    'Check_Wall_Collision( Hero.Position, Hero.nRadius, _
                    'Collision_Cube, type(ToFixedi(X),Maze(X,Z).nTrans,ToFixedi(Z)) )
                    '    end if
                    '  next
                    'next
                    
                    'dim as integer iXPos, iZPos

                    'with Hero.Position
                    '    
                    '    if .nX < ToFixedi(2) then iXPos = ToFixedi(2)            
                    '    if .nX > ToFixedi(iUboundMaze1-1) then .nX = ToFixedi(iUboundMaze1-1)
                    '    
                    '    if .nZ < ToFixedi(2) then iZPos = ToFixedi(2)            
                    '    if .nZ > ToFixedi(iUboundMaze2-1) then .nZ = ToFixedi(iUboundMaze2-1)
                    '    
                  
                    
                    
                  with Hero.Position
                  	
                  	#define MazePoint(oX,oZ) maze(ToCint(.nX+ToFixed(oX)),ToCint(.nZ+ToFixed(oZ)))
                  	
	                  var HeroSpeed = FixedMulFixed( nFrequency , Hero.nSpeed )
							if MazePoint(0, .475).iTile > 2 then .nZ -= HeroSpeed
							if MazePoint(0,-.475).iTile > 2 then .nZ += HeroSpeed
							if MazePoint( .475,0).iTile > 2 then .nX -= HeroSpeed
							if MazePoint(-.475,0).iTile > 2 then .nX += HeroSpeed
						
						end with
                    
                    
                    ' eat a pellet?
                    #define EatPosX Last_Pac_Position.nX-Hero.Position.nX
                    #define EatPosZ Last_Pac_Position.nZ-Hero.Position.nZ
                    if abs(EatPosX) > ToFixed(.01) or abs(EatPosZ) > ToFixed(.01) then
                        iDo_Chomp = true
                    end if
                    
                    ' eating pellet animation
                    if iDo_Chomp then            
                        Hero.nAnimation += (Hero.iAnimation_Inc*Hero.iAnimation_Speed)*nFrequency
                        if Hero.nAnimation > ToFixedi(MAX_PAC_MODELS-1) then
                            Hero.nAnimation = ToFixedi(MAX_PAC_MODELS-1)
                            Hero.iAnimation_Inc = -Hero.iAnimation_Inc
                        elseif Hero.nAnimation < ToFixedi(0) then
                            Hero.nAnimation = ToFixedi(0)
                            Hero.iAnimation_Inc = -Hero.iAnimation_Inc
                        end if
                    end if
                    
                    if Maze(ToCint(Hero.Position.nX), ToCint(Hero.Position.nZ)).iTile = 1 then
                        Maze(ToCint(Hero.Position.nX), ToCint(Hero.Position.nZ)).iTile = 0
                        Hero.nAnimation = ToFixedi(0)
                        Hero.iAnimation_INC = -Hero.iAnimation_INC
                        iPellets_Eaten += 1: Hero.iScore += 50
                        if Play_Sounds then
                            #ifdef SoundEnabled
                            Chomp_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(1),0,0 )
                            FSOUND_3D_SetAttributes( Chomp_Channel, @Hero.Position.X, 0 )
                            #endif
                        end if
                    elseif Maze(ToCint(Hero.Position.nX), ToCint(Hero.Position.nZ)).iTile = 2 then
                        Maze(ToCint(Hero.Position.nX), ToCint(Hero.Position.nZ)).iTile = 0
                        Hero.nAnimation = ToFixedi(0)
                        Hero.iAnimation_INC = -Hero.iAnimation_INC
                        iPellets_Eaten+=1: Hero.iScore+=500
                        if Play_Sounds then
                            #ifdef SoundEnabled
                            Chomp_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(5),0,0 )
                            FSOUND_3D_SetAttributes( Chomp_Channel, @Hero.Position.X, 0 )
                            #endif
                        end if
                        if Song_Type <> SONG_ACTION then
                            Song_Type = SONG_ACTION
                            if Play_Music then
                                #ifdef SoundEnabled
                                FSOUND_Stream_Close( song )
                                song = FSOUND_Stream_Open( "Data/Sfx/Pacbo.ogg", FSOUND_LOOP_NORMAL, 0, 0 )
                                playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
                                FSOUND_SetVolume ( playsong, Music_Volume )
                                #endif
                            end if
                        end if
                        
                        iGhosts_Scared = true
                        var pCharI = @Chars(0)
                        for i as integer = 1 to (iUbound_Chars)
                            pCharI += 1
                            select case pCharI->iMood
                                case MOOD_WAITING, MOOD_GOHOME
                                case else
                                    pCharI->iMood = MOOD_SCARED
                                    pCharI->nIn_ScaredTime = nThisTime + pCharI->nScaredTime
                                    dim as integer tRand = int(rnd*iUbound_ValidIndex)
                                    pCharI->Targ_Position.nX = ToFixedi(Valid_Index[tRand].iX)
                                    pCharI->Targ_Position.nZ = ToFixedi(Valid_Index[tRand].iZ)
                            end select
                        next
                    end if
                end if
                
                Ghost_Logic( nFrequency )
                DO_FIND_PATH = 0
                
            else
                if nThisTime>nPauseTime then
                    if iAte_Em > 0 then
                        var pChars = @Chars(iAte_Em)
                        pChars->iMood = MOOD_GOHOME
                        pChars->nScalar = ToFixedi(1)
                        iAte_Em = 0
                    end if
                    iGame_On = true
                    nZoom = ToFixedi(1)
                end if
            end if      
            nLoopTime -= nFrequency
         
            
        loop    
        
        
    else    
        
        if Song_Type <> SONG_MENU then
            Last_Song_Type = Song_Type
            Song_Type = SONG_MENU
            if iIntro_Started then
                if Play_Music then
                    #ifdef SoundEnabled
                    FSOUND_Stream_Close( song )
                    song = FSOUND_Stream_Open( "Data/Sfx/Intro.ogg", FSOUND_LOOP_NORMAL, 0, 0 )
                    playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
                    FSOUND_SetVolume ( playsong, Music_Volume )
                    #endif
                end if
            end if
            iIntro_Started = true
        end if
        
        if nColorMult > ToFixed(.5) then
            nColorMult -= FixedMulFixed(nLTime,ToFixed(1/3))
            if nColorMult < ToFixed(.5) then nColorMult = ToFixed(.5)
        end if
        
        if nThisTime>=nKeyDelay then
            nKeyDelay = nThisTime+ToFixed(.1)
            if UpIsPressed() then
                iMenu_Highlight -= 1
            end if
            
            if DownIsPressed() then
                iMenu_Highlight += 1
            end if
            
            if iMenu_Highlight < 1 then iMenu_Highlight=1
            if iMenu_Highlight>ubound(Menu) then iMenu_Highlight=ubound(Menu)
            
            if EnterIsPressed() then
                Navigate_Menu( GO_UP, @iMenu_Level, iMenu_Highlight )
                Build_Menu_Array( Menu(), iMenu_Level )
                
                if iMenu_Level = MENU_LOAD_USER_MAZE1 then                    
                    Load_Maze( "Data/Levels/User/" & Menu(iMenu_Highlight), Header )
                    Rest_Positions( )
                end if
                
                if iMenu_Level = MENU_LOAD_USER_MAZE then
                    iMenu_Level = MENU_LOAD_USER_MAZE1
                end if
                
                WaitForKeyRelease( EnterIsPressed() )
            end if
        end if
        
        
        if EscapeIsPressed() then
            nKeyDelay = nThisTime+ToFixed(.2)
            Navigate_Menu( GO_DOWN, @iMenu_Level, iMenu_Highlight )
            Build_Menu_Array( Menu(), iMenu_Level )
            if iMenu_Active = False then
                Song_Type = Last_Song_Type
                dim as string Song_File
                select case as const Last_Song_Type
                    case SONG_ACTION
                        Song_File = "Data/Sfx/Pacbo.ogg"
                    case SONG_NORMAL
                        Song_File = "Data/Sfx/Pacsong.ogg"
                end select
                #ifdef SoundEnabled
                FSOUND_Stream_Close( song )
                #endif
                if Play_Music then
                    #ifdef SoundEnabled
                    song = FSOUND_Stream_Open( Song_File, FSOUND_LOOP_NORMAL, 0, 0 )
                    playsong = FSOUND_Stream_Play( FSOUND_FREE, song )
                    FSOUND_SetVolume ( playsong, Music_Volume )
                    #endif
                end if
                if iGame_on = 0 then
                    nPauseTime += (nThisTime-nStoppedTime)
                end if
                
                if Hero.iDied then
                    nDiedTime += (nThisTime-nStoppedTime)
                end if
                
                var pCharsI = @Chars(0)
                for i as integer = 1 to (iUbound_chars)
                    pCharsI += 1
                    select case pCharsI->iMood
                        case MOOD_WAITING
                            pCharsI->nIn_gBoxTime += (nThisTime-nStoppedTime)
                        case MOOD_SCARED
                            pCharsI->nIn_ScaredTime += (nThisTime-nStoppedTime)
                    end select    
                next
            end if
        end if   
        
        
    end if
    
    if iAte_Em then
        nZoom -= 10*nLTime
    end if
    
    if EscapeIsPressed() then
        if nThisTime > nKeyDelay then
            nKeyDelay = nThisTime+ToFixed(.1)
            if iMenu_Active = 0 then
                iMenu_Active = 1
                WaitForKeyRelease( EscapeIsPressed() )
                nStoppedTime = nThisTime
            end if
        end if
    end if
    
    ' X quit the game
    if multikey( FB.SC_X ) then end
    ' O increase zoom
    if oIsPressed() then nZoom += ToFixed(.1)
    ' I decrease zoom
    if iIsPressed() then nZoom -= ToFixed(.1)
    
    ' zoom range
    if nZoom>ToFixedi(5) then 
        nZoom = ToFixedi(5)
    elseif nZoom<ToFixed(.25) then 
        nZoom = ToFixed(.25)
    end if
    
    'Check/Switch Vsync
    if vIsPressed() then
        iSyncOn xor = 1
        printf(!"Vsync: %i\n",iSyncOn)
        WaitForKeyRelease( vIsPressed() )
    end if
    'Check/Switch Wireframe
    if wIsPressed() then
        iWireFrame xor = 1
        printf(!"WireFrame: %i\n",iWireFrame)
        WaitForKeyRelease( wIsPressed() )
    end if
    'Check/Switch Shadows
    if sIsPressed() then
        iRender_Shadows xor = 1
        printf(!"Shadows: %i\n",iRender_Shadows)
        WaitForKeyRelease( sIsPressed() )
    end if
    'Check/Increase music volume
    dim as integer iOMusic_Volume = iMusic_Volume
    if multikey( FB.SC_RIGHTBRACKET ) then
        iMusic_Volume += 1
        if iMusic_Volume >255 then iMusic_Volume = 255
    end if
    'Check/Decrease music volume
    if multikey( FB.SC_LEFTBRACKET ) then
        iMusic_Volume -= 1
        if iMusic_Volume < 0 then iMusic_Volume = 0
    end if
    'music Volume changed?
    if iOMusic_Volume<>iMusic_Volume then
        if Play_Music then
            #ifdef SoundEnabled
            FSOUND_SetVolume ( playsong, Music_Volume )
            #endif
        end if
    end if
    'check/increase sfx volume
    dim as integer iOSfx_Volume = iSfx_Volume
    if multikey( FB.SC_PAGEUP ) then
        iSfx_Volume += 1
        if iSfx_Volume >255 then iSfx_Volume = 255
    end if  
    'check/decrease sfx volume
    if multikey( FB.SC_PAGEDOWN ) then
        iSfx_Volume -= 1
        if iSfx_Volume < 0 then iSfx_Volume = 0
    end if
    'sfx volume changed?
    if iOSfx_Volume<>iSfx_Volume then
        if Play_Sounds or Play_Music then
            #ifdef SoundEnabled
            FSOUND_SetSFXMasterVolume( iSfx_Volume )
            #endif
        end if
    end if
    'Camera position
    static as number nVertexMult = ToFixedi(1)
    #ifdef __FB_NDS__
    if gfx.VertexCount > 6000 then
        #ifdef UseFixedPoint
        nVertexMult = ((nVertexMult*3)+ToFixed((6000\gfx.VertexCount))) shr 2
        #else
        'Is this way because Fixed point works with "shr"
        nVertexMult = ((nVertexMult*3)+ToFixed((6000\gfx.VertexCount)))*(1/4)
        #endif
        if nVertexMult < ToFixed(.25) then nVertexMult = ToFixed(.25)
        if nVertexMult > ToFixedi(1) then nVertexMult = ToFixedi(1)
    elseif gfx.VertexCount < 2000 then
        nVertexMult = ToFixedi(1)
    end if
    #endif
    
    if iMenu_Active = 0 then
        dim as number nTZoom = nZoom
        if Hero.iGo_Direction = GO_DOWN then
            nTZoom *= 2
            if nTZoom > ToFixedi(5) then nTZoom = ToFixedi(5)
        end if
        nTZoom = FixedMulFixed(nTZoom,nVertexMult)
        
        Look = Hero.Position
        select case as const Control_Scheme
            case 1
                CamPos.nX = (Hero.Position.nX+(6*nTZoom))
                CamPos.nY = (Hero.Position.nY+(8*nTZoom))
                CamPos.nZ = (Hero.Position.nZ+(6*nTZoom))
            case 2
                CamPos.nX = (Hero.Position.nX)
                CamPos.nY = (Hero.Position.nY+(8*nTZoom))
                CamPos.nZ = (Hero.Position.nZ+(6*nTZoom))
        end select   
        
        'ps: FixedMulFixed2 is the same, is just there to avoid nested macros :)
        if Hero.iDied then
            Campos.nX = Hero.Position.nX + (6 * ToFixed(sin(ToFloat(nThisTime*5))))
            Campos.nZ = Hero.Position.nZ + (6 * ToFixed(cos(ToFloat(nThisTime*5))))      
            Cam_Targ.nX += FixedMulFixed((CamPos.nX-Cam_Targ.nX),nLTime*10)
            Cam_Targ.nY += FixedMulFixed((CamPos.nY-Cam_Targ.nY),nLTime*10)
            Cam_Targ.nZ += FixedMulFixed((CamPos.nZ-Cam_Targ.nZ),nLTime*10)
        else      
            Cam_Targ.nX += FixedMulFixed((CamPos.nX-Cam_Targ.nX),nLTime)
            Cam_Targ.nY += FixedMulFixed((CamPos.nY-Cam_Targ.nY),nLTime)
            Cam_Targ.nZ += FixedMulFixed((CamPos.nZ-Cam_Targ.nZ),nLTime)
        end if
        
    else
        
        if nThisTime>nDemoTime then
            nDemoTime = nThisTime + ToFixedi(2)
            iDemo_Targ_Index += 1
            
            if iDemo_Targ_Index>(iUbound_Chars) then iDemo_Targ_Index = 0
            
            if iDemo_Targ_Index = 0 then
                Look = Hero.Position
            else
                Look = Chars(iDemo_Targ_index).Position
            end if
            Look.nY = ToFixedi(-2)
        end if
        
        CamPos.nX = FixedMulFixed(ToFixed((iUboundMaze1 shr 1)+ _
        iUboundMaze1*sin(ToFloat(nThisTime))),nVertexMult)
        CamPos.nY = FixedMulFixed(ToFixed(14+6*sin(ToFloat(nThisTime)*(1\3))),nVertexMult)
        CamPos.nZ = FixedMulFixed(ToFixed((iUboundMaze2 shr 1)+ _
        iUboundMaze2*cos(ToFloat(nThisTime))),nVertexMult)
        
        Cam_Targ.nX += FixedMulFixed((CamPos.nX-Cam_Targ.nX),nLTime)
        Cam_Targ.nY += FixedMulFixed((CamPos.nY-Cam_Targ.nY),nLTime)
        Cam_Targ.nZ += FixedMulFixed((CamPos.nZ-Cam_Targ.nZ),nLTime)
        
        
    end if
    
    
    #ifdef UseFixedPoint
    var nTempTime = nLTime shl 1
    #else
    'is this way because fixed point works with SHR
    var nTempTime = nLTime '*.5
    #endif    
    Look_Targ.nx += FixedMulFixed((Look.nx-Look_Targ.nx),nTempTime)
    Look_Targ.ny += FixedMulFixed((Look.ny-Look_Targ.ny),nTempTime)
    Look_Targ.nz += FixedMulFixed((Look.nz-Look_Targ.nz),nTempTime)
    
    MeasureTime(dOtherTime)
    StartTime()
    
    d3Matrix_Load_Identity( pnMatrix )
    d3Matrix_LookAt( pnMatrix, Cam_Targ, Look_Targ, type(ToFixed(0),ToFixed(1),ToFixed(0)) )
    
    dim as Vector3D Tempd = type((Cam_Targ.nX-Look_Targ.nX), _
    (Cam_Targ.nY-Look_Targ.nY),(Cam_Targ.nZ-Look_Targ.nZ))
    
    Vector_Normalize( Tempd )
    
    if Play_Sounds then
        #ifdef SoundEnabled
        FSOUND_3D_Listener_SetAttributes(@Cam_Targ.X, 0, Tempd.X, Tempd.Y, -Tempd.Z, 0, 1, 0 )
        #endif
    end if
    
    dim as number nIMatrix(15) = any
    memcpy( @nIMatrix(0), pnMatrix, MAT_SIZE )
    
    dim as Vector3D NPosition = any 
    d3Matrix_Mul_Vector3D( pnMatrix, Light_Position, NPosition )
    
    if iRender_Shadows then
        'Render character shadows...
        dim as number nMatrix(15)
        d3Matrix_Load_Identity( @nMatrix(0) )
        d3Matrix_Scale( @nMatrix(0), ToFixed(1), ToFixed(0), ToFixed(1) )
        'dim as Vector4D tLight = type( Light_Position.nX, _
        'Light_Position.nY, Light_Position.nZ, ToFixedi(1) )
        'd3matrix_plane_projection( @nMatrix(0), tLight, Maze_Models[0]->triangles[0].Plane )
        
        d3Matrix_Translate( pnMatrix, Hero.Position.nX, ToFixed(.1), Hero.Position.nZ )
        d3Matrix_Rotate( pnMatrix, 0, Hero.iAngle, 0 ) 'pVec3D , int , int , int
        d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
        
        if Hero.nScalar<>ToFixedi(1) then
            dim as number nMatrix(15)
            d3Matrix_Load_Identity( @nMatrix(0) )
            d3Matrix_Scale( @nMatrix(0), Hero.nScalar, Hero.nScalar, Hero.nScalar )
            d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
        end if
        Model_Transform( Pac_Models[ToCint(Hero.nAnimation)], _
        pnMatrix, @iFcnt, Hero.Position, NPosition, 0, 0)
        d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
        
        var pCharsI = @Chars(0)
        for i as integer = 1 to (iUbound_Chars)
            pCharsI += 1
            d3matrix_mul_matrix( pnMatrix, @nMatrix(0) )
            d3Matrix_Translate( pnMatrix, pCharsI->Position.nX, _
            ToFixed(.1),pCharsI->Position.nZ ) 'pVec3D,numb,numb,numb
            d3Matrix_Rotate( pnMatrix, 0, pCharsI->iAngle, 0 ) 'pVec3D , int , int , int
            
            if pCharsI->nScalar<>ToFixedi(1) then
                dim as number nMatrix(15)
                d3Matrix_Load_Identity( @nMatrix(0) )
                d3Matrix_Scale( @nMatrix(0), pCharsI->nScalar, pCharsI->nScalar, pCharsI->nScalar ) 'pVec3D , Number
                d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
            end if
            
            select case pCharsI->iMood
                case MOOD_GOHOME
                    Model_Transform( Ghost_Models[ToCint(pCharsI->nAnimation)+50], _
                    pnMatrix, @iFcnt, Hero.Position, NPosition, 0, 0 )
            	case else
                    Model_Transform( Ghost_Models[ToCint(pCharsI->nAnimation)], _
                    pnMatrix, @iFcnt, Hero.Position, NPosition, 0, 0 )
            end select    
            d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
        next
        
        
        dim as integer X = Door_Position.iX
        dim as integer Z = Door_Position.iZ
        d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
        d3Matrix_Translate( pnMatrix, ToFixedi(X), Maze(X,Z).nTrans, ToFixedi(Z) ) 'pVec3D,numb,numb,numb
        Model_Transform( Maze_Models[Maze(X,Z).iTile], _
        pnMatrix, @iFcnt, Hero.Position, NPosition, 0, 0 )
        d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )    
        
    end if
    

    'Render characters normally...
    iZStart = ToCint(Hero.Position.nZ)-iDraw_Dist
    iZEnd   = ToCint(Hero.Position.nZ)+iDraw_Dist
    iXStart = ToCint(Hero.Position.nX)-iDraw_Dist
    iXEnd   = ToCint(Hero.Position.nX)+iDraw_Dist
    if iZStart < 1 then iZStart = 1
    if iXStart < 1 then iXStart = 1
    if iZEnd > iUboundMaze2 then iZEnd = iUboundMaze2
    if iXEnd > iUboundMaze1 then iXEnd = iUboundMaze1
    
    #if 1
    for Z as integer = iZStart to iZEnd
        for X as integer = iXStart to iXEnd
            
            ' Emitting Ground
            '#ifndef __FB_NDS__            
            if Maze(X,Z).iTile <> 3 then
                d3Matrix_Translate( pnMatrix, ToFixedi(X), 0, ToFixedi(Z) )
                model_transform( Maze_Models[0], pnMatrix, @iFcnt, _
                Hero.Position, NPosition, ToFixed(-1), ToFixed(5) )
                d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
            end if            
            '#endif
            ' Emitting Object
            if Maze(X,Z).iTile > 0 then
                d3Matrix_Translate( pnMatrix, ToFixedi(X), Maze(X,Z).nTrans, ToFixedi(Z) )
                Model_Transform( Maze_Models[Maze(X,Z).iTile], _
                pnMatrix, @iFcnt, Hero.Position, NPosition, ToFixed(1), 0 )
                d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
            end if      
        next
    next
    #endif
    
    #if 1
    d3Matrix_Translate( pnMatrix, Hero.Position.nX, Hero.Position.nY, Hero.Position.nZ )
    d3Matrix_Rotate( pnMatrix, 0, Hero.iAngle, 0 )
    if Hero.nScalar <> ToFixedi(1) then
        dim as number nMatrix(15)
        d3Matrix_Load_Identity( @nMatrix(0) )
        d3Matrix_Scale( @nMatrix(0), Hero.nScalar, Hero.nScalar, Hero.nScalar )
        d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
    end if
    model_transform( Pac_Models[ToCint(Hero.nAnimation)], _
    pnMatrix, @iFcnt, Hero.Position, NPosition, ToFixed(1), 0 )
    d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
    
    var pCharsI = @Chars(0)
    for i as integer = 1 to (iUbound_Chars)
        pCharsI += 1
        d3Matrix_Translate( pnMatrix, pCharsI->Position.nX, _
        pCharsI->Position.nY, pCharsI->Position.nZ )
        d3Matrix_Rotate( pnMatrix, 0, pCharsI->iAngle, 0 )
        
        if pCharsI->nScalar<>ToFixedi(1) then
            dim as number nMatrix(15)
            d3Matrix_Load_Identity( @nMatrix(0) )
            d3Matrix_Scale( @nMatrix(0), pCharsI->nScalar, pCharsI->nScalar, pCharsI->nScalar )
            d3Matrix_Mul_Matrix( pnMatrix, @nMatrix(0) )
        end if
        
        select case as const pCharsI->iMood
            case MOOD_SCARED
                Model_Transform( Ghost_Models[ToCint(pCharsI->nAnimation)+40], _
                pnMatrix, @iFcnt, Hero.Position, NPosition, ToFixed(1), 0 )
        	case MOOD_GOHOME    
                Model_Transform( Ghost_Models[ToCint(pCharsI->nAnimation)+50], _
                pnMatrix, @iFcnt, Hero.Position, NPosition, ToFixed(1), 0 )
        	case else
                Model_Transform( Ghost_Models[ToCint(pCharsI->nAnimation)+((i-1)*10)], _
                pnMatrix, @iFcnt, Hero.Position, NPosition, ToFixed(1), 0 )
        end select
        d3Matrix_Copy( @pnMatrix[0], @nIMatrix(0) )
    next
    #endif
    
    if Play_Sounds then
        #ifdef SoundEnabled
        FSound_Update()
        #endif
    end if
    
    MeasureTime(dGeometryTime)
    
    StartTime()    
    screenlock
    
    #ifndef __FB_NDS__
    if Flags = FB.GFX_SHAPED_WINDOW then
        line(0,0)-(SCR_WIDTH-1, SCR_HEIGHT-1),&HFF00FF,bf
    else    
        line(0,0)-(SCR_WIDTH-1, SCR_HEIGHT-1),0,bf
    end if
    #endif
    
    Buffer_Render( @iFCnt )
    
    draw string  (0,0), "Score: " & Hero.iScore, &HFFFF00
    draw string  (0,20), FPS_Time, &HFFFF00
    draw string  (0,10), "vSync = " & iSyncOn, &HFFFF00
    
    if iMenu_Active then 
        var pChar = @Chars(iDemo_Targ_Index)
        if iDemo_Targ_Index = 0 then pChar = @Hero
        dim as Vector3D Temp = pChar->Position
        Temp.nY += ToFixedi(1)
        d3Matrix_Mul_Vector3D( pnMatrix, Temp, Temp )
        var TempLens = FixedDivFixed( ToFixedi(iLens) , Temp.nZ )
        Temp.nX = ToFixedi((SCR_WD2-len((*(pChar->zName))) shl 2)) + _
        FixedMulFixed( TempLens , Temp.nX )
        Temp.nY = ToFixedi(SCR_HD2) - FixedMulFixed( TempLens , Temp.nY )
        draw string(ToCint(Temp.nX),ToCint(temp.nY)), *(pChar->zName), &HFF0000
        
        dim as integer tcolor
        dim as string zNString
        dim as integer upper_menu = ubound(Menu)
        dim as integer Scrolling_Menu
        if upper_menu>10 then
            upper_menu = 10
            if iMenu_Highlight > Scrolling_Menu+10 then
                Scrolling_Menu = iMenu_Highlight-10
            end if
        end if
        
        for i as integer = 0 to upper_menu
            dim as integer ni
            ni = Scrolling_Menu+i
            if ni > ubound(Menu) then
                ni = ubound(Menu)
            end if
            
            zNString = Menu(ni)
            
            if i = 0 then
                tColor = &HFFFFFF
                zNString = Menu(0)
            else
                tColor = &HFFFF00
            end if
            
            dim as integer texty = (SCR_HD2 - (upper_menu*6))+(i*12)
            
            dim as integer tStart = SCR_WD2 - (len(zNString))*4
            dim as integer tarrL = (SCR_WD2 - (len(zNString)+9)*4) - (5 * sin(ToFloat(nThisTime*10)))
            dim as integer tarrR = (SCR_WD2 + (len(zNString)+1)*4) + (5 * sin(ToFloat(nThisTime*10)))
            draw string (tStart, textY ), zNString, tColor
            
            if iMenu_Highlight = ni then
                draw string (tarrL, textY ), "--->", tColor
                draw string (tarrR, textY ), "<---", tColor
            end if
        next
        
    else
        
        if iAte_Em then
            var pCharsAte_Em = @Chars(iAte_Em)
            Hero.nAnimation = ToFixed(int(rnd*MAX_PAC_MODELS))
            pCharsAte_Em->nScalar = (nPauseTime-nThisTime)
            dim as string zNString
            zNString = Text_Fx( iRand_Text_Id )
            
            pCharsAte_Em->Position.nX += _
            FixedMulFixed((Hero.Position.nX-(pCharsAte_Em->Position.nX)),nLTime)
            pCharsAte_Em->Position.nY += _
            FixedMulFixed((Hero.Position.nY-(pCharsAte_Em->Position.nY)),nLTime)
            pCharsAte_Em->Position.nZ += _
            FixedMulFixed((Hero.Position.nZ-(pCharsAte_Em->Position.nZ)),nLTime)
            
            dim as Vector3D Temp = any
            var pCharsPosi = @(pCharsAte_Em->Position)      
            Temp = type((pCharsPosi->nX)+(Hero.Position.nX), _
            (pCharsPosi->nY)+(Hero.Position.nY),(pCharsPosi->nZ)+(Hero.Position.nZ))
            
            #ifdef UseFixedPoint
            Temp.nX shr= 1:Temp.nY shr= 1:Temp.nZ shr= 1
            #else
            'is this way because fixed point can do SHR
            Temp.nX *= 0.5f:Temp.nY *= 0.5f:Temp.nZ *= 0.5f
            #endif
            Temp.nX -= ToFixed(.05+rnd*.1)
            Temp.nY += (nThisTime-nPauseTime)+ToFixedi(1)
            d3Matrix_Mul_Vector3D( pnMatrix, Temp, Temp )
            var LensTempZ = FixedDivFixed(ToFixedi(iLens) , Temp.nZ)
            Temp.nX = ToFixedi(SCR_WD2) + FixedMulFixed(LensTempZ , Temp.nX)
            Temp.nY = ToFixedi(SCR_HD2) - FixedMulFixed(LensTempZ , Temp.nY)
            draw string (ToCint(temp.nX)-(len(zNString) shl 2),ToCint(Temp.nY)), zNString, &HFFFFFF
        end if
        
        if Hero.iDied then
            dim as string zNString
            zNString = "KTHXBYE!!!"
            dim as Vector3D Temp = Hero.Position
            d3Matrix_Mul_Vector3D( pnMatrix, Temp , Temp)
            var LensTempZ = FixedDivFixed(ToFixedi(iLens) , Temp.nZ)
            Temp.nX = ToFixedi(SCR_WD2) + FixedMulFixed(LensTempZ , Temp.nX)
            Temp.nY = ToFixedi(SCR_HD2) - FixedMulFixed(LensTempZ , Temp.nY)
            draw string (ToCint(temp.nX)-(len(zNString) shl 2),ToCint(Temp.nY)), zNString, &HFFFFFF
        end if
        
        if iGame_On = 0 then
            dim as Vector3D Temp = any
            d3Matrix_Mul_Vector3D( pnMatrix, Hero.Position, Temp )
            var LensTempZ = FixedDivFixed(ToFixedi(iLens) , Temp.nZ)
            Temp.nX = ToFixedi(SCR_WD2) + FixedMulFixed(LensTempZ , Temp.nX)
            Temp.nY = ToFixedi(SCR_HD2) - FixedMulFixed(LensTempZ , Temp.nY)
            dim as string gText = "GET READY!"
            dim as integer tStart = ToCint(temp.nX) - 40
            dim as float pit = sPi2 * (1/10)
            for i as integer = 1 to 10
                dim as string tString = mid(gText, i, 1)
                dim as float yPos = ToFloat(temp.nY) + 10 * sin(Pit*i+ToFloat(nThisTime*10))
                draw string (tStart+((i-1) shl 3), ypos ), tString, &HFFFFFF
            next
        end if
    end if
    
    MeasureTime(dRenderTime)
    
    #ifdef __FB_NDS__
    flip
    #endif   
    if iSyncOn then 
        ScreenSync    
    end if
    
    screenunlock
    
    '#ifndef __FB_NDS__
    'sleep 1,1
    '#endif
    
    iFPS += 1
    if nThisTime>nNTime then
        nNTime = nThisTime+ToFixedi(1)
        FPS_Time = str(iFPS)
        iFPS = 0
    end if
    
loop until iExit_Game

deallocate( inverse_pnM )

#ifdef SoundEnabled
FSOUND_Stream_Close(song)
#endif

#ifdef SoundEnabled
sub Load_Sfx( )
    dim as string File_Name
    dim as integer i
    
    for i = 1 to MAX_SOUNDS
        if i = 1 then File_Name = "Data/Sfx/Chomp.ogg"
        if i = 2 then File_Name = "Data/Sfx/Silly.ogg"
        if i = 3 then File_Name = "Data/Sfx/Killed.ogg"
        if i = 4 then File_Name = "Data/Sfx/Spook.ogg"
        if i = 5 then File_Name = "Data/Sfx/Bloop.ogg"
        if i = 6 then File_Name = "Data/Sfx/Ghost_Death.ogg"
        Sfx(i) = FSOUND_Sample_Load(FSOUND_FREE, File_Name, FSOUND_HW3D or FSOUND_LOOP_OFF, 0, 0)
        FSOUND_3D_SetRolloffFactor( 1 )
    next  
end sub
#endif

sub Rest_Positions( )
    var pCharI = @Chars((iUbound_chars))
    pCharI += 1
    for i as integer = (iUbound_chars) to 0 step-1    
        pCharI -= 1:if i = 0 then pCharI = @Hero    
        pCharI->position = pCharI->start_position
        pCharI->iAngle = 180
        pCharI->nIn_gBoxTime = ToFixedi(0)
        pCharI->iMood = MOOD_WAITING
        pCharI->nIn_gBoxTime = nThisTime + pCharI->nGBoxTime
        pCharI->nScalar = ToFixedi(1)
    next
    iAte_Em = 0             'shared var to pause for a sec when pac eats a ghost
    Song_Type = SONG_NORMAL 'another shared var to retain the type of song in the buffer
    Hero.iGo_Direction = GO_NONE
    iGame_On = 0
    nPauseTime = nThisTime+ToFixedi(3)
end sub

sub Ghost_Logic( n_Ltime as number )
    dim as integer Free_channel = any
    
    'exit sub
    
    var pCharsI = @Chars(0)
    for i as integer = 1 to (iUbound_chars)
        pCharsI += 1
        pCharsI->nAnimation += FixedMulFixed( _
        ToFixedi((pCharsI->iAnimation_Inc*pCharsI->iAnimation_Speed)),n_Ltime)
        if pCharsI->nAnimation > ToFixedi(9) then
            pCharsI->nAnimation = ToFixedi(9)
            pCharsI->iAnimation_Inc = -pCharsI->iAnimation_Inc
        end if
        
        if pCharsI->nAnimation < ToFixedi(0) then
            pCharsI->nAnimation = ToFixedi(0)
            pCharsI->iAnimation_Inc = -pCharsI->iAnimation_Inc
        end if
        
        'dim as number nTy1 = pCharsI->Position.nY
        'dim as number nTy2 = Hero.Position.nY
        dim as Vector3D tvec1 = pCharsI->Position    
        dim as Vector3D tvec2 = Hero.Position
        tvec1.nY = ToFixedi(0):tvec2.nY = ToFixedi(0)
        
        dim as number nDist = Distance( tvec1, tvec2 )
        dim as number nRadii = (pCharsI->nRadius+Hero.nRadius)
        
        if nDist < nRadii then
            '                If Dist = 0 Then Dist = 1
            '                Dim As Vector3D Offset = tvec1 - tvec2
            '                Offset*=(Radii-Dist)
            '                pCharsI->Position+=Offset
            '                pCharsI->Position.Y = ty1
            select case as const pCharsI->iMood
                case MOOD_COMPLACENT, MOOD_STRATEGIZE, MOOD_PISSED
                    if Hero.iDied = 0 then
                        Hero.iDied = true
                        nDiedTime = nThisTime+ToFixedi(2)
                        if Play_Music then
                            #ifdef SoundEnabled
                            FSOUND_Stream_Stop( song )
                            #endif
                        end if
                        if Play_Sounds then
                            #ifdef SoundEnabled
                            Free_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(3),0,0 )
                            FSOUND_3D_SetAttributes( Free_Channel, @Hero.Position.X, 0 )
                            #endif
                        end if
                    end if
                case MOOD_SCARED
                    if Hero.iDied = 0 then  
                        if pCharsI->iDied = 0 then
                            iRand_Text_Id = 1+int(rnd*MAX_TEXT_FX)
                            iAte_Em = i
                            nPauseTime = nThisTime+ToFixedi(1)
                            pCharsI->iDied = true
                            if Play_Sounds then
                                #ifdef SoundEnabled
                                Free_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(6),0,0 )
                                FSOUND_3D_SetAttributes( Free_Channel, @(pCharsI->Position.X), 0 )
                                #endif
                            end if
                        end if
                    end if
            end select
        end if
        
        #define ComparePosition(suf) ToCint(pCharsI->Position.##suf) <> ToCint(pCharsI->Last_Position.##suf)
        if ComparePosition(nX) orelse ComparePosition(nZ) then
            pCharsI->Last_Position.nX = ToCint(pCharsI->Position.nX)
            pCharsI->Last_Position.nZ = ToCint(pCharsI->Position.nZ)
            if ToCint(pCharsI->Position.nX) = ToCint(Door_Position.iX) then
                if (pCharsI->Position.nZ) = ToCint(Door_Position.iZ) then
                    if Play_Sounds then
                        #ifdef SoundEnabled
                        Free_Channel = FSOUND_PlaySoundEx( FSound_FREE, SFX(4),0,0 )
                        FSOUND_3D_SetAttributes( Free_Channel, @(pCharsI->Position.X), 0 )
                        #endif
                    end if
                end if
            end if
        end if
        
        dim as number n_NTime = FixedMulFixed(n_Ltime,(pCharsI->nSpeed))
        pCharsI->Position.nX -= FixedMulFixed(ToFixed(sin(pCharsI->iAngle*sPid180)),n_NTime)
        pCharsI->Position.nY  = ToFixed(.75)+ToFixed(.25*sin(ToFloat(nThisTime*5)+i))
        pCharsI->Position.nZ -= FixedMulFixed(ToFixed(cos(pCharsI->iAngle*sPid180)),n_NTime)
        
        'dim as integer iZStart = ToCint(pCharsI->Position.nZ)-1
        'dim as integer iZEnd   = ToCint(pCharsI->Position.nZ)+1
        'dim as integer iXStart = ToCint(pCharsI->Position.nX)-1
        'dim as integer iXEnd   = ToCint(pCharsI->Position.nX)+1
        'if iZStart < 1 then iZStart = 1
        'if iXStart < 1 then iXStart = 1
        'if iZEnd > iUboundMaze2 then iZEnd = iUboundMaze2
        'if iXEnd > iUboundMaze1 then iXEnd = iUboundMaze1
        '
        'for X as integer = iXStart to iXEnd      
        '    for Z as integer = iZStart to iZEnd
        '        if Maze(X,Z).iTile > 2 then          
        '            Check_Wall_Collision( pCharsI->Position, pCharsI->nRadius, _
        '            Maze(X,Z).Model, type( ToFixedi(X),Maze(X,Z).nTrans,ToFixedi(Z) ) )          
        '        end if
        '    next      
        'next
        
        
        with pCharsI->Position
                  	
            #define MazePoint(oX,oZ) maze(ToCint(.nX+ToFixed(oX)),ToCint(.nZ+ToFixed(oZ)))
                  	
	         var HeroSpeed = FixedMulFixed( n_Ltime, pCharsI->nSpeed )
				if MazePoint(0, .475).iTile = 3 then .nZ -= HeroSpeed
				if MazePoint(0,-.475).iTile = 3 then .nZ += HeroSpeed
				if MazePoint( .475,0).iTile = 3 then .nX -= HeroSpeed
				if MazePoint(-.475,0).iTile = 3 then .nX += HeroSpeed
						
        end with
        
        
        select case pCharsI->iMood
            case MOOD_WAITING
                pCharsI->Position = pCharsI->Start_Position
                pCharsI->iAngle = Find_Angle( pCharsI->Position.nX, _
                pCharsI->Position.nZ, Hero.Position.nX, Hero.Position.nZ )
                pCharsI->iDied = 0
                if nThisTime > (pCharsI->nIn_gBoxTime) then
                    pCharsI->iMood = MOOD_COMPLACENT
                end if    
            case MOOD_SCARED      
                if ToCint(pCharsI->Position.nX) = ToCint(pCharsI->Targ_Position.nX) then
                    if ToCint(pCharsI->Position.nZ) = ToCint(pCharsI->Targ_Position.nZ) then
                        dim as integer tRand = int(rnd*iUbound_ValidIndex)
                        pCharsI->Targ_Position.nX = ToFixedi(Valid_Index[tRand].iX)
                        pCharsI->Targ_Position.nZ = ToFixedi(Valid_Index[tRand].iZ)
                    end if
                end if      
                if nThisTime > (pCharsI->nIn_ScaredTime) then
                    pCharsI->iMood = MOOD_COMPLACENT
                end if
            case MOOD_PISSED
                pCharsI->Targ_Position = Hero.Position
            case MOOD_COMPLACENT
                if iPellets_Eaten >= (iTotal_Pellets shr 1) then pCharsI->iMood = MOOD_PISSED
                if ToCint(pCharsI->Position.nX) = ToCint(pCharsI->Targ_Position.nX) then
                    if ToCint(pCharsI->Position.nZ) = ToCint(pCharsI->Targ_Position.nZ) then
                        dim as integer tRand = int(rnd*iUbound_ValidIndex)
                        pCharsI->Targ_Position.nX = ToFixedi(Valid_Index[tRand].iX)
                        pCharsI->Targ_Position.nZ = ToFixedi(Valid_Index[tRand].iZ)
                    end if
                end if    
            case MOOD_GOHOME
                pCharsI->Targ_Position = pCharsI->Start_Position
                if ToCint(pCharsI->Position.nX) = ToCint(pCharsI->Targ_Position.nX) then
                    if ToCint(pCharsI->Position.nZ) = ToCint(pCharsI->Targ_Position.nZ) then
                        pCharsI->iMood = MOOD_WAITING
                        pCharsI->nIn_gBoxTime = nThisTime + pCharsI->nGBoxTime
                    end if
                end if    
        end select
        
        dim as Vector3D Target '= any
        
        if DO_FIND_PATH then
        		FindPath( pCharsI , Target )
        end if
        
        pCharsI->iTarg_Angle = Find_Angle( pCharsI->Position.nX, _
        pCharsI->Position.nZ, Target.nX, Target.nZ )
        
        if (pCharsI->iAngle) < (pCharsI->iTarg_Angle) then
            if abs(pCharsI->iAngle-pCharsI->iTarg_Angle) < 180 then
                pCharsI->iAngle += ToCint(FixedMulFixed(pCharsI->nTurnSpeed,n_Ltime))
            else
                pCharsI->iAngle -= ToCint(FixedMulFixed(pCharsI->nTurnSpeed,n_Ltime))
            end if
        end if
        
        if (pCharsI->iAngle) > (pCharsI->iTarg_Angle) then
            if abs( (pCharsI->iAngle) - (pCharsI->iTarg_Angle) ) < 180 then
                pCharsI->iAngle -= ToCint(FixedMulFixed(pCharsI->nTurnSpeed,n_Ltime))
            else
                pCharsI->iAngle += ToCint(FixedMulFixed(pCharsI->nTurnSpeed,n_Ltime))
            end if
        end if
        
        if (pCharsI->iAngle) > 360 then 
            pCharsI->iAngle -= 360
        elseif (pCharsI->iAngle) < 0   then 
            pCharsI->iAngle += 360
        end if
        
    next
    
end sub


sub findpath_new( pCharsI as const Character_Struct ptr, ReturnUDT as Vector3D )
	
	
end sub


sub findpath (pCharsI as const Character_Struct ptr, ReturnUDT as Vector3D ) 
    
    'redim Node(0 to ubound(maze,1), 0 to ubound(maze,2) ) as Path_Struct  
    'redim OpenList(0 to ubound(maze,1) * ubound(maze,2)) as OpenList_Struct
    dim as integer iMapWidth=iUboundMaze1,iMapHeight=iUboundMaze2
    dim as integer iEntry_On_Open_List=any, iOpenListCnt=any
    dim as integer iTempListCnt=any, iSpawn_Open_List_Entry=any  
    dim as integer iCurX=any,iCurZ=any,iInitX=any,iInitZ=any
    dim as integer iTargX=any,iTargZ=any,iScanX=any,iScanZ=any
    dim as integer iNewX=any,iNewZ=any,iTempX=any,iTempZ=any
    dim as integer iI2=any,iCurScore=any,iGCost=any
    
    #ifdef __FB_NDS__
    static OpenList(21*21) as OpenList_Struct
    static Node(21,21) as Path_Struct  
    dmafillwords(@OpenList(0),0,21*21*sizeof(OpenList_Struct))
    dmafillwords(@node(0,0),0,21*21*sizeof(Path_Struct))
    #else
    dim OpenList(iUboundMaze1*iUboundMaze2) as OpenList_Struct
    dim Node(iUboundMaze1,iUboundMaze2) as Path_Struct  
    #endif  
    
    iCurX = ToCint(pCharsI->Targ_Position.nX)
    iCurZ = ToCint(pCharsI->Targ_Position.nZ)
    iInitX = iCurX: iInitZ = iCurZ
    iTargX = ToCint(pCharsI->Position.nX)
    iTargZ = ToCint(pCharsI->Position.nZ)
    OpenList(1).iX = iCurX
    OpenList(1).iZ = iCurZ
    
    if iCurX = iTargX andalso iCurZ = iTargZ then exit sub
    
    Node(iCurX, iCurZ).iCs = OpenL
    iEntry_On_Open_List = true
    iOpenListCnt = 1
    
    var pCharsI2 = @Chars(0)
    for iI2 = 1 to (iUbound_chars)
        pCharsI2 += 1
        if pCharsi2<>pCharsI then
            'Node(chars(i2).Position.X, chars(i2).Position.Z).Cs = CloseL
            Node(ToCint(pCharsI2->Position.nX), ToCint(pCharsI2->Position.nZ)).iP = 1000
        end if    
    next
    
    Node(ToCint(pCharsI->Last_Position.nX), ToCint(pCharsI->Last_Position.nZ)).iP += 1500
    'Node(pCharsI->Last_Position.X, pCharsI->Last_Position.Z).Cs = CloseL
    
    if pCharsI->iMood = MOOD_SCARED then
        Node(ToCint(Hero.Position.nX), ToCint(Hero.Position.nZ)).iP = 2500
    end if
    
    do while iEntry_On_Open_List
        iCurScore = 10000
        iEntry_On_Open_List = False
        
        var pOpenListi2 = @OpenList(0)
        for iI2 = 1 to iOpenListCnt
            pOpenListi2 += 1
            var pOpenListi2X = pOpenListi2->iX
            var pOpenListi2Z = pOpenListi2->iZ
            if (pOpenListi2X)>0 andalso (pOpenListi2Z)>0 then
                var pNode = @Node(pOpenListi2X,pOpenListi2Z)
                if pNode->iCs = OpenL then
                    if pNode->iF < iCurScore then
                        iCurScore = pNode->iF
                        iNewX = pOpenListi2X
                        iNewZ = pOpenListi2Z
                        iEntry_On_Open_List = true
                        iTempListCnt = iI2
                    end if
                end if
            end if
        next
        
        if iEntry_On_Open_List = 0 then exit sub
        
        iCurX = iNewX: iCurZ = iNewZ
        
        Node(iCurX, iCurZ).iCs = CloseL
        OpenList(iTempListCnt).iX = 0
        OpenList(iTempListCnt).iZ = 0
        iSpawn_Open_List_Entry = False
        
        for iTempX = -1 to 1
            iScanX = iCurX + iTempX
            if iScanX > 0 and iScanX <= iMapWidth then
                for iTempZ = -1 to 1
                    iScanZ = iCurZ + iTempZ
                    if iScanZ > 0 and iScanZ <= iMapHeight then
                        if Maze(iScanX, iScanZ).iTile <> 3 then              
                            if iTempX = 0 or iTempZ = 0 then iGCost = 10 else iGCost = 21              
                            'If Maze(ScanX, ScanZ).Tile(1) = 2 Then
                            '    GCost-=3
                            'End If
                            var pNodeScan = @Node(iScanX,iScanZ)
                            var pNodeCUR = @Node(iCurX,iCurZ)
                            if pNodeScan->iCs <> CloseL then
                                if pNodeScan->iCs = Nul then
                                    pNodeScan->iCs = OpenL
                                    pNodeScan->iPx = iCurX
                                    pNodeScan->iPz = iCurZ
                                    pNodeScan->iH  = (abs(iScanX-iTargX) + abs(iScanZ-iTargZ))*10
                                    pNodeScan->iG  = pNodeCUR->iG + iGCost
                                    pNodeScan->iF  = pNodeScan->iH +pNodeScan->iG + pNodeScan->iP                  
                                    if iSpawn_Open_List_Entry then
                                        iOpenListCnt+=1
                                        OpenList(iOpenListCnt).iX = iScanX
                                        OpenList(iOpenListCnt).iZ = iScanZ
                                    else
                                        iSpawn_Open_List_Entry = true
                                        OpenList(iTempListCnt).iX = iScanX
                                        OpenList(iTempListCnt).iZ = iScanZ
                                    end if                  
                                else 'already on openList
                                    if pNodeCUR->iG + iGCost < Node(iScanX, iScanZ).iG then
                                        pNodeScan->iPx = iCurX
                                        pNodeScan->iPz = iCurZ
                                        pNodeScan->iH  = (abs(iScanX-iTargX) + abs(iScanZ-iTargZ))*10
                                        pNodeScan->iG  = pNodeCUR->iG + iGCost
                                        pNodeScan->iF  = pNodeScan->iH + pNodeScan->iG + pNodeScan->iP
                                    end if
                                end if
                            end if              
                        end if    
                    end if
                    
                next
            end if
        next
        if iCurX=iTargX andalso iCurZ = iTargZ then exit do
    loop
    
    ReturnUDT = type( Node(iTargX, iTargZ).iPX, 0, Node(iTargX, iTargZ).iPZ )
end sub

sub Init_Characters( )
    
    'iUbound_Chars = (Ubound(Chars))
    
    Hero.Start_Position.nX = ToFixedi(11)
    Hero.Start_Position.nY = ToFixed(.5)
    Hero.Start_Position.nZ = ToFixedi(16)
    Hero.Position = Hero.Start_Position
    Hero.nSpeed = ToFixedi(5)
    Hero.nTurnSpeed = ToFixedi(540)
    Hero.nAnimation = ToFixedi(0)
    Hero.iAnimation_Inc = 1
    Hero.iAnimation_Speed = 50
    Hero.nRadius = ToFixed(.46)
    Hero.nScalar = ToFixedi(1)
    
    Hero.zname = @"Pacenstein"
    
    var pCharsI = @Chars(4)
    pCharsI->Start_Position = type( ToFixedi(10), ToFixed(.5), ToFixedi(8) )  
    pCharsI->zname = @"Pinky"
    pCharsI -= 1
    
    pCharsI->Start_Position = type( ToFixedi(11), ToFixed(.5), ToFixedi(8) )  
    pCharsI->zname = @"Inky"
    pCharsI -= 1
    
    pCharsI->Start_Position = type( ToFixedi(12), ToFixed(.5), ToFixedi(8) )    
    pCharsI->zname = @"Clyde"
    pCharsI -= 1
    
    pCharsI->Start_Position = type( ToFixedi(11), ToFixed(.5), ToFixedi(9) )
    pCharsI->zname = @"Speedy"
    pCharsI -= 1
    
    for i as integer = 1 to iUbound_Chars
        pCharsI += 1
        pCharsI->Position = pCharsI->Start_Position
        pCharsI->nSpeed = ToFixed(3 + ((iUbound_Chars-i+1)*.25))
        pCharsI->nTurnSpeed = ToFixedi(540)
        pCharsI->nAnimation = ToFixedi(0)
        pCharsI->iAnimation_Inc = 1
        pCharsI->iAnimation_Speed = 50
        pCharsI->iAngle = 180
        pCharsI->nRadius = ToFixed(.46)
        pCharsI->iMood = MOOD_WAITING
        dim as integer tRand = int(rnd*iUbound_ValidIndex)
        pCharsI->Targ_Position.nX = ToFixedi(Valid_Index[tRand].iX)
        pCharsI->Targ_Position.nZ = ToFixedi(Valid_Index[tRand].iZ)
        pCharsI->nGBoxTime = ToFixedi(i shl 2)
        pCharsI->nIn_gBoxTime = ToFixed(sTimer())+pCharsI->nGBoxTime
        pCharsI->nScaredTime = ToFixedi(i shl 3)
        pCharsI->nIn_ScaredTime = ToFixed(sTimer())+pCharsI->nScaredTime
        pCharsI->nScalar = ToFixedi(1)
    next
end sub

function Find_Angle( nX1 as const number, nY1 as const number, nX2 as const number,  nY2 as const number ) as integer
    dim iTemp_Angle as integer = -atan2(ToFloat(nY2-nY1), ToFloat(nX2-nX1)) * 57.29577951308232
    if iTemp_Angle < 0 then iTemp_Angle += 360
    return (iTemp_Angle + 270) mod 360
end function

function Check_Wall_Collision( byref Cam as Vector3D, n_Radius as const number, Model as const Model3D ptr, byref tTrans as Vector3D ) as integer
    dim vTriangle(2) as Vector3D=any
    dim vOffSet as Vector3D = any, vIntersection as Vector3D = any
    dim vNormal as Vector3D = any, n_Dist as number=any
    dim as integer iClassification=any,iI=any,iI2=any  
    dim as integer iFaceResult=any,iEdgeResult=any
    
    var pModelVert = Model->vert16
    var pModVertTriID = (@(Model->triangles[-1].iPointID1))
    var pModVertNorm = (@(Model->triangles[-1].Normal))
    for iI = 0 to Model->iMax_triangles - 1
        'var pModVertTriID = (@(Model->triangles[i].PointID1))
        *cptr(any ptr ptr,@pModVertTriID) += sizeof(Model->triangles[0])
        *cptr(any ptr ptr,@pModVertNorm) += sizeof(Model->triangles[0])
        
        var pvTriangle = @vTriangle(0)
        for iI2 = 0 to 2
            with pModelVert[pModVertTriID[iI2]]
                pvTriangle->nX = .nX + tTrans.nX
                pvTriangle->nY = .nY + tTrans.nY
                pvTriangle->nZ = .nZ + tTrans.nZ
            end with
            pvTriangle += 1
        next  
        
        'var pModVertNorm = (@(Model->triangles[i].Normal))
        vNormal.nX = pModVertNorm->nX
        vNormal.nY = pModVertNorm->nY
        vNormal.nZ = pModVertNorm->nZ
        
        iClassification = Classify_Sphere(Cam, vNormal, vTriangle(0), n_Radius, @n_Dist)
        
        if iClassification = SPHERE_INTERSECTS then 
            
            vOffSet.nX = (FixedMulFixed(vNormal.nX , n_Dist))
            vOffSet.nY = (FixedMulFixed(vNormal.nY , n_Dist))
            vOffSet.nZ = (FixedMulFixed(vNormal.nZ , n_Dist))
            
            vInterSection.nX = Cam.nX - vOffSet.nX
            vInterSection.nY = Cam.nY - vOffSet.nY
            vInterSection.nZ = Cam.nZ - vOffSet.nZ
            
            iFaceResult = Is_Inside_Polygon(vIntersection, @vTriangle(0))
            #ifdef UseFixedPoint
            iEdgeResult = Edge_Sphere_Collision(vIntersection, @vTriangle(0), n_Radius shr 1)
            #else
            'its like this because fixed point can be "shr" while float need to be /2 or *.5
            iEdgeResult = Edge_Sphere_Collision(vIntersection, @vTriangle(0), n_Radius*(1/2))
            #endif
            
            if (iFaceResult or iEdgeResult) then
                Get_Collision_OffSet( vNormal, n_Radius, n_Dist, vOffSet )
                Cam.nX = Cam.nX + vOffSet.nX
                Cam.nZ = Cam.nZ + vOffSet.nZ
                return true
            end if   
        end if        
    next
    
end function

sub Model_Transform( Model as Model3D ptr, pnM as number ptr, piFcnt as integer ptr, byref Camera as Vector3D, byref Light_Position as Vector3D, nColorMult as number, nDepth_Offset as const number  )
    
    var pModTVertI = Model->tvertices
    var pModVert16 = Model->vert16
    for i as integer = 0 to Model->iMax_vertices - 1
        'Model->tvertices[i] = d3Matrix_Mul_Vector( M, Model->vertices[i] )
        'var pModTVertI = @(Model->tvertices[i])
        dim as number nVx = pModVert16->nX, nVy = pModVert16->nY, nVz = pModVert16->nZ                
        '#define fmf FixedMulFixed
        #define fmfs FixMulFixSmall                
        pModTVertI->nX = fmfs(nVx,pnM[0]) + fmfs(nVy,pnM[4]) + fmfs(nVz,pnM[8])  + pnM[12]
        pModTVertI->nY = fmfs(nVx,pnM[1]) + fmfs(nVy,pnM[5]) + fmfs(nVz,pnM[9])  + pnM[13]
        pModTVertI->nZ = fmfs(nVx,pnM[2]) + fmfs(nVy,pnM[6]) + fmfs(nVz,pnM[10]) + pnM[14]    
        pModTVertI += 1: pModVert16 += 1
    next
    
    'dim as number nTM(15) = any
    'MemCpy( @nTM(0), pnM, MAT_SIZE )
    'nTM(12) = ToFixedi(0):  nTM(13) = ToFixedi(0):  nTM(14) = ToFixedi(0)
    
    'var pModTri = Model->Triangles
    'var ptM = @nTM(0)
    'for i as integer = 0 to Model->iMax_triangles - 1
    '    #ifdef InlineFunctions
    '    var vinX = pModTri->normal.nX, vInY = pModTri->normal.nY , vInZ = pModTri->normal.nZ
    '    #define fmf FixedMulFixed
    '    pModTri->tnormal.nX = fmf(vInX,nTM(0)) + fmf(vInY,nTM(4)) + fmf(vInZ,nTM(8))  + nTM(12)
    '    pModTri->tnormal.nY = fmf(vInX,nTM(1)) + fmf(vInY,nTM(5)) + fmf(vInZ,nTM(9))  + nTM(13)
    '    pModTri->tnormal.nZ = fmf(vInX,nTM(2)) + fmf(vInY,nTM(6)) + fmf(vInZ,nTM(10)) + nTM(14)    
    '    #else
    '    d3Matrix_Mul_Vector3D( ptM, pModTri->normal, pModTri->tnormal )
    '    #endif
    '    pModTri += 1
    'next
    
        
    'NOTE: inverse_pnM is a shared number ptr....
    d3matrix_inverse( inverse_pnM, pnM )
    dim as vector3d tLight 
    d3matrix_mul_vector3d( inverse_pnM, Light_Position, tLight )
    
    dim as number n_Dist = any
    
    pModTVertI = Model->tvertices 'already exists so restart
    var pModpVertI = Model->pvertices
    for i as integer = 0 to Model->iMax_vertices - 1
        n_Dist = ToFixed(1/ToFloat(pModTVertI->nZ))*iLens
        if n_Dist > ToFixedi(1) then          
          pModpVertI->iX = SCR_WD2 + ToCint(FixedMulFixed( pModTVertI->nX , n_Dist ))
          pModpVertI->iY = SCR_HD2 - ToCint(FixedMulFixed( pModTVertI->nY , n_Dist ))
        elseif n_Dist > ToFixedi(0) then
          pModpVertI->iX = SCR_WD2 + ToCint(FixMulFixSmall( pModTVertI->nX , n_Dist ))
          pModpVertI->iY = SCR_HD2 - ToCint(FixMulFixSmall( pModTVertI->nY , n_Dist ))        
        end if
        pModTVertI += 1: pModpVertI += 1
    next  
    
    dim as integer iR = any
    dim as integer iG = any
    dim as integer iB = any
    dim as Vector3DInt vP1 = any
    dim as Vector3DInt vP2 = any
    dim as Vector3DInt vP3 = any
    dim as integer iZNormal = any
    dim as Vector3D pa = any
    dim as Vector3D tVec = any
    dim as number nDot2 = any
    dim as vector3d p = any
    
    var pModPVert = Model->pvertices
    var pModTVert = Model->tvertices
    var pModTriT = @(Model->triangles[-1])    
    
    var OutFcnt = *piFcnt
    var Outrbuffer = @rbuffer(OutFcnt)
    for t as integer = 0 to model->iMax_triangles - 1
        
        pModTriT += 1
        vP1 = pModPVert[pModTriT->iPointID1]
        vP2 = pModPVert[pModTriT->iPointID2]
        vP3 = pModPVert[pModTriT->iPointID3]
        
        iZNormal = ((vp2.iX-vp1.iX)*(vp1.iY-vp3.iY)-(vp2.iY-vp1.iY)*(vp1.iX-vp3.iX))
        
        if iZnormal <= 0 then
            if pModTVert[pModTriT->iPointID1].nZ >= ToFixedi(0) then
                if pModTVert[pModTriT->iPointID2].nZ >= ToFixedi(0) then
                    if pModTVert[pModTriT->iPointID3].nZ >= ToFixedi(0) then
                    	
                    	
                    	
                        #define fmf FixedMulFixed
                        var pModTriT = @(Model->Triangles[t])
                        #define ModTriTtnorm pModTriT->normal
                        
                        #define tID(iid) pModTVert[pModTriT->iPointID##iid]
                        #define Elm(xyz) (fmf((tID(1).xyz+tID(2).xyz+tID(3).xyz),ToFixed(1/3f)))
                        p = type(Elm(nX),Elm(nY),Elm(nZ))
                        
                        
                        pa.nX = FixMulFixSmall(p.nX , ModTriTtnorm.nX)
                        pa.nY = FixMulFixSmall(p.nY , ModTriTtnorm.nY)
                        pa.nZ = FixMulFixSmall(p.nZ , ModTriTtnorm.nZ)
                        
                     if nColorMult > 0 then 
                        
                        tVec.nX = tLight.nX - pa.nX
                        tVec.nY = tLight.nY - pa.nY
                        tVec.nZ = tLight.nZ - pa.nZ
                        Vector_Normalize(tVec)
                        
                        nDot2 = fmf(tVec.nX,ModTriTtnorm.nX) + fmf(tVec.nY,ModTriTtnorm.nY) + fmf(tVec.nZ,ModTriTtnorm.nZ)
                        if nDot2 >= ToFixedi(1) then nDot2 = ToFixedi(1)
                        
                        '#define nTempMult AcosTab(nDot2)
                        'nDot2 = (ToFixed((acos(ToFloat(nDot2))*-.35)+1))
                        'nDot2 = FixMulFixSmall(nTempMult, nColorMult)                        
                        
                        #define ModTriTCol pModTriT->Col            
                        iR = ToFint(nDot2 * ModTriTCol.iR)
                        iG = ToFint(nDot2 * ModTriTCol.iG)
                        iB = ToFint(nDot2 * ModTriTCol.iB)
                                                
                        if iR > 255 then iR = 255 else if iR < 0 then iR = 0
                        if iG > 255 then iG = 255 else if iG < 0 then iG = 0
                        if iB > 255 then iB = 255 else if iB < 0 then iB = 0
                     
                     elseif nColorMult < 0 then
                     	
                    		#define ModTriTCol pModTriT->Col
                    		
                    		iR = ModTriTCol.iR
                    		iG = ModTriTCol.iG
                    		iB = ModTriTCol.iB
                    	
                     elseif nColorMult = 0 then
                     	
                    		iR = 0
                    		iG = 0
                    		iB = 0
                    		
                     end if
                        
                        #ifdef UseFixedPoint
                        OutRbuffer->iMidPoint = (p.nZ+nDepth_Offset)
                        'if nDepth_Offset <> 0 then
                        '	OutRbuffer->iMidPoint = 32767
                        'end if
                        #else
                        'it's like this because in fixed point is already a big int
                        OutRbuffer->iMidPoint = (p.nZ+nDepth_Offset)*32767
                        'if nDepth_Offset <> 0 then
                        '	OutRbuffer->iMidPoint = 32767
                        'end if
                        #endif
                        OutRbuffer->iCol = rgb(iR, iG, iB)
                        OutRbuffer->Vec1 = *cptr(vector2dint ptr,@vP1) 'type(vP1.X,vP1.Y)
                        OutRbuffer->Vec2 = *cptr(vector2dint ptr,@vP2) 'type(vP2.X,vP2.Y)
                        OutRbuffer->Vec3 = *cptr(vector2dint ptr,@vP3) 'type(vP3.X,vP3.Y)
                        OutFcnt += 1: OutRbuffer += 1
                        
                    end if
                end if
            end if
        end if
    next
    *piFcnt = OutFcnt
    
end sub

'def __FB_NDS__
#if 1 
function Sort cdecl ( elm1 as any ptr, elm2 as any ptr ) as integer
    'return sgn( (cptr(sortstuff ptr, elm2)->midpoint) - (cptr(sortstuff ptr, elm1)->midpoint) )
    return ((cptr(sortstuff ptr, elm2)->iMidpoint) <= (cptr(sortstuff ptr, elm1)->iMidpoint)) or 1
end function
#else
function Sort naked cdecl ( elm1 as any ptr, elm2 as any ptr ) as integer
    asm
        mov eax, [esp+8]
        mov edx, [esp+4]
        mov eax, [eax+offsetof(sortstuff,iMidpoint)]
        mov edx, [edx+offsetof(sortstuff,iMidpoint)]
        sub eax, edx    
        sar eax, 31
        or eax,1    
        ret
    end asm  
end function
#endif

sub Buffer_Render( fcnt as integer ptr)
    
    #ifndef __FB_NDS__
    qsort( @rBuffer(0), *fCnt, sizeof(SortStuff), @Sort )
    #endif
    
    #define tOffs offsetof(typeof(rBuffer(0)),iCol)-offsetof(typeof(rBuffer(0)),vec1)
    #define tColor *cptr(typeof(rBuffer(0).iCol) ptr,Temp+tOffs)
    
    #ifdef SkipPoly
    dim as integer skip,skpcnt
    #endif
    'if *fCnt > 2048 then *fCnt = 2048 'skip = 8192-((8192*2048)\(*fCnt))
    
    if iWireFrame = 0 then
        #ifdef __FB_NDS__      
        printf("%i %i",*fCnt,gfx.VertexCount)
        #define RR ((iColor and &hF8) shl 7)
        #define GG ((iColor and &hF800) shr 6)
        #define BB ((iColor and &hF80000) shr 19)    
        CheckFifoFull()
        glBindTexture(0,0)        
        glBegin(GL_TRIANGLES)        
        dim as integer iColor = -2,midpoint    
        var prBuffer = @rBuffer(0)
        for i as integer = 0 to *fCnt-1      
            'if (i and 31)=0 then
            '  if (*cptr(uinteger ptr,&h4000604) shr 16) > 6000 then exit for
            'end if      
            midpoint = (-4096)-(prBuffer->iMidpoint shr (FixBits-4))        
            if midpoint > -4098 then midpoint = -4098
            if midpoint < -8190 then midpoint = -8190        
            if prBuffer->iCol <> iColor then 
                iColor = prBuffer->iCol: glColor(RR or GG or BB)
            end if
            glVertex3v16(prBuffer->Vec1.iX, prBuffer->Vec1.iY, midpoint)
            glVertex3v16(prBuffer->Vec2.iX, prBuffer->Vec2.iY, midpoint)
            glVertex3v16(prBuffer->Vec3.iX, prBuffer->Vec3.iY, midpoint)              
            #ifdef SkipPoly
            skpcnt += skip
            if skpcnt >= 8192 then i+=1:skpcnt -= 8192
            #endif
            prBuffer += 1
        next    
        gfx.fg.CanFlush = 1: gfx.Depth = -2048
        glEnd()
        #else    
        dim as any ptr Temp = @(rBuffer(0).Vec1)
        for i as integer = 0 to *fCnt-1            
            DJ_triangle( screenptr,Temp, tColor, 0, 0 )      
            Temp += sizeof(typeof(rBuffer(0)))
            #ifdef SkipPoly
            skpcnt += skip
            if skpcnt >= 8192 then 
                i+=1:skpcnt -= 8192
                Temp += sizeof(typeof(rBuffer(0)))
            end if
            #endif
        next
        #endif
    else
        dim as integer x1,y1,x2,y2
        for i as integer = 0 to *fCnt-1
            with rBuffer(i)
                x1=.vec1.iX:y1=.vec1.iY: x2=.vec2.iX:y2=.vec2.iY
                line(x1,y1)-(x2,y2),.iCol
                
                x1=.vec3.iX:y1=.vec3.iY
                line (x2,y2)-(x1,y1),.iCol
                
                x2=.vec1.iX:y2=.vec1.iY
                line (x1,y1)-(x2,y2),.iCol
            end with
            #ifdef SkipPoly
            skpcnt += skip
            if skpcnt >= 8192 then i+=1:skpcnt -= 8192
            #endif
            
        next
    end if
    
    *fcnt = 0
end sub

sub Intro()
    dim as number nIntro_Time, nLoop_Time = ToFixed(sTimer())
    dim as string tString
    dim nText_pos() as number
    dim nYinc() as number
    dim iStage as integer = 1
    dim lStage as integer 
    dim as integer Bottom(0 to 3), Exit_intro
    Bottom(1) = SCR_HD2 - 30
    Bottom(2) = SCR_HD2 - 4
    Bottom(3) = SCR_HD2 + 26
    dim as number nScroll_off
    
    do
        
        nIntro_Time = ToFixed(sTimer()) - nLoop_time
        nLoop_Time = ToFixed(sTimer())
        
        if lStage<>iStage then
            lStage = iStage
            select case as const iStage
                case 1
                    tString = "Pacenstein FB"
                    redim nText_pos(len(tString))
                    redim nYinc(len(tString))
                    for i as integer = 1 to ubound(nText_pos)
                        nText_pos(i) = ToFixed(-50 +rnd*50-rnd*i)
                        nYinc(i) = 0
                    next    
                case 2    
                    tString = "By"
                    redim nText_pos(len(tString))
                    redim nYinc(len(tString))
                    for i as integer = 1 to ubound(nText_pos)
                        nText_pos(i) = ToFixed(-50 +rnd*50-rnd*i)
                        nYinc(i) = 0
                    next    
                case 3    
                    tString = "Dr_Davenstein!"
                    redim nText_pos(len(tString))    
                    redim nYinc(len(tString))
                    for i as integer = 1 to ubound(nText_pos)
                        nText_pos(i) = ToFixed(-50 +rnd*50-rnd*i)
                        nYinc(i) = 0
                    next
            end select    
        end if
        
        
        screenlock
        line(0,0)-(SCR_WIDTH,SCR_HEIGHT),0,bf
        
        if iStage<4 then
            dim as integer tStart = SCR_WD2 - (len(tString))*4
            dim as number nYpos
            dim as integer icnt
            for i as integer = 1 to ubound(nText_pos)
                nText_pos(i) += nYinc(i)
                nYinc(i) += nIntro_Time*10
                if nText_pos(i) >= ToFixed(Bottom(iStage)) then
                    nText_pos(i) = ToFixed(Bottom(iStage))
                    nYinc(i) = FixedMulFixed( nYinc(i) , ToFixed(-(.5)) )
                end if
                
                dim as string nString = mid(tString, i, 1)
                draw string (tStart+((i-1)*8), ToCint(nText_pos(i)) ), nString, &HFFFF00
            next     
            
            for i as integer = 1 to ubound(nText_pos)
                if ToCint(nText_pos(i)) >= (Bottom(iStage)-1) then
                    icnt+=1
                end if
            next      
            
            if icnt=ubound(nText_pos) then
                iStage+=1
            end if
        end if    
        
        select case as const iStage
            case 2
                dim as string nString
                nString = "Pacenstein FB"
                dim as integer tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(1) ), nString, &HFFFF00
            case 3
                dim as string nString
                nString = "Pacenstein FB"
                dim as integer tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(1) ), nString, &HFFFF00
                nString = "By"
                tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(2) ), nString, &HFFFF00
            case 4
                nScroll_Off += nIntro_Time*150
                dim as string nString
                nString = "Pacenstein FB"
                dim as integer tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(1)+ToCint(nScroll_Off) ), nString, &HFFFF00
                nString = "By"
                tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(2)+ToCint(nScroll_Off) ), nString, &HFFFF00
                nString = "Dr_Davenstein!"
                tStart = SCR_WD2 - (len(nString))*4
                draw string (tStart, Bottom(3)+ToCint(nScroll_Off) ), nString, &HFFFF00
                if (ToCint(nScroll_Off)+Bottom(1)) > SCR_HEIGHT+20 then
                    Exit_Intro = 1
                end if
        end select
        
        screenunlock
        
        #ifdef __FB_NDS__
        flip
        #endif    
        ScreenSync
        sleep 1,1
        
        if len(inkey) then exit do
    loop until Exit_Intro
    
end sub

'Fast flat shaded triangle algo by DJ Peters.
sub DJ_triangle( d as ushort ptr, p as vector2dInt ptr, c as ipixel, b as const ipixel=0, u as const integer=0 )
    dim as integer   yt =any,yb=any,l=any,r=any
    dim as integer   d1 =any,d2=any,s1=any,s2=any,cl=any,cr=any
    dim as ushort ptr row=any,cstart=any,cend=any
    dim as vector2dInt  v0 =any,v1=any,v2=any, vt = any
    dim as integer temp = any
    
    #ifdef __FB_NDS__
    #define RR ((C and &hF8) shl 7)
    #define GG ((C and &hF800) shr 6)
    #define BB ((C and &hF80000) shr 19)
    c = RR or GG or BB or &h8000
    #else
    #define RR ((C and &hF8) shr 3)
    #define GG ((C and &hFC00) shr 5)
    #define BB ((C and &hF80000) shr 8)
    c = RR or GG or BB
    #endif
    'RRRRR000GGGGGG00BBBBB000
    '00000000RRRRRGGGGGGBBBBB
    
    v0=p[0]:v1=p[1]:v2=p[2]
    if (v1.iY>v2.iY) then 
        'Swap v1,v2
        vt = v1: v1 = v2: v2 = vt
    end if
    
    if (v0.iY>v2.iY) then 
        'Swap v0,v2
        vt = v0: v0 = v2: v2 = vt
    end if
    
    if (v0.iY>v1.iY) then 
        'Swap v0,v1
        vt = v0:v0 = v1: v1 = vt
    end if
    
    if (v2.iY=v0.iY) then return
    s1=((v2.iX-v0.iX) shl SHIFTS)/(v2.iY-v0.iY)
    d1=v0.iX shl SHIFTS
    for i as integer=0 to 1
        s2=((v1.iX-v0.iX) shl SHIFTS)/(v1.iY-v0.iY)
        d2=v0.iX shl SHIFTS
        yt=v0.iY
        ' begin in first row
        if yt<0 then
            d1-=s1*yt
            d2-=s2*yt
            yt=0
        end if
        yb=v1.iY
        ' end in last row
        if yb>=SCR_HEIGHT then yb=SCR_HEIGHT-1
        if yb<=yt    then goto next_triangle
        row=d+yt*SCR_WIDTH ' first row
        yb-=yt ' how many scanlines
        ' from top to bottom
        while yb
            l=d1 shr SHIFTS:r=d2 shr SHIFTS
            'If l>r      Then Swap l,r
            if l>r then
                temp = l
                l = r
                r = temp
            end if
            
            if l>=SCR_WIDTH then goto next_scanline 
            if r<1      then goto next_scanline
            cl=0:cr=0   ' reset clipflag
            if l<0      then l=0    :cl=1
            if r>=SCR_WIDTH then r=SCR_WIDTH:cr=1
            cstart=row+l ' first pixel
            cend  =row+r ' last  pixel
            'If u Then ' use border
            '    If cl=0 Then *cstart=b:cstart+=1
            '    If cr=0 Then *cend  =b
            'End If
            while cstart<cend
                #ifdef AlphaTriangles
                #define PixBits &b1111011111011110
                *cstart = ((*cstart and PixBits) shr 1)+((c and PixBits) shr 1)
                #else
                *cstart = c
                #endif
                cstart+=1
            wend
            '            Asm
            '                mov edi,[cstart]
            '                mov ecx,[cend]
            '                Sub ecx,edi
            '                cmp ecx,4 ' 4 bytes = 1 pixel
            '                jl row_loop_end
            '                Shr ecx,2 ' bytes to pixels
            '                mov eax,[c]
            '                row_loop:
            '                mov [edi],eax
            '                add edi,4
            '                dec ecx
            '                jnz row_loop
            '                row_loop_end:
            '            End Asm
            
            next_scanline:
            d1+=s1:d2+=s2:row+=SCR_WIDTH:yb-=1
        wend
        next_triangle:
        d1= (v0.iX shl SHIFTS)+((v1.iY-v0.iY)*s1)
        v0=v1:v1=v2
    next
end sub

sub New_Screen_Res( W as const integer, H as const integer, tFlags as const integer )
    
    SCR_WIDTH = W
    SCR_HEIGHT = H
    SCR_WD2 = SCR_WIDTH shr 1
    SCR_HD2 = SCR_HEIGHT shr 1
    iLENS = (SCR_WIDTH+SCR_HEIGHT) shr 1
    Flags = tFlags
    
    screenres SCR_WIDTH, SCR_HEIGHT, 16,,Flags
    
    setmouse(,,0)
end sub

sub Navigate_Menu( iDirection as const integer, piMenu_Level as integer ptr, iMenu_Highlight as const integer )
    if iDirection = GO_UP then
        select case as const iMenu_Highlight
            case 1
                select case as const *piMenu_Level
                    case MENU_TOP
                        'start new game
                    case MENU_GFX
                        *piMenu_Level = MENU_GFX_SUB1
                    case MENU_GFX_SUB1
                        New_Screen_Res( 256, 192, Flags )
                    case MENU_GFX_SUB2
                        Flags = FB.GFX_FULLSCREEN
                        New_Screen_Res( SCR_WIDTH, SCR_HEIGHT, Flags )  
                    case MENU_GFX_SUB3
                        Flags = FB.GFX_SHAPED_WINDOW
                        New_Screen_Res( SCR_WIDTH, SCR_HEIGHT, Flags )  
                    case MENU_SFX
                        *piMenu_Level = MENU_SFX_SUB1
                    case MENU_SFX_SUB1
                        Play_Music  = 0
                    case MENU_SFX_SUB2
                        Play_Sounds = 0
                    case MENU_CONTROLS
                        Control_Scheme = 1
                end select
                
            case 2
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_LOAD_USER_MAZE
                    case MENU_GFX
                        *piMenu_Level = MENU_GFX_SUB2
                    case MENU_GFX_SUB1
                        New_Screen_Res( 320, 240, Flags )
                    case MENU_GFX_SUB2
                        Flags = FB.GFX_WINDOWED
                        New_Screen_Res( SCR_WIDTH, SCR_HEIGHT, Flags )  
                    case MENU_GFX_SUB3
                        Flags = FB.GFX_WINDOWED
                        New_Screen_Res( SCR_WIDTH, SCR_HEIGHT, Flags )
                    case MENU_SFX
                        *piMenu_Level = MENU_SFX_SUB2
                    case MENU_SFX_SUB1
                        Play_Music  = 1
                    case MENU_SFX_SUB2
                        Play_Sounds = 1
                    case MENU_CONTROLS
                        Control_Scheme = 2
                end select
                
            case 3    
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_GFX
                    case MENU_GFX
                        *piMenu_Level = MENU_GFX_SUB3
                    case MENU_GFX_SUB1
                        New_Screen_Res( 640, 400, Flags )
                end select
                
            case 4
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_SFX
                    case MENU_GFX_SUB1
                        New_Screen_Res( 640, 480, Flags )
                end select
            case 5
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_HIGH_SCORES
                    case MENU_GFX_SUB1
                        New_Screen_Res( 800, 600, Flags )
                end select
                
            case 6
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_CONTROLS
                    case MENU_GFX_SUB1
                        New_Screen_Res( 1024, 768, Flags )
                end select
                
            case 7
                select case as const *piMenu_Level
                    case MENU_TOP
                        *piMenu_Level = MENU_QUIT
                        iExit_Game = 1
                    case MENU_GFX_SUB1
                        New_Screen_Res( 1280, 1024, Flags )
                end select
                
        end select
    end if
    
    
    if iDirection = GO_DOWN then
        select case as const *piMenu_Level
            case MENU_TOP
                iMenu_Active = 0
            case MENU_GFX_SUB1, MENU_GFX_SUB2, MENU_GFX_SUB3
                *piMenu_Level = MENU_GFX
            case MENU_SFX_SUB1, MENU_SFX_SUB2
                *piMenu_Level = MENU_SFX
            case MENU_GFX, MENU_SFX, MENU_HIGH_SCORES, MENU_CONTROLS, MENU_LOAD_USER_MAZE, MENU_LOAD_USER_MAZE1
                *piMenu_Level = MENU_TOP
        end select
    end if
end sub

sub Build_Menu_Array( Menu() as string, Menu_Level as const integer )
    
    select case as const Menu_Level
        case MENU_TOP
            redim Menu( 7 )
            Menu(0) = "MAIN MENU"
            Menu(1) = "NEW GAME"
            Menu(2) = "LOAD USER MAZE"
            Menu(3) = "GFX OPTIONS"
            Menu(4) = "SFX OPTIONS"
            Menu(5) = "HIGH SCORES"
            Menu(6) = "CONTROLS"
            Menu(7) = "QUIT"
        case MENU_LOAD_USER_MAZE    
            Get_File_List( "Data/Levels/User/*.maz", fbnormal, Menu(), 0 )
            Menu( 0 ) = "LOAD A USER MAZE!"
            
        case MENU_GFX
            'gfx options 1
            redim Menu( 3 )
            Menu(0) = "GFX OPTIONS"
            Menu(1) = "RESOLUTION"
            Menu(2) = "FULL/WINDOW"
            Menu(3) = "BACKGROUND MODE"
        case MENU_GFX_SUB1
            redim Menu( 7 )
            Menu(0) = "SCREEN RESOLUTION"
            Menu(1) = "256x192"
            Menu(2) = "320x240"
            Menu(3) = "640x400"
            Menu(4) = "640x480"
            Menu(5) = "800x600"
            Menu(6) = "1024x768"
            Menu(7) = "1280x1024"
        case MENU_GFX_SUB2
            redim Menu( 2 )
            Menu(0) = "WINDOW OPTIONS"
            Menu(1) = "FULL SCREEN"
            Menu(2) = "WINDOW"
        case MENU_GFX_SUB3
            redim Menu( 2 )
            Menu(0) = "ADVANCED GFX OPTIONS"
            Menu(1) = "TRANSPARENT BACKGROUND"
            Menu(2) = "REGULAR BACKGROUND"
        case MENU_SFX
            redim Menu( 2 )
            Menu(0) = "SOUND OPTIONS"
            Menu(1) = "MUSIC"
            Menu(2) = "SOUND FX"
        case MENU_SFX_SUB1
            redim Menu( 2 )
            Menu(0) = "MUSIC OPTIONS"
            Menu(1) = "OFF"
            Menu(2) = "ON"
        case MENU_SFX_SUB2
            redim Menu( 2 )
            Menu(0) = "SOUND EFFECTS OPTIONS"
            Menu(1) = "OFF"
            Menu(2) = "ON"
        case MENU_CONTROLS
            redim Menu( 2 )
            Menu(0) = "CONTROL SETUP"
            Menu(1) = "ROTATE AND MOVE"
            Menu(2) = "CLASSIC STYLE"
        case MENU_HIGH_SCORES
            redim Menu(5)
            Menu(0) = "HIGH SCORE RECORDS"
            Menu(1) = "#1 |DrD| 1,999,999"
            Menu(2) = "#2 |DrD| 1,999,999"
            Menu(3) = "#3 |DrD| 1,999,999"
            Menu(4) = "#4 |DrD| 1,999,999"
            Menu(5) = "#5 |DrD| 1,999,999"
    end select
    
end sub

function Get_File_Cnt( filespec as const string, attrib as const integer ) as integer
    dim as string File_Name
    dim as integer i
    File_Name = dir(filespec, attrib)
    do while File_Name <> ""
        i+=1
        File_Name = dir("", attrib)
    loop
    function = i
end function

sub Get_File_List( filespec as const string, attrib as const integer, Array() as string, Offset as const integer )
    
    redim Array( Get_File_Cnt( filespec, fbnormal) ) 
    
    dim as string F_Name
    dim as integer fi
    F_Name = dir(filespec, attrib)
    do while F_Name <> ""
        fi+=1
        Array(fi+Offset) = F_Name
        F_Name = dir( "", attrib )
    loop
end sub

sub Save_Maze( Filename as const string, byref Header as Maze_Header_Struct )
    
    dim as integer Filenum = freefile
    
    open Filename for binary as #Filenum
    put #FileNum,, Header
    for Z as integer = 1 to Header.iLength
        for X as integer =  1 to Header.iWidth
            put #Filenum,, Maze(X, Z).iTile
            put #Filenum,, Maze(X, Z).nTrans
        next
    next
    close #Filenum
    
end sub

sub Load_Maze( Filename as const string, byref Header as Maze_Header_Struct )
    
    dim as integer Filenum = freefile
    if open(Filename for binary access read as #Filenum) then    
        print "Failed to load maze: '"; Filename ; "'"
        beep: sleep :exit sub
    end if
    get #FileNum,, Header
    
    'redim Maze(Header.Width,Header.Length)
    iUboundMaze1 = Header.iWidth: iUboundMaze2 = Header.iLength
    
    dim TempbTile as byte,TempsTrans as float
    for Z as integer = 1 to Header.iLength    
        for X as integer = 1 to Header.iWidth
            get #Filenum,, TempbTile: Maze(X, Z).iTile = TempbTile
            get #Filenum,, TempsTrans: Maze(X, Z).nTrans = ToFixed(TempsTrans)
        next
    next
    close #Filenum
    
    print "here!"
    'sleep
    
    dim as integer vid_count
    for ny as integer = 1 to Header.iLength
        for nx as integer = 1 to Header.iWidth
            
            Maze(nx,ny).Model = Maze_Models[Maze(nx,ny).iTile]
            
            if Maze(nx,ny).iTile = 1 or Maze(nx,ny).iTile = 2 then
                iTotal_Pellets+=1
            end if
            
            if Maze(nx,ny).iTile = 4 then
                Door_Position = type(nx,ny)
                Maze(nx,ny).Model = Collision_Cube
            end if
            
            if Maze(nx,ny).iTile <> 3 then
                if Maze(nx,ny).iTile>0 then
                    vid_count+=1
                end if    
            end if
        next
    next
    
    'dim as integer ff = freefile
    'open cons for output as #ff
    'print #ff, Header.Width
    'print #ff, Header.Length
    'close #ff
    
    
    Valid_Index = callocate((vid_count+1)*sizeof(typeof((*Valid_Index))))
    iUbound_ValidIndex = vid_count
    'redim Valid_Index( vid_count )
    
    vid_count=0
    for ny as integer = 1 to Header.iLength
        for nx as integer = 1 to Header.iWidth
            if Maze(nx,ny).iTile <> 3 then
                if Maze(nx,ny).iTile > 0 then
                    Valid_Index[vid_count] = type(nx,ny)
                    vid_count+=1
                end if
            end if
        next
    next
    
    
    'build a render buffer now.
    dim as integer fcnt
    
    'For i As Integer = 0 To MAX_MAZE_MODELS - 1
    '    fcnt+=Maze_Models[i]->max_triangles
    'Next
    '    fcnt*=( UboundMaze1 * UboundMaze2 )*2
    
    for ny as integer = 1 to Header.iLength
        for nx as integer = 1 to Header.iWidth
            fcnt += Maze(nx,ny).Model->iMax_triangles
        next
    next
    
    for i as integer = 0 to MAX_PAC_MODELS - 1
        fcnt += Pac_Models[i]->iMax_triangles
    next
    
    for i as integer = 0 to MAX_GHOST_MODELS - 1
        fcnt += Ghost_Models[i]->iMax_triangles
    next
    
    'redim rBuffer( fcnt*1.5 )
    
    with Hero
        var pCP = @(Header.char_positionsF(0))
        .Start_Position = Type(ToFixed(pCP->fX),ToFixed(pCP->Fy),ToFixed(pCP->Fz))
        .nSpeed         = ToFixed(Header.fCharSpeed(0))
        .nGBoxTime      = ToFixed(Header.fWaitTime(0))
        .nScaredTime    = ToFixed(Header.fScareTime(0))
    end with
    
    var pCharsI = @Chars(0)
    for i as integer = 1 to iUbound_Chars
        pCharsI += 1
        var pCP = @(Header.char_positionsF(i))
        pCharsI->Start_Position      = Type(ToFixed(pCP->fX),ToFixed(pCP->Fy),ToFixed(pCP->Fz))
        pCharsI->nSpeed      = ToFixed(Header.fCharSpeed(i))
        pCharsI->nGBoxTime   = ToFixed(Header.fWaitTime(i))
        pCharsI->nScaredTime = ToFixed(Header.fScareTime(i))    
    next
    
end sub
