#define fbc -gen GCC -O 3

#ifdef __FB_NDS__
#define __FB_NITRO__
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

'#define SlowMotion
#ifndef __FB_NDS__
  static shared as short ifbAtnTab(2048) 'iTabSize
  scope 'Init Table
    const _PI2=6.2831854,_iTabSize = 2048 '~(Radius/1.4) usage
    for CNT as integer = 0 to _iTabSize
      ifbAtnTab(CNT) = atn(CNT/_iTabSize)*(16384/_PI2)
    next CNT
  end scope
  const ITERS = 4999
#else
  const ITERS = 49
#endif

sub DrawCircle(pBuff as fb.image ptr,x0 as integer,y0 as integer,radius as integer,iColor as integer)

  dim as integer x = radius
  dim as integer y = 0
  dim as integer radiusError = 1-x
    
  var iW = pBuff->Width, iH = pBuff->Height,iPitch = pBuff->Pitch  
  var pBuffStart = cast(ubyte ptr,pBuff+1),iBuffSz=(iPitch*iH)  
  var pMidPix = pBuffStart+(y0*iPitch)+(x0)  
  var p0 = pMidPix+(y*iPitch)+x 'x0 + x , y0 + y
  var p1 = pMidPix+(x*iPitch)+y 'x0 + y , y0 + x
  var p2 = pMidPix+(x*iPitch)-y 'x0 - y , y0 + x
  var p3 = pMidPix+(y*iPitch)-x 'x0 - x , y0 + y
  var p4 = pMidPix-(y*iPitch)-x 'x0 - x , y0 - y
  var p5 = pMidPix-(x*iPitch)-y 'x0 - y , y0 - x
  var p6 = pMidPix-(x*iPitch)+y 'x0 + y , y0 - x
  var p7 = pMidPix-(y*iPitch)+x 'x0 + x , y0 - y
   
  #define DrawPixel(N) if cuint(p##n-pBuffStart)<iBuffSz then : *p##N = iColor : end if    
  while x >= y
    if cuint(x0+x) < iW then : DrawPixel(0) : DrawPixel(7) : end if
    if cuint(x0+y) < iW then : DrawPixel(1) : DrawPixel(6) : end if
    if cuint(x0-x) < iW then : DrawPixel(3) : DrawPixel(4) : end if
    if cuint(x0-y) < iW then : DrawPixel(2) : DrawPixel(5) : end if
    y += 1: p0 += iPitch: p1 += 1: p2 -= 1: p3 += iPitch: 
    p4 -= iPitch: p5 -= 1: p6 += 1: p7 -= iPitch
    if (radiusError<0) then    
      radiusError += 2 * y + 1
    else
      x -= 1: p0 -= 1: p1 -= iPitch: p2 -= iPitch: p3 += 1
      p4 += 1: p5 += iPitch: p6 += iPitch: p7 -= 1
      radiusError += 2 * (y - x + 1)
    end if    
  wend

end sub
sub DrawArc(pBuff as fb.image ptr,x0 as integer,y0 as integer,radius as integer,iColor as integer,fStartAng as single,fEndAng as single)

  const _PI2=6.2831854,_iTabSize = 2048

  dim as integer x = radius
  dim as integer y = 0
  dim as integer radiusError = 1-x    
  const sTemp = 16384/_PI2    
  dim as integer iStartAng = (fStartAng*sTemp) and 16383
  dim as integer iEndAng   = (fEndAng*sTemp) and 16383   
  var iW = pBuff->Width, iH = pBuff->Height,iPitch = pBuff->Pitch  
  var pBuffStart = cast(ubyte ptr,pBuff+1),iBuffSz=(iPitch*iH)  
  var pMidPix = pBuffStart+(y0*iPitch)+(x0)
  if iStartAng > iEndAng then iEndAng += 16384
    
  #macro SetOctant(_N,_ANGS,_ANGE,_ALGO)
  if (iStartAng >= (_ANGS) and iEndAng <= (_ANGE)) orelse (iEndAng>= (_ANGS) and iStartAng <= (_ANGE)) then p##_N = _ALGO
  if (iStartAng >= (_ANGS+16384) and iEndAng <= (_ANGE+16384)) orelse (iEndAng>= (_ANGS+16384) and iStartAng <= (_ANGE+16384)) then p##_N = _ALGO  
  #endmacro
  dim as ubyte ptr p0,p1,p2,p3,p4,p5,p6,p7
  SetOctant(0,14336,16383,pMidPix+(y*iPitch)+x) 'x0 + x , y0 + y
  SetOctant(1,12288,14335,pMidPix+(x*iPitch)+y) 'x0 + y , y0 + x
  SetOctant(2,10240,12887,pMidPix+(x*iPitch)-y) 'x0 - y , y0 + x
  SetOctant(3, 8192,10239,pMidPix+(y*iPitch)-x) 'x0 - x , y0 + y
  SetOctant(4, 6144, 8191,pMidPix-(y*iPitch)-x) 'x0 - x , y0 - y
  SetOctant(5, 4096, 6143,pMidPix-(x*iPitch)-y) 'x0 - y , y0 - x
  SetOctant(6, 2048, 4095,pMidPix-(x*iPitch)+y) 'x0 + y , y0 - x
  SetOctant(7,    0, 2047,pMidPix-(y*iPitch)+x) 'x0 + x , y0 - y
 
  #macro DrawPixel(N) 
    if cuint(p##n-pBuffStart)<iBuffSz then 
      if i##N >= iStartAng and i##N <= iEndAng then *p##N = iColor
      if i##N >= (iStartAng-16384) and i##N <= (iEndAng-16384) then *p##N = iColor
    end if
  #endmacro      
  while x >= y    
    var i7 = ifbAtnTab((y*_iTabSize)\x)    
    var i6=4095-i7,i5=i7+4096,i4=8192-i7,i3=i7+8192
    var i2=12288-i7,i1=i7+12288,i0=16383-i7
    if cuint(x0+x) < iW then : DrawPIxel(0) : DrawPIxel(7) : end if    
    if cuint(x0+y) < iW then : DrawPIxel(1) : DrawPIxel(6) : end if    
    if cuint(x0-x) < iW then : DrawPIxel(3) : DrawPIxel(4) : end if
    if cuint(x0-y) < iW then : DrawPIxel(2) : DrawPIxel(5) : end if
    y += 1: p0 += iPitch: p1 += 1: p2 -= 1: p3 += iPitch: 
    p4 -= iPitch: p5 -= 1: p6 += 1: p7 -= iPitch
    if (radiusError<0) then    
      radiusError += 2 * y + 1
      
    else
      x -= 1: p0 -= 1: p1 -= iPitch: p2 -= iPitch: p3 += 1
      p4 += 1: p5 += iPitch: p6 += iPitch: p7 -= 1
      radiusError += 2 * (y - x + 1)      
    end if    
  wend
  
end sub

screenres 256,192

dim as fb.image ptr pBuff = screenptr+256-sizeof(fb.image)
*pBuff = type((7,0,0),1,256,191,256)
dim as double TMR

const PI = 3.1415927,PI180 = PI/180
const PI2 = PI*2,IPI2 = 1/PI2
const _RADIUS_ = 40

do
  
  for OFF as integer = 0 to (360*4)-1
    
    screenlock
    
    line pBuff,(0,0)-(320,240),0,bf    
    TMR = timer
    for CNT as integer = 0 to ITERS
      DrawCircle(pBuff,98,130,_RADIUS_,9)
    next CNT
    draw string pBuff, (4,34),"Mysoft Full Bresenham .: " & cint((timer-TMR)*10000) & "ns",9    
    TMR = timer
    for CNT as integer = 0 to ITERS
      DrawArc(pBuff,118,130,_RADIUS_,10,(0+OFF)*PI180,(359+(OFF/2))*PI180)
    next CNT
    draw string pBuff, (4,4),"Mysoft Bresenham Arc ..: " & cint((timer-TMR)*10000) & "ns",10    
    TMR = timer
    for CNT as integer = 0 to ITERS      
      circle pBuff,(138,130),_RADIUS_,12,(0+OFF)*PI180,(359+(OFF/2))*PI180      
    next CNT
    draw string pBuff, (4,14),"Freebasic Arc .........: " & cint((timer-TMR)*10000) & "ns",12
    TMR = timer
    for CNT as integer = 0 to ITERS
      circle pBuff,(158,130),_RADIUS_,14
    next CNT
    draw string pBuff, (4,24), "FB Full Bresenham .....: " & cint((timer-TMR)*10000) & "ns",14
    
    screenunlock
    
    static as double TMR
    if abs(timer-TMR) > 1 then TMR = timer
    while (timer-TMR) < .05
      sleep 1,1
    wend
    TMR += .05
    if len(inkey) then exit do
    
  next OFF
  
loop
