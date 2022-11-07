#define ARM9

#include "crt.bi"
#include "nds.bi"
#include "sys/socket.bi"
#include "netinet/in.bi"
#include "netdb.bi"
#include "dswifi9.bi"

declare sub getHttp(url as zstring ptr)

'//---------------------------------------------------------------------------------
'//---------------------------------------------------------------------------------
function main alias "main"() as integer
  
	consoleDemoInit()  '//setup the sub screen for printing
  
	iprintf(!"\n\n\tSimple Wifi Connection Demo\n\n")
	iprintf(!"Connecting via WFC data ...\n")
  
	if Wifi_InitDefault(WFC_CONNECT)=0 then
		iprintf("Failed to connect!")
  else
		iprintf(!"Connected\n\n")
		getHttp("www.akkit.org")
  end if	
	
	do
		swiWaitForVBlank()
  loop
  
	return 0
  
end function

'//---------------------------------------------------------------------------------
'//---------------------------------------------------------------------------------
sub getHttp(url as zstring ptr)
  '// Let's send a simple HTTP request to a server and print the results!
  '// store the HTTP request for later
  dim as zstring ptr request_text = _
  @!"GET /dswifi/example1.php HTTP/1.1\r\nHost: www.akkit.org\r\nUser-Agent: Nintendo DS\r\n\r\n"
  'Host: www.akkit.org\r\n
  'User-Agent: Nintendo DS\r\n\r\n"
  
  '// Find the IP address of the server, with gethostbyname
  dim as hostent ptr myhost = gethostbyname( url )
  iprintf(!"Found IP Address!\n")
  
  '// Create a TCP socket
  dim as integer my_socket
  my_socket = ssocket( AF_INET, SOCK_STREAM, 0 )
  iprintf(!"Created Socket!\n")
  
  '// Tell the socket to connect to the IP address we found, on port 80 (HTTP)
  dim as sockaddr_in sain
  sain.sin_family = AF_INET
  sain.sin_port = shtons(80)
  sain.sin_addr.s_addr= *cast(ulong ptr,(myhost->h_addr_list[0]) )
  sconnect( my_socket,cast(sockaddr ptr,@sain), sizeof(sain) )
  iprintf(!"Connected to server!\n")
  
  '// send our request
  ssend( my_socket, request_text, strlen(request_text), 0 )
  iprintf(!"Sent our request!\n")
  
  '// Print incoming data
  iprintf(!"Printing incoming data:\n")
  
  dim as integer recvd_len
  dim as zstring*256 incoming_buffer
  
  '// if recv returns 0, the socket has been closed.
  do
    recvd_len = srecv( my_socket, @incoming_buffer, 255, 0 )
    if recvd_len = 0 then exit do '// data was received!
    incoming_buffer[recvd_len] = 0 '; // null-terminate
    iprintf(incoming_buffer)    
  loop
  
	iprintf(!"Other side closed connection!")
  
	sshutdown(my_socket,0) '; // good practice to shutdown the socket.
  
	sclosesocket(my_socket) '; // remove the socket.
  
end sub

