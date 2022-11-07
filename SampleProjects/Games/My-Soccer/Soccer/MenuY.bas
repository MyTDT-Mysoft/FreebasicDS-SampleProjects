
' *************************************************************************
' ****************************** MENU LOOP ********************************
' *************************************************************************

enum MenuPages
  mpMain = 0
  mpOptions
end enum
enum MainMenuItems
  mmoPlay = 0
  mmoOptions
  mmoQuit
end enum
enum OptionMenuItems
  omiSfxVol = 0
  omiMusicVol
  OmiFieldType 
end enum

scope  
  
  dim as single MBX,MBY,CURFRM,INVE,CIR=-16,ANV=.5
  dim as single CURPOS
  dim as any ptr BKHELP,BKTMP,ATUMENU
  dim as ubyte ptr TMPPIX,HLPPIX
  dim as integer INTE,OLDIT,YY,XX,PX,PY
  dim as short CURSPD=4,CUROPT,MENUPAG
  dim as any ptr ExplodeBase = callocate(80*60*2*sizeof(short))
  dim as single QX,QY
  
  scope
    dim as ushort ptr Explode = ExplodeBase
    for YY = 0 to 59
      for XX = 0 to 79
        INTE = (60+rnd*60)*(1 shl 6)
        OLDIT = (rnd*360)
        Explode[0] = (40+sin(OLDIT*PI))*INTE
        Explode[1] = (30+cos(OLDIT*PI))*INTE
        Explode += 2
      next XX
    next YY
  end scope
  
  dim as any ptr BaseImage = ImageCreate(80,60)
  scope
    dim as ubyte ptr UpLine = BaseImage+SizeOf(fb.Image)
    dim as ubyte ptr DownLine = UpLine+59*80
    dim as integer Cir = 22
    for iY as integer = 29 to 0 step -1
      dim as integer iYP = iY*iY
      dim as integer NUM = 0, ADD = 0
      for iX as integer = 0 to 39    
        dim as integer SZ = int(sqr(iYP+NUM))
        UpLine[39-iX] = SZ :   UpLine[40+iX] = SZ
        DownLine[39-iX] = SZ : DownLine[40+iX] = SZ
        NUM += ADD+1 : ADD += 2
      next iX
      UpLine += 80: DownLine -= 80
    next iY  
  end scope  
  
  ATUMENU = MENU
  
  BKHELP = ImageCreate(80,60,,8)
  BKTMP = ImageCreate(80,60,,8)
  _MenuBegin_:
  
  CURFRM=0:INVE=0:CIR=-16:ANV=.5
  CURPOS=0:TMPPIX=0:HLPPIX=0
  INTE=0:OLDIT=0:YY=0:XX=0:PX=0:PY=0
  CURSPD=4:CUROPT=0:QX=0:QY=0
  
  ' *** Music Start ***
  #ifdef DoSound
  select case MENUPAG
  case mpMain    
    ATUSONG = MENUSONG        
  case mpOptions    
    ATUSONG = CFGSONG        
  end select  
  FMUSIC_PlaySong(ATUSONG)  
  #endif
  
  do    
    TMR = timer    
    ' ****** Background *******
    put MYIMG,(MBX,MBY),BACK,pset
    put MYIMG,(MBX+80,MBY),BACK,pset
    put MYIMG,(MBX,MBY+60),BACK,pset
    put MYIMG,(MBX+80,MBY+60),BACK,pset
    
    ' ****** Menu **********
    put BKTMP,(5,4),ATUMENU,pset
    put BKTMP,(9,8+(CURPOS)*13),CURSOR,(0,int(CURFRM)*19)-(20,(int(CURFRM)*19)+18),trans    
    if int(INVE) then 
      put BKTMP,(8,7+(CURPOS)*13),CURBR1,trans
    else
      put BKTMP,(8,7+(CURPOS)*13),CURBR2,trans
    end if
    
    ' ********************* Per Menu Drawing ******************
    select case MENUPAG
    '6.89
    case mpOptions
      ' ***** options SFX volume *****
      line BKTMP,(35,16)-(72,20),8,bf      
      if SFXVOL >= 168 then
        line BKTMP,(35,16)-(35+SFXVOL/6.89,20),4,bf
      elseif SFXVOL > 84 then
        line BKTMP,(35,16)-(35+SFXVOL/6.89,20),14,bf
      elseif SFXVOL = 0 then
        put BKTMP,(46,16),MOFF,pset
      else
        line BKTMP,(35,16)-(35+SFXVOL/6.89,20),2,bf
      end if      
      ' ***** options Music volume *****
      line BKTMP,(35,32)-(72,36),8,bf
      if MUSICVOL >= .66 then
        line BKTMP,(35,32)-(35+MUSICVOL*37,36),4,bf
      elseif MUSICVOL >= .33 then
        line BKTMP,(35,32)-(35+MUSICVOL*37,36),14,bf
      elseif MUSICVOL = 0 then
        put BKTMP,(46,32),MOFF,pset
      else
        line BKTMP,(35,32)-(35+MUSICVOL*37,36),2,bf
      end if 
      ' ***** options Field Type volume *****
      line BKTMP,(35,48)-(72,52),8,bf
      if FYTYPE then 
        put BKTMP,(35,48),MFIA,pset
      else
        put BKTMP,(35,48),MFIB,pset
      end if
    end select
    
    ' ****** Effect *****
    line BKHELP,(0,0)-(79,59),0,bf
    if ANV > 0 then 
      ' ****** in animation ******
      scope 'circle BKHELP,(40,30),CIR,15,,,,f
        dim as ubyte ptr SrcPix = BaseImage + sizeof(fb.image)
        dim as ubyte ptr DstPix = BKHELP + sizeof(fb.image)
        for CNT as integer = 0 to (80*60)-1
          if *SrcPix <= CIR then *DstPix = 15
          SrcPix += 1: DstPix += 1
        next CNT
      end scope      
      put BKHELP,(0,0),BKTMP,and
      CIR += SPD*ANV: if CIR > 55 then CIR=55:ANV=0
      #ifdef DoSound
      FMUSIC_SetMasterVolume(ATUSONG,cint(CIR*4.6)*MUSICVOL)
      #endif
    elseif ANV < 0 then
      ' **** out animation ****
      INTE=CIR:if INTE > 100 then INTE = 100
      if CUROPT <> mmoQuit then 'Volume Down (except if its for quit)
        #ifdef DoSound
        FMUSIC_SetMasterVolume(ATUSONG,cint((100-INTE)*2.55)*MUSICVOL)
        #endif
      end if
      dim as integer MARK = sin((INTE*.9)*PI)*(1 shl 6)
      HLPPIX = BKHELP+sizeof(fb.image)
      TMPPIX = BKTMP+Sizeof(fb.image)
      ' *** Draws the screen exploding ***
      dim as short ptr Explode = ExplodeBase
      for YY = 0 to 59
        for XX = 0 to 79          
          PX = XX+(((cint(Explode[0])-(XX shl 6))*MARK) shr (6+6))
          PY = YY+(((cint(Explode[1])-(YY shl 6))*MARK) shr (6+6))          
          if cuint(PX)<80 and cuint(PY)<60 then
            HLPPIX[PY*80+PX] = *TMPPIX
          end if
          TMPPIX += 1: Explode += 2
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
    var KeyLen = len(KEY)
    if KeyLen >= 1 then
      if KeyEnter() and ANV=0 then 'enter select option
        CIR=0:ANV = -1.5
        #ifdef DoSound
        SoundPlay(gsExplode)
        #endif
      end if    
      if KeyEsc() then end 'esc/ctrl+f4/X bt - quit instantly
    end if
    if KeyLen >= 1 andalso abs(CURPOS-CUROPT) < .1 and CIR>32 then      
      if KeyUp() then 'Up key move menu cursor up
        #ifdef DoSound
        SoundPlay(gsChute)
        #endif
        CUROPT -= 1:CURSPD = -4:if CUROPT < 0 then CUROPT = 2
      elseif KeyDown() then 'Down Key move menu cursor down
        #ifdef DoSound
        SoundPlay(gsChute)
        #endif
        CUROPT += 1:CURSPD = 4:if CUROPT > 2 then CUROPT = 0
      end if      
    end if
    
    ' ******************** Key for especific item/menu ****************
    if KeyLen >= 1 then
      select case MENUPAG
      case mpOptions 'Options Controls
        select case CUROPT
        case omiSfxVol
          if KeyLeft() andalso SFXVOL > 0 then
            SFXVOL -= 6.89:if SFXVOL < 0 then SFXVOL = 0
            #ifdef DoSound
            FSOUND_SetVolume(FSOUND_ALL,SFXVOL)          
            SoundPlay(gsNaTrave2)
            #endif
          elseif KeyRight() andalso SFXVOL < 255 then
            SFXVOL += 6.89:if SFXVOL > 255 then SFXVOL = 255
            #ifdef DoSound
            FSOUND_SetVolume(FSOUND_ALL,SFXVOL)          
            SoundPlay(gsNaTrave2)
            #endif
          end if
        case omiMusicVol
          #ifdef DoSound
          if KeyLeft() andalso MUSICVOL > 0 then
            MUSICVOL -= 0.02702:if MUSICVOL < 0 then MUSICVOL = 0
            FMUSIC_SetMasterVolume(ATUSONG,cint(255*MUSICVOL))         
          elseif KeyRight() andalso MUSICVOL < 1 then
            MUSICVOL += 0.02702:if MUSICVOL > 1 then MUSICVOL = 1
            FMUSIC_SetMasterVolume(ATUSONG,cint(255*MUSICVOL))          
          end if
          #endif
        case OmiFieldType
          if KeyLeft() orelse KeyRight() then            
            if FYTYPE = 0 then FYTYPE = 1 else FYTYPE = 0
          end if
        end select
      end select
    end if
    
    ' ********* Sync and Update ********
    Sync()    
    SPD = (timer-TMR)/(1/60)
    
  loop 
  
  ' **********************************************************
  ' ********************* Option Selected ********************
  ' **********************************************************
  select case MENUPAG 
  case mpMain 'In Main Menu
    select case CUROPT
    case mmoQuit 'Main -> Quit
      ' ******** Quit Animation ********
      CIR=55:ANV = -.25:QX=0:QY=0  
      do        
        TMR = timer        
        'line MYIMG,(0,0)-(79,59),13,bf
        memset(MYIMG+sizeof(fb.image),13,128*60)
        #ifdef DoSound
        FMUSIC_SetMasterVolume(MENUSONG,abs(cint(CIR*4.63)*MUSICVOL))
        #endif        
        ' ****** Effect *****
        'line BKHELP,(0,0)-(79,59),0,bf    
        memset(BKHELP+sizeof(fb.image),0,80*60)
        scope 'circle BKHELP,(40,30),CIR,15,,,,f
          dim as ubyte ptr SrcPix = BaseImage + sizeof(fb.image)
          dim as ubyte ptr DstPix = BKHELP + sizeof(fb.image)
          for CNT as integer = 0 to (80*60)-1
            if *SrcPix <= CIR then *DstPix = 15
            SrcPix += 1: DstPix += 1
          next CNT
        end scope
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
        SPD = (timer-TMR)*60 '/(1/60)      
      loop 
      end
    case mmoOptions
      ' ******* Save Options and back to main menu *********
      MENUPAG = mpOptions
      ATUMENU = CONFIG
      Goto _MenuBegin_
      scope
        dim as integer MYFILE = freefile()        
        #ifndef __FB_NDS__
        open "Soccer.cfg" for output as #MYFILE:close #MYFILE
        open "Soccer.cfg" for binary as #MYFILE
        put #MYFILE,1,FYTYPE
        put #MYFILE,,SFXVOL
        put #MYFILE,,MUSICVOL
        close #MYFILE
        #endif
      end scope      
    end select
  case mpOptions
    MENUPAG = mpMain
    ATUMENU = MENU
    Goto _MenuBegin_
  end select
  
end scope
