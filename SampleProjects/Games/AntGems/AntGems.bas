'
' AntGems, a gem elimination puzzle game
' written by Ronja Breitinger and Mysoft
' gfx by vladart(bg), Kenney Vleugels(gems), Carlos Alface(ant)
' sfx by https://opengameart.org/users/subspaceaudio
' bgm by wolfgang
' Date: 12-03-2021
'
#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  '#define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  '#define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
  '#include "Modules\wshelper.bas"
  #include "Modules\fmod.bas"
#else  
  #include "Mytdt\GfxResize.bas"
  #ifndef true
    const true = -1 , false = 0
  #endif
  '#include "fmod.bi"
  #include "MysoftFmod.bi"
  #include "fbgfx.bi"
  '#include "wshelper.bas"
  #include "crt.bi"
  chdir "NitroFiles/"
  #define fbc -s console
#endif
'
#ifdef __FB_NDS__
  #define KeyQuit   -fb.SC_BUTTONSELECT
  #define KeyStart  -fb.SC_BUTTONSTART
  #define KeyX      -asc("k")
  #define KeyA      -fb.SC_BUTTONA
  #define KeyLeft   -fb.SC_BUTTONLEFT
  #define KeyRight  -fb.SC_BUTTONRIGHT
  #define KeyUp     -fb.SC_BUTTONUP
  #define KeyDown   -fb.SC_BUTTONDOWN
#else
  #define KeyQuit   27
  #define KeyStart  32
  #define KeyX      -asc("k")
  #define KeyA      32
  #define KeyLeft   -fb.SC_LEFT
  #define KeyRight  -fb.SC_RIGHT
  #define KeyUp     -fb.SC_UP
  #define KeyDown   -fb.SC_DOWN
#endif
'
const cGridWid = 16 , cGridHei = 10, SZ = 16,  ty = 176
'
dim shared grid(1 to cGridWid, 1 to cGridHei) as byte
dim shared ct(4) as byte = {0, 2, 40, 13, 1}
dim shared as byte cx = cGridWid\2, cy = cGridHei\2
dim shared as long score, broke ',hiscore
dim shared as byte cLeft = 1 , cRight = cGridWid , CheckFall
dim shared as byte level, nextLevel = true, remaining, showTitle = true
dim shared as any ptr gem(1 to 5)
dim shared as any ptr bg, titlebg
dim shared as integer mx, my, mb
'
' // draws the entire screen //
sub fDrawScreen(nextLevel as byte, remaining as byte)
  screenlock
  'background
  if showTitle then 
    put(0, 0), titlebg, pset 
    draw string (39, 29), "A N T", rgb(32, 64, 128)
    draw string (38, 28), "A N T", rgb(128, 64, 0)
    draw string (176, 29), "G E M S", rgb(32, 64, 128)
    draw string (175, 28), "G E M S", rgb(128, 64, 0)
    'draw string (71, 183), "HI-SCORE:"+ right("0000"& hiscore, 5), rgb(32, 64, 128)
    'draw string (70, 182), "HI-SCORE:"+ right("0000"& hiscore, 5), rgb(128, 64, 0)
    screenunlock
    sleep 100,1
    exit sub 'no need to draw things below
  else 
    put(0, 0), bg, pset
  end if
  '
  'diamonds on board
  for y as byte = 1 to cGridHei
    for x as byte = 1 to cGridWid
      if grid(x, y) > 0 then put(-SZ + x*SZ, -SZ + y*SZ), gem(grid(x, y)), pset
    next x
  next y
  '
  'cursor
'  static as ushort uCursor = &b1111000011110000
'  uCursor = (uCursor shl 1) + (uCursor shr 15) 'rotate bits
'  'asm rol word ptr [uCursor], 1 'rotate bits
'  line(-SZ + cx*SZ, -SZ + cy*SZ)-(-1 + cx*SZ, -1 + cy*SZ), rgb(255, 255, 255), b, uCursor
  '
  'stats
  static as fb.image ptr pBlock 
  if pBlock=0 then pBlock = ImageCreate(255-16,10+4,&h0)
  put (8,ty-4),pBlock,alpha,128
  line (8, ty-4)-(255-8, ty+10), rgb(255,255,255), b
  'shadow

  if nextLevel = false then
      draw string (13, ty+1), "SCORE:" + right("0000"& score, 5), rgb(32, 64, 128)
      draw string (113, ty+1), "LVL:" & level,                    rgb(32, 64, 128)
      draw string (165, ty+1), "BLOCKS:" + right("00"& broke, 3), rgb(32, 64, 128)
      'real text
      draw string (12, ty), "SCORE:" + right("0000"& score, 5), rgb(255, 255, 255)
      draw string (112, ty), "LVL:" & level,                    rgb(255, 255, 255)
      draw string (164, ty), "BLOCKS:" + right("00"& broke, 3), rgb(255, 255, 255)
  elseif level > 0 then
      select case remaining
        case 0
          draw string (95, ty+1), "PERFECT!", rgb(32, 64, 128)
          draw string (94, ty), "PERFECT!", rgb(255, 255, 255)
        case 1 to 10
          draw string (113, ty+1), "GOOD!", rgb(32, 64, 128)
          draw string (112, ty), "GOOD!", rgb(255, 255, 255)
        case is > 10
          draw string (79, ty+1), "GAME OVER!", rgb(32, 64, 128)
          draw string (78, ty), "GAME OVER!", rgb(255, 255, 255)
          'reset data, yeah it doesnt belong into draw but ugh..
          showTitle = true
          level = 0
          nextLevel = true
          broke = 0
          score = 0
      end select
  else
    draw string (87, ty+1), "GET READY!", rgb(32, 64, 128)
    draw string (86, ty), "GET READY!", rgb(255, 255, 255)
  end if
  '
  screenunlock
end sub
'
'
'
function CheckGrid(cx as byte, cy as byte) as byte
  var Gem = grid(cx,cy)
  if Gem = 0 then return 0
  if cx > 1        andalso grid(cx - 1, cy) = Gem then return 1
  if cy > 1        andalso grid(cx, cy - 1) = Gem then return 1
  if cx < cGridWid andalso grid(cx + 1, cy) = Gem then return 1
  if cy < cGridHei andalso grid(cx, cy + 1) = Gem then return 1
  return 0
end function
'
'
'
sub ProcessGrid(cx as byte, cy as byte, gem as byte)
  'check if inside bounds
  if cx < 1 orelse cx > cGridWid then exit sub 'if cuint(cx-1) < (12-1) then return 0
  if cy < 1 orelse cy > cGridHei then exit sub
  'check if its correct gem
  if grid(cx, cy) <> gem then exit sub
  'clear the gem
  grid(cx,cy)=0 : broke += 1:remaining -= 1
  'process neighbour gems
  ProcessGrid(cx + 1, cy, gem)
  ProcessGrid(cx - 1, cy, gem)
  ProcessGrid(cx, cy + 1, gem)
  ProcessGrid(cx, cy - 1, gem)
end sub
'
'
'does the check grid, process grid and score/block counting
sub doAction()
  if CheckGrid(cx, cy) then 
    var iOldBroke = broke
    ProcessGrid(cx, cy, grid(cx, cy))        
    score += (broke - iOldBroke) * (broke - iOldBroke)
    'remaining -= broke
    CheckFall = true
  end if
end sub
'
'
'
' ////////////////// M A I N     S T A R T     H E R E ///////////////////////////
'
'
FSOUND_Init(44100, 8, 0)
var pBgmMusic = FSOUND_Sample_Load(FSOUND_FREE,"bgm.wav",FSOUND_LOOP_NORMAL,0,0)

#ifndef __FB_NDS__
  gfx.PreResize()
#else
  gfx.GfxDriver = gfx.gdOpenGL
#endif
screenres 256, 192, 16
#ifndef __FB_NDS__
  gfx.Resize(256*2, 192*2)
  windowtitle "AntGems (C)AntWareZ(TM)"
#else
  'fb_ShowKeyboard()
  'fb.KeyboardIsON = 1
  lcdMainOnBottom()
#endif
'
' // load gfx //
for i as byte = 1 to 5
	gem(i) = imagecreate(16, 16)
  bload "gem"+ str(i) + ".bmp", gem(i)
next i
bg = imagecreate(256, 192): bload "bg.bmp", bg
titlebg = imagecreate(256, 192): bload "title.bmp", titlebg
'

var iChan = FSOUND_PlaySound( FSOUND_FREE , pBgmMusic )
var pStartSound = FSOUND_Sample_Load(FSOUND_FREE, "start.wav", FSOUND_LOOP_OFF or FSOUND_STEREO, 0, 0)
var pWinSound = FSOUND_Sample_Load(FSOUND_FREE, "win.wav", FSOUND_LOOP_OFF, 0, 0)
var pLossSound = FSOUND_Sample_Load(FSOUND_FREE, "loss.wav", FSOUND_LOOP_OFF, 0, 0)
var pFallSound = FSOUND_Sample_Load(FSOUND_FREE, "fall.wav", FSOUND_LOOP_OFF, 0, 0)
'
'
'main loop
do
  if showTitle = false then
      'init new level if it's time for
      if nextLevel then
        fDrawScreen(nextLevel, remaining)
        if level > 0 then var iChanSFX = FSOUND_PlaySound( FSOUND_FREE , pWinSound )
        sleep 2000, 1
        level += 1
        var i = 0
        if level <= 4 then i = level else i = 4
        remaining = cGridWid*cGridHei
        cLeft = 1  : cRight = cGridWid
        'fill the grid with random pieces
        for y as byte = 1 to cGridHei
          for x as byte = 1 to cGridWid
            grid(x, y) = int(rnd * (i+2)) + 1 
          next x
        next y
        nextLevel = false
      end if
  end if

  '
  'draw everything
  fDrawScreen(nextLevel, remaining)

  if showTitle = false then
      '
      'do the falling
      if CheckFall then
        var iDidFall = false , iDidSlide = false
        for x as byte = cLeft to cRight
          for y as byte = cGridHei to 2 step -1    
            if grid(x, y) = 0 andalso grid(x, y - 1) > 0 then 
              swap grid(x, y), grid(x, y - 1): iDidFall = true
            end if
          next y
        next x
        scope
          static as integer iChanSFX
          if iChanSFX then FSOUND_StopSound( iChanSFX )
          iChanSFX = FSOUND_PlaySound( FSOUND_FREE , pFallSound )
        end scope

        'slide blocks towards center if there are gaps
        if iDidFall = false then    
          for x as byte = cLeft to cRight
            if grid(x, cGridHei) = 0 then
              iDidSlide = true
              'sliding sound here
              static as byte iLeftRight: iLeftRight xor = 1
              if iLeftRight then
                for N as byte = x to cLeft + 1 step - 1
                  for y as byte = 1 to cGridHei
                    swap grid(N, y) , grid(N - 1, y)
                  next y
                next N
                cLeft += 1 : exit for
              else
                for N as byte = x to cRight - 1 step 1
                  for y as byte = 1 to cGridHei
                    swap grid(N, y) , grid(N + 1, y)
                  next y
                next N
                cRight -= 1 : exit for
              end if
            end if
          next x
          'check if there are possible moves left
          if iDidSlide = false then
            var iMoves = false
            for x as byte = cLeft to cRight
              for y as byte = 1 to cGridHei
                if CheckGrid(x, y) then iMoves = true: exit for, for
              next y
            next x
            '
            ' no more moves left
            if iMoves = false then 
              select case remaining
                case is > 10
                  nextLevel = false
                  var iChanSFX = FSOUND_PlaySound( FSOUND_FREE , pLossSound )
                case 0
                  score += 2500
              end select
              nextLevel = true
              iMoves = true
            end if
            '
          end if
          '
        end if
        '
        if iDidFall = false andalso iDidSlide = false then CheckFall = false
      end if  
      '
  end if ' //NOT showTitle
  '
  ' // keyboard and mouse handler //  
  var sKey = inkey()
  static as integer OldMX, OldMY, OldMB
  static as integer MX, MY, MB
  dim as integer NX , NY , NB  
  #ifdef __FB_NDS__
    var dWait = timer
    do
      getmouse NX, NY,, NB
      if NB <> -1 andalso (NB<>MB) then
        MX=NX:MY=NY:MB=NB : exit do
      end if
      screensync
    loop until CheckFall orelse abs(timer-dWait) > 1/10
  #else
    getmouse NX, NY,, NB
    if NB <> -1 andalso (NX<>MX or NY<>MY or NB<>MB) then MX=NX:MY=NY:MB=NB
  #endif
  '
  if showTitle = false then
      'while button is pressed calculate the new square position
      if MB <> -1 andalso MY < cGridHei*SZ then
        if (MB and 1) then      
          cx = 1 + MX\SZ
          cy = 1 + MY\SZ
        elseif (OldMB and 1) then
          'otherwise if button is being released trigger the 
          'ButtonReleased flag... to simulate the key
          doAction()
        end if
        OldMB = MB
      end if
  else
    if MB <> -1 andalso (MB and 1) then 
      showTitle = false : randomize()
      var iChanSFX = FSOUND_PlaySound( FSOUND_FREE , pStartSound )
    end if
  end if
  '
  dim as integer iKey = 0
  if len(sKey) <> 0 then 
    'translate keystate
    iKey = cint(sKey[0]) 
    if iKey = 255 then iKey = -sKey[1]
    '
    if showTitle = false then 
        #ifndef __FB_NDS__
          select case iKey
            case KeyQuit, KeyX:   exit do
'            case KeyLeft:   if cx > 1        then cx -= 1
'            case KeyUp  :   if cy > 1        then cy -= 1
'            case KeyRight:  if cx < cGridWid then cx += 1
'            case KeyDown:   if cy < cGridHei then cy += 1
'            case KeyA   :   doAction()
          end select
        #endif
    else
        select case iKey
        #ifndef __FB_NDS__
          case KeyQuit, KeyX:   exit do
        #endif
          case KeyA, KeyStart: showTitle = false: 'play a sound or fade....   
        end select
    end if ' // NOT show title

  end if ' // key handler
  '
  #ifdef __FB_NDS__     
    screensync
    'flip
  #else
    sleep 32, 1
  #endif
loop

'// cleanup audio
FSOUND_StopSound( iChan )
FSOUND_Sample_Free( pBgmMusic )
FSOUND_Sample_Free( pStartSound )
FSOUND_Sample_Free( pWinSound )
FSOUND_Sample_Free( pLossSound )
FSOUND_Sample_Free( pFallSound )
