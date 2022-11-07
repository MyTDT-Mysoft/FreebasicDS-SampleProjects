declare function Shade(COR as uinteger,PERCENT as integer) as uinteger
declare sub Ray (AA as integer,RX as integer,RY as integer, SX as integer)
declare sub DrawView(DVX as integer,DVY as integer,DANG as integer)
declare sub InitMap(MAP as zstring ptr)
declare sub InitTables()

type ThreadStruct
  PTHREAD as any ptr
  DVX as integer
  DVY as integer
  DANG as integer
  INI as integer
  STP as integer
end type

'This controls the maximum distance displayed. If you increase this,
'you will see more of the landscape, but it will also be slower

'const M_PI = 3.141592
const PI = atn(1)/32

#define UseTables