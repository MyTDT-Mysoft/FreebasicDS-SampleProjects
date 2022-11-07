#ifdef Render_OpenGL

#ifdef __FB_WIN32__
#include "windows.bi"
#endif

#ifndef FSAA
#define FSAA 1
#endif

#include once "fbgfx.bi"
#include once "GL/gl.bi"

namespace ogl

Dim Shared As Integer CORS(255),UseOpenGL=1
Dim Shared As Any Ptr BUFFER
Dim Shared As Integer TEXTURE,SCRX,SCRY,BPP
dim shared as integer TEXX,TEXY
Dim Shared As Double OFX,OFY,UPTIME
Dim Shared As Integer FRAMESKIP=0

Function GetScrPtr() As Any Ptr
  Return Screenptr
End Function

#define As5(Z,A,B,C,D,E) A as Z,B as Z,C as Z,D as Z,E as Z

sub VSync()
  screensync
end sub

Sub CallScreen(WID As Integer,HEI As Integer, BPP As Integer,PAGS As Integer,FLAGS As Integer)
  Screenres WID,HEI,BPP,PAGS,FLAGS
  if ogl.UseOpenGL then
    Windowtitle("OpenGL Render")
  end if
End Sub

' ***** Make a integer multiple of a power of 2 ****
#macro ogl_MulBits( MultipleBits, MyIntVar )
Asm
  mov eax,[MyIntVar]
  dec eax
  Shr eax,(MultipleBits)
  inc eax
  Shl eax,(MultipleBits)
  mov [MyIntVar],eax
End Asm
#endmacro
' ***** Raise a integer to a power of 2 *****
#macro ogl_Power2( MyIntNumber )
Asm
  mov eax,[MyIntNumber]  
  dec eax
  bsr ecx,eax
  inc ecx
  mov eax,0xFFFF0000  
  rol eax,cl
  And eax,0xFFFF
  inc eax
  mov [MyIntNumber],eax
End Asm
#endmacro

End namespace

#undef screenptr
Function Screenptr() As Any Ptr
  if ogl.UseOpenGL then
    #if FSAA = 16
    Return ogl.BUFFER+sizeof(fb.image)
    #Elseif FSAA = 4  
    Return ogl.BUFFER+sizeof(fb.image) 
    #else
    Return ogl.GetScrPtr()
    #Endif  
  else
    Return ogl.GetScrPtr()
  end if
End Function

#undef screenres
Sub Screenres( WID As Integer=-1, HEI As Integer=-1, BPP As Integer=32, PAGS As Integer=1, FLAGS As Integer=0, FRAMEX as integer=-1,FRAMEY as integer=-1)
  
  if ogl.UseOpenGL=0 then
    ogl.callscreen(WID,HEI,BPP,PAGS,FLAGS)
    exit sub
  end if  
  
  Dim As Integer TEXX,TEYY,FBWND
  Dim As Any Ptr TMP  
  Dim As Integer SCX,SCY  
  ScreenControl(fb.GET_DESKTOP_SIZE,SCX,SCY)  
  If WID=-1 Then WID=SCX
  If HEI=-1 Then HEI=SCY  
  If WID>=SCX Or HEI>=SCY Then FLAGS Or= fb.gfx_fullscreen
  
  ogl_Power2(BPP)
  If BPP <> 8 And BPP <> 16 And BPP <> 32 Then BPP = 32  
  If BPP = 8 Then Exit Sub
  ogl_Mulbits( 3, WID)
  ogl_Mulbits( 3, HEI)
  ogl.SCRX = WID:ogl.SCRY = HEI
  #if FSAA = 16
  WID *= 4: HEI *= 4
  #Elseif FSAA = 4
  WID *= 2: HEI *= 2
  #Endif  
  if FRAMEX<>-1 or FRAMEY<>-1 then
    TEXX=FRAMEX:TEYY=FRAMEY
  else
    TEXX = WID:TEYY = HEI
  end if      
  ogl.TEXX=TEXX:ogl.TEXY=TEYY
  ogl_Power2(TEXX)  
  ogl_Power2(TEYY)  
  ogl.OFX=ogl.TEXX/TEXX
  ogl.OFY=ogl.TEXY/TEYY
  ogl.BPP=BPP
  ogl.callscreen ogl.TEXX,ogl.TEXY,BPP,PAGS,fb.GFX_OPENGL Or FLAGS    
  Screencontrol(fb.GET_WINDOW_HANDLE,FBWND)
  #ifdef fb_win32
  scope
    dim as rect RCT
    dim as integer DFX,DFY,TMPX,TMPY
    GetWindowRect(cast(hwnd,FBWND),@RCT)
    with RCT
      DFX = ogl.SCRX+((.Right-.Left)-ogl.TEXX)
      DFY = ogl.SCRY+((.Bottom-.Top)-ogl.TEXY)
      SystemParametersInfo(SPI_GETWORKAREA,null,@RCT,null)    
      TMPX = RCT.Left+(((.Right-.Left)-DFX)/2)
      TMPY = RCT.Top+(((.Bottom-.Top)-DFY)/2)
    end with
    SetWindowPos(cast(hwnd,FBWND),null,TMPX,TMPY,DFX,DFY,SWP_NOZORDER)
  end scope  
  #endif
  glViewport(0,0,WID,HEI)
  glMatrixMode(GL_PROJECTION)  'Select The Projection Matrix
  glLoadIdentity()             'Reset The Projection Matrix
  glMatrixMode(GL_MODELVIEW)   'Select The Modelview Matrix
  glLoadIdentity()             'Reset The Projection Matrix
  glEnable(GL_TEXTURE_2D)      'Texture Mapping
  glGenTextures 1, @ogl.TEXTURE
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST)
  glClearColor(0f, 0f, 0f, 1.0f)
  glClear(GL_COLOR_BUFFER_BIT)  
  glLoadIdentity()
  glBindTexture GL_TEXTURE_2D, ogl.TEXTURE
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)  
  If BPP = 8 Then BPP=32
  TMP = ImageCreate(TEXX,TEYY,0,BPP)    
  If BPP = 32 Then
    #ifdef Render_32as16
    glTexImage2D(GL_TEXTURE_2D,0,3,TEXX,TEYY,0,GL_RGB,GL_UNSIGNED_SHORT_5_6_5,TMP+Sizeof(fb.image))
    #Else
    glTexImage2D(GL_TEXTURE_2D,0,3,TEXX,TEYY,0,GL_BGRA,GL_UNSIGNED_BYTE,TMP+Sizeof(fb.image))
    #Endif
  Else
    glTexImage2D(GL_TEXTURE_2D,0,3,TEXX,TEYY,0,GL_RGB,GL_UNSIGNED_SHORT_5_6_5,TMP+Sizeof(fb.image))
  End If
  
  #if FSAA = 16
  ogl.BUFFER = TMP
  #elseif FSAA = 4
  ogl.BUFFER = TMP
  #else
  If ogl.bpp = 8 Then
    ogl.BUFFER = TMP
  Else 
    ImageDestroy(TMP)
  End If
  #endif
  
End Sub

#undef screensync

Sub screenSync(SCRPTR as any ptr=0) 
  if ogl.UseOpenGL=0 then
    Ogl.Vsync()
    exit sub
  end if
  Dim BT As Double,TMP As Any Ptr, BUFSZ As Integer      
  if SCRPTR=0 then SCRPTR=screenptr
  Static As Integer FS
  Static As Any Ptr BUF  
  #ifdef Render_32as16
  If BUF = 0 Then BUF = ImageCreate(ogl.TEXX,ogl.TEXY,,16)  
  #Else
  If BUF Then ImageDestroy(BUF):BUF = 0  
  #Endif
  BT=Timer
  glBindTexture GL_TEXTURE_2D, ogl.TEXTURE  
  FS += 1
  If FS > OGL.FRAMESKIP Then FS=0  
  If FS=0 Then
    If ogl.BPP = 32 Then    
      #ifdef Render_32as16    
      '000rrrrr000ggggg000bbbbb   (shl al, 2)
      '000rrrrr000ggggg0bbbbb00   (shl ax, 3)
      '000rrrrrggggg0bbbbb00000   (shr eax,5)
      
      glTexSubImage2D(GL_TEXTURE_2D,0,0,0,ogl.TEXX,ogl.TEXY,GL_RGB,GL_UNSIGNED_SHORT_5_6_5,SCRPTR)
      #Else
      glTexSubImage2D(GL_TEXTURE_2D,0,0,0,ogl.TEXX,ogl.TEXY,GL_BGRA,GL_UNSIGNED_BYTE,SCRPTR)    
      #Endif
    Elseif ogl.BPP = 16 Then
      glTexSubImage2D(GL_TEXTURE_2D,0,0,0,ogl.TEXX,ogl.TEXY,GL_RGB,GL_UNSIGNED_SHORT_5_6_5,SCRPTR)
    Else
      For BUFSZ = 0 To 255
        'ogl.CORS(BUFSZ) = rgba(64,0,BUFSZ,0) 
        Palette Get BUFSZ,ogl.CORS(BUFSZ)
      Next BUFSZ
      TMP = SCRPTR
      BUFSZ = ogl.TEXX*ogl.TEXY
      Asm
        mov esi,[TMP]    
        mov edi,[ogl.BUFFER]
        add edi,Sizeof(fb.image)
        mov edx,offset ogl.CORS      
        mov ecx,[BUFSZ]
        Xor eax,eax
        _8TO32_NEXTPIXEL_:
        lodsb
        mov ebx,[EDX+EAX*4]
        mov [edi],ebx
        add edi,4
        dec ecx
        jnz _8TO32_NEXTPIXEL_
      End Asm
      glTexSubImage2D(GL_TEXTURE_2D,0,0,0,ogl.TEXX,ogl.TEXY,GL_BGRA,GL_UNSIGNED_BYTE,ogl.BUFFER+Sizeof(fb.image))
    End If
  End If  
  glBegin(GL_QUADS)      
  glTexCoord2f(ogl.OFX, ogl.OFY):glVertex3f(1,-1,0)  
  glTexCoord2f(0, ogl.OFY):glVertex3f(-1,-1,0)  
  glTexCoord2f(0,0):glVertex3f(-1,1,0)  
  glTexCoord2f(ogl.OFX, 0):glVertex3f(1,1,0)  
  glEnd()   
  ogl.UPTIME=Timer-BT
  Flip
End Sub

#else
namespace ogl
Dim Shared As Double UPTIME
Dim Shared As Integer FRAMESKIP=0
End namespace
#endif
