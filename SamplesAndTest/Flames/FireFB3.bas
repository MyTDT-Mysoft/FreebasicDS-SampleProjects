#define fbc -gen gcc -O 3 -s gui -asm intel

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
chdir "NitroFiles/"
#endif

type ParticleStruct
  iX as short
  iY as short
  iC as short
  iL as short
end type

#ifdef __FB_NDS__
const MAXX=256,MAXY=192          '256x192 on DS, with "floats" being 32bit (timer precision)
type float as single
#else
const MAXX=512,MAXY=384         '1024x768 otherwise, "floats" being 64bit (timer precision)
type float as double
#endif
' constants with sizes relatives to screen size 
const MAXXM1=MAXX-1,MAXYM1=MAXY-1,MAXYM2=MAXY-2
const iYMax = MAXY-20, iYmm = (iYmax - 20)
' how many particles? calculated based on pixel count 
const iPC = cint((MAXX*MAXY)*(4500/64000))
static as integer Cons1F = &h1F1F1F1F, Cons03 = (not &h03030303) '<- for inlined asm

' helper macros
#define iYLut(_N) (MAXX*(MAXYM1-(_N)))
#define piLine(_N) cptr(uinteger ptr,pLine)[_N]

screenres MAXX,MAXY
randomize()

' arrays to speed up
static shared as ubyte iPlut(MAXX)              'blurred line base
static shared tParticle(iPC) as ParticleStruct  'particles
static shared iRand2(4095) as short             'random table for X
static shared iRand3(4095) as short             'random table for Y
static shared iRand(MAXXM1) as short            'random table gamma
dim as float TMR1,TMR2,fT
dim as integer iFrame, iR, iR2

' ***** Fire Palette *** (rgb666)
static as integer iPal(...) = { 0,0,0,0,0,8,2,0,10,10,0,7,18,0,5,26,0,2,32,0,0, _
36,0,0,39,0,0,42,0,0,46,1,0,50,3,0,54,5,0,58,7,0,63,9,0,63,11,0,63,13,0,63,15,0, _
63,17,0,63,19,0,63,21,0,63,23,0,63,25,0,63,27,0,63,29,0,63,31,0,63,33,0,63,35,0, _
63,38,0,63,40,0,63,42,0,63,44,0,63,46,0,63,48,0,63,50,0,63,52,0,63,53,0,63,54,0, _
63,54,0,63,55,0,63,56,0,63,57,0,63,58,0,63,59,0,63,60,0,63,61,0,63,62,0,63,63,1, _
63,63,5,63,63,9,63,63,12,63,63,16,63,63,20,63,63,23,63,63,27,63,63,31,63,63,34, _
63,63,38,63,63,42,63,63,45,63,63,49,63,63,52,63,63,56,63,63,60 }

' **** Load palette and random arrays ****
for CNT as integer = 0 to 191 step 3 'Palette
  var iR = cint( iPal(CNT+0)*(255/63) )
  var iG = cint( iPal(CNT+1)*(255/63) )
  var iB = cint( iPal(CNT+2)*(255/63) * 2 )+16
  if iB > 255 then iB = 255
  var iC = (CNT\3)*1.2 '< 1.333 adjust to make for div by 6 imprecision 
  for iC2 as integer = iC to 128
    palette iC2, iR,iG,iB
  next IC2
next CNt
for CNT as integer = 1 to iPC        'Particles
  with tParticle(CNT)
    .iX = int(rnd*MAXX)
    .iL = 20 + (rnd * iYmm)
    .iC = .iL * (rnd + .001) / 3
    .iY = .iC * 3
  end with
next CNT
for CNT as integer = 0 to MAXXM1     'Gamma
  iRand(CNT) = rnd*6
next CNT
for CNT as integer = 0 to 4095       'X/Y random
  iRand2(CNT) = int(rnd*MAXX)
  iRand3(CNT) = 20+int(rnd*iYmm)
next CNT

do
  TMR1= timer 'Start measuring time here
  screenlock 'lock screen framebuffer
  var PTRR = cast(ubyte ptr,screenptr)
  
  ' *** Update/Draw soot particles ***
  dim as integer iMaxh = rnd*iYmax
  for CNT as integer = 1 to iPC    
    with tParticle(CNT)
      PTRR[.iX+ iYlut(.iY)] = 64 - .iC      
      'if particle goes out of sight generate another one
      if .iY >= .iL then
        .iL = iRand3(iR2): .iC = 0 '20+(rnd*iYmm): .iC = 0
        .iX = iRand2(iR2): .iY = 1 
        iR2 = (iR2+1) and 4095
      else
        'add some random behavior in horizontal
        var iTX = (.iX and 1) xor 1
        .iX += (iRand(iR) shr iTX) - (3-iTX)        
        'raise particle
        .iY += 1: iR = (iR+1) and 255
        'color is a function of heigth
        .iC = (.iY shl 6)\.iL
        if cuint(.iC) > 63 then .iC = 63
      end if
    end with
  next CNT
  'apply fire smoothing, using last row precalc table
  'divides by 8, as pre step for the "div by 6" approximation
  var iY = MAXX*(MAXY-2)
  for iX as integer = 0 to MAXX-1
    iPlut(iX) = ((PTRR[iX-1+iY]+PTRR[iX+iY]+PTRR[iX+1+iY]) and (not &h07070707)) shr 3
  next  

  ' ***** SMOOTH the entire screen causing the fire effect using last row as guide *******
  var pLine = PTRR+MAXX*(MAXY-1), pLut=cast(uinteger ptr,@ipLut(0))
  #ifdef __FB_NDS__
    asm ' ******** CODE SPECIFIC FOR DS **********
        'bkpt
        ldr r2, $Cons1F
        ldr r3, $Cons03
        ldr r7, $pLine
        ldr r8, $pLut        
        mov r9, #183         '(MAXYM2-8)
      0:
        orr r9, #0x0FF00000  '(MAXX)
        ldrb r0,[r7,#-1]     'pLine[-1]          
      1:
        ldmia r7, {r4,r5,r6} 'piLine() 0,1,2     
        
        add r0,r4,LSL #8     'piLine(0) shl 8    
        add r0,r4            'piLine(0)          
        add r0,r4,LSR #8     'piLine(0) shr 8    
        add r0,r5,LSL #24    'pIline(1) shl 24   
        mov r1,r2            '0x1F1F1F1F         
        and r1,r0,LSR #3     'shr 3 and ^ (< iT) 
        ldr r0,[r8]          'Temp = *pLut       
        str r1,[r8!],#4      '*pLut = iT         
        add r0,r1            '< iTX              
        mov r1,r0,LSR #3     'iTX shr 3          
        and r1,r2            'and 0x3F3F3F3F     
        add r1,r0            '+ITX               
        and r0,r3            'and (~03030303)    
        add r1,r0,LSR #2     'r1 = A+B+C         
        'str r1,[r7],#0      'piLine(0) = r1     
        
        mov r0,r4,LSR #24    'piLine(1) shr 24   
        add r0,r5,LSL #8     'piLine(1) shl 8    
        add r0,r5            'piLine(1)          
        add r0,r5,LSR #8     'piLine(1) shr 8    
        add r0,r6,LSL #24    'pIline(2) shl 24   
        mov r4,r2            '0x1F1F1F1F         
        and r4,r0,LSR #3     'shr 3 and ^ (< iT) 
        ldr r0,[r8]          'Temp = *pLut       
        str r4,[r8!],#4      '*pLut = iT         
        add r0,r4            '< iTX              
        mov r4,r0,LSR #3     'iTX shr 3          
        and r4,r2            'and 0x3F3F3F3F     
        add r4,r0            '+ITX               
        and r0,r3            'and (~03030303)    
        add r4,r0,LSR #2     'r1 = A+B+C         
        'str r4,[r7],#0      'piLine(0) = r1     
        
        mov r0,r5,LSR #24    'pLine[-1]          
        stmia r7 !,{r1,r4}   'piLine(0-1)=r1,r4  
       
        subs r9, #0x00800000 '4 pixels done      
        bpl 1b               'line done?         
        sub r7, #512         'adjust next line   
        sub r8, #256         'reset pLut         
        add r9, #0x00100000  'clear high on r9   
        subs r9, #1          'one line done      
        bne 0b               'screen done?       
        
    end asm      
  #else
    for iYY as integer = MAXYM2-8 to 0 step -1
      for iX as integer = 0 to MAXXM1 step 8                   
        var iT = (((pLine[-1] or (piLine(0) shl 8)) + _
        piLine(0)+(piLine(0) shr 8)+(piLine(1) shl 24)) shr 3) and &h1F1F1F1F
        var iTX = iT+*pLut: *pLut = iT
        piLine(0) = ((iTX shr 3) and &h1F1F1F1F)+iTX+((iTX and (not &h03030303)) shr 2)
        iT = ((((piLine(0) shr 24) or (piLine(1) shl 8)) + _
        piLine(1)+(piLine(1) shr 8)+(piLine(2) shl 24)) shr 3) and &h1F1F1F1F
        iTX = iT+pLut[1]: pLut[1] = iT
        piLine(1) = ((iTX shr 3) and &h1F1F1F1F)+iTX+((iTX and (not &h03030303)) shr 2)
        pLine += 8: pLut += 2
      next iX
      pLine -= (MAXX+MAXX): pLut -= (MAXX\4)
    next iYY
  #endif
  
  ' *** Sum & Draw FPS ***
  #ifndef __FB_NDS__
    line(0,0)-(8*8,8),0,bf
    draw string(0,0),str$(csng(TMR2)),80
  #else
    printf(!"%f \r",TMR2)
  #endif
  screenunlock  
  fT += (timer-TMR1): iFrame += 1: TMR2 = .96/(fT/iFrame)
  
  ' *** vsync and done ***
  #ifndef __FB_NDS__
  sleep 1,1
  #endif  
  screensync  
  
loop until len(inkey$)

