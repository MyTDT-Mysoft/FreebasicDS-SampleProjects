#include once "3dmath.bi"

type RGBInt
  as uinteger iR,iG,iB
end type

type sortstuff
  iMidpoint as integer  
  Vec1      as vector2dint
  Vec2      as vector2dint
  Vec3      as vector2dint
  iCol      as integer
end type

type Surface3D
  iStart_ID         as uinteger
  iEnd_ID           as uinteger
  iShade_Mode       as uinteger
  iDouble_Sided     as integer
  iTexture_Id       as integer
  iIs_Multi_Texture as integer
  'piMulti_Texture  as integer Ptr
  Rgbalpha         as Rgbalpha
  Ambient          as Rgbalpha
  Diffuse          as Rgbalpha
  Specular         as Rgbalpha
  Emission         as Rgbalpha
  Shininess        as number
  'iList           as gluint
  'Shader          as GlHandleARB
end type

type Triangle3D
  iPointID1    as uinteger
  iPointID2    as uinteger
  iPointID3    as uinteger
  'TexCoord1   as UV2D
  'TexCoord2   as UV2D
  'TexCoord3   as UV3D    
  'iNeigh1      as uinteger
  'iNeigh2      as uinteger
  'iNeigh3      as uinteger
  'iCon1        as integer
  'iCon2        as integer
  'iCon3        as integer
  iVisible     as integer
  col          as RGBInt
  normal       as Vector3D
  tnormal      as Vector3D
  Plane        as Vector4D
  'iGroup      as Integer
  'Posit       as Vector3D
  midpoint     as Vector3D
  'Tangent1    as Vector3D
  'Tangent2    as Vector3D
  'Tangent3    as Vector3D
  'BiTangent1  as Vector3D
  'BiTangent2  as Vector3D
  'BiTangent3  as Vector3D
  'midpoint    as Vector3d
  'iIndex      as integer
end type

type Model3D
  iMax_vertices  as uinteger
  iMax_triangles as uinteger
  'iMax_surfaces as uinteger
  vert16         as Vector3D16  ptr  'Vertices (-1.0 to 1.0!)
  tvertices      as Vector3D    ptr  'Transformed vertices...
  pvertices      as Vector3DInt ptr  'Transformed and projected vertices
  vnormals       as Vector3D    ptr
  tnormals       as Vector3D    ptr
  triangles      as Triangle3D  ptr
  'surfaces      as surface3D   ptr
end type

declare sub Load_Obj( Filename as const string, byref Model as Model3D ptr,  texture_offset as integer )
declare sub Material_Sort( byref Model as Model3D ptr )

declare sub Render_Model(  Model as Model3D ptr, Texture() as uinteger )
declare sub Render_Model_Alt(  Model as Model3D ptr, Texture() as uinteger, byref Light_Position as Vector4D, byref Translation as Vector3D )
declare sub Render_Model_Shadow(  Model as Model3D ptr )
declare sub LoadMesh( byref Model as Model3D ptr, Filename as string,  Texture_Offset as integer, Texture() as uinteger )
declare sub GetSurfaces(  FileID as uinteger, Store_Name() as string )
declare sub unloadmesh( byref Model as Model3D ptr)
declare sub Calc_Normals( byref Model as Model3D ptr )
declare sub Calc_Planes( byref Model as Model3D ptr )
declare sub Set_Poly_Neighbors( byref Model as Model3D ptr )
declare sub Begin_Shadow_Pass()
declare sub End_Shadow_Pass()

declare sub Render_Shadow_Volume( byref Model as Model3D ptr, byref lp as Vector4D )
declare sub Save_Model_To_Binary( byref Model as Model3D ptr, byref File_Name as string )
declare sub Load_Model_From_Binary( byref Model as Model3D ptr, byref File_Name as string )

declare sub Calc_Shadow_Volume( byref Model as Model3D ptr, byref lp as Vector4D )
declare sub Render_Quick_Volume( byref Model as Model3D ptr )

declare sub Do_Shadow_Pass_zFail( byref Model as Model3D ptr,  lp as Vector4D )
declare sub Calc_Shadow_Volume_zFail( byref Model as Model3D ptr, byref lp as Vector4D )
declare sub Render_Volume_zFail( byref Model as Model3D ptr )
declare sub Build_Stencil_Cube( byref List as uinteger )
