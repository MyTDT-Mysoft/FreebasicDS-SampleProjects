
declare function parse_expression() as expr_t ptr

'   factor ::= var | number | (expression)
function parse_factor() as expr_t ptr

	if lexer.token = "SQR" then
		dim as integer do_paren_close
		read_token()
		if lexer.token_type = asc("(") then
			read_token()
			do_paren_close = 1
		end if
		dim as expr_t ptr e = parse_expression()
		if e->dt = DT_INTEGER then
			function = _uop(OP_SQR_SI, e)
		elseif e->dt = DT_SINGLE then
			function = _uop(OP_SQR_SF, e)
		else
			puts("Major error")
			end 1
		end if
		if (do_paren_close = 1) and (lexer.token_type <> asc(")")) then
			set_error(0)
		end if
		read_token()
	elseif lexer.token_type = TK_IDENT then
		if right(lexer.token, 1) = "!" then
			function = _varf(lexer.token[0] - asc("A"))
		else
			function = _vari(lexer.token[0] - asc("A"))
		end if
		read_token()
	elseif lexer.token_type = TK_INTEGER then
		function = _int(valint(lexer.token))
		read_token()
	elseif lexer.token_type = TK_SINGLE then
		function = _sng(val(lexer.token))
		read_token()
	elseif lexer.token_type = asc("(") then
		read_token()
		function = parse_expression()
		if lexer.token_type <> asc(")") then
			set_error(0)
		end if
		read_token()
	end if

end function

'   term ::= factor ((*|/) factor)*
function parse_term() as expr_t ptr

	dim as expr_t ptr node

	node = parse_factor()

	while (lexer.token_type = asc("*")) or (lexer.token_type = asc("/"))
		dim as integer _op = lexer.token_type
		read_token()
		dim as expr_t ptr r = parse_factor()
		if _op = asc("*") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_MUL_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_MUL_SF_SF, node, r)
			else
				puts("WJIO432W1")
				end 1
			end if
		elseif _op = asc("/") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_DIV_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_DIV_SF_SF, node, r)
			else
				puts("WJIO432W2")
				end 1
			end if
		end if
	wend

	return node

end function

'   term2 ::= term ((shl|shr) term)*
function parse_term2() as expr_t ptr

	dim as expr_t ptr node

	node = parse_term()

	do
		dim as ulong _iop = *cast(ulong ptr,@lexer.token)
		if _iop <> cvi3("SHL") and _iop <> cvi3("SHR") then exit do
		read_token()
		dim as expr_t ptr r = parse_term()
		if _iop = cvi3("SHL") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_SHL_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_SHL_SF_SF, node, r)
			else
				puts("TREJIO432W2")
				end 1
			end if
		elseif _iop = cvi3("SHR") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_SHR_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_SHR_SF_SF, node, r)
			else
				puts("TREJIO432W2")
				end 1
			end if
		end if
	loop

	return node

end function

#define cvi2(s) (cvi(s "  ")-&H20200000)

'   term3 ::= term2 ((and|xor|or) term2)*
function parse_term3() as expr_t ptr

	dim as expr_t ptr node

	node = parse_term2()

	do
		dim as string _sop = lexer.token
		dim as ulong _iop = *cast(ulong ptr,@lexer.token)
		if (_iop <> cvi3("XOR")) and (_iop <> cvi3("AND")) and (_sop <> "OR") then exit do
		read_token()
		dim as expr_t ptr r = parse_term2()
		if _iop = cvi3("XOR") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_XOR_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_XOR_SF_SF, node, r)
			else
				puts("GDO432W2")
				end 1
			end if
		elseif _iop = cvi3("AND") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_AND_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_AND_SF_SF, node, r)
			else
				puts("GDO432W2")
				end 1
			end if
		elseif _sop = "OR" then
			if r->dt = DT_INTEGER then
				node = _bop(OP_OR_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_OR_SF_SF, node, r)
			else
				puts("GDO432W2")
				end 1
			end if
		end if
	loop

	return node

end function

'   expression ::= (+|-|ε) term3 ((+|-) term3)*
function parse_expression() as expr_t ptr

	dim as integer do_neg = 0

	if lexer.token_type = asc("+") then
		read_token()
	elseif lexer.token_type = asc("-") then
		do_neg = -1
		read_token()
	end if

	dim as expr_t ptr node

	node = parse_term3()

	while (lexer.token_type = asc("+")) or (lexer.token_type = asc("-"))
		dim as integer _op = lexer.token_type
		read_token()
		dim as expr_t ptr r = parse_term3()
		if _op = asc("+") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_ADD_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_ADD_SF_SF, node, r)
			else
				puts("WJIOW1")
				end 1
			end if
		elseif _op = asc("-") then
			if r->dt = DT_INTEGER then
				node = _bop(OP_SUB_SI_SI, node, r)
			elseif r->dt = DT_SINGLE then
				node = _bop(OP_SUB_SF_SF, node, r)
			else
				puts("WJIOW2")
				end 1
			end if
		end if
	wend

	if do_neg then
		if node->_type = EXPR_INT then
			node->n = -node->n
		elseif node->_type = EXPR_SNG then
			node->f = -node->f
		else
			if node->dt = DT_INTEGER then
				node = _uop(OP_NEG_SI, node)
			elseif node->dt = DT_SINGLE then
				node = _uop(OP_NEG_SF, node)
			else
				puts "jkfdj"
				end 1
			end if
		end if
	end if

	return node

end function