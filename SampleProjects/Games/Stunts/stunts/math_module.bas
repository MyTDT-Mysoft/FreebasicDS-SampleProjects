'3d math functions...

'vec3/polygon functions

function vec3_PlaneDistance( tNormal as vec3 ptr, tPoint as vec3 ptr ) as number  
    return -((tNormal->x * tPoint->x) + (tNormal->y * tPoint->y) + (tNormal->z * tPoint->z))
end function


function vec3_LineIntersectedPlane( vPoly as vec3 ptr, vLine as vec3 ptr, vNormal as vec3 ptr, byref OriginDist as number ) as integer

    dim dist1 as number, dist2 as number
    OriginDist = vec3_planedistance( vNormal, @vPoly[0] )
    
    dist1 = ((vNormal->x * vLine[0].x) + (vNormal->y * vLine[0].y) + (vNormal->z * vLine[0].z)) + OriginDist   
    dist2 = ((vNormal->x * vLine[1].x) + (vNormal->y * vLine[1].y) + (vNormal->z * vLine[1].z)) + OriginDist
    
    if Dist1*Dist2>=0 then 
        return 0
    elseif Dist1*Dist2<0 then
        return -1
    end if   
    
end function

function vec3_AngleBetween( v1 as vec3 ptr, v2 as vec3 ptr ) as number

    dim tDot as number, VecsMag as number, Angle as number
    
    tDot = vec3_Dot( v1, v2 )
    VecsMag = vec3_Magnitude( v1 ) * vec3_Magnitude( v2 )
    Angle = acos(tDot/VecsMag)
    return Angle

end function


sub vec3_IntersectionPoint( vNormal as vec3 ptr, vLine as vec3 ptr, byref tDistance as number, vReturn as vec3 ptr )

    dim vLineDir as vec3
    dim numerator as number, denominator as number, dist as number
    
    vLineDir.X =  vLine[1].x - vLine[0].x
    vLineDir.Y =  vLine[1].y - vLine[0].y
    vLineDir.Z =  vLine[1].z - vLine[0].z
    vec3_Normalize( @vLineDir )
    
    numerator = -((vNormal->x*vLine[0].X) + (vNormal->y*vLine[0].Y) + ((vNormal->z*vLine[0].Z) + tDistance))
    denominator = vec3_Dot( vNormal, @vLineDir )
    
    if denominator = 0 then 
        vReturn->x = vLine[0].x
        vReturn->y = vLine[0].y
        vReturn->z = vLine[0].z    
    else
        dist = numerator / denominator
        vReturn->x = vLine[0].x + (vLineDir.x * dist)
        vReturn->y = vLine[0].y + (vLineDir.y * dist)
        vReturn->z = vLine[0].z + (vLineDir.z * dist)
    end if
    
end sub


function vec3_InsidePolygon( vIntersection as vec3 ptr, vPoly as vec3 ptr, max_vert as integer ) as integer
    
    dim angle as number
    dim vA as vec3, vB as vec3
    dim i as integer, iAnd1 as integer
    
    for i = 0 to max_vert-1

       iAnd1 = (i+1) mod max_vert
       vA.x = vPoly[i].x - vIntersection->x
       vA.y = vPoly[i].y - vIntersection->y
       vA.z = vPoly[i].z - vIntersection->z
       
       vB.x = vPoly[iAnd1].x - vIntersection->x
       vB.y = vPoly[iAnd1].y - vIntersection->y
       vB.z = vPoly[iAnd1].z - vIntersection->z
    
       angle += vec3_AngleBetween( @vA, @vB )

    next
    
    if angle>=fmatch then 
       return-1
    end if
   
end function


function vec3_LineIntersectedPolygon( vPoly as vec3 ptr, max_vert as integer, vNormal as vec3 ptr, vLine as vec3 ptr, vIntersection as vec3 ptr ) as integer

    dim OriginDistance as number
    
    if vec3_LineIntersectedPlane( vPoly, vLine, vNormal, OriginDistance) then
    	
        vec3_intersectionpoint( vNormal, vLine, OriginDistance, vIntersection )
        
        if vec3_InsidePolygon( vIntersection, vPoly, max_vert ) then
            return -1
        end if
        
    end if

end function

function vec3_distance( p1 as vec3 ptr, p2 as vec3 ptr ) as number

	dim as number x = (p2->x - p1->x)
	dim as number y = (p2->y - p1->y)
	dim as number z = (p2->z - p1->z)

	return sqr( x*x + y*y + z*z )

end function

function vec3_dot( v1 as vec3 ptr, v2 as vec3 ptr ) as number

	return ( v1->x*v2->x + v1->y*v2->y + v1->z*v2->z )

end function


sub vec3_cross ( vr as vec3 ptr, v1 as vec3 ptr, v2 as vec3 ptr )
	  
    vr->x = ((v1->y * v2->z) - (v1->z * v2->y))
    vr->y = ((v1->z * v2->x) - (v1->x * v2->z))
    vr->z = ((v1->x * v2->y) - (v1->y * v2->x))

end sub

function vec3_magnitude( v as vec3 ptr ) as number

	dim as number mag  = sqr( v->x*v->x + v->y*v->y + v->z*v->z )
	if mag = 0 then mag = 1
	return mag

end function


sub vec3_normalize ( v as vec3 ptr )

	dim as number mag = vec3_magnitude(v)

	v->x/=Mag
	v->y/=Mag
	v->z/=Mag

end sub

sub vec3_polynormal( vNormal as vec3 ptr, vPoly as vec3 ptr )

	dim as vec3 v1 = any, v2 = any

	v1.x = vPoly[1].x - vPoly[0].x
	v1.y = vPoly[1].y - vPoly[0].y
	v1.z = vPoly[1].z - vPoly[0].z

	v2.x = vPoly[2].x - vPoly[0].x
	v2.y = vPoly[2].y - vPoly[0].y
	v2.z = vPoly[2].z - vPoly[0].z

	vec3_cross( vNormal, @v1, @v2 )
	vec3_normalize ( vNormal )

end sub


'matrix functions__________________________________________________________
sub mat44_loadidentity( mat as number ptr )

	'right vector
	mat[0 ]  = 1
	mat[1 ]  = 0
	mat[2 ]  = 0
	mat[3 ]  = 0

	'up vector
	mat[4 ]  = 0
	mat[5 ]  = 1
	mat[6 ]  = 0
	mat[7 ]  = 0

	'forward vector
	mat[8 ]  = 0
	mat[9 ]  = 0
	mat[10]  = 1
	mat[11]  = 0

	'position vector
	mat[12]  = 0
	mat[13]  = 0
	mat[14]  = 0
	mat[15]  = 1

end sub

sub mat44_mul_mat44( result as number ptr, mat as number ptr )

	dim as number tmp(15)
	memcpy( @tmp(0), @result[0], 16 * sizeof(number) )

	result[0]  = (mat[0]  * tmp(0))+(mat[1]  * tmp(4))+(mat[2]  * tmp(8)) +(mat[3]  * tmp(12))
	result[1]  = (mat[0]  * tmp(1))+(mat[1]  * tmp(5))+(mat[2]  * tmp(9)) +(mat[3]  * tmp(13))
	result[2]  = (mat[0]  * tmp(2))+(mat[1]  * tmp(6))+(mat[2]  * tmp(10))+(mat[3]  * tmp(14))
	result[3]  = (mat[0]  * tmp(3))+(mat[1]  * tmp(7))+(mat[2]  * tmp(11))+(mat[3]  * tmp(15))
	result[4]  = (mat[4]  * tmp(0))+(mat[5]  * tmp(4))+(mat[6]  * tmp(8)) +(mat[7]  * tmp(12))
	result[5]  = (mat[4]  * tmp(1))+(mat[5]  * tmp(5))+(mat[6]  * tmp(9)) +(mat[7]  * tmp(13))
	result[6]  = (mat[4]  * tmp(2))+(mat[5]  * tmp(6))+(mat[6]  * tmp(10))+(mat[7]  * tmp(14))
	result[7]  = (mat[4]  * tmp(3))+(mat[5]  * tmp(7))+(mat[6]  * tmp(11))+(mat[7]  * tmp(15))
	result[8]  = (mat[8]  * tmp(0))+(mat[9]  * tmp(4))+(mat[10] * tmp(8)) +(mat[11] * tmp(12))
	result[9]  = (mat[8]  * tmp(1))+(mat[9]  * tmp(5))+(mat[10] * tmp(9)) +(mat[11] * tmp(13))
	result[10] = (mat[8]  * tmp(2))+(mat[9]  * tmp(6))+(mat[10] * tmp(10))+(mat[11] * tmp(14))
	result[11] = (mat[8]  * tmp(3))+(mat[9]  * tmp(7))+(mat[10] * tmp(11))+(mat[11] * tmp(15))
	result[12] = (mat[12] * tmp(0))+(mat[13] * tmp(4))+(mat[14] * tmp(8)) +(mat[15] * tmp(12))
	result[13] = (mat[12] * tmp(1))+(mat[13] * tmp(5))+(mat[14] * tmp(9)) +(mat[15] * tmp(13))
	result[14] = (mat[12] * tmp(2))+(mat[13] * tmp(6))+(mat[14] * tmp(10))+(mat[15] * tmp(14))
	result[15] = (mat[12] * tmp(3))+(mat[13] * tmp(7))+(mat[14] * tmp(11))+(mat[15] * tmp(15))

end sub

sub vec3_mul_mat44( v as vec3 ptr, mat as number ptr )

	dim as vec3 tv = *v

	v->x = tv.x*mat[0] + tv.y*mat[4] + tv.z*mat[8]  + mat[12]
	v->y = tv.x*mat[1] + tv.y*mat[5] + tv.z*mat[9]  + mat[13]
	v->z = tv.x*mat[2] + tv.y*mat[6] + tv.z*mat[10] + mat[14]

end sub

sub mat44_pointat( mat as number ptr, v1 as vec3 ptr, v2 as vec3 ptr )

	dim as vec3 d = type(v2->x-v1->x, v2->y-v1->y, v2->z-v1->z)
	vec3_normalize( @d )

	dim as vec3 u = type(0,1,0)

	if abs( d.y ) >.9999 then
		u.x = 0
		u.y = 0
		u.z = 1
	end if

	dim as vec3 r
	vec3_cross( @r, @d, @u )
	r.x = -r.x
	r.y = -r.y
	r.z = -r.z
	vec3_normalize( @r )

	vec3_cross( @u, @r, @d )
	u.x=-u.x
	u.y=-u.y
	u.z=-u.z
	vec3_normalize( @u )

	mat[0]  = r.x
	mat[1]  = r.y
	mat[2]  = r.z
	mat[3]  = 0.0

	mat[4]  = u.x
	mat[5]  = u.y
	mat[6]  = u.z
	mat[7]  = 0.0

	mat[8]  = d.x
	mat[9]  = d.y
	mat[10] = d.z
	mat[11] = 0.0

	mat[12]  = v1->x
	mat[13]  = v1->y
	mat[14]  = v1->z
	mat[15]  = 1.0

end sub

sub mat44_rotx( mat as number ptr, Angle as number )

	dim as number tCos = cos(Angle)
	dim as number tSin = sin(Angle)

	mat[8]  = mat[8]*tCOS  + mat[4]*tSin
	mat[9]  = mat[9]*tCOS  + mat[5]*tSin
	mat[10] = mat[10]*tCOS + mat[6]*tSin

	vec3_normalize( cast(vec3 ptr,  @mat[8]) )
	vec3_cross( cast(vec3 ptr, @mat[4]), cast( vec3 ptr, @mat[8]), cast( vec3 ptr, @mat[0]) )

	mat[4] = -mat[4]
	mat[5] = -mat[5]
	mat[6] = -mat[6]

end sub

sub mat44_roty( mat as number ptr, Angle as number )

	dim as number tCos = cos(Angle)
	dim as number tSin = sin(Angle)

	mat[8]  = mat[8]*tCOS  - mat[0]*tSin
	mat[9]  = mat[9]*tCOS  - mat[1]*tSin
	mat[10] = mat[10]*tCOS - mat[2]*tSin

	vec3_normalize( cast( vec3 ptr, @mat[8]) )
	vec3_cross( cast( vec3 ptr, @mat[0]), cast( vec3 ptr, @mat[8]), cast( vec3 ptr, @mat[4]) )

end sub

sub mat44_rotz( mat as number ptr, Angle as number )

	dim as number tCos = cos(Angle)
	dim as number tSin = sin(Angle)

	mat[0] = mat[0]*tCOS+mat[4]*tSin
	mat[1] = mat[1]*tCOS+mat[5]*tSin
	mat[2] = mat[2]*tCOS+mat[6]*tSin

	vec3_normalize( cast( vec3 ptr, @mat[0]) )
	vec3_cross( cast( vec3 ptr, @mat[4]), cast( vec3 ptr, @mat[8]), cast( vec3 ptr, @mat[0]) )

	mat[4] = -mat[4]
	mat[5] = -mat[5]
	mat[6] = -mat[6]

end sub
