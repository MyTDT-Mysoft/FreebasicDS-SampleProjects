#define fbc -s console
'fbc -s console -gen gcc -O 2 -asm intel

#define DebugAudio
#define On_x86
'#define NitroData
'#define __FB_FAT__

#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
  #include "Modules\fmod.bas"
  DeclareResource(fultfont_tex)
  dim shared as any ptr FultFont
  FultFont=fultfont_tex
#else
  #include "fmod.bi"
  #include "crt.bi"
  #include "fbgfx.bi"
  chdir "NitroFiles/"
#endif

#ifndef __FB_NDS__
#include "windows.bi"
#endif

#ifdef On_x86  
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

#include "SmushMods\Types.bas"

dim shared as integer SanFile,SanSize,ChunkSz
dim shared as uinteger SanBuffSz,SanBuffEnd
dim shared as any ptr SanPtr,NextFrame,SanBuff
dim shared as ubyte ptr pBuff
dim shared as uinteger LitPal,LitColor
dim shared as integer FrameSync=1,iResu,ObjPerFrame
dim shared as integer FrameResize=0,DoDither=0,iSpeed=2
dim shared as integer FrameCount,FrameTotal,ChunkType,MustReset=1
dim shared as integer FrameReady,FrameSize,IsFrameStored
dim shared as integer DoubleMode=1,ModeFull=0,DoNoise,IsPlaying

dim shared sMessage as string,dMessage as double
dim shared sOSD as zstring*64,iOSD as integer
#define SetMessage(_TXT_) sMessage = _TXT_: dMessage = timer

const SAMPLE_UBOUND = 255,TRACK_UBOUND=127,SOUND_CHANNELS=7
const UNUSED_TRACK = -32768
static shared as SubtitleStruct tSubTitle(15)
dim shared as integer SubTitleCount,NewSubtitles
dim shared as SampleStackStruct SampleStack(SAMPLE_UBOUND)
dim shared as TrackStruct TrackUsage(SOUND_CHANNELS)
dim shared as TrackCross TrackPtr(TRACK_UBOUND)
dim shared as integer TrackMin,TrackMax,SampleMin,SampleMax
dim shared as ubyte ptr ImgBuffer,ImgBuffer2,ImgBuffs
dim shared as any ptr UpdateBuffer,SubtitleBuff,StoredFrame
dim shared as integer MemoryUsage,FPS,FpsWanted,MovieLeft
dim shared as short ptr _offset_table
dim shared as integer _table_last_pitch
dim shared as integer _table_last_index
static shared as short CurPal(767),AtuPal(767),CurPal2(767)
static shared as short DeltaPal(767),StoredPal(767)
dim shared as short BlendLevel,BlendFrames=0,IgnoreOjbs=0
dim shared as double FPT,TMR
dim shared as single WaitAmount,ZoomX=32
dim shared as string SanFileName,SanDir,NewFile2,SanDir2
dim shared as SubtitleInfoStruct ptr pSubtitle
dim shared as integer FilePosi = 0
dim shared as single GfxTime,DecodeTime
dim shared as integer GfxCount,DecodeCount,DecodeEnabled

#include "SmushMods\Subs.bas"

#ifndef __FB_NDS__
  'screencontrol(fb.SET_DRIVER_NAME,"GDI")
  'width 40,50
#endif
#ifdef On_x86
  timeBeginPeriod(1)
  'SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS)
#endif

#ifdef On_x86
  #ifdef DebugAudio
    screenres 640,600,16,,fb.gfx_high_priority or fb.gfx_no_switch
  #else
    screenres 640,400,16,,fb.gfx_high_priority or fb.gfx_no_switch
  #endif
#else
  screenres 256,192,8
#endif

#ifndef __FB_NDS__
scope
  dim as hwnd MyWND
  screencontrol(fb.GET_WINDOW_HANDLE,*cast(integer ptr,@MyWND))
  dim as rect ScrRect 
  GetWindowRect(GetDesktopWindow(),@ScrRect)
  with ScrRect
    var SX = .right-.left
    var SY = .bottom-.top
    SetWindowPos(MyWND,null,SX/4,SY/4,SX/2,SY/2,SWP_NOZORDER)
  end with
end scope
#endif

SanBuff=allocate(65536+1024)
ImgBuffer=ImageCreate(320,600,,8)
ImgBuffs=ImgBuffer
memcpy(ImgBuffer+&h3E00,ImgBuffer,sizeof(fb.image))
ImgBuffer += &h3E00
with *cptr(fb.image ptr,ImgBuffer)
  .Width = 320: .Height = 200: .Pitch = 320
end with
ImgBuffer2=ImgBuffer+&h3E00+320*200
memcpy(ImgBuffer2,ImgBuffer,sizeof(fb.image))
MemoryUsage = 65536*1+1024+320*600+16384
#ifdef __FB_NDS__
  vramSetBankB(VRAM_B_LCD)
  vramSetBankD(VRAM_D_LCD)
  vramSetBankE(VRAM_E_LCD)
  vramSetBankF(VRAM_F_LCD)
  SubtitleBuff=VRAM_B
  StoredFrame=VRAM_D
  dc_flushrange(ImgBuffer,sizeof(fb.image))
  dmacopywords(3,ImgBuffer,SubtitleBuff,sizeof(fb.image))
  dmacopywords(3,ImgBuffer,StoredFrame,sizeof(fb.image))
#else
  MemoryUsage += (320*200+sizeof(fb.image))*2
  StoredFrame=ImageCreate(320,200,,8)
  SubtitleBuff=ImageCreate(320,200)
#endif

if screenptr = 0 then Errout("Failed to init video...")
if SanBuff = 0 then Errout("Failed to allocate decode buffer")
if ImgBuffs = 0 then Errout("Failed to allocate frame buffer")
if SubtitleBuff = 0 then Errout("Failed to allocate subtitle buffer")
if StoredFrame=0 then Errout("Failed to allocate storage buffer")

FSOUND_Init(44100,8,null)

dim shared as string NewFile
dim as string FileLIst(...) = {"VIDEO/","INTROD_8.SAN","CREDITS.SAN","KS_X.SAN", _
  "KS_1.SAN","KS_11.SAN","KS_111.SAN","KS_IV.SAN","INTRO4.SAN","KS_V.SAN", _
  "REALRIDE.SAN","BC.SAN","DAZED.SAN","VISION.SAN","NAMES_MO.SAN", _
  "ACCIDENT.SAN","2009_10.SAN","MWC.SAN","NITEFADE.SAN","SEEN_RIP.SAN", _
  "SNAPFOTO.SAN","RIP_KILL.SAN","FLINCH.SAN","GOTCHA.SAN","RIPBROW.SAN", _
  "NITERIDE.SAN","BOLUSKIL.SAN", _
  "BENBURN.SAN","BENESCPE.SAN","BENHANG.SAN","BIGBLOW.SAN", _
  "BIKESWAR.SAN","BURST.SAN","BURSTDOG.SAN","CABSTRUG.SAN", _
  "CATCHUP.SAN","CES_NITE.SAN","BARKDOG.SAN","CRUSHDOG.SAN","CVRAMP.SAN", _
  "DRIVEBY.SAN","ESCPPLNE.SAN","FANSTOP.SAN","FIRE.SAN", _
  "FI_14.SAN","FI_14_15.SAN","FULPLANE.SAN", _
  "GR_LOS.SAN","GR_WIN.SAN","HI_SIGN.SAN","INTO_FAN.SAN", _
  "JG.SAN","JUMPGORG.SAN","KICK_OFF.SAN","KILLGULL.SAN", "KR.SAN", _
  "LIMOBY.SAN","LIMOROAR.SAN","MOEJECT.SAN","MOREACH.SAN", _
  "MO_FUME.SAN","NB_BLOW.SAN", _
  "NTREACT.SAN","OFFGOGG.SAN","OM.SAN","PLNCRSH.SAN", _
  "REACHHER.SAN","REV.SAN","RIDEAWAY.SAN","RIDEOUT.SAN", _
  "RIPSHIFT.SAN","SCRAPBOT.SAN", _
  "SHEFALLS.SAN","SHORTOPN.SAN","SHOWSMRK.SAN","SHOWUP1.SAN", _
  "SNSETRDE.SAN","SQUINT.SAN","TC.SAN","TEETBURN.SAN","TINYPLNE.SAN", _
  "TINYTRUC.SAN","TINYTRUK.SAN","TOKCRGO.SAN","TRKCRSH.SAN", _
  "WEREINIT.SAN","WHIP_PAN.SAN", _ 'DATA
  "DATA/","BENFLIP.SAN","CHASEBEN.SAN","CHASOUT.SAN","CHASTHRU.SAN", _
  "FISHFEAR.SAN","FISHGOG2.SAN","FISHGOGG.SAN","GETNITRO.SAN","HITDUST1.SAN", _
  "HITDUST2.SAN","HITDUST3.SAN","HITDUST4.SAN","LIFTBORD.SAN","LIFTCHAY.SAN", _
  "LIFTGOG.SAN","LIFTMACE.SAN","LIFTSAW.SAN","LIMOCRSH.SAN","MINEDRIV.SAN", _
  "MINEEXIT.SAN","MINEFITE.SAN","ROTTFITE.SAN","ROTTFLIP.SAN","ROTTOPEN.SAN", _
  "TOMINE.SAN","TORANCH.SAN","TOVISTA1.SAN","TOVISTA2.SAN","VISTTHRU.SAN", _
  "WR2_BEN.SAN","WR2_BENC.SAN","WR2_BENR.SAN","WR2_BENV.SAN","WR2_CAVE.SAN", _
  "WR2_CVKO.SAN","WR2_ROTT.SAN","WR2_VLTC.SAN","WR2_VLTP.SAN","WR2_VLTS.SAN", "" }

#ifdef On_x86  
  'dim as string NewFile = "JG.SAN"
  'dim as string NewFile = "NITEFADE.SAN"
  'dim as string NewFile = "CREDITS.SAN"
  'dim as string NewFile = "BOLUSKIL.SAN"
  #ifdef NitroData    
    NewFile = dir$(SanDir+"*.SAN")    
    SanDir = exepath+"/NitroFiles/" 'exepath+"/"'"h:\fromdata\games4\fullt\VIDEO\"
  #else
    SanDir = "G:/BackupH/FromData/Games4/Fullt/"
    NewFile = FileList(FilePosi)    
  #endif
#else  
  #ifdef __FB_NDS__
    SanDir = "/DATA/Games/Fullt/"
    iResu = Open(SanDir+"VIDEO/INTROD_8.SAN" for binary access read as #90)
    if IResu then SanDir = "":FileList(0)="/" else close #90
  #else
    'SanDir = exepath+"/DATA/Games/Fullt/"
    SanDir = "G:/BackupH/FromData/Games4/Fullt/"
  #endif
  
#endif


while len(NewFile)   
  IsPlaying = 0
  
  while strchr(strptr(NewFile),asc("/"))
    SanDir2 = NewFile: FilePosi += 1
    NewFile = FileList(FilePOsi)
    if len(NewFile)=0 then exit while,while
  wend  
  NewFile2 = SanDir2+NewFile
  InitVideo(NewFile2,MustReset)
  MustReset=0
  
  SanFile = freefile()
 
  if open(SanFileName for binary access read as #SanFile)=0 then
    
    pSubtitle = LoadSubtitles(SanFileName) 
    if pSubtitle then
      DbgOut("Subtitles Loaded...")
    end if
    Dbgout("Movie Pre-Buffer")    
    
    dim as uinteger iFileSign 
    get #sanFile,1,iFileSign

    #define HeadOfType(tType) *cptr(tType ptr, SanPtr+sizeof(HeaderStruct))  
    #define ChunkHeader() *cptr(HeaderStruct ptr,SanPtr)
    #define IsGenericHeader() if ChunkSz > 0 then ChunkSz=0    
    ' *** Load Initial Chunk Buffer ***
    SanSize=lof(SanFile): SanBuffSz = 8192
    if SanBuffSz > SanSize then SanBuffSz = SanSize 
    SanBuffEnd = SanBuffSz: SanPtr = SanBuff    
    get #SanFile,1,*cptr(ubyte ptr,SanBuff),SanBuffSz
    static as double TMR
    MovieLeft = SanSize
    TMR = timer: FPT = TMR: FPS = 0    
    
    #define Brk 
    '!"\r"
    
    Dbgout("Movie starting... (%ikb)",SanSize\1024)    
    IsPlaying = 1: SetMessage(NewFile)
    
    do while iFileSign = cvi("ANIM")
      
      'printf("-" Brk)
      DecodeEnabled = 1
      dim as double DecodeTemp = timer
      
      ' *** Check if more data is needed on the buffer ***
      with ChunkHeader()
        UpdateAudioState(__LINE__)        
        if ChunkSz >= 0 then  
          ChunkSz = GetChunkSz(MakeInt(.iSize))          
          if ChunkSz <= 0 then 
            if cuint(SanPtr) >= lof(SanFile) then exit do
            ErrOut("Bad Chunk Size: %i",ChunkSz)            
            ChunkSz = 65536: sleep            
          end if
          ChunkType = MakeInt(.iType)
          dim as uinteger BufferPos = cuint(SanPtr-SanBuff)          
          if ChunkType <> cvi("ANIM") and chunkType <> cvi("FRME") then
            var NextChunkSz = BufferPos+ChunkSz+(sizeof(HeaderStruct) shl 2)
            'Errout("Pos=%i Next=%i End=%i Sz=%i SanLeft=%i", _
            'BufferPos,NextChunkSz,SanBuffEnd,SanBuffSz,SanSize-SanBuffSz)
            if BufferPos > 4096 or NextChunkSz >= SanBuffEnd then
              SanSize -= SanBuffSz              
              if SanSize > 0 then
                var RemainBuffSz = (SanBuffEnd-BufferPos)
                SanBuffSz = 65536-RemainBuffSz 'BufferPos                
                #ifdef __FB_NDS__
                  fbFastcopy(SanBuff,SanPtr,RemainBuffsz)
                #else
                  Memcpy(SanBuff,SanPtr,RemainBuffsz)
                #endif
                if SanBuffSz > SanSize then SanBuffSz=SanSize                
                SanPtr = SanBuff: SanBuffEnd = SanBuffSz+RemainBuffSz
                var TgtPtr = cptr(ubyte ptr,SanBuff+RemainBuffSz)
                'Errout("Rem=%i BuffSz=%i End=%i (%i)", _
                'RemainBuffSz,SanBuffSz,SanBuffEnd,RemainBuffSz+SanBuffSz)
                dim as integer ReadSz=SanBuffSz,ReadAmount=4096
                while ReadSz > 0
                  if ReadSz < 4096 then ReadAmount = ReadSz
                  get #SanFile,,*TgtPtr,ReadAmount
                  TgtPtr += ReadAmount: ReadSz -= ReadAmount
                wend
                'printf("+" Brk)
                continue do                
              end if
            end if
          end if
        end if
      end with      
      
      ' *** Parse Chunk ***
      with ChunkHeader()     
        'Cout("Chunk Type: %s",mki(ChunkType)): sleep
        select case ChunkType
        case cvi("FOBJ")             'Frame Object
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)          
          with HeadOfType(FrameObjectStruct)
            ExOut("          .Codec=%i",.Codec)
            ExOut("          .Position=%i,%i",.PosX,.PosY)
            ExOut("          .Size=%ix%i",.Wid,.Hei)
            if .Wid > 320 or .Hei > 200 then exit do            
            dim as any ptr ObjPtr = @.ObjectData
            pBuff = ImgBuffer+sizeof(fb.image)+.Posy*320+.PosX
            select case .Codec
            case 1,3 '----------- transparent ----------
              'printf("1" Brk)
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
                    #ifdef __FB_NDS__
                      if Pix then MemSet(pBuff,Pix,uCode)
                    #else
                      if Pix then memset(pBuff,Pix,uCode)
                    #endif
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
                ExOut("          ..SubCodec=%i (%i)",.SubCodec,.Sequence)
                ExOut("          ..Size=%i->%i",InSize,OutSize)
                ExOut("          ..Index=%i:%i",.Index,dwFlags)              
                dim as any ptr DataPtr = @.EncodedData              
                dim as any ptr DataEnd = DataPtr+InSize
                dim as any ptr BuffEnd = pBuff+OutSize
                dim as integer OutSz = 0
                
                static as integer Init=0
                if _offset_table=0 then                  
                  _offset_table = allocate(256*sizeof(short))                
                  _table_last_pitch = -1: _table_last_index = -1                  
                  codec37_MakeTable(BuffPit, .Index)
                end if                
                
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
                    'printf("2" Brk)
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
                    'printf("3" Brk)
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
                  'printf("4" Brk)
                  while cuint(DataPtr) < cuint(DataEnd)
                    dim as ubyte uCode = *cptr(ubyte ptr,DataPtr)
                    if (uCode and 1) then                    
                      uCode = (uCode shr 1)+1
                      #ifdef __FB_NDS__
                        MemSet(pBuff,*cptr(ubyte ptr,DataPtr+1),uCode)
                      #else
                        MemSet(pBuff,*cptr(ubyte ptr,DataPtr+1),uCode)
                      #endif
                      pBuff += uCode: DataPtr += 2: OutSz += uCode 
                    else
                      uCode = (uCode shr 1)+1
                      #ifdef __FB_NDS__
                        fbFastCopy(pBuff,DataPtr+1,uCode)
                      #else
                        memcpy(pBuff,DataPtr+1,uCode)
                      #endif
                      pBuff += uCode: DataPtr += cuint(uCode)+1: OutSz += uCode
                    end if                                    
                  wend                  
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
            end select
          end with
          ObjPerFrame += 1
          
          
        case cvi("PSAD")             'Audio Block
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)          
          with HeadOfType(FrameAudioStruct)
            ExOut("          .Track=%i (%i->%i) ",.TrackID,.Index,.IndexCount-2)
            ExOut("          .Voume=%i (%i)",.Volume,.Balance)
            ExOut("          .Flags=%X",.Flags)
            var SampleSz = ((ChunkSz-(sizeof(FrameAudioStruct)-1))*2)\iSpeed
            static as integer MaxSz
            if SampleSz > MaxSz then MaxSz = SampleSz
            'Errout(" trk=%3i id=%4i cnt=%4i f=%4i sz=%5i(%i)", _
            '.TrackID,.Index,.IndexCount-2,.Flags,SampleSz,MaxSz)
            if SampleSz andalso FrameSync then
              'printf("~" Brk)
              AddToTrack(.TrackID,.Index,.IndexCount-2,@.SoundData,SampleSz,.Volume,.Balance)            
            end if
          end with
        case cvi("FRME")             'Frame Chunk
          
          'if SubtitleCount < 0 then SubtitleCount = 0
          ObjPerFrame = 0: NewSubtitles = 0 '-SubtitleCount
          FrameSize = ChunkSz: FrameReady = 0
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          NextFrame = SanPtr+sizeof(HeaderStruct)+ChunkSz
          IsGenericHeader() 
          FrameCount += 1
          
        case cvi("XPAL")             'Palette Effect
          Cout("        %s (%i)",mki(ChunkType),ChunkSz)         
          with HeadOfType(ChgPaletteStruct)
            Cout("        .Size=%i (%i)",.PalSize,.Unknown)
            if ChunkSz = 6 then
              Cout("        .Index=%i",.Index)
              for CNT as integer = 0 to 256*3-1
                #define x CurPal(CNT)
                dim as integer temp = x+DeltaPal(CNT)
                if Temp > 32767 then Temp = 32767
                if Temp < 0 then Temp = 0
                x = temp              
              next CNT
            else
              for CNT as integer = 0 to 256*3-1                
                CurPal(CNT) = (.NewPal(CNT) shl 7)                
              next CNT
              FastCopy(@DeltaPal(0),@.PalDelta(0),256*3*sizeof(short))
            end if  
            IgnoreOjbs = 1
          end with          
        case cvi("TRES")             'Subtitle
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(ResourceStruct)
            ExOut("        .Pos=%ix%i",.PosX,.PosY)
            ExOut("        .LeftTop=%ix%i",.iLeft,.iTop)
            ExOut("        .Size=%ix%i",.iWid,.iHei)
            ExOut("         ID=%i(%i)%i",.ID,.Flags,.Unknown)
            if pSubtitle then
              if NewSubtitles < 0 then NewSubtitles = 0
              var SubPtr = pSubtitle
              dim as integer iCharSz = 10
              if FrameResize then iCharSz = 8
              do                
                if SubPtr->OffsetText = 255 then exit do
                if SubPtr->ID = .ID then
                  var TxtPtr = cast(zstring ptr,cuint(SubPtr)+SubPtr->OffsetText)                  
                  dim as integer iX = .PosX, iY = .PosY
                  if (.Flags and 1) then 
                    iX = .iLeft+1: iY += 0 '.iTop
                    dim as integer TxtPos = 0,iPX,LineLen
                    dim as integer TxtLen = SubPtr->TextLen 'len(sTxt)
                    while TxtPos < TxtLen
                      LineLen = TxtLen-TxtPos                                            
                      if (LineLen*iCharSz) > .iWid then                        
                        LineLen = .iWid\iCharSz
                        for LineLen = LineLen to 1 step -1
                          if cptr(ubyte ptr,TxtPtr+TxtPos)[LineLen]=32 then exit for                          
                        next LineLen
                      end if
                      var iWid = .iWid
                      with tSubtitle(NewSubtitles)
                        '.sTxt = mid$(sTxt,TxtPos+1,LineLen)
                        .pTxt = TxtPtr+TxtPos
                        .TxtSz = LineLen
                        TxtPos += (LineLen+1)
                        .iX = iX+((iWid-(LineLen*8))\2)                        
                        .iY = iY
                        if FrameReSize=0 then 
                          if .iY > 100 then .iY -= 5 else .iY += 5
                          if .iX < 34 then .iX = 34
                          if .iX+(.TxtSz*8) > 285 then .iX = 285-(.TxtSz*8)
                        end if
                      end with
                      NewSubtitles += 1: iY += 8                     
                    wend
                  else
                    with tSubtitle(NewSubtitles)
                      .iX = iX
                      .iY = iY
                      .TxtSz = SubPtr->TextLen
                      if FrameReSize=0 then 
                        if .iX < 34 then .iX = 34
                        if .iX+(.TxtSz*8) > 285 then .iX = 285-(.TxtSz*8)
                        if .iY > 100 then .iY -= 5 else .iY += 5
                      end if
                      .pTxt = TxtPtr
                      
                      '.sTxt = sTxt
                    end with
                    NewSubtitles += 1                    
                  end if                  
                  'sleep
                  exit do
                end if                  
                var iNext = SubPtr->OffsetNext
                if iNext = 0 then
                  exit do
                else
                  SubPtr = cast(any ptr,cuint(SubPtr)+(iNext shl 1))
                end if                
              loop
            end if
          end with
        case cvi("FTCH")             'Restore Frame
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          if IsFrameStored then
            #ifdef __FB_NDS__
              dc_flushrange(ImgBuffer,sizeof(fb.image))
              dmacopywords(3,StoredFrame,ImgBuffer,320*200+sizeof(fb.image))
            #else
              FastCopy(ImgBuffer,StoredFrame,320*200+sizeof(fb.image))            
            #endif            
            'FastCopy(@CurPal(0),@StoredPal(0),768*2)
            'printf("5" Brk)
            UpdateAudioState(__LINE__)
          end if          
        case cvi("STOR")             'Store Frame
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)          
          #ifdef __FB_NDS__
            dc_flushrange(ImgBuffer,sizeof(fb.image))
            dmacopywords(3,ImgBuffer,StoredFrame,320*200+sizeof(fb.image))
          #else
            FastCopy(StoredFrame,ImgBuffer,320*200+sizeof(fb.image))
          #endif
          UpdateAudioState(__LINE__)
          'FastCopy(@StoredPal(0),@CurPal(0),768*2)
          'printf("6" Brk)
          IsFrameStored = 1
        case cvi("NPAL")             'New Palette
          cout("        %s (%i)",mki(ChunkType),ChunkSz)          
          with HeadOfType(NewPaletteStruct)          
            for CNT as integer = 0 to 767
              CurPal(CNT) = cshort(.NewPal(CNT)) shl 7
            next CNT
          end with 
          IgnoreOjbs = 1
        case cvi("AHDR")             'Animation Info        
          cout("    %s (%i)",mki(ChunkType),ChunkSz)
          with HeadOfType(AnimHeaderStruct)
            ExOut("      .Version=%i",.Version)
            ExOut("      .Frames=%i",.Frames)
            FrameTotal = .Frames
            if .Version = 2 then
              ExOut("      .Sampling=%i",MakeInt(.v2Frequency))
            end if
            for CNT as integer = 0 to 767
              CurPal(CNT) = cshort(.StartPal(CNT)) shl 7
            next CNT
            IgnoreOjbs = 1
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
          Cout("%s Size:%5.2fmb Total:%5.2fmb",mki(ChunkType),ChunkSz/(1024*1024),(SanSize-8)/(1024*1024))      
          IsGenericHeader()          
        case cvi("IACT")             'Audio Track
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          ErrOut("IACT not implemented yet...")
        case cvi("SKIP")             'Video Marker
          Cout("    %s (%i)",mki(ChunkType),ChunkSz)
          ErrOut("SKIP not implemented yet...")
        case else                    'Unknown Header
          Errout(">>> Unknown Header: %s of size %i <<<",mki(ChunkType),ChunkSz)          
          sleep 500,1': exit do
        end select
      end with
      
      ' *** Point to next chunk ***
      if (ChunkSz and 1) then ChunkSz += 1
      SanPtr += sizeof(HeaderStruct)+ChunkSz
      FrameReady += sizeof(HeaderStruct)+ChunkSz
      MovieLeft -= (sizeof(HeaderStruct)+ChunkSz)
      
      dim as uinteger TempType = MakeInt(cptr(HeaderStruct ptr,SanPtr)->iType)      
      if TempType = cvi("FRME") or MovieLeft <=0 then 
        FrameReady = FrameSize
      end if
      
      DecodeTime += timer-DecodeTemp
      DecodeEnabled = 0
      DecodeCount += 1
      
      if ChunkSz = 0 then continue do
      
      ' *** A frame was finished so update/sync ***
      FpsWanted = (10*iSpeed) shr 1
      if FrameSync = 0 then FpsWanted = 60
      if FrameReady >= FrameSize then       
        WaitAmount = 1/(FpsWanted)
        SubtitleCount = NewSubtitles: FrameReady = 0
        for CNT as integer = 0 to SOUND_CHANNELS
          with TrackUsage(CNT)
            if .TrackID <> UNUSED_TRACK andalso (.EndTime-timer) < (1/(FpsWanted*2)) then
              with TrackPtr(.TrackID)
                if .CurrentID < .LastID then                  
                  WaitAmount = 1/(FpsWanted+(FpsWanted\2))
                end if
              end with
            end if
          end with
        next CNT        
        
        dim as integer Temp        
        #if 1
          'var sTextOut = "[" & FrameCOunt & ">" & FrameTotal & "]{" & cuint(FPS/(timer-FPT)) & !"}"
          'sTextOut = left$(sTextOut+string$(15,32),15)        
          'Printf(sTextOut+"Memory:" & MemoryUsage\1024 & !"kb | ")
          '#else
          static as double CleanTime,ResuTime
          static as single ResuDecode,ResuGfx
          static as integer ResuFrames
          'ResuDecode = (DecodeTime/DecodeCount)*1000
          'ReseGfx = (GfxTime/GfxCount)*1000)
          ResuFrames += 1
          'printf(!"Dec:%5.2f Blt:%5.2f (%i%%) \r",ResuDecode,ResuGfx,cuint(ResuDecode+ResuGfx))        
          iOSD = sprintf(sOSD,"[%i>%i] %ikb Dec:%4.2f Blt:%4.2f (%i%%)", _
          FrameCount,FrameTotal,MemoryUsage\1024,ResuDecode,ResuGfx,cuint(ResuDecode+ResuGfx))
          ResuTime = abs(timer-CleanTime)
          if ResuTime >= 1 then          
            CleanTime = timer          
            ResuTime = ResuFrames: ResuFrames = 0          
            ResuDecode = (DecodeTime/ResuTime)*1000
            ResuGfx = (GfxTime/ResuTime)*1000
            'if DecodeCount then DecodeTime /= (DecodeCount/4): DecodeCount = 4
            'if GfxCount then GfxTime /= (GfxCount/4): GfxCount = 4
            DecodeTime=0:GfxTime=0: GfxCount=0:DecodeCount=0
          end if
        #endif
        
        UpdateAudioState(__LINE__)
        
        #ifdef On_x86
        GfxUpdateX86()
        #else        
        GfxUpdate()
        #endif
        
        
        'if IgnoreOjbs = 1 then screenunlock:sleep:screenlock
        
      end if
      
      UpdateAudioState(__LINE__)
      if MovieLeft <= 0 then exit do
      
      do ' *** Check Controls ***
        static as integer DeskWid,DeskHei
        
        #ifdef __FB_NDS__
          #define KeyEnter() Key[1] = fb.Sc_ButtonA
          #define KeyLimit()   Key[1] = fb.Sc_ButtonX
          #define KeySmooth() Key[1] = fb.Sc_ButtonY
          #define KeyResize() Key[1] = fb.Sc_ButtonB
        #else
          #define KeyEnter() Key[0] = 13
          #define KeyLimit()   Key[0] = asc("l")
          #define KeySmooth() Key[0] = asc("s")
          #define KeyResize() Key[0] = asc("r")
        #endif
        
        var Key = Inkey$
        if len(Key)=0 then exit do
        if KeyEnter()      then exit do,do        
        if KeySmooth()     then          
          BlendFrames = iif(BlendFrames<0,0,-1)
          ErrOut("Motion Smooth=%s",iif(BlendFrames=-1,@"off",@"on"))          
          if BlendFrames=-1 then
            SetMessage("Motion Smooth=DISABLED")
          else
            SetMessage("Motion Smooth=ENABLED")
          end if
        end if
        if KeyResize()     then
          if FrameResize then
            if (FrameResize and 2) then BlendFrames = 0
            FrameResize = 0
          else
            FrameResize = 1-(BlendFrames>=0)
          end if
          ErrOut("FrameResize=%s",iif(FrameResize=0,@"off",@"on"))
          if FrameResize=0 then
            SetMessage("Resize=DISABLED")
          else
            SetMessage("Resize=ENABLED")
          end if
        end if
        if KeyLimit()      then 
          FrameSync xor= 1
          ErrOut("FrameSync=%s",iif(FrameSync=0,@"off",@"on"))
          if FrameSync=0 then
            SetMessage("FrameSync=DISABLED")
          else
            SetMessage("FrameSync=ENABLED")
          end if
        end if
        if Key[1]=asc("k") then FrameSync = -1: exit while
        if Key[0]=27       then FrameSync = -1: exit while        
        
        #ifdef On_x86    
          if Key[0]=asc("=") or Key[0]=asc("+") then
            if iSpeed < 32 then iSpeed += 1      
            dim as zstring*64 sMsg
            sPrintf(sMsg,"Speed=%1.1fx",iSpeed/2):SetMessage(sMsg)            
          end if
          if Key[0]=asc("-") or Key[0]=asc("_") then
            if iSpeed > 2 then iSpeed -= 1     
            dim as zstring*64 sMsg
            sPrintf(sMsg,"Speed=%1.1fx",iSpeed/2):SetMessage(sMsg)            
          end if
          if Key[1]=fb.SC_F1 then           
            DoubleMode = (DoubleMode+1) and 3          
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
            select case DoubleMode
            case 0: SetMessage("Resize=RGB2x")
            case 1: SetMessage("Resize=Resize2x")
            case 2: SetMessage("Resize=Scale2x")
            case 3: SetMessage("Resize=None")
            end select
          end if
          if Key[1]=fb.SC_F2 then          
            ModeFull xor= 1
            dim as integer ResX = 640, ResY = 400
            #ifdef DebugAudio
              ResY = 600
            #endif
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
            if ModeFull then
              SetMessage("Fullscreen (stretch)")
            else
              SetMessage("Windowed 1x/2x")
            end if
          end if
          if Key[1]=fb.SC_F3 then 
            DoNoise xor= 1
            if DoNoise then
              SetMessage("Noise=Enabled")
            else
              SetMessage("Noise=Disabled")
            end if
          end if
          if Key[1]=fb.SC_F4 then 
            DoDither = (DoDither+1) mod 3
            select case DoDither
            case 0: SetMessage("Effect=None")
            case 1: SetMessage("Effect=Dither")
            case 2: SetMessage("Effect=Scanline")
            end select
          end if          
        #endif
        
      loop
      
    loop    
    Dbgout("End Movie.")
    
    ' ******* File Is Done Playing ******
    ' *** Wait/Free Allocated Buffers ***
    screenunlock
    close #SanFile
    #if 0
    if MovieLeft <= 0 then
      dim as integer NoTrackCount
      do        
        for CNT as integer = 0 to 10
          UpdateAudioState(__LINE__)
          sleep 1,1        
        next CNT        
        UpdateAudioState(__LINE__)
        NoTrackCount += 1
        for CNT as integer = 0 to SOUND_CHANNELS
          if TrackUsage(CNT).SamplePtr then NoTrackCount = 0
        next CNT
        if NoTrackCount > 2 then exit do
        for CNT as integer = 0 to SAMPLE_UBOUND          
          if SampleStack(CNT).SamplePtr then continue do
        next CNT
        exit do        
      loop
    end if    
    #endif
    if 1 then 'MovieLeft > 0 then
      MustReset=1
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
    Dbgout("Samples Freed.")
    
  end if
  
  '#ifdef On_x86
  'NewFile = dir$()  
  '#else
  FilePosi += 1
  NewFile = FileList(FilePosi)
  '#endif
  
  '("wut?")
  'sleep
  
wend
ErrOut("Done!")
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

