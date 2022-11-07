if GOALANIM then 'here goes the goal animation
  FX += SPD/2:FY += SPD/2
  if FYY >= (240-60) andalso CH2 <> -1 then      
    do
      CNT = int((rnd*399)/100)
    loop until LOOPREP(CNT) = 0      
    select case CNT
    case 0
      #ifdef DoSound
      CH3 = SoundPlay(gsCrowd)
      #endif
      LOOPTMR = timer+16
    case 1
      #ifdef DoSound
      CH3 = SoundPlay(gsBatuque)
      #endif
      LOOPTMR = timer+16
    case 2
      #ifdef DoSound
      CH3 = SoundPlay(gsBatuque2)
      #endif
      LOOPTMR = timer+16
    case 3
      #ifdef DoSound
      CH3 = SoundPlay(gsTorcida)
      #endif
      LOOPTMR = timer+16
    end select
    LOOPCNT += 1      
    if LOOPCNT = 4 then
      for CNT = 0 to 3
        LOOPREP(CNT)=0
      next CNT
      LOOPCNT=0
    else
      LOOPREP(CNT) = 1
    end if      
    #ifdef DoSound
    SoundStop(CH2)
    #endif
    CH2=-1
  end if
  if GOALANIM < 3 then 
    line MYIMG,(0,15)-(79,15),13
    line MYIMG,(0,44)-(79,44),13
  end if
  if GOALANIM = 1 then
    if GOALSHW<27 then 'is showing only part of the led panel?
      for CNT = 0 to GOALSHW
        NY = APORD(CNT)
        put MYIMG,(0,16+NY),SPLF,(0,NY)-(19,NY),pset
        put MYIMG,(60,16+NY),SPRT,(0,NY)-(19,NY),pset
        NX = ((NY+ZSWAP) and 1) *8          
        CULZ = ANM_GOAL(0,0,NY)        
        dim as ubyte ptr ptrNY = MYIMG+sizeof(fb.image)+((NY+16) shl 7)+20
        for COUNT as integer = 39 to 0 step -1
          if (CULZ and 1) then 
            ptrNY[COUNT] = GOALCOLOR+NX 'pset
          else
            ptrNY[COUNT] = 13 'pset
          end if
          CULZ shr= 1: NX = 8-NX
        next COUNT
        NX = 8-NX          
      next CNT
      GOALSHW += SPD/3
      if GOALSHW >= 27 then 
        GOALANIM = 2
        GOALSHW=0
      end if
    end if
  elseif GOALANIM=2 then
    put MYIMG,(0,16),SPLF,pset
    put MYIMG,(60,16),SPRT,pset
    line MYIMG,(20,16)-(59,43),13,bf            
    ' ***** Drawing the animation *******
    NX = ZSWAP*8
    if GOALSHW > (DURI(GOALANI) and 127) then GOALANIM=3
    dim as ubyte ptr ptrNY = MYIMG+sizeof(fb.image)+(16 shl 7)+20
    for NY = 0 to 27
      CULZ = ANM_GOAL(GOALANI,int(GOALSHW),NY)        
      for CNT = 39 to 0 step -1
        if (CULZ and 1) then 
          NB=GOALCOLOR+NX
          if NB=13 then NB=0
          ptrNY[CNT] = NB 'pset
        else
          ptrNY[CNT] = 13 'pset
        end if
        CULZ shr= 1
        NX = 8-NX
      next CNT
      NX = 8-NX: ptrNY += (1 shl 7)
    next NY
    GOALSHW += SPD/4      
  else
    if GOALSHW > (DURI(GOALANI) and 127)+30 then
      BAX=199:BAY=116:GOALLEFT=0:GOALANIM=0
      BSX=0:BSY=0:GOALSHW=(DURI(GOALANI) and 127)
      setmouse 320,240:APITOTMR=timer+2
    else
      GOALSHW += SPD/4
    end if
  end if    
end if

' ***************************** Goal Animation ****************************
if GOALLEFT then
  if (abs(BSX)+abs(BSY)) > .05 then 
    GOALTMR = timer
  elseif (timer-GOALTMR) > 2 and GOALANIM=0 then       
    GOALANIM=1:GOALSHW=-3
    GOALCOLOR=2+rnd*4
    do
      GOALANI=cint((rnd*60)/10)
    loop while (DURI(GOALANI) and 128)
    DURI(-1) += 1: DURI(GOALANI) or= 128
    if DURI(-1) > ubound(DURI) then
      for CNT = 0 to ubound(DURI)
        DURI(CNT) and= (not 128)
      next CNT
      DURI(-1) = 0
    end if
  end if
  end if