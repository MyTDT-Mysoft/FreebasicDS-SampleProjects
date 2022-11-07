#define fbc -s gui

const MaxFrames = 0
const FixScale = 1/1024

#ifdef __FB_NDS__
  #define __FB_NITRO__  
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define DoFlush() glFlush(0)
#else
  #define DoFlush() flip
#endif

type number as single

dim shared as integer iSwapFrame
dim shared as integer CameraX,CameraY,CameraAngle,CameraFOV
dim shared as single CameraMul=1
dim shared as single lmatrix(15)


#include "stunts/math_module.bi"
#include "stunts/model_module.bi"
#include "stunts/gl_module.bi"

#include "stunts/math_module.bas"
#include "stunts/glList.bas"
#include "stunts/gl_module.bas"
#include "stunts/model_module.bas"

#include "Stunts/Track.bas"

'temp for now...
type vec3s
	as short x, y, z
end type

mat44_loadidentity( @lmatrix(0) )
lmatrix(12) = 0
lmatrix(13) = 1
lmatrix(14) = 0
mat44_rotx( @lmatrix(0), -3.14159265 )
mat44_roty( @lmatrix(0), 0 )
mat44_rotz( @lmatrix(0), -lMatrix(1) )

dim as vec3 carposition = type(0, 1, 0)

dim as integer MidX,MidY,MidZ
dim as double TMR = timer

LoadModel("Models/STVETT_P3S-car0.obj", @CarModel )
LoadModel("Models/wheel.obj", @WheelModel )

DoFlush(): screensync

'print #99,LoadTrack("Map/expert.rpl")

#ifdef __FB_NDS__
const ScrX = 256, ScrY = 192
#else
const ScrX = 640, ScrY = 480
#endif

init_gl_window(ScrX, ScrY)
dim as integer SCRmidx = ScrX/2, SCRmidy = ScrY/2

DoFlush(): screensync

'glEnable( GL_BLEND )
'glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA )

#ifdef __FB_NDS__
glClearColor(16,24,31,31)
glEnable(GL_FOG)
glFogShift(5)
glFogColor(16,24,31,31)
for i as integer = 0 to 31
  glFogDensity(i,1-sin((3.141592/180)*((31-i)*(90/31)))*127)
next i	
glFogOffset(&h7C80)
#else
glEnable(GL_FOG)
scope
  dim as single fColor(3) = {.5,.75,1,1}, Temp = any
  dim as integer iTemp = any
  glfogfv(GL_FOG_COLOR,@fColor(0))
  glfogi(GL_FOG_MODE,GL_LINEAR)
  glFogf(GL_FOG_START,6)
  glFogf(GL_FOG_END,11)
end scope
glClearColor(	.5 , .75 , 1 , 1 )
glEnable( GL_LIGHT0 )
glDisable( GL_CULL_FACE )
#endif

DoFlush(): screensync
LoadTrackModels()
DoFlush(): screensync

dim as single light_position(3) = {0, 4096*FixScale, -16, 1}
dim as single angleX=10,AngleY=0,MaxTrack
dim as double ftime, ltime
dim Key as string,TrackNum as integer=0
dim as integer Lighting
dim shared as string Tracks(255)

'glEnable( GL_LIGHTING ): Lighting = 1

scope
  dim as integer TrkLst = freefile()
  open "Tracks.txt" for input as #TrkLst
  while not eof(TrkLst)
    line input #TrkLst,Tracks(MaxTrack)
    MaxTrack += 1
  wend
  close #Trklst
  MaxTrack -= 1
  LoadTrack("Map/"+Tracks(TrackNum))
  #ifdef __FB_NDS__
  print "Map/"+Tracks(TrackNum)
  #else
  WindowTitle("Map/"+Tracks(TrackNum))
  #endif
  printf !"Ready.\n"
end scope

DoFlush(): screensync

ltime = timer

dim as single SNC = timer,FTMR,FTMP = timer
dim as integer FPS,FCNT

do
  
  #ifdef __FB_NDS__
  #define KeyPrevTrack() fb.SC_ButtonL
  #define KeyNextTrack() fb.SC_ButtonR
  #else
  #define KeyPrevTrack() fb.SC_PAGEUP
  #define KeyNextTrack() fb.SC_PAGEDOWN
  #endif
  
	Key = inkey$
	if len(Key) then
		if Key[1] = KeyPrevTrack() andalso TrackNum > 0 then
			TrackNum -= 1
			LoadTrack("Map/"+Tracks(TrackNum))
			#ifdef __FB_NDS__
			print "Map/"+Tracks(TrackNum)
			#else
			WindowTitle("Map/"+Tracks(TrackNum))
			#endif
    elseif Key[1] = KeyNextTrack() andalso TrackNum < MaxTrack  then
			TrackNum += 1
			LoadTrack("Map/"+Tracks(TrackNum))
			#ifdef __FB_NDS__
			print "Map/"+Tracks(TrackNum)
			#else
			WindowTitle("Map/"+Tracks(TrackNum))
			#endif
    end if
		if Key[0] = asc("l") or Key[0] = asc("L") then
			Lighting xor= 1
			#ifdef __FB_NDS__
			rem ??
			#else
			if Lighting then glEnable( GL_LIGHTING ) else glDisable( GL_LIGHTING )
			#endif
    end if
  end if
  
	ftime = timer-ltime
	ltime = timer
  
	'if multikey( FB.SC_LEFT ) then
	'	tire_angle+=1: if tire_angle>30 then tire_angle = 30
	'end if
	'
	'if multikey( FB.SC_RIGHT ) then
	'	tire_angle-=1: if tire_angle<-30 then tire_angle = -30
	'end if
  
	if multikey(FB.SC_UP) then
		CarPosition.z-=.1
  end if  
	if multikey(FB.SC_down) then
		CarPosition.z+=.1
  end if  
	if multikey(FB.SC_right) then
		CarPosition.x+=.1
  end if  
	if multikey(FB.SC_left) then
		CarPosition.x-=.1
  end if
  
	dim as vec3 factor
	dim as integer tempx, tempy, button
	static as integer WasOut
	getmouse(TempX, TempY,, Button) 
  
  if Button = -1 then
		WasOut = 1
  else
		if WasOut then
			WasOut = 0			
      setmouse(SCRMidX, SCRMidY)
    else
      #ifdef __FB_NDS__
        static as integer MouseDown,BaseX,BaseY
        if Button then
          if MouseDown = 0 then 
            MouseDown = 1: BaseX = TempX : BaseY = TempY
          else
            Factor.y = (BaseX-TempX)/100
            Factor.x = (BaseY-TempY)/100          
            Factor.z = -lMatrix(1)
            BaseX = TempX : BaseY = TempY
          end if
        else
          MouseDown = 0
        end if      
      #else        
        if SCRMidX <> Tempx orelse SCRMidY<>TempY then          
          Factor.y = (SCRMidX-TempX)/500
          Factor.x = (SCRMidY-TempY)/500
          setmouse(SCRMidX, SCRMidY, 0)
          Factor.z = -lMatrix(1)
        end if        
      #endif
      
			mat44_rotx( @lmatrix(0), Factor.x )
      mat44_roty( @lmatrix(0), Factor.y )
			mat44_rotz( @lmatrix(0), Factor.z )
      
      #ifdef __FB_NDS__
      #define PressedW() (multikey(fb.sc_ButtonUp)    or multikey(fb.sc_ButtonX))
      #define PressedS() (multikey(fb.sc_ButtonDown)  or multikey(fb.sc_ButtonB))
      #define PressedD() (multikey(fb.sc_ButtonRight) or multikey(fb.sc_ButtonA))
      #define PressedA() (multikey(fb.sc_ButtonLeft)  or multikey(fb.sc_ButtonY))
      #else
      #define PressedW() multikey(fb.sc_W)
      #define PressedS() multikey(fb.sc_S)
      #define PressedD() multikey(fb.sc_D)
      #define PressedA() multikey(fb.sc_A)
      #endif
      
			if PressedW() then
				lMatrix(12)+=lMatrix(8)*.025
				lMatrix(13)+=lMatrix(9)*.025
				lMatrix(14)+=lMatrix(10)*.025
      end if
      
			if PressedS() then
				lMatrix(12)-=lMatrix(8)*.025
				lMatrix(13)-=lMatrix(9)*.025
				lMatrix(14)-=lMatrix(10)*.025
      end if
      
			if PressedD() then
				lMatrix(12)+=lMatrix(0)*.075
				lMatrix(13)+=lMatrix(1)*.075
				lMatrix(14)+=lMatrix(2)*.075
      end if
			if PressedA() then
				lMatrix(12)-=lMatrix(0)*.075
				lMatrix(13)-=lMatrix(1)*.075
				lMatrix(14)-=lMatrix(2)*.075
      end if
      
    end if
  end if
  
	#ifndef __FB_NDS__
	glclear( GL_DEPTH_BUFFER_BIT or GL_COLOR_BUFFER_BIT )
	#endif
    
  light_position(0) = 0 'lMatrix(12)'position.x
	light_position(1) = 2
	light_position(2) = 0 'lMatrix(14)
  
	'glMatrixMode( 2 ) 'GL_MODELVIEW )
	'glLoadIdentity()
  'glLight(0, 0 , 0, floattov10(-1), 0)
  'glTranslatef( light_position(0) , light_position(1) , light_position(2) )
  'glMatrixMode( 1 )
  'glLoadIdentity()
  
  #ifdef __FB_NDS__
  glMatrixMode( GL_POSITION )
  #else
  glMatrixMode( GL_MODELVIEW )
  #endif  
  glLoadIdentity()
  
	glulookat( lMatrix(12), lMatrix(13), lMatrix(14), lMatrix(12)+lMatrix(8), lMatrix(13)+lMatrix(9), lMatrix(14)+lMatrix(10), lMatrix(4), lMatrix(5), lMatrix(6) )

	#ifdef __FB_NDS__
  if lMatrix(13) > 3 then lMatrix(13) = 3
  if lMatrix(13) < 20*FixScale then lMatrix(13) = 20*FixScale
  CameraFOV = 45+(lMatrix(13)*20)    
  #else
  if lMatrix(13) > 4 then lMatrix(13) = 4
  if lMatrix(13) < 20*FixScale then lMatrix(13) = 20*FixScale
	glLightfv( GL_LIGHT0, GL_POSITION, @light_position(0) )
	#endif
  
	'render the car and wheels....
	'glpushmatrix()
	'gltranslatef( -7 ,  0 , 7 )
	'gltranslatef( CarPosition.x, CarPosition.y, CarPosition.z )
	'DrawModel(@CarModel)
	'glpopmatrix()
  
  RenderTrack()
  
	'gltranslatef( CarPosition.x, CarPosition.y, CarPosition.z )
  
	'glloadidentity()
	'gltranslatef(0,0,-3)
	'glrotatef(90,1,0,0)
  
	'gldisable( GL_DEPTH_TEST )
	#ifdef __FB_NDS__
  dim as integer PX = (15-lMatrix(12))+.5
  dim as integer PY = (30-(15-lMatrix(14)))+.5
  #else
  dim as integer PX = 15-lMatrix(12)
  dim as integer PY = 30-(15-lMatrix(14))
  #endif
	CameraX=PX: CameraY=PY: CameraAngle = atan2(lmatrix(10),lMatrix(8))*(1/(PI/180))
  CameraAngle = 180-CameraAngle
  if CameraAngle > 180 then CameraAngle -= 360
  #if 0
  
  dim as tModel ptr CollideModel = TrackObjects( Track.Object(PY, PX) ).ObjA
	'if CollideModel then
	'	drawmodel( CollideModel )  
  'else
	'	DrawModel(@CarModel)
	'end if
	'glenable( GL_DEPTH_TEST )
  
  if CollideModel then    
    var spShapes = CollideModel->spShapes
    var spVertices = CollideModel->spVertices
    dim as integer si,shape
    dim as integer max_vert,iMaterial
    dim as integer MainTires = 0
    
    do
      shape = spShapes[si]: si += 1
      select case shape
			case skFace
        if MainTires > 0 then MainTires = -1
        max_vert = spShapes[si]
        dim as vec3 norm = type( spShapes[si+1]*FixScale , spShapes[si+2]*FixScale , spShapes[si+3]*FixScale )					
        
        dim as vec3 vLine(1), vPoly(max_vert-1), vIntersection
        'take into account that the model is actually at (0,0)... need to subtract the integer value from the camera position
        vLine(0).x = lMatrix(12)-int(lMatrix(12))
        vLine(0).y = 10000
        vLine(0).z = lMatrix(14)-int(lMatrix(14))
        vLine(1).x = vLine(0).x
        vLine(1).y = -10000
        vLine(1).z = vLine(0).z
        
        si += 3					
        for vi as integer = 1 to max_vert
          dim as integer Shape = spShapes[si+vi]							
          vPoly(vi-1) = type( SpVertices[Shape]*fixscale, spVertices[Shape+1]*fixscale, spVertices[Shape+2]*fixscale )
        next
        
        if vec3_lineIntersectedPolygon( @vPoly(0), max_vert-1, @norm, @vLine(0), @vIntersection ) then
          printf(!"Intersection detected\n")
        end if
        
        si += (max_vert+1)
      case skLine
				si += 2
      case skMaterial
        si += 1
      case skLast
        exit do
      end select
    loop
  end if
  
  #endif
  
  FPS += 1: FCNT += 1
  if (timer-SNC) >= 1 then
    SNC = timer
    FCNT /= 2: FTMR = FTMR/2 
    #ifdef __FB_NDS__
    printf(!"fps: %i (%i %i) %0.2f ms  \n", _
    FPS,GFX_VERTEX_RAM_USAGE,GFX_POLYGON_RAM_USAGE,(FTMR/FCNT)*1000)
    #else
    printf(!"fps: %i %0.2f ms  \n",FPS,(FTMR/FCNT)*1000)
    #endif
    FPS = 0
  end if
  
	#ifdef __FB_NDS__	
  DoFlush()
  FTMR += (timer-FTMP)  
  swiWaitForVBlank()
  iSwapFrame xor= 1
  FTMP = timer
  if multikey(FB.SC_BUTTONSTART) then exit do
	#else 
  flip
	sleep 3, 1  
  if multikey(FB.SC_ESCAPE) then exit do
	#endif
  
  
loop





