#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  '#define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
#else
  #include "crt.bi"
  chdir "NitroFiles/"
#endif


#if 0
dim as uinteger q

q = &h80990044
asm  
  mov r3, #0xFF, LSL #3
  mov r3, #0x7F          '\
  orr r3, r3, LSL #8     '| r3 = &h7F7F7F7F (not on the loop)
  orr r3, r3, LSL #16    '/
  
  ldr r4, $q
  
  and r5, r4, r3
  add r5, r3
  orr r5, r4
  orr r5, r3
  mvn r5, r5
  orr r5, r5, LSR #1
  orr r5, r5, LSR #2
  orr r5, r5, LSR #4
  
  str r5, $q
end asm

print hex$(q,8)
sleep
#endif  



#if 1
'gfx.GfxDriver = gfx.gdOpenGL
screenres 256,192,8

dim as any ptr Imgs = imagecreate(256,576)
bload "Worms.bmp",Imgs
dim as ubyte ptr OutPtr,ScrPtr = screenptr
dim as ubyte ptr InPtr,ImgPtr = Imgs+sizeof(fb.image)+192*256

dim as double TMR,MTDA,MTDB,MTDC,MTDD
dim as double iCount

do
  screenlock
  put(0,0),Imgs,(0,384)-(255,575),pset
  
  TMR = timer
  InPtr = ImgPtr: OutPtr = ScrPtr
  for CNT as integer = (192*256)-1 to 0 step -1
    if *InPtr then *OutPtr = *InPtr
    InPtr += 1: OutPtr += 1
  next CNT
  MTDA += (timer-TMR)
  
  put(0,0),Imgs,(0,384)-(255,575),pset  
  TMR = timer
  asm
        ldr r0, $ImgPtr
        ldr r1, $ScrPtr
        mov r2, #49152
        subs r2, #4
        blt 1f
      0:ldrb r3,[r0!],#1
        ldrb r4,[r0!],#1
        ldrb r5,[r0!],#1
        ldrb r6,[r0!],#1        
        tst r3,r3
        strneb r3,[r1,#0]
        tst r4,r4
        strneb r4,[r1,#1]
        tst r5,r5
        strneb r5,[r1,#2]
        tst r6,r6
        strneb r6,[r1,#3]        
        subs r2, #4
        add r1, #4        
        bge 0b        
      1:adds r2, #4
        beq 9f
      1:ldrb r3,[r0!],#1
        tst r3,r3
        strneb r3,[r1,#0]
        subs r2, #1
        bne 1b
      9:    
  end asm  
  MTDB += (timer-TMR)
  
  put(0,0),Imgs,(0,384)-(255,575),pset  
  TMR = timer
  asm
        ldr r0, $ImgPtr
        ldr r1, $ScrPtr
        mov r2, #49152
        mov r3, #0xFF
        subs r2, #8
        blt 1f
      0:ldmia r0 !,{r4,r5}
        ands r6,r3,r4, LSR #00
        strneb r6,[r1,#0]
        ands r6,r3,r4, LSR #08
        strneb r6,[r1,#1]
        ands r6,r3,r4, LSR #16
        strneb r6,[r1,#2]
        ands r6,r3,r4, LSR #24
        strneb r6,[r1,#3]
        ands r6,r3,r5, LSR #00
        strneb r6,[r1,#4]
        ands r6,r3,r5, LSR #08
        strneb r6,[r1,#5]
        ands r6,r3,r5, LSR #16
        strneb r6,[r1,#6]
        ands r6,r3,r5, LSR #24
        strneb r6,[r1,#7]
        subs r2, #8
        add r1, #8       
        bge 0b        
      1:adds r2, #8
        beq 9f
      1:ldrb r3,[r0!],#1
        tst r3,r3
        strneb r3,[r1,#0]
        subs r2, #1
        bne 1b
      9:    
  end asm  
  MTDC += (timer-TMR)
  
  put(0,0),Imgs,(0,384)-(255,575),pset  
  TMR = timer
  asm
        ldr r0, $ImgPtr
        ldr r1, $ScrPtr
        mov r2, #49152
        mov r3, #0xFF
        subs r2, #8
        blt 1f
      0:ldmia r0 !, {r4,r5}
        tst r4,r4
        beq 2f         
        ands r8,r3,r4, LSR #00
        orrne r8,#0x000000FF
        tst r3,r4,    LSR #08
        orrne r8,#0x0000FF00
        tst r3,r4,    LSR #16
        orrne r8,#0x00FF0000
        tst r3,r4,    LSR #24
        orrne r8,#0xFF000000        
        cmp r8,#0xFFFFFFFF
        beq 3f
        ldr r6, [r1]        
        'and r4,r8        
        bic r6,r8
        orr r4,r6
      3:str r4, [r1]
      2:tst r5,r5
        beq 2f         
        ands r8,r3,r5, LSR #00
        orrne r8,#0x000000FF
        tst r3,r5,    LSR #08
        orrne r8,#0x0000FF00
        tst r3,r5,    LSR #16
        orrne r8,#0x00FF0000
        tst r3,r5,    LSR #24
        orrne r8,#0xFF000000        
        cmp r8,#0xFFFFFFFF
        beq 3f
        ldr r6, [r1,#4]        
        'and r5,r8        
        bic r6,r8
        orr r5,r6
      3:str r5, [r1,#4]
      
      2:add r1, #8
        subs r2, #8        
        bge 0b     
        
      1:adds r2, #8
        beq 9f
      1:ldrb r3,[r0!],#1
        tst r3,r3
        strneb r3,[r1,#0]
        subs r2, #1
        bne 1b
      9:    
  end asm  
  MTDD += (timer-TMR)
  
  screenunlock
  locate 1,1: iCount += 1/1000
  print " GCC",csng(MTDA/iCount)
  print " ASM",csng(MTDB/iCount)
  print " OPT",csng(MTDC/iCount)
  print " OPT2",csng(MTDD/iCount)
  print csng(timer)
  screensync
loop
#endif

