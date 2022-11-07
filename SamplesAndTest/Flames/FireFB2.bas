#define fbc -gen gcc -O 3 -s console -asm intel
'gui

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
const MAXX=256,MAXY=192
type float as single
#else
const MAXX=256,MAXY=192
'const MAXX=1024,MAXY=768
type float as double
#endif
const MAXXM1=MAXX-1,MAXYM1=MAXY-1,MAXYM2=MAXY-2
const iPC = cint((MAXX*MAXY)*(4500/72000))
const iYMax = MAXY-20, iYmm = (iYmax - 20)

screenres MAXX,MAXY
randomize()

static shared as ubyte iPlut(4095)
static shared tParticle(iPC) as ParticleStruct

static as integer iPal(...) = { 0,0,0,0,0,8,2,0,10,10,0,7,18,0,5,26,0,2,32,0,0, _
36,0,0,39,0,0,42,0,0,46,1,0,50,3,0,54,5,0,58,7,0,63,9,0,63,11,0,63,13,0,63,15,0, _
63,17,0,63,19,0,63,21,0,63,23,0,63,25,0,63,27,0,63,29,0,63,31,0,63,33,0,63,35,0, _
63,38,0,63,40,0,63,42,0,63,44,0,63,46,0,63,48,0,63,50,0,63,52,0,63,53,0,63,54,0, _
63,54,0,63,55,0,63,56,0,63,57,0,63,58,0,63,59,0,63,60,0,63,61,0,63,62,0,63,63,1, _
63,63,5,63,63,9,63,63,12,63,63,16,63,63,20,63,63,23,63,63,27,63,63,31,63,63,34, _
63,63,38,63,63,42,63,63,45,63,63,49,63,63,52,63,63,56,63,63,60 }

for CNT as integer = 0 to 191 step 3 'ubound(iPal)
  var iR = cint( iPal(CNT+0)*(255/63) )
  var iG = cint( iPal(CNT+1)*(255/63) )
  var iB = cint( iPal(CNT+2)*(255/63) * 2 )+16
  if iB > 255 then iB = 255
  palette CNT\3, iR,iG,iB
next CNt

#define iYLut(_N) (MAXX*(MAXYM1-(_N)))

'const ff = 65 * 6 - 1
'dim iFlut(ff) as ubyte
'for CNT as integer = 0 to ff
'  iFlut(CNT) = ((CNT)\6): if iFlut(CNT) then iFlut(CNT) -= 1
'next

#define iFlut(_N) ((((_N)) shr 2)+(((_N)) shr 4)+(((_N)) shr 5))
'#define iFlut(_N) (((_N)-5)\6)

for CNT as integer = 1 to iPC
  with tParticle(CNT)
    .iX = int(rnd*MAXX)
    .iL = 20 + (rnd * iYmm)
    .iC = .iL * (rnd + .001) / 3
    .iY = .iC * 3
  end with
next CNT

static shared iRand2(4095) as short
static shared iRand3(4095) as short
static shared iRand(MAXXM1) as short
dim as float fT = timer
dim as integer iFrame, iR, iR2

for CNT as integer = 0 to MAXXM1 'ubound(iRand)
  iRand(CNT) = rnd*6
next CNT
for CNT as integer = 0 to 4095 'ubound(iRand2)
  iRand2(CNT) = int(rnd*MAXX)
  iRand3(CNT) = 20+int(rnd*iYmm)
next CNT

dim as float TMR1,TMR2
dim as integer iMax=0
do
  screenlock  
  var PTRR = cast(ubyte ptr,screenptr)  
  iFrame += 1
  dim as float TMR = timer
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
  var iY = MAXX*(MAXY-1)
  for iX as integer = 0 to MAXX-1
    iPlut(iX) = ((PTRR[iX-1+iY]+PTRR[iX+iY]+PTRR[iX+1+iY]) and (not &h01010101)) shr 1
  next  
  TMR1 += (timer-TMR)
  
  TMR = timer
  var pLine = PTRR+MAXX*(MAXY-1), pLut=@ipLut(0)
  #ifdef __XFB_NDS__  
    var piFlut=@iFlut(0)
    asm
        ldr r8, $pLine
        ldr r9, $pLut
        ldr r10, $piFlut
        mov r11, #191 '(MAXYM2)
      0:
        mov r12, #0
      1:        
        ldrb r4, [r8,#-1]  'r4 = -1
        ldrb r0, [r8,#0]   'r0 =  0
        ldrb r2, [r8,#1]   'r2 =  1
        ldrb r3, [r8,#2]   'r3 =  2
        ldrb r5, [r8,#3]   'r5 =  3
        ldrb r6, [r8,#4]   'r6 =  4
        add r0, r2         'r0 = 0+1
        add r1, r0, r3     'r1 = 0+1+2
        add r3, r5         'r3 = 2+3
        add r2, r3         'r2 = 1+2+3
        add r3, r6         'r3 = 2+3+4
        add r0, r4         'r0 = -1+0+1
        ldrb r5, [r9,#0]   '\
        add r5, r0         '| iFlut(ipLut(iX+0) + iT0)
        ldrb r5, [r10,r5]  '/        
        ldrb r4, [r9,#1]   '  \
        add r4, r1         '  | iFlut(ipLut(iX+1) + iT1)
        ldrb r4, [r10,r4]  '  |
        orr r5,r4,LSL #8   '  /
        ldrb r4, [r9,#2]   '\
        add r4, r2         '| iFlut(ipLut(iX+2) + iT2)
        ldrb r4, [r10,r4]  '|
        orr r5,r4,LSL #16  '  /
        ldrb r4, [r9,#3]   '  \
        add r4, r3         '  | iFlut(ipLut(iX+3) + iT3)
        ldrb r4, [r10,r4]  '  |
        orr r5,r4,LSL #24  '  /
        
        str r5,[r8!],#4
        
        orr r0, r1, LSL #8
        orr r2, r3, LSL #8
        orr r0, r2, LSL #16
        str r0, [r9!], #4
        
        add r12, #4        
        'add r8, #4
        'add r9, #4
        cmp r12, #256
        blo 1b
        sub r8, #512
        sub r9, #256
        subs r11, #1
        bne 0b
    end asm      
  #else    
    static as integer iFrames
    iFrames += 1
    for iYY as integer = MAXYM2 to 0 step -1
      for iX as integer = 0 to MAXXM1 step 4
        #if 0
          var iT0 = (pLine[iX-1]+pLine[iX+0]+pLine[iX+1]) shr 1
          var iT1 = (pLine[iX+0]+pLine[iX+1]+pLine[iX+2]) shr 1
          var iT2 = (pLine[iX+1]+pLine[iX+2]+pLine[iX+3]) shr 1
          var iT3 = (pLine[iX+2]+pLine[iX+3]+pLine[iX+4]) shr 1       
          pLine[iX+0] = iFlut(ipLut(iX+0) + iT0)
          pLine[iX+1] = iFlut(ipLut(iX+1) + iT1)
          pLine[iX+2] = iFlut(ipLut(iX+2) + iT2)
          pLine[iX+3] = iFlut(ipLut(iX+3) + iT3)
          iPlut(iX+0) = iT0
          iPlut(iX+1) = iT1
          iPlut(iX+2) = iT2
          iPlut(iX+3) = iT3
        #else          
          #if 0
            asm            
              mov edi, [pLine]
              mov esi, [pLut]                            
              add edi, [iX]
              add esi, [iX]
              mov eax, [edi-1]
              add eax, [edi+0]
              add eax, [edi+1]
              and eax, (not &h01010101)
              shr eax, 1
              mov edx, [esi]
              add edx, eax
              mov [esi], eax
              mov eax, edx
              mov esi, edx
              and eax, (not &h03030303)
              and esi, (not &h0F0F0F0F)
              and edx, (not &h1F1F1F1F)
              shr eax, 2
              shr esi, 4
              shr edx, 5
              add eax, esi
              add eax, edx
              mov [edi], eax          
            end asm
          #else          
            var iT = ((*cptr(uinteger ptr,pLine+iX-1) + _
            *cptr(uinteger ptr,pLine+iX)+ *cptr(uinteger ptr,pLine+iX+1)) _
            and (not &h01010101)) shr 1
            var iTX = iT+*cptr(uinteger ptr,pLut+iX) 
            *cptr(uinteger ptr,pLut+iX) = iT
            *cptr(uinteger ptr,pLine+iX) = ((iTX and (not &h03030303)) shr 2) + _
            ((iTX and (not &h0F0F0F0F)) shr 4) + ((iTX and (not &h1F1F1F1F)) shr 5)          
          #endif
        #endif        
      next iX
      pLine -= MAXX    
    next iYY
  #endif
  TMR2 += (timer-TMR)
  'put all to screen
  printf !"%f \r",(iFrame / (timer - fT))
  #ifndef __FB_NDS__
  line(0,0)-(9*8+4,16),0,bf
  draw string(4,0),str(csng(1/(TMR1/iFrame))),63
  draw string(4,8),str(csng(1/(TMR2/iFrame))),63
  #endif
  'draw string(0,0),str$(csng(iFrame / (timer - fT))),63
  'if iFrame >= 1000 then 
  '  iFrame \= 10: fT += ((timer-fT)*.9)    
  'end if
    
  screenunlock  
  
  screensync
  'screensync
  'screensync
  
loop until len(inkey$)

