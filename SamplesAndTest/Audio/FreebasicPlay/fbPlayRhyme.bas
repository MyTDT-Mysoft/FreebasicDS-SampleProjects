#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  '#include "Modules\fbgfx.bas"
#else
  #include "fbgfx.bi"
  #include "crt.bi"
  chdir "NitroFiles/"
#endif

dim shared as zstring ptr Music(...) = { _
@"L32,O3,F16,FG,FG,F16,EF,L64,O1,B-,O2,B-,O3,DF,B-16,P16,B-16,L32", _
@"B-,O4C,O3,B-,O4C,O3,B-16,AB-,O1D,O2D,O3,B-,O4D,P16,D16,DE-,DB-", _
@"D16,C+D,L16,O1F,O2F,O4,F8,L32,O1,B-,O2,DF,B-,O4,DF,B-4..", _
@"E3,F8,F16,L8,B-,A16,O4,C,O3,B-16,O4,D,C16,E-,D16,L64,O1,A,O2,C", _
@"E-,F,O3,B8,O1,A,O2,C,E-,F,O4,C8,P8,O3,G16,L32,G,A,G,A,G16,F+,G", _
@"O1,C,O2,C,O3,G,O4,C,P16,C16,C,D,C,D,C16,O3,B,O4,C,O1,E-,O2,E-,O4,C,E-", _
@"P16,L32,E-16,E-,F,E-,F,E-16,D,E-,L16,O1,G,O2,G,O4,G8,O2,C,E-,G,O3,C", _
@"O4,E-,G,O5,C8,C8,O4,B-8,O5,C,O4,B-,A8,B-,A,G8,A,G,F8,G,F,E-8,O2,B-", _
@"O3,D,O4,C+,O2,B-,O3,D,O4,D,P8,O3,F,L32,F,G,F,G,F16,E,F,O0,B-,O1,B-", _
@"O3,B-16,P16,B-16,B-,O4,C,O3,B-,O4,C,O3,B-16,A,B-,D,O4,D16,P16", _
@"O3,B-16,O3,B-,O4,C,O3,B-,O4,C,O3,B-16,A,B-,O2,E-,B,O3,G16,P16,O4,C16", _
@"C,D,C,D,C16,O3,B,O4,C,O3,C,E-,O4,E-16,P16,C16,C,D,C,D,C16,O3,B-,O4,C", _
@"O2,F,A,O3,L16,A,P16,O4,D,L32,D,E-,D,E-,D16,C+,D,O3,D,F,O4,L16,F,P16,D", _
@"L32,D,E-,D,E-,D16,C,D,O2,G,B-,O3,B-16,P16,O4,E-16,E-,F,E-,F,E-16,D,E-", _
@"O2,A,O3,C,O4,C16,P16,F16,F,G,F,G,F16,E,F,O2,B-16,O3,D16,O4,D8,O2,L16E", _
@"G,B-,O3,D-,O4,D-,G,B-8,A8,G,O2,F,B-,O3,D,O4,F,P4,O2,L32,F,A,O3,C,E-", _
@"F,A16,P4,L16,O1,B-,O2,D,F8,O1,B-,O2,D,F8,O1,B-,O2,D,F8", _
@"O3,F4,B-8,A,B-8,O4,C,D8,C,D8,E-,E4,F,D,O3,B-4,F8,F,B-B,A,O4,C8", _
@"O3,B-,O4,D8,C,E-8,D,L4,O3,B,O4,C,O1,L16,A,O2,C,E-,F,O3,F4,L16,O4C8", _
@"O3,B,O4,C8,D,E-6,D,E-8,F,F+4,G,E-,C4,O3,F,B,F,O4,C8,O3,B,O4,D8,C", _
@"E-8,D,F8,E-,L4,C+,D,O1,B-16,O2,D16,F8,O4,D,B,O5,D8,L8,O4,E-,O5,E-", _
@"O4,D,O5,D,P8,O4,D,F16,E-,D16,D4,O1,G32,B-32,O2,D32,G32,O3,B-16,O4,B-16", _
@"O2,C16,E-16,O4,G8,G16,F16,E-8,L64,O2,D,O4,F32,E-16,O3,D,O4,D8,O2,D", _
@"O4,E-32,D16,O3,C,O4,C8,O2,D,O4,D32,C16,O2,B-O3,B-8,O2,D,O4,C32,O3", _
@"B-16,O2,A,B-,A,O2,L32,G,O3,G,O2,G,O3,G,L16,O2,D,O3,G,O1,B-,O3,G,O1,G", _
@"O2,B-,O3,D,G,O5,C8,D4,C4,P8,O4,C8,E,D8,C,C4,F2,E8,D8,L64,O2,C,O4,E32", _
@"D16,O3,A,O4,C8,O2,C,O4,D32,C16,O2,B-,O3,B-8,O2,C,O4,C32,O3,B-16,O2,A", _
@"O3,A8,O2,C,O3,B-32,A16,O2,G,O3,G8,L16,A,O2,F,O3,G8,L32,O1,F,A,O2,C,F", _
@"O3,F,A,O4,C,F8,O3,L32,G,F,E,F,L8,A,O4,C,E-,L16,O3,F,G,A,B-,O4,C,D,E-8", _
@"F,G,A,B-,O5,C,D,L8,E-,C,O4,A,F,E-,C,O3,A,F,L16,O4,B-8,A,B-8,O5,C", _
@"D8,C,D8,E-,E4,F,D,O4,B-4,F8,F,B-8,O4,A,O5,C8,O4,B-,O5,D8,C", _
@"E-8,D,O4,B4,O5,C4,O1,A,O2,C,F,O4,F4,O5,C8,O4,B,O5,C8", _
@"D,E-8,D,E-8,F+4,G,E-,C4,O4,F8,F,O5,C8,O4,B,O5,D8,C,E-8,D,F8,E-", _
@"C+4,D4,O1,B-,O2,D,P8,O4,B-,O5,C8,O4,B-,A6,B-,A8,B-,O5,D,C8,O4,B-", _
@"B-4,O5,C,D,E-4,O2,B-E-B-O5,C,D8,C,O4,O6,O5,C,O4,B8,O5,C,E,D8,C", _
@"C3,D,E,F4,O3,C,O2,F,O3,C,O5,D,E-8", _
@"D,C+8,D,C+8,D,F,E-8,D,L8,D4,G4,F,E-,O4,G,O5,D,C,C4,O4,B-4,P4,A,B-", _
@"O5,C8,E-,D,O4,A,B-,F+,G,O5,E-,C,C4,O4,B-4,P8,O5,C,D,E-,E,F,D,O4,B-,G", _
@"A,B-,O5,C,D,E-,L6,D8,E,D-,C,O4,B-,A,G,L8,F,A,G,F,G,A",0 }

dim as zstring*10 Note
dim as integer Posi,Lent,LineNum,Col
dim as zstring ptr Part

#include "Modules\PlayDS.bas"

play "MFT110I0"

do
  Part = Music(LineNum): LineNum += 1
  if Part = 0 then exit do
  Lent = strlen(Part)
  for CNT as integer = 0 to Lent
    dim as integer Char = Part[CNT]
    if Char = asc(",") or Char=0 then
      for CNT2 as integer = Posi to 8
        Note[CNT2] = 0
      next CNT2
      if (Col+Posi) >= 31 then
        print "": Col=0
      end if
      if Col then print ","; else print " ";
      print Note;
      Play Note
      Col += (Posi+1): Posi = 0
    else
      Note[Posi] = Char: Posi += 1
    end if
  next CNT  
loop

PlayFlush()

print:print "Done!"

sleep