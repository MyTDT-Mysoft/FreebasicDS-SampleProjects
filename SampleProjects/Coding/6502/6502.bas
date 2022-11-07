'#cmdline "-gen gcc -Wc '-Ofast -march=native -mtune=native'"
'#cmdline "-maxerr 1"

#ifdef __FB_NDS__
  #define __FB_NITRO__
  '#define __FB_PRECISE_TIMER__
  #define __FB_GFX_NO_GL_RENDER__
  #define __FB_GFX_NO_16BPP__
  #define __FB_GFX_NO_OLD_HEADER__
  '#define __FB_NO_NITRO__
  '#define __FB_CALLBACKS__
  #include "Modules\fbLib.bas"
  #include "Modules\fbgfx.bas"
  '#include "Modules\wshelper.bas"
  '#include "Modules\fmod.bas"
#else
  #include "fbgfx.bi"  
  #include "crt.bi"
  chdir "NitroFiles/"
#endif

#ifdef __FB_WIN32__
  #include "Windows.bi"
#endif

#include "file.bi"
#include "fbgfx.bi"

#define MultiThread
#define SpeedBench

#ifndef __FB_NDS__
  #define CpuNotifyRead
  #define CpuNotifyWrite
#endif

#ifdef __FB_NDS__
  #undef MultiThread
#endif

#ifdef __FB_NDS__
  #define AlignedOnly
  #undef WaitKey
  #define width2() (&h00180020)  
  #include "6502-gfx-dll.bas"
#else
  #define width2() width()
  #inclib "6502-gfx-dll"
  #inclib "6502-view-dll"  
#endif

#undef bool
type bool as byte

#ifndef __FB_NDS__
  namespace gfx
    declare sub      InitScreen(bOnTop as byte=false)
    declare sub      ScreenPos( iX as integer , iY as integer )
    declare sub      CloseScreen()
    declare function ReadKey() as long
    declare sub      UpdateScreen( pPix as ubyte ptr )
    declare function IsScreenOpen() as long
  end namespace
  namespace viewer
    declare sub      OpenScreen(bOnTop as byte = false)
    declare sub      ScreenPos( iX as integer , iY as integer )
    declare sub      CloseScreen()
    declare function ProcessKeys() as long
    declare sub      UpdateViewHelp( iPage as long )
    declare sub      UpdateViewHex( pbMem as ubyte ptr , pbChanges as byte ptr , uAddress as long , bForce as byte = 0 )
    declare sub      UpdateViewSource( pbSource as zstring ptr , plIndex as ulong ptr , pwAddr as ushort ptr , uLineCount as ulong , uViewLine as long )
    declare sub      UpdateViewDisasm( pbMem as ubyte ptr , uAddress as long )
    declare sub      UpdateViewSymbols( ptLabel as any ptr , iLabelCount as long , iLabelView as long )
    declare sub      UpdateViewText( pbMem as ubyte ptr , uAddress as long )
    declare function IsScreenOpen() as long
  end namespace
#endif

enum ViewMode
  vmNone
  vmHelp
  vmHex
  vmSource
  vmDisasm
  vmSymbols
  vmText
  vmLast
end enum

static shared as long g_uHexView = 0   , g_uTextView = &hF000
static shared as long g_uLabelView = 0 , g_uDisasmView = &h600
static shared as long g_bBreakPoint = -1  , g_bBreakPoint2 = -1
static shared as bool g_bFinished , g_GfxFocus
static shared as byte g_bViewMode = vmNone
static shared as longint uTotalCycles, uTotalCycles2

declare function WaitKey() as long
declare sub UpdateCurrentView( bForce as bool = false )
declare sub ShowStatus()

#include "6502-asm.bas"
#include "6502-dis.bas"
#include "6502-cpu2x.bas"

using cpu

sub DragWindow(bForce as bool=false)
  #ifdef __FB_WIN32__
    dim as HWND hCon = GetConsoleWindow()
    dim as RECT tRC = any : GetWindowRect(hCon,@tRC)
    static as long OldX = -1000 , OldY = 1000
    if bForce then OldX = -1000 : OldY = 1000
    if OldX <> tRc.left or OldY <> tRc.top then
      OldX = tRc.left : OldY = tRc.top  
      gfx.ScreenPos(tRC.right-37*8,tRc.bottom-36*8)
      viewer.ScreenPos(tRc.right,tRc.top)
    end if
  #endif
end sub

#ifdef __FB_CALLBACKS__
  sub VsyncCallback( pValue as any ptr )
    with g_tCpu
      if .iCyclesMS >= 8192 then .bSleep = -1 : .bBreak = 1
    end with
  end sub
  fb_AddVsyncCallBack(@VsyncCallback,0,True)    
#endif

#ifdef MultiThread
  static shared as any ptr g_pUpdateMutex , g_ConsoleMutex
  g_pUpdateMutex = MutexCreate()
  g_ConsoleMutex = MutexCreate()
  
  #define _LockConsole   Mutexlock(g_ConsoleMutex)
  #define _UnlockConsole Mutexunlock(g_ConsoleMutex)
  #define _LockUpdate    Mutexlock(g_pUpdateMutex)
  #define _UnlockUpdate  Mutexunlock(g_pUpdateMutex)
  
  sub Async_Update( Dummy as any ptr )
    #ifdef SetThreadPriority
      SetThreadPriority( GetCurrentThread() , THREAD_PRIORITY_TIME_CRITICAL )      
    #endif
    do
      if g_tCpu.bRun andalso g_tCpu.bDebug=0 then
        sleep 15,1
        _LockUpdate
          if g_tCpu.bRun=0 orelse g_tCpu.bDebug then
            _UnlockUpdate : continue do
          end if
          UpdateCurrentView()
          gfx.UpdateScreen( @g_bMemory(&h200) )        
        _UnlockUpdate
        _LockConsole
          if g_tCpu.bRun=0 orelse g_tCpu.bDebug then
            _UnlockConsole : continue do
          end if
          ShowCPU(g_tCpu)
        _UnlockConsole        
      else
        sleep 100,1
      end if      
    loop until g_tCpu.bDone
  end sub
  var hUpdateThread = ThreadCreate( @Async_Update , 0 )
#else
  #define _LockConsole    
  #define _UnlockConsole    
  #define _LockUpdate
  #define _UnlockUpdate
#endif

#define KeyToView( _vm ) (-((fb.SC_F1-1)+(_vm) ))

sub ShowStatus()
  _LockConsole
  var iConW = width2(), iConH = hiword(iConW) : iConW = loword(iConW)    
  var iRow = csrlin() , iCol = pos()
  #ifdef __FB_NDS__
    view print 1 to 24 : locate iConH,1 : color 14,1  
  #else
    view print : locate iConH,1 : color 14,1  
  #endif
  #ifdef __FB_NDS__
    if g_tCpu.bDebug then
      printf("Asm Run Step Break Jump View   ")
    else
      printf("Asm Run Pause View Dbg (0-9)Spd")
    end if
  #else
    if g_tCpu.bDebug then
      printf("%s",left("(A)ssembly (R)un (S)tep (B)reakpoint (J)ump (V)iew"+space(iConW),iConW-1))
    else
      printf("%s",left("(A)ssembly (R)un (P)ause (V)iew (D)ebug (0-9) Speed"+space(iConW),iConW-1))
    end if
  #endif
  #ifdef __FB_NDS__
    color 7,0 : view print 3 to 13
  #else
    color 7,0 : view print 3 to iConH-1
  #endif
  locate iRow,iCol : color 7,0  
  _UnlockConsole
end sub
sub FocusConsole()
  #ifdef SetForegroundWindow
    SetForegroundWindow(GetConsoleWindow())
  #endif
end sub
function ReadKey() as long
  var sKey = inkey
  if len(sKey) then
    dim as long iKey = sKey[0]
    if iKey=255 then iKey = -sKey[1]
    return iKey
  end if
  return 0
end function
sub UpdateCurrentView( bForce as bool = false )
  #ifndef __FB_NDS__
  select case g_bViewMode
  case vmHelp
    Viewer.UpdateViewHelp( 0 )
  case vmHex     'Hexadecimal Display
    viewer.UpdateViewHex( @g_bMemory(0) , @g_bMemChg(0) , g_uHexView , bForce )
  case vmSource  'Source code Display
    with g_tCpu
      var iLine = g_lPosition(.RegPC)
      if iLine >= 0 then
        var pbSource = cptr(zstring ptr,@g_tParser.sCode[0])
        Viewer.UpdateViewSource( pbSource , @g_lLineIndex(0) , @g_wLineAddr(0) , g_tParser.iLineNum , iLine )                
      end if
    end with
  case vmDisasm  'Disassembler Display
    viewer.UpdateViewDisasm( @g_bMemory(0) , g_uDisasmView )
  case vmSymbols 'Source symbols Display
    viewer.UpdateViewSymbols( @g_tLabel(0) , g_iLabelsCount , g_uLabelView )    
  case vmText    'Virtual Console
    viewer.UpdateViewText( @g_bMemory(0) , g_uTextView )
  end select
  #endif
end sub
sub HandleViewKeys(iKey as long)  
  #ifndef __FB_NDS__
    'if Viewer.ProcessKeys()=0 then 
    ' g_bViewMode = vmNone
    '  Viewer.CloseScreen()
    'else  
      select case iKey
      case -fb.SC_F12
        g_bViewMode = vmNone
        if viewer.IsScreenOpen() then viewer.CloseScreen()
      case -(fb.SC_F1+vmLast-2) to -fb.SC_F1
        g_bViewMode = (-iKey)-fb.SC_F1+1      
        if viewer.IsScreenOpen() = 0 then viewer.OpenScreen() : DragWindow(true) : FocusConsole()
        UpdateCurrentView(true)
      case asc("v") 'View Mode +
        g_bViewMode = (g_bViewMode+1) mod vmLast
        if g_bViewMode = 0 andalso viewer.IsScreenOpen() then viewer.CloseScreen()
        if g_bViewMode andalso viewer.IsScreenOpen() = 0 then viewer.OpenScreen() : DragWindow(true) : FocusConsole()
        if g_bViewMode then UpdateCurrentView(true)
      case asc("V") 'View Mode -
        g_bViewMode = (vmLast+g_bViewMode-1) mod vmLast
        if g_bViewMode = 0 andalso viewer.IsScreenOpen() then viewer.CloseScreen()
        if g_bViewMode andalso viewer.IsScreenOpen() = 0 then viewer.OpenScreen() : DragWindow(true) : FocusConsole()
        UpdateCurrentView(true)
      case -fb.SC_UP          'Scroll View UP
        select case g_bViewMode
        case vmHex    : if g_uHexView    > 0 then g_uHexView    -= 16 : UpdateCurrentView(true)
        case vmDisasm 
          dim as long uTgt(3), uMax, uLen = 1
          if g_uDisasmView > 0 then 
            for N as long = 1 to 16 
              var uAddr = g_uDisasmView-N , uLenChk = 0
              if uAddr <= 0 then exit for
              do
                uLenChk = abs(g_LenDisasm( g_bMemory(uAddr)))
                uAddr += uLenChk
              loop until uAddr >= g_uDisasmView
              if g_uDisasmView = uAddr then
                uTgt(uLenChk) += 1
                if uTgt(uLenChk) > uMax then
                  uMax = uTgt(uLenChk) : uLen = uLenChk
                end if
              end if
            next N
            g_uDisasmView -= uLen  : UpdateCurrentView(true)
          end if
        case vmText   : if g_uTextView   > 0 then g_uTextView   -= 40 : UpdateCurrentView(true)
        case vmSymbols: if g_uLabelView  > 0 then g_uLabelView  -=  1 : UpdateCurrentView(true) 
        end select
      case -fb.SC_DOWN        'Scroll View Down
        select case g_bViewMode
        case vmhex    : if cuint(g_uHexView)    < (65536-(16*16)) then g_uHexView    += 16 : UpdateCurrentView(true)
        case vmDisasm 
          if cuint(g_uDisasmView) < (65536-(16*3)) then 
            g_uDisasmView += abs(g_LenDisasm( g_bMemory(g_uDisasmView)))
            UpdateCurrentView(true)
          end if
        case vmText   : if cuint(g_uTextView)   < (65536-(40*16)) then g_uTextView   += 40 : UpdateCurrentView(true)
        case vmSymbols: if g_uLabelView < (g_iLabelsCount-15)    then g_uLabelView   +=  1 : UpdateCurrentView(true)
        end select
      end select
    'end if
  #endif
end sub
function HandleKeys() as byte
  
  DragWindow()
  
  #ifdef __FB_NDS__
    #define _KeyMenu_ 9,-fb.SC_ButtonSelect
    #define _KeyMenuAct_ multikey(fb.SC_ButtonStart)    
    static as long iKeyA=asc("d"),iKeyB=asc("s"),iKeyX=asc("w"),iKeyY=asc("a")
    static as long iKeyL=asc("q"),iKeyR=asc("e")
    static as long iKeyLt=-fb.SC_LEFT,iKeyRt=-fb.SC_RIGHT,iKeyUp=-fb.SC_UP,iKeyDn=-fb.SC_DOWN
  #else
    #define _KeyMenu_ 9
    #define _KeyMenuAct_ 0
    if Viewer.ProcessKeys()=0 then 
      g_bViewMode = vmNone
      Viewer.CloseScreen()
    end if
  #endif
  
  #ifdef __FB_NDS__
  if g_tCpu.bDebug = 0 andalso g_tCpu.bRun = 0 then g_GfxFocus = false  
  if g_GfxFocus = false orelse _KeyMenuAct_ then
  #endif
    with g_tCpu
      if .bDebug = 0 then        
        do
          var iKey = ReadKey()
          if iKey = 0 then exit do
          #ifdef __FB_NDS__
            #define CheckKey(_V,_K) if multikey(fb.sc##_K) andalso iKey <> -fb.sc##_K then _V = iKey
            CheckKey(iKeyA,_ButtonA)
            CheckKey(iKeyB,_ButtonB)
            CheckKey(iKeyX,_ButtonX)
            CheckKey(iKeyY,_ButtonY)
            CheckKey(iKeyL,_ButtonL)
            CheckKey(iKeyR,_ButtonR)
            CheckKey(iKeyLt,_ButtonLeft)
            CheckKey(iKeyRt,_ButtonRight)
            CheckKey(iKeyUp,_ButtonUp)
            CheckKey(iKeyDn,_ButtonDown)
          #endif
          
          select case iKey
          #ifdef __FB_NDS__
          case _KeyMenu_
            if .bRun then
              color 14: puts("Menu is now deactivated")
              g_GfxFocus = true
            end if
          #endif
          case 27, -asc("k")         'ESC/X = quit
            return 0 
          case asc("0")              'Max Speed
            #ifdef __FB_NDS__
            .iCyclesMS = 2^14
            _LockConsole
            color 10: printf("Speed: UNLIMITED instructions/ms")
            #else
            .iCyclesMS = 2^18
            _LockConsole
            color 10: puts("Speed: UNLIMITED instructions/ms?")
            #endif
            _UnlockConsole
          case asc("1") to asc("9")
            .iCyclesMS = 1 shl (4+iKey-asc("1"))
            _LockConsole
            color 10: printf(!"Speed: %i instructions/ms\n",.iCyclesMS)
            _UnlockConsole
          case asc("a"),asc("A")  'Assembly
            return 2
          case asc("r"),asc("R")  'Run
            if g_bFinished orelse .bRun then 
              ResetCPU(g_tCpu) 
              memset(@g_bMemory(&h200),0,32*32)
              memset(@g_bMemChg(&h200),1,32*32)
              g_bFinished = 0 : g_GfxFocus = true
              _LockConsole
              color 10
              if .bRun then puts("CPU Reseted!") else puts("Emulation Started!")
              _UnlockConsole
            else
              _LockConsole
              color 10 : puts("Emulation Resumed!")
              _UnlockConsole
            end if
            
            .bRun = true
          case asc("p"),asc("P")  'Pause
            if .bRun then
              _LockConsole
              color 14 : puts("Emulation paused!")
              _UnlockConsole
              .bRun = false
            end if
          case asc("d"),asc("D")  'Debug
            _LockConsole
              color 10 : puts("Entering Debug Mode")
            _UnlockConsole
            .bDebug = true : .bRun = false : sleep 50,1
            if g_bViewMode = vmNone then
              HandleViewKeys( KeyToView(vmSource) )
            end if
            g_bBreakPoint = -1          
            DragWindow(true)          
            ShowStatus()
          case else
            HandleViewKeys( iKey )
          end select
        loop
      end if
    end with
  #ifdef __FB_NDS__
  end if
  #endif
  
  do
    #ifdef __FB_NDS__
      var iKey = iif(g_GfxFocus,ReadKey(),0)      
      #define CheckKey(_V,_K) -fb.sc##_K : iKey = _V
      select case iKey
      case CheckKey(iKeyA,_ButtonA)
      case CheckKey(iKeyB,_ButtonB)
      case CheckKey(iKeyX,_ButtonX)
      case CheckKey(iKeyY,_ButtonY)
      case CheckKey(iKeyL,_ButtonL)
      case CheckKey(iKeyR,_ButtonR)
      case CheckKey(iKeyLt,_ButtonLeft)
      case CheckKey(iKeyRt,_ButtonRight)
      case CheckKey(iKeyUp,_ButtonUp)
      case CheckKey(iKeyDn,_ButtonDown)
      case _KeyMenu_
        color 14: puts("Menu is now activated!")
        g_GfxFocus = false
      end select
    #else
      var iKey = gfx.ReadKey()
    #endif
    if iKey = 0 then exit do
    g_bMemory(&hFF) = iKey
    NotifyWrite8(&hFF)
  loop
  
  return 1
  
end function
function WaitKey() as long  
  ShowCPU(g_tCpu)
  gfx.UpdateScreen( @g_bMemory(&h200) )  
  do
    HandleKeys()
    #ifndef __FB_NDS__
    if Viewer.ProcessKeys()=0 then 
      g_bViewMode = vmNone
      Viewer.CloseScreen()
    end if
    #endif
    var iKey = ReadKey()
    if iKey then return iKey    
    sleep 50,1
  loop
end function

#ifdef __FB_NDS__
  dim as string sAsmFile = "sample/Compo1st.asm" 
#else
  dim as string sAsmFile = command$
  sAsmFile = "sample/Compo1st.asm"
  'sAsmFile = "sample/byterun.asm"
  if FileExists(sAsmFile)=0 then
    color 12: printf("%s","Syntax: 6502 file.asm")
    end 0
  end if
#endif

gfx.InitScreen(true)
'viewer.OpenScreen(true)
ShowStatus()
FocusConsole()

#if 0
  scope
    var hWnd = GetConsoleWindow()
    SetWindowPos( hWnd , HWND_TOPMOST	, 0,0 , 0,0 , SWP_NOMOVE or SWP_NOSIZE )
  end scope
#endif

do
  dim as long bSteps = 1 , iLimit = 0
  dim as bool bCanRun = 0 
  
  g_bFinished = 1 : g_bBreakPoint = -1
  
  scope 'assembly
    
    _LockConsole        
    #ifdef __FB_NDS__
      view print 1 to 24
    #else
      view print 
    #endif    
    #ifdef __FB_NDS__
    scope
      static as byte iPrevQuery = -1
      fbKeyboard->offset_y = -192-32+fb.KeyboardOffset
      KeyboardShow() 
      cls
      static as zstring*64 sFileArr(40-1)
      var sFile = dir("sample/*.asm") , iFile = 0 , iQuery = 0        
      while len(sFile)
        locate 1+(iFile mod 16),1+(iFile\16)*16 
        sFileArr(iFile) = sFile : sFile[instr(sFile,".asm")-1]=0
        color iif(iFile and 1,10,11) : printf("%i)",iFile)
        color iif(iFile and 1, 2, 3) : printf("%s",sFile) 
        iFile += 1 : sFile = dir()
      wend
      
      do
        dim as string sQuery
        locate 18,1: print "File #";: input sQuery
        if len(sQuery)=0 andalso iPrevQuery <> -1 then 
          iQuery = iPrevQuery          
        else
          iQuery = valint(sQuery)
          
        end if
      loop while cuint(iQuery) >= iFile
      
      iPrevQuery = iQuery
      'print iQuery
      sAsmFile = "sample/"+sFileArr(iQuery)        
      'print sFileArr(iQuery)
      'sleep
      fbKeyboard->offset_y = -192+8+fb.KeyboardOffset
      KeyboardShow()
      while len(inkey) : wend        
      'ShowStatus() : view print 1 to 24
    end scope
    #endif
    color 7,0 : cls : locate 2,1,0 
    color 15 : puts(sAsmFile)
    
    _UnlockConsole  
    
    ShowStatus()
    _LockConsole    
    '#ifdef __FB_NDS__
    '  view print 3 to 13
    '#else
    '  view print 3 to hiword(width2())-1
    '#endif   
    
    color 10: puts("Assembling... ")
    _UnlockConsole
    
    if Assemble(sAsmFile) then 
      _LockConsole
      color 11 : bCanRun = 1
      printf(!"Assembly: %i bytes, %i lines\n",g_tParser.iTotalSz,g_tParser.iLineNum)
      _UnlockConsole
    end if
      
    ResetCPU(g_tCpu) : ShowCPU(g_tCpu)
    uTotalCycles = 0 : uTotalCycles2 = 0
    
    _LockUpdate
    UpdateCurrentView(true)
    gfx.UpdateScreen( @g_bMemory(&h200) )
    _UnlockUpdate
    
  end scope
  
  with g_tCpu    
    do
      #ifndef MultiThread
        static as double dLimit
        for N as long = 0 to 1
          if (timer-dLimit) >= 1/60 then
            static as byte bSwap : bSwap xor= 1
            if bSwap then
              if .bDebug then ShowCPU(g_tCpu)
              UpdateCurrentView()
              DragWindow()
            else              
              gfx.UpdateScreen( @g_bMemory(&h200) )
            end if
            dLimit += 1/60
          end if
        next N
        if abs(timer-dLimit) > .5 then dLimit = timer
      #endif
      _LockUpdate
      
      select case HandleKeys()
      case 0 :
        _UnlockUpdate
        .bDone = 1 : exit do,do     'quit
      case 2                        're-assembly
        _UnlockUpdate
        continue do,do       
      end select
            
      if .bDebug then        
        g_GfxFocus = true
        for N as long = bSteps-1 to 0 step-1
          .bOpcode = g_bMemory(.RegPC) 
          if N = 0 orelse cint(.RegPC) = g_bBreakPoint then
            if cint(.RegPC) = g_bBreakPoint then
              _LockConsole
              color 10 : puts("Breakpoint reached!")
              _UnlockConsole
              g_bBreakPoint = -1
            end if            
            UpdateCurrentView() : g_GfxFocus = false
            N = 0 : DisasmInstruction(type<long>(.RegPC))            
            gfx.UpdateScreen( @g_bMemory(&h200) )            
            do              
              var iKey = iif(g_bBreakPoint>=0,ReadKey(),WaitKey())              
              select case iKey
              case 0
                bSteps = 16384 : exit do
              case asc("s"),asc("S")
                g_bBreakPoint = -1
                if bCanRun then bSteps = 1   : exit do              
              case asc("w"),asc("W")
                g_bBreakPoint = -1
                if bCanRun then bSteps = 10  : exit do
              case asc("x"),asc("X"),-31
                g_bBreakPoint = -1
                if bCanRun then bSteps = 100 : exit do
              case asc("b"),asc("B") 'breakpoint
                if bCanRun then 
                  dim as string sBreak : g_bBreakPoint = -1
                  _LockConsole
                  color 14 : input "Breakpoint where"; sBreak
                  sBreak = trim(sBreak)
                  if len(sBreak) then
                    if sBreak[0] = asc("$") then
                      g_bBreakPoint = valint("&h"+mid(sBreak,2))
                    elseif sBreak[0] = asc("#") then
                      g_bBreakPoint = valint(mid(sBreak,2))
                    else
                      g_bBreakPoint = valint("&h"+sBreak)
                    end if
                    if cuint(g_bBreakPoint) > 65535 then
                      color 12 : puts("Invalid address for breakpoint")
                      g_bBreakPoint = -1
                    else
                      color 13 : printf(!"Breakpoint set to $%04X\n",g_bBreakPoint)
                    end if
                  else
                    color 13 : puts("Breakpoint cleared")
                  end if
                  _UnlockConsole
                end if
              case asc("j"),asc("J") 'jump
                if bCanRun then 
                  dim as string sJump : g_bBreakPoint = -1
                  dim as long iTarget
                  _LockConsole
                  input "Jump to where"; sJump
                  sJump = trim(sJump)
                  if len(sJump) then
                    if sJump[0] = asc("$") then
                      iTarget = valint("&h"+mid(sJump,2))
                    elseif sJump[0] = asc("#") then
                      iTarget = valint(mid(sJump,2))
                    else
                      iTarget = valint("&h"+sJump)
                    end if
                    if cuint(iTarget) > 65535 then
                      color 12 : puts("Invalid address for jump")
                    else
                      color 13 : printf(!"Jumping to $%04X\n",iTarget)
                      .RegPC = iTarget 
                      .bOpcode = g_bMemory(.RegPC) : NotifyRead8(.RegPC)
                    end if
                  else
                    color 13 : puts("Jumping cancelled.")
                  end if
                  _UnlockConsole
                end if                
              case asc("a"),asc("A") 'assembly
                _UnlockUpdate
                g_bBreakPoint = -1
                continue do,do,do
              case asc("d"),asc("D") 'close debugger
                _LockConsole
                color 14 : puts("Exiting Debug Mode")
                _UnlockConsole
                DragWindow(true)
                .bDebug = false : g_bBreakPoint = -1
                ShowStatus()
                #ifndef __FB_NDS__
                g_bViewMode = vmNone : Viewer.CloseScreen()
                #endif
                _UnlockUpdate
                continue do,do              
              case asc("r"),asc("R") 'run
                _LockConsole
                color 14 : puts("Exiting Debug Mode and running")
                _UnlockConsole
                #ifndef __FB_NDS__
                g_bViewMode = vmNone : Viewer.CloseScreen()
                #endif
                DragWindow(true)
                .bDebug = false : .bRun = true
                g_bBreakPoint = -1 : ShowStatus()
                g_GfxFocus = true
                _UnlockUpdate                  
                continue do,do
              case 1 , -30           'ctrl/alt A (set Accumulator)
                _LockConsole           
                dim as string sTemp 
                color 14 : input "New value for A"; sTemp
                if len(sTemp) then                   
                  .RegA = valint("&h"+sTemp)
                  color 13 : printf(!"A set to $%02X\n",.RegA)
                else
                  color 13 : puts("Not modified")
                end if
                _UnlockConsole           
              case 27 , -asc("k")   
                _UnlockUpdate                
                .bDone = 1   : exit do,do
              case else 
                HandleViewKeys( iKey )
              end select
            loop
          end if        
          NotifyRead8(.RegPC)
          .RegPC += 1 : uTotalCycles2 += 1
          g_fnOpcode(.bOpcode)()
          if .bBreak then 
            .bBreak = 0 : g_bBreakPoint = -1
            _LockConsole
            color 10 : puts("Program Finished!")
            _UnlockConsole
            WaitKey() : ResetCPU(g_tCpu) 
            memset(@g_bMemory(&h200),0,32*32)
            memset(@g_bMemChg(&h200),1,32*32)
            g_bFinished = 0 : N = 1            
          end if
        next N      
      elseif .bRun then
        if bCanRun = 0 then 
          _UnlockUpdate            
          .bRun = 0 : continue do
        end if
        #ifdef SpeedBench
          static as double TMR      
          if TMR = 0 then TMR = timer
        #endif
        dim N as long = any
        for N = 0 to ((.iCyclesMS*1000)\60)-1
          .bOpcode = g_bMemory(.RegPC) : NotifyRead8(.RegPC)             
          .RegPC += 1 : g_fnOpcode(.bOpcode)()          
          if .bBreak then                         
            .bBreak=0 
            if .bSleep then exit for
            .bRun = 0
            _LockConsole
            color 10 : puts("Program Finished!")
            _UnlockConsole
            gfx.UpdateScreen( @g_bMemory(&h200) )
            g_bFinished = true : exit for
          end if
        next N
        uTotalCycles2 += N
        #ifdef SpeedBench
          uTotalCycles += N
          if abs(timer-TMR) >= 1 then
            _LockConsole
            color 13
            if iLimit then
              printf(!"%1.1f Khz (%1.1f fps)    \r",(uTotalCycles/1000)/(timer-TMR),1000/(iLimit-1))            
              iLimit = 0
            else
              printf(!"%1.1f Khz    \r",(uTotalCycles/1000)/(timer-TMR))            
            end if
            _UnlockConsole
            TMR = timer : uTotalCycles = 0
          end if
        #endif
        static as double dTime
        if .bSleep then 
          if .bSleep <> cubyte(-1) then iLimit = g_bMemory(&hFE)+1
          dTime = timer : .bSleep = 0 : 
        elseif g_tCpu.iCyclesMS < 8192 then          
          if abs(timer-dTime) > 1 then 
            dTime = timer
          else
            while (timer-dTime) < 1/60
              screensync
            wend
            dTime += 1/60
          end if
          '#endif
        end if
      else
        sleep 50,1
      end if
      _UnlockUpdate
    loop

    
  end with
  
loop

g_tCpu.bDone = 1
puts("Waiting thread...")
#ifdef MultiThread
ThreadWait(hUpdateThread)
#endif
puts("Done...")
gfx.CloseScreen()
#ifndef __FB_NDS__
viewer.CloseScreen()
#endif
