#include once "crt.bi"
#ifndef WOLFSSL_API  
  #include once "wolfssl.bi"    
#endif

puts("Net init")
hStart()
puts("WolfSSL init")
wolfSSL_Init()  

namespace http
  static shared as WOLFSSL_CTX ptr g_pCtxSSL
  static shared as long g_lCtxRefCount
  
  enum AsyncMode
    amSync
    amAsyncStream
    amAsyncThread
  end enum
  enum ConnectState
    csError = -1
    csNone    
    csConnect
    csConnecting
    csUpgrade
    csUpgrading
    csSendHeader
    csReply    
    csContent
    csComplete    
  end enum
  
  const uMagic = cvi("HtTp")
  
  type NetContext_fwd as NetContext
  type NetContext
    as ulong           uMagic
    as double          dLastRequest
    as WOLFSSL_CTX ptr pCtx
    as any ptr         pThread
    as WOLFSSL ptr     pSSL
    as socket          pSock
    as string          sBuffer , sOrgHost , sHeaders
    as string          sHost , sPath , sFile , sExtra
    as string ptr      psOutput
    as ulongint        uReceived,uLength    
    as AsyncMode       iAsync
    as ConnectState    iState
    as ulong           uIp , iPort
    as long            HttpResult , iPreBuffer
    as byte            bDynAlloc :1
    as byte            bClose    :1
    as byte            bRedirCount
    HandleState as function ( pContext as NetContext_fwd ptr ) as long
  end type
  
  type fbString
    pzStr as zstring ptr
    iLen  as integer
    iSize as integer
  end type
  
  #define ErrOutF(_s,_p...) color 12 : printf(_s+!"\n",_p)
  '#define DebugF(_s,_p...) color 6 : printf(_s+!"\n",_p) : color 7
  #define DebugF(_s,_p...) rem
  #define DebugF2(_s,_p...) rem

  function NewSession( amMode as AsyncMode , pCtxUserAlloc as NetContext ptr = NULL ) as NetContext ptr
    'Global Context ... provavelente shouldnt be created here
    if g_pCtxSSL = NULL then
      g_pCtxSSL = wolfSSL_CTX_new( wolfTLS_client_method() )
      if g_pCtxSSL = NULL then return NULL
      wolfSSL_CTX_set_verify(g_pCtxSSL, SSL_VERIFY_NONE, 0)
      wolfSSL_CTX_SetMinVersion(g_pCtxSSL, WOLFSSL_SSLV3)
    end if
    'if pointer to store context is NULL then create one here
    dim as NetContext ptr pResult = pCtxUserAlloc 
    dim as byte bDynAlloc = 0
    if pResult = NULL then 
      bDynAlloc=1 : pResult = callocate(sizeof(NetContext))
    else
      if pResult->uMagic = uMagic then return pResult
      memset( pResult , 0 , sizeof(NetContext) )      
    end if
    if pResult = NULL then return NULL
    'context default configuration
    with *pResult
      .uMagic = uMagic
      .iAsync = amMode
      .pCtx = g_pCtxSSL : g_lCtxRefCount += 1
      .bDynAlloc = bDynAlloc
    end with
    return pResult  
  end function
  sub FreeSession( byref pContext as NetContext ptr )
    if pContext = NULL then exit sub
    with *pContext
      if .pThread then 
        var pTemp = .pThread : .pThread = NULL
        #ifndef __FB_NDS__
        ThreadWait(pTemp)
        #endif
      end if
      if .pCtx then
        g_lCtxRefCount -= 1
        if g_lCtxRefCount = 0 then 
          g_pCtxSSL = NULL
          wolfSSL_CTX_free(.pCtx)
          .pCtx = NULL
        end if
      end if
      if .pSock then hClose(.pSock) : .pSock=NULL
      .sBuffer = "" : .sHost = "" : .sOrgHost = ""
      .sPath = "" : .sFile = "" : .sExtra = "" : .sHeaders = ""
      var bDynAlloc = .bDynAlloc
      memset( pContext , 0 , sizeof(NetContext) )
      if bDynAlloc then deallocate(pContext) : pContext = NULL
    end with        
  end sub
  
  enum ErrorCodes
    ecBadContext        = -1
    ecBadProtocol       = -2
    ecBadURL            = -3
    ecOutOfMemory       = -4
    ecWrongAsyncMode    = -5
    ecNotImplemented    = -6
    ecFailedToResolve   = -100
    ecFailedToSocket
    ecFailedToConnect
    ecFailedToSend
    ecSecureFailed      
    ecEmptyReply        = -200
    ecReplyTooLong
    ecFailedToReceive
    ecNonHttpResponse   
  end enum
  
  const Timeout = 12 , BufferSz = 4096 , MaxRedirCount = 1
  
  sub CleanUpConnection( pContext as NetContext ptr )
    DebugF("Cleanup connection!")
    with *pContext
      .dLastRequest = 0
      if .pSock then hClose(.pSock) : .pSock = 0
    end with
  end sub
  function GetHeader( pContext as NetContext ptr , sName as string , sOutput as string ) as long
    with *pContext
      var sHeaderL = lcase(.sHeaders) , iLen = len(sName)
      var iPosi = instr(sHeaderL,!"\n"+lcase(sName)+": ")
      if iPosi = 0 then sOutput = "" : return 0 else iPosi += iLen+3
      var iPos2 = instr(iPosi,sHeaderL,!"\r\n")
      if iPos2=0 then iPos2=len(sHeaderL)
      sOutput = mid(.sHeaders,iPosi,(iPos2-iPosi)) 
      return 1
    end with
  end function
  
  function Validate( pContext as NetContext ptr , sUrl as string ) as long
    if pContext = NULL orelse pContext->uMagic <> uMagic then 
      ErrOutF("%s","HttpGet -> Bad Context pointer")
      return ecBadContext
    end if
    with *pContext
    
      dim as byte bSecure = 0
      .uReceived=0:.uLength=0:.HttpResult=0
      .iState=0:.uIp=0:.iPort=0:.bClose=0
      
      var iProtoEnd = instr(sUrl,"://")
      if iProtoEnd then 
        if iProtoEnd < 5 orelse iProtoEnd > 6 orelse (sUrl[0] <> asc("h") andalso sUrl[0] <> asc("H")) then 
          ErrOutF("%s","HttpGet -> Bad Protocol")
          return ecBadProtocol
        end if        
        #ifdef __FB_NDS__
        select case (culng(*cptr(ulongint ptr,strptr(sUrl)) shr 8) or &h20202020)
        #else
        select case (*cptr(ulong ptr,strptr(sUrl)+1) or &h20202020)
        #endif
        case cvl("ttp:") : bSecure = 0
        case cvl("ttps") : bSecure = 1
        case else   
          ErrOutF("%s","HttpGet -> Bad Protocol")
          return ecBadProtocol
        end select
      end if
      
      DebugF("Proto: '%s'",left(sUrl,iProtoEnd-1))
      
      iProtoEnd += 3 '://
      if len(sUrl)=0 orelse len(sUrl)=iProtoEnd then 
        ErrOutF("%s","HttpGet -> Bad Url")
        return ecBadURL
      end if
      var iHostEnd = instr(iProtoEnd+1,sUrl,"/")
      if iHostEnd = 0 then iHostEnd = len(sUrl)    
      var sHost = mid(sUrl,iProtoEnd,iHostEnd-iProtoEnd)            
      var iPortStart = instr(sHost,":")      
      if iPortStart then 
        .iPort = valint(mid(sHost,iPortStart+1))
        sHost = left(sHost,iPortStart-1)
      end if
      if .iPort = 0 then .iPort = iif(bSecure,443,80)
      .sHost = sHost : .sFile = mid(sUrl,iHostEnd)
      DebugF("Host.: '%s'",.sHost)
      DebugF("Port.: %i",.iPort)
      DebugF("Parms: '%s'",.sFile)
      
      'if switching back/forth on SSL, can't reuse connection
      dim as byte bSecurityChanged
      if bSecure then 
        if .pSSL = 0 then 
          .pSSL = wolfSSL_new(.pCtx)
          bSecure = 2 : bSecurityChanged = 1
          if .pSock then
            bSecurityChanged = 1
            hClose(.pSock):.pSock=0
          end if
        end if
      else
        if .pSSL then 
          wolfSSL_shutdown(.pSSL) : .pSSL = NULL
          if .pSock then 
            bSecurityChanged = 1
            hClose(.pSock):.pSock=0
          end if
        end if
      end if
  
      'check for connection re-usage
      if .pSock andalso abs(timer-.dLastRequest) < Timeout andalso .sHost = .sOrgHost then         
        rem reuse connection
        puts("REUSE CONNECTION!")
        .iState = csSendHeader '2
      else
        printf(!"%s\n","-------------------------------")
        if .pSock = 0 andalso bSecurityChanged=0  then printf(!"%s\n","NR: No Socket")        
        if abs(timer-.dLastRequest) >= Timeout then printf(!"%s\n","NR: Timeout")
        if .sHost <> .sOrgHost then printf(!"NR: Different host ('%s'->'%s')\n",.sOrgHost,sHost)
        if bSecurityChanged then printf(!"%s\n",!"NR: changing security")
        printf(!"%s\n","-------------------------------")
        if bSecure = 1 then
          if .pSSL then wolfSSL_shutdown(.pSSL) : .pSSL = NULL
          .pSSL = wolfSSL_new(.pCtx)
        end if
        if .pSock then hClose(.pSock) : .pSock = 0
        .iState = csConnect
      end if
      
      if .bRedirCount = 0 then .sOrgHost = sHost
      
    end with
    return 0
  end function
  function HandleReply( pContext as NetContext ptr , iContentStart as long ) as long    
    with *pContext     
      var iBufferLen = len(.sBuffer), ptsBuff = cptr(fbString ptr,@.sBuffer)
      ptsBuff->iLen = iContentStart-3 ': .sBuffer[ptsBuff->iLen]=0
      .sHeaders = .sBuffer
      DebugF("'%s'",.sHeaders)
      select case .HttpResult
      case 200
        'TODO: handle header length
        dim as string sTemp        
        GetHeader(pContext,"Content-Length",sTemp)
        if len(sTemp) then 
          .uLength = valint(sTemp)
        else
          .uLength = -1 : .bClose = 1
        end if        
        var iDataLen = (iBufferLen+1)-iContentStart
        if iDataLen > .uLength then
          puts("Extra data...")
          sleep
          .sExtra = string(iDataLen-.uLength,0)
          memcpy( strptr(.sExtra) , @.sBuffer[.uLength] , iDataLen-.uLength )
          iDataLen = .uLength
        end if
        'printf(!"%i\t%i\n",cint(.uLength),cint(iDataLen))
        cptr(fbString ptr,.psOutput)->iLen = 0
        .iPreBuffer = iDataLen : .uReceived = 0
        memmove( strptr(.sBuffer) , @.sBuffer[iContentStart-1] , iDataLen )        
        '.iState = iif(.uReceived >= .uLength , csComplete , csContent ) : return 1
        .iState = csContent : return 1
      case 302
        .bRedirCount += 1
        if .bRedirCount > MaxRedirCount then
          ErrOutF("%s","HttpGet -> Too many redirections")
          .HttpResult = -.HttpResult
          return 0
        end if
        dim as string sUrl
        GetHeader( pContext , "Location" , sUrl )
        if len(sUrl)=0 then return 0        
        DebugF("Redir: '%s'",sUrl)
        .HttpResult = Validate( pContext , sUrl )
        DebugF("Http Code = %i\n",.HttpResult)
        if .HttpResult then return 0
        return 1
      case else
        ErrOutF("%s%i","Unhandled HTTP code: ",.HttpResult)
        return 0
      end select
    end with
  end function
  function HandleState( pContext as NetContext ptr ) as long    
    with *pContext
      select case .iState
      case csConnect
        .uIp = hResolve(.sHost)
        if .uIp = 0 then
           ErrOutF("%s'%s'","HttpGet -> Failed to resolve ",.sHost) 
           .HttpResult = ecFailedToResolve : return 0
        end if
        .pSock = hOpen()
        if .pSock = 0 then
          ErrOutF("%s","HttpGet -> Failed to create socket ") 
          .HttpResult = ecFailedToSocket : return 0
        end if
        .dLastRequest = timer
        if hConnect( .pSock , .uIP , .iPort ) = 0 then
          ErrOutF("%s","HttpGet -> Failed to connect ") 
          .HttpResult = ecFailedToConnect : return 0
        end if              
        .iState = iif(.pSSL,csUpgrade,csSendHeader) : return 1
      case csUpgrade
        wolfSSL_set_fd(.pSSL, .pSock)
        wolfSSL_UseSNI(.pSSL, WOLFSSL_SNI_HOST_NAME , strptr(.sHost) , len(.sHost) )
        var ret = wolfSSL_connect(.pSSL)    
        var ierr = wolfSSL_get_error(.pSSL, ret)
        if ierr < 0 then '<> SSL_SUCCESS then
          dim as zstring*256 buffer = any          
          ErrOutF(!"error = %d, %s", ierr, wolfSSL_ERR_error_string(ierr, buffer))
          .HttpResult = ecSecureFailed : return 0
        end if  
        .iState = csSendHeader : return 1
      case csSendHeader
        if .iAsync <> amSync andalso hSelect(.pSock,1)=0 then return -1 'can't send yet
        dim as zstring*512 zHdr = any
        var iLen = sprintf( zHdr , _
          "GET %s HTTP/1.1"              !"\r\n" _
          "Host: %s"                     !"\r\n" _          
          "Cache-Control: no-cache"      !"\r\n" _
          _ '"Upgrade-Insecure-Requests: 1" !"\r\n" _
          "User-Agent: Embedded Browser" !"\r\n" _
          "Accept: */*"                  !"\r\n" _
          "%s"                           !"\r\n" _
          "Connection: keep-alive"       !"\r\n\r\n", _
        .sFile , .sHost , "Pragma: no-cache" )
        dim as long iResu = any
        DebugF("'%s'",zHdr)
        if .pSSL then
          iResu = wolfSSL_write(.pSSL,@zHdr,iLen)
        else
          iResu = hSend(.pSock,@zHdr,iLen)
        end if
        if iResu <> iLen then
          ErrOutF("%s","HttpGet -> Failed to send header ") 
          .HttpResult = ecFailedToSend : return 0
        end if        
        .sBuffer = string(BufferSz,0) : .uReceived = 0
        .iState = csReply : return 1
      case csReply
        if .iAsync <> amSync andalso hSelect(.pSock)=0 then return -1 'nothing to receive yet
        dim as long iResu = any
        if .pSSL then 
          iResu = wolfSSL_read(.pSSL,strptr(.sBuffer)+.uReceived,len(.sBuffer)-.uReceived)
        else
          iResu = hReceive(.pSock,strptr(.sBuffer)+.uReceived,len(.sBuffer)-.uReceived)
        end if
        if iResu < 0 then
          ErrOutF("%s","HttpGet -> Failed to receive reply ") 
          .HttpResult = ecFailedToReceive : return 0
        end if
        var PrevSize = .uReceived : if PrevSize >= 4 then PrevSize -= 4 else PrevSize = 0
        .uReceived += iResu : .sBuffer[.uReceived] = 0
        cptr(fbString ptr,@.sBuffer)->iLen = .uReceived
        if .HttpResult = 0 andalso .uReceived > 12 then          
          .HttpResult = valint(mid(.sBuffer,9,4))          
          #define Fail1 (cptr(ulong ptr,strptr(.sBuffer))[0] or &h20202020) <> cvl("http")
          #define Fail2 (cptr(ulong ptr,strptr(.sBuffer))[1] and &h30FF30FF) <> cvl("/0.0")
          if Fail1 orelse Fail2 orelse .HttpResult < 100 orelse .httpResult > 999 then
            ErrOutF("{%s}",.sBuffer)
            ErrOutF("%s","HttpGet -> Response was not HTTP ") 
            .HttpResult = ecNonHttpResponse : return 0
          end if
        end if
        var iEndOfHdr = instr(PrevSize+1,.sBuffer,!"\r\n\r\n")        
        if iEndOfHdr then          
          return HandleReply( pContext , iEndOfHdr+4 )        
        end if
        if .uReceived >= BufferSz then
          ErrOutF("%s","HttpGet -> Response is too long") 
          .HttpResult = ecReplyTooLong : return 0
        end if
        return -1 'more!
      case csContent
        if .iAsync <> amSync andalso .iPreBuffer=0 andalso hSelect(.pSock)=0 then return -1 'nothing to receive yet        
        
        var psBuff = cptr(fbString ptr , .psOutput )
        var iBuffLen = psBuff->iLen , iResu = 0
        
        'if theres no space left on the buffer, but a read is attempted
        'it will grow the string otherwise it will leave the string data/size untouched
        if iBuffLen >= (psBuff->iSize) then
          *.psOutput += string(BufferSz,0)
          psBuff->iLen = iBuffLen
        end if   
        
        'read max what can fit on the buffer or max what's left to finish the download
        var iBuffLeft = (psBuff->iSize)-psBuff->iLen        
        var iAmount = .uLength-.uReceived        
        if iAmount > iBuffLeft then iAmount = iBuffLeft
        if .iPreBuffer then
          DebugF("%s",!"Reading from pre-buffer\n")
          iResu = iif(iAmount>.iPreBuffer,.iPreBuffer,iAmount)
          memcpy(psBuff->pzStr+iBuffLen,@.sBuffer[.uReceived],iResu)
          .iPreBuffer -= iResu
        elseif .pSSL then 
          iResu = wolfSSL_read(.pSSL,psBuff->pzStr+iBuffLen,iAmount)
        else
          iResu = hReceive(.pSock,psBuff->pzStr+iBuffLen,iAmount)
        end if        
        
        DebugF2("%i{%i} %i - %i",cint(iAmount),cint(iResu),cint(.uReceived+iResu),cint(.uLength))
        'if iResu = 0 then sleep 500,1
        
        'special case if theres an error... but size is not known
        'so it means the download over when connection close (useful for streams)
        if iResu < 0 then
          if .bClose then .dLastRequest = timer : .iState = csComplete : return 1
          ErrOutF("%s","HttpGet -> Failed to receive reply ") 
          .HttpResult = ecFailedToReceive : return 0
        end if
        
        'if received everything return 1
        'if filled the buffer return -1 (as if there was temporally no more to read)
        'which works good to be used as sync point
        .uReceived += iResu : psBuff->iLen += iResu
        
        if .uReceived = .uLength then 
          .iState = csComplete : .dLastRequest = timer
        elseif iAmount = iBuffLeft then 
          return -1        
        end if
        return 1
        
      end select      
    end with
  end function
  
  #ifndef __FB_NDS__
  '------ MultiThread -----
  sub SockThread( pContext as NetContext ptr )
    with *pContext
      do
        var iResu = HandleState( pContext )
        if iResu then        
          if .iState = csComplete then exit sub          
        else          
          .iState = csComplete
          CleanUpConnection( pContext ) : exit sub
        end if          
      loop
    end with
  end sub
  #endif
  
  '------ Root ------
  '<= 0 ... Connection Error ... 0 = async ... > 0 ... Http Result ... 
  function GetUrl( pContext as NetContext ptr , sUrl as string , sOutput as string ) as long
    var iResu = Validate( pContext , sUrl )
    if iResu then return iResu
    with *pContext
      'TODO: drop previous existing connection or fail?
      .psOutput = @sOutput : .bRedirCount = 0
      
      select case .iAsync 
      case amSync, amAsyncStream
        do
          var iResu = HandleState( pContext )
          if iResu then        
            if .iState = csComplete then return .HttpResult
            if iResu < 0 andalso .iAsync = amAsyncStream then return 0
          else          
            CleanUpConnection( pContext ) : return .HttpResult
          end if
        loop
      case amAsyncThread
        #ifndef __FB_NDS__
          if .pThread then ThreadWait(.pThread)
          .pThread = ThreadCreate(cast(any ptr,@SockThread),pContext)
          return 0
        #else
          return ecNotImplemented
        #endif
      end select
      'dLastRequest
    end with
  end function
  function AsyncUpdate( pContext as NetContext ptr ) as long
    if pContext = NULL orelse pContext->uMagic <> uMagic then 
      ErrOutF("%s","HttpGet -> Bad Context pointer")
      return ecBadContext
    end if
    with *pContext
      'if .iAsync <> amAsyncStream then
      '  ErrOutF("%s","HttpGet(update) -> This is only callable in amSyncStream mode")
      '  return ecWrongAsyncMode
      'end if
        
      do
        var iResu = HandleState( pContext )
        if iResu then        
          if .iState = csComplete then return .HttpResult        
          return 0 'if iResu < 0 then return 0
        else          
          CleanUpConnection( pContext ) : return .HttpResult
        end if
      loop
    end with
  end function

end namespace
