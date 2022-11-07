const PI = 3.141592/180
const InvPI = 1/PI

type Fragment
  iLvl as integer
  sAng as single  
  sSpd as single
  union
    sDst as single
    sPX as single
    iPX as integer
  end union
  union
    type
      iPnX as short
      iPnY as short
    end type
    sPY as single
    iPY as integer
  end union
end type

type PowerUpData
  iKindY as short
  iScroll as short
  iWait as short
  iPosX as short
  iPosY as short
end type

type BallData
  sX as single
  sY as single
  sAng as single
  iOldX(5) as short
  iOldY(5) as short
end type

type RoundData
  union
    type
    Kind :4 as ubyte
    Stat :4 as ubyte
  end type
  Block as ubyte
end union
end type

type AlienStruct
  as single fX,fY,fAng
  as single fSX,fSY
  iType as short
  iFrame as short
  iOldFrame as short
  iLast as short
  iSpd as short
  FrameStep as short
end type

type PasswordStruct  
  union
    #define _xPackedx_
    Type _xPackedx_
      Score       :16  as ushort
      Difficulty  :2   as ubyte
      Level       :3   as ubyte
      Lives       :3   as ubyte
      Hash        :5   as ubyte
      Noise       :3   as ubyte
    end type
    iEncoded as uinteger
  end union
end type

type HighScoreStruct
  as integer    iScore(4)
  as ubyte      iLevel(7)
  as zstring*16 sName(4)
end type

type SaveStruct
  as uinteger iRandom,iHash
  union
    type
      ScoreData  as HighScoreStruct
      ScrDouble  as byte
      RenderType as byte
      ScaleType  as byte
      SoundVol   as byte
    end type
    iData(125) as uinteger         
  end union
end type

#define CP1 byref iScore      as uinteger
#define CP2 byref iDifficulty as ushort
#define CP3 byref iLevel      as ushort
#define CP4 byref iLives      as ushort
#define CP5 byref sCode       as string
