#define fbc -gen GCC -O 3

#ifdef __FB_NDS__
#define __FB_PRECISE_TIMER__
#define __FB_GFX_NO_GL_RENDER__
#define __FB_GFX_NO_16BPP__
#define __FB_GFX_NO_OLD_HEADER__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
chdir "NitroFiles/"
#endif

sub DrawCircle(pBuff as fb.image ptr,x0 as integer,y0 as integer,radius as integer,iColor as integer)

  dim as integer x = radius
  dim as integer y = 0
  dim as integer radiusError = 1-x
    
  var iW = pBuff->Width, iH = pBuff->Height,iPitch = pBuff->Pitch  
  var pBuffStart = cast(ubyte ptr,pBuff+1),iBuffSz=(iPitch*iH)  
  var pMidPix = pBuffStart+(y0*iPitch)
  
  var q0 = pMidPix-(x*iPitch) ' y0-x 
  var q1 = pMidPix-(y*iPitch) ' y0-y 
  var q2 = pMidPix+(y*iPitch) ' y0+y 
  var q3 = pMidPix+(x*iPitch) ' y0+x 
  
  dim as uinteger iColor4 = (iColor and 255)+(iColor and 255) shl 8
  iColor4 = iColor4+((iColor4) shl 16)
  
  while x >= y
    
    var YA = cuint(y0-y) < iH, YB = cuint(y0+y) < iH
    if YA or YB then      
      var iAmountY = y+y+1, iAmountX = x+x+1
      var iLeftY = x0-y, iLeftX = x0-x    
      if iLeftY < 0 then iAmountY += iLeftY: iLeftY=0
      if iLeftX < 0 then iAmountX += iLeftX: iLeftX=0
      if (x0+y) >= iW then iAmountY -= (x0+y)-(iW-1)
      if (x0+x) >= iW then iAmountX -= (x0+x)-(iW-1)    
      if iAmountY >= 4 then
        if cuint(q0-pBuffStart)<iBuffSz then 'Y Clipping
          memset(q0+iLeftY,iColor,iAmountY) '0
          'dmaFillWords(iColor4,q0+iLeftY,iAmountY)
        end if
        if cuint(q3-pBuffStart)<iBuffSz then 'Y Clipping
          memset(q3+iLeftY,iColor,iAmountY) '3
          'dmaFillWords(iColor4,q3+iLeftY,iAmountY)
        end if
      end if
      if iAmountX > 0 then
        if YA then 'Y Clipping
          memset(q1+iLeftX,iColor,iAmountX) '1
          'dmaFillWords(iColor4,q1+iLeftX,iAmountX)
        end if
        if YB then 'Y Clipping
          memset(q2+iLeftX,iColor,iAmountX) '2
          'dmaFillWords(iColor4,q2+iLeftX,iAmountX)
        end if
      end if
    end if
    
    y += 1: q1 -= iPitch: q2 += iPitch
    if (radiusError<0) then    
      radiusError += 2 * y + 1
    else
      x -= 1: q0 += iPitch: q3 -= iPitch 
      radiusError += 2 * (y - x + 1)
    end if
  
  wend

end sub

screenres 256,192

dim as fb.image ptr pBuff = screenptr+256-sizeof(fb.image)
*pBuff = type((7,0,0),1,256,191,256)

dim as double TMR

screenlock

TMR = timer
for CNT as integer = 0 to 499
  circle pBuff,(128,96),90,12,,,,f
next CNT
printf !"%f\n",(timer-TMR)*1000

TMR = timer
for CNT as integer = 0 to 499
  DrawCircle(pBuff,128,96,90,10)
next CNT
printf !"%f\n",(timer-TMR)*1000

screenunlock

sleep


