#define SingleGround

enum TrackModels
  tmFence
  tmFenceCorner
  tmLast
end enum

#ifdef __FB_NDS__
type TrackObject  
  Matrix     as m4x3
  MatrixPtr  as any ptr
  ListPtr    as any ptr
  PosX       as byte
  PosY       as byte
  Frames     as byte  
end type
#else
type TrackObject  
  Matrix(15) as single 
  MatrixPtr  as any ptr
  ListPtr    as any ptr  
  PosX       as byte
  PosY       as byte  
  Frames     as byte
end type
#endif

type TrackTile
  ObjA      as any ptr
  objB      as any ptr
  AngleY    as short
  Frames    as short  
end type

namespace Track
dim shared as tModel Models(255)
dim shared as ubyte bObject(29,29)
dim shared as ubyte Terrain(29,29)
dim shared as byte Horizon
dim shared as TrackObject Array(30*30*4)
dim shared as integer ObjectCount
end namespace

dim shared as short AtnTab(-32*32 to 32*32)

#define LastObject() 0
#define NoObject() 0
'cast(any ptr, 255)
#define SameObject() @"255"
'cast(any ptr, num)
#define AsObject(num) @#num
dim shared as TrackTile TrackObjects(255) = { _
( @"offi.obj"   , NoObject()  ,   0,0) , _ '  0
( @"road-1.obj" , @"fini.obj" ,   0,0) , _ '  1
( 0 , 0 , 0 , 0 ) ,  ( 0 , 0 , 0 , 0 ) , _ '  2-3
( @"road-1.obj" , NoObject()  ,   0,0) , _ '  4
( SameObject()  , NoObject()  , +90,0) , _ '  5
( @"turn-1.obj" , NoObject()  , -90,0) , _ '  6
( SameObject()  , NoObject()  ,   0,0) , _ '  7
( SameObject()  , NoObject()  ,-180,0) , _ '  8
( SameObject()  , NoObject()  , +90,0) , _ '  9
( @"stur-1.obj" , NoObject()  , -90,0) , _ ' 10
( SameObject()  , NoObject()  ,   0,0) , _ ' 11
( SameObject()  , NoObject()  ,-180,0) , _ ' 12
( SameObject()  , NoObject()  , +90,0) , _ ' 13
( @"road-2.obj" , NoObject()  ,   0,0) , _ ' 14
( SameObject()  , NoObject()  , +90,0) , _ ' 15
( @"turn-2.obj" , NoObject()  , -90,0) , _ ' 16
( SameObject()  , NoObject()  ,   0,0) , _ ' 17
( SameObject()  , NoObject()  ,-180,0) , _ ' 18
( SameObject()  , NoObject()  , +90,0) , _ ' 19
( @"stur-2.obj" , NoObject()  , -90,0) , _ ' 20
( SameObject()  , NoObject()  ,   0,0) , _ ' 21
( SameObject()  , NoObject()  ,-180,0) , _ ' 22
( SameObject()  , NoObject()  , +90,0) , _ ' 23
( @"road-3.obj" , NoObject()  ,   0,0) , _ ' 24
( SameObject()  , NoObject()  , +90,0) , _ ' 25
( @"turn-3.obj" , NoObject()  , -90,0) , _ ' 26
( SameObject()  , NoObject()  ,   0,0) , _ ' 27
( SameObject()  , NoObject()  ,-180,0) , _ ' 28
( SameObject()  , NoObject()  , +90,0) , _ ' 29
( @"stur-3.obj" , NoObject()  , -90,0) , _ ' 30
( SameObject()  , NoObject()  ,   0,0) , _ ' 31
( SameObject()  , NoObject()  ,-180,0) , _ ' 32
( SameObject()  , NoObject()  , +90,0) , _ ' 33
( @"elrd.obj"   , NoObject()  ,   0,0) , _ ' 34
( SameObject()  , NoObject()  , +90,0) , _ ' 35
( @"ramp.obj"   , NoObject()  , +90,0) , _ ' 36
( SameObject()  , NoObject()  , -90,0) , _ ' 37
( SameObject()  , NoObject()  ,   0,0) , _ ' 38
( SameObject()  , NoObject()  ,-180,0) , _ ' 39
( @"rban.obj"   , NoObject()  ,   0,0) , _ ' 40
( SameObject()  , NoObject()  , +90,0) , _ ' 41
( SameObject()  , NoObject()  ,-180,0) , _ ' 42
( SameObject()  , NoObject()  , -90,0) , _ ' 43
( @"lban.obj"   , NoObject()  ,   0,0) , _ ' 44
( SameObject()  , NoObject()  , +90,0) , _ ' 45
( SameObject()  , NoObject()  ,-180,0) , _ ' 46
( SameObject()  , NoObject()  , -90,0) , _ ' 47
( @"bank.obj"   , NoObject()  ,-180,0) , _ ' 48
( SameObject()  , NoObject()  ,   0,0) , _ ' 49
( SameObject()  , NoObject()  , -90,0) , _ ' 50
( SameObject()  , NoObject()  , +90,0) , _ ' 51
( @"btur.obj"   , NoObject()  , -90,0) , _ ' 52
( SameObject()  , NoObject()  ,   0,0) , _ ' 53
( SameObject()  , NoObject()  ,-180,0) , _ ' 54
( SameObject()  , NoObject()  , +90,0) , _ ' 55
( @"brid.obj"   , NoObject()  , +90,0) , _ ' 56
( SameObject()  , NoObject()  , -90,0) , _ ' 57
( SameObject()  , NoObject()  ,   0,0) , _ ' 58
( SameObject()  , NoObject()  ,-180,0) , _ ' 59
( @"chi2.obj"   , NoObject()  ,   0,0) , _ ' 60
( @"chi1.obj"   , NoObject()  , +90,0) , _ ' 61
( SameObject()  , NoObject()  ,   0,0) , _ ' 62
( AsObject(60)  , NoObject()  , -90,0) , _ ' 63
( @"loo1.obj"   , @"loop.obj" ,   0,0) , _ ' 64
( SameObject()  , NoObject()  , +90,0) , _ ' 65
( @"tun2.obj"   , @"tunn.obj" ,   0,0) , _ ' 66
( SameObject()  , NoObject()  , +90,0) , _ ' 67
( @"pipe.obj"   , @"pip2.obj" ,   0,0) , _ ' 68
( SameObject()  , NoObject()  , +90,0) , _ ' 69
( @"spip.obj"   , NoObject()  ,   0,0) , _ ' 70
( SameObject()  , NoObject()  ,-180,0) , _ ' 71
( SameObject()  , NoObject()  , -90,0) , _ ' 72
( SameObject()  , NoObject()  , +90,0) , _ ' 73
( @"inte-1.obj" , NoObject()  ,   0,0) , _ ' 74
( @"offl-1.obj" , NoObject()  ,   0,0) , _ ' 75
( SameObject()  , NoObject()  , -90,0) , _ ' 76
( SameObject()  , NoObject()  ,-180,0) , _ ' 77
( SameObject()  , NoObject()  , +90,0) , _ ' 78
( @"offr-1.obj" , NoObject()  ,   0,0) , _ ' 79
( SameObject()  , NoObject()  , -90,0) , _ ' 80
( SameObject()  , NoObject()  ,-180,0) , _ ' 81
( SameObject()  , NoObject()  , +90,0) , _ ' 82
( @"hpip.obj"   , NoObject()  ,   0,0) , _ ' 83
( SameObject()  , NoObject()  , +90,0) , _ ' 84
( @"vcor.obj"   , NoObject()  ,   0,0) , _ ' 85
( SameObject()  , NoObject()  , +90,0) , _ ' 86
( @"sofl-1.obj" , NoObject()  ,   0,0) , _ ' 87
( SameObject()  , NoObject()  , -90,0) , _ ' 88
( SameObject()  , NoObject()  ,-180,0) , _ ' 89
( SameObject()  , NoObject()  , +90,0) , _ ' 90
( @"sofr-1.obj" , NoObject()  ,   0,0) , _ ' 91
( SameObject()  , NoObject()  , -90,0) , _ ' 92
( SameObject()  , NoObject()  ,-180,0) , _ ' 93
( SameObject()  , NoObject()  , +90,0) , _ ' 94
( @"sram.obj"   , NoObject()  , +90,0) , _ ' 95
( SameObject()  , NoObject()  , -90,0) , _ ' 96
( SameObject()  , NoObject()  ,   0,0) , _ ' 97
( SameObject()  , NoObject()  ,-180,0) , _ ' 98
( @"selr.obj"   , NoObject()  ,   0,0) , _ ' 99
( SameObject()  , NoObject()  , +90,0) , _ '100
( @"rdrt.obj"   , @"elsp.obj" , +90,0) , _ '101
( SameObject()  , NoObject()  ,   0,0) , _ '102
( @"elsp.obj"   , NoObject()  ,   0,0) , _ '103
( SameObject()  , NoObject()  , +90,0) , _ '104
( @"sest.obj"   , NoObject()  , -90,0) , _ '105
( SameObject()  , NoObject()  ,   0,0) , _ '106
( SameObject()  , NoObject()  ,-180,0) , _ '107
( SameObject()  , NoObject()  ,  90,0) , _ '108
( @"wroa.obj"   , NoObject()  ,   0,0) , _ '109
( SameObject()  , NoObject()  , +90,0) , _ '110
( @"gwro.obj"   , NoObject()  ,   0,0) , _ '111
( SameObject()  , NoObject()  , +90,0) , _ '112
( SameObject()  , NoObject()  ,-180,0) , _ '113
( SameObject()  , NoObject()  , -90,0) , _ '114
( @"road-1.obj" , @"barr.obj" ,-180,0) , _ '115
( SameObject()  , NoObject()  , -90,0) , _ '116
( @"lco1.obj"   , @"lco0.obj" ,   0,0) , _ '117
( SameObject()  , NoObject()  , -90,0) , _ '118
( SameObject()  , NoObject()  ,-180,0) , _ '119
( SameObject()  , NoObject()  , +90,0) , _ '120
( @"rco1.obj"   , @"rco0.obj" ,   0,0) , _ '121
( SameObject()  , NoObject()  , -90,0) , _ '122
( SameObject()  , NoObject()  ,-180,0) , _ '123
( SameObject()  , NoObject()  , +90,0) , _ '124
( @"inte-2.obj" , NoObject()  ,   0,0) , _ '125
( @"offl-2.obj" , NoObject()  ,   0,0) , _ '126
( SameObject()  , NoObject()  , -90,0) , _ '127
( SameObject()  , NoObject()  ,-180,0) , _ '128
( SameObject()  , NoObject()  , +90,0) , _ '129
( @"offr-2.obj" , NoObject()  ,   0,0) , _ '130
( SameObject()  , NoObject()  , -90,0) , _ '131
( SameObject()  , NoObject()  ,-180,0) , _ '132
( SameObject()  , NoObject()  , +90,0) , _ '133
( @"road-2.obj" , @"fini.obj" ,   0,0) , _ '134
( SameObject()  , NoObject()  ,-180,0) , _ '135
( SameObject()  , NoObject()  , +90,0) , _ '136
( SameObject()  , NoObject()  , -90,0) , _ '137
( @"inte-3.obj" , NoObject()  ,   0,0) , _ '138
( @"offl-3.obj" , NoObject()  ,   0,0) , _ '139
( SameObject()  , NoObject()  , -90,0) , _ '140
( SameObject()  , NoObject()  ,-180,0) , _ '141
( SameObject()  , NoObject()  , +90,0) , _ '142
( @"offr-3.obj" , NoObject()  ,   0,0) , _ '143
( SameObject()  , NoObject()  , -90,0) , _ '144
( SameObject()  , NoObject()  ,-180,0) , _ '145
( SameObject()  , NoObject()  , +90,0) , _ '146
( @"road-2.obj" , @"fini.obj" ,   0,0) , _ '147
( SameObject()  , NoObject()  ,-180,0) , _ '148
( SameObject()  , NoObject()  , +90,0) , _ '149
( SameObject()  , NoObject()  , -90,0) , _ '150
( @"palm.obj"   , NoObject()  ,   0,0) , _ '151
( @"cact.obj"   , NoObject()  ,   0,0) , _ '152
( @"tree.obj"   , NoObject()  ,   0,0) , _ '153
( @"tenn.obj"   , NoObject()  ,   0,0) , _ '154
( @"gass.obj"   , NoObject()  ,   0,0) , _ '155
( SameObject()  , NoObject()  ,-180,0) , _ '156
( SameObject()  , NoObject()  , -90,0) , _ '157
( SameObject()  , NoObject()  , +90,0) , _ '158
( @"barn.obj"   , NoObject()  ,   0,0) , _ '159
( SameObject()  , NoObject()  ,-180,0) , _ '160
( SameObject()  , NoObject()  , -90,0) , _ '161
( SameObject()  , NoObject()  , +90,0) , _ '162
( @"offi.obj"   , NoObject()  ,   0,0) , _ '163
( SameObject()  , NoObject()  ,-180,0) , _ '164
( SameObject()  , NoObject()  , -90,0) , _ '165
( SameObject()  , NoObject()  , +90,0) , _ '166
( @"wind-$.obj" , NoObject()  ,   0,3) , _ '167
( SameObject()  , NoObject()  ,-180,3) , _ '168
( SameObject()  , NoObject()  , -90,3) , _ '169
( SameObject()  , NoObject()  , +90,3) , _ '170
( @"boat.obj"   , NoObject()  ,   0,0) , _ '171
( SameObject()  , NoObject()  ,-180,0) , _ '172
( SameObject()  , NoObject()  , -90,0) , _ '173
( SameObject()  , NoObject()  , +90,0) , _ '174
( @"rest-$.obj" , NoObject()  ,   0,3) , _ '175
( SameObject()  , NoObject()  ,-180,3) , _ '176
( SameObject()  , NoObject()  , -90,3) , _ '177
( SameObject()  , NoObject()  , +90,3) , _ '178
( AsObject(1)   , @"fini.obj" ,-180,0) , _ '179
( SameObject()  , NoObject()  , +90,0) , _ '180
( SameObject()  , NoObject()  , -90,0) , _ '181
( 0 , 0 , 0 , 0 )  ,  ( 0 , 0 , 0 , 0) , _ '182-183
( SameObject()  , NoObject()  ,   0,0) , _ '184
( SameObject()  , NoObject()  ,-190,0) , _ '185
( SameObject()  , NoObject()  ,-180,0) , _ '186
( SameObject()  , NoObject()  , +90,0) , _ '187
( @"sofr-2.obj" , NoObject()  ,   0,0) , _ '188
( SameObject()  , NoObject()  ,-190,0) , _ '189
( SameObject()  , NoObject()  ,-180,0) , _ '190
( SameObject()  , NoObject()  , +90,0) , _ '191
( @"sofl-3.obj" , NoObject()  ,   0,0) , _ '192
( SameObject()  , NoObject()  ,-190,0) , _ '193
( SameObject()  , NoObject()  ,-180,0) , _ '194
( SameObject()  , NoObject()  , +90,0) , _ '195
( @"sofr-3.obj" , NoObject()  ,   0,0) , _ '196
( SameObject()  , NoObject()  ,-190,0) , _ '197
( SameObject()  , NoObject()  ,-180,0) , _ '198
( SameObject()  , NoObject()  , +90,0) , _ '199
( @"rdup-1.obj" , NoObject()  ,   0,0) , _ '200
( SameObject()  , NoObject()  ,-180,0) , _ '201
( SameObject()  , NoObject()  , -90,0) , _ '202
( SameObject()  , NoObject()  , +90,0) , _ '203
( @"rdup-2.obj" , NoObject()  ,   0,0) , _ '204
( SameObject()  , NoObject()  ,-180,0) , _ '205
( SameObject()  , NoObject()  , -90,0) , _ '206
( SameObject()  , NoObject()  , +90,0) , _ '207
( @"rdup-3.obj" , NoObject()  ,   0,0) , _ '208
( SameObject()  , NoObject()  ,-180,0) , _ '209
( SameObject()  , NoObject()  , -90,0) , _ '210
( SameObject()  , NoObject()  , +90,0) , _ '211
(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0), _ '212-215
(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0), _ '216-219
(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0), _ '220-223
( @"grnd.obj"   , NoObject()  ,   0,0) , _ '224
( @"lake.obj"   , NoObject()  ,   0,0) , _ '225
( AsObject(224) , @"lakc.obj" ,   0,0) , _ '+45,0) , _ '226
( SameObject()  , NoObject()  , -90,0) , _ '-45,0) , _ '227
( SameObject()  , NoObject()  ,-180,0) , _ '-135,0) , _ '228
( SameObject()  , NoObject()  , +90,0) , _ '135,0) , _ '229
( @"high.obj"   , NoObject()  ,   0,0) , _ '230
( @"goup.obj"   , NoObject()  ,  0,-1) , _ '231
( @"godn.obj"   , NoObject()  ,+90,-1) , _ '232
( SameObject()  , NoObject()  ,  0,-1) , _ '233
( AsObject(231) , NoObject()  ,+90,-1) , _ '234
( AsObject(224) , @"gouo.obj" ,   0,0) , _ '235
( SameObject()  , NoObject()  , -90,0) , _ '236
( SameObject()  , NoObject()  ,-180,0) , _ '237
( SameObject()  , NoObject()  , +90,0) , _ '238
( @"goui.obj"   , NoObject()  ,   0,0) , _ '239
( SameObject()  , NoObject()  , -90,0) , _ '240
( SameObject()  , NoObject()  ,-180,0) , _ '241
( SameObject()  , NoObject()  , +90,0) , _ '242
( @"rdup-1.obj" , NoObject()  ,   0,0) , _ '243
( SameObject()  , NoObject()  ,  90,0) , _ '244
( @"rdup-2.obj" , NoObject()  ,   0,0) , _ '245
( SameObject()  , NoObject()  ,  90,0) , _ '246
( @"rdup-3.obj" , NoObject()  ,   0,0) , _ '247
( SameObject()  , NoObject()  ,  90,0) , _ '248
( LastObject()  ,LastObject() , -1,-1) }

#undef NullObject
#undef RepeatObject
#undef OldObject

function LoadTrackModels() as integer
  
  static as integer ModelsLoaded
  if ModelsLoaded then return ModelsLoaded
  
  '151-178
  
  LoadModel("Models/fenc.obj",@Track.Models(tmFence))  
  Track.Models(tmFence).pList = cast(any ptr,ListFromModel(@Track.Models(tmFence)))
  LoadModel("Models/cfen.obj",@Track.Models(tmFenceCorner))
  Track.Models(tmFenceCorner).pList = cast(any ptr,ListFromModel(@Track.Models(tmFenceCorner)))
  ModelsLoaded = tmLast
  
  for CNT as integer = 0 to 255
    dim as integer Special = 0
    with TrackObjects(CNT)
      if .AngleY = -1 and .Frames = -1 then exit for        
      dim as integer Temp = valint(*cptr(zstring ptr,.ObjA)) 'cint(.ObjA)
      if Temp>0 then 'Temp < 256
        if Temp = 255 then Temp = CNT-1
        .ObjA = TrackObjects(Temp).ObjA
        if .ObjB = 0 then 
          .ObjB = TrackObjects(Temp).ObjB 
          continue for
        else 
          Temp=0: Special = 1
        end if        
      end if      
      dim as string ModelFile
      if .ObjA<>0 and Special = 0 then 
        ModelFile = "Models/"+*cptr(zstring ptr,.ObjA)
        if .Frames > 0 then  
          var ModelPos = instr(1,ModelFile,"$")-1
          if ModelPos = -1 then 
            print "No position for the frames...":sleep
          end if            
          for FrameNum as integer = 0 to .Frames
            ModelFile[ModelPos] = 49+FrameNum
            printf(ModelFile & !"(%i %i)\n", _
            LoadModel(ModelFile,@Track.Models(ModelsLoaded)),CNT)
            Track.Models(ModelsLoaded).pList = _
            cast(any ptr,ListFromModel(@Track.Models(ModelsLoaded)))
            'LoadModel(ModelFile,@Track.Models(ModelsLoaded))
            if FrameNum = 0 then .ObjA = @Track.Models(ModelsLoaded)              
            ModelsLoaded += 1
          next FrameNum
        else
          printf(ModelFile & !"(%i %i)\n", _
          LoadModel(ModelFile,@Track.Models(ModelsLoaded)),CNT)
          Track.Models(ModelsLoaded).pList = _
          cast(any ptr,ListFromModel(@Track.Models(ModelsLoaded)))
          'LoadModel(ModelFile,@Track.Models(ModelsLoaded))
          .ObjA = @Track.Models(ModelsLoaded): ModelsLoaded += 1
        end if
      end if
      if .ObjB then
        ModelFile = "Models/"+*cptr(zstring ptr,.ObjB)
        printf(ModelFile & !"(%i %i)\n", _
        LoadModel(ModelFile,@Track.Models(ModelsLoaded)),CNT)
        Track.Models(ModelsLoaded).pList = _
        cast(any ptr,ListFromModel(@Track.Models(ModelsLoaded)))
        'LoadModel(ModelFile,@Track.Models(ModelsLoaded))
        .ObjB = @Track.Models(ModelsLoaded): ModelsLoaded += 1
      end if
    end with
  next CNT
  
  return ModelsLoaded
end function

#ifdef __FB_NDS__
sub Matrix4x4to4x3(M4 as integer ptr, M3 as integer ptr)
  M3[ 0] = M4[ 0]:  M3[ 1] = M4[ 1]:  M3[ 2] = M4[ 2]
  M3[ 3] = M4[ 4]:  M3[ 4] = M4[ 5]:  M3[ 5] = M4[ 6]
  M3[ 6] = M4[ 8]:  M3[ 7] = M4[ 9]:  M3[ 8] = M4[10]
  M3[ 9] = M4[12]:  M3[10] = M4[13]:  M3[11] = M4[14]
end sub
#endif

sub CacheTrack()
  
  Track.ObjectCount = 0
  
  dim as integer GoUp
  dim as any ptr LastGrnd
  
  #ifdef __FB_NDS__
  dim as m4x4 TempMatrix
  #endif
  
  ' ***************************************************************************
  ' ************************ Objects Above Ground *****************************
  ' ***************************************************************************
  #if 1
  glPushMatrix()
  glLoadIdentity()
  #ifdef _x_FB_NDS__  
  glTranslatef32( 15 shl 12, 6 , -15 shl 12 )
  #else
  glTranslatef( 15 , 6*FixScale , -15 )
  #endif  
  
  for Y as integer = 0 to 29
    for X as integer = 29 to 0 step -1
      dim as uinteger Obj = Track.bObject(Y,X), Map = Track.Terrain(29-Y,X)+224      
      dim as single TranslateY = 0
      dim as integer RotateY=180,IgnoreRotation,MatrixAdded
      dim as integer InvalidateMatrix, SkipGround
      glPushMatrix()      
      if Obj < &hFD then        
        if Map = 230 then 
          TranslateY += .4394
        end if
        dim as single XS,YS
        if X < 29 then if Track.bObject(Y,X+1) = &hFF then XS = .5: InvalidateMatrix = 1
        if Y > 0 then if Track.bObject(Y-1,X) = &hFE then YS = .5: InvalidateMatrix = 1
        if Obj > 0 then                    
          with TrackObjects(Obj)             
            glTranslatef( -X-XS , TranslateY , Y-YS ) 
            RotateY -= .AngleY 
            if Obj=101 or Obj=102 then RotateY += 90
            glRotatef(RotateY,0,1,0)
            dim as tModel ptr Temp = .Obja
            if TrackObjects(Map).Frames then
              select case temp
              case TrackObjects( 4).ObjA: Temp = TrackObjects(243).ObjA: SkipGround = 1
              case TrackObjects(14).ObjA: Temp = TrackObjects(245).ObjA: SkipGround = 1
              case TrackObjects(24).ObjA: Temp = TrackObjects(247).ObjA: SkipGround = 1
              case TrackObjects(56).ObjA: Temp = TrackObjects(103).ObjA
              case TrackObjects(95).ObjA: Temp = TrackObjects(103).ObjA
              case TrackObjects(36).ObjA: Temp = TrackObjects(103).ObjA
              end select
              if Map = 232 or Map = 233 then glRotatef(-180,0,1,0): RotateY -= 180
            end if            
            
            'if Temp then               
            '  if cuint(.Frames) < 6 then Temp += (((timer*16)+X+Y) mod (.Frames+1))
            '  DrawModel(Temp)
            'end if            
            'if .ObjB then DrawModel(.ObjB)
            
            if Temp then
              #ifdef __FB_NDS__
              Track.Array(Track.ObjectCount).MatrixPtr = @Track.Array(Track.ObjectCount).Matrix.m(0)              
              glGetFixed( GL_GET_MATRIX_POSITION,@TempMatrix.m(0))
              Matrix4x4to4x3(@TempMatrix.m(0),Track.Array(Track.ObjectCount).MatrixPtr)
              glMatrixMode(GL_MODELVIEW)
              #else
              Track.Array(Track.ObjectCount).MatrixPtr = @Track.Array(Track.ObjectCount).Matrix(0)
              glGetFloatv(GL_MODELVIEW_MATRIX,Track.Array(Track.ObjectCount).MatrixPtr)
              #endif                    
              if .Frames > 0 then
                Track.Array(Track.ObjectCount).ListPtr = Temp
              else
                Track.Array(Track.ObjectCount).ListPtr = cptr(tModel ptr,Temp)->pList
              end if
              Track.Array(Track.ObjectCount).PosX = X '15-X
              Track.Array(Track.ObjectCount).PosY = Y '-15+Y
              Track.Array(Track.ObjectCount).Frames = .Frames
              Track.ObjectCount += 1
              MatrixAdded = 1
              
              if .ObjB then           
                Track.Array(Track.ObjectCount).MatrixPtr = 0
                Track.Array(Track.ObjectCount).ListPtr = cptr(tModel ptr,.ObjB)->pList
                Track.Array(Track.ObjectCount).Frames = 0               
                Track.ObjectCount += 1
              end if
              
            end if
            
            
          end with
        end if
      end if      
      
      if SkipGround then 
        glPopOneMatrix()
        continue for
      end if
      if InvalidateMatrix then MatrixAdded = 0
      if MatrixAdded = 0 then
        glPopOneMatrix()     
        glPushMatrix()
        RotateY=0
      end if
      
      with TrackObjects(Map)
        select case Map        
        case 224,225                    
          LastGrnd = .ObjA: IgnoreRotation = 1
        case 230 'High Terrain
          if MatrixAdded = 0 then
            #ifdef __FB_NDS__  
            glTranslatef32( 0, .4394 * (1 shl 12) , 0 )
            #else
            glTranslatef( 0 , .4394 , 0 )
            #endif
          end if
          GoUp = 0: IgnoreRotation = 1           
        case 231,234
          GoUp = 1
        case 233,232
          GoUp = -1
        case 235 to 238
          .objA = LastGrnd
        case else
          GoUp = 0
        end select     
        if MatrixAdded = 0 then
          #ifdef _x_FB_NDS__  
          glTranslatef32( -X shl 12 , 0 , Y shl 12 ) '-6 shl 2
          #else
          glTranslatef( -X , 0 , Y ) '-6*FixScale
          #endif
        end if
        if IgnoreRotation = 0 then 
          dim as integer TempRotateY = 180-.AngleY
          dim as integer NewRotateY = TempRotateY-RotateY
          while TempRotateY > 180
            TempRotateY -= 360
          wend
          while TempRotateY < -180
            TempRotateY += 360
          wend
          while RotateY > 180
            RotateY -= 360
          wend
          while RotateY < -180
            RotateY += 360
          wend
          if RotateY <> TempRotateY then
            glRotatef( NewRotateY, 0, 1, 0 )
          else
            IgnoreRotation = 1
          end if     
        end if        
        dim as integer CheckGround = .ObjA <> 0
        if .ObjA = TrackObjects(224).ObjA then
          #ifdef SingleGround
          if .ObjB=0 or .ObjB = TrackObjects(224).ObjA then CheckGround = 0
          #endif          
        end if
        if CheckGround then 
          #ifdef __FB_NDS__
          Track.Array(Track.ObjectCount).MatrixPtr = @Track.Array(Track.ObjectCount).Matrix.m(0)          
          glGetFixed( GL_GET_MATRIX_POSITION,@TempMatrix.m(0))
          Matrix4x4to4x3(@TempMatrix.m(0),Track.Array(Track.ObjectCount).MatrixPtr)
          glMatrixMode(GL_MODELVIEW)
          #else
          Track.Array(Track.ObjectCount).MatrixPtr = @Track.Array(Track.ObjectCount).Matrix(0)
          glGetFloatv(GL_MODELVIEW_MATRIX,Track.Array(Track.ObjectCount).MatrixPtr)
          #endif    
          if MatrixAdded=1 and IgnoreRotation=1 then 
            Track.Array(Track.ObjectCount).MatrixPtr = 0
          end if
          Track.Array(Track.ObjectCount).PosX = X '15-X
          Track.Array(Track.ObjectCount).PosY = Y '-15+Y
          Track.Array(Track.ObjectCount).Frames = 0
          #ifdef SingleGround
          if .Obja <> TrackObjects(224).ObjA then
            Track.Array(Track.ObjectCount).ListPtr = cptr(tModel ptr,.ObjA)->pList
          else
            Track.Array(Track.ObjectCount).ListPtr = 0
          end if
          #else
          Track.Array(Track.ObjectCount).ListPtr = cptr(tModel ptr,.ObjA)->pList          
          #endif          
          Track.ObjectCount += 1
        end if
        #ifdef SingleGround
        if .ObjB andalso .ObjB <> TrackObjects(224).ObjB then           
        #else
        if .ObjB then           
          #endif
          Track.Array(Track.ObjectCount).MatrixPtr = 0
          Track.Array(Track.ObjectCount).ListPtr = cptr(tModel ptr,.ObjB)->pList
          Track.Array(Track.ObjectCount).Frames = 0
          Track.ObjectCount += 1
        end if
      end with      
      glPopOneMatrix()      
      
    next X    
  next Y   
  glPopOneMatrix()
  #endif
end sub

function LoadTrack(TrackFile as string) as integer
  
  dim as integer MapFile=freefile()
  dim as ubyte TrackPosi
  
  if open(TrackFile for binary access read as #MapFile) then return 0
  
  if Lof(MapFile) < 1826  then
    TrackPosi = 1
  else
    get #Mapfile,24,TrackPosi
    if TrackPosi = 0 then TrackPosi = 27 else TrackPosi = 25  
  end if    
  
  Get #MapFile,TrackPosi,Track.bObject(0,0),30*30
  Get #MapFile,,Track.Horizon
  Get #MapFile,,Track.Terrain(0,0),30*30  
  close #MapFile
  
  CacheTrack()
  
  return 1
end function

sub RenderTrack()    
  
  #ifdef __FB_NDS__
  glStoreMatrix(30)
  glPolyFmt(POLY_ALPHA(31) or POLY_CULL_NONE or POLY_FOG or POLY_FARPLANE_RENDER)
  #else
  dim as single OrgMatrix(15)
  glGetFloatv(GL_MODELVIEW_MATRIX,@OrgMatrix(0))
  #endif 
  
  #ifdef SingleGround
  #ifdef __FB_NDS__
  glScalef32( 5000 , 5000 , 5000 )
  glTranslatef32( (15-CameraX) shl 12 ,  -10 shl 2 , (-15+CameraY) shl 12 )
  glRotateY(CameraAngle)  
  glColor3f(cMaterial(64),cMaterial(65),cMaterial(66))  
  glBegin( GL_QUADS )  
  glVertex3v16( -32767 , 0 , -32767 )
  glVertex3v16( -32767 , 0 ,  32767 )
  glVertex3v16(  32767 , 0 ,  32767 )
  glVertex3v16(  32767 , 0 , -32767 )
  glEnd()  
  
  #else
  glDisable( GL_DEPTH_TEST )
  glTranslatef( .5 , -10*FixScale , -.5 )
  glColor3f(cMaterial(64),cMaterial(65),cMaterial(66))  
  glBegin( GL_QUADS )
  glVertex3f( -128, 0 , -128 )
  glVertex3f( -128, 0 ,  128 )
  glVertex3f(  128, 0 ,  128 )
  glVertex3f(  128, 0 , -128 )
  glEnd()
  glEnable( GL_DEPTH_TEST )  
  #endif  
  #endif
  '----------------------------------------------------------------------
  #ifdef __FB_NDS__        
  glRestoreMatrix(30)
  dim as integer Check = -1
  for CNT as integer = 0 to Track.ObjectCount-1
    with Track.Array(CNT)      
      if .MatrixPtr then       
        dim as integer dfX = .PosX-CameraX,abx = abs(dfX)
        dim as integer dfY = .Posy-CameraY,aby = abs(dfY)
        dim as integer Temp = CameraAngle
        if abx > 2 or aby > 2 then
          if abx > 8 or aby > 8 then
            Check = 0
          else
            if dfX then         
              Temp -= AtnTab((dfY shl 5)\dfX)
              if dfX < 0 then Temp = 180-abs(Temp)
            else
              if dfy > 0 then Temp -= 90 else Temp += 90
            end if          
            if abs(Temp) <= CameraFOV then Check = -1 else Check = 0
          end if
        else
          Check = -1
        end if        
        if Check then          
          Pack.DmaReady()
          glRestoreMatrix(30)
          glMultMatrix4x3(.MatrixPtr)          
        end if          
      end if            
      if .ListPtr<>0 and Check then        
        if .Frames > 0 then 
          dim as integer Temp = (((timer*16)+CNT) mod (.Frames+1))
          dim as tModel ptr bObject = .ListPtr 'Not the list for animated
          Pack.DmaReady()
          Pack.CallList( bObject[Temp].pList, 1 )          
        else
          Pack.DmaReady()
          Pack.CallList( .ListPtr, 1 )
        end if
      end if      
    end with
  next CNT  
  #else
  glLoadMatrixf(@OrgMatrix(0))
  dim as integer Check = -1
  for CNT as integer = 0 to Track.ObjectCount-1
    with Track.Array(CNT)      
      if .MatrixPtr then
        glLoadMatrixf(@OrgMatrix(0))
        glMultMatrixf( .MatrixPtr )        
      end if
      if .ListPtr then 
        if .Frames > 0 then
          dim as integer Temp = (((timer*16)+CNT) mod (.Frames+1))
          dim as tModel ptr bObject = .ListPtr 'Not the list for animated
          glCallList(cuint(bObject[Temp].pList))
        else          
          glCallList(cuint(.ListPtr))
        end if
      end if      
    end with
  next CNT   
  #endif
  '----------------------------------------------------------------------
  dim as integer DoFence = 1
  #ifdef __FB_NDS__
  if CameraX > 8 and CameraX < 24 then
    if CameraY > 8 and CameraY < 24 then 
      DoFence = 0
    end if
  end if
  #endif
  
  if DoFence then
    #ifdef __FB_NDS__        
    Pack.DmaReady()
    glRestoreMatrix(30)
    glTranslatef32( -14 shl 12 , -3 , -15 shl 12 )
    #else
    glLoadMatrixf(@OrgMatrix(0))
    glTranslatef( -14 , -3*FixScale , -15 )
    #endif  
    for CNTA as integer = 0 to 3
      '#ifdef __FB_NDS__
      glRotatef( 90, 0, 1, 0 )    
      '#else
      '#endif    
      'DrawModel(@Track.Models(tmFenceCorner))
      #ifdef __FB_NDS__
      Pack.CallList(Track.Models(tmFenceCorner).pList)
      #else
      glCallList(cuint(Track.Models(tmFenceCorner).pList))
      #endif    
      for CNT as integer = 1 to 29
        #ifdef _x_FB_NDS__      
        glTranslatef32( -1 shl 12 , 0 , 0 )
        #else
        glTranslatef( -1 , 0 , 0 )
        #endif
        'DrawModel(@Track.Models(tmFence))
        #ifdef __FB_NDS__
        Pack.CallList(Track.Models(tmFence).pList)
        #else
        glCallList(cuint(Track.Models(tmFence).pList))
        #endif  
      next CNT    
    next CNTA
  end if
  
  #ifdef __FB_NDS__        
  glRestoreMatrix(30)
  #else
  glLoadMatrixf(@OrgMatrix(0))
  #endif
  
end sub

scope
  const aPI = 3.141592/180
  const rPI = 1/aPI
  dim as single Temp = -32*32*(1/32)
  for CNT as integer = -32*32 to 32*32
    AtnTab(CNT) = atn(Temp)*rPI
    Temp += 1/32    
  next CNT 
end scope

#if 0
"truk.obj" 'Deliver Truck
"cfen.obj" 'Track Fences Corners
"fenc.obj" 'Track Fences
"cld1.obj" 'Cloud 1
"cld2.obj" 'Cloud 2
"cld3.obj" 'Cloud 3
"sigl.obj" 'Sign Left Turn
"sigr.obj" 'Sign Right Turn
"exp0.obj" 'Explosion Debris 0?
"exp1.obj" 'Explosion Debris 1?
"exp2.obj" 'Explosion Debris 2?
"exp3.obj" 'Explosion Debris 3?
"temp.obj" '???
"flag.obj" '???
"goui.obj" 'Terrain?
"gouo.obj" 'Terrain?
"goup.obj" 'Terrain?
"hig1.obj" 'Terrain?
"hig2.obj" 'Terrain?
"hig3.obj" 'Terrain?
"high.obj" 'Terrain?
"lakc.obj" 'Lake?
"lake.obj" 'Lake?
"lco1.obj" '???
"rco1.obj" '???
#endif
