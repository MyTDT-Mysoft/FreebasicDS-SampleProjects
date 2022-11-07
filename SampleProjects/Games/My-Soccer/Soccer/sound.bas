enum GameSounds
  gsExplode = 0
  gsApito
  gsBatuque
  gsBatuque2
  gsBerro
  gsBerro2
  gsCarrinho
  gsChute
  gsCorneta
  gsCrowd
  gsCrowd2
  gsCrowd3
  gsCrowd4
  gsDividida
  gsFimDeJogo
  gsFora
  gsNaTrave
  gsNaTrave2
  gsPasse
  gsTorcida
  gsFinal
end enum

#ifdef DoSound

#ifndef __FB_NDS__
#include once "fmod.bi"
#endif

#define SoundPlay(SOUNDID) FSOUND_PlaySound(FSOUND_FREE,SOUNDS(SOUNDID))
#define SoundMode(SOUNDID,MODE) FSOUND_Sample_SetMode(SOUNDS(SOUNDID),MODE)
#define SoundLoop(SID,STLP,EDLP) FSOUND_Sample_SetLoopPoints(SOUNDS(SID),STLP,EDLP)
#define SoundStop(CHANID) FSOUND_StopSound(CHANID)
#define IsPlaying(CHANID) FSOUND_IsPlaying(CHANID)

'print FSOUND_SetOutput(FSOUND_OUTPUT_DSOUND)
if FSOUND_Init(44100, 32, FSOUND_INIT_USEDEFAULTMIDISYNTH) = 0 then
  Print #99,"Erro Ao iniciar o FMOD"
  sleep 3000:end
end if
#endif

#ifdef DoSound
dim as FMUSIC_MODULE ptr ATUSONG,MENUSONG,CFGSONG,INGAME(5)
dim shared as Fsound_Sample ptr SOUNDS(gsFinal)
#endif
dim shared as double MUSICVOL,SFXVOL
dim shared as integer INGAMEPLAYING

#ifdef DoSound
MENUSONG = FMUSIC_LoadSong("music\xm\MainMenu.xm")':if MENUSONG = 0 then end
CFGSONG = FMUSIC_LoadSong("music\xm\OptionsMenu.xm")':if CFGSONG = 0 then end
INGAME(0) = FMUSIC_LoadSong("music\xm\InPlaying1.xm")':if INGAME(0) = 0 then end
INGAME(1) = FMUSIC_LoadSong("music\xm\InPlaying2.xm")':if INGAME(1) = 0 then end
INGAME(2) = FMUSIC_LoadSong("music\xm\InPlaying3.xm")':if INGAME(2) = 0 then end
INGAME(3) = FMUSIC_LoadSong("music\xm\InPlaying4.xm")':if INGAME(3) = 0 then end
INGAME(4) = FMUSIC_LoadSong("music\xm\InPlaying5.xm")':if INGAME(4) = 0 then end
INGAME(5) = FMUSIC_LoadSong("music\xm\InPlaying6.xm")':if INGAME(5) = 0 then end

#define SoundLoad(SoundName,LoopType) FSOUND_Sample_Load(FSOUND_FREE,"Sounds/" SoundName,LoopType,0,0): printf(SoundName !"\n")
SOUNDS(gsExplode)   = SoundLoad("Explode.wav"  ,FSOUND_LOOP_OFF   )
SOUNDS(gsApito)     = SoundLoad("Apito.wav"    ,FSOUND_LOOP_OFF   )
SOUNDS(gsBatuque)   = SoundLoad("Batuque.wav"  ,FSOUND_LOOP_NORMAL)
SOUNDS(gsBatuque2)  = SoundLoad("Batuque2.wav" ,FSOUND_LOOP_NORMAL)
SOUNDS(gsBerro)     = SoundLoad("Berro.wav"    ,FSOUND_LOOP_OFF   )
SOUNDS(gsBerro2)    = SoundLoad("Berro2.wav"   ,FSOUND_LOOP_OFF   )
SOUNDS(gsCarrinho)  = SoundLoad("Carrinho.wav" ,FSOUND_LOOP_OFF   )
SOUNDS(gsChute)     = SoundLoad("Chute.wav"    ,FSOUND_LOOP_OFF   )
SOUNDS(gsCorneta)   = SoundLoad("Corneta.wav"  ,FSOUND_LOOP_OFF   )
SOUNDS(gsCrowd)     = SoundLoad("Crowd.wav"    ,FSOUND_LOOP_NORMAL)
SOUNDS(gsCrowd2)    = SoundLoad("Crowd2.wav"   ,FSOUND_LOOP_NORMAL)
SOUNDS(gsCrowd3)    = SoundLoad("Crowd3.wav"   ,FSOUND_LOOP_NORMAL)
SOUNDS(gsCrowd4)    = SoundLoad("Crowd4.wav"   ,FSOUND_LOOP_NORMAL)
SOUNDS(gsDividida)  = SoundLoad("Dividida.wav" ,FSOUND_LOOP_OFF   )
SOUNDS(gsFimDeJogo) = SoundLoad("FimDeJogo.wav",FSOUND_LOOP_OFF   )
SOUNDS(gsFora)      = SoundLoad("Fora.wav"     ,FSOUND_LOOP_OFF   )
SOUNDS(gsNaTrave)   = SoundLoad("NaTrave.wav"  ,FSOUND_LOOP_OFF   )
SOUNDS(gsNaTrave2)  = SoundLoad("NaTrave2.wav" ,FSOUND_LOOP_OFF   )
SOUNDS(gsPasse)     = SoundLoad("Passe.wav"    ,FSOUND_LOOP_OFF   )
SOUNDS(gsTorcida)   = SoundLoad("Torcida.wav"  ,FSOUND_LOOP_NORMAL)
#endif