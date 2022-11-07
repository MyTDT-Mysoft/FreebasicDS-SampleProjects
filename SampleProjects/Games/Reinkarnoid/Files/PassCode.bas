#if 0
dim as uinteger StageCode = &hFF884422,PerCheck,iMix,iOld
dim as string Chars = "ZA0YBX1CWD2VE3UF4TG5SH6RI7QJ8PKO9LNM"
dim as uinteger NumBase = len(Chars)

dim as uinteger Posi,Temp,iPower
dim as string sCode = "    -    "

print hex$(StageCode)

' ---- Encode ----
Posi = 0: Temp = StageCode: iOld = 0
for CNT as integer = 0 to 7
  dim as integer Char = ((Temp) mod NumBase)
  iMix = CNT xor (iOld and 7)
  Char += iMix-(((Char+iMix)>=NumBase) and NumBase)  
  sCode[Posi] = Chars[Char]: iOld = Char
  Temp \= NumBase: Posi += 1-(CNT=3)
next CNT
' ----------------

print Scode

' ---- Decode ----
Temp=0: iPower = 1: Posi = 0: iOld = 0
for CNT as integer = 0 to 7
  dim as integer Char = instr(1,Chars,chr$(sCode[Posi]))-1  
  iMix = CNT xor (iOld and 7): iOld = Char
  Char -= iMix-((Char<iMix) and NumBase)
  Temp += Char*iPower: iPower *= NumBase: Posi += 1-(CNT=3)
next CNT
'-----------------

'if StageCode = PerCheck then 
'  PerCheck += 54321: locate ,1,0
'  print hex$(StageCode,8),sCode,hex$(Temp,8),
'  print cint(cdbl(StageCode)/cdbl(&hFFFFFFFEull)*100) & "%";
'end if

print hex$(Temp)

sleep
#endif

#if 1
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

#define CP1 byref iScore      as uinteger
#define CP2 byref iDifficulty as ushort
#define CP3 byref iLevel      as ushort
#define CP4 byref iLives      as ushort
#define CP5 byref sCode       as string
function ConvertPassword(CP1,CP2,CP3,CP4,CP5,Operation as integer) as uinteger  
  dim as PasswordStruct TempPass
  dim as string Chars = "ZA0YBX1CWD2VE3UF4TG5SH6RI7QJ8PKO9LNM"
  dim as uinteger TempHash,NumBase = len(Chars)
  dim as uinteger Posi,Temp,iPower,iMix,iOld
  
  with TempPass
    if Operation = 0 then '---- Encode -----
      
      .Score      = iScore shr 4
      .Difficulty = iDifficulty
      .Level      = (iLevel+2)\5
      .Lives      = iLives
      .Noise      = rnd*8
      TempHash = (((((.Score shl 1)+.Difficulty) shl 1)+.Level) shl 1)+.Lives
      TempHash xor= ((TempHash shr 20) and &b11111)
      TempHash xor= ((TempHash shr 15) and &b11111)
      TempHash xor= ((TempHash shr 10) and &b11111)
      TempHash xor= ((TempHash shr  5) and &b11111)
      TempHash and= &b11111
      .Hash = TempHash
      TempHash = TempHash or (TempHash shl 5)
      TempHash or= (TempHash shl 10)
      TempHash or= ((TempHash shl 20) and &h00FFFFFF)            
      .iEncoded xor= TempHash      
      TempHash = .Noise or (.Noise shl 3)
      TempHash or= (TempHash shl 6)
      TempHash or= (TempHash shl 12) or (TempHash shl 24)
      TempHash and= &b00011111111111111111111111111111
      .iEncoded xor= TempHash
      
      sCode = "    -    ": Posi = 0: Temp = .iEncoded : iOld = 0
      for CNT as integer = 0 to 7
        dim as integer Char = ((Temp) mod NumBase)
        iMix = CNT xor (iOld and 7)
        Char += iMix-(((Char+iMix)>=NumBase) and NumBase)  
        sCode[Posi] = Chars[Char]: iOld = Char
        Temp \= NumBase: Posi += 1-(CNT=3)
      next CNT
      
      return 0
      
    else                 '---- Decode -----
      
      if len(sCode) <> 9 orelse sCode[4] <> asc("-") then return -1
      Temp=0: iPower = 1: Posi = 0: iOld = 0
      for CNT as integer = 0 to 7
        dim as integer Char = instr(1,Chars,chr$(sCode[Posi]))-1  
        iMix = CNT xor (iOld and 7): iOld = Char
        Char -= iMix-((Char<iMix) and NumBase)
        Temp += Char*iPower: iPower *= NumBase: Posi += 1-(CNT=3)
      next CNT
      
      .iEncoded = Temp
      TempHash = .Noise or (.Noise shl 3)
      TempHash or= (TempHash shl 6)
      TempHash or= (TempHash shl 12) or (TempHash shl 24)
      TempHash and= &b00011111111111111111111111111111
      .iEncoded xor= TempHash      
      TempHash = .Hash
      TempHash = TempHash or (TempHash shl 5)
      TempHash or= (TempHash shl 10)
      TempHash or= ((TempHash shl 20) and &h00FFFFFF)
      .iEncoded xor= TempHash      
      
      TempHash = (((((.Score shl 1)+.Difficulty) shl 1)+.Level) shl 1)+.Lives
      TempHash xor= ((TempHash shr 20) and &b11111)
      TempHash xor= ((TempHash shr 15) and &b11111)
      TempHash xor= ((TempHash shr 10) and &b11111)
      TempHash xor= ((TempHash shr  5) and &b11111)
      TempHash and= &b11111      
      if TempHash <> .Hash then return -2
      if .Lives > 6 then return -3      
      if .Difficulty > 2 then return -4
      dim TempScore as uinteger, TempDiff as ushort
      dim as integer TempLevel,TempLives
      TempScore = cint(.Score) shl 4
      if TempScore > 999999 then return -5
      TempDiff = .Difficulty
      TempLevel = (cint(.Level)-1)*5
      if TempLevel < 0 then TempLevel = 1 else TempLevel += 3
      if TempLevel > 33 then return -6
      TempLives = .Lives
      
      iScore = TempScore: iDifficulty = TempDiff
      iLevel = TempLevel: iLives = TempLives
      return 0
      
    end if
  end with
  
end function

randomize()
dim as integer iScore
dim as short iDifficulty,iLevel,iLives
dim as string sCode

iScore=324224: iDifficulty = 0: iLevel = 23: iLives = 5
if ConvertPassword(iScore,iDifficulty,iLevel,iLives,sCode,0) then
  print "Invalid Parameters for Encoding..."
end if
print iScore,iDifficulty,iLevel,iLives
print sCode

sCode = "002Y-Q51A"
iScore=-1: iDifficulty = -1: iLevel = -1: iLives = -1
var Resu = ConvertPassword(iScore,iDifficulty,iLevel,iLives,sCode,1)
if Resu then
  print "Invalid Code " & cint(Resu)
end if
print iScore,iDifficulty,iLevel,iLives

sleep
#endif