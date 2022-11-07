type ItemInfoStruct
  iFileLen as integer  
  pPrev as any ptr
  pNext as any ptr
end type

type ItemStructS
  as const string sName   
  info as ItemInfoStruct
end type

type ItemStructP
  as zstring ptr  pData
  as integer      iLen,iAllocSz
  info as ItemInfoStruct
  as zstring*2048 zName
end type

type ItemList
  as any ptr pFirst,pLast,pFile
  as short X1,Y1,X2,Y2
  as short iMode
  as short iLineMax,iCur
  as short iAtuLine,iTotLines
  as short iTotFiles,iTotFolders
end type

#if 0
dim as ItemStructS ptr MyStr
var sTemp = "Hello World"
MyStr = allocate(sizeof(ItemStructS)+len(sTemp)+1)
with *cptr(ItemStructP ptr,MyStr)
  .iLen = len(sTemp) : .iAllocSz = .iLen+1
  .pData = @.zName   : .zName = sTemp
end with
print MyStr->sName
sleep
#endif
