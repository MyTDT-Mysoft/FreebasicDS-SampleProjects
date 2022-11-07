'3d math module header

const as number pi=3.1415926, pi2 = pi*2, pi_180 = 180*pi, inv_pi_180 = 180/pi, fmatch = pi2*.99

type vec3
	x as number
	y as number
	z as number
end type

declare function vec3_PlaneDistance( tNormal as vec3 ptr, tPoint as vec3 ptr ) as number  
declare function vec3_LineIntersectedPlane( vPoly as vec3 ptr, vLine as vec3 ptr, vNormal as vec3 ptr, byref OriginDist as number) as integer
declare function vec3_AngleBetween( v1 as vec3 ptr, v2 as vec3 ptr) as number
declare sub vec3_IntersectionPoint( vNormal as vec3 ptr, vLine as vec3 ptr, byref tDistance as number, vReturn as vec3 ptr )
declare function vec3_InsidePolygon( vIntersection as vec3 ptr, vPoly as vec3 ptr, max_vert as integer ) as integer
declare function vec3_LineIntersectedPolygon( vPoly as vec3 ptr, max_vert as integer, vNormal as vec3 ptr, vLine as vec3 ptr, vIntersection as vec3 ptr ) as integer
declare function vec3_distance( p1 as vec3 ptr, p2 as vec3 ptr ) as number
declare function vec3_dot( v1 as vec3 ptr, v2 as vec3 ptr ) as number
declare sub vec3_cross ( vr as vec3 ptr, v1 as vec3 ptr, v2 as vec3 ptr )
declare function vec3_magnitude( v as vec3 ptr ) as number
declare sub vec3_normalize ( v as vec3 ptr )
declare sub vec3_polynormal( vNormal as vec3 ptr, vPoly as vec3 ptr )
declare sub mat44_loadidentity( mat as number ptr )
declare sub mat44_mul_mat44( result as number ptr, mat as number ptr )
declare sub vec3_mul_mat44( v as vec3 ptr, mat as number ptr )
declare sub mat44_pointat( mat as number ptr, v1 as vec3 ptr, v2 as vec3 ptr )
declare sub mat44_rotx( mat as number ptr, Angle as number )
declare sub mat44_roty( mat as number ptr, Angle as number )
declare sub mat44_rotz( mat as number ptr, Angle as number )
