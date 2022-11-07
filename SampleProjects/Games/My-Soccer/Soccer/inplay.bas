' *************************************************************************
' ****************************** MAIN LOOP ********************************
' *************************************************************************
TM8=timer:TM30=TM8:TM20=TM8
KEYTIME=TM8
APITOTMR=TM8+2
INGAMEPLAYING = cint(rnd*5)
#ifdef DoSound
FMUSIC_PlaySong(INGAME(INGAMEPLAYING))
FMUSIC_SetMasterVolume(INGAME(INGAMEPLAYING),255*MUSICVOL)
CH3 = SoundPlay(gsCrowd3)
#endif

LOOPTMR = 0
do
  
  #if __FB_BACKEND__ = "gcc"
  #define RotateBorderL(SHBORD) SHBORD = (SHBORD shr 15) or (SHBORD shl 1):
  #define RotateBorderR(SHBORD) SHBORD = (SHBORD shl 15) or (SHBORD shr 1):
  #else
  #define RotateBorderL(SHBORD) asm rol word ptr [SHBORD]
  #define RotateBorderR(SHBORD) asm ror word ptr [SHBORD]
  #endif
  
  TMR=timer
  ' **** Timing based frames ****
  AdjustFrame(8)
  AdjustFrame(20)
  AdjustFrame(30)
  
  ' *** Apito Sound ***
  if APITOTMR<>0 andalso timer>APITOTMR then
    #ifdef DoSound
    SoundPlay(gsApito)
    #endif
    APITOTMR = 0
  end if
  ' *** Loop Sound ****
  if LOOPTMR<>0 andalso timer>LOOPTMR then
    #ifdef DoSound
    SoundStop(CH3)
    #endif
    select case cint(rnd*3)
    case 0
      #ifdef DoSound
      CH3 = SoundPlay(gsCrowd3)
      #endif
      LOOPTMR = 0
    end select
  end if
  ' *** Corneta Sound ***
  if LOOPTMR<>0 then CNT = 300/SPD else CNT = 1000/SPD
  if cint(rnd*CNT) = (CNT shr 2) then
    #ifdef DoSound
    if IsPlaying(CH4) = 0 then
      CH4 = SoundPlay(gsCorneta)
    end if
    #endif
  end if
  
  ' *** Altertaning 20fps ***
  for CNT = 1 to FR20
    ZSWAP = 1-ZSWAP
  next CNT
  
  ' *** Get Mouse ***
  getmouse NX,NY,,NB
  if NX>=0 and NY>=0 and NB>=0 then
    MX=NX:MY=NY:MB=NB
  end if
  
  ' *****************************************************
  ' ******************** Draw Frame *********************
  ' *****************************************************
  
  ' *** Field ***
  FXX = fix(FX): FYY = fix(FY)
  put MYIMG,(-FXX,-FYY),FILD,pset  
  
  
  ' ************** Borders and markers **************
  with PLAYERS(SELPLAY)
    NX = .X-(FXX):NY = .Y-(FYY)    
    if NX < -7 orelse NX > 77 orelse NY < -14 orelse NY > 56 then
      NX += 5: NY += 7 ' outside cursor
      if NX < 1 then NX = 1 else if NX > 78 then NX = 78
      if NY < 1 then NY = 1 else if NY > 58 then NY = 58
      NB = cint(rnd*15)
      if NX = 1 then
        if NY = 1 then
          line MYIMG,(0,0)-(3,0),NB 'left top
          line MYIMG,(0,0)-(0,3),NB
        elseif NY = 58 then
          line MYIMG,(0,59)-(3,59),NB 'left bottom
          line MYIMG,(0,59)-(0,56),NB
        else  
          line MYIMG,(0,NY)-(2,NY-2),NB 'left
          line MYIMG,(0,NY)-(2,NY+2),NB
        end if
      elseif NX = 78 then
        if NY = 1 then
          line MYIMG,(76,0)-(79,0),NB,b 'right, top
          line MYIMG,(79,0)-(79,3),NB,b          
        elseif NY = 58 then
          line MYIMG,(79,59)-(79,56),NB,b 'right, bottom
          line MYIMG,(79,59)-(76,59),NB,b
        else  
          line MYIMG,(79,NY)-(77,NY-2),NB 'right
          line MYIMG,(79,NY)-(77,NY+2),NB
        end if
      else
        if NY = 1 then
          line MYIMG,(NX,0)-(NX-2,2),NB 'top
          line MYIMG,(NX,0)-(NX+2,2),NB
        else
          line MYIMG,(NX,59)-(NX-2,57),NB 'bottom
          line MYIMG,(NX,59)-(NX+2,57),NB
        end if
      end if      
    else
      ' ****** Selection border ******
      if .KEYFL then 
        ' Border Animation while moving
        NB = cint(rnd*15)        
        NX += 4: NY = (NY-3)+sin(PLAYSMT*PI)*4
        line MYIMG,(NX,NY)-(NX-2,NY-2),NB
        line MYIMG,(NX,NY)-(NX+2,NY-2),NB
        PLAYSMT += 5*SPD
        while PLAYSMT > 165
          PLAYSMT -= 135
        wend        
        #if 0
        NX += 4: NY += 8
        pset2 (IMGPTR,NX,NY,NB)
        pset2 (IMGPTR,NX+sin(PLAYSMT*PI),NY-cos(PLAYSMT*PI),NB)
        pset2 (IMGPTR,NX-sin(PLAYSMT*PI),NY+cos(PLAYSMT*PI),NB)
        PLAYSMT += 17*SPD
        while PLAYSMT >= 360
          PLAYSMT -= 360
        wend
        #endif
      elseif PLAYERS(SELPLAY).frame = 0 then        
        ' Border Animation While not moving
        TMPBORDER = SELBORDER        
        for TCNT = NX+1 to NX+8 'top
          if (TMPBORDER and 1) then pset2(IMGPTR,TCNT,NY+2,1)
          RotateBorderL(TMPBORDER) 
        next TCNT
        for TCNT = NY+3 to NY+14 'right
          if (TMPBORDER and 1) then pset2(IMGPTR,NX+8,TCNT,1)
          RotateBorderL(TMPBORDER) 
        next TCNT
        for TCNT = NX+8 to NX+1 step -1 'bottom
          if (TMPBORDER and 1) then pset2(IMGPTR,TCNT,NY+15,1)
          RotateBorderL(TMPBORDER) 
        next TCNT
        for TCNT = NY+14 to NY+3 step -1 'left
          if (TMPBORDER and 1) then pset2(IMGPTR,NX+1,TCNT,1)
          RotateBorderL(TMPBORDER) 
        next TCNT        
      end if
    end if
    
  end with 
  
  ' ***** the Ball ******
  if HASBALL=-1 then 
    put MYIMG,(BAX-FXX,BAY-FYY),BALL,(0,int(BAFR)*2)-(1,int(BAFR)*2+1),trans
  end if
  
  ' *** Players ***
  for CNT = 0 to 10
    with PLAYERS(CNT)
      NX = fix(.X)-(FXX):NY = fix(.Y)-(FYY)
      put MYIMG,(NX,NY),PLAYLF, _ 'team A
      (.DIC*11,.FRAME*16)-(.DIC*11+9,.FRAME*16+14),trans
    end with    
  next CNT
  for CNT = 11 to 21
    with PLAYERS(CNT)
      put MYIMG,((fix(.X)-(FXX)),(fix(.Y)-(FYY))),PLAYRT, _ 'team B
      (.DIC*11,.FRAME*16)-(.DIC*11+9,.FRAME*16+14),trans
    end with
  next CNT
  
  ' ***** the Ball ******
  if HASBALL<>-1 then 
    put MYIMG,(BAX-FXX,BAY-FYY),BALL,(0,int(BAFR)*2)-(1,int(BAFR)*2+1),trans
  end if
  
  ' *** Goal posts ***
  put MYIMG,(19-FXX,100-FYY),TRAVEA,trans
  put MYIMG,(359-FXX,100-FYY),TRAVEB,trans
  DrawString (80-FXX,1-FYY, *TEAMS(TEAMA).zNAME & " 0x0 " & *TEAMS(TEAMB).zNAME)
  
  #include "GoalAnim.bas"
  
  ' ************************************************************************
  ' **************************** Keyboard Key events ***********************
  ' ************************************************************************
  KEY = inkey$
  var KeyLen = len(KEY)
  dim as integer KeyCode
  
  #ifdef __FB_NDS__
  #define KeyEscape() ((KeyCode=27) or (KeyCode=-fb.SC_ButtonSelect))
  #define KeyTAB() (KeyCode=9 or KeyCode=-fb.SC_BUTTONX)
  #define ButtonKick() asc("d"),-fb.SC_BUTTONA
  #define ButtonPass() asc("s"),-fb.SC_BUTTONB
  #define ButtonLeft() (multikey(fb.SC_LEFT) or multikey(fb.SC_ButtonLeft))
  #define ButtonRight() (multikey(fb.SC_RIGHT) or multikey(fb.SC_ButtonRight))
  #define ButtonUp() (multikey(fb.SC_UP) or multikey(fb.SC_ButtonUp))
  #define ButtonDown() (multikey(fb.SC_DOWN) or multikey(fb.SC_ButtonDown))
  #else
  #define KeyEscape() ((KeyCode=27))
  #define KeyTAB() (KeyCode=9)
  #define ButtonKick() asc("d")
  #define ButtonPass() asc("s")
  #define ButtonLeft() (multikey(fb.SC_LEFT))
  #define ButtonRight() (multikey(fb.SC_RIGHT))
  #define ButtonUp() (multikey(fb.SC_UP))
  #define ButtonDown() (multikey(fb.SC_DOWN))    
  #endif
  
  if KeyLen then        
    if KeyLen > 1 then KeyCode = -Key[1] else KeyCode = Key[0]          
    if KeyEscape() then exit do      
    if KeyTAB() then ' TAB key - Change Field Type
      if FYTYPE = 0 then 
        ObjectLoad("Field",400,240,FILD):FYTYPE=1
      else
        ObjectLoad("Field2",400,240,FILD):FYTYPE=0
      end if
    end if
    ' ********** letter keys ************
    if KeyCode > asc("A") andalso KeyCode < asc("Z") then KeyCode += 32
    select case KeyCode
    case ButtonKick() 'kick
      if SELPLAY = HASBALL then
        BSX = SINDIC*8: BSY = COSDIC*8
        HASBALL = -1: OLDHAS = -1
      end if
    case ButtonPass() ' Pass / Change Player
      ' *** Getting PLayer Distances ****
      for CNT = 1 to 10
        with SORT(CNT)
          .DIST = sqr(((BAX-PLAYERS(CNT).X)^2)+((BAY-PLAYERS(CNT).Y)^2))
          .ANGLE = atan2((BAY-PLAYERS(CNT).Y),(BAX-PLAYERS(CNT).X))
          .PLAYER = CNT
        end with
      next CNT
      ' *** Sorting ***
      do
        TCNT = 0
        for CNT = 1 to 9
          if SORT(CNT+1).DIST < SORT(CNT).DIST then 
            swap SORT(CNT),SORT(CNT+1): TCNT = 1
          end if
        next CNT
      loop while TCNT
      ' *** Selecting ***
      LASTSEL += 1
      if SORT(LASTSEL).DIST > 55 then LASTSEL = 1
      SELPLAY = SORT(LASTSEL).PLAYER
    end select
  end if
  
  ' ***********************************************************************
  ' *************************** Player Movement ***************************
  ' ***********************************************************************
  for CNT = 0 to 21
    PLAYERS(CNT).KEYFL = 0 ' Clearing "press key"
  next CNT
  SINDIC=0:COSDIC=0  
  if OLDHAS < 0 andalso GOALLEFT=0 andalso GOALRIGHT=0 then
    with PLAYERS(SELPLAY)
      ' ******* Left/Right key = move player *******
      if ButtonLeft() then
        .DIC=0:.KEYFL=1:SINDIC=-1
        for CNT = 1 to FR8
          .FRAME += 1: if .FRAME = 4 then .FRAME = 1
        next CNT
        .X -= .5*SPD
        ' ** moving ball **
        if HASBALL=SELPLAY then
          if (timer-KEYTIME) > .25 then
            BSX -= 1.6:HASBALL=-2:OLDHAS=SELPLAY
          end if
        end if
      elseif ButtonRight() then
        .DIC=1:.KEYFL=1:SINDIC=1
        for CNT = 1 to FR8
          .FRAME += 1: if .FRAME = 4 then .FRAME = 1
        next CNT
        .X += .5*SPD
        ' ** moving ball **
        if HASBALL=SELPLAY then
          if (timer-KEYTIME) > .25 then
            BSX += 1.6:HASBALL=-2:OLDHAS=SELPLAY
          end if
        end if
      end if
      ' ******* Up/Down key = move player *******
      if ButtonDown() then
        COSDIC=1
        if .KEYFL=0 then
          .DIC=2:.KEYFL=1
          for CNT = 1 to FR8
            .FRAME += 1: if .FRAME = 4 then .FRAME = 1
          next CNT
        end if
        .Y += .5*SPD        
        ' ** moving ball **
        if HASBALL=SELPLAY orelse HASBALL=-2 then
          if (timer-KEYTIME) > .25 then
            BSY += 1.6:OLDHAS=SELPLAY:HASBALL=-1
          end if
        end if
      elseif ButtonUp() then
        COSDIC=-1
        if .KEYFL=0 then
          .DIC=3:.KEYFL=1
          for CNT = 1 to FR8
            .FRAME += 1: if .FRAME = 4 then .FRAME = 1
          next CNT          
        end if
        .Y -= .5*SPD
        ' ** moving ball **
        if HASBALL=SELPLAY orelse HASBALL=-2 then
          if (timer-KEYTIME) > .25 then
            BSY -= 1.6:OLDHAS=SELPLAY:HASBALL=-1
          end if
        end if
      end if
      if HASBALL=-2 then HASBALL=-1
    end with 
  end if
  
  #ifndef __FB_NDS__
  windowtitle "OLDHAS: " & OLDHAS & " / HASBALL: " & HASBALL
  #endif
  
  ' *************************************************************************
  ' ************************* Player automatic run **************************
  ' *************************************************************************
  if HASBALL < 0 andalso GOALLEFT=0 andalso GOALRIGHT=0 then
    dim as integer PLTEAM
    if OLDHAS >= 0 then
      if OLDHAS < 11 then PLTEAM=0 else PLTEAM=1         
    else
      PLTEAM=-1
    end if
    for PLAYCNT as integer = 0 to 21
      if PLTEAM=0 andalso PLAYCNT<11 andalso PLAYCNT<>SELPLAY then continue for
      if PLTEAM=1 andalso PLAYCNT>=11 andalso PLAYCNT<>SELPLAY then continue for
      with PLAYERS(PLAYCNT)      
        PLAYERS(PLAYCNT).KEYFL = 0
        if abs(BAX-(.X+4))<16 andalso abs(BAY-(.Y+13))<16 then        
          ' ******* Left/Right key = move player *******
          if cint(BAX)<cint(.X+4) then
            .DIC=0:.KEYFL=1
            for CNT = 1 to FR8
              .FRAME += 1: if .FRAME = 4 then .FRAME = 1
            next CNT
            .X -= .5*SPD        
          elseif cint(BAX)>CINT(.X+4) then
            .DIC=1:.KEYFL=1
            for CNT = 1 to FR8
              .FRAME += 1: if .FRAME = 4 then .FRAME = 1
            next CNT
            .X += .5*SPD        
          end if
          ' ******* Up/Down key = move player *******
          if cint(BAY)>cint(.Y+13) then            
            if .KEYFL=0 then
              .DIC=2:.KEYFL=1
              for CNT = 1 to FR8
                .FRAME += 1: if .FRAME = 4 then .FRAME = 1
              next CNT
            end if
            .Y += .5*SPD          
          elseif cint(BAY)<cint(.Y+13) then            
            if .KEYFL=0 then
              .DIC=3:.KEYFL=1
              for CNT = 1 to FR8
                .FRAME += 1: if .FRAME = 4 then .FRAME = 1
              next CNT          
            end if
            .Y -= .5*SPD            
          end if          
        else
          if PLAYCNT=SELPLAY then OLDHAS=-1
        end if
      end with
    next PLAYCNT
  end if
  
  ' ************************************************************************
  ' ******************** FIELD / SPRITES movement calc *********************
  ' ************************************************************************
  with PLAYERS(SELPLAY)
    
    ' *** Normalizing animation before stop player ***
    if .KEYFL = 0 then
      if HASBALL>=0 then KEYTIME = timer
      if .FRAME <> 0 then
        for CNT = 1 to FR8        
          .FRAME += 1:if .FRAME = 4 then .FRAME=0:exit for
        next CNT
      end if
    end if
  end with
  
  ' *** Moving ball while hooked to a player ***
  if HASBALL=SELPLAY then
    with Players(SELPLAY)
      BAX = .X+4
      BAY = .Y+13
    end with
  end if      
  ' *** Catching ball ***
  if HASBALL < 0 andalso (timer-KEYTIME)>=.5 then      
    for CNT = 0 to 10
      with Players(CNT)
        if abs(BAX-(.X+4))<=5 and abs(BAY-(.Y+13))<=5 then
          HASBALL=CNT:BSX/=4:BSY/=4
          SELPLAY=CNT:OLDHAS=-1          
          KEYTIME=timer:exit for
        end if
      end with
    next CNT
  end if      
  
  ' *** Player Selection Border ***
  if PLAYERS(SELPLAY).DIC = 0 orelse PLAYERS(SELPLAY).DIC = 3 then
    for CNT = 1 to FR30
      RotateBorderL(SELBORDER)  'Rotating Selection border (left-top)
    next CNT
  else
    for CNT = 1 to FR30
      RotateBorderR(SELBORDER)  'Rotating Selection border (right-bottom)
    next CNT
  end if
  
  ' ********* Ball Movement *********
  for CNT = 1 to FR30    
    ' *** Ball x Field Bounds ***
    if BAX < 0 then BAX = 0 else if BAX > 398 then BAX = 398
    if BAY < 0 then BAY = 0 else if BAY > 238 then BAY = 238
    ' *** Ball x Left Goal ***
    if BAX >= 40 and BAY >= 102 then 'is it inside the goal?
      if BAY <= 137 and (BAX+BSX)<40 then 
        GOALLEFT=1:GOALTMR = timer
        if CH3 <> -1 then 
          #ifdef DoSound
          SoundStop(CH3)
          #endif
          CH3=-1
        end if
        #ifdef DoSound
        CH2 = SoundPlay(gsCrowd2)
        #endif
      end if
    end if
    if GOALLEFT then 'if inside dont let it go back
      BAX+=BSX:BAY+=BSY
      if BAX < 20 then ' net
        BAX=20:BSX = -BSX*.025
        #ifdef DoSound
        SoundPlay(gsPasse)
        #endif
      end if
      if BAY < 105 then 
        BAY=105:BSY = -BSY/4
        #ifdef DoSound
        SoundPlay(gsPasse)
        #endif
      elseif BAY > 134 then 
        BAY=134:BSY = -BSY/4
        #ifdef DoSound
        SoundPlay(gsPasse)
        #endif
      end if
    else
      if BAX < 40  then 'if not inside...
        if BAX>18 then 'is in the back?
          if BAY >= 102 and BAY <= 137 then
            if BSY > 0 then BAY=102 else BAY=137
            BSY = (-BSY)/4
            #ifdef DoSound
            SoundPlay(gsPasse)
            #endif
          end if
        else 'if in up or down?
          if BAY >= 102 and BAY <= 137 then
            if BSX > 0 and (BAX+BSX)>18 then 
              BAX=18:BSX= (-BSX/4)
              #ifdef DoSound
              SoundPlay(gsPasse)
              #endif
            end if
          end if
        end if
      end if
      BAX+=BSX:BAY+=BSY
    end if    
    ' *** Ball speed decrease ***
    if abs(BSX) < .4 then BSX/=1.1 else BSX /= 1.03
    if abs(BSY) < .4 then BSY/=1.1 else BSY /= 1.03
  next CNT
  
  ' ************************* left mouse button = move field ****************
  if (MB and 1) then ' --- field offset ---
    if FIMOV=0 then
      FIMOV=1:setmouse 320,240,0
    else
      FX+=(MX-320)/2:FY+=(MY-240)/2
      setmouse 320,240      
    end if
  elseif (MB and 2) andalso APITOTMR=0 then ' --- ball offset ---
    if FIMOV=0 then
      FIMOV=1:setmouse 320,240,0
    elseif GOALLEFT=0 and GOALRIGHT=0 then
      DTMP =(MX-320)/8:if abs(DTMP)>8 then DTMP=8*sgn(DTMP)
      if abs(DTMP) > abs(BSX) then BSX = DTMP:DTMP=1000
      DTMP =(MY-240)/8:if abs(DTMP)>6 then DTMP=6*sgn(DTMP)
      if abs(DTMP) > abs(BSY) then BSY = DTMP:DTMP=1000
      setmouse 320,240
      if DTMP = 1000 then
        if sqr(BSX*BSX+BSY*BSY) > 4 then
          #ifdef DoSound
          if FSOUND_IsPlaying(CH1) = 0 then            
            CH1 = SoundPlay(gsChute)            
          end if
          #endif
        else
          #ifdef DoSound
          if FSOUND_IsPlaying(CH1) = 0 then            
            CH1 = SoundPlay(gsPasse)            
          end if
          #endif
        end if
      end if
    end if    
  else
    if FIMOV then FIMOV=0:setmouse ,,0
  end if
  if (MB and 1) = 0 and GOALANIM=0 then ' --- camera Offset ---
    static as integer BAXX,BAYY
    for CNT = 1 to 8
      BAXX = BAX: BAYY = BAY
    next CNT
    for CNT = 1 to FR30
      if abs((FX+40)-BAXX) > 35 or abs((FY+30)-BAYY) > 25 then 'ball is offscreen?
        if (abs(BSX)+abs(BSY)) > .05 then 'ball is moving??
          FX = (FX*3+(BAXX-40))/4: FY = (FY*3+(BAYY-30))/4 'double speed camera
        else
          FX = (FX*7+(BAXX-40))/8: FY = (FY*7+(BAYY-30))/8 'normal speed camera
        end if
      else
        FX = (FX*7+(BAXX-40))/8: FY = (FY*7+(BAYY-30))/8 'normal speed camera
      end if
    next CNT
  end if
  
  ' **** field bounds ****
  if FX < 0 then FX = 0 else if FX > 400-80 then FX = 400-80
  if FY < 0 then FY = 0 else if FY > 240-60 then FY = 240-60
  
  ' ********* Frame changer **********
  if (abs(BSX)+abs(BSY)) > .05 then
    BAFR += SPD*((abs(BSX)+abs(BSY))/2)
    while int(BAFR) > 3
      BAFR -= 4
    wend
  else
    BAFR = 4
  end if
  
  ' ********* Sync and Update ********
  'screenlock
  Sync()
  'color 15,13:locate 1,1:print " " & cint(BAX) & " - " & cint(BAY) & " "
  'screenunlock
  
  SPD = (timer-TMR)/(1/60)
  
  
  
loop
