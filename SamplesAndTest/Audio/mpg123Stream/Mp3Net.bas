#define ARM9

#include "crt.bi"
#include "nds.bi"
#include "hacks.bi"
#include "mpg123\mpg123.bi"
#include "sys/socket.bi"
#include "netinet/in.bi"
#include "netdb.bi"
#include "dswifi9.bi"

dim shared as longint Ticks

declare function StreamDecode cdecl (Server as zstring ptr,Port as integer=80,Filename as zstring ptr) as integer  

sub hBlankInterrupt cdecl ()
  *cptr(longint ptr,cuint(@Ticks) or &h2400000) += 1
end sub

consoleDemoInit()
soundEnable()
irqSet(IRQ_HBLANK, @hBlankInterrupt)
irqEnable(IRQ_HBLANK)

dim as file ptr Music_mp3
dim as integer Music_mp3_size  

if Wifi_InitDefault(WFC_CONNECT)=0 then
  iprintf("WFC connect failed!\n")
else
  iprintf(!"Connected to WFC\n")
end if

'"dl.dropbox.com",,"/u/33347820/richard_marx-right_here_waiting_for_you.mp3"
'"/files/stream/richard_marx-right_here_waiting_for_you.mp3"
StreamDecode("192.168.0.111",8000,"/richard_marx-right_here_waiting_for_you.mp3")
StreamDecode("192.168.0.111",8000,"/martika-toy_soldiers.mp3")

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

type StreamStruct
  StreamStart as any ptr
  StreamSize as uinteger
  Channels as integer
  SampleRate as integer
  Length as integer
  PcmData as any ptr  
end type

function StreamOutput cdecl (bStream as StreamStruct ptr) as integer
  
  const ExSamples = 1152
  
  static as ushort ptr cLeft,cRight,BuffLeft,BuffRight
  static as integer ChanLeft = -1   'Left Channel ID
  static as integer ChanRight = -1  'Right Channel ID
  static as integer SwapBuff=0      '0=first halft  1 = second half
  static as integer SampleCount     'Number of Samples remaining to resync
  static as integer SwapTicks       'Ticks to wait (fixed point 11:21)
  static as integer BufferSamples   'Stores the computed half buffer sample size
  static as ulongint OldTicks       'Last timer ticks reading
  static as integer SyncDelay       'Delay before swap bufferss
  static as double RealFreq
  static as integer MulCnt,SwapXor
  static as single TempTime,CPU=.5,MulSync = .1
  
  if bStream = 0 then
    if ChanLeft <> -1 then SoundKill(ChanLeft):ChanLeft = -1
    if ChanRight <> -1 then SoundKill(ChanRight):ChanRight = -1
    if BuffLeft then deallocate(BuffLeft):BuffLeft = 0
    if BuffRight then deallocate(BuffRight):BuffRight = 0
    SwapBuff=0:SampleCount=0:SwapTicks=0
    BufferSamples=0:TempTime=0:CPU=.5
    ClEft=0:CRight=0:OldTicks=0:SyncDelay=0
    RealFreq=0:MulSync=.1:MulCnt=0:SwapXor=0    
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
    BufferSamples = ((ExSamples/RealFreq)/(1/15766))*(1 shl 21)    
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
      SampleCount = ((nfreq)/ExSamples)*(MulSync*8) 'schedule next resync 5 seconds
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
    SwapBuff = (SwapBuff+1) and 1  'swap the buffer half
  end if 
  
  ' print some statistic
  TempTime += (nsamples/(nfreq))
  CPU = ((CPU*7)+(1-((IdleTicks*(nFreq/ExSamples))/15766)))/8
  MulSync = ((1-CPU)+.12)/3
  printf(!"\r%2.1f %i ",MulSync*10,SwapXor)
  printf(!"%02im%02is cpu=%1.2f%%  \r",TempTime\60,cint(TempTime mod 60),CPU*100)
    
  return True
end function

function StreamDecode cdecl (Server as zstring ptr,Port as integer=80,Filename as zstring ptr) as integer  
  
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
  static as integer Init
  
  Mp3Stream.StreamStart = 0  
  Mp3Stream.StreamSize = -1
  
  if Init = 0 then 'Init
    Init = 1
    Try( mpg123_init,() )
  end if
  
  mpeg = mpg123_new(null,@result)                 ' new decode instance
  'Try( mpg123_param,(mpeg,MPG123_VERBOSE,2,0) )   ' set parameter
  Try( mpg123_param,(mpeg,MPG123_QUIET,1,0) )   ' set parameter
  Try( mpg123_open_feed,(mpeg) )                  ' creating a stream (feeding)
  
  '============================================================================
  '============================================================================
  '============================================================================
    
  '// Find the IP address of the server, with gethostbyname
  dim as hostent ptr myhost = gethostbyname( Server )
    
  '// Create a TCP socket
  dim as integer my_socket
  my_socket = ssocket( AF_INET, SOCK_STREAM, 0 )
    
  '// Tell the socket to connect to the IP address we found, on port 80 (HTTP)
  dim as sockaddr_in sain
  sain.sin_family = AF_INET
  sain.sin_port = shtons(Port)
  sain.sin_addr.s_addr= *cast(ulong ptr,(myhost->h_addr_list[0]) )
  if sconnect( my_socket,cast(sockaddr ptr,@sain), sizeof(sain) ) then
    iprintf(!"Failed to connect to \n '%s'\n",Server):return 0
  end if
  iprintf(!"Connected: %s\n\n",Server)
  
  '// send our request
  scope
    dim as zstring*1024 RequestText
    sprintf(RequestText,@!"GET %s HTTP/1.1\r\n" !"Host: %s\r\n" _
    !"User-Agent: Nintendo DS\r\n\r\n", Filename,Server)
    ssend( my_socket, @RequestText, strlen(RequestText), 0 )
  end scope
  
  dim as ulong NonBlocking = 1
  dim as integer ReadPOS,WritePOS,BuffCount,SlotCount,PreBuff
  dim SpdMet as integer,SpdVal as single
  
  sioctl(my_socket, FIONBIO, @NonBlocking)
  
  type BuffData
    DataPtr as any ptr
    DataSize as uinteger
  end type
  
  dim as BuffData Buffs(511)
  
  '============================================================================
  '============================================================================
  '============================================================================

  do    
    do      
      if SlotCount = 0 andalso PreBuff then 
        StreamOutput(null):PreBuff = 0: SpdMet = 0
      end if
      if SlotCount >= 500 or BuffCount >= 65535 then PreBuff=1:exit do
      with Buffs(WritePos)        
        if .DataPtr andalso .DataSize = -1 then exit do
        if .DataPtr = 0 then .DataPtr = allocate(1024)        
        dim as integer Result = srecv( my_socket, .Dataptr, 1024, 0 )
        if Result < 0 or Result > 65536 then 
          if PreBuff then exit do
        elseif Result = 0 then 
          deallocate(.DataPtr):.DataSize = -1:exit do
        else        
          .DataSize = Result: BuffCount += Result
          WritePos = (WritePos+1) and 511: SlotCount += 1
          'printf(".")
        endif
      end with
      if Prebuff andalso BuffCount then exit do
      swiWaitForvBlank(): SpdMet += 1      
      if (SpdMet mod 30) = 1 then SpdVal = (BuffCount/1024)/(SpdMet/60)
      printf(!"\r%3i %3i %3i %02.2f %02.1fkb/s \r", _
      ReadPos,WritePos,SlotCount,BuffCount/1024,SpdVal)
    loop
    
    terr = mpg123_decode_frame(mpeg,cast(any ptr,@Offset), _
    cast(any ptr,@Outbuff),cast(any ptr,@Outlen))
    select case terr
    case MPG123_NEED_MORE      
      with Buffs(ReadPos)
        if .DataSize = -1 then           
          .DataPtr = 0:.DataSize = 0
          printf(!"\n"):exit do
        end if
        if SlotCount = 0 then continue do
        Try(mpg123_feed,(mpeg,.DataPtr,.DataSize))
        Deallocate(.DataPtr):.DataPtr=0:SlotCount -= 1 
        BuffCount -= .DataSize: .DataSize = 0
        ReadPos = (ReadPos+1) and 511
      end with
    case MPG123_NEW_FORMAT
      dim as integer rate,channels, enc
      mpg123_getformat( mpeg, @rate, @channels, @enc )  
      printf(!"\rformat: %iHz %i ch, enc %i\n",Rate,Channels,enc)
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
  
  for CNT as integer = 0 to 511
    with buffs(CNT)
      if .DataPtr andalso .DataSize <> -1 then deallocate(.DataPtr)
      .DataPtr = 0: .DataSize = 0
    end with
  next CNT
  
  sshutdown(my_socket,0)
  sclosesocket(my_socket)
  
  StreamOutput(null)
  mpg123_delete(mpeg)
  
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
