'opengl handler

#ifdef __FB_NDS__
#define glPopOneMatrix() glPopMatrix(1)
#else
#define glPopOneMatrix() glPopMatrix()
#endif

#ifdef __FB_NDS__
function init_gl_window( W as integer, H as integer, BPP as integer = 32, DBits as integer = 24, Num_buffers as integer = 0, Num_Samples as integer = 0, Fullscreen as integer = 0, zNear as integer = 1, zFar as integer = 1024 ) as integer
  
  'gfx.GfxDriver = gfx.gdOpenGL  
  'screenres 256,192
  
  videoSetMode(MODE_0_3D)	
	glInit()
	
  'glEnable(GL_TEXTURE_2D)
  'glEnable(GL_BLEND)
  glDisable(GL_BLEND)
  glDisable(GL_ANTIALIAS)  
  'glEnable(GL_OUTLINE)
  glClearColor(0,0,0,31)
  glClearPolyID(63)
  glClearDepth(&h7FFF)
  glViewport(0,0,255,191)
  
  glMatrixMode(GL_TEXTURE)
  glLoadIdentity()
  glMatrixMode(GL_MODELVIEW) 
  glColor3f(1,1,1)
  
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  dim as single aspect = W/H
  'gluPerspective( 60, aspect, zNear*FixScale, zFar )  
  gluPerspective(60, 256.0 / 192.0, 0.1, 7.99)
 	
  glLight(0, RGB15(31,31,31) , 0, floattov10(-1.0), 0)
  
  glMaterialf(GL_AMBIENT, RGB15(8,8,8))
	glMaterialf(GL_DIFFUSE, RGB15(8,8,8))
	glMaterialf(GL_SPECULAR, vBIT(15) or RGB15(15,15,15))
	glMaterialf(GL_EMISSION, RGB15(16,16,16))	
	'//ds uses a table for shinyness..this generates a half-ass one
	glMaterialShinyness()
  
  glMatrixMode(GL_MODELVIEW)
  glPolyFmt(POLY_ALPHA(31) or POLY_CULL_NONE)
  'glEnable(GL_POLY_OVERFLOW)
  'glPolyFmt(POLY_ALPHA(30) or POLY_CULL_NONE)
  
  Return 1
  
end function
#else
function init_gl_window( W as integer, H as integer, BPP as integer = 32, DBits as integer = 24, Num_buffers as integer = 0, Num_Samples as integer = 0, Fullscreen as integer = 0, zNear as integer = 1, zFar as integer = 1024 ) as integer
  
  dim Flags as integer = FB.GFX_OPENGL
  
  if FullScreen <> 0 then
    Flags or = FB.GFX_FULLSCREEN
    print #debugout, "FULL SCREEN"
  end if
  
  screencontrol FB.SET_GL_COLOR_BITS, BPP
  screencontrol FB.SET_GL_DEPTH_BITS, DBits
  
  if Num_Samples > 0 then
    screencontrol FB.SET_GL_NUM_SAMPLES, Num_Samples
    Flags or = FB.GFX_MULTISAMPLE
    print #debugout, "MULTISAMPLE ENABLED"
  end if
  
  screenres W, H, BPP, Num_Buffers, Flags
  
  glViewport( 0, 0, W, H )
  glMatrixMode( GL_PROJECTION )
  glLoadIdentity()
  
  dim as single aspect = W/H
  
  glMatrixMode( GL_PROJECTION )
  glLoadIdentity()
  gluPerspective( 60, aspect, zNear*FixScale, 11 ) 'locked at 60... we can change to make a fisheye view or whatever
  
  glEnable( GL_DEPTH_TEST )
  glDepthFunc( GL_LEQUAL )
  glEnable( GL_COLOR_MATERIAL )
  
  glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST )
  glPolygonmode( GL_BACK, GL_FILL )
  glPolygonmode( GL_FRONT, GL_FILL )
  
  glEnable( GL_CULL_FACE )    
  glMatrixMode( GL_MODELVIEW )
  glShadeModel( GL_FLAT )
  
  return 0
  
end function
#endif