declare function InitLUTs() as integer 
declare sub HQ2X_16 cdecl alias "hq2x_16" (INBUFFER as any ptr,OUTBUFFER as any ptr,XRES as uinteger,YRES as uinteger,PITCH as uinteger)

common shared as uinteger RGBTOYUV()
common shared as uinteger LUT16TO32()

dim shared as uinteger RGBTOYUV(65536)
dim shared as uinteger LUT16TO32(65536)

if InitLUTS() = 0 then
  'print "Erro MMX naum encontrado"
  end
else
  'print "MMX encontrado"  
end if

function InitLUTs() as integer export
  dim as integer I,J,K,R,G,B,Y,U,V  
  
  for I = 0 to 65535
    LUT16to32(I) = ((I and &hF800) shl 8) + ((I and &h07E0) shl 5) + ((I and &h001F) shl 3)
  next I  
  
  for I = 0 to 31
    for J = 0 to 63
      for K = 0 to 31
        R = I shl 3
        G = J shl 2
        B = K shl 3
        Y = (R + G + B) shr 2
        U = 128 + ((R - B) shr 2)
        V = 128 + ((-R + 2*G -B) shr 3)
        RGBtoYUV( (I shl 11) + (J shl 5) + K ) = (Y shl 16) + (U shl 8) + V 
      next K
    next J
  next I

  dim as integer nMMXsupport = 0

  asm  
    mov  eax, 1
    cpuid
    and  edx, 0x00800000
    mov  [nMMXsupport], edx
  end asm

  return nMMXsupport
end function