#include "crt.bi"

#define UseFixedPoint
'#define AlphaTriangles
'#define UseInlineAsm

#if __FB_BACKEND__ = "gcc"
#print "Compiling optimized for -gen GCC"
#endif
#ifdef UseFixedPoint
#print "Compiling FixedPoint version..."
#else
#print "Compiling Float Point version"
#endif

#ifndef float
type float as single
#endif

#ifdef UseFixedPoint
  #define Number integer
  #define NumberSmall short
  #define NumberBig LongInt
  const FixBits = 12,FixError = 0
  const FixMul = (1 shl FixBits)  
  const FixMax = (1 shl (16-FixBits))*FixMul
  #define ToFixedi(IntNum) cint(((IntNum) shl FixBits))
  #define ToFixed(FloatNum) cint(((FloatNum)*(FixMul-FixError)))
  #define ToFloat(FixedNum) (cint(FixedNum)*(1/(FixMul-FixError)))
  #define ToCint(FixedNum) ((cint(FIxedNum)+((FixMul shr 1))) shr FixBits)
  #define ToFint(FixedNum) ((cint(FixedNum)) shr FixBits)
  #define FixedMulFixed(FixA,FixB) cint(((clngint(FixA)*(cint(FixB))) shr FixBits))
  #define FixedMulFixed2(FixA2,FixB2) cint(((clngint(FixA2)*(cint(FixB2))) shr FixBits))
  '#define FixMulFixSmall(FixA,FixB) cint((((cint(FixA))*(cint(FixB))) shr FixBits))
  #define FixMulFixSmall(FixA,FixB) cint(((clngint(FixA)*(cint(FixB))) shr FixBits))
  #define FixedDivFixed(FixA,FixB) cint((((clngint(FixA) shl FixBits)\(FixB))))
  #define FixedInverse(FixedNum) ToFixed((1/ToFloat(FixedNum)))
  '((1/((cint(FixedNum)*(1/(FixMul-FixError)))))*(FixMul-FixError))
  #define FloatClipFix(FloatNum) (csng(cint(FloatNum*10000)*(1/10000)))
#else
  #define Number single
  #define NumberSmall single
  #define NumberBig double
  #define ToFixedi(IntNum) (IntNum)
  #define ToFixed(FloatNum) (FloatNum)
  #define ToFloat(FixedNum) (FixedNum)
  #if __FB_BACKEND__ = "gcc"
  #define ToCint(FixedNum) ((FixedNum)+.5)
  #else
  #define ToCint(FixedNum) cint(FixedNum)
  #endif
  #define ToFint(FixedNum) (FixedNum)
  #define FixedMulFixed(FixA,FixB) ((FixA)*(FixB))
  #define FixedMulFixed2(FixA2,FixB2) ((FixA2)*(FixB2))
  #define FixMulFixSmall(FixA,FixB) ((FixA)*(FixB))
  #define FixedInverse(FixedNum) (1/FixedNum)
  #define FixedDivFixed(FixA,FixB) ((FixA)/(FixB))
#endif

'const as Number Pi = ToFixed(3.1415926535897932)
'const as Number Pi2 = Pi*2
'const as Number pid180 = Pi/180, Match_Factor = FixedMulFixed(Pi2,ToFixed(0.9999))
const as single sPi = 3.1415926535897932
const as single sPi2 = sPi*2
const as single sPid180 = sPi/180, sMatch_Factor = sPi2*(0.9999)
'const Shadow_Infinity = ToFixed(500)
'const sShadow_Infinity = 500

#ifdef __FB_NDS__
#define UpIsPressed() (multikey(FB.SC_UP) or multikey(fb.SC_BUTTONUP))
#define DownIsPressed() (multikey(FB.SC_DOWN) or multikey(fb.SC_BUTTONDOWN))
#define LeftIsPressed() (multikey(FB.SC_LEFT) or multikey(fb.SC_BUTTONLEFT))
#define RightIsPressed() (multikey(FB.SC_RIGHT) or multikey(fb.SC_BUTTONRIGHT))
#define EnterIsPressed() (multikey(FB.SC_ENTER) or multikey(fb.SC_BUTTONA))
#define EscapeIsPressed() (multikey(FB.SC_ESCAPE) or multikey(fb.SC_BUTTONSTART))
#define wIsPressed() (multikey(FB.SC_W) or multikey(fb.SC_BUTTONSELECT))
#define sIsPressed() (multikey(FB.SC_S) or multikey(fb.SC_BUTTONX))
#define vIsPressed() (multikey(FB.SC_V) or multikey(fb.SC_BUTTONY))
#define oIsPressed() (multikey(FB.SC_O) or multikey(fb.SC_BUTTONL))
#define iIsPressed() (multikey(FB.SC_I) or multikey(fb.SC_BUTTONR))

#else
#define UpIsPressed() (multikey(FB.SC_UP))
#define DownIsPressed() (multikey(FB.SC_DOWN))
#define LeftIsPressed() (multikey(FB.SC_LEFT))
#define RightIsPressed() (multikey(FB.SC_RIGHT))
#define EnterIsPressed() (multikey(FB.SC_ENTER))
#define EscapeIsPressed() (multikey(FB.SC_ESCAPE))
#define wIsPressed() (multikey(FB.SC_W))
#define sIsPressed() (multikey(FB.SC_S))
#define vIsPressed() (multikey(FB.SC_V))
#define oIsPressed() (multikey(FB.SC_O))
#define iIsPressed() (multikey(FB.SC_I))

#endif
#ifndef True
const False = 0, true = not False
#endif

#ifdef __FB_NDS__
#define sTimer() (Timer)
#else
dim shared as double StartTimer
StartTimer = timer
#define sTimer() (Timer-StartTimer)
#endif

'#define AlphaTriangles
#define InlineFunctions

type Vector2D
  as Number nX,nY
end type

type Vector2DInt
  as integer iX,iY
end type

type Vector4D
  as number nX,nY,nZ,nW
end type

type Vector3D
  as number nX,nY,nZ    
  'declare operator cast() as Vector4d
end type

type Vector3Df
  as float fX,fY,fZ    
  'declare operator cast() as Vector4d
end type

type Vector3D16
  as NumberSmall nX,nY,nZ    
  'declare operator cast() as Vector4d
end type

type Vector3DInt
  as integer iX,iY,iZ
end type

type Plane3D
  as number  nA,nB,nC,nD
end type

type Rgbalpha
  as number nR,nG,nB,nA
end type

type UV2D
  as number nU,nV
end type

type Light_Struct
  Ambient             as RGBAlpha
  Diffuse             as RGBAlpha
  Specular            as RGBAlpha
  Position            as Vector4D
  Direction           as Vector3D
  pnProjection_Matrix as number ptr
  pnView_Matrix       as number ptr
end type

type vMatrix_Struct
  R as Vector3D
  U as Vector3D
  D as Vector3D
  P as Vector3D
end type


'Type Joint_Struct
'    nJoint          As NewtonJoint Ptr
'    Body            As NewtonBody ptr
'    Pin             As Vector3D
'    Pivot           As Vector3D
'    Omega           As Vector3D
'    Collision_State As Integer
'    Destroyed       As Integer
'    Min_Friction    As dFloat
'    Max_Friction    As dFloat
'    Min_Angle       As dFLoat
'    Max_Angle       As dFLoat
'    ID              As uInteger
'End Type


'Type Effect_Struct
'    Body1                   As NewtonBody Ptr
'    Body2                   As NewtonBody Ptr
'    contactMaxNormalSpeed   As dFloat
'    contactMaxTangentSpeed  As dFloat
'    Velocity                As Vector3D
'    Velocity_Mag            As dFloat
'    Sound                   As uInteger
'    Position                As Vector3D
'    Add_Score               As Integer
'    Behavior                As Integer
'End Type

type Object_Struct
  'Body            As NewtonBody Ptr
  iMaterial       as integer
  nMass           as number
  'Collision       As NewtonCollision Ptr
  iMax_Joints     as integer
  'Joint           As Joint_Struct Ptr
  'dList           As Gluint Ptr
  'Shadow_dList    As Gluint Ptr
  iMax_models     as uinteger
  'Model_ID        As Uinteger Ptr
  'Matrix          As dFLoat Ptr
  'Sub_Matrix      As dFLoat Ptr Ptr
  Vec             as vMatrix_Struct
  External_Force  as Vector3D
  External_Omega  as Vector3D
  iUse_Modifier   as integer
  iUse_Gravity    as integer
  iID             as integer' Used for rigid body or collision tree
  iIndex          as integer' Used to store this object's index number.
  Designation     as string * 32
  iAdd_Score      as integer
  iMax_sounds     as uinteger
  piSound         as uinteger ptr
  iOn_Ground      as integer
  iGround_Flag    as integer
  iSound_Flag     as uinteger
  iFollowing      as integer
  'Effect          As Effect_Struct
end type

'Type Character_Struct
'    animation_inc       as integer
'    animation_ind       as uinteger
'    max_lists           as uinteger
'    dList               As Gluint Ptr
'    Model_ID            As Uinteger
'    Matrix              As Single Ptr
'    Vec                 As vMatrix_Struct
'End Type

'Type Character_Struct
'    'Body            As NewtonBody Ptr
'    'Sel_Body        As NewtonBody Ptr
'    Sel_Body_ID     As Integer
'    Mass            As Single
'    'Collision       As NewtonCollision Ptr
'    Matrix          As Single Ptr
'    bMatrix         As Single Ptr
'    Vec             As vMatrix_Struct
'    Force           As Vector3D
'    Omega           As Vector3D
'    DVec            As Vector3D
'    RVec            As Vector3D
'    UVec            As Vector3D
'    Angle           As Vector3D
'    Score           As Integer
'    Launch_Power    As Single
'    On_Ground       As Integer
'    Jump            As Integer
'End Type

type Ray_Struct
  nParam              as number
  Intersection_Point  as Vector3D
  Vec                 as vMatrix_Struct
  Normal              as Vector3D
  'Newton_ID           As NewtonBody Ptr
  iObject_ID          as integer
  iCollision_ID       as integer
  Designation         as string * 32
end type

type Display_Struct
  iW as uinteger
  iH as uinteger
  iW2 as uinteger
  iH2 as uinteger
  iR_BITS as uinteger
  iG_BITS as uinteger
  iB_BITS as uinteger
  iA_BITS as uinteger
  iD_BITS as uinteger
  iS_BITS as uinteger
  iMODE as uinteger
  GlVer as zstring ptr
  as number nFOV, nAspect, nZNear, nZFar
end type

'Common Shared glGenFramebuffersEXT             As PFNglGenFramebuffersEXTPROC
'Common Shared glDeleteFramebuffersEXT          As PFNglDeleteFramebuffersEXTPROC
'Common Shared glBindFramebufferEXT             As PFNglBindFramebufferEXTPROC
'Common Shared glFramebufferTexture2DEXT        As PFNglFramebufferTexture2DEXTPROC
'Common Shared glFramebufferRenderbufferEXT     As PFNglFramebufferRenderbufferEXTPROC
'Common Shared glGenRenderbuffersEXT            As PFNglGenRenderbuffersEXTPROC
'Common Shared glBindRenderbufferEXT            As PFNglBindRenderbufferEXTPROC
'Common Shared glRenderbufferStorageEXT         As PFNglRenderbufferStorageEXTPROC
'
'
'Common Shared glMultiTexCoord2fARB              As PFNGLMULTITEXCOORD2FARBPROC
'Common Shared glMultiTexCoord2fvARB             As PFNGLMULTITEXCOORD2FVARBPROC
'Common Shared glActiveTextureARB                As PFNGlActiveTextureARBPROC
'Common Shared glClientActiveTextureARB          As PFNglClientActiveTextureARBPROC
'Common Shared maxTexelUnits                     As Gluint
'
'
'Common Shared glGenerateMipmapEXT              As PFNglGenerateMipmapEXTPROC
'Common Shared glCreateShaderObjectARB          As PFNglCreateShaderObjectARBPROC
'Common Shared glShaderSourceARB                As PFNglShaderSourceARBPROC
'Common Shared glGetShaderSourceARB             As PFNglGetShaderSourceARBPROC
'Common Shared glCompileShaderARB               As PFNGLCompileShaderARBPROC
'Common Shared glDeleteObjectARB                As PFNGLDeleteObjectARBPROC
'Common Shared glCreateProgramObjectARB         As PFNglCreateProgramObjectARBPROC
'Common Shared glAttachObjectARB                As PFNglAttachObjectARBPROC
'Common Shared glUseProgramObjectARB            As PFNglUseProgramObjectARBPROC
'Common Shared glLinkProgramARB                 As PFNglLinkProgramARBPROC
'Common Shared glValidateProgramARB             As PFNglValidateProgramARBPROC
'Common Shared glGetObjectParameterivARB        As PFNglGetObjectParameterivARBPROC
'Common Shared glGetInfoLogARB                  As PFNglGetInfoLogARBPROC
'Common Shared glGetUniformLocationARB          As PFNglGetUniformLocationARBPROC
'Common Shared glUniform1iARB                   As PFNglUniform1iARBPROC
'Common Shared glUniform1fARB                   As PFNglUniform1fARBPROC
'Common Shared glUniform2fvARB                  As PFNglUniform2fvARBPROC
'Common Shared glGetAttribLocationARB           As PFNglGetAttribLocationARBPROC
'Common Shared glVertexAttrib3fARB              As PFNglVertexAttrib3fARBPROC
'Common Shared glVertexAttrib3fvARB             As PFNglVertexAttrib3fvARBPROC
'Common Shared glVertexAttribPointerARB         As PFNglVertexAttribPointerARBPROC
'Common Shared glEnableVertexAttribArrayARB     As PFNglEnableVertexAttribArrayARBPROC
'Common Shared glDisableVertexAttribArrayARB    As PFNglDisableVertexAttribArrayARBPROC
'
'Common Shared Display As Display_Struct
'Common Shared vSync As Integer
'Common Shared Use_Shadows As Integer
'Common Shared Use_Shaders As Integer
'Common Shared Use_Anisotropic As Integer
'Common Shared Filter_Level As Integer
'Common shared as GlInt TextureLoc, NormalLoc, vattrib_tangent, vattrib_bitangent, RadiusLoc 
