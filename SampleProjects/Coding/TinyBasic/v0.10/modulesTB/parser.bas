function strdup(byval s as zstring ptr) as zstring ptr

	dim as zstring ptr result = callocate(strlen(s) + 1)

	strcpy(result, s)

	function = result

end function

sub parse_print()

	do
		if lexer.token_type = TK_STRING then
			emit(OP_PRINTS, cast(integer, strdup(lexer.token)))
			read_token()
		else
			dim as expr_t ptr e = parse_expression()
			emit_expression(e)
			if e->dt = DT_INTEGER then
				emit(OP_PRINT_SI)
			elseif e->dt = DT_SINGLE then
				emit(OP_PRINT_SF)
			else
				puts("hjhkfjsdhkdf")
				end 1
			end if
			expr_free(e)
		end if
		if lexer.token_type <> asc(",") then exit do
		read_token()
	loop

end sub

sub parse_load()

	if lexer.token_type <> TK_STRING then
		set_error(1)
		exit sub
	end if

	emit(OP_LOAD, cast(integer, strdup(lexer.token)))
	read_token()

end sub

sub parse_save()

	if lexer.token_type <> TK_STRING then
		set_error(1)
		exit sub
	end if

	emit(OP_SAVE, cast(integer, strdup(lexer.token)))
	read_token()

end sub

'   var-list ::= var (, var)*
sub parse_input()

	do
		if lexer.token_type = TK_IDENT then
			emit(OP_INPUT, lexer.token[0] - asc("A"))
			read_token()
		else
			set_error(4)
		end if
		if lexer.token_type <> asc(",") then exit do
		read_token()
	loop

end sub

declare sub parse_statement()

' IF expression relop expression THEN statement
sub parse_if()

	dim as expr_t ptr e1 = parse_expression()
	dim as integer op = lexer.token_type
	read_token()
	dim as expr_t ptr e2 = parse_expression()

	emit_expression(e1)
	emit_expression(e2)

	dim as integer dt = e1->dt

	if dt = DT_INTEGER then
		select case op
			case asc("<"):emit(OP_LT_SI_SI)
			case asc(">"):emit(OP_GT_SI_SI)
			case asc("="):emit(OP_EQ_SI_SI)
			case TK_NE   :emit(OP_NE_SI_SI)
			case TK_GTE  :emit(OP_GTE_SI_SI)
			case TK_LTE  :emit(OP_LTE_SI_SI)
			case else    :set_error(7)
		end select
	elseif dt = DT_SINGLE then
		select case op
			case asc("<"):emit(OP_LT_SF_SF)
			case asc(">"):emit(OP_GT_SF_SF)
			case asc("="):emit(OP_EQ_SF_SF)
			case TK_NE   :emit(OP_NE_SF_SF)
			case TK_GTE  :emit(OP_GTE_SF_SF)
			case TK_LTE  :emit(OP_LTE_SF_SF)
			case else    :set_error(7)
		end select
	else
		puts "9850945"
		end 1
	end if

	expr_free(e1)
	expr_free(e2)

	if lexer.token_type <> TK_IDENT then
		set_error(6)
	end if

	if *cast(uinteger ptr, @lexer.token[0]) <> cvi("THEN") then
		set_error(6)
	end if

	' these always return an integer...
	'if dt = DT_INTEGER then
		emit(OP_THEN_SI)
	'elseif dt = DT_SINGLE then
	'	emit(OP_THEN_SF)
	'else
	''	puts "89439525"
	'	end 1
	'end if

	read_token()

	parse_statement()

end sub

' LET var = expression
sub parse_let()

	if lexer.token_type <> TK_IDENT then
		set_error(4)
	end if

	dim as integer v = toupper(lexer.token[0]) - asc("A")
	dim as integer is_single = right(lexer.token, 1) = "!"

	read_token()

	if lexer.token_type <> asc("=") then
		set_error(5)
	end if

	read_token()

	dim as expr_t ptr e = parse_expression()

	if (e->_type = EXPR_BOP) then
		if (e->l->_type = EXPR_VAR) and (e->l->n = v) then
			if (e->op = OP_ADD_SF_SF) and (e->r->_type = EXPR_SNG) then
				dim as single temp = e->r->f
				emit(OP_SELFADD_VF_CF, v, , *cast(integer ptr, @temp))
				exit sub
			elseif (e->op = OP_ADD_SI_SI) and (e->r->_type = EXPR_INT) then
				emit(OP_SELFADD_VI_CI, v, , e->r->n)
				exit sub
			end if
		end if
	end if

	if is_single then
		if e->_type = EXPR_SNG then
			dim as integer q = *cast(integer ptr, @e->f)
			emit(OP_LET_SF_CF, v, , q)
		else
			emit_expression(e)
			if e->dt = DT_INTEGER then
				emit(OP_CONV_SI_SF)
			end if
			emit(OP_LET_SF, v)
		end if
	else
		if e->_type = EXPR_INT then
			emit(OP_LET_SI_CI, v, , e->n)
		else
			emit_expression(e)
			if e->dt = DT_SINGLE then
				emit(OP_CONV_SF_SI)
			end if
			emit(OP_LET_SI, v)
		end if
	end if

	expr_free(e)

end sub

sub parse_pset()

	dim as expr_t ptr e = parse_expression()
	emit_expression(e)
	expr_free(e)
	if lexer.token_type <> asc(",") then
		set_error(10)
	end if
	read_token()

	e = parse_expression()
	emit_expression(e)
	expr_free(e)
	if lexer.token_type <> asc(",") then
		set_error(10)
	end if
	read_token()

	e = parse_expression()
	emit_expression(e)
	expr_free(e)

	emit(OP_PSET)

end sub

'   statement ::= PRINT expr-list
'                 IF expression relop expression THEN statement
'                 GOTO expression
'                 INPUT var-list
'                 LET var = expression
'                 GOSUB expression
'                 RETURN
'                 CLEAR
'                 LIST
'                 RUN
'                 END
sub parse_statement()

	dim as zstring * 32 keyword

	do
		strcpy(@keyword[0], @lexer.token[0])
	
		read_token()
	
		if strcmp(@keyword[0], "PRINT") = 0 then
			parse_print()
		elseif strcmp(@keyword[0], "LOAD") = 0 then
			parse_load()
		elseif strcmp(@keyword[0], "SAVE") = 0 then
			parse_save()
		elseif strcmp(@keyword[0], "IF") = 0 then
			parse_if()
		elseif strcmp(@keyword[0], "GOTO") = 0 then
			if lexer.token_type = TK_INTEGER then
				emit(OP_GOTO_CONST, valint(lexer.token))
				read_token()
			else
				dim as expr_t ptr e = parse_expression()
				emit_expression(e)
				expr_free(e)
				emit(OP_GOTO_SI)
			end if
		elseif strcmp(@keyword[0], "INPUT") = 0 then
			parse_input()
		elseif strcmp(@keyword[0], "LET") = 0 then
			parse_let()
		elseif strcmp(@keyword[0], "GOSUB") = 0 then
			dim as expr_t ptr e = parse_expression()
			emit_expression(e)
			expr_free(e)
			emit(OP_GOSUB_SI)
		elseif strcmp(@keyword[0], "RETURN") = 0 then
			emit(OP_RETURN_SI)
		elseif strcmp(@keyword[0], "CLEAR") = 0 then
			emit(OP_CLEAR)
		elseif strcmp(@keyword[0], "NEW") = 0 then
			emit(OP_NEW)
		elseif strcmp(@keyword[0], "LIST") = 0 then
			emit(OP_LIST)
		elseif strcmp(@keyword[0], "RUN") = 0 then
			emit(OP_RUN)
		elseif strcmp(@keyword[0], "END") = 0 then
			emit(OP_END)
		elseif strcmp(@keyword[0], "PSET") = 0 then
			parse_pset()
		elseif strcmp(@keyword[0], "FLIP") = 0 then
			emit(OP_FLIP)
		elseif strcmp(@keyword[0], "DEBUG") = 0 then
			dim as expr_t ptr e = parse_expression()
			emit_expression(e)
			expr_free(e)
			emit(OP_DEBUG_SI)
		elseif strcmp(@keyword[0], "CLS") = 0 then
			emit(OP_CLS)
		elseif strcmp(@keyword[0], "TRON") = 0 then
			emit(OP_TRON)
		elseif strcmp(@keyword[0], "TROFF") = 0 then
			emit(OP_TROFF)
		else
			set_error(2)
		end if
	
		if lexer.token_type <> asc(":") then exit do

		read_token() ' Dump the ':'
	loop

end sub

'   line ::= number statement CR | statement CR
sub parse_line(byval s as zstring ptr)

	dim as integer num = 0

	_thiscode_pos = 0
	memset(@_thiscode(0), 0, 64 * 4)

	if lexer.token_type = TK_INTEGER then
		num = valint(lexer.token)
		read_token()
	end if

	parse_statement()

	if num <> 0 then
		_thiscode(0).lineno = num
	end if

	if lexer.token_type <> TK_EOL then
		set_error(3)
	end if

	if was_error then
		io_printstr(*error_message)
		io_printstr(">>" & *s)
	else
		dim as string __bytecode = space((_thiscode_pos * sizeof(op_t)) + sizeof(op_t))
		memset(@__bytecode[0], 0, (_thiscode_pos * sizeof(op_t)) + sizeof(op_t))
		memcpy(@__bytecode[0], @_thiscode(0), _thiscode_pos * sizeof(op_t))
		if num = 0 then
			execute(cast(op_t ptr, @__bytecode[0]), 0)
			free_bytecode_strings(cast(op_t ptr, @__bytecode[0]))
		else
			line_insert(@__lines, num, *s, __bytecode)
		end if
	end if

end sub

sub parse(byval s as zstring ptr)

	was_error = 0

	lexer_init(s)
	
	parse_line(s)

end sub