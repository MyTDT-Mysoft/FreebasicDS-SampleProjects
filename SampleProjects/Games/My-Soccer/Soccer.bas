#define fbc -s console

#define DoSound

#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#ifdef DoSound
#include "Modules\fmod.bas"
#endif
#else
#include "crt.bi"
chdir "NitroFiles/"
open cons for output as #99
#endif

#include "fbgfx.bi"
#include "Soccer\sound.bas"
#include "Soccer\Macros.bas"
#include "Soccer\Types.bas"

declare sub DrawString(PX as integer,PY as integer,TXT as string)

const PI = 3.141592/180

dim shared as byte FNTSPC(35) = { 5,5,4,5,5,5,5,5,2,5, _
5,4,6,5,5,5,5,5,5,4,5,6,6,4,6,4,4,4,4,4,4,4,4,4,4,4 } 'Font Spacing
dim shared as byte APORD(27) = { 14,0,24,2,19,4,18,7,23,9,25, _
3,10,1,13,6,15,22,16,12,27,11,5,17,20,8,21,26 }
dim shared as byte DURI(-1 to 6) = {0,80,90,60,90,80,90,96}

dim shared as ulongint PIX(15),CULZ          'Pixels Colors (8 chars)
dim shared as ulongint ANM_GOAL(6,100,27)    'Goal Anim Object
dim shared as ulongint ptr CULI              'Pointer for Anim lines
dim shared as ubyte ptr BUFPTR,SCRPTR,PIXPT  'Main Graphic buffer pointers
dim shared as any ptr MYIMG,FILD,FONT,BALL   'Graphic Object Pointers
dim shared as any ptr TRAVEA,TRAVEB,PLAYLF   'Graphic Object Pointers
dim shared as any ptr IMGPTR,PLAYRT          'Graphic Object Pointers
dim shared as any ptr SPLF,SPRT,BACK,MENU    'Graphic Object Pointers
dim shared as any ptr CURSOR,CURBR1,CURBR2   'Graphic Object Pointers
dim shared as any ptr CONFIG,MFIA,MFIB,MOFF  'Graphic Object Pointers
dim as ubyte LOOPREP(3),LOOPCNT,TEAMA,TEAMB 
dim as ushort SELBORDER=&h0101,TMPBORDER
dim as integer TCNT,FR8,FR30,FR20            'Frame Timed Counters
dim as integer CNT,VU,FIMOV,GOALLEFT,GOALRIGHT
dim as integer MX,MY,NX,NY,MB,NB,GOALANIM,ZSWAP
dim as integer MYFILE,FYTYPE=1
dim as integer GOALCOLOR,GOALANI,PLFR,FXX,FYY
dim as integer CH1=-1,CH2=-1,CH3=-1,CH4=-1
dim as double VV,TMR,TM4,TM8,TM30,TM20,SPD=1
dim as double BAFR,BSX,BSY,DTMP,SPX,SPY,FX,FY
dim as double GOALTMR,GOALSHW,APITOTMR,LOOPTMR
dim as double PLAYSMT=30
dim as double PX=200,PY=110,BAX=199,BAY=116
dim as string KEY

TEAMA=3:TEAMB=0

' *********************** Game play Variables ********************
dim shared as FormationStruct Form(4)       '4 Formation data
dim shared as TeamStruct Teams(23)          '23 Team Structures
dim shared as PlayerStruct Players(21)      '22 Players Structure
dim shared as PlayerDistanceStruct Sort(10) 'sort players array

dim as integer SINDIC,COSDIC
dim as integer SELPLAY=9,LASTSEL=0,OLDHAS=-1
dim as integer TMAFORM=4,TMBFORM=2,HASBALL=9
dim as double KEYTIME

randomize timer
' *** Set Colors ***
for CNT = 1 to 15
  PIX(CNT) = PIX(CNT-1)+&h0101010101010101
next CNT

#include "Soccer\Gfx.bas"

' *** Game Buffer ***
MYIMG = ImageCreate(128,60,,8)
SCRPTR = screenptr
BUFPTR = MYIMG+sizeof(fb.image)
IMGPTR = MYIMG+sizeof(fb.image)
line(0,0)-(255,191),13,bf
#ifndef __FB_NDS__
WindowTitle "Mysoft Soccer v1.0 beta"
#endif

' *** Loading Graphic Objects ***
ObjectLoad("Field",400,240,FILD)        'Load The field
ObjectLoad("Menu/Back",80,60,BACK)      'Load The background menu
ObjectLoad("Menu/Menu",72,53,MENU)      'Load The menu
ObjectLoad("Menu/Config",72,53,CONFIG)  'Load The menu
ObjectLoad("Menu/Cursor",21,133,CURSOR) 'Load The Cursor
ObjectLoad("Menu/Circle",23,21,CURBR1)  'Load The Cursor
ObjectLoad("Menu/Circle2",23,21,CURBR2) 'Load The Cursor
ObjectLoad("Menu/Ooff",17,5,MOFF)       'Off State
ObjectLoad("Menu/TipoA",38,5,MFIA)      'Field TYPE A
ObjectLoad("Menu/TipoB",38,5,MFIB)      'Field TYPE B
ObjectLoad("Font",7,575,FONT)           'Main Font
ObjectLoad("Trave",22,39,TRAVEA)        'Left Goal Post
ObjectLoad("Trave2",22,39,TRAVEB)       'Right Goal Post
ObjectLoad("Ball",2,10,BALL)            'Ball
ObjectLoad("Player",43,64,PLAYLF)       'Player Model Left/One/You
ObjectLoad("Player",43,64,PLAYRT)       'Player Model Right/Two/Other
ObjectLoad("Sponsors/PanLf",20,28,SPLF) 'Left Panel
ObjectLoad("Sponsors/PanRt",20,28,SPRT) 'Right Panel

' *********** Reading Team Data ****************
#include "Soccer\TeamData.bas"

' **** Team Colors *****
with *cptr(fb.image ptr,PLAYLF)
  PIXPT = PLAYLF+sizeof(fb.image)
  for CNT = 0 to (.pitch*.height)-1
    if PIXPT[CNT] = 9 then 'Team A Colors
      PIXPT[CNT] = TEAMS(TEAMA).CTSHIRT
    elseif PIXPT[CNT] = 12 then
      PIXPT[CNT] = TEAMS(TEAMA).CSHORTS
    end if
  next CNT
  PIXPT = PLAYRT+sizeof(fb.image)
  for CNT = 0 to (.pitch*.height)-1
    if PIXPT[CNT] = 9 then 'Team B Colors
      PIXPT[CNT] = TEAMS(TEAMB).CTSHIRT
    elseif PIXPT[CNT] = 12 then
      PIXPT[CNT] = TEAMS(TEAMB).CSHORTS
    end if
  next CNT
end with

' 50 - 190 (130)
' 70 - 180 (110)

' **** Generating Player Position ***
for CNT = 0 to 10
  ' *** teamA ***
  with Players(CNT)
    .X = (40+FORM(TMAFORM).POSI(CNT).BASEX)/2
    .Y = FORM(TMAFORM).POSI(CNT).BASEY-10
    .DIC = 1
    .ENERGY = 100
    .SPEED = 40+rnd*60
    .POWER = 40+rnd*60
    .SKILL = 40+rnd*60
    .MIND = 40+rnd*60  
  end with
  ' *** teamB ***
  with Players(CNT+11)
    .X = (360+(400-FORM(TMBFORM).POSI(CNT).BASEX))/2
    .Y = FORM(TMBFORM).POSI(CNT).BASEY-10
    .DIC = 0
    .ENERGY = 100
    .SPEED = 40+rnd*60
    .POWER = 40+rnd*60
    .SKILL = 40+rnd*60
    .MIND = 40+rnd*60  
  end with
next CNT
' *************** Start position ***************
for CNT = 9 to 10
  with Players(CNT)
    .X = 195-(CNT-9)*5
    .Y = 103+((CNT-9)*10)
  end with
next CNT

' ******* Loading Goal Animations *******
MYFILE = Freefile()
if open("Anim/Anims.anm" for binary access read as #MYFILE) then
  print "Failed to load animations.":sleep:end
end if
'get #MYFILE,1,ANM_GOAL()
get #MYFILE,1,*cptr(ubyte ptr,@ANM_GOAL(0,0,0)),7*101*28*8
close #MYFILE

' ******* Loading Configs ********
if open("Soccer.cfg" for binary as #MYFILE)=0 then
  get #MYFILE,1,FYTYPE
  get #MYFILE,,SFXVOL
  get #MYFILE,,MUSICVOL
  close #MYFILE  
  if FYTYPE <> 0 andalso FYTYPE <> 1 then FYTYPE = 1
  if SFXVOL < 0 orelse SFXVOL > 255 then SFXVOL = 128
  if MUSICVOL < 0 orelse MUSICVOL > 1 then MUSICVOL = .33  
else
  FYTYPE=1:SFXVOL=128:MUSICVOL=.33
end if
#ifndef __FB_NDS__
open "Soccer.cfg" for output as #MYFILE:close #MYFILE
open "Soccer.cfg" for binary as #MYFILE
put #MYFILE,1,FYTYPE
put #MYFILE,,SFXVOL
put #MYFILE,,MUSICVOL
close #MYFILE
#endif
#ifdef DoSound
FSOUND_SetVolume(FSOUND_ALL,SFXVOL)
#endif

#include "Soccer\MenuY.bas"
#include "Soccer\InPlay.bas"

' ***********************************************************************************
' **************************** SUBS AND FUNCTIONS ***********************************
' ***********************************************************************************
sub DrawString(PX as integer,PY as integer,TXT as string)
  static as integer CC,CHA
  for CC = 0 to len(TXT)-1
    CHA = TXT[CC]
    select case CHA 
    case asc("a") to asc("z")
      CHA -= asc("a")
      put MYIMG,(PX,PY),FONT,(0,CHA*6)-(5,CHA*6+5),trans
      PX += FNTSPC(CHA)
      if PX > 80 then exit for
    case asc("A") to asc("Z")
      CHA -= asc("A")
      put MYIMG,(PX,PY),FONT,(0,CHA*6)-(5,CHA*6+5),trans
      PX += FNTSPC(CHA)
      if PX > 80 then exit for
    case asc("0") to asc("9")
      CHA = CHA-asc("0")+26
      put MYIMG,(PX,PY),FONT,(0,CHA*6)-(5,CHA*6+5),trans
      PX += FNTSPC(CHA)
      if PX > 80 then exit for
    case else
      PX += 2
    end select
  next CC
end sub
