#define DoNotDisableNagle

#ifdef __FB_NDS__
  '#define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define __FB_NO_NITRO__
  '#define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"  
  #include "Modules\fbgfx.bas"
  #include "Modules\wshelper.bas"
  '#include "Modules\fmod.bas"
  #include "wolfssl.bi"
#else
  #include "fbgfx.bi"  
  #include "crt.bi"      
  #include "wshelper.bas"
  #include "wolfssl.bi"
#endif


#include "wshelper-http.bas"


screenres 256,192
dim as Http.NetContext tCtx
dim as Http.NetContext ptr pCtx
'pCtx = Http.NewSession(Http.amAsyncStream,@tCtx)

'for N as long = 0 to 255
'  palette N,N,N*.8,N*.6
'  'palette N,N*.6,N*.8,N
'next N
  
var sOutput = space(2048) , pBuf = cptr(http.fbString ptr,@sOutput) , iImg = 0
do  
  if pCtx = 0 then pCtx = Http.NewSession(Http.amAsyncStream,@tCtx)
  if pCtx <> @tCtx then 
    puts("Failed to create session")
    sleep
  end if
  pCtx->iAsync = Http.amAsyncStream
  pBuf->iLen = 0 : pBuf->iSize = 54+1024
      
  static as zstring ptr pzUrl(...) = { _
    @"https://people.math.sc.edu/Burkardt/data/bmp/dots.bmp", _
    @"https://people.math.sc.edu/Burkardt/data/bmp/lena.bmp", _
    @"http://192.168.0.111:8000/Lena.bmp", _
    @"http://192.168.0.111:8000/Betty.bmp", _
    @"http://192.168.0.111:8000/Betty2.bmp", _
    @"http://192.168.0.111:8000/Betty3.bmp" _
  }
  var iResu = Http.GetUrl(pCtx,*pzUrl(iImg),sOutput)    
  printf(!"iResu=%i ",iResu) 
  if iResu < 0 then 
    puts("download ERROR any key to retry") : sleep
    if pCtx then Http.FreeSession(pCtx) : pCtx = 0
    'pCtx = Http.NewSession(Http.amAsyncStream,@tCtx)
    continue do
  else
    iImg = (iImg+1) mod (ubound(pzUrl)+1)
  end if
  

  'grab header and palette
  dim as double dTMR = timer
  pCtx->iAsync = Http.amSync
  do until iResu orelse pBuf->iLen = pBuf->iSize
    iResu = Http.AsyncUpdate( pCtx )
    sleep 1,1
  loop 
  printf(!"%1.3f ms\n",(timer-dTMR)*1000)
  
  line(0,0)-(255,191),0,bf
  for N as long = 0 to 255
    palette N,sOutput[54+N*4+2],sOutput[54+N*4+1],sOutput[54+N*4+0]
  next N        
  Draw String(1, 1),pCtx->sHost, 255
  Draw String(1,10),pCtx->sFile, 255
  
  var pScr = cptr(ubyte ptr,screenptr+190*256)
  pBuf->iLen = 0 : pBuf->iSize = 512*3
  var pRow = cptr(ubyte ptr,strptr(sOutput)) , iRows = 0
    
  do until iResu    
    printf(!"%i%%\r",cint((100*pCtx->uReceived+(pCtx->uLength-1))\pCtx->uLength))    
    iResu = Http.AsyncUpdate( pCtx )
    'screensync
    if iResu orelse pBuf->iLen = pBuf->iSize then            
      screenlock
      #ifdef Smooth
        for Y as long = 0 to 2*512 step 512
          for X as long = 0 to 255
            pScr[X] += (pRow[Y+X*2+0]+pRow[Y+X*2+1])\6            
          next X
        next Y
      #else
        for X as long = 0 to 255
          pScr[X] = pRow[X*2+0]
        next X
      #endif
      screenunlock
      pBuf->iLen = 0 : pScr -= 256
      'memset(pScr,0,256)
      'screensync
      
      'iRows += 3 ': if iRows >= (512-2) then exit do    
    end if    
  loop
  
  printf(!"\nResu=%i , Received=%i\n",iResu,cint(pCtx->uReceived)) 'len(sOutput))
  #ifndef __FB_NDS__
  sleep
  #endif
  'if pCtx then Http.FreeSession(pCtx) : pCtx = 0
loop

if pCtx then Http.FreeSession(pCtx) : pCtx = 0
puts("Done!")

sleep

#if 0
  HTTP/1.1 302 Found
  Date: Sun, 11 Sep 2022 18:56:38 GMT
  Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips mod_fcgid/2.3.9 PHP/5.4.16
  Location: https://people.math.sc.edu/Burkardt/data/bmp/lena.bmp
  Content-Length: 237
  Keep-Alive: timeout=5, max=100
  Connection: Keep-Alive
  Content-Type: text/html; charset=iso-8859-1
  
  HTTP/1.1 403 Forbidden
  Date: Sun, 11 Sep 2022 19:32:12 GMT
  Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips mod_fcgid/2.3.9 PHP/5.4.16
  Content-Length: 228
  Keep-Alive: timeout=5, max=100
  Connection: Keep-Alive
  Content-Type: text/html; charset=iso-8859-1  
#endif