dim shared as integer cursor_x, cursor_y
dim shared as string cc
cc = " "

sub io_flip()
  
  #ifndef __FB_NDS__
	screenlock
		dim as pixel ptr scr_p = cast(any ptr,screenptr)
		dim as pixel ptr buf_p = cast(any ptr,@buffer[1])

		for y as integer = 0 to 191
			for x as integer = 0 to 255
				'pset (x, y), point(x \ 2, y \ 2, buffer)
				scr_p[x*2]     = buf_p[x] : scr_p[x*2+1]   = buf_p[x]
				scr_p[x*2+512] = buf_p[x] : scr_p[x*2+513] = buf_p[x]
			next x
			scr_p += 1024 : buf_p += 256
		next y
	screenunlock
  #endif

end sub

sub io_scrollup()

	put buffer,(0,-8),buffer,pset
	cursor_y -= 8
	line buffer, (0, 184)-(255, 191), 0, BF

	io_flip()

end sub

sub io_newline()

	cursor_x = 0
	cursor_y += 8

	if cursor_y = 192 then
		io_scrollup()
	end if

end sub

sub io_printc(byval c as integer, DoFlip as integer=1)

	cc[0] = c '(no chr)
	line buffer,(cursor_x,cursor_y)-(cursor_x+7,cursor_y+7),0,bf
	draw string buffer, (cursor_x, cursor_y), cc,-1
	'locate (cursor_y\8)+1,(cursor_x\8)+1: printf cc
	cursor_x += 8
	if cursor_x >= 256 then
		io_newline()
	end if

	if DoFlip then io_flip()

end sub

sub io_printstr(byref s as string, iNextLine as integer = 1)

	for i as integer = 0 to len(s) - 1
		io_printc(s[i],0)
	next i
	io_flip()

	if iNextLine then
		io_newline()
	end if

end sub

sub io_printint(byval n as integer)

	dim as string temp = "" & n

	io_printstr(temp)

end sub

sub io_printsng(byval n as single)

	dim as string temp = "" & n

	io_printstr(temp)

end sub

sub io_swapcursor()
  if cursor_x > (256-8) then exit sub
  if cursor_y > (192-8) then exit sub
  var p = cast(pixel ptr,buffer+1)+((cursor_y+7)*256)+cursor_x
  for CNT as integer = 0 to 7
    p[CNT] xor= &h7FFF
  next CNT
end sub

sub io_inputstr(byval prompt as zstring ptr, byval keybuff as zstring ptr, byval max_len as integer)
	
	dim as integer buffer_pos = 0
  dim as double fBlink = timer
  dim as integer iBlink

	io_printc(int(prompt[0]))

	while buffer_pos < max_len
		dim as string k = inkey()
    if abs(timer-fBlink) > 1/3 then
      io_swapcursor()
      iBlink xor= 1: fBlink = timer
      io_flip()
    end if
    if len(k) then      
      var iChar = cuint(k[0])
      if iChar = 255 then ichar += k[1]      
      select case ichar
      case 255+asc("k")
        end
      case 8  'backspace
        if buffer_pos > 0 then
          if iBlink then io_swapcursor()
          cursor_x -= 8
          if cursor_x < 0 then 
            cursor_x += 256: cursor_y -= 8
          end if
          buffer_pos -= 1          
          line buffer,(cursor_x,cursor_y)-(cursor_x+7,cursor_y+7),0,bf
          if iBlink then io_swapcursor()
          io_flip()
        end if
      case 13 'return
        if iBlink then io_swapcursor()
        io_flip()
        exit while
      case 1 to 254      
        keybuff[buffer_pos] = k[0]
        buffer_pos += 1
        if iBlink then io_swapcursor()
        io_printc(k[0],0)
        if iBlink then io_swapcursor()
        io_flip()
      end select      
		end if    
		sleep 1, 1
	wend

	keybuff[buffer_pos] = 0

	io_newline()

end sub

function io_inputnum(byval prompt as zstring ptr) as integer
	
	dim as zstring * 1025 buffer

	io_inputstr(prompt, buffer, 1024)

	function = val(buffer)

end function

sub io_screenopen()

	#ifdef __FB_NDS__
  screenres 256, 192, ScreenBPP  
  #else
  screenres 512, 384, ScreenBPP
  #endif
  
  #if ScreenBPP = 8
  dim as integer CNT
  for R as integer = 0 to 7
    for G as integer = 0 to 7
      for B as integer = 0 to 3
        palette CNT,(255/7)*R,(255/7)*G,(255/3)*B
        CNT += 1
      next B
    next G
  next R
  #endif

  #ifdef __FB_NDS__
  fb_ShowKeyboard()
  fb.KeyboardIsON = 1
  lcdMainOnTop()  
  buffer = gfx.Scr
  #else
  buffer = imagecreate(256, 192)
  #endif

  line buffer, (0, 0)-(255, 191), 0, BF  

end sub

sub io_screenclose()

	imagedestroy(buffer)

end sub

sub io_load(byref fname as string)

	dim as FILE ptr hFile = fopen(fname & ".bas", "rb")
	
	if hFile then
		while feof(hFile) = 0
			dim as zstring * 1024 buffer
			fgets(buffer, 1024, hFile)
			if strlen(buffer) > 0 then
				if buffer[strlen(buffer) - 1] = 10 then
					buffer[strlen(buffer) - 1] = 0
				end if
			end if
			if strlen(buffer) > 0 then
				if buffer[strlen(buffer) - 1] = 13 then
					buffer[strlen(buffer) - 1] = 0
				end if
			end if
			if strlen(buffer) > 0 then
				parse(buffer)
			end if
		wend
		
		fclose(hFile)
	else
		io_printstr("Could not open file " & fname & ".bas")
	end if

end sub

sub line_walk(byval ln as line_t ptr, byval hFile as FILE ptr)

	if ln = NULL then exit sub

	line_walk(ln->l, hFile)
	fprintf(hFile, !"%s\n", strptr(ln->text))
	line_walk(ln->r, hFile)

end sub

sub io_save(byref fname as string)

	dim as FILE ptr hFile = fopen(fname & ".bas", "wb")
	
	if hFile then
		line_walk(__lines.root, hFile)
		fclose(hFile)
	else
		io_printstr("Could not open file " & fname & ".bas")
	end if

end sub

sub io_pset(byval x as integer, byval y as integer, byval c as integer)
	
	if cuint(x) >= 256 then exit sub
	if cuint(y) >= 192 then exit sub

  #if ScreenBPP = 8
  c = ((c and &h0000C0) shr 6) _
   or ((c and &h00E000) shr 11) _ 
   or ((c and &HE00000) shr 16)
  #elseif ScreenBPP = 16
  #ifdef __FB_NDS__
  c = ((c and &h0000F8) shl 7) _
   or ((c and &h00F800) shr 6) _ 
   or ((c and &HF80000) shr 19) or &h8000 
   #else
   c = ((c and &h0000F8) shr 3) _
   or ((c and &h00FC00) shr 5) _ 
   or ((c and &Hf80000) shr 8)
   #endif
  #endif
  
  cast(pixel ptr,buffer+1)[y*256+x] = c  

end sub