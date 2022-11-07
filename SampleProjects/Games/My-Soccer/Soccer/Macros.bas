' Macro For create a graphic buffer and load a bmp into it
#macro ObjectLoad(OL_FNAME,OL_WID,OL_HEI,OL_TARGET)
if OL_TARGET = 0 then
  OL_TARGET = ImageCreate((OL_WID),(OL_HEI),,8)
else
  with *cptr(fb.image ptr,OL_TARGET)
  if .width <> OL_WID or .height <> OL_HEI then
    ImageDestroy(OL_TARGET)
    OL_TARGET = ImageCreate((OL_WID),(OL_HEI),,8)
  end if
  end with
end if
#ifndef __FB_NDS__
if dir$("Graph/" & OL_FNAME & ".bmp") = "" then end
#endif
printf("Graph/" & OL_FNAME & !".bmp\n")
bload "Graph/" & OL_FNAME & ".bmp",OL_TARGET
#endmacro

' Macro for adjust frame count for Frame Timed Movement
#macro AdjustFrame(AF_NUMB)
FR##AF_NUMB = 0
while (timer-TM##AF_NUMB) > 1/AF_NUMB
  FR##AF_NUMB += 1: TM##AF_NUMB += 1/AF_NUMB
wend
#endmacro

'#macro Pset2(pTGT,iPOSX,iPOSY,iCOLOR)
sub Pset2(pTGT as any ptr,iPOSX as uinteger,iPOSY as uinteger,iCOLOR as integer)
  if cuint(iPOSX) < 80 and cuint(iPOSY) < 60 then    
    cptr(ubyte ptr,pTGT)[((iPosY) shl 7)+iPosX] = iColor    
    'dim as any ptr Target = pTGT-32
    'pset Target,(iPosX,iPosY),iCOLOR
  end if
end sub

#ifdef __FB_NDS__
#define KeyEnter() ((Key[0]=13)          or (Key[1]=fb.SC_ButtonStart)  or (Key[1]=fb.SC_ButtonX))
#define KeyEsc()   ((Key[0]=27)          or (Key[1]=fb.SC_ButtonSelect) or (Key[1]=fb.SC_ButtonB))
#define KeyUp()    ((Key[1]=fb.SC_UP)    or (Key[1]=fb.SC_ButtonUP)     or (Key[1]=fb.SC_L))
#define KeyDown()  ((Key[1]=fb.SC_DOWN)  or (Key[1]=fb.SC_ButtonDOWN)   or (Key[1]=fb.SC_R))
#define KeyLeft()  ((Key[1]=fb.SC_LEFT)  or (Key[1]=fb.SC_ButtonLEFT)   or (Key[1]=fb.SC_ButtonY))
#define KeyRight() ((Key[1]=fb.SC_RIGHT) or (Key[1]=fb.SC_ButtonRIGHT)  or (Key[1]=fb.SC_ButtonA))
#else
#define KeyEnter() ((Key[0]=13))
#define KeyEsc()   ((Key[0]=27)          or (Key[1] = asc("k")))
#define KeyUp()    ((Key[1]=fb.SC_UP))
#define KeyDown()  ((Key[1]=fb.SC_DOWN))
#define KeyLeft()  ((Key[1]=fb.SC_LEFT))
#define KeyRight() ((Key[1]=fb.SC_RIGHT))
#endif