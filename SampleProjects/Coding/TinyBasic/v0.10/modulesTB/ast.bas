sub expr_free(byval e as expr_t ptr)

	if e->l then expr_free(e->l)
	if e->r then expr_free(e->r)

	deallocate(e)

end sub

function _int(byval n as integer) as expr_t ptr

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_INT
	node->dt = DT_INTEGER
	node->n = n

	return node

end function

function _sng(byval f as single) as expr_t ptr

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_SNG
	node->dt = DT_SINGLE
	node->f = f

	return node

end function

function _vari(byval n as integer) as expr_t ptr

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_VAR
	node->dt = DT_INTEGER
	node->n = n

	return node

end function

function _varf(byval n as integer) as expr_t ptr

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_VAR
	node->dt = DT_SINGLE
	node->n = n

	return node

end function

function _uop(byval op as integer, byval l as expr_t ptr) as expr_t ptr

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_UOP
	node->op = op
	node->l = l
	node->dt = l->dt

	return node

end function

function optimize_bop(byval e as expr_t ptr) as expr_t ptr

	select case e->op
		case OP_ADD_SI_SI
			if (e->l->_type = EXPR_INT) andalso (e->r->_type = EXPR_INT) then
				dim as integer n = e->l->n + e->r->n
				expr_free(e->l)
				expr_free(e->r)
				return _int(n)
			end if
		case OP_SUB_SI_SI

		case OP_MUL_SI_SI
			if (e->l->_type = EXPR_INT) andalso (e->r->_type = EXPR_INT) then
				dim as integer n = e->l->n * e->r->n
				expr_free(e->l)
				expr_free(e->r)
				return _int(n)
			end if
		case OP_DIV_SI_SI

		case OP_SHR_SI_SI

	end select

	return e

end function

function optimize(byval e as expr_t ptr) as expr_t ptr

	select case e->_type
		case EXPR_BOP
			return optimize_bop(e)
		case else
			return e
	end select

end function

function _bop(byval op as integer, byval l as expr_t ptr, byval r as expr_t ptr) as expr_t ptr

	if l->dt <> r->dt then
		puts("Type mismatch at _bop")
		end 1
	end if

	dim as expr_t ptr node = callocate(sizeof(expr_t))

	node->_type = EXPR_BOP
	node->op = op
	node->l = l
	node->r = r
	node->dt = l->dt

	return optimize(node)

end function
