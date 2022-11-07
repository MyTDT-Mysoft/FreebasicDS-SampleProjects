#include once "3dmath.bi"

#ifdef UseInlineAsm
#include "3dMath_x86.bas"
#else
'operator Vector3D.cast( ) As Vector4D
'    return Type<Vector4D>(x, y, z, 0)
'End operator

'Function Cotangent( angle as const single ) As Single
'    Return 1 / tan(angle)
'End Function
#ifdef NOT_UseFixedPoint
dim shared as NumberSmall SqrTab(FixMul)
dim shared as short SqrtabInit
if SqrTabInit = 0 then
  for CNT as integer = 0 to FixMul    
    if CNT then
      SqrTab(CNT) = ToFixed(sqr(ToFloat(CNT+.5)))
    else
      SqrTab(CNT) = 0
    end if
  next CNT
  SqrTabInit = 1
end if
#endif

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

sub d3matrix_inverse( Inverse as number ptr ,  m as number ptr )
  #define n ToFixed  
	Inverse[0]  = m[0]: Inverse[1] = m[4]: Inverse[2]  = m[8]
	Inverse[4]  = m[1]: Inverse[5] = m[5]: Inverse[6]  = m[9]
	Inverse[8]  = m[2]: Inverse[9] = m[6]: Inverse[10] = m[10]
	Inverse[3]  = n(0): Inverse[7] = n(0): Inverse[11] = n(0)
	Inverse[15] = n(1)
  '#define fmf fixedmulfixed
  #define fmf FixMulFixSmall
	Inverse[12] = -(fmf(m[12],m[0])) - (fmf(m[13],m[1])) - (fmf(m[14],m[2]))
	Inverse[13] = -(fmf(m[12],m[4])) - (fmf(m[13],m[5])) - (fmf(m[14],m[6]))
	Inverse[14] = -(fmf(m[12],m[8])) - (fmf(m[13],m[9])) - (fmf(m[14],m[10]))    
end sub

sub d3Matrix_Mul_Matrix ( Matrix_1 as number ptr, Matrix_2 as number ptr)  
  static Matrix_R(15) as number = any  
  'The first one suppose to be FixedMulFixed
  #define Mat2xMat1(m2,m1) FixedMulFixed(Matrix_2[m2],Matrix_1[m1])
  #define Ma2xMa1fs(m2,m1) FixMulFixSmall(Matrix_2[m2],Matrix_1[m1])  
  Matrix_R( 0) = (Ma2xMa1fs( 0,0))+(Ma2xMa1fs( 1,4))+(Ma2xMa1fs( 2, 8))+(Mat2xMat1( 3,12))
  Matrix_R( 1) = (Ma2xMa1fs( 0,1))+(Ma2xMa1fs( 1,5))+(Ma2xMa1fs( 2, 9))+(Mat2xMat1( 3,13))
  Matrix_R( 2) = (Ma2xMa1fs( 0,2))+(Ma2xMa1fs( 1,6))+(Ma2xMa1fs( 2,10))+(Mat2xMat1( 3,14))
  Matrix_R( 3) = (Ma2xMa1fs( 0,3))+(Ma2xMa1fs( 1,7))+(Ma2xMa1fs( 2,11))+(Mat2xMat1( 3,15))
  Matrix_R( 4) = (Ma2xMa1fs( 4,0))+(Ma2xMa1fs( 5,4))+(Ma2xMa1fs( 6, 8))+(Mat2xMat1( 7,12))
  Matrix_R( 5) = (Ma2xMa1fs( 4,1))+(Ma2xMa1fs( 5,5))+(Ma2xMa1fs( 6, 9))+(Mat2xMat1( 7,13))
  Matrix_R( 6) = (Ma2xMa1fs( 4,2))+(Ma2xMa1fs( 5,6))+(Ma2xMa1fs( 6,10))+(Mat2xMat1( 7,14))
  Matrix_R( 7) = (Ma2xMa1fs( 4,3))+(Ma2xMa1fs( 5,7))+(Ma2xMa1fs( 6,11))+(Mat2xMat1( 7,15))
  Matrix_R( 8) = (Ma2xMa1fs( 8,0))+(Ma2xMa1fs( 9,4))+(Ma2xMa1fs(10, 8))+(Mat2xMat1(11,12))
  Matrix_R( 9) = (Ma2xMa1fs( 8,1))+(Ma2xMa1fs( 9,5))+(Ma2xMa1fs(10, 9))+(Mat2xMat1(11,13))
  Matrix_R(10) = (Ma2xMa1fs( 8,2))+(Ma2xMa1fs( 9,6))+(Ma2xMa1fs(10,10))+(Mat2xMat1(11,14))
  Matrix_R(11) = (Ma2xMa1fs( 8,3))+(Ma2xMa1fs( 9,7))+(Ma2xMa1fs(10,11))+(Mat2xMat1(11,15))
  Matrix_R(12) = (Mat2xMat1(12,0))+(Mat2xMat1(13,4))+(Mat2xMat1(14, 8))+(Mat2xMat1(15,12))
  Matrix_R(13) = (Mat2xMat1(12,1))+(Mat2xMat1(13,5))+(Mat2xMat1(14, 9))+(Mat2xMat1(15,13))
  Matrix_R(14) = (Mat2xMat1(12,2))+(Mat2xMat1(13,6))+(Mat2xMat1(14,10))+(Mat2xMat1(15,14))
  Matrix_R(15) = (Mat2xMat1(12,3))+(Mat2xMat1(13,7))+(Mat2xMat1(14,11))+(Mat2xMat1(15,15))  
  Memcpy( Matrix_1, @Matrix_R(0), MAT_SIZE )
  
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
    #define fmf FixedMulFixed
    #define fmfs FixMulFixSmall
    
    xx = FixedMulFixed(.nX , LightPos.nX)
    yy = FixedMulFixed(.nY , LightPos.nY)
    zz = FixedMulFixed(.nZ , LightPos.nZ)
    ww = FixedMulFixed(.nW , LightPos.nW)
    dot = xx+yy+zz+ww
    
    M[ 0] = dot-xx
    M[ 1] = fmfs(-LightPos.nY , .nX)
    M[ 2] = fmfs(-LightPos.nZ , .nX)
    M[ 3] = fmfs(-LightPos.nW , .nX)
    
    M[ 4] = fmfs(-LightPos.nX , .nY)
    M[ 5] = dot-yy
    M[ 6] = fmfs(-LightPos.nZ , .nY)
    M[ 7] = fmfs(-LightPos.nW , .nY)
    
    M[ 8] = fmfs(-LightPos.nX , .nZ)
    M[ 9] = fmfs(-LightPos.nY , .nZ)
    M[10] = dot-zz
    M[11] = fmfs(-LightPos.nW , .nZ)
    
    M[12] = fmf(-LightPos.nX , .nW)
    M[13] = fmf(-LightPos.nY , .nW)
    M[14] = fmf(-LightPos.nZ , .nW)
    M[15] = dot-ww
  end with
end sub

sub d3Matrix_Translate(M as number ptr, X as const number, Y as const number, Z as const number )
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
  #define fmfs(aa,bb) FixMulFixSmall(aa,bb)    
  'vOut.nX = M[12] : vOut.nY = M[13] : vOut.nz = M[14]
  'if abs(vinX) <= FixMax then 
  '  Vout.nX += fmfs(vInX,M[0]) : vOut.nY += fmfs(vInX,M[1]) : vOut.nZ += fmfs(vInX,M[2])
  'else 
  '  Vout.nX += fmf(vInX,M[0])  : vOut.nY += fmf(vInX,M[1])  : vOut.nZ += fmf(vInX,M[2])
  'end if
  'if abs(vinY) <= FixMax then
  '  Vout.nX += fmfs(vInY,M[4]) : Vout.nY += fmfs(vInY,M[5]) : Vout.nZ += fmfs(vInY,M[6])
  'else
  '  Vout.nX += fmf(vInY,M[4])  : Vout.nY += fmf(vInY,M[5])  : Vout.nZ += fmf(vInY,M[6])
  'end if
  'if abs(vinZ) <= FixMax then
  '  Vout.nX += fmfs(vInZ,M[8]) : Vout.nY += fmfs(vInZ,M[9]) : Vout.nZ += fmfs(vInZ,M[10])
  'else
  '  Vout.nX += fmf(vInZ,M[ 8]) : Vout.nY += fmf(vInZ,M[ 9]) : Vout.nZ += fmf(vInZ,M[10])
  'end if
  vOut.nX = fmfs(vInX,M[0]) + fmfs(vInY,M[4]) + fmfs(vInZ,M[ 8]) + M[12]
  vOut.nY = fmfs(vInX,M[1]) + fmfs(vInY,M[5]) + fmfs(vInZ,M[ 9]) + M[13]
  vOut.nZ = fmfs(vInX,M[2]) + fmfs(vInY,M[6]) + fmfs(vInZ,M[10]) + M[14]  
end sub

'sub d3Matrix_Mul_Vector4D( M As Single Ptr, byref vIn As Vector4D, byref vOut As Vector4D )
'    'Dim As Vector4D vOut = any    
'    var vinX = vIn.X, vInY = vIn.Y , vInZ = vIn.Z
'    vOut.X = vInX*M[0] + vInY*M[4] + vInZ*M[8]  + M[12]
'    vOut.Y = vInX*M[1] + vInY*M[5] + vInZ*M[9]  + M[13]
'    vOut.Z = vInX*M[2] + vInY*M[6] + vInZ*M[10] + M[14]
'    vOut.W = vIn.W
'    'Return vOut
'End sub

function Vector_Dot (byref v1 as Vector3D, byref v2 as Vector3D) as number 'Shadows?
  #define fmf(aa,bb) FixedMulFixed(aa,bb)  
  return fmf(v1.nX,v2.nX) + fmf(v1.nY,v2.nY) + fmf(v1.nZ,v2.nZ)   
end function

'Function Vector_Dot (Byref v1 As Vector4D, Byref v2 As Vector4D) As Single
'    Return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z) + (v1.w * v2.w)
'End Function

sub Vector_Cross ( byref v1 as Vector3D, byref v2 as Vector3D, byref V as Vector3D)  
  'Dim As Vector3D v = any
  '#define fmf(aa,bb) FixedMulFixed(aa,bb)
  #define fmf(aa,bb) FixMulFixSmall(aa,bb)
  v.nX = (fmf(v1.nY , v2.nZ)) - (fmf(v2.nY , v1.nZ))
  v.nY = (fmf(v1.nZ , v2.nX)) - (fmf(v2.nZ , v1.nX))
  v.nZ = (fmf(v1.nX , v2.nY)) - (fmf(v2.nX , v1.nY))
  'Return v
end sub

'function Magnitude( byref V as Vector3D) as single
'    dim Mag as single = sqr(v.x*v.x + v.y*v.y + v.z*v.z)
'    if Mag = 0 then Mag = 1
'    return Mag
'end function

#ifdef NOT__FB_NDS__
sub Vector_Normalize (byref v as Vector3D)      
  #print "Vector Normalize with DS hardware"
  #define fmf FixedMulFixed
  #define fmfs FixMulFixSmall
  #define WaitFor(xxx) while (xxx): wend
  dim as number vx = fmf(v.nX,v.nX)
  dim as number vy = fmf(v.nY,v.nY)
  dim as number vz = fmf(v.nZ,v.nZ)  
  REG_SQRTCNT = SQRT_64	
	REG_SQRT_PARAM = clngint(vx+vy+vz) shl FixBits
	WaitFor(REG_SQRTCNT and SQRT_BUSY)  
  dim as number nMag = REG_SQRT_RESULT 'sqrtf32(vx+vy+vz)  
  REG_DIVCNT = DIV_64_32
 	REG_DIV_NUMER = (clngint(ToFixedi(1)) shl FixBits)
 	REG_DIV_DENOM_L = nMag
 	WaitFor(REG_DIVCNT and DIV_BUSY)
	nMag = REG_DIV_RESULT_L 'divf32(ToFixedi(1),nMag)
  v.nX = fmfs(v.nX,nMag)
  v.nY = fmfs(v.nY,nMag)
  v.nZ = fmfs(v.nZ,nMag)  
end sub
#else
sub Vector_Normalize (byref v as Vector3D)      
  #define fmf FixedMulFixed
  #define fmfs FixMulFixSmall
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
  v.nX = fmfs(v.nX,nMag)
  v.nY = fmfs(v.nY,nMag)
  v.nZ = fmfs(v.nZ,nMag)

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
      nMag2 = FixedInverse(cint(SqrTab(Temp)))
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
#endif

sub Poly_Normal(pV as Vector3D ptr, byref tNorm as Vector3D)    
  'dim as Vector3D V1 = type(pV[1].nX-(pV->nX),pV[1].nY-(pV->nY),pV[1].nZ-(pV->nZ))
  'dim as Vector3D V2 = type(pV[2].nX-(pV->nX),pV[2].nY-(pV->nY),pV[2].nZ-(pV->nZ))
  'Vector_Cross( V1, V2, tNorm )
  #define fmf FixMulFixSmall
  dim as number v1x=pV[1].nX-(pV->nX),v1y=pV[1].nY-(pV->nY),v1z=pV[1].nZ-(pV->nZ)
  dim as number v2x=pV[2].nX-(pV->nX),v2y=pV[2].nY-(pV->nY),v2z=pV[2].nZ-(pV->nZ)
  tNorm.nX = (fmf(v1Y , v2Z)) - (fmf(v2Y , v1Z))
  tNorm.nY = (fmf(v1Z , v2X)) - (fmf(v2Z , v1X))
  tNorm.nZ = (fmf(v1X , v2Y)) - (fmf(v2X , v1Y))  
  Vector_Normalize(tNorm)
end sub

function Distance( byref vP1 as Vector3D, byref vP2 as Vector3D) as number
  dim as float vx = ToFloat((vP2.nX - vP1.nX))
  dim as float vy = ToFloat((vP2.nY - vP1.nY))
  dim as float vz = ToFloat((vP2.nZ - vP1.nZ))    
  return ToFixed(sqr(vx*vx+vy*vy+vz*vz))  
end function

'Function Distance( Byref vP1 As Vector4D, Byref vP2 As Vector3D) As Single
'    Distance = Sqr((vP2.x - vP1.x)^2 + (vP2.y - vP1.y)^2 + (vP2.z - vP1.z)^2)
'End Function

'Function Angle_Between_Vectors( Byref Vector1 As Vector3D, Byref Vector2 As Vector3D ) As Single
'    Dim tDot As Single, VecsMag As Single, Angle As Single    
'    tDot = Vector_Dot(Vector1, Vector2)
'    VecsMag = Magnitude(Vector1) * Magnitude(Vector2)
'    Angle = Acos(tDot/VecsMag)
'    Angle_Between_Vectors = Angle
'End Function

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

'Function Intersected_Plane(pV As Vector3D ptr,pvLine As Vector3D ptr, Byref vNormal As Vector3D, OriginDist As Single ptr) As Integer
'    Dim Dist1 As Single, Dist2 As Single   
'    
'    Poly_Normal(pV, vNormal)
'    *OriginDist = Plane_Distance(VNormal, pV[0])
'    
'    Dist1 = ((vNormal.x * pvLine[0].x) + (vNormal.y * pvLine[0].y) + (vNormal.z * pvLine[0].z)) + *OriginDist   
'    Dist2 = ((vNormal.x * pvLine[1].x) + (vNormal.y * pvLine[1].y) + (vNormal.z * pvLine[1].z)) + *OriginDist
'    
'    If Dist1*Dist2>=0 Then 
'        Intersected_Plane = False
'    Elseif Dist1*Dist2<0 Then
'        Intersected_Plane = True
'    End If   
'    
'End Function

'Sub Intersection_point( Byref vNormal As Vector3D, pvLine As Vector3D ptr, tDistance As const Single, Byref vReturn As Vector3D)
'    Dim vLineDir As Vector3D
'    Dim Numerator As Double, Denominator As Double, Dist As Double
'    
'    vLineDir.X =  pVLine[1].X - pVLine[2].X
'    vLineDir.Y = pVLine[1].Y - pVLine[2].Y
'    vLineDir.Z =  pVLine[1].Z - pVLine[2].Z
'    Vector_Normalize VLineDir
'    
'    Numerator = -((vNormal.X*pVLine[0].X) + (vNormal.Y*pvLine[0].Y) + ((vNormal.Z*pvLine[0].Z) + tDistance))
'    Denominator = Vector_Dot(vNormal, vLineDir)
'    
'    If Denominator = 0 Then 
'        vReturn.X = pVLine[0].X
'        vReturn.Y = pVLine[0].Y
'        vReturn.Z = pVLine[0].Z    
'    Else
'        Dist = Numerator / Denominator
'        vReturn.x = pvLine[0].x + (vLineDir.x * Dist)
'        vReturn.y = pvLine[0].y + (vLineDir.y * Dist)
'        vReturn.z = pvLine[0].z + (vLineDir.z * Dist)
'    End If
'End Sub

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

'Function Is_Polygon_Intersected(pV As Vector3D ptr, pvLine As Vector3D ptr, Byref New_Intersection As Vector3D ) As Integer
'    Dim vNormal As Vector3D, OriginDistance As Single    
'    If Intersected_Plane(pV, pVLine, vNormal, @OriginDistance) Then 
'        Intersection_Point(vNormal, pvLine, OriginDistance, New_Intersection)
'        If Is_Inside_Polygon( New_Intersection, pV ) Then
'            Return True
'        End If
'    End If
'End Function

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
#endif

