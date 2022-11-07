#include once "global_structures.bi"
const Sphere_Intersects = 1, Sphere_Front = 2, Sphere_Behind = 3
const MAT_SIZE = 16 * sizeof(Number)

declare sub d3Matrix_Load_Identity( Matrix as Number ptr )
declare sub d3Matrix_Copy( Dest as Number ptr,Src as Number ptr )
declare sub d3Matrix_Mul_Matrix(Matrix_1 as Number ptr, Matrix_2 as Number ptr)
declare sub d3Matrix_Translate( Matrix as Number ptr, X as const Number, Y as const Number, Z as const Number )
declare sub d3Matrix_Rotate( Matrix as Number ptr,AngleX as const integer, AngleY as const integer,AngleZ as const integer )
declare sub d3Matrix_LookAt( Matrix as Number ptr,byref v1 as vector3d,byref v2 as vector3d,byref up as vector3d )
declare sub d3Matrix_Plane_Projection( Matrix as Number ptr, byref LightPos as Vector4D, byref Plane as Vector4D )
declare sub d3Matrix_Scale( Matrix as Number ptr, Scalar as const Number )
declare sub d3Matrix_Inverse(Inverse as Number ptr , m as Number ptr )
declare sub d3Matrix_Mul_Vector3D ( M as Number ptr, byref vIn as Vector3D, byref vOut as Vector3D)
declare sub d3Matrix_Mul_Vector4D ( M as Number ptr, byref vIn as Vector4D, byref vOut as Vector4D)

declare sub      Vector_Cross ( byref v1 as Vector3D, byref v2 as Vector3D, v as Vector3D)
declare function Vector_Dot overload( byref v1 as Vector3D, byref v2 as Vector3D) as Number
declare function Vector_Dot (byref v1 as Vector4D, byref v2 as Vector4D) as Number
declare sub      Vector_Normalize (v as Vector3D)
declare function Magnitude( byref V as Vector3D) as Number
declare sub      Poly_Normal(pV as Vector3D ptr, byref tNorm as Vector3D)
declare function Plane_Distance( byref tNormal as Vector3D, byref tPoint as Vector3D) as Number
declare function Angle_Between_Vectors( byref Vector1 as Vector3D, byref Vector2 as Vector3D) as Number
declare function Cotangent( angle as const Number ) as Number
declare function Distance overload( byref vP1 as Vector3D, byref vP2 as Vector3D) as Number
declare function Distance overload( byref vP1 as Vector4D, byref vP2 as Vector3D) as Number
declare function SameSide( byref vp1 as Vector3D, byref vp2 as Vector3D, byref a as Vector3D, byref b as Vector3D ) as integer
declare function Classify_Sphere(byref vCenter as Vector3D, byref VNormal as Vector3D, byref vPoint as Vector3D, Radius as const Number, Dist as Number ptr ) as integer
declare function Edge_Sphere_Collision( byref vCenter as Vector3D,pV as Vector3D ptr, Radius as const Number ) as integer
