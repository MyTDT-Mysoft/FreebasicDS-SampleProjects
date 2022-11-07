#define SC2X_X 256
#define SC2X_Y 192

#include "fbgfx.bi"
#include "MyTDT\scale2x.bas"
chdir exepath+"\nitrofiles\"

#define bpp 16
type pixel as ubyte
using bpp16

screenres 512,384,16

dim as fb.image ptr gBuff,gBack,gTheme

gBuff  = ImageCreate(256,192)
gBack  = ImageCreate(256,192)
gTheme = ImageCreate(128,128)

bload "bg.bmp",gBack
bload "theme.bmp",gTheme
palette 0,0

dim as integer MX,MY

do
  'put gBuff,(0,0),gBack,pset
  
  getmouse MX,MY
  MX shr= 1: MY shr= 1
  
  put gBuff,(MX,MY),gTheme,(112,48)-(112+3,48+15),and
  for CNT as integer = 4 to 63-8 step 8
    put gBuff,(MX+CNT,MY),gTheme,(112+4,48)-(112+11,48+15),and
  next CNT
  put gBuff,(MX+60,MY),gTheme,(112+12,48)-(112+15,48+15),and
  line gBuff,(MX+1,MY+1)-(MX+59,MY+11),254,bf
  
  screenlock
  resize2x(gBuff+1,screenptr)
  screenunlock
  sleep 50,1
loop until multikey(1)
  