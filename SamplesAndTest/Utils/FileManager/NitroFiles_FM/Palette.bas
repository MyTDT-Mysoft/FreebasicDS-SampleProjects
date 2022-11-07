#if 0
screenres 320,240

var pImage = imagecreate(32,8)
var pPix = cast(ubyte ptr,pImage+32)
for CNT as integer = 0 to 255
  pPix[CNT] = CNT
next CNT
bsave "palette.bmp",pImage
#endif

screenres 640,480

const iMax = 52^3-1
dim as uinteger iRGB(iMax),CNT
for R as integer = 0 to 51
  for G as integer = 0 to 51
    for B as integer = 0 to 51
      iRgb(CNT) = rgb(R*5,G*5,B*5)
      CNT += 1
    next B
  next G
next R

CNT = 0
for R as integer = 0 to 7
  for G as integer = 0 to 7
    for B as integer = 0 to 3
      palette CNT,R*(255/7),G*(255/7),B*(255/3)
      CNT += 1
    next B
  next G
next R
  
print CNT

var pImage = imagecreate(32,8)
var pPix = cast(ubyte ptr,pImage+32)
for CNT as integer = 0 to 255
  pPix[CNT] = CNT
next CNT
bsave "pal256.bmp",pImage

      

