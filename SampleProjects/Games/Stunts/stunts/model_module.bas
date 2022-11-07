'model(obj) loading module...

dim shared as tModel WheelModel,CarModel
dim shared as integer tire_angle
dim shared as single cMaterial(...) = { _
0.000000,0.000000,0.000000,1.000000, 0.000000,0.000000,0.658824,1.000000, _
0.000000,0.658824,0.000000,1.000000, 0.000000,0.658824,0.658824,1.000000, _
0.658824,0.000000,0.000000,1.000000, 0.658824,0.000000,0.658824,1.000000, _
0.658824,0.329412,0.000000,1.000000, 0.658824,0.658824,0.658824,1.000000, _
0.329412,0.329412,0.329412,1.000000, 0.329412,0.329412,0.988235,1.000000, _
0.329412,0.988235,0.329412,1.000000, 0.329412,0.988235,0.988235,1.000000, _
0.988235,0.329412,0.329412,1.000000, 0.988235,0.329412,0.988235,1.000000, _
0.988235,0.988235,0.329412,1.000000, 0.988235,0.988235,0.988235,1.000000, _
0.141176,0.407843,0.125490,1.000000, 0.360784,0.988235,0.988235,1.000000, _
0.988235,0.988235,0.988235,1.000000, 0.282353,0.282353,0.282353,1.000000, _
0.219608,0.219608,0.219608,1.000000, 0.988235,0.988235,0.329412,1.000000, _
0.282353,0.282353,0.282353,0.800000, 0.125490,0.125490,0.125490,0.800000, _
0.988235,0.988235,0.329412,0.800000, 0.611765,0.392157,0.219608,1.000000, _
0.705882,0.501961,0.329412,1.000000, 0.800000,0.627451,0.501961,1.000000, _
0.847059,0.988235,0.988235,1.000000, 0.611765,0.988235,0.988235,1.000000, _
0.360784,0.988235,0.988235,1.000000, 0.894118,0.768627,0.674510,1.000000, _
0.752941,0.564706,0.423529,1.000000, 0.611765,0.392157,0.219608,1.000000, _
0.611765,0.611765,0.988235,0.800000, 0.988235,0.250980,0.250980,1.000000, _
0.988235,0.486275,0.486275,1.000000, 0.988235,0.250980,0.988235,1.000000, _
0.219608,0.219608,0.219608,1.000000, 0.125490,0.125490,0.125490,1.000000, _
0.752941,0.752941,0.752941,1.000000, 0.000000,0.658824,0.658824,1.000000, _
0.329412,0.988235,0.988235,1.000000, 0.329412,0.329412,0.329412,1.000000, _
0.000000,0.000000,0.000000,1.000000, 0.658824,0.000000,0.000000,1.000000, _
0.658824,0.000000,0.000000,1.000000, 0.988235,0.329412,0.329412,1.000000, _
0.000000,0.000000,0.486275,1.000000, 0.000000,0.000000,0.658824,1.000000, _
0.000000,0.000000,0.815686,1.000000, 0.000000,0.015686,0.988235,1.000000, _
0.705882,0.000000,0.000000,1.000000, 0.894118,0.000000,0.000000,1.000000, _
0.988235,0.125490,0.125490,1.000000, 0.988235,0.250980,0.250980,1.000000, _
0.329412,0.329412,0.329412,1.000000, 0.376471,0.376471,0.376471,1.000000, _
0.439216,0.439216,0.439216,1.000000, 0.486275,0.486275,0.486275,1.000000, _
0.894118,0.847059,0.000000,1.000000, 0.988235,0.956863,0.125490,1.000000, _
0.988235,0.972549,0.360784,1.000000, 0.988235,0.988235,0.611765,1.000000, _
0.000000,0.611765,0.611765,1.000000, 0.000000,0.800000,0.800000,1.000000, _
0.000000,0.894118,0.894118,1.000000, 0.250980,0.988235,0.988235,1.000000, _
0.313725,0.517647,0.000000,1.000000, 0.454902,0.705882,0.000000,1.000000, _
0.564706,0.894118,0.000000,1.000000, 0.627451,0.988235,0.000000,1.000000, _
0.266667,0.000000,0.439216,1.000000, 0.376471,0.000000,0.611765,1.000000, _
0.501961,0.000000,0.800000,1.000000, 0.658824,0.000000,0.988235,1.000000, _
0.690196,0.690196,0.690196,1.000000, 0.752941,0.752941,0.752941,1.000000, _
0.800000,0.800000,0.800000,1.000000, 0.862745,0.862745,0.862745,1.000000, _
0.423529,0.345098,0.000000,1.000000, 0.517647,0.454902,0.000000,1.000000, _
0.705882,0.643137,0.000000,1.000000, 0.800000,0.752941,0.000000,1.000000, _
0.439216,0.000000,0.000000,1.000000, 0.517647,0.000000,0.000000,1.000000, _
0.705882,0.000000,0.000000,1.000000, 0.800000,0.000000,0.000000,1.000000, _
0.000000,0.000000,0.250980,1.000000, 0.156863,0.000000,0.250980,1.000000, _
0.203922,0.000000,0.345098,1.000000, 0.313725,0.000000,0.517647,1.000000, _
0.219608,0.219608,0.219608,1.000000, 0.282353,0.282353,0.282353,1.000000, _
0.800000,0.800000,0.800000,0.800000, 0.454902,0.705882,0.000000,1.000000, _
0.988235,0.988235,0.988235,1.000000, 0.658824,0.658824,0.658824,1.000000, _
0.611765,0.392157,0.219608,1.000000, 0.752941,0.376471,0.172549,1.000000, _
0.000000,0.501961,0.815686,1.000000, 0.517647,0.878431,0.517647,1.000000, _
0.439216,0.768627,0.423529,1.000000, 0.345098,0.658824,0.345098,1.000000, _
0.313725,0.611765,0.298039,1.000000, 0.219608,0.501961,0.203922,1.000000, _
0.862745,0.862745,0.862745,1.000000, 0.690196,0.690196,0.690196,1.000000, _
0.564706,0.329412,0.062745,1.000000, 0.423529,0.345098,0.000000,1.000000, _
0.345098,0.000000,0.000000,1.000000, 0.454902,0.250980,0.031373,1.000000, _
0.439216,0.000000,0.000000,1.000000, 0.501961,0.329412,0.172549,1.000000, _
0.329412,0.000000,0.329412,1.000000, 0.643137,0.000000,0.643137,1.000000, _
0.878431,0.000000,0.894118,1.000000, 0.988235,0.360784,0.988235,1.000000, _
0.988235,0.988235,0.988235,0.000000, 0.282353,0.282353,0.282353,0.950000, _
0.172549,0.172549,0.172549,0.400000, 0.988235,0.988235,0.988235,0.600000, _
0.690196,0.690196,0.690196,0.200000, 0.988235,0.972549,0.360784,0.600000, _
0.988235,0.674510,0.329412,0.200000, 0.988235,0.000000,0.000000,0.600000, _
0.611765,0.000000,0.000000,0.200000, 0.988235,0.329412,0.329412,1.000000, _
0.862745,0.862745,0.862745,1.000000, 0.000000,0.000000,0.000000,1.000000 }

#ifndef __FB_NDS__
dim shared as ubyte Stipple (5,(4*32)-1) = { _
{ &b00000000,&b00000000,&b00000000,&b00000000,   _
&b00000000,&b00000000,&b00000000,&b00000000 }, _ 
{ &b00101001,&b00101001,&b00101001,&b00101001,   _
&b10010100,&b10010100,&b10010100,&b10010100 }, _ 
{ &b11001100,&b11001100,&b11001100,&b11001100,   _
&b00110011,&b00110011,&b00110011,&b00110011 }, _ 
{ &b11010110,&b11010110,&b11010110,&b11010110,   _
&b01101011,&b01101011,&b01101011,&b01101011 }, _ 
{ &b10111011,&b10111011,&b10111011,&b10111011,   _
&b11101110,&b11101110,&b11101110,&b11101110 }, _
{ &b00110011,&b00110011,&b00110011,&b00110011,   _
&b11001100,&b11001100,&b11001100,&b11001100 } } 

scope
  for SCNT as integer = 0 to 4
    for VCNT as integer = 8 to (4*32)-1 step 8
      for HCNT as integer = 0 to 7
        Stipple(SCNT,VCNT+HCNT) = Stipple(SCNT,VCNT+HCNT-8)
      next HCNT
    next VCNT
  next SCNT
end scope
#endif

sub CalculateSurfaceNormal( spVertices as short ptr, Polygon as short ptr, VertCount as integer, NormalOut as short ptr )
	'exit sub
  
	const x=0,y=1,z=2
	dim as single v1x, v2x, vcx
	dim as single v1y, v2y, vcy
	dim as single v1z, v2z, vcz
  
	dim as short ptr PCurr = spVertices+Polygon[0] 'first vertex...
	dim as short ptr PNext = spVertices+Polygon[1] 'second vertex...
	dim as short ptr PEnd  = spVertices+Polygon[2] 'thrid vertex...
  
	'first vertex
	v1x = (pNext[x] - pCurr[x])
	v1y = (pNext[y] - pCurr[y])
	v1z = (pNext[z] - pCurr[z])
  
	'second vertex
	v2x = (pEnd[x] - pCurr[x])
	v2y = (pEnd[y] - pCurr[y])
	v2z = (pEnd[z] - pCurr[z])
  
	'cross product
	vcx = (v1y * v2z) - (v2y * v1z)
	vcy = (v1z * v2x) - (v2z * v1x)
	vcz = (v1x * v2y) - (v2x * v1y)
  
	'normalize
	dim as single magrecip = 1/sqr(vcx * vcx + vcy * vcy + vcz * vcz)
	NormalOut[x] = (vcx*magrecip)*1023.99
	NormalOut[y] = (vcy*magrecip)*1023.99
	NormalOut[z] = (vcz*magrecip)*1023.99
  
end sub

function LoadModel(sFileName as string, ptModel as tModel ptr) as integer
	dim as short ptr spVertices,spShapes
	dim as integer VertPos,ShapPos,VertMax,ShapMax,NumPos
	dim as integer FileSz,LinePosi,NextLine,iMaterial
	dim as integer ModFile = freefile()
	dim as string ModelData
	static as string sNumber
	dim as integer ptr psNumber = cast(any ptr,@sNumber)
  'dim as zstring*256 zTemp
  
	const FixAspect = 1'200/240
  
  if open(sFilename+".cache" for binary access read as #ModFile) = 0 then    
    FileSz = lof(ModFile)    
    get #ModFile,1,VertPos
    get #ModFile,,ShapPos
    if FileSz = ((VertPos+ShapPos+2) shl 1)+8 then          
      spVertices = allocate((VertPos+1) shl 1)
      spShapes = allocate((ShapPos+1) shl 1)
      get #ModFile,,*cptr(ubyte ptr,spVertices),(VertPos+1) shl 1
      get #ModFile,,*cptr(ubyte ptr,spShapes),(ShapPos+1) shl 1
      close #ModFile
      spShapes[ShapPos] = skLast
      ptModel->CheckSum = cuint(spVertices) xor cuint(spShapes)
      ptModel->spVertices = spVertices
      ptModel->spShapes = spShapes	
      ModelData = ""      
      return VertPos\3
    else
      print "Bad Cache file...": sleep
    end if
  end if
  
	if open(sFilename for binary access read as #ModFile) then
		printf("Failed to open: " & sFilename & !"\n"): sleep: return 0
  end if
  
	FileSz = lof(ModFile)
	ModelData = string$(FileSz,0)
	dim as any ptr DataPtr = strptr(ModelData)
	get #ModFile,1,*cptr(ubyte ptr,DataPtr),FileSz
	close #ModFile
  
	spVertices = allocate(2048*2): VertMax = 2024 '32
	spShapes = allocate(2048*2): ShapMax = 2024 '32
	VertPos = 0
  
	LinePosi = 0: NextLine = 0
	psNumber[1] = 10
	do
		if VertPos > VertMax then
			VertMax += 32: spVertices = reallocate(spVertices,(VertMax+32) shl 1)
			'print ,VertMax
    end if
		if ShapPos > ShapMax then
			ShapMax += 32: spShapes = reallocate(spShapes, (ShapMax+32) shl 1)
			'print ,ShapMax
    end if
    
		NextLine = instr(LinePosi+1,ModelData,chr$(10))
		if NextLine <= 0 then NextLine = FileSz
		if (NextLine-LinePosi) > 4 then
			NumPos = -1
			var ShapeType = ModelData[LinePosi]
			'print "[" & mid$(ModelData,LinePosi+1,(NextLine-LinePosi)-1) & "]"
      'print mid$(ModelData,LinePosi+1,(NextLine-LinePosi)-1):sleep 100,1
      
      'memcpy(@zTemp,strptr(ModelData)+LinePosi,(NextLine-LinePosi)-1)
      'zTemp[(NextLine-LinePosi)-1] = 10
      'zTemp[(NextLine-LinePosi)] = 0
      'printf zTemp
      
      select case ShapeType
      #macro ReadNumber(ipos,outvar)
      if NumPos = -1 then
        NumPos = ipos
      else
        do
          NumPos += 1
          if (LinePosi+NumPos) >= (NextLine-1) then exit do
        loop until *cptr(ubyte ptr,DataPtr+LinePosi+NumPos) = 32
      end if
      if (LinePosi+NumPos) >= (NextLine-1) then
        outvar = 0
      else
        do while *cptr(ubyte ptr,DataPtr+LinePosi+NumPos) = 32
          NumPos += 1
        loop
        *psNumber = cint(DataPtr+LinePosi+NumPos)
        outvar = val(sNumber)          
      end if
      #endmacro
      
    case asc("v"),asc("V") 'print "Vertice"
      dim as integer fX,fY,fZ          
      ReadNumber(1,fX)
      ReadNumber(0,fY)
      ReadNumber(0,fZ)          
      spVertices[VertPos+0] = fX
      spVertices[VertPos+1] = fY'*FixAspect
      spVertices[VertPos+2] = -fZ
      VertPos += 3
      'print fX,fY,fZ: sleep
    case asc("f"),asc("F") 'print "Face"
      dim as integer CNT, iIndex, iTemp = ShapPos+1					
      spShapes[ShapPos] = skFace
      ShapPos += 5
      for CNT = 0 to 9
        ReadNumber(1,iIndex)
        if iIndex = 0 then exit for
        iIndex = (iIndex-1)*3
        spShapes[ShapPos] = iIndex 'xyz
        ShapPos += 1
      next CNT          
      
      for INV as integer = 1 to (((CNT-1) shr 1))
        swap spShapes[ShapPos-INV], spShapes[ShapPos-CNT+INV]
      next INV
      
      spShapes[iTemp] = CNT
      CalculateSurfaceNormal(spVertices,spShapes+iTemp+4,CNT,spShapes+iTemp+1)
      
      case asc("l"),asc("L") 'print "Line"
        dim as integer iA,iB					
        spShapes[ShapPos] = skLine
        ReadNumber(1,iA)
        ReadNumber(0,iB)
        spShapes[ShapPos+1] = (iA-1)*3 'xyz
        spShapes[ShapPos+2] = (iB-1)*3 'xyz
        ShapPos += 3
      case asc("#"),asc("o")          'print "Comment"
        'print "Comment"
      case asc("u"),asc("U") 'print "Select Material":
        ReadNumber(13,iMaterial)
        spShapes[ShapPos] = skMaterial
        spShapes[ShapPos+1] = iMaterial
        ShapPos += 2
      case asc("m")          'print "Material lib"
        'print "Material lib"
      case else              'Other? error or not implemented!!!
        print "Other: [" & mid$(ModelData,LinePosi+1,(NextLine-LinePosi)-2) & "]"
        sleep
      end select
    end if
    if NextLine >= FileSz then exit do
    LinePosi = NextLine
  loop

  spVertices = reallocate(spVertices,(VertPos+1) shl 1)
  spShapes = reallocate(spShapes,(ShapPos+1) shl 1)

  spShapes[ShapPos] = skLast	
  ptModel->CheckSum = cuint(spVertices) xor cuint(spShapes)
  ptModel->spVertices = spVertices
  ptModel->spShapes = spShapes
  ModelData = ""

  #ifndef __FB_NDS__
  printf(!"Caching... %s \n",sFilename+".cache")
  if open(sFilename+".cache" for binary access write as #ModFile)=0 then
    put #ModFile,1,VertPos
    put #ModFile,,ShapPos        
    put #ModFile,,*cptr(ubyte ptr,spVertices),(VertPos+1) shl 1
    put #ModFile,,*cptr(ubyte ptr,spShapes),(ShapPos+1) shl 1
    close #ModFile
  end if
  #endif

  return VertPos\3

end function

sub DrawWheel( pVertices as short ptr, iV1 as short , iV2 as short , iV3 as short , iV4 as short , IsMain as short )  
  'find center
  const x=0,y=1,z=2
  #define v(a,b) pVertices[iV##a+b]
  dim as integer p1x=v(1,x) , p1y=v(1,y) , p1z=v(1,z)
  dim as integer p2x=v(2,x) , p2y=v(2,y) , p2z=v(2,z)
  dim as integer p3x=v(3,x) , p3y=v(3,y) , p3z=v(3,z)
  dim as integer p4x=v(4,x) , p4y=v(4,y) , p4z=v(4,z)
  
  dim as integer wx = (p1x-p4x), wy = (p1y-p4y) , wz = (p1z-p4z)
  dim as integer sx = (p1x-p2x), sy = (p1y-p2y) , sz = (p1z-p2z)
  dim as single scalex = sqr(wx*wx+wy*wy+wz*wz)*(1/3)
  dim as single scaley = sqr(sx*sx+sy*sy+sz*sz)*(1/12)
  
  dim as single AngleY = any
  if IsMain < 0 then
    AngleY = atan2( p4z-p1z , p4x-p1x ) * (180/3.141592)
  else
    AngleY = 0
  end if
  
  p4x = ((p1x+p4x) shr 1)
  p4y = ((p1y+p4y) shr 1)
  p4z = ((p1z+p4z) shr 1)
  
  scope
    
    glpushmatrix()
    gltranslatef( p4x*fixscale , p4y*fixscale , p4z*fixscale )
    if cuint(IsMain) <= 2 then
    	glrotatef( tire_angle, 0, 1, 0 )
    else
      glrotatef( AngleY, 0, 1, 0 )
    end if
    if IsMain > 0 then      
      glrotatef( timer*50,-1,0,0)
    end if
    
    glscalef( scalex*(1/128), scaley*(1/128), scaley*(1/128) ) ' y an dz need to be the same, or else it will become an ellipse
    
    var spShapes = WheelModel.spShapes
    var spVertices = wheelModel.spVertices
    
    dim as integer si,shape
    dim as integer max_vert
    
    do
      shape = spShapes[si]: si += 1    
      select case shape    
      case skFace  'draw a polygon...
        
        max_vert = spShapes[si]
        
        #ifdef __FB_NDS__
        CheckFifoFull()
        #endif
        
        select case max_vert
        case 3: glBegin( GL_TRIANGLES )
        case 4: glBegin( GL_QUADS )
        case else: printf !"No POLYGONS HERE! LOL \n" 'glBegin( GL_POLYGON )
        end select
        
        'glnormal3s(	spShapes[si+1], spShapes[si+2], spShapes[si+3] )
        'glnormal3f(spShapes[si+1]*FixScale, spShapes[si+2]*FixScale, spShapes[si+3]*FixScale )
        si += 3
        
        for vi as integer = 1 to max_vert
          dim as integer Shape = spShapes[si+vi]        
          'glvertex3s( SpVertices[Shape] , spVertices[Shape+1] , spVertices[Shape+2])        
          glvertex3f( SpVertices[Shape]*FixScale, spVertices[Shape+1]*FixScale , spVertices[Shape+2]*FixScale )
        next        
        si += (max_vert+1)
        glEnd()
        
      case skMaterial      'change color/alpha properties
    		
        dim as integer i = spShapes[si]*4: si += 1
        glcolor3f( cMaterial(i), cMaterial(i+1), cMaterial(i+2)) 'cMaterial(i+3) )
        
      case skLast
        exit do
      case else
        end
      end select
      
    loop
    
    glPopOneMatrix()
  end scope
end sub

sub DrawModel(ptModel as tModel ptr)  
  
  if ptModel = 0 then 
    printf !"Bad Pointer...\n":exit sub
  end if
  
  var spShapes = ptModel->spShapes
  var spVertices = ptModel->spVertices
  if ptModel->CheckSum <> (cuint(spVertices) xor cuint(spShapes)) then
    printf(!"CheckSum: %i \n",ptModel->CheckSum)
    printf !"Bad Pointer...\n":exit sub
  end if
  
  dim as integer si,shape
  dim as integer max_vert,iMaterial
  dim as integer MainTires = 0
  
  do
    shape = spShapes[si]: si += 1    
    select case shape 
    case skFace  'draw a polygon... 
      if iMaterial = 38 and spShapes[si] = 6 then 
        if MainTires >= 0 then MainTires += 1
        'it's a wheel!
        'skip past normal index
        max_vert = spShapes[si]: si += 3               
        #define s(x) SpShapes[si+x]
        DrawWheel( spVertices , s(1) , s(2) , s(3) , s(4) , MainTires )
        si += (max_vert+1)        
      else      
        if MainTires > 0 then MainTires = -1
	      max_vert = spShapes[si]	      	              
        
        #ifndef __FB_NDS__
        glnormal3f(spShapes[si+1]*FixScale, spShapes[si+2]*FixScale, spShapes[si+3]*FixScale )
        #endif
        
        #ifdef __FB_NDS__
        CheckFifoFull()
        #endif
        
        select case max_vert
	      case 3: glBegin( GL_TRIANGLES )
	      case 4: glBegin( GL_QUADS )	      
	      end select
	      
        si += 3
	      
        if max_vert <= 4 then
          for vi as integer = 1 to max_vert
            dim as integer Shape = spShapes[si+vi]          
            #ifdef __FB_NDS__
            glvertex3v16(SpVertices[Shape] shl 2,SpVertices[Shape+1] shl 2,SpVertices[Shape+2] shl 2)
            #else
            glvertex3f( SpVertices[Shape]*FixScale, spVertices[Shape+1]*FixScale , spVertices[Shape+2]*FixScale )
            #endif
          next 
          #ifndef __FB_NDS__
          glEnd()      
          #endif
        end if
        
	      si += (max_vert+1)
	      
	      
      end if
      
    case skLine 'draw a line...
      #ifdef __FB_NDS__
      glBegin( GL_TRIANGLE )
      dim as integer ShapeA = spShapes[si], ShapeB = spShapes[si+1]
      glvertex3f( SpVertices[ShapeA+0]*FixScale, spVertices[ShapeA+1]*FixScale , spVertices[ShapeA+2]*FixScale )
      glvertex3f( SpVertices[ShapeB+0]*FixScale, spVertices[ShapeB+1]*FixScale , spVertices[ShapeB+2]*FixScale )
      glvertex3f( SpVertices[ShapeB+0]*FixScale, spVertices[ShapeB+1]*FixScale , spVertices[ShapeB+2]*FixScale )
      'glEnd()
      #else
      glBegin( GL_LINES )
      dim as integer ShapeA = spShapes[si], ShapeB = spShapes[si+1]
      glvertex3f( SpVertices[ShapeA+0]*FixScale, spVertices[ShapeA+1]*FixScale , spVertices[ShapeA+2]*FixScale )
      glvertex3f( SpVertices[ShapeB+0]*FixScale, spVertices[ShapeB+1]*FixScale , spVertices[ShapeB+2]*FixScale )
      glEnd()
      #endif
      si += 2
    case skMaterial      'change color/alpha properties
    	
    	iMaterial = spShapes[si]
      dim as integer i = iMaterial*4: si += 1
      'printf(!"%g %g %g\n",cMaterial(i),cMaterial(i+1),cMaterial(i+2))
      'sleep
      'glcolor3f( cMaterial(i)*CameraMul, cMaterial(i+1)*CameraMul, cMaterial(i+2)*CameraMul) 'cMaterial(i+3) )
      
      #ifdef __FB_NDS__
      CheckFifoFull()
      #endif
      
      glcolor3f( cMaterial(i), cMaterial(i+1), cMaterial(i+2) )
      
      #if 1
      #ifndef __FB_NDS__
      static as integer Last = -2
      dim as integer Check = cMaterial(i+3)<1.0
      if Last <> Check then
        if Check then
          'glEnable( GL_ALPHA_TEST )
          'glAlphaFunc ( GL_GREATER, 0 )
          'glDisable( GL_DEPTH_TEST )
          glEnable(GL_POLYGON_STIPPLE)
          glPolygonStipple(@Stipple(cint(cMaterial(i+3)*5),0))
        else
          'glDisable( GL_ALPHA_TEST )
          'glEnable( GL_DEPTH_TEST )
          glDisable(GL_POLYGON_STIPPLE)
        end if
        Last = Check
      end if
      #endif 
      #endif
      
    case skLast
      exit do
    case else            
      printf !"Bug?\n":sleep:exit sub
    end select       
  loop
  
  #ifndef __FB_NDS__
  glDisable(GL_POLYGON_STIPPLE)
  #endif
  
end sub

#ifdef __FB_NDS__
function ListFromModel(ptModel as tModel ptr) as glList  
  
  if ptModel = 0 then 
    printf !"Bad Pointer...\n":return 0
  end if  
  var spShapes = ptModel->spShapes
  var spVertices = ptModel->spVertices
  if ptModel->CheckSum <> (cuint(spVertices) xor cuint(spShapes)) then
    printf(!"CheckSum: %i \n",ptModel->CheckSum)
    printf !"Bad Pointer...\n":return 0
  end if
  
  dim as integer si,shape,iColor
  dim as integer max_vert,iMaterial
  dim as integer MainTires = 0,iAlphaCnt=0
  
  dim as glList ModelList = Pack.NewList()
  dim as integer iAlphaOff(31)
  
  do
    shape = spShapes[si]: si += 1    
    select case shape 
    case skFace  'draw a polygon... 
      if iMaterial = 38 and spShapes[si] = 6 then 'it's a wheel!
        if MainTires >= 0 then MainTires += 1        
        'skip past normal index
        max_vert = spShapes[si]: si += 3               
        #define s(x) SpShapes[si+x]
        'DrawWheel( spVertices , s(1) , s(2) , s(3) , s(4) , MainTires )
        si += (max_vert+1)        
      else      
        if MainTires > 0 then MainTires = -1
	      max_vert = spShapes[si]	      	              
        
        pack.LightColori(iColor)
        'pack.Normal3f(spShapes[si+1]*FixScale, spShapes[si+2]*FixScale, spShapes[si+3]*FixScale )
        'pack.Normali( NORMAL_PACK((spShapes[si+1] shr 1), _
        '(spShapes[si+2] shr 1), (spShapes[si+3] shr 1) ) )        
        
        select case max_vert
	      case 3: Pack.Begin( GL_TRIANGLES )
	      case 4: Pack.Begin( GL_QUADS )	      
	      end select
	      
        si += 3	      
        if max_vert <= 4 and iMaterial<>118 then '118 = transparent
          for vi as integer = 1 to max_vert
            dim as integer Shape = spShapes[si+vi]                      
            Pack.Vertex3v16(SpVertices[Shape] shl 2,SpVertices[Shape+1] shl 2,SpVertices[Shape+2] shl 2)            
          next           
        end if        
	      si += (max_vert+1)
	      
      end if
      
    case skLine 'draw a line...
      if iMaterial<>118 then
        dim as integer iID = si and 63 '(iMaterial and 63) '63
        Pack.PolyFmt(POLY_ALPHA(0) or POLY_CULL_NONE or _
        POLY_FOG or POLY_ID(iID) or POLY_FORMAT_LIGHT0)
        Pack.Begin( GL_TRIANGLE )
        dim as integer ShapeA = spShapes[si], ShapeB = spShapes[si+1]
        Pack.Vertex3v16( SpVertices[ShapeA+0] shl 2, spVertices[ShapeA+1] shl 2 , spVertices[ShapeA+2] shl 2 )
        Pack.Vertex3v16( SpVertices[ShapeB+0] shl 2, spVertices[ShapeB+1] shl 2 , spVertices[ShapeB+2] shl 2 )
        Pack.Vertex3v16((SpVertices[ShapeB+0] shl 2) xor 0, (spVertices[ShapeB+1] shl 2) xor 0 , (spVertices[ShapeB+2] shl 2) xor 0)
      end if
      si += 2
    case skMaterial      'change color/alpha properties
      dim as integer ZFight = 0
      iMaterial = spShapes[si]
      if iMaterial > 128 then iMaterial -= 129': ZFight = 1
      dim as integer i = iMaterial*4: si += 1      
      
      iColor = Pack.Color3f( cMaterial(i), cMaterial(i+1), cMaterial(i+2) )
      'iColor = ((cMaterial(i))*31.49)+ _
      '(((cMaterial(i+1))*31.49) shl 5)+ _
      '(((cMaterial(i+2))*31.49) shl 10)
      'pack.LightColori(iColor)
      
      dim as integer iAlpha = int(cMaterial(i+3)*31.99), iID = si and 63 '(iMaterial and 63) 'cMaterial(i+3)*10
      if iID = 63 then iID = 24 else if iID = 0 then iID = 48
      if iMaterial >= 101 and iMaterial <= 105 then 
        'iID = 2 ?
      end if      
      if ZFight then 'POLY_DEPTH_EQUAL
        Pack.PolyFmt( POLY_ALPHA(30) or POLY_CULL_NONE or POLY_FORMAT_LIGHT0 or _
        POLY_FARPLANE_RENDER or POLY_FOG or Poly_ID(iID))
      else
        if iMaterial = 21 then
          Pack.PolyFmt( POLY_ALPHA(31) or POLY_CULL_NONE or POLY_FARPLANE_RENDER or _
          POLY_ALPHADEPTH_UPDATE or POLY_FOG or Poly_ID(iID) or POLY_FORMAT_LIGHT0)          
        else          
          if iAlpha < 31 then            
            Pack.PolyFmt( POLY_ALPHA(31) or POLY_CULL_NONE or POLY_FORMAT_LIGHT0 or _
            POLY_FARPLANE_RENDER or POLY_ALPHADEPTH_UPDATE or POLY_FOG or Poly_ID(0))
            iAlphaOff(iAlphaCnt) = Pack.GetOffset()-1: iAlphaCnt += 1
            if iAlphaCnt > 30 then printf !"AlphaCount overflow!\n":iAlphaCnt -= 1
          else
            Pack.PolyFmt( POLY_ALPHA(31) or POLY_CULL_NONE or POLY_FORMAT_LIGHT0 or _
            POLY_FARPLANE_RENDER or POLY_FOG or Poly_ID(iID))
          end if
          'iAlpha
        end if
      end if

    case skLast
      exit do
    case else      
      printf !"Bug?\n":sleep:return 0
    end select    
    
  loop
  
  Pack.EndList()
  if iAlphaCnt then 'Make 50% alpha effect
    iAlphaOff(iAlphaCnt) = -1: iAlphaCnt += 1
    ModelList = reallocate(ModelList,(*ModelList+1+iAlphaCnt) shl 2)
    memcpy(ModelList+*ModelList+1,@iAlphaOff(0),iAlphaCnt shl 2)
    *ModelList or= &h8000 
  end if
  return ModelList
  
end function
#else
function ListFromModel(ptModel as tModel ptr) as glList  
  if ptModel = 0 then 
    printf !"Bad Pointer...\n":return 0
  end if  
  var spShapes = ptModel->spShapes
  var spVertices = ptModel->spVertices
  if ptModel->CheckSum <> (cuint(spVertices) xor cuint(spShapes)) then
    printf(!"CheckSum: %i \n",ptModel->CheckSum)
    printf !"Bad Pointer...\n":return 0
  end if
  
  dim as integer si,shape
  dim as integer max_vert,iMaterial
  dim as integer MainTires = 0
  
  dim as glList ModelList = glGenLists(1)
  glNewList(ModelList,GL_COMPILE)
  
  do
    shape = spShapes[si]: si += 1    
    select case shape 
    case skFace  'draw a polygon... 
      if iMaterial = 38 and spShapes[si] = 6 then 
        if MainTires >= 0 then MainTires += 1
        'it's a wheel!
        'skip past normal index
        max_vert = spShapes[si]: si += 3               
        #define s(x) SpShapes[si+x]
        DrawWheel( spVertices , s(1) , s(2) , s(3) , s(4) , MainTires )
        si += (max_vert+1)        
      else      
        if MainTires > 0 then MainTires = -1
	      max_vert = spShapes[si]	      	                      
        glnormal3f(spShapes[si+1]*FixScale, spShapes[si+2]*FixScale, spShapes[si+3]*FixScale )
        
        select case max_vert
	      case 3: glBegin( GL_TRIANGLES )
	      case 4: glBegin( GL_QUADS )
	      end select
	      
        si += 3
	      
        if max_vert <= 4 then 'and iMaterial<>118 then
          for vi as integer = 1 to max_vert
            dim as integer Shape = spShapes[si+vi]            
            glvertex3f( SpVertices[Shape]*FixScale, spVertices[Shape+1]*FixScale , spVertices[Shape+2]*FixScale )            
          next           
          glEnd()
        end if
        
	      si += (max_vert+1)
        
      end if
      
    case skLine 'draw a line...
      'if iMaterial<>118 then
        glBegin( GL_LINES )
        dim as integer ShapeA = spShapes[si], ShapeB = spShapes[si+1]
        glvertex3f( SpVertices[ShapeA+0]*FixScale, spVertices[ShapeA+1]*FixScale , spVertices[ShapeA+2]*FixScale )
        glvertex3f( SpVertices[ShapeB+0]*FixScale, spVertices[ShapeB+1]*FixScale , spVertices[ShapeB+2]*FixScale )
        glEnd()      
      'end if
      si += 2
    case skMaterial      'change color/alpha properties
    	
    	iMaterial = spShapes[si]
      if iMaterial > 128 then iMaterial -= 129
      dim as integer i = iMaterial*4: si += 1
      glcolor3f( cMaterial(i), cMaterial(i+1), cMaterial(i+2) )
      
      'if iMaterial = 21 then
      '  glDepthFunc( GL_ALWAYS )
      'else
      '  glDepthFunc( GL_LESS )
      'end if
      
      #if 1
      static as integer Last = -2
      dim as integer Check = cMaterial(i+3)<1.0
      if Last <> Check then
        if Check then
          'glEnable( GL_ALPHA_TEST )
          'glAlphaFunc ( GL_GREATER, 0 )
          'glDisable( GL_DEPTH_TEST )
          glEnable(GL_POLYGON_STIPPLE)
          glPolygonStipple(@Stipple(cint(cMaterial(i+3)*5),0))
        else
          'glDisable( GL_ALPHA_TEST )
          'glEnable( GL_DEPTH_TEST )
          glDisable(GL_POLYGON_STIPPLE)
        end if
        Last = Check
      end if
      #endif
      
    case skLast
      exit do
    case else            
      printf !"Bug?\n":sleep:return 0
    end select
    
  loop
  
  glDisable(GL_POLYGON_STIPPLE)
  glEndList()
  
  return ModelList
  
end function
#endif