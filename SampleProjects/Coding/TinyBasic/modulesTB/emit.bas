sub emit(byval op as integer, byval v1 as integer = 0, byval lineno as integer = -1, byval v2 as integer = 0)

	_thiscode(_thiscode_pos).opcode = op
	_thiscode(_thiscode_pos).v1 = v1
	_thiscode(_thiscode_pos).v2 = v2
	_thiscode(_thiscode_pos).lineno = lineno
	_thiscode_pos += 1

end sub

sub emit_expression(byval e as expr_t ptr)

	select case e->_type
		case EXPR_INT
			emit(OP_PUSH_I, e->n)
		case EXPR_SNG
			emit(OP_PUSH_F, *cast(integer ptr, @e->f))
		case EXPR_VAR
			if e->dt = DT_INTEGER then
				emit(OP_PUSH_VI, e->n)
			elseif e->dt = DT_SINGLE then
				emit(OP_PUSH_VF, e->n)
			else
				puts("Quat? 1")
				end 1
			end if
		case EXPR_BOP
			if (e->l->_type = EXPR_VAR) and (e->r->_type = EXPR_VAR) then
				select case e->op
					case OP_ADD_SF_SF
						emit(OP_ADD_VF_VF, e->l->n, , e->r->n)
					case OP_SUB_SF_SF
						emit(OP_SUB_VF_VF, e->l->n, , e->r->n)
					case OP_MUL_SF_SF
						emit(OP_MUL_VF_VF, e->l->n, , e->r->n)
					case OP_DIV_SF_SF
						emit(OP_DIV_VF_VF, e->l->n, , e->r->n)
					case OP_ADD_SI_SI
						emit(OP_ADD_VI_VI, e->l->n, , e->r->n)
					case OP_SUB_SI_SI
						emit(OP_SUB_VI_VI, e->l->n, , e->r->n)
					case OP_MUL_SI_SI
						emit(OP_MUL_VI_VI, e->l->n, , e->r->n)
					case OP_DIV_SI_SI
						emit(OP_DIV_VI_VI, e->l->n, , e->r->n)
					case else
						emit_expression(e->l)
						emit_expression(e->r)
						emit(e->op)
				end select
			else
				emit_expression(e->l)
				emit_expression(e->r)
				emit(e->op)
			end if
		case EXPR_UOP
			emit_expression(e->l)
			emit(e->op)
		case else
			puts("Quat? 2")
			end 1
	end select

end sub