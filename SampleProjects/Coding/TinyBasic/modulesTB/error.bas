sub set_error(byval n as integer)

	if was_error = 0 then
		select case n
			case 0
				error_message = @"Expected ')'        "
			case 1
				error_message = @"Expected '""'       "
			case 2
				error_message = @"Expected keyword    "
			case 3
				error_message = @"Expected end of line"
			case 4
				error_message = @"Expected variable   "
			case 5
				error_message = @"Expected '='        "
			case 6
				error_message = @"Expected THEN       "
			case 7
				error_message = @"Expected relop      "
			case 8
				error_message = @"Runtime stack error "
			case 9
				error_message = @"Runtime error       "
			case 10
				error_message = @"Expected ','        "
			case else
				error_message = @"<<UNKNOWN ERROR>>   "
		end select
	
		was_error = -1
	end if

end sub
