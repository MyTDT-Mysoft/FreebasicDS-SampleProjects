#ifdef __FB_NDS__
'#define __FB_NITRO__
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

screenres 256,192

var pCircle = ImageCreate(256,192)
Circle pCircle,(128,96),90,10,,,,f

view screen (128-64,96-48)-(128+64,96+48)

put(0,0),pCircle,pset

sleep 2000,1

view screen
put(0,0),pCircle,xor

sleep