''
'' High Score functions
''
'' FBGD RetroComp Aug/Sept 2008 Entry by ssjx (http://ssjx.co.uk)
''
''
declare function loadscore() as integer
declare sub savescore(score as integer)
''

function loadscore() as integer
	dim as integer score

	if  Open("score.dat" For binary access read As #1)=0 then
		get #1,,score
		close #1
	else
		score=100
	end if
	
	return score	
		
end function

''
sub savescore(score as integer)
	exit sub
  'if  Open("score.dat" For binary access write As #1)=0 then
	'	put #1,1,score
	'	close #1
	'end if	
end sub
