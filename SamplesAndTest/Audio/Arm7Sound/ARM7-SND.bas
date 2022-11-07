#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
  #include "Modules\wshelper.bas"
  #include "Modules\fmod.bas"
#else
  #include "fmod.bi"
  #include "fbgfx.bi"
  #include "wshelper.bas"
  #include "crt.bi"
  chdir "NitroFiles/"
#endif

function Test(pData as any ptr) as ulong  
  dim as integer A
  for N as integer = 0 to 1 shl 16
    A += (cast_vu32_ptr(@A)-1)
  next N
  return A
end function
puts("A continue , B ARM7 Test")
do
  var sKey = inkey
  if len(sKey)=0 then screensync : continue do
  if sKey[1]=fb.SC_BUTTONB then
    scope
      puts("Synchronous...")
      dim as double TMR = timer , dTotal = timer      
      var iResu = Test(0)
      printf(!"%i %.3f\tARM9\n",iResu,(timer-TMR)*1000)
      TMR = timer
      iResu = NDS_Arm7Exec( @Test , 0 , 1 )
      printf(!"%i %.3f\tARM7\n",iResu,(timer-TMR)*1000)
      print "Total: ";csng((timer-dTotal)*1000)
    end scope
    scope
      puts("ASynchronous...")
      dim as double TMR = timer , dTotal = timer
      NDS_Arm7Exec( @Test , 0 , 0 )
      var iResu = Test(0)
      printf(!"%i %.3f\tARM9\n",iResu,(timer-TMR)*1000)
      iResu = NDS_Arm7Ack()
      printf(!"%i %.3f\tARM7\n",iResu,(timer-TMR)*1000)
      print "Total: ";csng((timer-dTotal)*1000)
    end scope
    while len(inkey)=0: screensync: wend
  end if
  exit do
loop


FSOUND_Init(44100,8,0)

static as zstring ptr pzNames(...) = { _
@"start8M.wav" , @"start16M.wav" , @"start8S.wav" , @"start16S.wav" , _
@"Smile.wav" , @"Love.wav" , @"Garotos.wav" }

puts("Any button to next sound...")
for N as integer = 0 to ubound(pzNames)  
  var pStream = FSOUND_Sample_Load(FSOUND_FREE,pzNames(N),FSOUND_LOOP_OFF,0,0)
  if pStream = 0 then continue for
  #ifdef __FB_NDS__
    with *cptr(FSOUND_SampleInfo ptr,pStream)
      var iBits = 0, pzChan = @"Mono"
      select case .Format
      case SoundFormat_ADPCM : iBits=4 : pzChan = @"mADPCM"
      case SoundFormat_8bit  : iBits=8
      case SoundFormat_16bit : iBits=16
      end select
      printf(!"%-12s %iKhz %2ibit %s\n",pzNames(N),.Frequency\1000,iBits,pzChan)
    end with
  #else
    printf(!"%s\n",pzNames(N))
  #endif
  var iChan = FSOUND_PlaySound( FSOUND_FREE , pStream )
  do
    screensync : screensync
    var uReg = NDS_Arm7Read(cast(any ptr,&h4000400+((iChan-1) shl 4)))
    var uPtr = NDS_Arm7Read(cast(any ptr,&h4000404+((iChan-1) shl 4)))
    printf(!"%i %08X %08X\r",iChan,uReg,uPtr)
  loop until len(inkey)
  FSOUND_StopSound( iChan ) : FSOUND_Sample_Free( pStream )
next N

puts("DONE!!!")
sleep
end

#if 0
const ScrWid=256,ScrHei=192
'gfx.GfxDriver = gfx.gdOpenGL
screenres ScrWid,ScrHei
#endif

#if 0
var Img = ImageCreate(128,128)
for CNT as integer = 0 to 99
  circle Img,(rnd*128,rnd*128),10+rnd*24,rnd*255,,,,f
next CNT

do
  put(128-64,96-64),Img,pset
  flip
  screensync
  sleep 1,1
loop until len(inkey)
#endif

#if 0
  dim as integer MX,MY
  dim as string sTemp
  input "name";sTemp
  
  do
    
    getmouse MX,MY
    
    circle(rnd*ScrWid,rnd*ScrHei),20+rnd*20,rnd*255,,,,f
    for Y as integer = -1 to 1
      for X as integer = -1 to 1  
        draw string (((ScrWid\2)-44)+X,((ScrHei\2)-4)+Y),"Hello World",0
      next X
    next Y
    draw string (((ScrWid\2)-44),((ScrHei\2)-4)),"Hello World",12
    
    line(0,0)-(ScrWid,8),0,bf
    draw string (0,0),MX & "," & MY,15
    
    screensync
  
  loop until len(inkey)=1
#endif