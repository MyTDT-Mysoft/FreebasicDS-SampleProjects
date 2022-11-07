type lexer_t
	__line       as zstring ptr
	__line_pos   as integer
	__line_len   as integer
	look         as integer
	token        as zstring * (MAX_TOKEN_LENGTH + 1)
	token_type   as tk_e
end type

dim shared as lexer_t lexer

declare sub lexer_init(byval s as zstring ptr)
declare sub read_char()
declare sub read_token()

sub lexer_init(byval s as zstring ptr)

	memset(@lexer, 0, sizeof(lexer))

	lexer.__line = s
	lexer.__line_pos = 0
	lexer.__line_len = strlen(s)

	read_char()
	read_token()

end sub

sub read_char()

	lexer.look = -1

	if lexer.__line_pos < lexer.__line_len then
		lexer.look = lexer.__line[lexer.__line_pos]
		lexer.__line_pos += 1
	end if

end sub

sub read_token()

	while isspace(lexer.look)
		read_char()
	wend

	if lexer.look = -1 then
		lexer.token_type = TK_EOL
		exit sub
	end if

	dim as integer tk_start = lexer.__line_pos - 1
	dim as integer tk_len = 0

	if isalpha(lexer.look) then
		while isalpha(lexer.look)
			tk_len += 1
			read_char()
		wend
		if lexer.look = asc("!") then
			tk_len += 1
			read_char()
		end if
		lexer.token_type = TK_IDENT
	elseif isdigit(lexer.look) then
		dim as integer is_single
		while isdigit(lexer.look) or lexer.look = asc(".")
			if lexer.look = asc(".") then is_single = 1
			tk_len += 1
			read_char()
		wend
		if is_single then
			lexer.token_type = TK_SINGLE
		else
			lexer.token_type = TK_INTEGER
		end if
	elseif lexer.look = asc("""") then
		tk_start += 1
		read_char()
		while (lexer.look <> -1) and (lexer.look <> asc(""""))
			tk_len += 1
			read_char()
		wend
		if lexer.look <> asc("""") then
			set_error(1)
		end if
		read_char()
		lexer.token_type = TK_STRING
	elseif lexer.look = asc("<") then
		lexer.token_type = lexer.look
		tk_len += 1
		read_char()
		if lexer.look = asc(">") then
			lexer.token_type = TK_NE
			tk_len += 1
			read_char()
		elseif lexer.look = asc("=") then
			lexer.token_type = TK_LTE
			tk_len += 1
			read_char()
		end if
	elseif lexer.look = asc(">") then
		lexer.token_type = lexer.look
		tk_len += 1
		read_char()
		if lexer.look = asc("=") then
			lexer.token_type = TK_GTE
			tk_len += 1
			read_char()
		end if
	else
		lexer.token_type = lexer.look
		tk_len += 1
		read_char()
	end if

	if tk_len > MAX_TOKEN_LENGTH then
		tk_len = MAX_TOKEN_LENGTH
	end if

	if lexer.token_type <> TK_STRING then
		for i as integer = 0 to tk_len - 1
			lexer.token[i] = toupper(int(lexer.__line[tk_start+i]))
		next i
	else
		for i as integer = 0 to tk_len - 1
			lexer.token[i] = int(lexer.__line[tk_start+i])
		next i
	end if
	lexer.token[tk_len] = 0

	'printf(!"tk: '%s'\n", token)

end sub
