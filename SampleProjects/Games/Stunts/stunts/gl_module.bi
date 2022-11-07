'opengl handler header

#ifndef __FB_NDS__
#include "fbgfx.bi"
#include "GL/gl.bi"
#include "GL/glu.bi"
#endif

declare function init_gl_window( W as integer, H as integer, BPP as integer = 32, DBits as integer = 24, Num_buffers as integer = 0, Num_Samples as integer = 0, Fullscreen as integer = 0, zNear as integer = 1, zFar as integer = 1024 ) as integer
