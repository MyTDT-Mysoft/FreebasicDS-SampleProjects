#Include once "model_module.bi"

sub Load_Obj(Filename as const string, byref Model as Model3D ptr, byval iTexture_offset as integer )
  dim as string  FileRec
  dim as integer  i
  dim as uinteger FileID = freefile
  dim as uinteger vertex_counter
  dim as uinteger triangle_counter
  dim as uinteger uv_counter
  dim as uinteger Current_Group
  dim as uinteger Red,Green,Blue
  dim as double LoadTime = stimer()
  
  if Model then 
    iTexture_offset = 0
    beep:print "Model already allocated!!!"
    sleep 1000,1:exit sub
  end if  
  Model = callocate( sizeof( Model3D ))
  if Model=0 then
    beep:print "unable to allocate model: " & Filename
    sleep 1000,1:exit sub
  end if    
  if open(Filename for binary access read as #FileID) then
    beep:print "unable to open: " & Filename
    sleep 1000,1:exit sub
  end if
  
  static as string SpeedUp
  dim as integer RecSz,IsHeader=1
  dim as any ptr RecPtr
  dim as integer ptr SpeedUpPtr = cast(any ptr,@SpeedUp)
  
  '#define SingleBlockRead
  
  #ifdef SingleBlockRead    
    dim as integer FileSize = lof(FileID),LineSize
    dim as ubyte ptr FileCurrentPtr,LinePosi,FileData = allocate(FileSize+1)
    dim as uinteger ptr StrHead = cast(any ptr,@FileRec)
    if FileData=0 then print "No Memory to load file...":beep:sleep:exit sub    
    get #FileID,1,*FileData,FileSize: FileData[FileSize] = 0    
    FileCurrentPtr=FileData:close #FileID    
    #macro ReadOneLine()      
      LinePosi = memchr(FileCurrentPtr,10,FileSize)      
      if LinePosi then
        LineSize = cuint(LinePosi)-cuint(FileCurrentPtr)        
        StrHead[0] = cuint(FileCurrentPtr):FileSize -= (LineSize+1)
        FileCurrentPtr += (LineSize+1)
        if *cptr(ubyte ptr,LinePosi-1)=13 then LineSize -= 1
        StrHead[1] = LineSize: StrHead[2] = LineSize+1
        RecSz = len(FileRec): RecPtr = strptr(FileRec)
        'color 8: print left$(FileRec,30): color 15: sleep 100,1
      else
        StrHead[0] = cuint(FileCurrentPtr): StrHead[1] = FileSize
        FileSize=0: StrHead[2] = -1
      end if
    #endmacro
    #define EndOfFile() (FileSize<=0)
    #macro FileClose()      
      deallocate(FileData)
      StrHead[0]=0:StrHead[1]=0:StrHead[2]=0      
    #endmacro    
  #else
    #macro ReadOneLine() 
      line input #FileID, FileRec      
    #endmacro
    #define EndOfFile() eof(FileID)
    #define FileClose() close #FileID
  #endif  
  
  dim as string VertText = "Vertices:"
  dim as string FaceText = "Faces:"
  SpeedUpPtr[2] = -1
 
  do while not EndOfFile()
    
    ReadOneLine()
    RecSz = len(FileRec): RecPtr = strptr(FileRec)
    
    
    if isHeader and RecSz > 5 then      
      dim as integer Result
      Result = instr( FileRec, VertText )
      if Result then          
        'Allocate our vertices
        SpeedUpPtr[0] = cuint(RecPtr+Result+(10-1)): SpeedUpPtr[1] = recsz-(Result+(10-1))
        Model->iMax_vertices   = valint(SpeedUp)        
        if Model->iMax_vertices then
          Model->vert16    = callocate(Model->iMax_vertices*sizeof(typeof(*(Model->vert16   ))))
          Model->tvertices = callocate(Model->iMax_vertices*sizeof(typeof(*(Model->tvertices))))
          Model->pvertices = callocate(Model->iMax_vertices*sizeof(typeof(*(Model->pvertices))))
          if Model->vert16 = 0 or Model->tvertices = 0 or Model->pvertices = 0 then
            beep:print "Failed to allocate model vertices: " & Filename
            sleep 1000,1:exit sub
          end if
        end if
        'Model->vnormals       = Callocate( Model->max_vertices * Sizeof( Vector3D ) )
      end if
      if Result=0 then 
        Result = instr( FileRec, FaceText )
        if Result then          
          'Allocate our triangles
          SpeedUpPtr[0] = cuint(RecPtr+Result+(7-1)): SpeedUpPtr[1] = recsz-(Result+(7-1))
          Model->iMax_triangles = valint(SpeedUp)          
          if Model->iMax_triangles then
            Model->triangles = callocate( Model->iMax_triangles * sizeof( Triangle3D ) )            
            'Model->tnormals      = Callocate( Model->max_triangles * Sizeof( Vector3D ) )
            if model->triangles=0 then
              beep:print "Failed to allocate model faces: " & Filename
              sleep 1000,1:exit sub
            end if
          end if
        end if
      end if
      #if 0
      'Allocate our surfaces, or materials as LW calls them
      if instr( FileRec, "Materials:" ) then
        print "Materials!!!"
        'Model->max_surfaces  = Val(Mid$(FileRec, Instr( FileRec, "Materials:" ) + 11 ))
        'Model->surfaces      = Callocate( Model->max_surfaces * Sizeof( Surface3D ) )
      end if
      #endif
    end if
    
    'used later for sorting materials
    'this will allow us to bunch all the triangles that...
    'use the same texture into one block
    'then, we don't have to call glbindtexture nearly as much
    
    if RecSz >= (13+7) andalso *cptr(uinteger ptr,RecPtr) = cvi("usem") then
      IsHeader=0
      if *cptr(ushort ptr,RecPtr+4) = cvshort("tl") then
        SpeedUpPtr[0] = cuint(RecPtr+(7-1)): SpeedUpPtr[1] = recsz-((7-1))
        Current_Group = valint(SpeedUp) 'Valint( Mid$( FileRec, 7 ) )
        SpeedUpPtr[0] = cuint(RecPtr+5+(7-1)): SpeedUpPtr[1] = recsz-(5+(7-1))
        Red   = valint(SpeedUp) 'Valint(Mid$( FileRec, 5+7 ) )
        SpeedUpPtr[0] = cuint(RecPtr+9+(7-1)): SpeedUpPtr[1] = recsz-(9+(7-1))
        Green = valint(SpeedUp) 'Valint(Mid$( FileRec, 9+7 ) )
        SpeedUpPtr[0] = cuint(RecPtr+13+(7-1)): SpeedUpPtr[1] = recsz-(13+(7-1))
        Blue  = valint(SpeedUp) 'Valint(Mid$( FileRec, 13+7 ) )
      end if
    end if
    
    if RecSz > 2 then
      select case *cptr(ushort ptr,RecPtr)
      case cvshort("v ")
        'process a vertex here
        'vertices are loaded straight into an array by themselves.
        dim as integer space_counter = 0
        IsHeader=0        
        for i = 0 to RecSz-1
          if *cptr(ubyte ptr,RecPtr+i) = asc(" ") then 
            space_counter+=1
            SpeedUpPtr[0] = cuint(RecPtr+i+1): SpeedUpPtr[1] = recsz-(i+1)
            with Model->vert16[vertex_counter]
              select case space_counter
              case 1 'first space  = X
                .nX = ToFixed(val(SpeedUp))              
              case 2 'second space = Y
                .nY = ToFixed(val(SpeedUp))              
              case 3 'third space  = Z
                .nZ = ToFixed(val(SpeedUp))
              end select
            end with
          end if
        next
        vertex_counter+=1 'increment the vertex array counter
      case cvshort("vt")
        print "vt????"
        #if 0
        'process a texture uv here
        'they are actually listed before the faces that they belong to.
        'In otherwords, the uvs we are about to load, 
        'belong to the triangle we will load next.
        'So, our uv_counter cycles from 1 to 3
        dim as integer space_counter = 0
        IsHeader=0
        uv_counter  = (uv_counter mod 3) + 1
        for i = 1 to len( FileRec )
          if FileRec[i-1] = asc(" ") then 
            space_counter+=1
            select case space_counter
            case 1
              'first space  = U
              'Model->triangles[triangle_counter].texcoord(4-uv_counter).u = Val(Mid$( FileRec, i+1 ) )
            case 2
              'second space = V
              'Model->triangles[triangle_counter].texcoord(4-uv_counter).v = Val(Mid$( FileRec, i+1 ) )
            end select
          end if
        next
        #endif        
      case cvshort("f ")
        'process a triangle/face here.
        'we have to subtract one because we're using pointers
        'and a pointer array is 0 relative.
        'Model->triangles[triangle_counter].Group = Current_Group
        Model->triangles[triangle_counter].col = type( Red, Green, Blue )
        IsHeader=0
        dim as integer space_counter = 0
        var PointIDx = (@(Model->triangles[triangle_counter].iPointID1))
        for i = 1 to len( FileRec )
          if *cptr(ubyte ptr,RecPtr+i) = asc(" ") then 
            i += 1: SpeedUpPtr[0] = cuint(RecPtr+i): SpeedUpPtr[1] = recsz-i
            PointIDx[space_counter] = valint(SpeedUp)-1
            space_counter+=1
          end if
        next        
        triangle_counter+=1 'increment the triangle index counter
      end select
    end if
  
  loop
  
  FileClose()
 
  Calc_Planes( Model )
  Calc_Normals( Model )
  'Set_Poly_Neighbors( Model )
 
  dim as string TempFile = Filename+string$(25-len(FileName),32)
  color 11:printf(strptr(TempFile))
  printf(!"%4i \x08ms\n",cint((sTimer()-LoadTime)*1000)): color 15    

  
end sub

sub GetSurfaces( byval FileID as uinteger, Store_Name() as string )
  dim as string FileRec
  dim as integer i, Surf_Cntr
  
  do while not eof(FileID)
    line input #FileID, FileRec
    
    if mid$( FileRec, 1, 6 ) = "usemtl" then
      dim as integer Skip_Add = False
      
      for i = 0 to ubound(Store_Name)
        if FileRec = Store_Name(i) then Skip_Add = true
      next
      
      if Skip_Add = False then
        Store_Name(Surf_Cntr) = FileRec
        Surf_Cntr+=1
      end if
    end if
    
  loop
  seek FileID, 1
end sub

sub Calc_Normals( byref Model as Model3D ptr )
  dim vTriangle(2) as Vector3D, Normal as Vector3D
  dim i as integer, i2 as integer
  
  for i = 0 to Model->iMax_triangles -1
    var ModelTriangle = @(Model->triangles[i])
    #macro RepeatI2(i2)
    with Model->vert16[ModelTriangle->iPointID##i2]
      vTriangle(i2-1).nX = .nX
      vTriangle(i2-1).nY = .nY
      vTriangle(i2-1).nZ = .nZ
    end with
    #endmacro
    RepeatI2(1)
    RepeatI2(2)
    RepeatI2(3)
      
    Poly_Normal(@Vtriangle(0), Normal)
    ModelTriangle->Normal = Normal
    
    'For i2 = 1 To 3
    '    Model->vnormals[Model->triangles[i].point_Id(i2)] + = Normal
    'Next
  next
  
  '    For i = 0 To Model->max_triangles -1
  '        For i2 = 1 To 3
  '            Vector_Normalize Model->vnormals[Model->triangles[i].point_Id(i2)]
  '        Next
  '    Next
end sub

sub Calc_Planes( byref Model as Model3D ptr )
  dim as integer i
  dim as Vector3D V1,V2,V3
  
  var ModelVert = Model->vert16
  for i = 0 to Model->iMax_triangles-1
    var pModelTriangle = @(Model->triangles[i])
    #macro RepeatVx(ID)
    with ModelVert[pModelTriangle->iPointID##ID]
      V##ID.nX = .nX
      V##ID.nY = .nY
      V##ID.nZ = .nZ
    end with
    #endmacro
    RepeatVx(1)
    RepeatVx(2)
    RepeatVx(3)
    
    #define fmf(aa,bb) FixedMulFixed(aa,bb)
    #define fmf2(aa2,bb2) FixedMulFixed(aa2,bb2)
    with Model->triangles[i].Plane
      .nX = fmf(v1.nY , (v2.nZ-v3.nZ)) + fmf(v2.nY , (v3.nZ-v1.nZ)) + fmf(v3.nY , (v1.nZ-v2.nZ))
      .nY = fmf(v1.nZ , (v2.nX-v3.nX)) + fmf(v2.nZ , (v3.nX-v1.nX)) + fmf(v3.nZ , (v1.nX-v2.nX))
      .nZ = fmf(v1.nX , (v2.nY-v3.nY)) + fmf(v2.nX , (v3.nY-v1.nY)) + fmf(v3.nX , (v1.nY-v2.nY))      
      .nW = -( fmf(v1.nX,( fmf2(v2.nY , v3.nZ) - fmf2(v3.nY , v2.nZ) )) + _
      fmf(v2.nX,(fmf2(v3.nY , v1.nZ) - fmf2(v1.nY , v3.nZ) )) + _
      fmf(v3.nX,(fmf2(v1.nY , v2.nZ) - fmf2(v2.nY , v1.nZ) )) )
    end with
  next
end sub

sub Set_Poly_Neighbors( byref Model as Model3D ptr )
	
  'dim as integer f, f2
  'dim as integer i, i2
  'dim as integer Hitcnt
  'dim as integer P1a, P1b, P2a, P2b, C1a, C2a, C1b, C2b
  '
  'for f = 0 to Model->iMax_triangles-1
  '  var pModTriF = @(Model->triangles[f])    
  '  pModTriF->iCon1 = 0
  '  pModTriF->iCon2 = 0
  '  pModTriF->iCon3 = 0    
  'next
  '
  'for f = 0 to Model->iMax_triangles-2
  '  var pTrif = @(Model->triangles[f])
  '  var pModTriFCON = (@(pTrif->iCon1))
  '  var pTriFID = @(pTrif->iPointID1)
  '  
  '  for f2 = f+1 to Model->iMax_triangles-1
  '    var pTrif2 = @(Model->triangles[f2])
  '    var pModTriF2CON = (@(pTrif2->iCon1))
  '    var pTriF2ID = @(pTrif->iPointID1)
  '    
  '    for i = 0 to 2
  '      
  '      if pModTriFCON[i] = 0 then
  '        for i2 = 0 to 2
  '          
  '          P1a = i: P1b = i2
  '          P2a = (p1a+1)+((p1a=2) and -3) '1..2..0
  '          P2b = (p1b+1)+((p1b=2) and -3) '1..2..0
  '          
  '          P1a = pTriFID[P1a]
  '          P2a = pTriFID[P2a]
  '          P1b = pTriF2ID[P1b]
  '          P2b = pTriF2ID[P2b]
  '          
  '          C1a=((P1a+P2a) - abs(P1a-P2a)) shr 1
	'					C2a=((P1a+P2a) + abs(P1a-P2a)) shr 1
	'					C1b=((P1b+P2b) - abs(P1b-P2b)) shr 1
	'					C2b=((P1b+P2b) + abs(P1b-P2b)) shr 1
  '          
  '          if (C1a = C1b) and (C2a = C2b) then
  '            pModTriFCON[i] = f2+1
  '            pModTriF2CON[i2] = f+1
  '          end if
  '          
  '        next
  '      end if
  '    next
  '  next
  'next
  
end sub

sub UnloadMesh( byref Model as Model3D ptr )
  Model->iMax_vertices=0:Model->iMax_triangles=0:'Model->max_surfaces=0
  deallocate( Model->vert16 )    :  Model->vert16= 0
  'Deallocate( Model->vNormals ) : Model->vNormals = 0
  deallocate( Model->triangles ) : Model->triangles = 0
  'Deallocate( Model->surfaces ) : Model->max_surfaces = 0
  deallocate( Model ): Model = 0
end sub
