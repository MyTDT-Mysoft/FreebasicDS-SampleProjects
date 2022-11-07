#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  '#define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  '#define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"  
#else
  #include "fbgfx.bi"
  #include "MyTDT\GfxResize.bas"
  chdir "NitroFiles/"
#endif

dim as integer nMouseButton
dim as integer nMouseX, nMouseY
dim as byte nPuzzle(0 to 15)
dim as long nRealX, nRealY
dim as long nSelected
dim as long nMoves
dim as double dTimer
dim as byte bRedraw = true
dim as byte bSolved

'for the whole image
dim as any ptr img, img2
const TS = 48
'
'initialize a simple gfx screen
#ifndef __FB_NDS__
using FB
gfx.PreResize()
screenres 256, 192, 16, , (GFX_WINDOWED or GFX_NO_SWITCH)
gfx.Resize(256*2, 192*2)
#else
screenres 256, 192, 16
#endif
windowtitle "Hatsune Miku"
'
dTimer = timer

puts("Any key to Start.")
sleep
randomize()
'init and load the image
img = imagecreate(192, 192)

'count how many images are there
var sFile = dir("*.bmp"), iImgCnt = 0
while len(sFile) : iImgCnt += 1 : sFile = dir() : wend 
bload (cint(int(rnd*iImgCnt))+1) & ".bmp", img

' init our puzzle indexed (15 tiles sorted, last is free)
dim as long i
for i = 0 to 15
	nPuzzle(i) = i+1
next
for i = 0 to 15
  swap nPuzzle(i),nPuzzle(int(rnd*15))
next i

scope 'process image
  img2 = imagecreate(64,64)
  var temp = ImageCreate(192,192)
  for iX as long = 0 to (192\3)-1
    put temp, (iX,0), img, (iX*3+0,0)-(iX*3+0,191), pset
    #ifndef __FB_NDS__
    put temp, (iX,0), img, (iX*3+1,0)-(iX*3+1,191), alpha,128 'to get 33% of each image
    put temp, (iX,0), img, (iX*3+2,0)-(iX*3+2,191), alpha,85
    #endif
  next iX
  for iY as long = 0 to (192\3)-1
    put img2, (0,iY), temp, (0,iY*3+0)-(63,iY*3+0), pset
    #ifndef __FB_NDS__
    put img2, (0,iY), temp, (0,iY*3+1)-(63,iY*3+1), alpha,128 'to get 33% of each image
    put img2, (0,iY), temp, (0,iY*3+2)-(63,iY*3+2), alpha,85
    #endif
  next iY 
  line temp,(0,0)-(191,191),0,bf
  'draw border lines
  for i as long = 0 to 192 step 48
    if i=192 then i=191
    put img,(0,i),temp, (0,0)-(191,0),pset 'alpha,128
    put img,(i,0),temp, (0,0)-(0,191),pset 'alpha,128
    'line img, (0,i)-(191,i),0
    'line img, (i,0)-(i,191),0
  next i
  ImageDestroy( temp )  
end scope

'line img, (0,0)-(191,191),0,b
line(0,0)-(255,191),rgb(32,64,128),bf
put (0,0),img,pset
put (193,0),img2,pset

'helper vars to positionize our tiles
dim as long nGridX, nGridY
'
' main game!
while not (bSolved)
  '
	if inkey = Chr(255, asc("k")) then exit while
	getmouse (nMouseX, nMouseY,, nMouseButton)
  '
  'get real position (which tile we are on)
	nRealX = nMouseX\TS 'int(nMouseX/64)
	nRealY = nMouseY\TS 'int(nMouseY/64)
  '
	'check for out of boundaries
	if nRealX < 0 then nRealX = 0
	if nRealX > 3 then nRealX = 3
	if nRealY < 0 then nRealY = 0
	if nRealY > 3 then nRealY = 3
	'
	if nMouseButton = 1 then
		bRedraw = true
    'store our selected tile
		nSelected = nPuzzle(nRealY*4+nRealX)
    '
		'if clicked on a tile which is not the empty space then
		if nSelected < 16 then
			'check if selected tile can be moved
			'
			'check for down swapping
			if nRealY < 3 andalso nPuzzle((nRealY+1)*4+nRealX) = 16 then
				nPuzzle(nRealY*4+nRealX)=16
				nPuzzle((nRealY+1)*4+nRealX) = nSelected
				nMoves +=1
			'check for up swapping
			elseif nRealY > 0 andalso nPuzzle((nRealY-1)*4+nRealX) = 16 then
				nPuzzle(nRealY*4+nRealX)=16
				nPuzzle((nRealY-1)*4+nRealX) = nSelected
				nMoves +=1
			'check for left swapping
			elseif nRealX < 3 andalso nPuzzle(nRealY*4+nRealX+1) = 16 then
				nPuzzle(nRealY*4+nRealX)=16
				nPuzzle(nRealY*4+nRealX+1)= nSelected
				nMoves +=1
			'check for right swapping
			elseif nRealX > 0 andalso nPuzzle(nRealY*4+nRealX-1) = 16 then
				nPuzzle(nRealY*4+nRealX)=16
				nPuzzle(nRealY*4+nRealX-1)= nSelected
				nMoves +=1
			'nothing to do
			else
				bRedraw = false
			end if
		end if
		'
	end if
	'
	' draw the updated gamefield
	if bRedraw then
    
    bRedraw = false
		' check if player has solved the puzzle
		bSolved = true
    for i = 1 to 15			
			if nPuzzle(i-1) <> i then bSolved = false: exit for
		next
		'if bSolved and (nPuzzle(15)<>16) then bSolved = false ''useless???
    
		screenlock
		'cls
    '
		    
    #if 0
    i = 0
		for nGridY = 1 to 4
			for nGridX = 1 to 4
				line(-TS+nGridX*TS, -TS+nGridY*TS)-(nGridX*TS,nGridY*TS), nPuzzle(i), bf
				color 0, nPuzzle(i)
				locate -2+(nGridY*(TS\4))\2, -4+(nGridX*(TS\4))\2
				print nPuzzle(i)
				i += 1
			next
		next
    #endif    
    for nGridY = 0 to 3
			for nGridX = 0 to 3
        var nTile = nPuzzle(nGridY*4+nGridX) 
        if bSolved=false andalso nTile < 16 then
          var iX = (nTile\4)*48 , iY = (nTile mod 4)*48
          put ( nGridX*48 , nGridY*48 ), img , (iX,iY)-(iX+47,iY+47), pset
        else
          line ( nGridX*48 , nGridY*48 )-( nGridX*48+47 , nGridY*48+47 ) , rgb(0,0,64) ,bf
        end if
      next 
    next
    
		screenunlock
		
    '
	end if
	'
	sleep 15, 1
	'
wend

if bsolved then
  '
  'there we go, finished the game...
  dim dEndTimer as double = timer
  line (16,32)-(240,192), 0, bf
  while (1)
    if inkey = Chr(255, 107) then exit while
    line (16,32)-(240,192-32),int(rnd*15)+1,b
    line (17,33)-(239,191-32),int(rnd*15)+1,b
    line (18,34)-(238,190-32),int(rnd*15)+1,b
    locate 10, 8
    color int(rnd*15)+1
    print "Y O U   W I N ! ! !"
    locate 13, 7
    print "Needed";int(dEndTimer-dTimer);" seconds to"
    locate 15,9
    print "finish and made"
    locate 17,12
    print nMoves;" moves."
    sleep 15, 1
  wend
end if

'clean up
imagedestroy img
end
