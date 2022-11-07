10 LET f = -98304
20 LET d = 0
30 FLIP
31 if d >= 192 then goto 270
40 LET e = -131072
50 LET c = 0
60 if c >= 256 then goto 240
70 LET x = 0
80 LET y = 0
90 LET i = 0
100 LET m = 64
110 LET a = (x/256) * (x/256)
120 LET b = (y/256) * (y/256)
130 if (a+b) >= (4*65536) then goto 200
140 if i >= m then goto 195
150 LET t = (a - b + e)
160 LET y = ((x/128)*(y/256)) + f
170 LET x = t
180 LET i = i + 1
190 goto 110
195 LET i = 256
200 pset c, d, i * 10000
210 LET e = e + 1024
220 LET c = c + 1
230 goto 60
240 LET f = f + 1024
250 LET d = d + 1
260 goto 30
270 end
