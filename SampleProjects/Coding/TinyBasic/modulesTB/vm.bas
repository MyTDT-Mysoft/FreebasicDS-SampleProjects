dim shared as integer _stack(0 to 99)
dim shared as integer _stack_pos
dim shared as integer ivars(0 to 25)
dim shared as single fvars(0 to 25)

function _pop() as integer
  
	if _stack_pos = 0 then
		set_error(8)
	else
		_stack_pos -= 1
		function = _stack(_stack_pos)
	end if
  
end function

sub _push(n as integer)

	_stack(_stack_pos) = n
	_stack_pos += 1

end sub



sub execute2(byval s as op_t ptr)

	dim as op_t ptr first = s
	dim as uinteger cycles = 0

	while s->opcode

		if (cycles and 255) = 0 then
			if multikey(fb.sc_escape) then
				io_printstr("BREAK")
				while multikey(fb.sc_escape)
					sleep 1,1: var k = inkey()
				wend
				exit sub
			end if
		end if

		dim as integer il = 0, ir = 0
		dim as single fl = 0, fr = 0
		dim as integer curr_op = s->opcode

		if curr_op >= OP_STACK_SF_SF then ' Binary op
			ir = _pop()
			il = _pop()
			fr = *cast(single ptr, @ir)
			fl = *cast(single ptr, @il)
			'puts(":1 " & fl & "-" & fr)
		elseif curr_op >= OP_STACK_SI_SI then
			ir = _pop()
			il = _pop()
			'puts(":2 " & il & "-" & ir)
		elseif curr_op >= OP_STACK_SF then  ' Unary op
			il = _pop()
			fl = *cast(single ptr, @il)
			'puts(":3 " & fl)
		elseif curr_op >= OP_STACK_SI then
			il = _pop()
			'puts(":4 " & il)
		end if

		if was_error = 0 then
			if s->lineno >= 0 then
				if trace then io_printstr("[" & s->v1 & "]",0)
			end if

			select case as const curr_op
				case OP_NEW
					for i as integer = 0 to 25
						ivars(i) = 0
						fvars(i) = 0
					next i
					line_free(__lines.root)
					__lines.root = NULL
					exit sub
				case OP_LOAD
					for i as integer = 0 to 25
						ivars(i) = 0
						fvars(i) = 0
					next i
					line_free(__lines.root)
					__lines.root = NULL
					io_load(*cast(zstring ptr, s->v1))
					exit sub
				case OP_SAVE
					io_save(*cast(zstring ptr, s->v1))
					exit sub
				case OP_CLEAR
					for i as integer = 0 to 25
						ivars(i) = 0
						fvars(i) = 0
					next i
				case OP_PSET
					dim as integer c = _pop()
					dim as integer y = _pop()
					dim as integer x = _pop()
					io_pset(x, y, c)
				case OP_FLIP
					io_flip()
				case OP_TRON
					trace = -1
				case OP_TROFF
					trace = 0
				case OP_CLS
					line buffer,(0,0)-(255,191),0,bf
					cursor_x = 0: cursor_y = 0
				case OP_PUSH_I
					_push(s->v1)
				case OP_PUSH_F
					_push(s->v1)
				case OP_PUSH_VI
					_push(ivars(s->v1))
				case OP_PUSH_VF
					'puts("Push_vf " & fvars(s->v1))
					'puts("Push_v^ " & *cast(integer ptr, @fvars(s->v1)))
					_push(*cast(integer ptr, @fvars(s->v1)))

				case OP_ADD_VF_VF
					dim as single result = fvars(s->v1) + fvars(s->v2)
					_push(*cast(integer ptr, @result))
				case OP_SUB_VF_VF
					dim as single result = fvars(s->v1) - fvars(s->v2)
					_push(*cast(integer ptr, @result))
				case OP_MUL_VF_VF
					dim as single result = fvars(s->v1) * fvars(s->v2)
					_push(*cast(integer ptr, @result))
				case OP_DIV_VF_VF
					dim as single result = fvars(s->v1) / fvars(s->v2)
					_push(*cast(integer ptr, @result))


				case OP_SELFADD_VF_CF
					 fvars(s->v1) += *cast(single ptr, @s->v2)
				case OP_SELFADD_VI_CI
					 ivars(s->v1) += s->v2



				case OP_ADD_VI_VI
					_push(ivars(s->v1) + ivars(s->v2))
				case OP_SUB_VI_VI
					_push(ivars(s->v1) - ivars(s->v2))
				case OP_MUL_VI_VI
					_push(ivars(s->v1) * ivars(s->v2))
				case OP_DIV_VI_VI
					_push(ivars(s->v1) \ ivars(s->v2))




				case OP_LET_SF_CF
					fvars(s->v1) = *cast(single ptr, @s->v2)
				case OP_LET_SI_CI
					ivars(s->v1) = s->v2


				case OP_RUN
					''''
				case OP_END
					exit sub
				case OP_INPUT
					ivars(s->v1) = io_inputnum("?")
				case OP_LIST
					dim as integer lines_printed
					for i as integer = 0 to 999
						dim as line_t ptr l = *line_find(@__lines, i)
						if l then
							io_printstr(l->text)
							lines_printed += 1
							if lines_printed >= 18 then
								io_printstr("Press enter")
								io_inputnum("?")
								lines_printed = -1
							end if
						end if
					next i
				case OP_JMP
					s = cast(op_t ptr, s->v1)
					s -= 1
				case OP_GOTO_CONST
					dim as op_t ptr o = first
					dim as integer found
					while o->opcode
						if o->lineno >= 0 then
							if o->lineno = s->v1 then
								s = o
								found = 1
								exit while
							end if
						end if
						o += 1
					wend

					if found = 0 then
						io_printstr("GOTO TARGET NOT FOUND 4")
						exit sub
					end if
					s -= 1
				case OP_PRINTS
					io_printstr(*cast(zstring ptr, s->v1))

'-------------------------------------------------------------------------------
' Unary operators
				case OP_LET_SI
					ivars(s->v1) = il
				case OP_DEBUG_SI
					_debug(il)
				case OP_NEG_SI
					_push(-il)
				case OP_SQR_SI
					_push(int(sqr(il)))
				case OP_SQR_SF
					dim as single result = sqr(fl)
					_push(*cast(integer ptr, @result))
				case OP_JZ_SI
					if il = 0 then
						s = cast(op_t ptr, s->v1)
						s -= 1
					end if
				case OP_THEN_SI
					if il = 0 then
						while (s->lineno = -1) and (s->opcode <> 0)
							s += 1
						wend
						s -= 1
					end if
				case OP_GOTO_SI
					dim as op_t ptr o = first
					dim as integer found
					while o->opcode
						if o->lineno >= 0 then
							if o->lineno = il then
								s = o
								found = 1
								exit while
							end if
						end if
						o += 1
					wend

					if found = 0 then
						io_printstr("GOTO TARGET NOT FOUND 3")
						exit sub
					end if

					s -= 1
				case OP_GOSUB_SI
					_push(cast(integer, s + 1))

					dim as op_t ptr o = first
					dim as integer found
					while o->opcode
						if o->lineno >= 0 then
							if o->lineno = il then
								s = o
								found = 1
								exit while
							end if
						end if
						o += 1
					wend

					if found = 0 then
						io_printstr("GOTO TARGET NOT FOUND 2")
						exit sub
					end if

					s -= 1
				case OP_RETURN_SI
					s = cast(op_t ptr, il)
					s -= 1
				case OP_PRINT_SI
					io_printint(il)
				case OP_SQUARE_SI
					_push(il * il)
				case OP_SQUARE_SF
					dim as single result = fl * fl
					_push(*cast(integer ptr, @result))
				case OP_LET_SF
					fvars(s->v1) = fl
				case OP_NEG_SF
					dim as single result = -fl
					_push(*cast(integer ptr, @result))
				case OP_PRINT_SF
					io_printsng(fl)

				case OP_CONV_SF_SI
					_push(fl)
				case OP_CONV_SI_SF
					dim as single temp = il
					_push(*cast(integer ptr, @temp))


'-------------------------------------------------------------------------------
' Binary operators
				case OP_ADD_SI_SI
					_push(il + ir)
				case OP_MUL_SI_SI
					_push(il * ir)
				case OP_DIV_SI_SI
					_push(il \ ir)
				case OP_LT_SI_SI
					_push(il < ir)
				case OP_LTE_SI_SI
					_push(il <= ir)
				case OP_GT_SI_SI
					_push(il > ir)
				case OP_GTE_SI_SI
					_push(il >= ir)
				case OP_EQ_SI_SI
					_push(il = ir)
				case OP_NE_SI_SI
					_push(il <> ir)
				case OP_SUB_SI_SI
					_push(il - ir)
				case OP_SHL_SI_SI
					_push(il shl ir)
				case OP_SHR_SI_SI
					_push(il shr ir)
				case OP_AND_SI_SI
					_push(il and ir)
				case OP_XOR_SI_SI
					_push(il xor ir)
				case OP_OR_SI_SI
					_push(il or ir)

				case OP_ADD_SF_SF
					dim as single result = fl + fr
					_push(*cast(integer ptr, @result))
				case OP_SUB_SF_SF
					dim as single result = fl - fr
					_push(*cast(integer ptr, @result))
				case OP_MUL_SF_SF
					dim as single result = fl * fr
					_push(*cast(integer ptr, @result))
				case OP_DIV_SF_SF
					dim as single result = fl / fr
					_push(*cast(integer ptr, @result))
				case OP_GTE_SF_SF
					_push(fl >= fr)
				case OP_EQ_SF_SF
					_push(fl = fr)
				case OP_NE_SF_SF
					_push(fl <> fr)
				case OP_LT_SF_SF
					_push(fl < fr)
				case OP_LTE_SF_SF
					_push(fl <= fr)
				case OP_GT_SF_SF
					_push(fl > fr)


'-------------------------------------------------------------------------------
' TODO
				case OP_SHL_SF_SF
				case OP_SHR_SF_SF
				case OP_XOR_SF_SF
				case OP_AND_SF_SF
				case OP_OR_SF_SF
				case OP_THEN_SF
				case OP_GOTO_SF
				case OP_GOSUB_SF
				case OP_RETURN_SF
				case OP_DEBUG_SF
				case OP_JZ_SF
'-------------------------------------------------------------------------------














				case else
					io_printstr("error on run '" & curr_op & "'", 0)
					set_error(9)
			end select
		end if
		s += 1
		cycles += 1
	wend

end sub

sub build_all_bytecode(byval node as line_t ptr, byref _out as string)
  
	if node = NULL then exit sub
  
	build_all_bytecode(node->l, _out)
  
	dim as integer _len = len(node->bytecode) - sizeof(op_t)
	_out += mid(node->bytecode, 1, _len)
  
	build_all_bytecode(node->r, _out)
  
end sub

sub patch_const_goto(byval s as op_t ptr)
	
	dim as op_t ptr first = s
	
	while s->opcode
		if s->opcode = OP_GOTO_CONST then
			dim as op_t ptr o = first
			dim as op_t ptr foundat
			dim as integer found
			while o->opcode
				if o->lineno >= 0 then
					if o->lineno = s->v1 then
						foundat = o
						found = 1
						exit while
					end if
				end if
				o += 1
			wend
	
			if found = 0 then
				io_printstr("GOTO TARGET NOT FOUND 1")
				exit sub
			end if
	
			s->opcode = OP_JMP
			s->v1 = cast(integer, foundat)
		elseif s->opcode = OP_THEN_SI then
			dim as op_t ptr o = s
	
			while o->opcode
				if o->lineno >= 0 then exit while
				o += 1
			wend
	
			s->opcode = OP_JZ_SI
			s->v1 = cast(integer, o)
		end if
		s += 1
	wend
	
end sub

sub do_run()
  
	dim as string _out
  
	build_all_bytecode(__lines.root, _out)
  
	dim as string temp = space(sizeof(op_t))
	memset(@temp[0], 0, sizeof(op_t))
  
	_out += temp
  
	patch_const_goto(cast(op_t ptr, @_out[0]))
  
	dim as double t = timer()
  
	execute2(cast(op_t ptr, @_out[0]))
  
	t = timer() - t
	io_printstr(int(t * 1000) & "ms")
  
end sub

sub execute(byval s as op_t ptr, byval lineno as integer)
  
	if s->opcode = OP_RUN then
		do_run()
	else
		execute2(s)
	end if
  
end sub
