#include once "fbgfx.bi"

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
lcdMainOnBottom()
#else
#include "crt.bi"
chdir "NitroFiles/"
open cons for output as #99
#define debugout 99
#endif

#ifdef __FB_NDS__
const ScrX = 256, ScrY = 192
#else
const ScrX = 256, ScrY = 192
#endif
const as integer MaxDots = sqr(ScrX*ScrY)*2
const as integer LightLen = ScrY/2
const as integer LightStep = LightLen/8
const LightDivisor = 1/(LightLen/10)

const PI = 3.141592/180
const rPI = 1/PI

type DotsType
  X as short
  Y as short
end type

dim shared as DotsType Dots(MaxDots)
dim shared as short AtnTab(-ScrX*32 to ScrX*32)
dim shared as byte ColorTab(128*128)
dim shared as any ptr scrptr 

scope  
  dim as single Temp = -ScrX*32*(1/32)
  for CNT as integer = -ScrX*32 to ScrX*32
    AtnTab(CNT) = atn(Temp)*rPI
    Temp += 1/32
    if (CNT and 2047)=0 then printf "."
  next CNT    
  for Y as integer = 0 to 127
    var YLine = Y shl 7, YPower = Y*Y
    for X as integer = 0 to 127
      ColorTab(YLine+X) = sqr(X*X+YPower)*(4*(1/(LightLen/8)))
    next X
    if (Y and 15)=0 then printf "."
  next Y 
end scope

screenres ScrX,ScrY
printf "."

for CNT as integer = 0 to MaxDots
  with Dots(CNT)
    .X = 2+(rnd*(ScrX-5))
    .Y = 2+(rnd*(ScrY-5))
  end with
  if (CNT and 255)=0 then printf "."
next CNT


dim as double TMR
dim as integer Angle,fps
dim as integer PosX = ScrX shr 1, PosY = ScrY shr 1
dim as integer fPosX = PosX shl 8,fPosY = PosY shl 8

for CNT as integer = 1 to 16
  palette CNT+15,0,(CNT*16)-1,0
  palette CNT+31,(CNT*8)-1,(CNT*11)-1,(CNT*14)-1
next CNT

#if 1 'def __FB_NDS__
dim as byte ptr MyIMG = allocate(((LightLen*2)^2)*2)
scope  
  dim as byte ptr Light = MyIMG
  for Y as integer = -LightLen to LightLen-1
    var YY = Y*Y
    for X as integer = -LightLen to LightLen-1
      dim as integer Pix = sqr(YY+X*X)
      if Pix <= LightLen then
        dim as single A = (Pix*LightDivisor)
        dim as integer B = cint(A+rnd)
        Pix = 42-B: if Pix<32 then Pix = 32
        Light[0] = Pix
        'Pix = (atan2(Y,X)*rPI)
        if X then
          Pix = AtnTab((Y shl 5)\X)        
          if X < 0 then 
            if Y >= 0 then Pix = 180-abs(Pix)
            if Y < 0 then Pix = -180+abs(Pix)
          end if        
        else
          if Y >=0 then Pix = 90 else Pix = -90
        end if
        Light[1] = Pix shr 1
        Light += 2
      else
        Light[0] = cbyte(248): Light += 2
      end if
    next X
    if (Y and 15)=0 then printf "."
  next Y  
end scope
#endif

do  
  screenlock    
  scrptr = screenptr
  
  static as single Flt
  Flt += .05: if Flt >= .5 then Flt -= .5
  
  for CNT as integer = 1 to 16    
    palette CNT+31,((CNT+Flt+rnd*.5)*8)-1,((CNT+Flt+rnd*.5)*11)-1,((CNT+Flt+rnd*.5)*14)-1
  next CNT

  
  memset(scrptr,0,(ScrX*ScrY)-1)
  
  static as integer MX,MY,MB
  dim as integer NX,NY,NB
  getmouse NX,NY,,NB
  if NB <> -1 then
    MX = NX: MY = NY
  end if  
  
  PosX = fPosX shr 8: PosY = fPosY shr 8
  
  dim as integer Angle = atan2((MY-PosY),(MX-PosX))*rPI
  if Angle > 180 then Angle -= 180
  if Angle < -180 then Angle += 180
  printf(!"%i   \r",Angle)
  
  #if 1 'def __FB_NDS__
  scope    
    dim as byte ptr pLight = MyIMG    
    dim as integer StartX = PosX-LightLen, StartY = PosY-LightLen
    dim as integer EndX = StartX+((LightLen*2)-1), EndY = StartY+((LightLen*2)-1)
    dim as integer Pitch=LightLen*2,LineCount=LightLen*2
    if abs(Angle)<=60 then 
      pLight += (LightLen*2): Pitch -= LightLen: StartX += LightLen
    end if
    if abs(Angle)>=120 then 
      Pitch -= LightLen: EndX -= LightLen
    end if
    if Angle < -30 and Angle > -150 then 
      LineCount -= LightLen: endY -= LightLen
    end if
    if Angle > 30 and Angle < 150 then 
      pLight += LightLen*(LightLen*4):StartY += LightLen: LineCount -= LightLen
    end if
    if EndX >= ScrX then Pitch -= ((EndX-ScrX)+1)
    if EndY >= ScrY then LineCount -= ((EndY-ScrY)+1)
    if StartX < 0 then pLight -= StartX*2: Pitch += StartX: StartX = 0
    if StartY < 0 then pLight -= (StartY*(LightLen*4)): LineCount += StartY: StartY = 0    
    dim as ubyte ptr pScr = scrptr+StartY*ScrX + StartX      
    dim as integer iSeed = rnd*1023

    #ifdef __FB_NDS__
    asm      
      ldr r7, $pScr
      ldr r0, $LineCount
      ldr r1, $Pitch
      ldr r2, $pLight
      ldr r6, $angle      
      0:
      mov r3, r2
      mov r4, r1
      mov r8, r7
      1:
      ldrsb r5, [r3,#1]      
      subs r5, r6, r5, asl #1
      mvnmi r5, r5      
      addmi r5, #1
      cmp r5, #328
      bgt 3f
      cmp r5, #30
      bgt 2f      
      3:
      ldrb r5, [r3]
      strb r5, [r8]
      2: add r3, #2
      add r8,#1
      subs r4,#1
      bne 1b
      add r7, #256
      add r2, #(96*4)
      subs r0, #1
      bne 0b      
    end asm      
    #else
    for Y as integer = 0 to LineCount-1
      dim as byte ptr pLine = pLight
      for X as integer = 0 to Pitch-1
        dim as short Temp = cint(pLine[1]) shl 1
        Temp = abs(Angle-Temp)
        if Temp <= 30 or Temp >= 330 then
          pSCR[X] = *pLine
        end if
        pLine += 2
      next X
      pSCR += ScrX: pLight += (LightLen*4)
    next Y
    #endif
    
  end scope  
  #else
  scope
    dim as single ALow = (Angle-30)*PI
    dim as single AHigh = (Angle+30)*PI 
    dim as short oX,oY
    static as integer RadX
    
    if ALow < 0 then ALow += PI*360
    if AHigh < 0 then AHigh += PI*360
    ALow = (PI*360)-ALow: AHigh = (PI*360)-AHigh 
    
    RadX += 1:if RadX > (LightStep-2) then RadX = 0
    oX = cos(Angle*PI)*8: oY = sin(Angle*PI)*8
    
    for Rad2 as integer = LightLen to LightStep step -LightStep
      dim as integer Rad = Rad2-rnd*RadX
      if Rad < 16 then Rad = 16
      var Cor = 42-(Rad*LightDivisor)
      circle(PosX,PosY),Rad,Cor,-AHigh,-ALow,,f
      circle(PosX,PosY),Rad-1,Cor,-AHigh,-ALow,,f     
      paint(PosX+oX,Posy+oY),Cor,Cor                  
    next Rad2
    
  end scope
  #endif
  
  for CNT as integer = 0 to MaxDots
    with Dots(CNT)
      
      dim as integer dfX = .X-PosX, dfY = .Y-PosY, Temp = Angle
      if dfX then         
        Temp -= AtnTab((dfY shl 5)\dfX)
        if dfX < 0 then Temp = 180-abs(Temp)
      else
        if dfy > 0 then Temp -= 90 else Temp += 90
      end if      
      
      dim as integer Cor
      dfX = abs(dfX): dfY = abs(dfY)
      if abs(Temp) <= 31 and dfX < 512 and dfY < 512 then 
        var TableOff = ((dfY shr 2) shl 7)+(dfX shr 2)
        Cor = 31-ColorTab(TableOff)
      end if
      if Cor < 17 then Cor = 17
      dim as ubyte ptr Dot = scrptr+.Y*ScrX+.X
      Dot[-1] = Cor: Dot[+1] = Cor: *Dot = Cor
      Dot[-ScrX] = Cor: Dot[+ScrX] = Cor      
      
    end with
  next CNT
  
  for CNT as integer = 0 to 360 step 36
    dim as integer PX = PosX+sin(CNT*PI)*5
    dim as integer PY = PosY+cos(CNT*PI)*5
    dim as ubyte ptr pDot = scrptr+PY*ScrX+PX
    #define Dot(X,Y) pDot[Y*ScrX+X] = 15
    Dot(-4,-4): Dot(-2,-4): Dot(-0, -4): Dot(2,-4): Dot(4, -4)
    Dot(-3,-2): Dot(-1,-2): Dot(+1, -2): Dot(3,-2): Dot(5, -2)
    Dot(-4,-0): Dot(-2,-0): Dot(-0, -0): Dot(2,-0): Dot(4, -0)
    Dot(-3,+2): Dot(-1,+2): Dot(+1, +2): Dot(3,+2): Dot(5, +2)
    Dot(-4,+4): Dot(-2,+4): Dot(-0, +4): Dot(2,+4): Dot(4, +4)    
  next CNT
  
  #ifdef __FB_NDS__
  static as single LastRelease
  static as integer DoubleClick  
  if NB=0 then 
    if DoubleClick=1 then DoubleCLick = -1
    if DoubleClick=-2 then DoubleClick = 0: LastRelease=timer    
  end if
  if NB>0 then
    if DoubleClick=-1 then
      DoubleClick=-2
    elseif DoubleClick=0 then
      dim as single Temp = timer-LastRelease   
      if Temp < 1/7 then DoubleClick = 1 else DoubleClick=-2
    end if    
  end if  
  #define KeyForward() (multikey(fb.SC_ButtonL) or multikey(fb.SC_ButtonR) or DoubleClick>0)
  #else
  #define KeyForward() (NB>0)  
  #endif
  
  if KeyForward() then  
    if abs(PosX-MX) > 8 or abs(PosY-MY) > 8 then
      fPosX += cos(Angle*PI)*384
      fPosY += sin(Angle*PI)*384
      if fPosX < 10*256 then fPosX = 10*256
      if fPosY < 10*256 then fPosY = 10*256
      if fPosX > (ScrX-11)*256 then fPosX = (ScrX-11)*256
      if fPosY > (ScrY-11)*256 then fPosY = (ScrY-11)*256
    end if
  end if
  
  #ifdef __FB_NDS__
  #define KeyUp()    (multikey(fb.SC_ButtonX) or multikey(fb.SC_ButtonUP)) 
  #define KeyDown()  (multikey(fb.SC_ButtonB) or multikey(fb.SC_ButtonDOWN))
  #define KeyLeft()  (multikey(fb.SC_ButtonY) or multikey(fb.SC_ButtonLEFT))
  #define KeyRight() (multikey(fb.SC_ButtonA) or multikey(fb.SC_ButtonRIGHT))
  #else
  #define KeyUp()    multikey(fb.SC_UP)  
  #define KeyDown()  multikey(fb.SC_DOWN)
  #define KeyLeft()  multikey(fb.SC_LEFT)
  #define KeyRight() multikey(fb.SC_RIGHT)
  #endif
  
  if KeyUp()    and PosY>10        then fPosY -= 384
  if KeyDown()  and PosY<(ScrY-11) then fPosY += 384
  if KeyLeft()  and PosX>10        then fPosX -= 384
  if KeyRight() and PosX<(ScrX-11) then fPosX += 384
  
  screenunlock
  
  #ifdef __FB_NDS__
  screensync
  #else      
  static as double tSync 
  if abs(timer-tSync) > 1 then
    tSync = timer
  else
    while (timer-tSync) < 1/60
      sleep 1,1
    wend
    tSync += 1/60
  end if
  #endif
  
  FPS += 1
  if (timer-TMR) >= 1 then
    TMR = timer
    printf(!"                fps: %i  \r",FPS)
    FPS = 0
  end if
  
loop until inkey$ = chr$(27)
