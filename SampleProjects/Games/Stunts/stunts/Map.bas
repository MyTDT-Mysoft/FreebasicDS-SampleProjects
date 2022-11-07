#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
chdir "NitroFiles/"
open cons for output as #99
#define debugout 99
#endif

#ifdef __FB_NDS__
const ResX = 256, ResY = 192
#else
const ResX = (30*16), ResY = (30*16)
#endif

screenres ResX,ResY '(30*16),(30*16)

dim shared as ubyte Track(29,29)
dim shared as ubyte Terrain(29,29)
dim shared as byte Horizon

dim shared as any ptr MapImg,TileMap
dim as integer MapList = freefile()

TileMap = ImageCreate(512,512)
MapImg = ImageCreate(480,480)

bload "Graph/TileMap.bmp",TileMap

dim as string TrackFile 
open "Tracks.txt" for input as #MapList

dim as integer PosX,PosY

do
  
  line input #MapList, TrackFile
  if len(TrackFile) < 3 then exit do
  
  'for TrackNum as integer = 1 to 1
  dim as string Numb
  'if TrackNum < 10 then Numb = "0" & TrackNum else Numb = "" & TrackNum
  dim as integer MapFile = freefile()
  
  Numb = "Map/"+TrackFile  
  #ifdef __FB_NDS__  
  print Numb
  #else
  WindowTitle(Numb)
  #endif
  
  if open(Numb for binary access read as #MapFile) = 0 then  
    if Lof(MapFile) < 1826  then
      Horizon = 1
    else
      get #Mapfile,24,Horizon
      if Horizon = 0 then Horizon = 27 else Horizon = 25  
    end if
    
    Get #MapFile,Horizon,Track(0,0),30*30
    Get #MapFile,,Horizon
    Get #MapFile,,Terrain(0,0),30*30
    close #MapFile
    dim as uinteger XS,YS
    dim as double TMR=timer
    dim as integer FPS
    
    scope
      dim as integer PX,PY,TX,TY,Obj,Map
      dim as ubyte ptr pTerrain = @Terrain(29,29)
      dim as ubyte ptr pTrack = @Track(0,29)
      for Y as integer = 0 to 29
        PY = (29-Y) shl 4
        for X as integer = 29 to 0 step -1          
          Obj = *pTrack 'Track(Y,X)
          Map = *pTerrain+224 'Terrain(29-Y,X)
          PX = X shl 4: TX = (Map and 15) shl 5:  TY = (Map shr 4) shl 5
          put MapImg,(PX,PY),TileMap,(TX,TY)-(TX+15,TY+15),pset        
          if Obj < &hFD then
            XS = 15:if X < 29 then if pTrack[1] = &hFF then XS += 16
            YS = 15:if Y > 0 then if pTrack[-30] = &hFE then YS += 16
            if Obj > 0 then
              TX = (Obj and 15) shl 5: TY = (Obj shr 4) shl 5
              put MapImg,(PX,PY),TileMap,(TX,TY)-(TX+XS,TY+YS),trans
            end if
          end if          
          pTrack -= 1: pTerrain -= 1
        next X
        pTrack += 60
      next Y 
    end scope    
    
    do
      if (timer-TMR) >= 1 then
        TMR = timer
        print FPS: FPS = 0
      end if
      FPS += 1
      screenlock 
      put(-Posx and (not 15),-Posy and (not 15)),MapImg,pset      
      #ifdef __FB_NDS__
      screensync
      #else
      sleep 1,1
      #endif      
      screenunlock
      scope      
        static as integer MX,MY,MB,LX,LY,LB
        dim as integer NX,NY,NB
        getmouse NX,NY,,NB
        if NB <> -1 then MX = NX:MY = NY: MB = NB
        if MB then
          if LB = 0 then
            LB = 1: LX = MX: LY = MY
          else
            PosX += LX-MX: PosY += LY-MY: LX = MX: LY = MY
            if PosX < 0 then PosX = 0 else if PosX > 224 then PosX = 224
            if PosY < 0 then PosY = 0 else if PosY > 288 then PosY = 288
          end if
        else
          LB = 0
        end if             
        dim as string Key = inkey$
        if len(Key) then
          #ifdef __FB_NDS__
          if Key[1] = fb.sc_ButtonA then exit do
          #else
          exit do
          #endif
        end if
        
      end scope      
    loop
    
  end if
  
loop
