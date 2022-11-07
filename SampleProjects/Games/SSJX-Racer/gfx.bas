''
'' Graphics functions
''
'' FBGD RetroComp Aug/Sept 2008 Entry by ssjx (http://ssjx.co.uk)
''

dim shared stars() as ipoint

sub ScreenUpdate()
 
  const BorderY = ((192-(60*3)))
  const BorderX = ((256-(80*3)))
  const SourcePitch = 128-80
    
  screenlock
  dim as ubyte ptr scrptr = Screenptr + ((BorderY\2)*256) + (BorderX\2)
  dim as ubyte ptr bufptr = pixptr  
  for Y as integer = 1 to 60*4    
    for X as integer = 0 to 79
      scrptr[0] = *bufptr: scrptr[1] = *bufptr: scrptr[2] = *bufptr
      scrptr += 3: bufptr += 1
    next X
    scrptr += borderx
    if (Y and 3)=0 then bufptr += (128-80): Y += 1 else bufptr -= 80
  next Y
  screenunlock
  
end sub

sub block(x as integer,y as integer,c as integer)
	
	'' few quick exit checks
	if c<0 then return
	'if x<0 or x>79 then return
	'if y<0 or y>59 then return
	PixPtr[(y shl 7)+x] = c
		
end sub

sub square(x as integer,y as integer,w as integer,c as integer)

for j as integer=0 to w-1
	block(x,y+j,c)
	block(x+(w-1),y+j,c)

	block(x+j,y,c)
	block(x+j,y+(w-1),c)

next j	

end sub

'' draw big sprites
sub draw_sprite(x as integer, y as integer, spr() as short)

	for j as integer=0 to 7
		for i as integer=0 to 7
		block(x+i,y+j, spr(i,j)) ''
		next i
	next j

end sub

'' draw scale sprites
sub draw_halfsprite(x as integer, y as integer, spr() as short)
dim as integer sx,sy

sx=x+2
sy=y+4

	for j as integer=0 to 3 
		for i as integer=0 to 3
		block(sx+i,sy+j,spr(i*2,j*2)) ''
		next i
	next j

end sub


''
'' Shows giant text A-Z 0-9 only
''

sub blockprint(x as integer, y as integer,text as string, spr() as short ,col as integer)
	dim as integer i,value=0
	
	text=ucase(text)
	
	for l as integer=1 to len(text)
	value= text[l-1]
	
	'' space
	if value=32 then x+=8
	
	'' show a letter
	if value>64 then
	
		value-=65
		if value>=0 and value<26 then
		
			for j as integer=0 to 7
			for i as integer=0 to 7
			
			if spr((value*8)+i,j)<>-1 then
			block(x+i,y+j, col) ''
			end if
			
			next i
		next j
		
		x+=8
		end if
	end if
	
	'' number
	if value>47 and value<58 then
	
		value-=48
		
		if value>=0 and value<26 then
		
		value+=26
			for j as integer=0 to 7
			for i as integer=0 to 7
			'block(x+i,y+j, spr((value*8)+i,j)) ''
		
			if spr((value*8)+i,j)<>-1 then
			block(x+i,y+j, col) ''
			end if
			
			next i
		next j
		
		x+=8
		end if
	end if
	next l

end sub

''
'' Horizontal row of blocks
''
sub hblock(x as integer,x1 as integer,y as integer,c as integer)
	
	
	if x<0 then x=0
	if x1<0 then x1=0
	
	if x>x1 then swap x,x1
	
	
	for h as integer=x to x1
	block(h,y,c)
	next h
	
'	color 15
'	line (x,y)-(x+7,y+7),,b
	
end sub

''
'' Horizontal row of blocks (alternating colours)
''
sub hblock2(x as integer,x1 as integer,y as integer,c1 as integer,c2 as integer)
	
if (y and 1)=1 then swap c1,c2

	if x<0 then x=0
	if x1<0 then x1=0
	
	if x>x1 then swap x,x1
	
	
	for h as integer=x to x1 step 2
	block(h,y,c1)
	block(h+1,y,c2)
	
	next h
	
'	color 15
'	line (x,y)-(x+7,y+7),,b
	
end sub


''
'' Simple sky
''

sub draw_sky(num as integer)
dim as integer top,middle,bottom


select case as const num
case 0:
	''dawn
	top=4
	middle=12
	bottom=14
case 1:	
	''day
	top=1
	middle=3
	bottom=11
case 2:
	''night
	top=1
	middle=0
	bottom=8

case else:
	''day
	top=1
	middle=3
	bottom=11	

end select

	for j as integer =0 to 7
	hblock(0,79,j,top)
	next j

	for j as integer =8 to 16 ''6
	hblock(0,79,j,middle)
	next j
			
	for j as integer =17 to 29 ''13
	hblock(0,79,j,bottom)
	next j
	
	'' put a blend between the sky colours
	hblock2(0,79,7,top,middle)
	hblock2(0,79,8,top,middle)
	
	hblock2(0,79,16,middle,bottom)
	hblock2(0,79,17,middle,bottom)	
	
		
	'' night time - add some stars
	if num=2 then
		for i as integer=0 to STARCOUNT
		with stars(i)
		block(.x,.y,14)
		end with
		next i
	end if
	
	
end sub

''
'' Draw main road and barrier (ground value is ignored at the moment)
''

sub draw_tunnel(stp as integer,skycol as integer,roadtype as integer)
	dim as integer i,j,w=29,cx,cc,d=0,dmax=2
	dim as integer c ''5
	dim as integer grass=2
	dim as integer nw,nwc
	
	dim as integer roadcol,c1,c2
	
	'' stripe colors	
	select case as const roadtype
	case 0:	
		''red and magenta (default)
		c1=5
		c2=4
	case 1:	
		''grassy
		c1=6
		c2=7 ''

	case 2:	
		''normal road
		c1=3
		c2=1
		
	end select 
	
	
	
	if stp=1 then
	 
		swap c1,c2
		'' move grass	
		if stp=1 then grass=10
	
	end if
	
	roadcol=c1
	
	
	draw_sky(skycol)
	
	'' set road widths (should really take out...)
	dim as integer wid(30)
	for i=0 to 29 	
		wid(i)=30+int( (49*i)/29 )
	next i
	
	''	

	
	''draw road
	for j=30 to 59

		cx=(80-wid(j-30))/2 '(80-w)/2
		
		cc=0
		c=roadcol
		nw=wid(j-30)
		nwc=6
	
	
		''side walls
				
		for h as integer=25+dmax to 59
		hblock(0,cx,h,c)
		hblock(cx+wid(j-30),79,h,c)
		next h
		
		''grass
		hblock(0,cx,25+dmax,grass)
		hblock(cx+wid(j-30),79,25+dmax,grass)
		if grass=2 then grass=10 else grass=2
		
		'' ''center road
		for i=0 to wid(j-30)
			
			block(cx+i,j,c)
			
			''get blocks spaced properly
			cc+=1
			if cc=int(nw/nwc) then 
				nw-=cc
				nwc-=1
				cc=0
				if c>7 then c-=8 else c+=8
			end if
			
		next i	
		
		''road edge
		block(cx,j,0)
		block(cx+wid(j-30),j,0)
		
		'change stripe colour	
		d+=1
		if d=dmax then
			d=0
			if roadcol=c1 then roadcol=c2 else roadcol=c1
			c=roadcol
			dmax+=1
		end if
		
	next j

end sub

''
'' EGA Testing...
''

sub stripeclr()
	dim as integer c=0
	for j as integer=0 to 59
		for i as integer=0 to 79
		
				block(i,j,c)		
				c+=1
				if c>15 then c=0
		
		
		next i
	next j
end sub
