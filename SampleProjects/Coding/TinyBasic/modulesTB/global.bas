#undef isdigit
#undef isupper
#undef islower
#undef isalpha
#undef isspace

#define cvi3(s) (cvi(s " ")-&H20000000)

#define isdigit(c) (cuint(c-asc("0")) <= (asc("9")-asc("0")))
#define isupper(c) (cuint(c-asc("A")) <= (asc("Z")-asc("A")))
#define islower(c) (cuint(c-asc("a")) <= (asc("z")-asc("a")))
#define isalpha(c) (islower(c) or isupper(c))
#define isspace(c) ((c) = asc(" "))

enum op_e
	OP_NOSTACK
	OP_PUSH_I
	OP_PUSH_F
	OP_PUSH_VI
	OP_PUSH_VF
	OP_GOTO_CONST
	OP_RUN
	OP_END
	OP_CLEAR
	OP_LIST
	OP_INPUT
	OP_PSET
	OP_FLIP
	OP_CLS
	OP_TRON
	OP_TROFF
	OP_JMP
	OP_PRINTS
	OP_NEW
	OP_LOAD
	OP_SAVE
	OP_LET_SF_CF
	OP_LET_SI_CI
	OP_ADD_VF_VF
	OP_SUB_VF_VF
	OP_MUL_VF_VF
	OP_DIV_VF_VF
	OP_ADD_VI_VI
	OP_SUB_VI_VI
	OP_MUL_VI_VI
	OP_DIV_VI_VI
	OP_SELFADD_VF_CF
	OP_SELFADD_VI_CI

	' Unary operators, cause a single pop
	OP_STACK_SI
	OP_NEG_SI
	OP_SQUARE_SI
	OP_SQR_SI
	OP_THEN_SI
	OP_GOTO_SI
	OP_GOSUB_SI
	OP_LET_SI
	OP_RETURN_SI
	OP_PRINT_SI
	OP_DEBUG_SI
	OP_JZ_SI
	OP_CONV_SI_SF

	OP_STACK_SF
	OP_NEG_SF
	OP_SQUARE_SF
	OP_SQR_SF
	OP_THEN_SF
	OP_GOTO_SF
	OP_GOSUB_SF
	OP_LET_SF
	OP_RETURN_SF
	OP_PRINT_SF
	OP_DEBUG_SF
	OP_JZ_SF
	OP_CONV_SF_SI

	' Binary operators, cause two pops
	OP_STACK_SI_SI
	OP_ADD_SI_SI
	OP_SUB_SI_SI
	OP_MUL_SI_SI
	OP_DIV_SI_SI
	OP_EQ_SI_SI
	OP_NE_SI_SI
	OP_LT_SI_SI
	OP_LTE_SI_SI
	OP_GT_SI_SI
	OP_GTE_SI_SI
	OP_SHL_SI_SI
	OP_SHR_SI_SI
	OP_XOR_SI_SI
	OP_AND_SI_SI
	OP_OR_SI_SI

	OP_STACK_SF_SF
	OP_ADD_SF_SF
	OP_SUB_SF_SF
	OP_MUL_SF_SF
	OP_DIV_SF_SF
	OP_EQ_SF_SF
	OP_NE_SF_SF
	OP_LT_SF_SF
	OP_LTE_SF_SF
	OP_GT_SF_SF
	OP_GTE_SF_SF
	OP_SHL_SF_SF
	OP_SHR_SF_SF
	OP_XOR_SF_SF
	OP_AND_SF_SF
	OP_OR_SF_SF

end enum

enum dt_e
	DT_BAD
	DT_INTEGER
	DT_SINGLE
end enum

type op_t
	opcode as op_e
	v1     as integer
	v2     as integer
	lineno as integer
end type

enum tk_e
	TK_IDENT = 256
	TK_INTEGER
	TK_SINGLE
	TK_STRING
	TK_NE
	TK_LTE
	TK_GTE
	TK_EOL
end enum

type line_t
	lineno   as integer
	text     as string
	bytecode as string
	l        as line_t ptr
	r        as line_t ptr
end type

enum expr_e
	EXPR_BAD
	EXPR_INT
	EXPR_SNG
	EXPR_VAR
	EXPR_UOP
	EXPR_BOP
end enum

type expr_t
	_type as expr_e
	dt    as dt_e
	n     as integer
	f     as single
	op    as integer
	l     as expr_t ptr
	r     as expr_t ptr
end type

type lines_t
	root as line_t ptr
end type

function line_find(byval lines as lines_t ptr, byval n as integer) as line_t ptr ptr

	dim as line_t ptr ptr node = @lines->root

	while *node
		if n < (*node)->lineno then
			node = @(*node)->l
		elseif n > (*node)->lineno then
			node = @(*node)->r
		else
			exit while
		end if
	wend

	function = node

end function

function line_insert(byval lines as lines_t ptr, byval n as integer, byref text as string, byref bytecode as string) as line_t ptr

	dim as line_t ptr ptr node = line_find(lines, n)

	if *node = NULL then
		*node = callocate(sizeof(line_t))
	end if

	(*node)->lineno = n
	(*node)->text = text
	(*node)->bytecode = bytecode

	function = *node

end function

sub free_bytecode_strings(byval o as op_t ptr)

	while o->opcode
		if o->opcode = OP_PRINTS then
			deallocate(cast(any ptr, o->v1))
		elseif o->opcode = OP_LOAD then
			deallocate(cast(any ptr, o->v1))
		end if
		o += 1
	wend

end sub

sub line_free(byval l as line_t ptr)

	if l = NULL then exit sub

	if l->l then line_free(l->l)
	if l->r then line_free(l->r)

	free_bytecode_strings(cast(op_t ptr, @l->bytecode[0]))

	l->text = ""
	l->bytecode = ""

	deallocate(l)

end sub

dim shared as lines_t __lines

dim shared as zstring ptr error_message
dim shared as integer was_error
dim shared as op_t _thiscode(0 to 63)
dim shared as integer _thiscode_pos
dim shared as fb.image ptr buffer

dim shared as integer trace

declare sub parse(byval s as zstring ptr)

/'
1 let a = 0
2 let a = a + 1
3 if a < 10000000 then goto 2
4 end
'/