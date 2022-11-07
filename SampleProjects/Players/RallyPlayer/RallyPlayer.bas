#define fbc  -Wl --enable-stdcall-fixup

#include "zlib.bi"

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbGfx.bas"
'if fatInitDefault() = 0 then
'  printf(!"Failed to init fat...\n")
'  printf(!"Listing NitroFS :(\n")
'end if
#else
chdir "NitroDir\"
#include "gl\gl.bi"
#include "gl\glu.bi"
#include "gl\glext.bi"
#include "crt.bi"
#include "fbgfx.bi"
#ifndef true
#define False 0
#define True 1
#endif
#endif


declare function DrawGLScene() as integer

dim shared as single xrot  '// X Rotation ( NEW )
dim shared as single yrot  '// Y Rotation ( NEW )
dim shared as single zrot  '// Z Rotation ( NEW )

dim shared as integer texture(1-1) '// Storage For One Texture ( NEW )
dim shared as integer iWid,iHei

function LoadGLTextures() as integer '// Load PCX files And Convert To Textures

	glGenTextures(1, @texture(0))
	glBindTexture(0, texture(0))
	'glTexImage2D(0, 0, GL_RGB, TEXTURE_SIZE_128 , _
  'TEXTURE_SIZE_128, 0, TEXGEN_TEXCOORD, pcx.image.data8)
	
	return true
  
end function
sub glColori(iColor as uinteger)  
  #define f(x) csng(((cuint(iColor) shr x) and &hF)/15)
  var fCA = f(12):if fCA < (1/256) then fCA = 1
  var fCR = f(8),fCG=f(4),fCB=f(0)     
  glColor3f(fCR,fCG,fCB) ',fCA)
end sub
sub InitializeVideo()
  #ifdef __FB_NDS__
    'gfx.CurrentDriver = gfx.gdOpenGL
    'screenres 256,192,8
    iWid=256:iHei=192
    videoSetMode(MODE_0_3D)
    vramSetBankA(VRAM_A_TEXTURE)
    vramSetBankB(VRAM_B_TEXTURE)
    vramSetBankC(VRAM_C_TEXTURE)
    vramSetBankD(VRAM_D_TEXTURE)
    vramSetBankF(VRAM_F_TEX_PALETTE_SLOT0)    
    
    videoSetModeSub( MODE_0_2D  )
    vramSetBankI( VRAM_I_SUB_BG_0x06208000 )
    consoleInit( NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 23, 2, false, true )
    
    glInit()
    
    glEnable(GL_BLEND)
    glEnable(GL_ANTIALIAS)  
    glEnable(GL_OUTLINE)
    glClearColor(0,0,0,31)
    glClearPolyID(63)
    glClearDepth(GL_MAX_DEPTH)
    glViewport(0,0,iWid-1,iHei-1)      
    glLight(0, RGB15(31,31,31) , 0, floattov10(-1.0), 0)  
    glMaterialf(GL_AMBIENT, RGB15(8,8,8))
    glMaterialf(GL_DIFFUSE, RGB15(8,8,8))
    glMaterialf(GL_SPECULAR, vBIT(15) or RGB15(15,15,15))
    glMaterialf(GL_EMISSION, RGB15(16,16,16))	
    '//ds uses a table for shinyness..this generates a half-ass one
    glMaterialShinyness()  
    glMatrixMode(GL_MODELVIEW)
    glPolyFmt(POLY_ALPHA(31) or POLY_CULL_BACK)
    'glEnable(GL_POLY_OVERFLOW)
    'glPolyFmt(POLY_ALPHA(30) or POLY_CULL_NONE)
  #else
    iWid=512:iHei=384
    screenres iWid,iHei,32,,fb.gfx_OpenGL
    glClearColor(0,0,0,1)
	  glViewport(0,0,iWid,iHei)
    glDisable(GL_DEPTH_TEST)
    glEnable(GL_ALPHA_TEST)
    glAlphaFunc(GL_GREATER,3/256)  
    glEnable(GL_BLEND)
    glShadeModel(GL_SMOOTH)      'Enable Smooth Shading
    glClearDepth 100.0           'Depth Buffer Setup
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
    glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE)
    glEnable(GL_DITHER)
    glDisable(GL_DEPTH_WRITEMASK)
  #endif
    
  glMatrixMode(GL_TEXTURE)
  glLoadIdentity()
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  glMatrixMode(GL_MODELVIEW)   
  
  glLoadIdentity()             'Reset The Projection Matrix
  glEnable(GL_TEXTURE_2D) 
  
end sub

enum BlendTypes
  RecNoBlend
  RecBlendAlpha
  RecBlendAdd
end enum
enum tRecTypes  
  tRecNull
  tRecFrameID
  tRecTriangleID
  tRecPointsID
  tRecLinesID
  tRecTexBlendID  
  tRecHeaderID = cvi("RREC")
end enum
namespace rec    
  type RecPoint
    as ulong uColor
    as short wSX,wSY    
  end type
  type RecLine
    as ulong uColor
    as short wSX1,wSY1
    as short wSX2,wSY2
  end type
  type tRecHeader
    as ulong wtype
    as short wWidth,wHeight
    as ulongint iTextures(1 to 32)
  end type
  type tRecFrame
    as byte btype,bResv
    iSize as ushort
    fTime as single    
  end type
  type tRecTriangle
    as byte bType    
    as byte bTex   :5
    as byte bBlend :3
    '
    as ubyte bU1,bV1
    as ubyte bSX1,bSY1
    as ushort wW1,wColor1
    '
    as ubyte bU2,bV2
    as ubyte bSX2,bSY2
    as ushort wW2,wColor2
    '
    as ubyte bU3,bV3
    as ubyte bSX3,bSY3
    as ushort wW3,wColor3
  end type
  type tRecPoints
    as short wType,wCount    
    as RecPoint rPoints(1023)
  end type
  type tRecLines
    as short wType,wCount
    as RecLine rLines(1023)
  end type
  
  dim shared as byte LastTex,LastBlend  
  dim shared as integer iTexAdded(255)

end namespace

'printf(!"----- Files: ----- \n")
var sFile = dir$("Recordings/*.rec")
'while len(sFile)
'  printf(!"%s\n",sFile)
'  sFile = dir$()
'wend
'printf(!"------------------ \n")
printf(!"[%s]\n",sFile)
var f = freefile()
if open("Recordings/"+sFile for binary access read as #f) then
  printf(!"Failed to open video file\n")
  sleep: end
end if

dim as integer FileSz = lof(f)-sizeof(rec.tRecHeader)
dim as rec.tRecHeader tHead
get #f,1,tHead
if tHead.wType <> tRecHeaderID then
  printf(!"File not a Rally Championship recording.\n")
  close #f: sleep: end
end if

var pBuffer = allocate(32768),iPosi=0,InputSz=0
var pRaw = allocate(256*1024)

InitializeVideo()

for CNT as integer = 1 to 32
  var iHash = tHead.iTextures(CNT)
  if iHash then
    #ifdef __FB_NDS__
    var iResu = glGenTextures(1,@rec.iTexAdded(CNT))
    if iResu=0 then
      printf(!"Failed to create texture...\n")
    end if
    #else
    glGenTextures(1,@rec.iTexAdded(CNT))
    #endif
    glBindTexture(GL_TEXTURE_2D,rec.iTexAdded(CNT))
    #ifndef __FB_NDS__
      'glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR)
      'glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST)
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT)
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT)
      'glTexParameteri(GL_TEXTURE_2D,GL_GENERATE_MIPMAP,1)
    #else
      glTexParameter(GL_TEXTURE_2D,GL_TEXTURE_COLOR0_TRANSPARENT)
    #endif
    
    var sFile = "Recordings/TexPacked/"+hex$(iHash,16)+".bmp"
    var f = freefile(),iW=0,iH=0
    if open(sFile for binary access read as #f)=0 then
      get #f,19,iW
      get #f,  ,iH
      close #f  
      printf(!"#%i %ix%i %s\n",CNT,iW,iH,hex$(iHash,16))                  
      #ifndef __FB_NDS__
        var pTemp = cast(fb.image ptr,ImageCreate(iW,iH))
        bload sFile,pTemp      
        var pPix = cast(uinteger ptr,pTemp+1)
        for CNT as integer = 0 to (iW*iH)-1
          if (pPix[CNT] and (not &hFF030303))=0 then
            pPix[CNT] and= &h00FFFFFF
          end if
        next CNT
        glTexImage2D(GL_TEXTURE_2D,0,4,iW,iH,0,GL_BGRA,GL_UNSIGNED_BYTE,0)
        glTexSubImage2D(GL_TEXTURE_2D,0,0,0,iW,iH,GL_BGRA,GL_UNSIGNED_BYTE,pTemp+1)
      #else
        var pTemp = cast(fb.image ptr,ImageCreate(iW,iH,,8))
        if pTemp=0 then printf(!"Failed to allocate image."):sleep 100,1
        dim as uinteger dwPal(255)        
        bload sFile,pTemp,@dwPal(0)      
        dim as integer iWSz,iHSz
        iWSz = iif(iW=128,TEXTURE_SIZE_128,TEXTURE_SIZE_256)
        iHSz = iif(iH=128,TEXTURE_SIZE_128,TEXTURE_SIZE_256)
        if glTexImage2D(0, 0, GL_RGB256, iWSz, iHSz, 0, TEXGEN_TEXCOORD or GL_TEXTURE_COLOR0_TRANSPARENT, pTemp+1)=0 then
          printf(!"Failed to upload texture?\n"):sleep 100,1
        else            
          dim as ushort wPal(255)
          for CNT as integer = 1 to 255
            wPal(CNT) = ((dwPal(CNT) and &h3E) shl 9) or _
            ((dwPal(CNT) and &h3E00) shr 4) or _
            ((dwPal(CNT) and &h3E0000) shr 17)
          next CNT
          glColorTableEXT(0,0,256,0,0,@wPal(0))
        end if
      #endif
      ImageDestroy(pTemp):pTemp=0
    else
      printf(!"Failed to open %s\n",hex$(iHash,16)+".bmp")
    end if
  end if
next CNT

dim as integer iLastTex=-1,iLastBlend=-1
dim as double FrameTime = timer
dim as double LastTime = 0
'dim as single fWX = iWid/255, fWY = iHei/255
dim as single fWX = 2/255, fWY = 2/255

InputSz = sizeof(rec.tRecHeader)+1

#if 1
do
  
  if InputSz >= FileSz then exit do  
  if multikey(fb.SC_ESCAPE) then exit do
  if inkey = chr$(255)+"k" then exit do
  
  var iRawSz = 512*1024, iCompSz = 0 '*cptr(integer ptr,pBuffer+InputSz)    
  dim as double TMR = timer  
  get #f,,iCompSz
  if (timer-FrameTime) > (LastTime + 1/8) then
    for CNT as integer = 1 to cint(((timer-FrameTime)-LastTime)*8)
      InputSz += (iCompSz+4)
      if InputSz > FileSz then exit do
      seek #f,InputSz    
      get #f,,iCompSz
    next CNT
  end if  
  if iCompSz > 32768 then 
    printf(!"Overflow on input buffer\n")
    sleep 1000,1:end
  end if
  get #f,,*cptr(ubyte ptr,pBuffer),iCompSz  
  var iResu = uncompress(pRaw,@iRawSz,pBuffer,iCompSz) '+inputSz
  'printf("[%i(%i)]",iResu,iRawSz)
  InputSz += (iCompSz+4): iPosi = 0
  if InputSz > FileSz then exit do
  
  dim as integer iTriCount = 0  
  dim as integer iTexUse(31)
  
  'dim as single MyMat(15) = { _
  '   1   ,   0 , 0   , 0   , _
  '   0   ,  -1 , 0   , 0   , _
  '   0   ,   0 , 0.5 , 0.5   , _
  '  -0.5 ,  0.5, 0.5 , 0.5 }
  
  while iPosi<iRawSz    
    'printf("{%i}",*cptr(short ptr,pRaw+iPosi))
    select case *cptr(byte ptr,pRaw+iPosi)
    case tRecFrameID      
      printf(!"%1.1fms %i %1.1fs   \r",(timer-TMR)*1000,iCompSz,LastTime)  
      #ifdef __FB_NDS__    
      glFlush(0) 'GL_TRANS_MANUALSORT)    
      swiWaitForVBlank()
      #else
      flip
      glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)
      screensync
      #endif
      with *cptr(rec.tRecFrame ptr,pRaw+iPosi)
        if .iSize < 0 then exit while        
        LastTime = .fTime
        while (timer-FrameTime) <  LastTime
          sleep 1,1
          #ifndef __FB_NDS__
          screencontrol(fb.POLL_EVENTS)
          #endif
          if multikey(fb.SC_ESCAPE) then exit do
          if inkey = chr$(255)+"k" then exit do
        wend
      end with
      iPosi += sizeof(rec.tRecFrame)      
    case tRecTriangleID
      with *cptr(rec.tRecTriangle ptr,pRaw+iPosi) 
        if .bTex <> iLastTex then
          iLastTex = .bTex
          glBindTexture(GL_TEXTURE_2D,rec.iTexAdded(.bTex))
          iTexUse(.bTex)=1          
        end if
        if .bBlend <> iLastBlend then
          iLastBlend = .bBlend
          select case .bBlend
          case RecNoBlend
            glDisable(GL_BLEND)
          case RecBlendAlpha
            glEnable(GL_BLEND)
            'glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
          case RecBlendAdd
            glEnable(GL_BLEND)
            'glBlendFunc(GL_ZERO,GL_ONE)
          end select
        end if
        dim as single fW,fIW        
        
        'for CNT as integer = 0 to 15
        '  MyMat(CNT) = rnd
        'next CNT
        'glLoadMatrixf(@MyMat(0))
        glBegin(GL_TRIANGLES)        
        #macro RecVertex(_I_)
        #ifdef __FB_NDS__        
        'glPolyFmt((((cint(.wColor##_I_) shl 5) or &h010000) and &hFF0000) or POLY_CULL_BACK or POLY_ALPHADEPTH_UPDATE)
        #define fc(_z1_) (((.wColor##_I_) and (&h0F shl (4*(3-_z1_)))) shl (4-_z1_))
        glColor(fc(1) or fc(2) or fc(3))        
        #undef fc
        'glTexCoord2f32(.bU##_I_,.bV##_I_)
        glTexCoord2f(.bU##_I_/255,.bV##_I_/255)
        glVertex3v16(-4096+(.bSX##_I_ shl 5), 4096-(.bSY##_I_ shl 5), 4095-iTriCount)
        #else
        glColori(.wColor1) 
        glTexCoord2f(.bU##_I_/255,.bV##_I_/255)
        fW = (.wW##_I_/65536): fIW = (1/fW)
        glVertex4f((-128+.bSX##_I_)*fWX*fIW,(128-.bSY##_I_)*fWY*fIW,0,fiW)
        'glVertex2f((-128+.bSX##_I_)*fWX,(128-.bSY##_I_)*fWY)
        #endif
        #endmacro
        
        RecVertex(1)
        RecVertex(3)
        RecVertex(2)
        
        iTriCount += 1
        
        glEnd()        
        iPosi += sizeof(rec.tRecTriangle)
      end with
    case tRecPointsID
      printf(!"Points Not implemented!\n"):exit while
    case tRecLinesID
      printf(!"Points Not implemented!\n"):exit while    
    case else
      'iPosi -= 4
      printf(!"Bad ID %i(%s)!\n",*cptr(ushort ptr,pRaw+iPosi))
      exit while
    end select
  wend
  
loop
#endif

#if 0
dim shared as integer MyTex
print glGenTextures(1,@MyTex)
glBindTexture(0,MyTex)
var pTexture = cast(ushort ptr,allocate(128*128*2))
dim as integer iCnt
for Y as integer = 0 to 127
  for X as integer = 0 to 127
    pTexture[iCnt] = sqr(((X-64)^2)+((Y-64)^2)) or &h8000
    iCNT += 1
  next X
next Y
print glTexImage2D(0, 0, GL_RGB, TEXTURE_SIZE_128 , _
TEXTURE_SIZE_128, 0, TEXGEN_TEXCOORD, pTexture)
rec.iTexAdded(0) = MyTex

do	
  '// set the color of the vertices to be drawn
  glColor3f(1,1,1)
  
  DrawGLScene()
  
  #ifdef __FB_NDS__    
  glFlush(GL_TRANS_MANUALSORT) 'GL_WBUFFERING
  swiWaitForVBlank()
  #else
  flip
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)
  screensync
  #endif
  
loop until len(inkey)

function DrawGLScene() as integer   '// Here's Where We Do All The Drawing
	glLoadIdentity()									'// Reset The View
	glRotatef(zrot,0.0f,0.0f,1.0f)  
  static as double fTime
  if fTime=0 then fTime=timer
  glBindTexture(GL_TEXTURE_2D, rec.iTexAdded(timer-fTime))
	glBegin(GL_QUADS)
		'// Front Face
    glColor3f(1,1,0)
		glTexCoord2f(0.0f, 0.0f): glVertex3f(-1.0f, -1.0f,  0.0f)
    glColor3f(1,0,1)
		glTexCoord2f(1.0f, 0.0f): glVertex3f( 1.0f, -1.0f,  0.0f)
    glColor3f(0,1,1)
		glTexCoord2f(1.0f, 1.0f): glVertex3f( 1.0f,  1.0f,  0.0f)
    glColor3f(1,1,1)
		glTexCoord2f(0.0f, 1.0f): glVertex3f(-1.0f,  1.0f,  0.0f)		
	glEnd()
  
	zrot += 0.4f*3
	return true
end function
#endif
