#define fbc -gen GCC -O 3

#ifdef __FB_NDS__
'#define __FB_NITRO__
'#define __FB_PRECISE_TIMER__
#define __FB_GFX_NO_GL_RENDER__
#define __FB_GFX_NO_16BPP__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
chdir "NitroFiles/"
#endif

const scr_wid=256,scr_hei=192
const mid_wid=scr_wid\2,mid_hei=scr_hei\2
const fScale = scr_hei/512
const PI = atn(1)/45

screenres scr_wid,scr_hei,8

dim as integer X,Y,iCC,RESU,TMP
dim as double DST,ANG,TMR

ANG=0:DST=-(10000\scr_hei)
dim as integer iFirst
line(0,0)-(scr_wid,scr_hei),rgb(0,0,0),bf    
do
  X = mid_wid+sin(PI*ANG)*DST*1.33*fScale
  Y = mid_hei-cos(PI*ANG)*DST*fScale
  'if X < 0 or X > 639 or Y < 0 or Y > 479 then exit do
  if DST < -225 then exit do
  if iFirst=0 then 
    iFirst=1: pset (X,Y),8   
  else
    line -(X,Y),8
  end if    
  
  ANG += (1/2)
  if ANG >= 360 then ANG -= 360
  DST += cos(ANG/10)/1.8
loop    
line(scr_wid*.02,scr_hei*.02)-(scr_wid*.98,scr_hei*.98),8,b
circle(mid_wid,mid_hei),scr_hei*.6,8',,,1/1.33

sleep
 