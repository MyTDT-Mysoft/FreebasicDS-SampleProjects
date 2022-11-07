#include "Modules\fbLib.bas"

dim as string Border,Chars(4),Text(4),Message
dim as integer BorderPosi=2,TextPosi,TextLen
dim as short CharSize(255),CharPosi(255)
dim as integer Vsync=4

Chars(0) =  "    ;####;####; ###;### ;####;####; ###;#  #;###; ###;#  #;#  ;#   #;#   #;"
Chars(1) =  "    ;#  #;#  #;#   ;#  #;#   ;#   ;#   ;#  #; # ;  # ;# # ;#  ;## ##;##  #;"
Chars(2) =  "    ;####;### ;#   ;#  #;####;### ;# ##;####; # ;  # ;##  ;#  ;# # #;# # #;"
Chars(3) =  "    ;#  #;#  #;#   ;#  #;#   ;#   ;#  #;#  #; # ;# # ;# # ;#  ;#   #;#  ##;"
Chars(4) =  "    ;#  #;####; ###;### ;####;#   ; ## ;#  #;###;### ;#  #;###;#   #;#   #;"
Chars(0) += "####;### ; ## ;### ; ###;###;#  #;#   #;#   #;#   #;#   #;#####;"
Chars(1) += "#  #;#  #;#  #;#  #;#   ; # ;#  #;#   #;#   #; # # ;#   #;   # ;"
Chars(2) += "#  #;### ;#  #;### ; ## ; # ;#  #;#   #;# # #;  #  ; # # ;  #  ;"
Chars(3) += "#  #;#   ;# ##;# # ;   #; # ;#  #; # # ;## ##; # # ;  #  ; #   ;"
Chars(4) += "####;#   ; ###;#  #;### ; # ; ## ;  #  ;#   #;#   #;  #  ;#####;"
Chars(0) += " ## ;  # ;####;### ;#  #;####;####;### ; ## ;####;"
Chars(1) += "#  #; ## ;   #;   #;#  #;#   ;#   ;  # ;#  #;#  #;"
Chars(2) += "#  #;  # ;####;### ;####;### ;####; ###; ## ;####;"
Chars(3) += "#  #;  # ;#   ;   #;   #;   #;#  #;  # ;#  #;   #;"
Chars(4) += " ## ;####;####;### ;   #;### ;####;  # ; ## ;####;"

Border = string$(32,asc(" "))
Message = "Mysoft wishes everyone a nice Hello World From 2011 ahhahaha"
Message = ucase$(Message)

for CNL as integer = 0 to 4
  CharPosi(0) = 1: TextLen = 1: TextPosi = 0
  for CNC as integer = 0 to len(Chars(CNL))-1
    select case Chars(CNL)[CNC]
    case asc("#")
      Chars(CNL)[CNC] = 2
    case asc(";")
      Chars(CNL)[CNC] = asc(" ")
      CharSize(TextPosi)=TextLen
      TextPosi += 1: TextLen = 0
      CharPosi(TextPosi)=CNC+2
    end select
    TextLen += 1
  next CNC  
next CNL

for CNT as integer = 0 to len(Message)-1
  dim as integer Char = Message[CNT]
  if Char >= asc("A") and Char <= asc("Z") then
    Char = (Char-asc("A"))+1   
  elseif Char >= asc("0") and Char <= asc("9") then
    Char = (Char-asc("0"))+27
  else
    Char = 0
  end if
  for CNL as integer = 0 to 4
    Text(CNL) += mid$(Chars(CNL),CharPosi(Char),CharSize(Char))
  next CNL
next CNT

for CNL as integer = 0 to 4
  Text(CNL) = Border+Text(CNL)+Border
next CNL
TextPosi = 1: TextLen = len(Text(0))

Border = "* * * * * * * * * * * * * * * * * * "

do
  
  for Console as integer  = 0 to 1
    fbConsole = iif(Console,@fbTopConsole,@fbBottomConsole)
    ConsoleSelect(fbConsole)    
    color 14-(Console*3)
    locate 1,1,0: print mid$(Border,BorderPosi,32);
    for CNT as integer = 2 to 23
      locate CNT,1: print mid$(Border,BorderPosi+CNT-1,1);
      locate CNT,32: print mid$(Border,BorderPosi+CNT,1);
    next CNT  
    locate 24,1: print mid$(Border,BorderPosi-1,32);
    if Console=0 then BorderPosi xor= 1
  next Console
  
  for REP as integer = 0 to 1
    for Console as integer = 0 to 1
      fbConsole = iif(Console,@fbTopConsole,@fbBottomConsole)
      ConsoleSelect(fbConsole)    
      color 10+(Console*2)
      for CNL as integer = 0 to 4
        locate CNL+10,2: print mid$(Text(CNL),TextPosi,30);
      next CNL
    next Console    
    for CNT as integer = 1 to Vsync
      Screensync()                
    next CNT    
    if TextPosi+30 = TextLen then TextPosi=1 else TextPosi += 1    
  next REP
  
  ScanKeys()
  if (KeysDown() and KEY_DOWN) and Vsync > 0 then Vsync -= 1
  if (KeysDown() and KEY_UP) and Vsync < 8 then Vsync += 1
  
loop

sleep
