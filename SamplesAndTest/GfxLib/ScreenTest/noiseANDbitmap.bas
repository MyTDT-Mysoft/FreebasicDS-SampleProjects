#ifdef __FB_NDS__
#define __FB_NITRO__
'#define __FB_PRECISE_TIMER__
#define __FB_GFX_NO_GL_RENDER__
#define __FB_GFX_NO_16BPP__
#define __FB_GFX_NO_OLD_HEADER__

#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
#endif

type BmpFileHeader field=1
  as ubyte Signature(1)    'BM
  as uinteger FileSize     'Size of BMP file
  as uinteger Reserved1    'Reserved O.o
  as uinteger ImageOffset  'Offset to image data
  as uinteger BihSize      'size of BITMAPINFOHEADER structure, must be 40
  as uinteger Wid          'Image Width
  as uinteger Hei          'Image Height
  as ushort   Planes       'Must be 1 (no mode-x .bmp :P)
  as ushort   Bpp          'Bits Per Pixel (1,4,8,16,24,32)
  as uinteger Compression  'compression type (0=none, 1=RLE-8, 2=RLE-4)
  as uinteger ImageSize    'Size of image data (plus paddings)
  as uinteger hres         'ppm Horizontal resolution (lol)
  as uinteger vres         'ppm Vertical resolution (lol)
  as uinteger MaxColors    'number of colors in image, or zero
  as uinteger NeedColors   'number of important colors, or zero
end type

type ColorBGRA    
  B as ubyte
  G as ubyte
  R as ubyte
  A as ubyte
end type

screenres 256,192,8
if Screenptr = 0 then print "Erro :("
scope
  dim as uinteger carry,index,seed = &h12345
  dim as uinteger Noise,Noise1,Noise2,Noise3
  dim as integer SCR_SIZE = 256*192,Frame
  dim as uinteger ptr Buffer = screenptr  
  dim as string key
  dim as double TMR
  for CNT as integer = 0 to 255
    palette CNT,CNT,CNT,CNT
  next CNT
  #macro MakeNoise(noisevar)
  noisevar = (seed shr 3) xor seed
  carry = noisevar and 1
  noisevar shr= 1
  seed = seed shr 1
  seed = seed or (carry shl 30)
  noisevar and= &hFF      
  #endmacro  
  do    
    screensync
    screenlock
    for index = 0 to (SCR_SIZE\4)-1
			MakeNoise(Noise)
      MakeNoise(Noise1)
      MakeNoise(Noise2)
      MakeNoise(Noise3)
      buffer[index] = noise or (noise1 shl 8) or (noise2 shl 16) or (noise3 shl 24)      
    next index 
    screenunlock
    Frame += 1:locate 1,1
    print cuint(Frame/(timer-TMR)) & " fps";    
  loop until multikey(fb.SC_BUTTONSTART)
end scope

cls
screenres 256,192,8
if Screenptr = 0 then print "Erro :("

dim as ubyte ptr scrptr = Screenptr()
dim as integer BmpFile = freefile()
dim as BmpFileHeader MyBMP

if open("nvidia.bmp" for binary access read as #BmpFile)=0 then
  dim as ColorBGRA Pal32(255)
  get #BmpFile,,MyBMP
  with MyBMP
    
    print .Wid,.Hei,.Bpp  
    
    if .Bpp = 8 then 
      Get #BmpFile,,*cptr(ubyte ptr,@Pal32(0)),256*sizeof(ColorBGRA)
      for CNT as integer = 0 to 255
        with Pal32(CNT)
          if CNT = 251 then print .r,.g,.b
          Palette CNT,.r,.g,.b
        end with
      next CNT
    end if
    
    seek #BmpFile,.ImageOffset+1
    dim as ubyte ptr Buff = scrptr+(256*(.Hei-1))
    dim as integer LineSize = ((.Wid*.Bpp)/8)
    if (LineSize and 3) then LineSize = (LineSize or 3)+1
    for Y as integer = .hei-1 to 0 step -1
      get #BmpFile,,*Buff,LineSize
      Buff -= 256
    next Y
    
  end with  
  close #BmpFile
else
  print "Failed!"
end if

sleep
