#ifdef __FB_NDS__
  '#define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  '#define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
  #include "Modules\wshelper.bas"
#else
  #include "fbgfx.bi"
  #include "crt.bi"
  chdir "NitroFiles/"
#endif


#ifdef __FB_NDS__
gfx.GfxDriver = gfx.gdOpenGL
#endif

#include "Modules/gfxUtil.bas"

gfx.GfxDriver = gfx.gdOpenGL
screenres 256,192,8

dim as any ptr MyImage = ImageCreate(256,256)
dim as integer MyTexture 
dim as any ptr MyPal = callocate(256*4),SwPal = callocate(256*4)
dim as any ptr Ying(15)

for CNT as integer = 0 to 15
  Ying(CNT) = ImageCreate(58,48)
next CNT

bload "test.bmp",MyImage,MyPal

for CNT as integer = 0 to 15
  dim as string Temp
  Temp = "0"+str$(CNT)
  bload "Ying"+right$(Temp,2)+".bmp",Ying(CNT),SwPal
next CNT

palcopy SwPal,MyPal,128,255

dim as double TMR
static as integer Frame

do
  
  dim as integer VX = 255
  dim as integer XX = VX shl (12-8)
  
  dim as integer MX,MY
  
  getmouse MX,MY
  
  Frame += 1
  if (Frame and 3) = 0 then    
    palrotate MyPal,1,54,63
    palrotate MyPal,1,67,79   '67,79
    palrotate MyPal,1,83,95   '83,96
    palrotate MyPal,1,99,111  '99,111
    palrotate MyPal,1,113,127 '113,127 
  end if
  
  palset MyPal,0,255
  
  Put (0,0),MyImage,pset
  put (MX-29,MY-24),Ying((Frame and 31) shr 1),trans
  
  flip    
  screensync  
  
loop

sleep



