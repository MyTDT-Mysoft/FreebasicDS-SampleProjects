sub Sync()
 
  const BorderY = ((192-(60*3)))
  const BorderX = ((256-(80*3)))
  const SourcePitch = 128-80
    
  screenlock
  dim as ubyte ptr scrptr = Screenptr + ((BorderY\2)*256) + (BorderX\2)
  dim as ubyte ptr buffptr = bufptr
  for Y as integer = 1 to 60*4    
    for X as integer = 0 to 79
      scrptr[0] = *buffptr: scrptr[1] = *buffptr: scrptr[2] = *buffptr
      scrptr += 3: buffptr += 1
    next X
    scrptr += borderx
    if (Y and 3)=0 then buffptr += (128-80): Y += 1 else buffptr -= 80
  next Y
  
  screensync
  screenunlock
  
end sub

screenres 256,192,8