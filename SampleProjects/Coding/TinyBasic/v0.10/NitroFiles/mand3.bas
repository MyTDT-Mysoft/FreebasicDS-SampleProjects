10 LET f = -98304:LET d = 0
30 FLIP:if d >= 96 then goto 270
40 LET e = -131072:LET c = 0
60 if c >= 256 then goto 240
70 LET x = 0:LET y = 0:LET i = 0:LET m = 64

101 LET z = (x shr 8)
102 LET w = (y shr 8)
110 LET a = z * z:LET b = w * w
130 if (a+b) >= 262144 then goto 200
140 if i >= m then goto 195
150 LET t = (a - b + e)
160 LET y = ((x shr 7)*w) + f
170 LET x = t
180 LET i = i + 1
190 goto 101
195 LET c = c + 2
197 LET e = e + 2048
198 goto 210
200 pset c, d, i * 10000
205 pset c, 191-d, i * 10000
210 LET e = e + 1024
220 LET c = c + 1
230 goto 60
240 LET f = f + 1024:LET d = d + 1
260 goto 30
270 end

debug 101