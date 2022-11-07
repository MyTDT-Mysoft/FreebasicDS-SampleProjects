#print "Compiling use inlined asm MATH LIBRARY"

sub d3Matrix_Load_Identity( Matrix as Number ptr )    
  #define n(num) ToFixed(num)
  static as typeof(*Matrix) NewMatrix(...) = { _
  n(1),n(0),n(0),n(0), _
  n(0),n(1),n(0),n(0), _
  n(0),n(0),n(1),n(0), _
  n(0),n(0),n(0),n(1) }
  memcpy( Matrix, @NewMatrix(0), MAT_SIZE )    
end sub

sub d3Matrix_Copy( Dest as number ptr, Src as number ptr )
  memcpy( Dest, Src, MAT_SIZE )
end sub

sub d3Matrix_Scale( Matrix as number ptr, Scalarx as const number, byref Scalary as number, byref Scalarz as number )

  Matrix[0 ] = Scalarx
  Matrix[5 ] = Scalary
  Matrix[10] = Scalarz
  
end sub

sub d3Matrix_Mul_Matrix ( Matrix_1 as number ptr, Matrix_2 as number ptr)
  
  static Matrix_R(15) as number = any  
  #define Mat2xMat1(m2,m1) FixedMulFixed(Matrix_2[m2],Matrix_1[m1])
  Matrix_R( 0) = (Mat2xMat1( 0,0))+(Mat2xMat1( 1,4))+(Mat2xMat1( 2, 8))+(Mat2xMat1( 3,12))
  Matrix_R( 1) = (Mat2xMat1( 0,1))+(Mat2xMat1( 1,5))+(Mat2xMat1( 2, 9))+(Mat2xMat1( 3,13))
  Matrix_R( 2) = (Mat2xMat1( 0,2))+(Mat2xMat1( 1,6))+(Mat2xMat1( 2,10))+(Mat2xMat1( 3,14))
  Matrix_R( 3) = (Mat2xMat1( 0,3))+(Mat2xMat1( 1,7))+(Mat2xMat1( 2,11))+(Mat2xMat1( 3,15))
  Matrix_R( 4) = (Mat2xMat1( 4,0))+(Mat2xMat1( 5,4))+(Mat2xMat1( 6, 8))+(Mat2xMat1( 7,12))
  Matrix_R( 5) = (Mat2xMat1( 4,1))+(Mat2xMat1( 5,5))+(Mat2xMat1( 6, 9))+(Mat2xMat1( 7,13))
  Matrix_R( 6) = (Mat2xMat1( 4,2))+(Mat2xMat1( 5,6))+(Mat2xMat1( 6,10))+(Mat2xMat1( 7,14))
  Matrix_R( 7) = (Mat2xMat1( 4,3))+(Mat2xMat1( 5,7))+(Mat2xMat1( 6,11))+(Mat2xMat1( 7,15))
  Matrix_R( 8) = (Mat2xMat1( 8,0))+(Mat2xMat1( 9,4))+(Mat2xMat1(10, 8))+(Mat2xMat1(11,12))
  Matrix_R( 9) = (Mat2xMat1( 8,1))+(Mat2xMat1( 9,5))+(Mat2xMat1(10, 9))+(Mat2xMat1(11,13))
  Matrix_R(10) = (Mat2xMat1( 8,2))+(Mat2xMat1( 9,6))+(Mat2xMat1(10,10))+(Mat2xMat1(11,14))
  Matrix_R(11) = (Mat2xMat1( 8,3))+(Mat2xMat1( 9,7))+(Mat2xMat1(10,11))+(Mat2xMat1(11,15))
  Matrix_R(12) = (Mat2xMat1(12,0))+(Mat2xMat1(13,4))+(Mat2xMat1(14, 8))+(Mat2xMat1(15,12))
  Matrix_R(13) = (Mat2xMat1(12,1))+(Mat2xMat1(13,5))+(Mat2xMat1(14, 9))+(Mat2xMat1(15,13))
  Matrix_R(14) = (Mat2xMat1(12,2))+(Mat2xMat1(13,6))+(Mat2xMat1(14,10))+(Mat2xMat1(15,14))
  Matrix_R(15) = (Mat2xMat1(12,3))+(Mat2xMat1(13,7))+(Mat2xMat1(14,11))+(Mat2xMat1(15,15))  
  Memcpy( Matrix_1, @Matrix_R(0), MAT_SIZE )
  
end sub

sub d3Matrix_Inverse( Inverse as number ptr ,  m as number ptr )
  #define n ToFixed  
	Inverse[0]  = m[0]: Inverse[1] = m[4]: Inverse[2]  = m[8]
	Inverse[4]  = m[1]: Inverse[5] = m[5]: Inverse[6]  = m[9]
	Inverse[8]  = m[2]: Inverse[9] = m[6]: Inverse[10] = m[10]
	Inverse[3]  = n(0): Inverse[7] = n(0): Inverse[11] = n(0)
	Inverse[15] = n(1)
  #define fmf fixedmulfixed
	Inverse[12] = -(fmf(m[12],m[0])) - (fmf(m[13],m[1])) - (fmf(m[14],m[2]))
	Inverse[13] = -(fmf(m[12],m[4])) - (fmf(m[13],m[5])) - (fmf(m[14],m[6]))
	Inverse[14] = -(fmf(m[12],m[8])) - (fmf(m[13],m[9])) - (fmf(m[14],m[10]))    
end sub

sub d3Matrix_LookAt(  Matrix as number ptr, byref v1 as vector3d, byref v2 as vector3d, byref up as vector3d )
  dim as Vector3D d = type(v1.nX-v2.nX,v1.nY-v2.nY,v1.nZ-v2.nZ)
  vector_normalize( d )
  dim as Vector3D r = any
  vector_cross( d, up, r)
  dim as Vector3D u = any
  vector_cross( r, d , u )
  vector_normalize( r )
  vector_normalize( u )
  
  Matrix[0 ] = r.nX
  Matrix[4 ] = r.nY
  Matrix[8 ] = r.nZ
  Matrix[1 ] = u.nX
  Matrix[5 ] = u.nY
  Matrix[9 ] = u.nZ
  Matrix[2 ] = -d.nX
  Matrix[6 ] = -d.nY
  Matrix[10] = -d.nZ
  
  dim as number Matrix2(15) = any
  d3Matrix_Load_Identity( @Matrix2(0) )
  Matrix2(12)=-v1.nX
  Matrix2(13)=-v1.nY
  Matrix2(14)=-v1.nZ
  
  d3Matrix_Mul_Matrix( Matrix, @Matrix2(0) )
end sub

sub d3Matrix_Plane_Projection( M as number ptr,byref LightPos as Vector4D,byref Plane as Vector4D )
  
  dim as number Dot = any, xx = any, yy = any, zz = any , ww = any
  
  with plane
    xx = FixedMulFixed(.nX , LightPos.nX)
    yy = FixedMulFixed(.nY , LightPos.nY)
    zz = FixedMulFixed(.nZ , LightPos.nZ)
    ww = FixedMulFixed(.nW , LightPos.nW)
    dot = xx+yy+zz+ww
    
    M[ 0] = dot-xx
    M[ 1] = FixedMulFixed(-LightPos.nY , .nX)
    M[ 2] = FixedMulFixed(-LightPos.nZ , .nX)
    M[ 3] = FixedMulFixed(-LightPos.nW , .nX)
    
    M[ 4] = FixedMulFixed(-LightPos.nX , .nY)
    M[ 5] = dot-yy
    M[ 6] = FixedMulFixed(-LightPos.nZ , .nY)
    M[ 7] = FixedMulFixed(-LightPos.nW , .nY)
    
    M[ 8] = FixedMulFixed(-LightPos.nX , .nZ)
    M[ 9] = FixedMulFixed(-LightPos.nY , .nZ)
    M[10] = dot-zz
    M[11] = FixedMulFixed(-LightPos.nW , .nZ)
    
    M[12] = FixedMulFixed(-LightPos.nX , .nW)
    M[13] = FixedMulFixed(-LightPos.nY , .nW)
    M[14] = FixedMulFixed(-LightPos.nZ , .nW)
    M[15] = dot-ww
  end with
end sub

sub d3Matrix_Translate(M as number ptr,X as const number,Y as const number,Z as const number)
  static as number T(15) = any
  #define n(num) ToFixed(num)
  if T(0)<>n(1) then
    : T( 0)=n(1) : T( 1)=n(0) : T( 2)=n(0) : T( 3)=n(0)
    : T( 4)=n(0) : T( 5)=n(1) : T( 6)=n(0) : T( 7)=n(0)
    : T( 8)=n(0) : T( 9)=n(0) : T(10)=n(1) : T(11)=n(0)
    :            :            :            : T(15)=n(1)
  end if
  : : T(12) = X  : T(13) = Y  : T(14) = Z  :
  d3Matrix_Mul_Matrix(M,@T(0))
end sub

sub d3Matrix_Rotate(Matrix as number ptr,AngleX as const integer,AngleY as const integer,AngleZ as const integer)
  static as number TX(15)=any
  static as number TY(15)=any
  static as number TZ(15)=any
  dim as number tcos = any
  dim as number tsin = any
  
  #define n(num) ToFixed(num)
  
  if TX(15)<>n(1) then
    TX( 0)=n(1) : TX( 1)=n(0) : TX( 2)=n(0) : TX( 3)=n(0)
    TX( 4)=n(0) :             :             : TX( 7)=n(0)
    TX( 8)=n(0) :             :             : TX(11)=n(0)
    TX(12)=n(0) : TX(13)=n(0) : TX(14)=n(0) : TX(15)=n(1)
  end if
  if TY(15)<>n(1) then
    TY( 1)=n(0) :             : TY( 3)=n(0)
    TY( 4)=n(0) : TY( 5)=n(1) : TY( 6)=n(0) : TY( 7)=n(0)
    TY( 9)=n(0) :             : TY(11)=n(0)
    TY(12)=n(0) : TY(13)=n(0) : TY(14)=n(0) : TY(15)=n(1)
  end if
  if TZ(15)<>n(1) then
    TZ( 2)=n(0) : TZ( 3)=n(0)
    TZ( 6)=n(0) : TZ( 7)=n(0)
    TZ( 8)=n(0) : TZ( 9)=n(0) : TZ(10)=n(1) : TZ(11)=n(0)
    TZ(12)=n(0) : TZ(13)=n(0) : TZ(14)=n(0) : TZ(15)=n(1)
  end if
  if AngleX<>0 then
    tcos = ToFixed( cos( AngleX * sPid180 ) )
    tsin = ToFixed( sin( AngleX * sPid180 ) )
    tx( 5)= tcos: tx( 6)= tsin: tx( 9)=-tsin: tx(10)= tcos
    d3Matrix_Mul_Matrix( Matrix, @tx(0) )
  end if
  
  if AngleY<>0 then
    tcos = ToFixed( cos( AngleY * sPid180 ) )
    tsin = ToFixed( sin( AngleY * sPid180 ) )
    ty( 0)= tcos: ty( 2)=-tsin: ty( 8)= tsin: ty(10)= tcos
    d3Matrix_Mul_Matrix(Matrix,@ty(0))
  end if
  
  if AngleZ<>0 then
    tcos = ToFixed( cos( AngleZ * (sPid180) ) )
    tsin = ToFixed( sin( AngleZ * (sPid180) ) )
    tz(0) = tcos: tz(1) = tsin: tz(4) =-tsin: tz(5) = tcos
    d3Matrix_Mul_Matrix(Matrix,@tz(0) )
  end if
end sub

sub d3Matrix_Mul_Vector3D( M as number ptr, byref vIn as Vector3D, byref vOut as Vector3D ) 
  'Dim As Vector3D vOut = any    
  var vinX = vIn.nX, vInY = vIn.nY , vInZ = vIn.nZ
  #define fmf(aa,bb) FixedMulFixed(aa,bb)
  vOut.nX = fmf(vInX,M[0]) + fmf(vInY,M[4]) + fmf(vInZ,M[ 8]) + M[12]
  vOut.nY = fmf(vInX,M[1]) + fmf(vInY,M[5]) + fmf(vInZ,M[ 9]) + M[13]
  vOut.nZ = fmf(vInX,M[2]) + fmf(vInY,M[6]) + fmf(vInZ,M[10]) + M[14]    
  'Return vOut
end sub

function Vector_Dot (byref v1 as Vector3D, byref v2 as Vector3D) as number
  #define fmf(aa,bb) FixedMulFixed(aa,bb)
  return fmf(v1.nX,v2.nX) + fmf(v1.nY,v2.nY) + fmf(v1.nZ,v2.nZ)
end function

sub Vector_Cross ( byref v1 as Vector3D, byref v2 as Vector3D, byref V as Vector3D)
  'Dim As Vector3D v = any
  #define fmf(aa,bb) FixedMulFixed(aa,bb)
  v.nX = (fmf(v1.nY , v2.nZ)) - (fmf(v2.nY , v1.nZ))
  v.nY = (fmf(v1.nZ , v2.nX)) - (fmf(v2.nZ , v1.nX))
  v.nZ = (fmf(v1.nX , v2.nY)) - (fmf(v2.nX , v1.nY))
  'Return v
end sub

sub Vector_Normalize (byref v as Vector3D)      
  dim as float svx = ToFloat(v.nX)
  dim as float svy = ToFloat(v.nY)
  dim as float svz = ToFloat(v.nZ)  
  dim as float tdist = svx*svx+svy*svy+svz*svz
  dim as float xhalf = 0.5f*tdist
  var ti = *cast( integer ptr, @tdist )
  ti = &h5f3759df - (ti shr 1)
  tdist = *cast( single ptr, @ti )
  tdist = tdist*(1.5f - xhalf*tdist*tdist)
  dim nMag as number = ToFixed(tdist)
  v.nX = FixedMulFixed(v.nX,nMag)
  v.nY = FixedMulFixed(v.nY,nMag)
  v.nZ = FixedMulFixed(v.nZ,nMag)

  #if 0  
  #define fmf FixedMulFixed      
  dim as number vx = fmf(v.nX,v.nX)
  dim as number vy = fmf(v.nY,v.nY)
  dim as number vz = fmf(v.nZ,v.nZ)
  dim as float svx = ToFloat(v.nX)
  dim as float svy = ToFloat(v.nY)
  dim as float svz = ToFloat(v.nZ)
  dim temp as number = (fmf(v.nX,v.nX) + fmf(v.nY,v.nY) + fmf(v.nZ,v.nZ))
    
  if temp > 0 then    
    dim nMag as number = any,nMag2 as number = any
    #if 1
    if temp >= ToFixedi(1) then      
      nMag2 = SqrTab(FixedInverse(Temp))
    else
      'print #99, temp
      nMag2 = FixedInverse(Cint(SqrTab(Temp)))
    end if    
    #endif
    nMag = ToFixed(1/sqr(ToFloat(temp)))
    if abs(nMag-nMag2) > 128 then 
      print #99, "error!",nMag,nMag2
    end if
    v.nX = FixedMulFixed(v.nX,nMag)
    v.nY = FixedMulFixed(v.nY,nMag)
    v.nZ = FixedMulFixed(v.nZ,nMag)
  elseif temp < 0 then
    print #99,,,v.nX,v.nY,v.nZ
    print #99,,vx,vy,vz
    print #99,FloatClipFix(ToFloat(v.nX)),FloatClipFix(ToFloat(v.nY)),FloatClipFix(ToFloat(v.nZ))
    sleep 100,1
  end if
  #endif
  
end sub

sub Poly_Normal(pV as Vector3D ptr, byref tNorm as Vector3D)    
  dim as Vector3D V1 = type(pV[1].nX-(pV->nX),pV[1].nY-(pV->nY),pV[1].nZ-(pV->nZ))
  dim as Vector3D V2 = type(pV[2].nX-(pV->nX),pV[2].nY-(pV->nY),pV[2].nZ-(pV->nZ))
  Vector_Cross( V1, V2, tNorm )
  Vector_Normalize(tNorm)
end sub

function Distance( byref vP1 as Vector3D, byref vP2 as Vector3D) as number    
  dim as float vx = ToFloat((vP2.nX - vP1.nX))
  dim as float vy = ToFloat((vP2.nY - vP1.nY))
  dim as float vz = ToFloat((vP2.nZ - vP1.nZ))  
  return ToFixed(Sqr(vx*vx+vy*vy+vz*vz))  
end function

function Plane_Distance( byref tNormal as Vector3D, byref tPoint as Vector3D) as number
  #define fmf(aa,bb) FixedMulFixed(aa,aa)
  return -(fmf(tNormal.nX,tPoint.nX) + fmf(tNormal.nY,tPoint.nY) + fmf(tNormal.nZ,tPoint.nZ))
end function

sub ClosestPointOnLine( byref Va as Vector3D, byref Vb as Vector3D, byref vPoint as Vector3D, byref vReturn as Vector3D )
  dim vVector1 as Vector3D, vVector2 as Vector3D, vVector3 as Vector3D
  dim d as number, t as number
  
  vVector1.nX = VPoint.nX - Va.nX
  vVector1.nY = VPoint.nY - Va.nY
  vVector1.nZ = VPoint.nZ - Va.nZ
  
  vVector2.nX = Vb.nX - Va.nX
  vVector2.nY = Vb.nY - Va.nY
  vVector2.nZ = Vb.nZ - Va.nZ
  
  Vector_Normalize(vVector2)
  
  d = Distance(vA, vB)
  t = Vector_Dot(vVector2, vVector1)
  
  if t<=ToFixed(0) then 
    vReturn.nX = Va.nX
    vReturn.nY = Va.nY
    vReturn.nZ = Va.nZ
    exit sub
  elseif t>=d then 
    vReturn.nX = Vb.nX
    vReturn.nY = Vb.nY
    vReturn.nZ = Vb.nZ
    exit sub
  end if
  
  vVector3.nX = FixedMulFixed(vVector2.nX , t)
  vVector3.nY = FixedMulFixed(vVector2.nY , t)
  vVector3.nZ = FixedMulFixed(vVector2.nZ , t)
  
  vReturn.nX = Va.nX + vVector3.nX
  vReturn.nY = Va.nY + vVector3.nY
  vReturn.nZ = Va.nZ + vVector3.nZ
end sub

function Is_Inside_Polygon( byref vIntersection as Vector3D, pV as Vector3D ptr) as integer
  if SameSide(vInterSection, pV[0], pV[1], pV[2]) then
    if SameSide(vInterSection, pV[1], pV[0], pV[2]) then
      if SameSide(vInterSection, pV[2], pV[0], pV[1]) then 
        return true
      end if
    end if
  end if
end function

function SameSide( byref vp1 as Vector3D, byref vp2 as Vector3D, byref a as Vector3D, byref b as Vector3D ) as integer
  dim cp1 as Vector3D,cp2 as Vector3D,tVector1 as Vector3D,tVector2 as Vector3D
  
  tVector1.nX = (  b.nX-a.nX)
  tVector1.nY = (  b.ny-a.nY)
  tVector1.nZ = (  b.nZ-a.nZ)    
  tVector2.nX = (vp1.nX-a.nX)
  tVector2.nY = (vp1.ny-a.nY)
  tVector2.nZ = (vp1.nZ-a.nZ)
  Vector_Cross(tVector1,tVector2, cp1)
  
  tVector2.nX = (vp2.nX-a.nX)
  tVector2.nY = (vp2.ny-a.nY)
  tVector2.nZ = (vp2.nZ-a.nZ)
  Vector_Cross(tVector1,tVector2, cp2)
  function = Vector_Dot(cp1, cp2) >= ToFixed(0)
end function

sub Get_Collision_Offset(byref vNormal as Vector3D, Radius as const number, Dist as const number, byref vOffSet as Vector3D)
  dim DistanceOver as number = Radius - Dist    
  vOffSet.nX = FixedMulFixed(vNormal.nX , DistanceOver)
  vOffSet.nY = FixedMulFixed(vNormal.nY , DistanceOver)
  vOffSet.nZ = FixedMulFixed(vNormal.nZ , DistanceOver)
end sub

function Classify_Sphere(byref vCenter as Vector3D, byref VNormal as Vector3D, byref vPoint as Vector3D, Radius as const number, Dist as number ptr) as integer
  dim D as number = Plane_Distance(vNormal, vPoint)
  #define vnormalXvcenter(suf) FixedMulFixed(vNormal.##suf,vCenter.##suf)
  dim as Number Temp = (vnormalXvcenter(nX)  + vnormalXvcenter(nY) + vnormalXvcenter(nZ) + D)
  *Dist = Temp  
  if abs(Temp) < Radius then
    return SPHERE_INTERSECTS
  end if
  if Temp >= Radius then
    return SPHERE_FRONT
  else
    return SPHERE_BEHIND
  end if
end function

function Edge_Sphere_Collision( byref vCenter as Vector3D, pV as Vector3D ptr, Radius as const number ) as integer
  dim vPoint as Vector3D, Dist as number
  dim i as integer, iAnd1 as integer   
  for i = 0 to 2
    iAnd1 = (i+1)+((i=2) and -3)
    ClosestPointOnLine( pV[i], pV[iAnd1], vCenter, VPoint )   
    Dist = Distance(vPoint, VCenter)
    if Dist < Radius then return true
  next 
end function
