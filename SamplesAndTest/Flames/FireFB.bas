#define fbc -gen gcc -O 3 -s gui

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
chdir "NitroFiles/"
#endif

const MAXX=256,MAXY=192
const MAXXM1=MAXX-1,MAXYM1=MAXY-1,MAXYM2=MAXY-2

screenres MAXX,MAXY
randomize()

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

type ParticleStruct
  iX as integer
  iY as integer
  iC as integer
  iL as integer
end type

static shared as integer iPlut(4095), iYlut(2047)
for CNT as integer = 0 to MAXYM1
  iYlut(CNT) = MAXX * (MAXYM1 - CNT)
next CNT

const ff = 65 * 6 - 1
static shared iFlut(ff) as integer
for CNT as integer = 0 to ff
  iFlut(CNT) = (CNT\6)-1: if iFlut(CNT) < 0 then iFlut(CNT) = 0
next

const iPC = cint((MAXX*MAXY)*(4500/64000))
const iYMax = MAXY-20, iYmm = (iYmax - 20)
'static shared
static shared tParticle(iPC) as ParticleStruct
for CNT as integer = 1 to iPC
  with tParticle(CNT)
    .iX = int(rnd*MAXX)
    .iL = 20 + (rnd * iYmm)
    .iC = .iL * (rnd + .001) / 3
    .iY = .iC * 3
  end with
next CNT

static shared iRand2(8191) as integer
static shared iRand(255) as integer
dim as double fT = timer
dim as integer iFrame, iR, iR2

for CNT as integer = 0 to 255 'ubound(iRand)
  iRand(CNT) = rnd*6
next CNT
for CNT as integer = 0 to 8191 'ubound(iRand2)
  iRand2(CNT) = int(rnd*MAXX)
next CNT

do
  screenlock
  var PTRR = cast(ubyte ptr,screenptr)  
  iFrame += 1
  dim as integer iMaxh = int(rnd*iYmax)
  for CNT as integer = 1 to iPC    
    with tParticle(CNT)
      PTRR[.iX+ iYlut(.iY)] = 64 - .iC      
      'if particle goes out of sight generate another one
      if .iY >= .iL then
        .iL = 20+(rand() and iYmm): .iC = 0
        .iX = iRand2(iR2) : .iY = 1
        iR2 = (iR2+1) and 8191
      else
        'add some random behavior in horizontal
        var iTX = (.iX and 1) xor 1
        .iX += (iRand(iR) shr iTX) - (3-iTX)        
        'raise particle
        .iY += 1: iR = (iR+1) and 255
        'color is a function of heigth
        .iC = (.iY*64)\.iL
      end if
    end with
  next CNT
  
  'apply fire smoothing, using last row precalc table
  var iY = iYlut(1)
  for iX as integer = 2 to MAXX-3
    iPlut(iX) = PTRR[iX-1+iY]+PTRR[iX+iY]+PTRR[iX+1+iY]
  next
  for iYY as integer = 1 to MAXYM2
    iY = iYlut(iYY)    
    var PTR2 = PTRR+iY+MAXX
    var piP = @iPlut(0)
    for iX as integer = 0 to MAXXM1
      var iT = *piP
      var iT1 = PTR2[-1]+PTR2[0]+PTR2[1]
      *PTR2 = iFlut(*piP + iT1)
      *piP = iT1: PTR2 += 1: piP += 1
    next iX
  next iYY
  'put all to screen
  'printf !"%f \r",(iFrame / (timer - fT))
  line(0,0)-(8*8,8),0,bf
  draw string(0,0),str$(csng(iFrame / (timer - fT))),63
  if iFrame >= 1000 then 
    iFrame \= 10: fT += ((timer-fT)*.9)
  end if
    
  screenunlock  
  
  'sleep 1,1
  'screensync
  
loop until len(inkey$)

