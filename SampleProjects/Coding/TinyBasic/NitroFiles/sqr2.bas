1 goto 10
2 let M=7 : let A=0 : let C=0 : if I >= 65536 then let M=M+8
3 let S=1 shl (M*2) : let J=M
4 let D=C+(A shl (J+1))+S
5 if D <= I then LET C=D : let A=A+(1 shl J)
6 if D <> I then let S=S shr 2 : let J=J-1
7 if J < 0 then let R=A: return
8 if D = I then let R=A: return
9 goto 4
10 let Y = -96
20 let W = Y*Y: let X = -128
30 let I = W+X*X : gosub 2
40 let R = R*3+((255-R)*2816)+(R*720896)
50 pset X+128,Y+96,R : pset 128-X,Y+96,R
60 pset X+128,96-Y,R : pset 128-X,96-Y,R
70 let X=X+1: if X < 1 then goto 30
80 flip: let Y=Y+1: if Y < 1 then goto 20
