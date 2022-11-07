#define fbc -gen GCC -O 3

#ifdef __FB_NDS__
#define __FB_NITRO__
#define __FB_PRECISE_TIMER__
#define __FB_GFX_NO_GL_RENDER__
#define __FB_GFX_NO_16BPP__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "fbgfx.bi"
#include "crt.bi"
chdir "NitroFiles/"
#endif

'#define SlowMotion

type floodPoint   
  as Integer x,y
  as floodPoint Ptr nextPoint
end type

declare sub flood_fill(x As Integer,y As Integer,newColor As Uinteger)
declare sub yetiflood(x as integer, y as integer, c as uinteger, fc as uinteger = &hFEFDFCFA )

dim shared as uinteger PFILLCOLOR,PBACKCOLOR,PMAXX,PMAXY
dim shared as uinteger PCALL
dim shared as ubyte ptr PSCRPTR,PTMPTR

const scr_wid=256,scr_hei=192
const mid_wid=scr_wid\2,mid_hei=scr_hei\2
const fScale = scr_hei/512
const SCRWID=scr_wid,SCRHEI=scr_hei
const PI = atn(1)/45

screenres scr_wid,scr_hei,8

dim as integer X,Y,iCC,RESU,TMP
dim as double DST,ANG,TMR

for iCC = 0 to 3
  
  #if 0
  ANG=0:DST=-(10000\scr_hei)
  dim as integer iFirst
  line(0,0)-(scr_wid,scr_hei),rgb(0,0,0),bf    
  do
    X = mid_wid+sin(PI*ANG)*DST*1.33*fScale
    Y = mid_hei-cos(PI*ANG)*DST*fScale
    'if X < 0 or X > 639 or Y < 0 or Y > 479 then exit do
    if DST < -225 then exit do
    if iFirst=0 then 
      iFirst=1: pset (X,Y),8   
    else
      line -(X,Y),8
    end if    
    
    ANG += (1/2)
    if ANG >= 360 then ANG -= 360
    DST += cos(ANG/10)/1.8
  loop    
  line(scr_wid*.02,scr_hei*.02)-(scr_wid*.98,scr_hei*.98),8,b
  circle(mid_wid,mid_hei),scr_hei*.6,8,,,1/1.33
  bsave "screen.bmp",0
  #else
  bload "screen.bmp"
  #endif 
  
  TMR = timer
  select case iCC
  case 0
    paint(mid_wid-1,mid_hei),9,8
    paint(0,mid_hei),10,8
    paint(mid_wid\4,mid_hei\4),12,8    
    puts(cint((timer-TMR)*10000) & "ns - Freebasic")  
  case 1
    flood_fill(mid_wid-1,mid_hei,9)
    flood_fill(0,mid_hei,10)
    flood_fill(mid_wid\4,mid_hei\4,12)
    puts(cint((timer-TMR)*10000) & "ns - Eclipse")
  case 2    
    yetiflood(mid_wid-1,mid_hei,9,8)
    yetiflood(0,mid_hei,10,8)
    yetiflood(mid_wid\4,mid_hei\4,12,8)      
    puts(cint((timer-TMR)*10000) & "ns - Yetifoot")
  case 3
    line(0,0)-(scr_wid,scr_hei),10,bf
    line(scr_wid*.02,scr_hei*.02)-(scr_wid*.98,scr_hei*.98),12,bf
    line(scr_wid*.1,scr_hei*.1)-(scr_wid*.9,scr_hei*.9),9,bf
    puts(cint((timer-TMR)*10000) & "ns - Plain")
  end select
  
  sleep
  
next iCC

' ************************************************************************************
' ************************************************************************************
Sub flood_fill(x As Integer,y As Integer,newColor As Uinteger)
    
  #macro DoSlow()
  #ifdef SlowMotion
  PCALL += 1: if PCALL >= 32 then PCALL=0: screenunlock:sleep 10,1:screenlock
  #endif
  #endmacro
  
  #macro FLOOD_POINT(px,py,lastPoint)       
  Dim As floodPoint Ptr newPoint = allocate(sizeof(floodPoint)) 'create new flood point
  If lastPoint Then lastPoint->nextPoint=newPoint 'append new point to last point if present
  With *newPoint
    .x=px
    .y=py
    .nextPoint=0
  End With
  lastPoint=newPoint 'update last point
  #endmacro
  
  Dim As ubyte Ptr target = screenptr   
  Dim As floodPoint Ptr currPoint,lastPoint,nextPoint
  
  Dim As Integer addr,xres,yres,pitch,targetPitch
  Dim As Integer xmin,ymin,xmax,ymax
  Dim As Integer x0,y0,x1,y1,x2,y2
  
  xres = scr_wid: yres = scr_hei: pitch = scr_wid  
  'screeninfo xres,yres,,,pitch
  
  xmin=0: xmax=xres-1
  ymin=0: ymax=yres-1
  
  If (x<xmin) Or (y<ymin) Or (x>xmax) Or (x>ymax) Then Return
  
  targetPitch=pitch' Shr 2
  
  addr=x+y*targetPitch
  
  FLOOD_POINT(x,y,lastPoint) 'generate initial flood point   
  currPoint=lastPoint        'store initial pointer
  
  screenlock
  
  Dim As Uinteger oldColor=target[addr] 'sample for oldColor
  
  If newColor=oldColor Then
    screenunlock
    Exit Sub
  End If
  
  target[addr]=newColor
  DoSlow()
  
  
  Do While currPoint
    
    With *currPoint       
      x0=.x: x1=x0-1: x2=x0+1
      y0=.y: y1=y0-1: y2=y0+1
    End With
    
    addr=x0+y0*targetPitch
    
    If x1>=xmin Then 'left         
      If (target[addr-1]=oldColor) Then
        target[addr-1]=newColor
        DoSlow()
        FLOOD_POINT(x1,y0,lastPoint)
      End If         
    End If
    
    If x2<=xmax Then 'right         
      If (target[addr+1]=oldColor) Then
        target[addr+1]=newColor
        DoSlow()
        FLOOD_POINT(x2,y0,lastPoint)
      End If         
    End If
    
    If y1>=ymin Then 'top
      If (target[addr-targetPitch]=oldColor) Then
        target[addr-targetPitch]=newColor
        DoSlow()
        FLOOD_POINT(x0,y1,lastPoint)
      End If
    End If
    
    If y2<=ymax Then 'bottom
      If (target[addr+targetPitch]=oldColor) Then
        target[addr+targetPitch]=newColor
        DoSlow()
        FLOOD_POINT(x0,y2,lastPoint)
      End If
    End If
    
    nextPoint=currPoint->nextPoint 'save next point     
    Deallocate(currPoint)          'delete current point       
    currPoint=nextPoint            'move to next point
    
  Loop
  
  screenunlock  
  
End Sub
' ************************************************************************************
' ************************************************************************************
sub yetiflood	(x as integer, y as integer, c as uinteger, fc as uinteger = &hFEFDFCFA )
  
  #define stack_size 512
  dim as ubyte ptr p = any, screen_p = any
  dim as short stack_pos=any,xx=any,x1=any
  dim as short on_lineA=any,on_lineB=any,oldx=any
  dim as short ya=any,yb=any,ya_good=any,yb_good=any
  dim stack(0 to stack_size - 1) as short = any
  
  screenlock  
  screen_p = screenptr( )
  
  stack_pos = stack_size-2
  
  'if fc = &hFEFDFCFA then
    fc = screen_p[(y * scr_wid) + x]    
  'end if
  
  'stack_pos -= 2
  stack(stack_pos+0) = x
  stack(stack_pos+1) = y
  
  'dim as integer MinStack = stack_size
  
  while stack_pos < stack_size
    'if stack_pos < MinStack then MinStack=stack_pos
    x = stack(stack_pos+0)
    y = stack(stack_pos+1)
    stack_pos += 2
    
    p = screen_p+(y * scr_wid)
    
    on_lineA = 0:on_lineB = 0
    
    do
      X -= 1: if X < 0 then exit do
    loop until p[x] <> fc
    x += 1
    
    oldx = x    
    ya = y - 1 :  yb = y + 1
    ya_good = (ya < scr_hei) and (ya >= 0)
    yb_good = (yb < scr_hei) and (yb >= 0)
    
    if yb_good then
      while x < scr_wid
        if p[x] <> fc then exit while
        if p[x + scr_wid] = fc then
          if on_lineB = 0 then
            stack_pos -= 2
            stack(stack_pos+0) = x
            stack(stack_pos+1) = yb
            on_lineB = 1
          end if
        else
          on_lineB = 0
        end if                
        x += 1
      wend    
    end if    
    if ya_good then
      for xx=oldx to x-1        
        if p[xx - scr_wid] = fc then
          if on_lineA = 0 then
            stack_pos -= 2
            stack(stack_pos+0) = xx
            stack(stack_pos+1) = ya
            on_lineA = 1
          end if
        else
          on_lineA = 0
        end if
        p[xx] = c
        '#ifdef SlowMotion
        'PCALL += 1: if PCALL >= 32 then PCALL=0: screenunlock:sleep 1,1:screenlock
        '#endif
      next xx      
    end if
    
    for x1 = oldx to x - 1
      p[x1] = c      
      #ifdef SlowMotion
      PCALL += 1: if PCALL >= 32 then PCALL=0: screenunlock:sleep 30,1:screenlock
      #endif
    next x1    
    
  wend
  
  'printf(!"%i\n",stack_size-MinStack)
  
  screenunlock
  
end sub
