#define ARM9

#include "crt.bi"
#include "nds.bi"
#include "hacks.bi"
#include "mpg123\mpg123.bi"

DeclareResource(Music_mp3) '  _end  _size
dim shared as longint Ticks

declare function StreamDecode cdecl alias "decode" (as ubyte ptr,as ulong) as integer

sub hBlankInterrupt cdecl ()
  *cptr(longint ptr,cuint(@Ticks) or &h2400000) += 1
end sub

consoleDemoInit()
soundEnable()
irqSet(IRQ_HBLANK, @hBlankInterrupt)
irqEnable(IRQ_HBLANK)

StreamDecode(Music_mp3, Music_mp3_size)
printf(!"done!\n")
do:swiIntrWait(1,IRQ_HBLANK):loop

function SearchSync(BuffStart as any ptr,BuffLength as uinteger) as any ptr
  dim as ubyte ptr Buff = BuffStart
  for CNT as integer = 0 to Bufflength-4
    if Buff[CNT] = 255 then
      'printf(!".")
      if (Buff[CNT+1] and &b11110000) = &b11110000 then
        'printf(!"Sync at %i\n",CNT)
        return Buff+CNT        
      end if
    end if
  next CNT
  return 0
end function
function FixedToShort cdecl (sample as integer) as integer  
  sample = sample shr 12
  static as integer LastSample
  Sample = (LastSample+sample) shr 1
  if sample < -32768 then sample = -32768
  if sample > 32767 then sample = 32767
  return sample
end function

type StreamStruct
  StreamStart as any ptr
  StreamSize as uinteger
  Channels as integer
  SampleRate as integer
  Length as integer
  PcmData as any ptr  
end type

function StreamOutput cdecl (bStream as StreamStruct ptr) as integer
  
  static as ushort ptr cLeft,cRight,BuffLeft,BuffRight
  static as integer ChanLeft = -1   'Left Channel ID
  static as integer ChanRight = -1  'Right Channel ID
  static as integer SwapBuff=0      '0=first halft  1 = second half
  static as integer SampleCount     'Number of Samples remaining to resync
  static as integer SwapTicks       'Ticks to wait (fixed point 11:21)
  static as integer BufferSamples   'Stores the computed half buffer sample size
  static as ulongint OldTicks       'Last timer ticks reading
  static as integer SyncDelay       'Delay before swap bufferss
  static as double RealFreq,MulSync = .15
  static as integer MulCnt,SwapXor
  
  if bStream = 0 then
    if ChanLeft <> -1 then SoundKill(ChanLeft):ChanLeft = -1
    if ChanRight <> -1 then SoundKill(ChanRight):ChanRight = -1
    return 0
  end if
  
  dim as uinteger nchannels, nsamples, nfreq
  dim as ushort ptr sound_chs
  '/* pcm->samplerate contains the sampling frequency */
  nchannels = bStream->Channels
  nsamples  = bStream->Length
  nfreq     = bStream->SampleRate
  sound_chs = bStream->PcmData
  
  ScanKeys()
  if (KeysDown() and Key_A) then MulCnt += 1
  if (KeysDown() and Key_B) then MulCnt -= 1
  
  dim as integer IdleTicks
  dim as longint ptr TicksNoCache = cptr(longint ptr,cuint(@Ticks) or &h2400000)
  
  if BuffLeft = 0 then    
    BuffLeft = allocate((nSamples*4))   'AllocateBuffer for (2304 samples)
    BuffRight = allocate((nSamples*4))  'AllocateBuffer for (2304 samples)  
    'Get Exact frequency (since 44100 might not be exactly 44100)
    RealFreq = (33513982/(33513982\(nFreq)))
    'How many ticks is 1152 samples? (fixed point 11:21 for accuracy)
    BufferSamples = ((1152/RealFreq)/(1/15766))*(1 shl 21)    
  end if
  
  if nChannels = 2 then 'Stereo
    
    cLeft = BuffLeft+(SwapBuff*(nSamples))   'Cleft points to half buffer
    cRight = BuffRight+(SwapBuff*(nSamples)) 'Cright points to half buffer
    'cLeft = cast(any ptr,cuint(cLeft) or &h2400000)
    'cRight = cast(any ptr,cuint(cRight) or &h2400000)
    dim as integer OutPosi
    for CNT as integer = 0 to (nsamples*2) step 2
      cLeft[OutPosi] = sound_chs[CNT]
      cRight[OutPosi] = sound_chs[CNT+1]
      OutPosi += 1
    next CNT      
    
    if ChanLeft <> -1 then '-1 means not playing yet
      SwapTicks += BufferSamples 'We're waiting for half buffer
      if SyncDelay = 0 then
        SwapTicks += BufferSamples*MulSync '(Buffersamples\10)*MulCnt
        SyncDelay = 1
      end if
      if OldTicks > *TicksNoCache then 'Timer Ticks overflow protection
        OldTicks = *TicksNoCache: SampleCount = 0
      end if
      dim as uinteger FixedTicksDiff 'ticks passed (fixed 11:21)
      dim as ulongint TempTicks = *TicksNoCache      
      do
        'set it and convert from integer to Fixed
        FixedTicksDiff = (*TicksNoCache-OldTicks) shl 21
        if FixedTicksDiff > SwapTicks then exit do
        swiIntrWait(1,IRQ_HBLANK)
      loop      
      SwapTicks -= FixedTicksDiff 'Subtracted elapsed time
      OldTicks = *TicksNoCache    'Update old ticks
      IdleTicks = (*TicksNoCache-TempTicks)
    end if    
    #if 1
    ' i want to sincronize after some samples but only start when i
    ' writed the first half of the buffer...
    if SampleCount <= 0 and SwapBuff=0 then
      OldTicks = *TicksNoCache   'Get ticks
      if ChanLeft = -1 then
        while OldTicks = *TicksNoCache
          'rem wait              'And synchronize with hblank
        wend      
        OldTicks += 1            'Adjust old ticks
      end if      
      SampleCount = ((nfreq)/1152) 'schedule next resync 5 seconds
      ' if there's already sound play... first stop(kill) the old stream
      if ChanLeft <> -1 then SoundKill(ChanLeft) 
      if ChanRight <> -1 then SoundKill(ChanRight)
      ' start playing both channels with infinite full loop of the full buffer
      ChanLeft = soundPlaySample(BuffLeft, SoundFormat_16Bit, nsamples*4, nfreq, 127, 0, true, 0)
      ChanRight = soundPlaySample(BuffRight, SoundFormat_16Bit, nsamples*4, nfreq, 127,127, true, 0)      
      SyncDelay = 0:SwapXor xor= 1
    end if    
    SampleCount -= 1  'One sample less for next resync
    #else
    dim as integer lTemp,rTemp
    lTemp = soundPlaySample(cLeft, SoundFormat_16Bit, nsamples*2, nfreq, 127, 0, true, 0)
    rTemp = soundPlaySample(cRight, SoundFormat_16Bit, nsamples*2, nfreq, 127,127, true, 0)
    SoundKill(ChanLeft):ChanLeft = ltemp
    SoundKill(ChanRight):ChanRight = rtemp
    #endif
    SwapBuff xor= 1   'swap the buffer half
  end if 
  
  ' print some statistic
  static as single Temp,CPU
  Temp += (nsamples/(nfreq))
  CPU = ((CPU*7)+(1-((IdleTicks*(nFreq/1152))/15766)))/8
  MulSync = ((1-CPU)+.15)/3
  printf(!"%1.1f %i ",MulSync*10,SwapXor)
  printf(!"%02im%02is cpu=%1.2f%%  \r",Temp\60,cint(Temp mod 60),CPU*100)
    
  return True
end function

function StreamDecode cdecl (Start as ubyte ptr,Length as ulong) as integer  
  
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
  
  dim as integer terr,result
  dim as uinteger Decoded,Offset,OutLen
  dim as any ptr OutBuff
  dim as mpg123_handle ptr mpeg
  dim as StreamStruct Mp3Stream
  dim MyMp3sz as integer = Length, MyMP3 as any ptr = Start
  static as integer Init
  
  Mp3Stream.StreamStart = Start
  Mp3Stream.StreamSize = Length
  
  if Init = 0 then 'Init
    Init = 1
    Try( mpg123_init,() )
  end if
  
  mpeg = mpg123_new(null,@result)                 ' new decode instance
  'Try( mpg123_param,(mpeg,MPG123_VERBOSE,2,0) )   ' set parameter
  Try( mpg123_param,(mpeg,MPG123_QUIET,1,0) )   ' set parameter
  Try( mpg123_open_feed,(mpeg) )                  ' creating a stream (feeding)
  
  ' Getting First sync (skipping ID headers)
  MyMp3 = SearchSync(MyMp3,Music_mp3_Size)
  printf(!"Sync found at offset %i\n",cuint(MyMp3)-cuint(Music_mp3))
  
  do  
    terr = mpg123_decode_frame(mpeg,cast(any ptr,@Offset), _
    cast(any ptr,@Outbuff),cast(any ptr,@Outlen))
    select case terr
    case MPG123_NEED_MORE
      dim as integer TempSZ = 65536
      if MyMp3SZ = 0 then printf(!"\n"):exit do    
      if TempSZ > MyMP3Sz then TempSZ = MyMp3Sz
      Try(mpg123_feed,(mpeg,MyMP3,TempSZ))
      MyMp3 += TempSZ: MyMP3Sz -= TempSZ
      'printf(".")
    case MPG123_NEW_FORMAT
      dim as integer rate,channels, enc
      mpg123_getformat( mpeg, @rate, @channels, @enc )  
      printf(!"format: %iHz %i ch, enc %i\n",Rate,Channels,enc)
      Mp3Stream.Channels = Channels
      Mp3Stream.SampleRate = Rate
      Mp3Stream.Length = 1152      
    case MPG123_OK
      if OutLen = 1152*Mp3Stream.Channels*2 then
        Mp3Stream.PcmData = OutBuff
        StreamOutput(@Mp3Stream)
      else
        'printf(!"offset:%i out:%08x len:%i\n", _
        'offset,cuint(outbuff),outlen\(Mp3Stream.Channels*2))
      end if
    case else
      'printf(!"Message: %i\n",terr)
      'do:swiWaitForVBlank():loop
      exit do
    end select
  loop  
  
  StreamOutput(null)
  
  return True
end function

#if 0
(byval as mad_decoder ptr, byval as any ptr, _ 
byval as function cdecl(byval as any ptr, byval as mad_stream ptr) as mad_flow,
byval as function cdecl(byval as any ptr, byval as mad_header ptr) as mad_flow,
byval as function cdecl(byval as any ptr, byval as mad_stream ptr, byval as mad_frame ptr) as mad_flow, _
byval as function cdecl(byval as any ptr, byval as mad_header ptr, byval as mad_pcm ptr) as mad_flow, 
byval as function cdecl(byval as any ptr, byval as mad_stream ptr, byval as mad_frame ptr) as mad_flow, 
byval as function cdecl(byval as any ptr, byval as any ptr, byval as uinteger ptr) as mad_flow)
#endif
