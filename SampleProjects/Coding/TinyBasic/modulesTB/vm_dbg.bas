sub _debug(byval ln as integer)
  
	dim as line_t ptr l = *line_find(@__lines, ln)
  
	if l = NULL then
		io_printstr("Line not found")
		exit sub
	end if
  
	dim as op_t ptr s = cast(op_t ptr, @l->bytecode[0])
  
	io_printstr("Debugging line " & ln)
  
	while s->opcode
		select case as const s->opcode
			case OP_INPUT
				var sTMP = "INPUT x"
				sTMP[6] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_PUSH_VI
				var sTMP = "PUSH_VI x"
				sTMP[8] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_PUSH_VF
				var sTMP = "PUSH_VF x!"
				sTMP[8] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_LET_SI
				var sTMP = "LET_SI x"
				sTMP[7] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_LET_SF
				var sTMP = "LET_SF x!"
				sTMP[7] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_ADD_VF_VF
				var sTMP = "ADD_VF_VF x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_SUB_VF_VF
				var sTMP = "SUB_VF_VF x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_MUL_VF_VF
				var sTMP = "MUL_VF_VF x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_DIV_VF_VF
				var sTMP = "DIV_VF_VF x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)



			case OP_ADD_VI_VI
				var sTMP = "ADD_VI_VI x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_SUB_VI_VI
				var sTMP = "SUB_VI_VI x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_MUL_VI_VI
				var sTMP = "MUL_VI_VI x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)
			case OP_DIV_VI_VI
				var sTMP = "DIV_VI_VI x! x!"
				sTMP[10] = s->v1+asc("A")
				sTMP[13] = s->v2+asc("A")
				io_printstr(sTMP)


			case OP_SELFADD_VF_CF
				var sTMP = "OP_SELFADD_VF_CF x! " & *cast(single ptr, @s->v2)
				sTMP[17] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_SELFADD_VI_CI
				var sTMP = "OP_SELFADD_VI_CI x " & s->v2
				sTMP[17] = s->v1+asc("A")
				io_printstr(sTMP)


			case OP_LET_SF_CF
				var sTMP = "LET_SF_CF x! " & *cast(single ptr, @s->v2)
				sTMP[10] = s->v1+asc("A")
				io_printstr(sTMP)
			case OP_LET_SI_CI
				var sTMP = "LET_SI_CI x " & s->v2
				sTMP[10] = s->v1+asc("A")
				io_printstr(sTMP)
'-------------------------------------------------------------------------------
			case OP_GOTO_CONST
				io_printstr("GOTO " & s->v1)
			case OP_PUSH_I
				io_printstr("PUSH_I " & s->v1)
			case OP_PUSH_F
				io_printstr("PUSH_F " & *cast(single ptr, @s->v1))
			case OP_PRINTS
				io_printstr("PRINTS " & *cast(zstring ptr, s->v1))
'-------------------------------------------------------------------------------
			case OP_CONV_SF_SI
				io_printstr("CONV_SF_SI")
			case OP_CONV_SI_SF
				io_printstr("CONV_SI_SF")
			case OP_END
				io_printstr("END")
			case OP_NEG_SI
				io_printstr("NEG_SI")
			case OP_NEG_SF
				io_printstr("NEG_SF")
			case OP_ADD_SI_SI
				io_printstr("ADD_SI_SI")
			case OP_ADD_SF_SF
				io_printstr("ADD_SF_SF")
			case OP_SUB_SI_SI
				io_printstr("SUB_SI_SI")
			case OP_SUB_SF_SF
				io_printstr("SUB_SF_SF")
			case OP_MUL_SI_SI
				io_printstr("MUL_SI_SI")
			case OP_MUL_SF_SF
				io_printstr("MUL_SF_SF")
			case OP_DIV_SI_SI
				io_printstr("DIV_SI_SI")
			case OP_DIV_SF_SF
				io_printstr("DIV_SF_SF")
			case OP_SHL_SI_SI
				io_printstr("SHL_SI_SI")
			case OP_SHR_SI_SI
				io_printstr("SHR_SI_SI")
			case OP_THEN_SI
				io_printstr("THEN_SI")
			case OP_EQ_SF_SF
				io_printstr("EQ_SF_SF")
			case OP_NE_SF_SF
				io_printstr("NE_SF_SF")
			case OP_LT_SF_SF
				io_printstr("LT_SF_SF")
			case OP_LTE_SF_SF
				io_printstr("LTE_SF_SF")
			case OP_GT_SF_SF
				io_printstr("GT_SF_SF")
			case OP_EQ_SI_SI
				io_printstr("EQ_SI_SI")
			case OP_NE_SI_SI
				io_printstr("NE_SI_SI")
			case OP_SQR_SI
				io_printstr("SQR_SI")
			case OP_LT_SI_SI
				io_printstr("LT_SI_SI")
			case OP_LTE_SI_SI
				io_printstr("LTE_SI_SI")
			case OP_GT_SI_SI
				io_printstr("GT_SI_SI")
			case OP_GTE_SI_SI
				io_printstr("GTE_SI_SI")
			case OP_GTE_SF_SF
				io_printstr("GTE_SF_SF")
			case OP_OR_SI_SI
				io_printstr("OR_SI_SI")
			case OP_XOR_SI_SI
				io_printstr("XOR_SI_SI")
			case OP_AND_SI_SI
				io_printstr("AND_SI_SI")
			case OP_GOTO_SI
				io_printstr("GOTO_SI")
			case OP_SQUARE_SI
				io_printstr("SQUARE_SI")
			case OP_PSET
				io_printstr("PSET")
			case OP_FLIP
				io_printstr("FLIP")
			case OP_CLS
				io_printstr("CLS")
			case OP_TRON
				io_printstr("TRON")
			case OP_TROFF
				io_printstr("TROFF")
			case OP_PRINT_SI
				io_printstr("PRINT_SI")
			case OP_PRINT_SF
				io_printstr("PRINT_SF")
			case OP_RUN
				io_printstr("RUN")
			case OP_CLEAR
				io_printstr("CLEAR")
			case OP_LIST
				io_printstr("LIST")
			case OP_JMP
				io_printstr("JMP")
			case OP_NEW
				io_printstr("NEW")
			case OP_LOAD
				io_printstr("LOAD")
			case OP_SAVE
				io_printstr("SAVE")
			case OP_GOSUB_SI
				io_printstr("GOSUB_SI")
			case OP_RETURN_SI
				io_printstr("RETURN_SI")
			case OP_DEBUG_SI
				io_printstr("DEBUG_SI")
			case OP_JZ_SI
				io_printstr("JZ_SI")
			case OP_SHL_SF_SF
				io_printstr("SHL_SF_SF")
			case OP_SHR_SF_SF
				io_printstr("SHR_SF_SF")
			case OP_XOR_SF_SF
				io_printstr("XOR_SF_SF")
			case OP_AND_SF_SF
				io_printstr("AND_SF_SF")
			case OP_OR_SF_SF
				io_printstr("OR_SF_SF")
			case OP_SQUARE_SF
				io_printstr("SQUARE_SF")
			case OP_SQR_SF
				io_printstr("SQR_SF")
			case OP_THEN_SF
				io_printstr("THEN_SF")
			case OP_GOTO_SF
				io_printstr("GOTO_SF")
			case OP_GOSUB_SF
				io_printstr("GOSUB_SF")
			case OP_RETURN_SF
				io_printstr("RETURN_SF")
			case OP_DEBUG_SF
				io_printstr("DEBUG_SF")
			case OP_JZ_SF
				io_printstr("JZ_SF")
			case else
				io_printSTR("UNKNOWN " & s->opcode)
   		end select
		s += 1
  wend
  
end sub