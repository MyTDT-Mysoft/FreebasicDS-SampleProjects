enum MainMenuOptions
  mmoPlay = 0
  mmoOptions
  mmoQuit
end enum

' *************************************************************************
' ****************************** MENU LOOP ********************************
' *************************************************************************

scope  
  
  dim as double MBX,MBY,CURFRM,INVE,CIR=-16,ANV=.5
  dim as double CURPOS
  dim as any ptr BKHELP,BKTMP
  dim as ubyte ptr TMPPIX,HLPPIX
  dim as integer INTE,OLDIT,YY,XX,PX,PY
  dim as integer CURSPD=4,CUROPT
  dim as ExplodeStruct EXPLODE(79,59)
  dim as double MARK,QX,QY
  
  for YY = 0 to 59
    for XX = 0 to 79
      INTE = 60+rnd*60
      OLDIT = (rnd*360)
      with EXPLODE(XX,YY)
        .X = 40+sin(OLDIT*PI)*INTE
        .Y = 30+cos(OLDIT*PI)*INTE
      end with      
    next XX
  next YY
  
  BKHELP = ImageCreate(80,60,,8)
  BKTMP = ImageCreate(80,60,,8)
  
  ' *** Music Start ***
  FMUSIC_PlaySong(MENUSONG)
  
  do
    
    TMR = timer
    
    ' ****** Background *******
    put MYIMG,(MBX,MBY),BACK,pset
    put MYIMG,(MBX+80,MBY),BACK,pset
    put MYIMG,(MBX,MBY+60),BACK,pset
    put MYIMG,(MBX+80,MBY+60),BACK,pset
    
    ' ****** Menu **********
    put BKTMP,(5,4),MENU,pset
    put BKTMP,(9,8+(CURPOS)*13),CURSOR,(0,int(CURFRM)*19)-(20,(int(CURFRM)*19)+18),trans    
    if int(INVE) then 
      put BKTMP,(8,7+(CURPOS)*13),CURBR1,trans
    else
      put BKTMP,(8,7+(CURPOS)*13),CURBR2,trans
    end if
    
    ' ****** Effect *****
    line BKHELP,(0,0)-(79,59),0,bf
    if ANV > 0 then 
      ' ****** in animation ******
      circle BKHELP,(40,30),CIR,15,,,,f
      put BKHELP,(0,0),BKTMP,and
      CIR += SPD*ANV: if CIR > 55 then CIR=55:ANV=0
      FMUSIC_SetMasterVolume(MENUSONG,cint(CIR*4.6)*MUSICVOL)
    elseif ANV < 0 then
      ' **** out animation ****
      INTE=CIR:if INTE > 100 then INTE = 100
      if CUROPT <> mmoQuit then 'Volume Down (except if its for quit)
        FMUSIC_SetMasterVolume(MENUSONG,cint((100-INTE)*2.55)*MUSICVOL)
      end if
      MARK = sin((INTE*.9)*PI)
      HLPPIX = BKHELP+sizeof(fb.image)
      TMPPIX = BKTMP+Sizeof(fb.image)
      ' *** Draws the screen exploding ***
      for YY = 0 to 59
        for XX = 0 to 79
          with EXPLODE(XX,YY)        
            PX = XX+((.X-XX)*MARK)
            PY = YY+((.Y-YY)*MARK)
          end with
          if PX>=0 andalso PY>=0 andalso PX<=79 andalso PY<=59 then
            HLPPIX[PY*80+PX] = *TMPPIX
          end if
          TMPPIX += 1
        next XX
      next YY
      CIR += SPD*-ANV
      if CIR > 133 and ANV < 0 then exit do
    end if
    
    ' *** Drawing menu ***
    if ANV<>0 then 
      put MYIMG,(0,0),BKHELP,trans
    else
      put MYIMG,(0,0),BKTMP,trans
    end if
    
    ' **** Moevement Calc ****
    INVE += SPD/2:while INVE >= 2:INVE -= 2: wend    
    CURPOS = ((CURPOS*(7/SPD))+CUROPT)/((7/SPD)+1) ' Cursor Speed
    MBX-=SPD/4:MBY-=SPD/4
    if MBX <= -80 then MBX += 80
    if MBY <= -60 then MBY += 60    
    CURFRM += SPD/CURSPD
    if CURFRM >= 7 then CURFRM -= 7
    if CURFRM < 0 then CURFRM += 7
    
    ' *** Keyboard ***
    KEY = inkey$
    if KEY = chr$(13) and ANV=0 then 'enter select option
      CIR=0:ANV = -1.5:SoundPlay(gsExplode)
    end if
    if KEY = chr$(27) orelse KEY = chr$(255)+"k" then end 'esc/ctrl+f4/X bt - quit instantly
    if abs(CURPOS-CUROPT) < .1 and CIR>32 then
      if KEY = chr$(255)+"H" then 'Up key move menu cursor up
        SoundPlay(gsChute)
        CUROPT -= 1:CURSPD = -4:if CUROPT < 0 then CUROPT = 2
      elseif KEY = chr$(255)+"P" then 'Down Key move menu cursor down
        SoundPlay(gsChute)
        CUROPT += 1:CURSPD = 4:if CUROPT > 2 then CUROPT = 0
      end if      
    end if
    
    ' ********* Sync and Update ********
    Sync()    
    SPD = (timer-TMR)/(1/60)
    
  loop 
  
  if CUROPT = mmoQuit then
    ' ******** Quit Animation ********
    CIR=55:ANV = -.25:QX=0:QY=0  
    do
      
      TMR = timer
      
      line MYIMG,(0,0)-(79,59),13,bf
      FMUSIC_SetMasterVolume(MENUSONG,abs(cint(CIR*4.63)*MUSICVOL))
      
      ' ****** Effect *****
      line BKHELP,(0,0)-(79,59),0,bf    
      circle BKHELP,(40,30),CIR,15,,,,f
      PX = MBX+QX:PY = MBY+QY
      
      put BKHELP,(PX,PY),BACK,and
      put BKHELP,(PX+80,PY),BACK,and
      put BKHELP,(PX,PY+60),BACK,and
      put BKHELP,(PX+80,PY+60),BACK,and
      CIR += SPD*ANV: if CIR < -3 then exit do
      put MYIMG,(0,0),BKHELP,trans
      
      ' **** Moevement Calc ****
      if (int(CIR*3) and 1) then QX=-2+rnd*4:QY=-2+rnd*4
      INVE += SPD/2:while INVE >= 2:INVE -= 2: wend    
      MBX-=SPD/4:MBY-=SPD/4
      if MBX <= -80 then MBX += 80
      if MBY <= -60 then MBY += 60    
      CURFRM += SPD/4
      if CURFRM >= 7 then CURFRM -= 7
      
      ' ********* Sync and Update ********
      Sync()    
      SPD = (timer-TMR)/(1/60)
      
    loop 
    end
  end if
  
end scope
