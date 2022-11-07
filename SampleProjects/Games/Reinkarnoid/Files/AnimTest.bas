#define SC2X_X 256
#define SC2X_Y 192

#include "fbgfx.bi"
#include "MyTDT\scale2x.bas"
#include "crt.bi"
chdir "NitroFiles\"

const PI = 3.141592/180

screenres 512,384,16

dim as any ptr Buf = ImageCreate(256,192,0)
dim as any ptr Aliens = ImageCreate(128,64)


bload "Aliens.bmp",Aliens

type AlienStruct
  as single fX,fY,fAng  
  iType as short
  iFrame as short
  iOldFrame as short
  iLast as short
  iSpd as short
  FrameStep as short
end type

dim as AlienStruct tAlien(3)
dim as byte AlienSz(3) = {6,7,5,7}

#if 0
dim as any ptr Aliens2 = ImageCreate(128,64)
put Aliens2,(0,0),Aliens,pset
for CNT as integer = 0 to 3
  for Frame as integer = (CNT shl 3) to (CNT shl 3)+AlienSz(CNT)
    dim as integer FrameU = Frame-1, FrameD = Frame+1
    if FrameU < (CNT shl 3) then FrameU += (AlienSz(CNT)+1)
    if FrameD > (CNT shl 3)+AlienSz(CNT) then FrameD -= (AlienSz(CNT)+1)
    dim as integer AX = (Frame and 7) shl 4, AY = (Frame shr 3) shl 4
    dim as integer BX = (FrameD and 7) shl 4, BY = (FrameD shr 3) shl 4
    dim as integer ZX = (FrameU and 7) shl 4, ZY = (FrameU shr 3) shl 4
    dim as uinteger BackColor = point(AX,AY,Aliens)
    dim as uinteger BlackColor = iif(((Frame+CNT) and 1),rgb(150,0,150),rgb(200,0,200))
    line Aliens2,(AX,AY)-(AX+15,AY+15),BackColor,bf
    put Aliens2,(AX,AY),Aliens,(BX,BY)-(BX+15,BY+15),trans
    put Aliens2,(AX,AY),Aliens,(ZX,ZY)-(ZX+15,ZY+15),trans
    for Y as integer = 0 to 15
      for X as integer = 0 to 15
        if point(AX+X,AY+Y,Aliens2)<>BackColor then
          pset Aliens2,(AX+X,AY+Y),BlackColor
        end if
      next X
    next Y
    put Aliens2,(AX,AY),Aliens,(AX,AY)-(AX+15,AY+15),trans
  next Frame
next CNT
put(0,0),Aliens2,pset
bsave "Aliens16.bmp",Aliens2
sleep:end
#endif

for CNT as integer = 0 to 3
  with tAlien(CNT)
    .fX = 16+rnd*224
    .fY = 16+rnd*160
    .iType = CNT shl 3
    .iLast = AlienSz(CNT)
    .iFrame = int(rnd*(.iLast))+1
    .iOldFrame = .iFrame-1
    .iSpd = ((CNT and 1) xor 1)
    .fAng = (rnd*360)*PI
  end with
next CNT

do
  line Buf,(0,0)-(255,191),rgb(0,0,0),bf  
  for CNT as integer = 0 to 3
    with tAlien(CNT)
      if .iType >= 0 then
        dim as integer Frame = .iOldFrame+.iType
        dim as integer PX = (Frame and 7) shl 4
        dim as integer PY = (Frame shr 3) shl 4
        put Buf,(int(.fX),int(.fY)),Aliens,(PX,PY)-(PX+15,PY+15),trans
        if .iOldFrame <> .iFrame then
          Frame = .iFrame+.iType
          PX = (Frame and 7) shl 4: PY = (Frame shr 3) shl 4
          put Buf,(int(.fX),int(.fY)),Aliens,(PX,PY)-(PX+15,PY+15),alpha,.FrameStep
        end if
        'printf(!"%i %i %i \n",.iOldFrame,.iFrame,Frame)
        .FrameStep += 15      
        .fX += sin(.fAng)/8: .fY -= cos(.fAng)/8
        if .FrameStep >= 255 then
          'draw string Buf,(.iX-4,.iY-12),"" & .iFrame & "/" & .iSpd
          '.fX += sin(.fAng): .fY -= cos(.fAng)
          if .fX <=   0 then .fX =   1: .fAng = (( 90-60)+(rnd*120))*PI
          if .fY <=   0 then .fY =   1: .fAng = ((180-60)+(rnd*120))*PI
          if .fX >= 239 then .fX = 238: .fAng = ((270-60)+(rnd*120))*PI
          if .fY >= 175 then .fY = 174: .fAng = ((  0-60)+(rnd*120))*PI
          if int(rnd*100) = 50 then .fAng = (rnd*360)*PI
          .iOldFrame = .iFrame: .FrameStep = 0
          if .iSpd then
            if .iFrame = 0 and .iSpd <= -1 then
              if .iSpd = -1 then 
                .iSpd = -10 
              else
                .iSpd += 1: if .iSpd = -1 then .iSpd = 1
              end if
            elseif .iFrame = .iLast and .iSpd >= 1 then
              if .iSpd = 1 then 
                .iSpd = 10
              else
                .iSpd -= 1: if .iSpd = 1 then .iSpd = -1
              end if
            else
              .iFrame += .iSpd
              if int(rnd*10) = 5 then .iSpd = -sgn(.iSpd): .fAng += 180
            end if
          else
            .iFrame += 1: if .iFrame > .iLast then .iFrame = 0
          end if
        end if
      end if
    end with
  next CNT
  
  screenlock
  bpp16.resize2x(buf+sizeof(fb.image),screenptr)
  'put(0,0),buf,pset
  screenunlock
  
  static as double TMR
  if abs(timer-TMR) > 1 then TMR = timer  
  while (timer-TMR) < 1/60
    sleep 1,1
  wend
  TMR += 1/60
  'sleep 1,1
  'screensync
  
loop

sleep
