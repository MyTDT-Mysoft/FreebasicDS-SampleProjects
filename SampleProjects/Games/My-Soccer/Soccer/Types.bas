' ***** Player Distance Array *******
type PlayerDistanceStruct
  DIST as integer
  ANGLE as integer
  PLAYER as integer
end type

' **** Player Struct for the 22 players in field ******
type PlayerStruct
  zNAME as zstring ptr ' Name of the player
  X as single          ' Position X in the field
  Y as single          ' Position Y in the field
  SX as single         ' Speed X
  SY as single         ' Speed Y
  FRAME as byte        ' Actual Frame
  KEYFL as byte        ' Key pressed
  DIC as byte          ' Direction (0=left / 1=right)
  BALL as byte         ' Has the ball?  
  ENERGY as byte       ' Energy that player have (SPEED/POWER/SKILL affected)
  SPEED as byte        ' Max Player Speed (more power... more speed loss)
  POWER as byte        ' Max Player Power (strenght of the kick vs height)
  SKILL as byte        ' Max Skill (Easy chance to connect moves)
  MIND as byte         ' Intelligence (when you dont control it)
end type

' **** Team Struct for team data ****
type TeamStruct
  zNAME as zstring ptr ' Team Name
  INTIMIDATE as byte   ' Intimidate level (favorite)
  CTSHIRT as byte      ' T-shirt Color
  CSHORTS as byte      ' Shorts color
  FLAG as byte         ' Flag Image Pointer
  ATTACK as byte       ' Attack average level
  DEFENSE as byte      ' Defense average level
  SPEED as byte        ' Speed average level
  SKILL as byte        ' Skill average level
end type

' **** Struct for Game Formation ****
type PlayerType
  BASEX as short
  BASEY as short
  TECH as byte
end type
type FormationStruct
  zName as zstring ptr
  Posi(10) as PlayerType
end type

' *** Explosion Effect Struct ***
type ExplodeStruct field=1
  X as short            ' Actual Position X
  Y as short            ' Actual Position Y
end type