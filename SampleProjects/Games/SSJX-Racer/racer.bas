''
'' ????Racer
''
'' FBGD RetroComp Aug/Sept 2008 Entry by ssjx (http://ssjx.co.uk)
''
''
''

#define STARCOUNT 20
#define FPS 20
#define DEBUG 0
#define SOUND

type ipoint
	x as integer
	y as integer
end type

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
chdir "NitroFiles/"
open cons for output as #99
#endif

dim shared as ubyte ptr PixPtr

#ifdef SOUND
#ifdef __FB_NDS__
#include "Modules\fmod.bas"
#else
#include "fmod.bi"
#endif
#endif
#include "fbgfx.bi"
#include "gfx.bas"
#include "score.bas"

#ifdef __FB_NDS__
#define SpacePressed()  (multikey(fb.sc_Space)  or multikey(fb.sc_ButtonStart)  or multikey(fb.sc_ButtonA))
#define EscapePressed() (multikey(fb.sc_Escape) or multikey(fb.sc_ButtonSelect) or multikey(fb.sc_ButtonB))
#define LeftPressed()   (multikey(fb.sc_Left)   or multikey(fb.sc_ButtonLeft)   or multikey(fb.sc_ButtonL))
#define RightPressed()  (multikey(fb.sc_Right)  or multikey(fb.sc_ButtonRight)  or multikey(fb.sc_ButtonR))
#else
#define SpacePressed()  (multikey(fb.sc_Space))
#define EscapePressed() (multikey(fb.sc_Escape))
#define LeftPressed()   (multikey(fb.sc_Left))
#define RightPressed()  (multikey(fb.sc_Right))
#endif

'' used to copy vehicle to player
sub vcopy(dest() as short,src() as short)
	for j as integer=0 to 7
		for i as integer=0 to 7
      dest(i,j)=src(i,j)
    next i
  next j
end sub

randomize 33

screenres 256,192
dim as any ptr MyImage = ImageCreate(128,60)
PixPtr = MyImage+sizeof(fb.image)

'width 80,60

dim as integer c,i,j,a,alt=0,sky=0,roadtype=0
dim as integer px,quit=0,fc=0,fcmax,dist,totaldist
dim as integer release
dim as integer bestdist=0,vehicle,bonus
dim as string k

dim shared as integer xpos(5)={8,18,30,40,54,64}
dim shared as integer ypos(5)={2,5,9,14,20,27}

dim shared as short alpha(96*8,12)
dim shared as short number(10*8,12)

'' xpos per stripe
dim shared as short gridpos(5,5) = { _
{ 25,23,18,16,12, 8 } , _
{ 28,28,25,22,20,18 } , _
{ 34,34,33,32,31,30 } , _
{ 39,40,40,40,40,40 } , _
{ 44,45,46,48,52,54 } , _
{ 49,52,54,56,60,64 } }
'bikeimage:
dim shared as short bike(7,7) = { _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1, 8,-1, 8, 8, 8, 8,-1 } , _
{  8, 8, 8, 8, 0, 0, 0, 0 } , _
{  8, 8, 8, 8, 0, 0, 0, 0 } , _
{ -1, 8,-1, 8, 8, 8, 8,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } } 
'carimage:
dim shared as short bluecar(7,7),blackcar(7,7),car(7,7) = { _
{ -1,-1,-1, 2, 2, 2,-1,-1 } , _
{ -1,-1, 2, 3, 2, 2, 0, 0 } , _
{ -1, 2, 3, 3, 2, 2, 0, 0 } , _
{ -1, 2, 3, 3, 2, 2,-1,-1 } , _
{ -1, 2, 3, 3, 2, 2,-1,-1 } , _
{ -1, 2, 3, 3, 2, 2, 0, 0 } , _
{ -1,-1, 2, 3, 2, 2, 0, 0 } , _
{ -1,-1,-1, 2, 2, 2,-1,-1 } }
'treeimage:
dim shared as short tree(7,7) = { _
{ -1, 2,10, 2,10,-1,-1,-1 } , _
{  2,10, 2, 4, 2,10,-1,-1 } , _
{ 10, 2,10, 2,10, 2,-1,-1 } , _
{  2,10, 2,10, 2,10, 0, 0 } , _
{ 10, 2, 4, 2,10, 2, 0, 0 } , _
{  2,10, 2,10, 4,10,-1,-1 } , _
{ 10, 2,10, 2,10, 2,-1,-1 } , _
{ -1,10, 2,10, 2,-1,-1,-1 } }
'snowmanimage:
dim shared as short snowman(7,7) = { _
{ -1,-1,-1,-1,-1,15,15,15 } , _
{ -1,15,15,-1,15,15,15,15 } , _
{ 15, 0,15,15,15,15,15,15 } , _
{ 15,15,14,15, 0,15, 0,15 } , _
{ 15, 0,15,15,15,15,15,15 } , _
{ -1,15,15,-1,15,15,15,15 } , _
{ -1,-1,-1,-1,-1,15,15,15 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } }
'sunimage:
dim shared as short sun(7,7) = { _
{ -1,14,14,14,14,-1,-1,-1 } , _
{ 14,14,14,14,14,14,-1,-1 } , _
{ 14,14,14,14,14,14,-1,-1 } , _
{ 14,14,14,14,14,14,-1,-1 } , _
{ 14,14,14,14,14,14,-1,-1 } , _
{ -1,14,14,14,14,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } }
'moonimage:
dim shared as short moon(7,7) = { _
{ -1,14,14,14,14,-1,-1,-1 } , _
{ 14,14,14,14,14,14,-1,-1 } , _
{ 14,-1,-1,-1,-1,14,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } , _
{ -1,-1,-1,-1,-1,-1,-1,-1 } }
'cloudimage:
dim shared as short cloud(7,7) = { _
{ -1,15,15,-1,-1,-1,-1,-1 } , _
{ 15,15,15,15,15,-1,-1,-1 } , _
{ 15,15,15,15,15,-1,-1,-1 } , _
{ -1,15,15,15,15,-1,-1,-1 } , _
{ 15,15,15,-1,15,-1,-1,-1 } , _
{ 15,15,15,15,-1,-1,-1,-1 } , _
{ 15,15,15,15,-1,-1,-1,-1 } , _
{ -1,15,15,-1,-1,-1,-1,-1 } }
'ssjximage:
dim shared as short ssjx(4,14) = { _
{ 15,15,15,-1,15,15,15,-1,15,15,15,-1,15,-1,15} , _ 
{ 15,-1,-1,-1,15,-1,-1,-1,-1,-1,15,-1,15,-1,15} , _
{ 15,15,15,-1,15,15,15,-1,15,-1,15,-1,-1,15,-1} , _
{ -1,-1,15,-1,-1,-1,15,-1,15,-1,15,-1,15,-1,15} , _
{ 15,15,15,-1,15,15,15,-1,15,15,15,-1,15,-1,15} }

dim shared as short player(7,7)
'dim as integer ptr player
redim shared as ipoint stars(STARCOUNT)
dim shared as short road(5,5)

'' -- Timer related --

dim as integer minf=99999,maxf=0
dim as double start,rad, current,av
dim as double realfps
dim as double last = timer,t
const as double oneFrame = 1/FPS '1/?th of a second

''' ------------------

''
'' Sound..
''
#ifdef SOUND
FSOUND_Init(44100, 8, 0) 
#endif

dim shared sample(10) as any ptr
#ifdef SOUND
for i=0 to 1	
  sample(i) = FSOUND_Sample_Load(FSOUND_FREE,"wav/"+str(i)+".wav", FSOUND_HW3D, 0, 0) 
next i
#endif


''' --------------
'' set up the giant text/font
#if 0
scope
  color 5,0
  dim buffer as any ptr
  buffer = ImageCreate( 640,16)  
  for i=0 to 25    
    draw string buffer,(i*8,0),chr(65+i)
    'draw string (i*8,0),chr(65+i)
  next i
  for i=0 to 10    
    draw string buffer,((26*8)+(i*8),0),chr(48+i)
    'draw string ((i+26)*8,0),chr(48+i)
  next i
  for j=0 to 7
    for i=0 to 40*8
      if point(i,j,buffer)<>0 then alpha(i,j)=14 else alpha(i,j)=-1
    next i
  next j
  ImageDestroy buffer
  open "font.dat" for binary access write as #1
  put #1,1,*cptr(ubyte ptr,@alpha(0,0)),(ubound(alpha,1)+1)*(ubound(alpha,2)+1)*sizeof(alpha(0,0))
  close #1
end scope
#else
scope
  dim as integer MyFile = freefile
  open "font.dat" for binary access read as #MyFile
  get #1,1,*cptr(ubyte ptr,@alpha(0,0)),(ubound(alpha,1)+1)*(ubound(alpha,2)+1)*sizeof(alpha(0,0))
end scope
#endif


''
'sleep

'''
for j=0 to 7
	for i=0 to 7
    a = car(i,j)
    ''default is green car
    bluecar(i,j)=a
    blackcar(i,j)=a    
    if a=2 then
      bluecar(i,j)=1
      blackcar(i,j)=0
    end if
  next i
next j

''
bestdist=loadscore()

''
'' Main game
''
do
  ''
  '' title screen
  ''
  quit=0
  
	draw_tunnel(0,1,0)
  
	blockprint(20,4,"Racer",alpha(),14 )
	blockprint(21,5,"racer",alpha(),4 )
	
	blockprint(6,14,"best dist",alpha(),14 )
	blockprint(7,15,"best dist",alpha(),4 )
	
	blockprint(40-len(str(bestdist))*4,24,str(bestdist),alpha(),3 )
	blockprint(41-len(str(bestdist))*4,25,str(bestdist),alpha(),1 )
  
	blockprint(20,34,"press",alpha(),3 )
	blockprint(21,35,"press",alpha(),14 )
	#ifdef __FB_NDS__
  blockprint(20,44,"start",alpha(),3 )
	blockprint(21,45,"start",alpha(),14 )
  #else
  blockprint(20,44,"space",alpha(),3 )
	blockprint(21,45,"space",alpha(),14 )
  #endif
	
	''corner initials
	for j=0 to 4
		for i=0 to 14      
      block(65+i,55+j,ssjx(j,i))
    next i
  next j
	
	
	while inkey <> "": wend
	
	do
    ScreenUpdate()
    sleep 5
    
    if EscapePressed() then
      #ifdef SOUND
      FSOUND_Close()
      #endif
      end
    end if
    
  loop until SpacePressed()
  
  ''
  '' By bike or car?
  ''
  bonus=0
  if bestdist>150 then bonus+=1  '' green car
  if bestdist>250 then bonus+=1  '' snowman
  if bestdist>350 then bonus+=1  '' tree
  if bestdist>400 then bonus+=1  '' cloud
  
	vehicle=0
	release=0
	do
    
		screenlock
		draw_tunnel(0,1,0)
    
		blockprint(16,4,"choose",alpha(),3 )
		blockprint(17,5,"choose",alpha(),14 )
    
		blockprint(24,14,"your",alpha(),3 )
		blockprint(25,15,"your",alpha(),14 )
    
		blockprint(12,24,"vehicle",alpha(),3 )
		blockprint(13,25,"vehicle",alpha(),14 )
    
		draw_sprite(xpos(0),48,bike() )
		draw_sprite(xpos(1),48,blackcar() )
		
		if bonus>0 then
			draw_sprite(xpos(2),48,car() )
    end if
		
		if bonus>1 then
			draw_sprite(xpos(3),48,snowman() )
    end if	
		
		if bonus>2 then
			draw_sprite(xpos(4),48,tree() )
    end if	
    
		if bonus>3 then
			draw_sprite(xpos(5),48,cloud() )
    end if
    
		''box around selected
		square(xpos(vehicle)-1,48-1,10,14 )
		
		screenunlock
		
		while inkey <> "" or SpacePressed()
      sleep 1,1
    wend
		do	
      #ifdef SOUND
      FSOUND_Update
      #endif
      k=inkey
      if LeftPressed() and vehicle>0 and release=0 then
        vehicle-=1
        release=1
        #ifdef SOUND
        FSOUND_PlaySound(FSOUND_FREE, sample(0))
        #endif
      end if
      
      if RightPressed() and (vehicle<(1+bonus)) and release=0 then
        vehicle+=1
        release=1	
        #ifdef SOUND
        FSOUND_PlaySound(FSOUND_FREE, sample(0))
        #endif
      end if	
      
      if SpacePressed() then k=" "
      
      ''
      if LeftPressed()=0 and RightPressed()=0 then release=0
      ScreenUpdate()
      sleep 5
    loop until k<>""
		
  loop until k=" "
  
  
  ''
  select case vehicle
  case 0: vcopy(player(),bike())
  case 1: vcopy(player(),blackcar())
  case 2: vcopy(player(),car())
  case 3: vcopy(player(),snowman())
  case 4: vcopy(player(),tree())
  case 5: vcopy(player(),cloud())
  end select
  
  
  ''
  ''reset things
  ''
  
  '' clear road
  for j=0 to 5
    for i=0 to 5
      road(i,j)=0
    next i
  next j
  
  '' star positions (also used for clouds)
  for i=0 to STARCOUNT
    stars(i).x=int(rnd*80)
    stars(i).y=int(rnd*29)
  next i
  
  px=3
  fcmax=15
  dist=0
  totaldist=0
  road( int(rnd*6),0)=1
  sky=0
  roadtype=0
	
  do
    ''
    '' Controls...
    ''		
    
    if  LeftPressed() and release=0 then
      px-=1
      if px<0 then px=0
      release=1
    end if 
    
    if  RightPressed() and release=0 then
      px+=1
      if px>5 then px=5	
      release=1
    end if
    
    if LeftPressed()=0 and RightPressed()=0 then release=0
    
    if EscapePressed() then
      quit=2
    end if
    
    
    '' Screenshot
    'if multikey(SC_S) then
    '  bsave "screen.bmp",0
    'end if
    
    ''
    '' update track and item positions
    ''
    fc+=1
    if fc>=fcmax then
      ''move road
      alt=1-alt
      
      '' shift obstacles down		
      for j=5 to 1 step -1
        for i=0 to 5
          road(i,j)=road(i,j-1)
        next i
      next j
      
      for i=0 to 5
        road(i,0)=0
      next i
      
      '' add a car
      if (rnd*100)>60 then
        road( int(rnd*6),0)=1+int(rnd*3)
      end if
      
      '' maybe add another car
      if totaldist>50 then
        if (rnd*100)>60 then
          road( int(rnd*6),0)=1+int(rnd*3)
        end if
      end if
      
      ''
      fc=0
      
      '' adjust speed depending on distance travelled
      dist+=1
      totaldist+=1	
      if dist=18 then
        
        dist=0
        
        if fcmax>5 then
          fcmax-=1
        end if
        
        
        '' change the time of day
        sky+=1
        if sky>2 then sky=0
        
        if sky=2 then
          '' stars
          for i=0 to STARCOUNT
            stars(i).x=int(rnd*80)
            stars(i).y=int(rnd*29)
          next i
        end if
        
        '' change the type of road
        'roadtype+=1
        'if roadtype>2 then roadtype=0
        roadtype=int(rnd*3)
        
        
      end if
      
    end if	
    
    
    
    
    ''
    '' Draw everything
    ''
    screenlock
    'cls
    draw_tunnel(alt,sky,roadtype)
    
    select case sky
    ''case 0: draw_sprite(70,10,sun() )
    case 1
      draw_sprite(70,2,sun() )
      draw_sprite(stars(0).x,2,cloud() )
      draw_sprite(stars(1).x,10,cloud() )
      draw_sprite(stars(2).x,11,cloud() )      
    case 2
      draw_sprite(70,2,moon() )
    end select
    
    '' corner score
    blockprint(0,0,str(totaldist),alpha(),14 )
    
    for j=0 to 5
      for i=0 to 5
        color 1,0
        '	print road(i,j);
        
        ''
        '' Road has cars on
        ''
        
        if roadtype=0 then
          
          select case road(i,j)        
          case 1
            if j<2 then
              draw_halfsprite(gridpos(i,j),21+ypos(j),car() )	
            else
              draw_sprite(gridpos(i,j),21+ypos(j),car() )
            end if
          case 2
            if j<2 then
              draw_halfsprite(gridpos(i,j),21+ypos(j),bluecar() )	
            else
              draw_sprite(gridpos(i,j),21+ypos(j),bluecar() )
            end if			
          case 3
            if j<2 then
              draw_halfsprite(gridpos(i,j),21+ypos(j),blackcar() )	
            else
              draw_sprite(gridpos(i,j),21+ypos(j),blackcar() )
            end if	          
          end select
          
        end if
        
        ''
        '' Grassy has trees
        ''
        
        if roadtype=1 then
          if road(i,j)>0 then
            if j<2 then
              draw_halfsprite(gridpos(i,j),21+ypos(j),tree() )	
            else
              draw_sprite(gridpos(i,j),21+ypos(j),tree() )
            end if
          end if
        end if
        
        ''
        '' Cold
        ''
        
        if roadtype=2 then
          if road(i,j)>0 then
            if j<2 then
              draw_halfsprite(gridpos(i,j),21+ypos(j),snowman() )	
            else
              draw_sprite(gridpos(i,j),21+ypos(j),snowman() )
            end if
          end if
        end if
        
      next i
      '	print ""
    next j
    'print "--"
    
    
    '' draw player
    draw_sprite(xpos(px),48,player() )
    
    'color 4
    'print fcmax,fc,dist
    screenunlock
    ScreenUpdate()
    ''
    '' End of drawing
    ''
    
    '' check for player collision
    if road(px,5)<>0 then
      quit=2
      #ifdef SOUND
      FSOUND_PlaySound(FSOUND_FREE, sample(1))	
      #endif
    end if
    
    ' Clear input buffer
    
    'sleep 1000/30
    
    ''' ---------- TIMER ---------
    
    
    #if DEBUG=1
    locate 10, 1          
    av+=realfps
    av=av/2                       '
    
    if int(realfps)<minf then minf=int(realfps)
    if int(realfps)>maxf then maxf=int(realfps)
    
    color 1,2
    print ""
    print "target : "+str(FPS)
    print "actual : ";int(realfps)
    print "average: ";int(av)
    print "min: ";minf
    print "max: ";maxf	
    print "speed: ";fcmax	
    
    #endif
    
    '' Frame rate control 
    'while (( timer-start)<=(1/FPS))
    'sleep 1
    'wend 
    if timer < (start + oneFrame) then 
      'ScreenUpdate()
      sleep ((start + oneFrame) - timer)* 1000	
    end if
    realfps = 1 / (timer-start)
    start=timer
    ''' ---------- TIMER ---------
    
    
  loop until quit<>0
  
  
  if quit=2 then
    
    '' draw explosion
    for j as integer=0 to 7
      for i as integer=0 to 7
        
        if (rnd*10)>5 then
          block(xpos(px)+i,21+ypos(5)+j, 14) ''
        end if
      next i
    next j
    
    '' draw scores
    blockprint(8,4,"gameover",alpha(),14 )
    blockprint(9,5,"gameover",alpha(),4 )
    
    blockprint(8,14,"distance",alpha(),14 )
    blockprint(9,15,"distance",alpha(),4 )
    
    blockprint(40-len(str(totaldist))*4,24,str(totaldist),alpha(),3 )
    blockprint(41-len(str(totaldist))*4,25,str(totaldist),alpha(),1 )
    
    
    '' update best score
    if totaldist>bestdist then
      bestdist=totaldist
      
      blockprint(8,34,"new best",alpha(),14 )
      blockprint(9,35,"new best",alpha(),3 )
      
      savescore(bestdist)
    else
      blockprint(24,34,"best",alpha(),14 )
      blockprint(25,35,"best",alpha(),4 )
      
      blockprint(40-len(str(bestdist))*4,44,str(bestdist),alpha(),3 )
      blockprint(40-len(str(bestdist))*4,45,str(bestdist),alpha(),1 )			
    end if
    
    
    while inkey <> "": wend
    
    do
      ScreenUpdate()
      sleep 5
    loop until inkey=" " or SpacePressed()
    do
      ScreenUpdate()
      sleep 5
    loop while inkey=" " or SpacePressed()
  end if
  
loop until quit=1

#ifdef SOUND
FSOUND_Close()
#endif


