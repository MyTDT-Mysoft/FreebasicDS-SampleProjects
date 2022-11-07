'model(obj) loading header...

#ifdef __FB_NDS__
#define __FB_NITRO__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
chdir "NitroFiles/"
open cons for output as #99
#define debugout 99
#endif

enum ShapeKind
  skFace       'VerticeCount, Vert0 , Vert1 , ... , Vert(VerticeCount-1)  
  skLine       'VerticeA,VerticeB  
  skMaterial   'MaterialNum
  skLast       'Last shape on the model
end enum

type tModel
  CheckSum as uinteger
  spVertices as short ptr  'x,y,z...
  spShapes as short ptr    'See ShapeKind
  pList as any ptr
end type
