const as integer MAX_TOKEN_LENGTH = 80

#ifdef __FB_NDS__
  #define ScreenBPP 8
#else
  #define ScreenBPP 16
#endif

#if ScreenBPP = 8
  #define pixel ubyte
#elseif ScreenBPP = 16
  #define pixel ushort
#elseif ScreenBPP = 32
  #define pixel ulong
#endif