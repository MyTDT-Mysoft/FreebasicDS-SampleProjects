#define ARM9
#define MyDebug

#include "crt.bi"
#ifdef __fb_NDS__
#include "nds.bi"
#endif
#include "mpg123\mpg123.bi"

#ifdef __fb_NDS__
DeclareResource(Music_mp3)
#else
dim shared as ubyte ptr Music_mp3
dim shared as uinteger Music_mp3_size
scope
  dim as integer MyFile = freefile()
  open "Music.mp3" for binary access read as #MyFile
  Music_mp3_size = lof(MyFile)
  Music_mp3 = allocate(Music_mp3_size)
  get #MyFile,1,*Music_mp3,music_mp3_size)
  close #Myfile
end scope
#endif

function SearchSync(BuffStart as any ptr,BuffLength as uinteger) as any ptr
  dim as ubyte ptr Buff = BuffStart
  for CNT as integer = 0 to Bufflength-4
    if Buff[CNT] = 255 then      
      if (Buff[CNT+1] and &b11110000) = &b11110000 then
        return Buff+CNT        
      end if
    end if
  next CNT
  return 0
end function

#ifdef __fb_NDS__
consoleDemoInit()
#endif

dim shared as integer terr
dim as mpg123_handle ptr mpeg
dim as integer result,MyMp3sz = Music_mp3_size
dim as any ptr MyMP3 = Music_mp3

const AppPath = -(len(__path__)+1)
#define _file_ @(__file__)-AppPath
#macro Try(funcname,funcparms)
terr = funcname##funcparms
#ifdef MyDebug
if terr <> MPG123_OK then
  printf(!"\nError %i calling: %s\nfile: %s(%i)\n",terr,#funcname,_file_,__line__)
  #ifdef __fb_NDS__
  do:swiWaitForVBlank():loop
  #else
  sleep
  #endif
end if
#endif
#endmacro

'init
Try( mpg123_init,() )

' new decode instance
mpeg = mpg123_new(null,@result)

' set parameter
'Try( mpg123_param,(mpeg,MPG123_VERBOSE,2,0) )

' creating a stream (feeding)
Try( mpg123_open_feed,(mpeg) )

' Getting First sync (skipping ID headers)
MyMp3 = SearchSync(MyMp3,Music_mp3_Size)
printf(!"Sync found at offset %i\n",cuint(MyMp3)-cuint(Music_mp3))

dim as any ptr OutBuff '= allocate(1024*512)
dim as uinteger Decoded,Offset,OutLen
' feeding some data
do  
  terr = mpg123_decode_frame(mpeg,cast(any ptr,@offset), _
  cast(any ptr,@outbuff),cast(any ptr,@outlen))
  select case terr
  case MPG123_NEED_MORE
    dim as integer TempSZ = 4096
    if MyMp3SZ = 0 then printf(!"\n"):exit do    
    if TempSZ > MyMP3Sz then TempSZ = MyMp3Sz
    Try(mpg123_feed,(mpeg,MyMP3,TempSZ))
    MyMp3 += TempSZ: MyMP3Sz -= TempSZ
    printf(".")
  case MPG123_NEW_FORMAT
    dim as integer rate,channels, enc
    mpg123_getformat( mpeg, @rate, @channels, @enc )  
    printf(!"\nformat: %iHz %i ch, enc %i\n",rate,channels,enc)
  case MPG123_OK
    'printf(!"offset:%i out:%08x len:%i\n",offset,cuint(outbuff),outlen)
  case else
    printf(!"\nMessage: %i\n",terr)
    do:swiWaitForVBlank():loop
  end select
loop

printf(!"Done. %i",Decoded)
do  
  #ifdef __fb_NDS__
  swiWaitForVBlank()
  #else
  sleep 100,1
  #endif
loop


