#ifndef __FB_NDS__
  '#cmdline "-dll -s gui"
  '#cmdline "-dll -s gui -gen gcc -O 3"
#endif

#include "fbgfx.bi"

static shared as ubyte tBuff(32*32-1)
static shared as ubyte bScreenOn

namespace gfx
  sub InitScreen(bOnTop as byte) export
    #ifdef __FB_NDS__
      screenres 256,192
      screenlock
      dim as ubyte ptr pScr = screenptr
      for Y as long = 0 to 191
        var iC = (&hB0+(Y\12)), iD = ((Y mod 12)/12)
        for X as long = 0 to 255          
          var iC2 = iC+rnd*2
          pScr[X] = (-((X+Y) and 1)) and iC2
        next X
        pScr += 256
      next Y      
      line(63,31)-(192,160),0,bf
      line(63,31)-(192,160),31,b
      screenunlock
      fb.KeyboardIsON = 1 'fb_ShowKeyboard()
      lcdMainOnTop()
      fbKeyboard->offset_y = -192+8+fb.KeyboardOffset
      KeyboardShow()
    #else
      screenres 32*8,32*8,8,1,iif(bOnTop,fb.GFX_ALWAYS_ON_TOP,0)
    #endif
    clear tBuff(0),-1,32*32
    palette 0,0,0,0
    palette 1,255,255,255
    palette 2,136,0,0
    palette 3,170,255,238
    palette 4,204,68,204
    palette 5,0,204,85
    palette 6,0,0,170
    palette 7,238,238,119
    palette 8,221,136,85
    palette 9,102,68,0
    palette 10,255,119,119
    palette 11,51,51,51
    palette 12,119,119,119
    palette 13,170,255,102
    palette 14,0,136,255
    palette 15,187,187,187
    #ifndef __FB_NDS__
    WindowTitle("32x32 GFX ($200)")
    #endif
    bScreenOn = 1
  end sub
  function IsScreenOpen() as long export
    return bScreenOn andalso screenptr<>0
  end function
  sub ScreenPos( iX as integer , iY as integer ) export
    if bScreenOn=0 then exit sub
    #ifndef __FB_NDS__
    screencontrol fb.SET_WINDOW_POS,iX,iY
    #endif
  end sub
  sub CloseScreen() export
    if bScreenOn=0 then exit sub
    #ifndef __FB_NDS__
    screenres 32,32,8,1,fb.gfx_null
    #endif
    bScreenOn = 0
  end sub
  function ReadKey() as long export
    #if __FB_OUT_EXE__
      return 0
    #else
      if bScreenOn=0 then return 0
      var sKey = inkey()
      if len(sKey)=0 then return 0
      dim as long iKey = sKey[0]
      if iKey=255 then iKey = -sKey[1]
      if iKey=-asc("k") then end
      return iKey
    #endif
  end function
  sub UpdateScreen( pPix as ubyte ptr ) export
    if bScreenOn=0 then exit sub
    dim as long iN = 0
    #ifdef __FB_NDS__
      screenlock
      var pPtr = cast(ulong ptr,screenptr)+16+(32*64)
      for iY as long = 0 to 31
        for iX as long = 0 to 31
          var iC = pPix[iN] and &hF
          if iC <> tBuff(iN) then
            tBuff(iN)=iC 
            dim as ulong uPix = iC+(iC shl 8)+(iC shl 16)+(iC shl 24)
            pPtr[0]=uPix : pPtr[64]=uPix : pPtr[128]=uPix : pPtr[192]=uPix
          end if
          pPtr += 1 : iN += 1
        next iX
        pPtr += (256-32)
      next iY   
      screenunlock
    #else
      for iY as long = 0 to 31
        for iX as long = 0 to 31
          var iC = pPix[iN] and &hF
          if iC <> tBuff(iN) then
            tBuff(iN)=iC 
            line(iX*8,iY*8)-step(7,7),iC,bf            
          end if
          iN += 1
        next iX
      next iY
    #endif
  end sub
end namespace
