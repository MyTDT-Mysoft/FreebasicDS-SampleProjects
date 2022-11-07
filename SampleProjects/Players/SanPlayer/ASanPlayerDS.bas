#define fbc -s console

'#define On_x86

#ifdef __FB_NDS__
'#define __FB_FAT__
#define __FB_NITRO__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#include "Modules\fmod.bas"
#else
#include "fmod.bi"
#include "crt.bi"
#include "fbgfx.bi"
chdir "NitroFiles/"
#endif

#ifdef On_x86
#include "windows.bi"
#include "win\mmsystem.bi"
#endif
#include "fbgfx.bi"
#include "crt.bi"

#ifdef On_x86
#define SC2X_X 320
#define SC2X_Y 200
#include "MyTDT\scale2x.bas"
#endif

declare sub codec37_MakeTable(pitch as integer,index as integer)
#ifndef __FB_NDS__
screencontrol(fb.SET_DRIVER_NAME,"GDI")
#endif
#ifdef On_x86
timeBeginPeriod(1)
SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS)
#endif

#ifdef On_x86
screenres 640,400,16,,fb.gfx_high_priority or fb.gfx_no_switch
#else
screenres 256,192,8
#endif

#define unnamed
#define Cout(sFormat,Parms...) 'printf(!"                               \r" !sFormat !"\n",Parms)
#define Errout(sFormat,Parms...) printf(!"                               \r" !sFormat !"\n",Parms)
#define MakeInt(DualShort) cuint(cuint(DualShort##L) or (cuint(DualShort##H) shl 16))
#define CopyInt(pTgt,pSrc) memcpy(pTgt,pSrc,4)

type HeaderStruct
  iTypeL as ushort                'Type of the chunk (BIG)
  iTypeH as ushort                'High
  iSizeL as ushort               'Size of the chunk (BIG)
  iSizeH as ushort                'High
end type
type AnimHeaderStruct
  as ushort   Version              'Version number of the animation
  as ushort   Frames               'Number of frames in the animation
  as ushort   Reserved             'Reserved (unknown)
  as ubyte    StartPal(256*3-1)    'Starting palette of the animation
  as ushort   v2VersionL           'Secondary version number (???)
  as ushort   v2VersionH
  as ushort   v2Reserved(1)        'Reserved (unknown)  
  as ushort   v2FrequencyL         'sound sampling frequency
  as ushort   V2FrequencyH         
  as ubyte    v2Filler(7)          'unknown, always 0
end type
type NewPaletteStruct
  as ubyte    NewPal(256*3-1)      'New palette for the animation
end type
type ChgPaletteStruct
  as ushort   Unknown              'Unknown
  as ushort   PalSize              'size of the palette (???)
  union
    as ushort Index                'index of the transition ???
    type unnamed    
      as short PalDelta(256*3-1)   'Palette delta value
      as ubyte  NewPal(256*3-1)    'Starting Palette in RGB format
    end type
  end union
end type
type FrameObjectStruct
  as ushort    Codec                'codec used for data compression
  as ushort    PosX                 'Horizontal start of the frame object
  as ushort    PosY                 'Vertical start of the frame object
  as ushort    Wid                  'width of the frame object
  as ushort    Hei                  'height of the frame object
  as ubyte     Unk1(3)              'unknown
  as ubyte     ObjectData           'Referenced pointer to data start
end type
type FrameAudioStruct
  as ushort    TrackID              'Track identifier
  as ushort    Index                'progressive index
  as ushort    IndexCount           'number of progressive indexes ?
  as ushort    Flags                'flags for the track
  as ubyte     Volume               'volume of the track
  as byte      Balance              'balance of the track (-127,0127)
  as ubyte     SoundData            'Referenced pointer to sound start
end type
type Codec37Struct
  as ubyte     SubCodec             'subcodec identifier
  as ubyte     Index                'table index??
  as ushort    Sequence             'frame sequence number
  as ushort    OutSzL               'size of decoded data
  as ushort    OutszH               'high
  as ushort    InSzL                'size of encoded data
  as ushort    InSzH                'high
  as ushort    FlagsL               'flags??
  as ushort    FlagsH               'high
  as ubyte     EncodedData          'referenced pointer to encoded data
end type
type SampleStackStruct
  as any ptr SamplePtr  
  as ushort SampleSz
  as short TrackNum
  as short SliceID
end type
type TrackStruct
  as double  StartTime
  as double  EndTime
  as any ptr SamplePtr  
  as short TrackID
  as short TrackChan  
  as short SampleID  
end type
type TrackCross
  TrackData as TrackStruct ptr
  as integer SampleCount  
  as short CurrentID
  as short LastID  
  as short Samples
end type

function GetChunkSz(InVar as uinteger) as integer  
  return (InVar shr 24)+((InVar shr 8) and &hFF00)+ _
  ((InVar shl 8) and &hFF0000)+((InVar shl 24) and &hFF000000)  
end function

dim as integer SanFile = freefile(),SanSize,ChunkSz
dim as uinteger SanBuffSz,SanBuffEnd
dim as any ptr SanPtr,NextFrame,SanBuff
dim as ubyte ptr ImgBuffer,ImgBuffer2,pBuff,StoredFrame
dim as uinteger LitPal,LitColor
dim as integer RenderLastFrame,FrameSync=1
dim as integer FrameCount,FrameTotal,ChunkType
dim as integer FrameReady,FrameSize,IsFrameStored
dim as integer DoubleMode,ModeFull,DoNoise

const SAMPLE_UBOUND = 127,TRACK_UBOUND=127,SOUND_CHANNELS=7
dim shared as SampleStackStruct SampleStack(SAMPLE_UBOUND)
dim shared as TrackStruct TrackUsage(SOUND_CHANNELS)
dim shared as TrackCross TrackPtr(TRACK_UBOUND)
dim shared as integer TrackMin,TrackMax,SampleMin,SampleMax

dim shared as any ptr UpdateBuffer,ExtraBuff
dim shared as integer MemoryUsage
dim shared as short ptr _offset_table
dim shared as integer _table_last_pitch
dim shared as integer _table_last_index
dim shared as ushort CurPal(767)
dim shared as short DeltaPal(767)

#macro UpdateAudioState(ss)
'Errout("Line: %s",str(ss))
AudioPlayback()
#endmacro

sub AudioPlayback(ID as any ptr=0)  
  static as integer AudioMutex
  
  if AudioMutex then exit sub
  AudioMutex = 1
  
  for iTrack as integer = 0 to SOUND_CHANNELS
    with TrackUsage(iTrack)
      if .TrackID <> -32768 then
        var SampleSz = SampleStack(.SampleID).SampleSz        
        if timer > (.EndTime-(1/60)) then
          if .SamplePtr then
            .SamplePtr = 0
          elseif .TrackChan >= 0 then
            if timer > (.EndTIme+(1/5)) then
              MemoryUsage -= (SampleSz+64)
               .TrackChan = -1
              with TrackPtr(.TrackID)
                .SampleCount -= SampleSz: .Samples -= 1
                .CurrentID += 1
              end with          
              with SampleStack(.SampleID)
                FSOUND_Sample_Free(.SamplePtr): .SamplePtr=0
                .SliceID = -1: .TrackNum = -1 : .SampleSz=0
              end with
            end if
          end if
          'ErrOut("SampleFree Trk=%i Ch=%i #%i",.TrackID,iTrack,.SampleID)
          .TrackID = -.TrackID
        end if
      end if
    end with
  next iTrack
  
  for iIndex as integer = 0 to SAMPLE_UBOUND
    with SampleStack(iIndex)
      var CurSample = .SamplePtr, CurID = .SliceID
      var TrackID = .TrackNum, SampleSz = .SampleSz
      if  CurSample andalso TrackID <> -1 then 
        with TrackPtr(TrackID)
          if .TrackData = 0 then
            for iTrack as integer = 0 to SOUND_CHANNELS
              with TrackUsage(iTrack)
                if .TrackID = -32768 then 
                  TrackPtr(TrackID).TrackData = @TrackUsage(iTrack)
                  .TrackID = TrackID: .TrackChan = -1
                  exit for
                end if
              end with
            next iTrack
            if .TrackData = 0 then
              ErrOut("Fatal: ALL CHANNELS ARE IN USE!")
              sleep: end
            end if
          end if        
          with *.TrackData
            if .SamplePtr = 0 andalso TrackPtr(TrackID).CurrentID = CurID then              
              dim FreeSample as any ptr, FreeChan as integer
              if .TrackChan <> -1 then                
                FreeChan = .TrackChan
                with TrackPtr(.TrackID)
                  .SampleCount -= SampleSz: .Samples -= 1
                  .CurrentID += 1
                end with          
                with SampleStack(.SampleID)                
                  MemoryUsage -= (SampleSz+64)
                  FreeSample = .SamplePtr: .SamplePtr=0 
                  .SliceID = -1: .TrackNum = -1: .SampleSz=0           
                end with
              end if              
              .SamplePtr = CurSample : .SampleID = iIndex
              .StartTime = timer: .EndTime = .StartTime+((SampleSz)/22050)
              .TrackID = TrackID
              .TrackChan = FSOUND_PlaySound(FSOUND_FREE,CurSample)            
              var iChan = (cuint(TrackPtr(TrackID).TrackData)-cuint(@TrackUsage(0)))\sizeof(TrackUsage)
              if FreeSample then 
                FSOUND_StopSound(FreeChan)
                FSOUND_Sample_Free(FreeSample)
              end if
              'ErrOut("Playing Trk=%i Ch=%i #%i",TrackID,iChan,iIndex)
            end if
          end with
        end with
      end if
    end with
  next iIndex
  
  for iTrack as integer = 0 to SOUND_CHANNELS
    with TrackUsage(iTrack)
      if .TrackID < 0 andalso .TrackID <> -32768 then 
        TrackPtr(-.TrackID).TrackData = 0   
        .TrackID = -32768
      end if
    end with
  next iTrack
  
  AudioMutex = 0
  
end sub
sub AddToTrack(iNum as short,pData as any ptr,iSize as short,iVol as short,iPan as short)
  const FromMemory = FSOUND_LOADRAW or FSOUND_LOADMemory
  const SoundMode = FSOUND_8BITS or FSOUND_MONO or FSOUND_UNSIGNED  
  if iSize < 0 then exit sub
  dim as integer iLen = cuint(iSize) 
  UpdateAudioState(__LINE__)
  dim as integer FreeStack
  while iNum > TRACK_UBOUND
    ErrOut("Track Number Above limit %i",iNum)
    iNum -= 64    
  wend
  
  do    
    for FreeStack = 0 to SAMPLE_UBOUND
      with SampleStack(FreeStack)
        if .SamplePtr andalso .TrackNum < 0 then
          FSOUND_Sample_Free(.SamplePtr): .SamplePtr = 0
        end if
        if .SamplePtr = 0 then exit do
      end with
    next FreeStack      
    ErrOut("Sample Stack is full? O_O")
    sleep
    UpdateAudioState(__LINE__)    
  loop
  with SampleStack(FreeStack)
    .SampleSz = iLen 'iSize
    .TrackNum = iNum
    .SliceID = TrackPtr(iNum).LastID+1
    dim SampleBuff as any ptr,SampleExtra as integer
    if ExtraBuff then
      memcpy(ExtraBuff,pData,iLen)
      SampleBuff = ExtraBuff: SampleExtra = 22050\90
      memset(ExtraBuff+iLen,*cptr(ubyte ptr,pData+iLen-1),SampleExtra)
    else
      SampleBuff = pData: SampleExtra = 0
    end if
    .SamplePtr = FSOUND_Sample_Load(FSOUND_FREE,SampleBuff, _
    FSOUND_LOOP_OFF or SoundMode or FromMemory,0,iLen+SampleExtra)    
    FSOUND_Sample_SetDefaults(.SamplePtr,22050,iVol,(iPan+99)*(128/100),-1)
    if .SamplePtr = 0 then
      ErrOut("Failed to Create Sample (%i)",iLen)      
    else
      static as integer MaxSz
      if iLen > MaxSz then MaxSz = iLen
      'ErrOut("New Sample(%i)%8X Trk=%i\n  Sz=%i(%i) Vol=%i Pan=%i", _
      'FreeStack,.SamplePtr,iNum,iSize,MaxSz,iVol,iPan)
      with TrackPtr(iNum)
        .LastID += 1 : .SampleCount += iLen : .Samples += 1        
      end with
      MemoryUsage += (iLen+64)
    end if
  end with  
  
end sub
sub RescaleBuffer(SrcBuffer as any ptr)
  static as integer mods,iDirect=320,iChange,iFlip=320
  dim as integer CNT
  
  mods = 0'xor= 1  
  var inPtr = SrcBuffer+sizeof(fb.image)+4*320 
  var OutPtr = screenptr  
  
  if mods then    
    if iChange >= 5 andalso iDirect then 
      iDirect xor= iFlip: iFlip = -iFlip: iChange = 0
    else  
      iDirect xor= iFlip
    end if
    iChange += 1: inPtr += iDirect
    #ifdef __FB_NDS__
    asm     '                                                   
      ldr r5, $InPtr          'r5 = ImgBk+sizeof(fb.image)      
      ldr r6, $OutPtr         'r6 = ScrBk (screenptr)           
      mov r7, #49152          'r7 = ((256*192)-1)               
      sub r7, #1              '-^                               
      mov r8, #0x0000FF00     'r8  = 0x0000FF00                 
      mov r9, #0x00FF0000     'r9  = 0x00FF0000                 
      add r10, r9, r9, LSL #8 'r10 = 0xFFFF0000                 
      mvn r11, r10            'r11 = 0x0000FFFF                 
      0: ldmia r5 !,{r0-r4}   '  load r0 to r4 from [r6]        
      and r12, r4,r10         'r12 = in5 and &hFFFF0000         4
      and r4 , r8, r4,LSL #8  'r4  = (in5 shl 8) and &hFF00     4
      add r4 , r3,    LSR #24 'r4 += (in4 shr 24)               4
      add r4 ,r12             'r4 += r12                        4
      and r3 ,r10, r3,LSL #8  'r3  = (in4 shl 8) and &hFFFF0000 3
      add r3 , r2,    LSR #16 'r3 += (in3 shr 16)               3
      and r12,r11, r1,LSR #8  'r12 = (in2 shr 8) and &hFFFF     2
      add r2 ,r12, r2,LSL #16 'r2  = r12+(in3 shl 16)           2
      and r12, r0,r11         'r12 = (in1 and &hFFFF)           1
      and r0,  r9, r0,LSR #8  'r0  = (in1 shr 8) and &hFF0000   1
      add r0,  r1,    LSL #24 'r0 += (in2 shl 24)               1
      add r0,  r12            'r0 += r12                        1
      stmia r6 !,{r0,r2-r4}   '  store r0,r2 to r4 at [r6]      
      subs r7, #16            '  loop while r7 >=0              
      bpl 0b                  '  -^                             
    end asm '                                                   
    #else
    for CNT = (256*192) to 1 step -16
      var In1 = *cptr(uinteger ptr, InPtr+ 0)
      var In2 = *cptr(uinteger ptr, InPtr+ 4)
      var In3 = *cptr(uinteger ptr, InPtr+ 8)
      var In4 = *cptr(uinteger ptr, InPtr+12)
      var In5 = *cptr(uinteger ptr, InPtr+16)
      *cptr(uinteger ptr, OutPtr+ 0) = (in1 and &hFFFF)+((in1 and &hFF000000) shr 8)+(in2 shl 24)
      *cptr(uinteger ptr, OutPtr+ 4) = ((in2 shr 8) and &hFFFF)+(in3 shl 16)
      *cptr(uinteger ptr, OutPtr+ 8) = (in3 shr 16)+((in4 shl 8) and &hFFFF0000)
      *cptr(uinteger ptr, OutPtr+12) = (in4 shr 24)+((in5 and &hFF) shl 8) +(in5 and &hFFFF0000)
      InPtr += 20: OutPtr += 16
    next CNT 
    #endif
  else
    #ifdef __FB_NDS__
    asm     '                                               
      ldr r5, $inPtr          'r5 = ImgBk+sizeof(fb.image)  
      ldr r6, $OutPtr         'r6 = ScrBk (screenptr)       
      mov r7, #49152          'r7 = ((256*192)-1)           
      0: ldmia r5,{r0-r4}     'load r0 to r4 from [r6]      
      add r5, #20             'point to after it            
      mov r4, r4, LSL #8      'r4 = (In5 shl 8)             
      add r4, r3, LSR #24     'r4 += (In4 shr 24)           
      mov r3, r3, LSL #16     'r3 = (In4 shl 16)            
      add r3, r2, LSR #16     'r3 += (In3 shr 16)           
      mov r2, r2, LSL #24     'r2 = (In3 shl 24)            
      add r2, r1, LSR #8      'r2 += (In2 shr 8)            
      stmia r6,{r0,r2-r4}     'store r0,r2 to r4 at [r6]    
      add r6, #16             'point to after it            
      subs r7, #16            ' loop while r7 >=0           
      bpl 0b                  '                             
    end asm '                                               
    #else
    for CNT = (256*192) to 1 step -16
      var In1 = *cptr(uinteger ptr, InPtr+ 0)
      var In2 = *cptr(uinteger ptr, InPtr+ 4)
      var In3 = *cptr(uinteger ptr, InPtr+ 8)
      var In4 = *cptr(uinteger ptr, InPtr+12)
      var In5 = *cptr(uinteger ptr, InPtr+16)
      *cptr(uinteger ptr, OutPtr+ 0) = In1
      *cptr(uinteger ptr, OutPtr+ 4) = (In2 shr  8)+(In3 shl 24)
      *cptr(uinteger ptr, OutPtr+ 8) = (In3 shr 16)+(In4 shl 16)
      *cptr(uinteger ptr, OutPtr+12) = (In4 shr 24)+(In5 shl 8)
      InPtr += 20: OutPtr += 16
    next CNT
    #endif
  end if
  
end sub
#ifdef __FB_NDS__
sub UpdateJitter(ID as any ptr)
  if UpdateBuffer then
    RescaleBuffer(UpdateBuffer)
    UpdateAudioState(__LINE__)
  end if
end sub
#endif

FSOUND_Init(44100,8,null)
'ExtraBuff=callocate(65536)
SanBuff=allocate(65536+1024)
StoredFrame=ImageCreate(320,200,,8)
ImgBuffer=ImageCreate(320,500,,8)
with *cptr(fb.image ptr,ImgBuffer)
  .Width = 320: .Height = 200: .Pitch = 320
end with
ImgBuffer2=ImgBuffer+&h3E00+320*200
memcpy(ImgBuffer2,ImgBuffer,sizeof(fb.image))
MemoryUsage = 65536*1+1024+((320*500+64))+(320*200+64)+16384

#ifdef On_x86
'dim as string NewFile = "JG.SAN"
'dim as string NewFile = "NITEFADE.SAN"
'dim as string NewFile = "CREDITS.SAN"
'dim as string NewFile = "BOLUSKIL.SAN"
dim as string SanFileName,SanDir = exepath+"/"'"h:\fromdata\games4\fullt\VIDEO\"
#ifndef NewFile
dim as string NewFile = dir$(SanDir+"*.SAN")
#endif
#else
dim as string SanFileName,Sandir,NewFile
#ifdef __FB_FAT__
SanDir = ""'"DATA/Games/Fullt/VIDEO/"
dim as string FileLIst(...) = { "2009_10.SAN","ACCIDENT.SAN","BARKDOG.SAN", _
"BC.SAN","BENBURN.SAN","BENESCPE.SAN","BENHANG.SAN","BIGBLOW.SAN", _
"BIKESWAR.SAN","BOLUSKIL.SAN","BURST.SAN","BURSTDOG.SAN","CABSTRUG.SAN", _
"CATCHUP.SAN","CES_NITE.SAN","CREDITS.SAN","CRUSHDOG.SAN","CVRAMP.SAN", _
"DAZED.SAN","DRIVEBY.SAN","ESCPPLNE.SAN","FANSTOP.SAN","FIRE.SAN", _
"FI_14.SAN","FI_14_15.SAN","FLINCH.SAN","FULPLANE.SAN","GOTCHA.SAN", _
"GR_LOS.SAN","GR_WIN.SAN","HI_SIGN.SAN","INTO_FAN.SAN","INTRO4.SAN", _
"INTROD_8.SAN","JG.SAN","JUMPGORG.SAN","KICK_OFF.SAN","KILLGULL.SAN", _
"KR.SAN","KS_1.SAN","KS_11.SAN","KS_111.SAN","KS_IV.SAN","KS_V.SAN", _
"KS_X.SAN","LIMOBY.SAN","LIMOROAR.SAN","MOEJECT.SAN","MOREACH.SAN", _
"MO_FUME.SAN","MWC.SAN","NAMES_MO.SAN","NB_BLOW.SAN","NITEFADE.SAN", _
"NITERIDE.SAN","NTREACT.SAN","OFFGOGG.SAN","OM.SAN","PLNCRSH.SAN", _
"REACHHER.SAN","REALRIDE.SAN","REV.SAN","RIDEAWAY.SAN","RIDEOUT.SAN", _
"RIPBROW.SAN","RIPSHIFT.SAN","RIP_KILL.SAN","SCRAPBOT.SAN","SEEN_RIP.SAN", _
"SHEFALLS.SAN","SHORTOPN.SAN","SHOWSMRK.SAN","SHOWUP1.SAN","SNAPFOTO.SAN", _
"SNSETRDE.SAN","SQUINT.SAN","TC.SAN","TEETBURN.SAN","TINYPLNE.SAN", _
"TINYTRUC.SAN","TINYTRUK.SAN","TOKCRGO.SAN","TRKCRSH.SAN","VISION.SAN", _
"WEREINIT.SAN","WHIP_PAN.SAN","" }

#else
'dim as string FileList(...) = {"Intro1.san","Intro2.san",""}
dim as string FileLIst(...) = { "2009_10.SAN","ACCIDENT.SAN","BARKDOG.SAN", _
"BC.SAN","BENBURN.SAN","BENESCPE.SAN","BENHANG.SAN","BIGBLOW.SAN", _
"BIKESWAR.SAN","BOLUSKIL.SAN","BURST.SAN","BURSTDOG.SAN","CABSTRUG.SAN", _
"CATCHUP.SAN","CES_NITE.SAN","CREDITS.SAN","CRUSHDOG.SAN","CVRAMP.SAN", _
"DAZED.SAN","DRIVEBY.SAN","ESCPPLNE.SAN","FANSTOP.SAN","FIRE.SAN", _
"FI_14.SAN","FI_14_15.SAN","FLINCH.SAN","FULPLANE.SAN","GOTCHA.SAN", _
"GR_LOS.SAN","GR_WIN.SAN","HI_SIGN.SAN","INTO_FAN.SAN","INTRO4.SAN", _
"INTROD_8.SAN","JG.SAN","JUMPGORG.SAN","KICK_OFF.SAN","KILLGULL.SAN", _
"KR.SAN","KS_1.SAN","KS_11.SAN","KS_111.SAN","KS_IV.SAN","KS_V.SAN", _
"KS_X.SAN","LIMOBY.SAN","LIMOROAR.SAN","MOEJECT.SAN","MOREACH.SAN", _
"MO_FUME.SAN","MWC.SAN","NAMES_MO.SAN","NB_BLOW.SAN","NITEFADE.SAN", _
"NITERIDE.SAN","NTREACT.SAN","OFFGOGG.SAN","OM.SAN","PLNCRSH.SAN", _
"REACHHER.SAN","REALRIDE.SAN","REV.SAN","RIDEAWAY.SAN","RIDEOUT.SAN", _
"RIPBROW.SAN","RIPSHIFT.SAN","RIP_KILL.SAN","SCRAPBOT.SAN","SEEN_RIP.SAN", _
"SHEFALLS.SAN","SHORTOPN.SAN","SHOWSMRK.SAN","SHOWUP1.SAN","SNAPFOTO.SAN", _
"SNSETRDE.SAN","SQUINT.SAN","TC.SAN","TEETBURN.SAN","TINYPLNE.SAN", _
"TINYTRUC.SAN","TINYTRUK.SAN","TOKCRGO.SAN","TRKCRSH.SAN","VISION.SAN", _
"WEREINIT.SAN","WHIP_PAN.SAN","" }
#endif
dim as integer FilePosi = 0
NewFile = FileList(FilePOsi)
#endif

Cout("Starting...")

while len(NewFile)  
  #ifndef __FB_NDS__
  WindowTitle(NewFile)
  #else
  static as integer DidCb
  if DidCb = 0 then
    DidCb = 1
    fb_AddVsyncCallBack(@UpdateJitter,null,False) 
  end if
  print string$(31,32)+!"\r";
  print string$((32-len(NewFile)) shr 1,32)+NewFile
  #endif
  FrameCount = 0: ChunkSz = 0
  SanFileName = SanDir+NewFile
  IsFrameStored = 0
  
  memset(@SampleStack(0),0,(SAMPLE_UBOUND+1)*sizeof(SampleStack))
  memset(@TrackPtr(0),0,(TRACK_UBOUND+1)*sizeof(TrackPtr))
  memset(@TrackUsage(0),0,(SOUND_CHANNELS+1)*sizeof(TrackUsage))
  
  memset(SanBuff,0,65536+1024)
  
  if ImgBuffer > ImgBuffer2 then swap ImgBuffer,ImgBuffer2
  memset(ImgBuffer+sizeof(fb.image),0,320*500)
  ImgBuffer2=ImgBuffer+&h3E00+320*200
  memcpy(ImgBuffer2,ImgBuffer,sizeof(fb.image))
  
  for iTrack as integer = 0 to TRACK_UBOUND
    Trackptr(iTrack).CurrentID = 1
  next iTrack
  for iTrack as integer = 0 to SOUND_CHANNELS
    with TrackUsage(iTrack)
      .TrackID = -32768: .SampleID = -1
    end with
  next iTrack
  
  if open(SanFileName for binary access read as #SanFile)=0 then
    SanSize=lof(SanFile): SanBuffSz = 65536
    if SanBuffSz > SanSize then SanBuffSz = SanSize 
    SanBuffEnd = SanBuffSz: SanPtr = SanBuff
    get #SanFile,1,*cptr(ubyte ptr,SanBuff),SanBuffSz
    
    #define HeadOfType(tType) *cptr(tType ptr, SanPtr+sizeof(HeaderStruct))  
    #define ChunkHeader() *cptr(HeaderStruct ptr,SanPtr)
    #define IsGenericHeader() if ChunkSz > 0 then ChunkSz=0
    
    static as double TMR
    TMR = timer
    
    do
      
      with ChunkHeader()
        UpdateAudioState(__LINE__)        
        if ChunkSz >= 0 then  
          ChunkSz = GetChunkSz(MakeInt(.iSize))          
          if ChunkSz < 0 then ChunkSz = 65536*2
          ChunkType = MakeInt(.iType)
          dim as uinteger BufferPos = cuint(SanPtr-SanBuff)          
          if ChunkType <> cvi("ANIM") and chunkType <> cvi("FRME") then
            var NextChunkSz = BufferPos+ChunkSz+(sizeof(HeaderStruct) shl 2)
            'Errout("Pos=%i Next=%i End=%i Sz=%i SanLeft=%i", _
            'BufferPos,NextChunkSz,SanBuffEnd,SanBuffSz,SanSize-SanBuffSz)
            if NextChunkSz >= SanBuffEnd then
              SanSize -= SanBuffSz              
              if SanSize > 0 then
                var RemainBuffSz = (SanBuffEnd-BufferPos)
                SanBuffSz = 65536-RemainBuffSz 'BufferPos                
                memcpy(SanBuff,SanPtr,RemainBuffsz)            
                if SanBuffSz > SanSize then SanBuffSz=SanSize                
                SanPtr = SanBuff: SanBuffEnd = SanBuffSz+RemainBuffSz
                var TgtPtr = cptr(ubyte ptr,SanBuff+RemainBuffSz)
                'Errout("Rem=%i BuffSz=%i End=%i (%i)", _
                'RemainBuffSz,SanBuffSz,SanBuffEnd,RemainBuffSz+SanBuffSz)
                get #SanFile,,*TgtPtr,SanBuffSz                
                continue do
              end if
            end if
          end if
        end if
      end with
      
      with ChunkHeader()     
        'Cout("Chunk Type: %s",mki(ChunkType)): sleep
        select case ChunkType
        case cvi("FOBJ")             'Frame Object
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)
          RenderLastFrame = 1          
          with HeadOfType(FrameObjectStruct)
            Cout("          .Codec=%i",.Codec)
            Cout("          .Position=%i,%i",.PosX,.PosY)
            Cout("          .Size=%ix%i",.Wid,.Hei)
            if .Wid > 320 or .Hei > 200 then exit do
            dim as any ptr ObjPtr = @.ObjectData
            pBuff = ImgBuffer+sizeof(fb.image)+.Posy*320+.PosX
            select case .Codec
            case 1,3 '----------- transparent ----------
              dim as ubyte ptr DataPtr = ObjPtr              
              for Y as integer = 0 to .hei-1 'to -1 step -1
                dim as integer LineLen = cuint(*Dataptr) or (cuint(DataPtr[1]) shl 8)
                DataPtr += 2
                'printf("LineLen=%i ",LineLen): sleep
                while LineLen > 0
                  var uCode = *cptr(ubyte ptr,DataPtr)
                  'printf("%i ",uCode)
                  if (uCode and 1) then                   
                    uCode = (uCode shr 1)+1
                    var Pix = *cptr(ubyte ptr,DataPtr+1)
                    if Pix then memset(pBuff,Pix,uCode)
                    pBuff += uCode: DataPtr += 2: LineLen -= 2
                  else
                    uCode = (uCode shr 1)+1: DataPtr += 1
                    for CNT as uinteger = 0 to cuint(uCode)-1                      
                      if *cptr(ubyte ptr,DataPtr) then
                        *cptr(ubyte ptr,pBuff) = *cptr(ubyte ptr,DataPtr)
                      end if
                      pBuff += 1: DataPtr += 1
                    next CNT
                    LineLen -= (cuint(uCode)+1)
                    'OutSz += uCode
                  end if                                    
                wend
                DataPtr += LineLen
                'put(.Posx,.Posy+Y+200),ImgBuffer2,(.Posx,.Posy+Y)-(.Posx+.wid-1,.Posy+y),pset
              next Y
              'put(0,200),ImgBuffer2,pset
              'sleep
            case 37 '1,3,21,37,44
              dim as integer BlkWid = (.wid + 3) shr 2
              dim as integer BlkHei = (.hei + 3) shr 2
              dim as integer BuffPit = BlkWid shl 2              
              with *cptr(Codec37Struct ptr,ObjPtr)
                var InSize = MakeInt(.InSz)
                var OutSize = MakeInt(.OutSz)
                var dwFlags = MakeInt(.Flags)
                Cout("          ..SubCodec=%i (%i)",.SubCodec,.Sequence)
                Cout("          ..Size=%i->%i",InSize,OutSize)
                Cout("          ..Index=%i:%i",.Index,dwFlags)              
                dim as any ptr DataPtr = @.EncodedData              
                dim as any ptr DataEnd = DataPtr+InSize
                dim as any ptr BuffEnd = pBuff+OutSize
                dim as integer OutSz = 0
                
                static as integer Init=0
                if _offset_table=0 then                  
                  _offset_table = allocate(256*sizeof(short))                
                  _table_last_pitch = -1: _table_last_index = -1                  
                end if
                codec37_MakeTable(BuffPit, .Index)
                
                if (.Sequence and 1) orelse (dwFlags and 1)=0 then
                  swap ImgBuffer,ImgBuffer2 '_curtable xor= 1
                end if
                
                select case .SubCodec
                case 3',4       'Block Selection
                  #macro VarExpand(iTarget,iSource)
                  dim as uinteger iTarget = iSource
                  iTarget += (iTarget shl 8): iTarget += (iTarget shl 16)
                  #endmacro          
                  #macro SetBlock(i1,i2,i3,i4)
                  dim as uinteger ptr pBlockBuff = cast(any ptr,pBuff)                  
                  *pBlockBuff = i1: pBlockBuff += BlkWid
                  *pBlockBuff = i2: pBlockBuff += BlkWid
                  *pBlockBuff = i3: pBlockBuff += BlkWid
                  *pBlockBuff = i4
                  #endmacro                
                  #define GetByte(iOffs) *cptr(ubyte ptr,DataPtr+iOffs)
                  #define Bt(iOffs,iS) (cuint(*cptr(ubyte ptr,DataPtr+iOffs)) shl iS)                  
                  #define GetDword(iO) (Bt((iO),0)+Bt((iO)+1,8)+Bt((iO)+2,16)+Bt((iO)+3,24))
                  if (dwFlags and 1) or .SubCodec=4 then 'with fdfe?
                    for Y as integer = BlkHei to 1 step -1        
                      for X as integer = BlkWid to 1 step -1                      
                        select case GetByte(0)
                        case &hFD
                          VarExpand(pBlock,GetByte(1))
                          SetBlock(pBlock,pBlock,pBlock,pBlock)
                          OutSz += 1:pBuff += 4: DataPtr += (1+1)
                        case &hFE
                          VarExpand(pBlock1,GetByte(1))
                          VarExpand(pBlock2,GetByte(2))
                          VarExpand(pBlock3,GetByte(3))
                          VarExpand(pBlock4,GetByte(4))
                          SetBlock(pBlock1,pBlock2,pBlock3,pBlock4)
                          OutSz += (4+1):pBuff += 4: DataPtr += (4+1)         
                        case &hFF
                          SetBlock(GetDword(1),GetDword(5),GetDword(9),GetDword(13))
                          OutSz += (16+1):pBuff += 4: DataPtr += (16+1)
                        case else
                          dim as uinteger ptr pBlockBuff = cast(any ptr,pBuff)                        
                          var iOffset=cuint(pBlockBuff)-cuint(ImgBuffer2)
                          iOffset += _offset_table[GetByte(0)]                          
                          dim as uinteger ptr pBuffOld = cast(any ptr,ImgBuffer)+iOffset  
                          if (cuint(pBuffOld) and 3) then                            
                            #define Bt3(iOffs,iS) (cuint(cptr(ubyte ptr,pBuffOld+iOffset)[iOffs]) shl iS)                  
                            #define GetDwordB() (Bt3(0,0)+Bt3(1,8)+Bt3(2,16)+Bt3(3,24))
                            iOffset = 0       : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            #undef GetDwordB
                            #undef Bt3
                          else
                            iOffset = 0       : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                          end if
                          OutSz += (0+1): pBuff += 4 : DataPtr += (0+1)
                        end select
                      next X
                      pBuff += BuffPit*3
                    next Y
                  else                   'without fdfe
                    for Y as integer = BlkHei to 1 step -1         
                      for X as integer = BlkWid to 1 step -1                      
                        if GetByte(0) = &hFF then                    
                          SetBlock(GetDword(1),GetDword(5),GetDword(9),GetDword(13))
                          OutSz += (16+1): pBuff += 4: DataPtr += (16+1)
                        else                        
                          dim as uinteger ptr pBlockBuff = cast(any ptr,pBuff)                        
                          var iOffset=cuint(pBlockBuff)-cuint(ImgBuffer2)
                          iOffset += _offset_table[GetByte(0)]
                          dim as uinteger ptr pBuffOld = cast(any ptr,ImgBuffer)+iOffset
                          if (cuint(pBuffOld) and 3) then                            
                            #define Bt3(iOffs,iS) (cuint(cptr(ubyte ptr,pBuffOld+iOffset)[iOffs]) shl iS)                  
                            #define GetDwordB() (Bt3(0,0)+Bt3(1,8)+Bt3(2,16)+Bt3(3,24))
                            iOffset = 0       : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            iOffset += BlkWid : pBlockBuff[iOffset]=GetDwordB()
                            #undef GetDwordB
                            #undef Bt3
                          else
                            iOffset = 0       : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                            iOffset += BlkWid : pBlockBuff[iOffset]=pBuffOld[iOffset]
                          end if
                          OutSz += (0+1): pBuff += 4 : DataPtr += (0+1)
                        end if
                      next X
                      pBuff += BuffPit*3
                    next Y
                  end if                
                case 2         'RLE
                  while cuint(DataPtr) < cuint(DataEnd)
                    dim as ubyte uCode = *cptr(ubyte ptr,DataPtr)
                    if (uCode and 1) then                    
                      uCode = (uCode shr 1)+1
                      memset(pBuff,*cptr(ubyte ptr,DataPtr+1),uCode)
                      pBuff += uCode: DataPtr += 2: OutSz += uCode 
                    else
                      uCode = (uCode shr 1)+1
                      memcpy(pBuff,DataPtr+1,uCode)
                      pBuff += uCode: DataPtr += cuint(uCode)+1: OutSz += uCode
                    end if                                    
                  wend
                  memcpy(ImgBuffer,ImgBuffer2,320*200)
                  'Cout("%04X > %04X | %04X > %04X (%i)",pBuff,BuffEnd,DataPtr,DataEnd,OutSz)
                case else      'Unknown?
                  'line ImgBuffer2,(0,0)-(319,199),0,bf
                  Errout(" > Unsupport sub-code: %i< ",.SubCodec)                  
                end select
                
                if OutSz <> OutSize then 
                  Errout(" > Error... < OutSz is %i but Should Be %i",OutSz,OutSize)                  
                end if                
                
              end with            
              
            case else
              Errout("          {Unknown Codec (%i)}",.Codec)              
              RenderLastFrame = 0
            end select
          end with
          
        case cvi("PSAD")             'Audio Block
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(FrameAudioStruct)
            Cout("          .Track=%i (%i->%i) ",.TrackID,.Index,.IndexCount)
            Cout("          .Voume=%i (%i)",.Volume,.Balance)
            Cout("          .Flags=%X",.Flags)
            var SampleSz = ChunkSz-(sizeof(FrameAudioStruct)+4)
            SampleSz and= (not 1)
            if FrameSync then
              AddToTrack(.TrackID,@.SoundData,SampleSz,.Volume,.Balance)
            end if
          end with
        case cvi("FRME")             'Frame Chunk
          
          FrameSize = ChunkSz: FrameReady = 0
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          NextFrame = SanPtr+sizeof(HeaderStruct)+ChunkSz
          IsGenericHeader()          
          
        case cvi("XPAL")             'Palette Effect
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(ChgPaletteStruct)
            Cout("        .Size=%i (%i)",.PalSize,.Unknown)
            if ChunkSz = 6 then
              Cout("        .Index=%i",.Index)
              if .Index then
                for CNT as integer = 0 to 256*3-1
                  #define x CurPal(CNT)
                  dim as uinteger Temp = cuint(x)+cint(DeltaPal(CNT))*2
                  if Temp > 65535 then x = cshort(Temp) shr 16 else x = temp              
                next CNT
              end if
            else
              for CNT as integer = 0 to 256*3-1                
                CurPal(CNT) = cushort(.NewPal(CNT)) shl 8
              next CNT
              memcpy(@DeltaPal(0),@.PalDelta(0),256*3*sizeof(short))
            end if          
          end with
          RenderLastFrame = 1
        case cvi("TRES")             'Subtitle
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          RenderLastFrame = 1
        case cvi("FTCH")             'Restore Frame
          if IsFrameStored then
            put ImgBuffer,(0,0),StoredFrame,pset          
            UpdateAudioState(__LINE__)
          end if
          RenderLastFrame = 1
        case cvi("STOR")             'Store Frame
          put StoredFrame,(0,0),ImgBuffer,pset    
          UpdateAudioState(__LINE__)
          IsFrameStored = 1
        case cvi("NPAL")             'New Palette
          cout("        %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(NewPaletteStruct)          
            for CNT as integer = 0 to 767
              CurPal(CNT) = cushort(.NewPal(CNT)) shl 8
            next CNT
          end with
          RenderLastFrame = 1
        case cvi("AHDR")             'Animation Info        
          cout("    %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(AnimHeaderStruct)
            Cout("      .Version=%i",.Version)
            Cout("      .Frames=%i",.Frames)
            FrameTotal = .Frames
            if .Version = 2 then
              Cout("      .Sampling=%i",MakeInt(.v2Frequency))
            end if
            for CNT as integer = 0 to 767
              CurPal(CNT) = cushort(.StartPal(CNT)) shl 8
            next CNT
            #if 0
            LitPal=0: LitColor = 255
            dim as any ptr PalPtr = @.StartPal(0)
            for CNT as integer = 0 to 255
              var iColor = *cptr(uinteger ptr,PalPtr) and &hFFFFFF
              if iColor > LitPal then LitPal=iColor:LitColor=CNT            
              PalPtr += 3
            next CNT
            LitColor = 15
            for Y as integer = 0 to 15
              for X as integer = 0 to 15              
                line(328+X*19,4+Y*12)-(328+X*19+18,Y*12+15),Y*15+X,BF
                line(328+X*19,4+Y*12)-(328+X*19+19,Y*12+16),LitColor,B
              next X
            next Y          
            #endif
          end with          
        case cvi("ANIM")             'Main Header
          Cout("%s \t Size:%8i \t Total:%8i",mki(ChunkType), ChunkSz,SanSize-8)      
          IsGenericHeader()          
        case cvi("IACT")             'Audio Track
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          ErrOut("IACT not implemented yet...")
        case cvi("SKIP")             'Video Marker
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          ErrOut("SKIP not implemented yet...")
        case else                    'Unknown Header
          Errout(">>> Unknown Header: %s of size %i <<<",mki(ChunkType),ChunkSz)          
          sleep 500,1: exit do
        end select
      end with
      
      if (ChunkSz and 1) then ChunkSz += 1
      SanPtr += sizeof(HeaderStruct)+ChunkSz
      FrameReady += sizeof(HeaderStruct)+ChunkSz
      
      dim as uinteger TempType = MakeInt(cptr(HeaderStruct ptr,SanPtr)->iType)      
      if TempType = cvi("FRME") then 
        FrameReady = FrameSize
      end if
      
      if FrameReady >= FrameSize and RenderLastFrame then
        RenderLastFrame = 0
        
        dim as integer SampleSum=0,SampleSz=0            
        for CNT as integer = 0 to SOUND_CHANNELS
          with TrackUsage(CNT)
          if .SamplePtr then
            dim as uinteger AvgSz = Timer-(.StartTime*22050)
            with TrackPtr(.TrackID)                
              if .TrackData andalso .SampleCount then
                dim as integer iSz = .SampleCount-AvgSz
                'if cuint(iSz) < 65535 then
                SampleSz += iSz: SampleSum += 1
                'end if
              end if              
            end with
          end if
          end with
        next CNT
        
        dim as single WaitAmount
        dim as integer FpsWanted
        if SampleSum then FpsWanted = SampleSz\SampleSum
        if SampleSum then
          if (SampleSz\SampleSum) > 22050 then
            WaitAmount = 1/9.5: FpsWanted = 9
          elseif (SampleSz\SampleSum) < (6*(22050\10)) then
            WaitAmount = 1/10.5: FpsWanted = 10
          elseif (SampleSz\SampleSum) < (3*(22050\10)) then
            WaitAmount = 1/11.5: FpsWanted = 11
          end if
        else
          WaitAmount = 1/10: FpsWanted = 10
        end if
        if WaitAmount = 0 then              
          WaitAmount = 1/9: FpsWanted = 9
        end if
        if FrameSync = 0 then WaitAmount = 1/60
        
        dim as integer Temp
        if SampleSum=0 then Temp=0 else Temp=SampleSz\SampleSum
        #ifdef __FB_NDS__
        var TextOut = "[" & FrameCOunt & ">" & FrameTotal & "]{" & FpsWanted & !"}"
        while len(TextOut) < 15: TextOut += " ": wend
        Print TextOut+"Memory:" & MemoryUsage\1024 & !"kb  \r";
        #else
        WindowTitle(NewFile+" [" & FrameCOunt & ">" & FrameTotal & _
        "] {" & FpsWanted & "} " & ((Temp*100)\(6*(22050\10))) & _
        " Memory: " & MemoryUsage\1024 & "kb")
        #endif
        
        UpdateAudioState(__LINE__)
        
        #ifndef on_x86
        dim as integer PalNum = 0
        for CNT as integer = 0 to 767 step 3            
          #define Att(x) (CurPal(CNT+x) shr 8)
          palette PalNum,Att(0),Att(1),Att(2)
          PalNum += 1
        next CNT
        #endif
        
        #ifdef On_x86
        static as any ptr Buffer16,Buffer16b
        static as ushort Pal16(255)
        static as ushort RandTab(32767),RandPos          
        if Buffer16 = 0 then 
          dim as ushort Noises(5) = { _
          &b0000100000000001, &b0001100000000000, _
          &b0000100000100000, &b0000000001100000, _
          &b0000000000100001, &b0000000000000011 }
          for CNT as integer = 0 to 32767              
            RandTab(CNT) = int(rnd*65536) and Noises(int(rnd*6))
          next CNT            
          Buffer16 = imagecreate(320,200)
          Buffer16b = imagecreate(320,200)
        end if
        dim as integer PalNum = 0          
        for CNT as integer = 0 to 767 step 3            
          #define Att(x) (CurPal(CNT+x) shr 8)              
          Pal16(PalNum) = (CurPal(CNT) and &b1111100000000000) or _
          ((CurPal(CNT+1) shr  5) and &b0000011111100000) or _
          ((CurPal(CNT+2) shr 11) and &b0000000000011111)            
          PalNum += 1
        next CNT          
        RandPos = int(rnd*65536) and (not 3)
        asm
          mov ebx,[ImgBuffer2]
          mov edi,[Buffer16b]            
          add ebx,(sizeof(fb.image))
          add edi,(sizeof(fb.image))            
          mov ecx, 320*200
          0: movzx eax, byte ptr [ebx]
          add ebx, 1
          lea esi,[Pal16+eax*2]
          movsw
          sub ecx, 1
          jnz 0b
        end asm
        for CNT as integer = 2 to 1 step -1
          UpdateAudioState(__LINE__)
          put buffer16,(0,0),buffer16b,alpha,383-(CNT shl 7)
          UpdateAudioState(__LINE__)
          dim Target as any ptr = screenptr, TargetSz as integer = 320*400            
          screenlock
          select case DoubleMode
          case 0: bpp16.rgb2x(Buffer16+sizeof(fb.image),screenptr)
          case 1: bpp16.resize2x(Buffer16+sizeof(fb.image),screenptr)
          case 2: bpp16.scale2x(Buffer16+sizeof(fb.image),screenptr)
          case 3: put(0,0),buffer16,pset: TargetSz \= 4
          end select
          screenunlock
          UpdateAudioState(__LINE__)
          
          if DoNoise then
            asm
              mov edi,[Target]
              mov ecx,[TargetSz]
              mov edx,[RandPos]
              0:
              mov eax,[RandTab+edx]
              add edx,4
              xor [edi],eax
              and edx,65535
              add edi,4
              dec ecx
              jnz 0b
            end asm
          end if
          
          screenunlock
          if abs(timer-TMR) > 1 then TMR = timer            
          while (timer-TMR) < (WaitAmount/CNT)
            UpdateAudioState(__LINE__)
            sleep 1,1            
          wend        
          screenlock
        next CNT
        TMR += WaitAmount
        #else        
        if abs(timer-TMR) > 1 then TMR = timer
        UpdateAudioState(__LINE__)
        do 
          UpdateAudioState(__LINE__)          
          #ifdef __FB_NDS__
          UpdateBuffer = ImgBuffer2
          if (timer-TMR) >= WaitAmount then exit do
          screensync
          #else
          RescaleBuffer(ImgBuffer2)
          if (timer-TMR) >= WaitAmount then exit do
          screensync
          screenunlock
          UpdateAudioState(__LINE__)          
          screenlock
          #endif
        loop            
        UpdateAudioState(__LINE__)        
        TMR += WaitAmount
        
        #endif
        
        FrameCount += 1: 'screensync
        
        #if 0
        line(0,200)-(640,400),0,bf
        color 15: locate 26,1
        print "Memory Usage: " & MemoryUsage\1024 & "kb"            
        for CNT as integer = 0 to TRACK_UBOUND
          with TrackData(CNT)
            dim as integer iSz = .SampleCount-((Timer-.StartTime)*22050)
            if cuint(iSz) < 65535 then
              print CNT & "(" & .Samples & "/" & iSz & ")  ";
            end if
          end with
        next CNT
        #endif
        
        #ifndef __FB_NDS__        
        screenunlock
        #endif
        UpdateAudioState(__LINE__)        
        
      end if
      
      UpdateAudioState(__LINE__)
      if ChunkSz < 0 or SanSize <=0 then exit do      
      
      do
        static as integer DeskWid,DeskHei
        
        #ifdef __FB_NDS__
        #define KeyEnter() Key[1] = fb.Sc_ButtonA
        #define KeyTab()   Key[1] = fb.Sc_ButtonX
        #else
        #define KeyEnter() Key[0] = 13
        #define KeyTab()   Key[0] = 9
        #endif
        
        var Key = Inkey$
        if Len(Key)=0 then exit do
        if KeyEnter()      then exit do,do
        if Key[1]=fb.SC_F1 then 
          DoubleMode = (DoubleMode+1) and 3
          #ifdef On_x86
          if DoubleMode = 0 or DoubleMode=3 then
            dim as integer ResX = 640, ResY = 400, fbwnd
            if DoubleMode = 3 then ResX = 320: ResY = 200
            if ModeFull then
              screenres ResX,ResY,16,,fb.gfx_high_priority or _
              fb.gfx_no_switch or fb.gfx_no_frame            
              screencontrol(fb.GET_WINDOW_HANDLE,fbwnd)
              ShowWindow(cast(hwnd,fbwnd),SW_HIDE)
              SetWindowPos(cast(hwnd,fbwnd),HWND_TOPMOST, _
              0,0,DeskWid,DeskHei,swp_nozorder or swp_showwindow)
            else
              screenres ResX,ResY,16,,fb.gfx_high_priority or fb.gfx_no_switch
            end if
          end if
          #endif
        end if
        if Key[1]=fb.SC_F2 then
          #ifdef On_x86
          ModeFull xor= 1
          dim as integer ResX = 640, ResY = 400
          if DoubleMode = 3 then ResX = 320: ResY = 200
          if ModeFull then
            dim as integer fbwnd
            screen 0: screeninfo DeskWid,DeskHei
            screencontrol(fb.SET_DRIVER_NAME,"DDRAW")
            screenres ResX,ResY,16,,fb.gfx_high_priority or _
            fb.gfx_no_switch or fb.gfx_no_frame            
            screencontrol(fb.GET_WINDOW_HANDLE,fbwnd)
            ShowWindow(cast(hwnd,fbwnd),SW_HIDE)
            SetWindowPos(cast(hwnd,fbwnd),HWND_TOPMOST, _
            0,0,DeskWid,DeskHei,swp_nozorder or swp_showwindow)            
          else
            screencontrol(fb.SET_DRIVER_NAME,"GDI")
            screenres ResX,ResY,16,,fb.gfx_high_priority or fb.gfx_no_switch
          end if
          #endif
        end if
        if Key[1]=fb.SC_F3 then DoNoise xor= 1        
        if KeyTab()        then FrameSync xor= 1
        if Key[1]=asc("k") then FrameSync = -1: exit while
        if Key[0]=27       then FrameSync = -1: exit while
      loop
      
    loop
    
    screenunlock
    close #SanFile
    if ChunkSz < 0 then
      do
        for CNT as integer = 0 to 10
          UpdateAudioState(__LINE__)
          sleep 1,1        
        next CNT        
        UpdateAudioState(__LINE__)
        for CNT as integer = 0 to SAMPLE_UBOUND
          if SampleStack(CNT).SamplePtr then continue do
        next CNT
        exit do
      loop
    end if    
    for iTrack as integer = 0 to SOUND_CHANNELS
      with TrackUsage(iTrack)
        if .SamplePtr then FSOUND_StopSound(iTrack)
      end with
    next iTrack      
    for iCNT as integer = 0 to SAMPLE_UBOUND
      with SampleStack(iCNT)
        if .SamplePtr then 
          FSOUND_Sample_Free(.SamplePtr): .SamplePtr = 0
          MemoryUsage -= (.SampleSz+64)
        end if
      end with
    next iCNT    
    
  end if
  
  #ifdef On_x86
  NewFile = dir$()  
  #else
  FilePosi += 1
  NewFile = FileList(FilePosi)
  #endif
  
wend
printf("Done!")
if FrameSync <> -1 then sleep else sleep 200,1

sub codec37_MakeTable(pitch as integer,index as integer)
  static as short maketable_bytes(...) = { _
  + 0,  0,  1,  0,  2,  0,  3,  0,  5,  0,  8,  0, 13,  0, 21,  0,_
  +-1,  0, -2,  0, -3,  0, -5,  0, -8,  0,-13,  0,-17,  0,-21,  0,_
  + 0,  1,  1,  1,  2,  1,  3,  1,  5,  1,  8,  1, 13,  1, 21,  1,_
  +-1,  1, -2,  1, -3,  1, -5,  1, -8,  1,-13,  1,-17,  1,-21,  1,_
  + 0,  2,  1,  2,  2,  2,  3,  2,  5,  2,  8,  2, 13,  2, 21,  2,_
  +-1,  2, -2,  2, -3,  2, -5,  2, -8,  2,-13,  2,-17,  2,-21,  2,_
  + 0,  3,  1,  3,  2,  3,  3,  3,  5,  3,  8,  3, 13,  3, 21,  3,_
  +-1,  3, -2,  3, -3,  3, -5,  3, -8,  3,-13,  3,-17,  3,-21,  3,_
  + 0,  5,  1,  5,  2,  5,  3,  5,  5,  5,  8,  5, 13,  5, 21,  5,_
  +-1,  5, -2,  5, -3,  5, -5,  5, -8,  5,-13,  5,-17,  5,-21,  5,_
  + 0,  8,  1,  8,  2,  8,  3,  8,  5,  8,  8,  8, 13,  8, 21,  8,_
  +-1,  8, -2,  8, -3,  8, -5,  8, -8,  8,-13,  8,-17,  8,-21,  8,_
  + 0, 13,  1, 13,  2, 13,  3, 13,  5, 13,  8, 13, 13, 13, 21, 13,_
  +-1, 13, -2, 13, -3, 13, -5, 13, -8, 13,-13, 13,-17, 13,-21, 13,_
  + 0, 21,  1, 21,  2, 21,  3, 21,  5, 21,  8, 21, 13, 21, 21, 21,_
  +-1, 21, -2, 21, -3, 21, -5, 21, -8, 21,-13, 21,-17, 21,-21, 21,_
  + 0, -1,  1, -1,  2, -1,  3, -1,  5, -1,  8, -1, 13, -1, 21, -1,_
  +-1, -1, -2, -1, -3, -1, -5, -1, -8, -1,-13, -1,-17, -1,-21, -1,_
  + 0, -2,  1, -2,  2, -2,  3, -2,  5, -2,  8, -2, 13, -2, 21, -2,_
  +-1, -2, -2, -2, -3, -2, -5, -2, -8, -2,-13, -2,-17, -2,-21, -2,_
  + 0, -3,  1, -3,  2, -3,  3, -3,  5, -3,  8, -3, 13, -3, 21, -3,_
  +-1, -3, -2, -3, -3, -3, -5, -3, -8, -3,-13, -3,-17, -3,-21, -3,_
  + 0, -5,  1, -5,  2, -5,  3, -5,  5, -5,  8, -5, 13, -5, 21, -5,_
  +-1, -5, -2, -5, -3, -5, -5, -5, -8, -5,-13, -5,-17, -5,-21, -5,_
  + 0, -8,  1, -8,  2, -8,  3, -8,  5, -8,  8, -8, 13, -8, 21, -8,_
  +-1, -8, -2, -8, -3, -8, -5, -8, -8, -8,-13, -8,-17, -8,-21, -8,_
  + 0,-13,  1,-13,  2,-13,  3,-13,  5,-13,  8,-13, 13,-13, 21,-13,_
  +-1,-13, -2,-13, -3,-13, -5,-13, -8,-13,-13,-13,-17,-13,-21,-13,_
  + 0,-17,  1,-17,  2,-17,  3,-17,  5,-17,  8,-17, 13,-17, 21,-17,_
  +-1,-17, -2,-17, -3,-17, -5,-17, -8,-17,-13,-17,-17,-17,-21,-17,_
  + 0,-21,  1,-21,  2,-21,  3,-21,  5,-21,  8,-21, 13,-21, 21,-21,_
  +-1,-21, -2,-21, -3,-21, -5,-21, -8,-21,-13,-21,-17,-21,  0,  0,_
  +-8,-29,  8,-29,-18,-25, 17,-25,  0,-23, -6,-22,  6,-22,-13,-19,_
  +12,-19,  0,-18, 25,-18,-25,-17, -5,-17,  5,-17,-10,-15, 10,-15,_
  + 0,-14, -4,-13,  4,-13, 19,-13,-19,-12, -8,-11, -2,-11,  0,-11,_
  + 2,-11,  8,-11,-15,-10, -4,-10,  4,-10, 15,-10, -6, -9, -1, -9,_
  + 1, -9,  6, -9,-29, -8,-11, -8, -8, -8, -3, -8,  3, -8,  8, -8,_
  +11, -8, 29, -8, -5, -7, -2, -7,  0, -7,  2, -7,  5, -7,-22, -6,_
  +-9, -6, -6, -6, -3, -6, -1, -6,  1, -6,  3, -6,  6, -6,  9, -6,_
  +22, -6,-17, -5, -7, -5, -4, -5, -2, -5,  0, -5,  2, -5,  4, -5,_
  + 7, -5, 17, -5,-13, -4,-10, -4, -5, -4, -3, -4, -1, -4,  0, -4,_
  + 1, -4,  3, -4,  5, -4, 10, -4, 13, -4, -8, -3, -6, -3, -4, -3,_
  +-3, -3, -2, -3, -1, -3,  0, -3,  1, -3,  2, -3,  4, -3,  6, -3,_
  + 8, -3,-11, -2, -7, -2, -5, -2, -3, -2, -2, -2, -1, -2,  0, -2,_
  + 1, -2,  2, -2,  3, -2,  5, -2,  7, -2, 11, -2, -9, -1, -6, -1,_
  +-4, -1, -3, -1, -2, -1, -1, -1,  0, -1,  1, -1,  2, -1,  3, -1,_
  + 4, -1,  6, -1,  9, -1,-31,  0,-23,  0,-18,  0,-14,  0,-11,  0,_
  +-7,  0, -5,  0, -4,  0, -3,  0, -2,  0, -1,  0,  0,-31,  1,  0,_
  + 2,  0,  3,  0,  4,  0,  5,  0,  7,  0, 11,  0, 14,  0, 18,  0,_
  +23,  0, 31,  0, -9,  1, -6,  1, -4,  1, -3,  1, -2,  1, -1,  1,_
  + 0,  1,  1,  1,  2,  1,  3,  1,  4,  1,  6,  1,  9,  1,-11,  2,_
  +-7,  2, -5,  2, -3,  2, -2,  2, -1,  2,  0,  2,  1,  2,  2,  2,_
  + 3,  2,  5,  2,  7,  2, 11,  2, -8,  3, -6,  3, -4,  3, -2,  3,_
  +-1,  3,  0,  3,  1,  3,  2,  3,  3,  3,  4,  3,  6,  3,  8,  3,_
  -13,  4,-10,  4, -5,  4, -3,  4, -1,  4,  0,  4,  1,  4,  3,  4,_
  + 5,  4, 10,  4, 13,  4,-17,  5, -7,  5, -4,  5, -2,  5,  0,  5,_
  + 2,  5,  4,  5,  7,  5, 17,  5,-22,  6, -9,  6, -6,  6, -3,  6,_
  +-1,  6,  1,  6,  3,  6,  6,  6,  9,  6, 22,  6, -5,  7, -2,  7,_
  + 0,  7,  2,  7,  5,  7,-29,  8,-11,  8, -8,  8, -3,  8,  3,  8,_
  + 8,  8, 11,  8, 29,  8, -6,  9, -1,  9,  1,  9,  6,  9,-15, 10,_
  +-4, 10,  4, 10, 15, 10, -8, 11, -2, 11,  0, 11,  2, 11,  8, 11,_
  +19, 12,-19, 13, -4, 13,  4, 13,  0, 14,-10, 15, 10, 15, -5, 17,_
  + 5, 17, 25, 17,-25, 18,  0, 18,-12, 19, 13, 19, -6, 22,  6, 22,_
  + 0, 23,-17, 25, 18, 25, -8, 29,  8, 29,  0, 31,  0,  0, -6,-22,_
  + 6,-22,-13,-19, 12,-19,  0,-18, -5,-17,  5,-17,-10,-15, 10,-15,_
  + 0,-14, -4,-13,  4,-13, 19,-13,-19,-12, -8,-11, -2,-11,  0,-11,_
  + 2,-11,  8,-11,-15,-10, -4,-10,  4,-10, 15,-10, -6, -9, -1, -9,_
  + 1, -9,  6, -9,-11, -8, -8, -8, -3, -8,  0, -8,  3, -8,  8, -8,_
  +11, -8, -5, -7, -2, -7,  0, -7,  2, -7,  5, -7,-22, -6, -9, -6,_
  +-6, -6, -3, -6, -1, -6,  1, -6,  3, -6,  6, -6,  9, -6, 22, -6,_
  -17, -5, -7, -5, -4, -5, -2, -5, -1, -5,  0, -5,  1, -5,  2, -5,_
  + 4, -5,  7, -5, 17, -5,-13, -4,-10, -4, -5, -4,  3, -4, -2, -4,_
  +-1, -4,  0, -4,  1, -4,  2, -4,  3, -4,  5, -4, 10, -4, 13, -4,_
  +-8, -3, -6, -3, -4, -3, -3, -3, -2, -3, -1, -3,  0, -3,  1, -3,_
  + 2, -3,  3, -3,  4, -3,  6, -3,  8, -3,-11, -2, -7, -2, -5, -2,_
  +-4, -2, -3, -2, -2, -2, -1, -2,  0, -2,  1, -2,  2, -2,  3, -2,_
  + 4, -2,  5, -2,  7, -2, 11, -2, -9, -1, -6, -1, -5, -1, -4, -1,_
  +-3, -1, -2, -1, -1, -1,  0, -1,  1, -1,  2, -1,  3, -1,  4, -1,_
  + 5, -1,  6, -1,  9, -1,-23,  0,-18,  0,-14,  0,-11,  0, -7,  0,_
  +-5,  0, -4,  0, -3,  0, -2,  0, -1,  0,  0,-23,  1,  0,  2,  0,_
  + 3,  0,  4,  0,  5,  0,  7,  0, 11,  0, 14,  0, 18,  0, 23,  0,_
  +-9,  1, -6,  1, -5,  1, -4,  1, -3,  1, -2,  1, -1,  1,  0,  1,_
  + 1,  1,  2,  1,  3,  1,  4,  1,  5,  1,  6,  1,  9,  1,-11,  2,_
  +-7,  2, -5,  2, -4,  2, -3,  2, -2,  2, -1,  2,  0,  2,  1,  2,_
  + 2,  2,  3,  2,  4,  2,  5,  2,  7,  2, 11,  2, -8,  3, -6,  3,_
  +-4,  3, -3,  3, -2,  3, -1,  3,  0,  3,  1,  3,  2,  3,  3,  3,_
  + 4,  3,  6,  3,  8,  3,-13,  4,-10,  4, -5,  4, -3,  4, -2,  4,_
  +-1,  4,  0,  4,  1,  4,  2,  4,  3,  4,  5,  4, 10,  4, 13,  4,_
  -17,  5, -7,  5, -4,  5, -2,  5, -1,  5,  0,  5,  1,  5,  2,  5,_
  + 4,  5,  7,  5, 17,  5,-22,  6, -9,  6, -6,  6, -3,  6, -1,  6,_
  + 1,  6,  3,  6,  6,  6,  9,  6, 22,  6, -5,  7, -2,  7,  0,  7,_
  + 2,  7,  5,  7,-11,  8, -8,  8, -3,  8,  0,  8,  3,  8,  8,  8,_
  +11,  8, -6,  9, -1,  9,  1,  9,  6,  9,-15, 10, -4, 10,  4, 10,_
  +15, 10, -8, 11, -2, 11,  0, 11,  2, 11,  8, 11, 19, 12,-19, 13,_
  +-4, 13,  4, 13,  0, 14,-10, 15, 10, 15, -5, 17,  5, 17,  0, 18,_
  -12, 19, 13, 19, -6, 22,  6, 22,  0, 23 }	
  
  if _table_last_pitch = pitch andalso _table_last_index = index then exit sub		
  _table_last_pitch = pitch
  _table_last_index = index
  index *= 255
  
  for i as integer = 0 to 254
    dim as integer j = (i + index) shl 1
    _offset_table[i] = maketable_bytes(j + 1) * pitch + maketable_bytes(j)
  next i
  
end sub

