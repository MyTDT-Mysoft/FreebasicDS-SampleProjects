#define fbc -s gui

#define UseTab
'#define UseResize

'-target dos

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
  #include "crt.bi"
  chdir "NitroFiles/"
  #ifdef __FB_WIN32__
    #include "windows.bi"
    #ifdef UseResize
      #include "MyTDT\gfxresize.bas"
      gfx.PreResize()
      SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS)
    #endif
  #endif
#endif

#include "VoxFire/Voxels3.bi"
#include "fbgfx.bi"

'Height map
dim shared as any ptr HMAP
'Texture map
dim shared as any ptr TMAP
'The buffer
'dim shared as any ptr BUFFER
'Background
'dim shared as any ptr BACK
dim shared as any ptr WEAPON
dim shared as any ptr RAIL(5)
dim shared as any ptr CROSS

#define BPP 8
#define UseFog

#if BPP=32
#define BPPTYPE uinteger
#elseif BPP=16
#define BPPTYPE ushort
#elseif BPP=8
#define BPPTYPE ubyte
#else
#define BPPTYPE ubyte
#error bbad bpp selected
#endif

dim shared as BPPTYPE ptr MYSCR
dim shared as integer TNUM,LOCKD=1

#ifdef UseTables
'Cosine and Sine tables
dim shared as short COST(2048),SINT(2048)
#else
#define COST(AA) cos( AA * M_PI / 1024) * 256
#define SINT(AA) sin( AA * M_PI / 1024) * 256
#endif

const Depth = 128
#ifdef UseFog
const FOG = Depth-32
#else
const FOG = Depth
#endif
const SCALE = 2

#if __FB_DOS__
  const WINX = 320*SCALE,  WINY = 200*SCALE
#elseif __FB_NDS__
  const WINX = 256*SCALE,  WINY = 192*SCALE  
#else
  const WINX = 256*SCALE,  WINY = 192*SCALE  
#endif
const MEDX = WINX shr 1,MEDY = WINY shr 1
const DIFX = WINX/256,DIFY = (WINY/192)*2

'Camera information
'dim shared as integer MEDX,MEDY
dim shared as short ptr GlobalDCOMP '@DCOMP(0)-1
dim shared as integer HEIGHT,ANGY,iMAX,iMouseLock
dim shared as integer ALTI,UseVsync=0,CurrentMap,pDCOMP
dim shared as single POWY,SPD
static shared as uinteger ColorTab(255)
static shared as short MathTab(-1024 to 1023,Depth)

dim shared as byte Table64(127) = { _
01,49,13,61,04,52,16,64, 33,17,45,29,36,20,48,32, _
09,57,05,53,12,60,08,56, 41,25,37,21,44,28,40,24, _
03,51,15,63,02,50,14,62, 35,19,47,31,34,18,46,30, _
11,59,07,55,10,58,06,54, 43,27,39,23,42,26,38,22, _
01,49,13,61,04,52,16,64, 33,17,45,29,36,20,48,32, _
09,57,05,53,12,60,08,56, 41,25,37,21,44,28,40,24, _
03,51,15,63,02,50,14,62, 35,19,47,31,34,18,46,30, _
11,59,07,55,10,58,06,54, 43,27,39,23,42,26,38,22 }


sub Voxels3_Main ()
  
  dim as single UX, UY, ANGLE
  dim as double SNC,FPT,FPL
  dim as single WC,WY,OLDWY,FPC
  dim as byte BOOST
  dim as integer MX,MY,MB,FPS
  dim as integer FRM,PX,WPX
  dim as integer BaseX,BaseY,ButDown
  dim BACKP as integer  
  
  dim as short DCOMP(DEPTH+1)
  GlobalDCOMP = @DCOMP(0)
  
  '//Precalculate sine and cosine  
  InitTables()
  '//Set up player
  UX = &h8000:UY = &h8000
  ANGLE = 2048-600
  
  '//Switch to graphics mode
  Screenres WINX,WINY,BPP,,fb.gfx_high_priority or fb.gfx_no_frame
  
  #ifdef __FB_WIN32__
  
  #endif
  
  dim as string CNUM
  dim as uinteger CUCOR = rgb(128,255,64),CUCNT
  
  #ifndef __FB_NDS__
  Windowtitle "Voxels on Fire - by: Mysoft"  
  #endif
  
  #ifdef __FB_WIN32__
    #ifdef UseResize
      gfx.Resize()
      'dim as hwnd MyWnd
      'screencontrol(fb.get_window_handle,*cast(uinteger ptr,@MyWnd))
      'SetWindowPos(MyWnd,null,16,16,720,576,SWP_NOZORDER)
    #endif
  #endif
  
  TNUM = 1
  
  MYSCR = Screenptr
  'BUFFER = ImageCreate(WINX,WINY,rgb(120,180,240))
  'MYSCR = BUFFER+32
  
  '//Create the map
  InitMap("Ground")
  
  dim as double EVMU
  dim as integer EVFLAG
  
  SNC=timer:FPT=SNC:EVMU=SNC:FPL=timer
  if LOCKD then
    setmouse(MEDX,MEDY,0,1)
  end if
  do
    
    EVFLAG=0
    if (timer-EVMU) >= 1/60 then
      EVMU += 1/60:EVFLAG=1:CUCNT+=1
      'if CUCNT=10 then CUCNT=0:CUCOR xor= &hFFFFFF
    end if
    
    '//Adjust camera height according to height map
    if EVFLAG then
      HEIGHT = peek(ubyte,HMAP+32+(((UY and &hFF00)+((UX and &hFF00) shr 8))))+8      
      if ALTI>HEIGHT then 
        ALTI += POWY '*SPD
        if ALTI > 160 then ALTI = 160: POWY = -1
        if ALTI < HEIGHT then ALTI=HEIGHT
        POWY -= .3
      else
        ALTI = HEIGHT
      end if      
      HEIGHT = (8+ALTI)*DIFY
      
    end if    
    
    '//Clear the buffer
    screenlock       
    
    BACKP = cint(ANGLE and 2047) shr 2
    #if BPP=8
    line (0,0)-(WINX,WINY),200,bf  
    #else
    line (0,0)-(WINX,WINY),rgb(120,180,240),bf  
    #endif
    'for PX = 0 to WINX+512 step 512
    '  put(PX-BACKP,-64),BACK,pset
    'next PX
    
    '//Draw a screen
    DrawView(UX,UY,ANGLE)  
    
    WPX = (WINX*.85)-148*SCALE
    put(WPX,(WINY-76*SCALE)+abs(WY)*SCALE),WEAPON,trans
    put(WPX+59*SCALE,(WINY-64*SCALE)+abs(WY)*SCALE),RAIL(WC),trans  
    WC += 0.30*SPD
    while cint(WC) > 4 
      WC -= 5
    wend
    
    put((WINX shr 1)-5*SCALE,(WINY shr 1)-5*SCALE),CROSS,trans
    
    #if 0
    scope
      dim as integer VX,VY,VX2,VY2
      dim as single TANG  
      view screen (4,4)-(4+128,4+128)  
      VX = ((UX and 65535)/256)
      VY = ((UY and 65535)/256)  
      for TX as integer = -256 to 256 step 256
        for TY as integer = -256 to 256 step 256
          put(68-VX+TX,68-VY+TY),TMAP,alpha,192  
        next TY
      next TX
      TANG = ANGLE/(325.949)+M_PI/2
      VX = sin(TANG)*4: VY = cos(TANG)*4
      VX2 = 68+VX:VY2 = 68-VY
      line(68-VX,68+VY)-(VX2,VY2),CUCOR
      line(VX2,VY2)-(VX2+sin(TANG+M_PI/1.25)*6,VY2-cos(TANG+M_PI/1.25)*6),CUCOR
      line(VX2,VY2)-(VX2+sin(TANG-M_PI/1.25)*6,VY2-cos(TANG-M_PI/1.25)*6),CUCOR    
      view screen
      line(4,4)-(4+128,4+128),rgb(255,128,64),b
    end scope      
    #endif
    
    if UseVsync then screensync
    
    screenunlock
    
    #ifndef __FB_NDS__
      sleep 5,1
    #endif
    FRM += 1: FPS += 1
    SPD = (timer-SNC)/(1/30)  
    SNC = timer    
    if (timer-FPT) >= 1 then       
      printf(!"fps: %1.1f  \r",csng(FPS))
      FPT += 1:FPS=0
    end if
    
    if EVFLAG then
      if WY=OLDWY then WY = (WY*31) shr 5      
      #ifdef __FB_NDS__
      getmouse MX,MY,,MB      
      if (MB and 1) then
        if ButDown = 0 then
          ButDown = 1: BaseX = MX: BaseY = MY
        else
          if MY <> BaseY then            
            ANGY += ((BaseY-MY)) shl 2 '*DIFY*0.5
            if ANGY < -(WINY shl 1) then ANGY = -(WINY shl 1)
            if ANGY > WINY then ANGY = WINY
            BaseY=MY
          end if
          if MX<>BaseX then
            ANGLE = (ANGLE + ((MX-BaseX) shl 2)) and 2047    
            BaseX=MX
          end if
        end if
      else
        ButDown = 0
      end if
      #else
      if LOCKD=1 then    
        Getmouse MX,MY
        if MY<>MEDY then
          ANGY += ((MEDY-MY))*DIFY*0.5
          if ANGY < -(WINY shl 1) then ANGY = -(WINY shl 1)
          if ANGY > WINY then ANGY = WINY
        end if
        if MX<>MEDX then
          ANGLE = (ANGLE + ((MX-MEDX))) and 2047    
        end if   
        setmouse(MEDX,MEDY,0)   
      end if
      #endif
    end if
    OLDWY=WY    
    
    
    #ifdef __FB_NDS__
    #define KeyRun()        (multikey(fb.SC_ButtonL) or multikey(fb.SC_ButtonL))
    #define KeyForward()    (multikey(fb.SC_ButtonUP) or multikey(fb.SC_ButtonX))
    #define KeyBackward()   (multikey(fb.SC_ButtonDown) or multikey(fb.SC_ButtonB))
    #define KeyStrafeLeft() (multikey(fb.SC_ButtonLeft) or multikey(fb.SC_ButtonY))
    #define KeyStrafeRight()(multikey(fb.SC_ButtonRight) or multikey(fb.SC_ButtonA))
    #define KeyAbort()      (0)
    #define KeyJump()       (multikey(fb.SC_ButtonR))
    #define KeyChangeVsync()(fb.SC_ButtonSelect)
    #define KeyChangeMap()  (fb.SC_ButtonStart)
    #else
    #define KeyRun()        (multikey(fb.SC_LSHIFT) or multikey(fb.SC_RSHIFT))
    #define KeyForward()    (multikey(fb.SC_W))
    #define KeyBackward()   (multikey(fb.SC_S))
    #define KeyStrafeLeft() (multikey(fb.SC_A))
    #define KeyStrafeRight()(multikey(fb.SC_D))
    #define KeyAbort()      (multikey(fb.SC_ESCAPE))
    #define KeyJump()       (multikey(fb.SC_SPACE))
    #define KeyChangeVsync()(asc("v"))
    #define KeyChangeMap()  (13)
    #endif
    
    if EVFLAG then
      do
        dim as string Key = inkey$  
        if len(Key) then
          dim as integer KeyCode = any
          if len(Key) > 1 then KeyCode = Key[1] else KeyCode = Key[0]
          select case KeyCode          
          case KeyChangeVsync()
            UseVsync xor= 1
          case KeyChangeMap()
            CurrentMap xor= 1
            screenlock
            if CurrentMap then
              InitMap("Earth")        
            else
              InitMap("Ground")
            end if    
            screenunlock
          case 9
            LOCKD xor= 1: SetMouse(MEDX,MEDY,1-LOCKD,LOCKD)
          end select
          if KeyAbort() or Key[1] = asc("k") then exit do,do
        else
          exit do
        end if
      loop
      
      if KeyJump() then
        POWY=7:ALTI += 1
      end if
      
    end if
    
    BOOST = 1-KeyRun()     
    
    if KeyForward() then '//move forward
      WY += SPD*(BOOST/2)
      if WY >= 16 then WY -= 32
      UX += (COST(ANGLE)*SPD*BOOST)
      UY += (SINT(ANGLE)*SPD*BOOST)
    elseif KeyBackward() then '//move backward 
      WY -= SPD*(BOOST/2)
      if WY <= -16 then WY += 32
      UX -= (COST(ANGLE)*SPD*BOOST)
      UY -= (SINT(ANGLE)*SPD*BOOST)
    end if
    if KeyStrafeLeft() then '//turn left
      UX -= (COST((ANGLE+512) and 2047)*SPD*BOOST)
      UY -= (SINT((ANGLE+512) and 2047)*SPD*BOOST)
      elseif KeyStrafeRight()then '//turn right
      UX += (COST((ANGLE+512) and 2047)*SPD*BOOST)
      UY += (SINT((ANGLE+512) and 2047)*SPD*BOOST)
    end if
    
  loop
end sub
' **************************************************************
' ********************* SUBS AND FUNCTIONS *********************
' **************************************************************

sub DrawView(DVX as integer,DVY as integer,DANG as integer)  
  dim as integer DVA=DANG+1888,I '(DANG+I\PDIFX+1888)
  dim as ubyte ptr pHEI = HMAP+32
  dim as BPPTYPE ptr pPIX = TMAP+32
  dim as integer O,H,Y1,LC,LY,LTY
  dim as integer OTX,OTY,NTX,NTY
  
  var pDComp = GlobalDCOMP
  
  #define FineRes
  #ifdef FineRes  
  #define ShiftRes 0
  #define IncRes 1
  #define TypeRes ubyte
  #else
  #define ShiftRes 2
  #define IncRes 4
  #define TypeRes uinteger
  #endif
  
  #ifdef UseFog  
  type StateColumnStruct
    pScr as any ptr
    Tx as ushort
    Ty as ushort    
    MinY as ushort
  end type  
  static as StateColumnStruct StateColumn(WINX shr ShiftRes)
  #endif
  
  static as integer iSwap=0
  'iSwap = (iSwap+5) and 63
  iSwap = (((DANG shr 2)*3)+((ANGY shr 3)*12)) and 63
  'iSwapB += 27
  
  
  for I = 0 to (WINX-1) step IncRes
    '//Calculate ray angle depending on view angle
    DVA = ((DVA+IncRes) and 2047)
    'DVA=(DANG+1888+(I shl 1)) and 2047'
    '//Cast the ray
    
    dim as integer DELTAX=COST(DVA),DELTAY=SINT(DVA),P,D
    dim as integer MINY=WINY-1,TX=DVX,TY=DVY
    
    #ifdef __FB_NDS__
      dim as typeof(MYSCR) pScr = MYSCR+(((MINY) shl 8)+I)    
    #else
      dim as typeof(MYSCR) pScr = MYSCR+(((MINY)*WINX)+I)    
    #endif
    
    'if iSwap then TX+=DELTAX shr 1:TY+=DELTAY shr 1: D += 1
    #if 0
      asm
        mov edi,[pSCR]
        _doBegin_:            'do
        mov eax,[TX]             '\
        mov esi,[TY]             '| TX += DELTAX: TY += DELTAY
        add eax,[DeltaX]         '|
        add esi,[DeltaY]         '|
        mov [TX],eax             '|
        mov [TY],esi             '/
        and eax,&hFF00             '\
        and esi,&hFF00             '| O = ((TY and &hFF00) or _ 
        shr eax,8                  '| ((TX and &hFF00) shr 8))
        or esi,eax                 '/
        inc dword ptr [D]            '\ D += 1
        mov eax, [pHei]                        '\
        movzx eax, byte ptr [eax+esi]          '|
        sub eax, [HEIGHT]                      '|
        add eax, 512                           '|
        mov ecx, [D]                           '| MathTab(pHEI[O]-HEIGHT,D)+ANGY
        sal eax, 8                             '|
        movsx ebx, word ptr [MathTab+ecx*2+eax]'|
        add ebx, [ANGY]                        '/
        cmp ebx,[MINY]            '\ if Y1 <= MINY then
        jg _EndIfY1_              '/
        xor eax,eax                 '\
        test ebx,ebx                '| LY=Y1
        mov edx,ebx                 '|
        mov ecx,[MINY]              '| if LY<0 then LY=0
        cmovs ebx,eax               '|
        sub edx,1                   '| LTY=MINY-LY:MINY = Y1-1
        sub ecx,ebx                 '|
        mov [MINY],edx              '|
        js _EndAsm_                 '/
        mov eax,[pPIX]                '\ 
        movzx ebx, byte ptr [eax+esi] '| LC = pPIX[O]
        movzx eax, byte ptr [eax+esi] '|
        shl ebx,8                     '| LC = LC or (LC shl 8)
        or eax,ebx                    '|
        mov ebx,eax                   '| LC = LC or (LC shl 16)
        shl eax,16                    '|
        or eax,ebx                    '/
        _ForLTYBegin_:              'for LTY=LTY to 0 step-1
        mov [edi],eax             '\
        sub ecx,1                 '| *cptr(uinteger ptr,pSCR) = LC: pSCR -= 256
        lea edi, [edi-256]        '/
        jns  _ForLTYBegin_      ' next LTY
        _EndIfY1_:                ' endif
        cmp dword ptr [MINY], 0
        jl _EndAsm_
        cmp dword ptr [D],(DEPTH)   '\ loop while (D < DEPTH)
        jl _doBegin_                '/
        _EndAsm_:
      end asm
    #else
      do      
        TX += DELTAX : TY += DELTAY
        D += 1: pDComp += 1 '//New distance
        O = (((TY and &hFF00)) or ((TX and &hFF00) shr 8)) '//Calculate offset into map
        
        #ifdef UseTab
          Y1 = MathTab((pHEI[O]-HEIGHT),D)+ANGY
        #else
          H = ((pHEI[O])-HEIGHT) shl (5+4)      
          Y1 = (*pDComp+ANGY)-(H\(D shl 3)) '(H\D) '//Calculate height      
        #endif
        '
        if Y1 <= MINY then
          LY=Y1: LC = pPIX[O] 'ColorTab(pPIX[O])
          #if IncRes=4
          LC = LC or (LC shl 8):LC = LC or (LC shl 16)
          #endif
          if LY<=0 then 'LY=0 'LY and= LY>= 0       
            for LTY=MINY to 0 step -1           
              *cptr(TypeRes ptr,pSCR) = LC: pSCR -= WINX
            next LTY
            D=DEPTH: exit do
          end if
          for LTY=MINY to LY step -1           
            *cptr(TypeRes ptr,pSCR) = LC: pSCR -= WINX
          next LTY
          MINY = Y1-1
        end if
      loop while (D < FOG)
    #ifdef UseFog
    if D = DEPTH then
      StateColumn(I shr ShiftRes).pScr = 0
    else
      with StateColumn(I shr ShiftRes)
        .pScr = pScr        
        .Tx = TX+rnd
        .Ty = TY
        .MinY = MinY
      end with
    end if
    #endif
    #endif
  next I 
  
  #ifdef UseFog
  DVA=DANG+1888
  for I = 0 to (WINX-1) step 1
    DVA = ((DVA+1) and 2047)
    with StateColumn(I shr ShiftRes)    
      if .pScr then
        dim as integer DELTAX=COST(DVA),DELTAY=SINT(DVA),P,D=FOG-1
        dim as integer MINY=.MinY,TX=.Tx,TY=.Ty
        #if IncRes=4
        dim as typeof(MYSCR) pScr = .pScr+(i and 3)
        #else
        dim as typeof(MYSCR) pScr = .pScr
        #endif
        do while (D < DEPTH)
          TX += DELTAX: TY += DELTAY
          O = (((TY and &hFF00)) or ((TX and &hFF00) shr 8))
          D += 1: Y1 = MathTab((pHEI[O]-HEIGHT),D)+ANGY          
          if Y1 <= MINY then
            LY=Y1: LC = pPIX[O]
            dim as ubyte ptr pTab = @Table64((((I+iSwap) and 7) shl 3))
            dim as integer iFOG = ((D-FOG) shl 1)
            if LY<=0 then 
              for LTY=MINY to 0 step -1
                if pTab[LTY and 7] > iFOG then
                  *cptr(ubyte ptr,pSCR) = LC
                end if
                pSCR -= WINX
              next LTY
              exit do
            end if
            for LTY=MINY to LY step -1
              if pTab[LTY and 7] > iFOG then
                *cptr(ubyte ptr,pSCR) = LC
              end if
              pSCR -= WINX
            next LTY
            MINY = Y1-1        
          end if    
        loop
      end if
    end with
  next I
  #endif
  
end sub

sub ScaleImage(byref IMG as any ptr )
  dim as any ptr TMP
  dim as integer SCA = Scale-1,COR
  with *cptr(fb.image ptr,IMG)
    TMP = ImageCreate(.Width*Scale,.Height*Scale,0)  
    for Y as integer = 0 to .Height-1
      for X as integer = 0 to .Width-1
        COR = point(X,Y,IMG)
        line TMP,(X*Scale,Y*Scale)-(X*Scale+SCA,Y*Scale+SCA),COR,bf
      next X
    next Y
  end with
  ImageDestroy(IMG)
  IMG=TMP
end sub  

function Pload(FileName as string,byref Buffer as any ptr,ForceBPP as integer=0) as integer
  dim as integer pfile = freefile()
  dim as integer X,Y
  if open(Filename for binary access read as #pfile) then
    printf("Failed to open %s",Filename)
    return 0
  end if  
  
  get #pfile,19,X
  get #pfile,,Y
  close #pfile
  if (X and 3) then X = (X or 3)+1  
  if (Y and 3) then Y = (Y or 3)+1  
  
  if Buffer then ImageDestroy(Buffer):Buffer=0
  if ForceBPP then
    Buffer=ImageCreate(X,Y,,BPP)
  else
    Buffer=ImageCreate(X,Y)
  end if
  bload Filename,Buffer
  return 1
  
end function

sub InitMap(MAP as zstring ptr)
  
  dim as integer COUNT
  dim as string TMP
  static as integer INIT
  
  'TMP = "Grap/backc.png"
  'pload(@TMP,BACK)
  
  if INIT = 0 then
    INIT=1
    TMP = "Graph/Railgun.bmp"
    pload(TMP,WEAPON)': ScaleImage(WEAPON)      
    for COUNT = 0 to 4
      'RAIL(COUNT) = ImageCreate(36,27)
      TMP = "Graph/Rail"+str$(COUNT)+".bmp"
      pload(TMP,RAIL(COUNT))':ScaleImage(RAIL(COUNT))
    next COUNT  
    'CROSS = ImageCreate(9,9)
    TMP = "Graph/Cross.bmp"
    pload(TMP,CROSS)':ScaleImage(CROSS)
  end if
  
  if HMAP then ImageDestroy(HMAP):HMAP=0
  TMP = "Maps/"+*MAP+".Hei.bmp"
  pload(TMP,HMAP)
  if TMAP then ImageDestroy(TMAP):TMAP=0
  TMP = "Maps/"+*MAP+".bmp"
  pload(TMP,TMAP)  
  
end sub  

'//This void calculates some lookup table
sub InitTables()
  
  dim as uinteger A
  dim as single RESULT
  
  dim as short DCOMP(DEPTH+1)
  GlobalDCOMP = @DCOMP(0)
  
  #ifdef UseTables
  for A = 0 to 2047
    '//Precalculate cosine
    RESULT = cos( A * M_PI / 1024) * 256
    COST(A) = RESULT
    '//and sine
    RESULT = sin (A * M_PI / 1024) * 256
    SINT(A) = RESULT
  next A
  #endif
  
  '//Precalculate distance compensation table  
  for A = 1 to DEPTH+1
    GlobalDCOMP[A-1] = ((1000/A)+MEDY)
  next A
  
  'for CNT as integer = 1 to Depth+1
  '  DivMath(CNT) = 4294967295/(CNT shl 3)
  'next CNT
  
  for CNT as integer = 0 to 255
    ColorTab(CNT) = CNT+(CNT shl 8)+(CNT shl 16)+(CNT shl 24)
  next CNT
  
  for CNT as integer = -512 to 511
    for CN2 as integer = 1 to Depth
      dim as integer H = CNT shl (5+4)
      dim as integer Y1 = GlobalDCOMP[CN2]-(H\(CN2 shl 3))      
      MathTab(CNT,CN2) = Y1
    next CN2
  next CNT
  
  
end sub

function Shade(COR as uinteger,PERCENT as integer) as uinteger
  'if PERCENT < 0 then PERCENT = 0
  'if PERCENT > 100 then PERCENT = 100
  dim as integer R,G,B,RR,GG,BB
  
  R =(COR shr 16) and 255
  RR = ( R / 100 ) * PERCENT
  RR = RR + ( 1.2 ) * (100 - PERCENT)
  
  G = (COR shr 8) and 255
  GG = ( G / 100 ) * PERCENT
  GG = GG + ( 1.8 ) * (100 - PERCENT)
  
  B = COR and 255
  BB = ( B / 100 ) * PERCENT
  BB = BB + ( 2.4 ) * (100 - PERCENT)
  
  return rgb(RR,GG,BB)
  
end function

Voxels3_Main()
