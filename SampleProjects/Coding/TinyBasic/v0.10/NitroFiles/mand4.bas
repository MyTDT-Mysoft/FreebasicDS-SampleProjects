10 LET f! = -1.5:LET d = 0
30 FLIP:if d >= 96 then goto 270
40 LET e! = -2.0:LET c = 0
60 if c >= 256 then goto 240
70 LET x! = 0:LET y! = 0:LET i = 0:LET m = 64

110 LET a! = x! * x!:LET b! = y! * y!
130 if (a!+b!) >= 4.0 then goto 200
140 if i >= m then goto 195
150 LET t! = (a! - b! + e!)
160 LET y! = (2.0*x!*y!) + f!
170 LET x! = t!
180 LET i = i + 1
190 goto 110
195 LET c = c + 2
197 LET e! = e! + 0.03125
198 goto 210
200 pset c, d, i * 10000
205 pset c, 191-d, i * 10000
210 LET e! = e! + 0.01562
220 LET c = c + 1
230 goto 60
240 LET f! = f! + 0.01562:LET d = d + 1
260 goto 30
270 end

debug 110
debug 130
debug 140
debug 150
debug 160
debug 180
debug 197
