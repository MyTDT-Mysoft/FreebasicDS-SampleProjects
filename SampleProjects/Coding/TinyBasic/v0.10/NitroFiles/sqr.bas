10 let Y = -96
20 let W = Y*Y: let X = -128
30 let I = W+X*X
32 let M=7 : let A=0 : let C=0
33 let S=1 shl (M+M) : let J=M
34 let D=C+(A shl (J+1))+S
35 if D <= I then let C=D : let A=A+(1 shl J)
36 if D <> I then let S=S shr 2 : let J=J-1
37 if J >= 0 then if D<>I then goto 34
40 let R = A
40 let R = A*3+((255-A)*2816)+(A*720896)
50 pset X+128,Y+96,R : pset 127-X,Y+96,R
60 pset X+128,95-Y,R : pset 127-X,95-Y,R
70 let X=X+1: if X < 1 then goto 30
80 flip: let Y=Y+1: if Y < 1 then goto 20
run 
