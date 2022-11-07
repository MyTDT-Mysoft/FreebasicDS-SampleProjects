#ifdef __FB_NDS__
#include "Modules\fbLib.bas"
#include "Modules\fbgfx.bas"
#else
#include "crt.bi"
chdir "NitroFiles/"
#endif

#include once "fbgfx.bi"
#include once "crt.bi"

dim as integer COUNT,CNT,XX,YY
dim as uinteger CORE
dim as integer PR,PG,PB,DR,DG,DB
dim as integer SV,SC,CR,CG,CB
dim as any ptr MYIMG,BUFIMG
dim as uinteger ptr MYPIX
dim shared as any ptr SCRPTR,BUFPTR,SCRIMG
dim shared as ulongint PIX(15)

#ifdef __FB_NDS__
function ReadFrame(InBuff as any ptr,byref OutBuff as any ptr, byref Buff2 as any ptr) as integer
  #print "DS inline asm"
  const MAXALGS = 4  
  
  dim as ubyte ptr InPTR = inBuff
  static as integer OutOff,InOFF,MaxBits,MaxLen,LastCount
  static as ubyte ptr OutPTR,NextBuff
  dim as integer OutCnt = LastCount
  
  if InBuff = 0 then 
    OutOff=0:InOff=0:NextBuff=0:LastCount=0: return 1
  end if
  
  if OutPTR = 0 then OutPTR = callocate(65536)
  if NextBuff=0 then NextBuff=OutPTR
  OutBuff = NextBuff
  LastCount = ((cuint(NextBuff)-Cuint(OutPTR))+(80*60))
  if LastCount > 65535 then 
    function = LastCount-65535 : Buff2 = OutPTR
  else 
    function = 80*60: Buff2 = 0
  end if
  NextBuff = OutPTR+(LastCount and 65535)
  
  if MaxBits = 0 then
    for CNT as uinteger = 0 to 7
      if (1 shl CNT) >= MAXALGS then
        MAXLEN = 256 shr CNT: MAXBITS = CNT: exit for
      end if
    next CNT
  end if
  
  asm    
    ldr r0, $InPtr        '\
    ldr r1, $OutPtr       '|
    mov r2, $InOff        '|
    mov r3, $OutOff       '| while OutCnt < 80*60
    ldr r7, $OutCnt       '|
    0: cmp r7, #(80*60)   '|
    bge 9f                '/
    ldrb r5, [r0,r2]    'dim as uinteger ALGO = INPTR[INOFF]
    mov r6,r5, lsr #2     'dim as uinteger REPCNT = ALGO shr MAXBITS
    ands r5, #3         '\ALGO and= ((1 shl MAXBITS)-1): INOFF += 1    
    add r2, #1          '/
    add r7,r6             ' OutCnt += REPCNT
    beq 5f              'select case ALGO {0}
    adds r5, #-1           '\ {1}
    beq 6f                 '/
    adds r5, #-1        '\ {2}
    beq 7f              '/
    '-----------------------------------------------------------------
    8:                    'case 3 ' 3 = X bytes same as -Y7/15 offset
    ldrb r5, [r0,r2]    '\ PARM = INPTR[INOFF]:INOFF += 1: 
    add r2, #1          '/
    tst r5, #128          '\ if (PARM and 128) then
    beq 1f                '/
    ldrb r4, [r0,r2]    '\ DISP = ((DISP) shl 8)+INPTR[INOFF]
    add r4,r5, lsl #8   '/
    neg r5,r4             ' DISP = -DISP
    add r2, #1          ' INOFF += 1
    1: sub r5,r3,r5       '\
    mov r4, #-1           '| DISP = (OUTOFF-DISP) and 65535
    and r5,r4, lsr #16    '/
    add r4,r3, r6
    cmp r4,#65536
    bge 1f    
    2:                  ' for CNT as integer = 0 to REPCNT-1
    ldrb r4, [r1,r5]      '\
    strb r4, [r1,r3]      '|
    add r5, #1            '| OUTPTR[OUTOFF]=OUTPTR[(DISP+CNT) and 65535]
    bic r5, #65536      '\ OUTOFF = (OUTOFF+1) and 65535
    add r3, #1          
    adds r6, #-1          '\
    beq 0b                '/ next CNT
    ldrb r4, [r1,r5]      '\
    strb r4, [r1,r3]      '|
    add r5, #1            '| OUTPTR[OUTOFF]=OUTPTR[(DISP+CNT) and 65535]
    bic r5, #65536      '\ OUTOFF = (OUTOFF+1) and 65535
    add r3, #1          
    adds r6, #-1          '\
    beq 0b                '/ next CNT
    ldrb r4, [r1,r5]      '\
    strb r4, [r1,r3]      '|
    add r5, #1            '| OUTPTR[OUTOFF]=OUTPTR[(DISP+CNT) and 65535]
    bic r5, #65536      '\ OUTOFF = (OUTOFF+1) and 65535
    add r3, #1          
    adds r6, #-1          '\
    beq 0b                '/ next CNT
    ldrb r4, [r1,r5]      '\
    strb r4, [r1,r3]      '|
    add r5, #1            '| OUTPTR[OUTOFF]=OUTPTR[(DISP+CNT) and 65535]
    bic r5, #65536
    add r3, #1          '\ OUTOFF = (OUTOFF+1) and 65535
    adds r6, #-1          '\
    bne 2b                '/ next CNT
    b 0b                'end select
    
    1:                  ' for CNT as integer = 0 to REPCNT-1
    ldrb r4, [r1,r5]      '\
    strb r4, [r1,r3]      '|
    add r5, #1            '| OUTPTR[OUTOFF]=OUTPTR[(DISP+CNT) and 65535]
    bic r5, #65536        '/
    add r3, #1          '\
    bic r3, #65536      '/ OUTOFF = (OUTOFF+1) and 65535
    adds r6, #-1          '\
    bne 1b                '/ next CNT
    b 0b                'end select
    '-----------------------------------------------------------------
    5:                    'case 0 ' 0 = not compressed X bytes
    ldrb r5, [r0,r2]    '\ for CNT as integer = 1 to REPCNT
    strb r5, [r1,r3]    '/ OUTPTR[OUTOFF] = INPTR[INOFF]
    add r3, #1            '\
    add r2, #1            '| INOFF += 1: OUTOFF = (OUTOFF+1) and 65535
    bic r3, #65536        '/
    adds r6, #-1        '\
    bne 5b              '/ next CNT
    b 0b                  'end select
    '-----------------------------------------------------------------
    6:                    'case 1 ' 1 = X repeated Y8 bytes
    ldrb r5, [r0,r2]    '\ PARM = INPTR[INOFF]:INOFF += 1: 
    add r2, #1          '/
    1:                    'for CNT as integer = 1 to REPCNT
    strb r5, [r1,r3]    ' OUTPTR[OUTOFF] = PARM
    add r3, #1            ' \
    bic r3, #65536        ' / OUTOFF = (OUTOFF+1) and 65535
    adds r6, #-1        '\
    bne 1b              '/ next CNT
    b 0b                  'end select
    '-----------------------------------------------------------------
    7:                    'case 2 ' 2 = X bytes from Y8 adding Z8
    ldrb r5, [r0,r2]    '\ PARM = INPTR[INOFF]:INOFF += 1
    add r2, #1          '/
    ldrb r4, [r0,r2]      '\ PARM2 = INPTR[INOFF]:INOFF += 1 
    add r2, #1            '/
    strb r4, [r1,r3]    ' OUTPTR[OUTOFF] = PARM2
    add r3, #1            ' \
    bic r3, #65536        ' / OUTOFF = (OUTOFF+1) and 65535
    1:                  'for CNT as integer = 1 to REPCNT
    add r4,r5             'PARM2 += PARM
    strb r4, [r1,r3]    ' OUTPTR[OUTOFF] = PARM2
    add r3, #1            ' \
    bic r3, #65536        ' / OUTOFF = (OUTOFF+1) and 65535
    adds r6, #-1        '\
    bne 1b              '/ next CNT
    b 0b                  'end select
    '-----------------------------------------------------------------
    9: mov $InOff, r2    '\
    str r7, $OutCnt      '|
    mov $OutOff, r3      '/ wend
  end asm  
  
  LastCount = OutCnt-80*60
  
end function
#else
function ReadFrame(InBuff as any ptr,byref OutBuff as any ptr, byref Buff2 as any ptr) as integer
  
  const MAXALGS = 4  
  
  dim as ubyte ptr InPTR = inBuff
  static as uinteger OutOff,InOFF,MaxBits,MaxLen,LastCount
  static as ubyte ptr OutPTR,NextBuff
  dim as uinteger OutCnt = LastCount
    
  if InBuff = 0 then 
    OutOff=0:InOff=0:NextBuff=0:LastCount=0: return 1
  end if
  
  if OutPTR = 0 then OutPTR = callocate(65536)
  if NextBuff=0 then NextBuff=OutPTR
  OutBuff = NextBuff
  LastCount = ((cuint(NextBuff)-Cuint(OutPTR))+(80*60))
  if LastCount > 65535 then 
    function = LastCount-65535 : Buff2 = OutPTR
  else 
    function = 80*60: Buff2 = 0
  end if
  NextBuff = OutPTR+(LastCount and 65535)
  
  if MaxBits = 0 then
    for CNT as uinteger = 0 to 7
      if (1 shl CNT) >= MAXALGS then
        MAXLEN = 256 shr CNT: MAXBITS = CNT: exit for
      end if
    next CNT
  end if  
  
  while OutCnt < 80*60
    dim as uinteger ALGO = INPTR[INOFF]
    dim as uinteger REPCNT = ALGO shr MAXBITS
    dim as ubyte PARM,PARM2
    ALGO and= ((1 shl MAXBITS)-1): INOFF += 1    
    OutCnt += REPCNT
    select case ALGO
    case 0 ' 0 = not compressed X bytes
      for CNT as integer = 1 to REPCNT
        OUTPTR[OUTOFF] = INPTR[INOFF]
        INOFF += 1: OUTOFF = (OUTOFF+1) and 65535
      next CNT
    case 1 ' 1 = X repeated Y8 bytes
      PARM = INPTR[INOFF]:INOFF += 1: 
      for CNT as integer = 1 to REPCNT
        OUTPTR[OUTOFF] = PARM: OUTOFF = (OUTOFF+1) and 65535
      next CNT
    case 2 ' 2 = X bytes from Y8 adding Z8
      PARM = INPTR[INOFF]:INOFF += 1
      PARM2 = INPTR[INOFF]:INOFF += 1      
      OUTPTR[OUTOFF]=PARM2: OutCnt += 1
      OUTOFF = (OUTOFF+1) and 65535
      for CNT as integer = 1 to REPCNT
        PARM2 += PARM: OUTPTR[OUTOFF] = PARM2
        OUTOFF = (OUTOFF+1) and 65535
      next CNT
    case 3 ' 3 = X bytes same as -Y7/15 offset
      dim as uinteger DISP
      DISP = INPTR[INOFF]:INOFF += 1      
      if (DISP and 128) then       
        DISP = ((DISP) shl 8)+INPTR[INOFF]
        INOFF += 1: DISP = -DISP      
      end if 
      DISP = (OUTOFF-DISP) and 65535
      for CNT as uinteger = 0 to REPCNT-1
        OUTPTR[OUTOFF]=OUTPTR[DISP]        
        DISP = (DISP+1) and 65535
        OUTOFF = (OUTOFF+1) and 65535
      next CNT
    end select
  wend   
   
  LastCount = OutCnt-80*60
  
end function
#endif

sub Sync()
  
  const BorderY = ((192-(60*3)))
  const BorderX = ((256-(80*3)))
  const SourcePitch = 80-80
  
  dim as ubyte ptr scrptr2 = scrptr + ((BorderY\2)*256) + (BorderX\2)
  dim as ubyte ptr buffptr = bufptr
    
  #ifdef __FB_NDS__
  asm
    ldr r0, $buffptr       'r0 = source pointer
    ldr r1, $scrptr2       'r1 = screen pointer
    mov r2, #60            'r2 = 60 lines counter
    0: mov r3, #80         'r3 = 80 columns counter
    1: ldrb r4, [r0]       'load a byte from source
    strb r4,[r1]           '\
    strb r4,[r1,#1]        '| store it 3 times on screen
    strb r4,[r1,#2]        '/
    add r1, #3             '3 bytes stored
    add r0, #1             '1 byte read
    adds r3, #-1           '1 source pixel done
    bne 1b                 'continue while there's pixels in the line
    add r1, #16            'adjust border to begin of line
    mov r3, #15            'copying 60 words
    1: ldr r4,[r1,#-256]   'loading 4 target pixels from previous line
    ldr r5,[r1,#-252]      'loading 4 target pixels from previous line
    ldr r6,[r1,#-248]      'loading 4 target pixels from previous line
    ldr r7,[r1,#-244]      'loading 4 target pixels from previous line
    str r4,[r1]            'storing 4 target pixels on current line
    str r5,[r1,#4]         'storing 4 target pixels on current line
    str r6,[r1,#8]         'storing 4 target pixels on current line
    str r7,[r1,#12]        'storing 4 target pixels on current line
    str r4,[r1,#256]       'storing 4 target pixels on next line
    str r5,[r1,#260]       'storing 4 target pixels on next line
    str r6,[r1,#264]       'storing 4 target pixels on next line
    str r7,[r1,#268]       'storing 4 target pixels on next line
    add r1, #16            '4 target pixels read
    adds r3, #-1           '1 word done
    bne 1b                 'continue until all words are done
    add r1,#(512-240)      'align to start of next target line
    adds r2, #-1           'one line dine
    bne 0b                 'continue until all lines are done
  end asm    
  #else
  for Y as integer = 0 to 59
    for X as integer = 0 to 79
      scrptr2[0] = *buffptr: scrptr2[1] = *buffptr: scrptr2[2] = *buffptr
      scrptr2 += 3: buffptr += 1      
    next X
    scrptr2 += borderx        
    memcpy(scrptr2,scrptr2-256,80*3)
    memcpy(scrptr2+256,scrptr2,80*3)
    scrptr2 += 512
  next Y
  #endif
  
end sub

for COUNT = 1 to 15
  PIX(COUNT) = PIX(COUNT-1)+&h0101010101010101
next COUNT

screenres 256,192
palette 0,255,85,255
palette 13,0,0,0
line(0,0)-(255,191),13,bf

dim as uinteger MyBuff((80*60+sizeof(fb.image)) shr 2)

BUFPTR = ImageCreate(80,60,,8):BUFIMG = @MyBuff(0)
memcpy(BUFIMG,BUFPTR,sizeof(fb.image))
imageDestroy(BUFPTR)
SCRPTR = screenptr
BUFPTR = BUFIMG+sizeof(fb.image)

dim as integer VideoFile = freefile()
open "Frames.rlx" for binary access read as #VideoFile
dim as integer VideoSz = lof(1),VCount=168
dim as ubyte ptr pVideo = callocate(VideoSz)
get #VideoFile,1,*pVideo,VideoSz
close #VideoFile

dim as double BT,TMAX,TMR
dim as integer Frame,DoSync=1

screensync
BT = timer
do
  ReadFrame(0,0,0) 
  for COUNT = 1 to 7589
    dim as any ptr BUFF1,BUFF2    
    TMR = timer
    dim as integer Resu = ReadFrame(pVideo,BUFF1,BUFF2)
    'printf(!"Resu %i \n",Resu)
    if Resu <> 80*60 then
      dim as integer Inv = (80*60)-Resu+1        
      memcpy(BUFPTR,BUFF1,Inv)
      memcpy(BUFPTR+Inv,BUFF2,Resu)        
    else          
      memcpy(BUFPTR,BUFF1,Resu)      
    end if      
    #ifdef __FB_NDS__
    Sync()    
    #else
    screenlock        
    Sync()    
    screenunlock    
    #endif
    TMR = timer-TMR
    if DoSync then screensync
    'var tempcnt = *cptr(ushort ptr,&h4000004)
    '*cptr(ushort ptr,&h4000004) = (tempcnt and 255) or (VCount shl 8)
    dim as string KEY = inkey$
    if len(KEY) then
      #ifdef __FB_NDS__
      if KEY[1] = fb.SC_ButtonX then DoSync xor= 1:TMAX=0
      #else
      if KEY[0] = 13 then DoSync xor= 1
      #endif
    end if   
    if multikey(1) then end 
    Frame += 1
    if TMR > TMAX then TMAX = TMR
    if (timer-BT) >= .5 then        
      printf(!"%i fps (%g ms) %i  \r",Frame*2,TMAX*1000,DoSync)
      BT = timer: Frame = 0
    end if  
    
  next COUNT
loop

sleep