#ifdef __FB_NDS__
#define __FB_FAT__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
#include once "fbgfx.bi"
chdir "NitroFiles/"
#endif

#ifdef __FB_NDS__
'gfx.GfxDriver = gfx.gdOpenGL
#endif

#include once "modulesTB/config.bas"
#include once "modulesTB/global.bas"
#include once "modulesTB/io.bas"
#include once "modulesTB/error.bas"
#include once "modulesTB/vm_dbg.bas"
#include once "modulesTB/vm.bas"
#include once "modulesTB/lexer.bas"
#include once "modulesTB/emit.bas"
#include once "modulesTB/ast.bas"
#include once "modulesTB/parse_expr.bas"
#include once "modulesTB/parser.bas"
#include once "modulesTB/debug.bas"

io_screenopen()
'io_load("prime")
'io_load("fill")
'io_load("mand2")
'io_load("mand3")
'io_load("mysoft1") '192ms
'io_load("sng")
io_load("mand4") ' 87ms

io_printstr("NDS BASIC v0.01")
io_printstr("Ready.")

#ifdef __FB_NDS__
while fb.KeyboardTempOffset < fb.KeyboardOffset
  screensync
wend
#endif

do
	dim as zstring * 1025 ln
	io_inputstr(">", ln, 1024)
	if ucase(ln) = "QUIT" then exit do
	if ln <> "" then parse(@ln[0])
loop

io_screenclose()

if __lines.root then line_free(__lines.root)

'1289ms mand2
'515ms mand2
