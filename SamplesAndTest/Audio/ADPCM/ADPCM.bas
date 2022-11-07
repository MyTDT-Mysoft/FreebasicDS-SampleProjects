#ifdef __FB_NDS__
#define __FB_NITRO__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
chdir "NitroFiles/"
#endif

dim as any ptr MySnd
dim as integer SndSz

dim as string files(1) = { "zelda.sox.ima","zelda.sox.ima" }

for CNT as integer = 0 to 1


if open(files(CNT) for binary access read as #1) then
  print "error"
else
  SndSz = lof(1)
  print files(CNT), SndSz\1024 & "kb ";
  MySnd = callocate(SndSz)
  get #1,,*cptr(ubyte ptr,MySnd),SndSz
  close #1
end if

dim as integer Freq = 18157

if 1 then
  cptr(short ptr,MySND)[0] = 0
  cptr(short ptr,MySND)[1] = 0
end if

print cptr(short ptr,MySND)[1]

var x = soundPlaySample(MySnd,SoundFormat_ADPCM,SndSz+4,Freq,127,64,4,4)
sleep
SoundKill(x)
deallocate(MySnd)

next CNT

print "done."
sleep