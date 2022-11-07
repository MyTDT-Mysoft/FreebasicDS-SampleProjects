// Compilation of main.bas started at 17:11:51 on 10-22-2022

typedef char ubyte;
typedef   signed char byte;
typedef unsigned short ushort;
typedef int integer;
typedef unsigned int uinteger;
typedef unsigned long ulong;
typedef long long longint;
typedef unsigned long long ulongint;
typedef float single;
typedef struct Fstring { char *data; int len; int size; } string;
typedef char fixstr;
typedef integer wchar;
typedef int IPC_SYNC_BITS;
typedef int PM_BITS;
typedef int BGTYPE;
typedef int BGSIZE;
struct GLVECTOR {
	integer X;
	integer Y;
	integer Z;
};
struct __FB_ARRAYDIMTB$ {
	integer ELEMENTS;
	integer LBOUND;
	integer UBOUND;
};
struct M4X4 {
	integer M[16];
};
struct M4X3 {
	integer M[12];
};
struct M3X3 {
	integer M[9];
};
typedef int GL_GET_ENUM;
struct GL_TEXTURE_DATA {
	void* VRAMADDR;
	ulong TEXINDEX;
	ulong TEXINDEXEXT;
	integer PALINDEX;
	ulong TEXFORMAT;
	ulong TEXSIZE;
};
struct DYNAMICARRAY {
	void** DATA;
	uinteger CUR_SIZE;
};
typedef int GFX$GFXDRIVERS;
typedef int KEYPAD_BITS;
struct TOUCHPOSITION {
	ushort RAWX;
	ushort RAWY;
	ushort PX;
	ushort PY;
	ushort Z1;
	ushort Z2;
};
typedef int IRQ_MASKS;
typedef int DUTYCYCLE;
struct _IO_FILE {
	integer _FLAGS;
};
struct FBSTRING {
	char* DATA;
	integer LEN;
	integer SIZE;
};
typedef int FB$TMP$64;
struct FB$FBFILE {
	struct _IO_FILE* PHANDLE;
	integer IFLAGS;
	longint ILOF;
};
typedef int FB$ERRORNUMBERS;
typedef int FB$OPENMODES;
typedef int FB$ACCESSFLAGS;
struct DIR_ITER {
	integer DEVICE;
	void* DIRSTRUCT;
};
struct DIRENT {
	uinteger D_INO;
	ubyte D_TYPE;
	char D_NAME[768];
};
struct DIR {
	integer POSITION;
	struct DIR_ITER* DIRDATA;
	struct DIRENT FILEDATA;
};
struct FB_ARRAYDIMTB {
	integer IELEMENTS;
	integer ILBOUND;
	integer IUBOUND;
};
struct FB_ARRAYDESC {
	void* PDATA;
	void* PPTR;
	integer ISIZE;
	integer IELEMENT_LEN;
	integer IDIMENSIONS;
	struct FB_ARRAYDIMTB TDIMTB[8];
};
struct __U_QUAD_T {
	uinteger __VAL[2];
};
struct STAT {
	struct __U_QUAD_T ST_DEV;
	uinteger ST_INO __attribute__((packed, aligned(1)));
	uinteger ST_MODE __attribute__((packed, aligned(1)));
	uinteger ST_NLINK __attribute__((packed, aligned(1)));
	uinteger ST_UID __attribute__((packed, aligned(1)));
	uinteger ST_GID __attribute__((packed, aligned(1)));
	struct __U_QUAD_T ST_RDEV;
	integer ST_SIZE __attribute__((packed, aligned(1)));
	integer ST_ATIME __attribute__((packed, aligned(1)));
	integer ST_SPARE1 __attribute__((packed, aligned(1)));
	integer ST_MTIME __attribute__((packed, aligned(1)));
	integer ST_SPARE2 __attribute__((packed, aligned(1)));
	integer ST_CTIME __attribute__((packed, aligned(1)));
	integer ST_SPARE3 __attribute__((packed, aligned(1)));
	integer ST_BLKSIZE __attribute__((packed, aligned(1)));
	integer ST_BLOCKS __attribute__((packed, aligned(1)));
	integer ST_SPARE4[2] __attribute__((packed, aligned(1)));
};
struct BGSTATE {
	integer ANGLE;
	long CENTERX;
	long CENTERY;
	long SCALEX;
	long SCALEY;
	long SCROLLX;
	long SCROLLY;
	integer SIZE;
	integer TYPE;
	integer DIRTY;
};
struct FB$_OLD_HEADER {
	ushort BPP __attribute__((packed, aligned(1)));
	ushort HEIGHT __attribute__((packed, aligned(1)));
};
struct FB$IMAGE {
	union {
		struct FB$_OLD_HEADER OLD;
		uinteger TYPE __attribute__((packed, aligned(1)));
	};
	integer BPP __attribute__((packed, aligned(1)));
	uinteger WIDTH __attribute__((packed, aligned(1)));
	uinteger HEIGHT __attribute__((packed, aligned(1)));
	uinteger PITCH __attribute__((packed, aligned(1)));
	ubyte _RESERVED[12];
};
struct FBBMPFILEHEADER {
	ushort SIGNATURE __attribute__((packed, aligned(1)));
	uinteger FILESIZE __attribute__((packed, aligned(1)));
	uinteger RESERVED1 __attribute__((packed, aligned(1)));
	uinteger IMAGEOFFSET __attribute__((packed, aligned(1)));
	uinteger BIHSIZE __attribute__((packed, aligned(1)));
	uinteger WID __attribute__((packed, aligned(1)));
	uinteger HEI __attribute__((packed, aligned(1)));
	ushort PLANES __attribute__((packed, aligned(1)));
	ushort BPP __attribute__((packed, aligned(1)));
	uinteger COMPRESSION __attribute__((packed, aligned(1)));
	uinteger IMAGESIZE __attribute__((packed, aligned(1)));
	uinteger HRES __attribute__((packed, aligned(1)));
	uinteger VRES __attribute__((packed, aligned(1)));
	uinteger MAXCOLORS __attribute__((packed, aligned(1)));
	uinteger NEEDCOLORS __attribute__((packed, aligned(1)));
};
struct PATCHSTRUCT {
	ushort ILABEL;
	ushort ILINE;
	ushort UADDRESS;
	byte BABS;
	byte BHI;
};
struct PARSERSTRUCT {
	string SCODE;
	long ILINENUM;
	long ICODESZ;
	long IPOS;
	long ITOTALSZ;
	long ITOKENSTART;
	long ILINESTART;
	long ICHAR;
	long ITOKENNUM;
	long IHADLABEL;
	long UADDRESS;
	long UADDRESSMIN;
};
static void _ZN12PARSERSTRUCTC1Ev( struct PARSERSTRUCT* );
static void _ZN12PARSERSTRUCTaSERS_( struct PARSERSTRUCT*, struct PARSERSTRUCT* );
static void _ZN12PARSERSTRUCTC1ERS_( struct PARSERSTRUCT*, struct PARSERSTRUCT* );
static void _ZN12PARSERSTRUCTD1Ev( struct PARSERSTRUCT* );
struct ADDRMODES {
	ubyte BINHERENT;
	ubyte BACCUMULATOR;
	ubyte BIMMEDIATE;
	ubyte BZEROPAGE;
	ubyte BZEROPAGEX;
	ubyte BABSOLUTE;
	ubyte BABSOLUTEX;
	ubyte BABSOLUTEY;
	ubyte BINDIRECT;
	ubyte BINDIRECTX;
	ubyte BINDIRECTY;
};
typedef long (*tmp$850)( long );
struct OPCODESTRUCT {
	char ZNAME[8];
	struct ADDRMODES TOPCODES;
	tmp$850 FNEVAL;
};
struct CPU$CPUFLAGS {
	union {
		struct {
			ubyte CARRY;
		};
		ubyte BFLAGS;
	};
};
struct CPU$CPUCORE {
	ubyte REGA;
	ubyte REGX;
	ubyte REGY;
	ubyte REGSP;
	struct CPU$CPUFLAGS REGP;
	ubyte BOPCODE;
	ushort REGPC;
	ushort WMEMADDR;
	ubyte BBREAK;
	ubyte BDONE;
	ubyte BDEBUG;
	ubyte BRUN;
	ubyte BSLEEP;
	ulong ICYCLESMS;
	ulong ILFRESUNZ;
	ulong ILFRESUC;
	ulong ILFRESUV;
};
static void _ZN3CPU7CPUCOREC1Ev( struct CPU$CPUCORE* );
typedef int VIEWMODE;
struct CONSOLEFONT {
	ushort* GFX;
	ushort* PAL;
	ushort NUMCOLORS;
	ubyte BPP;
	ushort ASCIIOFFSET;
	ushort NUMCHARS;
	integer CONVERTSINGLECOLOR;
};
typedef integer (*tmp$43)( void*, byte );
struct PRINTCONSOLE {
	struct CONSOLEFONT FONT;
	ushort* FONTBGMAP;
	ushort* FONTBGGFX;
	ubyte MAPBASE;
	ubyte GFXBASE;
	ubyte BGLAYER;
	integer BGID;
	integer CURSORX;
	integer CURSORY;
	integer PREVCURSORX;
	integer PREVCURSORY;
	integer CONSOLEWIDTH;
	integer CONSOLEHEIGHT;
	integer WINDOWX;
	integer WINDOWY;
	integer WINDOWWIDTH;
	integer WINDOWHEIGHT;
	integer TABSIZE;
	ushort FONTCHAROFFSET;
	ushort FONTCURPAL;
	tmp$43 PRINTCHAR;
	integer CONSOLEINITIALISED;
	integer LOADGRAPHICS;
};
typedef int KEYBOARDSTATE;
struct KEYMAP {
	ushort* MAPDATAPRESSED;
	ushort* MAPDATARELEASED;
	integer* KEYMAP;
	integer WIDTH;
	integer HEIGHT;
};
typedef void (*tmp$29)( integer );
struct KEYBOARD {
	integer BACKGROUND;
	integer KEYBOARDONSUB;
	integer OFFSET_X;
	integer OFFSET_Y;
	integer GRID_WIDTH;
	integer GRID_HEIGHT;
	KEYBOARDSTATE STATE;
	integer SHIFTED;
	integer VISIBLE;
	struct KEYMAP* MAPPINGS[4];
	ushort* TILES;
	ulong TILELEN;
	ushort* PALETTE;
	ulong PALETTELEN;
	integer MAPBASE;
	integer TILEBASE;
	integer TILEOFFSET;
	ulong SCROLLSPEED;
	tmp$29 ONKEYPRESSED;
	tmp$29 ONKEYRELEASED;
};
typedef int CLOCKDIVIDER;
typedef void (*tmp$2)( void );
//teger fb_ConsoleView( integer, integer );
//teger fb_Locate( integer, integer, integer, integer, integer );
//teger fb_GetX( void );
//teger fb_GetY( void );
//id fb_Cls( integer );
//teger fb_Color( integer, integer, integer );
//void* fb_Inkey( void );
//teger fb_FileOpen( string*, integer, integer, integer, integer, integer );
//teger fb_FileClose( integer );
//teger fb_FileGet( integer, uinteger, void*, integer );
//ngint fb_FileTell( integer );
//teger fb_ConsoleInput( string*, integer, integer );
//teger fb_InputString( void*, integer, integer );
//teger fb_FileFree( void );
//ngint fb_FileSize( integer );
//id fb_GfxLine( void*, single, single, single, single, uinteger, integer, uinteger, integer );
//id fb_GfxPalette( integer, integer, integer, integer );
//teger fb_GfxScreenRes( integer, integer, integer, integer, integer, integer );
//teger fb_GfxWaitVSync( void );
//id fb_GfxLock( void );
//id fb_GfxUnlock( integer, integer );
//id* fb_GfxScreenPtr( void );
//teger fb_Multikey( integer );
double pow( double, double );
//uble fb_Rnd( single );
#define atan( temp_ppparam$0 ) __builtin_atan( temp_ppparam$0 )
#define abs( temp_ppparam$0 ) __builtin_abs( temp_ppparam$0 )
#define fabs( temp_ppparam$0 ) __builtin_fabs( temp_ppparam$0 )
//teger fb_SGNi( integer );
#define memset( temp_ppparam$0, temp_ppparam$1, temp_ppparam$2 ) __builtin_memset( temp_ppparam$0, temp_ppparam$1, temp_ppparam$2 )
//id fb_PrintInt( integer, integer, integer );
//id fb_PrintString( integer, string*, integer );
//void* fb_StrInit( void*, integer, void*, integer, integer );
//void* fb_StrAssign( void*, integer, void*, integer, integer );
//id fb_StrDelete( string* );
//void* fb_StrConcat( string*, void*, integer, void*, integer );
//teger fb_StrCompare( void*, integer, void*, integer );
//void* fb_StrConcatAssign( void*, integer, void*, integer, integer );
//void* fb_StrAllocTempDescZ( char* );
//void* fb_StrAllocTempDescZEx( char*, integer );
//void* fb_StrMid( string*, integer, integer );
//void* fb_StrFill1( integer, integer );
//teger fb_StrLen( void*, integer );
//teger fb_StrInstr( integer, string*, string* );
//void* fb_TRIM( string* );
//teger fb_VALINT( string* );
//void* fb_HEXEx_i( uinteger, integer );
//void* fb_LEFT( string*, integer );
//void* fb_SPACE( integer );
//void* fb_LCASE( string* );
//uble fb_Timer( void );
//id fb_Sleep( integer );
//teger fb_SleepEx( integer, integer );
//void* fb_DirNext( integer* );
//void* fb_Dir( string*, integer, integer* );
//id fb_Beep( void );
static void fb_ctor__main( void ) ; //tribute__(( constructor ));
void* memchr( void*, integer, uinteger );
integer memcmp( void*, void*, uinteger );
static void* memcpy( void*, void*, uinteger );
void* memset( void*, integer, uinteger );
uinteger strlen( char* );
char* strrchr( char*, integer );
char* strstr( char*, char* );
struct _IO_FILE* fopen( char*, char* );
struct _IO_FILE* freopen( char*, char*, struct _IO_FILE* );
integer fclose( struct _IO_FILE* );
integer printf( char*, ... );
integer sprintf( char*, char*, ... );
integer sscanf( char*, char*, ... );
integer fputc( integer, struct _IO_FILE* );
integer fputs( char*, struct _IO_FILE* );
integer getc( struct _IO_FILE* );
integer putchar( integer );
integer puts( char* );
uinteger fread( void*, uinteger, uinteger, struct _IO_FILE* );
uinteger fwrite( void*, uinteger, uinteger, struct _IO_FILE* );
integer fseek( struct _IO_FILE*, integer, integer );
integer ftell( struct _IO_FILE* );
void exit( integer );
integer rand( void );
void srand( uinteger );
void* calloc( uinteger, uinteger );
void* malloc( uinteger );
void* realloc( void*, uinteger );
void free( void* );
integer chdir( char* );
ubyte* CAST_VU8( ubyte* );
ushort* CAST_VU16( ushort* );
ulong* CAST_VU32( ulong* );
long* CAST_VS32( long* );
longint* CAST_VS64( longint* );
void irqSet( ulong, tmp$2 );
void irqEnable( ulong );
void irqDisable( ulong );
void swiIntrWait( ulong, ulong );
void swiWaitForVBlank( void );
static inline void SetYtrigger( integer );
static inline byte isDSiMode( void );
void powerOn( integer );
void lcdMainOnTop( void );
void lcdMainOnBottom( void );
void timerStart( integer, CLOCKDIVIDER, short, tmp$2 );
integer fifoSendValue32( integer, ulong );
integer fifoCheckValue32( integer );
ulong fifoGetValue32( integer );
void* DynamicArrayGet( struct DYNAMICARRAY*, uinteger );
integer bgInit_call( integer, BGTYPE, BGSIZE, integer, integer );
integer bgInitSub_call( integer, BGTYPE, BGSIZE, integer, integer );
void bgUpdate( void );
static inline integer BGINIT( integer, BGTYPE, BGSIZE, integer, integer );
static inline integer BGINITSUB( integer, BGTYPE, BGSIZE, integer, integer );
static inline ushort* BGGETGFXPTR( integer );
void DC_FlushRange( void*, ulong );
void consoleSetWindow( struct PRINTCONSOLE*, integer, integer, integer, integer );
struct PRINTCONSOLE* consoleSelect( struct PRINTCONSOLE* );
struct PRINTCONSOLE* consoleInit( struct PRINTCONSOLE*, integer, BGTYPE, BGSIZE, integer, integer, integer, integer );
void consoleClear( void );
void setExceptionHandler( tmp$2 );
void scanKeys( void );
ulong keysCurrent( void );
ulong keysHeld( void );
ulong keysDownRepeat( void );
void keysSetRepeat( ubyte, ubyte );
void touchRead( struct TOUCHPOSITION* );
struct KEYBOARD* keyboardInit( struct KEYBOARD*, integer, BGTYPE, BGSIZE, integer, integer, integer, integer );
void keyboardShow( void );
void keyboardHide( void );
integer keyboardUpdate( void );
static inline long divf32( long, long );
static inline long mulf32( long, long );
static inline long sqrtf32( long );
static inline void crossf32( long*, long*, long* );
static inline integer dotf32( long*, long* );
static inline void normalizef32( long* );
void soundEnable( void );
integer soundPlayPSG( DUTYCYCLE, ushort, ubyte, ubyte );
void soundKill( integer );
short sinLerp( short );
short cosLerp( short );
long tanLerp( short );
static inline void GLULOOKATF32( integer, integer, integer, integer, integer, integer, integer, integer, integer );
static inline void GLFRUSTUMF32( integer, integer, integer, integer, integer, integer );
integer nitroFSInit( char** );
integer stat( char*, struct STAT* );
integer closedir( struct DIR* );
struct DIR* opendir( char* );
struct DIRENT* readdir( struct DIR* );
void _ZN3GFX10INITSCREENEa( byte );
void _ZN3GFX11CLOSESCREENEv( void );
void _ZN3GFX12UPDATESCREENEPh( ubyte* );
static ulong NDS_ARM7ACK( void );
static void _FB_INT_UPDATESCREEN( void );
void TIMERINTERRUPT( void );
void VBLANKINTERRUPT( void );
static void ONKEYPRESSED( integer );
static void ONKEYRELEASED( integer );
static        integer fb_GfxWaitVSync( void );
static        integer fb_SleepEx( integer, integer );
static        void fb_PrintString( integer, void*, integer );
static        void* fb_StrAllocTempDescZEx( char*, integer );
static inline void* fb_StrAllocTempResult( void* );
static inline integer fbHexToInt( byte*, integer );
static inline integer fbOctToInt( byte*, integer );
static inline integer fbBinToInt( byte*, integer );
static inline longint fbHexToLng( byte*, integer );
static inline longint fbOctToLng( byte*, integer );
static inline longint fbBinToLng( byte*, integer );
static        void* fb_BINEx_Proto( integer, integer, integer );
static        void* fb_StrAssign( void*, integer, void*, integer, integer );
static        void fb_StrDelete( void* );
static        void* fb_StrFill1( integer, integer );
static        integer fb_InputNumber( char*, void* );
static        integer fb_FileSeek( integer, uinteger );
static        integer fb_FileEof( integer );
static        integer fb_WildMatch( char*, char* );
static        void* fb_Dir_Proto( void*, integer, integer* );
integer mkdir( char*, integer );
static        void fb_ArrayStrErase( void* );
static void FB_EXCEPTION( void );
static inline ushort fb_Gfx24to16( uinteger );
long WAITKEY( void );
void UPDATECURRENTVIEW( byte );
void SHOWSTATUS( void );
long GETLABEL( string*, long* );
long ADDLABEL( string*, long, byte );
long ADDPATCH( struct PATCHSTRUCT* );
long ADDBLOCK( long, long );
long NOMOREPARMS_( void );
void ENDOFLINE_( void );
long OPNOP( long );
long OPMOD( long );
long OPJMP( long );
long DECLBYTE( long );
long DEFCONST( long );
long PROCESSEOL_( void );
void PROCESSERROR_( void );
ubyte NEXTCHAR_( void );
long TRANSLATEADDRESSING( long, byte );
long FINDOPCODE( string* );
long PROCESSOPCODE_( void );
long PROCESSLABEL_( void );
long PROCESSNEWORG_( void );
byte ASSEMBLE( string*, byte );
byte DISASMINSTRUCTION( long* );
ubyte _ZN3CPU8READBYTEEl( long );
void _ZN3CPU9WRITEBYTEElh( long, ubyte );
void _ZN3CPU8RESETCPUERNS_7CPUCOREE( struct CPU$CPUCORE* );
void _ZN3CPU7SHOWCPUERNS_7CPUCOREE( struct CPU$CPUCORE* );
void _ZN3CPU22FNOPCODE_UNIMPLEMENTEDEv( void );
void _ZN3CPU12FNOPCODE__X_Ev( void );
void _ZN3CPU17FNOPCODE_BRK_NONEEv( void );
void _ZN3CPU18FNOPCODE_ORA_IND8XEv( void );
void _ZN3CPU15FNOPCODE_ORA_Z8Ev( void );
void _ZN3CPU15FNOPCODE_ASL_Z8Ev( void );
void _ZN3CPU17FNOPCODE_PHP_NONEEv( void );
void _ZN3CPU17FNOPCODE_ORA_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_ASLA_ACCEv( void );
void _ZN3CPU16FNOPCODE_ORA_A16Ev( void );
void _ZN3CPU16FNOPCODE_ASL_A16Ev( void );
void _ZN3CPU16FNOPCODE_BPL_R16Ev( void );
void _ZN3CPU18FNOPCODE_ORA_IND8YEv( void );
void _ZN3CPU16FNOPCODE_ORA_I8XEv( void );
void _ZN3CPU16FNOPCODE_ASL_I8XEv( void );
void _ZN3CPU17FNOPCODE_CLC_NONEEv( void );
void _ZN3CPU17FNOPCODE_ORA_I16YEv( void );
void _ZN3CPU17FNOPCODE_ORA_I16XEv( void );
void _ZN3CPU17FNOPCODE_ASL_I16XEv( void );
void _ZN3CPU16FNOPCODE_JSR_A16Ev( void );
void _ZN3CPU18FNOPCODE_AND_IND8XEv( void );
void _ZN3CPU15FNOPCODE_BIT_Z8Ev( void );
void _ZN3CPU15FNOPCODE_AND_Z8Ev( void );
void _ZN3CPU15FNOPCODE_ROL_Z8Ev( void );
void _ZN3CPU17FNOPCODE_PLP_NONEEv( void );
void _ZN3CPU17FNOPCODE_AND_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_ROLA_ACCEv( void );
void _ZN3CPU16FNOPCODE_BIT_A16Ev( void );
void _ZN3CPU16FNOPCODE_AND_A16Ev( void );
void _ZN3CPU16FNOPCODE_ROL_A16Ev( void );
void _ZN3CPU16FNOPCODE_BMI_R16Ev( void );
void _ZN3CPU18FNOPCODE_AND_IND8YEv( void );
void _ZN3CPU16FNOPCODE_AND_I8XEv( void );
void _ZN3CPU16FNOPCODE_ROL_I8XEv( void );
void _ZN3CPU17FNOPCODE_SEC_NONEEv( void );
void _ZN3CPU17FNOPCODE_AND_I16YEv( void );
void _ZN3CPU17FNOPCODE_AND_I16XEv( void );
void _ZN3CPU17FNOPCODE_ROL_I16XEv( void );
void _ZN3CPU17FNOPCODE_RTI_NONEEv( void );
void _ZN3CPU18FNOPCODE_EOR_IND8XEv( void );
void _ZN3CPU15FNOPCODE_EOR_Z8Ev( void );
void _ZN3CPU15FNOPCODE_LSR_Z8Ev( void );
void _ZN3CPU17FNOPCODE_PHA_NONEEv( void );
void _ZN3CPU17FNOPCODE_EOR_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_LSRA_ACCEv( void );
void _ZN3CPU16FNOPCODE_JMP_A16Ev( void );
void _ZN3CPU16FNOPCODE_EOR_A16Ev( void );
void _ZN3CPU16FNOPCODE_LSR_A16Ev( void );
void _ZN3CPU16FNOPCODE_BVC_R16Ev( void );
void _ZN3CPU18FNOPCODE_EOR_IND8YEv( void );
void _ZN3CPU16FNOPCODE_EOR_I8XEv( void );
void _ZN3CPU16FNOPCODE_LSR_I8XEv( void );
void _ZN3CPU17FNOPCODE_CLI_NONEEv( void );
void _ZN3CPU17FNOPCODE_EOR_I16YEv( void );
void _ZN3CPU17FNOPCODE_EOR_I16XEv( void );
void _ZN3CPU17FNOPCODE_LSR_I16XEv( void );
void _ZN3CPU17FNOPCODE_RTS_NONEEv( void );
void _ZN3CPU18FNOPCODE_ADC_IND8XEv( void );
void _ZN3CPU15FNOPCODE_ADC_Z8Ev( void );
void _ZN3CPU15FNOPCODE_ROR_Z8Ev( void );
void _ZN3CPU17FNOPCODE_PLA_NONEEv( void );
void _ZN3CPU17FNOPCODE_ADC_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_RORA_ACCEv( void );
void _ZN3CPU18FNOPCODE_JMP_IND16Ev( void );
void _ZN3CPU16FNOPCODE_ADC_A16Ev( void );
void _ZN3CPU16FNOPCODE_ROR_A16Ev( void );
void _ZN3CPU16FNOPCODE_BVS_R16Ev( void );
void _ZN3CPU18FNOPCODE_ADC_IND8YEv( void );
void _ZN3CPU16FNOPCODE_ADC_I8XEv( void );
void _ZN3CPU16FNOPCODE_ROR_I8XEv( void );
void _ZN3CPU17FNOPCODE_SEI_NONEEv( void );
void _ZN3CPU17FNOPCODE_ADC_I16YEv( void );
void _ZN3CPU17FNOPCODE_ADC_I16XEv( void );
void _ZN3CPU17FNOPCODE_ROR_I16XEv( void );
void _ZN3CPU18FNOPCODE_STA_IND8XEv( void );
void _ZN3CPU15FNOPCODE_STY_Z8Ev( void );
void _ZN3CPU15FNOPCODE_STA_Z8Ev( void );
void _ZN3CPU15FNOPCODE_STX_Z8Ev( void );
void _ZN3CPU17FNOPCODE_DEY_NONEEv( void );
void _ZN3CPU17FNOPCODE_TXA_NONEEv( void );
void _ZN3CPU16FNOPCODE_STY_A16Ev( void );
void _ZN3CPU16FNOPCODE_STA_A16Ev( void );
void _ZN3CPU16FNOPCODE_STX_A16Ev( void );
void _ZN3CPU16FNOPCODE_BCC_R16Ev( void );
void _ZN3CPU18FNOPCODE_STA_IND8YEv( void );
void _ZN3CPU16FNOPCODE_STY_I8XEv( void );
void _ZN3CPU16FNOPCODE_STA_I8XEv( void );
void _ZN3CPU16FNOPCODE_STX_I8YEv( void );
void _ZN3CPU17FNOPCODE_TYA_NONEEv( void );
void _ZN3CPU17FNOPCODE_STA_I16YEv( void );
void _ZN3CPU17FNOPCODE_TXS_NONEEv( void );
void _ZN3CPU17FNOPCODE_STA_I16XEv( void );
void _ZN3CPU17FNOPCODE_LDY_IMM8Ev( void );
void _ZN3CPU18FNOPCODE_LDA_IND8XEv( void );
void _ZN3CPU17FNOPCODE_LDX_IMM8Ev( void );
void _ZN3CPU15FNOPCODE_LDY_Z8Ev( void );
void _ZN3CPU15FNOPCODE_LDA_Z8Ev( void );
void _ZN3CPU15FNOPCODE_LDX_Z8Ev( void );
void _ZN3CPU17FNOPCODE_TAY_NONEEv( void );
void _ZN3CPU17FNOPCODE_LDA_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_TAX_NONEEv( void );
void _ZN3CPU16FNOPCODE_LDY_A16Ev( void );
void _ZN3CPU16FNOPCODE_LDA_A16Ev( void );
void _ZN3CPU16FNOPCODE_LDX_A16Ev( void );
void _ZN3CPU16FNOPCODE_BCS_R16Ev( void );
void _ZN3CPU18FNOPCODE_LDA_IND8YEv( void );
void _ZN3CPU16FNOPCODE_LDY_I8XEv( void );
void _ZN3CPU16FNOPCODE_LDA_I8XEv( void );
void _ZN3CPU16FNOPCODE_LDX_I8YEv( void );
void _ZN3CPU17FNOPCODE_CLV_NONEEv( void );
void _ZN3CPU17FNOPCODE_LDA_I16YEv( void );
void _ZN3CPU17FNOPCODE_TSX_NONEEv( void );
void _ZN3CPU17FNOPCODE_LDY_I16XEv( void );
void _ZN3CPU17FNOPCODE_LDA_I16XEv( void );
void _ZN3CPU17FNOPCODE_LDX_I16YEv( void );
void _ZN3CPU17FNOPCODE_CPY_IMM8Ev( void );
void _ZN3CPU18FNOPCODE_CMP_IND8XEv( void );
void _ZN3CPU15FNOPCODE_CPY_Z8Ev( void );
void _ZN3CPU15FNOPCODE_CMP_Z8Ev( void );
void _ZN3CPU15FNOPCODE_DEC_Z8Ev( void );
void _ZN3CPU17FNOPCODE_INY_NONEEv( void );
void _ZN3CPU17FNOPCODE_CMP_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_DEX_NONEEv( void );
void _ZN3CPU16FNOPCODE_CPY_A16Ev( void );
void _ZN3CPU16FNOPCODE_CMP_A16Ev( void );
void _ZN3CPU16FNOPCODE_DEC_A16Ev( void );
void _ZN3CPU16FNOPCODE_BNE_R16Ev( void );
void _ZN3CPU18FNOPCODE_CMP_IND8YEv( void );
void _ZN3CPU16FNOPCODE_CMP_I8XEv( void );
void _ZN3CPU16FNOPCODE_DEC_I8XEv( void );
void _ZN3CPU17FNOPCODE_CLD_NONEEv( void );
void _ZN3CPU17FNOPCODE_CMP_I16YEv( void );
void _ZN3CPU17FNOPCODE_CMP_I16XEv( void );
void _ZN3CPU17FNOPCODE_DEC_I16XEv( void );
void _ZN3CPU17FNOPCODE_CPX_IMM8Ev( void );
void _ZN3CPU18FNOPCODE_SBC_IND8XEv( void );
void _ZN3CPU15FNOPCODE_CPX_Z8Ev( void );
void _ZN3CPU15FNOPCODE_SBC_Z8Ev( void );
void _ZN3CPU15FNOPCODE_INC_Z8Ev( void );
void _ZN3CPU17FNOPCODE_INX_NONEEv( void );
void _ZN3CPU17FNOPCODE_SBC_IMM8Ev( void );
void _ZN3CPU17FNOPCODE_NOP_NONEEv( void );
void _ZN3CPU16FNOPCODE_CPX_A16Ev( void );
void _ZN3CPU16FNOPCODE_SBC_A16Ev( void );
void _ZN3CPU16FNOPCODE_INC_A16Ev( void );
void _ZN3CPU16FNOPCODE_BEQ_R16Ev( void );
void _ZN3CPU18FNOPCODE_SBC_IND8YEv( void );
void _ZN3CPU16FNOPCODE_SBC_I8XEv( void );
void _ZN3CPU16FNOPCODE_INC_I8XEv( void );
void _ZN3CPU17FNOPCODE_SED_NONEEv( void );
void _ZN3CPU17FNOPCODE_SBC_I16YEv( void );
void _ZN3CPU17FNOPCODE_SBC_I16XEv( void );
void _ZN3CPU17FNOPCODE_INC_I16XEv( void );
void DRAGWINDOW( byte );
void FOCUSCONSOLE( void );
long READKEY( void );
void HANDLEVIEWKEYS( long );
byte HANDLEKEYS( void );
void fb_ctor__main( void );
static void _GLOBAL__I( void )                               ;
static void _GLOBAL__D( void ) __attribute__(( destructor ));
static char* _ZN2FB10PZEXEPATH$E;
static short _ZN2FB14VSYNCHAPPENED$E;
static short _ZN2FB15KEYBOARDOFFSET$E;
static short _ZN2FB19KEYBOARDTEMPOFFSET$E;
static byte _ZN2FB15SCREENECHOISON$E;
static byte _ZN2FB13KEYBOARDISON$E;
static short _ZN2FB10INKEYBUFF$E[256];
static short _ZN2FB10CODESTATE$E[256];
static short _ZN2FB10SCANSTATE$E[256];
static short _ZN2FB11INKEYWRITE$E;
static short _ZN2FB10INKEYREAD$E;
static short _ZN2FB10DSBUTTONS$E;
static short _ZN2FB7MOUSEX$E;
static short _ZN2FB7MOUSEY$E;
static integer _ZN2FB13INITIALSTACK$E;
static integer _ZN2FB19EXECUTINGCALLBACKS$E;
static struct FBSTRING* _ZN2FB11TEMPSTRING$E;
static struct FBSTRING* _ZN2FB12INPUTSTRING$E;
static struct FBSTRING* _ZN2FB13RETURNSTRING$E;
static struct FBSTRING* _ZN2FB12DESTROYTEMP$E;
static struct FB$FBFILE _ZN2FB5FNUM$E[127];
extern byte __dsimode;
extern ushort* bgControl[8];
struct BG_SCROLL {
	ushort X;
	ushort Y;
};
extern struct BG_SCROLL* bgScrollTable[8];
struct BG_TRANSFORM {
	short HDX;
	short VDX;
	short HDY;
	short VDY;
	long DX;
	long DY;
};
extern struct BG_TRANSFORM* bgTransform[8];
extern struct BGSTATE bgState[8];
typedef int GL_MATRIX_MODE_ENUM;
struct S_SINGLEBLOCK;
struct S_SINGLEBLOCK {
	ulong INDEXOUT;
	ubyte* ADDRSET;
	struct S_SINGLEBLOCK* NODE[4];
	ulong BLOCKSIZE;
};
struct S_VRAMBLOCK {
	ubyte* STARTADDR;
	ubyte* ENDADDR;
	struct S_SINGLEBLOCK* FIRSTBLOCK;
	struct S_SINGLEBLOCK* FIRSTEMPTY;
	struct S_SINGLEBLOCK* FIRSTALLOC;
	struct S_SINGLEBLOCK* LASTEXAMINED;
	ubyte* LASTEXAMINEDADDR;
	ulong LASTEXAMINEDSIZE;
	struct DYNAMICARRAY BLOCKPTRS;
	struct DYNAMICARRAY DEALLOCBLOCKS;
	ulong BLOCKCOUNT;
	ulong DEALLOCCOUNT;
};
struct GL_HIDDEN_GLOBALS {
	GL_MATRIX_MODE_ENUM MATRIXMODE;
	struct S_VRAMBLOCK* VRAMBLOCKS[2];
	integer VRAMLOCK[2];
	struct DYNAMICARRAY TEXTUREPTRS;
	struct DYNAMICARRAY PALETTEPTRS;
	struct DYNAMICARRAY DEALLOCTEX;
	struct DYNAMICARRAY DEALLOCPAL;
	ulong DEALLOCTEXSIZE;
	ulong DEALLOCPALSIZE;
	integer ACTIVETEXTURE;
	integer ACTIVEPALETTE;
	integer TEXCOUNT;
	integer PALCOUNT;
	ulong CLEARCOLOR;
	ubyte ISACTIVE;
};
extern struct GL_HIDDEN_GLOBALS glGlobalData;
static struct GL_HIDDEN_GLOBALS* GLGLOB$ = (void*)&glGlobalData;
struct GLOBALDATA {
	integer ERRNUM __attribute__((packed, aligned(1)));
	struct _IO_FILE* STDIN_ __attribute__((packed, aligned(1)));
	struct _IO_FILE* STDOUT_ __attribute__((packed, aligned(1)));
	struct _IO_FILE* STDERR_ __attribute__((packed, aligned(1)));
};
extern struct GLOBALDATA* _impure_ptr;
struct GFX$ENGINEFLAGS {
	integer NEEDUPDATE;
};
static struct GFX$ENGINEFLAGS _ZN3GFX3FG$E;
static ushort* _ZN3GFX11PALETTEPTR$E;
static void* _ZN3GFX7SCRPTR$E;
static void* _ZN3GFX8VRAMPTR$E;
static void* _ZN3GFX9VRAMBPTR$E;
static short _ZN3GFX7LOCKED$E;
static short _ZN3GFX5CURX$E;
static short _ZN3GFX5CURY$E;
static short _ZN3GFX10GFXDRIVER$E;
static short _ZN3GFX14CURRENTDRIVER$E = -32768;
static struct FB$IMAGE* _ZN3GFX4SCR$E;
static uinteger _ZN3GFX11TRANSCOLOR$E;
static uinteger _ZN3GFX8GFXSIZE$E;
static uinteger _ZN3GFX12VERTEXCOUNT$E;
static integer _ZN3GFX3BG$E;
static integer _ZN3GFX4BG2$E;
static integer _ZN3GFX8TEXTURE$E;
static integer _ZN3GFX6DEPTH$E;
static integer _ZN3GFX8FONTTEX$E;
static integer _ZN3GFX21G_TEXTUREMEMORYUSAGE$E;
static short _ZN3GFX7ISVIEW$E;
static short _ZN3GFX7VIEWLT$E;
static short _ZN3GFX7VIEWTP$E;
static short _ZN3GFX7VIEWRT$E;
static short _ZN3GFX7VIEWBT$E;
static short _ZN3GFX8VIEWWID$E;
static short _ZN3GFX8VIEWHEI$E;
static uinteger _ZN3GFX11DEFAULTVGA$E[256] = { 0u, 170u, 43520u, 43690u, 11141120u, 11141290u, 11162880u, 11184810u, 5592405u, 5592575u, 5635925u, 5636095u, 16733525u, 16733695u, 16777045u, 16777215u, 0u, 1315860u, 2105376u, 2894892u, 3684408u, 4473924u, 5263440u, 6381921u, 7434609u, 8487297u, 9539985u, 10592673u, 11974326u, 13290186u, 14869218u, 16777215u, 255u, 4194559u, 8192255u, 12452095u, 16711935u, 16711870u, 16711805u, 16711744u, 16711680u, 16728064u, 16743680u, 16760320u, 16776960u, 12517120u, 8257280u, 4259584u, 65280u, 65344u, 65405u, 65470u, 65535u, 48895u, 32255u, 16639u, 8224255u, 10321407u, 12484095u, 14581247u, 16743935u, 16743902u, 16743870u, 16743837u, 16743805u, 16751997u, 16760445u, 16768637u, 16777085u, 14614397u, 12517245u, 10354557u, 8257405u, 8257437u, 8257470u, 8257502u, 8257535u, 8249087u, 8240895u, 8232447u, 11974399u, 13022975u, 14333695u, 15382271u, 16758527u, 16758506u, 16758490u, 16758470u, 16758454u, 16762550u, 16767670u, 16771766u, 16777142u, 15400886u, 14352310u, 13041590u, 11993014u, 11993030u, 11993050u, 11993066u, 11993087u, 11987711u, 11983615u, 11978495u, 113u, 1835121u, 3670129u, 5570673u, 7405681u, 7405653u, 7405624u, 7405596u, 7405568u, 7412736u, 7419904u, 7427328u, 7434496u, 5599488u, 3698944u, 1863936u, 28928u, 28956u, 28984u, 29013u, 29041u, 21873u, 14449u, 7281u, 3684465u, 4470897u, 5585009u, 6371441u, 7420017u, 7420001u, 7419989u, 7419972u, 7419960u, 7423032u, 7427384u, 7430456u, 7434552u, 6385976u, 5599544u, 4485432u, 3699000u, 3699012u, 3699029u, 3699041u, 3699057u, 3694961u, 3691889u, 3687537u, 5263473u, 5853297u, 6377585u, 6901873u, 7426161u, 7426153u, 7426145u, 7426137u, 7426128u, 7428432u, 7430480u, 7432528u, 7434576u, 6910288u, 6386000u, 5861712u, 5271888u, 5271897u, 5271905u, 5271913u, 5271921u, 5269873u, 5267825u, 5265777u, 64u, 1048640u, 2097216u, 3145792u, 4194368u, 4194352u, 4194336u, 4194320u, 4194304u, 4198400u, 4202496u, 4206592u, 4210688u, 3162112u, 2113536u, 1064960u, 16384u, 16400u, 16416u, 16432u, 16448u, 12352u, 8256u, 4160u, 2105408u, 2629696u, 3153984u, 3678272u, 4202560u, 4202552u, 4202544u, 4202536u, 4202528u, 4204576u, 4206624u, 4208672u, 4210720u, 3686432u, 3162144u, 2637856u, 2113568u, 2113576u, 2113584u, 2113592u, 2113600u, 2111552u, 2109504u, 2107456u, 2894912u, 3157056u, 3419200u, 3943488u, 4205632u, 4205628u, 4205620u, 4205616u, 4205612u, 4206636u, 4207660u, 4209708u, 4210732u, 3948588u, 3424300u, 3162156u, 2900012u, 2900016u, 2900020u, 2900028u, 2900032u, 2899008u, 2896960u, 2895936u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u };
static void* FBLASTCONCAT$;
static struct KEYBOARD* FBKEYBOARD$;
static struct PRINTCONSOLE* FBCONSOLE$;
static struct PRINTCONSOLE FBTOPCONSOLE$;
static struct PRINTCONSOLE FBBOTTOMCONSOLE$;
static ulong FB_TICKS$;
static void* TEMPSTRINGLIST$[64];
static long TEMPSTRINGCOUNT$ = 0;
static long NDS_PENDINGACK$ = 0;
typedef integer (*tmp$76)( void* );
static tmp$76 FBTEMPCALLBACK$;
extern long keyBufferLength;
extern ubyte fbgfxfont_tex;
static short IFBATNTAB$[2049];
static ubyte TBUFF$[1024];
static ubyte BSCREENON$;
static long G_BBREAKPOINT$ = -1;
static byte G_BFINISHED$;
static byte G_GFXFOCUS$;
static byte G_BVIEWMODE$ = 0;
static longint UTOTALCYCLES$;
static longint UTOTALCYCLES2$;
struct LABELSTRUCT {
	char SNAME[56];
	long UADDR;
	ubyte B16;
};
static struct LABELSTRUCT G_TLABEL$[512];
static struct PATCHSTRUCT G_TPATCH$[512];
struct BLOCKSTRUCT {
	ushort UBEGIN;
	ushort UEND;
};
static struct BLOCKSTRUCT G_TBLOCK$[64];
static long G_ILABELSCOUNT$;
static long G_IPATCHCOUNT$;
static long G_IBLOCKCOUNT$;
static ubyte G_BMEMORY$[65536];
static byte G_BMEMCHG$[65536];
static long G_LPOSITION$[65536];
static long G_LLINEINDEX$[65536];
static ushort G_WLINEADDR$[65536];
static struct PARSERSTRUCT G_TPARSER$;
static struct OPCODESTRUCT TOPCODE$[58] = { { "ADC", { 255u, 255u, 105u, 101u, 117u, 109u, 125u, 121u, 255u, 97u, 113u }, (void*)&OPMOD }, { "AND", { 255u, 255u, 41u, 37u, 53u, 45u, 61u, 57u, 255u, 33u, 49u }, (void*)&OPMOD }, { "ASL", { 255u, 10u, 255u, 6u, 22u, 14u, 30u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "BCC", { 255u, 255u, 144u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BCS", { 255u, 255u, 176u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BEQ", { 255u, 255u, 240u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BIT", { 255u, 255u, 255u, 36u, 255u, 44u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "BMI", { 255u, 255u, 48u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BNE", { 255u, 255u, 208u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BPL", { 255u, 255u, 16u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BRK", { 0u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "BVC", { 255u, 255u, 80u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "BVS", { 255u, 255u, 112u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "CLC", { 24u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "CLD", { 216u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "CLI", { 88u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "CLV", { 184u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "CMP", { 255u, 255u, 201u, 197u, 213u, 205u, 221u, 217u, 255u, 193u, 209u }, (void*)&OPMOD }, { "CPX", { 255u, 255u, 224u, 228u, 255u, 236u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "CPY", { 255u, 255u, 192u, 196u, 255u, 204u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "DEC", { 255u, 255u, 255u, 198u, 214u, 206u, 222u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "DEX", { 202u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "DEY", { 136u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "EOR", { 255u, 255u, 73u, 69u, 85u, 77u, 93u, 89u, 255u, 65u, 81u }, (void*)&OPMOD }, { "INC", { 255u, 255u, 255u, 230u, 246u, 238u, 254u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "INX", { 232u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "INY", { 200u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "JMP", { 255u, 255u, 255u, 255u, 255u, 76u, 255u, 255u, 108u, 255u, 255u }, (void*)&OPJMP }, { "JSR", { 255u, 255u, 255u, 255u, 255u, 32u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPJMP }, { "LDA", { 255u, 255u, 169u, 165u, 181u, 173u, 189u, 185u, 255u, 161u, 177u }, (void*)&OPMOD }, { "LDX", { 255u, 255u, 162u, 166u, 182u, 174u, 255u, 190u, 255u, 255u, 255u }, (void*)&OPMOD }, { "LDY", { 255u, 255u, 160u, 164u, 180u, 172u, 188u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "LSR", { 255u, 74u, 255u, 166u, 86u, 78u, 94u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "NOP", { 234u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "ORA", { 255u, 255u, 9u, 5u, 21u, 13u, 29u, 25u, 255u, 1u, 17u }, (void*)&OPMOD }, { "PHA", { 72u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "PHP", { 8u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "PLA", { 104u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "PLP", { 40u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "ROL", { 255u, 42u, 255u, 38u, 54u, 46u, 62u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "ROR", { 255u, 106u, 255u, 102u, 118u, 110u, 126u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "RTI", { 64u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "RTS", { 96u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "SBC", { 255u, 255u, 233u, 229u, 245u, 237u, 253u, 249u, 255u, 225u, 241u }, (void*)&OPMOD }, { "SEC", { 56u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "SED", { 248u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "SEI", { 120u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "STA", { 255u, 255u, 255u, 133u, 149u, 141u, 157u, 153u, 255u, 129u, 145u }, (void*)&OPMOD }, { "STX", { 255u, 255u, 255u, 134u, 150u, 142u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "STY", { 255u, 255u, 255u, 132u, 148u, 140u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPMOD }, { "TAX", { 170u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "TAY", { 168u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "TSX", { 186u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "TXA", { 138u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "TXS", { 154u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "TYA", { 152u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&OPNOP }, { "DCB", { 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&DECLBYTE }, { "DEFINE", { 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u, 255u }, (void*)&DEFCONST } };
static byte G_LENDISASM$[256] = { 1, 2, -1, -1, -1, 2, 2, -1, 1, 2, 1, -1, -1, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1, 3, 2, -1, -1, 2, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1, 1, 2, -1, -1, -1, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1, 1, 2, -1, -1, -1, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1, -1, 2, -1, -1, 2, 2, 2, -1, 1, -1, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, 2, 2, 2, -1, 1, 3, 1, -1, -1, 3, -1, -1, 2, 2, 2, -1, 2, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, 2, 2, 2, -1, 1, 3, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, 2, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1, 2, 2, -1, -1, 2, 2, 2, -1, 1, 2, 1, -1, 3, 3, 3, -1, 2, 2, -1, -1, -1, 2, 2, -1, 1, 3, -1, -1, -1, 3, 3, -1 };
static char G_ZDISM$[256][12] = { "BRK", "ORA ($xx,X)", "", "", "", "ORA $xx", "ASL $xx", "", "PHP", "ORA #$xx", "ASL  A", "", "", "ORA $xxxx", "ASL $xxxx", "", "BPL $xx@@", "ORA ($xx),Y", "", "", "", "ORA $xx,X", "ASL $xx,X", "", "CLC", "ORA $xxxx,Y", "", "", "", "ORA $xxxx,X", "ASL $xxxx,X", "", "JSR $xxxx", "AND ($xx,X)", "", "", "BIT $xx", "AND $xx", "ROL $xx", "", "PLP", "AND #$xx", "ROL  A", "", "BIT $xxxx", "AND $xxxx", "ROL $xxxx", "", "BMI $xx@@", "AND ($xx),Y", "", "", "", "AND $xx,X", "ROL $xx,X", "", "SEC", "AND $xxxx,Y", "", "", "", "AND $xxxx,X", "ROL $xxxx,X", "", "RTI", "EOR ($xx,X)", "", "", "", "EOR $xx", "LSR $xx", "", "PHA", "EOR #$xx", "LSR  A", "", "JMP $xxxx", "EOR $xxxx", "LSR $xxxx", "", "BVC $xx@@", "EOR ($xx),Y", "", "", "", "EOR $xx,X", "LSR $xx,X", "", "CLI", "EOR $xxxx,Y", "", "", "", "EOR $xxxx,X", "LSR $xxxx,X", "", "RTS", "ADC ($xx,X)", "", "", "", "ADC $xx", "ROR $xx", "", "PLA", "ADC #$xx", "ROR  A", "", "JMP ($xxxx)", "ADC $xxxx", "ROR $xxxx", "", "BVS $xx@@", "ADC ($xx),Y", "", "", "", "ADC $xx,X", "ROR $xx,X", "", "SEI", "ADC $xxxx,Y", "", "", "", "ADC $xxxx,X", "ROR $xxxx,X", "", "", "STA ($xx,X)", "", "", "STY $xx", "STA $xx", "STX $xx", "", "DEY", "", "TXA", "", "STY $xxxx", "STA $xxxx", "STX $xxxx", "", "BCC $xx@@", "STA ($xx),Y", "", "", "STY $xx,X", "STA $xx,X", "STX $xx,Y", "", "TYA", "STA $xxxx,Y", "TXS", "", "", "STA $xxxx,X", "", "", "LDY #$xx", "LDA ($xx,X)", "LDX #$xx", "", "LDY $xx", "LDA $xx", "LDX $xx", "", "TAY", "LDA #$xx", "TAX", "", "LDY $xxxx", "LDA $xxxx", "LDX $xxxx", "", "BCS $xx@@", "LDA ($xx),Y", "", "", "LDY $xx,X", "LDA $xx,X", "LDX $xx,Y", "", "CLV", "LDA $xxxx,Y", "TSX", "", "LDY $xxxx,X", "LDA $xxxx,X", "LDX $xxxx,Y", "", "CPY #$xx", "CMP ($xx,X)", "", "", "CPY $xx", "CMP $xx", "DEC $xx", "", "INY", "CMP #$xx", "DEX", "", "CPY $xxxx", "CMP $xxxx", "DEC $xxxx", "", "BNE $xx@@", "CMP ($xx),Y", "", "", "", "CMP $xx,X", "DEC $xx,X", "", "CLD", "CMP $xxxx,Y", "", "", "", "CMP $xxxx,X", "DEC $xxxx,X", "", "CPX #$xx", "SBC ($xx,X)", "", "", "CPX $xx", "SBC $xx", "INC $xx", "", "INX", "SBC #$xx", "NOP", "", "CPX $xxxx", "SBC $xxxx", "INC $xxxx", "", "BEQ $xx@@", "SBC ($xx),Y", "", "", "", "SBC $xx,X", "INC $xx,X", "", "SED", "SBC $xxxx,Y", "", "", "", "SBC $xxxx,X", "INC $xxxx,X", "" };
static struct CPU$CPUCORE _ZN3CPU7G_TCPU$E;
static tmp$2 _ZN3CPU11G_FNOPCODE$E[257] = { (void*)&_ZN3CPU17FNOPCODE_BRK_NONEEv, (void*)&_ZN3CPU18FNOPCODE_ORA_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_ORA_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_ASL_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_PHP_NONEEv, (void*)&_ZN3CPU17FNOPCODE_ORA_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_ASLA_ACCEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_ORA_A16Ev, (void*)&_ZN3CPU16FNOPCODE_ASL_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BPL_R16Ev, (void*)&_ZN3CPU18FNOPCODE_ORA_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_ORA_I8XEv, (void*)&_ZN3CPU16FNOPCODE_ASL_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CLC_NONEEv, (void*)&_ZN3CPU17FNOPCODE_ORA_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_ORA_I16XEv, (void*)&_ZN3CPU17FNOPCODE_ASL_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_JSR_A16Ev, (void*)&_ZN3CPU18FNOPCODE_AND_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_BIT_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_AND_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_ROL_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_PLP_NONEEv, (void*)&_ZN3CPU17FNOPCODE_AND_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_ROLA_ACCEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BIT_A16Ev, (void*)&_ZN3CPU16FNOPCODE_AND_A16Ev, (void*)&_ZN3CPU16FNOPCODE_ROL_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BMI_R16Ev, (void*)&_ZN3CPU18FNOPCODE_AND_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_AND_I8XEv, (void*)&_ZN3CPU16FNOPCODE_ROL_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_SEC_NONEEv, (void*)&_ZN3CPU17FNOPCODE_AND_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_AND_I16XEv, (void*)&_ZN3CPU17FNOPCODE_ROL_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_RTI_NONEEv, (void*)&_ZN3CPU18FNOPCODE_EOR_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_EOR_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_LSR_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_PHA_NONEEv, (void*)&_ZN3CPU17FNOPCODE_EOR_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_LSRA_ACCEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_JMP_A16Ev, (void*)&_ZN3CPU16FNOPCODE_EOR_A16Ev, (void*)&_ZN3CPU16FNOPCODE_LSR_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BVC_R16Ev, (void*)&_ZN3CPU18FNOPCODE_EOR_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_EOR_I8XEv, (void*)&_ZN3CPU16FNOPCODE_LSR_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CLI_NONEEv, (void*)&_ZN3CPU17FNOPCODE_EOR_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_EOR_I16XEv, (void*)&_ZN3CPU17FNOPCODE_LSR_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_RTS_NONEEv, (void*)&_ZN3CPU18FNOPCODE_ADC_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_ADC_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_ROR_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_PLA_NONEEv, (void*)&_ZN3CPU17FNOPCODE_ADC_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_RORA_ACCEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU18FNOPCODE_JMP_IND16Ev, (void*)&_ZN3CPU16FNOPCODE_ADC_A16Ev, (void*)&_ZN3CPU16FNOPCODE_ROR_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BVS_R16Ev, (void*)&_ZN3CPU18FNOPCODE_ADC_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_ADC_I8XEv, (void*)&_ZN3CPU16FNOPCODE_ROR_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_SEI_NONEEv, (void*)&_ZN3CPU17FNOPCODE_ADC_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_ADC_I16XEv, (void*)&_ZN3CPU17FNOPCODE_ROR_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU18FNOPCODE_STA_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_STY_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_STA_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_STX_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_DEY_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_TXA_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_STY_A16Ev, (void*)&_ZN3CPU16FNOPCODE_STA_A16Ev, (void*)&_ZN3CPU16FNOPCODE_STX_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BCC_R16Ev, (void*)&_ZN3CPU18FNOPCODE_STA_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_STY_I8XEv, (void*)&_ZN3CPU16FNOPCODE_STA_I8XEv, (void*)&_ZN3CPU16FNOPCODE_STX_I8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_TYA_NONEEv, (void*)&_ZN3CPU17FNOPCODE_STA_I16YEv, (void*)&_ZN3CPU17FNOPCODE_TXS_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_STA_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_LDY_IMM8Ev, (void*)&_ZN3CPU18FNOPCODE_LDA_IND8XEv, (void*)&_ZN3CPU17FNOPCODE_LDX_IMM8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_LDY_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_LDA_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_LDX_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_TAY_NONEEv, (void*)&_ZN3CPU17FNOPCODE_LDA_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_TAX_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_LDY_A16Ev, (void*)&_ZN3CPU16FNOPCODE_LDA_A16Ev, (void*)&_ZN3CPU16FNOPCODE_LDX_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BCS_R16Ev, (void*)&_ZN3CPU18FNOPCODE_LDA_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_LDY_I8XEv, (void*)&_ZN3CPU16FNOPCODE_LDA_I8XEv, (void*)&_ZN3CPU16FNOPCODE_LDX_I8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CLV_NONEEv, (void*)&_ZN3CPU17FNOPCODE_LDA_I16YEv, (void*)&_ZN3CPU17FNOPCODE_TSX_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_LDY_I16XEv, (void*)&_ZN3CPU17FNOPCODE_LDA_I16XEv, (void*)&_ZN3CPU17FNOPCODE_LDX_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CPY_IMM8Ev, (void*)&_ZN3CPU18FNOPCODE_CMP_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_CPY_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_CMP_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_DEC_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_INY_NONEEv, (void*)&_ZN3CPU17FNOPCODE_CMP_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_DEX_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_CPY_A16Ev, (void*)&_ZN3CPU16FNOPCODE_CMP_A16Ev, (void*)&_ZN3CPU16FNOPCODE_DEC_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BNE_R16Ev, (void*)&_ZN3CPU18FNOPCODE_CMP_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_CMP_I8XEv, (void*)&_ZN3CPU16FNOPCODE_DEC_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CLD_NONEEv, (void*)&_ZN3CPU17FNOPCODE_CMP_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CMP_I16XEv, (void*)&_ZN3CPU17FNOPCODE_DEC_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_CPX_IMM8Ev, (void*)&_ZN3CPU18FNOPCODE_SBC_IND8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU15FNOPCODE_CPX_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_SBC_Z8Ev, (void*)&_ZN3CPU15FNOPCODE_INC_Z8Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_INX_NONEEv, (void*)&_ZN3CPU17FNOPCODE_SBC_IMM8Ev, (void*)&_ZN3CPU17FNOPCODE_NOP_NONEEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_CPX_A16Ev, (void*)&_ZN3CPU16FNOPCODE_SBC_A16Ev, (void*)&_ZN3CPU16FNOPCODE_INC_A16Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_BEQ_R16Ev, (void*)&_ZN3CPU18FNOPCODE_SBC_IND8YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU16FNOPCODE_SBC_I8XEv, (void*)&_ZN3CPU16FNOPCODE_INC_I8XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_SED_NONEEv, (void*)&_ZN3CPU17FNOPCODE_SBC_I16YEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU12FNOPCODE__X_Ev, (void*)&_ZN3CPU17FNOPCODE_SBC_I16XEv, (void*)&_ZN3CPU17FNOPCODE_INC_I16XEv, (void*)&_ZN3CPU12FNOPCODE__X_Ev, 0u };

#define fb_ftosl( temp_double ) ((longint)__builtin_llrintf(temp_double))
#define fb_ftoui( v ) (uinteger)fb_ftosl( v )

#define fb_ftosi( temp_double ) ((int)__builtin_lrintf(temp_double))
#define fb_ftoss( v ) (short)fb_ftosi( v )

#define fb_dtosl( temp_double ) ((longint)__builtin_llrint(temp_double))
#define fb_dtoui( v ) (uinteger)fb_dtosl( v )

#define fb_dtosi( temp_double ) ((integer)__builtin_lrint(temp_double))
#define fb_dtoss( v ) (short)fb_dtosi( v )

ubyte* CAST_VU8( ubyte* P$1 )
{
	ubyte* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (ubyte*)PP$1;
	goto label$3;
	label$3:;
	return fb$result$1;
}

ushort* CAST_VU16( ushort* P$1 )
{
	ushort* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (ushort*)PP$1;
	goto label$5;
	label$5:;
	return fb$result$1;
}

ulong* CAST_VU32( ulong* P$1 )
{
	ulong* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$6:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (ulong*)PP$1;
	goto label$7;
	label$7:;
	return fb$result$1;
}

ulongint* CAST_VU64( ulongint* P$1 )
{
	ulongint* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$8:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (ulongint*)PP$1;
	goto label$9;
	label$9:;
	return fb$result$1;
}

byte* CAST_VS8( byte* P$1 )
{
	byte* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$10:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (byte*)PP$1;
	goto label$11;
	label$11:;
	return fb$result$1;
}

short* CAST_VS16( short* P$1 )
{
	short* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$12:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (short*)PP$1;
	goto label$13;
	label$13:;
	return fb$result$1;
}

long* CAST_VS32( long* P$1 )
{
	long* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$14:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (long*)PP$1;
	goto label$15;
	label$15:;
	return fb$result$1;
}

longint* CAST_VS64( longint* P$1 )
{
	longint* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$16:;
	void* PP$1;
	__builtin_memset( &PP$1, 0, 4 );
	__asm__ __volatile__( "ldr  r0,  %1\n"  "str  r0,  %0\n"  : "=m" (PP$1)  : "m" (P$1)  : "r0"   );
	fb$result$1 = (longint*)PP$1;
	goto label$17;
	label$17:;
	return fb$result$1;
}

static inline void eepromWaitBusy( void )
{
	label$18:;
	label$20:;
	ushort* vr$24 = CAST_VU16( (ushort*)67109280 );
	if( ((integer)*vr$24 & 128) == 0 ) goto label$21;
	{
	}
	goto label$20;
	label$21:;
	label$19:;
}

static inline integer enterCriticalSection( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$22:;
	ulong OLDIME$1;
	ulong* vr$28 = CAST_VU32( (ulong*)67109384 );
	OLDIME$1 = *vr$28;
	ulong* vr$29 = CAST_VU32( (ulong*)67109384 );
	*vr$29 = 0u;
	fb$result$1 = (integer)OLDIME$1;
	goto label$23;
	label$23:;
	return fb$result$1;
}

static inline void leaveCriticalSection( integer OLDIME$1 )
{
	label$24:;
	ulong* vr$31 = CAST_VU32( (ulong*)67109384 );
	*vr$31 = (ulong)OLDIME$1;
	label$25:;
}

static inline void IPC_SendSync( uinteger _SYNC$1 )
{
	label$26:;
	ushort* vr$32 = CAST_VU16( (ushort*)67109248 );
	ushort* vr$40 = CAST_VU16( (ushort*)67109248 );
	*vr$40 = (ushort)(IPC_SYNC_BITS)((integer)(((integer)*vr$32 & 61695) | ((_SYNC$1 & 15) << 8)) | (IPC_SYNC_BITS)8192);
	label$27:;
}

static inline integer IPC_GetSync( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$28:;
	ushort* vr$42 = CAST_VU16( (ushort*)67109248 );
	fb$result$1 = (integer)*vr$42 & 15;
	goto label$29;
	label$29:;
	return fb$result$1;
}

static inline void sysSetCartOwner( integer iarm9 )
{
	integer tmp$22;
	label$30:;
	ushort* vr$46 = CAST_VU16( (ushort*)67109380 );
	if( iarm9 == 0 ) goto label$32;
	tmp$22 = 0;
	goto label$33;
	label$32:;
	tmp$22 = 128;
	label$33:;
	ushort* vr$51 = CAST_VU16( (ushort*)67109380 );
	*vr$51 = (ushort)(((integer)*vr$46 & 0) | tmp$22);
	label$31:;
}

static inline void sysSetCardOwner( integer iarm9 )
{
	integer tmp$23;
	label$34:;
	ushort* vr$52 = CAST_VU16( (ushort*)67109380 );
	if( iarm9 == 0 ) goto label$36;
	tmp$23 = 0;
	goto label$37;
	label$36:;
	tmp$23 = 2048;
	label$37:;
	ushort* vr$57 = CAST_VU16( (ushort*)67109380 );
	*vr$57 = (ushort)(((integer)*vr$52 & 0) | tmp$23);
	label$35:;
}

static inline void sysSetBusOwners( integer iarm9rom, integer iarm9card )
{
	integer tmp$24;
	integer tmp$25;
	label$38:;
	ushort* vr$58 = CAST_VU16( (ushort*)67109380 );
	if( iarm9card == 0 ) goto label$40;
	tmp$24 = 0;
	goto label$42;
	label$40:;
	tmp$24 = 2048;
	label$42:;
	if( iarm9rom == 0 ) goto label$41;
	tmp$25 = 0;
	goto label$43;
	label$41:;
	tmp$25 = 128;
	label$43:;
	ushort* vr$64 = CAST_VU16( (ushort*)67109380 );
	*vr$64 = (ushort)((((integer)*vr$58 & 0) | tmp$24) | tmp$25);
	label$39:;
}

static inline void SetYtrigger( integer YVALUE$1 )
{
	label$44:;
	ushort* vr$65 = CAST_VU16( (ushort*)67108868 );
	ushort* vr$74 = CAST_VU16( (ushort*)67108868 );
	*vr$74 = (ushort)((((integer)*vr$65 & 127) | (YVALUE$1 << 8)) | ((YVALUE$1 & 256) >> 1));
	label$45:;
}

static inline byte isDSiMode( void )
{
	byte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$46:;
	fb$result$1 = __dsimode;
	goto label$47;
	label$47:;
	return fb$result$1;
}

void lcdSwap( void )
{
	ushort* tmp$26;
	label$48:;
	ushort* vr$77 = CAST_VU16( (ushort*)67109636 );
	tmp$26 = vr$77;
	*tmp$26 = (ushort)(PM_BITS)((PM_BITS)*tmp$26 ^ (PM_BITS)98304);
	label$49:;
}

void lcdMainOnTop( void )
{
	ushort* tmp$27;
	label$50:;
	ushort* vr$83 = CAST_VU16( (ushort*)67109636 );
	tmp$27 = vr$83;
	*tmp$27 = (ushort)(PM_BITS)((PM_BITS)*tmp$27 | (PM_BITS)98304);
	label$51:;
}

void lcdMainOnBottom( void )
{
	ushort* tmp$28;
	label$52:;
	ushort* vr$89 = CAST_VU16( (ushort*)67109636 );
	tmp$28 = vr$89;
	*tmp$28 = (ushort)(PM_BITS)((PM_BITS)*tmp$28 & (PM_BITS)-98305);
	label$53:;
}

void systemShutDown( void )
{
	label$54:;
	powerOn( 64 );
	label$55:;
}

static inline void fifoWaitValue32( integer CHANNEL$1 )
{
	label$56:;
	label$58:;
	integer vr$95 = fifoCheckValue32( CHANNEL$1 );
	if( 0 != vr$95 ) goto label$59;
	{
		swiIntrWait( 1u, 262144u );
	}
	goto label$58;
	label$59:;
	label$57:;
}

static inline integer BGINIT( integer LAYER$1, BGTYPE BTYPE$1, BGSIZE BSIZE$1, integer MAPBASE$1, integer TILEBASE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$60:;
	integer vr$97 = bgInit_call( LAYER$1, BTYPE$1, BSIZE$1, MAPBASE$1, TILEBASE$1 );
	fb$result$1 = vr$97;
	goto label$61;
	label$61:;
	return fb$result$1;
}

static inline integer BGINITSUB( integer LAYER$1, BGTYPE BTYPE$1, BGSIZE BSIZE$1, integer MAPBASE$1, integer TILEBASE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$62:;
	integer vr$100 = bgInitSub_call( LAYER$1, BTYPE$1, BSIZE$1, MAPBASE$1, TILEBASE$1 );
	fb$result$1 = vr$100;
	goto label$63;
	label$63:;
	return fb$result$1;
}

static inline ushort* BGSETCONTROLBITS( integer ID$1, ushort UBITS$1 )
{
	ushort* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$64:;
	*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) = (ushort)(*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) | UBITS$1);
	fb$result$1 = *(ushort**)((ubyte*)bgControl + (ID$1 << 2));
	goto label$65;
	label$65:;
	return fb$result$1;
}

static inline ushort* BGGETGFXPTR( integer ID$1 )
{
	ushort* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$66:;
	if( *(integer*)(((ubyte*)bgState + (ID$1 * 40)) + 32) >= (BGTYPE)4 ) goto label$69;
	{
		ushort* TMP$41$2;
		if( ID$1 >= 4 ) goto label$70;
		TMP$41$2 = (ushort*)(((uinteger)(((integer)*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) >> 2) & 15) << 14) + 100663296);
		goto label$72;
		label$70:;
		TMP$41$2 = (ushort*)(((((integer)*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) >> 2) & 15) << 14) + 102760448);
		label$72:;
		fb$result$1 = TMP$41$2;
		goto label$67;
	}
	goto label$68;
	label$69:;
	{
		ushort* TMP$42$2;
		if( ID$1 >= 4 ) goto label$71;
		TMP$42$2 = (ushort*)((ubyte*)100663296 + ((8192 * (((integer)*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) >> 8) & 31)) << 1));
		goto label$73;
		label$71:;
		TMP$42$2 = (ushort*)((ubyte*)102760448 + ((8192 * (((integer)*(*(ushort**)((ubyte*)bgControl + (ID$1 << 2))) >> 8) & 31)) << 1));
		label$73:;
		fb$result$1 = TMP$42$2;
		goto label$67;
	}
	label$68:;
	label$67:;
	return fb$result$1;
}

static inline long divf32( long NUM$1, long DEN$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$74:;
	ushort* vr$144 = CAST_VU16( (ushort*)67109504 );
	*vr$144 = (ushort)1;
	label$76:;
	ushort* vr$145 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$145 & 32768) == 0 ) goto label$77;
	{
	}
	goto label$76;
	label$77:;
	longint* vr$150 = CAST_VS64( (longint*)67109520 );
	*vr$150 = (longint)NUM$1 << 12;
	long* vr$151 = CAST_VS32( (long*)67109528 );
	*vr$151 = DEN$1;
	label$78:;
	ushort* vr$152 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$152 & 32768) == 0 ) goto label$79;
	{
	}
	goto label$78;
	label$79:;
	long* vr$155 = CAST_VS32( (long*)67109536 );
	fb$result$1 = *vr$155;
	goto label$75;
	label$75:;
	return fb$result$1;
}

static inline long mulf32( long A$1, long B$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$80:;
	fb$result$1 = (long)(((longint)A$1 * (longint)B$1) >> 12);
	goto label$81;
	label$81:;
	return fb$result$1;
}

static inline long sqrtf32( long A$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$82:;
	ushort* vr$165 = CAST_VU16( (ushort*)67109552 );
	*vr$165 = (ushort)1;
	label$84:;
	ushort* vr$166 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$166 & 32768) == 0 ) goto label$85;
	{
	}
	goto label$84;
	label$85:;
	longint* vr$171 = CAST_VS64( (longint*)67109560 );
	*vr$171 = (longint)A$1 << 12;
	label$86:;
	ushort* vr$172 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$172 & 32768) == 0 ) goto label$87;
	{
	}
	goto label$86;
	label$87:;
	ulong* vr$175 = CAST_VU32( (ulong*)67109556 );
	fb$result$1 = *(long*)vr$175;
	goto label$83;
	label$83:;
	return fb$result$1;
}

static inline long div32( long NUM$1, long DEN$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$88:;
	ushort* vr$178 = CAST_VU16( (ushort*)67109504 );
	*vr$178 = (ushort)0;
	label$90:;
	ushort* vr$179 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$179 & 32768) == 0 ) goto label$91;
	{
	}
	goto label$90;
	label$91:;
	long* vr$182 = CAST_VS32( (long*)67109520 );
	*vr$182 = NUM$1;
	long* vr$183 = CAST_VS32( (long*)67109528 );
	*vr$183 = DEN$1;
	label$92:;
	ushort* vr$184 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$184 & 32768) == 0 ) goto label$93;
	{
	}
	goto label$92;
	label$93:;
	long* vr$187 = CAST_VS32( (long*)67109536 );
	fb$result$1 = *vr$187;
	goto label$89;
	label$89:;
	return fb$result$1;
}

static inline long mod32( long NUM$1, long DEN$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$94:;
	ushort* vr$190 = CAST_VU16( (ushort*)67109504 );
	*vr$190 = (ushort)0;
	label$96:;
	ushort* vr$191 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$191 & 32768) == 0 ) goto label$97;
	{
	}
	goto label$96;
	label$97:;
	long* vr$194 = CAST_VS32( (long*)67109520 );
	*vr$194 = NUM$1;
	long* vr$195 = CAST_VS32( (long*)67109528 );
	*vr$195 = DEN$1;
	label$98:;
	ushort* vr$196 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$196 & 32768) == 0 ) goto label$99;
	{
	}
	goto label$98;
	label$99:;
	long* vr$199 = CAST_VS32( (long*)67109544 );
	fb$result$1 = *vr$199;
	goto label$95;
	label$95:;
	return fb$result$1;
}

static inline long div64( longint NUM$1, long DEN$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$100:;
	ushort* vr$202 = CAST_VU16( (ushort*)67109504 );
	*vr$202 = (ushort)1;
	label$102:;
	ushort* vr$203 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$203 & 32768) == 0 ) goto label$103;
	{
	}
	goto label$102;
	label$103:;
	longint* vr$206 = CAST_VS64( (longint*)67109520 );
	*vr$206 = NUM$1;
	long* vr$207 = CAST_VS32( (long*)67109528 );
	*vr$207 = DEN$1;
	label$104:;
	ushort* vr$208 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$208 & 32768) == 0 ) goto label$105;
	{
	}
	goto label$104;
	label$105:;
	long* vr$211 = CAST_VS32( (long*)67109536 );
	fb$result$1 = *vr$211;
	goto label$101;
	label$101:;
	return fb$result$1;
}

static inline long mod64( longint NUM$1, long DEN$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$106:;
	ushort* vr$214 = CAST_VU16( (ushort*)67109504 );
	*vr$214 = (ushort)1;
	label$108:;
	ushort* vr$215 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$215 & 32768) == 0 ) goto label$109;
	{
	}
	goto label$108;
	label$109:;
	longint* vr$218 = CAST_VS64( (longint*)67109520 );
	*vr$218 = NUM$1;
	long* vr$219 = CAST_VS32( (long*)67109528 );
	*vr$219 = DEN$1;
	label$110:;
	ushort* vr$220 = CAST_VU16( (ushort*)67109504 );
	if( ((integer)*vr$220 & 32768) == 0 ) goto label$111;
	{
	}
	goto label$110;
	label$111:;
	long* vr$223 = CAST_VS32( (long*)67109544 );
	fb$result$1 = *vr$223;
	goto label$107;
	label$107:;
	return fb$result$1;
}

static inline ulong sqrt32( integer A$1 )
{
	ulong fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$112:;
	ushort* vr$226 = CAST_VU16( (ushort*)67109552 );
	*vr$226 = (ushort)0;
	label$114:;
	ushort* vr$227 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$227 & 32768) == 0 ) goto label$115;
	{
	}
	goto label$114;
	label$115:;
	long* vr$230 = CAST_VS32( (long*)67109560 );
	*vr$230 = (long)A$1;
	label$116:;
	ushort* vr$231 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$231 & 32768) == 0 ) goto label$117;
	{
	}
	goto label$116;
	label$117:;
	ulong* vr$234 = CAST_VU32( (ulong*)67109556 );
	fb$result$1 = *vr$234;
	goto label$113;
	label$113:;
	return fb$result$1;
}

static inline ulong sqrt64( longint A$1 )
{
	ulong fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$118:;
	ushort* vr$237 = CAST_VU16( (ushort*)67109552 );
	*vr$237 = (ushort)1;
	label$120:;
	ushort* vr$238 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$238 & 32768) == 0 ) goto label$121;
	{
	}
	goto label$120;
	label$121:;
	longint* vr$241 = CAST_VS64( (longint*)67109560 );
	*vr$241 = A$1;
	label$122:;
	ushort* vr$242 = CAST_VU16( (ushort*)67109552 );
	if( ((integer)*vr$242 & 32768) == 0 ) goto label$123;
	{
	}
	goto label$122;
	label$123:;
	ulong* vr$245 = CAST_VU32( (ulong*)67109556 );
	fb$result$1 = *vr$245;
	goto label$119;
	label$119:;
	return fb$result$1;
}

static inline void crossf32( long* A$1, long* B$1, long* RESULT$1 )
{
	label$124:;
	long vr$249 = mulf32( *(long*)((ubyte*)A$1 + 4), *(long*)((ubyte*)B$1 + 8) );              
	long vr$252 = mulf32( *(long*)((ubyte*)B$1 + 4), *(long*)((ubyte*)A$1 + 8) );              
	*RESULT$1 = vr$249 - vr$252;
	long vr$257 = mulf32( *(long*)((ubyte*)A$1 + 8), *B$1 );              
	long vr$260 = mulf32( *(long*)((ubyte*)B$1 + 8), *A$1 );              
	*(long*)((ubyte*)RESULT$1 + 4) = vr$257 - vr$260;
	long vr$265 = mulf32( *A$1, *(long*)((ubyte*)B$1 + 4) );              
	long vr$268 = mulf32( *B$1, *(long*)((ubyte*)A$1 + 4) );              
	*(long*)((ubyte*)RESULT$1 + 8) = vr$265 - vr$268;
	label$125:;
}

static inline integer dotf32( long* A$1, long* B$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$126:;
	long vr$274 = mulf32( *A$1, *B$1 );              
	long vr$277 = mulf32( *(long*)((ubyte*)A$1 + 4), *(long*)((ubyte*)B$1 + 4) );              
	long vr$281 = mulf32( *(long*)((ubyte*)A$1 + 8), *(long*)((ubyte*)B$1 + 8) );              
	fb$result$1 = (integer)((vr$274 + vr$277) + vr$281);
	goto label$127;
	label$127:;
	return fb$result$1;
}

static inline void normalizef32( long* A$1 )
{
	label$128:;
	long MAGNITUDE$1;
	long vr$286 = mulf32( *A$1, *A$1 );              
	long vr$289 = mulf32( *(long*)((ubyte*)A$1 + 4), *(long*)((ubyte*)A$1 + 4) );              
	long vr$293 = mulf32( *(long*)((ubyte*)A$1 + 8), *(long*)((ubyte*)A$1 + 8) );              
	long vr$295 = sqrtf32( (vr$286 + vr$289) + vr$293 );              
	MAGNITUDE$1 = vr$295;
	long vr$297 = divf32( *A$1, MAGNITUDE$1 );              
	*A$1 = vr$297;
	long vr$300 = divf32( *(long*)((ubyte*)A$1 + 4), MAGNITUDE$1 );              
	*(long*)((ubyte*)A$1 + 4) = vr$300;
	long vr$303 = divf32( *(long*)((ubyte*)A$1 + 8), MAGNITUDE$1 );              
	*(long*)((ubyte*)A$1 + 8) = vr$303;
	label$129:;
}

static inline void GLSCALEV( struct GLVECTOR* V$1 )
{
	label$130:;
	long* vr$306 = CAST_VS32( (long*)67109996 );
	*vr$306 = *(long*)V$1;
	long* vr$308 = CAST_VS32( (long*)67109996 );
	*vr$308 = *(long*)((ubyte*)V$1 + 4);
	long* vr$310 = CAST_VS32( (long*)67109996 );
	*vr$310 = *(long*)((ubyte*)V$1 + 8);
	label$131:;
}

static inline void GLTRANSLATEV( struct GLVECTOR* V$1 )
{
	label$132:;
	long* vr$312 = CAST_VS32( (long*)67110000 );
	*vr$312 = *(long*)V$1;
	long* vr$314 = CAST_VS32( (long*)67110000 );
	*vr$314 = *(long*)((ubyte*)V$1 + 4);
	long* vr$316 = CAST_VS32( (long*)67110000 );
	*vr$316 = *(long*)((ubyte*)V$1 + 8);
	label$133:;
}

static inline void GLSCALEF32( integer X$1, integer Y$1, integer Z$1 )
{
	label$134:;
	long* vr$317 = CAST_VS32( (long*)67109996 );
	*vr$317 = (long)X$1;
	long* vr$318 = CAST_VS32( (long*)67109996 );
	*vr$318 = (long)Y$1;
	long* vr$319 = CAST_VS32( (long*)67109996 );
	*vr$319 = (long)Z$1;
	label$135:;
}

static inline void GLLIGHT( integer ID$1, ushort RGBCOLOR$1, short X$1, short Y$1, short Z$1 )
{
	label$136:;
	ID$1 = (ID$1 & 3) << 30;
	ulong* vr$333 = CAST_VU32( (ulong*)67110088 );
	*vr$333 = (ulong)(((ID$1 | (((integer)Z$1 & 1023) << 20)) | (((integer)Y$1 & 1023) << 10)) | ((integer)X$1 & 1023));
	ulong* vr$336 = CAST_VU32( (ulong*)67110092 );
	*vr$336 = (ulong)(ID$1 | (integer)RGBCOLOR$1);
	label$137:;
}

static inline void GLMATERIALSHINYNESS( void )
{
	label$138:;
	ulong SHINY32$1[32];
	__builtin_memset( (ulong*)SHINY32$1, 0, 128 );
	struct TMP$49 {
		ulong* DATA;
		ulong* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$49 tmp$48$1;
	*(ulong**)&tmp$48$1 = (ulong*)SHINY32$1;
	*(ulong**)((ubyte*)&tmp$48$1 + 4) = (ulong*)SHINY32$1;
	*(integer*)((ubyte*)&tmp$48$1 + 8) = 128;
	*(integer*)((ubyte*)&tmp$48$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$48$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$48$1 + 20) = 32;
	*(integer*)((ubyte*)&tmp$48$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$48$1 + 28) = 31;
	ubyte* SHINY8$1;
	SHINY8$1 = (ubyte*)SHINY32$1;
	integer I$1;
	__builtin_memset( &I$1, 0, 4 );
	{
		I$1 = 0;
		label$143:;
		{
			*(ubyte*)(SHINY8$1 + (I$1 >> 1)) = (ubyte)I$1;
		}
		label$141:;
		I$1 = I$1 + 2;
		label$140:;
		if( I$1 <= 255 ) goto label$143;
		label$142:;
	}
	{
		I$1 = 0;
		label$147:;
		{
			ulong* vr$347 = CAST_VU32( (ulong*)67110096 );
			*vr$347 = *(ulong*)((ubyte*)SHINY32$1 + (I$1 << 2));
		}
		label$145:;
		I$1 = I$1 + 1;
		label$144:;
		if( I$1 <= 31 ) goto label$147;
		label$146:;
	}
	label$139:;
}

static inline void GLCALLLIST( ulong* LIST$1 )
{
	label$148:;
	ulong COUNT$1;
	COUNT$1 = *LIST$1;
	LIST$1 = (ulong*)((ubyte*)LIST$1 + 4);
	DC_FlushRange( (void*)LIST$1, COUNT$1 << 2 );
	label$150:;
	ulong* vr$352 = CAST_VU32( (ulong*)67109048 );
	ulong* vr$354 = CAST_VU32( (ulong*)67109060 );
	ulong* vr$357 = CAST_VU32( (ulong*)67109072 );
	ulong* vr$360 = CAST_VU32( (ulong*)67109084 );
	if( ((((*vr$352 & -2147483648u) | (*vr$354 & -2147483648u)) | (*vr$357 & -2147483648u)) | (*vr$360 & -2147483648u)) == 0u ) goto label$151;
	{
	}
	goto label$150;
	label$151:;
	ulong* vr$363 = CAST_VU32( (ulong*)67109040 );
	*vr$363 = (ulong)LIST$1;
	ulong* vr$364 = CAST_VU32( (ulong*)67109044 );
	*vr$364 = 67109888u;
	ulong* vr$366 = CAST_VU32( (ulong*)67109048 );
	*vr$366 = (ulong)(integer)(-1136656384 | COUNT$1);
	label$152:;
	ulong* vr$367 = CAST_VU32( (ulong*)67109048 );
	if( (*vr$367 & -2147483648u) == 0u ) goto label$153;
	{
	}
	goto label$152;
	label$153:;
	label$149:;
}

static inline void GLLOADMATRIX4X4( struct M4X4* M$1 )
{
	label$154:;
	long* vr$370 = CAST_VS32( (long*)67109976 );
	*vr$370 = *(long*)M$1;
	long* vr$372 = CAST_VS32( (long*)67109976 );
	*vr$372 = *(long*)((ubyte*)M$1 + 4);
	long* vr$374 = CAST_VS32( (long*)67109976 );
	*vr$374 = *(long*)((ubyte*)M$1 + 8);
	long* vr$376 = CAST_VS32( (long*)67109976 );
	*vr$376 = *(long*)((ubyte*)M$1 + 12);
	long* vr$378 = CAST_VS32( (long*)67109976 );
	*vr$378 = *(long*)((ubyte*)M$1 + 16);
	long* vr$380 = CAST_VS32( (long*)67109976 );
	*vr$380 = *(long*)((ubyte*)M$1 + 20);
	long* vr$382 = CAST_VS32( (long*)67109976 );
	*vr$382 = *(long*)((ubyte*)M$1 + 24);
	long* vr$384 = CAST_VS32( (long*)67109976 );
	*vr$384 = *(long*)((ubyte*)M$1 + 28);
	long* vr$386 = CAST_VS32( (long*)67109976 );
	*vr$386 = *(long*)((ubyte*)M$1 + 32);
	long* vr$388 = CAST_VS32( (long*)67109976 );
	*vr$388 = *(long*)((ubyte*)M$1 + 36);
	long* vr$390 = CAST_VS32( (long*)67109976 );
	*vr$390 = *(long*)((ubyte*)M$1 + 40);
	long* vr$392 = CAST_VS32( (long*)67109976 );
	*vr$392 = *(long*)((ubyte*)M$1 + 44);
	long* vr$394 = CAST_VS32( (long*)67109976 );
	*vr$394 = *(long*)((ubyte*)M$1 + 48);
	long* vr$396 = CAST_VS32( (long*)67109976 );
	*vr$396 = *(long*)((ubyte*)M$1 + 52);
	long* vr$398 = CAST_VS32( (long*)67109976 );
	*vr$398 = *(long*)((ubyte*)M$1 + 56);
	long* vr$400 = CAST_VS32( (long*)67109976 );
	*vr$400 = *(long*)((ubyte*)M$1 + 60);
	label$155:;
}

static inline void GLLOADMATRIX4X3( struct M4X3* M$1 )
{
	label$156:;
	long* vr$402 = CAST_VS32( (long*)67109980 );
	*vr$402 = *(long*)M$1;
	long* vr$404 = CAST_VS32( (long*)67109980 );
	*vr$404 = *(long*)((ubyte*)M$1 + 4);
	long* vr$406 = CAST_VS32( (long*)67109980 );
	*vr$406 = *(long*)((ubyte*)M$1 + 8);
	long* vr$408 = CAST_VS32( (long*)67109980 );
	*vr$408 = *(long*)((ubyte*)M$1 + 12);
	long* vr$410 = CAST_VS32( (long*)67109980 );
	*vr$410 = *(long*)((ubyte*)M$1 + 16);
	long* vr$412 = CAST_VS32( (long*)67109980 );
	*vr$412 = *(long*)((ubyte*)M$1 + 20);
	long* vr$414 = CAST_VS32( (long*)67109980 );
	*vr$414 = *(long*)((ubyte*)M$1 + 24);
	long* vr$416 = CAST_VS32( (long*)67109980 );
	*vr$416 = *(long*)((ubyte*)M$1 + 28);
	long* vr$418 = CAST_VS32( (long*)67109980 );
	*vr$418 = *(long*)((ubyte*)M$1 + 32);
	long* vr$420 = CAST_VS32( (long*)67109980 );
	*vr$420 = *(long*)((ubyte*)M$1 + 36);
	long* vr$422 = CAST_VS32( (long*)67109980 );
	*vr$422 = *(long*)((ubyte*)M$1 + 40);
	long* vr$424 = CAST_VS32( (long*)67109980 );
	*vr$424 = *(long*)((ubyte*)M$1 + 44);
	label$157:;
}

static inline void GLMULTMATRIX4X4( struct M4X4* M$1 )
{
	label$158:;
	long* vr$426 = CAST_VS32( (long*)67109984 );
	*vr$426 = *(long*)M$1;
	long* vr$428 = CAST_VS32( (long*)67109984 );
	*vr$428 = *(long*)((ubyte*)M$1 + 4);
	long* vr$430 = CAST_VS32( (long*)67109984 );
	*vr$430 = *(long*)((ubyte*)M$1 + 8);
	long* vr$432 = CAST_VS32( (long*)67109984 );
	*vr$432 = *(long*)((ubyte*)M$1 + 12);
	long* vr$434 = CAST_VS32( (long*)67109984 );
	*vr$434 = *(long*)((ubyte*)M$1 + 16);
	long* vr$436 = CAST_VS32( (long*)67109984 );
	*vr$436 = *(long*)((ubyte*)M$1 + 20);
	long* vr$438 = CAST_VS32( (long*)67109984 );
	*vr$438 = *(long*)((ubyte*)M$1 + 24);
	long* vr$440 = CAST_VS32( (long*)67109984 );
	*vr$440 = *(long*)((ubyte*)M$1 + 28);
	long* vr$442 = CAST_VS32( (long*)67109984 );
	*vr$442 = *(long*)((ubyte*)M$1 + 32);
	long* vr$444 = CAST_VS32( (long*)67109984 );
	*vr$444 = *(long*)((ubyte*)M$1 + 36);
	long* vr$446 = CAST_VS32( (long*)67109984 );
	*vr$446 = *(long*)((ubyte*)M$1 + 40);
	long* vr$448 = CAST_VS32( (long*)67109984 );
	*vr$448 = *(long*)((ubyte*)M$1 + 44);
	long* vr$450 = CAST_VS32( (long*)67109984 );
	*vr$450 = *(long*)((ubyte*)M$1 + 48);
	long* vr$452 = CAST_VS32( (long*)67109984 );
	*vr$452 = *(long*)((ubyte*)M$1 + 52);
	long* vr$454 = CAST_VS32( (long*)67109984 );
	*vr$454 = *(long*)((ubyte*)M$1 + 56);
	long* vr$456 = CAST_VS32( (long*)67109984 );
	*vr$456 = *(long*)((ubyte*)M$1 + 60);
	label$159:;
}

static inline void GLMULTMATRIX4X3( struct M4X3* M$1 )
{
	label$160:;
	long* vr$458 = CAST_VS32( (long*)67109988 );
	*vr$458 = *(long*)M$1;
	long* vr$460 = CAST_VS32( (long*)67109988 );
	*vr$460 = *(long*)((ubyte*)M$1 + 4);
	long* vr$462 = CAST_VS32( (long*)67109988 );
	*vr$462 = *(long*)((ubyte*)M$1 + 8);
	long* vr$464 = CAST_VS32( (long*)67109988 );
	*vr$464 = *(long*)((ubyte*)M$1 + 12);
	long* vr$466 = CAST_VS32( (long*)67109988 );
	*vr$466 = *(long*)((ubyte*)M$1 + 16);
	long* vr$468 = CAST_VS32( (long*)67109988 );
	*vr$468 = *(long*)((ubyte*)M$1 + 20);
	long* vr$470 = CAST_VS32( (long*)67109988 );
	*vr$470 = *(long*)((ubyte*)M$1 + 24);
	long* vr$472 = CAST_VS32( (long*)67109988 );
	*vr$472 = *(long*)((ubyte*)M$1 + 28);
	long* vr$474 = CAST_VS32( (long*)67109988 );
	*vr$474 = *(long*)((ubyte*)M$1 + 32);
	long* vr$476 = CAST_VS32( (long*)67109988 );
	*vr$476 = *(long*)((ubyte*)M$1 + 36);
	long* vr$478 = CAST_VS32( (long*)67109988 );
	*vr$478 = *(long*)((ubyte*)M$1 + 40);
	long* vr$480 = CAST_VS32( (long*)67109988 );
	*vr$480 = *(long*)((ubyte*)M$1 + 44);
	label$161:;
}

static inline void GLMULTMATRIX3X3( struct M3X3* M$1 )
{
	label$162:;
	long* vr$482 = CAST_VS32( (long*)67109992 );
	*vr$482 = *(long*)M$1;
	long* vr$484 = CAST_VS32( (long*)67109992 );
	*vr$484 = *(long*)((ubyte*)M$1 + 4);
	long* vr$486 = CAST_VS32( (long*)67109992 );
	*vr$486 = *(long*)((ubyte*)M$1 + 8);
	long* vr$488 = CAST_VS32( (long*)67109992 );
	*vr$488 = *(long*)((ubyte*)M$1 + 12);
	long* vr$490 = CAST_VS32( (long*)67109992 );
	*vr$490 = *(long*)((ubyte*)M$1 + 16);
	long* vr$492 = CAST_VS32( (long*)67109992 );
	*vr$492 = *(long*)((ubyte*)M$1 + 20);
	long* vr$494 = CAST_VS32( (long*)67109992 );
	*vr$494 = *(long*)((ubyte*)M$1 + 24);
	long* vr$496 = CAST_VS32( (long*)67109992 );
	*vr$496 = *(long*)((ubyte*)M$1 + 28);
	long* vr$498 = CAST_VS32( (long*)67109992 );
	*vr$498 = *(long*)((ubyte*)M$1 + 32);
	label$163:;
}

static inline void GLROTATEXI( integer ANGLE$1 )
{
	label$164:;
	integer SINE$1;
	short vr$500 = sinLerp( (short)ANGLE$1 );
	SINE$1 = (integer)vr$500;
	integer COSINE$1;
	short vr$503 = cosLerp( (short)ANGLE$1 );
	COSINE$1 = (integer)vr$503;
	long* vr$505 = CAST_VS32( (long*)67109992 );
	*vr$505 = 4096;
	long* vr$506 = CAST_VS32( (long*)67109992 );
	*vr$506 = 0;
	long* vr$507 = CAST_VS32( (long*)67109992 );
	*vr$507 = 0;
	long* vr$508 = CAST_VS32( (long*)67109992 );
	*vr$508 = 0;
	long* vr$509 = CAST_VS32( (long*)67109992 );
	*vr$509 = (long)COSINE$1;
	long* vr$510 = CAST_VS32( (long*)67109992 );
	*vr$510 = (long)SINE$1;
	long* vr$511 = CAST_VS32( (long*)67109992 );
	*vr$511 = 0;
	long* vr$513 = CAST_VS32( (long*)67109992 );
	*vr$513 = (long)-SINE$1;
	long* vr$514 = CAST_VS32( (long*)67109992 );
	*vr$514 = (long)COSINE$1;
	label$165:;
}

static inline void GLROTATEYI( integer ANGLE$1 )
{
	label$166:;
	integer SINE$1;
	short vr$516 = sinLerp( (short)ANGLE$1 );
	SINE$1 = (integer)vr$516;
	integer COSINE$1;
	short vr$519 = cosLerp( (short)ANGLE$1 );
	COSINE$1 = (integer)vr$519;
	long* vr$521 = CAST_VS32( (long*)67109992 );
	*vr$521 = (long)COSINE$1;
	long* vr$522 = CAST_VS32( (long*)67109992 );
	*vr$522 = 0;
	long* vr$524 = CAST_VS32( (long*)67109992 );
	*vr$524 = (long)-SINE$1;
	long* vr$525 = CAST_VS32( (long*)67109992 );
	*vr$525 = 0;
	long* vr$526 = CAST_VS32( (long*)67109992 );
	*vr$526 = 4096;
	long* vr$527 = CAST_VS32( (long*)67109992 );
	*vr$527 = 0;
	long* vr$528 = CAST_VS32( (long*)67109992 );
	*vr$528 = (long)SINE$1;
	long* vr$529 = CAST_VS32( (long*)67109992 );
	*vr$529 = 0;
	long* vr$530 = CAST_VS32( (long*)67109992 );
	*vr$530 = (long)COSINE$1;
	label$167:;
}

static inline void GLROTATEZI( integer ANGLE$1 )
{
	label$168:;
	integer SINE$1;
	short vr$532 = sinLerp( (short)ANGLE$1 );
	SINE$1 = (integer)vr$532;
	integer COSINE$1;
	short vr$535 = cosLerp( (short)ANGLE$1 );
	COSINE$1 = (integer)vr$535;
	long* vr$537 = CAST_VS32( (long*)67109992 );
	*vr$537 = (long)COSINE$1;
	long* vr$538 = CAST_VS32( (long*)67109992 );
	*vr$538 = (long)SINE$1;
	long* vr$539 = CAST_VS32( (long*)67109992 );
	*vr$539 = 0;
	long* vr$541 = CAST_VS32( (long*)67109992 );
	*vr$541 = (long)-SINE$1;
	long* vr$542 = CAST_VS32( (long*)67109992 );
	*vr$542 = (long)COSINE$1;
	long* vr$543 = CAST_VS32( (long*)67109992 );
	*vr$543 = 0;
	long* vr$544 = CAST_VS32( (long*)67109992 );
	*vr$544 = 0;
	long* vr$545 = CAST_VS32( (long*)67109992 );
	*vr$545 = 0;
	long* vr$546 = CAST_VS32( (long*)67109992 );
	*vr$546 = 4096;
	label$169:;
}

static inline void GLORTHOF32( integer ILEFT$1, integer IRIGHT$1, integer IBOTTOM$1, integer ITOP$1, integer IZNEAR$1, integer IZFAR$1 )
{
	label$170:;
	long vr$548 = divf32( 8192, (long)(IRIGHT$1 - ILEFT$1) );              
	long* vr$549 = CAST_VS32( (long*)67109984 );
	*vr$549 = vr$548;
	long* vr$550 = CAST_VS32( (long*)67109984 );
	*vr$550 = 0;
	long* vr$551 = CAST_VS32( (long*)67109984 );
	*vr$551 = 0;
	long* vr$552 = CAST_VS32( (long*)67109984 );
	*vr$552 = 0;
	long* vr$553 = CAST_VS32( (long*)67109984 );
	*vr$553 = 0;
	long vr$555 = divf32( 8192, (long)(ITOP$1 - IBOTTOM$1) );              
	long* vr$556 = CAST_VS32( (long*)67109984 );
	*vr$556 = vr$555;
	long* vr$557 = CAST_VS32( (long*)67109984 );
	*vr$557 = 0;
	long* vr$558 = CAST_VS32( (long*)67109984 );
	*vr$558 = 0;
	long* vr$559 = CAST_VS32( (long*)67109984 );
	*vr$559 = 0;
	long* vr$560 = CAST_VS32( (long*)67109984 );
	*vr$560 = 0;
	long vr$562 = divf32( -8192, (long)(IZFAR$1 - IZNEAR$1) );              
	long* vr$563 = CAST_VS32( (long*)67109984 );
	*vr$563 = vr$562;
	long* vr$564 = CAST_VS32( (long*)67109984 );
	*vr$564 = 0;
	long vr$567 = divf32( (long)(IRIGHT$1 + ILEFT$1), (long)(IRIGHT$1 - ILEFT$1) );              
	long* vr$569 = CAST_VS32( (long*)67109984 );
	*vr$569 = -vr$567;
	long vr$572 = divf32( (long)(ITOP$1 + IBOTTOM$1), (long)(ITOP$1 - IBOTTOM$1) );              
	long* vr$574 = CAST_VS32( (long*)67109984 );
	*vr$574 = -vr$572;
	long vr$577 = divf32( (long)(IZFAR$1 + IZNEAR$1), (long)(IZFAR$1 - IZNEAR$1) );              
	long* vr$579 = CAST_VS32( (long*)67109984 );
	*vr$579 = -vr$577;
	long* vr$580 = CAST_VS32( (long*)67109984 );
	*vr$580 = 4096;
	label$171:;
}

static inline void GLULOOKATF32( integer EYEX$1, integer EYEY$1, integer EYEZ$1, integer LOOKATX$1, integer LOOKATY$1, integer LOOKATZ$1, integer UPX$1, integer UPY$1, integer UPZ$1 )
{
	label$172:;
	integer SIDE$1[3];
	__builtin_memset( (integer*)SIDE$1, 0, 12 );
	struct TMP$51 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$51 tmp$50$1;
	*(integer**)&tmp$50$1 = (integer*)SIDE$1;
	*(integer**)((ubyte*)&tmp$50$1 + 4) = (integer*)SIDE$1;
	*(integer*)((ubyte*)&tmp$50$1 + 8) = 12;
	*(integer*)((ubyte*)&tmp$50$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$50$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$50$1 + 20) = 3;
	*(integer*)((ubyte*)&tmp$50$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$50$1 + 28) = 2;
	integer FORWARD$1[3];
	__builtin_memset( (integer*)FORWARD$1, 0, 12 );
	struct TMP$53 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$53 tmp$52$1;
	*(integer**)&tmp$52$1 = (integer*)FORWARD$1;
	*(integer**)((ubyte*)&tmp$52$1 + 4) = (integer*)FORWARD$1;
	*(integer*)((ubyte*)&tmp$52$1 + 8) = 12;
	*(integer*)((ubyte*)&tmp$52$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$52$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$52$1 + 20) = 3;
	*(integer*)((ubyte*)&tmp$52$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$52$1 + 28) = 2;
	integer UP$1[3];
	__builtin_memset( (integer*)UP$1, 0, 12 );
	struct TMP$55 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$55 tmp$54$1;
	*(integer**)&tmp$54$1 = (integer*)UP$1;
	*(integer**)((ubyte*)&tmp$54$1 + 4) = (integer*)UP$1;
	*(integer*)((ubyte*)&tmp$54$1 + 8) = 12;
	*(integer*)((ubyte*)&tmp$54$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$54$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$54$1 + 20) = 3;
	*(integer*)((ubyte*)&tmp$54$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$54$1 + 28) = 2;
	integer EYE$1[3];
	__builtin_memset( (integer*)EYE$1, 0, 12 );
	struct TMP$57 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$57 tmp$56$1;
	*(integer**)&tmp$56$1 = (integer*)EYE$1;
	*(integer**)((ubyte*)&tmp$56$1 + 4) = (integer*)EYE$1;
	*(integer*)((ubyte*)&tmp$56$1 + 8) = 12;
	*(integer*)((ubyte*)&tmp$56$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$56$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$56$1 + 20) = 3;
	*(integer*)((ubyte*)&tmp$56$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$56$1 + 28) = 2;
	*(integer*)FORWARD$1 = EYEX$1 - LOOKATX$1;
	*(integer*)((ubyte*)FORWARD$1 + 4) = EYEY$1 - LOOKATY$1;
	*(integer*)((ubyte*)FORWARD$1 + 8) = EYEZ$1 - LOOKATZ$1;
	normalizef32( (long*)FORWARD$1 );              
	*(integer*)UP$1 = UPX$1;
	*(integer*)((ubyte*)UP$1 + 4) = UPY$1;
	*(integer*)((ubyte*)UP$1 + 8) = UPZ$1;
	*(integer*)EYE$1 = EYEX$1;
	*(integer*)((ubyte*)EYE$1 + 4) = EYEY$1;
	*(integer*)((ubyte*)EYE$1 + 8) = EYEZ$1;
	crossf32( (long*)UP$1, (long*)FORWARD$1, (long*)SIDE$1 );              
	normalizef32( (long*)SIDE$1 );              
	crossf32( (long*)FORWARD$1, (long*)SIDE$1, (long*)UP$1 );              
	*(ulong*)67109952 = 2u;
	long* vr$604 = CAST_VS32( (long*)67109988 );
	*vr$604 = *(long*)SIDE$1;
	long* vr$605 = CAST_VS32( (long*)67109988 );
	*vr$605 = *(long*)UP$1;
	long* vr$606 = CAST_VS32( (long*)67109988 );
	*vr$606 = *(long*)FORWARD$1;
	long* vr$607 = CAST_VS32( (long*)67109988 );
	*vr$607 = *(long*)((ubyte*)SIDE$1 + 4);
	long* vr$608 = CAST_VS32( (long*)67109988 );
	*vr$608 = *(long*)((ubyte*)UP$1 + 4);
	long* vr$609 = CAST_VS32( (long*)67109988 );
	*vr$609 = *(long*)((ubyte*)FORWARD$1 + 4);
	long* vr$610 = CAST_VS32( (long*)67109988 );
	*vr$610 = *(long*)((ubyte*)SIDE$1 + 8);
	long* vr$611 = CAST_VS32( (long*)67109988 );
	*vr$611 = *(long*)((ubyte*)UP$1 + 8);
	long* vr$612 = CAST_VS32( (long*)67109988 );
	*vr$612 = *(long*)((ubyte*)FORWARD$1 + 8);
	integer vr$615 = dotf32( (long*)EYE$1, (long*)SIDE$1 );              
	long* vr$617 = CAST_VS32( (long*)67109988 );
	*vr$617 = (long)-vr$615;
	integer vr$620 = dotf32( (long*)EYE$1, (long*)UP$1 );              
	long* vr$622 = CAST_VS32( (long*)67109988 );
	*vr$622 = (long)-vr$620;
	integer vr$625 = dotf32( (long*)EYE$1, (long*)FORWARD$1 );              
	long* vr$627 = CAST_VS32( (long*)67109988 );
	*vr$627 = (long)-vr$625;
	label$173:;
}

static inline void GLFRUSTUMF32( integer ILEFT$1, integer IRIGHT$1, integer IBOTTOM$1, integer ITOP$1, integer INEAR$1, integer IFAR$1 )
{
	label$174:;
	long vr$630 = divf32( (long)(2 * INEAR$1), (long)(IRIGHT$1 - ILEFT$1) );              
	long* vr$631 = CAST_VS32( (long*)67109984 );
	*vr$631 = vr$630;
	long* vr$632 = CAST_VS32( (long*)67109984 );
	*vr$632 = 0;
	long* vr$633 = CAST_VS32( (long*)67109984 );
	*vr$633 = 0;
	long* vr$634 = CAST_VS32( (long*)67109984 );
	*vr$634 = 0;
	long* vr$635 = CAST_VS32( (long*)67109984 );
	*vr$635 = 0;
	long vr$638 = divf32( (long)(2 * INEAR$1), (long)(ITOP$1 - IBOTTOM$1) );              
	long* vr$639 = CAST_VS32( (long*)67109984 );
	*vr$639 = vr$638;
	long* vr$640 = CAST_VS32( (long*)67109984 );
	*vr$640 = 0;
	long* vr$641 = CAST_VS32( (long*)67109984 );
	*vr$641 = 0;
	long vr$644 = divf32( (long)(IRIGHT$1 + ILEFT$1), (long)(IRIGHT$1 - ILEFT$1) );              
	long* vr$645 = CAST_VS32( (long*)67109984 );
	*vr$645 = vr$644;
	long vr$648 = divf32( (long)(ITOP$1 + IBOTTOM$1), (long)(ITOP$1 - IBOTTOM$1) );              
	long* vr$649 = CAST_VS32( (long*)67109984 );
	*vr$649 = vr$648;
	long vr$652 = divf32( (long)(IFAR$1 + INEAR$1), (long)(IFAR$1 - INEAR$1) );              
	long* vr$654 = CAST_VS32( (long*)67109984 );
	*vr$654 = -vr$652;
	long* vr$655 = CAST_VS32( (long*)67109984 );
	*vr$655 = -4096;
	long* vr$656 = CAST_VS32( (long*)67109984 );
	*vr$656 = 0;
	long* vr$657 = CAST_VS32( (long*)67109984 );
	*vr$657 = 0;
	long vr$659 = mulf32( (long)IFAR$1, (long)INEAR$1 );              
	long vr$661 = divf32( (long)(integer)(2 * vr$659), (long)(IFAR$1 - INEAR$1) );              
	long* vr$663 = CAST_VS32( (long*)67109984 );
	*vr$663 = -vr$661;
	long* vr$664 = CAST_VS32( (long*)67109984 );
	*vr$664 = 0;
	label$175:;
}

static inline void GLUPERSPECTIVEF32( integer FOVY$1, integer ASPECT$1, integer ZNEAR$1, integer ZFAR$1 )
{
	label$176:;
	integer XMIN$1;
	__builtin_memset( &XMIN$1, 0, 4 );
	integer XMAX$1;
	__builtin_memset( &XMAX$1, 0, 4 );
	integer YMIN$1;
	__builtin_memset( &YMIN$1, 0, 4 );
	integer YMAX$1;
	__builtin_memset( &YMAX$1, 0, 4 );
	long vr$671 = tanLerp( (short)(FOVY$1 >> 1) );
	long vr$672 = mulf32( (long)ZNEAR$1, vr$671 );              
	YMAX$1 = (integer)vr$672;
	YMIN$1 = -YMAX$1;
	long vr$674 = mulf32( (long)YMIN$1, (long)ASPECT$1 );              
	XMIN$1 = (integer)vr$674;
	long vr$675 = mulf32( (long)YMAX$1, (long)ASPECT$1 );              
	XMAX$1 = (integer)vr$675;
	GLFRUSTUMF32( XMIN$1, XMAX$1, YMIN$1, YMAX$1, ZNEAR$1, ZFAR$1 );              
	label$177:;
}

static inline void GLGETFIXED( GL_GET_ENUM IPARAM$1, integer* F$1 )
{
	label$178:;
	integer I$1;
	__builtin_memset( &I$1, 0, 4 );
	{
		if( IPARAM$1 != (GL_GET_ENUM)2 ) goto label$181;
		label$182:;
		{
			label$183:;
			ulong* vr$677 = CAST_VU32( (ulong*)67110400 );
			if( (*vr$677 & 134217728) == 0u ) goto label$184;
			{
			}
			goto label$183;
			label$184:;
			{
				I$1 = 0;
				label$188:;
				{
					long* vr$679 = CAST_VS32( (long*)67110528 );
					*(integer*)((ubyte*)F$1 + (I$1 << 2)) = *(integer*)((ubyte*)vr$679 + (I$1 << 2));
				}
				label$186:;
				I$1 = I$1 + 1;
				label$185:;
				if( I$1 <= 8 ) goto label$188;
				label$187:;
			}
		}
		goto label$180;
		label$181:;
		if( IPARAM$1 != (GL_GET_ENUM)5 ) goto label$189;
		label$190:;
		{
			label$191:;
			ulong* vr$685 = CAST_VU32( (ulong*)67110400 );
			if( (*vr$685 & 134217728) == 0u ) goto label$192;
			{
			}
			goto label$191;
			label$192:;
			{
				I$1 = 0;
				label$196:;
				{
					long* vr$687 = CAST_VS32( (long*)67110464 );
					*(integer*)((ubyte*)F$1 + (I$1 << 2)) = *(integer*)((ubyte*)vr$687 + (I$1 << 2));
				}
				label$194:;
				I$1 = I$1 + 1;
				label$193:;
				if( I$1 <= 15 ) goto label$196;
				label$195:;
			}
		}
		goto label$180;
		label$189:;
		if( IPARAM$1 != (GL_GET_ENUM)4 ) goto label$197;
		label$198:;
		{
			*(ulong*)67109952 = 1u;
			*(ulong*)67109956 = 0u;
			*(ulong*)67109972 = 0u;
			label$199:;
			ulong* vr$693 = CAST_VU32( (ulong*)67110400 );
			if( (*vr$693 & 134217728) == 0u ) goto label$200;
			{
			}
			goto label$199;
			label$200:;
			{
				I$1 = 0;
				label$204:;
				{
					long* vr$695 = CAST_VS32( (long*)67110464 );
					*(integer*)((ubyte*)F$1 + (I$1 << 2)) = *(integer*)((ubyte*)vr$695 + (I$1 << 2));
				}
				label$202:;
				I$1 = I$1 + 1;
				label$201:;
				if( I$1 <= 15 ) goto label$204;
				label$203:;
			}
			*(ulong*)67109960 = 1u;
		}
		goto label$180;
		label$197:;
		if( IPARAM$1 != (GL_GET_ENUM)3 ) goto label$205;
		label$206:;
		{
			*(ulong*)67109952 = 0u;
			*(ulong*)67109956 = 0u;
			*(ulong*)67109972 = 0u;
			label$207:;
			ulong* vr$701 = CAST_VU32( (ulong*)67110400 );
			if( (*vr$701 & 134217728) == 0u ) goto label$208;
			{
			}
			goto label$207;
			label$208:;
			{
				I$1 = 0;
				label$212:;
				{
					long* vr$703 = CAST_VS32( (long*)67110464 );
					*(integer*)((ubyte*)F$1 + (I$1 << 2)) = *(integer*)((ubyte*)vr$703 + (I$1 << 2));
				}
				label$210:;
				I$1 = I$1 + 1;
				label$209:;
				if( I$1 <= 15 ) goto label$212;
				label$211:;
			}
			*(ulong*)67109960 = 1u;
		}
		label$205:;
		label$180:;
	}
	label$179:;
}

static inline void GLULOOKAT( single EYEX$1, single EYEY$1, single EYEZ$1, single LOOKATX$1, single LOOKATY$1, single LOOKATZ$1, single UPX$1, single UPY$1, single UPZ$1 )
{
	label$213:;
	integer vr$710 = fb_ftosi( UPZ$1 * 4096.0f );
	integer vr$712 = fb_ftosi( UPY$1 * 4096.0f );
	integer vr$714 = fb_ftosi( UPX$1 * 4096.0f );
	integer vr$716 = fb_ftosi( LOOKATZ$1 * 4096.0f );
	integer vr$718 = fb_ftosi( LOOKATY$1 * 4096.0f );
	integer vr$720 = fb_ftosi( LOOKATX$1 * 4096.0f );
	integer vr$722 = fb_ftosi( EYEZ$1 * 4096.0f );
	integer vr$724 = fb_ftosi( EYEY$1 * 4096.0f );
	integer vr$726 = fb_ftosi( EYEX$1 * 4096.0f );
	GLULOOKATF32( vr$726, vr$724, vr$722, vr$720, vr$718, vr$716, vr$714, vr$712, vr$710 );              
	label$214:;
}

static inline void GLFRUSTUM( single FLEFT$1, single FRIGHT$1, single FBOTTOM$1, single FTOP$1, single FNEAR$1, single FFAR$1 )
{
	label$215:;
	integer vr$728 = fb_ftosi( FFAR$1 * 4096.0f );
	integer vr$730 = fb_ftosi( FNEAR$1 * 4096.0f );
	integer vr$732 = fb_ftosi( FTOP$1 * 4096.0f );
	integer vr$734 = fb_ftosi( FBOTTOM$1 * 4096.0f );
	integer vr$736 = fb_ftosi( FRIGHT$1 * 4096.0f );
	integer vr$738 = fb_ftosi( FLEFT$1 * 4096.0f );
	GLFRUSTUMF32( vr$738, vr$736, vr$734, vr$732, vr$730, vr$728 );              
	label$216:;
}

static inline void GLTEXCOORD2F( single S$1, single T$1 )
{
	label$217:;
	struct GL_TEXTURE_DATA* TEX$1;
	void* vr$742 = DynamicArrayGet( (struct DYNAMICARRAY*)((ubyte*)GLGLOB$ + 20), *(uinteger*)((ubyte*)GLGLOB$ + 60) );
	TEX$1 = (struct GL_TEXTURE_DATA*)vr$742;
	if( TEX$1 == (struct GL_TEXTURE_DATA*)0 ) goto label$220;
	{
		integer X$2;
		X$2 = (integer)((*(ulong*)((ubyte*)TEX$1 + 16) >> 20) & 7);
		integer Y$2;
		Y$2 = (integer)((*(ulong*)((ubyte*)TEX$1 + 16) >> 23) & 7);
		short vr$753 = fb_ftoss( (S$1 * (single)(8 << X$2)) * 16.0f );
		short vr$760 = fb_ftoss( (T$1 * (single)(8 << Y$2)) * 16.0f );
		ulong* vr$764 = CAST_VU32( (ulong*)67110024 );
		*vr$764 = (ulong)(((integer)vr$753 & 65535) | ((integer)vr$760 << 16));
	}
	label$220:;
	label$219:;
	label$218:;
}

void TIMERINTERRUPT( void )
{
	label$244:;
	FB_TICKS$ = FB_TICKS$ + 1;
	label$245:;
}

void VBLANKINTERRUPT( void )
{
	ulong* TMP$77$1;
	integer TMP$78$1;
	integer TMP$80$1;
	label$246:;
	ulong OLDINTS$1;
	ulong* vr$766 = CAST_VU32( (ulong*)67109384 );
	OLDINTS$1 = *vr$766;
	ulong* vr$767 = CAST_VU32( (ulong*)67109384 );
	TMP$77$1 = vr$767;
	*TMP$77$1 = *TMP$77$1 | 1;
	if( -(*(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) == 1) == 0 ) goto label$248;
	TMP$78$1 = -(((*(integer*)&_ZN3GFX3FG$E >> 1) & 1) != 0);
	goto label$310;
	label$248:;
	TMP$78$1 = 0;
	label$310:;
	if( TMP$78$1 == 0 ) goto label$250;
	{
		integer TMP$79$2;
		if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$252;
		{
		}
		goto label$251;
		label$252:;
		if( ((*(integer*)&_ZN3GFX3FG$E >> 8) & 1) == 0 ) goto label$254;
		TMP$79$2 = -(_ZN3GFX11PALETTEPTR$E != 0);
		goto label$311;
		label$254:;
		TMP$79$2 = 0;
		label$311:;
		if( TMP$79$2 == 0 ) goto label$253;
		{
			DC_FlushRange( (void*)_ZN3GFX11PALETTEPTR$E, 512u );
			ulong* vr$780 = CAST_VU32( (ulong*)67109076 );
			*vr$780 = (ulong)_ZN3GFX11PALETTEPTR$E;
			ushort* vr$781 = CAST_VU16( (ushort*)83887104 );
			ulong* vr$782 = CAST_VU32( (ulong*)67109080 );
			*vr$782 = (ulong)vr$781;
			ulong* vr$783 = CAST_VU32( (ulong*)67109084 );
			*vr$783 = 2147483904u;
			label$255:;
			{
			}
			label$257:;
			ulong* vr$784 = CAST_VU32( (ulong*)67109084 );
			if( (*vr$784 & -2147483648u) != 0u ) goto label$255;
			label$256:;
			ushort* vr$787 = CAST_VU16( (ushort*)83887104 );
			*vr$787 = *_ZN3GFX11PALETTEPTR$E;
		}
		label$253:;
		label$251:;
	}
	label$250:;
	label$249:;
	static byte ISWAP$1;
	ISWAP$1 = (byte)((integer)ISWAP$1 ^ 1);
	if( _ZN3GFX8VRAMPTR$E == 0 ) goto label$258;
	TMP$80$1 = -(_ZN3GFX7SCRPTR$E != 0);
	goto label$312;
	label$258:;
	TMP$80$1 = 0;
	label$312:;
	if( TMP$80$1 == 0 ) goto label$260;
	{
		if( _ZN3GFX7LOCKED$E == (short)0 ) goto label$262;
		{
			if( ((*(integer*)&_ZN3GFX3FG$E >> 4) & 3) != 0 ) goto label$264;
			*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -49) | 16u);
			label$264:;
			*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -2) | 1u);
		}
		label$262:;
		label$261:;
		if( (-((integer)_ZN3GFX7LOCKED$E == 0) | -(((*(integer*)&_ZN3GFX3FG$E >> 4) & 3) == 2)) == 0 ) goto label$266;
		_FB_INT_UPDATESCREEN(  );
		label$266:;
	}
	label$260:;
	label$259:;
	if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$268;
	{
		if( ((*(integer*)&_ZN3GFX3FG$E >> 3) & 1) == 0 ) goto label$270;
		{
			label$271:;
			ulong* vr$807 = CAST_VU32( (ulong*)67110400 );
			if( (*vr$807 & 16777216) == 0u ) goto label$272;
			{
			}
			goto label$271;
			label$272:;
			ulong* vr$809 = CAST_VU32( (ulong*)67110404 );
			_ZN3GFX12VERTEXCOUNT$E = (uinteger)(*vr$809 >> 16);
			ulong* vr$811 = CAST_VU32( (ulong*)67110208 );
			*vr$811 = 1u;
			_ZN3GFX6DEPTH$E = -4095;
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -5;
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -9;
		}
		label$270:;
		label$269:;
	}
	label$268:;
	label$267:;
	if( (integer)_ZN2FB13KEYBOARDISON$E == 0 ) goto label$274;
	{
		keyboardUpdate(  );
	}
	label$274:;
	label$273:;
	ulong vr$815 = keysCurrent(  );
	_ZN2FB10DSBUTTONS$E = (short)vr$815;
	integer PRESSNUM$1;
	PRESSNUM$1 = 0;
	{
		integer CNT$2;
		CNT$2 = 12;
		label$278:;
		{
			if( ((integer)_ZN2FB10DSBUTTONS$E & (1 << CNT$2)) == 0 ) goto label$280;
			PRESSNUM$1 = -128 + CNT$2;
			label$280:;
		}
		label$276:;
		CNT$2 = CNT$2 + -1;
		label$275:;
		if( CNT$2 >= 0 ) goto label$278;
		label$277:;
	}
	{
		integer CNT$2;
		CNT$2 = -128;
		label$284:;
		{
			if( PRESSNUM$1 == CNT$2 ) goto label$286;
			{
				*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) = (short)0;
			}
			goto label$285;
			label$286:;
			{
				if( (integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) != 0 ) goto label$288;
				{
					*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) = (short)128;
				}
				label$288:;
				label$287:;
			}
			label$285:;
		}
		label$282:;
		CNT$2 = CNT$2 + 1;
		label$281:;
		if( CNT$2 <= -116 ) goto label$284;
		label$283:;
	}
	{
		integer CNT$2;
		CNT$2 = -128;
		label$292:;
		{
			if( *(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) == (short)0 ) goto label$294;
			{
				if( ((integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) & 128) == 0 ) goto label$296;
				{
					if( (((integer)_ZN2FB11INKEYWRITE$E + 1) & 255) == (integer)_ZN2FB10INKEYREAD$E ) goto label$298;
					{
						*(short*)((ubyte*)_ZN2FB10INKEYBUFF$E + ((integer)_ZN2FB11INKEYWRITE$E << 1)) = (short)CNT$2;
						_ZN2FB11INKEYWRITE$E = (short)(((integer)_ZN2FB11INKEYWRITE$E + 1) & 255);
					}
					label$298:;
					label$297:;
				}
				label$296:;
				label$295:;
				if( (integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) != 128 ) goto label$300;
				{
					*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) = (short)1;
				}
				goto label$299;
				label$300:;
				if( (integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) < 40 ) goto label$301;
				{
					*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) = (short)((integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) ^ 128);
				}
				goto label$299;
				label$301:;
				{
					*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) = (short)((integer)*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (CNT$2 << 1)) + 256) + 1);
				}
				label$299:;
			}
			label$294:;
			label$293:;
		}
		label$290:;
		CNT$2 = CNT$2 + 1;
		label$289:;
		if( CNT$2 <= 127 ) goto label$292;
		label$291:;
	}
	if( (KEYPAD_BITS)((KEYPAD_BITS)_ZN2FB10DSBUTTONS$E & (KEYPAD_BITS)4096) == (KEYPAD_BITS)0 ) goto label$303;
	{
		struct TOUCHPOSITION TEMPTOUCH$2;
		touchRead( &TEMPTOUCH$2 );
		if( ((*(integer*)&_ZN3GFX3FG$E >> 8) & 1) == 0 ) goto label$305;
		{
			_ZN2FB7MOUSEX$E = *(short*)((ubyte*)&TEMPTOUCH$2 + 4);
			_ZN2FB7MOUSEY$E = (short)((uinteger)*(ushort*)((ubyte*)&TEMPTOUCH$2 + 6) + (*(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12) >> 1));
		}
		goto label$304;
		label$305:;
		if( ((*(integer*)&_ZN3GFX3FG$E >> 7) & 1) == 0 ) goto label$306;
		{
			_ZN2FB7MOUSEX$E = *(short*)((ubyte*)&TEMPTOUCH$2 + 6);
			_ZN2FB7MOUSEY$E = (short)((*(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12) + -1) - (uinteger)*(ushort*)((ubyte*)&TEMPTOUCH$2 + 4));
		}
		goto label$304;
		label$306:;
		{
			integer TMP$81$3;
			if( -((integer)_ZN2FB13KEYBOARDISON$E == 0) != 0 ) goto label$307;
			TMP$81$3 = -(-((integer)*(ushort*)((ubyte*)&TEMPTOUCH$2 + 6) < (192 - (integer)_ZN2FB15KEYBOARDOFFSET$E)) != 0);
			goto label$313;
			label$307:;
			TMP$81$3 = -1;
			label$313:;
			if( TMP$81$3 == 0 ) goto label$309;
			{
				_ZN2FB7MOUSEX$E = (short)(((uinteger)*(ushort*)((ubyte*)&TEMPTOUCH$2 + 4) * *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 8)) >> 8);
				_ZN2FB7MOUSEY$E = (short)(((uinteger)*(ushort*)((ubyte*)&TEMPTOUCH$2 + 6) * *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12)) / 192);
			}
			label$309:;
			label$308:;
		}
		label$304:;
	}
	label$303:;
	label$302:;
	ulong* vr$892 = CAST_VU32( (ulong*)67109384 );
	*vr$892 = OLDINTS$1;
	_ZN2FB14VSYNCHAPPENED$E = (short)1;
	label$247:;
}

static        void fb_GfxFlip( integer IUNK0$1, integer IUNK1$1 )
{
	label$668:;
	goto label$669;
	label$669:;
}

static        integer fb_GfxWaitVSync( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$670:;
	integer HAPPENED$1;
	_ZN2FB14VSYNCHAPPENED$E = (short)0;
	swiWaitForVBlank(  );
	fb$result$1 = 0;
	goto label$671;
	label$671:;
	return fb$result$1;
}

static        double fb_Timer( void )
{
	double fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$672:;
	static double DTIME$1;
	double DNEWTIME$1;
	ulong* vr$896 = CAST_VU32( &FB_TICKS$ );
	ushort* vr$899 = CAST_VU16( (ushort*)67109120 );
	DNEWTIME$1 = ((double)*vr$896 / 7.990355968475342) + ((double)*vr$899 / 523655.96875);
	if( DNEWTIME$1 >= DTIME$1 ) goto label$675;
	DNEWTIME$1 = DTIME$1;
	goto label$674;
	label$675:;
	DTIME$1 = DNEWTIME$1;
	label$674:;
	fb$result$1 = DNEWTIME$1;
	goto label$673;
	label$673:;
	return fb$result$1;
}

static        integer fb_SleepEx( integer AMOUNT$1, integer MUSTWAIT$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$676:;
	static uinteger TEMPKEYS$1;
	if( AMOUNT$1 >= 0 ) goto label$679;
	{
		scanKeys(  );
		ulong vr$905 = keysCurrent(  );
		TEMPKEYS$1 = (uinteger)vr$905;
		label$680:;
		{
			scanKeys(  );
			uinteger CHECKKEYS$3;
			ulong vr$906 = keysDownRepeat(  );
			CHECKKEYS$3 = (uinteger)vr$906;
			if( CHECKKEYS$3 >= TEMPKEYS$1 ) goto label$684;
			TEMPKEYS$1 = CHECKKEYS$3;
			label$684:;
			if( CHECKKEYS$3 <= TEMPKEYS$1 ) goto label$686;
			fb$result$1 = 0;
			goto label$677;
			label$686:;
			fb_GfxWaitVSync(  );              
		}
		label$682:;
		goto label$680;
		label$681:;
	}
	goto label$678;
	label$679:;
	if( AMOUNT$1 != 0 ) goto label$687;
	{
		IRQ_MASKS HBLANKENABLED$2;
		ulong* vr$907 = CAST_VU32( (ulong*)67109392 );
		HBLANKENABLED$2 = (IRQ_MASKS)(*vr$907 & (IRQ_MASKS)2);
		if( HBLANKENABLED$2 != 0 ) goto label$689;
		irqEnable( 2u );
		label$689:;
		swiIntrWait( 1u, 4294967295u );
		if( HBLANKENABLED$2 != 0 ) goto label$691;
		irqDisable( 2u );
		label$691:;
	}
	goto label$678;
	label$687:;
	{
		double DAFTER$2;
		double vr$909 = fb_Timer(  );
		DAFTER$2 = vr$909 + ((double)AMOUNT$1 / 1000.0);
		if( MUSTWAIT$1 != 0 ) goto label$693;
		scanKeys(  );
		ulong vr$913 = keysHeld(  );
		TEMPKEYS$1 = (uinteger)vr$913;
		label$693:;
		label$694:;
		double vr$914 = fb_Timer(  );
		if( (DAFTER$2 - vr$914) <= 0.01666666666666667 ) goto label$695;
		{
			fb_GfxWaitVSync(  );              
			if( MUSTWAIT$1 != 0 ) goto label$697;
			{
				scanKeys(  );
				uinteger CHECKKEYS$4;
				ulong vr$916 = keysDownRepeat(  );
				CHECKKEYS$4 = (uinteger)vr$916;
				if( CHECKKEYS$4 >= TEMPKEYS$1 ) goto label$699;
				TEMPKEYS$1 = CHECKKEYS$4;
				label$699:;
				if( CHECKKEYS$4 <= TEMPKEYS$1 ) goto label$701;
				fb$result$1 = 0;
				goto label$677;
				label$701:;
			}
			label$697:;
			label$696:;
		}
		goto label$694;
		label$695:;
		IRQ_MASKS HBLANKENABLED$2;
		ulong* vr$917 = CAST_VU32( (ulong*)67109392 );
		HBLANKENABLED$2 = (IRQ_MASKS)(*vr$917 & (IRQ_MASKS)2);
		if( HBLANKENABLED$2 != 0 ) goto label$703;
		irqEnable( 2u );
		label$703:;
		label$704:;
		double vr$919 = fb_Timer(  );
		if( DAFTER$2 <= vr$919 ) goto label$705;
		{
			swiIntrWait( 1u, 4294967295u );
		}
		goto label$704;
		label$705:;
		if( HBLANKENABLED$2 != 0 ) goto label$707;
		irqDisable( 2u );
		label$707:;
		fb$result$1 = 1;
		goto label$677;
	}
	label$678:;
	label$677:;
	return fb$result$1;
}

static inline void fb_Sleep( integer AMOUNT$1 )
{
	label$708:;
	fb_SleepEx( AMOUNT$1, 0 );              
	label$709:;
}

static inline void fb_Beep( void )
{
	label$710:;
	integer BEEPCHAN$1;
	integer vr$921 = soundPlayPSG( (DUTYCYCLE)3, (ushort)3520, (ubyte)127, (ubyte)64 );
	BEEPCHAN$1 = vr$921;
	fb_SleepEx( 250, 1 );
	soundKill( BEEPCHAN$1 );
	label$711:;
}

static        void fb_ConsoleView( integer ISTART$1, integer ISTOP$1 )
{
	label$712:;
	if( ISTART$1 >= 1 ) goto label$715;
	goto label$713;
	label$715:;
	if( ISTOP$1 >= ISTART$1 ) goto label$717;
	goto label$713;
	label$717:;
	if( ISTOP$1 <= 24 ) goto label$719;
	goto label$713;
	label$719:;
	consoleSetWindow( FBCONSOLE$, 0, ISTART$1 + -1, 32, (ISTOP$1 - ISTART$1) + 1 );
	label$713:;
}

static inline long fb_Width( integer IWID$1, integer IHEI$1 )
{
	integer TMP$344$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$720:;
	if( -(IWID$1 == 1) == 0 ) goto label$722;
	TMP$344$1 = -(-(IHEI$1 == 1) != 0);
	goto label$725;
	label$722:;
	TMP$344$1 = 0;
	label$725:;
	if( TMP$344$1 == 0 ) goto label$724;
	fb$result$1 = 8216;
	goto label$721;
	label$724:;
	IWID$1 = IHEI$1;
	fb$result$1 = 8216;
	goto label$721;
	label$721:;
	return fb$result$1;
}

static        void fb_PrintVoid( integer FNUM$1, integer MASK$1 )
{
	label$726:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$729;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$729:;
	if( MASK$1 != 1 ) goto label$731;
	{
		fputc( 10, F$1 );
	}
	goto label$730;
	label$731:;
	if( MASK$1 != 2 ) goto label$732;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$732:;
	label$730:;
	label$727:;
}

static        void fb_PrintString( integer FNUM$1, void* FBS$1, integer MASK$1 )
{
	label$733:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$736;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$736:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$347$2;
		TMP$347$2 = *(integer*)((ubyte*)FBS$1 + 4) + -1;
		goto label$737;
		label$740:;
		{
			integer ICHAR$3;
			ICHAR$3 = (integer)*(ubyte*)(*(ubyte**)FBS$1 + CNT$2);
			if( ICHAR$3 != 0 ) goto label$742;
			ICHAR$3 = 32;
			label$742:;
			fputc( ICHAR$3, F$1 );
		}
		label$738:;
		CNT$2 = CNT$2 + 1;
		label$737:;
		if( CNT$2 <= TMP$347$2 ) goto label$740;
		label$739:;
	}
	if( MASK$1 != 1 ) goto label$744;
	{
		fputc( 10, F$1 );
	}
	goto label$743;
	label$744:;
	if( MASK$1 != 2 ) goto label$745;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$745:;
	label$743:;
	if( FBS$1 == (void*)0 ) goto label$747;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$748;
			label$751:;
			{
				if( FBS$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$753;
				{
					struct FBSTRING* TMP$349$5;
					void* PTEMP$5;
					PTEMP$5 = FBS$1;
					{
						void* TMP$348$6;
						TMP$348$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$348$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$349$5 = (struct FBSTRING*)FBS$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$349$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$349$5 == (char*)0 ) goto label$755;
					free( *(void**)TMP$349$5 );
					*(char**)TMP$349$5 = (char*)0;
					*(integer*)((ubyte*)TMP$349$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$349$5 + 8) = 0;
					label$755:;
					if( ISTEMP$5 == 0 ) goto label$757;
					{
						free( FBS$1 );
						FBS$1 = (void*)0;
					}
					label$757:;
					label$756:;
				}
				label$753:;
				label$752:;
			}
			label$749:;
			N$3 = N$3 + -1;
			label$748:;
			if( N$3 >= 0 ) goto label$751;
			label$750:;
		}
	}
	label$747:;
	label$746:;
	label$734:;
}

static inline void fb_PrintByte( integer FNUM$1, byte NUMBER$1, integer MASK$1 )
{
	label$758:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	uinteger TEMP$1;
	TEMP$1 = (uinteger)NUMBER$1;
	if( TEMP$1 < 128 ) goto label$761;
	TEMP$1 = TEMP$1 + -256;
	label$761:;
	if( FNUM$1 != 0 ) goto label$763;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$763:;
	printf( (char*)"% i", TEMP$1 );
	if( MASK$1 != 1 ) goto label$765;
	{
		fputc( 10, F$1 );
	}
	goto label$764;
	label$765:;
	if( MASK$1 != 2 ) goto label$766;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$766:;
	label$764:;
	label$759:;
}

static inline void fb_PrintUByte( integer FNUM$1, ubyte NUMBER$1, integer MASK$1 )
{
	label$767:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$770;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$770:;
	printf( (char*)"%u", (uinteger)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$772;
	{
		fputc( 10, F$1 );
	}
	goto label$771;
	label$772:;
	if( MASK$1 != 2 ) goto label$773;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$773:;
	label$771:;
	label$768:;
}

static inline void fb_PrintShort( integer FNUM$1, short NUMBER$1, integer MASK$1 )
{
	label$774:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$777;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$777:;
	printf( (char*)"% i", (integer)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$779;
	{
		fputc( 10, F$1 );
	}
	goto label$778;
	label$779:;
	if( MASK$1 != 2 ) goto label$780;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$780:;
	label$778:;
	label$775:;
}

static inline void fb_PrintUShort( integer FNUM$1, ushort NUMBER$1, integer MASK$1 )
{
	label$781:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$784;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$784:;
	printf( (char*)"%u", (uinteger)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$786;
	{
		fputc( 10, F$1 );
	}
	goto label$785;
	label$786:;
	if( MASK$1 != 2 ) goto label$787;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$787:;
	label$785:;
	label$782:;
}

static        void fb_PrintInt( integer FNUM$1, integer NUMBER$1, integer MASK$1 )
{
	label$788:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$791;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$791:;
	printf( (char*)"% i", NUMBER$1 );
	if( MASK$1 != 1 ) goto label$793;
	{
		fputc( 10, F$1 );
	}
	goto label$792;
	label$793:;
	if( MASK$1 != 2 ) goto label$794;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$794:;
	label$792:;
	label$789:;
}

static        void fb_PrintUInt( integer FNUM$1, uinteger NUMBER$1, integer MASK$1 )
{
	label$795:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$798;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$798:;
	printf( (char*)"%u", NUMBER$1 );
	if( MASK$1 != 1 ) goto label$800;
	{
		fputc( 10, F$1 );
	}
	goto label$799;
	label$800:;
	if( MASK$1 != 2 ) goto label$801;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$801:;
	label$799:;
	label$796:;
}

static inline void fb_PrintLongint( integer FNUM$1, longint NUMBER$1, integer MASK$1 )
{
	label$802:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$805;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$805:;
	printf( (char*)"% 1.0f", (double)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$807;
	{
		fputc( 10, F$1 );
	}
	goto label$806;
	label$807:;
	if( MASK$1 != 2 ) goto label$808;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$808:;
	label$806:;
	label$803:;
}

static inline void fb_PrintULongint( integer FNUM$1, ulongint NUMBER$1, integer MASK$1 )
{
	label$809:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$812;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$812:;
	printf( (char*)"%1.0f", (double)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$814;
	{
		fputc( 10, F$1 );
	}
	goto label$813;
	label$814:;
	if( MASK$1 != 2 ) goto label$815;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$815:;
	label$813:;
	label$810:;
}

static        void fb_PrintDouble( integer FNUM$1, double NUMBER$1, integer MASK$1 )
{
	label$816:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$819;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$819:;
	printf( (char*)"% .15g", NUMBER$1 );
	if( MASK$1 != 1 ) goto label$821;
	{
		fputc( 10, F$1 );
	}
	goto label$820;
	label$821:;
	if( MASK$1 != 2 ) goto label$822;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$822:;
	label$820:;
	label$817:;
}

static inline void fb_PrintSingle( integer FNUM$1, single NUMBER$1, integer MASK$1 )
{
	label$823:;
	struct _IO_FILE* F$1;
	__builtin_memset( &F$1, 0, 4 );
	if( FNUM$1 != 0 ) goto label$826;
	F$1 = *(struct _IO_FILE**)((ubyte*)_impure_ptr + 8);
	label$826:;
	printf( (char*)"% .7g", (double)NUMBER$1 );
	if( MASK$1 != 1 ) goto label$828;
	{
		fputc( 10, F$1 );
	}
	goto label$827;
	label$828:;
	if( MASK$1 != 2 ) goto label$829;
	{
		integer AMOUNT$2;
		AMOUNT$2 = (((*(integer*)((ubyte*)FBCONSOLE$ + 36) + 1) | 7) + 1) - *(integer*)((ubyte*)FBCONSOLE$ + 36);
		fputs( (char*)((ubyte*)((ubyte*)"                 " + 17) - AMOUNT$2), F$1 );
	}
	label$829:;
	label$827:;
	label$824:;
}

static        void* fb_StrAllocTempDescZEx( char* S$1, integer S_LEN$1 )
{
	struct FBSTRING* TMP$358$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$830:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$833;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$835;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$836;
				label$839:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$841;
					{
						struct FBSTRING* TMP$357$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$356$7;
							TMP$356$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$356$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$357$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$357$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$357$6 == (char*)0 ) goto label$843;
						free( *(void**)TMP$357$6 );
						*(char**)TMP$357$6 = (char*)0;
						*(integer*)((ubyte*)TMP$357$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$357$6 + 8) = 0;
						label$843:;
						if( ISTEMP$6 == 0 ) goto label$845;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$845:;
						label$844:;
					}
					label$841:;
					label$840:;
				}
				label$837:;
				N$4 = N$4 + -1;
				label$836:;
				if( N$4 >= 0 ) goto label$839;
				label$838:;
			}
		}
		label$835:;
		label$834:;
	}
	label$833:;
	label$832:;
	void* vr$1089 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1089;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$358$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$358$1 = (char*)0;
	*(integer*)((ubyte*)TMP$358$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$358$1 + 8) = -2147483648u;
	void* vr$1097 = realloc( *(void**)_ZN2FB11TEMPSTRING$E, (uinteger)(S_LEN$1 + 1) );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1097;
	memcpy( *(void**)_ZN2FB11TEMPSTRING$E, (void*)S$1, (uinteger)S_LEN$1 );
	*(char*)((ubyte*)*(char**)_ZN2FB11TEMPSTRING$E + S_LEN$1) = (char)0;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = S_LEN$1;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | (S_LEN$1 + 1);
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$831;
	label$831:;
	return fb$result$1;
}

static inline void* fb_StrAllocTempDescZ( char* S$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$846:;
	uinteger vr$1109 = strlen( S$1 );
	void* vr$1110 = fb_StrAllocTempDescZEx( S$1, (integer)vr$1109 );              
	fb$result$1 = vr$1110;
	goto label$847;
	label$847:;
	return fb$result$1;
}

static inline void* fb_StrAllocTempResult( void* PFROMSTRING$1 )
{
	struct FBSTRING* TMP$361$1;
	integer TMP$362$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$848:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$851;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$853;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$854;
				label$857:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$859;
					{
						struct FBSTRING* TMP$360$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$359$7;
							TMP$359$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$359$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$360$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$360$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$360$6 == (char*)0 ) goto label$861;
						free( *(void**)TMP$360$6 );
						*(char**)TMP$360$6 = (char*)0;
						*(integer*)((ubyte*)TMP$360$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$360$6 + 8) = 0;
						label$861:;
						if( ISTEMP$6 == 0 ) goto label$863;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$863:;
						label$862:;
					}
					label$859:;
					label$858:;
				}
				label$855:;
				N$4 = N$4 + -1;
				label$854:;
				if( N$4 >= 0 ) goto label$857;
				label$856:;
			}
		}
		label$853:;
		label$852:;
	}
	label$851:;
	label$850:;
	void* vr$1131 = malloc( 16u );
	_ZN2FB13RETURNSTRING$E = (struct FBSTRING*)vr$1131;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB13RETURNSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$361$1 = _ZN2FB13RETURNSTRING$E;
	*(char**)TMP$361$1 = (char*)0;
	*(integer*)((ubyte*)TMP$361$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$361$1 + 8) = -2147483648u;
	if( PFROMSTRING$1 == 0 ) goto label$864;
	TMP$362$1 = -(*(char**)PFROMSTRING$1 != 0);
	goto label$867;
	label$864:;
	TMP$362$1 = 0;
	label$867:;
	if( TMP$362$1 == 0 ) goto label$866;
	{
		struct FBSTRING* TMP$363$2;
		TMP$363$2 = _ZN2FB13RETURNSTRING$E;
		void* vr$1140 = malloc( *(uinteger*)((ubyte*)PFROMSTRING$1 + 8) );
		*(char**)TMP$363$2 = (char*)vr$1140;
		*(integer*)((ubyte*)TMP$363$2 + 4) = *(integer*)((ubyte*)PFROMSTRING$1 + 4);
		*(integer*)((ubyte*)TMP$363$2 + 8) = *(integer*)((ubyte*)TMP$363$2 + 8) | (*(integer*)((ubyte*)PFROMSTRING$1 + 8) & 2147483647);
		memcpy( *(void**)TMP$363$2, *(void**)PFROMSTRING$1, (uinteger)(*(integer*)((ubyte*)TMP$363$2 + 8) & 2147483647) );
	}
	label$866:;
	label$865:;
	fb$result$1 = (void*)_ZN2FB13RETURNSTRING$E;
	goto label$849;
	label$849:;
	return fb$result$1;
}

static inline void* fb_ByteToStr( byte NUMBER$1 )
{
	struct FBSTRING* TMP$366$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$868:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$871;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$873;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$874;
				label$877:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$879;
					{
						struct FBSTRING* TMP$365$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$364$7;
							TMP$364$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$364$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$365$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$365$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$365$6 == (char*)0 ) goto label$881;
						free( *(void**)TMP$365$6 );
						*(char**)TMP$365$6 = (char*)0;
						*(integer*)((ubyte*)TMP$365$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$365$6 + 8) = 0;
						label$881:;
						if( ISTEMP$6 == 0 ) goto label$883;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$883:;
						label$882:;
					}
					label$879:;
					label$878:;
				}
				label$875:;
				N$4 = N$4 + -1;
				label$874:;
				if( N$4 >= 0 ) goto label$877;
				label$876:;
			}
		}
		label$873:;
		label$872:;
	}
	label$871:;
	label$870:;
	void* vr$1173 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1173;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$366$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$366$1 = (char*)0;
	*(integer*)((ubyte*)TMP$366$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$366$1 + 8) = -2147483648u;
	void* vr$1179 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1179;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	integer vr$1186 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%i", (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1186;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$869;
	label$869:;
	return fb$result$1;
}

static inline void* fb_UByteToStr( ubyte NUMBER$1 )
{
	struct FBSTRING* TMP$370$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$884:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$887;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$889;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$890;
				label$893:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$895;
					{
						struct FBSTRING* TMP$369$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$368$7;
							TMP$368$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$368$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$369$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$369$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$369$6 == (char*)0 ) goto label$897;
						free( *(void**)TMP$369$6 );
						*(char**)TMP$369$6 = (char*)0;
						*(integer*)((ubyte*)TMP$369$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$369$6 + 8) = 0;
						label$897:;
						if( ISTEMP$6 == 0 ) goto label$899;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$899:;
						label$898:;
					}
					label$895:;
					label$894:;
				}
				label$891:;
				N$4 = N$4 + -1;
				label$890:;
				if( N$4 >= 0 ) goto label$893;
				label$892:;
			}
		}
		label$889:;
		label$888:;
	}
	label$887:;
	label$886:;
	void* vr$1208 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1208;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$370$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$370$1 = (char*)0;
	*(integer*)((ubyte*)TMP$370$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$370$1 + 8) = -2147483648u;
	void* vr$1214 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1214;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	integer vr$1221 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%u", (uinteger)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1221;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$885;
	label$885:;
	return fb$result$1;
}

static inline void* fb_ShortToStr( short NUMBER$1 )
{
	struct FBSTRING* TMP$373$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$900:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$903;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$905;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$906;
				label$909:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$911;
					{
						struct FBSTRING* TMP$372$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$371$7;
							TMP$371$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$371$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$372$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$372$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$372$6 == (char*)0 ) goto label$913;
						free( *(void**)TMP$372$6 );
						*(char**)TMP$372$6 = (char*)0;
						*(integer*)((ubyte*)TMP$372$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$372$6 + 8) = 0;
						label$913:;
						if( ISTEMP$6 == 0 ) goto label$915;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$915:;
						label$914:;
					}
					label$911:;
					label$910:;
				}
				label$907:;
				N$4 = N$4 + -1;
				label$906:;
				if( N$4 >= 0 ) goto label$909;
				label$908:;
			}
		}
		label$905:;
		label$904:;
	}
	label$903:;
	label$902:;
	void* vr$1243 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1243;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$373$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$373$1 = (char*)0;
	*(integer*)((ubyte*)TMP$373$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$373$1 + 8) = -2147483648u;
	void* vr$1249 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1249;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	integer vr$1256 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%i", (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1256;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$901;
	label$901:;
	return fb$result$1;
}

static inline void* fb_UShortToStr( ushort NUMBER$1 )
{
	struct FBSTRING* TMP$376$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$916:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$919;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$921;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$922;
				label$925:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$927;
					{
						struct FBSTRING* TMP$375$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$374$7;
							TMP$374$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$374$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$375$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$375$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$375$6 == (char*)0 ) goto label$929;
						free( *(void**)TMP$375$6 );
						*(char**)TMP$375$6 = (char*)0;
						*(integer*)((ubyte*)TMP$375$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$375$6 + 8) = 0;
						label$929:;
						if( ISTEMP$6 == 0 ) goto label$931;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$931:;
						label$930:;
					}
					label$927:;
					label$926:;
				}
				label$923:;
				N$4 = N$4 + -1;
				label$922:;
				if( N$4 >= 0 ) goto label$925;
				label$924:;
			}
		}
		label$921:;
		label$920:;
	}
	label$919:;
	label$918:;
	void* vr$1278 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1278;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$376$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$376$1 = (char*)0;
	*(integer*)((ubyte*)TMP$376$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$376$1 + 8) = -2147483648u;
	void* vr$1284 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1284;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	integer vr$1291 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%u", (uinteger)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1291;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$917;
	label$917:;
	return fb$result$1;
}

static inline void* fb_IntToStr( integer NUMBER$1 )
{
	struct FBSTRING* TMP$379$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$932:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$935;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$937;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$938;
				label$941:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$943;
					{
						struct FBSTRING* TMP$378$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$377$7;
							TMP$377$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$377$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$378$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$378$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$378$6 == (char*)0 ) goto label$945;
						free( *(void**)TMP$378$6 );
						*(char**)TMP$378$6 = (char*)0;
						*(integer*)((ubyte*)TMP$378$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$378$6 + 8) = 0;
						label$945:;
						if( ISTEMP$6 == 0 ) goto label$947;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$947:;
						label$946:;
					}
					label$943:;
					label$942:;
				}
				label$939:;
				N$4 = N$4 + -1;
				label$938:;
				if( N$4 >= 0 ) goto label$941;
				label$940:;
			}
		}
		label$937:;
		label$936:;
	}
	label$935:;
	label$934:;
	void* vr$1313 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1313;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$379$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$379$1 = (char*)0;
	*(integer*)((ubyte*)TMP$379$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$379$1 + 8) = -2147483648u;
	void* vr$1319 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1319;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$1325 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%i", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1325;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$933;
	label$933:;
	return fb$result$1;
}

static inline void* fb_UIntToStr( uinteger NUMBER$1 )
{
	struct FBSTRING* TMP$382$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$948:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$951;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$953;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$954;
				label$957:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$959;
					{
						struct FBSTRING* TMP$381$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$380$7;
							TMP$380$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$380$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$381$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$381$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$381$6 == (char*)0 ) goto label$961;
						free( *(void**)TMP$381$6 );
						*(char**)TMP$381$6 = (char*)0;
						*(integer*)((ubyte*)TMP$381$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$381$6 + 8) = 0;
						label$961:;
						if( ISTEMP$6 == 0 ) goto label$963;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$963:;
						label$962:;
					}
					label$959:;
					label$958:;
				}
				label$955:;
				N$4 = N$4 + -1;
				label$954:;
				if( N$4 >= 0 ) goto label$957;
				label$956:;
			}
		}
		label$953:;
		label$952:;
	}
	label$951:;
	label$950:;
	void* vr$1347 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1347;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$382$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$382$1 = (char*)0;
	*(integer*)((ubyte*)TMP$382$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$382$1 + 8) = -2147483648u;
	void* vr$1353 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1353;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$1359 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%u", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1359;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$949;
	label$949:;
	return fb$result$1;
}

static inline void* fb_LongintToStr( longint NUMBER$1 )
{
	struct FBSTRING* TMP$385$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$964:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$967;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$969;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$970;
				label$973:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$975;
					{
						struct FBSTRING* TMP$384$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$383$7;
							TMP$383$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$383$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$384$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$384$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$384$6 == (char*)0 ) goto label$977;
						free( *(void**)TMP$384$6 );
						*(char**)TMP$384$6 = (char*)0;
						*(integer*)((ubyte*)TMP$384$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$384$6 + 8) = 0;
						label$977:;
						if( ISTEMP$6 == 0 ) goto label$979;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$979:;
						label$978:;
					}
					label$975:;
					label$974:;
				}
				label$971:;
				N$4 = N$4 + -1;
				label$970:;
				if( N$4 >= 0 ) goto label$973;
				label$972:;
			}
		}
		label$969:;
		label$968:;
	}
	label$967:;
	label$966:;
	void* vr$1381 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1381;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$385$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$385$1 = (char*)0;
	*(integer*)((ubyte*)TMP$385$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$385$1 + 8) = -2147483648u;
	void* vr$1387 = malloc( 20u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1387;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 20;
	integer vr$1393 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%Li", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1393;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$965;
	label$965:;
	return fb$result$1;
}

static inline void* fb_ULongintToStr( ulongint NUMBER$1 )
{
	struct FBSTRING* TMP$389$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$980:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$983;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$985;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$986;
				label$989:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$991;
					{
						struct FBSTRING* TMP$388$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$387$7;
							TMP$387$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$387$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$388$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$388$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$388$6 == (char*)0 ) goto label$993;
						free( *(void**)TMP$388$6 );
						*(char**)TMP$388$6 = (char*)0;
						*(integer*)((ubyte*)TMP$388$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$388$6 + 8) = 0;
						label$993:;
						if( ISTEMP$6 == 0 ) goto label$995;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$995:;
						label$994:;
					}
					label$991:;
					label$990:;
				}
				label$987:;
				N$4 = N$4 + -1;
				label$986:;
				if( N$4 >= 0 ) goto label$989;
				label$988:;
			}
		}
		label$985:;
		label$984:;
	}
	label$983:;
	label$982:;
	void* vr$1415 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1415;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$389$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$389$1 = (char*)0;
	*(integer*)((ubyte*)TMP$389$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$389$1 + 8) = -2147483648u;
	void* vr$1421 = malloc( 20u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1421;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 20;
	integer vr$1427 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%Lu", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1427;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$981;
	label$981:;
	return fb$result$1;
}

static inline void* fb_FloatToStr( single NUMBER$1 )
{
	struct FBSTRING* TMP$393$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$996:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$999;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1001;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1002;
				label$1005:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1007;
					{
						struct FBSTRING* TMP$392$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$391$7;
							TMP$391$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$391$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$392$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$392$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$392$6 == (char*)0 ) goto label$1009;
						free( *(void**)TMP$392$6 );
						*(char**)TMP$392$6 = (char*)0;
						*(integer*)((ubyte*)TMP$392$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$392$6 + 8) = 0;
						label$1009:;
						if( ISTEMP$6 == 0 ) goto label$1011;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1011:;
						label$1010:;
					}
					label$1007:;
					label$1006:;
				}
				label$1003:;
				N$4 = N$4 + -1;
				label$1002:;
				if( N$4 >= 0 ) goto label$1005;
				label$1004:;
			}
		}
		label$1001:;
		label$1000:;
	}
	label$999:;
	label$998:;
	void* vr$1449 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1449;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$393$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$393$1 = (char*)0;
	*(integer*)((ubyte*)TMP$393$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$393$1 + 8) = -2147483648u;
	void* vr$1455 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1455;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$1462 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%.7g", (double)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1462;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$997;
	label$997:;
	return fb$result$1;
}

static inline void* fb_DoubleToStr( double NUMBER$1 )
{
	struct FBSTRING* TMP$397$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1012:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1015;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1017;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1018;
				label$1021:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1023;
					{
						struct FBSTRING* TMP$396$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$395$7;
							TMP$395$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$395$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$396$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$396$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$396$6 == (char*)0 ) goto label$1025;
						free( *(void**)TMP$396$6 );
						*(char**)TMP$396$6 = (char*)0;
						*(integer*)((ubyte*)TMP$396$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$396$6 + 8) = 0;
						label$1025:;
						if( ISTEMP$6 == 0 ) goto label$1027;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1027:;
						label$1026:;
					}
					label$1023:;
					label$1022:;
				}
				label$1019:;
				N$4 = N$4 + -1;
				label$1018:;
				if( N$4 >= 0 ) goto label$1021;
				label$1020:;
			}
		}
		label$1017:;
		label$1016:;
	}
	label$1015:;
	label$1014:;
	void* vr$1484 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1484;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$397$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$397$1 = (char*)0;
	*(integer*)((ubyte*)TMP$397$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$397$1 + 8) = -2147483648u;
	void* vr$1490 = malloc( 20u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1490;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 20;
	integer vr$1496 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%.15g", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$1496;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1013;
	label$1013:;
	return fb$result$1;
}

static inline integer fbHexToInt( byte* X$1, integer XSIZE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1028:;
	uinteger INTEGRAL$1;
	INTEGRAL$1 = 0u;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$399$2;
		TMP$399$2 = XSIZE$1 + -1;
		goto label$1030;
		label$1033:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			uinteger OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1035;
				if( CHAR$3 > 57u ) goto label$1035;
				label$1036:;
				{
					INTEGRAL$1 = ((INTEGRAL$1 << 4) + CHAR$3) + 4294967248u;
				}
				goto label$1034;
				label$1035:;
				if( CHAR$3 < 65u ) goto label$1037;
				if( CHAR$3 > 70u ) goto label$1037;
				label$1038:;
				{
					INTEGRAL$1 = ((INTEGRAL$1 << 4) + CHAR$3) + 4294967241u;
				}
				goto label$1034;
				label$1037:;
				if( CHAR$3 < 97u ) goto label$1039;
				if( CHAR$3 > 102u ) goto label$1039;
				label$1040:;
				{
					INTEGRAL$1 = ((INTEGRAL$1 << 4) + CHAR$3) + 4294967209u;
				}
				goto label$1034;
				label$1039:;
				{
					goto label$1032;
				}
				label$1041:;
				label$1034:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1043;
			fb$result$1 = -1;
			goto label$1029;
			label$1043:;
		}
		label$1031:;
		CNT$2 = CNT$2 + 1;
		label$1030:;
		if( CNT$2 <= TMP$399$2 ) goto label$1033;
		label$1032:;
	}
	fb$result$1 = (integer)INTEGRAL$1;
	goto label$1029;
	label$1029:;
	return fb$result$1;
}

static inline integer fbOctToInt( byte* X$1, integer XSIZE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1044:;
	uinteger INTEGRAL$1;
	INTEGRAL$1 = 0u;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$400$2;
		TMP$400$2 = XSIZE$1 + -1;
		goto label$1046;
		label$1049:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			uinteger OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1051;
				if( CHAR$3 > 55u ) goto label$1051;
				label$1052:;
				{
					INTEGRAL$1 = ((INTEGRAL$1 << 3) + CHAR$3) + 4294967248u;
				}
				goto label$1050;
				label$1051:;
				{
					goto label$1048;
				}
				label$1053:;
				label$1050:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1055;
			fb$result$1 = -1;
			goto label$1045;
			label$1055:;
		}
		label$1047:;
		CNT$2 = CNT$2 + 1;
		label$1046:;
		if( CNT$2 <= TMP$400$2 ) goto label$1049;
		label$1048:;
	}
	fb$result$1 = (integer)INTEGRAL$1;
	goto label$1045;
	label$1045:;
	return fb$result$1;
}

static inline integer fbBinToInt( byte* X$1, integer XSIZE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1056:;
	uinteger INTEGRAL$1;
	INTEGRAL$1 = 0u;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$401$2;
		TMP$401$2 = XSIZE$1 + -1;
		goto label$1058;
		label$1061:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			uinteger OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1063;
				if( CHAR$3 > 49u ) goto label$1063;
				label$1064:;
				{
					INTEGRAL$1 = ((INTEGRAL$1 << 1) + CHAR$3) + 4294967248u;
				}
				goto label$1062;
				label$1063:;
				{
					goto label$1060;
				}
				label$1065:;
				label$1062:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1067;
			fb$result$1 = -1;
			goto label$1057;
			label$1067:;
		}
		label$1059:;
		CNT$2 = CNT$2 + 1;
		label$1058:;
		if( CNT$2 <= TMP$401$2 ) goto label$1061;
		label$1060:;
	}
	fb$result$1 = (integer)INTEGRAL$1;
	goto label$1057;
	label$1057:;
	return fb$result$1;
}

static inline longint fbHexToLng( byte* X$1, integer XSIZE$1 )
{
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1068:;
	ulongint INTEGRAL$1;
	INTEGRAL$1 = 0ull;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$402$2;
		TMP$402$2 = XSIZE$1 + -1;
		goto label$1070;
		label$1073:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			ulongint OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1075;
				if( CHAR$3 > 57u ) goto label$1075;
				label$1076:;
				{
					INTEGRAL$1 = (INTEGRAL$1 << 4) + (ulongint)(CHAR$3 + 4294967248u);
				}
				goto label$1074;
				label$1075:;
				if( CHAR$3 < 65u ) goto label$1077;
				if( CHAR$3 > 70u ) goto label$1077;
				label$1078:;
				{
					INTEGRAL$1 = (INTEGRAL$1 << 4) + (ulongint)(CHAR$3 + 4294967241u);
				}
				goto label$1074;
				label$1077:;
				if( CHAR$3 < 97u ) goto label$1079;
				if( CHAR$3 > 102u ) goto label$1079;
				label$1080:;
				{
					INTEGRAL$1 = (INTEGRAL$1 << 4) + (ulongint)(CHAR$3 + 4294967209u);
				}
				goto label$1074;
				label$1079:;
				{
					goto label$1072;
				}
				label$1081:;
				label$1074:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1083;
			fb$result$1 = -1ll;
			goto label$1069;
			label$1083:;
		}
		label$1071:;
		CNT$2 = CNT$2 + 1;
		label$1070:;
		if( CNT$2 <= TMP$402$2 ) goto label$1073;
		label$1072:;
	}
	fb$result$1 = (longint)INTEGRAL$1;
	goto label$1069;
	label$1069:;
	return fb$result$1;
}

static inline longint fbOctToLng( byte* X$1, integer XSIZE$1 )
{
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1084:;
	ulongint INTEGRAL$1;
	INTEGRAL$1 = 0ull;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$403$2;
		TMP$403$2 = XSIZE$1 + -1;
		goto label$1086;
		label$1089:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			ulongint OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1091;
				if( CHAR$3 > 55u ) goto label$1091;
				label$1092:;
				{
					INTEGRAL$1 = (INTEGRAL$1 << 3) + (ulongint)(CHAR$3 + 4294967248u);
				}
				goto label$1090;
				label$1091:;
				{
					goto label$1088;
				}
				label$1093:;
				label$1090:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1095;
			fb$result$1 = -1ll;
			goto label$1085;
			label$1095:;
		}
		label$1087:;
		CNT$2 = CNT$2 + 1;
		label$1086:;
		if( CNT$2 <= TMP$403$2 ) goto label$1089;
		label$1088:;
	}
	fb$result$1 = (longint)INTEGRAL$1;
	goto label$1085;
	label$1085:;
	return fb$result$1;
}

static inline longint fbBinToLng( byte* X$1, integer XSIZE$1 )
{
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1096:;
	ulongint INTEGRAL$1;
	INTEGRAL$1 = 0ull;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$404$2;
		TMP$404$2 = XSIZE$1 + -1;
		goto label$1098;
		label$1101:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			ulongint OLDINT$3;
			OLDINT$3 = INTEGRAL$1;
			{
				if( CHAR$3 < 48u ) goto label$1103;
				if( CHAR$3 > 49u ) goto label$1103;
				label$1104:;
				{
					INTEGRAL$1 = (INTEGRAL$1 << 1) + (ulongint)(CHAR$3 + 4294967248u);
				}
				goto label$1102;
				label$1103:;
				{
					goto label$1100;
				}
				label$1105:;
				label$1102:;
			}
			if( INTEGRAL$1 >= OLDINT$3 ) goto label$1107;
			fb$result$1 = -1ll;
			goto label$1097;
			label$1107:;
		}
		label$1099:;
		CNT$2 = CNT$2 + 1;
		label$1098:;
		if( CNT$2 <= TMP$404$2 ) goto label$1101;
		label$1100:;
	}
	fb$result$1 = (longint)INTEGRAL$1;
	goto label$1097;
	label$1097:;
	return fb$result$1;
}

static        double fb_VAL( void* FBQUERYSTRING$1 )
{
	double fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1108:;
	short NOSPACE$1;
	__builtin_memset( &NOSPACE$1, 0, 2 );
	short HAVEDOT$1;
	__builtin_memset( &HAVEDOT$1, 0, 2 );
	short HAVESIGN$1;
	__builtin_memset( &HAVESIGN$1, 0, 2 );
	short SIGN$1;
	__builtin_memset( &SIGN$1, 0, 2 );
	short DECICOUNT$1;
	__builtin_memset( &DECICOUNT$1, 0, 2 );
	short EXPOENTSIGN$1;
	__builtin_memset( &EXPOENTSIGN$1, 0, 2 );
	short DONE$1;
	__builtin_memset( &DONE$1, 0, 2 );
	longint INTEGRAL$1;
	__builtin_memset( &INTEGRAL$1, 0, 8 );
	longint DECIMAL$1;
	__builtin_memset( &DECIMAL$1, 0, 8 );
	longint EXPOENT$1;
	__builtin_memset( &EXPOENT$1, 0, 8 );
	double RESULT$1;
	__builtin_memset( &RESULT$1, 0, 8 );
	byte* X$1;
	X$1 = (byte*)*(char**)FBQUERYSTRING$1;
	static short INIT$1;
	static double DECINUM$1[16];
	struct TMP$406 {
		double* DATA;
		double* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	static struct TMP$406 tmp$405$1 = { (void*)DECINUM$1, (void*)DECINUM$1, 128, 8, 1, { { 16, 0, 15 } } };
	if( (integer)INIT$1 != 0 ) goto label$1111;
	{
		INIT$1 = (short)1;
		*(double*)DECINUM$1 = 1.0;
		{
			integer CNT$3;
			CNT$3 = 1;
			label$1115:;
			{
				*(double*)((ubyte*)DECINUM$1 + (CNT$3 << 3)) = *(double*)(((ubyte*)DECINUM$1 + (CNT$3 << 3)) + -8) * 0.1;
			}
			label$1113:;
			CNT$3 = CNT$3 + 1;
			label$1112:;
			if( CNT$3 <= 15 ) goto label$1115;
			label$1114:;
		}
	}
	label$1111:;
	label$1110:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$407$2;
		TMP$407$2 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$1116;
		label$1119:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			{
				if( CHAR$3 < 48u ) goto label$1121;
				if( CHAR$3 > 57u ) goto label$1121;
				label$1122:;
				{
					if( (integer)HAVEDOT$1 != 0 ) goto label$1124;
					{
						INTEGRAL$1 = (INTEGRAL$1 * 10ll) + (longint)(CHAR$3 + 4294967248u);
					}
					goto label$1123;
					label$1124:;
					if( (integer)HAVEDOT$1 != 1 ) goto label$1125;
					{
						DECIMAL$1 = (DECIMAL$1 * 10ll) + (longint)(CHAR$3 + 4294967248u);
						DECICOUNT$1 = (short)((integer)DECICOUNT$1 + 1);
					}
					goto label$1123;
					label$1125:;
					{
						EXPOENT$1 = (EXPOENT$1 * 10ll) + (longint)(CHAR$3 + 4294967248u);
					}
					label$1123:;
					NOSPACE$1 = (short)1;
				}
				goto label$1120;
				label$1121:;
				if( CHAR$3 != 45u ) goto label$1126;
				label$1127:;
				{
					if( HAVESIGN$1 == (short)0 ) goto label$1129;
					goto label$1118;
					label$1129:;
					if( (-((integer)HAVEDOT$1 != 2) & (integer)NOSPACE$1) == 0 ) goto label$1131;
					goto label$1118;
					label$1131:;
					NOSPACE$1 = (short)1;
					if( (integer)HAVEDOT$1 != 2 ) goto label$1133;
					EXPOENTSIGN$1 = (short)1;
					goto label$1132;
					label$1133:;
					SIGN$1 = (short)1;
					label$1132:;
				}
				goto label$1120;
				label$1126:;
				if( CHAR$3 != 43u ) goto label$1134;
				label$1135:;
				{
					if( HAVESIGN$1 == (short)0 ) goto label$1137;
					goto label$1118;
					label$1137:;
					if( (-((integer)HAVEDOT$1 != 2) & (integer)NOSPACE$1) == 0 ) goto label$1139;
					goto label$1118;
					label$1139:;
					NOSPACE$1 = (short)1;
					if( (integer)HAVEDOT$1 != 2 ) goto label$1141;
					EXPOENTSIGN$1 = (short)0;
					goto label$1140;
					label$1141:;
					SIGN$1 = (short)0;
					label$1140:;
				}
				goto label$1120;
				label$1134:;
				if( CHAR$3 != 32u ) goto label$1142;
				label$1143:;
				{
					if( NOSPACE$1 == (short)0 ) goto label$1145;
					goto label$1118;
					label$1145:;
				}
				goto label$1120;
				label$1142:;
				if( CHAR$3 != 46u ) goto label$1146;
				label$1147:;
				{
					if( HAVEDOT$1 == (short)0 ) goto label$1149;
					goto label$1118;
					label$1149:;
					NOSPACE$1 = (short)1;
					HAVEDOT$1 = (short)1;
				}
				goto label$1120;
				label$1146:;
				if( CHAR$3 == 100u ) goto label$1151;
				label$1152:;
				if( CHAR$3 == 68u ) goto label$1151;
				label$1153:;
				if( CHAR$3 == 101u ) goto label$1151;
				label$1154:;
				if( CHAR$3 != 69u ) goto label$1150;
				label$1151:;
				{
					if( (integer)HAVEDOT$1 != 2 ) goto label$1156;
					goto label$1118;
					label$1156:;
					HAVEDOT$1 = (short)2;
					HAVESIGN$1 = (short)0;
				}
				goto label$1120;
				label$1150:;
				if( CHAR$3 != 38u ) goto label$1157;
				label$1158:;
				{
					{
						uinteger TMP$409$6;
						TMP$409$6 = (uinteger)*(byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 1);
						if( TMP$409$6 == 104u ) goto label$1161;
						label$1162:;
						if( TMP$409$6 != 72u ) goto label$1160;
						label$1161:;
						{
							longint vr$1627 = fbHexToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = (double)vr$1627;
							DONE$1 = (short)1;
						}
						goto label$1159;
						label$1160:;
						if( TMP$409$6 == 98u ) goto label$1164;
						label$1165:;
						if( TMP$409$6 != 66u ) goto label$1163;
						label$1164:;
						{
							longint vr$1634 = fbBinToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = (double)vr$1634;
							DONE$1 = (short)1;
						}
						goto label$1159;
						label$1163:;
						if( TMP$409$6 == 111u ) goto label$1167;
						label$1168:;
						if( TMP$409$6 != 79u ) goto label$1166;
						label$1167:;
						{
							longint vr$1641 = fbOctToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = (double)vr$1641;
							DONE$1 = (short)1;
						}
						label$1166:;
						label$1159:;
					}
					if( DONE$1 == (short)0 ) goto label$1170;
					{
						if( FBQUERYSTRING$1 == (void*)0 ) goto label$1172;
						{
							{
								long N$8;
								N$8 = TEMPSTRINGCOUNT$ + -1;
								goto label$1173;
								label$1176:;
								{
									if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) ) goto label$1178;
									{
										struct FBSTRING* TMP$411$10;
										void* PTEMP$10;
										PTEMP$10 = FBQUERYSTRING$1;
										{
											void* TMP$410$11;
											TMP$410$11 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$410$11;
										}
										TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
										TMP$411$10 = (struct FBSTRING*)FBQUERYSTRING$1;
										integer ISTEMP$10;
										ISTEMP$10 = -((*(uinteger*)((ubyte*)TMP$411$10 + 8) & -1048576) == -2147483648u);
										if( *(char**)TMP$411$10 == (char*)0 ) goto label$1180;
										free( *(void**)TMP$411$10 );
										*(char**)TMP$411$10 = (char*)0;
										*(integer*)((ubyte*)TMP$411$10 + 4) = 0;
										*(integer*)((ubyte*)TMP$411$10 + 8) = 0;
										label$1180:;
										if( ISTEMP$10 == 0 ) goto label$1182;
										{
											free( FBQUERYSTRING$1 );
											FBQUERYSTRING$1 = (void*)0;
										}
										label$1182:;
										label$1181:;
									}
									label$1178:;
									label$1177:;
								}
								label$1174:;
								N$8 = N$8 + -1;
								label$1173:;
								if( N$8 >= 0 ) goto label$1176;
								label$1175:;
							}
						}
						label$1172:;
						label$1171:;
						goto label$1109;
					}
					goto label$1169;
					label$1170:;
					{
						goto label$1118;
					}
					label$1169:;
				}
				goto label$1120;
				label$1157:;
				{
					goto label$1118;
				}
				label$1183:;
				label$1120:;
			}
		}
		label$1117:;
		CNT$2 = CNT$2 + 1;
		label$1116:;
		if( CNT$2 <= TMP$407$2 ) goto label$1119;
		label$1118:;
	}
	RESULT$1 = (double)INTEGRAL$1 + ((double)DECIMAL$1 * *(double*)((ubyte*)DECINUM$1 + ((integer)DECICOUNT$1 << 3)));
	if( EXPOENTSIGN$1 == (short)0 ) goto label$1185;
	EXPOENT$1 = -EXPOENT$1;
	label$1185:;
	if( EXPOENT$1 == 0ll ) goto label$1187;
	double vr$1670 = pow( 10.0, (double)EXPOENT$1 );
	RESULT$1 = RESULT$1 * vr$1670;
	label$1187:;
	if( SIGN$1 == (short)0 ) goto label$1189;
	RESULT$1 = -RESULT$1;
	label$1189:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1191;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1192;
			label$1195:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1197;
				{
					struct FBSTRING* TMP$413$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$412$6;
						TMP$412$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$412$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$413$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$413$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$413$5 == (char*)0 ) goto label$1199;
					free( *(void**)TMP$413$5 );
					*(char**)TMP$413$5 = (char*)0;
					*(integer*)((ubyte*)TMP$413$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$413$5 + 8) = 0;
					label$1199:;
					if( ISTEMP$5 == 0 ) goto label$1201;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1201:;
					label$1200:;
				}
				label$1197:;
				label$1196:;
			}
			label$1193:;
			N$3 = N$3 + -1;
			label$1192:;
			if( N$3 >= 0 ) goto label$1195;
			label$1194:;
		}
	}
	label$1191:;
	label$1190:;
	fb$result$1 = RESULT$1;
	goto label$1109;
	label$1109:;
	return fb$result$1;
}

static        integer fb_VALINT( void* FBQUERYSTRING$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1202:;
	uinteger NOSPACE$1;
	__builtin_memset( &NOSPACE$1, 0, 4 );
	uinteger SIGN$1;
	__builtin_memset( &SIGN$1, 0, 4 );
	uinteger INTEGRAL$1;
	__builtin_memset( &INTEGRAL$1, 0, 4 );
	uinteger DONE$1;
	__builtin_memset( &DONE$1, 0, 4 );
	byte* X$1;
	X$1 = (byte*)*(char**)FBQUERYSTRING$1;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$414$2;
		TMP$414$2 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$1204;
		label$1207:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			{
				if( CHAR$3 < 48u ) goto label$1209;
				if( CHAR$3 > 57u ) goto label$1209;
				label$1210:;
				{
					uinteger OLDINT$5;
					OLDINT$5 = INTEGRAL$1;
					INTEGRAL$1 = ((INTEGRAL$1 * 10) + CHAR$3) + 4294967248u;
					if( INTEGRAL$1 >= OLDINT$5 ) goto label$1212;
					fb$result$1 = -1;
					goto label$1203;
					label$1212:;
					NOSPACE$1 = 1u;
				}
				goto label$1208;
				label$1209:;
				if( CHAR$3 != 45u ) goto label$1213;
				label$1214:;
				{
					if( NOSPACE$1 == 0u ) goto label$1216;
					goto label$1206;
					label$1216:;
					NOSPACE$1 = 1u;
					SIGN$1 = 1u;
				}
				goto label$1208;
				label$1213:;
				if( CHAR$3 != 43u ) goto label$1217;
				label$1218:;
				{
					if( NOSPACE$1 == 0u ) goto label$1220;
					goto label$1206;
					label$1220:;
					NOSPACE$1 = 1u;
					SIGN$1 = 0u;
				}
				goto label$1208;
				label$1217:;
				if( CHAR$3 != 32u ) goto label$1221;
				label$1222:;
				{
					if( NOSPACE$1 == 0u ) goto label$1224;
					goto label$1206;
					label$1224:;
				}
				goto label$1208;
				label$1221:;
				if( CHAR$3 != 38u ) goto label$1225;
				label$1226:;
				{
					{
						uinteger TMP$415$6;
						TMP$415$6 = (uinteger)*(byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 1);
						if( TMP$415$6 == 104u ) goto label$1229;
						label$1230:;
						if( TMP$415$6 != 72u ) goto label$1228;
						label$1229:;
						{
							integer vr$1712 = fbHexToInt( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1712;
							DONE$1 = 1u;
						}
						goto label$1227;
						label$1228:;
						if( TMP$415$6 == 98u ) goto label$1232;
						label$1233:;
						if( TMP$415$6 != 66u ) goto label$1231;
						label$1232:;
						{
							integer vr$1718 = fbBinToInt( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1718;
							DONE$1 = 1u;
						}
						goto label$1227;
						label$1231:;
						if( TMP$415$6 == 111u ) goto label$1235;
						label$1236:;
						if( TMP$415$6 != 79u ) goto label$1234;
						label$1235:;
						{
							integer vr$1724 = fbOctToInt( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1724;
							DONE$1 = 1u;
						}
						label$1234:;
						label$1227:;
					}
					if( DONE$1 == 0u ) goto label$1238;
					{
						if( FBQUERYSTRING$1 == (void*)0 ) goto label$1240;
						{
							{
								long N$8;
								N$8 = TEMPSTRINGCOUNT$ + -1;
								goto label$1241;
								label$1244:;
								{
									if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) ) goto label$1246;
									{
										struct FBSTRING* TMP$417$10;
										void* PTEMP$10;
										PTEMP$10 = FBQUERYSTRING$1;
										{
											void* TMP$416$11;
											TMP$416$11 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$416$11;
										}
										TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
										TMP$417$10 = (struct FBSTRING*)FBQUERYSTRING$1;
										integer ISTEMP$10;
										ISTEMP$10 = -((*(uinteger*)((ubyte*)TMP$417$10 + 8) & -1048576) == -2147483648u);
										if( *(char**)TMP$417$10 == (char*)0 ) goto label$1248;
										free( *(void**)TMP$417$10 );
										*(char**)TMP$417$10 = (char*)0;
										*(integer*)((ubyte*)TMP$417$10 + 4) = 0;
										*(integer*)((ubyte*)TMP$417$10 + 8) = 0;
										label$1248:;
										if( ISTEMP$10 == 0 ) goto label$1250;
										{
											free( FBQUERYSTRING$1 );
											FBQUERYSTRING$1 = (void*)0;
										}
										label$1250:;
										label$1249:;
									}
									label$1246:;
									label$1245:;
								}
								label$1242:;
								N$8 = N$8 + -1;
								label$1241:;
								if( N$8 >= 0 ) goto label$1244;
								label$1243:;
							}
						}
						label$1240:;
						label$1239:;
						goto label$1203;
					}
					goto label$1237;
					label$1238:;
					{
						goto label$1206;
					}
					label$1237:;
				}
				goto label$1208;
				label$1225:;
				{
					goto label$1206;
				}
				label$1251:;
				label$1208:;
			}
		}
		label$1205:;
		CNT$2 = CNT$2 + 1;
		label$1204:;
		if( CNT$2 <= TMP$414$2 ) goto label$1207;
		label$1206:;
	}
	if( SIGN$1 == 0u ) goto label$1253;
	INTEGRAL$1 = -INTEGRAL$1;
	label$1253:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1255;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1256;
			label$1259:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1261;
				{
					struct FBSTRING* TMP$419$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$418$6;
						TMP$418$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$418$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$419$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$419$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$419$5 == (char*)0 ) goto label$1263;
					free( *(void**)TMP$419$5 );
					*(char**)TMP$419$5 = (char*)0;
					*(integer*)((ubyte*)TMP$419$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$419$5 + 8) = 0;
					label$1263:;
					if( ISTEMP$5 == 0 ) goto label$1265;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1265:;
					label$1264:;
				}
				label$1261:;
				label$1260:;
			}
			label$1257:;
			N$3 = N$3 + -1;
			label$1256:;
			if( N$3 >= 0 ) goto label$1259;
			label$1258:;
		}
	}
	label$1255:;
	label$1254:;
	fb$result$1 = (integer)INTEGRAL$1;
	goto label$1203;
	label$1203:;
	return fb$result$1;
}

static        longint fb_VALLNG( void* FBQUERYSTRING$1 )
{
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1266:;
	uinteger NOSPACE$1;
	__builtin_memset( &NOSPACE$1, 0, 4 );
	uinteger SIGN$1;
	__builtin_memset( &SIGN$1, 0, 4 );
	uinteger DONE$1;
	__builtin_memset( &DONE$1, 0, 4 );
	ulongint INTEGRAL$1;
	__builtin_memset( &INTEGRAL$1, 0, 8 );
	byte* X$1;
	X$1 = (byte*)*(char**)FBQUERYSTRING$1;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$420$2;
		TMP$420$2 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$1268;
		label$1271:;
		{
			uinteger CHAR$3;
			CHAR$3 = (uinteger)*(byte*)((ubyte*)X$1 + CNT$2);
			{
				if( CHAR$3 < 48u ) goto label$1273;
				if( CHAR$3 > 57u ) goto label$1273;
				label$1274:;
				{
					ulongint OLDINT$5;
					OLDINT$5 = INTEGRAL$1;
					INTEGRAL$1 = (INTEGRAL$1 * 10ull) + (ulongint)(CHAR$3 + 4294967248u);
					if( INTEGRAL$1 >= OLDINT$5 ) goto label$1276;
					fb$result$1 = -1ll;
					goto label$1267;
					label$1276:;
					NOSPACE$1 = 1u;
				}
				goto label$1272;
				label$1273:;
				if( CHAR$3 != 45u ) goto label$1277;
				label$1278:;
				{
					if( NOSPACE$1 == 0u ) goto label$1280;
					goto label$1270;
					label$1280:;
					NOSPACE$1 = 1u;
					SIGN$1 = 1u;
				}
				goto label$1272;
				label$1277:;
				if( CHAR$3 != 43u ) goto label$1281;
				label$1282:;
				{
					if( NOSPACE$1 == 0u ) goto label$1284;
					goto label$1270;
					label$1284:;
					NOSPACE$1 = 1u;
					SIGN$1 = 0u;
				}
				goto label$1272;
				label$1281:;
				if( CHAR$3 != 32u ) goto label$1285;
				label$1286:;
				{
					if( NOSPACE$1 == 0u ) goto label$1288;
					goto label$1270;
					label$1288:;
				}
				goto label$1272;
				label$1285:;
				if( CHAR$3 != 38u ) goto label$1289;
				label$1290:;
				{
					{
						uinteger TMP$421$6;
						TMP$421$6 = (uinteger)*(byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 1);
						if( TMP$421$6 == 104u ) goto label$1293;
						label$1294:;
						if( TMP$421$6 != 72u ) goto label$1292;
						label$1293:;
						{
							longint vr$1785 = fbHexToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1785;
							DONE$1 = 1u;
						}
						goto label$1291;
						label$1292:;
						if( TMP$421$6 == 98u ) goto label$1296;
						label$1297:;
						if( TMP$421$6 != 66u ) goto label$1295;
						label$1296:;
						{
							longint vr$1791 = fbBinToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1791;
							DONE$1 = 1u;
						}
						goto label$1291;
						label$1295:;
						if( TMP$421$6 == 111u ) goto label$1299;
						label$1300:;
						if( TMP$421$6 != 79u ) goto label$1298;
						label$1299:;
						{
							longint vr$1797 = fbOctToLng( (byte*)((ubyte*)((ubyte*)X$1 + CNT$2) + 2), (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - CNT$2) + -2 );              
							fb$result$1 = vr$1797;
							DONE$1 = 1u;
						}
						label$1298:;
						label$1291:;
					}
					if( DONE$1 == 0u ) goto label$1302;
					{
						if( FBQUERYSTRING$1 == (void*)0 ) goto label$1304;
						{
							{
								long N$8;
								N$8 = TEMPSTRINGCOUNT$ + -1;
								goto label$1305;
								label$1308:;
								{
									if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) ) goto label$1310;
									{
										struct FBSTRING* TMP$423$10;
										void* PTEMP$10;
										PTEMP$10 = FBQUERYSTRING$1;
										{
											void* TMP$422$11;
											TMP$422$11 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$422$11;
										}
										TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
										TMP$423$10 = (struct FBSTRING*)FBQUERYSTRING$1;
										integer ISTEMP$10;
										ISTEMP$10 = -((*(uinteger*)((ubyte*)TMP$423$10 + 8) & -1048576) == -2147483648u);
										if( *(char**)TMP$423$10 == (char*)0 ) goto label$1312;
										free( *(void**)TMP$423$10 );
										*(char**)TMP$423$10 = (char*)0;
										*(integer*)((ubyte*)TMP$423$10 + 4) = 0;
										*(integer*)((ubyte*)TMP$423$10 + 8) = 0;
										label$1312:;
										if( ISTEMP$10 == 0 ) goto label$1314;
										{
											free( FBQUERYSTRING$1 );
											FBQUERYSTRING$1 = (void*)0;
										}
										label$1314:;
										label$1313:;
									}
									label$1310:;
									label$1309:;
								}
								label$1306:;
								N$8 = N$8 + -1;
								label$1305:;
								if( N$8 >= 0 ) goto label$1308;
								label$1307:;
							}
						}
						label$1304:;
						label$1303:;
						goto label$1267;
					}
					goto label$1301;
					label$1302:;
					{
						goto label$1270;
					}
					label$1301:;
				}
				goto label$1272;
				label$1289:;
				{
					goto label$1270;
				}
				label$1315:;
				label$1272:;
			}
		}
		label$1269:;
		CNT$2 = CNT$2 + 1;
		label$1268:;
		if( CNT$2 <= TMP$420$2 ) goto label$1271;
		label$1270:;
	}
	if( SIGN$1 == 0u ) goto label$1317;
	INTEGRAL$1 = -INTEGRAL$1;
	label$1317:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1319;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1320;
			label$1323:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1325;
				{
					struct FBSTRING* TMP$425$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$424$6;
						TMP$424$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$424$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$425$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$425$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$425$5 == (char*)0 ) goto label$1327;
					free( *(void**)TMP$425$5 );
					*(char**)TMP$425$5 = (char*)0;
					*(integer*)((ubyte*)TMP$425$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$425$5 + 8) = 0;
					label$1327:;
					if( ISTEMP$5 == 0 ) goto label$1329;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1329:;
					label$1328:;
				}
				label$1325:;
				label$1324:;
			}
			label$1321:;
			N$3 = N$3 + -1;
			label$1320:;
			if( N$3 >= 0 ) goto label$1323;
			label$1322:;
		}
	}
	label$1319:;
	label$1318:;
	fb$result$1 = (longint)INTEGRAL$1;
	goto label$1267;
	label$1267:;
	return fb$result$1;
}

static inline single fb_FIXSingle( single NUMBER0$1 )
{
	single fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1330:;
	single NUMBER$1;
	NUMBER$1 = NUMBER0$1;
	integer vr$1838 = fb_ftosi( NUMBER$1 );
	fb$result$1 = (single)vr$1838;
	goto label$1331;
	label$1331:;
	return fb$result$1;
}

static inline double fb_FIXDouble( double NUMBER$1 )
{
	double fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1332:;
	integer vr$1842 = fb_dtosi( NUMBER$1 );
	fb$result$1 = (double)vr$1842;
	goto label$1333;
	label$1333:;
	return fb$result$1;
}

static inline integer fb_SGNi( integer INUMBER$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1334:;
	if( INUMBER$1 <= 0 ) goto label$1337;
	fb$result$1 = 1;
	goto label$1335;
	label$1337:;
	if( INUMBER$1 >= 0 ) goto label$1339;
	fb$result$1 = -1;
	goto label$1335;
	label$1339:;
	fb$result$1 = 0;
	goto label$1335;
	label$1335:;
	return fb$result$1;
}

static inline long fb_SGNl( long INUMBER$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1340:;
	if( INUMBER$1 <= 0 ) goto label$1343;
	fb$result$1 = 1;
	goto label$1341;
	label$1343:;
	if( INUMBER$1 >= 0 ) goto label$1345;
	fb$result$1 = -1;
	goto label$1341;
	label$1345:;
	fb$result$1 = 0;
	goto label$1341;
	label$1341:;
	return fb$result$1;
}

static inline integer fb_SGNs( short INUMBER$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1346:;
	if( (integer)INUMBER$1 <= 0 ) goto label$1349;
	fb$result$1 = 1;
	goto label$1347;
	label$1349:;
	if( (integer)INUMBER$1 >= 0 ) goto label$1351;
	fb$result$1 = -1;
	goto label$1347;
	label$1351:;
	fb$result$1 = 0;
	goto label$1347;
	label$1347:;
	return fb$result$1;
}

static inline integer fb_SGNSingle( single SNUMBER$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1352:;
	if( SNUMBER$1 <= 0.0f ) goto label$1355;
	fb$result$1 = 1;
	goto label$1353;
	label$1355:;
	if( SNUMBER$1 >= 0.0f ) goto label$1357;
	fb$result$1 = -1;
	goto label$1353;
	label$1357:;
	fb$result$1 = 0;
	goto label$1353;
	label$1353:;
	return fb$result$1;
}

static inline integer fb_SGNDouble( double DNUMBER$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1358:;
	if( DNUMBER$1 <= 0.0 ) goto label$1361;
	fb$result$1 = 1;
	goto label$1359;
	label$1361:;
	if( DNUMBER$1 >= 0.0 ) goto label$1363;
	fb$result$1 = -1;
	goto label$1359;
	label$1363:;
	fb$result$1 = 0;
	goto label$1359;
	label$1359:;
	return fb$result$1;
}

static inline void* fb_MKSHORT( short NUMBER$1 )
{
	struct FBSTRING* TMP$428$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1364:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1367;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1369;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1370;
				label$1373:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1375;
					{
						struct FBSTRING* TMP$427$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$426$7;
							TMP$426$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$426$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$427$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$427$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$427$6 == (char*)0 ) goto label$1377;
						free( *(void**)TMP$427$6 );
						*(char**)TMP$427$6 = (char*)0;
						*(integer*)((ubyte*)TMP$427$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$427$6 + 8) = 0;
						label$1377:;
						if( ISTEMP$6 == 0 ) goto label$1379;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1379:;
						label$1378:;
					}
					label$1375:;
					label$1374:;
				}
				label$1371:;
				N$4 = N$4 + -1;
				label$1370:;
				if( N$4 >= 0 ) goto label$1373;
				label$1372:;
			}
		}
		label$1369:;
		label$1368:;
	}
	label$1367:;
	label$1366:;
	void* vr$1876 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1876;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$428$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$428$1 = (char*)0;
	*(integer*)((ubyte*)TMP$428$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$428$1 + 8) = -2147483648u;
	void* vr$1882 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1882;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = 2;
	*(*(short**)_ZN2FB11TEMPSTRING$E) = NUMBER$1;
	*(ubyte*)(*(ubyte**)_ZN2FB11TEMPSTRING$E + *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1365;
	label$1365:;
	return fb$result$1;
}

static inline void* fb_MKI( integer NUMBER$1 )
{
	struct FBSTRING* TMP$431$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1380:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1383;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1385;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1386;
				label$1389:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1391;
					{
						struct FBSTRING* TMP$430$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$429$7;
							TMP$429$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$429$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$430$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$430$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$430$6 == (char*)0 ) goto label$1393;
						free( *(void**)TMP$430$6 );
						*(char**)TMP$430$6 = (char*)0;
						*(integer*)((ubyte*)TMP$430$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$430$6 + 8) = 0;
						label$1393:;
						if( ISTEMP$6 == 0 ) goto label$1395;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1395:;
						label$1394:;
					}
					label$1391:;
					label$1390:;
				}
				label$1387:;
				N$4 = N$4 + -1;
				label$1386:;
				if( N$4 >= 0 ) goto label$1389;
				label$1388:;
			}
		}
		label$1385:;
		label$1384:;
	}
	label$1383:;
	label$1382:;
	void* vr$1913 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1913;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$431$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$431$1 = (char*)0;
	*(integer*)((ubyte*)TMP$431$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$431$1 + 8) = -2147483648u;
	void* vr$1919 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1919;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = 4;
	*(*(integer**)_ZN2FB11TEMPSTRING$E) = NUMBER$1;
	*(ubyte*)(*(ubyte**)_ZN2FB11TEMPSTRING$E + *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1381;
	label$1381:;
	return fb$result$1;
}

static inline void* fb_MKLONGINT( longint NUMBER$1 )
{
	struct FBSTRING* TMP$434$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1396:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1399;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1401;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1402;
				label$1405:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1407;
					{
						struct FBSTRING* TMP$433$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$432$7;
							TMP$432$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$432$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$433$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$433$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$433$6 == (char*)0 ) goto label$1409;
						free( *(void**)TMP$433$6 );
						*(char**)TMP$433$6 = (char*)0;
						*(integer*)((ubyte*)TMP$433$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$433$6 + 8) = 0;
						label$1409:;
						if( ISTEMP$6 == 0 ) goto label$1411;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1411:;
						label$1410:;
					}
					label$1407:;
					label$1406:;
				}
				label$1403:;
				N$4 = N$4 + -1;
				label$1402:;
				if( N$4 >= 0 ) goto label$1405;
				label$1404:;
			}
		}
		label$1401:;
		label$1400:;
	}
	label$1399:;
	label$1398:;
	void* vr$1950 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1950;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$434$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$434$1 = (char*)0;
	*(integer*)((ubyte*)TMP$434$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$434$1 + 8) = -2147483648u;
	void* vr$1956 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1956;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = 8;
	*(*(longint**)_ZN2FB11TEMPSTRING$E) = NUMBER$1;
	*(ubyte*)(*(ubyte**)_ZN2FB11TEMPSTRING$E + *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1397;
	label$1397:;
	return fb$result$1;
}

static inline void* fb_MKS( single NUMBER$1 )
{
	struct FBSTRING* TMP$437$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1412:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1415;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1417;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1418;
				label$1421:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1423;
					{
						struct FBSTRING* TMP$436$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$435$7;
							TMP$435$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$435$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$436$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$436$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$436$6 == (char*)0 ) goto label$1425;
						free( *(void**)TMP$436$6 );
						*(char**)TMP$436$6 = (char*)0;
						*(integer*)((ubyte*)TMP$436$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$436$6 + 8) = 0;
						label$1425:;
						if( ISTEMP$6 == 0 ) goto label$1427;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1427:;
						label$1426:;
					}
					label$1423:;
					label$1422:;
				}
				label$1419:;
				N$4 = N$4 + -1;
				label$1418:;
				if( N$4 >= 0 ) goto label$1421;
				label$1420:;
			}
		}
		label$1417:;
		label$1416:;
	}
	label$1415:;
	label$1414:;
	void* vr$1987 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$1987;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$437$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$437$1 = (char*)0;
	*(integer*)((ubyte*)TMP$437$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$437$1 + 8) = -2147483648u;
	void* vr$1993 = malloc( 8u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$1993;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 8;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = 4;
	*(*(single**)_ZN2FB11TEMPSTRING$E) = NUMBER$1;
	*(ubyte*)(*(ubyte**)_ZN2FB11TEMPSTRING$E + *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1413;
	label$1413:;
	return fb$result$1;
}

static inline void* fb_MKD( double NUMBER$1 )
{
	struct FBSTRING* TMP$440$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1428:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1431;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1433;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1434;
				label$1437:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1439;
					{
						struct FBSTRING* TMP$439$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$438$7;
							TMP$438$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$438$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$439$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$439$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$439$6 == (char*)0 ) goto label$1441;
						free( *(void**)TMP$439$6 );
						*(char**)TMP$439$6 = (char*)0;
						*(integer*)((ubyte*)TMP$439$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$439$6 + 8) = 0;
						label$1441:;
						if( ISTEMP$6 == 0 ) goto label$1443;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1443:;
						label$1442:;
					}
					label$1439:;
					label$1438:;
				}
				label$1435:;
				N$4 = N$4 + -1;
				label$1434:;
				if( N$4 >= 0 ) goto label$1437;
				label$1436:;
			}
		}
		label$1433:;
		label$1432:;
	}
	label$1431:;
	label$1430:;
	void* vr$2024 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2024;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$440$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$440$1 = (char*)0;
	*(integer*)((ubyte*)TMP$440$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$440$1 + 8) = -2147483648u;
	void* vr$2030 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2030;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = 8;
	*(*(double**)_ZN2FB11TEMPSTRING$E) = NUMBER$1;
	*(ubyte*)(*(ubyte**)_ZN2FB11TEMPSTRING$E + *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1429;
	label$1429:;
	return fb$result$1;
}

static inline short fb_CVSHORT( void* FBQUERYSTRING$1 )
{
	integer TMP$441$1;
	short fb$result$1;
	__builtin_memset( &fb$result$1, 0, 2 );
	label$1444:;
	short IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 2 );
	if( *(char**)FBQUERYSTRING$1 == 0 ) goto label$1446;
	TMP$441$1 = -(-(*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 2) != 0);
	goto label$1461;
	label$1446:;
	TMP$441$1 = 0;
	label$1461:;
	if( TMP$441$1 == 0 ) goto label$1448;
	{
		IRESULT$1 = *(*(short**)FBQUERYSTRING$1);
	}
	label$1448:;
	label$1447:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1450;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1451;
			label$1454:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1456;
				{
					struct FBSTRING* TMP$443$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$442$6;
						TMP$442$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$442$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$443$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$443$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$443$5 == (char*)0 ) goto label$1458;
					free( *(void**)TMP$443$5 );
					*(char**)TMP$443$5 = (char*)0;
					*(integer*)((ubyte*)TMP$443$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$443$5 + 8) = 0;
					label$1458:;
					if( ISTEMP$5 == 0 ) goto label$1460;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1460:;
					label$1459:;
				}
				label$1456:;
				label$1455:;
			}
			label$1452:;
			N$3 = N$3 + -1;
			label$1451:;
			if( N$3 >= 0 ) goto label$1454;
			label$1453:;
		}
	}
	label$1450:;
	label$1449:;
	fb$result$1 = IRESULT$1;
	goto label$1445;
	label$1445:;
	return fb$result$1;
}

static inline integer fb_CVI( void* FBQUERYSTRING$1 )
{
	integer TMP$444$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1462:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	if( *(char**)FBQUERYSTRING$1 == 0 ) goto label$1464;
	TMP$444$1 = -(-(*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 4) != 0);
	goto label$1479;
	label$1464:;
	TMP$444$1 = 0;
	label$1479:;
	if( TMP$444$1 == 0 ) goto label$1466;
	{
		IRESULT$1 = *(*(integer**)FBQUERYSTRING$1);
	}
	label$1466:;
	label$1465:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1468;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1469;
			label$1472:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1474;
				{
					struct FBSTRING* TMP$446$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$445$6;
						TMP$445$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$445$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$446$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$446$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$446$5 == (char*)0 ) goto label$1476;
					free( *(void**)TMP$446$5 );
					*(char**)TMP$446$5 = (char*)0;
					*(integer*)((ubyte*)TMP$446$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$446$5 + 8) = 0;
					label$1476:;
					if( ISTEMP$5 == 0 ) goto label$1478;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1478:;
					label$1477:;
				}
				label$1474:;
				label$1473:;
			}
			label$1470:;
			N$3 = N$3 + -1;
			label$1469:;
			if( N$3 >= 0 ) goto label$1472;
			label$1471:;
		}
	}
	label$1468:;
	label$1467:;
	fb$result$1 = IRESULT$1;
	goto label$1463;
	label$1463:;
	return fb$result$1;
}

static inline longint fb_CVLONGINT( void* FBQUERYSTRING$1 )
{
	integer TMP$447$1;
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1480:;
	longint IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 8 );
	if( *(char**)FBQUERYSTRING$1 == 0 ) goto label$1482;
	TMP$447$1 = -(-(*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 8) != 0);
	goto label$1497;
	label$1482:;
	TMP$447$1 = 0;
	label$1497:;
	if( TMP$447$1 == 0 ) goto label$1484;
	{
		IRESULT$1 = *(*(longint**)FBQUERYSTRING$1);
	}
	label$1484:;
	label$1483:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1486;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1487;
			label$1490:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1492;
				{
					struct FBSTRING* TMP$449$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$448$6;
						TMP$448$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$448$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$449$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$449$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$449$5 == (char*)0 ) goto label$1494;
					free( *(void**)TMP$449$5 );
					*(char**)TMP$449$5 = (char*)0;
					*(integer*)((ubyte*)TMP$449$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$449$5 + 8) = 0;
					label$1494:;
					if( ISTEMP$5 == 0 ) goto label$1496;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1496:;
					label$1495:;
				}
				label$1492:;
				label$1491:;
			}
			label$1488:;
			N$3 = N$3 + -1;
			label$1487:;
			if( N$3 >= 0 ) goto label$1490;
			label$1489:;
		}
	}
	label$1486:;
	label$1485:;
	fb$result$1 = IRESULT$1;
	goto label$1481;
	label$1481:;
	return fb$result$1;
}

static inline single fb_CVS( void* FBQUERYSTRING$1 )
{
	integer TMP$450$1;
	single fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1498:;
	single IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	if( *(char**)FBQUERYSTRING$1 == 0 ) goto label$1500;
	TMP$450$1 = -(-(*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 4) != 0);
	goto label$1515;
	label$1500:;
	TMP$450$1 = 0;
	label$1515:;
	if( TMP$450$1 == 0 ) goto label$1502;
	{
		IRESULT$1 = *(*(single**)FBQUERYSTRING$1);
	}
	label$1502:;
	label$1501:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1504;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1505;
			label$1508:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1510;
				{
					struct FBSTRING* TMP$452$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$451$6;
						TMP$451$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$451$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$452$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$452$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$452$5 == (char*)0 ) goto label$1512;
					free( *(void**)TMP$452$5 );
					*(char**)TMP$452$5 = (char*)0;
					*(integer*)((ubyte*)TMP$452$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$452$5 + 8) = 0;
					label$1512:;
					if( ISTEMP$5 == 0 ) goto label$1514;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1514:;
					label$1513:;
				}
				label$1510:;
				label$1509:;
			}
			label$1506:;
			N$3 = N$3 + -1;
			label$1505:;
			if( N$3 >= 0 ) goto label$1508;
			label$1507:;
		}
	}
	label$1504:;
	label$1503:;
	fb$result$1 = IRESULT$1;
	goto label$1499;
	label$1499:;
	return fb$result$1;
}

static inline double fb_CVD( void* FBQUERYSTRING$1 )
{
	integer TMP$453$1;
	double fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$1516:;
	double IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 8 );
	if( *(char**)FBQUERYSTRING$1 == 0 ) goto label$1518;
	TMP$453$1 = -(-(*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 8) != 0);
	goto label$1533;
	label$1518:;
	TMP$453$1 = 0;
	label$1533:;
	if( TMP$453$1 == 0 ) goto label$1520;
	{
		IRESULT$1 = *(*(double**)FBQUERYSTRING$1);
	}
	label$1520:;
	label$1519:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1522;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1523;
			label$1526:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1528;
				{
					struct FBSTRING* TMP$455$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$454$6;
						TMP$454$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$454$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$455$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$455$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$455$5 == (char*)0 ) goto label$1530;
					free( *(void**)TMP$455$5 );
					*(char**)TMP$455$5 = (char*)0;
					*(integer*)((ubyte*)TMP$455$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$455$5 + 8) = 0;
					label$1530:;
					if( ISTEMP$5 == 0 ) goto label$1532;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1532:;
					label$1531:;
				}
				label$1528:;
				label$1527:;
			}
			label$1524:;
			N$3 = N$3 + -1;
			label$1523:;
			if( N$3 >= 0 ) goto label$1526;
			label$1525:;
		}
	}
	label$1522:;
	label$1521:;
	fb$result$1 = IRESULT$1;
	goto label$1517;
	label$1517:;
	return fb$result$1;
}

static        void* fb_BINEx_Proto( integer NUMBER$1, integer IWIDTH$1, integer MAXSIZE$1 )
{
	struct FBSTRING* TMP$461$1;
	struct FBSTRING* TMP$462$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1534:;
	ubyte TEMPBUFF$1[64];
	struct TMP$457 {
		ubyte* DATA;
		ubyte* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$457 tmp$456$1;
	*(ubyte**)&tmp$456$1 = (ubyte*)TEMPBUFF$1;
	*(ubyte**)((ubyte*)&tmp$456$1 + 4) = (ubyte*)TEMPBUFF$1;
	*(integer*)((ubyte*)&tmp$456$1 + 8) = 64;
	*(integer*)((ubyte*)&tmp$456$1 + 12) = 1;
	*(integer*)((ubyte*)&tmp$456$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$456$1 + 20) = 64;
	*(integer*)((ubyte*)&tmp$456$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$456$1 + 28) = 63;
	ubyte* TEMP$1;
	TEMP$1 = (ubyte*)((ubyte*)TEMPBUFF$1 + 64);
	uinteger BITCHECK$1;
	BITCHECK$1 = 1u;
	uinteger BITPOS$1;
	BITPOS$1 = 0u;
	uinteger BITNUMB$1;
	BITNUMB$1 = (uinteger)NUMBER$1;
	if( (uinteger)IWIDTH$1 <= 32 ) goto label$1537;
	IWIDTH$1 = 32;
	label$1537:;
	{
		BITPOS$1 = 0u;
		uinteger TMP$458$2;
		TMP$458$2 = (uinteger)(IWIDTH$1 + -1);
		goto label$1538;
		label$1541:;
		{
			TEMP$1 = (ubyte*)(TEMP$1 + -1);
			*TEMP$1 = (ubyte)(integer)(48 + ((BITNUMB$1 & BITCHECK$1) >> BITPOS$1));
			BITCHECK$1 = BITCHECK$1 + BITCHECK$1;
		}
		label$1539:;
		BITPOS$1 = BITPOS$1 + 1;
		label$1538:;
		if( BITPOS$1 <= TMP$458$2 ) goto label$1541;
		label$1540:;
	}
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1543;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1545;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1546;
				label$1549:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1551;
					{
						struct FBSTRING* TMP$460$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$459$7;
							TMP$459$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$459$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$460$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$460$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$460$6 == (char*)0 ) goto label$1553;
						free( *(void**)TMP$460$6 );
						*(char**)TMP$460$6 = (char*)0;
						*(integer*)((ubyte*)TMP$460$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$460$6 + 8) = 0;
						label$1553:;
						if( ISTEMP$6 == 0 ) goto label$1555;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1555:;
						label$1554:;
					}
					label$1551:;
					label$1550:;
				}
				label$1547:;
				N$4 = N$4 + -1;
				label$1546:;
				if( N$4 >= 0 ) goto label$1549;
				label$1548:;
			}
		}
		label$1545:;
		label$1544:;
	}
	label$1543:;
	label$1542:;
	void* vr$2209 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2209;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$461$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$461$1 = (char*)0;
	*(integer*)((ubyte*)TMP$461$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$461$1 + 8) = -2147483648u;
	TMP$462$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$462$1 + 8) = (integer)(*(integer*)((ubyte*)TMP$462$1 + 8) | ((BITPOS$1 | 3) + 1));
	void* vr$2222 = malloc( (uinteger)(*(integer*)((ubyte*)TMP$462$1 + 8) & 2147483647) );
	*(char**)TMP$462$1 = (char*)vr$2222;
	*(integer*)((ubyte*)TMP$462$1 + 4) = (integer)BITPOS$1;
	memcpy( *(void**)TMP$462$1, (void*)TEMP$1, BITPOS$1 );
	*(ubyte*)(*(ubyte**)TMP$462$1 + *(integer*)((ubyte*)TMP$462$1 + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1535;
	label$1535:;
	return fb$result$1;
}

static        void* fb_BIN_i( integer NUMBER$1 )
{
	struct FBSTRING* TMP$467$1;
	struct FBSTRING* TMP$468$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1556:;
	ubyte TEMPBUFF$1[64];
	struct TMP$464 {
		ubyte* DATA;
		ubyte* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$464 tmp$463$1;
	*(ubyte**)&tmp$463$1 = (ubyte*)TEMPBUFF$1;
	*(ubyte**)((ubyte*)&tmp$463$1 + 4) = (ubyte*)TEMPBUFF$1;
	*(integer*)((ubyte*)&tmp$463$1 + 8) = 64;
	*(integer*)((ubyte*)&tmp$463$1 + 12) = 1;
	*(integer*)((ubyte*)&tmp$463$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$463$1 + 20) = 64;
	*(integer*)((ubyte*)&tmp$463$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$463$1 + 28) = 63;
	ubyte* TEMP$1;
	TEMP$1 = (ubyte*)((ubyte*)TEMPBUFF$1 + 64);
	uinteger BITCHECK$1;
	BITCHECK$1 = 1u;
	uinteger BITPOS$1;
	BITPOS$1 = 0u;
	uinteger BITNUMB$1;
	BITNUMB$1 = (uinteger)NUMBER$1;
	label$1558:;
	{
		TEMP$1 = (ubyte*)(TEMP$1 + -1);
		*TEMP$1 = (ubyte)(integer)(48 + ((BITNUMB$1 & BITCHECK$1) >> BITPOS$1));
		BITCHECK$1 = BITCHECK$1 + BITCHECK$1;
		BITPOS$1 = BITPOS$1 + 1;
	}
	label$1560:;
	if( (-(BITNUMB$1 != 0) & -(BITCHECK$1 <= BITNUMB$1)) != 0 ) goto label$1558;
	label$1559:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1562;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1564;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1565;
				label$1568:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1570;
					{
						struct FBSTRING* TMP$466$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$465$7;
							TMP$465$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$465$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$466$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$466$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$466$6 == (char*)0 ) goto label$1572;
						free( *(void**)TMP$466$6 );
						*(char**)TMP$466$6 = (char*)0;
						*(integer*)((ubyte*)TMP$466$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$466$6 + 8) = 0;
						label$1572:;
						if( ISTEMP$6 == 0 ) goto label$1574;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1574:;
						label$1573:;
					}
					label$1570:;
					label$1569:;
				}
				label$1566:;
				N$4 = N$4 + -1;
				label$1565:;
				if( N$4 >= 0 ) goto label$1568;
				label$1567:;
			}
		}
		label$1564:;
		label$1563:;
	}
	label$1562:;
	label$1561:;
	void* vr$2264 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2264;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$467$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$467$1 = (char*)0;
	*(integer*)((ubyte*)TMP$467$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$467$1 + 8) = -2147483648u;
	TMP$468$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$468$1 + 8) = (integer)(*(integer*)((ubyte*)TMP$468$1 + 8) | ((BITPOS$1 | 3) + 1));
	void* vr$2277 = malloc( (uinteger)(*(integer*)((ubyte*)TMP$468$1 + 8) & 2147483647) );
	*(char**)TMP$468$1 = (char*)vr$2277;
	*(integer*)((ubyte*)TMP$468$1 + 4) = (integer)BITPOS$1;
	memcpy( *(void**)TMP$468$1, (void*)TEMP$1, BITPOS$1 );
	*(ubyte*)(*(ubyte**)TMP$468$1 + *(integer*)((ubyte*)TMP$468$1 + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1557;
	label$1557:;
	return fb$result$1;
}

static inline void* fb_BINEx_i( integer NUMBER$1, integer IWIDTH$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1575:;
	void* vr$2286 = fb_BINEx_Proto( NUMBER$1, IWIDTH$1, 32 );              
	fb$result$1 = vr$2286;
	goto label$1576;
	label$1576:;
	return fb$result$1;
}

static inline void* fb_HEX_b( byte NUMBER$1 )
{
	struct FBSTRING* TMP$471$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1577:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1580;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1582;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1583;
				label$1586:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1588;
					{
						struct FBSTRING* TMP$470$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$469$7;
							TMP$469$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$469$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$470$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$470$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$470$6 == (char*)0 ) goto label$1590;
						free( *(void**)TMP$470$6 );
						*(char**)TMP$470$6 = (char*)0;
						*(integer*)((ubyte*)TMP$470$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$470$6 + 8) = 0;
						label$1590:;
						if( ISTEMP$6 == 0 ) goto label$1592;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1592:;
						label$1591:;
					}
					label$1588:;
					label$1587:;
				}
				label$1584:;
				N$4 = N$4 + -1;
				label$1583:;
				if( N$4 >= 0 ) goto label$1586;
				label$1585:;
			}
		}
		label$1582:;
		label$1581:;
	}
	label$1580:;
	label$1579:;
	void* vr$2307 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2307;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$471$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$471$1 = (char*)0;
	*(integer*)((ubyte*)TMP$471$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$471$1 + 8) = -2147483648u;
	void* vr$2313 = malloc( 4u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2313;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 4;
	integer vr$2320 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%X", (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2320;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1578;
	label$1578:;
	return fb$result$1;
}

static inline void* fb_HEXEx_b( byte NUMBER$1, integer CHARWIDTH$1 )
{
	struct FBSTRING* TMP$475$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1593:;
	if( CHARWIDTH$1 <= 15 ) goto label$1596;
	CHARWIDTH$1 = 15;
	label$1596:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1598;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1600;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1601;
				label$1604:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1606;
					{
						struct FBSTRING* TMP$474$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$473$7;
							TMP$473$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$473$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$474$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$474$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$474$6 == (char*)0 ) goto label$1608;
						free( *(void**)TMP$474$6 );
						*(char**)TMP$474$6 = (char*)0;
						*(integer*)((ubyte*)TMP$474$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$474$6 + 8) = 0;
						label$1608:;
						if( ISTEMP$6 == 0 ) goto label$1610;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1610:;
						label$1609:;
					}
					label$1606:;
					label$1605:;
				}
				label$1602:;
				N$4 = N$4 + -1;
				label$1601:;
				if( N$4 >= 0 ) goto label$1604;
				label$1603:;
			}
		}
		label$1600:;
		label$1599:;
	}
	label$1598:;
	label$1597:;
	void* vr$2342 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2342;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$475$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$475$1 = (char*)0;
	*(integer*)((ubyte*)TMP$475$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$475$1 + 8) = -2147483648u;
	void* vr$2348 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2348;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$2355 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%0*X", CHARWIDTH$1, (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2355;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1594;
	label$1594:;
	return fb$result$1;
}

static inline void* fb_HEX_s( short NUMBER$1 )
{
	struct FBSTRING* TMP$479$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1611:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1614;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1616;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1617;
				label$1620:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1622;
					{
						struct FBSTRING* TMP$478$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$477$7;
							TMP$477$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$477$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$478$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$478$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$478$6 == (char*)0 ) goto label$1624;
						free( *(void**)TMP$478$6 );
						*(char**)TMP$478$6 = (char*)0;
						*(integer*)((ubyte*)TMP$478$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$478$6 + 8) = 0;
						label$1624:;
						if( ISTEMP$6 == 0 ) goto label$1626;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1626:;
						label$1625:;
					}
					label$1622:;
					label$1621:;
				}
				label$1618:;
				N$4 = N$4 + -1;
				label$1617:;
				if( N$4 >= 0 ) goto label$1620;
				label$1619:;
			}
		}
		label$1616:;
		label$1615:;
	}
	label$1614:;
	label$1613:;
	void* vr$2377 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2377;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$479$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$479$1 = (char*)0;
	*(integer*)((ubyte*)TMP$479$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$479$1 + 8) = -2147483648u;
	void* vr$2383 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2383;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$2390 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%X", (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2390;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1612;
	label$1612:;
	return fb$result$1;
}

static inline void* fb_HEXEx_s( short NUMBER$1, integer CHARWIDTH$1 )
{
	struct FBSTRING* TMP$482$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1627:;
	if( CHARWIDTH$1 <= 15 ) goto label$1630;
	CHARWIDTH$1 = 15;
	label$1630:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1632;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1634;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1635;
				label$1638:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1640;
					{
						struct FBSTRING* TMP$481$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$480$7;
							TMP$480$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$480$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$481$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$481$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$481$6 == (char*)0 ) goto label$1642;
						free( *(void**)TMP$481$6 );
						*(char**)TMP$481$6 = (char*)0;
						*(integer*)((ubyte*)TMP$481$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$481$6 + 8) = 0;
						label$1642:;
						if( ISTEMP$6 == 0 ) goto label$1644;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1644:;
						label$1643:;
					}
					label$1640:;
					label$1639:;
				}
				label$1636:;
				N$4 = N$4 + -1;
				label$1635:;
				if( N$4 >= 0 ) goto label$1638;
				label$1637:;
			}
		}
		label$1634:;
		label$1633:;
	}
	label$1632:;
	label$1631:;
	void* vr$2412 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2412;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$482$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$482$1 = (char*)0;
	*(integer*)((ubyte*)TMP$482$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$482$1 + 8) = -2147483648u;
	void* vr$2418 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2418;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$2425 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%0*X", CHARWIDTH$1, (integer)NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2425;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1628;
	label$1628:;
	return fb$result$1;
}

static inline void* fb_HEX_i( integer NUMBER$1 )
{
	struct FBSTRING* TMP$485$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1645:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1648;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1650;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1651;
				label$1654:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1656;
					{
						struct FBSTRING* TMP$484$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$483$7;
							TMP$483$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$483$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$484$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$484$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$484$6 == (char*)0 ) goto label$1658;
						free( *(void**)TMP$484$6 );
						*(char**)TMP$484$6 = (char*)0;
						*(integer*)((ubyte*)TMP$484$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$484$6 + 8) = 0;
						label$1658:;
						if( ISTEMP$6 == 0 ) goto label$1660;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1660:;
						label$1659:;
					}
					label$1656:;
					label$1655:;
				}
				label$1652:;
				N$4 = N$4 + -1;
				label$1651:;
				if( N$4 >= 0 ) goto label$1654;
				label$1653:;
			}
		}
		label$1650:;
		label$1649:;
	}
	label$1648:;
	label$1647:;
	void* vr$2447 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2447;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$485$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$485$1 = (char*)0;
	*(integer*)((ubyte*)TMP$485$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$485$1 + 8) = -2147483648u;
	void* vr$2453 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2453;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$2459 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%X", NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2459;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1646;
	label$1646:;
	return fb$result$1;
}

static inline void* fb_HEXEx_i( integer NUMBER$1, integer CHARWIDTH$1 )
{
	struct FBSTRING* TMP$488$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1661:;
	if( CHARWIDTH$1 <= 15 ) goto label$1664;
	CHARWIDTH$1 = 15;
	label$1664:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1666;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1668;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1669;
				label$1672:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1674;
					{
						struct FBSTRING* TMP$487$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$486$7;
							TMP$486$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$486$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$487$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$487$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$487$6 == (char*)0 ) goto label$1676;
						free( *(void**)TMP$487$6 );
						*(char**)TMP$487$6 = (char*)0;
						*(integer*)((ubyte*)TMP$487$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$487$6 + 8) = 0;
						label$1676:;
						if( ISTEMP$6 == 0 ) goto label$1678;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1678:;
						label$1677:;
					}
					label$1674:;
					label$1673:;
				}
				label$1670:;
				N$4 = N$4 + -1;
				label$1669:;
				if( N$4 >= 0 ) goto label$1672;
				label$1671:;
			}
		}
		label$1668:;
		label$1667:;
	}
	label$1666:;
	label$1665:;
	void* vr$2481 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2481;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$488$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$488$1 = (char*)0;
	*(integer*)((ubyte*)TMP$488$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$488$1 + 8) = -2147483648u;
	void* vr$2487 = malloc( 16u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2487;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 16;
	integer vr$2493 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%0*X", CHARWIDTH$1, NUMBER$1 );
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2493;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1662;
	label$1662:;
	return fb$result$1;
}

static inline void* fb_HEX_l( longint NUMBER$1 )
{
	struct FBSTRING* TMP$491$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1679:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1682;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1684;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1685;
				label$1688:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1690;
					{
						struct FBSTRING* TMP$490$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$489$7;
							TMP$489$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$489$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$490$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$490$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$490$6 == (char*)0 ) goto label$1692;
						free( *(void**)TMP$490$6 );
						*(char**)TMP$490$6 = (char*)0;
						*(integer*)((ubyte*)TMP$490$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$490$6 + 8) = 0;
						label$1692:;
						if( ISTEMP$6 == 0 ) goto label$1694;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1694:;
						label$1693:;
					}
					label$1690:;
					label$1689:;
				}
				label$1686:;
				N$4 = N$4 + -1;
				label$1685:;
				if( N$4 >= 0 ) goto label$1688;
				label$1687:;
			}
		}
		label$1684:;
		label$1683:;
	}
	label$1682:;
	label$1681:;
	void* vr$2515 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2515;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$491$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$491$1 = (char*)0;
	*(integer*)((ubyte*)TMP$491$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$491$1 + 8) = -2147483648u;
	void* vr$2521 = malloc( 20u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2521;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 20;
	if( (ulongint)NUMBER$1 < 4294967296ll ) goto label$1696;
	{
		integer vr$2530 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%X%08X", (uinteger)((ulongint)NUMBER$1 >> 32), (uinteger)NUMBER$1 );
		*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2530;
	}
	goto label$1695;
	label$1696:;
	{
		integer vr$2534 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%X", (uinteger)NUMBER$1 );
		*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2534;
	}
	label$1695:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1680;
	label$1680:;
	return fb$result$1;
}

static inline void* fb_HEXEx_l( longint NUMBER$1, integer CHARWIDTH$1 )
{
	struct FBSTRING* TMP$495$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1697:;
	if( CHARWIDTH$1 <= 19 ) goto label$1700;
	CHARWIDTH$1 = 19;
	label$1700:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1702;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$1704;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1705;
				label$1708:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1710;
					{
						struct FBSTRING* TMP$494$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$493$7;
							TMP$493$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$493$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$494$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$494$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$494$6 == (char*)0 ) goto label$1712;
						free( *(void**)TMP$494$6 );
						*(char**)TMP$494$6 = (char*)0;
						*(integer*)((ubyte*)TMP$494$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$494$6 + 8) = 0;
						label$1712:;
						if( ISTEMP$6 == 0 ) goto label$1714;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$1714:;
						label$1713:;
					}
					label$1710:;
					label$1709:;
				}
				label$1706:;
				N$4 = N$4 + -1;
				label$1705:;
				if( N$4 >= 0 ) goto label$1708;
				label$1707:;
			}
		}
		label$1704:;
		label$1703:;
	}
	label$1702:;
	label$1701:;
	void* vr$2556 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$2556;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$495$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$495$1 = (char*)0;
	*(integer*)((ubyte*)TMP$495$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$495$1 + 8) = -2147483648u;
	void* vr$2562 = malloc( 20u );
	*(char**)_ZN2FB11TEMPSTRING$E = (char*)vr$2562;
	*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) = *(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 8) | 20;
	if( CHARWIDTH$1 <= 8 ) goto label$1716;
	{
		integer vr$2572 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%0*X%08X", CHARWIDTH$1 + -8, (uinteger)((ulongint)NUMBER$1 >> 32), (uinteger)NUMBER$1 );
		*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2572;
	}
	goto label$1715;
	label$1716:;
	{
		integer vr$2576 = sprintf( *(char**)_ZN2FB11TEMPSTRING$E, (char*)"%0*X", CHARWIDTH$1, (uinteger)NUMBER$1 );
		*(integer*)((ubyte*)_ZN2FB11TEMPSTRING$E + 4) = vr$2576;
	}
	label$1715:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$1698;
	label$1698:;
	return fb$result$1;
}

static inline void fb_MemSwap( void* TARGET$1, void* SOURCE$1, integer AMOUNT$1 )
{
	label$1717:;
	label$1719:;
	if( AMOUNT$1 == 0 ) goto label$1720;
	{
		ubyte TEMP$2;
		TEMP$2 = *(ubyte*)TARGET$1;
		*(ubyte*)TARGET$1 = *(ubyte*)SOURCE$1;
		*(ubyte*)SOURCE$1 = TEMP$2;
		TARGET$1 = (void*)((ubyte*)TARGET$1 + 1);
		SOURCE$1 = (void*)((ubyte*)SOURCE$1 + 1);
		AMOUNT$1 = AMOUNT$1 + -1;
	}
	goto label$1719;
	label$1720:;
	label$1718:;
}

static        void* fb_StrAssign( void* FBTARGETSTRING$1, integer ITARGETLEN$1, void* FBQUERYSTRING$1, integer IQUERYLEN$1, integer UNK0$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1721:;
	void* SOURCEDATA$1;
	SOURCEDATA$1 = FBQUERYSTRING$1;
	if( UNK0$1 == 0 ) goto label$1724;
	printf( (char*)"fb_strAssign unk0=%i\n", 1 );
	label$1724:;
	short ISFBSTRING$1;
	__builtin_memset( &ISFBSTRING$1, 0, 2 );
	if( IQUERYLEN$1 >= 0 ) goto label$1726;
	{
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1728;
		{
			struct FBSTRING* TMP$498$3;
			TMP$498$3 = (struct FBSTRING*)FBQUERYSTRING$1;
			IQUERYLEN$1 = *(integer*)((ubyte*)TMP$498$3 + 4) + 1;
			SOURCEDATA$1 = (void*)*(char**)TMP$498$3;
		}
		goto label$1727;
		label$1728:;
		{
			IQUERYLEN$1 = 1;
			SOURCEDATA$1 = (void*)0;
			if( FBTARGETSTRING$1 != 0 ) goto label$1730;
			fb$result$1 = (void*)0;
			goto label$1722;
			label$1730:;
		}
		label$1727:;
		ISFBSTRING$1 = (short)1;
	}
	goto label$1725;
	label$1726:;
	if( IQUERYLEN$1 != 0 ) goto label$1731;
	{
		uinteger vr$2591 = strlen( (char*)SOURCEDATA$1 );
		IQUERYLEN$1 = (integer)(vr$2591 + 1);
	}
	label$1731:;
	label$1725:;
	IQUERYLEN$1 = IQUERYLEN$1 + -1;
	if( ITARGETLEN$1 < 0 ) goto label$1733;
	{
		if( ITARGETLEN$1 <= 0 ) goto label$1735;
		{
			ITARGETLEN$1 = ITARGETLEN$1 + -1;
			if( IQUERYLEN$1 <= ITARGETLEN$1 ) goto label$1737;
			IQUERYLEN$1 = ITARGETLEN$1;
			label$1737:;
		}
		label$1735:;
		label$1734:;
		memcpy( FBTARGETSTRING$1, SOURCEDATA$1, (uinteger)IQUERYLEN$1 );
		*(ubyte*)((ubyte*)FBTARGETSTRING$1 + IQUERYLEN$1) = (ubyte)0;
	}
	goto label$1732;
	label$1733:;
	{
		if( *(integer*)((ubyte*)FBTARGETSTRING$1 + 8) != -1 ) goto label$1739;
		printf( (char*)"fb_StrAssign Realloc CONST string\n" );
		fb_Beep(  );
		fb_Sleep( -1 );
		label$1739:;
		void* vr$2599 = realloc( *(void**)FBTARGETSTRING$1, (uinteger)(IQUERYLEN$1 + 1) );
		*(char**)FBTARGETSTRING$1 = (char*)vr$2599;
		memcpy( *(void**)FBTARGETSTRING$1, SOURCEDATA$1, (uinteger)IQUERYLEN$1 );
		*(char*)((ubyte*)*(char**)FBTARGETSTRING$1 + IQUERYLEN$1) = (char)0;
		*(integer*)((ubyte*)FBTARGETSTRING$1 + 4) = IQUERYLEN$1;
		*(integer*)((ubyte*)FBTARGETSTRING$1 + 8) = (*(integer*)((ubyte*)FBTARGETSTRING$1 + 8) & -2147483648u) | (IQUERYLEN$1 + 1);
	}
	label$1732:;
	if( ISFBSTRING$1 == (short)0 ) goto label$1741;
	{
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1743;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1744;
				label$1747:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1749;
					{
						struct FBSTRING* TMP$501$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$500$7;
							TMP$500$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$500$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$501$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$501$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$501$6 == (char*)0 ) goto label$1751;
						free( *(void**)TMP$501$6 );
						*(char**)TMP$501$6 = (char*)0;
						*(integer*)((ubyte*)TMP$501$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$501$6 + 8) = 0;
						label$1751:;
						if( ISTEMP$6 == 0 ) goto label$1753;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$1753:;
						label$1752:;
					}
					label$1749:;
					label$1748:;
				}
				label$1745:;
				N$4 = N$4 + -1;
				label$1744:;
				if( N$4 >= 0 ) goto label$1747;
				label$1746:;
			}
		}
		label$1743:;
		label$1742:;
	}
	label$1741:;
	label$1740:;
	fb$result$1 = FBTARGETSTRING$1;
	goto label$1722;
	label$1722:;
	return fb$result$1;
}

static inline void* fb_StrInit( void* FBTARGETSTRING$1, integer ITARGETLEN$1, void* FBQUERYSTRING$1, integer IQUERYLEN$1, integer UNK0$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1754:;
	if( ITARGETLEN$1 >= 0 ) goto label$1757;
	memset( FBTARGETSTRING$1, 0, 12u );
	label$1757:;
	void* vr$2630 = fb_StrAssign( FBTARGETSTRING$1, ITARGETLEN$1, FBQUERYSTRING$1, IQUERYLEN$1, UNK0$1 );              
	fb$result$1 = vr$2630;
	goto label$1755;
	label$1755:;
	return fb$result$1;
}

static        void* fb_StrConcatAssign( void* FBTARGETSTRING$1, integer ITARGETLEN$1, void* FBQUERYSTRING$1, integer IQUERYLEN$1, integer UNK0$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1758:;
	void* SOURCEDATA$1;
	SOURCEDATA$1 = FBQUERYSTRING$1;
	short ISFBSTRING$1;
	__builtin_memset( &ISFBSTRING$1, 0, 2 );
	if( IQUERYLEN$1 >= 0 ) goto label$1761;
	{
		struct FBSTRING* TMP$502$2;
		TMP$502$2 = (struct FBSTRING*)FBQUERYSTRING$1;
		IQUERYLEN$1 = *(integer*)((ubyte*)TMP$502$2 + 4);
		SOURCEDATA$1 = (void*)*(char**)TMP$502$2;
		ISFBSTRING$1 = (short)1;
	}
	goto label$1760;
	label$1761:;
	if( IQUERYLEN$1 != 0 ) goto label$1762;
	{
		uinteger vr$2636 = strlen( (char*)SOURCEDATA$1 );
		IQUERYLEN$1 = (integer)vr$2636;
	}
	goto label$1760;
	label$1762:;
	{
		IQUERYLEN$1 = IQUERYLEN$1 + -1;
	}
	label$1760:;
	if( ITARGETLEN$1 < 0 ) goto label$1764;
	{
		string* vr$2638 = fb_StrAllocTempDescZEx( (char*)"concatassign with zstring ", 26 );
		fb_PrintString( 0, vr$2638, 0 );
		fb_PrintInt( 0, ITARGETLEN$1, 1 );
		integer TLEN$2;
		uinteger vr$2639 = strlen( (char*)FBTARGETSTRING$1 );
		TLEN$2 = (integer)vr$2639;
		if( ITARGETLEN$1 <= 0 ) goto label$1766;
		{
			ITARGETLEN$1 = ITARGETLEN$1 + -1;
		}
		goto label$1765;
		label$1766:;
		{
			ITARGETLEN$1 = TLEN$2;
		}
		label$1765:;
		if( (TLEN$2 + IQUERYLEN$1) <= ITARGETLEN$1 ) goto label$1768;
		IQUERYLEN$1 = ITARGETLEN$1 - TLEN$2;
		label$1768:;
		memcpy( (void*)((ubyte*)FBTARGETSTRING$1 + TLEN$2), SOURCEDATA$1, (uinteger)IQUERYLEN$1 );
		*(ubyte*)((ubyte*)FBTARGETSTRING$1 + (IQUERYLEN$1 + TLEN$2)) = (ubyte)0;
	}
	goto label$1763;
	label$1764:;
	{
		if( *(integer*)((ubyte*)FBTARGETSTRING$1 + 8) != -1 ) goto label$1770;
		printf( (char*)"fb_StrConcatAssign Re CONST str\n" );
		fb_Beep(  );
		fb_Sleep( -1 );
		label$1770:;
		*(integer*)((ubyte*)FBTARGETSTRING$1 + 8) = (*(integer*)((ubyte*)FBTARGETSTRING$1 + 8) & -2147483648u) | ((*(integer*)((ubyte*)FBTARGETSTRING$1 + 4) + IQUERYLEN$1) + 1);
		void* vr$2657 = realloc( *(void**)FBTARGETSTRING$1, (uinteger)(*(integer*)((ubyte*)FBTARGETSTRING$1 + 8) & 2147483647) );
		*(char**)FBTARGETSTRING$1 = (char*)vr$2657;
		memcpy( (void*)((ubyte*)*(void**)FBTARGETSTRING$1 + *(integer*)((ubyte*)FBTARGETSTRING$1 + 4)), SOURCEDATA$1, (uinteger)IQUERYLEN$1 );
		*(char*)((ubyte*)*(char**)FBTARGETSTRING$1 + (*(integer*)((ubyte*)FBTARGETSTRING$1 + 4) + IQUERYLEN$1)) = (char)0;
		*(integer*)((ubyte*)FBTARGETSTRING$1 + 4) = *(integer*)((ubyte*)FBTARGETSTRING$1 + 4) + IQUERYLEN$1;
	}
	label$1763:;
	if( ISFBSTRING$1 == (short)0 ) goto label$1772;
	{
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1774;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1775;
				label$1778:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1780;
					{
						struct FBSTRING* TMP$506$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$505$7;
							TMP$505$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$505$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$506$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$506$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$506$6 == (char*)0 ) goto label$1782;
						free( *(void**)TMP$506$6 );
						*(char**)TMP$506$6 = (char*)0;
						*(integer*)((ubyte*)TMP$506$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$506$6 + 8) = 0;
						label$1782:;
						if( ISTEMP$6 == 0 ) goto label$1784;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$1784:;
						label$1783:;
					}
					label$1780:;
					label$1779:;
				}
				label$1776:;
				N$4 = N$4 + -1;
				label$1775:;
				if( N$4 >= 0 ) goto label$1778;
				label$1777:;
			}
		}
		label$1774:;
		label$1773:;
	}
	label$1772:;
	label$1771:;
	fb$result$1 = FBTARGETSTRING$1;
	goto label$1759;
	label$1759:;
	return fb$result$1;
}

static        void* fb_StrConcat( void* TEMPFBS$1, void* SRCA$1, integer SRCASZ$1, void* SRCB$1, integer SRCBSZ$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1785:;
	void* DEALLOCA$1;
	DEALLOCA$1 = SRCA$1;
	void* DEALLOCB$1;
	DEALLOCB$1 = SRCB$1;
	byte ISFBSTRINGA$1;
	__builtin_memset( &ISFBSTRINGA$1, 0, 1 );
	byte ISFBSTRINGB$1;
	__builtin_memset( &ISFBSTRINGB$1, 0, 1 );
	if( SRCASZ$1 < 0 ) goto label$1788;
	{
		uinteger vr$2691 = strlen( (char*)SRCA$1 );
		SRCASZ$1 = (integer)vr$2691;
	}
	goto label$1787;
	label$1788:;
	{
		SRCASZ$1 = *(integer*)((ubyte*)SRCA$1 + 4);
		SRCA$1 = (void*)*(char**)SRCA$1;
		ISFBSTRINGA$1 = (byte)1;
	}
	label$1787:;
	if( SRCBSZ$1 < 0 ) goto label$1790;
	{
		uinteger vr$2694 = strlen( (char*)SRCB$1 );
		SRCBSZ$1 = (integer)vr$2694;
	}
	goto label$1789;
	label$1790:;
	{
		SRCBSZ$1 = *(integer*)((ubyte*)SRCB$1 + 4);
		SRCB$1 = (void*)*(char**)SRCB$1;
		ISFBSTRINGB$1 = (byte)1;
	}
	label$1789:;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)TEMPFBS$1;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	*(integer*)((ubyte*)TEMPFBS$1 + 4) = SRCASZ$1 + SRCBSZ$1;
	if( *(integer*)((ubyte*)TEMPFBS$1 + 8) != -1 ) goto label$1792;
	printf( (char*)"fb_StrConcat Realloc CONST string\n" );
	fb_Beep(  );
	fb_Sleep( -1 );
	label$1792:;
	*(integer*)((ubyte*)TEMPFBS$1 + 8) = *(integer*)((ubyte*)TEMPFBS$1 + 4) + 1;
	void* vr$2708 = realloc( *(void**)TEMPFBS$1, (uinteger)(*(integer*)((ubyte*)TEMPFBS$1 + 8) & 2147483647) );
	*(char**)TEMPFBS$1 = (char*)vr$2708;
	memcpy( *(void**)TEMPFBS$1, SRCA$1, (uinteger)SRCASZ$1 );
	memcpy( (void*)((ubyte*)*(char**)TEMPFBS$1 + SRCASZ$1), SRCB$1, (uinteger)SRCBSZ$1 );
	*(ubyte*)(*(ubyte**)TEMPFBS$1 + *(integer*)((ubyte*)TEMPFBS$1 + 4)) = (ubyte)0;
	if( (integer)ISFBSTRINGA$1 == 0 ) goto label$1794;
	{
		if( DEALLOCA$1 == (void*)0 ) goto label$1796;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1797;
				label$1800:;
				{
					if( DEALLOCA$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1802;
					{
						struct FBSTRING* TMP$509$6;
						void* PTEMP$6;
						PTEMP$6 = DEALLOCA$1;
						{
							void* TMP$508$7;
							TMP$508$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$508$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$509$6 = (struct FBSTRING*)DEALLOCA$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$509$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$509$6 == (char*)0 ) goto label$1804;
						free( *(void**)TMP$509$6 );
						*(char**)TMP$509$6 = (char*)0;
						*(integer*)((ubyte*)TMP$509$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$509$6 + 8) = 0;
						label$1804:;
						if( ISTEMP$6 == 0 ) goto label$1806;
						{
							free( DEALLOCA$1 );
							DEALLOCA$1 = (void*)0;
						}
						label$1806:;
						label$1805:;
					}
					label$1802:;
					label$1801:;
				}
				label$1798:;
				N$4 = N$4 + -1;
				label$1797:;
				if( N$4 >= 0 ) goto label$1800;
				label$1799:;
			}
		}
		label$1796:;
		label$1795:;
	}
	label$1794:;
	label$1793:;
	if( (integer)ISFBSTRINGB$1 == 0 ) goto label$1808;
	{
		if( DEALLOCB$1 == (void*)0 ) goto label$1810;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1811;
				label$1814:;
				{
					if( DEALLOCB$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1816;
					{
						struct FBSTRING* TMP$511$6;
						void* PTEMP$6;
						PTEMP$6 = DEALLOCB$1;
						{
							void* TMP$510$7;
							TMP$510$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$510$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$511$6 = (struct FBSTRING*)DEALLOCB$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$511$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$511$6 == (char*)0 ) goto label$1818;
						free( *(void**)TMP$511$6 );
						*(char**)TMP$511$6 = (char*)0;
						*(integer*)((ubyte*)TMP$511$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$511$6 + 8) = 0;
						label$1818:;
						if( ISTEMP$6 == 0 ) goto label$1820;
						{
							free( DEALLOCB$1 );
							DEALLOCB$1 = (void*)0;
						}
						label$1820:;
						label$1819:;
					}
					label$1816:;
					label$1815:;
				}
				label$1812:;
				N$4 = N$4 + -1;
				label$1811:;
				if( N$4 >= 0 ) goto label$1814;
				label$1813:;
			}
		}
		label$1810:;
		label$1809:;
	}
	label$1808:;
	label$1807:;
	fb$result$1 = TEMPFBS$1;
	goto label$1786;
	label$1786:;
	return fb$result$1;
}

static        void fb_StrDelete( void* STRINGTODELETE$1 )
{
	struct FBSTRING* TMP$512$1;
	label$1821:;
	if( STRINGTODELETE$1 != 0 ) goto label$1824;
	goto label$1822;
	label$1824:;
	TMP$512$1 = (struct FBSTRING*)STRINGTODELETE$1;
	if( *(integer*)((ubyte*)TMP$512$1 + 8) != -1 ) goto label$1826;
	printf( (char*)"fb_StrDelete CONST string\n" );
	fb_Beep(  );
	fb_Sleep( -1 );
	label$1826:;
	if( (*(integer*)((ubyte*)TMP$512$1 + 8) & -2147483648u) == 0 ) goto label$1828;
	{
		if( STRINGTODELETE$1 == (void*)0 ) goto label$1830;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1831;
				label$1834:;
				{
					if( STRINGTODELETE$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1836;
					{
						struct FBSTRING* TMP$515$6;
						void* PTEMP$6;
						PTEMP$6 = STRINGTODELETE$1;
						{
							void* TMP$514$7;
							TMP$514$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$514$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$515$6 = (struct FBSTRING*)STRINGTODELETE$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$515$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$515$6 == (char*)0 ) goto label$1838;
						free( *(void**)TMP$515$6 );
						*(char**)TMP$515$6 = (char*)0;
						*(integer*)((ubyte*)TMP$515$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$515$6 + 8) = 0;
						label$1838:;
						if( ISTEMP$6 == 0 ) goto label$1840;
						{
							free( STRINGTODELETE$1 );
							STRINGTODELETE$1 = (void*)0;
						}
						label$1840:;
						label$1839:;
					}
					label$1836:;
					label$1835:;
				}
				label$1832:;
				N$4 = N$4 + -1;
				label$1831:;
				if( N$4 >= 0 ) goto label$1834;
				label$1833:;
			}
		}
		label$1830:;
		label$1829:;
	}
	goto label$1827;
	label$1828:;
	{
		if( *(char**)TMP$512$1 == (char*)0 ) goto label$1842;
		free( *(void**)TMP$512$1 );
		label$1842:;
		*(char**)TMP$512$1 = (char*)0;
		*(integer*)((ubyte*)TMP$512$1 + 4) = 0;
		*(integer*)((ubyte*)TMP$512$1 + 8) = 0;
	}
	label$1827:;
	label$1822:;
}

static        integer fb_StrCompare( void* FBSTRINGA$1, integer STRINGSIZEA$1, void* FBSTRINGB$1, integer STRINGSIZEB$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1843:;
	void* DEALLOCA$1;
	DEALLOCA$1 = FBSTRINGA$1;
	void* DEALLOCB$1;
	DEALLOCB$1 = FBSTRINGB$1;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	byte ISFBSTRINGA$1;
	__builtin_memset( &ISFBSTRINGA$1, 0, 1 );
	byte ISFBSTRINGB$1;
	__builtin_memset( &ISFBSTRINGB$1, 0, 1 );
	{
		if( STRINGSIZEA$1 != -1 ) goto label$1846;
		label$1847:;
		{
			STRINGSIZEA$1 = *(integer*)((ubyte*)FBSTRINGA$1 + 4);
			FBSTRINGA$1 = (void*)*(char**)FBSTRINGA$1;
			ISFBSTRINGA$1 = (byte)1;
		}
		goto label$1845;
		label$1846:;
		{
			uinteger vr$2787 = strlen( (char*)FBSTRINGA$1 );
			STRINGSIZEA$1 = (integer)vr$2787;
		}
		label$1848:;
		label$1845:;
	}
	{
		if( STRINGSIZEB$1 != -1 ) goto label$1850;
		label$1851:;
		{
			STRINGSIZEB$1 = *(integer*)((ubyte*)FBSTRINGB$1 + 4);
			FBSTRINGB$1 = (void*)*(char**)FBSTRINGB$1;
			ISFBSTRINGB$1 = (byte)1;
		}
		goto label$1849;
		label$1850:;
		{
			uinteger vr$2790 = strlen( (char*)FBSTRINGB$1 );
			STRINGSIZEB$1 = (integer)vr$2790;
		}
		label$1852:;
		label$1849:;
	}
	if( STRINGSIZEA$1 <= STRINGSIZEB$1 ) goto label$1854;
	{
		integer vr$2792 = memcmp( FBSTRINGA$1, FBSTRINGB$1, (uinteger)(STRINGSIZEB$1 & 2147483647) );
		IRESULT$1 = vr$2792;
	}
	goto label$1853;
	label$1854:;
	{
		integer vr$2794 = memcmp( FBSTRINGA$1, FBSTRINGB$1, (uinteger)(STRINGSIZEA$1 & 2147483647) );
		IRESULT$1 = vr$2794;
	}
	label$1853:;
	if( (integer)ISFBSTRINGA$1 == 0 ) goto label$1856;
	{
		if( DEALLOCA$1 == (void*)0 ) goto label$1858;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1859;
				label$1862:;
				{
					if( DEALLOCA$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1864;
					{
						struct FBSTRING* TMP$517$6;
						void* PTEMP$6;
						PTEMP$6 = DEALLOCA$1;
						{
							void* TMP$516$7;
							TMP$516$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$516$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$517$6 = (struct FBSTRING*)DEALLOCA$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$517$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$517$6 == (char*)0 ) goto label$1866;
						free( *(void**)TMP$517$6 );
						*(char**)TMP$517$6 = (char*)0;
						*(integer*)((ubyte*)TMP$517$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$517$6 + 8) = 0;
						label$1866:;
						if( ISTEMP$6 == 0 ) goto label$1868;
						{
							free( DEALLOCA$1 );
							DEALLOCA$1 = (void*)0;
						}
						label$1868:;
						label$1867:;
					}
					label$1864:;
					label$1863:;
				}
				label$1860:;
				N$4 = N$4 + -1;
				label$1859:;
				if( N$4 >= 0 ) goto label$1862;
				label$1861:;
			}
		}
		label$1858:;
		label$1857:;
	}
	label$1856:;
	label$1855:;
	if( (integer)ISFBSTRINGB$1 == 0 ) goto label$1870;
	{
		if( DEALLOCB$1 == (void*)0 ) goto label$1872;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1873;
				label$1876:;
				{
					if( DEALLOCB$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1878;
					{
						struct FBSTRING* TMP$519$6;
						void* PTEMP$6;
						PTEMP$6 = DEALLOCB$1;
						{
							void* TMP$518$7;
							TMP$518$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$518$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$519$6 = (struct FBSTRING*)DEALLOCB$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$519$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$519$6 == (char*)0 ) goto label$1880;
						free( *(void**)TMP$519$6 );
						*(char**)TMP$519$6 = (char*)0;
						*(integer*)((ubyte*)TMP$519$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$519$6 + 8) = 0;
						label$1880:;
						if( ISTEMP$6 == 0 ) goto label$1882;
						{
							free( DEALLOCB$1 );
							DEALLOCB$1 = (void*)0;
						}
						label$1882:;
						label$1881:;
					}
					label$1878:;
					label$1877:;
				}
				label$1874:;
				N$4 = N$4 + -1;
				label$1873:;
				if( N$4 >= 0 ) goto label$1876;
				label$1875:;
			}
		}
		label$1872:;
		label$1871:;
	}
	label$1870:;
	label$1869:;
	if( IRESULT$1 == 0 ) goto label$1884;
	fb$result$1 = IRESULT$1;
	goto label$1844;
	goto label$1883;
	label$1884:;
	integer vr$2834 = fb_SGNi( STRINGSIZEA$1 - STRINGSIZEB$1 );
	fb$result$1 = vr$2834;
	goto label$1844;
	label$1883:;
	label$1844:;
	return fb$result$1;
}

static        integer fb_StrLen( void* FBQUERYSTRING$1, integer STRINGSIZE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1885:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	if( STRINGSIZE$1 < 0 ) goto label$1888;
	{
		uinteger vr$2838 = strlen( (char*)FBQUERYSTRING$1 );
		IRESULT$1 = (integer)vr$2838;
	}
	goto label$1887;
	label$1888:;
	{
		IRESULT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1890;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1891;
				label$1894:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1896;
					{
						struct FBSTRING* TMP$521$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$520$7;
							TMP$520$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$520$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$521$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$521$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$521$6 == (char*)0 ) goto label$1898;
						free( *(void**)TMP$521$6 );
						*(char**)TMP$521$6 = (char*)0;
						*(integer*)((ubyte*)TMP$521$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$521$6 + 8) = 0;
						label$1898:;
						if( ISTEMP$6 == 0 ) goto label$1900;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$1900:;
						label$1899:;
					}
					label$1896:;
					label$1895:;
				}
				label$1892:;
				N$4 = N$4 + -1;
				label$1891:;
				if( N$4 >= 0 ) goto label$1894;
				label$1893:;
			}
		}
		label$1890:;
		label$1889:;
	}
	label$1887:;
	fb$result$1 = IRESULT$1;
	goto label$1886;
	label$1886:;
	return fb$result$1;
}

static        integer fb_StrInstr( integer ISTART$1, void* FBQUERYSTRING$1, void* FBMATCHSTRING$1 )
{
	integer TMP$522$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1901:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	if( (-(ISTART$1 < 1) | -(ISTART$1 > *(integer*)((ubyte*)FBQUERYSTRING$1 + 4))) != 0 ) goto label$1903;
	TMP$522$1 = -((-(*(integer*)((ubyte*)FBMATCHSTRING$1 + 4) > *(integer*)((ubyte*)FBQUERYSTRING$1 + 4)) | -(*(integer*)((ubyte*)FBMATCHSTRING$1 + 4) < 1)) != 0);
	goto label$1964;
	label$1903:;
	TMP$522$1 = -1;
	label$1964:;
	if( TMP$522$1 == 0 ) goto label$1905;
	{
		if( FBMATCHSTRING$1 == FBQUERYSTRING$1 ) goto label$1907;
		{
			if( FBMATCHSTRING$1 == (void*)0 ) goto label$1909;
			{
				{
					long N$5;
					N$5 = TEMPSTRINGCOUNT$ + -1;
					goto label$1910;
					label$1913:;
					{
						if( FBMATCHSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2)) ) goto label$1915;
						{
							struct FBSTRING* TMP$524$7;
							void* PTEMP$7;
							PTEMP$7 = FBMATCHSTRING$1;
							{
								void* TMP$523$8;
								TMP$523$8 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2));
								*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
								*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$523$8;
							}
							TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
							TMP$524$7 = (struct FBSTRING*)FBMATCHSTRING$1;
							integer ISTEMP$7;
							ISTEMP$7 = -((*(uinteger*)((ubyte*)TMP$524$7 + 8) & -1048576) == -2147483648u);
							if( *(char**)TMP$524$7 == (char*)0 ) goto label$1917;
							free( *(void**)TMP$524$7 );
							*(char**)TMP$524$7 = (char*)0;
							*(integer*)((ubyte*)TMP$524$7 + 4) = 0;
							*(integer*)((ubyte*)TMP$524$7 + 8) = 0;
							label$1917:;
							if( ISTEMP$7 == 0 ) goto label$1919;
							{
								free( FBMATCHSTRING$1 );
								FBMATCHSTRING$1 = (void*)0;
							}
							label$1919:;
							label$1918:;
						}
						label$1915:;
						label$1914:;
					}
					label$1911:;
					N$5 = N$5 + -1;
					label$1910:;
					if( N$5 >= 0 ) goto label$1913;
					label$1912:;
				}
			}
			label$1909:;
			label$1908:;
		}
		label$1907:;
		label$1906:;
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1921;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1922;
				label$1925:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1927;
					{
						struct FBSTRING* TMP$526$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$525$7;
							TMP$525$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$525$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$526$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$526$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$526$6 == (char*)0 ) goto label$1929;
						free( *(void**)TMP$526$6 );
						*(char**)TMP$526$6 = (char*)0;
						*(integer*)((ubyte*)TMP$526$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$526$6 + 8) = 0;
						label$1929:;
						if( ISTEMP$6 == 0 ) goto label$1931;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$1931:;
						label$1930:;
					}
					label$1927:;
					label$1926:;
				}
				label$1923:;
				N$4 = N$4 + -1;
				label$1922:;
				if( N$4 >= 0 ) goto label$1925;
				label$1924:;
			}
		}
		label$1921:;
		label$1920:;
		fb$result$1 = 0;
		goto label$1902;
	}
	label$1905:;
	label$1904:;
	void* RESULT$1;
	__builtin_memset( &RESULT$1, 0, 4 );
	void* START$1;
	START$1 = (void*)((ubyte*)((ubyte*)*(char**)FBQUERYSTRING$1 + ISTART$1) + -1);
	integer LENT$1;
	LENT$1 = (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - ISTART$1) + 1;
	ubyte CHAR$1;
	CHAR$1 = *(ubyte*)((ubyte*)START$1 + LENT$1);
	if( (uinteger)CHAR$1 == 0u ) goto label$1933;
	*(ubyte*)((ubyte*)START$1 + LENT$1) = (ubyte)0;
	label$1933:;
	if( *(integer*)((ubyte*)FBMATCHSTRING$1 + 4) != 1 ) goto label$1935;
	{
		void* vr$2922 = memchr( START$1, (integer)*(*(ubyte**)FBMATCHSTRING$1), (uinteger)LENT$1 );
		RESULT$1 = vr$2922;
	}
	goto label$1934;
	label$1935:;
	{
		char* vr$2924 = strstr( (char*)START$1, *(char**)FBMATCHSTRING$1 );
		RESULT$1 = (void*)vr$2924;
	}
	label$1934:;
	if( (uinteger)CHAR$1 == 0u ) goto label$1937;
	*(ubyte*)((ubyte*)START$1 + LENT$1) = CHAR$1;
	label$1937:;
	if( RESULT$1 == (void*)0 ) goto label$1939;
	IRESULT$1 = (integer)(((uinteger)RESULT$1 - *(uinteger*)FBQUERYSTRING$1) + 1);
	label$1939:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$1941;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1942;
			label$1945:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1947;
				{
					struct FBSTRING* TMP$528$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$527$6;
						TMP$527$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$527$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$528$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$528$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$528$5 == (char*)0 ) goto label$1949;
					free( *(void**)TMP$528$5 );
					*(char**)TMP$528$5 = (char*)0;
					*(integer*)((ubyte*)TMP$528$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$528$5 + 8) = 0;
					label$1949:;
					if( ISTEMP$5 == 0 ) goto label$1951;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$1951:;
					label$1950:;
				}
				label$1947:;
				label$1946:;
			}
			label$1943:;
			N$3 = N$3 + -1;
			label$1942:;
			if( N$3 >= 0 ) goto label$1945;
			label$1944:;
		}
	}
	label$1941:;
	label$1940:;
	if( FBMATCHSTRING$1 == (void*)0 ) goto label$1953;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$1954;
			label$1957:;
			{
				if( FBMATCHSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$1959;
				{
					struct FBSTRING* TMP$530$5;
					void* PTEMP$5;
					PTEMP$5 = FBMATCHSTRING$1;
					{
						void* TMP$529$6;
						TMP$529$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$529$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$530$5 = (struct FBSTRING*)FBMATCHSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$530$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$530$5 == (char*)0 ) goto label$1961;
					free( *(void**)TMP$530$5 );
					*(char**)TMP$530$5 = (char*)0;
					*(integer*)((ubyte*)TMP$530$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$530$5 + 8) = 0;
					label$1961:;
					if( ISTEMP$5 == 0 ) goto label$1963;
					{
						free( FBMATCHSTRING$1 );
						FBMATCHSTRING$1 = (void*)0;
					}
					label$1963:;
					label$1962:;
				}
				label$1959:;
				label$1958:;
			}
			label$1955:;
			N$3 = N$3 + -1;
			label$1954:;
			if( N$3 >= 0 ) goto label$1957;
			label$1956:;
		}
	}
	label$1953:;
	label$1952:;
	fb$result$1 = IRESULT$1;
	goto label$1902;
	label$1902:;
	return fb$result$1;
}

static        integer fb_StrInstrRev( void* FBQUERYSTRING$1, void* FBMATCHSTRING$1, integer ISTART$1 )
{
	integer TMP$531$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$1965:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	if( (-(ISTART$1 < 1) | -(ISTART$1 > *(integer*)((ubyte*)FBQUERYSTRING$1 + 4))) != 0 ) goto label$1967;
	TMP$531$1 = -((-(*(integer*)((ubyte*)FBMATCHSTRING$1 + 4) > *(integer*)((ubyte*)FBQUERYSTRING$1 + 4)) | -(*(integer*)((ubyte*)FBMATCHSTRING$1 + 4) < 1)) != 0);
	goto label$2028;
	label$1967:;
	TMP$531$1 = -1;
	label$2028:;
	if( TMP$531$1 == 0 ) goto label$1969;
	{
		if( FBMATCHSTRING$1 == FBQUERYSTRING$1 ) goto label$1971;
		{
			if( FBMATCHSTRING$1 == (void*)0 ) goto label$1973;
			{
				{
					long N$5;
					N$5 = TEMPSTRINGCOUNT$ + -1;
					goto label$1974;
					label$1977:;
					{
						if( FBMATCHSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2)) ) goto label$1979;
						{
							struct FBSTRING* TMP$533$7;
							void* PTEMP$7;
							PTEMP$7 = FBMATCHSTRING$1;
							{
								void* TMP$532$8;
								TMP$532$8 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2));
								*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$5 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
								*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$532$8;
							}
							TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
							TMP$533$7 = (struct FBSTRING*)FBMATCHSTRING$1;
							integer ISTEMP$7;
							ISTEMP$7 = -((*(uinteger*)((ubyte*)TMP$533$7 + 8) & -1048576) == -2147483648u);
							if( *(char**)TMP$533$7 == (char*)0 ) goto label$1981;
							free( *(void**)TMP$533$7 );
							*(char**)TMP$533$7 = (char*)0;
							*(integer*)((ubyte*)TMP$533$7 + 4) = 0;
							*(integer*)((ubyte*)TMP$533$7 + 8) = 0;
							label$1981:;
							if( ISTEMP$7 == 0 ) goto label$1983;
							{
								free( FBMATCHSTRING$1 );
								FBMATCHSTRING$1 = (void*)0;
							}
							label$1983:;
							label$1982:;
						}
						label$1979:;
						label$1978:;
					}
					label$1975:;
					N$5 = N$5 + -1;
					label$1974:;
					if( N$5 >= 0 ) goto label$1977;
					label$1976:;
				}
			}
			label$1973:;
			label$1972:;
		}
		label$1971:;
		label$1970:;
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$1985;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$1986;
				label$1989:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$1991;
					{
						struct FBSTRING* TMP$535$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$534$7;
							TMP$534$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$534$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$535$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$535$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$535$6 == (char*)0 ) goto label$1993;
						free( *(void**)TMP$535$6 );
						*(char**)TMP$535$6 = (char*)0;
						*(integer*)((ubyte*)TMP$535$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$535$6 + 8) = 0;
						label$1993:;
						if( ISTEMP$6 == 0 ) goto label$1995;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$1995:;
						label$1994:;
					}
					label$1991:;
					label$1990:;
				}
				label$1987:;
				N$4 = N$4 + -1;
				label$1986:;
				if( N$4 >= 0 ) goto label$1989;
				label$1988:;
			}
		}
		label$1985:;
		label$1984:;
		fb$result$1 = 0;
		goto label$1966;
	}
	label$1969:;
	label$1968:;
	void* RESULT$1;
	__builtin_memset( &RESULT$1, 0, 4 );
	void* START$1;
	START$1 = (void*)((ubyte*)((ubyte*)*(char**)FBQUERYSTRING$1 + ISTART$1) + -1);
	integer LENT$1;
	LENT$1 = (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - ISTART$1) + 1;
	ubyte CHAR$1;
	CHAR$1 = *(ubyte*)((ubyte*)START$1 + LENT$1);
	if( (uinteger)CHAR$1 == 0u ) goto label$1997;
	*(ubyte*)((ubyte*)START$1 + LENT$1) = (ubyte)0;
	label$1997:;
	if( *(integer*)((ubyte*)FBMATCHSTRING$1 + 4) != 1 ) goto label$1999;
	{
		char* vr$3030 = strrchr( (char*)START$1, (integer)*(*(ubyte**)FBMATCHSTRING$1) );
		RESULT$1 = (void*)vr$3030;
	}
	goto label$1998;
	label$1999:;
	{
		puts( (char*)"Not implmented!" );
		char* vr$3032 = strstr( (char*)START$1, *(char**)FBMATCHSTRING$1 );
		RESULT$1 = (void*)vr$3032;
	}
	label$1998:;
	if( (uinteger)CHAR$1 == 0u ) goto label$2001;
	*(ubyte*)((ubyte*)START$1 + LENT$1) = CHAR$1;
	label$2001:;
	if( RESULT$1 == (void*)0 ) goto label$2003;
	IRESULT$1 = (integer)(((uinteger)RESULT$1 - *(uinteger*)FBQUERYSTRING$1) + 1);
	label$2003:;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2005;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2006;
			label$2009:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2011;
				{
					struct FBSTRING* TMP$538$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$537$6;
						TMP$537$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$537$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$538$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$538$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$538$5 == (char*)0 ) goto label$2013;
					free( *(void**)TMP$538$5 );
					*(char**)TMP$538$5 = (char*)0;
					*(integer*)((ubyte*)TMP$538$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$538$5 + 8) = 0;
					label$2013:;
					if( ISTEMP$5 == 0 ) goto label$2015;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2015:;
					label$2014:;
				}
				label$2011:;
				label$2010:;
			}
			label$2007:;
			N$3 = N$3 + -1;
			label$2006:;
			if( N$3 >= 0 ) goto label$2009;
			label$2008:;
		}
	}
	label$2005:;
	label$2004:;
	if( FBMATCHSTRING$1 == (void*)0 ) goto label$2017;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2018;
			label$2021:;
			{
				if( FBMATCHSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2023;
				{
					struct FBSTRING* TMP$540$5;
					void* PTEMP$5;
					PTEMP$5 = FBMATCHSTRING$1;
					{
						void* TMP$539$6;
						TMP$539$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$539$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$540$5 = (struct FBSTRING*)FBMATCHSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$540$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$540$5 == (char*)0 ) goto label$2025;
					free( *(void**)TMP$540$5 );
					*(char**)TMP$540$5 = (char*)0;
					*(integer*)((ubyte*)TMP$540$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$540$5 + 8) = 0;
					label$2025:;
					if( ISTEMP$5 == 0 ) goto label$2027;
					{
						free( FBMATCHSTRING$1 );
						FBMATCHSTRING$1 = (void*)0;
					}
					label$2027:;
					label$2026:;
				}
				label$2023:;
				label$2022:;
			}
			label$2019:;
			N$3 = N$3 + -1;
			label$2018:;
			if( N$3 >= 0 ) goto label$2021;
			label$2020:;
		}
	}
	label$2017:;
	label$2016:;
	fb$result$1 = IRESULT$1;
	goto label$1966;
	label$1966:;
	return fb$result$1;
}

static        void* fb_LCASE( void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$543$1;
	struct FBSTRING* TMP$544$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2029:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2032;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2034;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2035;
				label$2038:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2040;
					{
						struct FBSTRING* TMP$542$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$541$7;
							TMP$541$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$541$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$542$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$542$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$542$6 == (char*)0 ) goto label$2042;
						free( *(void**)TMP$542$6 );
						*(char**)TMP$542$6 = (char*)0;
						*(integer*)((ubyte*)TMP$542$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$542$6 + 8) = 0;
						label$2042:;
						if( ISTEMP$6 == 0 ) goto label$2044;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2044:;
						label$2043:;
					}
					label$2040:;
					label$2039:;
				}
				label$2036:;
				N$4 = N$4 + -1;
				label$2035:;
				if( N$4 >= 0 ) goto label$2038;
				label$2037:;
			}
		}
		label$2034:;
		label$2033:;
	}
	label$2032:;
	label$2031:;
	void* vr$3094 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3094;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$543$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$543$1 = (char*)0;
	*(integer*)((ubyte*)TMP$543$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$543$1 + 8) = -2147483648u;
	TMP$544$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$544$1 + 4) = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
	*(integer*)((ubyte*)TMP$544$1 + 8) = *(integer*)((ubyte*)TMP$544$1 + 8) | (*(integer*)((ubyte*)TMP$544$1 + 4) + 1);
	void* vr$3110 = realloc( *(void**)TMP$544$1, (uinteger)(*(integer*)((ubyte*)TMP$544$1 + 8) & 2147483647) );
	*(char**)TMP$544$1 = (char*)vr$3110;
	byte* SRC$1;
	SRC$1 = (byte*)*(char**)FBQUERYSTRING$1;
	byte* DST$1;
	DST$1 = (byte*)*(char**)TMP$544$1;
	uinteger CHAR$1;
	__builtin_memset( &CHAR$1, 0, 4 );
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$545$2;
		TMP$545$2 = *(integer*)((ubyte*)TMP$544$1 + 4);
		goto label$2045;
		label$2048:;
		{
			CHAR$1 = (uinteger)*SRC$1;
			SRC$1 = (byte*)((ubyte*)SRC$1 + 1);
			if( (CHAR$1 + 4294967231u) > 25u ) goto label$2050;
			CHAR$1 = CHAR$1 + 32u;
			label$2050:;
			*DST$1 = (byte)CHAR$1;
			DST$1 = (byte*)((ubyte*)DST$1 + 1);
		}
		label$2046:;
		CNT$2 = CNT$2 + 1;
		label$2045:;
		if( CNT$2 <= TMP$545$2 ) goto label$2048;
		label$2047:;
	}
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2052;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2053;
			label$2056:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2058;
				{
					struct FBSTRING* TMP$547$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$546$6;
						TMP$546$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$546$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$547$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$547$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$547$5 == (char*)0 ) goto label$2060;
					free( *(void**)TMP$547$5 );
					*(char**)TMP$547$5 = (char*)0;
					*(integer*)((ubyte*)TMP$547$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$547$5 + 8) = 0;
					label$2060:;
					if( ISTEMP$5 == 0 ) goto label$2062;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2062:;
					label$2061:;
				}
				label$2058:;
				label$2057:;
			}
			label$2054:;
			N$3 = N$3 + -1;
			label$2053:;
			if( N$3 >= 0 ) goto label$2056;
			label$2055:;
		}
	}
	label$2052:;
	label$2051:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2030;
	label$2030:;
	return fb$result$1;
}

static        void* fb_UCASE( void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$550$1;
	struct FBSTRING* TMP$551$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2063:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2066;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2068;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2069;
				label$2072:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2074;
					{
						struct FBSTRING* TMP$549$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$548$7;
							TMP$548$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$548$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$549$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$549$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$549$6 == (char*)0 ) goto label$2076;
						free( *(void**)TMP$549$6 );
						*(char**)TMP$549$6 = (char*)0;
						*(integer*)((ubyte*)TMP$549$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$549$6 + 8) = 0;
						label$2076:;
						if( ISTEMP$6 == 0 ) goto label$2078;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2078:;
						label$2077:;
					}
					label$2074:;
					label$2073:;
				}
				label$2070:;
				N$4 = N$4 + -1;
				label$2069:;
				if( N$4 >= 0 ) goto label$2072;
				label$2071:;
			}
		}
		label$2068:;
		label$2067:;
	}
	label$2066:;
	label$2065:;
	void* vr$3163 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3163;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$550$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$550$1 = (char*)0;
	*(integer*)((ubyte*)TMP$550$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$550$1 + 8) = -2147483648u;
	TMP$551$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$551$1 + 4) = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
	*(integer*)((ubyte*)TMP$551$1 + 8) = *(integer*)((ubyte*)TMP$551$1 + 8) | (*(integer*)((ubyte*)TMP$551$1 + 4) + 1);
	void* vr$3179 = realloc( *(void**)TMP$551$1, (uinteger)(*(integer*)((ubyte*)TMP$551$1 + 8) & 2147483647) );
	*(char**)TMP$551$1 = (char*)vr$3179;
	byte* SRC$1;
	SRC$1 = (byte*)*(char**)FBQUERYSTRING$1;
	byte* DST$1;
	DST$1 = (byte*)*(char**)TMP$551$1;
	uinteger CHAR$1;
	__builtin_memset( &CHAR$1, 0, 4 );
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$552$2;
		TMP$552$2 = *(integer*)((ubyte*)TMP$551$1 + 4);
		goto label$2079;
		label$2082:;
		{
			CHAR$1 = (uinteger)*SRC$1;
			SRC$1 = (byte*)((ubyte*)SRC$1 + 1);
			if( (CHAR$1 + 4294967199u) > 25u ) goto label$2084;
			CHAR$1 = CHAR$1 + 4294967264u;
			label$2084:;
			*DST$1 = (byte)CHAR$1;
			DST$1 = (byte*)((ubyte*)DST$1 + 1);
		}
		label$2080:;
		CNT$2 = CNT$2 + 1;
		label$2079:;
		if( CNT$2 <= TMP$552$2 ) goto label$2082;
		label$2081:;
	}
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2086;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2087;
			label$2090:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2092;
				{
					struct FBSTRING* TMP$554$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$553$6;
						TMP$553$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$553$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$554$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$554$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$554$5 == (char*)0 ) goto label$2094;
					free( *(void**)TMP$554$5 );
					*(char**)TMP$554$5 = (char*)0;
					*(integer*)((ubyte*)TMP$554$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$554$5 + 8) = 0;
					label$2094:;
					if( ISTEMP$5 == 0 ) goto label$2096;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2096:;
					label$2095:;
				}
				label$2092:;
				label$2091:;
			}
			label$2088:;
			N$3 = N$3 + -1;
			label$2087:;
			if( N$3 >= 0 ) goto label$2090;
			label$2089:;
		}
	}
	label$2086:;
	label$2085:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2064;
	label$2064:;
	return fb$result$1;
}

static        void* fb_LEFT( void* FBQUERYSTRING$1, integer IAMOUNT$1 )
{
	struct FBSTRING* TMP$557$1;
	struct FBSTRING* TMP$558$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2097:;
	if( IAMOUNT$1 >= 0 ) goto label$2100;
	IAMOUNT$1 = 0;
	label$2100:;
	if( IAMOUNT$1 <= *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) ) goto label$2102;
	IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
	label$2102:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2104;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2106;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2107;
				label$2110:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2112;
					{
						struct FBSTRING* TMP$556$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$555$7;
							TMP$555$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$555$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$556$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$556$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$556$6 == (char*)0 ) goto label$2114;
						free( *(void**)TMP$556$6 );
						*(char**)TMP$556$6 = (char*)0;
						*(integer*)((ubyte*)TMP$556$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$556$6 + 8) = 0;
						label$2114:;
						if( ISTEMP$6 == 0 ) goto label$2116;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2116:;
						label$2115:;
					}
					label$2112:;
					label$2111:;
				}
				label$2108:;
				N$4 = N$4 + -1;
				label$2107:;
				if( N$4 >= 0 ) goto label$2110;
				label$2109:;
			}
		}
		label$2106:;
		label$2105:;
	}
	label$2104:;
	label$2103:;
	void* vr$3234 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3234;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$557$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$557$1 = (char*)0;
	*(integer*)((ubyte*)TMP$557$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$557$1 + 8) = -2147483648u;
	TMP$558$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$558$1 + 8) = *(integer*)((ubyte*)TMP$558$1 + 8) | (IAMOUNT$1 + 1);
	void* vr$3247 = realloc( *(void**)TMP$558$1, (uinteger)(*(integer*)((ubyte*)TMP$558$1 + 8) & 2147483647) );
	*(char**)TMP$558$1 = (char*)vr$3247;
	*(integer*)((ubyte*)TMP$558$1 + 4) = IAMOUNT$1;
	memcpy( *(void**)TMP$558$1, *(void**)FBQUERYSTRING$1, *(uinteger*)((ubyte*)TMP$558$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$558$1 + *(integer*)((ubyte*)TMP$558$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2118;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2119;
			label$2122:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2124;
				{
					struct FBSTRING* TMP$560$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$559$6;
						TMP$559$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$559$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$560$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$560$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$560$5 == (char*)0 ) goto label$2126;
					free( *(void**)TMP$560$5 );
					*(char**)TMP$560$5 = (char*)0;
					*(integer*)((ubyte*)TMP$560$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$560$5 + 8) = 0;
					label$2126:;
					if( ISTEMP$5 == 0 ) goto label$2128;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2128:;
					label$2127:;
				}
				label$2124:;
				label$2123:;
			}
			label$2120:;
			N$3 = N$3 + -1;
			label$2119:;
			if( N$3 >= 0 ) goto label$2122;
			label$2121:;
		}
	}
	label$2118:;
	label$2117:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2098;
	label$2098:;
	return fb$result$1;
}

static inline void* fb_LTRIM( void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$564$1;
	struct FBSTRING* TMP$565$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2129:;
	ubyte* TEMPDATA$1;
	TEMPDATA$1 = (ubyte*)*(void**)FBQUERYSTRING$1;
	integer IAMOUNT$1;
	__builtin_memset( &IAMOUNT$1, 0, 4 );
	{
		IAMOUNT$1 = 0;
		integer TMP$561$2;
		TMP$561$2 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$2131;
		label$2134:;
		{
			if( (uinteger)*(ubyte*)(TEMPDATA$1 + IAMOUNT$1) == 32u ) goto label$2136;
			goto label$2133;
			label$2136:;
		}
		label$2132:;
		IAMOUNT$1 = IAMOUNT$1 + 1;
		label$2131:;
		if( IAMOUNT$1 <= TMP$561$2 ) goto label$2134;
		label$2133:;
	}
	IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - IAMOUNT$1;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2138;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2140;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2141;
				label$2144:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2146;
					{
						struct FBSTRING* TMP$563$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$562$7;
							TMP$562$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$562$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$563$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$563$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$563$6 == (char*)0 ) goto label$2148;
						free( *(void**)TMP$563$6 );
						*(char**)TMP$563$6 = (char*)0;
						*(integer*)((ubyte*)TMP$563$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$563$6 + 8) = 0;
						label$2148:;
						if( ISTEMP$6 == 0 ) goto label$2150;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2150:;
						label$2149:;
					}
					label$2146:;
					label$2145:;
				}
				label$2142:;
				N$4 = N$4 + -1;
				label$2141:;
				if( N$4 >= 0 ) goto label$2144;
				label$2143:;
			}
		}
		label$2140:;
		label$2139:;
	}
	label$2138:;
	label$2137:;
	void* vr$3303 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3303;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$564$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$564$1 = (char*)0;
	*(integer*)((ubyte*)TMP$564$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$564$1 + 8) = -2147483648u;
	TMP$565$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$565$1 + 8) = *(integer*)((ubyte*)TMP$565$1 + 8) | (IAMOUNT$1 + 1);
	void* vr$3316 = realloc( *(void**)TMP$565$1, (uinteger)(*(integer*)((ubyte*)TMP$565$1 + 8) & 2147483647) );
	*(char**)TMP$565$1 = (char*)vr$3316;
	*(integer*)((ubyte*)TMP$565$1 + 4) = IAMOUNT$1;
	memcpy( *(void**)TMP$565$1, (void*)((ubyte*)*(char**)FBQUERYSTRING$1 + (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - *(integer*)((ubyte*)TMP$565$1 + 4))), *(uinteger*)((ubyte*)TMP$565$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$565$1 + *(integer*)((ubyte*)TMP$565$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2152;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2153;
			label$2156:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2158;
				{
					struct FBSTRING* TMP$567$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$566$6;
						TMP$566$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$566$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$567$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$567$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$567$5 == (char*)0 ) goto label$2160;
					free( *(void**)TMP$567$5 );
					*(char**)TMP$567$5 = (char*)0;
					*(integer*)((ubyte*)TMP$567$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$567$5 + 8) = 0;
					label$2160:;
					if( ISTEMP$5 == 0 ) goto label$2162;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2162:;
					label$2161:;
				}
				label$2158:;
				label$2157:;
			}
			label$2154:;
			N$3 = N$3 + -1;
			label$2153:;
			if( N$3 >= 0 ) goto label$2156;
			label$2155:;
		}
	}
	label$2152:;
	label$2151:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2130;
	label$2130:;
	return fb$result$1;
}

static        void* fb_RIGHT( void* FBQUERYSTRING$1, integer IAMOUNT$1 )
{
	struct FBSTRING* TMP$570$1;
	struct FBSTRING* TMP$571$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2163:;
	if( IAMOUNT$1 >= 0 ) goto label$2166;
	IAMOUNT$1 = 0;
	label$2166:;
	if( IAMOUNT$1 <= *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) ) goto label$2168;
	IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
	label$2168:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2170;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2172;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2173;
				label$2176:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2178;
					{
						struct FBSTRING* TMP$569$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$568$7;
							TMP$568$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$568$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$569$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$569$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$569$6 == (char*)0 ) goto label$2180;
						free( *(void**)TMP$569$6 );
						*(char**)TMP$569$6 = (char*)0;
						*(integer*)((ubyte*)TMP$569$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$569$6 + 8) = 0;
						label$2180:;
						if( ISTEMP$6 == 0 ) goto label$2182;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2182:;
						label$2181:;
					}
					label$2178:;
					label$2177:;
				}
				label$2174:;
				N$4 = N$4 + -1;
				label$2173:;
				if( N$4 >= 0 ) goto label$2176;
				label$2175:;
			}
		}
		label$2172:;
		label$2171:;
	}
	label$2170:;
	label$2169:;
	void* vr$3369 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3369;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$570$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$570$1 = (char*)0;
	*(integer*)((ubyte*)TMP$570$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$570$1 + 8) = -2147483648u;
	TMP$571$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$571$1 + 8) = *(integer*)((ubyte*)TMP$571$1 + 8) | (IAMOUNT$1 + 1);
	void* vr$3382 = realloc( *(void**)TMP$571$1, (uinteger)(*(integer*)((ubyte*)TMP$571$1 + 8) & 2147483647) );
	*(char**)TMP$571$1 = (char*)vr$3382;
	*(integer*)((ubyte*)TMP$571$1 + 4) = IAMOUNT$1;
	memcpy( *(void**)TMP$571$1, (void*)((ubyte*)*(char**)FBQUERYSTRING$1 + (*(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - *(integer*)((ubyte*)TMP$571$1 + 4))), *(uinteger*)((ubyte*)TMP$571$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$571$1 + *(integer*)((ubyte*)TMP$571$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2184;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2185;
			label$2188:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2190;
				{
					struct FBSTRING* TMP$573$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$572$6;
						TMP$572$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$572$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$573$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$573$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$573$5 == (char*)0 ) goto label$2192;
					free( *(void**)TMP$573$5 );
					*(char**)TMP$573$5 = (char*)0;
					*(integer*)((ubyte*)TMP$573$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$573$5 + 8) = 0;
					label$2192:;
					if( ISTEMP$5 == 0 ) goto label$2194;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2194:;
					label$2193:;
				}
				label$2190:;
				label$2189:;
			}
			label$2186:;
			N$3 = N$3 + -1;
			label$2185:;
			if( N$3 >= 0 ) goto label$2188;
			label$2187:;
		}
	}
	label$2184:;
	label$2183:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2164;
	label$2164:;
	return fb$result$1;
}

static inline void* fb_RTRIM( void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$576$1;
	struct FBSTRING* TMP$577$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2195:;
	ubyte* TEMPDATA$1;
	TEMPDATA$1 = (ubyte*)*(void**)FBQUERYSTRING$1;
	integer IAMOUNT$1;
	__builtin_memset( &IAMOUNT$1, 0, 4 );
	{
		IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$2197;
		label$2200:;
		{
			if( (uinteger)*(ubyte*)(TEMPDATA$1 + IAMOUNT$1) == 32u ) goto label$2202;
			goto label$2199;
			label$2202:;
		}
		label$2198:;
		IAMOUNT$1 = IAMOUNT$1 + -1;
		label$2197:;
		if( IAMOUNT$1 >= 0 ) goto label$2200;
		label$2199:;
	}
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2204;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2206;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2207;
				label$2210:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2212;
					{
						struct FBSTRING* TMP$575$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$574$7;
							TMP$574$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$574$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$575$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$575$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$575$6 == (char*)0 ) goto label$2214;
						free( *(void**)TMP$575$6 );
						*(char**)TMP$575$6 = (char*)0;
						*(integer*)((ubyte*)TMP$575$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$575$6 + 8) = 0;
						label$2214:;
						if( ISTEMP$6 == 0 ) goto label$2216;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2216:;
						label$2215:;
					}
					label$2212:;
					label$2211:;
				}
				label$2208:;
				N$4 = N$4 + -1;
				label$2207:;
				if( N$4 >= 0 ) goto label$2210;
				label$2209:;
			}
		}
		label$2206:;
		label$2205:;
	}
	label$2204:;
	label$2203:;
	void* vr$3440 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3440;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$576$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$576$1 = (char*)0;
	*(integer*)((ubyte*)TMP$576$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$576$1 + 8) = -2147483648u;
	TMP$577$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$577$1 + 8) = *(integer*)((ubyte*)TMP$577$1 + 8) | (IAMOUNT$1 + 2);
	void* vr$3453 = realloc( *(void**)TMP$577$1, (uinteger)(*(integer*)((ubyte*)TMP$577$1 + 8) & 2147483647) );
	*(char**)TMP$577$1 = (char*)vr$3453;
	*(integer*)((ubyte*)TMP$577$1 + 4) = IAMOUNT$1 + 1;
	memcpy( *(void**)TMP$577$1, *(void**)FBQUERYSTRING$1, *(uinteger*)((ubyte*)TMP$577$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$577$1 + *(integer*)((ubyte*)TMP$577$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2218;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2219;
			label$2222:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2224;
				{
					struct FBSTRING* TMP$579$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$578$6;
						TMP$578$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$578$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$579$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$579$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$579$5 == (char*)0 ) goto label$2226;
					free( *(void**)TMP$579$5 );
					*(char**)TMP$579$5 = (char*)0;
					*(integer*)((ubyte*)TMP$579$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$579$5 + 8) = 0;
					label$2226:;
					if( ISTEMP$5 == 0 ) goto label$2228;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2228:;
					label$2227:;
				}
				label$2224:;
				label$2223:;
			}
			label$2220:;
			N$3 = N$3 + -1;
			label$2219:;
			if( N$3 >= 0 ) goto label$2222;
			label$2221:;
		}
	}
	label$2218:;
	label$2217:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2196;
	label$2196:;
	return fb$result$1;
}

static        void* fb_StrMid( void* FBQUERYSTRING$1, integer ISTART$1, integer IAMOUNT$1 )
{
	struct FBSTRING* TMP$582$1;
	struct FBSTRING* TMP$583$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2229:;
	ISTART$1 = ISTART$1 + -1;
	if( (-(ISTART$1 < 0) | -(ISTART$1 > *(integer*)((ubyte*)FBQUERYSTRING$1 + 4))) == 0 ) goto label$2232;
	ISTART$1 = 0;
	IAMOUNT$1 = 0;
	label$2232:;
	if( IAMOUNT$1 >= 0 ) goto label$2234;
	IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4);
	label$2234:;
	if( (ISTART$1 + IAMOUNT$1) <= *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) ) goto label$2236;
	IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) - ISTART$1;
	label$2236:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2238;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2240;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2241;
				label$2244:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2246;
					{
						struct FBSTRING* TMP$581$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$580$7;
							TMP$580$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$580$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$581$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$581$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$581$6 == (char*)0 ) goto label$2248;
						free( *(void**)TMP$581$6 );
						*(char**)TMP$581$6 = (char*)0;
						*(integer*)((ubyte*)TMP$581$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$581$6 + 8) = 0;
						label$2248:;
						if( ISTEMP$6 == 0 ) goto label$2250;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2250:;
						label$2249:;
					}
					label$2246:;
					label$2245:;
				}
				label$2242:;
				N$4 = N$4 + -1;
				label$2241:;
				if( N$4 >= 0 ) goto label$2244;
				label$2243:;
			}
		}
		label$2240:;
		label$2239:;
	}
	label$2238:;
	label$2237:;
	void* vr$3511 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3511;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$582$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$582$1 = (char*)0;
	*(integer*)((ubyte*)TMP$582$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$582$1 + 8) = -2147483648u;
	TMP$583$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$583$1 + 8) = *(integer*)((ubyte*)TMP$583$1 + 8) | (IAMOUNT$1 + 1);
	void* vr$3524 = realloc( *(void**)TMP$583$1, (uinteger)(*(integer*)((ubyte*)TMP$583$1 + 8) & 2147483647) );
	*(char**)TMP$583$1 = (char*)vr$3524;
	*(integer*)((ubyte*)TMP$583$1 + 4) = IAMOUNT$1;
	memcpy( *(void**)TMP$583$1, (void*)((ubyte*)*(char**)FBQUERYSTRING$1 + ISTART$1), *(uinteger*)((ubyte*)TMP$583$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$583$1 + *(integer*)((ubyte*)TMP$583$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2252;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2253;
			label$2256:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2258;
				{
					struct FBSTRING* TMP$585$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$584$6;
						TMP$584$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$584$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$585$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$585$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$585$5 == (char*)0 ) goto label$2260;
					free( *(void**)TMP$585$5 );
					*(char**)TMP$585$5 = (char*)0;
					*(integer*)((ubyte*)TMP$585$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$585$5 + 8) = 0;
					label$2260:;
					if( ISTEMP$5 == 0 ) goto label$2262;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2262:;
					label$2261:;
				}
				label$2258:;
				label$2257:;
			}
			label$2254:;
			N$3 = N$3 + -1;
			label$2253:;
			if( N$3 >= 0 ) goto label$2256;
			label$2255:;
		}
	}
	label$2252:;
	label$2251:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2230;
	label$2230:;
	return fb$result$1;
}

static        void* fb_TRIM( void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$589$1;
	struct FBSTRING* TMP$590$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2263:;
	ubyte* TEMPDATA$1;
	TEMPDATA$1 = (ubyte*)*(void**)FBQUERYSTRING$1;
	integer ISTART$1;
	__builtin_memset( &ISTART$1, 0, 4 );
	integer IAMOUNT$1;
	__builtin_memset( &IAMOUNT$1, 0, 4 );
	{
		ISTART$1 = 0;
		integer TMP$586$2;
		TMP$586$2 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$2265;
		label$2268:;
		{
			if( (uinteger)*(ubyte*)(TEMPDATA$1 + ISTART$1) == 32u ) goto label$2270;
			goto label$2267;
			label$2270:;
		}
		label$2266:;
		ISTART$1 = ISTART$1 + 1;
		label$2265:;
		if( ISTART$1 <= TMP$586$2 ) goto label$2268;
		label$2267:;
	}
	{
		IAMOUNT$1 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
		goto label$2271;
		label$2274:;
		{
			if( (uinteger)*(ubyte*)(TEMPDATA$1 + IAMOUNT$1) == 32u ) goto label$2276;
			goto label$2273;
			label$2276:;
		}
		label$2272:;
		IAMOUNT$1 = IAMOUNT$1 + -1;
		label$2271:;
		if( IAMOUNT$1 >= 0 ) goto label$2274;
		label$2273:;
	}
	IAMOUNT$1 = IAMOUNT$1 - ISTART$1;
	if( IAMOUNT$1 >= 0 ) goto label$2278;
	IAMOUNT$1 = IAMOUNT$1 + 1;
	label$2278:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2280;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2282;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2283;
				label$2286:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2288;
					{
						struct FBSTRING* TMP$588$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$587$7;
							TMP$587$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$587$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$588$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$588$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$588$6 == (char*)0 ) goto label$2290;
						free( *(void**)TMP$588$6 );
						*(char**)TMP$588$6 = (char*)0;
						*(integer*)((ubyte*)TMP$588$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$588$6 + 8) = 0;
						label$2290:;
						if( ISTEMP$6 == 0 ) goto label$2292;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2292:;
						label$2291:;
					}
					label$2288:;
					label$2287:;
				}
				label$2284:;
				N$4 = N$4 + -1;
				label$2283:;
				if( N$4 >= 0 ) goto label$2286;
				label$2285:;
			}
		}
		label$2282:;
		label$2281:;
	}
	label$2280:;
	label$2279:;
	void* vr$3587 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3587;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$589$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$589$1 = (char*)0;
	*(integer*)((ubyte*)TMP$589$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$589$1 + 8) = -2147483648u;
	TMP$590$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$590$1 + 8) = *(integer*)((ubyte*)TMP$590$1 + 8) | (IAMOUNT$1 + 2);
	void* vr$3600 = realloc( *(void**)TMP$590$1, (uinteger)(*(integer*)((ubyte*)TMP$590$1 + 8) & 2147483647) );
	*(char**)TMP$590$1 = (char*)vr$3600;
	*(integer*)((ubyte*)TMP$590$1 + 4) = IAMOUNT$1 + 1;
	memcpy( *(void**)TMP$590$1, (void*)((ubyte*)*(char**)FBQUERYSTRING$1 + ISTART$1), *(uinteger*)((ubyte*)TMP$590$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$590$1 + *(integer*)((ubyte*)TMP$590$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2294;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2295;
			label$2298:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2300;
				{
					struct FBSTRING* TMP$592$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$591$6;
						TMP$591$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$591$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$592$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$592$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$592$5 == (char*)0 ) goto label$2302;
					free( *(void**)TMP$592$5 );
					*(char**)TMP$592$5 = (char*)0;
					*(integer*)((ubyte*)TMP$592$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$592$5 + 8) = 0;
					label$2302:;
					if( ISTEMP$5 == 0 ) goto label$2304;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2304:;
					label$2303:;
				}
				label$2300:;
				label$2299:;
			}
			label$2296:;
			N$3 = N$3 + -1;
			label$2295:;
			if( N$3 >= 0 ) goto label$2298;
			label$2297:;
		}
	}
	label$2294:;
	label$2293:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2264;
	label$2264:;
	return fb$result$1;
}

static        void fb_StrAssignMid( void* FBQUERYSTRING$1, integer ISTART$1, integer IAMOUNT$1, void* FBSETSTRING$1 )
{
	struct FBSTRING* TMP$593$1;
	label$2305:;
	TMP$593$1 = (struct FBSTRING*)FBQUERYSTRING$1;
	ISTART$1 = ISTART$1 + -1;
	if( (-(ISTART$1 < 0) | -(ISTART$1 > *(integer*)((ubyte*)TMP$593$1 + 4))) == 0 ) goto label$2308;
	ISTART$1 = 0;
	IAMOUNT$1 = 0;
	label$2308:;
	if( (-(IAMOUNT$1 < 0) | -(IAMOUNT$1 > *(integer*)((ubyte*)FBSETSTRING$1 + 4))) == 0 ) goto label$2310;
	IAMOUNT$1 = *(integer*)((ubyte*)FBSETSTRING$1 + 4);
	label$2310:;
	if( (ISTART$1 + IAMOUNT$1) <= *(integer*)((ubyte*)TMP$593$1 + 4) ) goto label$2312;
	IAMOUNT$1 = *(integer*)((ubyte*)TMP$593$1 + 4) - ISTART$1;
	label$2312:;
	memcpy( (void*)((ubyte*)*(char**)TMP$593$1 + ISTART$1), *(void**)FBSETSTRING$1, (uinteger)IAMOUNT$1 );
	if( FBSETSTRING$1 == FBQUERYSTRING$1 ) goto label$2314;
	{
		if( FBSETSTRING$1 == (void*)0 ) goto label$2316;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2317;
				label$2320:;
				{
					if( FBSETSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2322;
					{
						struct FBSTRING* TMP$595$6;
						void* PTEMP$6;
						PTEMP$6 = FBSETSTRING$1;
						{
							void* TMP$594$7;
							TMP$594$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$594$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$595$6 = (struct FBSTRING*)FBSETSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$595$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$595$6 == (char*)0 ) goto label$2324;
						free( *(void**)TMP$595$6 );
						*(char**)TMP$595$6 = (char*)0;
						*(integer*)((ubyte*)TMP$595$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$595$6 + 8) = 0;
						label$2324:;
						if( ISTEMP$6 == 0 ) goto label$2326;
						{
							free( FBSETSTRING$1 );
							FBSETSTRING$1 = (void*)0;
						}
						label$2326:;
						label$2325:;
					}
					label$2322:;
					label$2321:;
				}
				label$2318:;
				N$4 = N$4 + -1;
				label$2317:;
				if( N$4 >= 0 ) goto label$2320;
				label$2319:;
			}
		}
		label$2316:;
		label$2315:;
	}
	label$2314:;
	label$2313:;
	label$2306:;
}

static        void* fb_StrFill1( integer IAMOUNT$1, integer ICHAR$1 )
{
	struct FBSTRING* TMP$598$1;
	struct FBSTRING* TMP$599$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2327:;
	if( IAMOUNT$1 >= 0 ) goto label$2330;
	IAMOUNT$1 = 0;
	label$2330:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2332;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2334;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2335;
				label$2338:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2340;
					{
						struct FBSTRING* TMP$597$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$596$7;
							TMP$596$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$596$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$597$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$597$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$597$6 == (char*)0 ) goto label$2342;
						free( *(void**)TMP$597$6 );
						*(char**)TMP$597$6 = (char*)0;
						*(integer*)((ubyte*)TMP$597$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$597$6 + 8) = 0;
						label$2342:;
						if( ISTEMP$6 == 0 ) goto label$2344;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2344:;
						label$2343:;
					}
					label$2340:;
					label$2339:;
				}
				label$2336:;
				N$4 = N$4 + -1;
				label$2335:;
				if( N$4 >= 0 ) goto label$2338;
				label$2337:;
			}
		}
		label$2334:;
		label$2333:;
	}
	label$2332:;
	label$2331:;
	void* vr$3684 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3684;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$598$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$598$1 = (char*)0;
	*(integer*)((ubyte*)TMP$598$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$598$1 + 8) = -2147483648u;
	TMP$599$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$599$1 + 4) = IAMOUNT$1;
	*(integer*)((ubyte*)TMP$599$1 + 8) = *(integer*)((ubyte*)TMP$599$1 + 8) | (*(integer*)((ubyte*)TMP$599$1 + 4) + 1);
	void* vr$3699 = realloc( *(void**)TMP$599$1, (uinteger)(*(integer*)((ubyte*)TMP$599$1 + 8) & 2147483647) );
	*(char**)TMP$599$1 = (char*)vr$3699;
	memset( *(void**)TMP$599$1, ICHAR$1, *(uinteger*)((ubyte*)TMP$599$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$599$1 + *(integer*)((ubyte*)TMP$599$1 + 4)) = (ubyte)0;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2328;
	label$2328:;
	return fb$result$1;
}

static        void* fb_StrFill2( integer IAMOUNT$1, void* FBQUERYSTRING$1 )
{
	struct FBSTRING* TMP$602$1;
	struct FBSTRING* TMP$603$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2345:;
	if( IAMOUNT$1 >= 0 ) goto label$2348;
	IAMOUNT$1 = 0;
	label$2348:;
	if( *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) >= 0 ) goto label$2350;
	IAMOUNT$1 = 0;
	label$2350:;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2352;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2354;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2355;
				label$2358:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2360;
					{
						struct FBSTRING* TMP$601$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$600$7;
							TMP$600$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$600$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$601$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$601$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$601$6 == (char*)0 ) goto label$2362;
						free( *(void**)TMP$601$6 );
						*(char**)TMP$601$6 = (char*)0;
						*(integer*)((ubyte*)TMP$601$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$601$6 + 8) = 0;
						label$2362:;
						if( ISTEMP$6 == 0 ) goto label$2364;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2364:;
						label$2363:;
					}
					label$2360:;
					label$2359:;
				}
				label$2356:;
				N$4 = N$4 + -1;
				label$2355:;
				if( N$4 >= 0 ) goto label$2358;
				label$2357:;
			}
		}
		label$2354:;
		label$2353:;
	}
	label$2352:;
	label$2351:;
	void* vr$3727 = malloc( 16u );
	_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$3727;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$602$1 = _ZN2FB11TEMPSTRING$E;
	*(char**)TMP$602$1 = (char*)0;
	*(integer*)((ubyte*)TMP$602$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$602$1 + 8) = -2147483648u;
	TMP$603$1 = _ZN2FB11TEMPSTRING$E;
	*(integer*)((ubyte*)TMP$603$1 + 4) = IAMOUNT$1;
	*(integer*)((ubyte*)TMP$603$1 + 8) = *(integer*)((ubyte*)TMP$603$1 + 8) | (*(integer*)((ubyte*)TMP$603$1 + 4) + 1);
	void* vr$3742 = realloc( *(void**)TMP$603$1, (uinteger)(*(integer*)((ubyte*)TMP$603$1 + 8) & 2147483647) );
	*(char**)TMP$603$1 = (char*)vr$3742;
	memset( *(void**)TMP$603$1, (integer)*(*(ubyte**)FBQUERYSTRING$1), *(uinteger*)((ubyte*)TMP$603$1 + 4) );
	*(ubyte*)(*(ubyte**)TMP$603$1 + *(integer*)((ubyte*)TMP$603$1 + 4)) = (ubyte)0;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2366;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2367;
			label$2370:;
			{
				if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2372;
				{
					struct FBSTRING* TMP$605$5;
					void* PTEMP$5;
					PTEMP$5 = FBQUERYSTRING$1;
					{
						void* TMP$604$6;
						TMP$604$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$604$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$605$5 = (struct FBSTRING*)FBQUERYSTRING$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$605$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$605$5 == (char*)0 ) goto label$2374;
					free( *(void**)TMP$605$5 );
					*(char**)TMP$605$5 = (char*)0;
					*(integer*)((ubyte*)TMP$605$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$605$5 + 8) = 0;
					label$2374:;
					if( ISTEMP$5 == 0 ) goto label$2376;
					{
						free( FBQUERYSTRING$1 );
						FBQUERYSTRING$1 = (void*)0;
					}
					label$2376:;
					label$2375:;
				}
				label$2372:;
				label$2371:;
			}
			label$2368:;
			N$3 = N$3 + -1;
			label$2367:;
			if( N$3 >= 0 ) goto label$2370;
			label$2369:;
		}
	}
	label$2366:;
	label$2365:;
	fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
	goto label$2346;
	label$2346:;
	return fb$result$1;
}

static inline void* fb_SPACE( integer IAMOUNT$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2377:;
	void* vr$3772 = fb_StrFill1( IAMOUNT$1, 32 );              
	fb$result$1 = vr$3772;
	goto label$2378;
	label$2378:;
	return fb$result$1;
}

static        integer fb_ConsoleInput( void* FBQUERYSTRING$1, integer QUERYTYPE$1, integer STRINGSIZE$1 )
{
	struct FBSTRING* TMP$608$1;
	struct FBSTRING* TMP$611$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2379:;
	fb_PrintString( 0, FBQUERYSTRING$1, 0 );              
	if( STRINGSIZE$1 < 0 ) goto label$2382;
	fb_StrDelete( FBQUERYSTRING$1 );              
	label$2382:;
	if( QUERYTYPE$1 != -1 ) goto label$2384;
	{
		putchar( 63 );
		putchar( 32 );
	}
	label$2384:;
	label$2383:;
	integer CHARASCII$1;
	__builtin_memset( &CHARASCII$1, 0, 4 );
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2386;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2388;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2389;
				label$2392:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2394;
					{
						struct FBSTRING* TMP$607$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$606$7;
							TMP$606$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$606$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$607$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$607$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$607$6 == (char*)0 ) goto label$2396;
						free( *(void**)TMP$607$6 );
						*(char**)TMP$607$6 = (char*)0;
						*(integer*)((ubyte*)TMP$607$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$607$6 + 8) = 0;
						label$2396:;
						if( ISTEMP$6 == 0 ) goto label$2398;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2398:;
						label$2397:;
					}
					label$2394:;
					label$2393:;
				}
				label$2390:;
				N$4 = N$4 + -1;
				label$2389:;
				if( N$4 >= 0 ) goto label$2392;
				label$2391:;
			}
		}
		label$2388:;
		label$2387:;
	}
	label$2386:;
	label$2385:;
	void* vr$3794 = malloc( 16u );
	_ZN2FB12INPUTSTRING$E = (struct FBSTRING*)vr$3794;
	*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB12INPUTSTRING$E;
	TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
	TMP$608$1 = _ZN2FB12INPUTSTRING$E;
	*(char**)TMP$608$1 = (char*)0;
	*(integer*)((ubyte*)TMP$608$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$608$1 + 8) = -2147483648u;
	if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2400;
	{
		if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2402;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2403;
				label$2406:;
				{
					if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2408;
					{
						struct FBSTRING* TMP$610$6;
						struct FBSTRING* PTEMP$6;
						PTEMP$6 = _ZN2FB12DESTROYTEMP$E;
						{
							void* TMP$609$7;
							TMP$609$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$609$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$610$6 = _ZN2FB12DESTROYTEMP$E;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$610$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$610$6 == (char*)0 ) goto label$2410;
						free( *(void**)TMP$610$6 );
						*(char**)TMP$610$6 = (char*)0;
						*(integer*)((ubyte*)TMP$610$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$610$6 + 8) = 0;
						label$2410:;
						if( ISTEMP$6 == 0 ) goto label$2412;
						{
							free( (void*)_ZN2FB12DESTROYTEMP$E );
							_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
						}
						label$2412:;
						label$2411:;
					}
					label$2408:;
					label$2407:;
				}
				label$2404:;
				N$4 = N$4 + -1;
				label$2403:;
				if( N$4 >= 0 ) goto label$2406;
				label$2405:;
			}
		}
		label$2402:;
		label$2401:;
	}
	label$2400:;
	label$2399:;
	_ZN2FB12DESTROYTEMP$E = _ZN2FB12INPUTSTRING$E;
	TMP$611$1 = _ZN2FB12INPUTSTRING$E;
	*(integer*)((ubyte*)TMP$611$1 + 4) = 0;
	*(integer*)((ubyte*)TMP$611$1 + 8) = *(integer*)((ubyte*)TMP$611$1 + 8) | 64;
	void* vr$3824 = malloc( (uinteger)(*(integer*)((ubyte*)TMP$611$1 + 8) & 2147483647) );
	*(char**)TMP$611$1 = (char*)vr$3824;
	label$2413:;
	{
		_ZN2FB15SCREENECHOISON$E = (byte)-1;
		integer vr$3827 = getc( *(struct _IO_FILE**)((ubyte*)_impure_ptr + 4) );
		CHARASCII$1 = vr$3827;
		_ZN2FB15SCREENECHOISON$E = (byte)0;
		if( CHARASCII$1 != 10u ) goto label$2417;
		{
			*(ubyte*)(*(ubyte**)TMP$611$1 + *(integer*)((ubyte*)TMP$611$1 + 4)) = (ubyte)0;
			goto label$2414;
		}
		label$2417:;
		label$2416:;
		*(ubyte*)(*(ubyte**)TMP$611$1 + *(integer*)((ubyte*)TMP$611$1 + 4)) = (ubyte)CHARASCII$1;
		*(integer*)((ubyte*)TMP$611$1 + 4) = *(integer*)((ubyte*)TMP$611$1 + 4) + 1;
		if( (*(integer*)((ubyte*)TMP$611$1 + 4) & 63) != 0 ) goto label$2419;
		{
			*(integer*)((ubyte*)TMP$611$1 + 8) = *(integer*)((ubyte*)TMP$611$1 + 8) + 64;
			void* vr$3846 = realloc( *(void**)TMP$611$1, (uinteger)(*(integer*)((ubyte*)TMP$611$1 + 8) & 2147483647) );
			*(char**)TMP$611$1 = (char*)vr$3846;
		}
		label$2419:;
		label$2418:;
	}
	label$2415:;
	goto label$2413;
	label$2414:;
	fb$result$1 = *(integer*)((ubyte*)_ZN2FB12INPUTSTRING$E + 4);
	goto label$2380;
	label$2380:;
	return fb$result$1;
}

static        integer fb_InputString( void* TARGETSTRING$1, integer STRINGSIZE$1, integer UNK1$1 )
{
	struct FBSTRING* TMP$612$1;
	integer TMP$613$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2420:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	TMP$612$1 = _ZN2FB12INPUTSTRING$E;
	if( *(integer*)((ubyte*)TMP$612$1 + 4) == 0 ) goto label$2422;
	TMP$613$1 = -(*(char**)TMP$612$1 != 0);
	goto label$2455;
	label$2422:;
	TMP$613$1 = 0;
	label$2455:;
	if( TMP$613$1 == 0 ) goto label$2424;
	{
		label$2425:;
		if( (-((uinteger)*(*(ubyte**)TMP$612$1) == 32) | -((uinteger)*(*(ubyte**)TMP$612$1) == 9)) == 0 ) goto label$2426;
		{
			*(char**)TMP$612$1 = (char*)((ubyte*)*(char**)TMP$612$1 + 1);
			*(integer*)((ubyte*)TMP$612$1 + 4) = *(integer*)((ubyte*)TMP$612$1 + 4) + -1;
		}
		goto label$2425;
		label$2426:;
		integer NEWSIZE$2;
		NEWSIZE$2 = *(integer*)((ubyte*)TMP$612$1 + 4);
		void* NEWPOINTER$2;
		void* vr$3872 = memchr( *(void**)TMP$612$1, 44, (uinteger)NEWSIZE$2 );
		NEWPOINTER$2 = vr$3872;
		if( NEWPOINTER$2 == (void*)0 ) goto label$2428;
		NEWSIZE$2 = (integer)((uinteger)NEWPOINTER$2 - *(uinteger*)TMP$612$1);
		label$2428:;
		if( TARGETSTRING$1 == (void*)0 ) goto label$2430;
		{
			if( STRINGSIZE$1 != -1 ) goto label$2432;
			{
				if( *(integer*)((ubyte*)TARGETSTRING$1 + 8) != -1 ) goto label$2434;
				printf( (char*)"fb_InputString Realloc CONST string\n" );
				fb_Beep(  );
				fb_Sleep( -1 );
				label$2434:;
				void* vr$3878 = realloc( *(void**)TARGETSTRING$1, (uinteger)(NEWSIZE$2 + 1) );
				*(char**)TARGETSTRING$1 = (char*)vr$3878;
				*(integer*)((ubyte*)TARGETSTRING$1 + 4) = NEWSIZE$2;
				*(integer*)((ubyte*)TARGETSTRING$1 + 8) = (*(integer*)((ubyte*)TARGETSTRING$1 + 8) & -2147483648u) | (NEWSIZE$2 + 1);
				memcpy( *(void**)TARGETSTRING$1, *(void**)TMP$612$1, (uinteger)NEWSIZE$2 );
				*(ubyte*)(*(ubyte**)TARGETSTRING$1 + NEWSIZE$2) = (ubyte)0;
				IRESULT$1 = NEWSIZE$2;
			}
			goto label$2431;
			label$2432:;
			{
				if( STRINGSIZE$1 != 0 ) goto label$2436;
				uinteger vr$3890 = strlen( (char*)TARGETSTRING$1 );
				STRINGSIZE$1 = (integer)vr$3890;
				label$2436:;
				if( NEWSIZE$2 < STRINGSIZE$1 ) goto label$2438;
				NEWSIZE$2 = STRINGSIZE$1 + -1;
				label$2438:;
				if( NEWSIZE$2 >= 1 ) goto label$2440;
				{
					*(ubyte*)TARGETSTRING$1 = (ubyte)0;
				}
				goto label$2439;
				label$2440:;
				{
					memcpy( TARGETSTRING$1, *(void**)TMP$612$1, (uinteger)NEWSIZE$2 );
					*(ubyte*)((ubyte*)TARGETSTRING$1 + NEWSIZE$2) = (ubyte)0;
				}
				label$2439:;
				IRESULT$1 = NEWSIZE$2;
			}
			label$2431:;
		}
		label$2430:;
		label$2429:;
		if( NEWPOINTER$2 == (void*)0 ) goto label$2442;
		{
			NEWSIZE$2 = NEWSIZE$2 + 1;
			*(char**)TMP$612$1 = (char*)((ubyte*)*(char**)TMP$612$1 + NEWSIZE$2);
			*(integer*)((ubyte*)TMP$612$1 + 4) = *(integer*)((ubyte*)TMP$612$1 + 4) - NEWSIZE$2;
			if( *(integer*)((ubyte*)TMP$612$1 + 4) >= 0 ) goto label$2444;
			*(integer*)((ubyte*)TMP$612$1 + 4) = 0;
			label$2444:;
			integer TEMP$3;
			TEMP$3 = *(integer*)((ubyte*)TMP$612$1 + 8) & -2147483648u;
			*(integer*)((ubyte*)TMP$612$1 + 8) = (*(integer*)((ubyte*)TMP$612$1 + 8) - TEMP$3) - NEWSIZE$2;
			if( *(integer*)((ubyte*)TMP$612$1 + 8) >= 0 ) goto label$2446;
			*(integer*)((ubyte*)TMP$612$1 + 8) = 0;
			label$2446:;
			*(integer*)((ubyte*)TMP$612$1 + 8) = *(integer*)((ubyte*)TMP$612$1 + 8) | TEMP$3;
		}
		goto label$2441;
		label$2442:;
		{
			if( *(char**)TMP$612$1 == (char*)0 ) goto label$2448;
			free( *(void**)TMP$612$1 );
			label$2448:;
			*(char**)TMP$612$1 = (char*)0;
			*(integer*)((ubyte*)TMP$612$1 + 4) = 0;
			*(integer*)((ubyte*)TMP$612$1 + 8) = *(integer*)((ubyte*)TMP$612$1 + 8) & -2147483648u;
		}
		label$2441:;
	}
	goto label$2423;
	label$2424:;
	{
		if( STRINGSIZE$1 != -1 ) goto label$2450;
		{
			if( *(integer*)((ubyte*)TARGETSTRING$1 + 8) != -1 ) goto label$2452;
			printf( (char*)"fb_InputString dealloc CONST\n" );
			label$2452:;
			if( *(char**)TARGETSTRING$1 == (char*)0 ) goto label$2454;
			free( *(void**)TARGETSTRING$1 );
			label$2454:;
			*(char**)TARGETSTRING$1 = (char*)0;
			*(integer*)((ubyte*)TARGETSTRING$1 + 4) = 0;
			*(integer*)((ubyte*)TARGETSTRING$1 + 8) = *(integer*)((ubyte*)TARGETSTRING$1 + 8) & -2147483648u;
		}
		goto label$2449;
		label$2450:;
		{
			*(*(ubyte**)TARGETSTRING$1) = (ubyte)0;
		}
		label$2449:;
	}
	label$2423:;
	fb$result$1 = IRESULT$1;
	goto label$2421;
	label$2421:;
	return fb$result$1;
}

static        integer fb_InputNumber( char* ZSCAN$1, void* TARGET$1 )
{
	struct FBSTRING* TMP$616$1;
	integer TMP$617$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2456:;
	TMP$616$1 = _ZN2FB12INPUTSTRING$E;
	if( *(integer*)((ubyte*)TMP$616$1 + 4) == 0 ) goto label$2458;
	TMP$617$1 = -(*(char**)TMP$616$1 != 0);
	goto label$2471;
	label$2458:;
	TMP$617$1 = 0;
	label$2471:;
	if( TMP$617$1 == 0 ) goto label$2460;
	{
		label$2461:;
		if( (-((uinteger)*(*(ubyte**)TMP$616$1) == 32) | -((uinteger)*(*(ubyte**)TMP$616$1) == 9)) == 0 ) goto label$2462;
		{
			*(char**)TMP$616$1 = (char*)((ubyte*)*(char**)TMP$616$1 + 1);
			*(integer*)((ubyte*)TMP$616$1 + 4) = *(integer*)((ubyte*)TMP$616$1 + 4) + -1;
			*(integer*)((ubyte*)TMP$616$1 + 8) = *(integer*)((ubyte*)TMP$616$1 + 8) + -1;
		}
		goto label$2461;
		label$2462:;
		integer NEWSIZE$2;
		NEWSIZE$2 = *(integer*)((ubyte*)TMP$616$1 + 4);
		void* NEWPOINTER$2;
		void* vr$3957 = memchr( *(void**)TMP$616$1, 44, (uinteger)NEWSIZE$2 );
		NEWPOINTER$2 = vr$3957;
		if( NEWPOINTER$2 == (void*)0 ) goto label$2464;
		NEWSIZE$2 = (integer)((uinteger)NEWPOINTER$2 - *(uinteger*)TMP$616$1);
		label$2464:;
		sscanf( *(char**)TMP$616$1, ZSCAN$1, TARGET$1 );
		if( NEWPOINTER$2 == (void*)0 ) goto label$2466;
		{
			NEWSIZE$2 = NEWSIZE$2 + 1;
			*(char**)TMP$616$1 = (char*)((ubyte*)*(char**)TMP$616$1 + NEWSIZE$2);
			*(integer*)((ubyte*)TMP$616$1 + 4) = *(integer*)((ubyte*)TMP$616$1 + 4) - NEWSIZE$2;
			if( *(integer*)((ubyte*)TMP$616$1 + 4) >= 0 ) goto label$2468;
			*(integer*)((ubyte*)TMP$616$1 + 4) = 0;
			label$2468:;
			integer TEMP$3;
			TEMP$3 = *(integer*)((ubyte*)TMP$616$1 + 8) & -2147483648u;
			*(integer*)((ubyte*)TMP$616$1 + 8) = (*(integer*)((ubyte*)TMP$616$1 + 8) - TEMP$3) - NEWSIZE$2;
			if( *(integer*)((ubyte*)TMP$616$1 + 8) >= 0 ) goto label$2470;
			*(integer*)((ubyte*)TMP$616$1 + 8) = 0;
			label$2470:;
			*(integer*)((ubyte*)TMP$616$1 + 8) = *(integer*)((ubyte*)TMP$616$1 + 8) | TEMP$3;
		}
		goto label$2465;
		label$2466:;
		{
			*(char**)TMP$616$1 = (char*)0;
			*(integer*)((ubyte*)TMP$616$1 + 4) = 0;
			*(integer*)((ubyte*)TMP$616$1 + 8) = *(integer*)((ubyte*)TMP$616$1 + 8) & -2147483648u;
		}
		label$2465:;
		fb$result$1 = NEWSIZE$2;
		goto label$2457;
	}
	goto label$2459;
	label$2460:;
	{
		sscanf( (char*)"0", ZSCAN$1, TARGET$1 );
	}
	label$2459:;
	label$2457:;
	return fb$result$1;
}

static inline integer fb_InputByte( byte* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2472:;
	integer TEMPTARGET$1;
	__builtin_memset( &TEMPTARGET$1, 0, 4 );
	integer vr$3990 = fb_InputNumber( (char*)"%i", (void*)&TEMPTARGET$1 );              
	fb$result$1 = vr$3990;
	*TARGET$1 = (byte)TEMPTARGET$1;
	label$2473:;
	return fb$result$1;
}

static inline integer fb_InputUbyte( ubyte* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2474:;
	uinteger TEMPTARGET$1;
	__builtin_memset( &TEMPTARGET$1, 0, 4 );
	integer vr$3997 = fb_InputNumber( (char*)"%u", (void*)&TEMPTARGET$1 );              
	fb$result$1 = vr$3997;
	*TARGET$1 = (ubyte)TEMPTARGET$1;
	label$2475:;
	return fb$result$1;
}

static inline integer fb_InputShort( short* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2476:;
	integer vr$4002 = fb_InputNumber( (char*)"%hi", (void*)TARGET$1 );              
	fb$result$1 = vr$4002;
	goto label$2477;
	label$2477:;
	return fb$result$1;
}

static inline integer fb_InputUshort( ushort* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2478:;
	integer vr$4005 = fb_InputNumber( (char*)"%hu", (void*)TARGET$1 );              
	fb$result$1 = vr$4005;
	goto label$2479;
	label$2479:;
	return fb$result$1;
}

static inline integer fb_InputInt( integer* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2480:;
	integer vr$4008 = fb_InputNumber( (char*)"%i", (void*)TARGET$1 );              
	fb$result$1 = vr$4008;
	goto label$2481;
	label$2481:;
	return fb$result$1;
}

static inline integer fb_InputUint( uinteger* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2482:;
	integer vr$4011 = fb_InputNumber( (char*)"%u", (void*)TARGET$1 );              
	fb$result$1 = vr$4011;
	goto label$2483;
	label$2483:;
	return fb$result$1;
}

static inline integer fb_InputSingle( single* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2484:;
	integer vr$4014 = fb_InputNumber( (char*)"%f", (void*)TARGET$1 );              
	fb$result$1 = vr$4014;
	goto label$2485;
	label$2485:;
	return fb$result$1;
}

static inline integer fb_InputDouble( double* TARGET$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2486:;
	integer vr$4017 = fb_InputNumber( (char*)"%Lf", (void*)TARGET$1 );              
	fb$result$1 = vr$4017;
	goto label$2487;
	label$2487:;
	return fb$result$1;
}

static        void* fb_Inkey( void )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2488:;
	static char INKDATA$1[4] = "   ";
	static struct FBSTRING INKEYSTRING$1;
	if( _ZN2FB10INKEYREAD$E == _ZN2FB11INKEYWRITE$E ) goto label$2491;
	{
		integer NEWKEY$2;
		NEWKEY$2 = (integer)*(short*)((ubyte*)_ZN2FB10INKEYBUFF$E + ((integer)_ZN2FB10INKEYREAD$E << 1));
		*(char**)&INKEYSTRING$1 = (char*)INKDATA$1;
		*(integer*)((ubyte*)&INKEYSTRING$1 + 8) = -1;
		if( NEWKEY$2 >= 0 ) goto label$2493;
		{
			*(integer*)((ubyte*)&INKEYSTRING$1 + 4) = 2;
			*(*(ushort**)&INKEYSTRING$1) = (ushort)(255 + (-NEWKEY$2 << 8));
		}
		goto label$2492;
		label$2493:;
		{
			*(integer*)((ubyte*)&INKEYSTRING$1 + 4) = 1;
			*(*(ubyte**)&INKEYSTRING$1) = (ubyte)NEWKEY$2;
		}
		label$2492:;
		_ZN2FB10INKEYREAD$E = (short)(((integer)_ZN2FB10INKEYREAD$E + 1) & 255);
		if( keyBufferLength == 0 ) goto label$2495;
		keyBufferLength = keyBufferLength + -1;
		label$2495:;
	}
	goto label$2490;
	label$2491:;
	{
		*(char**)&INKEYSTRING$1 = (char*)INKDATA$1;
		*(integer*)((ubyte*)&INKEYSTRING$1 + 8) = -1;
		*(integer*)((ubyte*)&INKEYSTRING$1 + 4) = 0;
	}
	label$2490:;
	*(ubyte*)(*(ubyte**)&INKEYSTRING$1 + *(integer*)((ubyte*)&INKEYSTRING$1 + 4)) = (ubyte)0;
	fb$result$1 = (void*)&INKEYSTRING$1;
	goto label$2489;
	label$2489:;
	return fb$result$1;
}

static inline integer fb_GetMouse( integer* IX$1, integer* IY$1, integer* IWHEEL$1, integer* IBUTTONS$1, integer* ICLIP$1 )
{
	integer TMP$623$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2496:;
	*IX$1 = (integer)_ZN2FB7MOUSEX$E;
	*IY$1 = (integer)_ZN2FB7MOUSEY$E;
	if( (KEYPAD_BITS)((KEYPAD_BITS)_ZN2FB10DSBUTTONS$E & (KEYPAD_BITS)4096) == (KEYPAD_BITS)0 ) goto label$2498;
	TMP$623$1 = 1;
	goto label$2499;
	label$2498:;
	TMP$623$1 = 0;
	label$2499:;
	*IBUTTONS$1 = TMP$623$1;
	*IWHEEL$1 = 0;
	*ICLIP$1 = 0;
	fb$result$1 = 0;
	goto label$2497;
	label$2497:;
	return fb$result$1;
}

static inline integer fb_SetMouse( integer IX$1, integer IY$1, integer ICURSOR$1, integer ICLIP$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2500:;
	fb$result$1 = -1;
	goto label$2501;
	label$2501:;
	return fb$result$1;
}

static inline integer fb_Multikey( integer ISCANCODE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2502:;
	if( ISCANCODE$1 >= 0 ) goto label$2505;
	fb$result$1 = -(((integer)_ZN2FB10DSBUTTONS$E & -ISCANCODE$1) != 0);
	goto label$2503;
	label$2505:;
	if( (-(ISCANCODE$1 >= (FB$TMP$64)116) & -(ISCANCODE$1 <= (FB$TMP$64)128)) == 0 ) goto label$2507;
	{
		fb$result$1 = -(((integer)_ZN2FB10DSBUTTONS$E & (1 << (128 - ISCANCODE$1))) != 0);
		goto label$2503;
	}
	label$2507:;
	label$2506:;
	fb$result$1 = -((integer)*(short*)((ubyte*)_ZN2FB10SCANSTATE$E + ((ISCANCODE$1 & 127) << 1)) != 0);
	goto label$2503;
	label$2503:;
	return fb$result$1;
}

static inline integer fb_Locate( integer ILIN$1, integer ICOL$1, integer UNK0$1, integer UNK1$1, integer UNK2$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2508:;
	if( (-(ILIN$1 > 24) | -(ICOL$1 > 32)) == 0 ) goto label$2511;
	fb$result$1 = 0;
	goto label$2509;
	label$2511:;
	if( ILIN$1 <= 0 ) goto label$2513;
	*(integer*)((ubyte*)FBCONSOLE$ + 40) = ILIN$1 + -1;
	label$2513:;
	if( ICOL$1 <= 0 ) goto label$2515;
	*(integer*)((ubyte*)FBCONSOLE$ + 36) = ICOL$1 + -1;
	label$2515:;
	fb$result$1 = 1;
	goto label$2509;
	label$2509:;
	return fb$result$1;
}

static inline void fb_Cls( integer UNK0$1 )
{
	label$2516:;
	puts( (char*)"\33""[2J" );
	fb_Locate( 1, 1, -1, 0, 0 );
	label$2517:;
}

static        integer fb_Color( integer IFORE$1, integer IBACK$1, integer UNK0$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2518:;
	integer UCOLOR$1;
	UCOLOR$1 = (((IFORE$1 & 4) >> 2) | ((IFORE$1 & 1) << 2)) | (IFORE$1 & 10);
	*(ushort*)((ubyte*)FBCONSOLE$ + 82) = (ushort)(UCOLOR$1 << 12);
	fb$result$1 = 1;
	goto label$2519;
	label$2519:;
	return fb$result$1;
}

static        integer fb_GetX( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2520:;
	fb$result$1 = (*(integer*)((ubyte*)FBCONSOLE$ + 36) & 31) + 1;
	goto label$2521;
	label$2521:;
	return fb$result$1;
}

static        integer fb_GetY( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2522:;
	fb$result$1 = (*(integer*)((ubyte*)FBCONSOLE$ + 40) + (*(integer*)((ubyte*)FBCONSOLE$ + 36) >> 5)) + 1;
	goto label$2523;
	label$2523:;
	return fb$result$1;
}

static inline void fb_Randomize( double DSEED$1, integer ITYPE$1 )
{
	label$2524:;
	if( DSEED$1 != -1.0 ) goto label$2527;
	DSEED$1 = (double)FB_TICKS$;
	label$2527:;
	uinteger vr$4102 = fb_dtoui( DSEED$1 );
	srand( vr$4102 );
	goto label$2525;
	label$2525:;
}

static inline double fb_Rnd( single SEED$1 )
{
	double fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$2528:;
	if( SEED$1 == 1.0f ) goto label$2531;
	uinteger vr$4104 = fb_ftoui( SEED$1 );
	srand( vr$4104 );
	label$2531:;
	integer vr$4105 = rand(  );
	fb$result$1 = (double)vr$4105 * 4.656612873077393e-010;
	goto label$2529;
	label$2529:;
	return fb$result$1;
}

static inline integer fb_FileFree( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2532:;
	{
		integer CNT$2;
		CNT$2 = 1;
		label$2537:;
		{
			struct FB$FBFILE* TMP$625$3;
			TMP$625$3 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (CNT$2 << 4)) + -16);
			if( *(struct _IO_FILE**)TMP$625$3 != 0 ) goto label$2539;
			fb$result$1 = CNT$2;
			goto label$2533;
			label$2539:;
		}
		label$2535:;
		CNT$2 = CNT$2 + 1;
		label$2534:;
		if( CNT$2 <= 127 ) goto label$2537;
		label$2536:;
	}
	fb$result$1 = 0;
	goto label$2533;
	label$2533:;
	return fb$result$1;
}

static        FB$ERRORNUMBERS fb_FileOpen( void* FBFILENAME$1, FB$OPENMODES IMODE$1, FB$ACCESSFLAGS IACCESS$1, FB$ACCESSFLAGS ILOCK$1, integer IFILENUM$1, integer IFIELDSZ$1 )
{
	FB$ERRORNUMBERS fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2540:;
	integer IRESULT$1;
	__builtin_memset( &IRESULT$1, 0, 4 );
	label$2542:;
	{
		struct FB$FBFILE* TMP$630$2;
		if( (uinteger)IFILENUM$1 <= 127 ) goto label$2546;
		IRESULT$1 = 1;
		goto label$2543;
		label$2546:;
		if( *(struct _IO_FILE**)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16) == (struct _IO_FILE*)0 ) goto label$2548;
		IRESULT$1 = 1;
		goto label$2543;
		label$2548:;
		if( (uinteger)IMODE$1 < (FB$OPENMODES)5 ) goto label$2550;
		IRESULT$1 = 1;
		goto label$2543;
		label$2550:;
		char* OPENMODE$2;
		OPENMODE$2 = (char*)"a+";
		{
			FB$ACCESSFLAGS TMP$627$3;
			TMP$627$3 = (FB$ACCESSFLAGS)(IACCESS$1 & (FB$ACCESSFLAGS)3);
			if( TMP$627$3 != (FB$ACCESSFLAGS)1 ) goto label$2552;
			label$2553:;
			{
				OPENMODE$2 = (char*)"rb";
			}
			goto label$2551;
			label$2552:;
			if( TMP$627$3 != (FB$ACCESSFLAGS)2 ) goto label$2554;
			label$2555:;
			{
				OPENMODE$2 = (char*)"wb";
			}
			label$2554:;
			label$2551:;
		}
		TMP$630$2 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
		struct _IO_FILE* vr$4122 = fopen( *(char**)FBFILENAME$1, OPENMODE$2 );
		*(struct _IO_FILE**)TMP$630$2 = vr$4122;
		if( *(struct _IO_FILE**)TMP$630$2 != 0 ) goto label$2557;
		IRESULT$1 = 2;
		goto label$2543;
		label$2557:;
		if( OPENMODE$2 != (char*)"a+" ) goto label$2559;
		freopen( *(char**)FBFILENAME$1, (char*)"r+", *(struct _IO_FILE**)TMP$630$2 );
		label$2559:;
		fseek( *(struct _IO_FILE**)TMP$630$2, 0, 2 );
		integer vr$4129 = ftell( *(struct _IO_FILE**)TMP$630$2 );
		*(longint*)((ubyte*)TMP$630$2 + 8) = (longint)vr$4129;
		fseek( *(struct _IO_FILE**)TMP$630$2, 0, 0 );
		*(integer*)((ubyte*)TMP$630$2 + 4) = (integer)IMODE$1;
		IRESULT$1 = 0;
		goto label$2543;
	}
	label$2544:;
	goto label$2542;
	label$2543:;
	if( FBFILENAME$1 == (void*)0 ) goto label$2561;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2562;
			label$2565:;
			{
				if( FBFILENAME$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2567;
				{
					struct FBSTRING* TMP$633$5;
					void* PTEMP$5;
					PTEMP$5 = FBFILENAME$1;
					{
						void* TMP$632$6;
						TMP$632$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$632$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$633$5 = (struct FBSTRING*)FBFILENAME$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$633$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$633$5 == (char*)0 ) goto label$2569;
					free( *(void**)TMP$633$5 );
					*(char**)TMP$633$5 = (char*)0;
					*(integer*)((ubyte*)TMP$633$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$633$5 + 8) = 0;
					label$2569:;
					if( ISTEMP$5 == 0 ) goto label$2571;
					{
						free( FBFILENAME$1 );
						FBFILENAME$1 = (void*)0;
					}
					label$2571:;
					label$2570:;
				}
				label$2567:;
				label$2566:;
			}
			label$2563:;
			N$3 = N$3 + -1;
			label$2562:;
			if( N$3 >= 0 ) goto label$2565;
			label$2564:;
		}
	}
	label$2561:;
	label$2560:;
	fb$result$1 = (FB$ERRORNUMBERS)IRESULT$1;
	goto label$2541;
	label$2541:;
	return fb$result$1;
}

static inline longint fb_FileSize( integer IFILENUM$1 )
{
	struct FB$FBFILE* TMP$634$1;
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$2572:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2575;
	fb$result$1 = -1ll;
	goto label$2573;
	label$2575:;
	TMP$634$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( *(struct _IO_FILE**)TMP$634$1 != 0 ) goto label$2577;
	fb$result$1 = -1ll;
	goto label$2573;
	label$2577:;
	fb$result$1 = *(longint*)((ubyte*)TMP$634$1 + 8);
	goto label$2573;
	label$2573:;
	return fb$result$1;
}

static        integer fb_FileSeekLarge( integer IFILENUM$1, longint IFILEPOS$1 )
{
	struct FB$FBFILE* TMP$635$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2578:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2581;
	fb$result$1 = 1;
	goto label$2579;
	label$2581:;
	TMP$635$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( (-(*(struct _IO_FILE**)TMP$635$1 == 0) | -(IFILEPOS$1 == 0ll)) == 0 ) goto label$2583;
	fb$result$1 = 1;
	goto label$2579;
	label$2583:;
	integer vr$4169 = fseek( *(struct _IO_FILE**)TMP$635$1, (integer)(IFILEPOS$1 + -1ll), 0 );
	if( vr$4169 != 0 ) goto label$2585;
	{
		fb$result$1 = 0;
		goto label$2579;
	}
	goto label$2584;
	label$2585:;
	{
		fb$result$1 = 3;
		goto label$2579;
	}
	label$2584:;
	label$2579:;
	return fb$result$1;
}

static        integer fb_FileSeek( integer IFILENUM$1, uinteger IFILEPOS$1 )
{
	struct FB$FBFILE* TMP$636$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2586:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2589;
	fb$result$1 = 1;
	goto label$2587;
	label$2589:;
	TMP$636$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( (-(*(struct _IO_FILE**)TMP$636$1 == 0) | -(IFILEPOS$1 == 0)) == 0 ) goto label$2591;
	fb$result$1 = 1;
	goto label$2587;
	label$2591:;
	integer vr$4180 = fseek( *(struct _IO_FILE**)TMP$636$1, (integer)(IFILEPOS$1 + -1), 0 );
	if( vr$4180 != 0 ) goto label$2593;
	{
		fb$result$1 = 0;
		goto label$2587;
	}
	goto label$2592;
	label$2593:;
	{
		fb$result$1 = 3;
		goto label$2587;
	}
	label$2592:;
	label$2587:;
	return fb$result$1;
}

static        longint fb_FileTell( integer IFILENUM$1 )
{
	struct FB$FBFILE* TMP$637$1;
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$2594:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2597;
	fb$result$1 = -1ll;
	goto label$2595;
	label$2597:;
	TMP$637$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( *(struct _IO_FILE**)TMP$637$1 != 0 ) goto label$2599;
	fb$result$1 = -1ll;
	goto label$2595;
	label$2599:;
	integer vr$4187 = ftell( *(struct _IO_FILE**)TMP$637$1 );
	fb$result$1 = (longint)(vr$4187 + 1);
	goto label$2595;
	label$2595:;
	return fb$result$1;
}

static        integer fb_FileEof( integer IFILENUM$1 )
{
	struct FB$FBFILE* TMP$638$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2600:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2603;
	fb$result$1 = -1;
	goto label$2601;
	label$2603:;
	TMP$638$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( *(struct _IO_FILE**)TMP$638$1 != 0 ) goto label$2605;
	fb$result$1 = -1;
	goto label$2601;
	label$2605:;
	longint vr$4195 = fb_FileTell( IFILENUM$1 );
	longint vr$4196 = fb_FileSize( IFILENUM$1 );
	fb$result$1 = -(vr$4195 >= vr$4196);
	goto label$2601;
	label$2601:;
	return fb$result$1;
}

static        integer fb_FileClose( integer IFILENUM$1 )
{
	struct FB$FBFILE* TMP$639$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2606:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2609;
	fb$result$1 = 1;
	goto label$2607;
	label$2609:;
	TMP$639$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( *(struct _IO_FILE**)TMP$639$1 != 0 ) goto label$2611;
	fb$result$1 = 1;
	goto label$2607;
	label$2611:;
	fclose( *(struct _IO_FILE**)TMP$639$1 );
	*(struct _IO_FILE**)TMP$639$1 = (struct _IO_FILE*)0;
	*(integer*)((ubyte*)TMP$639$1 + 4) = 0;
	*(longint*)((ubyte*)TMP$639$1 + 8) = 0ll;
	fb$result$1 = 0;
	goto label$2607;
	label$2607:;
	return fb$result$1;
}

static        integer fb_FileGet( integer IFILENUM$1, uinteger ISEEK$1, void* PBUFFER$1, integer IAMOUNT$1 )
{
	struct FB$FBFILE* TMP$640$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2612:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2615;
	fb$result$1 = -1;
	goto label$2613;
	label$2615:;
	TMP$640$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( (-(*(struct _IO_FILE**)TMP$640$1 == 0) | -(PBUFFER$1 == 0)) == 0 ) goto label$2617;
	fb$result$1 = -1;
	goto label$2613;
	label$2617:;
	if( ISEEK$1 == 0u ) goto label$2619;
	fb_FileSeek( IFILENUM$1, ISEEK$1 );              
	label$2619:;
	fread( PBUFFER$1, 1u, (uinteger)IAMOUNT$1, *(struct _IO_FILE**)TMP$640$1 );
	label$2613:;
	return fb$result$1;
}

static        integer fb_FilePut( integer IFILENUM$1, uinteger ISEEK$1, void* PBUFFER$1, integer IAMOUNT$1 )
{
	struct FB$FBFILE* TMP$641$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2620:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2623;
	fb$result$1 = -1;
	goto label$2621;
	label$2623:;
	TMP$641$1 = (struct FB$FBFILE*)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	if( (-(*(struct _IO_FILE**)TMP$641$1 == 0) | -(PBUFFER$1 == 0)) == 0 ) goto label$2625;
	fb$result$1 = -1;
	goto label$2621;
	label$2625:;
	if( ISEEK$1 == 0u ) goto label$2627;
	fb_FileSeek( IFILENUM$1, ISEEK$1 );              
	label$2627:;
	fwrite( PBUFFER$1, 1u, (uinteger)IAMOUNT$1, *(struct _IO_FILE**)TMP$641$1 );
	label$2621:;
	return fb$result$1;
}

static        integer fb_FileLineInput( integer IFILENUM$1, void* FBTARGET$1, integer UNK0$1, integer UNK1$1 )
{
	struct FBSTRING* TMP$645$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2628:;
	if( UNK0$1 == -1 ) goto label$2631;
	printf( (char*)"fb_FileLineInput unk0 = %i", UNK0$1 );
	label$2631:;
	if( UNK1$1 == 0 ) goto label$2633;
	printf( (char*)"fb_FileLineInput unk1 = %i", UNK1$1 );
	label$2633:;
	if( (uinteger)IFILENUM$1 <= 127 ) goto label$2635;
	fb$result$1 = -1;
	goto label$2629;
	label$2635:;
	void* INFILE$1;
	INFILE$1 = (void*)*(struct _IO_FILE**)(((ubyte*)_ZN2FB5FNUM$E + (IFILENUM$1 << 4)) + -16);
	void* RESULT$1;
	__builtin_memset( &RESULT$1, 0, 4 );
	if( INFILE$1 != 0 ) goto label$2637;
	fb$result$1 = -1;
	goto label$2629;
	label$2637:;
	integer READSIZE$1;
	__builtin_memset( &READSIZE$1, 0, 4 );
	integer CURPOSI$1;
	integer vr$4230 = ftell( (struct _IO_FILE*)INFILE$1 );
	CURPOSI$1 = vr$4230;
	integer vr$4231 = fb_FileEof( IFILENUM$1 );              
	if( vr$4231 == 0 ) goto label$2639;
	printf( (char*)"????\n" );
	fb$result$1 = 0;
	goto label$2629;
	label$2639:;
	TMP$645$1 = (struct FBSTRING*)FBTARGET$1;
	integer WASTEMP$1;
	WASTEMP$1 = *(integer*)((ubyte*)TMP$645$1 + 8) & -2147483648u;
	if( *(integer*)((ubyte*)TMP$645$1 + 8) != -1 ) goto label$2641;
	printf( (char*)"FileLineInput CONST %x\n", (uinteger)FBTARGET$1 );
	fb_Beep(  );
	fb_Sleep( -1 );
	label$2641:;
	*(integer*)((ubyte*)TMP$645$1 + 8) = 0;
	static integer BUFFERINCREMENT$1 = 96;
	if( BUFFERINCREMENT$1 <= 256 ) goto label$2643;
	BUFFERINCREMENT$1 = 256;
	label$2643:;
	label$2644:;
	{
		integer TMP$647$2;
		if( BUFFERINCREMENT$1 >= 4 ) goto label$2648;
		BUFFERINCREMENT$1 = 4;
		label$2648:;
		void* vr$4239 = realloc( *(void**)TMP$645$1, (uinteger)(*(integer*)((ubyte*)TMP$645$1 + 8) + BUFFERINCREMENT$1) );
		*(char**)TMP$645$1 = (char*)vr$4239;
		uinteger vr$4244 = fread( (void*)((ubyte*)*(char**)TMP$645$1 + *(integer*)((ubyte*)TMP$645$1 + 8)), 1u, (uinteger)BUFFERINCREMENT$1, (struct _IO_FILE*)INFILE$1 );
		READSIZE$1 = (integer)vr$4244;
		BUFFERINCREMENT$1 = (BUFFERINCREMENT$1 + (READSIZE$1 * 7)) >> 3;
		if( READSIZE$1 <= 1 ) goto label$2650;
		{
			void* vr$4251 = memchr( (void*)((ubyte*)*(char**)TMP$645$1 + *(integer*)((ubyte*)TMP$645$1 + 8)), 10, (uinteger)READSIZE$1 );
			RESULT$1 = vr$4251;
		}
		goto label$2649;
		label$2650:;
		{
			RESULT$1 = (void*)0;
		}
		label$2649:;
		*(integer*)((ubyte*)TMP$645$1 + 8) = *(integer*)((ubyte*)TMP$645$1 + 8) + READSIZE$1;
		if( RESULT$1 != 0 ) goto label$2651;
		TMP$647$2 = -(-(READSIZE$1 < BUFFERINCREMENT$1) != 0);
		goto label$2661;
		label$2651:;
		TMP$647$2 = -1;
		label$2661:;
		if( TMP$647$2 == 0 ) goto label$2653;
		{
			if( RESULT$1 == (void*)0 ) goto label$2655;
			{
				integer TMP$648$4;
				fseek( (struct _IO_FILE*)INFILE$1, (integer)((integer)(CURPOSI$1 + (uinteger)RESULT$1) - *(uinteger*)TMP$645$1) + 1, 0 );
				if( -(RESULT$1 != *(char**)TMP$645$1) == 0 ) goto label$2656;
				TMP$648$4 = -(-((uinteger)*(ubyte*)((ubyte*)RESULT$1 + -1) == 13) != 0);
				goto label$2662;
				label$2656:;
				TMP$648$4 = 0;
				label$2662:;
				if( TMP$648$4 == 0 ) goto label$2658;
				RESULT$1 = (void*)((ubyte*)RESULT$1 + -1);
				label$2658:;
				*(integer*)((ubyte*)TMP$645$1 + 8) = (integer)((uinteger)RESULT$1 - *(uinteger*)TMP$645$1);
			}
			label$2655:;
			label$2654:;
			*(integer*)((ubyte*)TMP$645$1 + 4) = *(integer*)((ubyte*)TMP$645$1 + 8);
			*(integer*)((ubyte*)TMP$645$1 + 8) = *(integer*)((ubyte*)TMP$645$1 + 8) + 1;
			void* vr$4278 = realloc( *(void**)TMP$645$1, *(uinteger*)((ubyte*)TMP$645$1 + 8) );
			*(char**)TMP$645$1 = (char*)vr$4278;
			*(ubyte*)(*(ubyte**)TMP$645$1 + *(integer*)((ubyte*)TMP$645$1 + 4)) = (ubyte)0;
			if( *(integer*)((ubyte*)TMP$645$1 + 8) >= 0 ) goto label$2660;
			string* vr$4284 = fb_StrAllocTempDescZEx( (char*)"wtf?", 4 );
			fb_PrintString( 0, vr$4284, 1 );
			label$2660:;
			*(integer*)((ubyte*)TMP$645$1 + 8) = *(integer*)((ubyte*)TMP$645$1 + 8) | WASTEMP$1;
			fb$result$1 = *(integer*)((ubyte*)TMP$645$1 + 4);
			goto label$2629;
		}
		label$2653:;
		label$2652:;
	}
	label$2646:;
	goto label$2644;
	label$2645:;
	label$2629:;
	return fb$result$1;
}

static        integer fb_WildMatch( char* ZFILTER$1, char* ZFILE$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2663:;
	ubyte* PFILTER$1;
	PFILTER$1 = (ubyte*)ZFILTER$1;
	ubyte* PFILE$1;
	PFILE$1 = (ubyte*)ZFILE$1;
	integer IFILTER$1;
	__builtin_memset( &IFILTER$1, 0, 4 );
	integer IFILE$1;
	__builtin_memset( &IFILE$1, 0, 4 );
	integer ILAST$1;
	ILAST$1 = -1;
	integer IMID$1;
	IMID$1 = 0;
	integer IFOUND$1;
	IFOUND$1 = 0;
	label$2665:;
	{
		ubyte ICHAR$2;
		ICHAR$2 = *(ubyte*)(PFILTER$1 + IFILTER$1);
		{
			if( (uinteger)ICHAR$2 == 0 ) goto label$2670;
			label$2671:;
			if( (uinteger)ICHAR$2 == 63u ) goto label$2670;
			label$2672:;
			if( (uinteger)ICHAR$2 != 42u ) goto label$2669;
			label$2670:;
			{
				if( ILAST$1 == -1 ) goto label$2674;
				{
					if( IMID$1 != 0 ) goto label$2676;
					{
						{
							integer CNT$7;
							CNT$7 = 0;
							integer TMP$650$7;
							TMP$650$7 = (IFILTER$1 - ILAST$1) + -1;
							goto label$2677;
							label$2680:;
							{
								if( (uinteger)*(ubyte*)((ubyte*)(PFILTER$1 + ILAST$1) + CNT$7) == (uinteger)*(ubyte*)((ubyte*)(PFILE$1 + IFILE$1) + CNT$7) ) goto label$2682;
								goto label$2666;
								label$2682:;
							}
							label$2678:;
							CNT$7 = CNT$7 + 1;
							label$2677:;
							if( CNT$7 <= TMP$650$7 ) goto label$2680;
							label$2679:;
						}
						IFILE$1 = (IFILE$1 + IFILTER$1) - ILAST$1;
					}
					goto label$2675;
					label$2676:;
					{
						integer ITEMP$6;
						ITEMP$6 = IFILE$1;
						label$2683:;
						{
							if( (uinteger)*(ubyte*)(PFILE$1 + ITEMP$6) != (uinteger)*(ubyte*)(PFILTER$1 + ILAST$1) ) goto label$2687;
							{
								{
									integer CNT$9;
									CNT$9 = 1;
									integer TMP$651$9;
									TMP$651$9 = (IFILTER$1 - ILAST$1) + -((uinteger)ICHAR$2 != 0);
									goto label$2688;
									label$2691:;
									{
										if( (uinteger)*(ubyte*)((ubyte*)(PFILTER$1 + ILAST$1) + CNT$9) == (uinteger)*(ubyte*)((ubyte*)(PFILE$1 + ITEMP$6) + CNT$9) ) goto label$2693;
										{
											ITEMP$6 = ITEMP$6 + 1;
											goto label$2685;
										}
										label$2693:;
										label$2692:;
									}
									label$2689:;
									CNT$9 = CNT$9 + 1;
									label$2688:;
									if( CNT$9 <= TMP$651$9 ) goto label$2691;
									label$2690:;
								}
								IFILE$1 = (ITEMP$6 + IFILTER$1) - ILAST$1;
								goto label$2684;
							}
							goto label$2686;
							label$2687:;
							{
								if( (uinteger)*(ubyte*)(PFILE$1 + ITEMP$6) != 0 ) goto label$2695;
								goto label$2666;
								label$2695:;
							}
							label$2686:;
							ITEMP$6 = ITEMP$6 + 1;
						}
						label$2685:;
						goto label$2683;
						label$2684:;
					}
					label$2675:;
				}
				label$2674:;
				label$2673:;
				if( (uinteger)ICHAR$2 != 0 ) goto label$2697;
				IFOUND$1 = -((uinteger)*(ubyte*)(PFILE$1 + IFILE$1) == 0);
				goto label$2666;
				label$2697:;
				ILAST$1 = -1;
				if( (uinteger)ICHAR$2 != 63u ) goto label$2699;
				{
					IFILE$1 = IFILE$1 - -((uinteger)*(ubyte*)(PFILE$1 + IFILE$1) != 0);
					IFILTER$1 = IFILTER$1 + 1;
					goto label$2667;
				}
				label$2699:;
				label$2698:;
				ILAST$1 = IFILTER$1 + 1;
				if( (uinteger)ICHAR$2 != 42u ) goto label$2701;
				IMID$1 = 1;
				label$2701:;
			}
			goto label$2668;
			label$2669:;
			{
				if( ILAST$1 != -1 ) goto label$2704;
				ILAST$1 = IFILTER$1;
				label$2704:;
			}
			label$2702:;
			label$2668:;
		}
		IFILTER$1 = IFILTER$1 + 1;
	}
	label$2667:;
	goto label$2665;
	label$2666:;
	fb$result$1 = IFOUND$1;
	goto label$2664;
	label$2664:;
	return fb$result$1;
}

static        void* fb_Dir_Proto( void* FBQUERYSTRING$1, integer IFLAGS$1, integer* POUTATT$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2705:;
	static string SFILTER$1;
	static integer IATTR$1;
	static struct DIR* PDIR$1;
	if( FBQUERYSTRING$1 == (void*)0 ) goto label$2708;
	{
		if( PDIR$1 == (struct DIR*)0 ) goto label$2710;
		closedir( PDIR$1 );
		PDIR$1 = (struct DIR*)0;
		label$2710:;
		if( *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) != 0 ) goto label$2712;
		void* vr$4345 = fb_StrAllocTempResult( (void*)0 );              
		fb$result$1 = vr$4345;
		goto label$2706;
		label$2712:;
		if( *(char**)FBQUERYSTRING$1 != 0 ) goto label$2714;
		void* vr$4347 = fb_StrAllocTempResult( (void*)0 );              
		fb$result$1 = vr$4347;
		goto label$2706;
		label$2714:;
		integer ITEMP$2;
		integer IPATH$2;
		IPATH$2 = -1;
		string SPATH$2;
		__builtin_memset( &SPATH$2, 0, 12 );
		ubyte* PCHAR$2;
		PCHAR$2 = (ubyte*)*(char**)FBQUERYSTRING$1;
		{
			integer CNT$3;
			CNT$3 = *(integer*)((ubyte*)FBQUERYSTRING$1 + 4) + -1;
			goto label$2715;
			label$2718:;
			{
				if( (uinteger)*(ubyte*)(PCHAR$2 + CNT$3) != 47u ) goto label$2720;
				{
					ITEMP$2 = (integer)*(ubyte*)((ubyte*)(PCHAR$2 + CNT$3) + 1);
					*(ubyte*)((ubyte*)(PCHAR$2 + CNT$3) + 1) = (ubyte)0;
					fb_StrAssign( (void*)&SPATH$2, -1, *(void**)FBQUERYSTRING$1, 0, 0 );
					*(ubyte*)((ubyte*)(PCHAR$2 + CNT$3) + 1) = (ubyte)ITEMP$2;
					IPATH$2 = CNT$3 + 1;
					goto label$2717;
				}
				label$2720:;
				label$2719:;
			}
			label$2716:;
			CNT$3 = CNT$3 + -1;
			label$2715:;
			if( CNT$3 >= 0 ) goto label$2718;
			label$2717:;
		}
		if( IPATH$2 != -1 ) goto label$2722;
		IPATH$2 = 0;
		fb_StrAssign( (void*)&SPATH$2, -1, (void*)"./", 3, 0 );
		label$2722:;
		fb_StrAssign( (void*)&SFILTER$1, -1, (void*)((ubyte*)*(char**)FBQUERYSTRING$1 + IPATH$2), 0, 0 );
		IATTR$1 = IFLAGS$1;
		struct DIR* vr$4366 = opendir( *(char**)&SPATH$2 );
		PDIR$1 = vr$4366;
		if( FBQUERYSTRING$1 == (void*)0 ) goto label$2724;
		{
			{
				long N$4;
				N$4 = TEMPSTRINGCOUNT$ + -1;
				goto label$2725;
				label$2728:;
				{
					if( FBQUERYSTRING$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) ) goto label$2730;
					{
						struct FBSTRING* TMP$654$6;
						void* PTEMP$6;
						PTEMP$6 = FBQUERYSTRING$1;
						{
							void* TMP$653$7;
							TMP$653$7 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$4 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
							*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$653$7;
						}
						TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
						TMP$654$6 = (struct FBSTRING*)FBQUERYSTRING$1;
						integer ISTEMP$6;
						ISTEMP$6 = -((*(uinteger*)((ubyte*)TMP$654$6 + 8) & -1048576) == -2147483648u);
						if( *(char**)TMP$654$6 == (char*)0 ) goto label$2732;
						free( *(void**)TMP$654$6 );
						*(char**)TMP$654$6 = (char*)0;
						*(integer*)((ubyte*)TMP$654$6 + 4) = 0;
						*(integer*)((ubyte*)TMP$654$6 + 8) = 0;
						label$2732:;
						if( ISTEMP$6 == 0 ) goto label$2734;
						{
							free( FBQUERYSTRING$1 );
							FBQUERYSTRING$1 = (void*)0;
						}
						label$2734:;
						label$2733:;
					}
					label$2730:;
					label$2729:;
				}
				label$2726:;
				N$4 = N$4 + -1;
				label$2725:;
				if( N$4 >= 0 ) goto label$2728;
				label$2727:;
			}
		}
		label$2724:;
		label$2723:;
		fb_StrDelete( &SPATH$2 );
	}
	label$2708:;
	label$2707:;
	if( PDIR$1 != 0 ) goto label$2736;
	{
		void* vr$4386 = fb_StrAllocTempResult( (void*)0 );              
		fb$result$1 = vr$4386;
		goto label$2706;
	}
	goto label$2735;
	label$2736:;
	{
		struct DIRENT* PENT$2;
		__builtin_memset( &PENT$2, 0, 4 );
		integer IATT$2;
		__builtin_memset( &IATT$2, 0, 4 );
		label$2737:;
		{
			struct DIRENT* vr$4389 = readdir( PDIR$1 );
			PENT$2 = vr$4389;
			if( PENT$2 != 0 ) goto label$2741;
			closedir( PDIR$1 );
			PDIR$1 = (struct DIR*)0;
			void* vr$4390 = fb_StrAllocTempResult( (void*)0 );              
			fb$result$1 = vr$4390;
			goto label$2706;
			label$2741:;
			if( (uinteger)*(ubyte*)((ubyte*)PENT$2 + 4) != 4 ) goto label$2743;
			IATT$2 = 16;
			goto label$2742;
			label$2743:;
			IATT$2 = 33;
			label$2742:;
			if( (IATT$2 & IATTR$1) == 0 ) goto label$2745;
			{
				integer TMP$655$4;
				integer vr$4394 = fb_StrLen( (void*)&SFILTER$1, -1 );
				if( -(vr$4394 == 0) != 0 ) goto label$2746;
				integer vr$4398 = fb_WildMatch( *(char**)&SFILTER$1, (char*)((ubyte*)PENT$2 + 5) );              
				TMP$655$4 = -(vr$4398 != 0);
				goto label$2765;
				label$2746:;
				TMP$655$4 = -1;
				label$2765:;
				if( TMP$655$4 == 0 ) goto label$2748;
				{
					struct FBSTRING* TMP$658$5;
					struct FBSTRING* TMP$659$5;
					if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2750;
					{
						if( _ZN2FB12DESTROYTEMP$E == (struct FBSTRING*)0 ) goto label$2752;
						{
							{
								long N$8;
								N$8 = TEMPSTRINGCOUNT$ + -1;
								goto label$2753;
								label$2756:;
								{
									if( _ZN2FB12DESTROYTEMP$E != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) ) goto label$2758;
									{
										struct FBSTRING* TMP$657$10;
										struct FBSTRING* PTEMP$10;
										PTEMP$10 = _ZN2FB12DESTROYTEMP$E;
										{
											void* TMP$656$11;
											TMP$656$11 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$8 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
											*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$656$11;
										}
										TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
										TMP$657$10 = _ZN2FB12DESTROYTEMP$E;
										integer ISTEMP$10;
										ISTEMP$10 = -((*(uinteger*)((ubyte*)TMP$657$10 + 8) & -1048576) == -2147483648u);
										if( *(char**)TMP$657$10 == (char*)0 ) goto label$2760;
										free( *(void**)TMP$657$10 );
										*(char**)TMP$657$10 = (char*)0;
										*(integer*)((ubyte*)TMP$657$10 + 4) = 0;
										*(integer*)((ubyte*)TMP$657$10 + 8) = 0;
										label$2760:;
										if( ISTEMP$10 == 0 ) goto label$2762;
										{
											free( (void*)_ZN2FB12DESTROYTEMP$E );
											_ZN2FB12DESTROYTEMP$E = (struct FBSTRING*)0;
										}
										label$2762:;
										label$2761:;
									}
									label$2758:;
									label$2757:;
								}
								label$2754:;
								N$8 = N$8 + -1;
								label$2753:;
								if( N$8 >= 0 ) goto label$2756;
								label$2755:;
							}
						}
						label$2752:;
						label$2751:;
					}
					label$2750:;
					label$2749:;
					void* vr$4418 = malloc( 16u );
					_ZN2FB11TEMPSTRING$E = (struct FBSTRING*)vr$4418;
					*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)TEMPSTRINGCOUNT$ << 2)) = (void*)_ZN2FB11TEMPSTRING$E;
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + 1;
					TMP$658$5 = _ZN2FB11TEMPSTRING$E;
					*(char**)TMP$658$5 = (char*)0;
					*(integer*)((ubyte*)TMP$658$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$658$5 + 8) = -2147483648u;
					TMP$659$5 = _ZN2FB11TEMPSTRING$E;
					uinteger vr$4426 = strlen( (char*)((ubyte*)PENT$2 + 5) );
					*(integer*)((ubyte*)TMP$659$5 + 4) = (integer)vr$4426;
					*(integer*)((ubyte*)TMP$659$5 + 8) = *(integer*)((ubyte*)TMP$659$5 + 8) | (*(integer*)((ubyte*)TMP$659$5 + 4) + 1);
					void* vr$4435 = malloc( (uinteger)(*(integer*)((ubyte*)TMP$659$5 + 4) + 1) );
					*(char**)TMP$659$5 = (char*)vr$4435;
					memcpy( *(void**)TMP$659$5, (void*)((ubyte*)PENT$2 + 5), (uinteger)(*(integer*)((ubyte*)TMP$659$5 + 4) + 1) );
					if( POUTATT$1 == (integer*)0 ) goto label$2764;
					*POUTATT$1 = IATT$2;
					label$2764:;
					fb$result$1 = (void*)_ZN2FB11TEMPSTRING$E;
					goto label$2706;
				}
				label$2748:;
				label$2747:;
			}
			label$2745:;
			label$2744:;
		}
		label$2739:;
		goto label$2737;
		label$2738:;
	}
	label$2735:;
	label$2706:;
	return fb$result$1;
}

static inline void* fb_Dir( void* FBQUERYSTRING$1, integer IFLAGS$1, integer* IOUTATT$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2766:;
	void* vr$4445 = fb_Dir_Proto( FBQUERYSTRING$1, IFLAGS$1, IOUTATT$1 );              
	fb$result$1 = vr$4445;
	goto label$2767;
	label$2767:;
	return fb$result$1;
}

static inline void* fb_DirNext( integer* IOUTATT$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2768:;
	void* vr$4448 = fb_Dir_Proto( (void*)0, 0, IOUTATT$1 );              
	fb$result$1 = vr$4448;
	goto label$2769;
	label$2769:;
	return fb$result$1;
}

static inline integer fb_MkDir( void* FBSTRINGDIRECTORY$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2770:;
	integer vr$4452 = mkdir( *(char**)FBSTRINGDIRECTORY$1, 511 );
	fb$result$1 = vr$4452;
	goto label$2771;
	label$2771:;
	return fb$result$1;
}

static inline void fb_End( integer IEXITCODE$1 )
{
	label$2772:;
	exit( IEXITCODE$1 );
	label$2773:;
}

static        void fb_ArrayStrErase( void* FBARRAY$1 )
{
	struct FB_ARRAYDESC* TMP$660$1;
	label$2774:;
	if( FBARRAY$1 != 0 ) goto label$2777;
	goto label$2775;
	label$2777:;
	TMP$660$1 = (struct FB_ARRAYDESC*)FBARRAY$1;
	if( *(void**)((ubyte*)TMP$660$1 + 4) == (void*)0 ) goto label$2779;
	{
		struct FBSTRING* STRINGELEMENT$2;
		__builtin_memset( &STRINGELEMENT$2, 0, 4 );
		{
			integer CNT$3;
			CNT$3 = 0;
			integer TMP$661$3;
			TMP$661$3 = (*(integer*)((ubyte*)TMP$660$1 + 8) / 12) + -1;
			goto label$2780;
			label$2783:;
			{
				if( *(char**)((ubyte*)STRINGELEMENT$2 + (CNT$3 * 12)) == (char*)0 ) goto label$2785;
				fb_StrDelete( (void*)((ubyte*)STRINGELEMENT$2 + (CNT$3 * 12)) );              
				label$2785:;
			}
			label$2781:;
			CNT$3 = CNT$3 + 1;
			label$2780:;
			if( CNT$3 <= TMP$661$3 ) goto label$2783;
			label$2782:;
		}
		free( *(void**)((ubyte*)TMP$660$1 + 4) );
	}
	label$2779:;
	label$2778:;
	memset( FBARRAY$1, 0, 4u );
	label$2775:;
}

static        integer fb_ArrayErase( void* FBARRAY$1 )
{
	struct FB_ARRAYDESC* TMP$662$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2786:;
	if( FBARRAY$1 != 0 ) goto label$2789;
	fb$result$1 = 0;
	goto label$2787;
	label$2789:;
	TMP$662$1 = (struct FB_ARRAYDESC*)FBARRAY$1;
	if( *(void**)((ubyte*)TMP$662$1 + 4) == (void*)0 ) goto label$2791;
	free( *(void**)((ubyte*)TMP$662$1 + 4) );
	label$2791:;
	memset( FBARRAY$1, 0, 4u );
	fb$result$1 = -1;
	goto label$2787;
	label$2787:;
	return fb$result$1;
}

static        integer fb_ArrayEraseStr( void* FBARRAY$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2792:;
	if( FBARRAY$1 != 0 ) goto label$2795;
	fb$result$1 = 0;
	goto label$2793;
	label$2795:;
	fb_ArrayStrErase( FBARRAY$1 );              
	fb$result$1 = -1;
	goto label$2793;
	label$2793:;
	return fb$result$1;
}

static        integer fb_ArrayDestructStr( void* FBARRAY$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2796:;
	if( FBARRAY$1 != 0 ) goto label$2799;
	fb$result$1 = 0;
	goto label$2797;
	label$2799:;
	fb_ArrayStrErase( FBARRAY$1 );              
	fb$result$1 = -1;
	goto label$2797;
	label$2797:;
	return fb$result$1;
}

static        integer fb_ArrayRedimEx( void* FBARRAY$1, integer IITEMSZ$1, integer IDOCLEAR$1, integer IISSTRING$1, integer IDEPTH$1, ... )
{
	struct FB_ARRAYDESC* TMP$663$1;
	integer TMP$664$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2800:;
	if( (-(FBARRAY$1 == 0) | -(IITEMSZ$1 <= 0)) == 0 ) goto label$2803;
	fb$result$1 = 0;
	goto label$2801;
	label$2803:;
	TMP$663$1 = (struct FB_ARRAYDESC*)FBARRAY$1;
	if( IISSTRING$1 == 0 ) goto label$2804;
	TMP$664$1 = -(*(void**)((ubyte*)TMP$663$1 + 4) != 0);
	goto label$2821;
	label$2804:;
	TMP$664$1 = 0;
	label$2821:;
	if( TMP$664$1 == 0 ) goto label$2806;
	fb_ArrayStrErase( FBARRAY$1 );              
	label$2806:;
	if( IDEPTH$1 > 0 ) goto label$2808;
	IDEPTH$1 = *(integer*)((ubyte*)TMP$663$1 + 16);
	goto label$2807;
	label$2808:;
	*(integer*)((ubyte*)TMP$663$1 + 16) = IDEPTH$1;
	label$2807:;
	*(integer*)((ubyte*)TMP$663$1 + 12) = IITEMSZ$1;
	*(integer*)((ubyte*)TMP$663$1 + 8) = IITEMSZ$1;
	integer ILBOUND$1;
	__builtin_memset( &ILBOUND$1, 0, 4 );
	integer IUBOUND$1;
	__builtin_memset( &IUBOUND$1, 0, 4 );
	void* ARG$1;
	ARG$1 = (void*)((ubyte*)&IDEPTH$1 + 4);
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$665$2;
		TMP$665$2 = IDEPTH$1 + -1;
		goto label$2809;
		label$2812:;
		{
			struct FB_ARRAYDIMTB* TMP$667$3;
			ILBOUND$1 = *(integer*)ARG$1;
			ARG$1 = (void*)((ubyte*)ARG$1 + 4);
			IUBOUND$1 = *(integer*)ARG$1;
			ARG$1 = (void*)((ubyte*)ARG$1 + 4);
			if( ILBOUND$1 == 0 ) goto label$2814;
			string* vr$4492 = fb_StrAllocTempDescZEx( (char*)"Bounds: ", 8 );
			fb_PrintString( 0, vr$4492, 0 );
			fb_PrintInt( 0, ILBOUND$1, 0 );
			string* vr$4493 = fb_StrAllocTempDescZEx( (char*)",", 1 );
			fb_PrintString( 0, vr$4493, 0 );
			fb_PrintInt( 0, IUBOUND$1, 1 );
			label$2814:;
			*(integer*)((ubyte*)TMP$663$1 + 8) = *(integer*)((ubyte*)TMP$663$1 + 8) * ((IUBOUND$1 - ILBOUND$1) + 1);
			TMP$667$3 = (struct FB_ARRAYDIMTB*)((ubyte*)((ubyte*)TMP$663$1 + (CNT$2 * 12)) + 20);
			*(integer*)((ubyte*)TMP$667$3 + 4) = ILBOUND$1;
			*(integer*)((ubyte*)TMP$667$3 + 8) = IUBOUND$1;
			*(integer*)TMP$667$3 = (IUBOUND$1 - ILBOUND$1) + 1;
		}
		label$2810:;
		CNT$2 = CNT$2 + 1;
		label$2809:;
		if( CNT$2 <= TMP$665$2 ) goto label$2812;
		label$2811:;
	}
	if( (*(integer*)((ubyte*)TMP$663$1 + 8) & 3) == 0 ) goto label$2816;
	*(integer*)((ubyte*)TMP$663$1 + 8) = (*(integer*)((ubyte*)TMP$663$1 + 8) | 3) + 1;
	label$2816:;
	void* vr$4516 = realloc( *(void**)((ubyte*)TMP$663$1 + 4), *(uinteger*)((ubyte*)TMP$663$1 + 8) );
	*(void**)((ubyte*)TMP$663$1 + 4) = vr$4516;
	*(void**)TMP$663$1 = *(void**)((ubyte*)TMP$663$1 + 4);
	if( *(void**)((ubyte*)TMP$663$1 + 4) != 0 ) goto label$2818;
	printf( (char*)"%i: %s\n", 3191, (char*)"Failed to allocate!" );
	fb_Sleep( -1 );
	label$2818:;
	if( IDOCLEAR$1 == 0 ) goto label$2820;
	memset( *(void**)((ubyte*)TMP$663$1 + 4), 0, *(uinteger*)((ubyte*)TMP$663$1 + 8) );
	label$2820:;
	fb$result$1 = -1;
	goto label$2801;
	label$2801:;
	return fb$result$1;
}

static inline integer fb_ArrayLBound( void* FBARRAY$1, integer IDEPTH$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2822:;
	if( (-(FBARRAY$1 == 0) | -(IDEPTH$1 > 7)) == 0 ) goto label$2825;
	fb$result$1 = 0;
	goto label$2823;
	label$2825:;
	fb$result$1 = *(integer*)((ubyte*)((ubyte*)FBARRAY$1 + (IDEPTH$1 * 12)) + 24);
	goto label$2823;
	label$2823:;
	return fb$result$1;
}

static inline integer fb_ArrayUBound( void* FBARRAY$1, integer IDEPTH$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2826:;
	if( (-(FBARRAY$1 == 0) | -(IDEPTH$1 > 7)) == 0 ) goto label$2829;
	fb$result$1 = 0;
	goto label$2827;
	label$2829:;
	fb$result$1 = *(integer*)((ubyte*)((ubyte*)FBARRAY$1 + (IDEPTH$1 * 12)) + 28);
	goto label$2827;
	label$2827:;
	return fb$result$1;
}

static        longint fb_FileLen( char* ZFILENAME$1 )
{
	longint fb$result$1;
	__builtin_memset( &fb$result$1, 0, 8 );
	label$2830:;
	integer FILESTAT$1[32];
	__builtin_memset( (integer*)FILESTAT$1, 0, 128 );
	struct TMP$671 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$671 tmp$670$1;
	*(integer**)&tmp$670$1 = (integer*)FILESTAT$1;
	*(integer**)((ubyte*)&tmp$670$1 + 4) = (integer*)FILESTAT$1;
	*(integer*)((ubyte*)&tmp$670$1 + 8) = 128;
	*(integer*)((ubyte*)&tmp$670$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$670$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$670$1 + 20) = 32;
	*(integer*)((ubyte*)&tmp$670$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$670$1 + 28) = 31;
	stat( ZFILENAME$1, (struct STAT*)FILESTAT$1 );
	fb$result$1 = (longint)*(integer*)((ubyte*)FILESTAT$1 + 24);
	goto label$2831;
	label$2831:;
	return fb$result$1;
}

static inline void KeyboardShowHideSync( void* ID$1 )
{
	label$2832:;
	keyboardShow(  );
	goto label$2833;
	label$2833:;
}

static inline void fb_ShowKeyboard( void )
{
	label$2848:;
	_ZN2FB13KEYBOARDISON$E = (byte)1;
	*(integer*)((ubyte*)FBKEYBOARD$ + 12) = -192 + (integer)_ZN2FB15KEYBOARDOFFSET$E;
	keyboardShow(  );
	label$2849:;
}

static inline void fb_HideKeyboard( void )
{
	label$2850:;
	_ZN2FB13KEYBOARDISON$E = (byte)0;
	*(integer*)((ubyte*)FBKEYBOARD$ + 12) = -192;
	keyboardHide(  );
	label$2851:;
}

static inline ushort fb_Gfx24to16( uinteger COLOR32$1 )
{
	ushort fb$result$1;
	__builtin_memset( &fb$result$1, 0, 2 );
	label$2870:;
	if( (COLOR32$1 & 16777215) != 16711935 ) goto label$2873;
	{
		fb$result$1 = (ushort)0;
		goto label$2871;
	}
	goto label$2872;
	label$2873:;
	{
		fb$result$1 = (ushort)((((((COLOR32$1 >> 16) & 255) >> 3) | 32768) | ((((COLOR32$1 >> 8) & 255) >> 3) << 5)) | (((COLOR32$1 & 255) >> 3) << 10));
		goto label$2871;
	}
	label$2872:;
	label$2871:;
	return fb$result$1;
}

static inline void* fb_GfxScreenPtr( void )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2874:;
	fb$result$1 = _ZN3GFX7SCRPTR$E;
	goto label$2875;
	label$2875:;
	return fb$result$1;
}

static        integer fb_GfxScreenRes( integer WID$1, integer HEI$1, integer BPP$1, integer PAGES$1, integer FLAGS$1, integer REFRESH$1 )
{
	uinteger TMP$684$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$2876:;
	integer OGLRENDER$1;
	__builtin_memset( &OGLRENDER$1, 0, 4 );
	integer PITCH$1;
	__builtin_memset( &PITCH$1, 0, 4 );
	if( BPP$1 > 8 ) goto label$2879;
	BPP$1 = 8;
	goto label$2878;
	label$2879:;
	BPP$1 = 16;
	label$2878:;
	{
		if( WID$1 != 192 ) goto label$2881;
		label$2882:;
		{
			if( HEI$1 == 256 ) goto label$2884;
			fb$result$1 = 0;
			goto label$2877;
			label$2884:;
			PITCH$1 = 256;
			*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -129) | 128u);
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -257;
		}
		goto label$2880;
		label$2881:;
		if( WID$1 != 256 ) goto label$2885;
		label$2886:;
		{
			if( (-(HEI$1 < 192) | -(HEI$1 > 480)) == 0 ) goto label$2888;
			fb$result$1 = 0;
			goto label$2877;
			label$2888:;
			PITCH$1 = 256;
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -129;
			if( WID$1 != 257 ) goto label$2890;
			{
				WID$1 = 256;
				*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -257;
			}
			goto label$2889;
			label$2890:;
			{
				integer TMP$677$4;
				if( HEI$1 <= 192 ) goto label$2891;
				TMP$677$4 = 1;
				goto label$2933;
				label$2891:;
				TMP$677$4 = 0;
				label$2933:;
				*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -257) | (((uinteger)TMP$677$4 & 1) << 8));
			}
			label$2889:;
		}
		goto label$2880;
		label$2885:;
		if( WID$1 < 257 ) goto label$2892;
		if( WID$1 > 512 ) goto label$2892;
		label$2893:;
		{
			if( (-(HEI$1 < 192) | -(HEI$1 > 384)) == 0 ) goto label$2895;
			fb$result$1 = 0;
			goto label$2877;
			label$2895:;
			PITCH$1 = 512;
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -129;
			*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -257;
		}
		goto label$2880;
		label$2892:;
		{
			fb$result$1 = 0;
			goto label$2877;
		}
		label$2896:;
		label$2880:;
	}
	if( PAGES$1 <= 2 ) goto label$2898;
	fb$result$1 = 0;
	goto label$2877;
	label$2898:;
	lcdMainOnBottom(  );
	if( (GFX$GFXDRIVERS)_ZN3GFX10GFXDRIVER$E == (GFX$GFXDRIVERS)-1 ) goto label$2900;
	{
		integer TMP$678$2;
		ulong* vr$4589 = CAST_VU32( (ulong*)67108864 );
		*vr$4589 = 65541u;
		if( -(WID$1 > 256) == 0 ) goto label$2901;
		TMP$678$2 = -(-(HEI$1 >= 192) != 0);
		goto label$2934;
		label$2901:;
		TMP$678$2 = 0;
		label$2934:;
		if( TMP$678$2 == 0 ) goto label$2903;
		{
			ubyte* vr$4593 = CAST_VU8( (ubyte*)67109440 );
			*vr$4593 = (ubyte)129;
			ubyte* vr$4594 = CAST_VU8( (ubyte*)67109441 );
			*vr$4594 = (ubyte)137;
			if( BPP$1 != 16 ) goto label$2905;
			{
				ubyte* vr$4595 = CAST_VU8( (ubyte*)67109442 );
				*vr$4595 = (ubyte)145;
				ubyte* vr$4596 = CAST_VU8( (ubyte*)67109443 );
				*vr$4596 = (ubyte)153;
			}
			label$2905:;
			label$2904:;
		}
		goto label$2902;
		label$2903:;
		{
			if( BPP$1 != 16 ) goto label$2907;
			{
				ubyte* vr$4597 = CAST_VU8( (ubyte*)67109440 );
				*vr$4597 = (ubyte)129;
			}
			goto label$2906;
			label$2907:;
			{
				ubyte* vr$4598 = CAST_VU8( (ubyte*)67109444 );
				*vr$4598 = (ubyte)129;
			}
			label$2906:;
		}
		label$2902:;
		if( ((*(integer*)&_ZN3GFX3FG$E >> 8) & 1) == 0 ) goto label$2909;
		{
			ulong* vr$4601 = CAST_VU32( (ulong*)67112960 );
			*vr$4601 = 65541u;
			ubyte* vr$4602 = CAST_VU8( (ubyte*)67109442 );
			*vr$4602 = (ubyte)132;
		}
		label$2909:;
		label$2908:;
	}
	goto label$2899;
	label$2900:;
	{
		puts( (char*)"SCREENRES: GL render disabled." );
	}
	label$2899:;
	_ZN3GFX14CURRENTDRIVER$E = _ZN3GFX10GFXDRIVER$E;
	OGLRENDER$1 = -((GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E == (GFX$GFXDRIVERS)-1);
	if( BPP$1 != 16 ) goto label$2911;
	{
	}
	goto label$2910;
	label$2911:;
	{
		if( OGLRENDER$1 == 0 ) goto label$2913;
		{
		}
		goto label$2912;
		label$2913:;
		{
			integer TMP$680$3;
			if( -(WID$1 > 256) == 0 ) goto label$2914;
			TMP$680$3 = -(-(HEI$1 > 192) != 0);
			goto label$2935;
			label$2914:;
			TMP$680$3 = 0;
			label$2935:;
			if( TMP$680$3 == 0 ) goto label$2916;
			{
				struct BGSTATE* TMP$681$4;
				integer vr$4608 = BGINIT( 3, (BGTYPE)4, (BGSIZE)245888, 0, 0 );              
				_ZN3GFX3BG$E = vr$4608;
				TMP$681$4 = (struct BGSTATE*)((ubyte*)bgState + (_ZN3GFX3BG$E * 40));
				*(long*)((ubyte*)TMP$681$4 + 12) = (long)((WID$1 << 8) / 256);
				*(long*)((ubyte*)TMP$681$4 + 16) = (long)((HEI$1 << 8) / 192);
				*(integer*)((ubyte*)TMP$681$4 + 36) = -1;
			}
			goto label$2915;
			label$2916:;
			{
				integer vr$4618 = BGINIT( 3, (BGTYPE)4, (BGSIZE)213120, 0, 0 );              
				_ZN3GFX3BG$E = vr$4618;
			}
			label$2915:;
			if( ((*(integer*)&_ZN3GFX3FG$E >> 8) & 1) == 0 ) goto label$2918;
			{
				integer vr$4621 = BGINITSUB( 3, (BGTYPE)4, (BGSIZE)213120, 0, 0 );              
				_ZN3GFX4BG2$E = vr$4621;
				ushort* vr$4622 = BGGETGFXPTR( _ZN3GFX4BG2$E );              
				_ZN3GFX9VRAMBPTR$E = (void*)vr$4622;
			}
			label$2918:;
			label$2917:;
			ushort* vr$4623 = CAST_VU16( (ushort*)83886080 );
			_ZN3GFX11PALETTEPTR$E = vr$4623;
		}
		label$2912:;
		{
			integer CNT$3;
			CNT$3 = 0;
			label$2922:;
			{
				uinteger R$4;
				R$4 = (*(uinteger*)((ubyte*)_ZN3GFX11DEFAULTVGA$E + (CNT$3 << 2)) >> 16) & 255;
				uinteger G$4;
				G$4 = (*(uinteger*)((ubyte*)_ZN3GFX11DEFAULTVGA$E + (CNT$3 << 2)) >> 8) & 255;
				uinteger B$4;
				B$4 = *(uinteger*)((ubyte*)_ZN3GFX11DEFAULTVGA$E + (CNT$3 << 2)) & 255;
				*(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (CNT$3 << 1)) = (ushort)((((R$4 >> 3) | ((G$4 >> 3) << 5)) | ((B$4 >> 3) << 10)) | 32768);
			}
			label$2920:;
			CNT$3 = CNT$3 + 1;
			label$2919:;
			if( CNT$3 <= 255 ) goto label$2922;
			label$2921:;
		}
		*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -3) | 2u);
	}
	label$2910:;
	if( OGLRENDER$1 == 0 ) goto label$2924;
	{
	}
	goto label$2923;
	label$2924:;
	{
		if( ((*(integer*)&_ZN3GFX3FG$E >> 7) & 1) == 0 ) goto label$2926;
		{
			struct BGSTATE* TMP$682$3;
			struct BGSTATE* TMP$683$3;
			TMP$682$3 = (struct BGSTATE*)((ubyte*)bgState + (_ZN3GFX3BG$E * 40));
			*(long*)((ubyte*)TMP$682$3 + 4) = 32768;
			*(long*)((ubyte*)TMP$682$3 + 8) = 32768;
			*(integer*)((ubyte*)TMP$682$3 + 36) = -1;
			*(integer*)((ubyte*)bgState + (_ZN3GFX3BG$E * 40)) = -8192;
			*(integer*)(((ubyte*)bgState + (_ZN3GFX3BG$E * 40)) + 36) = -1;
			TMP$683$3 = (struct BGSTATE*)((ubyte*)bgState + (_ZN3GFX3BG$E * 40));
			*(long*)((ubyte*)TMP$683$3 + 20) = 32768;
			*(long*)((ubyte*)TMP$683$3 + 24) = 32512;
			*(integer*)((ubyte*)TMP$683$3 + 36) = -1;
		}
		label$2926:;
		label$2925:;
		_ZN3GFX8GFXSIZE$E = (uinteger)(((PITCH$1 * BPP$1) >> 3) * HEI$1);
		byte vr$4663 = isDSiMode(  );              
		if( (integer)vr$4663 == 0 ) goto label$2928;
		{
			_ZN3GFX4SCR$E = (struct FB$IMAGE*)57671680;
		}
		goto label$2927;
		label$2928:;
		{
			void* vr$4667 = realloc( (void*)_ZN3GFX4SCR$E, (_ZN3GFX8GFXSIZE$E + PITCH$1) + 32 );
			_ZN3GFX4SCR$E = (struct FB$IMAGE*)vr$4667;
		}
		label$2927:;
		*(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 16) = (uinteger)((PITCH$1 * BPP$1) >> 3);
	}
	label$2923:;
	*(uinteger*)_ZN3GFX4SCR$E = 7u;
	*(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 8) = (uinteger)WID$1;
	*(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12) = (uinteger)HEI$1;
	*(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) = BPP$1 >> 3;
	_ZN3GFX8GFXSIZE$E = *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 16) * *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12);
	_ZN3GFX7SCRPTR$E = (void*)((ubyte*)_ZN3GFX4SCR$E + 32);
	ushort* vr$4680 = BGGETGFXPTR( _ZN3GFX3BG$E );              
	_ZN3GFX8VRAMPTR$E = (void*)((uinteger)vr$4680 & -(OGLRENDER$1 == 0));
	if( BPP$1 > 8 ) goto label$2929;
	TMP$684$1 = 0u;
	goto label$2936;
	label$2929:;
	TMP$684$1 = 16711935u;
	label$2936:;
	_ZN3GFX11TRANSCOLOR$E = TMP$684$1;
	_ZN3GFX6DEPTH$E = -4095;
	_ZN3GFX7LOCKED$E = (short)0;
	*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -513;
	DC_FlushRange( _ZN3GFX7SCRPTR$E, (ulong)_ZN3GFX8GFXSIZE$E );
	ulong* vr$4684 = CAST_VU32( (ulong*)67109100 );
	*vr$4684 = 0u;
	ulong* vr$4685 = CAST_VU32( (ulong*)67109100 );
	ulong* vr$4686 = CAST_VU32( (ulong*)67109076 );
	*vr$4686 = (ulong)vr$4685;
	ulong* vr$4687 = CAST_VU32( (ulong*)67109080 );
	*vr$4687 = (ulong)_ZN3GFX7SCRPTR$E;
	ulong* vr$4690 = CAST_VU32( (ulong*)67109084 );
	*vr$4690 = (ulong)(integer)(-2063597568 | (_ZN3GFX8GFXSIZE$E >> 2));
	label$2930:;
	{
	}
	label$2932:;
	ulong* vr$4691 = CAST_VU32( (ulong*)67109084 );
	if( (*vr$4691 & -2147483648u) != 0u ) goto label$2930;
	label$2931:;
	bgUpdate(  );
	goto label$2877;
	label$2877:;
	return fb$result$1;
}

static        void fb_GfxScreenInfo( integer* PIWID$1, integer* PIHEI$1, integer* PIDEPTH$1, integer* PIBPP$1, integer* PIPITCH$1, integer* PIRATE$1, void* PDRIVER$1 )
{
	label$2937:;
	if( _ZN3GFX4SCR$E == (struct FB$IMAGE*)0 ) goto label$2940;
	{
		struct FB$IMAGE* TMP$685$2;
		TMP$685$2 = _ZN3GFX4SCR$E;
		*PIWID$1 = *(integer*)((ubyte*)TMP$685$2 + 8);
		*PIHEI$1 = *(integer*)((ubyte*)TMP$685$2 + 12);
		*PIBPP$1 = *(integer*)((ubyte*)TMP$685$2 + 4);
		*PIDEPTH$1 = *(integer*)((ubyte*)TMP$685$2 + 4) << 3;
		*PIPITCH$1 = *(integer*)((ubyte*)TMP$685$2 + 16);
		*PIRATE$1 = 60;
		if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$2942;
		{
		}
		goto label$2941;
		label$2942:;
		{
		}
		label$2941:;
	}
	goto label$2939;
	label$2940:;
	{
		*PIWID$1 = 256;
		*PIHEI$1 = 192;
		*PIBPP$1 = 1;
		*PIDEPTH$1 = 8;
		*PIPITCH$1 = 256;
		*PIRATE$1 = 60;
	}
	label$2939:;
	label$2938:;
}

static        void fb_GfxView( integer ILEFT$1, integer ITOP$1, integer IRIGHT$1, integer IBOTTOM$1, uinteger IBKGND$1, uinteger IBORDER$1, integer IFLAGS$1 )
{
	label$2943:;
	if( _ZN3GFX7SCRPTR$E != 0 ) goto label$2946;
	goto label$2944;
	label$2946:;
	uinteger IWID$1;
	IWID$1 = *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 8);
	uinteger IHEI$1;
	IHEI$1 = *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 12);
	if( (-(ILEFT$1 == -32768) & -(IRIGHT$1 == -32768)) == 0 ) goto label$2948;
	{
		if( (-(ITOP$1 == -32768) & -(IBOTTOM$1 == -32768)) == 0 ) goto label$2950;
		{
			_ZN3GFX7VIEWLT$E = (short)0;
			_ZN3GFX7VIEWRT$E = (short)(IWID$1 + -1);
			_ZN3GFX7VIEWTP$E = (short)0;
			_ZN3GFX7VIEWBT$E = (short)(IHEI$1 + -1);
			_ZN3GFX8VIEWWID$E = (short)IWID$1;
			_ZN3GFX8VIEWHEI$E = (short)IHEI$1;
			_ZN3GFX7ISVIEW$E = (short)0;
			goto label$2944;
		}
		label$2950:;
		label$2949:;
	}
	label$2948:;
	label$2947:;
	if( ILEFT$1 >= 0 ) goto label$2952;
	ILEFT$1 = 0;
	goto label$2951;
	label$2952:;
	if( ILEFT$1 < IWID$1 ) goto label$2954;
	ILEFT$1 = (integer)(IWID$1 + -1);
	label$2954:;
	label$2951:;
	if( ITOP$1 >= 0 ) goto label$2956;
	ITOP$1 = 0;
	goto label$2955;
	label$2956:;
	if( ITOP$1 < IHEI$1 ) goto label$2958;
	ITOP$1 = (integer)(IHEI$1 + -1);
	label$2958:;
	label$2955:;
	if( IRIGHT$1 >= 0 ) goto label$2960;
	IRIGHT$1 = 0;
	goto label$2959;
	label$2960:;
	if( IRIGHT$1 < IWID$1 ) goto label$2962;
	IRIGHT$1 = (integer)(IWID$1 + -1);
	label$2962:;
	label$2959:;
	if( IBOTTOM$1 >= 0 ) goto label$2964;
	IBOTTOM$1 = 0;
	goto label$2963;
	label$2964:;
	if( IBOTTOM$1 < IHEI$1 ) goto label$2966;
	IBOTTOM$1 = (integer)(IHEI$1 + -1);
	label$2966:;
	label$2963:;
	if( ILEFT$1 <= IRIGHT$1 ) goto label$2968;
	{
		integer TMP$686$2;
		TMP$686$2 = ILEFT$1;
		ILEFT$1 = IRIGHT$1;
		IRIGHT$1 = TMP$686$2;
	}
	label$2968:;
	if( ITOP$1 <= IBOTTOM$1 ) goto label$2970;
	{
		integer TMP$687$2;
		TMP$687$2 = ITOP$1;
		ITOP$1 = IBOTTOM$1;
		IBOTTOM$1 = TMP$687$2;
	}
	label$2970:;
	_ZN3GFX7VIEWLT$E = (short)ILEFT$1;
	_ZN3GFX7VIEWRT$E = (short)IRIGHT$1;
	_ZN3GFX7VIEWTP$E = (short)ITOP$1;
	_ZN3GFX7VIEWBT$E = (short)IBOTTOM$1;
	_ZN3GFX8VIEWWID$E = (short)((IRIGHT$1 - ILEFT$1) + 1);
	_ZN3GFX8VIEWHEI$E = (short)((IBOTTOM$1 - ITOP$1) + 1);
	_ZN3GFX7ISVIEW$E = (short)1;
	label$2944:;
}

static inline void fb_GfxSetWindowTitle( void* FBS$1 )
{
	label$2971:;
	puts( *(char**)FBS$1 );
	if( FBS$1 == (void*)0 ) goto label$2974;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$2975;
			label$2978:;
			{
				if( FBS$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$2980;
				{
					struct FBSTRING* TMP$689$5;
					void* PTEMP$5;
					PTEMP$5 = FBS$1;
					{
						void* TMP$688$6;
						TMP$688$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$688$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$689$5 = (struct FBSTRING*)FBS$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$689$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$689$5 == (char*)0 ) goto label$2982;
					free( *(void**)TMP$689$5 );
					*(char**)TMP$689$5 = (char*)0;
					*(integer*)((ubyte*)TMP$689$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$689$5 + 8) = 0;
					label$2982:;
					if( ISTEMP$5 == 0 ) goto label$2984;
					{
						free( FBS$1 );
						FBS$1 = (void*)0;
					}
					label$2984:;
					label$2983:;
				}
				label$2980:;
				label$2979:;
			}
			label$2976:;
			N$3 = N$3 + -1;
			label$2975:;
			if( N$3 >= 0 ) goto label$2978;
			label$2977:;
		}
	}
	label$2974:;
	label$2973:;
	label$2972:;
}

static inline void fb_GfxPalette( integer IINDEX$1, integer IRED$1, integer IGREEN$1, integer IBLUE$1 )
{
	label$2985:;
	if( (uinteger)IINDEX$1 >= 256 ) goto label$2988;
	{
		if( (-(IGREEN$1 < 0) & -(IBLUE$1 < 0)) == 0 ) goto label$2990;
		{
			uinteger ICOLOR$3;
			ICOLOR$3 = (uinteger)((IRED$1 & 4079166) >> 1);
			*(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (IINDEX$1 << 1)) = (ushort)(((((ICOLOR$3 & 31) << 10) | ((ICOLOR$3 & 7936) >> 3)) | ((ICOLOR$3 & 2031616) >> 16)) | 32768);
		}
		goto label$2989;
		label$2990:;
		{
			*(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (IINDEX$1 << 1)) = (ushort)((((IRED$1 >> 3) | 32768) | ((IGREEN$1 >> 3) << 5)) | ((IBLUE$1 >> 3) << 10));
		}
		label$2989:;
		*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -3) | 2u);
	}
	label$2988:;
	label$2987:;
	label$2986:;
}

static inline void fb_GfxPaletteGet( integer IINDEX$1, integer* PIRED$1, integer* PIGREEN$1, integer* PIBLUE$1 )
{
	label$2991:;
	if( (uinteger)IINDEX$1 >= 256 ) goto label$2994;
	{
		if( PIRED$1 == (integer*)0 ) goto label$2996;
		{
			if( (-(PIGREEN$1 == 0) & -(PIBLUE$1 == 0)) == 0 ) goto label$2998;
			{
				ushort IPAL16$4;
				IPAL16$4 = *(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (IINDEX$1 << 1));
				*PIRED$1 = ((((integer)IPAL16$4 & 31) << 1) | (((integer)IPAL16$4 & 992) << 2)) | (((integer)IPAL16$4 & 31744) << 3);
			}
			goto label$2997;
			label$2998:;
			{
				ushort IPAL16$4;
				IPAL16$4 = *(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (IINDEX$1 << 1));
				*PIRED$1 = ((integer)IPAL16$4 & 31) << 3;
				*PIGREEN$1 = ((integer)IPAL16$4 & 992) >> 2;
				*PIBLUE$1 = ((integer)IPAL16$4 & 31744) >> 7;
			}
			label$2997:;
		}
		label$2996:;
		label$2995:;
	}
	label$2994:;
	label$2993:;
	label$2992:;
}

static inline void fb_GfxPaletteUsing( integer* IPALARRAY$1 )
{
	label$2999:;
	if( (-(*(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) > 8) | -(_ZN3GFX7SCRPTR$E == 0)) == 0 ) goto label$3002;
	goto label$3000;
	label$3002:;
	integer PALCNT$1;
	PALCNT$1 = (1 << *(integer*)((ubyte*)_ZN3GFX4SCR$E + 4)) + -1;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$690$2;
		TMP$690$2 = PALCNT$1;
		goto label$3003;
		label$3006:;
		{
			uinteger ICOLOR$3;
			ICOLOR$3 = (uinteger)((*(integer*)((ubyte*)IPALARRAY$1 + (CNT$2 << 2)) & 4079166) >> 1);
			*(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (CNT$2 << 1)) = (ushort)(((((ICOLOR$3 & 31) << 10) | ((ICOLOR$3 & 7936) >> 3)) | ((ICOLOR$3 & 2031616) >> 16)) | 32768);
		}
		label$3004:;
		CNT$2 = CNT$2 + 1;
		label$3003:;
		if( CNT$2 <= TMP$690$2 ) goto label$3006;
		label$3005:;
	}
	*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -3) | 2u);
	label$3000:;
}

static inline void fb_GfxPaletteGetUsing( integer* IPALARRAY$1 )
{
	label$3007:;
	if( (-(*(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) > 8) | -(_ZN3GFX7SCRPTR$E == 0)) == 0 ) goto label$3010;
	goto label$3008;
	label$3010:;
	integer PALCNT$1;
	PALCNT$1 = (1 << *(integer*)((ubyte*)_ZN3GFX4SCR$E + 4)) + -1;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$691$2;
		TMP$691$2 = PALCNT$1;
		goto label$3011;
		label$3014:;
		{
			uinteger TEMP$3;
			TEMP$3 = (uinteger)*(ushort*)((ubyte*)_ZN3GFX11PALETTEPTR$E + (CNT$2 << 1));
			uinteger R$3;
			R$3 = ((TEMP$3 & 31) * 63) / 31;
			uinteger G$3;
			G$3 = (((TEMP$3 >> 5) & 31) * 63) / 31;
			uinteger B$3;
			B$3 = (((TEMP$3 >> 10) & 31) * 63) / 31;
			*(integer*)((ubyte*)IPALARRAY$1 + (CNT$2 << 2)) = (integer)(((R$3 << 16) | (G$3 << 8)) | B$3);
		}
		label$3012:;
		CNT$2 = CNT$2 + 1;
		label$3011:;
		if( CNT$2 <= TMP$691$2 ) goto label$3014;
		label$3013:;
	}
	label$3008:;
}

static inline void fb_GfxLock( void )
{
	label$3015:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
	label$3016:;
}

static        void fb_GfxUnlock( integer UNKA$1, integer UNKB$1 )
{
	label$3017:;
	if( _ZN3GFX7LOCKED$E == (short)0 ) goto label$3020;
	{
		_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
		if( (integer)_ZN3GFX7LOCKED$E != 0 ) goto label$3022;
		{
			static byte IMUSTCOUNT$3;
			if( ((*(integer*)&_ZN3GFX3FG$E >> 4) & 3) != 1 ) goto label$3024;
			_FB_INT_UPDATESCREEN(  );
			label$3024:;
		}
		label$3022:;
		label$3021:;
	}
	label$3020:;
	label$3019:;
	goto label$3018;
	label$3018:;
}

static        void* fb_GfxImageCreate( integer IWID$1, integer IHEI$1, integer ICOLOR$1, integer IBPP$1, integer IFLAGS$1 )
{
	struct FB$IMAGE* TMP$693$1;
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3025:;
	if( (-(IWID$1 < 0) | -(IHEI$1 < 0)) == 0 ) goto label$3028;
	fb$result$1 = (void*)0;
	goto label$3026;
	label$3028:;
	if( IBPP$1 != 0 ) goto label$3030;
	{
		if( _ZN3GFX7SCRPTR$E == (void*)0 ) goto label$3032;
		{
			IBPP$1 = *(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) << 3;
		}
		goto label$3031;
		label$3032:;
		{
			fb$result$1 = (void*)0;
			goto label$3026;
		}
		label$3031:;
	}
	label$3030:;
	label$3029:;
	if( IBPP$1 <= 16 ) goto label$3034;
	fb$result$1 = (void*)0;
	goto label$3026;
	label$3034:;
	if( IBPP$1 > 8 ) goto label$3036;
	IBPP$1 = 8;
	goto label$3035;
	label$3036:;
	IBPP$1 = 16;
	label$3035:;
	if( (IFLAGS$1 & -2147483648u) == 0 ) goto label$3038;
	{
		if( IBPP$1 <= 8 ) goto label$3040;
		ICOLOR$1 = 16711935;
		label$3040:;
	}
	label$3038:;
	label$3037:;
	integer TEMPPITCH$1;
	TEMPPITCH$1 = (IWID$1 * IBPP$1) >> 3;
	struct FB$IMAGE* TEMPIMAGE$1;
	__builtin_memset( &TEMPIMAGE$1, 0, 4 );
	if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$3042;
	{
	}
	goto label$3041;
	label$3042:;
	{
		if( (TEMPPITCH$1 & 3) == 0 ) goto label$3044;
		TEMPPITCH$1 = (TEMPPITCH$1 | 3) + 1;
		label$3044:;
		void* vr$4900 = malloc( (uinteger)(32 + (IHEI$1 * TEMPPITCH$1)) );
		TEMPIMAGE$1 = (struct FB$IMAGE*)vr$4900;
		if( TEMPIMAGE$1 != 0 ) goto label$3046;
		{
			puts( (char*)"Failed to allocate create image :(" );
			fb$result$1 = (void*)0;
			goto label$3026;
		}
		label$3046:;
		label$3045:;
	}
	label$3041:;
	TMP$693$1 = TEMPIMAGE$1;
	*(uinteger*)TMP$693$1 = 7u;
	*(uinteger*)((ubyte*)TMP$693$1 + 8) = (uinteger)IWID$1;
	*(uinteger*)((ubyte*)TMP$693$1 + 12) = (uinteger)IHEI$1;
	*(integer*)((ubyte*)TMP$693$1 + 4) = IBPP$1 >> 3;
	*(uinteger*)((ubyte*)TMP$693$1 + 16) = (uinteger)TEMPPITCH$1;
	uinteger TEMPCOLOR$1;
	__builtin_memset( &TEMPCOLOR$1, 0, 4 );
	if( IBPP$1 <= 8 ) goto label$3048;
	{
	}
	goto label$3047;
	label$3048:;
	{
		TEMPCOLOR$1 = (uinteger)((ICOLOR$1 & 255) + ((ICOLOR$1 & 255) << 8));
	}
	label$3047:;
	TEMPCOLOR$1 = TEMPCOLOR$1 | (TEMPCOLOR$1 << 16);
	DC_FlushRange( (void*)((ubyte*)TEMPIMAGE$1 + 32), (ulong)(IHEI$1 * TEMPPITCH$1) );
	ulong* vr$4916 = CAST_VU32( (ulong*)67109100 );
	*vr$4916 = (ulong)TEMPCOLOR$1;
	ulong* vr$4917 = CAST_VU32( (ulong*)67109100 );
	ulong* vr$4918 = CAST_VU32( (ulong*)67109076 );
	*vr$4918 = (ulong)vr$4917;
	ulong* vr$4920 = CAST_VU32( (ulong*)67109080 );
	*vr$4920 = (ulong)(struct FB$IMAGE*)((ubyte*)TEMPIMAGE$1 + 32);
	ulong* vr$4924 = CAST_VU32( (ulong*)67109084 );
	*vr$4924 = (ulong)(-2063597568 | ((IHEI$1 * TEMPPITCH$1) >> 2));
	label$3049:;
	{
	}
	label$3051:;
	ulong* vr$4925 = CAST_VU32( (ulong*)67109084 );
	if( (*vr$4925 & -2147483648u) != 0u ) goto label$3049;
	label$3050:;
	fb$result$1 = (void*)TEMPIMAGE$1;
	goto label$3026;
	label$3026:;
	return fb$result$1;
}

static        void fb_GfxImageDestroy( void* PBUFFER$1 )
{
	label$3052:;
	if( PBUFFER$1 == (void*)0 ) goto label$3055;
	{
		free( PBUFFER$1 );
	}
	label$3055:;
	label$3054:;
	label$3053:;
}

static        integer fb_GfxBload( void* FBSTRNAME$1, void* POUTBUFF$1, void* PPAL$1 )
{
	struct FB$IMAGE* TMP$698$1;
	struct FBBMPFILEHEADER* TMP$699$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3056:;
	if( (-(POUTBUFF$1 == 0) & -(_ZN3GFX7SCRPTR$E == 0)) == 0 ) goto label$3059;
	fb$result$1 = 0;
	goto label$3057;
	label$3059:;
	integer BMPFILE$1;
	integer vr$4932 = fb_FileFree(  );
	BMPFILE$1 = vr$4932;
	string* TEMP$1;
	TEMP$1 = (string*)FBSTRNAME$1;
	integer vr$4933 = fb_FileOpen( TEMP$1, 0, 1, 0, BMPFILE$1, 0 );
	if( vr$4933 == 0 ) goto label$3061;
	{
		puts( (char*)"Failed to open bmp..." );
		puts( *(char**)TEMP$1 );
		fb$result$1 = 0;
		goto label$3057;
	}
	label$3061:;
	label$3060:;
	struct FBBMPFILEHEADER BMPHEADER$1;
	__builtin_memset( &BMPHEADER$1, 0, 54 );
	fb_FileGet( BMPFILE$1, 1u, (void*)&BMPHEADER$1, 54 );
	if( *(ushort*)&BMPHEADER$1 == (short)19778 ) goto label$3063;
	{
		fb_FileClose( BMPFILE$1 );
		fb$result$1 = 0;
		goto label$3057;
	}
	label$3063:;
	label$3062:;
	integer INBPP$1;
	__builtin_memset( &INBPP$1, 0, 4 );
	integer PALCNT$1;
	__builtin_memset( &PALCNT$1, 0, 4 );
	integer OUTWID$1;
	__builtin_memset( &OUTWID$1, 0, 4 );
	integer OUTHEI$1;
	__builtin_memset( &OUTHEI$1, 0, 4 );
	integer OUTPITCH$1;
	__builtin_memset( &OUTPITCH$1, 0, 4 );
	integer OUTBPP$1;
	__builtin_memset( &OUTBPP$1, 0, 4 );
	integer INPITCH$1;
	__builtin_memset( &INPITCH$1, 0, 4 );
	integer FILEOFFS$1;
	__builtin_memset( &FILEOFFS$1, 0, 4 );
	void* OUTDATA$1;
	__builtin_memset( &OUTDATA$1, 0, 4 );
	uinteger TEMPPAL$1[256];
	__builtin_memset( (uinteger*)TEMPPAL$1, 0, 1024 );
	struct TMP$697 {
		uinteger* DATA;
		uinteger* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$697 tmp$696$1;
	*(uinteger**)&tmp$696$1 = (uinteger*)TEMPPAL$1;
	*(uinteger**)((ubyte*)&tmp$696$1 + 4) = (uinteger*)TEMPPAL$1;
	*(integer*)((ubyte*)&tmp$696$1 + 8) = 1024;
	*(integer*)((ubyte*)&tmp$696$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$696$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$696$1 + 20) = 256;
	*(integer*)((ubyte*)&tmp$696$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$696$1 + 28) = 255;
	if( POUTBUFF$1 != 0 ) goto label$3065;
	POUTBUFF$1 = (void*)_ZN3GFX4SCR$E;
	label$3065:;
	struct FB$IMAGE* TEMPHEAD$1;
	TEMPHEAD$1 = (struct FB$IMAGE*)POUTBUFF$1;
	TMP$698$1 = TEMPHEAD$1;
	OUTWID$1 = *(integer*)((ubyte*)TMP$698$1 + 8);
	OUTHEI$1 = *(integer*)((ubyte*)TMP$698$1 + 12);
	OUTBPP$1 = *(integer*)((ubyte*)TMP$698$1 + 4);
	OUTDATA$1 = (void*)((ubyte*)TEMPHEAD$1 + 32);
	OUTPITCH$1 = *(integer*)((ubyte*)TMP$698$1 + 16);
	if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$3067;
	{
	}
	label$3067:;
	label$3066:;
	TMP$699$1 = &BMPHEADER$1;
	if( (integer)*(ushort*)((ubyte*)TMP$699$1 + 28) > 8 ) goto label$3069;
	{
		INBPP$1 = (integer)*(ushort*)((ubyte*)TMP$699$1 + 28);
		*(ushort*)((ubyte*)TMP$699$1 + 28) = (ushort)1;
		PALCNT$1 = 1 << INBPP$1;
	}
	goto label$3068;
	label$3069:;
	{
		INBPP$1 = (integer)*(ushort*)((ubyte*)TMP$699$1 + 28);
		*(ushort*)((ubyte*)TMP$699$1 + 28) = (ushort)2;
	}
	label$3068:;
	INPITCH$1 = (integer)((*(uinteger*)((ubyte*)TMP$699$1 + 18) * INBPP$1) >> 3);
	if( (INPITCH$1 & 3) == 0 ) goto label$3071;
	INPITCH$1 = (INPITCH$1 | 3) + 1;
	label$3071:;
	if( (((-((integer)*(ushort*)((ubyte*)TMP$699$1 + 28) != 1) & -((integer)*(ushort*)((ubyte*)TMP$699$1 + 28) != 2)) & -((integer)*(ushort*)((ubyte*)TMP$699$1 + 28) != 3)) & -((integer)*(ushort*)((ubyte*)TMP$699$1 + 28) != 4)) == 0 ) goto label$3073;
	{
		fb_FileClose( BMPFILE$1 );
		fb$result$1 = 0;
		goto label$3057;
	}
	label$3073:;
	label$3072:;
	if( (integer)*(ushort*)((ubyte*)TMP$699$1 + 28) > 1 ) goto label$3075;
	{
		fb_FileGet( BMPFILE$1, 0u, (void*)TEMPPAL$1, PALCNT$1 << 2 );
		if( (uinteger)PPAL$1 <= 0 ) goto label$3077;
		{
			{
				integer CNT$4;
				CNT$4 = 0;
				integer TMP$700$4;
				TMP$700$4 = PALCNT$1 + -1;
				goto label$3078;
				label$3081:;
				{
					uinteger UPAL$5;
					UPAL$5 = *(uinteger*)((ubyte*)TEMPPAL$1 + (CNT$4 << 2)) & 16579836;
					UPAL$5 = ((UPAL$5 >> 16) | ((UPAL$5 << 16) & 16711680)) | (UPAL$5 & 65280);
					*(uinteger*)((ubyte*)PPAL$1 + (CNT$4 << 2)) = UPAL$5 >> 2;
				}
				label$3079:;
				CNT$4 = CNT$4 + 1;
				label$3078:;
				if( CNT$4 <= TMP$700$4 ) goto label$3081;
				label$3080:;
			}
		}
		goto label$3076;
		label$3077:;
		if( (-((uinteger)PPAL$1 == 0) & -(*(integer*)((ubyte*)_ZN3GFX4SCR$E + 4) == 1)) == 0 ) goto label$3082;
		{
			{
				integer CNT$4;
				CNT$4 = 0;
				integer TMP$701$4;
				TMP$701$4 = (PALCNT$1 << 2) + -1;
				goto label$3083;
				label$3086:;
				{
					fb_GfxPalette( CNT$4, (integer)((*(uinteger*)((ubyte*)TEMPPAL$1 + (CNT$4 << 2)) & 16579836) >> 2), -1, -1 );
				}
				label$3084:;
				CNT$4 = CNT$4 + 1;
				label$3083:;
				if( CNT$4 <= TMP$701$4 ) goto label$3086;
				label$3085:;
			}
			*(integer*)&_ZN3GFX3FG$E = (integer)((*(integer*)&_ZN3GFX3FG$E & -3) | 2u);
		}
		label$3082:;
		label$3076:;
		{
			integer CNT$3;
			CNT$3 = 0;
			integer TMP$702$3;
			TMP$702$3 = PALCNT$1 + -1;
			goto label$3087;
			label$3090:;
			{
				ushort vr$5017 = fb_Gfx24to16( *(uinteger*)((ubyte*)TEMPPAL$1 + (CNT$3 << 2)) );              
				*(uinteger*)((ubyte*)TEMPPAL$1 + (CNT$3 << 2)) = (uinteger)vr$5017;
			}
			label$3088:;
			CNT$3 = CNT$3 + 1;
			label$3087:;
			if( CNT$3 <= TMP$702$3 ) goto label$3090;
			label$3089:;
		}
	}
	label$3075:;
	label$3074:;
	FILEOFFS$1 = (integer)((*(uinteger*)((ubyte*)TMP$699$1 + 10) + (integer)(INPITCH$1 * (*(uinteger*)((ubyte*)TMP$699$1 + 22) + -1))) + 1);
	integer LINESIZE$1;
	LINESIZE$1 = INPITCH$1;
	integer LINECOUNT$1;
	LINECOUNT$1 = (integer)(*(uinteger*)((ubyte*)TMP$699$1 + 22) + -1);
	{
		if( OUTBPP$1 != 1 ) goto label$3092;
		label$3093:;
		{
			{
				if( INBPP$1 != 4 ) goto label$3095;
				label$3096:;
				{
					if( (INPITCH$1 << 1) == 0 ) goto label$3098;
					LINESIZE$1 = OUTPITCH$1 >> 1;
					label$3098:;
					if( LINECOUNT$1 < OUTHEI$1 ) goto label$3100;
					LINECOUNT$1 = OUTHEI$1 + -1;
					label$3100:;
					ubyte* INBUFF$5;
					void* vr$5032 = calloc( (uinteger)LINESIZE$1, 1u );
					INBUFF$5 = (ubyte*)vr$5032;
					{
						integer Y$6;
						Y$6 = 0;
						integer TMP$703$6;
						TMP$703$6 = LINECOUNT$1;
						goto label$3101;
						label$3104:;
						{
							fb_FileGet( BMPFILE$1, (uinteger)(FILEOFFS$1 - (Y$6 * INPITCH$1)), (void*)INBUFF$5, LINESIZE$1 );
							{
								integer CNT$8;
								CNT$8 = 0;
								integer TMP$704$8;
								TMP$704$8 = LINESIZE$1 + -1;
								goto label$3105;
								label$3108:;
								{
									integer TEMP$9;
									TEMP$9 = (integer)*(ubyte*)(INBUFF$5 + CNT$8);
									*(ushort*)((ubyte*)OUTDATA$1 + (CNT$8 << 1)) = (ushort)((TEMP$9 >> 4) | ((TEMP$9 & 15) << 8));
								}
								label$3106:;
								CNT$8 = CNT$8 + 1;
								label$3105:;
								if( CNT$8 <= TMP$704$8 ) goto label$3108;
								label$3107:;
							}
							OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
						}
						label$3102:;
						Y$6 = Y$6 + 1;
						label$3101:;
						if( Y$6 <= TMP$703$6 ) goto label$3104;
						label$3103:;
					}
				}
				goto label$3094;
				label$3095:;
				if( INBPP$1 != 8 ) goto label$3109;
				label$3110:;
				{
					if( INPITCH$1 <= OUTPITCH$1 ) goto label$3112;
					LINESIZE$1 = OUTPITCH$1;
					label$3112:;
					if( LINECOUNT$1 < OUTHEI$1 ) goto label$3114;
					LINECOUNT$1 = OUTHEI$1 + -1;
					label$3114:;
					OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + (LINECOUNT$1 * OUTPITCH$1));
					{
						integer Y$6;
						Y$6 = 0;
						integer TMP$705$6;
						TMP$705$6 = LINECOUNT$1;
						goto label$3115;
						label$3118:;
						{
							fb_FileGet( BMPFILE$1, 0u, OUTDATA$1, INPITCH$1 );
							OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 - OUTPITCH$1);
						}
						label$3116:;
						Y$6 = Y$6 + 1;
						label$3115:;
						if( Y$6 <= TMP$705$6 ) goto label$3118;
						label$3117:;
					}
				}
				goto label$3094;
				label$3109:;
				{
					printf( (char*)"Bitmap Combination not supported %i %i\n", INBPP$1, OUTBPP$1 );
					fb_Sleep( -1 );
				}
				label$3119:;
				label$3094:;
			}
		}
		goto label$3091;
		label$3092:;
		if( OUTBPP$1 != 2 ) goto label$3120;
		label$3121:;
		{
			puts( (char*)"BLOAD: 16bpp disabled." );
		}
		goto label$3091;
		label$3120:;
		{
			printf( (char*)"Bitmap output not supported... %i %i", INBPP$1, OUTBPP$1 );
			fb_Sleep( -1 );
		}
		label$3122:;
		label$3091:;
	}
	fb_FileClose( BMPFILE$1 );
	fb$result$1 = 0;
	goto label$3057;
	fb_FileClose( BMPFILE$1 );
	fb$result$1 = 1;
	goto label$3057;
	label$3057:;
	return fb$result$1;
}

static inline void fb_GfxPset( void* PTARGET$1, single SX$1, single SY$1, uinteger ICOLOR$1, integer IUNK0$1, integer IUNK1$1 )
{
	label$3123:;
	integer X$1;
	integer vr$5054 = fb_ftosi( SX$1 );
	X$1 = vr$5054;
	integer Y$1;
	integer vr$5055 = fb_ftosi( SY$1 );
	Y$1 = vr$5055;
	if( PTARGET$1 != 0 ) goto label$3126;
	{
	}
	goto label$3125;
	label$3126:;
	{
		puts( (char*)"Pset to buffer Not Yet..." );
	}
	label$3125:;
	_ZN3GFX5CURX$E = (short)X$1;
	_ZN3GFX5CURY$E = (short)Y$1;
	goto label$3124;
	label$3124:;
}

static inline integer fb_GfxPoint( void* PTARGET$1, single SX$1, single SY$1 )
{
	struct FB$IMAGE* TMP$710$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3127:;
	integer X$1;
	integer vr$5059 = fb_ftosi( SX$1 );
	X$1 = vr$5059;
	integer Y$1;
	integer vr$5060 = fb_ftosi( SY$1 );
	Y$1 = vr$5060;
	if( PTARGET$1 != 0 ) goto label$3130;
	PTARGET$1 = (void*)_ZN3GFX4SCR$E;
	label$3130:;
	TMP$710$1 = (struct FB$IMAGE*)PTARGET$1;
	if( *(uinteger*)TMP$710$1 == 7 ) goto label$3132;
	{
		puts( (char*)"gfxpoint: Old Header?" );
	}
	goto label$3131;
	label$3132:;
	{
		if( (uinteger)X$1 < *(uinteger*)((ubyte*)TMP$710$1 + 8) ) goto label$3134;
		fb$result$1 = -1;
		goto label$3128;
		label$3134:;
		if( (uinteger)Y$1 < *(uinteger*)((ubyte*)TMP$710$1 + 12) ) goto label$3136;
		fb$result$1 = -1;
		goto label$3128;
		label$3136:;
		{
			integer TMP$712$3;
			TMP$712$3 = *(integer*)((ubyte*)TMP$710$1 + 4);
			if( TMP$712$3 != 1 ) goto label$3138;
			label$3139:;
			{
				fb$result$1 = (integer)*(ubyte*)((ubyte*)((ubyte*)((ubyte*)PTARGET$1 + (integer)(Y$1 * *(uinteger*)((ubyte*)TMP$710$1 + 16))) + 32) + X$1);
				goto label$3128;
			}
			goto label$3137;
			label$3138:;
			if( TMP$712$3 != 2 ) goto label$3140;
			label$3141:;
			{
				fb$result$1 = (integer)*(ushort*)((ubyte*)((ubyte*)((ubyte*)PTARGET$1 + (integer)(Y$1 * *(uinteger*)((ubyte*)TMP$710$1 + 16))) + 32) + (X$1 << 1));
				goto label$3128;
			}
			goto label$3137;
			label$3140:;
			{
				puts( (char*)"gfxpoint: bpp not supported" );
				fb$result$1 = -1;
				goto label$3128;
			}
			label$3142:;
			label$3137:;
		}
	}
	label$3131:;
	label$3128:;
	return fb$result$1;
}

static        void fb_GfxLine( void* PTARGET$1, single SX$1, single SY$1, single SXX$1, single SYY$1, uinteger ICOLOR$1, integer ITYPE$1, uinteger ISTYLE$1, integer IFLAGS$1 )
{
	label$3143:;
	integer X$1;
	integer vr$5079 = fb_ftosi( SX$1 );
	X$1 = vr$5079;
	integer Y$1;
	integer vr$5080 = fb_ftosi( SY$1 );
	Y$1 = vr$5080;
	integer XX$1;
	integer vr$5081 = fb_ftosi( SXX$1 );
	XX$1 = vr$5081;
	integer YY$1;
	integer vr$5082 = fb_ftosi( SYY$1 );
	YY$1 = vr$5082;
	static integer OUTWID$1;
	static integer OUTHEI$1;
	static integer OUTBPP$1;
	static integer OUTPITCH$1;
	static void* OUTDATA$1;
	if( (IFLAGS$1 & 2) == 0 ) goto label$3146;
	X$1 = (integer)_ZN3GFX5CURX$E;
	Y$1 = (integer)_ZN3GFX5CURY$E;
	label$3146:;
	_ZN3GFX5CURX$E = (short)XX$1;
	_ZN3GFX5CURY$E = (short)YY$1;
	if( PTARGET$1 != 0 ) goto label$3148;
	{
		PTARGET$1 = (void*)_ZN3GFX4SCR$E;
		if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E != (GFX$GFXDRIVERS)-1 ) goto label$3150;
		{
		}
		label$3150:;
		label$3149:;
	}
	label$3148:;
	label$3147:;
	struct FB$IMAGE* TEMPHEAD$1;
	TEMPHEAD$1 = (struct FB$IMAGE*)PTARGET$1;
	{
		struct FB$IMAGE* TMP$714$2;
		TMP$714$2 = TEMPHEAD$1;
		OUTWID$1 = *(integer*)((ubyte*)TMP$714$2 + 8);
		OUTHEI$1 = *(integer*)((ubyte*)TMP$714$2 + 12);
		OUTBPP$1 = *(integer*)((ubyte*)TMP$714$2 + 4);
		OUTDATA$1 = (void*)((ubyte*)TEMPHEAD$1 + 32);
		OUTPITCH$1 = *(integer*)((ubyte*)TMP$714$2 + 16);
	}
	label$3152:;
	label$3151:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
	{
		if( OUTBPP$1 != 1 ) goto label$3154;
		label$3155:;
		{
			{
				if( ITYPE$1 != 0 ) goto label$3157;
				label$3158:;
				{
					uinteger TEMPCOLOR$5;
					TEMPCOLOR$5 = ICOLOR$1 & 255;
					if( Y$1 != YY$1 ) goto label$3160;
					{
						if( X$1 <= XX$1 ) goto label$3162;
						{
							integer TMP$715$7;
							TMP$715$7 = X$1;
							X$1 = XX$1;
							XX$1 = TMP$715$7;
						}
						label$3162:;
						if( Y$1 <= YY$1 ) goto label$3164;
						{
							integer TMP$716$7;
							TMP$716$7 = Y$1;
							Y$1 = YY$1;
							YY$1 = TMP$716$7;
						}
						label$3164:;
						if( (uinteger)XX$1 < (uinteger)OUTWID$1 ) goto label$3166;
						goto label$3167;
						label$3166:;
						if( X$1 >= 0 ) goto label$3169;
						X$1 = 0;
						if( XX$1 >= 0 ) goto label$3171;
						goto label$3167;
						label$3171:;
						label$3169:;
						if( XX$1 < OUTWID$1 ) goto label$3173;
						XX$1 = OUTWID$1 + -1;
						if( X$1 < OUTWID$1 ) goto label$3175;
						goto label$3167;
						label$3175:;
						label$3173:;
						OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((Y$1 * OUTPITCH$1) + X$1));
						memset( OUTDATA$1, (integer)TEMPCOLOR$5, (uinteger)((XX$1 - X$1) + 1) );
					}
					goto label$3159;
					label$3160:;
					{
						integer STEEP$6;
						integer vr$5105 = abs( YY$1 - Y$1 );
						integer vr$5107 = abs( XX$1 - X$1 );
						STEEP$6 = -(vr$5105 > vr$5107);
						if( STEEP$6 == 0 ) goto label$3177;
						{
							integer TMP$717$7;
							TMP$717$7 = X$1;
							X$1 = Y$1;
							Y$1 = TMP$717$7;
						}
						{
							integer TMP$718$7;
							TMP$718$7 = XX$1;
							XX$1 = YY$1;
							YY$1 = TMP$718$7;
						}
						label$3177:;
						if( X$1 <= XX$1 ) goto label$3179;
						{
							integer TMP$719$7;
							TMP$719$7 = X$1;
							X$1 = XX$1;
							XX$1 = TMP$719$7;
						}
						{
							integer TMP$720$7;
							TMP$720$7 = Y$1;
							Y$1 = YY$1;
							YY$1 = TMP$720$7;
						}
						label$3179:;
						if( X$1 >= 0 ) goto label$3181;
						if( XX$1 >= 0 ) goto label$3183;
						goto label$3167;
						label$3183:;
						label$3181:;
						integer DELTAX$6;
						DELTAX$6 = XX$1 - X$1;
						integer DELTAY$6;
						integer vr$5111 = abs( YY$1 - Y$1 );
						DELTAY$6 = vr$5111;
						integer IERROR$6;
						IERROR$6 = DELTAX$6 >> 1;
						integer PSTEP$6;
						__builtin_memset( &PSTEP$6, 0, 4 );
						if( XX$1 < OUTWID$1 ) goto label$3185;
						if( X$1 < OUTWID$1 ) goto label$3187;
						goto label$3167;
						label$3187:;
						label$3185:;
						if( YY$1 <= Y$1 ) goto label$3189;
						{
							if( Y$1 >= 0 ) goto label$3191;
							if( YY$1 >= 0 ) goto label$3193;
							goto label$3167;
							label$3193:;
							label$3191:;
							if( YY$1 < OUTHEI$1 ) goto label$3195;
							if( Y$1 < OUTHEI$1 ) goto label$3197;
							goto label$3167;
							label$3197:;
							label$3195:;
						}
						goto label$3188;
						label$3189:;
						{
							if( YY$1 >= 0 ) goto label$3199;
							if( Y$1 >= 0 ) goto label$3201;
							goto label$3167;
							label$3201:;
							label$3199:;
							if( Y$1 < OUTHEI$1 ) goto label$3203;
							if( YY$1 < OUTHEI$1 ) goto label$3205;
							goto label$3167;
							label$3205:;
							label$3203:;
						}
						label$3188:;
						if( STEEP$6 == 0 ) goto label$3207;
						{
							if( XX$1 < OUTHEI$1 ) goto label$3209;
							XX$1 = OUTHEI$1 + -1;
							label$3209:;
							if( Y$1 >= YY$1 ) goto label$3211;
							PSTEP$6 = 1;
							goto label$3210;
							label$3211:;
							PSTEP$6 = -1;
							label$3210:;
							if( X$1 >= 0 ) goto label$3213;
							{
								IERROR$6 = IERROR$6 - (DELTAY$6 * X$1);
								X$1 = 0;
								integer ITEMP$8;
								ITEMP$8 = IERROR$6 / DELTAX$6;
								if( Y$1 > YY$1 ) goto label$3215;
								Y$1 = Y$1 + ITEMP$8;
								goto label$3214;
								label$3215:;
								Y$1 = Y$1 - ITEMP$8;
								label$3214:;
								IERROR$6 = (DELTAX$6 - IERROR$6) + (ITEMP$8 * DELTAX$6);
							}
							label$3213:;
							label$3212:;
							OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((X$1 * OUTPITCH$1) + Y$1));
							if( PSTEP$6 <= 0 ) goto label$3217;
							{
								{
									integer PY$9;
									PY$9 = X$1;
									integer TMP$721$9;
									TMP$721$9 = XX$1;
									goto label$3218;
									label$3221:;
									{
										*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
										IERROR$6 = IERROR$6 - DELTAY$6;
										OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
										if( IERROR$6 > 0 ) goto label$3223;
										{
											OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + PSTEP$6);
											IERROR$6 = IERROR$6 + DELTAX$6;
											Y$1 = Y$1 + 1;
											if( Y$1 < OUTWID$1 ) goto label$3225;
											goto label$3167;
											label$3225:;
										}
										label$3223:;
										label$3222:;
									}
									label$3219:;
									PY$9 = PY$9 + 1;
									label$3218:;
									if( PY$9 <= TMP$721$9 ) goto label$3221;
									label$3220:;
								}
							}
							goto label$3216;
							label$3217:;
							{
								{
									integer PY$9;
									PY$9 = X$1;
									integer TMP$722$9;
									TMP$722$9 = XX$1;
									goto label$3226;
									label$3229:;
									{
										*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
										IERROR$6 = IERROR$6 - DELTAY$6;
										OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
										if( IERROR$6 > 0 ) goto label$3231;
										{
											OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + PSTEP$6);
											IERROR$6 = IERROR$6 + DELTAX$6;
											Y$1 = Y$1 + -1;
											if( Y$1 >= 0 ) goto label$3233;
											goto label$3167;
											label$3233:;
										}
										label$3231:;
										label$3230:;
									}
									label$3227:;
									PY$9 = PY$9 + 1;
									label$3226:;
									if( PY$9 <= TMP$722$9 ) goto label$3229;
									label$3228:;
								}
							}
							label$3216:;
						}
						goto label$3206;
						label$3207:;
						{
							if( XX$1 < OUTWID$1 ) goto label$3235;
							XX$1 = OUTWID$1 + -1;
							label$3235:;
							if( Y$1 > YY$1 ) goto label$3237;
							PSTEP$6 = OUTPITCH$1;
							goto label$3236;
							label$3237:;
							PSTEP$6 = -OUTPITCH$1;
							label$3236:;
							if( X$1 >= 0 ) goto label$3239;
							{
								IERROR$6 = IERROR$6 - (DELTAY$6 * X$1);
								X$1 = 0;
								integer ITEMP$8;
								ITEMP$8 = IERROR$6 / DELTAX$6;
								if( PSTEP$6 <= 0 ) goto label$3241;
								Y$1 = Y$1 + ITEMP$8;
								goto label$3240;
								label$3241:;
								Y$1 = Y$1 - ITEMP$8;
								label$3240:;
								IERROR$6 = (DELTAX$6 - IERROR$6) + (ITEMP$8 * DELTAX$6);
							}
							label$3239:;
							label$3238:;
							OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((Y$1 * OUTPITCH$1) + X$1));
							if( PSTEP$6 <= 0 ) goto label$3243;
							{
								{
									integer PX$9;
									PX$9 = X$1;
									integer TMP$723$9;
									TMP$723$9 = XX$1;
									goto label$3244;
									label$3247:;
									{
										if( (uinteger)Y$1 >= (uinteger)OUTHEI$1 ) goto label$3249;
										{
											*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
										}
										label$3249:;
										label$3248:;
										IERROR$6 = IERROR$6 - DELTAY$6;
										OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + 1);
										if( IERROR$6 > 0 ) goto label$3251;
										{
											OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + PSTEP$6);
											IERROR$6 = IERROR$6 + DELTAX$6;
											Y$1 = Y$1 + 1;
											if( Y$1 < OUTHEI$1 ) goto label$3253;
											goto label$3167;
											label$3253:;
										}
										label$3251:;
										label$3250:;
									}
									label$3245:;
									PX$9 = PX$9 + 1;
									label$3244:;
									if( PX$9 <= TMP$723$9 ) goto label$3247;
									label$3246:;
								}
							}
							goto label$3242;
							label$3243:;
							{
								{
									integer PX$9;
									PX$9 = X$1;
									integer TMP$724$9;
									TMP$724$9 = XX$1;
									goto label$3254;
									label$3257:;
									{
										if( (uinteger)Y$1 >= (uinteger)OUTHEI$1 ) goto label$3259;
										{
											*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
										}
										label$3259:;
										label$3258:;
										IERROR$6 = IERROR$6 - DELTAY$6;
										OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + 1);
										if( IERROR$6 > 0 ) goto label$3261;
										{
											OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + PSTEP$6);
											IERROR$6 = IERROR$6 + DELTAX$6;
											Y$1 = Y$1 + -1;
											if( Y$1 >= 0 ) goto label$3263;
											goto label$3167;
											label$3263:;
										}
										label$3261:;
										label$3260:;
									}
									label$3255:;
									PX$9 = PX$9 + 1;
									label$3254:;
									if( PX$9 <= TMP$724$9 ) goto label$3257;
									label$3256:;
								}
							}
							label$3242:;
						}
						label$3206:;
					}
					label$3159:;
				}
				goto label$3156;
				label$3157:;
				if( ITYPE$1 != 1 ) goto label$3264;
				label$3265:;
				{
					uinteger TEMPCOLOR$5;
					TEMPCOLOR$5 = ICOLOR$1 & 255;
					integer HASLEFT$5;
					HASLEFT$5 = 1;
					integer HASRIGHT$5;
					HASRIGHT$5 = 1;
					integer NOTOP$5;
					__builtin_memset( &NOTOP$5, 0, 4 );
					integer NOBOTTOM$5;
					__builtin_memset( &NOBOTTOM$5, 0, 4 );
					if( X$1 <= XX$1 ) goto label$3267;
					{
						integer TMP$725$6;
						TMP$725$6 = X$1;
						X$1 = XX$1;
						XX$1 = TMP$725$6;
					}
					label$3267:;
					if( Y$1 <= YY$1 ) goto label$3269;
					{
						integer TMP$726$6;
						TMP$726$6 = Y$1;
						Y$1 = YY$1;
						YY$1 = TMP$726$6;
					}
					label$3269:;
					if( X$1 >= 0 ) goto label$3271;
					{
						if( XX$1 >= 0 ) goto label$3273;
						goto label$3167;
						label$3273:;
						X$1 = 0;
						HASLEFT$5 = 0;
					}
					label$3271:;
					label$3270:;
					if( XX$1 < OUTWID$1 ) goto label$3275;
					{
						if( X$1 < OUTWID$1 ) goto label$3277;
						goto label$3167;
						label$3277:;
						XX$1 = OUTWID$1 + -1;
						HASRIGHT$5 = 0;
					}
					label$3275:;
					label$3274:;
					if( Y$1 >= 0 ) goto label$3279;
					{
						if( YY$1 >= 0 ) goto label$3281;
						goto label$3167;
						label$3281:;
						Y$1 = 0;
						OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((Y$1 * OUTPITCH$1) + X$1));
					}
					goto label$3278;
					label$3279:;
					{
						OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((Y$1 * OUTPITCH$1) + X$1));
						memset( OUTDATA$1, (integer)TEMPCOLOR$5, (uinteger)((XX$1 - X$1) + 1) );
						NOTOP$5 = 1;
					}
					label$3278:;
					if( YY$1 < OUTHEI$1 ) goto label$3283;
					{
						if( Y$1 < OUTHEI$1 ) goto label$3285;
						goto label$3167;
						label$3285:;
						YY$1 = OUTHEI$1 + -1;
					}
					goto label$3282;
					label$3283:;
					{
						memset( (void*)((ubyte*)OUTDATA$1 + ((YY$1 - Y$1) * OUTPITCH$1)), (integer)TEMPCOLOR$5, (uinteger)((XX$1 - X$1) + 1) );
						NOBOTTOM$5 = 1;
					}
					label$3282:;
					if( (HASLEFT$5 & HASRIGHT$5) == 0 ) goto label$3287;
					{
						XX$1 = XX$1 - X$1;
						{
							integer CNT$7;
							CNT$7 = 0;
							integer TMP$727$7;
							TMP$727$7 = YY$1 - Y$1;
							goto label$3288;
							label$3291:;
							{
								*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
								*(ubyte*)((ubyte*)OUTDATA$1 + XX$1) = (ubyte)TEMPCOLOR$5;
								OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
							}
							label$3289:;
							CNT$7 = CNT$7 + 1;
							label$3288:;
							if( CNT$7 <= TMP$727$7 ) goto label$3291;
							label$3290:;
						}
					}
					goto label$3286;
					label$3287:;
					if( HASLEFT$5 == 0 ) goto label$3292;
					{
						{
							integer CNT$7;
							CNT$7 = 0;
							integer TMP$728$7;
							TMP$728$7 = YY$1 - Y$1;
							goto label$3293;
							label$3296:;
							{
								*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
								OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
							}
							label$3294:;
							CNT$7 = CNT$7 + 1;
							label$3293:;
							if( CNT$7 <= TMP$728$7 ) goto label$3296;
							label$3295:;
						}
					}
					goto label$3286;
					label$3292:;
					if( HASRIGHT$5 == 0 ) goto label$3297;
					{
						OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + (XX$1 - X$1));
						{
							integer CNT$7;
							CNT$7 = 0;
							integer TMP$729$7;
							TMP$729$7 = YY$1 - Y$1;
							goto label$3298;
							label$3301:;
							{
								*(ubyte*)OUTDATA$1 = (ubyte)TEMPCOLOR$5;
								OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
							}
							label$3299:;
							CNT$7 = CNT$7 + 1;
							label$3298:;
							if( CNT$7 <= TMP$729$7 ) goto label$3301;
							label$3300:;
						}
					}
					label$3297:;
					label$3286:;
				}
				goto label$3156;
				label$3264:;
				if( ITYPE$1 != 2 ) goto label$3302;
				label$3303:;
				{
					uinteger TEMPCOLOR$5;
					TEMPCOLOR$5 = ICOLOR$1 & 255;
					TEMPCOLOR$5 = TEMPCOLOR$5 | (TEMPCOLOR$5 << 8);
					TEMPCOLOR$5 = TEMPCOLOR$5 | (TEMPCOLOR$5 << 16);
					if( X$1 <= XX$1 ) goto label$3305;
					{
						integer TMP$730$6;
						TMP$730$6 = X$1;
						X$1 = XX$1;
						XX$1 = TMP$730$6;
					}
					label$3305:;
					if( Y$1 <= YY$1 ) goto label$3307;
					{
						integer TMP$731$6;
						TMP$731$6 = Y$1;
						Y$1 = YY$1;
						YY$1 = TMP$731$6;
					}
					label$3307:;
					if( X$1 >= 0 ) goto label$3309;
					X$1 = 0;
					if( XX$1 >= 0 ) goto label$3311;
					goto label$3167;
					label$3311:;
					label$3309:;
					if( XX$1 < OUTWID$1 ) goto label$3313;
					XX$1 = OUTWID$1 + -1;
					if( X$1 < OUTWID$1 ) goto label$3315;
					goto label$3167;
					label$3315:;
					label$3313:;
					if( Y$1 >= 0 ) goto label$3317;
					Y$1 = 0;
					if( YY$1 >= 0 ) goto label$3319;
					goto label$3167;
					label$3319:;
					label$3317:;
					if( YY$1 < OUTHEI$1 ) goto label$3321;
					YY$1 = OUTHEI$1 + -1;
					if( Y$1 < OUTHEI$1 ) goto label$3323;
					goto label$3167;
					label$3323:;
					label$3321:;
					OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + ((Y$1 * OUTPITCH$1) + X$1));
					XX$1 = (XX$1 - X$1) + 1;
					{
						integer CNT$6;
						CNT$6 = 0;
						integer TMP$732$6;
						TMP$732$6 = YY$1 - Y$1;
						goto label$3324;
						label$3327:;
						{
							memset( OUTDATA$1, (integer)TEMPCOLOR$5, (uinteger)XX$1 );
							OUTDATA$1 = (void*)((ubyte*)OUTDATA$1 + OUTPITCH$1);
						}
						label$3325:;
						CNT$6 = CNT$6 + 1;
						label$3324:;
						if( CNT$6 <= TMP$732$6 ) goto label$3327;
						label$3326:;
					}
				}
				goto label$3156;
				label$3302:;
				{
					puts( (char*)"Line type unknown..." );
				}
				label$3328:;
				label$3156:;
			}
		}
		goto label$3153;
		label$3154:;
		if( OUTBPP$1 != 2 ) goto label$3329;
		label$3330:;
		{
			puts( (char*)"LINE: 16bpp disabled" );
		}
		goto label$3153;
		label$3329:;
		{
			puts( (char*)"bit type not yet..." );
		}
		label$3331:;
		label$3153:;
	}
	label$3167:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
	goto label$3144;
	label$3144:;
}

static        integer fb_GfxDrawString( void* PTARGET$1, single SX$1, single SY$1, integer UNK0$1, void* FBTEXT$1, uinteger ICOLOR$1, void* UNK1$1, integer UNK2$1, void* UNK3$1, void* UNK4$1, void* UNK5$1 )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3332:;
	label$3334:;
	{
		struct FB$IMAGE* TMP$736$2;
		integer TMP$737$2;
		integer X$2;
		integer vr$5229 = fb_ftosi( SX$1 );
		X$2 = vr$5229;
		integer Y$2;
		integer vr$5230 = fb_ftosi( SY$1 );
		Y$2 = vr$5230;
		static uinteger OUTWID$2;
		static uinteger OUTHEI$2;
		static uinteger OUTBPP$2;
		static uinteger OUTPITCH$2;
		static void* OUTDATA$2;
		if( (-(*(integer*)((ubyte*)FBTEXT$1 + 4) == 0) | -(*(char**)FBTEXT$1 == 0)) == 0 ) goto label$3338;
		goto label$3335;
		label$3338:;
		integer STRSZ$2;
		STRSZ$2 = *(integer*)((ubyte*)FBTEXT$1 + 4);
		ubyte* STRCHAR$2;
		STRCHAR$2 = (ubyte*)*(void**)FBTEXT$1;
		if( PTARGET$1 != 0 ) goto label$3340;
		PTARGET$1 = (void*)_ZN3GFX4SCR$E;
		label$3340:;
		_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
		TMP$736$2 = (struct FB$IMAGE*)PTARGET$1;
		if( -((GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E == (GFX$GFXDRIVERS)-1) == 0 ) goto label$3341;
		TMP$737$2 = -(-(PTARGET$1 == _ZN3GFX4SCR$E) != 0);
		goto label$3432;
		label$3341:;
		TMP$737$2 = 0;
		label$3432:;
		if( TMP$737$2 == 0 ) goto label$3343;
		{
		}
		goto label$3342;
		label$3343:;
		{
			STRSZ$2 = STRSZ$2 + -1;
			if( (-(Y$2 <= -8) | -(Y$2 >= *(integer*)((ubyte*)TMP$736$2 + 12))) == 0 ) goto label$3345;
			goto label$3335;
			label$3345:;
			if( X$2 >= -8 ) goto label$3347;
			{
				integer IDIFF$4;
				IDIFF$4 = (X$2 + 8) >> 3;
				X$2 = X$2 - (IDIFF$4 << 3);
				STRSZ$2 = STRSZ$2 + IDIFF$4;
				STRCHAR$2 = (ubyte*)(STRCHAR$2 - IDIFF$4);
			}
			label$3347:;
			label$3346:;
			if( (-(X$2 >= *(integer*)((ubyte*)TMP$736$2 + 8)) | -(STRSZ$2 < 0)) == 0 ) goto label$3349;
			goto label$3335;
			label$3349:;
			ubyte* PFONT$3;
			PFONT$3 = &fbgfxfont_tex;
			integer IHEI$3;
			IHEI$3 = 8;
			if( Y$2 >= 0 ) goto label$3351;
			PFONT$3 = (ubyte*)(PFONT$3 - (Y$2 << 5));
			IHEI$3 = IHEI$3 + Y$2;
			Y$2 = 0;
			label$3351:;
			if( Y$2 < (integer)(*(uinteger*)((ubyte*)TMP$736$2 + 12) + -8) ) goto label$3353;
			IHEI$3 = (integer)((IHEI$3 - Y$2) + *(uinteger*)((ubyte*)TMP$736$2 + 12)) + -8;
			label$3353:;
			{
				integer TMP$738$4;
				TMP$738$4 = *(integer*)((ubyte*)TMP$736$2 + 4);
				if( TMP$738$4 != 1 ) goto label$3355;
				label$3356:;
				{
					ubyte* POUT$5;
					POUT$5 = (ubyte*)((ubyte*)((ubyte*)((ubyte*)PTARGET$1 + 32) + (integer)(Y$2 * *(uinteger*)((ubyte*)TMP$736$2 + 16))) + X$2);
					{
						integer CNT$6;
						CNT$6 = 0;
						integer TMP$739$6;
						TMP$739$6 = STRSZ$2;
						goto label$3357;
						label$3360:;
						{
							ubyte* PIN$7;
							PIN$7 = (ubyte*)((ubyte*)(PFONT$3 + (integer)(((uinteger)*STRCHAR$2 >> 4) << 8)) + (integer)(((uinteger)*STRCHAR$2 & 15) << 1));
							{
								integer Y$8;
								Y$8 = 1;
								integer TMP$740$8;
								TMP$740$8 = IHEI$3;
								goto label$3361;
								label$3364:;
								{
									if( (uinteger)X$2 < (*(uinteger*)((ubyte*)TMP$736$2 + 8) + -8) ) goto label$3366;
									{
										if( ((uinteger)*PIN$7 & 1) == 0u ) goto label$3368;
										if( (uinteger)X$2 >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3370;
										*POUT$5 = (ubyte)ICOLOR$1;
										label$3370:;
										label$3368:;
										if( ((uinteger)*PIN$7 & 4) == 0u ) goto label$3372;
										if( (uinteger)(X$2 + 1) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3374;
										*(ubyte*)(POUT$5 + 1) = (ubyte)ICOLOR$1;
										label$3374:;
										label$3372:;
										if( ((uinteger)*PIN$7 & 16) == 0u ) goto label$3376;
										if( (uinteger)(X$2 + 2) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3378;
										*(ubyte*)(POUT$5 + 2) = (ubyte)ICOLOR$1;
										label$3378:;
										label$3376:;
										if( ((uinteger)*PIN$7 & 64) == 0u ) goto label$3380;
										if( (uinteger)(X$2 + 3) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3382;
										*(ubyte*)(POUT$5 + 3) = (ubyte)ICOLOR$1;
										label$3382:;
										label$3380:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 1) == 0u ) goto label$3384;
										if( (uinteger)(X$2 + 4) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3386;
										*(ubyte*)(POUT$5 + 4) = (ubyte)ICOLOR$1;
										label$3386:;
										label$3384:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 4) == 0u ) goto label$3388;
										if( (uinteger)(X$2 + 5) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3390;
										*(ubyte*)(POUT$5 + 5) = (ubyte)ICOLOR$1;
										label$3390:;
										label$3388:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 16) == 0u ) goto label$3392;
										if( (uinteger)(X$2 + 6) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3394;
										*(ubyte*)(POUT$5 + 6) = (ubyte)ICOLOR$1;
										label$3394:;
										label$3392:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 64) == 0u ) goto label$3396;
										if( (uinteger)(X$2 + 7) >= *(uinteger*)((ubyte*)TMP$736$2 + 8) ) goto label$3398;
										*(ubyte*)(POUT$5 + 7) = (ubyte)ICOLOR$1;
										label$3398:;
										label$3396:;
									}
									goto label$3365;
									label$3366:;
									{
										if( ((uinteger)*PIN$7 & 1) == 0u ) goto label$3400;
										*POUT$5 = (ubyte)ICOLOR$1;
										label$3400:;
										if( ((uinteger)*PIN$7 & 4) == 0u ) goto label$3402;
										*(ubyte*)(POUT$5 + 1) = (ubyte)ICOLOR$1;
										label$3402:;
										if( ((uinteger)*PIN$7 & 16) == 0u ) goto label$3404;
										*(ubyte*)(POUT$5 + 2) = (ubyte)ICOLOR$1;
										label$3404:;
										if( ((uinteger)*PIN$7 & 64) == 0u ) goto label$3406;
										*(ubyte*)(POUT$5 + 3) = (ubyte)ICOLOR$1;
										label$3406:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 1) == 0u ) goto label$3408;
										*(ubyte*)(POUT$5 + 4) = (ubyte)ICOLOR$1;
										label$3408:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 4) == 0u ) goto label$3410;
										*(ubyte*)(POUT$5 + 5) = (ubyte)ICOLOR$1;
										label$3410:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 16) == 0u ) goto label$3412;
										*(ubyte*)(POUT$5 + 6) = (ubyte)ICOLOR$1;
										label$3412:;
										if( ((uinteger)*(ubyte*)(PIN$7 + 1) & 64) == 0u ) goto label$3414;
										*(ubyte*)(POUT$5 + 7) = (ubyte)ICOLOR$1;
										label$3414:;
									}
									label$3365:;
									PIN$7 = (ubyte*)(PIN$7 + 32);
									POUT$5 = (ubyte*)(POUT$5 + *(integer*)((ubyte*)TMP$736$2 + 16));
								}
								label$3362:;
								Y$8 = Y$8 + 1;
								label$3361:;
								if( Y$8 <= TMP$740$8 ) goto label$3364;
								label$3363:;
							}
							POUT$5 = (ubyte*)(POUT$5 - (integer)((*(uinteger*)((ubyte*)TMP$736$2 + 16) * IHEI$3) + -8));
							STRCHAR$2 = (ubyte*)(STRCHAR$2 + 1);
							X$2 = X$2 + 8;
							if( X$2 < *(integer*)((ubyte*)TMP$736$2 + 8) ) goto label$3416;
							goto label$3359;
							label$3416:;
						}
						label$3358:;
						CNT$6 = CNT$6 + 1;
						label$3357:;
						if( CNT$6 <= TMP$739$6 ) goto label$3360;
						label$3359:;
					}
				}
				goto label$3354;
				label$3355:;
				if( TMP$738$4 != 2 ) goto label$3417;
				label$3418:;
				{
					puts( (char*)"DRAWSTRING: 16bpp disabled" );
				}
				goto label$3354;
				label$3417:;
				{
					printf( (char*)"DrawString Wrong bpp: %i\n", *(integer*)((ubyte*)TMP$736$2 + 4) );
				}
				label$3419:;
				label$3354:;
			}
			fb$result$1 = 1;
			goto label$3335;
		}
		label$3342:;
	}
	label$3336:;
	goto label$3334;
	label$3335:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
	if( FBTEXT$1 == (void*)0 ) goto label$3421;
	{
		{
			long N$3;
			N$3 = TEMPSTRINGCOUNT$ + -1;
			goto label$3422;
			label$3425:;
			{
				if( FBTEXT$1 != *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) ) goto label$3427;
				{
					struct FBSTRING* TMP$744$5;
					void* PTEMP$5;
					PTEMP$5 = FBTEXT$1;
					{
						void* TMP$743$6;
						TMP$743$6 = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)N$3 << 2)) = *(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2));
						*(void**)((ubyte*)TEMPSTRINGLIST$ + ((integer)(TEMPSTRINGCOUNT$ + -1) << 2)) = TMP$743$6;
					}
					TEMPSTRINGCOUNT$ = TEMPSTRINGCOUNT$ + -1;
					TMP$744$5 = (struct FBSTRING*)FBTEXT$1;
					integer ISTEMP$5;
					ISTEMP$5 = -((*(uinteger*)((ubyte*)TMP$744$5 + 8) & -1048576) == -2147483648u);
					if( *(char**)TMP$744$5 == (char*)0 ) goto label$3429;
					free( *(void**)TMP$744$5 );
					*(char**)TMP$744$5 = (char*)0;
					*(integer*)((ubyte*)TMP$744$5 + 4) = 0;
					*(integer*)((ubyte*)TMP$744$5 + 8) = 0;
					label$3429:;
					if( ISTEMP$5 == 0 ) goto label$3431;
					{
						free( FBTEXT$1 );
						FBTEXT$1 = (void*)0;
					}
					label$3431:;
					label$3430:;
				}
				label$3427:;
				label$3426:;
			}
			label$3423:;
			N$3 = N$3 + -1;
			label$3422:;
			if( N$3 >= 0 ) goto label$3425;
			label$3424:;
		}
	}
	label$3421:;
	label$3420:;
	goto label$3333;
	label$3333:;
	return fb$result$1;
}

static        integer fb_GfxPut( void* PTARGET$1, single SPOSX$1, single SPOSY$1, void* PSOURCE$1, integer ICROPX$1, integer ICROPY$1, integer ICROPXX$1, integer ICROPYY$1, integer ISTEP$1, integer IMETHOD$1, void* PMETHOD$1, integer IMPARM$1, void* PCUSTOM$1, void* PCPARM$1 )
{
	struct FB$IMAGE* TMP$746$1;
	integer TMP$750$1;
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3433:;
	integer POSX$1;
	integer vr$5418 = fb_ftosi( SPOSX$1 );
	POSX$1 = vr$5418;
	integer POSY$1;
	integer vr$5419 = fb_ftosi( SPOSY$1 );
	POSY$1 = vr$5419;
	integer OUTWID$1;
	__builtin_memset( &OUTWID$1, 0, 4 );
	integer OUTHEI$1;
	__builtin_memset( &OUTHEI$1, 0, 4 );
	integer XSTART$1;
	__builtin_memset( &XSTART$1, 0, 4 );
	integer YSTART$1;
	__builtin_memset( &YSTART$1, 0, 4 );
	integer BS$1;
	__builtin_memset( &BS$1, 0, 4 );
	integer INBPP$1;
	__builtin_memset( &INBPP$1, 0, 4 );
	integer OUTBPP$1;
	__builtin_memset( &OUTBPP$1, 0, 4 );
	integer ISSCREEN$1;
	__builtin_memset( &ISSCREEN$1, 0, 4 );
	integer SRCSIZE$1;
	SRCSIZE$1 = 32;
	integer TGTSIZE$1;
	TGTSIZE$1 = 32;
	void* INSTART$1;
	__builtin_memset( &INSTART$1, 0, 4 );
	void* OUTSTART$1;
	__builtin_memset( &OUTSTART$1, 0, 4 );
	if( PSOURCE$1 != 0 ) goto label$3436;
	fb$result$1 = 0;
	goto label$3434;
	label$3436:;
	if( PTARGET$1 != 0 ) goto label$3438;
	PTARGET$1 = (void*)_ZN3GFX4SCR$E;
	ISSCREEN$1 = 1;
	label$3438:;
	if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E == (GFX$GFXDRIVERS)-1 ) goto label$3440;
	{
		integer TMP$745$2;
		if( ISSCREEN$1 == 0 ) goto label$3441;
		TMP$745$2 = -((integer)_ZN3GFX7ISVIEW$E != 0);
		goto label$3491;
		label$3441:;
		TMP$745$2 = 0;
		label$3491:;
		if( TMP$745$2 == 0 ) goto label$3443;
		{
			static struct FB$IMAGE TVIEW$3;
			__builtin_memcpy( &TVIEW$3, (struct FB$IMAGE*)PTARGET$1, 32 );
			PTARGET$1 = (void*)&TVIEW$3;
			*(uinteger*)((ubyte*)&TVIEW$3 + 8) = (uinteger)_ZN3GFX8VIEWWID$E;
			POSX$1 = POSX$1 - (integer)_ZN3GFX7VIEWLT$E;
			*(uinteger*)((ubyte*)&TVIEW$3 + 12) = (uinteger)_ZN3GFX8VIEWHEI$E;
			POSY$1 = POSY$1 - (integer)_ZN3GFX7VIEWTP$E;
			ISSCREEN$1 = 2;
		}
		label$3443:;
		label$3442:;
	}
	label$3440:;
	label$3439:;
	TMP$746$1 = (struct FB$IMAGE*)PSOURCE$1;
	if( (-(*(integer*)((ubyte*)TMP$746$1 + 8) <= 0) | -(*(integer*)((ubyte*)TMP$746$1 + 12) <= 0)) == 0 ) goto label$3445;
	fb$result$1 = 0;
	goto label$3434;
	label$3445:;
	if( (-(*(integer*)((ubyte*)PTARGET$1 + 8) <= 0) | -(*(integer*)((ubyte*)PTARGET$1 + 12) <= 0)) == 0 ) goto label$3447;
	fb$result$1 = 0;
	goto label$3434;
	label$3447:;
	INBPP$1 = *(integer*)((ubyte*)TMP$746$1 + 4);
	OUTBPP$1 = *(integer*)((ubyte*)PTARGET$1 + 4);
	if( INBPP$1 <= 8 ) goto label$3449;
	INBPP$1 = INBPP$1 >> 3;
	label$3449:;
	if( OUTBPP$1 <= 8 ) goto label$3451;
	OUTBPP$1 = OUTBPP$1 >> 3;
	label$3451:;
	if( (-(INBPP$1 != 1) & -(INBPP$1 != 2)) == 0 ) goto label$3453;
	{
		printf( (char*)"PUT: Wrong bpp: %i\n", INBPP$1 );
		fb$result$1 = 0;
		goto label$3434;
	}
	label$3453:;
	label$3452:;
	if( INBPP$1 == OUTBPP$1 ) goto label$3455;
	fb$result$1 = 0;
	goto label$3434;
	label$3455:;
	if( (uinteger)ICROPX$1 < *(integer*)((ubyte*)TMP$746$1 + 8) ) goto label$3457;
	ICROPX$1 = 0;
	label$3457:;
	if( (uinteger)ICROPY$1 < *(integer*)((ubyte*)TMP$746$1 + 12) ) goto label$3459;
	ICROPY$1 = 0;
	label$3459:;
	if( (-(ICROPXX$1 < 0) | -(ICROPX$1 >= *(integer*)((ubyte*)TMP$746$1 + 8))) == 0 ) goto label$3461;
	ICROPXX$1 = *(integer*)((ubyte*)TMP$746$1 + 8) + -1;
	label$3461:;
	if( (-(ICROPYY$1 < 0) | -(ICROPY$1 >= *(integer*)((ubyte*)TMP$746$1 + 12))) == 0 ) goto label$3463;
	ICROPYY$1 = *(integer*)((ubyte*)TMP$746$1 + 12) + -1;
	label$3463:;
	if( ICROPX$1 <= ICROPXX$1 ) goto label$3465;
	{
		integer TMP$748$2;
		TMP$748$2 = ICROPX$1;
		ICROPX$1 = ICROPXX$1;
		ICROPXX$1 = TMP$748$2;
	}
	label$3465:;
	if( ICROPY$1 <= ICROPYY$1 ) goto label$3467;
	{
		integer TMP$749$2;
		TMP$749$2 = ICROPY$1;
		ICROPY$1 = ICROPYY$1;
		ICROPYY$1 = TMP$749$2;
	}
	label$3467:;
	OUTWID$1 = (ICROPXX$1 - ICROPX$1) + 1;
	OUTHEI$1 = (ICROPYY$1 - ICROPY$1) + 1;
	if( (GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E == (GFX$GFXDRIVERS)-1 ) goto label$3469;
	{
		if( POSX$1 < *(integer*)((ubyte*)PTARGET$1 + 8) ) goto label$3471;
		fb$result$1 = 0;
		goto label$3434;
		label$3471:;
		if( POSY$1 < *(integer*)((ubyte*)PTARGET$1 + 12) ) goto label$3473;
		fb$result$1 = 0;
		goto label$3434;
		label$3473:;
		if( POSX$1 > -OUTWID$1 ) goto label$3475;
		fb$result$1 = 0;
		goto label$3434;
		label$3475:;
		if( POSY$1 > -OUTHEI$1 ) goto label$3477;
		fb$result$1 = 0;
		goto label$3434;
		label$3477:;
	}
	label$3469:;
	label$3468:;
	if( POSX$1 >= 0 ) goto label$3479;
	OUTWID$1 = OUTWID$1 + POSX$1;
	ICROPX$1 = ICROPX$1 - POSX$1;
	POSX$1 = 0;
	label$3479:;
	if( POSY$1 >= 0 ) goto label$3481;
	OUTHEI$1 = OUTHEI$1 + POSY$1;
	ICROPY$1 = ICROPY$1 - POSY$1;
	POSY$1 = 0;
	label$3481:;
	if( (POSX$1 + OUTWID$1) <= *(integer*)((ubyte*)PTARGET$1 + 8) ) goto label$3483;
	{
		ICROPXX$1 = (integer)(((ICROPXX$1 - POSX$1) - OUTWID$1) + *(uinteger*)((ubyte*)PTARGET$1 + 8));
		OUTWID$1 = *(integer*)((ubyte*)PTARGET$1 + 8) - POSX$1;
	}
	label$3483:;
	label$3482:;
	if( (POSY$1 + OUTHEI$1) <= *(integer*)((ubyte*)PTARGET$1 + 12) ) goto label$3485;
	{
		ICROPYY$1 = (integer)(((ICROPYY$1 - POSY$1) - OUTHEI$1) + *(uinteger*)((ubyte*)PTARGET$1 + 12));
		OUTHEI$1 = *(integer*)((ubyte*)PTARGET$1 + 12) - POSY$1;
	}
	label$3485:;
	label$3484:;
	if( -((GFX$GFXDRIVERS)_ZN3GFX14CURRENTDRIVER$E == (GFX$GFXDRIVERS)-1) == 0 ) goto label$3486;
	TMP$750$1 = -(ISSCREEN$1 != 0);
	goto label$3492;
	label$3486:;
	TMP$750$1 = 0;
	label$3492:;
	if( TMP$750$1 == 0 ) goto label$3488;
	{
	}
	goto label$3487;
	label$3488:;
	{
		BS$1 = INBPP$1;
		OUTWID$1 = OUTWID$1 * BS$1;
		INSTART$1 = (void*)((ubyte*)((ubyte*)((ubyte*)PSOURCE$1 + SRCSIZE$1) + (integer)(ICROPY$1 * *(uinteger*)((ubyte*)TMP$746$1 + 16))) + (ICROPX$1 * BS$1));
		if( ISSCREEN$1 != 2 ) goto label$3490;
		{
			OUTSTART$1 = (void*)((ubyte*)((ubyte*)((ubyte*)_ZN3GFX4SCR$E + 32) + (integer)(((integer)_ZN3GFX7VIEWTP$E + POSY$1) * *(uinteger*)((ubyte*)PTARGET$1 + 16))) + (((integer)_ZN3GFX7VIEWLT$E + POSX$1) * BS$1));
		}
		goto label$3489;
		label$3490:;
		{
			OUTSTART$1 = (void*)((ubyte*)((ubyte*)((ubyte*)PTARGET$1 + TGTSIZE$1) + (integer)(POSY$1 * *(uinteger*)((ubyte*)PTARGET$1 + 16))) + (POSX$1 * BS$1));
		}
		label$3489:;
		typedef void (*tmp$751)( ubyte*, ubyte*, integer, integer, integer, integer, integer, void*, void* );
		tmp$751 METHODFUNC$2;
		METHODFUNC$2 = (tmp$751)PMETHOD$1;
		_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
		(METHODFUNC$2)( (ubyte*)INSTART$1, (ubyte*)OUTSTART$1, OUTWID$1, OUTHEI$1, *(integer*)((ubyte*)TMP$746$1 + 16), *(integer*)((ubyte*)PTARGET$1 + 16), IMPARM$1, PCUSTOM$1, PCPARM$1 );
		_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
	}
	label$3487:;
	fb$result$1 = -1;
	goto label$3434;
	label$3434:;
	return fb$result$1;
}

static        void fb_hPutBlend( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3493:;
	goto label$3494;
	label$3494:;
}

static        void fb_hPutPSet( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3495:;
	__asm__ __volatile__( "ldr  r0,  %0\n"  "ldr  r1,  %1\n"  "ldr  r2,  %2\n"  "ldr  r3,  %3\n"  "ldr  r4,  %4\n"  "ldr  r5,  %5\n"  "sub  r2,  #1\n"  "sub  r3,  #1\n"  "sub  r4,  r1\n"  "sub  r5,  r1\n"  "cmp  r1,  #4\n"  "bge  0f\n"  "1:  mov  r6,  r1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "2:\n"  "add  r2,  r4\n"  "add  r3,  r5\n"  "subs  r0,  #1\n"  "bne  1b\n"  "b  9f\n"  "0:  mov  r6,  r1\n"  "1:  ldrb  r7,  [r2,#1]!\n"  "ldrb  r8,  [r2,#1]!\n"  "ldrb  r9,  [r2,#1]!\n"  "ldrb  r10,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "strb  r8,  [r3,#1]!\n"  "strb  r9,  [r3,#1]!\n"  "strb  r10,  [r3,#1]!\n"  "sub  r6,  #4\n"  "cmp  r6,  #4\n"  "bge  1b\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "strb  r7,  [r3,#1]!\n"  "2:\n"  "add  r2,  r4\n"  "add  r3,  r5\n"  "subs  r0,  #1\n"  "bne  0b\n"  "9:\n"  :   : "m" (IROWCOUNT$1) , "m" (ILINESIZE$1) , "m" (PSOURCE$1) , "m" (PTARGET$1) , "m" (ISOURCEPITCH$1) , "m" (ITARGETPITCH$1)  : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"   );
	goto label$3496;
	label$3496:;
}

static        void fb_hPutTrans( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3497:;
	__asm__ __volatile__( "ldr  r0,  %0\n"  "ldr  r1,  %1\n"  "ldr  r2,  %2\n"  "ldr  r3,  %3\n"  "ldr  r4,  %4\n"  "ldr  r5,  %5\n"  "sub  r2,  #1\n"  "sub  r3,  #1\n"  "sub  r4,  r1\n"  "sub  r5,  r1\n"  "cmp  r1,  #4\n"  "bge  0f\n"  "1:  mov  r6,  r1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "2:\n"  "add  r2,  r4\n"  "add  r3,  r5\n"  "subs  r0,  #1\n"  "bne  1b\n"  "b  9f\n"  "0:  mov  r6,  r1\n"  "1:  ldrb  r7,  [r2,#1]!\n"  "ldrb  r8,  [r2,#1]!\n"  "ldrb  r9,  [r2,#1]!\n"  "ldrb  r10,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "cmp  r8,  #0\n"  "strneb  r8,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "cmp  r9,  #0\n"  "strneb  r9,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "cmp  r10,  #0\n"  "strneb  r10,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "sub  r6,  #4\n"  "cmp  r6,  #4\n"  "bge  1b\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "subs  r6,  #1\n"  "bmi  2f\n"  "ldrb  r7,  [r2,#1]!\n"  "cmp  r7,  #0\n"  "strneb  r7,  [r3,#1]!\n"  "addeq  r3,  #1\n"  "2:\n"  "add  r2,  r4\n"  "add  r3,  r5\n"  "subs  r0,  #1\n"  "bne  0b\n"  "9:\n"  :   : "m" (IROWCOUNT$1) , "m" (ILINESIZE$1) , "m" (PSOURCE$1) , "m" (PTARGET$1) , "m" (ISOURCEPITCH$1) , "m" (ITARGETPITCH$1)  : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"   );
	goto label$3498;
	label$3498:;
}

static        void fb_hPutAnd( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3499:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$790$2;
		TMP$790$2 = IROWCOUNT$1 + -1;
		goto label$3501;
		label$3504:;
		{
			{
				integer POSI$4;
				POSI$4 = 0;
				integer TMP$791$4;
				TMP$791$4 = ILINESIZE$1 + -1;
				goto label$3505;
				label$3508:;
				{
					*(ubyte*)(PTARGET$1 + POSI$4) = (ubyte)((uinteger)*(ubyte*)(PTARGET$1 + POSI$4) & (uinteger)*(ubyte*)(PSOURCE$1 + POSI$4));
				}
				label$3506:;
				POSI$4 = POSI$4 + 1;
				label$3505:;
				if( POSI$4 <= TMP$791$4 ) goto label$3508;
				label$3507:;
			}
			PSOURCE$1 = (ubyte*)(PSOURCE$1 + ISOURCEPITCH$1);
			PTARGET$1 = (ubyte*)(PTARGET$1 + ITARGETPITCH$1);
		}
		label$3502:;
		CNT$2 = CNT$2 + 1;
		label$3501:;
		if( CNT$2 <= TMP$790$2 ) goto label$3504;
		label$3503:;
	}
	goto label$3500;
	label$3500:;
}

static        void fb_hPutXor( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3509:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$792$2;
		TMP$792$2 = IROWCOUNT$1 + -1;
		goto label$3511;
		label$3514:;
		{
			{
				integer POSI$4;
				POSI$4 = 0;
				integer TMP$793$4;
				TMP$793$4 = ILINESIZE$1 + -1;
				goto label$3515;
				label$3518:;
				{
					*(ubyte*)(PTARGET$1 + POSI$4) = (ubyte)((uinteger)*(ubyte*)(PTARGET$1 + POSI$4) ^ (uinteger)*(ubyte*)(PSOURCE$1 + POSI$4));
				}
				label$3516:;
				POSI$4 = POSI$4 + 1;
				label$3515:;
				if( POSI$4 <= TMP$793$4 ) goto label$3518;
				label$3517:;
			}
			PSOURCE$1 = (ubyte*)(PSOURCE$1 + ISOURCEPITCH$1);
			PTARGET$1 = (ubyte*)(PTARGET$1 + ITARGETPITCH$1);
		}
		label$3512:;
		CNT$2 = CNT$2 + 1;
		label$3511:;
		if( CNT$2 <= TMP$792$2 ) goto label$3514;
		label$3513:;
	}
	goto label$3510;
	label$3510:;
}

static        void fb_hPutOr( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3519:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$794$2;
		TMP$794$2 = IROWCOUNT$1 + -1;
		goto label$3521;
		label$3524:;
		{
			{
				integer POSI$4;
				POSI$4 = 0;
				integer TMP$795$4;
				TMP$795$4 = ILINESIZE$1 + -1;
				goto label$3525;
				label$3528:;
				{
					*(ubyte*)(PTARGET$1 + POSI$4) = (ubyte)((uinteger)*(ubyte*)(PTARGET$1 + POSI$4) | (uinteger)*(ubyte*)(PSOURCE$1 + POSI$4));
				}
				label$3526:;
				POSI$4 = POSI$4 + 1;
				label$3525:;
				if( POSI$4 <= TMP$795$4 ) goto label$3528;
				label$3527:;
			}
			PSOURCE$1 = (ubyte*)(PSOURCE$1 + ISOURCEPITCH$1);
			PTARGET$1 = (ubyte*)(PTARGET$1 + ITARGETPITCH$1);
		}
		label$3522:;
		CNT$2 = CNT$2 + 1;
		label$3521:;
		if( CNT$2 <= TMP$794$2 ) goto label$3524;
		label$3523:;
	}
	goto label$3520;
	label$3520:;
}

static        void fb_hPutPReset( ubyte* PSOURCE$1, ubyte* PTARGET$1, integer ILINESIZE$1, integer IROWCOUNT$1, integer ISOURCEPITCH$1, integer ITARGETPITCH$1, integer IMETHODPARM$1, void* ICUSTOMFUNC$1, void* ICUSTOMPARM$1 )
{
	label$3529:;
	{
		integer CNT$2;
		CNT$2 = 0;
		integer TMP$796$2;
		TMP$796$2 = IROWCOUNT$1 + -1;
		goto label$3531;
		label$3534:;
		{
			{
				integer POSI$4;
				POSI$4 = 0;
				integer TMP$797$4;
				TMP$797$4 = ILINESIZE$1 + -1;
				goto label$3535;
				label$3538:;
				{
					*(ubyte*)(PTARGET$1 + POSI$4) = (ubyte)~(uinteger)*(ubyte*)(PSOURCE$1 + POSI$4);
				}
				label$3536:;
				POSI$4 = POSI$4 + 1;
				label$3535:;
				if( POSI$4 <= TMP$797$4 ) goto label$3538;
				label$3537:;
			}
			PSOURCE$1 = (ubyte*)(PSOURCE$1 + ISOURCEPITCH$1);
			PTARGET$1 = (ubyte*)(PTARGET$1 + ITARGETPITCH$1);
		}
		label$3532:;
		CNT$2 = CNT$2 + 1;
		label$3531:;
		if( CNT$2 <= TMP$796$2 ) goto label$3534;
		label$3533:;
	}
	goto label$3530;
	label$3530:;
}

static        void fb_GfxPaint( void* PTARGET$1, single SX$1, single SY$1, uinteger ICOLOR$1, uinteger IBORDER$1, void* SSTYLE$1, integer IUNK$1, integer IFLAGS$1 )
{
	label$3539:;
	integer X$1;
	integer vr$5584 = fb_ftosi( SX$1 );
	X$1 = vr$5584;
	integer Y$1;
	integer vr$5585 = fb_ftosi( SY$1 );
	Y$1 = vr$5585;
	integer OUTWID$1;
	integer OUTHEI$1;
	integer OUTBPP$1;
	integer OUTPITCH$1;
	void* OUTDATA$1;
	if( PTARGET$1 != 0 ) goto label$3542;
	{
		PTARGET$1 = (void*)_ZN3GFX4SCR$E;
	}
	label$3542:;
	label$3541:;
	struct FB$IMAGE* TEMPHEAD$1;
	TEMPHEAD$1 = (struct FB$IMAGE*)PTARGET$1;
	{
		struct FB$IMAGE* TMP$798$2;
		TMP$798$2 = TEMPHEAD$1;
		OUTWID$1 = *(integer*)((ubyte*)TMP$798$2 + 8);
		OUTHEI$1 = *(integer*)((ubyte*)TMP$798$2 + 12);
		OUTBPP$1 = *(integer*)((ubyte*)TMP$798$2 + 4);
		OUTDATA$1 = (void*)((ubyte*)TEMPHEAD$1 + 32);
		OUTPITCH$1 = *(integer*)((ubyte*)TMP$798$2 + 16);
	}
	label$3544:;
	label$3543:;
	if( (-((uinteger)X$1 >= OUTWID$1) | -((uinteger)Y$1 >= OUTHEI$1)) == 0 ) goto label$3546;
	goto label$3540;
	label$3546:;
	integer STACK_POS$1;
	integer X1$1;
	integer YA$1;
	integer YB$1;
	integer ON_LINEA$1;
	integer ON_LINEB$1;
	integer OLDX$1;
	integer STACK$1[64];
	struct TMP$800 {
		integer* DATA;
		integer* PTR;
		integer SIZE;
		integer ELEMENT_LEN;
		integer DIMENSIONS;
		struct __FB_ARRAYDIMTB$ DIMTB[1];
	};
	struct TMP$800 tmp$799$1;
	*(integer**)&tmp$799$1 = (integer*)STACK$1;
	*(integer**)((ubyte*)&tmp$799$1 + 4) = (integer*)STACK$1;
	*(integer*)((ubyte*)&tmp$799$1 + 8) = 256;
	*(integer*)((ubyte*)&tmp$799$1 + 12) = 4;
	*(integer*)((ubyte*)&tmp$799$1 + 16) = 1;
	*(integer*)((ubyte*)&tmp$799$1 + 20) = 64;
	*(integer*)((ubyte*)&tmp$799$1 + 24) = 0;
	*(integer*)((ubyte*)&tmp$799$1 + 28) = 63;
	STACK_POS$1 = 62;
	*(integer*)((ubyte*)STACK$1 + (STACK_POS$1 << 2)) = X$1;
	*(integer*)(((ubyte*)STACK$1 + (STACK_POS$1 << 2)) + 4) = Y$1;
	if( IFLAGS$1 == 4 ) goto label$3548;
	{
		printf( (char*)"PAINT: Unknown flags %i", IFLAGS$1 );
		goto label$3540;
	}
	label$3548:;
	label$3547:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
	{
		if( OUTBPP$1 != 1 ) goto label$3550;
		label$3551:;
		{
			byte CTAB$3[256];
			__builtin_memset( (byte*)CTAB$3, 0, 256 );
			struct TMP$803 {
				byte* DATA;
				byte* PTR;
				integer SIZE;
				integer ELEMENT_LEN;
				integer DIMENSIONS;
				struct __FB_ARRAYDIMTB$ DIMTB[1];
			};
			struct TMP$803 tmp$802$3;
			*(byte**)&tmp$802$3 = (byte*)CTAB$3;
			*(byte**)((ubyte*)&tmp$802$3 + 4) = (byte*)CTAB$3;
			*(integer*)((ubyte*)&tmp$802$3 + 8) = 256;
			*(integer*)((ubyte*)&tmp$802$3 + 12) = 1;
			*(integer*)((ubyte*)&tmp$802$3 + 16) = 1;
			*(integer*)((ubyte*)&tmp$802$3 + 20) = 256;
			*(integer*)((ubyte*)&tmp$802$3 + 24) = 0;
			*(integer*)((ubyte*)&tmp$802$3 + 28) = 255;
			*(byte*)((ubyte*)CTAB$3 + (integer)ICOLOR$1) = (byte)1;
			*(byte*)((ubyte*)CTAB$3 + (integer)IBORDER$1) = (byte)1;
			ubyte* P$3;
			label$3552:;
			if( STACK_POS$1 >= 64 ) goto label$3553;
			{
				if( STACK_POS$1 >= 4 ) goto label$3555;
				{
					puts( (char*)"PAINT stack overflow!" );
					goto label$3540;
				}
				label$3555:;
				label$3554:;
				X$1 = *(integer*)((ubyte*)STACK$1 + (STACK_POS$1 << 2));
				Y$1 = *(integer*)(((ubyte*)STACK$1 + (STACK_POS$1 << 2)) + 4);
				STACK_POS$1 = STACK_POS$1 + 2;
				P$3 = (ubyte*)((ubyte*)OUTDATA$1 + (Y$1 * OUTPITCH$1));
				ON_LINEA$1 = 0;
				ON_LINEB$1 = 0;
				label$3556:;
				{
					X$1 = X$1 + -1;
					if( X$1 >= 0 ) goto label$3560;
					goto label$3557;
					label$3560:;
				}
				label$3558:;
				if( (uinteger)*(ubyte*)(P$3 + X$1) != IBORDER$1 ) goto label$3556;
				label$3557:;
				X$1 = X$1 + 1;
				OLDX$1 = X$1;
				YA$1 = Y$1 + -1;
				YB$1 = Y$1 + 1;
				if( (uinteger)YB$1 > OUTHEI$1 ) goto label$3562;
				{
					label$3563:;
					if( X$1 >= OUTWID$1 ) goto label$3564;
					{
						if( (uinteger)*(ubyte*)(P$3 + X$1) != IBORDER$1 ) goto label$3566;
						goto label$3564;
						label$3566:;
						if( (integer)*(byte*)((ubyte*)CTAB$3 + (integer)*(ubyte*)((ubyte*)(P$3 + X$1) + OUTPITCH$1)) != 0 ) goto label$3568;
						{
							if( ON_LINEB$1 != 0 ) goto label$3570;
							{
								STACK_POS$1 = STACK_POS$1 + -2;
								*(integer*)((ubyte*)STACK$1 + (STACK_POS$1 << 2)) = X$1;
								*(integer*)(((ubyte*)STACK$1 + (STACK_POS$1 << 2)) + 4) = YB$1;
								ON_LINEB$1 = 1;
							}
							label$3570:;
							label$3569:;
						}
						goto label$3567;
						label$3568:;
						{
							ON_LINEB$1 = 0;
						}
						label$3567:;
						X$1 = X$1 + 1;
					}
					goto label$3563;
					label$3564:;
				}
				label$3562:;
				label$3561:;
				if( (uinteger)YA$1 > OUTHEI$1 ) goto label$3572;
				{
					{
						integer XX$6;
						XX$6 = OLDX$1;
						integer TMP$805$6;
						TMP$805$6 = X$1 + -1;
						goto label$3573;
						label$3576:;
						{
							if( (integer)*(byte*)((ubyte*)CTAB$3 + (integer)*(ubyte*)((ubyte*)(P$3 + XX$6) - OUTPITCH$1)) != 0 ) goto label$3578;
							{
								if( ON_LINEA$1 != 0 ) goto label$3580;
								{
									STACK_POS$1 = STACK_POS$1 + -2;
									*(integer*)((ubyte*)STACK$1 + (STACK_POS$1 << 2)) = XX$6;
									*(integer*)(((ubyte*)STACK$1 + (STACK_POS$1 << 2)) + 4) = YA$1;
									ON_LINEA$1 = 1;
								}
								label$3580:;
								label$3579:;
							}
							goto label$3577;
							label$3578:;
							{
								ON_LINEA$1 = 0;
							}
							label$3577:;
						}
						label$3574:;
						XX$6 = XX$6 + 1;
						label$3573:;
						if( XX$6 <= TMP$805$6 ) goto label$3576;
						label$3575:;
					}
				}
				label$3572:;
				label$3571:;
				memset( (void*)(P$3 + OLDX$1), (integer)ICOLOR$1, (uinteger)(X$1 - OLDX$1) );
			}
			goto label$3552;
			label$3553:;
		}
		goto label$3549;
		label$3550:;
		if( OUTBPP$1 != 2 ) goto label$3581;
		label$3582:;
		{
			puts( (char*)"PAINT: 16bpp disabled" );
		}
		goto label$3549;
		label$3581:;
		{
			puts( (char*)"PAINT: other bpp not yet..." );
		}
		label$3583:;
		label$3549:;
	}
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
	goto label$3540;
	label$3540:;
}

static        void fb_GfxEllipse( void* PTARGET$1, single SX$1, single SY$1, single FRADIUS$1, uinteger ICOLOR$1, single FASPECT$1, single FSTART$1, single FEND$1, integer IFILLED$1, integer IFLAGS$1 )
{
	label$3584:;
	integer X0$1;
	integer vr$5639 = fb_ftosi( SX$1 );
	X0$1 = vr$5639;
	integer Y0$1;
	integer vr$5640 = fb_ftosi( SY$1 );
	Y0$1 = vr$5640;
	integer OUTWID$1;
	integer OUTHEI$1;
	integer OUTBPP$1;
	integer OUTPITCH$1;
	void* OUTDATA$1;
	if( PTARGET$1 != 0 ) goto label$3587;
	{
		PTARGET$1 = (void*)_ZN3GFX4SCR$E;
	}
	label$3587:;
	label$3586:;
	struct FB$IMAGE* TEMPHEAD$1;
	TEMPHEAD$1 = (struct FB$IMAGE*)PTARGET$1;
	{
		struct FB$IMAGE* TMP$808$2;
		TMP$808$2 = TEMPHEAD$1;
		OUTWID$1 = *(integer*)((ubyte*)TMP$808$2 + 8);
		OUTHEI$1 = *(integer*)((ubyte*)TMP$808$2 + 12);
		OUTBPP$1 = *(integer*)((ubyte*)TMP$808$2 + 4);
		OUTDATA$1 = (void*)((ubyte*)TEMPHEAD$1 + 32);
		OUTPITCH$1 = *(integer*)((ubyte*)TMP$808$2 + 16);
	}
	label$3589:;
	label$3588:;
	if( IFLAGS$1 == 4 ) goto label$3591;
	{
		printf( (char*)"CIRCLE: Unknown flags %i", IFLAGS$1 );
		goto label$3585;
	}
	label$3591:;
	label$3590:;
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + 1);
	{
		if( OUTBPP$1 != 1 ) goto label$3593;
		label$3594:;
		{
			if( FASPECT$1 == 0.0f ) goto label$3596;
			{
				puts( (char*)"CIRCLE: ellipse not yet" );
			}
			goto label$3595;
			label$3596:;
			{
				integer X$4;
				integer vr$5649 = fb_ftosi( FRADIUS$1 );
				X$4 = vr$5649;
				integer Y$4;
				Y$4 = 0;
				integer RADIUSERROR$4;
				RADIUSERROR$4 = 1 - X$4;
				integer IBUFFSZ$4;
				IBUFFSZ$4 = OUTPITCH$1 * OUTHEI$1;
				byte* PMIDPIX$4;
				PMIDPIX$4 = (byte*)((ubyte*)((ubyte*)OUTDATA$1 + (Y0$1 * OUTPITCH$1)) + X0$1);
				if( IFILLED$1 == 0 ) goto label$3598;
				{
					PMIDPIX$4 = (byte*)((ubyte*)PMIDPIX$4 - X0$1);
					byte* Q0$5;
					Q0$5 = (byte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1));
					byte* Q1$5;
					Q1$5 = (byte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1));
					byte* Q2$5;
					Q2$5 = (byte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1));
					byte* Q3$5;
					Q3$5 = (byte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1));
					label$3599:;
					if( X$4 < Y$4 ) goto label$3600;
					{
						integer IAMOUNTY$6;
						IAMOUNTY$6 = (Y$4 + Y$4) + 1;
						integer IAMOUNTX$6;
						IAMOUNTX$6 = (X$4 + X$4) + 1;
						integer ILEFTY$6;
						ILEFTY$6 = X0$1 - Y$4;
						integer ILEFTX$6;
						ILEFTX$6 = X0$1 - X$4;
						if( ILEFTY$6 >= 0 ) goto label$3602;
						IAMOUNTY$6 = IAMOUNTY$6 + ILEFTY$6;
						ILEFTY$6 = 0;
						label$3602:;
						if( ILEFTX$6 >= 0 ) goto label$3604;
						IAMOUNTX$6 = IAMOUNTX$6 + ILEFTX$6;
						ILEFTX$6 = 0;
						label$3604:;
						if( (X0$1 + Y$4) < OUTWID$1 ) goto label$3606;
						IAMOUNTY$6 = (((IAMOUNTY$6 - X0$1) - Y$4) + OUTWID$1) + -1;
						label$3606:;
						if( (X0$1 + X$4) < OUTWID$1 ) goto label$3608;
						IAMOUNTX$6 = (((IAMOUNTX$6 - X0$1) - X$4) + OUTWID$1) + -1;
						label$3608:;
						if( IAMOUNTY$6 <= 0 ) goto label$3610;
						{
							if( ((uinteger)Q0$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3612;
							{
								memset( (void*)((ubyte*)Q0$5 + ILEFTY$6), (integer)ICOLOR$1, (uinteger)IAMOUNTY$6 );
							}
							label$3612:;
							label$3611:;
							if( ((uinteger)Q3$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3614;
							{
								memset( (void*)((ubyte*)Q3$5 + ILEFTY$6), (integer)ICOLOR$1, (uinteger)IAMOUNTY$6 );
							}
							label$3614:;
							label$3613:;
						}
						label$3610:;
						label$3609:;
						if( IAMOUNTX$6 <= 0 ) goto label$3616;
						{
							if( ((uinteger)Q1$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3618;
							{
								memset( (void*)((ubyte*)Q1$5 + ILEFTX$6), (integer)ICOLOR$1, (uinteger)IAMOUNTX$6 );
							}
							label$3618:;
							label$3617:;
							if( ((uinteger)Q2$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3620;
							{
								memset( (void*)((ubyte*)Q2$5 + ILEFTX$6), (integer)ICOLOR$1, (uinteger)IAMOUNTX$6 );
							}
							label$3620:;
							label$3619:;
						}
						label$3616:;
						label$3615:;
						Y$4 = Y$4 + 1;
						Q1$5 = (byte*)((ubyte*)Q1$5 - OUTPITCH$1);
						Q2$5 = (byte*)((ubyte*)Q2$5 + OUTPITCH$1);
						if( RADIUSERROR$4 >= 0 ) goto label$3622;
						{
							RADIUSERROR$4 = (RADIUSERROR$4 + (2 * Y$4)) + 1;
						}
						goto label$3621;
						label$3622:;
						{
							X$4 = X$4 + -1;
							Q0$5 = (byte*)((ubyte*)Q0$5 + OUTPITCH$1);
							Q3$5 = (byte*)((ubyte*)Q3$5 - OUTPITCH$1);
							RADIUSERROR$4 = RADIUSERROR$4 + (2 * ((Y$4 - X$4) + 1));
						}
						label$3621:;
					}
					goto label$3599;
					label$3600:;
				}
				goto label$3597;
				label$3598:;
				if( FSTART$1 == 0.0f ) goto label$3623;
				{
					integer TMP$811$5;
					integer TMP$812$5;
					integer TMP$813$5;
					integer TMP$814$5;
					integer TMP$815$5;
					integer TMP$816$5;
					integer TMP$817$5;
					integer TMP$818$5;
					integer TMP$819$5;
					integer TMP$820$5;
					integer TMP$821$5;
					integer TMP$822$5;
					integer TMP$823$5;
					integer TMP$824$5;
					integer TMP$825$5;
					integer TMP$826$5;
					integer ISTARTANG$5;
					integer vr$5704 = fb_dtosi( FSTART$1 * 2607.594549096069 );
					ISTARTANG$5 = vr$5704 & 16383;
					integer IENDANG$5;
					integer vr$5707 = fb_dtosi( FEND$1 * 2607.594549096069 );
					IENDANG$5 = vr$5707 & 16383;
					if( ISTARTANG$5 <= IENDANG$5 ) goto label$3625;
					IENDANG$5 = IENDANG$5 + 16384;
					label$3625:;
					ubyte* Q0$5;
					__builtin_memset( &Q0$5, 0, 4 );
					ubyte* Q1$5;
					__builtin_memset( &Q1$5, 0, 4 );
					ubyte* Q2$5;
					__builtin_memset( &Q2$5, 0, 4 );
					ubyte* Q3$5;
					__builtin_memset( &Q3$5, 0, 4 );
					ubyte* Q4$5;
					__builtin_memset( &Q4$5, 0, 4 );
					ubyte* Q5$5;
					__builtin_memset( &Q5$5, 0, 4 );
					ubyte* Q6$5;
					__builtin_memset( &Q6$5, 0, 4 );
					ubyte* Q7$5;
					__builtin_memset( &Q7$5, 0, 4 );
					if( (-(ISTARTANG$5 >= 14336) & -(IENDANG$5 <= 16383)) != 0 ) goto label$3626;
					TMP$811$5 = -((-(IENDANG$5 >= 14336) & -(ISTARTANG$5 <= 16383)) != 0);
					goto label$3765;
					label$3626:;
					TMP$811$5 = -1;
					label$3765:;
					if( TMP$811$5 == 0 ) goto label$3628;
					Q0$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) + X$4);
					label$3628:;
					if( (-(ISTARTANG$5 >= 30720) & -(IENDANG$5 <= 32767)) != 0 ) goto label$3629;
					TMP$812$5 = -((-(IENDANG$5 >= 30720) & -(ISTARTANG$5 <= 32767)) != 0);
					goto label$3766;
					label$3629:;
					TMP$812$5 = -1;
					label$3766:;
					if( TMP$812$5 == 0 ) goto label$3631;
					Q0$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) + X$4);
					label$3631:;
					if( (-(ISTARTANG$5 >= 12288) & -(IENDANG$5 <= 14335)) != 0 ) goto label$3632;
					TMP$813$5 = -((-(IENDANG$5 >= 12288) & -(ISTARTANG$5 <= 14335)) != 0);
					goto label$3767;
					label$3632:;
					TMP$813$5 = -1;
					label$3767:;
					if( TMP$813$5 == 0 ) goto label$3634;
					Q1$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) + Y$4);
					label$3634:;
					if( (-(ISTARTANG$5 >= 28672) & -(IENDANG$5 <= 30719)) != 0 ) goto label$3635;
					TMP$814$5 = -((-(IENDANG$5 >= 28672) & -(ISTARTANG$5 <= 30719)) != 0);
					goto label$3768;
					label$3635:;
					TMP$814$5 = -1;
					label$3768:;
					if( TMP$814$5 == 0 ) goto label$3637;
					Q1$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) + Y$4);
					label$3637:;
					if( (-(ISTARTANG$5 >= 10240) & -(IENDANG$5 <= 12887)) != 0 ) goto label$3638;
					TMP$815$5 = -((-(IENDANG$5 >= 10240) & -(ISTARTANG$5 <= 12887)) != 0);
					goto label$3769;
					label$3638:;
					TMP$815$5 = -1;
					label$3769:;
					if( TMP$815$5 == 0 ) goto label$3640;
					Q2$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) - Y$4);
					label$3640:;
					if( (-(ISTARTANG$5 >= 26624) & -(IENDANG$5 <= 29271)) != 0 ) goto label$3641;
					TMP$816$5 = -((-(IENDANG$5 >= 26624) & -(ISTARTANG$5 <= 29271)) != 0);
					goto label$3770;
					label$3641:;
					TMP$816$5 = -1;
					label$3770:;
					if( TMP$816$5 == 0 ) goto label$3643;
					Q2$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) - Y$4);
					label$3643:;
					if( (-(ISTARTANG$5 >= 8192) & -(IENDANG$5 <= 10239)) != 0 ) goto label$3644;
					TMP$817$5 = -((-(IENDANG$5 >= 8192) & -(ISTARTANG$5 <= 10239)) != 0);
					goto label$3771;
					label$3644:;
					TMP$817$5 = -1;
					label$3771:;
					if( TMP$817$5 == 0 ) goto label$3646;
					Q3$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) - X$4);
					label$3646:;
					if( (-(ISTARTANG$5 >= 24576) & -(IENDANG$5 <= 26623)) != 0 ) goto label$3647;
					TMP$818$5 = -((-(IENDANG$5 >= 24576) & -(ISTARTANG$5 <= 26623)) != 0);
					goto label$3772;
					label$3647:;
					TMP$818$5 = -1;
					label$3772:;
					if( TMP$818$5 == 0 ) goto label$3649;
					Q3$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) - X$4);
					label$3649:;
					if( (-(ISTARTANG$5 >= 6144) & -(IENDANG$5 <= 8191)) != 0 ) goto label$3650;
					TMP$819$5 = -((-(IENDANG$5 >= 6144) & -(ISTARTANG$5 <= 8191)) != 0);
					goto label$3773;
					label$3650:;
					TMP$819$5 = -1;
					label$3773:;
					if( TMP$819$5 == 0 ) goto label$3652;
					Q4$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) - X$4);
					label$3652:;
					if( (-(ISTARTANG$5 >= 22528) & -(IENDANG$5 <= 24575)) != 0 ) goto label$3653;
					TMP$820$5 = -((-(IENDANG$5 >= 22528) & -(ISTARTANG$5 <= 24575)) != 0);
					goto label$3774;
					label$3653:;
					TMP$820$5 = -1;
					label$3774:;
					if( TMP$820$5 == 0 ) goto label$3655;
					Q4$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) - X$4);
					label$3655:;
					if( (-(ISTARTANG$5 >= 4096) & -(IENDANG$5 <= 6143)) != 0 ) goto label$3656;
					TMP$821$5 = -((-(IENDANG$5 >= 4096) & -(ISTARTANG$5 <= 6143)) != 0);
					goto label$3775;
					label$3656:;
					TMP$821$5 = -1;
					label$3775:;
					if( TMP$821$5 == 0 ) goto label$3658;
					Q5$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) - Y$4);
					label$3658:;
					if( (-(ISTARTANG$5 >= 20480) & -(IENDANG$5 <= 22527)) != 0 ) goto label$3659;
					TMP$822$5 = -((-(IENDANG$5 >= 20480) & -(ISTARTANG$5 <= 22527)) != 0);
					goto label$3776;
					label$3659:;
					TMP$822$5 = -1;
					label$3776:;
					if( TMP$822$5 == 0 ) goto label$3661;
					Q5$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) - Y$4);
					label$3661:;
					if( (-(ISTARTANG$5 >= 2048) & -(IENDANG$5 <= 4095)) != 0 ) goto label$3662;
					TMP$823$5 = -((-(IENDANG$5 >= 2048) & -(ISTARTANG$5 <= 4095)) != 0);
					goto label$3777;
					label$3662:;
					TMP$823$5 = -1;
					label$3777:;
					if( TMP$823$5 == 0 ) goto label$3664;
					Q6$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) + Y$4);
					label$3664:;
					if( (-(ISTARTANG$5 >= 18432) & -(IENDANG$5 <= 20479)) != 0 ) goto label$3665;
					TMP$824$5 = -((-(IENDANG$5 >= 18432) & -(ISTARTANG$5 <= 20479)) != 0);
					goto label$3778;
					label$3665:;
					TMP$824$5 = -1;
					label$3778:;
					if( TMP$824$5 == 0 ) goto label$3667;
					Q6$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) + Y$4);
					label$3667:;
					if( (-(ISTARTANG$5 >= 0) & -(IENDANG$5 <= 2047)) != 0 ) goto label$3668;
					TMP$825$5 = -((-(IENDANG$5 >= 0) & -(ISTARTANG$5 <= 2047)) != 0);
					goto label$3779;
					label$3668:;
					TMP$825$5 = -1;
					label$3779:;
					if( TMP$825$5 == 0 ) goto label$3670;
					Q7$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) + X$4);
					label$3670:;
					if( (-(ISTARTANG$5 >= 16384) & -(IENDANG$5 <= 18431)) != 0 ) goto label$3671;
					TMP$826$5 = -((-(IENDANG$5 >= 16384) & -(ISTARTANG$5 <= 18431)) != 0);
					goto label$3780;
					label$3671:;
					TMP$826$5 = -1;
					label$3780:;
					if( TMP$826$5 == 0 ) goto label$3673;
					Q7$5 = (ubyte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) + X$4);
					label$3673:;
					label$3674:;
					if( X$4 < Y$4 ) goto label$3675;
					{
						short I7$6;
						I7$6 = *(short*)((ubyte*)IFBATNTAB$ + (((Y$4 << 11) / X$4) << 1));
						integer I6$6;
						I6$6 = 4095 - (integer)I7$6;
						integer I5$6;
						I5$6 = (integer)I7$6 + 4096;
						integer I4$6;
						I4$6 = 8192 - (integer)I7$6;
						integer I3$6;
						I3$6 = (integer)I7$6 + 8192;
						integer I2$6;
						I2$6 = 12288 - (integer)I7$6;
						integer I1$6;
						I1$6 = (integer)I7$6 + 12288;
						integer I0$6;
						I0$6 = 16383 - (integer)I7$6;
						if( (uinteger)(X0$1 + X$4) >= OUTWID$1 ) goto label$3677;
						{
							if( ((uinteger)Q0$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3679;
							{
								if( (-(I0$6 >= ISTARTANG$5) & -(I0$6 <= IENDANG$5)) == 0 ) goto label$3681;
								*Q0$5 = (ubyte)ICOLOR$1;
								label$3681:;
								if( (-(I0$6 >= (ISTARTANG$5 + -16384)) & -(I0$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3683;
								*Q0$5 = (ubyte)ICOLOR$1;
								label$3683:;
							}
							label$3679:;
							label$3678:;
							if( ((uinteger)Q7$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3685;
							{
								if( (-((integer)I7$6 >= ISTARTANG$5) & -((integer)I7$6 <= IENDANG$5)) == 0 ) goto label$3687;
								*Q7$5 = (ubyte)ICOLOR$1;
								label$3687:;
								if( (-((integer)I7$6 >= (ISTARTANG$5 + -16384)) & -((integer)I7$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3689;
								*Q7$5 = (ubyte)ICOLOR$1;
								label$3689:;
							}
							label$3685:;
							label$3684:;
						}
						label$3677:;
						label$3676:;
						if( (uinteger)(X0$1 + Y$4) >= OUTWID$1 ) goto label$3691;
						{
							if( ((uinteger)Q1$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3693;
							{
								if( (-(I1$6 >= ISTARTANG$5) & -(I1$6 <= IENDANG$5)) == 0 ) goto label$3695;
								*Q1$5 = (ubyte)ICOLOR$1;
								label$3695:;
								if( (-(I1$6 >= (ISTARTANG$5 + -16384)) & -(I1$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3697;
								*Q1$5 = (ubyte)ICOLOR$1;
								label$3697:;
							}
							label$3693:;
							label$3692:;
							if( ((uinteger)Q6$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3699;
							{
								if( (-(I6$6 >= ISTARTANG$5) & -(I6$6 <= IENDANG$5)) == 0 ) goto label$3701;
								*Q6$5 = (ubyte)ICOLOR$1;
								label$3701:;
								if( (-(I6$6 >= (ISTARTANG$5 + -16384)) & -(I6$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3703;
								*Q6$5 = (ubyte)ICOLOR$1;
								label$3703:;
							}
							label$3699:;
							label$3698:;
						}
						label$3691:;
						label$3690:;
						if( (uinteger)(X0$1 - X$4) >= OUTWID$1 ) goto label$3705;
						{
							if( ((uinteger)Q3$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3707;
							{
								if( (-(I3$6 >= ISTARTANG$5) & -(I3$6 <= IENDANG$5)) == 0 ) goto label$3709;
								*Q3$5 = (ubyte)ICOLOR$1;
								label$3709:;
								if( (-(I3$6 >= (ISTARTANG$5 + -16384)) & -(I3$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3711;
								*Q3$5 = (ubyte)ICOLOR$1;
								label$3711:;
							}
							label$3707:;
							label$3706:;
							if( ((uinteger)Q4$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3713;
							{
								if( (-(I4$6 >= ISTARTANG$5) & -(I4$6 <= IENDANG$5)) == 0 ) goto label$3715;
								*Q4$5 = (ubyte)ICOLOR$1;
								label$3715:;
								if( (-(I4$6 >= (ISTARTANG$5 + -16384)) & -(I4$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3717;
								*Q4$5 = (ubyte)ICOLOR$1;
								label$3717:;
							}
							label$3713:;
							label$3712:;
						}
						label$3705:;
						label$3704:;
						if( (uinteger)(X0$1 - Y$4) >= OUTWID$1 ) goto label$3719;
						{
							if( ((uinteger)Q2$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3721;
							{
								if( (-(I2$6 >= ISTARTANG$5) & -(I2$6 <= IENDANG$5)) == 0 ) goto label$3723;
								*Q2$5 = (ubyte)ICOLOR$1;
								label$3723:;
								if( (-(I2$6 >= (ISTARTANG$5 + -16384)) & -(I2$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3725;
								*Q2$5 = (ubyte)ICOLOR$1;
								label$3725:;
							}
							label$3721:;
							label$3720:;
							if( ((uinteger)Q5$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3727;
							{
								if( (-(I5$6 >= ISTARTANG$5) & -(I5$6 <= IENDANG$5)) == 0 ) goto label$3729;
								*Q5$5 = (ubyte)ICOLOR$1;
								label$3729:;
								if( (-(I5$6 >= (ISTARTANG$5 + -16384)) & -(I5$6 <= (IENDANG$5 + -16384))) == 0 ) goto label$3731;
								*Q5$5 = (ubyte)ICOLOR$1;
								label$3731:;
							}
							label$3727:;
							label$3726:;
						}
						label$3719:;
						label$3718:;
						Y$4 = Y$4 + 1;
						Q0$5 = (ubyte*)(Q0$5 + OUTPITCH$1);
						Q1$5 = (ubyte*)(Q1$5 + 1);
						Q2$5 = (ubyte*)(Q2$5 + -1);
						Q3$5 = (ubyte*)(Q3$5 + OUTPITCH$1);
						Q4$5 = (ubyte*)(Q4$5 - OUTPITCH$1);
						Q5$5 = (ubyte*)(Q5$5 + -1);
						Q6$5 = (ubyte*)(Q6$5 + 1);
						Q7$5 = (ubyte*)(Q7$5 - OUTPITCH$1);
						if( RADIUSERROR$4 >= 0 ) goto label$3733;
						{
							RADIUSERROR$4 = (RADIUSERROR$4 + (2 * Y$4)) + 1;
						}
						goto label$3732;
						label$3733:;
						{
							X$4 = X$4 + -1;
							Q0$5 = (ubyte*)(Q0$5 + -1);
							Q1$5 = (ubyte*)(Q1$5 - OUTPITCH$1);
							Q2$5 = (ubyte*)(Q2$5 - OUTPITCH$1);
							Q3$5 = (ubyte*)(Q3$5 + 1);
							Q4$5 = (ubyte*)(Q4$5 + 1);
							Q5$5 = (ubyte*)(Q5$5 + OUTPITCH$1);
							Q6$5 = (ubyte*)(Q6$5 + OUTPITCH$1);
							Q7$5 = (ubyte*)(Q7$5 + -1);
							RADIUSERROR$4 = RADIUSERROR$4 + (2 * ((Y$4 - X$4) + 1));
						}
						label$3732:;
					}
					goto label$3674;
					label$3675:;
				}
				goto label$3597;
				label$3623:;
				{
					byte* Q0$5;
					Q0$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) + X$4);
					byte* Q1$5;
					Q1$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) + Y$4);
					byte* Q2$5;
					Q2$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 + (X$4 * OUTPITCH$1)) - Y$4);
					byte* Q3$5;
					Q3$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 + (Y$4 * OUTPITCH$1)) - X$4);
					byte* Q4$5;
					Q4$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) - X$4);
					byte* Q5$5;
					Q5$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) - Y$4);
					byte* Q6$5;
					Q6$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 - (X$4 * OUTPITCH$1)) + Y$4);
					byte* Q7$5;
					Q7$5 = (byte*)((ubyte*)((ubyte*)PMIDPIX$4 - (Y$4 * OUTPITCH$1)) + X$4);
					label$3734:;
					if( X$4 < Y$4 ) goto label$3735;
					{
						if( (uinteger)(X0$1 + X$4) >= OUTWID$1 ) goto label$3737;
						{
							if( ((uinteger)Q0$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3739;
							{
								*Q0$5 = (byte)ICOLOR$1;
							}
							label$3739:;
							label$3738:;
							if( ((uinteger)Q7$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3741;
							{
								*Q7$5 = (byte)ICOLOR$1;
							}
							label$3741:;
							label$3740:;
						}
						label$3737:;
						label$3736:;
						if( (uinteger)(X0$1 + Y$4) >= OUTWID$1 ) goto label$3743;
						{
							if( ((uinteger)Q1$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3745;
							{
								*Q1$5 = (byte)ICOLOR$1;
							}
							label$3745:;
							label$3744:;
							if( ((uinteger)Q6$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3747;
							{
								*Q6$5 = (byte)ICOLOR$1;
							}
							label$3747:;
							label$3746:;
						}
						label$3743:;
						label$3742:;
						if( (uinteger)(X0$1 - X$4) >= OUTWID$1 ) goto label$3749;
						{
							if( ((uinteger)Q3$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3751;
							{
								*Q3$5 = (byte)ICOLOR$1;
							}
							label$3751:;
							label$3750:;
							if( ((uinteger)Q4$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3753;
							{
								*Q4$5 = (byte)ICOLOR$1;
							}
							label$3753:;
							label$3752:;
						}
						label$3749:;
						label$3748:;
						if( (uinteger)(X0$1 - Y$4) >= OUTWID$1 ) goto label$3755;
						{
							if( ((uinteger)Q2$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3757;
							{
								*Q2$5 = (byte)ICOLOR$1;
							}
							label$3757:;
							label$3756:;
							if( ((uinteger)Q5$5 - (uinteger)OUTDATA$1) >= IBUFFSZ$4 ) goto label$3759;
							{
								*Q5$5 = (byte)ICOLOR$1;
							}
							label$3759:;
							label$3758:;
						}
						label$3755:;
						label$3754:;
						Y$4 = Y$4 + 1;
						Q0$5 = (byte*)((ubyte*)Q0$5 + OUTPITCH$1);
						Q1$5 = (byte*)((ubyte*)Q1$5 + 1);
						Q2$5 = (byte*)((ubyte*)Q2$5 + -1);
						Q3$5 = (byte*)((ubyte*)Q3$5 + OUTPITCH$1);
						Q4$5 = (byte*)((ubyte*)Q4$5 - OUTPITCH$1);
						Q5$5 = (byte*)((ubyte*)Q5$5 + -1);
						Q6$5 = (byte*)((ubyte*)Q6$5 + 1);
						Q7$5 = (byte*)((ubyte*)Q7$5 - OUTPITCH$1);
						if( RADIUSERROR$4 >= 0 ) goto label$3761;
						{
							RADIUSERROR$4 = (RADIUSERROR$4 + (2 * Y$4)) + 1;
						}
						goto label$3760;
						label$3761:;
						{
							X$4 = X$4 + -1;
							Q0$5 = (byte*)((ubyte*)Q0$5 + -1);
							Q1$5 = (byte*)((ubyte*)Q1$5 - OUTPITCH$1);
							Q2$5 = (byte*)((ubyte*)Q2$5 - OUTPITCH$1);
							Q3$5 = (byte*)((ubyte*)Q3$5 + 1);
							Q4$5 = (byte*)((ubyte*)Q4$5 + 1);
							Q5$5 = (byte*)((ubyte*)Q5$5 + OUTPITCH$1);
							Q6$5 = (byte*)((ubyte*)Q6$5 + OUTPITCH$1);
							Q7$5 = (byte*)((ubyte*)Q7$5 + -1);
							RADIUSERROR$4 = RADIUSERROR$4 + (2 * ((Y$4 - X$4) + 1));
						}
						label$3760:;
					}
					goto label$3734;
					label$3735:;
				}
				label$3597:;
			}
			label$3595:;
		}
		goto label$3592;
		label$3593:;
		if( OUTBPP$1 != 2 ) goto label$3762;
		label$3763:;
		{
			ushort vr$6109 = fb_Gfx24to16( ICOLOR$1 );              
			ICOLOR$1 = (uinteger)vr$6109;
			puts( (char*)"CIRCLE: 16bpp disabled" );
		}
		goto label$3592;
		label$3762:;
		{
			puts( (char*)"CIRCLE: other bpp not yet" );
		}
		label$3764:;
		label$3592:;
	}
	_ZN3GFX7LOCKED$E = (short)((integer)_ZN3GFX7LOCKED$E + -1);
	goto label$3585;
	label$3585:;
}

void _ZN3GFX10INITSCREENEa( byte BONTOP$1 )
{
	label$3781:;
	fb_GfxScreenRes( 256, 192, 8, 0, 0, 0 );
	fb_GfxLock(  );
	ubyte* PSCR$1;
	void* vr$6114 = fb_GfxScreenPtr(  );
	PSCR$1 = (ubyte*)vr$6114;
	{
		long Y$2;
		Y$2 = 0;
		label$3786:;
		{
			integer IC$3;
			IC$3 = (integer)(176 + (Y$2 / 12));
			double ID$3;
			ID$3 = (double)(Y$2 % 12) / 12.0;
			{
				long X$4;
				X$4 = 0;
				label$3790:;
				{
					double IC2$5;
					double vr$6121 = fb_Rnd( 1.0f );
					IC2$5 = (double)IC$3 + (vr$6121 * 2.0);
					integer vr$6127 = fb_dtosi( IC2$5 );
					*(ubyte*)(PSCR$1 + (integer)X$4) = (ubyte)(-((X$4 + Y$2) & 1) & vr$6127);
				}
				label$3788:;
				X$4 = X$4 + 1;
				label$3787:;
				if( X$4 <= 255 ) goto label$3790;
				label$3789:;
			}
			PSCR$1 = (ubyte*)(PSCR$1 + 256);
		}
		label$3784:;
		Y$2 = Y$2 + 1;
		label$3783:;
		if( Y$2 <= 191 ) goto label$3786;
		label$3785:;
	}
	fb_GfxLine( 0, 63.0f, 31.0f, 192.0f, 160.0f, 0u, 2, 65535u, 0 );
	fb_GfxLine( 0, 63.0f, 31.0f, 192.0f, 160.0f, 31u, 1, 65535u, 0 );
	fb_GfxUnlock( -1, -1 );
	_ZN2FB13KEYBOARDISON$E = (byte)1;
	lcdMainOnTop(  );
	*(integer*)((ubyte*)FBKEYBOARD$ + 12) = -184 + (integer)_ZN2FB15KEYBOARDOFFSET$E;
	keyboardShow(  );
	memset( (void*)TBUFF$, -1, 1024 );
	fb_GfxPalette( 0, 0, 0, 0 );
	fb_GfxPalette( 1, 255, 255, 255 );
	fb_GfxPalette( 2, 136, 0, 0 );
	fb_GfxPalette( 3, 170, 255, 238 );
	fb_GfxPalette( 4, 204, 68, 204 );
	fb_GfxPalette( 5, 0, 204, 85 );
	fb_GfxPalette( 6, 0, 0, 170 );
	fb_GfxPalette( 7, 238, 238, 119 );
	fb_GfxPalette( 8, 221, 136, 85 );
	fb_GfxPalette( 9, 102, 68, 0 );
	fb_GfxPalette( 10, 255, 119, 119 );
	fb_GfxPalette( 11, 51, 51, 51 );
	fb_GfxPalette( 12, 119, 119, 119 );
	fb_GfxPalette( 13, 170, 255, 102 );
	fb_GfxPalette( 14, 0, 136, 255 );
	fb_GfxPalette( 15, 187, 187, 187 );
	BSCREENON$ = (ubyte)1;
	label$3782:;
}

long _ZN3GFX12ISSCREENOPENEv( void )
{
	integer TMP$831$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3791:;
	if( (uinteger)BSCREENON$ == 0 ) goto label$3793;
	void* vr$6139 = fb_GfxScreenPtr(  );
	TMP$831$1 = -(-(vr$6139 != 0) != 0);
	goto label$3794;
	label$3793:;
	TMP$831$1 = 0;
	label$3794:;
	fb$result$1 = (long)TMP$831$1;
	goto label$3792;
	label$3792:;
	return fb$result$1;
}

void _ZN3GFX9SCREENPOSEii( integer IX$1, integer IY$1 )
{
	label$3795:;
	if( (uinteger)BSCREENON$ != 0 ) goto label$3798;
	goto label$3796;
	label$3798:;
	label$3796:;
}

void _ZN3GFX11CLOSESCREENEv( void )
{
	label$3799:;
	if( (uinteger)BSCREENON$ != 0 ) goto label$3802;
	goto label$3800;
	label$3802:;
	BSCREENON$ = (ubyte)0;
	label$3800:;
}

long _ZN3GFX7READKEYEv( void )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3803:;
	fb$result$1 = 0;
	goto label$3804;
	label$3804:;
	return fb$result$1;
}

void _ZN3GFX12UPDATESCREENEPh( ubyte* PPIX$1 )
{
	label$3805:;
	if( (uinteger)BSCREENON$ != 0 ) goto label$3808;
	goto label$3806;
	label$3808:;
	long IN$1;
	IN$1 = 0;
	fb_GfxLock(  );
	ulong* PPTR$1;
	void* vr$6148 = fb_GfxScreenPtr(  );
	PPTR$1 = (ulong*)((ubyte*)vr$6148 + 8256);
	{
		long IY$2;
		IY$2 = 0;
		label$3812:;
		{
			{
				long IX$4;
				IX$4 = 0;
				label$3816:;
				{
					uinteger IC$5;
					IC$5 = (uinteger)*(ubyte*)(PPIX$1 + (integer)IN$1) & 15;
					if( IC$5 == (uinteger)*(ubyte*)((ubyte*)TBUFF$ + (integer)IN$1) ) goto label$3818;
					{
						*(ubyte*)((ubyte*)TBUFF$ + (integer)IN$1) = (ubyte)IC$5;
						ulong UPIX$6;
						UPIX$6 = (ulong)(((IC$5 + (IC$5 << 8)) + (IC$5 << 16)) + (IC$5 << 24));
						*PPTR$1 = UPIX$6;
						*(ulong*)((ubyte*)PPTR$1 + 256) = UPIX$6;
						*(ulong*)((ubyte*)PPTR$1 + 512) = UPIX$6;
						*(ulong*)((ubyte*)PPTR$1 + 768) = UPIX$6;
					}
					label$3818:;
					label$3817:;
					PPTR$1 = (ulong*)((ubyte*)PPTR$1 + 4);
					IN$1 = IN$1 + 1;
				}
				label$3814:;
				IX$4 = IX$4 + 1;
				label$3813:;
				if( IX$4 <= 31 ) goto label$3816;
				label$3815:;
			}
			PPTR$1 = (ulong*)((ubyte*)PPTR$1 + 896);
		}
		label$3810:;
		IY$2 = IY$2 + 1;
		label$3809:;
		if( IY$2 <= 31 ) goto label$3812;
		label$3811:;
	}
	fb_GfxUnlock( -1, -1 );
	label$3806:;
}

long GETLABEL( string* SLABEL$1, long* IADDR$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3827:;
	string SLABELL$1;
	string* vr$6171 = fb_LCASE( (string*)SLABEL$1 );
	string* vr$6173 = fb_StrInit( (void*)&SLABELL$1, -1, vr$6171, -1, 0 );
	{
		long N$2;
		N$2 = 0;
		long TMP$848$2;
		TMP$848$2 = G_ILABELSCOUNT$ + -1;
		goto label$3829;
		label$3832:;
		{
			integer vr$6178 = fb_StrCompare( (void*)&SLABELL$1, -1, (void*)((ubyte*)G_TLABEL$ + ((integer)N$2 << 6)), 56 );
			if( vr$6178 != 0 ) goto label$3834;
			{
				*(long*)IADDR$1 = *(long*)(((ubyte*)G_TLABEL$ + ((integer)N$2 << 6)) + 56);
				fb$result$1 = N$2;
				fb_StrDelete( &SLABELL$1 );
				goto label$3828;
			}
			label$3834:;
			label$3833:;
		}
		label$3830:;
		N$2 = N$2 + 1;
		label$3829:;
		if( N$2 <= TMP$848$2 ) goto label$3832;
		label$3831:;
	}
	fb$result$1 = -1;
	fb_StrDelete( &SLABELL$1 );
	goto label$3828;
	fb_StrDelete( &SLABELL$1 );
	label$3828:;
	return fb$result$1;
}

long ADDLABEL( string* SLABEL$1, long UADDR$1, byte B16$1 )
{
	integer TMP$849$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3835:;
	long IEXISTADDR$1;
	__builtin_memset( &IEXISTADDR$1, 0, 4 );
	long IIDX$1;
	long vr$6189 = GETLABEL( (string*)SLABEL$1, &IEXISTADDR$1 );
	IIDX$1 = vr$6189;
	if( IIDX$1 >= 0 ) goto label$3838;
	{
		string* vr$6190 = fb_LCASE( (string*)SLABEL$1 );
		fb_StrAssign( (void*)((ubyte*)G_TLABEL$ + ((integer)G_ILABELSCOUNT$ << 6)), 56, vr$6190, -1, 0 );
		*(long*)(((ubyte*)G_TLABEL$ + ((integer)G_ILABELSCOUNT$ << 6)) + 56) = UADDR$1;
		*(ubyte*)(((ubyte*)G_TLABEL$ + ((integer)G_ILABELSCOUNT$ << 6)) + 60) = (ubyte)B16$1;
		G_ILABELSCOUNT$ = G_ILABELSCOUNT$ + 1;
		fb$result$1 = G_ILABELSCOUNT$ + -1;
		goto label$3836;
	}
	label$3838:;
	label$3837:;
	if( -(UADDR$1 >= 0) != 0 ) goto label$3839;
	TMP$849$1 = -(-(IEXISTADDR$1 < 0) != 0);
	goto label$3842;
	label$3839:;
	TMP$849$1 = -1;
	label$3842:;
	if( TMP$849$1 == 0 ) goto label$3841;
	{
		*(long*)(((ubyte*)G_TLABEL$ + ((integer)IIDX$1 << 6)) + 56) = UADDR$1;
		*(ubyte*)(((ubyte*)G_TLABEL$ + ((integer)IIDX$1 << 6)) + 60) = (ubyte)B16$1;
		fb$result$1 = IIDX$1;
		goto label$3836;
	}
	label$3841:;
	label$3840:;
	fb$result$1 = -1;
	goto label$3836;
	label$3836:;
	return fb$result$1;
}

long ADDPATCH( struct PATCHSTRUCT* TPATCH$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3843:;
	__builtin_memcpy( (struct PATCHSTRUCT*)((ubyte*)G_TPATCH$ + ((integer)G_IPATCHCOUNT$ << 3)), (struct PATCHSTRUCT*)TPATCH$1, 8 );
	G_IPATCHCOUNT$ = G_IPATCHCOUNT$ + 1;
	fb$result$1 = G_IPATCHCOUNT$ + -1;
	goto label$3844;
	label$3844:;
	return fb$result$1;
}

long ADDBLOCK( long UBEGIN$1, long UEND$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3845:;
	memset( (void*)((ubyte*)G_BMEMCHG$ + (integer)UBEGIN$1), 2, (uinteger)(UEND$1 - UBEGIN$1) );
	*(ushort*)((ubyte*)G_TBLOCK$ + ((integer)G_IBLOCKCOUNT$ << 2)) = (ushort)UBEGIN$1;
	*(ushort*)(((ubyte*)G_TBLOCK$ + ((integer)G_IBLOCKCOUNT$ << 2)) + 2) = (ushort)UEND$1;
	G_IBLOCKCOUNT$ = G_IBLOCKCOUNT$ + 1;
	fb$result$1 = G_IBLOCKCOUNT$ + -1;
	goto label$3846;
	label$3846:;
	return fb$result$1;
}

long NOMOREPARMS_( void )
{
	struct PARSERSTRUCT* TMP$851$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3847:;
	TMP$851$1 = &G_TPARSER$;
	label$3849:;
	{
		{
			ubyte TMP$852$3;
			TMP$852$3 = *(ubyte*)((ubyte*)*(char**)TMP$851$1 + *(integer*)((ubyte*)TMP$851$1 + 20));
			if( (uinteger)TMP$852$3 == 59u ) goto label$3854;
			label$3855:;
			if( (uinteger)TMP$852$3 == 13 ) goto label$3854;
			label$3856:;
			if( (uinteger)TMP$852$3 == 10 ) goto label$3854;
			label$3857:;
			if( (uinteger)TMP$852$3 != 0 ) goto label$3853;
			label$3854:;
			{
				fb$result$1 = 1;
				goto label$3848;
			}
			goto label$3852;
			label$3853:;
			if( (uinteger)TMP$852$3 == 9 ) goto label$3859;
			label$3860:;
			if( (uinteger)TMP$852$3 != 32 ) goto label$3858;
			label$3859:;
			{
			}
			goto label$3852;
			label$3858:;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"ERROR: bad character after opcode '%c'\n", (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$851$1 + *(integer*)((ubyte*)TMP$851$1 + 20)) );
				fb$result$1 = -1;
				goto label$3848;
			}
			label$3861:;
			label$3852:;
		}
		*(long*)((ubyte*)TMP$851$1 + 20) = *(long*)((ubyte*)TMP$851$1 + 20) + 1;
	}
	label$3851:;
	goto label$3849;
	label$3850:;
	label$3848:;
	return fb$result$1;
}

void ENDOFLINE_( void )
{
	struct PARSERSTRUCT* TMP$854$1;
	integer TMP$855$1;
	label$3862:;
	TMP$854$1 = &G_TPARSER$;
	label$3864:;
	if( (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$854$1 + *(integer*)((ubyte*)TMP$854$1 + 20)) == 0 ) goto label$3866;
	TMP$855$1 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$854$1 + *(integer*)((ubyte*)TMP$854$1 + 20)) != 10) != 0);
	goto label$3867;
	label$3866:;
	TMP$855$1 = 0;
	label$3867:;
	if( TMP$855$1 == 0 ) goto label$3865;
	{
		*(long*)((ubyte*)TMP$854$1 + 20) = *(long*)((ubyte*)TMP$854$1 + 20) + 1;
	}
	goto label$3864;
	label$3865:;
	*(long*)((ubyte*)TMP$854$1 + 20) = *(long*)((ubyte*)TMP$854$1 + 20) + -1;
	label$3863:;
}

long OP___( long IOPCODEINDEX$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3868:;
	fb_Color( 12, 0, 2 );
	printf( (char*)"ERROR: opcode not implemented\n" );
	fb$result$1 = -1;
	goto label$3869;
	label$3869:;
	return fb$result$1;
}

long PROCESSEOL_( void )
{
	struct PARSERSTRUCT* TMP$917$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3870:;
	TMP$917$1 = &G_TPARSER$;
	*(ubyte*)((ubyte*)*(char**)TMP$917$1 + (integer)(*(long*)((ubyte*)TMP$917$1 + 20) + -1)) = (ubyte)0;
	*(long*)((ubyte*)G_LLINEINDEX$ + (*(integer*)((ubyte*)TMP$917$1 + 12) << 2)) = *(long*)((ubyte*)TMP$917$1 + 32);
	*(long*)((ubyte*)G_LPOSITION$ + (*(integer*)((ubyte*)TMP$917$1 + 48) << 2)) = *(long*)((ubyte*)TMP$917$1 + 12) + 1;
	*(long*)((ubyte*)TMP$917$1 + 12) = *(long*)((ubyte*)TMP$917$1 + 12) + 1;
	*(long*)((ubyte*)TMP$917$1 + 28) = -1;
	*(long*)((ubyte*)TMP$917$1 + 32) = *(long*)((ubyte*)TMP$917$1 + 20);
	*(long*)((ubyte*)TMP$917$1 + 40) = 0;
	*(long*)((ubyte*)TMP$917$1 + 44) = 0;
	*(ushort*)((ubyte*)G_WLINEADDR$ + (*(integer*)((ubyte*)TMP$917$1 + 12) << 1)) = (ushort)*(long*)((ubyte*)TMP$917$1 + 48);
	if( *(long*)((ubyte*)TMP$917$1 + 36) != 0 ) goto label$3873;
	fb$result$1 = 0;
	goto label$3871;
	label$3873:;
	fb$result$1 = 1;
	goto label$3871;
	label$3871:;
	return fb$result$1;
}

void PROCESSERROR_( void )
{
	struct PARSERSTRUCT* TMP$918$1;
	label$3874:;
	TMP$918$1 = &G_TPARSER$;
	printf( (char*)"'%c'\n", *(long*)((ubyte*)TMP$918$1 + 36) );
	if( *(long*)((ubyte*)TMP$918$1 + 40) != 0 ) goto label$3877;
	{
		puts( (char*)"S/N Error" );
		ENDOFLINE_(  );
		*(ubyte*)((ubyte*)*(char**)TMP$918$1 + *(integer*)((ubyte*)TMP$918$1 + 20)) = (ubyte)0;
		fb_Color( 8, 0, 2 );
		puts( (char*)((ubyte*)*(char**)TMP$918$1 + *(integer*)((ubyte*)TMP$918$1 + 32)) );
		*(ubyte*)((ubyte*)*(char**)TMP$918$1 + *(integer*)((ubyte*)TMP$918$1 + 20)) = (ubyte)*(long*)((ubyte*)TMP$918$1 + 36);
	}
	label$3877:;
	label$3876:;
	label$3875:;
}

ubyte NEXTCHAR_( void )
{
	struct PARSERSTRUCT* TMP$921$1;
	ubyte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$3878:;
	TMP$921$1 = &G_TPARSER$;
	label$3880:;
	{
		*(long*)((ubyte*)TMP$921$1 + 36) = (long)*(ubyte*)((ubyte*)*(char**)TMP$921$1 + *(integer*)((ubyte*)TMP$921$1 + 20));
		{
			long TMP$922$3;
			TMP$922$3 = *(long*)((ubyte*)TMP$921$1 + 36);
			if( TMP$922$3 == 32 ) goto label$3885;
			label$3886:;
			if( TMP$922$3 != 9 ) goto label$3884;
			label$3885:;
			{
			}
			goto label$3883;
			label$3884:;
			{
				fb$result$1 = (ubyte)*(long*)((ubyte*)TMP$921$1 + 36);
				goto label$3879;
			}
			label$3887:;
			label$3883:;
		}
		*(long*)((ubyte*)TMP$921$1 + 20) = *(long*)((ubyte*)TMP$921$1 + 20) + 1;
	}
	label$3882:;
	goto label$3880;
	label$3881:;
	label$3879:;
	return fb$result$1;
}

long TRANSLATEADDRESSING( long IOPCODEINDEX$1, byte BJUMP$1 )
{
	struct PARSERSTRUCT* TMP$923$1;
	integer TMP$943$1;
	integer TMP$975$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$3888:;
	byte BIMM$1;
	__builtin_memset( &BIMM$1, 0, 1 );
	byte BHEX$1;
	__builtin_memset( &BHEX$1, 0, 1 );
	byte BHI$1;
	__builtin_memset( &BHI$1, 0, 1 );
	byte BADDR$1;
	__builtin_memset( &BADDR$1, 0, 1 );
	byte BDIGCNT$1;
	__builtin_memset( &BDIGCNT$1, 0, 1 );
	byte BINDI$1;
	__builtin_memset( &BINDI$1, 0, 1 );
	byte BREG$1;
	__builtin_memset( &BREG$1, 0, 1 );
	long UVAL$1;
	__builtin_memset( &UVAL$1, 0, 4 );
	long ICHAR$1;
	__builtin_memset( &ICHAR$1, 0, 4 );
	string SPARAM$1;
	__builtin_memset( &SPARAM$1, 0, 12 );
	TMP$923$1 = &G_TPARSER$;
	struct OPCODESTRUCT* POP$1;
	POP$1 = (struct OPCODESTRUCT*)((ubyte*)TOPCODE$ + ((integer)IOPCODEINDEX$1 * 24));
	label$3890:;
	{
		ICHAR$1 = (long)*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20));
		*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
		{
			if( ICHAR$1 < 65u ) goto label$3896;
			if( ICHAR$1 <= 90u ) goto label$3895;
			label$3896:;
			if( ICHAR$1 < 97u ) goto label$3897;
			if( ICHAR$1 <= 122u ) goto label$3895;
			label$3897:;
			if( ICHAR$1 != 95u ) goto label$3894;
			label$3895:;
			{
				char* PZSTART$4;
				PZSTART$4 = (char*)((ubyte*)*(char**)TMP$923$1 + (integer)(*(long*)((ubyte*)TMP$923$1 + 20) + -1));
				label$3898:;
				{
					ICHAR$1 = (long)*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20));
					*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
					{
						if( ICHAR$1 < 65u ) goto label$3904;
						if( ICHAR$1 <= 90u ) goto label$3903;
						label$3904:;
						if( ICHAR$1 < 97u ) goto label$3902;
						if( ICHAR$1 > 122u ) goto label$3902;
						label$3903:;
						{
						}
						goto label$3901;
						label$3902:;
						if( ICHAR$1 < 48u ) goto label$3907;
						if( ICHAR$1 <= 57u ) goto label$3906;
						label$3907:;
						if( ICHAR$1 != 95u ) goto label$3905;
						label$3906:;
						{
						}
						goto label$3901;
						label$3905:;
						{
							goto label$3899;
						}
						label$3908:;
						label$3901:;
					}
				}
				label$3900:;
				goto label$3898;
				label$3899:;
				*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + -1;
				*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20)) = (ubyte)0;
				fb_StrAssign( (void*)&SPARAM$1, -1, (void*)PZSTART$4, 0, 0 );
				*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20)) = (ubyte)ICHAR$1;
				goto label$3891;
			}
			goto label$3893;
			label$3894:;
			if( ICHAR$1 != 40u ) goto label$3909;
			label$3910:;
			{
				integer TMP$924$4;
				integer TMP$925$4;
				if( -((integer)BINDI$1 == 0) == 0 ) goto label$3911;
				TMP$924$4 = -(-((integer)BIMM$1 == 0) != 0);
				goto label$4104;
				label$3911:;
				TMP$924$4 = 0;
				label$4104:;
				if( TMP$924$4 == 0 ) goto label$3912;
				TMP$925$4 = -(-((integer)BADDR$1 == 0) != 0);
				goto label$4105;
				label$3912:;
				TMP$925$4 = 0;
				label$4105:;
				if( TMP$925$4 == 0 ) goto label$3914;
				{
					BINDI$1 = (byte)1;
				}
				goto label$3913;
				label$3914:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"Syntax Error, found '('" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$3889;
				}
				label$3913:;
			}
			goto label$3893;
			label$3909:;
			if( ICHAR$1 != 35u ) goto label$3915;
			label$3916:;
			{
				if( (integer)BINDI$1 == 0 ) goto label$3918;
				fb_Color( 12, 0, 2 );
				puts( (char*)"ERROR: expected address found #" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
				label$3918:;
				if( (integer)BIMM$1 != 0 ) goto label$3920;
				{
					BIMM$1 = (byte)1;
				}
				goto label$3919;
				label$3920:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: expected immediate... found #" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$3889;
				}
				label$3919:;
			}
			goto label$3893;
			label$3915:;
			if( ICHAR$1 < 48u ) goto label$3923;
			if( ICHAR$1 <= 57u ) goto label$3922;
			label$3923:;
			if( ICHAR$1 == 45u ) goto label$3922;
			label$3924:;
			if( ICHAR$1 != 43u ) goto label$3921;
			label$3922:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				label$3925:;
				{
					if( INUM$4 <= 65535 ) goto label$3929;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Number too big" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$3889;
					}
					label$3929:;
					label$3928:;
					{
						if( ICHAR$1 != 45u ) goto label$3931;
						label$3932:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$3934;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$3933;
							label$3934:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$3889;
							}
							label$3933:;
						}
						goto label$3930;
						label$3931:;
						if( ICHAR$1 != 43u ) goto label$3935;
						label$3936:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$3938;
							{
								ISGN$4 = 1;
							}
							goto label$3937;
							label$3938:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$3889;
							}
							label$3937:;
						}
						goto label$3930;
						label$3935:;
						if( ICHAR$1 < 48u ) goto label$3939;
						if( ICHAR$1 > 57u ) goto label$3939;
						label$3940:;
						{
							INUM$4 = (integer)((integer)((INUM$4 * 10) + ICHAR$1) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$3930;
						label$3939:;
						if( ICHAR$1 == 13 ) goto label$3942;
						label$3943:;
						if( ICHAR$1 == 10 ) goto label$3942;
						label$3944:;
						if( ICHAR$1 == 0 ) goto label$3942;
						label$3945:;
						if( ICHAR$1 == 32 ) goto label$3942;
						label$3946:;
						if( ICHAR$1 != 9 ) goto label$3941;
						label$3942:;
						{
							*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + -1;
							goto label$3926;
						}
						goto label$3930;
						label$3941:;
						if( ICHAR$1 == 44u ) goto label$3948;
						label$3949:;
						if( ICHAR$1 == 59u ) goto label$3948;
						label$3950:;
						if( ICHAR$1 != 41u ) goto label$3947;
						label$3948:;
						{
							*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + -1;
						}
						goto label$3930;
						label$3947:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid decimal caracter '" );
							if( (-(ICHAR$1 < 32) | -(ICHAR$1 > 127)) == 0 ) goto label$3953;
							printf( (char*)"0x%02X'", ICHAR$1 );
							goto label$3952;
							label$3953:;
							printf( (char*)"%c'", ICHAR$1 );
							label$3952:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$3889;
						}
						label$3951:;
						label$3930:;
					}
					ICHAR$1 = (long)*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20));
					*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
				}
				label$3927:;
				goto label$3925;
				label$3926:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				if( (integer)BIMM$1 != 0 ) goto label$3955;
				BADDR$1 = (byte)1;
				label$3955:;
				goto label$3891;
			}
			goto label$3893;
			label$3921:;
			if( ICHAR$1 != 36u ) goto label$3956;
			label$3957:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				ubyte vr$6393 = NEXTCHAR_(  );
				ICHAR$1 = (long)vr$6393;
				label$3958:;
				{
					if( INUM$4 <= 65535 ) goto label$3962;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Number too big" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$3889;
					}
					label$3962:;
					label$3961:;
					{
						if( ICHAR$1 != 45u ) goto label$3964;
						label$3965:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$3967;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$3966;
							label$3967:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$3889;
							}
							label$3966:;
						}
						goto label$3963;
						label$3964:;
						if( ICHAR$1 != 43u ) goto label$3968;
						label$3969:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$3971;
							{
								ISGN$4 = 1;
							}
							goto label$3970;
							label$3971:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$3889;
							}
							label$3970:;
						}
						goto label$3963;
						label$3968:;
						if( ICHAR$1 < 48u ) goto label$3972;
						if( ICHAR$1 > 57u ) goto label$3972;
						label$3973:;
						{
							INUM$4 = (integer)((integer)((INUM$4 << 4) + ICHAR$1) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$3963;
						label$3972:;
						if( ICHAR$1 < 65u ) goto label$3974;
						if( ICHAR$1 > 70u ) goto label$3974;
						label$3975:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$1) + -55;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$3963;
						label$3974:;
						if( ICHAR$1 < 97u ) goto label$3976;
						if( ICHAR$1 > 102u ) goto label$3976;
						label$3977:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$1) + -87;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$3963;
						label$3976:;
						if( ICHAR$1 == 13 ) goto label$3979;
						label$3980:;
						if( ICHAR$1 == 10 ) goto label$3979;
						label$3981:;
						if( ICHAR$1 == 0 ) goto label$3979;
						label$3982:;
						if( ICHAR$1 == 32 ) goto label$3979;
						label$3983:;
						if( ICHAR$1 != 9 ) goto label$3978;
						label$3979:;
						{
							goto label$3959;
						}
						goto label$3963;
						label$3978:;
						if( ICHAR$1 == 44u ) goto label$3985;
						label$3986:;
						if( ICHAR$1 == 41u ) goto label$3985;
						label$3987:;
						if( ICHAR$1 != 59u ) goto label$3984;
						label$3985:;
						{
							goto label$3959;
						}
						goto label$3963;
						label$3984:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid Hex caracter '" );
							if( (-(ICHAR$1 < 32) | -(ICHAR$1 > 127)) == 0 ) goto label$3990;
							printf( (char*)"0x%02X'", ICHAR$1 );
							goto label$3989;
							label$3990:;
							printf( (char*)"%c'", ICHAR$1 );
							label$3989:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$3889;
						}
						label$3988:;
						label$3963:;
					}
					*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
					ICHAR$1 = (long)*(ubyte*)((ubyte*)*(char**)TMP$923$1 + *(integer*)((ubyte*)TMP$923$1 + 20));
				}
				label$3960:;
				goto label$3958;
				label$3959:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BHEX$1 = (byte)1;
				if( (integer)BIMM$1 != 0 ) goto label$3992;
				BADDR$1 = (byte)1;
				label$3992:;
				goto label$3891;
			}
			goto label$3893;
			label$3956:;
			if( ICHAR$1 != 60u ) goto label$3993;
			label$3994:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$3996;
				{
					if( (integer)BHI$1 == 0 ) goto label$3998;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found <" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$3889;
					}
					goto label$3997;
					label$3998:;
					{
						BHI$1 = (byte)-1;
					}
					label$3997:;
				}
				goto label$3995;
				label$3996:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$3889;
				}
				label$3995:;
			}
			goto label$3893;
			label$3993:;
			if( ICHAR$1 != 62u ) goto label$3999;
			label$4000:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4002;
				{
					if( (integer)BHI$1 == 0 ) goto label$4004;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found >" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$3889;
					}
					goto label$4003;
					label$4004:;
					{
						BHI$1 = (byte)1;
					}
					label$4003:;
				}
				goto label$4001;
				label$4002:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$3889;
				}
				label$4001:;
			}
			goto label$3893;
			label$3999:;
			if( ICHAR$1 == 32 ) goto label$4006;
			label$4007:;
			if( ICHAR$1 != 9 ) goto label$4005;
			label$4006:;
			{
			}
			goto label$3893;
			label$4005:;
			if( ICHAR$1 == 13 ) goto label$4009;
			label$4010:;
			if( ICHAR$1 == 10 ) goto label$4009;
			label$4011:;
			if( ICHAR$1 == 0 ) goto label$4009;
			label$4012:;
			if( ICHAR$1 == 39u ) goto label$4009;
			label$4013:;
			if( ICHAR$1 != 59u ) goto label$4008;
			label$4009:;
			{
				goto label$3891;
			}
			goto label$3893;
			label$4008:;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"Syntax Error found '%c'\n", ICHAR$1 );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4014:;
			label$3893:;
		}
	}
	label$3892:;
	goto label$3890;
	label$3891:;
	byte BOPCODE$1;
	BOPCODE$1 = (byte)0;
	integer vr$6442 = fb_StrLen( (void*)&SPARAM$1, -1 );
	if( vr$6442 == 0 ) goto label$4016;
	{
		integer TMP$939$2;
		integer TMP$940$2;
		BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 9);
		integer vr$6445 = fb_StrLen( (void*)&SPARAM$1, -1 );
		if( vr$6445 == 0 ) goto label$4017;
		TMP$939$2 = -(-(((uinteger)*(ubyte*)*(char**)&SPARAM$1 & -33) == 65u) != 0);
		goto label$4106;
		label$4017:;
		TMP$939$2 = 0;
		label$4106:;
		if( TMP$939$2 == 0 ) goto label$4018;
		TMP$940$2 = -(-((integer)BOPCODE$1 != -1) != 0);
		goto label$4107;
		label$4018:;
		TMP$940$2 = 0;
		label$4107:;
		if( TMP$940$2 == 0 ) goto label$4020;
		{
			BREG$1 = (byte)65;
		}
		goto label$4019;
		label$4020:;
		{
			integer TMP$941$3;
			long IN$3;
			long vr$6456 = GETLABEL( &SPARAM$1, &UVAL$1 );
			IN$3 = vr$6456;
			if( -(IN$3 < 0) != 0 ) goto label$4021;
			TMP$941$3 = -(-(UVAL$1 == -1) != 0);
			goto label$4108;
			label$4021:;
			TMP$941$3 = -1;
			label$4108:;
			if( TMP$941$3 == 0 ) goto label$4023;
			{
				UVAL$1 = 0;
				struct PATCHSTRUCT TPATCH$4;
				*(ushort*)((ubyte*)&TPATCH$4 + 2) = (ushort)(*(long*)((ubyte*)TMP$923$1 + 12) + 1);
				long vr$6464 = ADDLABEL( &SPARAM$1, -1, (byte)-1 );
				*(ushort*)&TPATCH$4 = (ushort)vr$6464;
				*(ushort*)((ubyte*)&TPATCH$4 + 4) = (ushort)(*(long*)((ubyte*)TMP$923$1 + 48) + 1);
				*(byte*)((ubyte*)&TPATCH$4 + 6) = *(byte*)((ubyte*)POP$1 + 13);
				*(byte*)((ubyte*)&TPATCH$4 + 7) = BHI$1;
				ADDPATCH( &TPATCH$4 );
				BDIGCNT$1 = (byte)4;
			}
			goto label$4022;
			label$4023:;
			{
				integer TMP$942$4;
				if( (uinteger)*(ubyte*)(((ubyte*)G_TLABEL$ + ((integer)IN$3 << 6)) + 60) == 0u ) goto label$4024;
				TMP$942$4 = 4;
				goto label$4109;
				label$4024:;
				TMP$942$4 = 2;
				label$4109:;
				BDIGCNT$1 = (byte)TMP$942$4;
			}
			label$4022:;
			if( (integer)BJUMP$1 == 0 ) goto label$4026;
			BIMM$1 = (byte)0;
			label$4026:;
			BADDR$1 = (byte)1;
			BHEX$1 = (byte)1;
		}
		label$4019:;
	}
	goto label$4015;
	label$4016:;
	if( -((integer)BIMM$1 == 0) == 0 ) goto label$4028;
	TMP$943$1 = -(-((integer)BADDR$1 == 0) != 0);
	goto label$4110;
	label$4028:;
	TMP$943$1 = 0;
	label$4110:;
	if( TMP$943$1 == 0 ) goto label$4027;
	{
		BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 9);
		if( (integer)BOPCODE$1 != -1 ) goto label$4030;
		{
			fb_Color( 12, 0, 2 );
			puts( (char*)"ERROR: Incomplete instruction" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
		}
		label$4030:;
		label$4029:;
		BREG$1 = (byte)65;
	}
	label$4027:;
	label$4015:;
	if( (integer)BHI$1 <= 0 ) goto label$4032;
	UVAL$1 = (UVAL$1 >> 8) & 255;
	BDIGCNT$1 = (byte)2;
	label$4032:;
	if( (integer)BHI$1 >= 0 ) goto label$4034;
	UVAL$1 = UVAL$1 & 255;
	BDIGCNT$1 = (byte)2;
	label$4034:;
	if( (integer)BJUMP$1 == 0 ) goto label$4036;
	{
		ubyte TMP$945$2;
		integer TMP$946$2;
		BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 10);
		if( (integer)BOPCODE$1 != -1 ) goto label$4038;
		if( (integer)BINDI$1 == 0 ) goto label$4039;
		TMP$945$2 = *(ubyte*)((ubyte*)POP$1 + 16);
		goto label$4111;
		label$4039:;
		TMP$945$2 = *(ubyte*)((ubyte*)POP$1 + 13);
		label$4111:;
		BOPCODE$1 = (byte)TMP$945$2;
		label$4038:;
		if( -((integer)BIMM$1 == 0) == 0 ) goto label$4040;
		TMP$946$2 = -(-((integer)BADDR$1 == 0) != 0);
		goto label$4112;
		label$4040:;
		TMP$946$2 = 0;
		label$4112:;
		if( TMP$946$2 == 0 ) goto label$4042;
		{
			fb_Color( 12, 0, 2 );
			puts( (char*)"Expected address or label for jump instruction" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
		}
		label$4042:;
		label$4041:;
		if( (integer)BOPCODE$1 != -1 ) goto label$4044;
		{
			fb_Color( 12, 0, 2 );
			puts( (char*)"Invalid address mode for this instruction" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
		}
		label$4044:;
		label$4043:;
	}
	goto label$4035;
	label$4036:;
	if( (integer)BIMM$1 == 0 ) goto label$4045;
	{
		integer TMP$949$2;
		if( -(UVAL$1 < -128) != 0 ) goto label$4046;
		TMP$949$2 = -(-(UVAL$1 > 255) != 0);
		goto label$4113;
		label$4046:;
		TMP$949$2 = -1;
		label$4113:;
		if( TMP$949$2 == 0 ) goto label$4048;
		{
			fb_Color( 12, 0, 2 );
			puts( (char*)"Overflow byte immediate" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
		}
		label$4048:;
		label$4047:;
		BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 10);
		if( (integer)BOPCODE$1 != -1 ) goto label$4050;
		{
			fb_Color( 12, 0, 2 );
			puts( (char*)"Immediate number not valid for this instruction" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
		}
		label$4050:;
		label$4049:;
	}
	goto label$4035;
	label$4045:;
	if( (integer)BADDR$1 == 0 ) goto label$4051;
	{
		integer TMP$962$2;
		integer TMP$963$2;
		integer TMP$964$2;
		integer TMP$965$2;
		integer TMP$966$2;
		if( ICHAR$1 != 41u ) goto label$4053;
		{
			if( (integer)BINDI$1 != 0 ) goto label$4055;
			fb_Color( 12, 0, 2 );
			puts( (char*)"Bad addressing mode" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
			label$4055:;
			*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
			ubyte vr$6516 = NEXTCHAR_(  );
			ICHAR$1 = (long)vr$6516;
			BINDI$1 = (byte)2;
		}
		label$4053:;
		label$4052:;
		if( ICHAR$1 != 44u ) goto label$4057;
		{
			integer TMP$953$3;
			*(long*)((ubyte*)TMP$923$1 + 20) = *(long*)((ubyte*)TMP$923$1 + 20) + 1;
			ubyte vr$6521 = NEXTCHAR_(  );
			ICHAR$1 = (long)((uinteger)vr$6521 & -33);
			if( -(ICHAR$1 == 88u) != 0 ) goto label$4058;
			TMP$953$3 = -(-(ICHAR$1 == 89u) != 0);
			goto label$4114;
			label$4058:;
			TMP$953$3 = -1;
			label$4114:;
			if( TMP$953$3 == 0 ) goto label$4060;
			{
				BREG$1 = (byte)ICHAR$1;
			}
			goto label$4059;
			label$4060:;
			{
				fb_Color( 12, 0, 2 );
				puts( (char*)"Bad addressing mode" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4059:;
		}
		label$4057:;
		label$4056:;
		if( (integer)BINDI$1 == 0 ) goto label$4062;
		{
			integer TMP$954$3;
			integer TMP$956$3;
			integer TMP$958$3;
			if( -(UVAL$1 < -128) != 0 ) goto label$4063;
			TMP$954$3 = -(-(UVAL$1 > 255) != 0);
			goto label$4115;
			label$4063:;
			TMP$954$3 = -1;
			label$4115:;
			if( TMP$954$3 == 0 ) goto label$4065;
			fb_Color( 12, 0, 2 );
			puts( (char*)"Indirect mode must use zero page (8bit) adressing" );
			fb$result$1 = -1;
			fb_StrDelete( &SPARAM$1 );
			goto label$3889;
			label$4065:;
			BOPCODE$1 = (byte)-2;
			char* PZMODE$3;
			if( -((integer)BREG$1 == 88u) == 0 ) goto label$4066;
			TMP$956$3 = -(-((integer)BINDI$1 == 1) != 0);
			goto label$4116;
			label$4066:;
			TMP$956$3 = 0;
			label$4116:;
			if( TMP$956$3 == 0 ) goto label$4068;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 17);
				PZMODE$3 = (char*)"[addr+X]";
			}
			goto label$4067;
			label$4068:;
			if( -((integer)BREG$1 == 89u) == 0 ) goto label$4070;
			TMP$958$3 = -(-((integer)BINDI$1 == 2) != 0);
			goto label$4117;
			label$4070:;
			TMP$958$3 = 0;
			label$4117:;
			if( TMP$958$3 == 0 ) goto label$4069;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 18);
				PZMODE$3 = (char*)"[addr]+Y";
			}
			goto label$4067;
			label$4069:;
			{
				fb_Color( 12, 0, 2 );
				puts( (char*)"Bad syntax for addressing mode" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4067:;
			if( (integer)BOPCODE$1 != -1 ) goto label$4072;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"%s Indirect Addressing not valid for this instruction\n", PZMODE$3 );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4072:;
			label$4071:;
		}
		goto label$4061;
		label$4062:;
		if( -((uinteger)*(ubyte*)((ubyte*)POP$1 + 11) == 255) != 0 ) goto label$4078;
		if( (integer)BHEX$1 == 0 ) goto label$4074;
		TMP$962$2 = -(-((integer)BDIGCNT$1 > 2) != 0);
		goto label$4119;
		label$4074:;
		TMP$962$2 = 0;
		label$4119:;
		if( TMP$962$2 != 0 ) goto label$4077;
		if( -((integer)BDIGCNT$1 > 3) != 0 ) goto label$4075;
		TMP$963$2 = -(-(UVAL$1 < -128) != 0);
		goto label$4121;
		label$4075:;
		TMP$963$2 = -1;
		label$4121:;
		if( TMP$963$2 != 0 ) goto label$4076;
		TMP$964$2 = -(-(UVAL$1 > 255) != 0);
		goto label$4122;
		label$4076:;
		TMP$964$2 = -1;
		label$4122:;
		TMP$965$2 = -(TMP$964$2 != 0);
		goto label$4120;
		label$4077:;
		TMP$965$2 = -1;
		label$4120:;
		TMP$966$2 = -(TMP$965$2 != 0);
		goto label$4118;
		label$4078:;
		TMP$966$2 = -1;
		label$4118:;
		if( TMP$966$2 == 0 ) goto label$4073;
		{
			char* PZMODE$3;
			PZMODE$3 = (char*)"Absolute";
			if( (integer)BREG$1 != 88u ) goto label$4080;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 14);
				PZMODE$3 = (char*)"Absolute with X";
			}
			goto label$4079;
			label$4080:;
			if( (integer)BREG$1 != 89u ) goto label$4081;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 15);
				PZMODE$3 = (char*)"Absolute with Y";
			}
			goto label$4079;
			label$4081:;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 13);
			}
			label$4079:;
			if( (integer)BOPCODE$1 != -1 ) goto label$4083;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"%s Absolute Addressing not valid for this instruction\n", PZMODE$3 );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4083:;
			label$4082:;
		}
		goto label$4061;
		label$4073:;
		{
			char* PZMODE$3;
			PZMODE$3 = (char*)"Zero Page";
			if( (integer)BREG$1 != 88u ) goto label$4085;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 12);
				PZMODE$3 = (char*)"Zero Page with X";
			}
			goto label$4084;
			label$4085:;
			if( (integer)BREG$1 != 89u ) goto label$4086;
			{
				fb_Color( 12, 0, 2 );
				puts( (char*)"Bad addressing mode" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			goto label$4084;
			label$4086:;
			{
				BOPCODE$1 = *(byte*)((ubyte*)POP$1 + 11);
			}
			label$4084:;
			if( (integer)BOPCODE$1 != -1 ) goto label$4088;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"%s Addressing not valid for this instruction\n", PZMODE$3 );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$3889;
			}
			label$4088:;
			label$4087:;
		}
		label$4061:;
	}
	label$4051:;
	label$4035:;
	*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)BOPCODE$1;
	*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 1;
	if( (integer)BJUMP$1 == 0 ) goto label$4090;
	{
		integer TMP$974$2;
		if( -((uinteger)*(ubyte*)((ubyte*)POP$1 + 13) != 255) == 0 ) goto label$4091;
		TMP$974$2 = -(-((integer)BHI$1 == 0) != 0);
		goto label$4123;
		label$4091:;
		TMP$974$2 = 0;
		label$4123:;
		if( TMP$974$2 == 0 ) goto label$4093;
		{
			*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)(UVAL$1 & 255);
			*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(*(long*)((ubyte*)TMP$923$1 + 48) + 1)) = (ubyte)((UVAL$1 >> 8) & 255);
			*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 2;
		}
		goto label$4092;
		label$4093:;
		if( (uinteger)*(ubyte*)((ubyte*)POP$1 + 10) == 255 ) goto label$4094;
		{
			*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)((UVAL$1 - *(long*)((ubyte*)TMP$923$1 + 48)) + -1);
			*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 1;
		}
		label$4094:;
		label$4092:;
	}
	goto label$4089;
	label$4090:;
	if( (integer)BADDR$1 != 0 ) goto label$4096;
	TMP$975$1 = -((integer)BIMM$1 != 0);
	goto label$4124;
	label$4096:;
	TMP$975$1 = -1;
	label$4124:;
	if( TMP$975$1 == 0 ) goto label$4095;
	{
		if( (integer)BHEX$1 == 0 ) goto label$4098;
		{
			if( (integer)BDIGCNT$1 <= 2 ) goto label$4100;
			{
				*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)(UVAL$1 & 255);
				*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(*(long*)((ubyte*)TMP$923$1 + 48) + 1)) = (ubyte)((UVAL$1 >> 8) & 255);
				*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 2;
			}
			goto label$4099;
			label$4100:;
			{
				*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)UVAL$1;
				*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 1;
			}
			label$4099:;
		}
		goto label$4097;
		label$4098:;
		{
			integer TMP$976$3;
			if( -((integer)BDIGCNT$1 > 3) != 0 ) goto label$4101;
			TMP$976$3 = -(-(UVAL$1 > 255) != 0);
			goto label$4125;
			label$4101:;
			TMP$976$3 = -1;
			label$4125:;
			if( TMP$976$3 == 0 ) goto label$4103;
			{
				*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)(UVAL$1 & 255);
				*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(*(long*)((ubyte*)TMP$923$1 + 48) + 1)) = (ubyte)((UVAL$1 >> 8) & 255);
				*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 2;
			}
			goto label$4102;
			label$4103:;
			{
				*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$923$1 + 48)) = (ubyte)UVAL$1;
				*(long*)((ubyte*)TMP$923$1 + 48) = *(long*)((ubyte*)TMP$923$1 + 48) + 1;
			}
			label$4102:;
		}
		label$4097:;
	}
	label$4095:;
	label$4089:;
	fb_StrDelete( &SPARAM$1 );
	label$3889:;
	return fb$result$1;
}

long OPNOP( long IOPCODEINDEX$1 )
{
	struct PARSERSTRUCT* TMP$977$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4126:;
	TMP$977$1 = &G_TPARSER$;
	ubyte BOPCODE$1;
	BOPCODE$1 = *(ubyte*)(((ubyte*)TOPCODE$ + ((integer)IOPCODEINDEX$1 * 24)) + 8);
	*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$977$1 + 48)) = BOPCODE$1;
	*(long*)((ubyte*)TMP$977$1 + 48) = *(long*)((ubyte*)TMP$977$1 + 48) + 1;
	long vr$6659 = NOMOREPARMS_(  );
	fb$result$1 = vr$6659;
	goto label$4127;
	label$4127:;
	return fb$result$1;
}

long OPMOD( long IOPCODEINDEX$1 )
{
	struct PARSERSTRUCT* TMP$978$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4128:;
	TMP$978$1 = &G_TPARSER$;
	long vr$6662 = TRANSLATEADDRESSING( IOPCODEINDEX$1, (byte)0 );
	fb$result$1 = vr$6662;
	goto label$4129;
	label$4129:;
	return fb$result$1;
}

long OPJMP( long IOPCODEINDEX$1 )
{
	struct PARSERSTRUCT* TMP$979$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4130:;
	TMP$979$1 = &G_TPARSER$;
	long vr$6665 = TRANSLATEADDRESSING( IOPCODEINDEX$1, (byte)-1 );
	fb$result$1 = vr$6665;
	goto label$4131;
	label$4131:;
	return fb$result$1;
}

long DECLBYTE( long IOPCODEINDEX$1 )
{
	struct PARSERSTRUCT* TMP$980$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4132:;
	byte BIMM$1;
	__builtin_memset( &BIMM$1, 0, 1 );
	byte BHEX$1;
	__builtin_memset( &BHEX$1, 0, 1 );
	byte BHI$1;
	__builtin_memset( &BHI$1, 0, 1 );
	byte BDIGCNT$1;
	__builtin_memset( &BDIGCNT$1, 0, 1 );
	byte BLAB$1;
	__builtin_memset( &BLAB$1, 0, 1 );
	long UVAL$1;
	__builtin_memset( &UVAL$1, 0, 4 );
	long UCNT$1;
	__builtin_memset( &UCNT$1, 0, 4 );
	string SPARAM$1;
	__builtin_memset( &SPARAM$1, 0, 12 );
	TMP$980$1 = &G_TPARSER$;
	label$4134:;
	{
		long ICHAR$2;
		ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20));
		*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + 1;
		{
			if( ICHAR$2 != 34u ) goto label$4138;
			label$4139:;
			{
				label$4140:;
				{
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20));
					*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + 1;
					{
						if( ICHAR$2 == 13 ) goto label$4145;
						label$4146:;
						if( ICHAR$2 == 10 ) goto label$4145;
						label$4147:;
						if( ICHAR$2 != 0 ) goto label$4144;
						label$4145:;
						{
							*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + -1;
							goto label$4141;
						}
						goto label$4143;
						label$4144:;
						if( ICHAR$2 != 34u ) goto label$4148;
						label$4149:;
						{
							goto label$4141;
						}
						goto label$4143;
						label$4148:;
						{
							*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$980$1 + 48)) = (ubyte)ICHAR$2;
							*(long*)((ubyte*)TMP$980$1 + 48) = *(long*)((ubyte*)TMP$980$1 + 48) + 1;
							UCNT$1 = UCNT$1 + 1;
						}
						label$4150:;
						label$4143:;
					}
				}
				label$4142:;
				goto label$4140;
				label$4141:;
			}
			goto label$4137;
			label$4138:;
			if( ICHAR$2 < 65u ) goto label$4153;
			if( ICHAR$2 <= 90u ) goto label$4152;
			label$4153:;
			if( ICHAR$2 < 97u ) goto label$4154;
			if( ICHAR$2 <= 122u ) goto label$4152;
			label$4154:;
			if( ICHAR$2 != 95u ) goto label$4151;
			label$4152:;
			{
				char* PZSTART$4;
				PZSTART$4 = (char*)((ubyte*)*(char**)TMP$980$1 + (integer)(*(long*)((ubyte*)TMP$980$1 + 20) + -1));
				label$4155:;
				{
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20));
					*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + 1;
					{
						if( ICHAR$2 < 65u ) goto label$4161;
						if( ICHAR$2 <= 90u ) goto label$4160;
						label$4161:;
						if( ICHAR$2 < 97u ) goto label$4159;
						if( ICHAR$2 > 122u ) goto label$4159;
						label$4160:;
						{
						}
						goto label$4158;
						label$4159:;
						if( ICHAR$2 < 48u ) goto label$4164;
						if( ICHAR$2 <= 57u ) goto label$4163;
						label$4164:;
						if( ICHAR$2 != 95u ) goto label$4162;
						label$4163:;
						{
						}
						goto label$4158;
						label$4162:;
						{
							goto label$4156;
						}
						label$4165:;
						label$4158:;
					}
				}
				label$4157:;
				goto label$4155;
				label$4156:;
				*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + -1;
				BIMM$1 = (byte)1;
				BLAB$1 = (byte)1;
				*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20)) = (ubyte)0;
				fb_StrAssign( (void*)&SPARAM$1, -1, (void*)PZSTART$4, 0, 0 );
				*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20)) = (ubyte)ICHAR$2;
			}
			goto label$4137;
			label$4151:;
			if( ICHAR$2 != 35u ) goto label$4166;
			label$4167:;
			{
				if( (integer)BIMM$1 != 0 ) goto label$4169;
				{
					BIMM$1 = (byte)1;
				}
				goto label$4168;
				label$4169:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: expected immediate... found #" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4133;
				}
				label$4168:;
			}
			goto label$4137;
			label$4166:;
			if( ICHAR$2 < 48u ) goto label$4172;
			if( ICHAR$2 <= 57u ) goto label$4171;
			label$4172:;
			if( ICHAR$2 == 45u ) goto label$4171;
			label$4173:;
			if( ICHAR$2 != 43u ) goto label$4170;
			label$4171:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				label$4174:;
				{
					if( INUM$4 <= 65535 ) goto label$4178;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"number too big!" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4133;
					}
					label$4178:;
					label$4177:;
					{
						if( ICHAR$2 != 45u ) goto label$4180;
						label$4181:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4183;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4182;
							label$4183:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4133;
							}
							label$4182:;
						}
						goto label$4179;
						label$4180:;
						if( ICHAR$2 != 43u ) goto label$4184;
						label$4185:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4187;
							{
								ISGN$4 = 1;
							}
							goto label$4186;
							label$4187:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4133;
							}
							label$4186:;
						}
						goto label$4179;
						label$4184:;
						if( ICHAR$2 < 48u ) goto label$4188;
						if( ICHAR$2 > 57u ) goto label$4188;
						label$4189:;
						{
							INUM$4 = (integer)((integer)((INUM$4 * 10) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4179;
						label$4188:;
						if( ICHAR$2 == 13 ) goto label$4191;
						label$4192:;
						if( ICHAR$2 == 10 ) goto label$4191;
						label$4193:;
						if( ICHAR$2 == 0 ) goto label$4191;
						label$4194:;
						if( ICHAR$2 == 32 ) goto label$4191;
						label$4195:;
						if( ICHAR$2 == 9 ) goto label$4191;
						label$4196:;
						if( ICHAR$2 == 44u ) goto label$4191;
						label$4197:;
						if( ICHAR$2 != 59u ) goto label$4190;
						label$4191:;
						{
							*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + -1;
							goto label$4175;
						}
						goto label$4179;
						label$4190:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid decimal caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4200;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4199;
							label$4200:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4199:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$4133;
						}
						label$4198:;
						label$4179:;
					}
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20));
					*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + 1;
				}
				label$4176:;
				goto label$4174;
				label$4175:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BIMM$1 = (byte)1;
			}
			goto label$4137;
			label$4170:;
			if( ICHAR$2 != 36u ) goto label$4201;
			label$4202:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				ubyte vr$6750 = NEXTCHAR_(  );
				ICHAR$2 = (long)vr$6750;
				label$4203:;
				{
					if( INUM$4 <= 65535 ) goto label$4207;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Number too big" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4133;
					}
					label$4207:;
					label$4206:;
					{
						if( ICHAR$2 != 45u ) goto label$4209;
						label$4210:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4212;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4211;
							label$4212:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4133;
							}
							label$4211:;
						}
						goto label$4208;
						label$4209:;
						if( ICHAR$2 != 43u ) goto label$4213;
						label$4214:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4216;
							{
								ISGN$4 = 1;
							}
							goto label$4215;
							label$4216:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4133;
							}
							label$4215:;
						}
						goto label$4208;
						label$4213:;
						if( ICHAR$2 < 48u ) goto label$4217;
						if( ICHAR$2 > 57u ) goto label$4217;
						label$4218:;
						{
							INUM$4 = (integer)((integer)((INUM$4 << 4) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4208;
						label$4217:;
						if( ICHAR$2 < 65u ) goto label$4219;
						if( ICHAR$2 > 70u ) goto label$4219;
						label$4220:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -55;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4208;
						label$4219:;
						if( ICHAR$2 < 97u ) goto label$4221;
						if( ICHAR$2 > 102u ) goto label$4221;
						label$4222:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -87;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4208;
						label$4221:;
						if( ICHAR$2 == 13 ) goto label$4224;
						label$4225:;
						if( ICHAR$2 == 10 ) goto label$4224;
						label$4226:;
						if( ICHAR$2 == 0 ) goto label$4224;
						label$4227:;
						if( ICHAR$2 == 32 ) goto label$4224;
						label$4228:;
						if( ICHAR$2 == 9 ) goto label$4224;
						label$4229:;
						if( ICHAR$2 == 44u ) goto label$4224;
						label$4230:;
						if( ICHAR$2 != 59u ) goto label$4223;
						label$4224:;
						{
							goto label$4204;
						}
						goto label$4208;
						label$4223:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid Hex caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4233;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4232;
							label$4233:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4232:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$4133;
						}
						label$4231:;
						label$4208:;
					}
					*(long*)((ubyte*)TMP$980$1 + 20) = *(long*)((ubyte*)TMP$980$1 + 20) + 1;
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$980$1 + *(integer*)((ubyte*)TMP$980$1 + 20));
				}
				label$4205:;
				goto label$4203;
				label$4204:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BHEX$1 = (byte)1;
				BIMM$1 = (byte)1;
			}
			goto label$4137;
			label$4201:;
			if( ICHAR$2 != 60u ) goto label$4234;
			label$4235:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4237;
				{
					if( (integer)BHI$1 == 0 ) goto label$4239;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found <" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4133;
					}
					goto label$4238;
					label$4239:;
					{
						BHI$1 = (byte)-1;
					}
					label$4238:;
				}
				goto label$4236;
				label$4237:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4133;
				}
				label$4236:;
			}
			goto label$4137;
			label$4234:;
			if( ICHAR$2 != 62u ) goto label$4240;
			label$4241:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4243;
				{
					if( (integer)BHI$1 == 0 ) goto label$4245;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found >" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4133;
					}
					goto label$4244;
					label$4245:;
					{
						BHI$1 = (byte)1;
					}
					label$4244:;
				}
				goto label$4242;
				label$4243:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4133;
				}
				label$4242:;
			}
			goto label$4137;
			label$4240:;
			if( ICHAR$2 == 32 ) goto label$4247;
			label$4248:;
			if( ICHAR$2 != 9 ) goto label$4246;
			label$4247:;
			{
			}
			goto label$4137;
			label$4246:;
			if( ICHAR$2 == 13 ) goto label$4250;
			label$4251:;
			if( ICHAR$2 == 10 ) goto label$4250;
			label$4252:;
			if( ICHAR$2 == 0 ) goto label$4250;
			label$4253:;
			if( ICHAR$2 == 59u ) goto label$4250;
			label$4254:;
			if( ICHAR$2 != 44u ) goto label$4249;
			label$4250:;
			{
				integer TMP$982$4;
				*(long*)((ubyte*)G_LPOSITION$ + (*(integer*)((ubyte*)TMP$980$1 + 48) << 2)) = *(long*)((ubyte*)TMP$980$1 + 12) + 1;
				if( -((integer)BIMM$1 == 0) == 0 ) goto label$4255;
				TMP$982$4 = -(-(UCNT$1 == 0) != 0);
				goto label$4264;
				label$4255:;
				TMP$982$4 = 0;
				label$4264:;
				if( TMP$982$4 == 0 ) goto label$4257;
				fb_Color( 12, 0, 2 );
				puts( (char*)"Expected immediate" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$4133;
				label$4257:;
				if( (integer)BLAB$1 == 0 ) goto label$4259;
				fb_Color( 6, 0, 2 );
				goto label$4258;
				label$4259:;
				fb_Color( 3, 0, 2 );
				label$4258:;
				if( (integer)BHI$1 <= 0 ) goto label$4261;
				UVAL$1 = UVAL$1 >> 8;
				label$4261:;
				*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)((ubyte*)TMP$980$1 + 48)) = (ubyte)UVAL$1;
				*(long*)((ubyte*)TMP$980$1 + 48) = *(long*)((ubyte*)TMP$980$1 + 48) + 1;
				UCNT$1 = UCNT$1 + 1;
				if( ICHAR$2 == 44u ) goto label$4263;
				{
					fb$result$1 = UCNT$1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4133;
				}
				label$4263:;
				label$4262:;
				BIMM$1 = (byte)0;
				BHEX$1 = (byte)0;
				BHI$1 = (byte)0;
				BDIGCNT$1 = (byte)0;
				BLAB$1 = (byte)0;
			}
			label$4249:;
			label$4137:;
		}
	}
	label$4136:;
	goto label$4134;
	label$4135:;
	puts( (char*)"! ? ? ? ? !" );
	fb_StrDelete( &SPARAM$1 );
	label$4133:;
	return fb$result$1;
}

long DEFCONST( long IOPCODEINDEX$1 )
{
	struct PARSERSTRUCT* TMP$985$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4265:;
	byte BIMM$1;
	__builtin_memset( &BIMM$1, 0, 1 );
	byte BHEX$1;
	__builtin_memset( &BHEX$1, 0, 1 );
	byte BHI$1;
	__builtin_memset( &BHI$1, 0, 1 );
	byte BDIGCNT$1;
	__builtin_memset( &BDIGCNT$1, 0, 1 );
	byte BLAB$1;
	__builtin_memset( &BLAB$1, 0, 1 );
	long UVAL$1;
	__builtin_memset( &UVAL$1, 0, 4 );
	string SPARAM$1;
	__builtin_memset( &SPARAM$1, 0, 12 );
	string SDEFNAME$1;
	__builtin_memset( &SDEFNAME$1, 0, 12 );
	TMP$985$1 = &G_TPARSER$;
	label$4267:;
	{
		long ICHAR$2;
		ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
		*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
		{
			if( ICHAR$2 < 65u ) goto label$4273;
			if( ICHAR$2 <= 90u ) goto label$4272;
			label$4273:;
			if( ICHAR$2 < 97u ) goto label$4274;
			if( ICHAR$2 <= 122u ) goto label$4272;
			label$4274:;
			if( ICHAR$2 != 95u ) goto label$4271;
			label$4272:;
			{
				char* PZSTART$4;
				PZSTART$4 = (char*)((ubyte*)*(char**)TMP$985$1 + (integer)(*(long*)((ubyte*)TMP$985$1 + 20) + -1));
				label$4275:;
				{
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
					*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
					{
						if( ICHAR$2 < 65u ) goto label$4281;
						if( ICHAR$2 <= 90u ) goto label$4280;
						label$4281:;
						if( ICHAR$2 < 97u ) goto label$4279;
						if( ICHAR$2 > 122u ) goto label$4279;
						label$4280:;
						{
						}
						goto label$4278;
						label$4279:;
						if( ICHAR$2 < 48u ) goto label$4284;
						if( ICHAR$2 <= 57u ) goto label$4283;
						label$4284:;
						if( ICHAR$2 != 95u ) goto label$4282;
						label$4283:;
						{
						}
						goto label$4278;
						label$4282:;
						{
							goto label$4276;
						}
						label$4285:;
						label$4278:;
					}
				}
				label$4277:;
				goto label$4275;
				label$4276:;
				*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + -1;
				*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20)) = (ubyte)0;
				fb_StrAssign( (void*)&SDEFNAME$1, -1, (void*)PZSTART$4, 0, 0 );
				*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20)) = (ubyte)ICHAR$2;
			}
			goto label$4270;
			label$4271:;
			if( ICHAR$2 == 32 ) goto label$4287;
			label$4288:;
			if( ICHAR$2 != 9 ) goto label$4286;
			label$4287:;
			{
				integer vr$6856 = fb_StrLen( (void*)&SDEFNAME$1, -1 );
				if( vr$6856 == 0 ) goto label$4290;
				goto label$4268;
				label$4290:;
			}
			goto label$4270;
			label$4286:;
			{
				fb_Color( 12, 0, 2 );
				puts( (char*)"ERROR: expected define name" );
				fb$result$1 = -1;
				fb_StrDelete( &SDEFNAME$1 );
				fb_StrDelete( &SPARAM$1 );
				goto label$4266;
			}
			label$4291:;
			label$4270:;
		}
	}
	label$4269:;
	goto label$4267;
	label$4268:;
	label$4292:;
	{
		long ICHAR$2;
		ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
		*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
		{
			if( ICHAR$2 < 65u ) goto label$4298;
			if( ICHAR$2 <= 90u ) goto label$4297;
			label$4298:;
			if( ICHAR$2 < 97u ) goto label$4299;
			if( ICHAR$2 <= 122u ) goto label$4297;
			label$4299:;
			if( ICHAR$2 != 95u ) goto label$4296;
			label$4297:;
			{
				char* PZSTART$4;
				PZSTART$4 = (char*)((ubyte*)*(char**)TMP$985$1 + (integer)(*(long*)((ubyte*)TMP$985$1 + 20) + -1));
				label$4300:;
				{
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
					*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
					{
						if( ICHAR$2 < 65u ) goto label$4306;
						if( ICHAR$2 <= 90u ) goto label$4305;
						label$4306:;
						if( ICHAR$2 < 97u ) goto label$4304;
						if( ICHAR$2 > 122u ) goto label$4304;
						label$4305:;
						{
						}
						goto label$4303;
						label$4304:;
						if( ICHAR$2 < 48u ) goto label$4309;
						if( ICHAR$2 <= 57u ) goto label$4308;
						label$4309:;
						if( ICHAR$2 != 95u ) goto label$4307;
						label$4308:;
						{
						}
						goto label$4303;
						label$4307:;
						{
							goto label$4301;
						}
						label$4310:;
						label$4303:;
					}
				}
				label$4302:;
				goto label$4300;
				label$4301:;
				*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + -1;
				BIMM$1 = (byte)1;
				BLAB$1 = (byte)1;
				*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20)) = (ubyte)0;
				fb_StrAssign( (void*)&SPARAM$1, -1, (void*)PZSTART$4, 0, 0 );
				*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20)) = (ubyte)ICHAR$2;
			}
			goto label$4295;
			label$4296:;
			if( ICHAR$2 != 35u ) goto label$4311;
			label$4312:;
			{
				if( (integer)BIMM$1 != 0 ) goto label$4314;
				{
					BIMM$1 = (byte)1;
				}
				goto label$4313;
				label$4314:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: expected immediate... found #" );
					fb$result$1 = -1;
					fb_StrDelete( &SDEFNAME$1 );
					fb_StrDelete( &SPARAM$1 );
					goto label$4266;
				}
				label$4313:;
			}
			goto label$4295;
			label$4311:;
			if( ICHAR$2 < 48u ) goto label$4317;
			if( ICHAR$2 <= 57u ) goto label$4316;
			label$4317:;
			if( ICHAR$2 == 45u ) goto label$4316;
			label$4318:;
			if( ICHAR$2 != 43u ) goto label$4315;
			label$4316:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				label$4319:;
				{
					if( INUM$4 <= 65535 ) goto label$4323;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"number too big!" );
						fb$result$1 = -1;
						fb_StrDelete( &SDEFNAME$1 );
						fb_StrDelete( &SPARAM$1 );
						goto label$4266;
					}
					label$4323:;
					label$4322:;
					{
						if( ICHAR$2 != 45u ) goto label$4325;
						label$4326:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4328;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4327;
							label$4328:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SDEFNAME$1 );
								fb_StrDelete( &SPARAM$1 );
								goto label$4266;
							}
							label$4327:;
						}
						goto label$4324;
						label$4325:;
						if( ICHAR$2 != 43u ) goto label$4329;
						label$4330:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4332;
							{
								ISGN$4 = 1;
							}
							goto label$4331;
							label$4332:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SDEFNAME$1 );
								fb_StrDelete( &SPARAM$1 );
								goto label$4266;
							}
							label$4331:;
						}
						goto label$4324;
						label$4329:;
						if( ICHAR$2 < 48u ) goto label$4333;
						if( ICHAR$2 > 57u ) goto label$4333;
						label$4334:;
						{
							INUM$4 = (integer)((integer)((INUM$4 * 10) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4324;
						label$4333:;
						if( ICHAR$2 == 13 ) goto label$4336;
						label$4337:;
						if( ICHAR$2 == 10 ) goto label$4336;
						label$4338:;
						if( ICHAR$2 == 0 ) goto label$4336;
						label$4339:;
						if( ICHAR$2 == 32 ) goto label$4336;
						label$4340:;
						if( ICHAR$2 == 9 ) goto label$4336;
						label$4341:;
						if( ICHAR$2 == 44u ) goto label$4336;
						label$4342:;
						if( ICHAR$2 != 59u ) goto label$4335;
						label$4336:;
						{
							*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + -1;
							goto label$4320;
						}
						goto label$4324;
						label$4335:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid decimal caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4345;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4344;
							label$4345:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4344:;
							fb$result$1 = -1;
							fb_StrDelete( &SDEFNAME$1 );
							fb_StrDelete( &SPARAM$1 );
							goto label$4266;
						}
						label$4343:;
						label$4324:;
					}
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
					*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
				}
				label$4321:;
				goto label$4319;
				label$4320:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BIMM$1 = (byte)1;
			}
			goto label$4295;
			label$4315:;
			if( ICHAR$2 != 36u ) goto label$4346;
			label$4347:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				ubyte vr$6922 = NEXTCHAR_(  );
				ICHAR$2 = (long)vr$6922;
				label$4348:;
				{
					if( INUM$4 <= 65535 ) goto label$4352;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Number too big" );
						fb$result$1 = -1;
						fb_StrDelete( &SDEFNAME$1 );
						fb_StrDelete( &SPARAM$1 );
						goto label$4266;
					}
					label$4352:;
					label$4351:;
					{
						if( ICHAR$2 != 45u ) goto label$4354;
						label$4355:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4357;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4356;
							label$4357:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SDEFNAME$1 );
								fb_StrDelete( &SPARAM$1 );
								goto label$4266;
							}
							label$4356:;
						}
						goto label$4353;
						label$4354:;
						if( ICHAR$2 != 43u ) goto label$4358;
						label$4359:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4361;
							{
								ISGN$4 = 1;
							}
							goto label$4360;
							label$4361:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SDEFNAME$1 );
								fb_StrDelete( &SPARAM$1 );
								goto label$4266;
							}
							label$4360:;
						}
						goto label$4353;
						label$4358:;
						if( ICHAR$2 < 48u ) goto label$4362;
						if( ICHAR$2 > 57u ) goto label$4362;
						label$4363:;
						{
							INUM$4 = (integer)((integer)((INUM$4 << 4) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4353;
						label$4362:;
						if( ICHAR$2 < 65u ) goto label$4364;
						if( ICHAR$2 > 70u ) goto label$4364;
						label$4365:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -55;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4353;
						label$4364:;
						if( ICHAR$2 < 97u ) goto label$4366;
						if( ICHAR$2 > 102u ) goto label$4366;
						label$4367:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -87;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4353;
						label$4366:;
						if( ICHAR$2 == 13 ) goto label$4369;
						label$4370:;
						if( ICHAR$2 == 10 ) goto label$4369;
						label$4371:;
						if( ICHAR$2 == 0 ) goto label$4369;
						label$4372:;
						if( ICHAR$2 == 32 ) goto label$4369;
						label$4373:;
						if( ICHAR$2 == 9 ) goto label$4369;
						label$4374:;
						if( ICHAR$2 == 44u ) goto label$4369;
						label$4375:;
						if( ICHAR$2 != 59u ) goto label$4368;
						label$4369:;
						{
							goto label$4349;
						}
						goto label$4353;
						label$4368:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid Hex caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4378;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4377;
							label$4378:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4377:;
							fb$result$1 = -1;
							fb_StrDelete( &SDEFNAME$1 );
							fb_StrDelete( &SPARAM$1 );
							goto label$4266;
						}
						label$4376:;
						label$4353:;
					}
					*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + 1;
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$985$1 + *(integer*)((ubyte*)TMP$985$1 + 20));
				}
				label$4350:;
				goto label$4348;
				label$4349:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BHEX$1 = (byte)1;
				BIMM$1 = (byte)1;
			}
			goto label$4295;
			label$4346:;
			if( ICHAR$2 != 60u ) goto label$4379;
			label$4380:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4382;
				{
					if( (integer)BHI$1 == 0 ) goto label$4384;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found <" );
						fb$result$1 = -1;
						fb_StrDelete( &SDEFNAME$1 );
						fb_StrDelete( &SPARAM$1 );
						goto label$4266;
					}
					goto label$4383;
					label$4384:;
					{
						BHI$1 = (byte)-1;
					}
					label$4383:;
				}
				goto label$4381;
				label$4382:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SDEFNAME$1 );
					fb_StrDelete( &SPARAM$1 );
					goto label$4266;
				}
				label$4381:;
			}
			goto label$4295;
			label$4379:;
			if( ICHAR$2 != 62u ) goto label$4385;
			label$4386:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4388;
				{
					if( (integer)BHI$1 == 0 ) goto label$4390;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found >" );
						fb$result$1 = -1;
						fb_StrDelete( &SDEFNAME$1 );
						fb_StrDelete( &SPARAM$1 );
						goto label$4266;
					}
					goto label$4389;
					label$4390:;
					{
						BHI$1 = (byte)1;
					}
					label$4389:;
				}
				goto label$4387;
				label$4388:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SDEFNAME$1 );
					fb_StrDelete( &SPARAM$1 );
					goto label$4266;
				}
				label$4387:;
			}
			goto label$4295;
			label$4385:;
			if( ICHAR$2 == 32 ) goto label$4392;
			label$4393:;
			if( ICHAR$2 != 9 ) goto label$4391;
			label$4392:;
			{
			}
			goto label$4295;
			label$4391:;
			if( ICHAR$2 == 13 ) goto label$4395;
			label$4396:;
			if( ICHAR$2 == 10 ) goto label$4395;
			label$4397:;
			if( ICHAR$2 == 0 ) goto label$4395;
			label$4398:;
			if( ICHAR$2 != 59u ) goto label$4394;
			label$4395:;
			{
				integer TMP$989$4;
				integer TMP$991$4;
				integer TMP$992$4;
				integer TMP$993$4;
				*(long*)((ubyte*)TMP$985$1 + 20) = *(long*)((ubyte*)TMP$985$1 + 20) + -1;
				if( (integer)BLAB$1 == 0 ) goto label$4400;
				{
					integer TMP$987$5;
					long vr$6982 = GETLABEL( &SPARAM$1, &UVAL$1 );
					if( -(vr$6982 < 0) != 0 ) goto label$4401;
					TMP$987$5 = -(-(UVAL$1 < 0) != 0);
					goto label$4414;
					label$4401:;
					TMP$987$5 = -1;
					label$4414:;
					if( TMP$987$5 == 0 ) goto label$4403;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Label not found (forward labels not supported for ORG)" );
						fb$result$1 = -1;
						fb_StrDelete( &SDEFNAME$1 );
						fb_StrDelete( &SPARAM$1 );
						goto label$4266;
					}
					label$4403:;
					label$4402:;
					BIMM$1 = (byte)1;
					BHEX$1 = (byte)1;
				}
				label$4400:;
				label$4399:;
				if( -((integer)BIMM$1 == 0) == 0 ) goto label$4404;
				TMP$989$4 = -(-((integer)BLAB$1 == 0) != 0);
				goto label$4415;
				label$4404:;
				TMP$989$4 = 0;
				label$4415:;
				if( TMP$989$4 == 0 ) goto label$4406;
				fb_Color( 12, 0, 2 );
				puts( (char*)"Expected constant value" );
				fb$result$1 = -1;
				fb_StrDelete( &SDEFNAME$1 );
				fb_StrDelete( &SPARAM$1 );
				goto label$4266;
				label$4406:;
				if( (integer)BHI$1 == 0 ) goto label$4408;
				if( (integer)BHI$1 <= 0 ) goto label$4410;
				UVAL$1 = UVAL$1 >> 8;
				goto label$4409;
				label$4410:;
				UVAL$1 = UVAL$1 & 255;
				label$4409:;
				label$4408:;
				if( (integer)BHEX$1 == 0 ) goto label$4413;
				TMP$993$4 = -((integer)BDIGCNT$1 > 2);
				goto label$4416;
				label$4413:;
				if( -((integer)BDIGCNT$1 > 3) != 0 ) goto label$4411;
				TMP$991$4 = -(-(UVAL$1 < -128) != 0);
				goto label$4417;
				label$4411:;
				TMP$991$4 = -1;
				label$4417:;
				if( TMP$991$4 != 0 ) goto label$4412;
				TMP$992$4 = -(-(UVAL$1 > 255) != 0);
				goto label$4418;
				label$4412:;
				TMP$992$4 = -1;
				label$4418:;
				TMP$993$4 = TMP$992$4;
				label$4416:;
				long vr$7010 = ADDLABEL( &SDEFNAME$1, UVAL$1, (byte)TMP$993$4 );
				fb$result$1 = vr$7010;
				fb_StrDelete( &SDEFNAME$1 );
				fb_StrDelete( &SPARAM$1 );
				goto label$4266;
			}
			label$4394:;
			label$4295:;
		}
	}
	label$4294:;
	goto label$4292;
	label$4293:;
	fb_StrDelete( &SDEFNAME$1 );
	fb_StrDelete( &SPARAM$1 );
	label$4266:;
	return fb$result$1;
}

long FINDOPCODE( string* SOPCODE$1 )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4419:;
	long OPCODEU$1;
	OPCODEU$1 = *(*(long**)SOPCODE$1) & -538976289;
	{
		long N$2;
		N$2 = 0;
		label$4424:;
		{
			if( OPCODEU$1 != *(long*)((ubyte*)TOPCODE$ + ((integer)N$2 * 24)) ) goto label$4426;
			fb$result$1 = N$2;
			goto label$4420;
			label$4426:;
		}
		label$4422:;
		N$2 = N$2 + 1;
		label$4421:;
		if( N$2 <= 57 ) goto label$4424;
		label$4423:;
	}
	fb$result$1 = -1;
	goto label$4420;
	label$4420:;
	return fb$result$1;
}

long PROCESSOPCODE_( void )
{
	struct PARSERSTRUCT* TMP$994$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4427:;
	TMP$994$1 = &G_TPARSER$;
	*(long*)((ubyte*)G_LPOSITION$ + (*(integer*)((ubyte*)TMP$994$1 + 48) << 2)) = *(long*)((ubyte*)TMP$994$1 + 12) + 1;
	*(ubyte*)((ubyte*)*(char**)TMP$994$1 + (integer)(*(long*)((ubyte*)TMP$994$1 + 20) + -1)) = (ubyte)0;
	string SOPCODE$1;
	string* vr$7036 = fb_StrInit( (void*)&SOPCODE$1, -1, (void*)((ubyte*)*(char**)TMP$994$1 + *(integer*)((ubyte*)TMP$994$1 + 28)), 0, 0 );
	long IOPCODE$1;
	long vr$7038 = FINDOPCODE( &SOPCODE$1 );
	IOPCODE$1 = vr$7038;
	*(ubyte*)((ubyte*)*(char**)TMP$994$1 + (integer)(*(long*)((ubyte*)TMP$994$1 + 20) + -1)) = (ubyte)*(long*)((ubyte*)TMP$994$1 + 36);
	if( IOPCODE$1 >= 0 ) goto label$4430;
	{
		fb_Color( 12, 0, 2 );
		puts( (char*)"ERROR: unrecognized opcode" );
		fb$result$1 = IOPCODE$1;
		fb_StrDelete( &SOPCODE$1 );
		goto label$4428;
	}
	label$4430:;
	label$4429:;
	*(long*)((ubyte*)TMP$994$1 + 28) = -1;
	*(long*)((ubyte*)TMP$994$1 + 40) = *(long*)((ubyte*)TMP$994$1 + 40) + 1;
	long vr$7051 = (*(tmp$850*)(((ubyte*)TOPCODE$ + ((integer)IOPCODE$1 * 24)) + 20))( IOPCODE$1 );
	if( vr$7051 >= 0 ) goto label$4432;
	fb$result$1 = -1;
	fb_StrDelete( &SOPCODE$1 );
	goto label$4428;
	label$4432:;
	fb$result$1 = IOPCODE$1;
	fb_StrDelete( &SOPCODE$1 );
	goto label$4428;
	fb_StrDelete( &SOPCODE$1 );
	label$4428:;
	return fb$result$1;
}

long PROCESSLABEL_( void )
{
	struct PARSERSTRUCT* TMP$996$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4433:;
	TMP$996$1 = &G_TPARSER$;
	*(ubyte*)((ubyte*)*(char**)TMP$996$1 + (integer)(*(long*)((ubyte*)TMP$996$1 + 20) + -1)) = (ubyte)0;
	string SLABEL$1;
	string* vr$7065 = fb_StrInit( (void*)&SLABEL$1, -1, (void*)((ubyte*)*(char**)TMP$996$1 + *(integer*)((ubyte*)TMP$996$1 + 28)), 0, 0 );
	long vr$7068 = ADDLABEL( &SLABEL$1, *(long*)((ubyte*)TMP$996$1 + 48), (byte)-1 );
	if( vr$7068 >= 0 ) goto label$4436;
	{
		fb_Color( 12, 0, 2 );
		puts( (char*)"ERROR: Label already exist" );
		fb$result$1 = 0;
		fb_StrDelete( &SLABEL$1 );
		goto label$4434;
	}
	label$4436:;
	label$4435:;
	*(ubyte*)((ubyte*)*(char**)TMP$996$1 + (integer)(*(long*)((ubyte*)TMP$996$1 + 20) + -1)) = (ubyte)*(long*)((ubyte*)TMP$996$1 + 36);
	*(long*)((ubyte*)TMP$996$1 + 28) = -1;
	*(long*)((ubyte*)TMP$996$1 + 40) = *(long*)((ubyte*)TMP$996$1 + 40) + 1;
	*(long*)((ubyte*)TMP$996$1 + 44) = 1;
	fb$result$1 = 1;
	fb_StrDelete( &SLABEL$1 );
	goto label$4434;
	fb_StrDelete( &SLABEL$1 );
	label$4434:;
	return fb$result$1;
}

long PROCESSNEWORG_( void )
{
	struct PARSERSTRUCT* TMP$998$1;
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$4437:;
	byte BIMM$1;
	__builtin_memset( &BIMM$1, 0, 1 );
	byte BHEX$1;
	__builtin_memset( &BHEX$1, 0, 1 );
	byte BHI$1;
	__builtin_memset( &BHI$1, 0, 1 );
	byte BDIGCNT$1;
	__builtin_memset( &BDIGCNT$1, 0, 1 );
	byte BLAB$1;
	__builtin_memset( &BLAB$1, 0, 1 );
	long UVAL$1;
	__builtin_memset( &UVAL$1, 0, 4 );
	string SPARAM$1;
	__builtin_memset( &SPARAM$1, 0, 12 );
	TMP$998$1 = &G_TPARSER$;
	label$4439:;
	{
		long ICHAR$2;
		ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20));
		*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + 1;
		{
			if( ICHAR$2 < 65u ) goto label$4445;
			if( ICHAR$2 <= 90u ) goto label$4444;
			label$4445:;
			if( ICHAR$2 < 97u ) goto label$4446;
			if( ICHAR$2 <= 122u ) goto label$4444;
			label$4446:;
			if( ICHAR$2 != 95u ) goto label$4443;
			label$4444:;
			{
				char* PZSTART$4;
				PZSTART$4 = (char*)((ubyte*)*(char**)TMP$998$1 + (integer)(*(long*)((ubyte*)TMP$998$1 + 20) + -1));
				label$4447:;
				{
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20));
					*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + 1;
					{
						if( ICHAR$2 < 65u ) goto label$4453;
						if( ICHAR$2 <= 90u ) goto label$4452;
						label$4453:;
						if( ICHAR$2 < 97u ) goto label$4451;
						if( ICHAR$2 > 122u ) goto label$4451;
						label$4452:;
						{
						}
						goto label$4450;
						label$4451:;
						if( ICHAR$2 < 48u ) goto label$4456;
						if( ICHAR$2 <= 57u ) goto label$4455;
						label$4456:;
						if( ICHAR$2 != 95u ) goto label$4454;
						label$4455:;
						{
						}
						goto label$4450;
						label$4454:;
						{
							goto label$4448;
						}
						label$4457:;
						label$4450:;
					}
				}
				label$4449:;
				goto label$4447;
				label$4448:;
				*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + -1;
				BIMM$1 = (byte)1;
				BLAB$1 = (byte)1;
				*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20)) = (ubyte)0;
				fb_StrAssign( (void*)&SPARAM$1, -1, (void*)PZSTART$4, 0, 0 );
				*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20)) = (ubyte)ICHAR$2;
			}
			goto label$4442;
			label$4443:;
			if( ICHAR$2 != 35u ) goto label$4458;
			label$4459:;
			{
				if( (integer)BIMM$1 != 0 ) goto label$4461;
				{
					BIMM$1 = (byte)1;
				}
				goto label$4460;
				label$4461:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: expected immediate... found #" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4438;
				}
				label$4460:;
			}
			goto label$4442;
			label$4458:;
			if( ICHAR$2 < 48u ) goto label$4464;
			if( ICHAR$2 <= 57u ) goto label$4463;
			label$4464:;
			if( ICHAR$2 == 45u ) goto label$4463;
			label$4465:;
			if( ICHAR$2 != 43u ) goto label$4462;
			label$4463:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				label$4466:;
				{
					if( INUM$4 <= 65535 ) goto label$4470;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"number too big!" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4438;
					}
					label$4470:;
					label$4469:;
					{
						if( ICHAR$2 != 45u ) goto label$4472;
						label$4473:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4475;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4474;
							label$4475:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4438;
							}
							label$4474:;
						}
						goto label$4471;
						label$4472:;
						if( ICHAR$2 != 43u ) goto label$4476;
						label$4477:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4479;
							{
								ISGN$4 = 1;
							}
							goto label$4478;
							label$4479:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4438;
							}
							label$4478:;
						}
						goto label$4471;
						label$4476:;
						if( ICHAR$2 < 48u ) goto label$4480;
						if( ICHAR$2 > 57u ) goto label$4480;
						label$4481:;
						{
							INUM$4 = (integer)((integer)((INUM$4 * 10) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4471;
						label$4480:;
						if( ICHAR$2 == 13 ) goto label$4483;
						label$4484:;
						if( ICHAR$2 == 10 ) goto label$4483;
						label$4485:;
						if( ICHAR$2 == 0 ) goto label$4483;
						label$4486:;
						if( ICHAR$2 == 32 ) goto label$4483;
						label$4487:;
						if( ICHAR$2 == 9 ) goto label$4483;
						label$4488:;
						if( ICHAR$2 == 44u ) goto label$4483;
						label$4489:;
						if( ICHAR$2 != 59u ) goto label$4482;
						label$4483:;
						{
							*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + -1;
							goto label$4467;
						}
						goto label$4471;
						label$4482:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid decimal caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4492;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4491;
							label$4492:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4491:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$4438;
						}
						label$4490:;
						label$4471:;
					}
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20));
					*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + 1;
				}
				label$4468:;
				goto label$4466;
				label$4467:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BIMM$1 = (byte)1;
			}
			goto label$4442;
			label$4462:;
			if( ICHAR$2 != 36u ) goto label$4493;
			label$4494:;
			{
				integer INUM$4;
				INUM$4 = 0;
				integer ISGN$4;
				ISGN$4 = 1;
				BDIGCNT$1 = (byte)0;
				ubyte vr$7150 = NEXTCHAR_(  );
				ICHAR$2 = (long)vr$7150;
				label$4495:;
				{
					if( INUM$4 <= 65535 ) goto label$4499;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Number too big" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4438;
					}
					label$4499:;
					label$4498:;
					{
						if( ICHAR$2 != 45u ) goto label$4501;
						label$4502:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4504;
							{
								ISGN$4 = -ISGN$4;
							}
							goto label$4503;
							label$4504:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4438;
							}
							label$4503:;
						}
						goto label$4500;
						label$4501:;
						if( ICHAR$2 != 43u ) goto label$4505;
						label$4506:;
						{
							if( (integer)BDIGCNT$1 != 0 ) goto label$4508;
							{
								ISGN$4 = 1;
							}
							goto label$4507;
							label$4508:;
							{
								fb_Color( 12, 0, 2 );
								puts( (char*)"Expressions not supported yet." );
								fb$result$1 = -1;
								fb_StrDelete( &SPARAM$1 );
								goto label$4438;
							}
							label$4507:;
						}
						goto label$4500;
						label$4505:;
						if( ICHAR$2 < 48u ) goto label$4509;
						if( ICHAR$2 > 57u ) goto label$4509;
						label$4510:;
						{
							INUM$4 = (integer)((integer)((INUM$4 << 4) + ICHAR$2) + 4294967248u);
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4500;
						label$4509:;
						if( ICHAR$2 < 65u ) goto label$4511;
						if( ICHAR$2 > 70u ) goto label$4511;
						label$4512:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -55;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4500;
						label$4511:;
						if( ICHAR$2 < 97u ) goto label$4513;
						if( ICHAR$2 > 102u ) goto label$4513;
						label$4514:;
						{
							INUM$4 = (integer)((INUM$4 << 4) + ICHAR$2) + -87;
							BDIGCNT$1 = (byte)((integer)BDIGCNT$1 + 1);
						}
						goto label$4500;
						label$4513:;
						if( ICHAR$2 == 13 ) goto label$4516;
						label$4517:;
						if( ICHAR$2 == 10 ) goto label$4516;
						label$4518:;
						if( ICHAR$2 == 0 ) goto label$4516;
						label$4519:;
						if( ICHAR$2 == 32 ) goto label$4516;
						label$4520:;
						if( ICHAR$2 == 9 ) goto label$4516;
						label$4521:;
						if( ICHAR$2 == 44u ) goto label$4516;
						label$4522:;
						if( ICHAR$2 != 59u ) goto label$4515;
						label$4516:;
						{
							goto label$4496;
						}
						goto label$4500;
						label$4515:;
						{
							fb_Color( 12, 0, 2 );
							printf( (char*)"Invalid Hex caracter '" );
							if( (-(ICHAR$2 < 32) | -(ICHAR$2 > 127)) == 0 ) goto label$4525;
							printf( (char*)"0x%02X'", ICHAR$2 );
							goto label$4524;
							label$4525:;
							printf( (char*)"%c'", ICHAR$2 );
							label$4524:;
							fb$result$1 = -1;
							fb_StrDelete( &SPARAM$1 );
							goto label$4438;
						}
						label$4523:;
						label$4500:;
					}
					*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + 1;
					ICHAR$2 = (long)*(ubyte*)((ubyte*)*(char**)TMP$998$1 + *(integer*)((ubyte*)TMP$998$1 + 20));
				}
				label$4497:;
				goto label$4495;
				label$4496:;
				UVAL$1 = (long)(INUM$4 * ISGN$4);
				BHEX$1 = (byte)1;
				BIMM$1 = (byte)1;
			}
			goto label$4442;
			label$4493:;
			if( ICHAR$2 != 60u ) goto label$4526;
			label$4527:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4529;
				{
					if( (integer)BHI$1 == 0 ) goto label$4531;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found <" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4438;
					}
					goto label$4530;
					label$4531:;
					{
						BHI$1 = (byte)-1;
					}
					label$4530:;
				}
				goto label$4528;
				label$4529:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4438;
				}
				label$4528:;
			}
			goto label$4442;
			label$4526:;
			if( ICHAR$2 != 62u ) goto label$4532;
			label$4533:;
			{
				if( (integer)BIMM$1 == 0 ) goto label$4535;
				{
					if( (integer)BHI$1 == 0 ) goto label$4537;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"ERROR: expected label... found >" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4438;
					}
					goto label$4536;
					label$4537:;
					{
						BHI$1 = (byte)1;
					}
					label$4536:;
				}
				goto label$4534;
				label$4535:;
				{
					fb_Color( 12, 0, 2 );
					puts( (char*)"ERROR: a # must precede < or > for lo/hi offset" );
					fb$result$1 = -1;
					fb_StrDelete( &SPARAM$1 );
					goto label$4438;
				}
				label$4534:;
			}
			goto label$4442;
			label$4532:;
			if( ICHAR$2 == 32 ) goto label$4539;
			label$4540:;
			if( ICHAR$2 != 9 ) goto label$4538;
			label$4539:;
			{
			}
			goto label$4442;
			label$4538:;
			if( ICHAR$2 == 13 ) goto label$4542;
			label$4543:;
			if( ICHAR$2 == 10 ) goto label$4542;
			label$4544:;
			if( ICHAR$2 == 0 ) goto label$4542;
			label$4545:;
			if( ICHAR$2 != 59u ) goto label$4541;
			label$4542:;
			{
				integer TMP$1000$4;
				*(long*)((ubyte*)TMP$998$1 + 20) = *(long*)((ubyte*)TMP$998$1 + 20) + -1;
				if( (integer)BLAB$1 == 0 ) goto label$4547;
				{
					integer TMP$999$5;
					long vr$7202 = GETLABEL( &SPARAM$1, &UVAL$1 );
					if( -(vr$7202 < 0) != 0 ) goto label$4548;
					TMP$999$5 = -(-(UVAL$1 < 0) != 0);
					goto label$4562;
					label$4548:;
					TMP$999$5 = -1;
					label$4562:;
					if( TMP$999$5 == 0 ) goto label$4550;
					{
						fb_Color( 12, 0, 2 );
						puts( (char*)"Label not found (forward labels not supported for ORG)" );
						fb$result$1 = -1;
						fb_StrDelete( &SPARAM$1 );
						goto label$4438;
					}
					label$4550:;
					label$4549:;
					BIMM$1 = (byte)1;
					BHEX$1 = (byte)1;
				}
				label$4547:;
				label$4546:;
				if( -((integer)BIMM$1 == 0) == 0 ) goto label$4551;
				TMP$1000$4 = -(-((integer)BLAB$1 == 0) != 0);
				goto label$4563;
				label$4551:;
				TMP$1000$4 = 0;
				label$4563:;
				if( TMP$1000$4 == 0 ) goto label$4553;
				fb_Color( 12, 0, 2 );
				puts( (char*)"Expected new org address" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$4438;
				label$4553:;
				if( UVAL$1 >= 0 ) goto label$4555;
				fb_Color( 12, 0, 2 );
				puts( (char*)"Invalid new org address" );
				fb$result$1 = -1;
				fb_StrDelete( &SPARAM$1 );
				goto label$4438;
				label$4555:;
				if( (integer)BHI$1 == 0 ) goto label$4557;
				if( (integer)BHI$1 <= 0 ) goto label$4559;
				UVAL$1 = UVAL$1 >> 8;
				goto label$4558;
				label$4559:;
				UVAL$1 = UVAL$1 & 255;
				label$4558:;
				label$4557:;
				if( *(long*)((ubyte*)TMP$998$1 + 48) == *(long*)((ubyte*)TMP$998$1 + 52) ) goto label$4561;
				{
					ADDBLOCK( *(long*)((ubyte*)TMP$998$1 + 52), *(long*)((ubyte*)TMP$998$1 + 48) );
					*(long*)((ubyte*)TMP$998$1 + 24) = (*(long*)((ubyte*)TMP$998$1 + 24) + *(long*)((ubyte*)TMP$998$1 + 48)) - *(long*)((ubyte*)TMP$998$1 + 52);
				}
				label$4561:;
				label$4560:;
				*(long*)((ubyte*)TMP$998$1 + 48) = UVAL$1;
				*(long*)((ubyte*)TMP$998$1 + 52) = UVAL$1;
				fb$result$1 = *(long*)((ubyte*)TMP$998$1 + 48);
				fb_StrDelete( &SPARAM$1 );
				goto label$4438;
			}
			label$4541:;
			label$4442:;
		}
	}
	label$4441:;
	goto label$4439;
	label$4440:;
	fb_StrDelete( &SPARAM$1 );
	label$4438:;
	return fb$result$1;
}

byte ASSEMBLE( string* SFILE$1, byte IOUTPUT$1 )
{
	struct PARSERSTRUCT* TMP$1003$1;
	byte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$4564:;
	memset( (void*)G_BMEMORY$, 0, 65536 );
	memset( (void*)G_BMEMCHG$, 0, 65536 );
	{
		struct PARSERSTRUCT __TEMP__G_TPARSER$2;
		_ZN12PARSERSTRUCTC1Ev( &__TEMP__G_TPARSER$2 );
		_ZN12PARSERSTRUCTaSERS_( &G_TPARSER$, &__TEMP__G_TPARSER$2 );
		_ZN12PARSERSTRUCTD1Ev( &__TEMP__G_TPARSER$2 );
	}
	memset( (void*)G_LPOSITION$, -1, 262144 );
	G_ILABELSCOUNT$ = 0;
	G_IPATCHCOUNT$ = 0;
	G_IBLOCKCOUNT$ = 0;
	TMP$1003$1 = &G_TPARSER$;
	*(long*)((ubyte*)TMP$1003$1 + 48) = 1536;
	*(long*)((ubyte*)TMP$1003$1 + 52) = 1536;
	*(long*)((ubyte*)TMP$1003$1 + 28) = -1;
	integer F$1;
	integer vr$7241 = fb_FileFree(  );
	F$1 = vr$7241;
	integer vr$7242 = fb_FileOpen( (string*)SFILE$1, 0, 1, 0, F$1, 0 );
	if( vr$7242 == 0 ) goto label$4567;
	{
		fb_Color( 12, 0, 2 );
		printf( (char*)"File '%s' not found\n", *(char**)SFILE$1 );
		fb$result$1 = (byte)0;
		goto label$4565;
	}
	label$4567:;
	label$4566:;
	longint vr$7244 = fb_FileSize( F$1 );
	*(long*)((ubyte*)&G_TPARSER$ + 16) = (long)vr$7244;
	string* vr$7247 = fb_StrFill1( (integer)(*(long*)((ubyte*)&G_TPARSER$ + 16) + 2), 0 );
	string* vr$7248 = fb_StrAssign( (void*)&G_TPARSER$, -1, vr$7247, -1, 0 );
	fb_FileGet( F$1, 0u, *(void**)&G_TPARSER$, *(integer*)((ubyte*)&G_TPARSER$ + 16) );
	fb_FileClose( F$1 );
	*(ubyte*)((ubyte*)*(char**)&G_TPARSER$ + *(integer*)((ubyte*)&G_TPARSER$ + 16)) = (ubyte)13;
	*(ubyte*)((ubyte*)*(char**)&G_TPARSER$ + (integer)(*(long*)((ubyte*)&G_TPARSER$ + 16) + 1)) = (ubyte)10;
	integer IERROR$1;
	IERROR$1 = 1;
	*(long*)((ubyte*)G_LPOSITION$ + (*(integer*)((ubyte*)&G_TPARSER$ + 48) << 2)) = *(long*)((ubyte*)&G_TPARSER$ + 12);
	label$4568:;
	{
		struct PARSERSTRUCT* TMP$1006$2;
		TMP$1006$2 = &G_TPARSER$;
		*(long*)((ubyte*)TMP$1006$2 + 36) = (long)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20));
		*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
		{
			long TMP$1007$3;
			TMP$1007$3 = *(long*)((ubyte*)TMP$1006$2 + 36);
			if( TMP$1007$3 != 58u ) goto label$4572;
			label$4573:;
			{
				integer TMP$1008$4;
				if( -(*(long*)((ubyte*)TMP$1006$2 + 40) == 0) == 0 ) goto label$4574;
				TMP$1008$4 = -(-(*(long*)((ubyte*)TMP$1006$2 + 28) >= 0) != 0);
				goto label$4676;
				label$4574:;
				TMP$1008$4 = 0;
				label$4676:;
				if( TMP$1008$4 == 0 ) goto label$4576;
				{
					PROCESSLABEL_(  );
				}
				goto label$4575;
				label$4576:;
				{
					PROCESSERROR_(  );
					fb_Sleep( -1 );
					goto label$4569;
				}
				label$4575:;
			}
			goto label$4571;
			label$4572:;
			if( TMP$1007$3 != 59u ) goto label$4577;
			label$4578:;
			{
				integer TMP$1009$4;
				label$4579:;
				if( (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) == 0 ) goto label$4581;
				TMP$1009$4 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) != 10) != 0);
				goto label$4677;
				label$4581:;
				TMP$1009$4 = 0;
				label$4677:;
				if( TMP$1009$4 == 0 ) goto label$4580;
				{
					*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
				}
				goto label$4579;
				label$4580:;
			}
			goto label$4571;
			label$4577:;
			if( TMP$1007$3 == 13 ) goto label$4583;
			label$4584:;
			if( TMP$1007$3 == 10 ) goto label$4583;
			label$4585:;
			if( TMP$1007$3 != 0 ) goto label$4582;
			label$4583:;
			{
				integer TMP$1010$4;
				integer TMP$1011$4;
				if( *(long*)((ubyte*)TMP$1006$2 + 28) < 0 ) goto label$4587;
				long vr$7281 = PROCESSOPCODE_(  );
				if( vr$7281 >= 0 ) goto label$4589;
				*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + -1;
				label$4590:;
				if( (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) == 0 ) goto label$4592;
				TMP$1010$4 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) != 10) != 0);
				goto label$4678;
				label$4592:;
				TMP$1010$4 = 0;
				label$4678:;
				if( TMP$1010$4 == 0 ) goto label$4591;
				{
					*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
				}
				goto label$4590;
				label$4591:;
				*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) = (ubyte)0;
				fb_Color( 8, 0, 2 );
				puts( (char*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 32)) );
				*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) = (ubyte)*(long*)((ubyte*)TMP$1006$2 + 36);
				goto label$4569;
				label$4589:;
				label$4587:;
				if( -(*(long*)((ubyte*)TMP$1006$2 + 36) == 13) == 0 ) goto label$4593;
				TMP$1011$4 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) == 10) != 0);
				goto label$4679;
				label$4593:;
				TMP$1011$4 = 0;
				label$4679:;
				if( TMP$1011$4 == 0 ) goto label$4595;
				*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
				*(long*)((ubyte*)TMP$1006$2 + 36) = 10;
				label$4595:;
				if( *(long*)((ubyte*)TMP$1006$2 + 36) != 0 ) goto label$4597;
				IERROR$1 = 0;
				label$4597:;
				long vr$7322 = PROCESSEOL_(  );
				if( vr$7322 != 0 ) goto label$4599;
				goto label$4569;
				label$4599:;
			}
			goto label$4571;
			label$4582:;
			if( TMP$1007$3 == 32 ) goto label$4601;
			label$4602:;
			if( TMP$1007$3 != 9 ) goto label$4600;
			label$4601:;
			{
				if( *(long*)((ubyte*)TMP$1006$2 + 28) < 0 ) goto label$4604;
				{
					integer TMP$1012$5;
					integer TMP$1013$5;
					long vr$7324 = PROCESSOPCODE_(  );
					if( vr$7324 >= 0 ) goto label$4606;
					*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + -1;
					label$4607:;
					if( (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) == 0 ) goto label$4609;
					TMP$1012$5 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) != 10) != 0);
					goto label$4680;
					label$4609:;
					TMP$1012$5 = 0;
					label$4680:;
					if( TMP$1012$5 == 0 ) goto label$4608;
					{
						*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
					}
					goto label$4607;
					label$4608:;
					*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) = (ubyte)0;
					fb_Color( 8, 0, 2 );
					puts( (char*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 32)) );
					*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) = (ubyte)*(long*)((ubyte*)TMP$1006$2 + 36);
					goto label$4569;
					label$4606:;
					label$4610:;
					if( (uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) == 0 ) goto label$4612;
					TMP$1013$5 = -(-((uinteger)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) != 10) != 0);
					goto label$4681;
					label$4612:;
					TMP$1013$5 = 0;
					label$4681:;
					if( TMP$1013$5 == 0 ) goto label$4611;
					{
						*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + 1;
					}
					goto label$4610;
					label$4611:;
					*(long*)((ubyte*)TMP$1006$2 + 20) = *(long*)((ubyte*)TMP$1006$2 + 20) + -1;
				}
				label$4604:;
				label$4603:;
			}
			goto label$4571;
			label$4600:;
			if( TMP$1007$3 < 65u ) goto label$4615;
			if( TMP$1007$3 <= 90u ) goto label$4614;
			label$4615:;
			if( TMP$1007$3 < 97u ) goto label$4616;
			if( TMP$1007$3 <= 122u ) goto label$4614;
			label$4616:;
			if( TMP$1007$3 != 95u ) goto label$4613;
			label$4614:;
			{
				if( *(long*)((ubyte*)TMP$1006$2 + 28) >= 0 ) goto label$4618;
				*(long*)((ubyte*)TMP$1006$2 + 28) = *(long*)((ubyte*)TMP$1006$2 + 20) + -1;
				label$4618:;
			}
			goto label$4571;
			label$4613:;
			if( TMP$1007$3 < 48u ) goto label$4619;
			if( TMP$1007$3 > 57u ) goto label$4619;
			label$4620:;
			{
				if( *(long*)((ubyte*)TMP$1006$2 + 28) >= 0 ) goto label$4622;
				PROCESSERROR_(  );
				fb_Sleep( -1 );
				goto label$4569;
				label$4622:;
			}
			goto label$4571;
			label$4619:;
			if( TMP$1007$3 != 42u ) goto label$4623;
			label$4624:;
			{
				if( *(long*)((ubyte*)TMP$1006$2 + 28) < 0 ) goto label$4626;
				PROCESSERROR_(  );
				goto label$4569;
				label$4626:;
				if( (long)*(ubyte*)((ubyte*)*(char**)TMP$1006$2 + *(integer*)((ubyte*)TMP$1006$2 + 20)) != 61u ) goto label$4628;
				PROCESSNEWORG_(  );
				goto label$4627;
				label$4628:;
				PROCESSERROR_(  );
				goto label$4569;
				label$4627:;
			}
			goto label$4571;
			label$4623:;
			{
				PROCESSERROR_(  );
				goto label$4569;
			}
			label$4629:;
			label$4571:;
		}
	}
	label$4570:;
	goto label$4568;
	label$4569:;
	long ILINE$1;
	ILINE$1 = *(long*)((ubyte*)&G_TPARSER$ + 12) + 1;
	if( IERROR$1 != 0 ) goto label$4631;
	{
		{
			long N$3;
			N$3 = 0;
			long TMP$1014$3;
			TMP$1014$3 = G_IPATCHCOUNT$ + -1;
			goto label$4632;
			label$4635:;
			{
				struct PATCHSTRUCT* TMP$1015$4;
				TMP$1015$4 = (struct PATCHSTRUCT*)((ubyte*)G_TPATCH$ + ((integer)N$3 << 3));
				long UADDR$4;
				UADDR$4 = *(long*)(((ubyte*)G_TLABEL$ + ((integer)*(ushort*)TMP$1015$4 << 6)) + 56);
				if( UADDR$4 >= 0 ) goto label$4637;
				{
					fb_Color( 12, 0, 2 );
					printf( (char*)"ERROR: label '%s' not found\n", (char*)((ubyte*)G_TLABEL$ + ((integer)*(ushort*)TMP$1015$4 << 6)) );
					ILINE$1 = (long)*(ushort*)((ubyte*)TMP$1015$4 + 2);
					IERROR$1 = 1;
					goto label$4634;
				}
				label$4637:;
				label$4636:;
				if( (integer)*(byte*)((ubyte*)TMP$1015$4 + 7) == 0 ) goto label$4639;
				{
					long TMP$1017$5;
					if( (integer)*(byte*)((ubyte*)TMP$1015$4 + 7) <= 0 ) goto label$4640;
					TMP$1017$5 = UADDR$4 >> 8;
					goto label$4682;
					label$4640:;
					TMP$1017$5 = UADDR$4 & 255;
					label$4682:;
					*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1015$4 + 4)) = (ubyte)TMP$1017$5;
				}
				goto label$4638;
				label$4639:;
				if( (integer)*(byte*)((ubyte*)TMP$1015$4 + 6) == -1 ) goto label$4641;
				{
					*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1015$4 + 4)) = (ubyte)(UADDR$4 & 255);
					*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1015$4 + 4)) + 1) = (ubyte)((UADDR$4 >> 8) & 255);
				}
				goto label$4638;
				label$4641:;
				{
					*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1015$4 + 4)) = (ubyte)((UADDR$4 - (integer)*(ushort*)((ubyte*)TMP$1015$4 + 4)) + -1);
				}
				label$4638:;
			}
			label$4633:;
			N$3 = N$3 + 1;
			label$4632:;
			if( N$3 <= TMP$1014$3 ) goto label$4635;
			label$4634:;
		}
	}
	label$4631:;
	label$4630:;
	if( *(long*)((ubyte*)&G_TPARSER$ + 48) == *(long*)((ubyte*)&G_TPARSER$ + 52) ) goto label$4643;
	{
		ADDBLOCK( *(long*)((ubyte*)&G_TPARSER$ + 52), *(long*)((ubyte*)&G_TPARSER$ + 48) );
		*(long*)((ubyte*)&G_TPARSER$ + 24) = (*(long*)((ubyte*)&G_TPARSER$ + 24) + *(long*)((ubyte*)&G_TPARSER$ + 48)) - *(long*)((ubyte*)&G_TPARSER$ + 52);
	}
	label$4643:;
	label$4642:;
	fb_Color( 15, 0, 2 );
	if( IERROR$1 == 0 ) goto label$4645;
	{
		printf( (char*)"At Line %i\n", ILINE$1 );
	}
	goto label$4644;
	label$4645:;
	{
		if( (integer)IOUTPUT$1 != 1 ) goto label$4647;
		{
			{
				long M$4;
				M$4 = 0;
				long TMP$1019$4;
				TMP$1019$4 = G_IBLOCKCOUNT$ + -1;
				goto label$4648;
				label$4651:;
				{
					long UBEGIN$5;
					UBEGIN$5 = (long)*(ushort*)((ubyte*)G_TBLOCK$ + ((integer)M$4 << 2));
					long N$5;
					__builtin_memset( &N$5, 0, 4 );
					{
						N$5 = UBEGIN$5;
						long TMP$1020$6;
						TMP$1020$6 = (long)((integer)*(ushort*)(((ubyte*)G_TBLOCK$ + ((integer)M$4 << 2)) + 2) + -1);
						goto label$4652;
						label$4655:;
						{
							integer BSHOWHDR$7;
							BSHOWHDR$7 = -(((N$5 - UBEGIN$5) & 15) == 0);
							if( BSHOWHDR$7 == 0 ) goto label$4657;
							fb_Color( 7, 0, 2 );
							printf( (char*)"\n%04X: ", (integer)N$5 );
							fb_Color( 15, 0, 2 );
							label$4657:;
							printf( (char*)"%02X", (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)N$5) );
							if( ((N$5 - UBEGIN$5) & 1) == 0 ) goto label$4659;
							printf( (char*)" " );
							label$4659:;
						}
						label$4653:;
						N$5 = N$5 + 1;
						label$4652:;
						if( N$5 <= TMP$1020$6 ) goto label$4655;
						label$4654:;
					}
					if( ((N$5 - UBEGIN$5) & 1) == 0 ) goto label$4661;
					printf( (char*)"-- " );
					label$4661:;
				}
				label$4649:;
				M$4 = M$4 + 1;
				label$4648:;
				if( M$4 <= TMP$1019$4 ) goto label$4651;
				label$4650:;
			}
			puts( (char*)"" );
		}
		goto label$4646;
		label$4647:;
		if( (integer)IOUTPUT$1 != 2 ) goto label$4662;
		{
			{
				long M$4;
				M$4 = 0;
				long TMP$1024$4;
				TMP$1024$4 = G_IBLOCKCOUNT$ + -1;
				goto label$4663;
				label$4666:;
				{
					integer TMP$1025$5;
					long UBEGIN$5;
					UBEGIN$5 = (long)*(ushort*)((ubyte*)G_TBLOCK$ + ((integer)M$4 << 2));
					long N$5;
					__builtin_memset( &N$5, 0, 4 );
					if( M$4 != 0 ) goto label$4667;
					TMP$1025$5 = -(-(UBEGIN$5 != 1536) != 0);
					goto label$4683;
					label$4667:;
					TMP$1025$5 = -1;
					label$4683:;
					if( TMP$1025$5 == 0 ) goto label$4669;
					{
						fb_Color( 14, 0, 2 );
						printf( (char*)"\n*=%i", M$4 );
					}
					label$4669:;
					label$4668:;
					{
						N$5 = UBEGIN$5;
						long TMP$1027$6;
						TMP$1027$6 = (long)((integer)*(ushort*)(((ubyte*)G_TBLOCK$ + ((integer)M$4 << 2)) + 2) + -1);
						goto label$4670;
						label$4673:;
						{
							integer BSHOWHDR$7;
							BSHOWHDR$7 = -(((N$5 - UBEGIN$5) % 12) == 0);
							if( BSHOWHDR$7 == 0 ) goto label$4675;
							{
								fb_Color( 10, 0, 2 );
								printf( (char*)"\ndcb " );
								fb_Color( 15, 0, 2 );
							}
							goto label$4674;
							label$4675:;
							{
								printf( (char*)"," );
							}
							label$4674:;
							printf( (char*)"$%02X", (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)N$5) );
						}
						label$4671:;
						N$5 = N$5 + 1;
						label$4670:;
						if( N$5 <= TMP$1027$6 ) goto label$4673;
						label$4672:;
					}
				}
				label$4664:;
				M$4 = M$4 + 1;
				label$4663:;
				if( M$4 <= TMP$1024$4 ) goto label$4666;
				label$4665:;
			}
			puts( (char*)"" );
		}
		label$4662:;
		label$4646:;
		fb$result$1 = (byte)-1;
		goto label$4565;
	}
	label$4644:;
	fb$result$1 = (byte)0;
	goto label$4565;
	label$4565:;
	return fb$result$1;
}

byte DISASMINSTRUCTION( long* UADDR$1 )
{
	string TMP$1161$1;
	string TMP$1178$1;
	integer TMP$1179$1;
	integer TMP$1180$1;
	integer TMP$1181$1;
	string TMP$1183$1;
	byte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$4684:;
	ubyte BOP$1;
	BOP$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1);
	char SOPCODE$1[16];
	string* vr$7462 = fb_StrAssign( (void*)SOPCODE$1, 16, (void*)((ubyte*)G_ZDISM$ + ((integer)BOP$1 * 12)), 12, 0 );
	long ILEN$1;
	integer vr$7464 = fb_StrLen( (void*)SOPCODE$1, 16 );
	ILEN$1 = (long)vr$7464;
	__builtin_memset( &TMP$1161$1, 0, 12 );
	string* vr$7468 = fb_StrConcat( &TMP$1161$1, (void*)SOPCODE$1, 16, (void*)"      ", 7 );
	fb_StrAssign( (void*)SOPCODE$1, 16, vr$7468, -1, 0 );
	fb_Color( 7, 0, 2 );
	printf( (char*)"%04X: ", *(long*)UADDR$1 );
	fb_Color( 8, 0, 2 );
	printf( (char*)"%02 ", (uinteger)BOP$1 );
	*(long*)UADDR$1 = *(long*)UADDR$1 + 1;
	if( ILEN$1 != 0 ) goto label$4687;
	{
		fb_Locate( 0, 16, -1, 0, 0 );
		fb_Color( 12, 0, 2 );
		puts( (char*)"ILLEGAL" );
		fb$result$1 = (byte)0;
		goto label$4685;
	}
	label$4687:;
	label$4686:;
	byte OFFSET$1;
	OFFSET$1 = (byte)5;
	byte BDIG$1;
	BDIG$1 = (byte)2;
	byte BSZ$1;
	BSZ$1 = (byte)1;
	ushort UVAL$1;
	UVAL$1 = (ushort)*(long*)UADDR$1;
	uinteger UOP$1;
	UOP$1 = (((uinteger)*(ubyte*)((ubyte*)SOPCODE$1 + 5) + ((uinteger)*(ubyte*)((ubyte*)SOPCODE$1 + 6) << 8)) + ((uinteger)*(ubyte*)((ubyte*)SOPCODE$1 + 7) << 16)) + ((uinteger)*(ubyte*)((ubyte*)SOPCODE$1 + 8) << 24);
	{
		if( UOP$1 != 538976288 ) goto label$4689;
		label$4690:;
		{
			BDIG$1 = (byte)0;
			BSZ$1 = (byte)0;
		}
		goto label$4688;
		label$4689:;
		if( UOP$1 != 538976321 ) goto label$4691;
		label$4692:;
		{
			BDIG$1 = (byte)0;
			BSZ$1 = (byte)0;
		}
		goto label$4688;
		label$4691:;
		if( UOP$1 != 538998904 ) goto label$4693;
		label$4694:;
		{
			UVAL$1 = (ushort)*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1);
		}
		goto label$4688;
		label$4693:;
		if( UOP$1 != 544765988 ) goto label$4695;
		label$4696:;
		{
			OFFSET$1 = (byte)((integer)OFFSET$1 + 1);
		}
		goto label$4688;
		label$4695:;
		if( UOP$1 != 1077966968 ) goto label$4697;
		label$4698:;
		{
			UVAL$1 = (ushort)(((integer)UVAL$1 + (integer)*(byte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1)) + 1);
			BDIG$1 = (byte)4;
		}
		goto label$4688;
		label$4697:;
		if( UOP$1 != 746092580 ) goto label$4699;
		label$4700:;
		{
			OFFSET$1 = (byte)((integer)OFFSET$1 + 1);
		}
		goto label$4688;
		label$4699:;
		if( UOP$1 != 695760932 ) goto label$4701;
		label$4702:;
		{
			OFFSET$1 = (byte)((integer)OFFSET$1 + 1);
		}
		goto label$4688;
		label$4701:;
		if( UOP$1 != 1479309432 ) goto label$4703;
		label$4704:;
		{
		}
		goto label$4688;
		label$4703:;
		if( UOP$1 != 1496086648 ) goto label$4705;
		label$4706:;
		{
		}
		goto label$4688;
		label$4705:;
		if( UOP$1 != 2021160996 ) goto label$4707;
		label$4708:;
		{
			OFFSET$1 = (byte)((integer)OFFSET$1 + 1);
			BDIG$1 = (byte)4;
			BSZ$1 = (byte)2;
		}
		goto label$4688;
		label$4707:;
		if( UOP$1 != 2021161080 ) goto label$4709;
		label$4710:;
		{
			BDIG$1 = (byte)4;
			BSZ$1 = (byte)2;
		}
		goto label$4688;
		label$4709:;
		{
			fb_Color( 12, 0, 2 );
			printf( (char*)"{%s}%08X", UOP$1 );
			fb_Sleep( -1 );
		}
		label$4711:;
		label$4688:;
	}
	if( (integer)BSZ$1 != 1 ) goto label$4713;
	{
		string* vr$7510 = fb_HEXEx_i( (uinteger)(integer)*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1), 2 );
		fb_PrintString( 0, vr$7510, 0 );
		if( (integer)BDIG$1 != 2 ) goto label$4715;
		UVAL$1 = (ushort)*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1);
		label$4715:;
	}
	label$4713:;
	label$4712:;
	if( (integer)BSZ$1 != 2 ) goto label$4717;
	{
		string* vr$7517 = fb_HEXEx_i( (uinteger)(integer)*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1), 2 );
		fb_PrintString( 0, vr$7517, 0 );
		string* vr$7518 = fb_StrAllocTempDescZEx( (char*)" ", 1 );
		fb_PrintString( 0, vr$7518, 0 );
		string* vr$7522 = fb_HEXEx_i( (uinteger)(integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(*(long*)UADDR$1 + 1)), 2 );
		fb_PrintString( 0, vr$7522, 0 );
		UVAL$1 = (ushort)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(*(long*)UADDR$1 + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + *(integer*)UADDR$1));
	}
	label$4717:;
	label$4716:;
	*(long*)UADDR$1 = *(long*)UADDR$1 + (integer)BSZ$1;
	{
		long N$2;
		N$2 = (long)((integer)BDIG$1 + -1);
		goto label$4718;
		label$4721:;
		{
			integer UDIG$3;
			UDIG$3 = (integer)UVAL$1 & 15;
			if( UDIG$3 >= 10 ) goto label$4723;
			UDIG$3 = (integer)(UDIG$3 + 48u);
			goto label$4722;
			label$4723:;
			UDIG$3 = (integer)(UDIG$3 + 55u);
			label$4722:;
			*(ubyte*)((ubyte*)((ubyte*)SOPCODE$1 + (integer)OFFSET$1) + N$2) = (ubyte)UDIG$3;
			UVAL$1 = (ushort)((integer)UVAL$1 >> 4);
		}
		label$4719:;
		N$2 = N$2 + -1;
		label$4718:;
		if( N$2 >= 0 ) goto label$4721;
		label$4720:;
	}
	fb_Locate( 0, 16, -1, 0, 0 );
	fb_Color( 10, 0, 2 );
	__builtin_memset( &TMP$1178$1, 0, 12 );
	string* vr$7552 = fb_StrAllocTempDescZ( (char*)SOPCODE$1 );
	string* vr$7553 = fb_LEFT( vr$7552, 4 );
	string* vr$7555 = fb_StrAssign( (void*)&TMP$1178$1, -1, vr$7553, -1, 0 );
	printf( (char*)"%s", *(char**)&TMP$1178$1 );
	fb_StrDelete( &TMP$1178$1 );
	if( -((integer)BSZ$1 == 1) == 0 ) goto label$4724;
	TMP$1179$1 = -(-((integer)BDIG$1 == 4) != 0);
	goto label$4727;
	label$4724:;
	TMP$1179$1 = 0;
	label$4727:;
	if( TMP$1179$1 != 0 ) goto label$4725;
	TMP$1180$1 = -(-((uinteger)*(ubyte*)SOPCODE$1 == 74u) != 0);
	goto label$4728;
	label$4725:;
	TMP$1180$1 = -1;
	label$4728:;
	if( TMP$1180$1 == 0 ) goto label$4726;
	TMP$1181$1 = 14;
	goto label$4729;
	label$4726:;
	TMP$1181$1 = 15;
	label$4729:;
	fb_Color( TMP$1181$1, 0, 2 );
	__builtin_memset( &TMP$1183$1, 0, 12 );
	string* vr$7567 = fb_StrAllocTempDescZ( (char*)SOPCODE$1 );
	string* vr$7568 = fb_StrMid( vr$7567, 5, -1 );
	string* vr$7570 = fb_StrAssign( (void*)&TMP$1183$1, -1, vr$7568, -1, 0 );
	printf( (char*)"%s\n", *(char**)&TMP$1183$1 );
	fb_StrDelete( &TMP$1183$1 );
	fb$result$1 = (byte)-1;
	goto label$4685;
	label$4685:;
	return fb$result$1;
}

ubyte _ZN3CPU8READBYTEEl( long UADDR$1 )
{
	ubyte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$4732:;
	if( UADDR$1 != 254 ) goto label$4735;
	integer vr$7574 = rand(  );
	fb$result$1 = (ubyte)vr$7574;
	goto label$4733;
	label$4735:;
	fb$result$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)UADDR$1);
	goto label$4733;
	label$4733:;
	return fb$result$1;
}

void _ZN3CPU9WRITEBYTEElh( long UADDR$1, ubyte BVALUE$1 )
{
	label$4736:;
	if( UADDR$1 != 254 ) goto label$4739;
	{
		static double DDELAY$2;
		if( (uinteger)*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 12) == 0u ) goto label$4741;
		{
			double vr$7578 = fb_Timer(  );
			DDELAY$2 = vr$7578;
		}
		goto label$4740;
		label$4741:;
		{
			if( (uinteger)BVALUE$1 != 16 ) goto label$4743;
			{
				fb_GfxWaitVSync(  );
				double vr$7580 = fb_Timer(  );
				DDELAY$2 = vr$7580;
				*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 10) = (ubyte)1;
				*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 14) = (ubyte)1;
			}
			goto label$4742;
			label$4743:;
			{
				double vr$7581 = fb_Timer(  );
				double vr$7583 = fabs( vr$7581 - DDELAY$2 );
				if( vr$7583 <= ((double)((uinteger)BVALUE$1 << 1) / 1000.0) ) goto label$4745;
				{
					double vr$7588 = fb_Timer(  );
					DDELAY$2 = vr$7588;
				}
				goto label$4744;
				label$4745:;
				{
					label$4746:;
					double vr$7589 = fb_Timer(  );
					if( (vr$7589 - DDELAY$2) >= ((double)(uinteger)BVALUE$1 / 1000.0) ) goto label$4747;
					{
						fb_SleepEx( 1, 1 );
					}
					goto label$4746;
					label$4747:;
					DDELAY$2 = DDELAY$2 + ((double)(uinteger)BVALUE$1 / 1000.0);
				}
				label$4744:;
			}
			label$4742:;
			*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 10) = (ubyte)1;
			*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 14) = (ubyte)1;
		}
		label$4740:;
	}
	label$4739:;
	label$4738:;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)UADDR$1) = BVALUE$1;
	label$4737:;
}

void _ZN3CPU8RESETCPUERNS_7CPUCOREE( struct CPU$CPUCORE* TCPU$1 )
{
	struct CPU$CPUCORE* TMP$1186$1;
	label$4748:;
	TMP$1186$1 = (struct CPU$CPUCORE*)TCPU$1;
	if( *(ulong*)((ubyte*)TMP$1186$1 + 16) != 0 ) goto label$4751;
	*(ulong*)((ubyte*)TMP$1186$1 + 16) = 256u;
	label$4751:;
	*(ubyte*)TMP$1186$1 = (ubyte)0;
	*(ubyte*)((ubyte*)TMP$1186$1 + 1) = (ubyte)0;
	*(ubyte*)((ubyte*)TMP$1186$1 + 2) = (ubyte)0;
	*(ubyte*)((ubyte*)TMP$1186$1 + 3) = (ubyte)255;
	*(ushort*)((ubyte*)TMP$1186$1 + 6) = (ushort)1536;
	*(ubyte*)((ubyte*)TMP$1186$1 + 4) = (ubyte)0;
	*(ulong*)((ubyte*)TMP$1186$1 + 20) = 0u;
	*(ulong*)((ubyte*)TMP$1186$1 + 24) = 0u;
	label$4749:;
}

void _ZN3CPU7SHOWCPUERNS_7CPUCOREE( struct CPU$CPUCORE* TCPU$1 )
{
	struct CPU$CPUCORE* TMP$1187$1;
	uinteger TMP$1189$1;
	uinteger TMP$1190$1;
	uinteger TMP$1191$1;
	uinteger TMP$1192$1;
	uinteger TMP$1193$1;
	uinteger TMP$1194$1;
	uinteger TMP$1195$1;
	label$4752:;
	integer IROW$1;
	integer vr$7608 = fb_GetY(  );
	IROW$1 = vr$7608;
	integer ICOL$1;
	integer vr$7609 = fb_GetX(  );
	ICOL$1 = vr$7609;
	integer ICONW$1;
	ICONW$1 = 1572896;
	uinteger ICONH$1;
	ICONH$1 = (uinteger)ICONW$1 >> 16;
	ICONW$1 = (integer)((uinteger)ICONW$1 & 65535);
	fb_ConsoleView( 1, 24 );
	fb_Color( 14, 1, 0 );
	fb_Locate( 1, 1, -1, 0, 0 );
	TMP$1187$1 = (struct CPU$CPUCORE*)TCPU$1;
	*(ubyte*)((ubyte*)TMP$1187$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) & -129) | (((uinteger)((*(ulong*)((ubyte*)TMP$1187$1 + 20) >> 7) & 1) & 1) << 7));
	*(ubyte*)((ubyte*)TMP$1187$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) & -3) | (((uinteger)-((uinteger)(ubyte)*(ulong*)((ubyte*)TMP$1187$1 + 20) == 0) & 1) << 1));
	*(ubyte*)((ubyte*)TMP$1187$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) & -2) | ((uinteger)-(*(ulong*)((ubyte*)TMP$1187$1 + 24) > 255) & 1));
	char ZCPU$1[512];
	integer ILEN$1;
	if( ((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) & 1) == 0u ) goto label$4760;
	TMP$1195$1 = 67u;
	goto label$4761;
	label$4760:;
	TMP$1195$1 = 99u;
	label$4761:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 1) & 1) == 0u ) goto label$4759;
	TMP$1194$1 = 90u;
	goto label$4762;
	label$4759:;
	TMP$1194$1 = 122u;
	label$4762:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 2) & 1) == 0u ) goto label$4758;
	TMP$1193$1 = 73u;
	goto label$4763;
	label$4758:;
	TMP$1193$1 = 105u;
	label$4763:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 3) & 1) == 0u ) goto label$4757;
	TMP$1192$1 = 68u;
	goto label$4764;
	label$4757:;
	TMP$1192$1 = 100u;
	label$4764:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 4) & 1) == 0u ) goto label$4756;
	TMP$1191$1 = 66u;
	goto label$4765;
	label$4756:;
	TMP$1191$1 = 98u;
	label$4765:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 6) & 1) == 0u ) goto label$4755;
	TMP$1190$1 = 86u;
	goto label$4766;
	label$4755:;
	TMP$1190$1 = 118u;
	label$4766:;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 4) >> 7) & 1) == 0u ) goto label$4754;
	TMP$1189$1 = 78u;
	goto label$4767;
	label$4754:;
	TMP$1189$1 = 110u;
	label$4767:;
	integer vr$7679 = sprintf( (char*)ZCPU$1, (char*)"A%02X X%02X Y%02X S%02X PC%04X %c%c%c1%c%c%c%c", (uinteger)*(ubyte*)TMP$1187$1, (uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 1), (uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 2), (uinteger)*(ubyte*)((ubyte*)TMP$1187$1 + 3), (uinteger)*(ushort*)((ubyte*)TMP$1187$1 + 6), TMP$1189$1, TMP$1190$1, TMP$1191$1, TMP$1192$1, TMP$1193$1, TMP$1194$1, TMP$1195$1 );
	ILEN$1 = vr$7679;
	string* vr$7681 = fb_SPACE( (integer)(32u - ILEN$1) );
	fb_StrAssign( (void*)((ubyte*)ZCPU$1 + ILEN$1), 0, vr$7681, -1, 0 );
	printf( (char*)ZCPU$1 );
	fb_ConsoleView( 3, 13 );
	fb_Locate( IROW$1, ICOL$1, -1, 0, 0 );
	fb_Color( 7, 0, 0 );
	label$4753:;
}

void _ZN3CPU22FNOPCODE_UNIMPLEMENTEDEv( void )
{
	struct CPU$CPUCORE* TMP$1196$1;
	string TMP$1199$1;
	string TMP$1200$1;
	string TMP$1201$1;
	string TMP$1202$1;
	string TMP$1203$1;
	label$4768:;
	TMP$1196$1 = &_ZN3CPU7G_TCPU$E;
	fb_Color( 12, 0, 2 );
	__builtin_memset( &TMP$1203$1, 0, 12 );
	__builtin_memset( &TMP$1200$1, 0, 12 );
	string* vr$7692 = fb_StrConcat( &TMP$1200$1, (void*)" > '", 5, (void*)((ubyte*)G_ZDISM$ + ((integer)*(ubyte*)((ubyte*)TMP$1196$1 + 5) * 12)), 12 );
	__builtin_memset( &TMP$1201$1, 0, 12 );
	string* vr$7695 = fb_StrConcat( &TMP$1201$1, vr$7692, -1, (void*)"'", 2 );
	string* vr$7698 = fb_HEXEx_i( (uinteger)*(ubyte*)((ubyte*)TMP$1196$1 + 5), 2 );
	__builtin_memset( &TMP$1199$1, 0, 12 );
	string* vr$7701 = fb_StrConcat( &TMP$1199$1, (void*)"Unimplemented opcode: ", 23, vr$7698, -1 );
	__builtin_memset( &TMP$1202$1, 0, 12 );
	string* vr$7704 = fb_StrConcat( &TMP$1202$1, vr$7701, -1, vr$7695, -1 );
	string* vr$7706 = fb_StrAssign( (void*)&TMP$1203$1, -1, vr$7704, -1, 0 );
	puts( *(char**)&TMP$1203$1 );
	fb_StrDelete( &TMP$1203$1 );
	*(ubyte*)((ubyte*)TMP$1196$1 + 10) = (ubyte)1;
	label$4769:;
}

void _ZN3CPU12FNOPCODE__X_Ev( void )
{
	struct CPU$CPUCORE* TMP$1204$1;
	string TMP$1206$1;
	string TMP$1207$1;
	label$4770:;
	TMP$1204$1 = &_ZN3CPU7G_TCPU$E;
	fb_Color( 12, 0, 2 );
	__builtin_memset( &TMP$1207$1, 0, 12 );
	string* vr$7712 = fb_HEXEx_i( (uinteger)*(ubyte*)((ubyte*)TMP$1204$1 + 5), 2 );
	__builtin_memset( &TMP$1206$1, 0, 12 );
	string* vr$7715 = fb_StrConcat( &TMP$1206$1, (void*)"Illegal opcode: ", 17, vr$7712, -1 );
	string* vr$7717 = fb_StrAssign( (void*)&TMP$1207$1, -1, vr$7715, -1, 0 );
	puts( *(char**)&TMP$1207$1 );
	fb_StrDelete( &TMP$1207$1 );
	*(ubyte*)((ubyte*)TMP$1204$1 + 10) = (ubyte)1;
	label$4771:;
}

void _ZN3CPU17FNOPCODE_BRK_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1208$1;
	label$4772:;
	TMP$1208$1 = &_ZN3CPU7G_TCPU$E;
	goto label$4775;
	{
		if( G_BBREAKPOINT$ != ((integer)*(ushort*)((ubyte*)TMP$1208$1 + 6) + -1) ) goto label$4777;
		{
			*(ubyte*)((ubyte*)TMP$1208$1 + 10) = (ubyte)1;
			G_BBREAKPOINT$ = -1;
		}
		goto label$4776;
		label$4777:;
		{
			G_BBREAKPOINT$ = (long)((integer)*(ushort*)((ubyte*)TMP$1208$1 + 6) + -1);
			*(ushort*)((ubyte*)TMP$1208$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1208$1 + 6) + -1);
		}
		label$4776:;
	}
	goto label$4774;
	label$4775:;
	{
		*(ubyte*)((ubyte*)TMP$1208$1 + 10) = (ubyte)1;
	}
	label$4774:;
	label$4773:;
}

void _ZN3CPU18FNOPCODE_ORA_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1209$1;
	label$4778:;
	TMP$1209$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1209$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1209$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1209$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1209$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1209$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1209$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1209$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1209$1);
	*(ubyte*)TMP$1209$1 = (ubyte)*(ulong*)((ubyte*)TMP$1209$1 + 20);
	label$4779:;
}

void _ZN3CPU15FNOPCODE_ORA_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1210$1;
	label$4780:;
	TMP$1210$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1210$1 + 6));
	*(ushort*)((ubyte*)TMP$1210$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1210$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1210$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1210$1);
	*(ubyte*)TMP$1210$1 = (ubyte)*(ulong*)((ubyte*)TMP$1210$1 + 20);
	label$4781:;
}

void _ZN3CPU15FNOPCODE_ASL_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1211$1;
	label$4782:;
	TMP$1211$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1211$1 + 6));
	*(ushort*)((ubyte*)TMP$1211$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1211$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1211$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1211$1 + 20);
	*(ulong*)((ubyte*)TMP$1211$1 + 24) = *(ulong*)((ubyte*)TMP$1211$1 + 20);
	label$4783:;
}

void _ZN3CPU17FNOPCODE_PHP_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1212$1;
	label$4784:;
	TMP$1212$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1212$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 3) + -1);
	*(ubyte*)((ubyte*)TMP$1212$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 4) & -129) | (((uinteger)((*(ulong*)((ubyte*)TMP$1212$1 + 20) >> 7) & 1) & 1) << 7));
	*(ubyte*)((ubyte*)TMP$1212$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 4) & -3) | (((uinteger)-((uinteger)(ubyte)*(ulong*)((ubyte*)TMP$1212$1 + 20) == 0) & 1) << 1));
	*(ubyte*)((ubyte*)TMP$1212$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 4) & -2) | ((uinteger)-(*(ulong*)((ubyte*)TMP$1212$1 + 24) > 255) & 1));
	*(ubyte*)((ubyte*)TMP$1212$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 4) & -65) | (((uinteger)(-(*(long*)((ubyte*)TMP$1212$1 + 28) < -128) | -(*(long*)((ubyte*)TMP$1212$1 + 28) > 127)) & 1) << 6));
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1212$1 + 3))) = *(ubyte*)((ubyte*)TMP$1212$1 + 4);
	label$4785:;
}

void _ZN3CPU17FNOPCODE_ORA_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1213$1;
	label$4786:;
	TMP$1213$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1213$1 + 6);
	*(ushort*)((ubyte*)TMP$1213$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1213$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1213$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1213$1);
	*(ubyte*)TMP$1213$1 = (ubyte)*(ulong*)((ubyte*)TMP$1213$1 + 20);
	label$4787:;
}

void _ZN3CPU17FNOPCODE_ASLA_ACCEv( void )
{
	struct CPU$CPUCORE* TMP$1214$1;
	label$4788:;
	TMP$1214$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1214$1 + 20) = (ulong)*(ubyte*)TMP$1214$1 << 1;
	*(ulong*)((ubyte*)TMP$1214$1 + 24) = *(ulong*)((ubyte*)TMP$1214$1 + 20);
	*(ubyte*)TMP$1214$1 = (ubyte)*(ulong*)((ubyte*)TMP$1214$1 + 20);
	label$4789:;
}

void _ZN3CPU16FNOPCODE_ORA_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1215$1;
	label$4790:;
	TMP$1215$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1215$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1215$1 + 6));
	*(ushort*)((ubyte*)TMP$1215$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1215$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1215$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1215$1);
	*(ubyte*)TMP$1215$1 = (ubyte)*(ulong*)((ubyte*)TMP$1215$1 + 20);
	label$4791:;
}

void _ZN3CPU16FNOPCODE_ASL_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1216$1;
	label$4792:;
	TMP$1216$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1216$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1216$1 + 6));
	*(ushort*)((ubyte*)TMP$1216$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1216$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1216$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1216$1 + 20);
	*(ulong*)((ubyte*)TMP$1216$1 + 24) = *(ulong*)((ubyte*)TMP$1216$1 + 20);
	label$4793:;
}

void _ZN3CPU16FNOPCODE_BPL_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1217$1;
	label$4794:;
	TMP$1217$1 = &_ZN3CPU7G_TCPU$E;
	if( (*(ulong*)((ubyte*)TMP$1217$1 + 20) & 128) != 0 ) goto label$4797;
	*(ushort*)((ubyte*)TMP$1217$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1217$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1217$1 + 6))) & 65535);
	label$4797:;
	*(ushort*)((ubyte*)TMP$1217$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1217$1 + 6) + 1);
	label$4795:;
}

void _ZN3CPU18FNOPCODE_ORA_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1218$1;
	label$4798:;
	TMP$1218$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1218$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1218$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1218$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1218$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1218$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1218$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1218$1);
	*(ubyte*)TMP$1218$1 = (ubyte)*(ulong*)((ubyte*)TMP$1218$1 + 20);
	label$4799:;
}

void _ZN3CPU16FNOPCODE_ORA_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1219$1;
	label$4800:;
	TMP$1219$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1219$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1219$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1219$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1219$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1219$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1219$1);
	*(ubyte*)TMP$1219$1 = (ubyte)*(ulong*)((ubyte*)TMP$1219$1 + 20);
	label$4801:;
}

void _ZN3CPU16FNOPCODE_ASL_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1220$1;
	label$4802:;
	TMP$1220$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1220$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1220$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1220$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1220$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1220$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1220$1 + 20);
	*(ulong*)((ubyte*)TMP$1220$1 + 24) = *(ulong*)((ubyte*)TMP$1220$1 + 20);
	label$4803:;
}

void _ZN3CPU17FNOPCODE_CLC_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1221$1;
	label$4804:;
	TMP$1221$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1221$1 + 24) = 0u;
	label$4805:;
}

void _ZN3CPU17FNOPCODE_ORA_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1222$1;
	label$4806:;
	TMP$1222$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1222$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1222$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1222$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1222$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1222$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1222$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1222$1);
	*(ubyte*)TMP$1222$1 = (ubyte)*(ulong*)((ubyte*)TMP$1222$1 + 20);
	label$4807:;
}

void _ZN3CPU17FNOPCODE_ORA_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1223$1;
	label$4808:;
	TMP$1223$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1223$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1223$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1223$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1223$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1223$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1223$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) | (uinteger)*(ubyte*)TMP$1223$1);
	*(ubyte*)TMP$1223$1 = (ubyte)*(ulong*)((ubyte*)TMP$1223$1 + 20);
	label$4809:;
}

void _ZN3CPU17FNOPCODE_ASL_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1224$1;
	label$4810:;
	TMP$1224$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1224$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1224$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1224$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1224$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1224$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1224$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1224$1 + 20);
	*(ulong*)((ubyte*)TMP$1224$1 + 24) = *(ulong*)((ubyte*)TMP$1224$1 + 20);
	label$4811:;
}

void _ZN3CPU16FNOPCODE_JSR_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1225$1;
	label$4812:;
	TMP$1225$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1225$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1225$1 + 6));
	*(ushort*)((ubyte*)TMP$1225$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1225$1 + 6) + 2);
	*(ubyte*)((ubyte*)TMP$1225$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1225$1 + 3) + -2);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1225$1 + 3))) = (ubyte)(((integer)*(ushort*)((ubyte*)TMP$1225$1 + 6) + -1) & 255);
	*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1225$1 + 3))) + 1) = (ubyte)((((integer)*(ushort*)((ubyte*)TMP$1225$1 + 6) + -1) >> 8) & 255);
	*(ushort*)((ubyte*)TMP$1225$1 + 6) = (ushort)WMEMADDR$1;
	label$4813:;
}

void _ZN3CPU18FNOPCODE_AND_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1226$1;
	label$4814:;
	TMP$1226$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1226$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1226$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1226$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1226$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1226$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1226$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1226$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1226$1);
	*(ubyte*)TMP$1226$1 = (ubyte)*(ulong*)((ubyte*)TMP$1226$1 + 20);
	label$4815:;
}

void _ZN3CPU15FNOPCODE_BIT_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1227$1;
	label$4816:;
	TMP$1227$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1227$1 + 6));
	*(ushort*)((ubyte*)TMP$1227$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1227$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1227$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1227$1 + 28) = (*(ulong*)((ubyte*)TMP$1227$1 + 20) << 2) & 256;
	if( (uinteger)((uinteger)*(ubyte*)TMP$1227$1 & *(ulong*)((ubyte*)TMP$1227$1 + 20)) != 0 ) goto label$4819;
	*(ulong*)((ubyte*)TMP$1227$1 + 20) = 0u;
	label$4819:;
	label$4817:;
}

void _ZN3CPU15FNOPCODE_AND_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1228$1;
	label$4820:;
	TMP$1228$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1228$1 + 6));
	*(ushort*)((ubyte*)TMP$1228$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1228$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1228$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1228$1);
	*(ubyte*)TMP$1228$1 = (ubyte)*(ulong*)((ubyte*)TMP$1228$1 + 20);
	label$4821:;
}

void _ZN3CPU15FNOPCODE_ROL_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1229$1;
	label$4822:;
	TMP$1229$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1229$1 + 6));
	*(ushort*)((ubyte*)TMP$1229$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1229$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1229$1 + 20) = ((ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1) | ((*(ulong*)((ubyte*)TMP$1229$1 + 24) >> 8) & 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1229$1 + 20);
	*(ulong*)((ubyte*)TMP$1229$1 + 24) = *(ulong*)((ubyte*)TMP$1229$1 + 20);
	label$4823:;
}

void _ZN3CPU17FNOPCODE_PLP_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1230$1;
	uinteger TMP$1231$1;
	label$4824:;
	TMP$1230$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1230$1 + 4) = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 3)));
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 4) >> 1) & 1) == 0u ) goto label$4826;
	TMP$1231$1 = 0u;
	goto label$4827;
	label$4826:;
	TMP$1231$1 = (((uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 4) >> 7) & 1) << 7;
	label$4827:;
	*(ulong*)((ubyte*)TMP$1230$1 + 20) = (ulong)TMP$1231$1;
	*(ulong*)((ubyte*)TMP$1230$1 + 24) = (ulong)(((uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 4) & 1) << 8);
	*(ulong*)((ubyte*)TMP$1230$1 + 28) = (ulong)((((uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 4) >> 6) & 1) << 8);
	*(ubyte*)((ubyte*)TMP$1230$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1230$1 + 3) + 1);
	label$4825:;
}

void _ZN3CPU17FNOPCODE_AND_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1232$1;
	label$4828:;
	TMP$1232$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1232$1 + 6);
	*(ushort*)((ubyte*)TMP$1232$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1232$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1232$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1232$1);
	*(ubyte*)TMP$1232$1 = (ubyte)*(ulong*)((ubyte*)TMP$1232$1 + 20);
	label$4829:;
}

void _ZN3CPU17FNOPCODE_ROLA_ACCEv( void )
{
	struct CPU$CPUCORE* TMP$1233$1;
	label$4830:;
	TMP$1233$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1233$1 + 20) = ((ulong)*(ubyte*)TMP$1233$1 << 1) | ((*(ulong*)((ubyte*)TMP$1233$1 + 24) >> 8) & 1);
	*(ubyte*)TMP$1233$1 = (ubyte)*(ulong*)((ubyte*)TMP$1233$1 + 20);
	*(ulong*)((ubyte*)TMP$1233$1 + 24) = *(ulong*)((ubyte*)TMP$1233$1 + 20);
	label$4831:;
}

void _ZN3CPU16FNOPCODE_BIT_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1234$1;
	label$4832:;
	TMP$1234$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1234$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1234$1 + 6));
	*(ushort*)((ubyte*)TMP$1234$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1234$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1234$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1234$1 + 28) = (*(ulong*)((ubyte*)TMP$1234$1 + 20) << 2) & 256;
	if( (uinteger)((uinteger)*(ubyte*)TMP$1234$1 & *(ulong*)((ubyte*)TMP$1234$1 + 20)) != 0 ) goto label$4835;
	*(ulong*)((ubyte*)TMP$1234$1 + 20) = 0u;
	label$4835:;
	label$4833:;
}

void _ZN3CPU16FNOPCODE_AND_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1235$1;
	label$4836:;
	TMP$1235$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1235$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1235$1 + 6));
	*(ushort*)((ubyte*)TMP$1235$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1235$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1235$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1235$1);
	*(ubyte*)TMP$1235$1 = (ubyte)*(ulong*)((ubyte*)TMP$1235$1 + 20);
	label$4837:;
}

void _ZN3CPU16FNOPCODE_ROL_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1236$1;
	label$4838:;
	TMP$1236$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1236$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1236$1 + 6));
	*(ushort*)((ubyte*)TMP$1236$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1236$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1236$1 + 20) = ((ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1) | ((*(ulong*)((ubyte*)TMP$1236$1 + 24) >> 8) & 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1236$1 + 20);
	*(ulong*)((ubyte*)TMP$1236$1 + 24) = *(ulong*)((ubyte*)TMP$1236$1 + 20);
	label$4839:;
}

void _ZN3CPU16FNOPCODE_BMI_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1237$1;
	label$4840:;
	TMP$1237$1 = &_ZN3CPU7G_TCPU$E;
	if( (*(ulong*)((ubyte*)TMP$1237$1 + 20) & 128) == 0u ) goto label$4843;
	*(ushort*)((ubyte*)TMP$1237$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1237$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1237$1 + 6))) & 65535);
	label$4843:;
	*(ushort*)((ubyte*)TMP$1237$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1237$1 + 6) + 1);
	label$4841:;
}

void _ZN3CPU18FNOPCODE_AND_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1238$1;
	label$4844:;
	TMP$1238$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1238$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1238$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1238$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1238$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1238$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1238$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1238$1);
	*(ubyte*)TMP$1238$1 = (ubyte)*(ulong*)((ubyte*)TMP$1238$1 + 20);
	label$4845:;
}

void _ZN3CPU16FNOPCODE_AND_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1239$1;
	label$4846:;
	TMP$1239$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1239$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1239$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1239$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1239$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1239$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1239$1);
	*(ubyte*)TMP$1239$1 = (ubyte)*(ulong*)((ubyte*)TMP$1239$1 + 20);
	label$4847:;
}

void _ZN3CPU16FNOPCODE_ROL_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1240$1;
	label$4848:;
	TMP$1240$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1240$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1240$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1240$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1240$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1240$1 + 20) = ((ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1) | ((*(ulong*)((ubyte*)TMP$1240$1 + 24) >> 8) & 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1240$1 + 20);
	*(ulong*)((ubyte*)TMP$1240$1 + 24) = *(ulong*)((ubyte*)TMP$1240$1 + 20);
	label$4849:;
}

void _ZN3CPU17FNOPCODE_SEC_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1241$1;
	label$4850:;
	TMP$1241$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1241$1 + 24) = 4294967295u;
	label$4851:;
}

void _ZN3CPU17FNOPCODE_AND_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1242$1;
	label$4852:;
	TMP$1242$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1242$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1242$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1242$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1242$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1242$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1242$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1242$1);
	*(ubyte*)TMP$1242$1 = (ubyte)*(ulong*)((ubyte*)TMP$1242$1 + 20);
	label$4853:;
}

void _ZN3CPU17FNOPCODE_AND_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1243$1;
	label$4854:;
	TMP$1243$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1243$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1243$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1243$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1243$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1243$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1243$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) & (uinteger)*(ubyte*)TMP$1243$1);
	*(ubyte*)TMP$1243$1 = (ubyte)*(ulong*)((ubyte*)TMP$1243$1 + 20);
	label$4855:;
}

void _ZN3CPU17FNOPCODE_ROL_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1244$1;
	label$4856:;
	TMP$1244$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1244$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1244$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1244$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1244$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1244$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1244$1 + 20) = ((ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) << 1) | ((*(ulong*)((ubyte*)TMP$1244$1 + 24) >> 8) & 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1244$1 + 20);
	*(ulong*)((ubyte*)TMP$1244$1 + 24) = *(ulong*)((ubyte*)TMP$1244$1 + 20);
	label$4857:;
}

void _ZN3CPU17FNOPCODE_RTI_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1245$1;
	label$4858:;
	TMP$1245$1 = &_ZN3CPU7G_TCPU$E;
	_ZN3CPU22FNOPCODE_UNIMPLEMENTEDEv(  );
	label$4859:;
}

void _ZN3CPU18FNOPCODE_EOR_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1246$1;
	label$4860:;
	TMP$1246$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1246$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1246$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1246$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1246$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1246$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1246$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1246$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1246$1);
	*(ubyte*)TMP$1246$1 = (ubyte)*(ulong*)((ubyte*)TMP$1246$1 + 20);
	label$4861:;
}

void _ZN3CPU15FNOPCODE_EOR_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1247$1;
	label$4862:;
	TMP$1247$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1247$1 + 6));
	*(ushort*)((ubyte*)TMP$1247$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1247$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1247$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1247$1);
	*(ubyte*)TMP$1247$1 = (ubyte)*(ulong*)((ubyte*)TMP$1247$1 + 20);
	label$4863:;
}

void _ZN3CPU15FNOPCODE_LSR_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1248$1;
	label$4864:;
	TMP$1248$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1248$1 + 6));
	*(ushort*)((ubyte*)TMP$1248$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1248$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1248$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1248$1 + 24) = (*(ulong*)((ubyte*)TMP$1248$1 + 20) & 1) << 8;
	*(ulong*)((ubyte*)TMP$1248$1 + 20) = *(ulong*)((ubyte*)TMP$1248$1 + 20) >> 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1248$1 + 20);
	label$4865:;
}

void _ZN3CPU17FNOPCODE_PHA_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1249$1;
	label$4866:;
	TMP$1249$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1249$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1249$1 + 3) + -1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1249$1 + 3))) = *(ubyte*)TMP$1249$1;
	label$4867:;
}

void _ZN3CPU17FNOPCODE_EOR_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1250$1;
	label$4868:;
	TMP$1250$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1250$1 + 6);
	*(ushort*)((ubyte*)TMP$1250$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1250$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1250$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1250$1);
	*(ubyte*)TMP$1250$1 = (ubyte)*(ulong*)((ubyte*)TMP$1250$1 + 20);
	label$4869:;
}

void _ZN3CPU17FNOPCODE_LSRA_ACCEv( void )
{
	struct CPU$CPUCORE* TMP$1251$1;
	label$4870:;
	TMP$1251$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1251$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1251$1 >> 1);
	*(ulong*)((ubyte*)TMP$1251$1 + 24) = (ulong)((uinteger)*(ubyte*)TMP$1251$1 & 1) << 8;
	*(ubyte*)TMP$1251$1 = (ubyte)*(ulong*)((ubyte*)TMP$1251$1 + 20);
	label$4871:;
}

void _ZN3CPU16FNOPCODE_JMP_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1252$1;
	label$4872:;
	TMP$1252$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1252$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1252$1 + 6));
	*(ushort*)((ubyte*)TMP$1252$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1252$1 + 6) + 2);
	*(ushort*)((ubyte*)TMP$1252$1 + 6) = (ushort)WMEMADDR$1;
	label$4873:;
}

void _ZN3CPU16FNOPCODE_EOR_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1253$1;
	label$4874:;
	TMP$1253$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1253$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1253$1 + 6));
	*(ushort*)((ubyte*)TMP$1253$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1253$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1253$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1253$1);
	*(ubyte*)TMP$1253$1 = (ubyte)*(ulong*)((ubyte*)TMP$1253$1 + 20);
	label$4875:;
}

void _ZN3CPU16FNOPCODE_LSR_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1254$1;
	label$4876:;
	TMP$1254$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1254$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1254$1 + 6));
	*(ushort*)((ubyte*)TMP$1254$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1254$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1254$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1254$1 + 24) = (*(ulong*)((ubyte*)TMP$1254$1 + 20) & 1) << 8;
	*(ulong*)((ubyte*)TMP$1254$1 + 20) = *(ulong*)((ubyte*)TMP$1254$1 + 20) >> 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1254$1 + 20);
	label$4877:;
}

void _ZN3CPU16FNOPCODE_BVC_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1255$1;
	label$4878:;
	TMP$1255$1 = &_ZN3CPU7G_TCPU$E;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1255$1 + 4) >> 6) & 1) != 0 ) goto label$4881;
	*(ushort*)((ubyte*)TMP$1255$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1255$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1255$1 + 6))) & 65535);
	label$4881:;
	*(ushort*)((ubyte*)TMP$1255$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1255$1 + 6) + 1);
	label$4879:;
}

void _ZN3CPU18FNOPCODE_EOR_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1256$1;
	label$4882:;
	TMP$1256$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1256$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1256$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1256$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1256$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1256$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1256$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1256$1);
	*(ubyte*)TMP$1256$1 = (ubyte)*(ulong*)((ubyte*)TMP$1256$1 + 20);
	label$4883:;
}

void _ZN3CPU16FNOPCODE_EOR_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1257$1;
	label$4884:;
	TMP$1257$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1257$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1257$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1257$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1257$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1257$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1257$1);
	*(ubyte*)TMP$1257$1 = (ubyte)*(ulong*)((ubyte*)TMP$1257$1 + 20);
	label$4885:;
}

void _ZN3CPU16FNOPCODE_LSR_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1258$1;
	label$4886:;
	TMP$1258$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1258$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1258$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1258$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1258$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1258$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1258$1 + 24) = (*(ulong*)((ubyte*)TMP$1258$1 + 20) & 1) << 8;
	*(ulong*)((ubyte*)TMP$1258$1 + 20) = *(ulong*)((ubyte*)TMP$1258$1 + 20) >> 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1258$1 + 20);
	label$4887:;
}

void _ZN3CPU17FNOPCODE_CLI_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1259$1;
	label$4888:;
	TMP$1259$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1259$1 + 4) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1259$1 + 4) & -5);
	label$4889:;
}

void _ZN3CPU17FNOPCODE_EOR_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1260$1;
	label$4890:;
	TMP$1260$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1260$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1260$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1260$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1260$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1260$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1260$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1260$1);
	*(ubyte*)TMP$1260$1 = (ubyte)*(ulong*)((ubyte*)TMP$1260$1 + 20);
	label$4891:;
}

void _ZN3CPU17FNOPCODE_EOR_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1261$1;
	label$4892:;
	TMP$1261$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1261$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1261$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1261$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1261$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1261$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1261$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) ^ (uinteger)*(ubyte*)TMP$1261$1);
	*(ubyte*)TMP$1261$1 = (ubyte)*(ulong*)((ubyte*)TMP$1261$1 + 20);
	label$4893:;
}

void _ZN3CPU17FNOPCODE_LSR_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1262$1;
	label$4894:;
	TMP$1262$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1262$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1262$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1262$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1262$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1262$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1262$1 + 20) = (ulong)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1262$1 + 24) = (*(ulong*)((ubyte*)TMP$1262$1 + 20) & 1) << 8;
	*(ulong*)((ubyte*)TMP$1262$1 + 20) = *(ulong*)((ubyte*)TMP$1262$1 + 20) >> 1;
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1262$1 + 20);
	label$4895:;
}

void _ZN3CPU17FNOPCODE_RTS_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1263$1;
	label$4896:;
	TMP$1263$1 = &_ZN3CPU7G_TCPU$E;
	if( (uinteger)*(ubyte*)((ubyte*)TMP$1263$1 + 3) != 255 ) goto label$4899;
	{
		fb_Color( 14, 0, 2 );
		puts( (char*)"Stack is empty!" );
		*(ubyte*)((ubyte*)TMP$1263$1 + 10) = (ubyte)1;
		goto label$4897;
	}
	label$4899:;
	label$4898:;
	*(ushort*)((ubyte*)TMP$1263$1 + 6) = (ushort)((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1263$1 + 3))) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1263$1 + 3)))) + 1);
	*(ubyte*)((ubyte*)TMP$1263$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1263$1 + 3) + 2);
	label$4897:;
}

void _ZN3CPU18FNOPCODE_ADC_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1265$1;
	label$4900:;
	TMP$1265$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1265$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1265$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1265$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1265$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1265$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1265$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1265$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1265$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1265$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1265$1 = (ubyte)*(ulong*)((ubyte*)TMP$1265$1 + 20);
	*(ulong*)((ubyte*)TMP$1265$1 + 24) = *(ulong*)((ubyte*)TMP$1265$1 + 20);
	*(ulong*)((ubyte*)TMP$1265$1 + 28) = *(ulong*)((ubyte*)TMP$1265$1 + 20);
	label$4901:;
}

void _ZN3CPU15FNOPCODE_ADC_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1266$1;
	label$4902:;
	TMP$1266$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1266$1 + 6));
	*(ushort*)((ubyte*)TMP$1266$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1266$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1266$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1266$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1266$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1266$1 = (ubyte)*(ulong*)((ubyte*)TMP$1266$1 + 20);
	*(ulong*)((ubyte*)TMP$1266$1 + 24) = *(ulong*)((ubyte*)TMP$1266$1 + 20);
	*(ulong*)((ubyte*)TMP$1266$1 + 28) = *(ulong*)((ubyte*)TMP$1266$1 + 20);
	label$4903:;
}

void _ZN3CPU15FNOPCODE_ROR_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1267$1;
	label$4904:;
	TMP$1267$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1267$1 + 6));
	*(ushort*)((ubyte*)TMP$1267$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1267$1 + 6) + 1);
	ubyte SRC$1;
	SRC$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1267$1 + 20) = (ulong)(uinteger)(((uinteger)SRC$1 >> 1) | (((*(ulong*)((ubyte*)TMP$1267$1 + 24) >> 8) & 1) << 7));
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1267$1 + 20);
	*(ulong*)((ubyte*)TMP$1267$1 + 24) = (ulong)((uinteger)SRC$1 & 1) << 8;
	label$4905:;
}

void _ZN3CPU17FNOPCODE_PLA_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1268$1;
	label$4906:;
	TMP$1268$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)TMP$1268$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(256 + (uinteger)*(ubyte*)((ubyte*)TMP$1268$1 + 3)));
	*(ubyte*)((ubyte*)TMP$1268$1 + 3) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1268$1 + 3) + 1);
	label$4907:;
}

void _ZN3CPU17FNOPCODE_ADC_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1269$1;
	label$4908:;
	TMP$1269$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1269$1 + 6);
	*(ushort*)((ubyte*)TMP$1269$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1269$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1269$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1269$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1269$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1269$1 = (ubyte)*(ulong*)((ubyte*)TMP$1269$1 + 20);
	*(ulong*)((ubyte*)TMP$1269$1 + 24) = *(ulong*)((ubyte*)TMP$1269$1 + 20);
	*(ulong*)((ubyte*)TMP$1269$1 + 28) = *(ulong*)((ubyte*)TMP$1269$1 + 20);
	label$4909:;
}

void _ZN3CPU17FNOPCODE_RORA_ACCEv( void )
{
	struct CPU$CPUCORE* TMP$1270$1;
	label$4910:;
	TMP$1270$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1270$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1270$1 >> 1) | (((*(ulong*)((ubyte*)TMP$1270$1 + 24) >> 8) & 1) << 7));
	*(ulong*)((ubyte*)TMP$1270$1 + 24) = (ulong)((uinteger)*(ubyte*)TMP$1270$1 & 1) << 8;
	*(ubyte*)TMP$1270$1 = (ubyte)*(ulong*)((ubyte*)TMP$1270$1 + 20);
	label$4911:;
}

void _ZN3CPU18FNOPCODE_JMP_IND16Ev( void )
{
	struct CPU$CPUCORE* TMP$1271$1;
	label$4912:;
	TMP$1271$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1271$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1271$1 + 6)));
	*(ushort*)((ubyte*)TMP$1271$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1271$1 + 6) + 2);
	*(ushort*)((ubyte*)TMP$1271$1 + 6) = (ushort)WMEMADDR$1;
	label$4913:;
}

void _ZN3CPU16FNOPCODE_ADC_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1272$1;
	label$4914:;
	TMP$1272$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1272$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1272$1 + 6));
	*(ushort*)((ubyte*)TMP$1272$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1272$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1272$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1272$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1272$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1272$1 = (ubyte)*(ulong*)((ubyte*)TMP$1272$1 + 20);
	*(ulong*)((ubyte*)TMP$1272$1 + 24) = *(ulong*)((ubyte*)TMP$1272$1 + 20);
	*(ulong*)((ubyte*)TMP$1272$1 + 28) = *(ulong*)((ubyte*)TMP$1272$1 + 20);
	label$4915:;
}

void _ZN3CPU16FNOPCODE_ROR_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1273$1;
	label$4916:;
	TMP$1273$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1273$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1273$1 + 6));
	*(ushort*)((ubyte*)TMP$1273$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1273$1 + 6) + 2);
	ubyte SRC$1;
	SRC$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1273$1 + 20) = (ulong)(uinteger)(((uinteger)SRC$1 >> 1) | (((*(ulong*)((ubyte*)TMP$1273$1 + 24) >> 8) & 1) << 7));
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1273$1 + 20);
	*(ulong*)((ubyte*)TMP$1273$1 + 24) = (ulong)((uinteger)SRC$1 & 1) << 8;
	label$4917:;
}

void _ZN3CPU16FNOPCODE_BVS_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1274$1;
	label$4918:;
	TMP$1274$1 = &_ZN3CPU7G_TCPU$E;
	if( (((uinteger)*(ubyte*)((ubyte*)TMP$1274$1 + 4) >> 6) & 1) == 0u ) goto label$4921;
	*(ushort*)((ubyte*)TMP$1274$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1274$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1274$1 + 6))) & 65535);
	label$4921:;
	*(ushort*)((ubyte*)TMP$1274$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1274$1 + 6) + 1);
	label$4919:;
}

void _ZN3CPU18FNOPCODE_ADC_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1275$1;
	label$4922:;
	TMP$1275$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1275$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1275$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1275$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1275$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1275$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1275$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1275$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1275$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1275$1 = (ubyte)*(ulong*)((ubyte*)TMP$1275$1 + 20);
	*(ulong*)((ubyte*)TMP$1275$1 + 24) = *(ulong*)((ubyte*)TMP$1275$1 + 20);
	*(ulong*)((ubyte*)TMP$1275$1 + 28) = *(ulong*)((ubyte*)TMP$1275$1 + 20);
	label$4923:;
}

void _ZN3CPU16FNOPCODE_ADC_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1276$1;
	label$4924:;
	TMP$1276$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1276$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1276$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1276$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1276$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1276$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1276$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1276$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1276$1 = (ubyte)*(ulong*)((ubyte*)TMP$1276$1 + 20);
	*(ulong*)((ubyte*)TMP$1276$1 + 24) = *(ulong*)((ubyte*)TMP$1276$1 + 20);
	*(ulong*)((ubyte*)TMP$1276$1 + 28) = *(ulong*)((ubyte*)TMP$1276$1 + 20);
	label$4925:;
}

void _ZN3CPU16FNOPCODE_ROR_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1277$1;
	label$4926:;
	TMP$1277$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1277$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1277$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1277$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1277$1 + 6) + 1);
	ubyte SRC$1;
	SRC$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1277$1 + 20) = (ulong)(uinteger)(((uinteger)SRC$1 >> 1) | (((*(ulong*)((ubyte*)TMP$1277$1 + 24) >> 8) & 1) << 7));
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1277$1 + 20);
	*(ulong*)((ubyte*)TMP$1277$1 + 24) = (ulong)((uinteger)SRC$1 & 1) << 8;
	label$4927:;
}

void _ZN3CPU17FNOPCODE_SEI_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1278$1;
	label$4928:;
	TMP$1278$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1278$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1278$1 + 4) & -5) | 4u);
	label$4929:;
}

void _ZN3CPU17FNOPCODE_ADC_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1279$1;
	label$4930:;
	TMP$1279$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1279$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1279$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1279$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1279$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1279$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1279$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1279$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1279$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1279$1 = (ubyte)*(ulong*)((ubyte*)TMP$1279$1 + 20);
	*(ulong*)((ubyte*)TMP$1279$1 + 24) = *(ulong*)((ubyte*)TMP$1279$1 + 20);
	*(ulong*)((ubyte*)TMP$1279$1 + 28) = *(ulong*)((ubyte*)TMP$1279$1 + 20);
	label$4931:;
}

void _ZN3CPU17FNOPCODE_ADC_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1280$1;
	label$4932:;
	TMP$1280$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1280$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1280$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1280$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1280$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1280$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1280$1 + 20) = (ulong)(uinteger)(((uinteger)*(ubyte*)TMP$1280$1 + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) + ((*(ulong*)((ubyte*)TMP$1280$1 + 24) >> 8) & 1));
	*(ubyte*)TMP$1280$1 = (ubyte)*(ulong*)((ubyte*)TMP$1280$1 + 20);
	*(ulong*)((ubyte*)TMP$1280$1 + 24) = *(ulong*)((ubyte*)TMP$1280$1 + 20);
	*(ulong*)((ubyte*)TMP$1280$1 + 28) = *(ulong*)((ubyte*)TMP$1280$1 + 20);
	label$4933:;
}

void _ZN3CPU17FNOPCODE_ROR_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1281$1;
	label$4934:;
	TMP$1281$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1281$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1281$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1281$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1281$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1281$1 + 6) + 2);
	ubyte SRC$1;
	SRC$1 = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1);
	*(ulong*)((ubyte*)TMP$1281$1 + 20) = (ulong)(uinteger)(((uinteger)SRC$1 >> 1) | (((*(ulong*)((ubyte*)TMP$1281$1 + 24) >> 8) & 1) << 7));
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1281$1 + 20);
	*(ulong*)((ubyte*)TMP$1281$1 + 24) = (ulong)((uinteger)SRC$1 & 1) << 8;
	label$4935:;
}

void _ZN3CPU18FNOPCODE_STA_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1282$1;
	label$4936:;
	TMP$1282$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1282$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1282$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1282$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1282$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1282$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1282$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1282$1 );
	label$4937:;
}

void _ZN3CPU15FNOPCODE_STY_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1283$1;
	label$4938:;
	TMP$1283$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1283$1 + 6));
	*(ushort*)((ubyte*)TMP$1283$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1283$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1283$1 + 2) );
	label$4939:;
}

void _ZN3CPU15FNOPCODE_STA_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1284$1;
	label$4940:;
	TMP$1284$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1284$1 + 6));
	*(ushort*)((ubyte*)TMP$1284$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1284$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1284$1 );
	label$4941:;
}

void _ZN3CPU15FNOPCODE_STX_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1285$1;
	label$4942:;
	TMP$1285$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1285$1 + 6));
	*(ushort*)((ubyte*)TMP$1285$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1285$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1285$1 + 1) );
	label$4943:;
}

void _ZN3CPU17FNOPCODE_DEY_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1286$1;
	label$4944:;
	TMP$1286$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1286$1 + 2) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1286$1 + 2) + -1);
	*(ulong*)((ubyte*)TMP$1286$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1286$1 + 2);
	label$4945:;
}

void _ZN3CPU17FNOPCODE_TXA_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1287$1;
	label$4946:;
	TMP$1287$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1287$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1287$1 + 1);
	*(ubyte*)TMP$1287$1 = *(ubyte*)((ubyte*)TMP$1287$1 + 1);
	label$4947:;
}

void _ZN3CPU16FNOPCODE_STY_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1288$1;
	label$4948:;
	TMP$1288$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1288$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1288$1 + 6));
	*(ushort*)((ubyte*)TMP$1288$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1288$1 + 6) + 2);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1288$1 + 2) );
	label$4949:;
}

void _ZN3CPU16FNOPCODE_STA_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1289$1;
	label$4950:;
	TMP$1289$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1289$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1289$1 + 6));
	*(ushort*)((ubyte*)TMP$1289$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1289$1 + 6) + 2);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1289$1 );
	label$4951:;
}

void _ZN3CPU16FNOPCODE_STX_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1290$1;
	label$4952:;
	TMP$1290$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1290$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1290$1 + 6));
	*(ushort*)((ubyte*)TMP$1290$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1290$1 + 6) + 2);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1290$1 + 1) );
	label$4953:;
}

void _ZN3CPU16FNOPCODE_BCC_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1291$1;
	label$4954:;
	TMP$1291$1 = &_ZN3CPU7G_TCPU$E;
	if( *(ulong*)((ubyte*)TMP$1291$1 + 24) > 255 ) goto label$4957;
	*(ushort*)((ubyte*)TMP$1291$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1291$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1291$1 + 6))) & 65535);
	label$4957:;
	*(ushort*)((ubyte*)TMP$1291$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1291$1 + 6) + 1);
	label$4955:;
}

void _ZN3CPU18FNOPCODE_STA_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1292$1;
	label$4958:;
	TMP$1292$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1292$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1292$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1292$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1292$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1292$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1292$1 );
	label$4959:;
}

void _ZN3CPU16FNOPCODE_STY_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1293$1;
	label$4960:;
	TMP$1293$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1293$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1293$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1293$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1293$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1293$1 + 2) );
	label$4961:;
}

void _ZN3CPU16FNOPCODE_STA_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1294$1;
	label$4962:;
	TMP$1294$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1294$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1294$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1294$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1294$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1294$1 );
	label$4963:;
}

void _ZN3CPU16FNOPCODE_STX_I8YEv( void )
{
	struct CPU$CPUCORE* TMP$1295$1;
	label$4964:;
	TMP$1295$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1295$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1295$1 + 2)) & 255);
	*(ushort*)((ubyte*)TMP$1295$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1295$1 + 6) + 1);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)((ubyte*)TMP$1295$1 + 1) );
	label$4965:;
}

void _ZN3CPU17FNOPCODE_TYA_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1296$1;
	label$4966:;
	TMP$1296$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1296$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1296$1 + 2);
	*(ubyte*)TMP$1296$1 = *(ubyte*)((ubyte*)TMP$1296$1 + 2);
	label$4967:;
}

void _ZN3CPU17FNOPCODE_STA_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1297$1;
	label$4968:;
	TMP$1297$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1297$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1297$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1297$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1297$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1297$1 + 6) + 2);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1297$1 );
	label$4969:;
}

void _ZN3CPU17FNOPCODE_TXS_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1298$1;
	label$4970:;
	TMP$1298$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1298$1 + 3) = *(ubyte*)((ubyte*)TMP$1298$1 + 1);
	label$4971:;
}

void _ZN3CPU17FNOPCODE_STA_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1299$1;
	label$4972:;
	TMP$1299$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1299$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1299$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1299$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1299$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1299$1 + 6) + 2);
	_ZN3CPU9WRITEBYTEElh( WMEMADDR$1, *(ubyte*)TMP$1299$1 );
	label$4973:;
}

void _ZN3CPU17FNOPCODE_LDY_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1300$1;
	label$4974:;
	TMP$1300$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1300$1 + 6);
	*(ushort*)((ubyte*)TMP$1300$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1300$1 + 6) + 1);
	ubyte vr$9491 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1300$1 + 20) = (ulong)vr$9491;
	*(ubyte*)((ubyte*)TMP$1300$1 + 2) = (ubyte)*(ulong*)((ubyte*)TMP$1300$1 + 20);
	label$4975:;
}

void _ZN3CPU18FNOPCODE_LDA_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1301$1;
	label$4976:;
	TMP$1301$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1301$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1301$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1301$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1301$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1301$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1301$1 + 6) + 1);
	ubyte vr$9521 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1301$1 + 20) = (ulong)vr$9521;
	*(ubyte*)TMP$1301$1 = (ubyte)*(ulong*)((ubyte*)TMP$1301$1 + 20);
	label$4977:;
}

void _ZN3CPU17FNOPCODE_LDX_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1302$1;
	label$4978:;
	TMP$1302$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1302$1 + 6);
	*(ushort*)((ubyte*)TMP$1302$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1302$1 + 6) + 1);
	ubyte vr$9534 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1302$1 + 20) = (ulong)vr$9534;
	*(ubyte*)((ubyte*)TMP$1302$1 + 1) = (ubyte)*(ulong*)((ubyte*)TMP$1302$1 + 20);
	label$4979:;
}

void _ZN3CPU15FNOPCODE_LDY_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1303$1;
	label$4980:;
	TMP$1303$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1303$1 + 6));
	*(ushort*)((ubyte*)TMP$1303$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1303$1 + 6) + 1);
	ubyte vr$9548 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1303$1 + 20) = (ulong)vr$9548;
	*(ubyte*)((ubyte*)TMP$1303$1 + 2) = (ubyte)*(ulong*)((ubyte*)TMP$1303$1 + 20);
	label$4981:;
}

void _ZN3CPU15FNOPCODE_LDA_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1304$1;
	label$4982:;
	TMP$1304$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1304$1 + 6));
	*(ushort*)((ubyte*)TMP$1304$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1304$1 + 6) + 1);
	ubyte vr$9562 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1304$1 + 20) = (ulong)vr$9562;
	*(ubyte*)TMP$1304$1 = (ubyte)*(ulong*)((ubyte*)TMP$1304$1 + 20);
	label$4983:;
}

void _ZN3CPU15FNOPCODE_LDX_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1305$1;
	label$4984:;
	TMP$1305$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1305$1 + 6));
	*(ushort*)((ubyte*)TMP$1305$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1305$1 + 6) + 1);
	ubyte vr$9576 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1305$1 + 20) = (ulong)vr$9576;
	*(ubyte*)((ubyte*)TMP$1305$1 + 1) = (ubyte)*(ulong*)((ubyte*)TMP$1305$1 + 20);
	label$4985:;
}

void _ZN3CPU17FNOPCODE_TAY_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1306$1;
	label$4986:;
	TMP$1306$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1306$1 + 20) = (ulong)*(ubyte*)TMP$1306$1;
	*(ubyte*)((ubyte*)TMP$1306$1 + 2) = *(ubyte*)TMP$1306$1;
	label$4987:;
}

void _ZN3CPU17FNOPCODE_LDA_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1307$1;
	label$4988:;
	TMP$1307$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1307$1 + 6);
	*(ushort*)((ubyte*)TMP$1307$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1307$1 + 6) + 1);
	ubyte vr$9594 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1307$1 + 20) = (ulong)vr$9594;
	*(ubyte*)TMP$1307$1 = (ubyte)*(ulong*)((ubyte*)TMP$1307$1 + 20);
	label$4989:;
}

void _ZN3CPU17FNOPCODE_TAX_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1308$1;
	label$4990:;
	TMP$1308$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1308$1 + 20) = (ulong)*(ubyte*)TMP$1308$1;
	*(ubyte*)((ubyte*)TMP$1308$1 + 1) = *(ubyte*)TMP$1308$1;
	label$4991:;
}

void _ZN3CPU16FNOPCODE_LDY_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1309$1;
	label$4992:;
	TMP$1309$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1309$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1309$1 + 6));
	*(ushort*)((ubyte*)TMP$1309$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1309$1 + 6) + 2);
	ubyte vr$9618 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1309$1 + 20) = (ulong)vr$9618;
	*(ubyte*)((ubyte*)TMP$1309$1 + 2) = (ubyte)*(ulong*)((ubyte*)TMP$1309$1 + 20);
	label$4993:;
}

void _ZN3CPU16FNOPCODE_LDA_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1310$1;
	label$4994:;
	TMP$1310$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1310$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1310$1 + 6));
	*(ushort*)((ubyte*)TMP$1310$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1310$1 + 6) + 2);
	ubyte vr$9637 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1310$1 + 20) = (ulong)vr$9637;
	*(ubyte*)TMP$1310$1 = (ubyte)*(ulong*)((ubyte*)TMP$1310$1 + 20);
	label$4995:;
}

void _ZN3CPU16FNOPCODE_LDX_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1311$1;
	label$4996:;
	TMP$1311$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1311$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1311$1 + 6));
	*(ushort*)((ubyte*)TMP$1311$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1311$1 + 6) + 2);
	ubyte vr$9656 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1311$1 + 20) = (ulong)vr$9656;
	*(ubyte*)((ubyte*)TMP$1311$1 + 1) = (ubyte)*(ulong*)((ubyte*)TMP$1311$1 + 20);
	label$4997:;
}

void _ZN3CPU16FNOPCODE_BCS_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1312$1;
	label$4998:;
	TMP$1312$1 = &_ZN3CPU7G_TCPU$E;
	if( *(ulong*)((ubyte*)TMP$1312$1 + 24) <= 255 ) goto label$5001;
	*(ushort*)((ubyte*)TMP$1312$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1312$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1312$1 + 6))) & 65535);
	label$5001:;
	*(ushort*)((ubyte*)TMP$1312$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1312$1 + 6) + 1);
	label$4999:;
}

void _ZN3CPU18FNOPCODE_LDA_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1313$1;
	label$5002:;
	TMP$1313$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1313$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1313$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1313$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1313$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1313$1 + 6) + 1);
	ubyte vr$9697 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1313$1 + 20) = (ulong)vr$9697;
	*(ubyte*)TMP$1313$1 = (ubyte)*(ulong*)((ubyte*)TMP$1313$1 + 20);
	label$5003:;
}

void _ZN3CPU16FNOPCODE_LDY_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1314$1;
	label$5004:;
	TMP$1314$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1314$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1314$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1314$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1314$1 + 6) + 1);
	ubyte vr$9715 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1314$1 + 20) = (ulong)vr$9715;
	*(ubyte*)((ubyte*)TMP$1314$1 + 2) = (ubyte)*(ulong*)((ubyte*)TMP$1314$1 + 20);
	label$5005:;
}

void _ZN3CPU16FNOPCODE_LDA_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1315$1;
	label$5006:;
	TMP$1315$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1315$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1315$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1315$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1315$1 + 6) + 1);
	ubyte vr$9733 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1315$1 + 20) = (ulong)vr$9733;
	*(ubyte*)TMP$1315$1 = (ubyte)*(ulong*)((ubyte*)TMP$1315$1 + 20);
	label$5007:;
}

void _ZN3CPU16FNOPCODE_LDX_I8YEv( void )
{
	struct CPU$CPUCORE* TMP$1316$1;
	label$5008:;
	TMP$1316$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1316$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1316$1 + 2)) & 255);
	*(ushort*)((ubyte*)TMP$1316$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1316$1 + 6) + 1);
	ubyte vr$9751 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1316$1 + 20) = (ulong)vr$9751;
	*(ubyte*)((ubyte*)TMP$1316$1 + 1) = (ubyte)*(ulong*)((ubyte*)TMP$1316$1 + 20);
	label$5009:;
}

void _ZN3CPU17FNOPCODE_CLV_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1317$1;
	label$5010:;
	TMP$1317$1 = &_ZN3CPU7G_TCPU$E;
	*(ulong*)((ubyte*)TMP$1317$1 + 28) = 0u;
	label$5011:;
}

void _ZN3CPU17FNOPCODE_LDA_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1318$1;
	label$5012:;
	TMP$1318$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1318$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1318$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1318$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1318$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1318$1 + 6) + 2);
	ubyte vr$9775 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1318$1 + 20) = (ulong)vr$9775;
	*(ubyte*)TMP$1318$1 = (ubyte)*(ulong*)((ubyte*)TMP$1318$1 + 20);
	label$5013:;
}

void _ZN3CPU17FNOPCODE_TSX_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1319$1;
	label$5014:;
	TMP$1319$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1319$1 + 1) = *(ubyte*)((ubyte*)TMP$1319$1 + 3);
	label$5015:;
}

void _ZN3CPU17FNOPCODE_LDY_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1320$1;
	label$5016:;
	TMP$1320$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1320$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1320$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1320$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1320$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1320$1 + 6) + 2);
	ubyte vr$9800 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1320$1 + 20) = (ulong)vr$9800;
	*(ubyte*)((ubyte*)TMP$1320$1 + 2) = (ubyte)*(ulong*)((ubyte*)TMP$1320$1 + 20);
	label$5017:;
}

void _ZN3CPU17FNOPCODE_LDA_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1321$1;
	label$5018:;
	TMP$1321$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1321$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1321$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1321$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1321$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1321$1 + 6) + 2);
	ubyte vr$9823 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1321$1 + 20) = (ulong)vr$9823;
	*(ubyte*)TMP$1321$1 = (ubyte)*(ulong*)((ubyte*)TMP$1321$1 + 20);
	label$5019:;
}

void _ZN3CPU17FNOPCODE_LDX_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1322$1;
	label$5020:;
	TMP$1322$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1322$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1322$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1322$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1322$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1322$1 + 6) + 2);
	ubyte vr$9846 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1322$1 + 20) = (ulong)vr$9846;
	*(ubyte*)((ubyte*)TMP$1322$1 + 1) = (ubyte)*(ulong*)((ubyte*)TMP$1322$1 + 20);
	label$5021:;
}

void _ZN3CPU17FNOPCODE_CPY_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1323$1;
	label$5022:;
	TMP$1323$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1323$1 + 6);
	*(ushort*)((ubyte*)TMP$1323$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1323$1 + 6) + 1);
	ubyte vr$9861 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1323$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1323$1 + 2) - (uinteger)vr$9861);
	*(ulong*)((ubyte*)TMP$1323$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1323$1 + 20));
	label$5023:;
}

void _ZN3CPU18FNOPCODE_CMP_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1324$1;
	label$5024:;
	TMP$1324$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1324$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1324$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1324$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1324$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1324$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1324$1 + 6) + 1);
	ubyte vr$9894 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1324$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1324$1 - (uinteger)vr$9894);
	*(ulong*)((ubyte*)TMP$1324$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1324$1 + 20));
	label$5025:;
}

void _ZN3CPU15FNOPCODE_CPY_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1325$1;
	label$5026:;
	TMP$1325$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1325$1 + 6));
	*(ushort*)((ubyte*)TMP$1325$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1325$1 + 6) + 1);
	ubyte vr$9911 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1325$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1325$1 + 2) - (uinteger)vr$9911);
	*(ulong*)((ubyte*)TMP$1325$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1325$1 + 20));
	label$5027:;
}

void _ZN3CPU15FNOPCODE_CMP_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1326$1;
	label$5028:;
	TMP$1326$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1326$1 + 6));
	*(ushort*)((ubyte*)TMP$1326$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1326$1 + 6) + 1);
	ubyte vr$9928 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1326$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1326$1 - (uinteger)vr$9928);
	*(ulong*)((ubyte*)TMP$1326$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1326$1 + 20));
	label$5029:;
}

void _ZN3CPU15FNOPCODE_DEC_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1327$1;
	label$5030:;
	TMP$1327$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1327$1 + 6));
	*(ushort*)((ubyte*)TMP$1327$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1327$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1327$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + -1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1327$1 + 20);
	label$5031:;
}

void _ZN3CPU17FNOPCODE_INY_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1328$1;
	label$5032:;
	TMP$1328$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1328$1 + 2) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1328$1 + 2) + 1);
	*(ulong*)((ubyte*)TMP$1328$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1328$1 + 2);
	label$5033:;
}

void _ZN3CPU17FNOPCODE_CMP_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1329$1;
	label$5034:;
	TMP$1329$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1329$1 + 6);
	*(ushort*)((ubyte*)TMP$1329$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1329$1 + 6) + 1);
	ubyte vr$9965 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1329$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1329$1 - (uinteger)vr$9965);
	*(ulong*)((ubyte*)TMP$1329$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1329$1 + 20));
	label$5035:;
}

void _ZN3CPU17FNOPCODE_DEX_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1330$1;
	label$5036:;
	TMP$1330$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1330$1 + 1) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1330$1 + 1) + -1);
	*(ulong*)((ubyte*)TMP$1330$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1330$1 + 1);
	label$5037:;
}

void _ZN3CPU16FNOPCODE_CPY_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1331$1;
	label$5038:;
	TMP$1331$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1331$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1331$1 + 6));
	*(ushort*)((ubyte*)TMP$1331$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1331$1 + 6) + 2);
	ubyte vr$9995 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1331$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1331$1 + 2) - (uinteger)vr$9995);
	*(ulong*)((ubyte*)TMP$1331$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1331$1 + 20));
	label$5039:;
}

void _ZN3CPU16FNOPCODE_CMP_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1332$1;
	label$5040:;
	TMP$1332$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1332$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1332$1 + 6));
	*(ushort*)((ubyte*)TMP$1332$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1332$1 + 6) + 2);
	ubyte vr$10017 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1332$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1332$1 - (uinteger)vr$10017);
	*(ulong*)((ubyte*)TMP$1332$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1332$1 + 20));
	label$5041:;
}

void _ZN3CPU16FNOPCODE_DEC_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1333$1;
	label$5042:;
	TMP$1333$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1333$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1333$1 + 6));
	*(ushort*)((ubyte*)TMP$1333$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1333$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1333$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + -1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1333$1 + 20);
	label$5043:;
}

void _ZN3CPU16FNOPCODE_BNE_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1334$1;
	label$5044:;
	TMP$1334$1 = &_ZN3CPU7G_TCPU$E;
	if( (*(ulong*)((ubyte*)TMP$1334$1 + 20) & 255) == 0u ) goto label$5047;
	*(ushort*)((ubyte*)TMP$1334$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1334$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1334$1 + 6))) & 65535);
	label$5047:;
	*(ushort*)((ubyte*)TMP$1334$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1334$1 + 6) + 1);
	label$5045:;
}

void _ZN3CPU18FNOPCODE_CMP_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1335$1;
	label$5048:;
	TMP$1335$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1335$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1335$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1335$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1335$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1335$1 + 6) + 1);
	ubyte vr$10080 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1335$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1335$1 - (uinteger)vr$10080);
	*(ulong*)((ubyte*)TMP$1335$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1335$1 + 20));
	label$5049:;
}

void _ZN3CPU16FNOPCODE_CMP_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1336$1;
	label$5050:;
	TMP$1336$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1336$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1336$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1336$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1336$1 + 6) + 1);
	ubyte vr$10101 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1336$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1336$1 - (uinteger)vr$10101);
	*(ulong*)((ubyte*)TMP$1336$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1336$1 + 20));
	label$5051:;
}

void _ZN3CPU16FNOPCODE_DEC_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1337$1;
	label$5052:;
	TMP$1337$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1337$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1337$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1337$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1337$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1337$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + -1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1337$1 + 20);
	label$5053:;
}

void _ZN3CPU17FNOPCODE_CLD_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1338$1;
	label$5054:;
	TMP$1338$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1338$1 + 4) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1338$1 + 4) & -9);
	label$5055:;
}

void _ZN3CPU17FNOPCODE_CMP_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1339$1;
	label$5056:;
	TMP$1339$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1339$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1339$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1339$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1339$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1339$1 + 6) + 2);
	ubyte vr$10148 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1339$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1339$1 - (uinteger)vr$10148);
	*(ulong*)((ubyte*)TMP$1339$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1339$1 + 20));
	label$5057:;
}

void _ZN3CPU17FNOPCODE_CMP_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1340$1;
	label$5058:;
	TMP$1340$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1340$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1340$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1340$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1340$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1340$1 + 6) + 2);
	ubyte vr$10174 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1340$1 + 20) = (ulong)((uinteger)*(ubyte*)TMP$1340$1 - (uinteger)vr$10174);
	*(ulong*)((ubyte*)TMP$1340$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1340$1 + 20));
	label$5059:;
}

void _ZN3CPU17FNOPCODE_DEC_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1341$1;
	label$5060:;
	TMP$1341$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1341$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1341$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1341$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1341$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1341$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1341$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + -1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1341$1 + 20);
	label$5061:;
}

void _ZN3CPU17FNOPCODE_CPX_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1342$1;
	label$5062:;
	TMP$1342$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1342$1 + 6);
	*(ushort*)((ubyte*)TMP$1342$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1342$1 + 6) + 1);
	ubyte vr$10212 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1342$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1342$1 + 1) - (uinteger)vr$10212);
	*(ulong*)((ubyte*)TMP$1342$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1342$1 + 20));
	label$5063:;
}

void _ZN3CPU18FNOPCODE_SBC_IND8XEv( void )
{
	struct CPU$CPUCORE* TMP$1343$1;
	label$5064:;
	TMP$1343$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1343$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1343$1 + 1)) & 255) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1343$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1343$1 + 1)) & 255));
	*(ushort*)((ubyte*)TMP$1343$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1343$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1343$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1343$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1343$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1343$1 = (ubyte)*(ulong*)((ubyte*)TMP$1343$1 + 20);
	*(ulong*)((ubyte*)TMP$1343$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1343$1 + 20));
	*(ulong*)((ubyte*)TMP$1343$1 + 28) = *(ulong*)((ubyte*)TMP$1343$1 + 20);
	label$5065:;
}

void _ZN3CPU15FNOPCODE_CPX_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1344$1;
	label$5066:;
	TMP$1344$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1344$1 + 6));
	*(ushort*)((ubyte*)TMP$1344$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1344$1 + 6) + 1);
	ubyte vr$10271 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1344$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1344$1 + 1) - (uinteger)vr$10271);
	*(ulong*)((ubyte*)TMP$1344$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1344$1 + 20));
	label$5067:;
}

void _ZN3CPU15FNOPCODE_SBC_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1345$1;
	label$5068:;
	TMP$1345$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1345$1 + 6));
	*(ushort*)((ubyte*)TMP$1345$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1345$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1345$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1345$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1345$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1345$1 = (ubyte)*(ulong*)((ubyte*)TMP$1345$1 + 20);
	*(ulong*)((ubyte*)TMP$1345$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1345$1 + 20));
	*(ulong*)((ubyte*)TMP$1345$1 + 28) = *(ulong*)((ubyte*)TMP$1345$1 + 20);
	label$5069:;
}

void _ZN3CPU15FNOPCODE_INC_Z8Ev( void )
{
	struct CPU$CPUCORE* TMP$1346$1;
	label$5070:;
	TMP$1346$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1346$1 + 6));
	*(ushort*)((ubyte*)TMP$1346$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1346$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1346$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1346$1 + 20);
	label$5071:;
}

void _ZN3CPU17FNOPCODE_INX_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1347$1;
	label$5072:;
	TMP$1347$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1347$1 + 1) = (ubyte)((uinteger)*(ubyte*)((ubyte*)TMP$1347$1 + 1) + 1);
	*(ulong*)((ubyte*)TMP$1347$1 + 20) = (ulong)*(ubyte*)((ubyte*)TMP$1347$1 + 1);
	label$5073:;
}

void _ZN3CPU17FNOPCODE_SBC_IMM8Ev( void )
{
	struct CPU$CPUCORE* TMP$1348$1;
	label$5074:;
	TMP$1348$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)*(ushort*)((ubyte*)TMP$1348$1 + 6);
	*(ushort*)((ubyte*)TMP$1348$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1348$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1348$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1348$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1348$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1348$1 = (ubyte)*(ulong*)((ubyte*)TMP$1348$1 + 20);
	*(ulong*)((ubyte*)TMP$1348$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1348$1 + 20));
	*(ulong*)((ubyte*)TMP$1348$1 + 28) = *(ulong*)((ubyte*)TMP$1348$1 + 20);
	label$5075:;
}

void _ZN3CPU17FNOPCODE_NOP_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1349$1;
	label$5076:;
	TMP$1349$1 = &_ZN3CPU7G_TCPU$E;
	label$5077:;
}

void _ZN3CPU16FNOPCODE_CPX_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1350$1;
	label$5078:;
	TMP$1350$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1350$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1350$1 + 6));
	*(ushort*)((ubyte*)TMP$1350$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1350$1 + 6) + 2);
	ubyte vr$10365 = _ZN3CPU8READBYTEEl( WMEMADDR$1 );
	*(ulong*)((ubyte*)TMP$1350$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)TMP$1350$1 + 1) - (uinteger)vr$10365);
	*(ulong*)((ubyte*)TMP$1350$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1350$1 + 20));
	label$5079:;
}

void _ZN3CPU16FNOPCODE_SBC_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1351$1;
	label$5080:;
	TMP$1351$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1351$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1351$1 + 6));
	*(ushort*)((ubyte*)TMP$1351$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1351$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1351$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1351$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1351$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1351$1 = (ubyte)*(ulong*)((ubyte*)TMP$1351$1 + 20);
	*(ulong*)((ubyte*)TMP$1351$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1351$1 + 20));
	*(ulong*)((ubyte*)TMP$1351$1 + 28) = *(ulong*)((ubyte*)TMP$1351$1 + 20);
	label$5081:;
}

void _ZN3CPU16FNOPCODE_INC_A16Ev( void )
{
	struct CPU$CPUCORE* TMP$1352$1;
	label$5082:;
	TMP$1352$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = ((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1352$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1352$1 + 6));
	*(ushort*)((ubyte*)TMP$1352$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1352$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1352$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1352$1 + 20);
	label$5083:;
}

void _ZN3CPU16FNOPCODE_BEQ_R16Ev( void )
{
	struct CPU$CPUCORE* TMP$1353$1;
	label$5084:;
	TMP$1353$1 = &_ZN3CPU7G_TCPU$E;
	if( (*(ulong*)((ubyte*)TMP$1353$1 + 20) & 255) != 0 ) goto label$5087;
	*(ushort*)((ubyte*)TMP$1353$1 + 6) = (ushort)(((integer)*(ushort*)((ubyte*)TMP$1353$1 + 6) + (integer)*(byte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1353$1 + 6))) & 65535);
	label$5087:;
	*(ushort*)((ubyte*)TMP$1353$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1353$1 + 6) + 1);
	label$5085:;
}

void _ZN3CPU18FNOPCODE_SBC_IND8YEv( void )
{
	struct CPU$CPUCORE* TMP$1354$1;
	label$5088:;
	TMP$1354$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1354$1 + 6)) + 1)) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1354$1 + 6)))) + (uinteger)*(ubyte*)((ubyte*)TMP$1354$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1354$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1354$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1354$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1354$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1354$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1354$1 = (ubyte)*(ulong*)((ubyte*)TMP$1354$1 + 20);
	*(ulong*)((ubyte*)TMP$1354$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1354$1 + 20));
	*(ulong*)((ubyte*)TMP$1354$1 + 28) = *(ulong*)((ubyte*)TMP$1354$1 + 20);
	label$5089:;
}

void _ZN3CPU16FNOPCODE_SBC_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1355$1;
	label$5090:;
	TMP$1355$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1355$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1355$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1355$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1355$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1355$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1355$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1355$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1355$1 = (ubyte)*(ulong*)((ubyte*)TMP$1355$1 + 20);
	*(ulong*)((ubyte*)TMP$1355$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1355$1 + 20));
	*(ulong*)((ubyte*)TMP$1355$1 + 28) = *(ulong*)((ubyte*)TMP$1355$1 + 20);
	label$5091:;
}

void _ZN3CPU16FNOPCODE_INC_I8XEv( void )
{
	struct CPU$CPUCORE* TMP$1356$1;
	label$5092:;
	TMP$1356$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1356$1 + 6)) + (uinteger)*(ubyte*)((ubyte*)TMP$1356$1 + 1)) & 255);
	*(ushort*)((ubyte*)TMP$1356$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1356$1 + 6) + 1);
	*(ulong*)((ubyte*)TMP$1356$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1356$1 + 20);
	label$5093:;
}

void _ZN3CPU17FNOPCODE_SED_NONEEv( void )
{
	struct CPU$CPUCORE* TMP$1357$1;
	label$5094:;
	TMP$1357$1 = &_ZN3CPU7G_TCPU$E;
	*(ubyte*)((ubyte*)TMP$1357$1 + 4) = (ubyte)(((uinteger)*(ubyte*)((ubyte*)TMP$1357$1 + 4) & -9) | 8u);
	label$5095:;
}

void _ZN3CPU17FNOPCODE_SBC_I16YEv( void )
{
	struct CPU$CPUCORE* TMP$1358$1;
	label$5096:;
	TMP$1358$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1358$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1358$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1358$1 + 2)) & 65535);
	*(ushort*)((ubyte*)TMP$1358$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1358$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1358$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1358$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1358$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1358$1 = (ubyte)*(ulong*)((ubyte*)TMP$1358$1 + 20);
	*(ulong*)((ubyte*)TMP$1358$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1358$1 + 20));
	*(ulong*)((ubyte*)TMP$1358$1 + 28) = *(ulong*)((ubyte*)TMP$1358$1 + 20);
	label$5097:;
}

void _ZN3CPU17FNOPCODE_SBC_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1359$1;
	label$5098:;
	TMP$1359$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1359$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1359$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1359$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1359$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1359$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1359$1 + 20) = (ulong)(((uinteger)*(ubyte*)TMP$1359$1 - (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1)) - (integer)(1 - ((*(ulong*)((ubyte*)TMP$1359$1 + 24) >> 8) & 1)));
	*(ubyte*)TMP$1359$1 = (ubyte)*(ulong*)((ubyte*)TMP$1359$1 + 20);
	*(ulong*)((ubyte*)TMP$1359$1 + 24) = ~(*(ulong*)((ubyte*)TMP$1359$1 + 20));
	*(ulong*)((ubyte*)TMP$1359$1 + 28) = *(ulong*)((ubyte*)TMP$1359$1 + 20);
	label$5099:;
}

void _ZN3CPU17FNOPCODE_INC_I16XEv( void )
{
	struct CPU$CPUCORE* TMP$1360$1;
	label$5100:;
	TMP$1360$1 = &_ZN3CPU7G_TCPU$E;
	long WMEMADDR$1;
	WMEMADDR$1 = (long)(((ulong)(((long)*(ubyte*)(((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1360$1 + 6)) + 1) << 8) + (uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1360$1 + 6))) + (uinteger)*(ubyte*)((ubyte*)TMP$1360$1 + 1)) & 65535);
	*(ushort*)((ubyte*)TMP$1360$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1360$1 + 6) + 2);
	*(ulong*)((ubyte*)TMP$1360$1 + 20) = (ulong)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) + 1);
	*(ubyte*)((ubyte*)G_BMEMORY$ + (integer)WMEMADDR$1) = (ubyte)*(ulong*)((ubyte*)TMP$1360$1 + 20);
	label$5101:;
}

void DRAGWINDOW( byte BFORCE$1 )
{
	label$5102:;
	label$5103:;
}

void SHOWSTATUS( void )
{
	label$5104:;
	integer ICONW$1;
	ICONW$1 = 1572896;
	uinteger ICONH$1;
	ICONH$1 = (uinteger)ICONW$1 >> 16;
	ICONW$1 = (integer)((uinteger)ICONW$1 & 65535);
	integer IROW$1;
	integer vr$10621 = fb_GetY(  );
	IROW$1 = vr$10621;
	integer ICOL$1;
	integer vr$10622 = fb_GetX(  );
	ICOL$1 = vr$10622;
	fb_ConsoleView( 1, 24 );
	fb_Locate( (integer)ICONH$1, 1, -1, 0, 0 );
	fb_Color( 14, 1, 0 );
	if( (uinteger)*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 12) == 0u ) goto label$5107;
	{
		printf( (char*)"Asm Run Step Break Jump View   " );
	}
	goto label$5106;
	label$5107:;
	{
		printf( (char*)"Asm Run Pause View Dbg (0-9)Spd" );
	}
	label$5106:;
	fb_Color( 7, 0, 0 );
	fb_ConsoleView( 3, 13 );
	fb_Locate( IROW$1, ICOL$1, -1, 0, 0 );
	fb_Color( 7, 0, 0 );
	label$5105:;
}

void FOCUSCONSOLE( void )
{
	label$5108:;
	label$5109:;
}

long READKEY( void )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$5110:;
	string SKEY$1;
	string* vr$10625 = fb_Inkey(  );
	string* vr$10627 = fb_StrInit( (void*)&SKEY$1, -1, vr$10625, -1, 0 );
	integer vr$10629 = fb_StrLen( (void*)&SKEY$1, -1 );
	if( vr$10629 == 0 ) goto label$5113;
	{
		long IKEY$2;
		IKEY$2 = (long)*(ubyte*)*(char**)&SKEY$1;
		if( IKEY$2 != 255 ) goto label$5115;
		IKEY$2 = (long)-(uinteger)*(ubyte*)((ubyte*)*(char**)&SKEY$1 + 1);
		label$5115:;
		fb$result$1 = IKEY$2;
		fb_StrDelete( &SKEY$1 );
		goto label$5111;
	}
	label$5113:;
	label$5112:;
	fb$result$1 = 0;
	fb_StrDelete( &SKEY$1 );
	goto label$5111;
	fb_StrDelete( &SKEY$1 );
	label$5111:;
	return fb$result$1;
}

void UPDATECURRENTVIEW( byte BFORCE$1 )
{
	label$5116:;
	label$5117:;
}

void HANDLEVIEWKEYS( long IKEY$1 )
{
	label$5118:;
	label$5119:;
}

byte HANDLEKEYS( void )
{
	integer TMP$1365$1;
	integer TMP$1366$1;
	byte fb$result$1;
	__builtin_memset( &fb$result$1, 0, 1 );
	label$5120:;
	DRAGWINDOW( (byte)0 );
	static long IKEYA$1 = 100;
	static long IKEYB$1 = 115;
	static long IKEYX$1 = 119;
	static long IKEYY$1 = 97;
	static long IKEYL$1 = 113;
	static long IKEYR$1 = 101;
	static long IKEYLT$1 = -75;
	static long IKEYRT$1 = -77;
	static long IKEYUP$1 = -72;
	static long IKEYDN$1 = -80;
	if( -((uinteger)*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 12) == 0) == 0 ) goto label$5122;
	TMP$1365$1 = -(-((uinteger)*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 13) == 0) != 0);
	goto label$5230;
	label$5122:;
	TMP$1365$1 = 0;
	label$5230:;
	if( TMP$1365$1 == 0 ) goto label$5124;
	G_GFXFOCUS$ = (byte)0;
	label$5124:;
	if( -((integer)G_GFXFOCUS$ == 0) != 0 ) goto label$5125;
	integer vr$10647 = fb_Multikey( 125 );
	TMP$1366$1 = -(vr$10647 != 0);
	goto label$5231;
	label$5125:;
	TMP$1366$1 = -1;
	label$5231:;
	if( TMP$1366$1 == 0 ) goto label$5127;
	{
		struct CPU$CPUCORE* TMP$1367$2;
		TMP$1367$2 = &_ZN3CPU7G_TCPU$E;
		if( (uinteger)*(ubyte*)((ubyte*)TMP$1367$2 + 12) != 0 ) goto label$5129;
		{
			label$5130:;
			{
				integer TMP$1368$4;
				integer TMP$1369$4;
				integer TMP$1370$4;
				integer TMP$1371$4;
				integer TMP$1372$4;
				integer TMP$1373$4;
				integer TMP$1374$4;
				integer TMP$1375$4;
				integer TMP$1376$4;
				integer TMP$1377$4;
				long IKEY$4;
				long vr$10651 = READKEY(  );
				IKEY$4 = vr$10651;
				if( IKEY$4 != 0 ) goto label$5134;
				goto label$5131;
				label$5134:;
				integer vr$10652 = fb_Multikey( 128 );
				if( vr$10652 == 0 ) goto label$5135;
				TMP$1368$4 = -(-(IKEY$4 != (FB$TMP$64)-128) != 0);
				goto label$5232;
				label$5135:;
				TMP$1368$4 = 0;
				label$5232:;
				if( TMP$1368$4 == 0 ) goto label$5137;
				IKEYA$1 = IKEY$4;
				label$5137:;
				integer vr$10655 = fb_Multikey( 127 );
				if( vr$10655 == 0 ) goto label$5138;
				TMP$1369$4 = -(-(IKEY$4 != (FB$TMP$64)-127) != 0);
				goto label$5233;
				label$5138:;
				TMP$1369$4 = 0;
				label$5233:;
				if( TMP$1369$4 == 0 ) goto label$5140;
				IKEYB$1 = IKEY$4;
				label$5140:;
				integer vr$10658 = fb_Multikey( 118 );
				if( vr$10658 == 0 ) goto label$5141;
				TMP$1370$4 = -(-(IKEY$4 != (FB$TMP$64)-118) != 0);
				goto label$5234;
				label$5141:;
				TMP$1370$4 = 0;
				label$5234:;
				if( TMP$1370$4 == 0 ) goto label$5143;
				IKEYX$1 = IKEY$4;
				label$5143:;
				integer vr$10661 = fb_Multikey( 117 );
				if( vr$10661 == 0 ) goto label$5144;
				TMP$1371$4 = -(-(IKEY$4 != (FB$TMP$64)-117) != 0);
				goto label$5235;
				label$5144:;
				TMP$1371$4 = 0;
				label$5235:;
				if( TMP$1371$4 == 0 ) goto label$5146;
				IKEYY$1 = IKEY$4;
				label$5146:;
				integer vr$10664 = fb_Multikey( 119 );
				if( vr$10664 == 0 ) goto label$5147;
				TMP$1372$4 = -(-(IKEY$4 != (FB$TMP$64)-119) != 0);
				goto label$5236;
				label$5147:;
				TMP$1372$4 = 0;
				label$5236:;
				if( TMP$1372$4 == 0 ) goto label$5149;
				IKEYL$1 = IKEY$4;
				label$5149:;
				integer vr$10667 = fb_Multikey( 120 );
				if( vr$10667 == 0 ) goto label$5150;
				TMP$1373$4 = -(-(IKEY$4 != (FB$TMP$64)-120) != 0);
				goto label$5237;
				label$5150:;
				TMP$1373$4 = 0;
				label$5237:;
				if( TMP$1373$4 == 0 ) goto label$5152;
				IKEYR$1 = IKEY$4;
				label$5152:;
				integer vr$10670 = fb_Multikey( 123 );
				if( vr$10670 == 0 ) goto label$5153;
				TMP$1374$4 = -(-(IKEY$4 != (FB$TMP$64)-123) != 0);
				goto label$5238;
				label$5153:;
				TMP$1374$4 = 0;
				label$5238:;
				if( TMP$1374$4 == 0 ) goto label$5155;
				IKEYLT$1 = IKEY$4;
				label$5155:;
				integer vr$10673 = fb_Multikey( 124 );
				if( vr$10673 == 0 ) goto label$5156;
				TMP$1375$4 = -(-(IKEY$4 != (FB$TMP$64)-124) != 0);
				goto label$5239;
				label$5156:;
				TMP$1375$4 = 0;
				label$5239:;
				if( TMP$1375$4 == 0 ) goto label$5158;
				IKEYRT$1 = IKEY$4;
				label$5158:;
				integer vr$10676 = fb_Multikey( 122 );
				if( vr$10676 == 0 ) goto label$5159;
				TMP$1376$4 = -(-(IKEY$4 != (FB$TMP$64)-122) != 0);
				goto label$5240;
				label$5159:;
				TMP$1376$4 = 0;
				label$5240:;
				if( TMP$1376$4 == 0 ) goto label$5161;
				IKEYUP$1 = IKEY$4;
				label$5161:;
				integer vr$10679 = fb_Multikey( 121 );
				if( vr$10679 == 0 ) goto label$5162;
				TMP$1377$4 = -(-(IKEY$4 != (FB$TMP$64)-121) != 0);
				goto label$5241;
				label$5162:;
				TMP$1377$4 = 0;
				label$5241:;
				if( TMP$1377$4 == 0 ) goto label$5164;
				IKEYDN$1 = IKEY$4;
				label$5164:;
				{
					if( IKEY$4 == 9 ) goto label$5167;
					label$5168:;
					if( IKEY$4 != (FB$TMP$64)-126 ) goto label$5166;
					label$5167:;
					{
						if( (uinteger)*(ubyte*)((ubyte*)TMP$1367$2 + 13) == 0u ) goto label$5170;
						{
							fb_Color( 14, 0, 2 );
							puts( (char*)"Menu is now deactivated" );
							G_GFXFOCUS$ = (byte)-1;
						}
						label$5170:;
						label$5169:;
					}
					goto label$5165;
					label$5166:;
					if( IKEY$4 == 27 ) goto label$5172;
					label$5173:;
					if( IKEY$4 != -107 ) goto label$5171;
					label$5172:;
					{
						fb$result$1 = (byte)0;
						goto label$5121;
					}
					goto label$5165;
					label$5171:;
					if( IKEY$4 != 48u ) goto label$5174;
					label$5175:;
					{
						*(ulong*)((ubyte*)TMP$1367$2 + 16) = 16384u;
						fb_Color( 10, 0, 2 );
						printf( (char*)"Speed: UNLIMITED instructions/ms" );
					}
					goto label$5165;
					label$5174:;
					if( IKEY$4 < 49u ) goto label$5176;
					if( IKEY$4 > 57u ) goto label$5176;
					label$5177:;
					{
						*(ulong*)((ubyte*)TMP$1367$2 + 16) = (ulong)(1 << (integer)((integer)(4 + IKEY$4) + 4294967247u));
						fb_Color( 10, 0, 2 );
						printf( (char*)"Speed: %i instructions/ms\n", *(ulong*)((ubyte*)TMP$1367$2 + 16) );
					}
					goto label$5165;
					label$5176:;
					if( IKEY$4 == 97u ) goto label$5179;
					label$5180:;
					if( IKEY$4 != 65u ) goto label$5178;
					label$5179:;
					{
						fb$result$1 = (byte)2;
						goto label$5121;
					}
					goto label$5165;
					label$5178:;
					if( IKEY$4 == 114u ) goto label$5182;
					label$5183:;
					if( IKEY$4 != 82u ) goto label$5181;
					label$5182:;
					{
						integer TMP$1381$6;
						if( (integer)G_BFINISHED$ != 0 ) goto label$5184;
						TMP$1381$6 = -((uinteger)*(ubyte*)((ubyte*)TMP$1367$2 + 13) != 0);
						goto label$5242;
						label$5184:;
						TMP$1381$6 = -1;
						label$5242:;
						if( TMP$1381$6 == 0 ) goto label$5186;
						{
							_ZN3CPU8RESETCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
							memset( (void*)((ubyte*)G_BMEMORY$ + 512), 0, 1024u );
							memset( (void*)((ubyte*)G_BMEMCHG$ + 512), 1, 1024u );
							G_BFINISHED$ = (byte)0;
							G_GFXFOCUS$ = (byte)-1;
							fb_Color( 10, 0, 2 );
							if( (uinteger)*(ubyte*)((ubyte*)TMP$1367$2 + 13) == 0u ) goto label$5188;
							puts( (char*)"CPU Reseted!" );
							goto label$5187;
							label$5188:;
							puts( (char*)"Emulation Started!" );
							label$5187:;
						}
						goto label$5185;
						label$5186:;
						{
							fb_Color( 10, 0, 2 );
							puts( (char*)"Emulation Resumed!" );
						}
						label$5185:;
						*(ubyte*)((ubyte*)TMP$1367$2 + 13) = (ubyte)255;
					}
					goto label$5165;
					label$5181:;
					if( IKEY$4 == 112u ) goto label$5190;
					label$5191:;
					if( IKEY$4 != 80u ) goto label$5189;
					label$5190:;
					{
						if( (uinteger)*(ubyte*)((ubyte*)TMP$1367$2 + 13) == 0u ) goto label$5193;
						{
							fb_Color( 14, 0, 2 );
							puts( (char*)"Emulation paused!" );
							*(ubyte*)((ubyte*)TMP$1367$2 + 13) = (ubyte)0;
						}
						label$5193:;
						label$5192:;
					}
					goto label$5165;
					label$5189:;
					if( IKEY$4 == 100u ) goto label$5195;
					label$5196:;
					if( IKEY$4 != 68u ) goto label$5194;
					label$5195:;
					{
						fb_Color( 10, 0, 2 );
						puts( (char*)"Entering Debug Mode" );
						*(ubyte*)((ubyte*)TMP$1367$2 + 12) = (ubyte)255;
						*(ubyte*)((ubyte*)TMP$1367$2 + 13) = (ubyte)0;
						fb_SleepEx( 50, 1 );
						if( (integer)G_BVIEWMODE$ != (VIEWMODE)0 ) goto label$5198;
						{
							HANDLEVIEWKEYS( -61 );
						}
						label$5198:;
						label$5197:;
						G_BBREAKPOINT$ = -1;
						DRAGWINDOW( (byte)-1 );
						SHOWSTATUS(  );
					}
					goto label$5165;
					label$5194:;
					{
						HANDLEVIEWKEYS( IKEY$4 );
					}
					label$5199:;
					label$5165:;
				}
			}
			label$5132:;
			goto label$5130;
			label$5131:;
		}
		label$5129:;
		label$5128:;
	}
	label$5127:;
	label$5126:;
	label$5200:;
	{
		integer TMP$1387$2;
		integer IKEY$2;
		if( (integer)G_GFXFOCUS$ == 0 ) goto label$5203;
		long vr$10704 = READKEY(  );
		TMP$1387$2 = (integer)vr$10704;
		goto label$5243;
		label$5203:;
		TMP$1387$2 = 0;
		label$5243:;
		IKEY$2 = TMP$1387$2;
		{
			if( IKEY$2 != (FB$TMP$64)-128 ) goto label$5205;
			label$5206:;
			{
				IKEY$2 = (integer)IKEYA$1;
			}
			goto label$5204;
			label$5205:;
			if( IKEY$2 != (FB$TMP$64)-127 ) goto label$5207;
			label$5208:;
			{
				IKEY$2 = (integer)IKEYB$1;
			}
			goto label$5204;
			label$5207:;
			if( IKEY$2 != (FB$TMP$64)-118 ) goto label$5209;
			label$5210:;
			{
				IKEY$2 = (integer)IKEYX$1;
			}
			goto label$5204;
			label$5209:;
			if( IKEY$2 != (FB$TMP$64)-117 ) goto label$5211;
			label$5212:;
			{
				IKEY$2 = (integer)IKEYY$1;
			}
			goto label$5204;
			label$5211:;
			if( IKEY$2 != (FB$TMP$64)-119 ) goto label$5213;
			label$5214:;
			{
				IKEY$2 = (integer)IKEYL$1;
			}
			goto label$5204;
			label$5213:;
			if( IKEY$2 != (FB$TMP$64)-120 ) goto label$5215;
			label$5216:;
			{
				IKEY$2 = (integer)IKEYR$1;
			}
			goto label$5204;
			label$5215:;
			if( IKEY$2 != (FB$TMP$64)-123 ) goto label$5217;
			label$5218:;
			{
				IKEY$2 = (integer)IKEYLT$1;
			}
			goto label$5204;
			label$5217:;
			if( IKEY$2 != (FB$TMP$64)-124 ) goto label$5219;
			label$5220:;
			{
				IKEY$2 = (integer)IKEYRT$1;
			}
			goto label$5204;
			label$5219:;
			if( IKEY$2 != (FB$TMP$64)-122 ) goto label$5221;
			label$5222:;
			{
				IKEY$2 = (integer)IKEYUP$1;
			}
			goto label$5204;
			label$5221:;
			if( IKEY$2 != (FB$TMP$64)-121 ) goto label$5223;
			label$5224:;
			{
				IKEY$2 = (integer)IKEYDN$1;
			}
			goto label$5204;
			label$5223:;
			if( IKEY$2 == 9 ) goto label$5226;
			label$5227:;
			if( IKEY$2 != (FB$TMP$64)-126 ) goto label$5225;
			label$5226:;
			{
				fb_Color( 14, 0, 2 );
				puts( (char*)"Menu is now activated!" );
				G_GFXFOCUS$ = (byte)0;
			}
			label$5225:;
			label$5204:;
		}
		if( IKEY$2 != 0 ) goto label$5229;
		goto label$5201;
		label$5229:;
		*(ubyte*)((ubyte*)G_BMEMORY$ + 255) = (ubyte)IKEY$2;
	}
	label$5202:;
	goto label$5200;
	label$5201:;
	fb$result$1 = (byte)1;
	goto label$5121;
	label$5121:;
	return fb$result$1;
}

long WAITKEY( void )
{
	long fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$5244:;
	_ZN3CPU7SHOWCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
	_ZN3GFX12UPDATESCREENEPh( (ubyte*)((ubyte*)G_BMEMORY$ + 512) );
	label$5246:;
	{
		HANDLEKEYS(  );
		long IKEY$2;
		long vr$10708 = READKEY(  );
		IKEY$2 = vr$10708;
		if( IKEY$2 == 0 ) goto label$5250;
		fb$result$1 = IKEY$2;
		goto label$5245;
		label$5250:;
		fb_SleepEx( 50, 1 );
	}
	label$5248:;
	goto label$5246;
	label$5247:;
	label$5245:;
	return fb$result$1;
}

integer main( void )
{
	integer fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$5392:;
	fb_ctor__main(  );
	fb$result$1 = 0;
	goto label$5393;
	label$5393:;
	return fb$result$1;
}

                               static void fb_ctor__main( void )
{
	label$0:;
	{
		ulong* vr$10712 = CAST_VU32( (ulong*)67112960 );
		*vr$10712 = 65536u;
		ubyte* vr$10713 = CAST_VU8( (ubyte*)67109442 );
		*vr$10713 = (ubyte)132;
		struct PRINTCONSOLE* vr$10714 = consoleInit( (struct PRINTCONSOLE*)0, 0, (BGTYPE)1, (BGSIZE)65536, 10, 2, 0, -1 );
		FBCONSOLE$ = vr$10714;
		struct KEYBOARD* vr$10715 = keyboardInit( (struct KEYBOARD*)0, 3, (BGTYPE)1, (BGSIZE)65536, 14, 0, 0, -1 );
		FBKEYBOARD$ = vr$10715;
		if( FBKEYBOARD$ == (struct KEYBOARD*)0 ) goto label$2855;
		{
			*(tmp$29*)((ubyte*)FBKEYBOARD$ + 84) = (tmp$29)&ONKEYPRESSED;
			*(tmp$29*)((ubyte*)FBKEYBOARD$ + 88) = (tmp$29)&ONKEYRELEASED;
			*(ulong*)((ubyte*)FBKEYBOARD$ + 80) = 0u;
		}
		label$2855:;
		label$2854:;
		{
			void* PIMG$2;
			void* vr$10719 = malloc( 49152u );
			PIMG$2 = vr$10719;
			ulong* vr$10720 = CAST_VU32( (ulong*)67109064 );
			*vr$10720 = 102760448u;
			ulong* vr$10721 = CAST_VU32( (ulong*)67109068 );
			*vr$10721 = (ulong)PIMG$2;
			ulong* vr$10722 = CAST_VU32( (ulong*)67109072 );
			*vr$10722 = 2214604800u;
			label$2856:;
			{
			}
			label$2858:;
			ulong* vr$10723 = CAST_VU32( (ulong*)67109072 );
			if( (*vr$10723 & -2147483648u) != 0u ) goto label$2856;
			label$2857:;
			ubyte* vr$10725 = CAST_VU8( (ubyte*)67109442 );
			*vr$10725 = (ubyte)0;
			ubyte* vr$10726 = CAST_VU8( (ubyte*)67109448 );
			*vr$10726 = (ubyte)129;
			ubyte* vr$10727 = CAST_VU8( (ubyte*)67109449 );
			*vr$10727 = (ubyte)129;
			ulong* vr$10728 = CAST_VU32( (ulong*)67109064 );
			*vr$10728 = (ulong)PIMG$2;
			ulong* vr$10729 = CAST_VU32( (ulong*)67109068 );
			*vr$10729 = 102760448u;
			ulong* vr$10730 = CAST_VU32( (ulong*)67109072 );
			*vr$10730 = 2214604800u;
			label$2859:;
			{
			}
			label$2861:;
			ulong* vr$10731 = CAST_VU32( (ulong*)67109072 );
			if( (*vr$10731 & -2147483648u) != 0u ) goto label$2859;
			label$2860:;
			free( PIMG$2 );
		}
		ubyte* vr$10733 = CAST_VU8( (ubyte*)67109440 );
		*vr$10733 = (ubyte)0;
		ubyte* vr$10734 = CAST_VU8( (ubyte*)67109441 );
		*vr$10734 = (ubyte)0;
		ubyte* vr$10735 = CAST_VU8( (ubyte*)67109442 );
		*vr$10735 = (ubyte)0;
		ubyte* vr$10736 = CAST_VU8( (ubyte*)67109443 );
		*vr$10736 = (ubyte)0;
		consoleClear(  );
		setExceptionHandler( &FB_EXCEPTION );
		ulong* vr$10737 = CAST_VU32( (ulong*)67125256 );
		*vr$10737 = 4294967295u;
		soundEnable(  );
		irqSet( 1u, &VBLANKINTERRUPT );
		irqEnable( 1u );
		swiWaitForVBlank(  );
		void* PTIMERHANDLER$1;
		PTIMERHANDLER$1 = (void*)&TIMERINTERRUPT;
		FB_TICKS$ = 0u;
		timerStart( 0, (CLOCKDIVIDER)1, (short)0, (tmp$2)PTIMERHANDLER$1 );
		keysSetRepeat( (ubyte)40, (ubyte)3 );
		consoleSelect( FBCONSOLE$ );
		integer vr$10739 = abs( *(integer*)((ubyte*)FBKEYBOARD$ + 12) );
		_ZN2FB15KEYBOARDOFFSET$E = (short)(192 - vr$10739);
		byte IGOTFAT$1;
		IGOTFAT$1 = (byte)0;
		if( (integer)IGOTFAT$1 != 0 ) goto label$2863;
		{
			integer vr$10743 = nitroFSInit( &_ZN2FB10PZEXEPATH$E );
			if( vr$10743 != 0 ) goto label$2865;
			{
				fb_Color( 12, 0, 2 );
				printf( (char*)"Failed to start NitroFS.\n" );
			}
			goto label$2864;
			label$2865:;
			{
				chdir( (char*)"nitro:/" );
			}
			label$2864:;
		}
		label$2863:;
		label$2862:;
		SetYtrigger( 144 );              
		irqEnable( 4u );
	}
	{
		{
			integer CNT$2;
			CNT$2 = 0;
			label$2869:;
			{
				double vr$10746 = atan( (double)CNT$2 / 2048.0 );
				short vr$10748 = fb_dtoss( vr$10746 * 2607.594549096069 );
				*(short*)((ubyte*)IFBATNTAB$ + (CNT$2 << 1)) = vr$10748;
			}
			label$2867:;
			CNT$2 = CNT$2 + 1;
			label$2866:;
			if( CNT$2 <= 2048 ) goto label$2869;
			label$2868:;
		}
	}
	string SASMFILE$0;
	string* vr$10752 = fb_StrInit( (void*)&SASMFILE$0, -1, (void*)"sample/Compo1st.asm", 20, 0 );
	_ZN3GFX10INITSCREENEa( (byte)-1 );
	SHOWSTATUS(  );
	FOCUSCONSOLE(  );
	label$5251:;
	{
		struct CPU$CPUCORE* TMP$1402$1;
		long BSTEPS$1;
		BSTEPS$1 = 1;
		long ILIMIT$1;
		ILIMIT$1 = 0;
		byte BCANRUN$1;
		BCANRUN$1 = (byte)0;
		G_BFINISHED$ = (byte)1;
		G_BBREAKPOINT$ = -1;
		{
			fb_ConsoleView( 1, 24 );
			struct TMP$1391 {
				char* DATA;
				char* PTR;
				integer SIZE;
				integer ELEMENT_LEN;
				integer DIMENSIONS;
				struct __FB_ARRAYDIMTB$ DIMTB[1];
			};
			{
				static byte IPREVQUERY$3 = -1;
				*(integer*)((ubyte*)FBKEYBOARD$ + 12) = -224 + (integer)_ZN2FB15KEYBOARDOFFSET$E;
				keyboardShow(  );
				fb_Cls( -65536 );
				static char SFILEARR$3[40][64];
				static struct TMP$1391 tmp$1390$3 = { (void*)SFILEARR$3, (void*)SFILEARR$3, 2560, 64, 1, { { 40, 0, 39 } } };
				string SFILE$3;
				string* vr$10756 = fb_StrAllocTempDescZEx( (char*)"sample/*.asm", 12 );
				string* vr$10757 = fb_Dir( vr$10756, 33, (integer*)0 );
				string* vr$10759 = fb_StrInit( (void*)&SFILE$3, -1, vr$10757, -1, 0 );
				integer IFILE$3;
				IFILE$3 = 0;
				integer IQUERY$3;
				IQUERY$3 = 0;
				label$5254:;
				integer vr$10761 = fb_StrLen( (void*)&SFILE$3, -1 );
				if( vr$10761 == 0 ) goto label$5255;
				{
					integer TMP$1394$4;
					integer TMP$1396$4;
					fb_Locate( 1 + (IFILE$3 % 16), 1 + (((IFILE$3 + ((IFILE$3 >> 31) & 15)) >> 4) << 4), -1, 0, 0 );
					fb_StrAssign( (void*)((ubyte*)SFILEARR$3 + (IFILE$3 << 6)), 64, (void*)&SFILE$3, -1, 0 );
					string* vr$10773 = fb_StrAllocTempDescZEx( (char*)".asm", 4 );
					integer vr$10775 = fb_StrInstr( 1, &SFILE$3, vr$10773 );
					*(ubyte*)((ubyte*)((ubyte*)*(char**)&SFILE$3 + vr$10775) + -1) = (ubyte)0;
					if( (IFILE$3 & 1) == 0 ) goto label$5256;
					TMP$1394$4 = 10;
					goto label$5400;
					label$5256:;
					TMP$1394$4 = 11;
					label$5400:;
					fb_Color( TMP$1394$4, 0, 2 );
					printf( (char*)"%i)", IFILE$3 );
					if( (IFILE$3 & 1) == 0 ) goto label$5257;
					TMP$1396$4 = 2;
					goto label$5401;
					label$5257:;
					TMP$1396$4 = 3;
					label$5401:;
					fb_Color( TMP$1396$4, 0, 2 );
					printf( (char*)"%s", *(char**)&SFILE$3 );
					IFILE$3 = IFILE$3 + 1;
					string* vr$10780 = fb_DirNext( (integer*)0 );
					string* vr$10782 = fb_StrAssign( (void*)&SFILE$3, -1, vr$10780, -1, 0 );
				}
				goto label$5254;
				label$5255:;
				label$5258:;
				{
					integer TMP$1398$4;
					string SQUERY$4;
					__builtin_memset( &SQUERY$4, 0, 12 );
					fb_Locate( 18, 1, -1, 0, 0 );
					string* vr$10784 = fb_StrAllocTempDescZEx( (char*)"File #", 6 );
					fb_PrintString( 0, vr$10784, 0 );
					string* vr$10785 = 0;                                     
					fb_ConsoleInput( vr$10785, -1, -1 );
					fb_InputString( (void*)&SQUERY$4, -1, 0 );
					integer vr$10788 = fb_StrLen( (void*)&SQUERY$4, -1 );
					if( -(vr$10788 == 0) == 0 ) goto label$5261;
					TMP$1398$4 = -(-((integer)IPREVQUERY$3 != -1) != 0);
					goto label$5402;
					label$5261:;
					TMP$1398$4 = 0;
					label$5402:;
					if( TMP$1398$4 == 0 ) goto label$5263;
					{
						IQUERY$3 = (integer)IPREVQUERY$3;
					}
					goto label$5262;
					label$5263:;
					{
						integer vr$10795 = fb_VALINT( &SQUERY$4 );
						IQUERY$3 = vr$10795;
					}
					label$5262:;
					fb_StrDelete( &SQUERY$4 );
				}
				label$5260:;
				if( (uinteger)IQUERY$3 >= IFILE$3 ) goto label$5258;
				label$5259:;
				IPREVQUERY$3 = (byte)IQUERY$3;
				string* vr$10799 = fb_StrAssign( (void*)&SASMFILE$0, -1, (void*)"sample/", 8, 0 );
				string* vr$10803 = fb_StrConcatAssign( (void*)&SASMFILE$0, -1, (void*)((ubyte*)SFILEARR$3 + (IQUERY$3 << 6)), 64, 0 );
				*(integer*)((ubyte*)FBKEYBOARD$ + 12) = -184 + (integer)_ZN2FB15KEYBOARDOFFSET$E;
				keyboardShow(  );
				label$5264:;
				string* vr$10807 = fb_Inkey(  );
				integer vr$10808 = fb_StrLen( vr$10807, -1 );
				if( vr$10808 == 0 ) goto label$5265;
				{
				}
				goto label$5264;
				label$5265:;
				fb_StrDelete( &SFILE$3 );
			}
			fb_Color( 7, 0, 0 );
			fb_Cls( -65536 );
			fb_Locate( 2, 1, 0, 0, 0 );
			fb_Color( 15, 0, 2 );
			puts( *(char**)&SASMFILE$0 );
			SHOWSTATUS(  );
			fb_Color( 10, 0, 2 );
			puts( (char*)"Assembling... " );
			byte vr$10811 = ASSEMBLE( &SASMFILE$0, (byte)0 );
			if( (integer)vr$10811 == 0 ) goto label$5267;
			{
				fb_Color( 11, 0, 2 );
				BCANRUN$1 = (byte)1;
				printf( (char*)"Assembly: %i bytes, %i lines\n", *(long*)((ubyte*)&G_TPARSER$ + 24), *(long*)((ubyte*)&G_TPARSER$ + 12) );
			}
			label$5267:;
			label$5266:;
			_ZN3CPU8RESETCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
			_ZN3CPU7SHOWCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
			UTOTALCYCLES$ = 0ll;
			UTOTALCYCLES2$ = 0ll;
			UPDATECURRENTVIEW( (byte)-1 );
			_ZN3GFX12UPDATESCREENEPh( (ubyte*)((ubyte*)G_BMEMORY$ + 512) );
		}
		TMP$1402$1 = &_ZN3CPU7G_TCPU$E;
		label$5268:;
		{
			static double DLIMIT$2;
			{
				long N$3;
				N$3 = 0;
				label$5274:;
				{
					double vr$10813 = fb_Timer(  );
					if( (vr$10813 - DLIMIT$2) < 0.01666666666666667 ) goto label$5276;
					{
						static byte BSWAP$5;
						BSWAP$5 = (byte)((integer)BSWAP$5 ^ 1);
						if( (integer)BSWAP$5 == 0 ) goto label$5278;
						{
							if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 12) == 0u ) goto label$5280;
							_ZN3CPU7SHOWCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
							label$5280:;
							UPDATECURRENTVIEW( (byte)0 );
							DRAGWINDOW( (byte)0 );
						}
						goto label$5277;
						label$5278:;
						{
							_ZN3GFX12UPDATESCREENEPh( (ubyte*)((ubyte*)G_BMEMORY$ + 512) );
						}
						label$5277:;
						DLIMIT$2 = DLIMIT$2 + 0.01666666666666667;
					}
					label$5276:;
					label$5275:;
				}
				label$5272:;
				N$3 = N$3 + 1;
				label$5271:;
				if( N$3 <= 1 ) goto label$5274;
				label$5273:;
			}
			double vr$10823 = fb_Timer(  );
			double vr$10825 = fabs( vr$10823 - DLIMIT$2 );
			if( vr$10825 <= 0.5 ) goto label$5282;
			double vr$10826 = fb_Timer(  );
			DLIMIT$2 = vr$10826;
			label$5282:;
			{
				byte TMP$1403$3;
				byte vr$10827 = HANDLEKEYS(  );
				TMP$1403$3 = vr$10827;
				if( (integer)TMP$1403$3 != 0 ) goto label$5284;
				label$5285:;
				{
					*(ubyte*)((ubyte*)TMP$1402$1 + 11) = (ubyte)1;
					goto label$5252;
				}
				goto label$5283;
				label$5284:;
				if( (integer)TMP$1403$3 != 2 ) goto label$5286;
				label$5287:;
				{
					goto label$5253;
				}
				label$5286:;
				label$5283:;
			}
			if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 12) == 0u ) goto label$5289;
			{
				G_GFXFOCUS$ = (byte)-1;
				{
					long N$4;
					N$4 = BSTEPS$1 + -1;
					goto label$5290;
					label$5293:;
					{
						integer TMP$1404$5;
						*(ubyte*)((ubyte*)TMP$1402$1 + 5) = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1402$1 + 6));
						if( -(N$4 == 0) != 0 ) goto label$5294;
						TMP$1404$5 = -(-((integer)*(ushort*)((ubyte*)TMP$1402$1 + 6) == G_BBREAKPOINT$) != 0);
						goto label$5403;
						label$5294:;
						TMP$1404$5 = -1;
						label$5403:;
						if( TMP$1404$5 == 0 ) goto label$5296;
						{
							long TMP$1406$6;
							long TMP$1407$6;
							long TMP$1408$6;
							if( (integer)*(ushort*)((ubyte*)TMP$1402$1 + 6) != G_BBREAKPOINT$ ) goto label$5298;
							{
								fb_Color( 10, 0, 2 );
								puts( (char*)"Breakpoint reached!" );
								G_BBREAKPOINT$ = -1;
							}
							label$5298:;
							label$5297:;
							UPDATECURRENTVIEW( (byte)0 );
							G_GFXFOCUS$ = (byte)0;
							N$4 = 0;
							TMP$1408$6 = (long)*(ushort*)((ubyte*)TMP$1402$1 + 6);
							TMP$1407$6 = TMP$1408$6;
							DISASMINSTRUCTION( &TMP$1407$6 );
							_ZN3GFX12UPDATESCREENEPh( (ubyte*)((ubyte*)G_BMEMORY$ + 512) );
							label$5299:;
							{
								long TMP$1409$7;
								long IKEY$7;
								if( G_BBREAKPOINT$ < 0 ) goto label$5302;
								long vr$10847 = READKEY(  );
								TMP$1409$7 = vr$10847;
								goto label$5404;
								label$5302:;
								long vr$10848 = WAITKEY(  );
								TMP$1409$7 = vr$10848;
								label$5404:;
								IKEY$7 = TMP$1409$7;
								{
									if( IKEY$7 != 0 ) goto label$5304;
									label$5305:;
									{
										BSTEPS$1 = 16384;
										goto label$5300;
									}
									goto label$5303;
									label$5304:;
									if( IKEY$7 == 115u ) goto label$5307;
									label$5308:;
									if( IKEY$7 != 83u ) goto label$5306;
									label$5307:;
									{
										G_BBREAKPOINT$ = -1;
										if( (integer)BCANRUN$1 == 0 ) goto label$5310;
										BSTEPS$1 = 1;
										goto label$5300;
										label$5310:;
									}
									goto label$5303;
									label$5306:;
									if( IKEY$7 == 119u ) goto label$5312;
									label$5313:;
									if( IKEY$7 != 87u ) goto label$5311;
									label$5312:;
									{
										G_BBREAKPOINT$ = -1;
										if( (integer)BCANRUN$1 == 0 ) goto label$5315;
										BSTEPS$1 = 10;
										goto label$5300;
										label$5315:;
									}
									goto label$5303;
									label$5311:;
									if( IKEY$7 == 120u ) goto label$5317;
									label$5318:;
									if( IKEY$7 == 88u ) goto label$5317;
									label$5319:;
									if( IKEY$7 != -31 ) goto label$5316;
									label$5317:;
									{
										G_BBREAKPOINT$ = -1;
										if( (integer)BCANRUN$1 == 0 ) goto label$5321;
										BSTEPS$1 = 100;
										goto label$5300;
										label$5321:;
									}
									goto label$5303;
									label$5316:;
									if( IKEY$7 == 98u ) goto label$5323;
									label$5324:;
									if( IKEY$7 != 66u ) goto label$5322;
									label$5323:;
									{
										if( (integer)BCANRUN$1 == 0 ) goto label$5326;
										{
											string SBREAK$10;
											__builtin_memset( &SBREAK$10, 0, 12 );
											G_BBREAKPOINT$ = -1;
											fb_Color( 14, 0, 2 );
											string* vr$10854 = fb_StrAllocTempDescZEx( (char*)"Breakpoint where", 16 );
											fb_ConsoleInput( vr$10854, -1, -1 );
											fb_InputString( (void*)&SBREAK$10, -1, 0 );
											string* vr$10857 = fb_TRIM( &SBREAK$10 );
											string* vr$10859 = fb_StrAssign( (void*)&SBREAK$10, -1, vr$10857, -1, 0 );
											integer vr$10861 = fb_StrLen( (void*)&SBREAK$10, -1 );
											if( vr$10861 == 0 ) goto label$5328;
											{
												if( (uinteger)*(ubyte*)*(char**)&SBREAK$10 != 36u ) goto label$5330;
												{
													string TMP$1412$12;
													string* vr$10865 = fb_StrMid( &SBREAK$10, 2, -1 );
													__builtin_memset( &TMP$1412$12, 0, 12 );
													string* vr$10868 = fb_StrConcat( &TMP$1412$12, (void*)"&h", 3, vr$10865, -1 );
													integer vr$10869 = fb_VALINT( vr$10868 );
													G_BBREAKPOINT$ = (long)vr$10869;
												}
												goto label$5329;
												label$5330:;
												if( (uinteger)*(ubyte*)*(char**)&SBREAK$10 != 35u ) goto label$5331;
												{
													string* vr$10873 = fb_StrMid( &SBREAK$10, 2, -1 );
													integer vr$10874 = fb_VALINT( vr$10873 );
													G_BBREAKPOINT$ = (long)vr$10874;
												}
												goto label$5329;
												label$5331:;
												{
													string TMP$1413$12;
													__builtin_memset( &TMP$1413$12, 0, 12 );
													string* vr$10878 = fb_StrConcat( &TMP$1413$12, (void*)"&h", 3, (void*)&SBREAK$10, -1 );
													integer vr$10879 = fb_VALINT( vr$10878 );
													G_BBREAKPOINT$ = (long)vr$10879;
												}
												label$5329:;
												if( (uinteger)G_BBREAKPOINT$ <= 65535 ) goto label$5333;
												{
													fb_Color( 12, 0, 2 );
													puts( (char*)"Invalid address for breakpoint" );
													G_BBREAKPOINT$ = -1;
												}
												goto label$5332;
												label$5333:;
												{
													fb_Color( 13, 0, 2 );
													printf( (char*)"Breakpoint set to $%04X\n", G_BBREAKPOINT$ );
												}
												label$5332:;
											}
											goto label$5327;
											label$5328:;
											{
												fb_Color( 13, 0, 2 );
												puts( (char*)"Breakpoint cleared" );
											}
											label$5327:;
											fb_StrDelete( &SBREAK$10 );
										}
										label$5326:;
										label$5325:;
									}
									goto label$5303;
									label$5322:;
									if( IKEY$7 == 106u ) goto label$5335;
									label$5336:;
									if( IKEY$7 != 74u ) goto label$5334;
									label$5335:;
									{
										if( (integer)BCANRUN$1 == 0 ) goto label$5338;
										{
											string SJUMP$10;
											__builtin_memset( &SJUMP$10, 0, 12 );
											G_BBREAKPOINT$ = -1;
											long ITARGET$10;
											__builtin_memset( &ITARGET$10, 0, 4 );
											string* vr$10884 = fb_StrAllocTempDescZEx( (char*)"Jump to where", 13 );
											fb_ConsoleInput( vr$10884, -1, -1 );
											fb_InputString( (void*)&SJUMP$10, -1, 0 );
											string* vr$10887 = fb_TRIM( &SJUMP$10 );
											string* vr$10889 = fb_StrAssign( (void*)&SJUMP$10, -1, vr$10887, -1, 0 );
											integer vr$10891 = fb_StrLen( (void*)&SJUMP$10, -1 );
											if( vr$10891 == 0 ) goto label$5340;
											{
												if( (uinteger)*(ubyte*)*(char**)&SJUMP$10 != 36u ) goto label$5342;
												{
													string TMP$1418$12;
													string* vr$10895 = fb_StrMid( &SJUMP$10, 2, -1 );
													__builtin_memset( &TMP$1418$12, 0, 12 );
													string* vr$10898 = fb_StrConcat( &TMP$1418$12, (void*)"&h", 3, vr$10895, -1 );
													integer vr$10899 = fb_VALINT( vr$10898 );
													ITARGET$10 = (long)vr$10899;
												}
												goto label$5341;
												label$5342:;
												if( (uinteger)*(ubyte*)*(char**)&SJUMP$10 != 35u ) goto label$5343;
												{
													string* vr$10903 = fb_StrMid( &SJUMP$10, 2, -1 );
													integer vr$10904 = fb_VALINT( vr$10903 );
													ITARGET$10 = (long)vr$10904;
												}
												goto label$5341;
												label$5343:;
												{
													string TMP$1419$12;
													__builtin_memset( &TMP$1419$12, 0, 12 );
													string* vr$10908 = fb_StrConcat( &TMP$1419$12, (void*)"&h", 3, (void*)&SJUMP$10, -1 );
													integer vr$10909 = fb_VALINT( vr$10908 );
													ITARGET$10 = (long)vr$10909;
												}
												label$5341:;
												if( (uinteger)ITARGET$10 <= 65535 ) goto label$5345;
												{
													fb_Color( 12, 0, 2 );
													puts( (char*)"Invalid address for jump" );
												}
												goto label$5344;
												label$5345:;
												{
													fb_Color( 13, 0, 2 );
													printf( (char*)"Jumping to $%04X\n", ITARGET$10 );
													*(ushort*)((ubyte*)TMP$1402$1 + 6) = (ushort)ITARGET$10;
													*(ubyte*)((ubyte*)TMP$1402$1 + 5) = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1402$1 + 6));
												}
												label$5344:;
											}
											goto label$5339;
											label$5340:;
											{
												fb_Color( 13, 0, 2 );
												puts( (char*)"Jumping cancelled." );
											}
											label$5339:;
											fb_StrDelete( &SJUMP$10 );
										}
										label$5338:;
										label$5337:;
									}
									goto label$5303;
									label$5334:;
									if( IKEY$7 == 97u ) goto label$5347;
									label$5348:;
									if( IKEY$7 != 65u ) goto label$5346;
									label$5347:;
									{
										G_BBREAKPOINT$ = -1;
										goto label$5253;
									}
									goto label$5303;
									label$5346:;
									if( IKEY$7 == 100u ) goto label$5350;
									label$5351:;
									if( IKEY$7 != 68u ) goto label$5349;
									label$5350:;
									{
										fb_Color( 14, 0, 2 );
										puts( (char*)"Exiting Debug Mode" );
										DRAGWINDOW( (byte)-1 );
										*(ubyte*)((ubyte*)TMP$1402$1 + 12) = (ubyte)0;
										G_BBREAKPOINT$ = -1;
										SHOWSTATUS(  );
										goto label$5270;
									}
									goto label$5303;
									label$5349:;
									if( IKEY$7 == 114u ) goto label$5353;
									label$5354:;
									if( IKEY$7 != 82u ) goto label$5352;
									label$5353:;
									{
										fb_Color( 14, 0, 2 );
										puts( (char*)"Exiting Debug Mode and running" );
										DRAGWINDOW( (byte)-1 );
										*(ubyte*)((ubyte*)TMP$1402$1 + 12) = (ubyte)0;
										*(ubyte*)((ubyte*)TMP$1402$1 + 13) = (ubyte)255;
										G_BBREAKPOINT$ = -1;
										SHOWSTATUS(  );
										G_GFXFOCUS$ = (byte)-1;
										goto label$5270;
									}
									goto label$5303;
									label$5352:;
									if( IKEY$7 == 1 ) goto label$5356;
									label$5357:;
									if( IKEY$7 != -30 ) goto label$5355;
									label$5356:;
									{
										string STEMP$9;
										__builtin_memset( &STEMP$9, 0, 12 );
										fb_Color( 14, 0, 2 );
										string* vr$10920 = fb_StrAllocTempDescZEx( (char*)"New value for A", 15 );
										fb_ConsoleInput( vr$10920, -1, -1 );
										fb_InputString( (void*)&STEMP$9, -1, 0 );
										integer vr$10923 = fb_StrLen( (void*)&STEMP$9, -1 );
										if( vr$10923 == 0 ) goto label$5359;
										{
											string TMP$1426$10;
											__builtin_memset( &TMP$1426$10, 0, 12 );
											string* vr$10927 = fb_StrConcat( &TMP$1426$10, (void*)"&h", 3, (void*)&STEMP$9, -1 );
											integer vr$10928 = fb_VALINT( vr$10927 );
											*(ubyte*)TMP$1402$1 = (ubyte)vr$10928;
											fb_Color( 13, 0, 2 );
											printf( (char*)"A set to $%02X\n", (uinteger)*(ubyte*)TMP$1402$1 );
										}
										goto label$5358;
										label$5359:;
										{
											fb_Color( 13, 0, 2 );
											puts( (char*)"Not modified" );
										}
										label$5358:;
										fb_StrDelete( &STEMP$9 );
									}
									goto label$5303;
									label$5355:;
									if( IKEY$7 == 27 ) goto label$5361;
									label$5362:;
									if( IKEY$7 != -107 ) goto label$5360;
									label$5361:;
									{
										*(ubyte*)((ubyte*)TMP$1402$1 + 11) = (ubyte)1;
										goto label$5269;
									}
									goto label$5303;
									label$5360:;
									{
										HANDLEVIEWKEYS( IKEY$7 );
									}
									label$5363:;
									label$5303:;
								}
							}
							label$5301:;
							goto label$5299;
							label$5300:;
						}
						label$5296:;
						label$5295:;
						*(ushort*)((ubyte*)TMP$1402$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1402$1 + 6) + 1);
						UTOTALCYCLES2$ = UTOTALCYCLES2$ + 1ll;
						(*(tmp$2*)((ubyte*)_ZN3CPU11G_FNOPCODE$E + ((integer)*(ubyte*)((ubyte*)TMP$1402$1 + 5) << 2)))(  );
						if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 10) == 0u ) goto label$5365;
						{
							*(ubyte*)((ubyte*)TMP$1402$1 + 10) = (ubyte)0;
							G_BBREAKPOINT$ = -1;
							fb_Color( 10, 0, 2 );
							puts( (char*)"Program Finished!" );
							WAITKEY(  );
							_ZN3CPU8RESETCPUERNS_7CPUCOREE( &_ZN3CPU7G_TCPU$E );
							memset( (void*)((ubyte*)G_BMEMORY$ + 512), 0, 1024u );
							memset( (void*)((ubyte*)G_BMEMCHG$ + 512), 1, 1024u );
							G_BFINISHED$ = (byte)0;
							N$4 = 1;
						}
						label$5365:;
						label$5364:;
					}
					label$5291:;
					N$4 = N$4 + -1;
					label$5290:;
					if( N$4 >= 0 ) goto label$5293;
					label$5292:;
				}
			}
			goto label$5288;
			label$5289:;
			if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 13) == 0u ) goto label$5366;
			{
				if( (integer)BCANRUN$1 != 0 ) goto label$5368;
				{
					*(ubyte*)((ubyte*)TMP$1402$1 + 13) = (ubyte)0;
					goto label$5270;
				}
				label$5368:;
				label$5367:;
				static double TMR$3;
				if( TMR$3 != 0.0 ) goto label$5370;
				double vr$10952 = fb_Timer(  );
				TMR$3 = vr$10952;
				label$5370:;
				long N$3;
				{
					N$3 = 0;
					long TMP$1430$4;
					TMP$1430$4 = (long)(((*(ulong*)((ubyte*)TMP$1402$1 + 16) * 1000) / 60) + -1);
					goto label$5371;
					label$5374:;
					{
						*(ubyte*)((ubyte*)TMP$1402$1 + 5) = *(ubyte*)((ubyte*)G_BMEMORY$ + (integer)*(ushort*)((ubyte*)TMP$1402$1 + 6));
						*(ushort*)((ubyte*)TMP$1402$1 + 6) = (ushort)((integer)*(ushort*)((ubyte*)TMP$1402$1 + 6) + 1);
						(*(tmp$2*)((ubyte*)_ZN3CPU11G_FNOPCODE$E + ((integer)*(ubyte*)((ubyte*)TMP$1402$1 + 5) << 2)))(  );
						if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 10) == 0u ) goto label$5376;
						{
							*(ubyte*)((ubyte*)TMP$1402$1 + 10) = (ubyte)0;
							if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 14) == 0u ) goto label$5378;
							goto label$5373;
							label$5378:;
							*(ubyte*)((ubyte*)TMP$1402$1 + 13) = (ubyte)0;
							fb_Color( 10, 0, 2 );
							puts( (char*)"Program Finished!" );
							_ZN3GFX12UPDATESCREENEPh( (ubyte*)((ubyte*)G_BMEMORY$ + 512) );
							G_BFINISHED$ = (byte)-1;
							goto label$5373;
						}
						label$5376:;
						label$5375:;
					}
					label$5372:;
					N$3 = N$3 + 1;
					label$5371:;
					if( N$3 <= TMP$1430$4 ) goto label$5374;
					label$5373:;
				}
				UTOTALCYCLES2$ = UTOTALCYCLES2$ + (longint)N$3;
				UTOTALCYCLES$ = UTOTALCYCLES$ + (longint)N$3;
				double vr$10979 = fb_Timer(  );
				double vr$10981 = fabs( vr$10979 - TMR$3 );
				if( vr$10981 < 1.0 ) goto label$5380;
				{
					fb_Color( 13, 0, 2 );
					if( ILIMIT$1 == 0 ) goto label$5382;
					{
						double vr$10987 = fb_Timer(  );
						printf( (char*)"%1.1f Khz (%1.1f fps)    \r", ((double)UTOTALCYCLES$ / 1000.0) / (vr$10987 - TMR$3), 1000.0 / (double)(ILIMIT$1 + -1) );
						ILIMIT$1 = 0;
					}
					goto label$5381;
					label$5382:;
					{
						double vr$10992 = fb_Timer(  );
						printf( (char*)"%1.1f Khz    \r", ((double)UTOTALCYCLES$ / 1000.0) / (vr$10992 - TMR$3) );
					}
					label$5381:;
					double vr$10995 = fb_Timer(  );
					TMR$3 = vr$10995;
					UTOTALCYCLES$ = 0ll;
				}
				label$5380:;
				label$5379:;
				static double DTIME$3;
				if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 14) == 0u ) goto label$5384;
				{
					if( (uinteger)*(ubyte*)((ubyte*)TMP$1402$1 + 14) == 255u ) goto label$5386;
					ILIMIT$1 = (long)((uinteger)*(ubyte*)((ubyte*)G_BMEMORY$ + 254) + 1);
					label$5386:;
					double vr$11002 = fb_Timer(  );
					DTIME$3 = vr$11002;
					*(ubyte*)((ubyte*)TMP$1402$1 + 14) = (ubyte)0;
				}
				goto label$5383;
				label$5384:;
				if( *(ulong*)((ubyte*)&_ZN3CPU7G_TCPU$E + 16) >= 8192 ) goto label$5387;
				{
					double vr$11004 = fb_Timer(  );
					double vr$11006 = fabs( vr$11004 - DTIME$3 );
					if( vr$11006 <= 1.0 ) goto label$5389;
					{
						double vr$11007 = fb_Timer(  );
						DTIME$3 = vr$11007;
					}
					goto label$5388;
					label$5389:;
					{
						label$5390:;
						double vr$11008 = fb_Timer(  );
						if( (vr$11008 - DTIME$3) >= 0.01666666666666667 ) goto label$5391;
						{
							fb_GfxWaitVSync(  );
						}
						goto label$5390;
						label$5391:;
						DTIME$3 = DTIME$3 + 0.01666666666666667;
					}
					label$5388:;
				}
				label$5387:;
				label$5383:;
			}
			goto label$5288;
			label$5366:;
			{
				fb_SleepEx( 50, 1 );
			}
			label$5288:;
		}
		label$5270:;
		goto label$5268;
		label$5269:;
	}
	label$5253:;
	goto label$5251;
	label$5252:;
	*(ubyte*)((ubyte*)&_ZN3CPU7G_TCPU$E + 11) = (ubyte)1;
	puts( (char*)"Waiting thread..." );
	puts( (char*)"Done..." );
	_ZN3GFX11CLOSESCREENEv(  );
	fb_StrDelete( &SASMFILE$0 );
	label$1:;
}

static ulong NDS_ARM7ACK( void )
{
	ulong fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$221:;
	label$223:;
	if( NDS_PENDINGACK$ <= 0 ) goto label$224;
	{
		integer vr$11013 = fifoCheckValue32( 7 );
		if( vr$11013 == 0 ) goto label$226;
		{
			ulong vr$11014 = fifoGetValue32( 7 );
			fb$result$1 = vr$11014;
			NDS_PENDINGACK$ = NDS_PENDINGACK$ + -1;
		}
		goto label$225;
		label$226:;
		{
			swiIntrWait( 1u, 262144u );
		}
		label$225:;
	}
	goto label$223;
	label$224:;
	label$222:;
	return fb$result$1;
}

static void _FB_INT_UPDATESCREEN( void )
{
	label$236:;
	ulong* vr$11017 = CAST_VU32( (ulong*)67109072 );
	if( ((*vr$11017 & -2147483648u) >> 31) == 0u ) goto label$239;
	goto label$237;
	label$239:;
	void* PSRC$1;
	PSRC$1 = _ZN3GFX7SCRPTR$E;
	uinteger ISRCSZ$1;
	ISRCSZ$1 = _ZN3GFX8GFXSIZE$E;
	void* PVRAM$1;
	PVRAM$1 = _ZN3GFX8VRAMPTR$E;
	if( ((*(integer*)&_ZN3GFX3FG$E >> 8) & 1) == 0 ) goto label$241;
	{
		ulong* vr$11022 = CAST_VU32( (ulong*)67109084 );
		if( ((*vr$11022 & -2147483648u) >> 31) == 0u ) goto label$243;
		goto label$237;
		label$243:;
		DC_FlushRange( PSRC$1, (ulong)ISRCSZ$1 );
		integer ISZ$2;
		ISZ$2 = (integer)(192 * *(uinteger*)((ubyte*)_ZN3GFX4SCR$E + 16));
		ulong* vr$11027 = CAST_VU32( (ulong*)67109076 );
		*vr$11027 = (ulong)PSRC$1;
		ulong* vr$11028 = CAST_VU32( (ulong*)67109080 );
		*vr$11028 = (ulong)_ZN3GFX9VRAMBPTR$E;
		ulong* vr$11031 = CAST_VU32( (ulong*)67109084 );
		*vr$11031 = (ulong)(integer)(-2080374784 | ((ulong)ISZ$2 >> 2));
		PSRC$1 = (void*)((ubyte*)PSRC$1 + (integer)(ISRCSZ$1 - ISZ$2));
		ulong* vr$11034 = CAST_VU32( (ulong*)67109064 );
		*vr$11034 = (ulong)PSRC$1;
		ulong* vr$11035 = CAST_VU32( (ulong*)67109068 );
		*vr$11035 = (ulong)_ZN3GFX8VRAMPTR$E;
		ulong* vr$11038 = CAST_VU32( (ulong*)67109072 );
		*vr$11038 = (ulong)(integer)(-2080374784 | ((ulong)ISZ$2 >> 2));
		*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -2;
		*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -49;
	}
	goto label$240;
	label$241:;
	{
		*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -2;
		*(integer*)&_ZN3GFX3FG$E = *(integer*)&_ZN3GFX3FG$E & -49;
		ulong* vr$11043 = CAST_VU32( (ulong*)67109064 );
		*vr$11043 = (ulong)PSRC$1;
		ulong* vr$11044 = CAST_VU32( (ulong*)67109068 );
		*vr$11044 = (ulong)PVRAM$1;
		ulong* vr$11047 = CAST_VU32( (ulong*)67109072 );
		*vr$11047 = (ulong)(integer)(-2080374784 | ((ulong)ISRCSZ$1 >> 2));
	}
	label$240:;
	label$237:;
}

static void ONKEYPRESSED( integer KEY$1 )
{
	label$314:;
	integer ISCAN$1;
	ISCAN$1 = KEY$1;
	{
		if( KEY$1 != -15 ) goto label$317;
		label$318:;
		{
			goto label$315;
		}
		goto label$316;
		label$317:;
		if( KEY$1 != -17 ) goto label$319;
		label$320:;
		{
			KEY$1 = -72;
			ISCAN$1 = 72;
		}
		goto label$316;
		label$319:;
		if( KEY$1 != -18 ) goto label$321;
		label$322:;
		{
			KEY$1 = -77;
			ISCAN$1 = 77;
		}
		goto label$316;
		label$321:;
		if( KEY$1 != -19 ) goto label$323;
		label$324:;
		{
			KEY$1 = -80;
			ISCAN$1 = 80;
		}
		goto label$316;
		label$323:;
		if( KEY$1 != -20 ) goto label$325;
		label$326:;
		{
			KEY$1 = -75;
			ISCAN$1 = 75;
		}
		goto label$316;
		label$325:;
		if( KEY$1 != -23 ) goto label$327;
		label$328:;
		{
			KEY$1 = 27;
			ISCAN$1 = 1;
		}
		goto label$316;
		label$327:;
		if( KEY$1 != 10 ) goto label$329;
		label$330:;
		{
			KEY$1 = 13;
			ISCAN$1 = 28;
		}
		goto label$316;
		label$329:;
		if( KEY$1 != -5 ) goto label$331;
		label$332:;
		{
			ISCAN$1 = 93;
		}
		goto label$316;
		label$331:;
		if( KEY$1 != 8 ) goto label$333;
		label$334:;
		{
			ISCAN$1 = 14;
		}
		goto label$316;
		label$333:;
		if( KEY$1 != 9 ) goto label$335;
		label$336:;
		{
			ISCAN$1 = 15;
		}
		goto label$316;
		label$335:;
		if( KEY$1 != 32 ) goto label$337;
		label$338:;
		{
			ISCAN$1 = 57;
		}
		goto label$316;
		label$337:;
		if( KEY$1 == 97 ) goto label$340;
		label$341:;
		if( KEY$1 != 65 ) goto label$339;
		label$340:;
		{
			ISCAN$1 = 30;
		}
		goto label$316;
		label$339:;
		if( KEY$1 == 98 ) goto label$343;
		label$344:;
		if( KEY$1 != 66 ) goto label$342;
		label$343:;
		{
			ISCAN$1 = 48;
		}
		goto label$316;
		label$342:;
		if( KEY$1 == 99 ) goto label$346;
		label$347:;
		if( KEY$1 != 67 ) goto label$345;
		label$346:;
		{
			ISCAN$1 = 46;
		}
		goto label$316;
		label$345:;
		if( KEY$1 == 100 ) goto label$349;
		label$350:;
		if( KEY$1 != 68 ) goto label$348;
		label$349:;
		{
			ISCAN$1 = 32;
		}
		goto label$316;
		label$348:;
		if( KEY$1 == 101 ) goto label$352;
		label$353:;
		if( KEY$1 != 69 ) goto label$351;
		label$352:;
		{
			ISCAN$1 = 18;
		}
		goto label$316;
		label$351:;
		if( KEY$1 == 102 ) goto label$355;
		label$356:;
		if( KEY$1 != 70 ) goto label$354;
		label$355:;
		{
			ISCAN$1 = 33;
		}
		goto label$316;
		label$354:;
		if( KEY$1 == 103 ) goto label$358;
		label$359:;
		if( KEY$1 != 71 ) goto label$357;
		label$358:;
		{
			ISCAN$1 = 34;
		}
		goto label$316;
		label$357:;
		if( KEY$1 == 104 ) goto label$361;
		label$362:;
		if( KEY$1 != 72 ) goto label$360;
		label$361:;
		{
			ISCAN$1 = 35;
		}
		goto label$316;
		label$360:;
		if( KEY$1 == 105 ) goto label$364;
		label$365:;
		if( KEY$1 != 73 ) goto label$363;
		label$364:;
		{
			ISCAN$1 = 23;
		}
		goto label$316;
		label$363:;
		if( KEY$1 == 106 ) goto label$367;
		label$368:;
		if( KEY$1 != 74 ) goto label$366;
		label$367:;
		{
			ISCAN$1 = 36;
		}
		goto label$316;
		label$366:;
		if( KEY$1 == 107 ) goto label$370;
		label$371:;
		if( KEY$1 != 75 ) goto label$369;
		label$370:;
		{
			ISCAN$1 = 37;
		}
		goto label$316;
		label$369:;
		if( KEY$1 == 108 ) goto label$373;
		label$374:;
		if( KEY$1 != 76 ) goto label$372;
		label$373:;
		{
			ISCAN$1 = 38;
		}
		goto label$316;
		label$372:;
		if( KEY$1 == 109 ) goto label$376;
		label$377:;
		if( KEY$1 != 77 ) goto label$375;
		label$376:;
		{
			ISCAN$1 = 50;
		}
		goto label$316;
		label$375:;
		if( KEY$1 == 110 ) goto label$379;
		label$380:;
		if( KEY$1 != 78 ) goto label$378;
		label$379:;
		{
			ISCAN$1 = 49;
		}
		goto label$316;
		label$378:;
		if( KEY$1 == 111 ) goto label$382;
		label$383:;
		if( KEY$1 != 79 ) goto label$381;
		label$382:;
		{
			ISCAN$1 = 24;
		}
		goto label$316;
		label$381:;
		if( KEY$1 == 112 ) goto label$385;
		label$386:;
		if( KEY$1 != 80 ) goto label$384;
		label$385:;
		{
			ISCAN$1 = 25;
		}
		goto label$316;
		label$384:;
		if( KEY$1 == 113 ) goto label$388;
		label$389:;
		if( KEY$1 != 81 ) goto label$387;
		label$388:;
		{
			ISCAN$1 = 16;
		}
		goto label$316;
		label$387:;
		if( KEY$1 == 114 ) goto label$391;
		label$392:;
		if( KEY$1 != 82 ) goto label$390;
		label$391:;
		{
			ISCAN$1 = 19;
		}
		goto label$316;
		label$390:;
		if( KEY$1 == 115 ) goto label$394;
		label$395:;
		if( KEY$1 != 83 ) goto label$393;
		label$394:;
		{
			ISCAN$1 = 31;
		}
		goto label$316;
		label$393:;
		if( KEY$1 == 116 ) goto label$397;
		label$398:;
		if( KEY$1 != 84 ) goto label$396;
		label$397:;
		{
			ISCAN$1 = 20;
		}
		goto label$316;
		label$396:;
		if( KEY$1 == 117 ) goto label$400;
		label$401:;
		if( KEY$1 != 85 ) goto label$399;
		label$400:;
		{
			ISCAN$1 = 22;
		}
		goto label$316;
		label$399:;
		if( KEY$1 == 118 ) goto label$403;
		label$404:;
		if( KEY$1 != 86 ) goto label$402;
		label$403:;
		{
			ISCAN$1 = 47;
		}
		goto label$316;
		label$402:;
		if( KEY$1 == 119 ) goto label$406;
		label$407:;
		if( KEY$1 != 87 ) goto label$405;
		label$406:;
		{
			ISCAN$1 = 17;
		}
		goto label$316;
		label$405:;
		if( KEY$1 == 120 ) goto label$409;
		label$410:;
		if( KEY$1 != 88 ) goto label$408;
		label$409:;
		{
			ISCAN$1 = 45;
		}
		goto label$316;
		label$408:;
		if( KEY$1 == 121 ) goto label$412;
		label$413:;
		if( KEY$1 != 89 ) goto label$411;
		label$412:;
		{
			ISCAN$1 = 21;
		}
		goto label$316;
		label$411:;
		if( KEY$1 == 122 ) goto label$415;
		label$416:;
		if( KEY$1 != 90 ) goto label$414;
		label$415:;
		{
			ISCAN$1 = 44;
		}
		goto label$316;
		label$414:;
		if( KEY$1 == 33 ) goto label$418;
		label$419:;
		if( KEY$1 != 49 ) goto label$417;
		label$418:;
		{
			ISCAN$1 = 2;
		}
		goto label$316;
		label$417:;
		if( KEY$1 == 64 ) goto label$421;
		label$422:;
		if( KEY$1 != 50 ) goto label$420;
		label$421:;
		{
			ISCAN$1 = 3;
		}
		goto label$316;
		label$420:;
		if( KEY$1 == 35 ) goto label$424;
		label$425:;
		if( KEY$1 != 51 ) goto label$423;
		label$424:;
		{
			ISCAN$1 = 4;
		}
		goto label$316;
		label$423:;
		if( KEY$1 == 36 ) goto label$427;
		label$428:;
		if( KEY$1 != 52 ) goto label$426;
		label$427:;
		{
			ISCAN$1 = 5;
		}
		goto label$316;
		label$426:;
		if( KEY$1 == 37 ) goto label$430;
		label$431:;
		if( KEY$1 != 53 ) goto label$429;
		label$430:;
		{
			ISCAN$1 = 6;
		}
		goto label$316;
		label$429:;
		if( KEY$1 == 94 ) goto label$433;
		label$434:;
		if( KEY$1 != 54 ) goto label$432;
		label$433:;
		{
			ISCAN$1 = 7;
		}
		goto label$316;
		label$432:;
		if( KEY$1 == 38 ) goto label$436;
		label$437:;
		if( KEY$1 != 55 ) goto label$435;
		label$436:;
		{
			ISCAN$1 = 8;
		}
		goto label$316;
		label$435:;
		if( KEY$1 == 42 ) goto label$439;
		label$440:;
		if( KEY$1 != 56 ) goto label$438;
		label$439:;
		{
			ISCAN$1 = 9;
		}
		goto label$316;
		label$438:;
		if( KEY$1 == 40 ) goto label$442;
		label$443:;
		if( KEY$1 != 57 ) goto label$441;
		label$442:;
		{
			ISCAN$1 = 10;
		}
		goto label$316;
		label$441:;
		if( KEY$1 == 41 ) goto label$445;
		label$446:;
		if( KEY$1 != 48 ) goto label$444;
		label$445:;
		{
			ISCAN$1 = 11;
		}
		goto label$316;
		label$444:;
		if( KEY$1 == 95 ) goto label$448;
		label$449:;
		if( KEY$1 != 45 ) goto label$447;
		label$448:;
		{
			ISCAN$1 = 12;
		}
		goto label$316;
		label$447:;
		if( KEY$1 == 43 ) goto label$451;
		label$452:;
		if( KEY$1 != 61 ) goto label$450;
		label$451:;
		{
			ISCAN$1 = 13;
		}
		goto label$316;
		label$450:;
		if( KEY$1 == 60 ) goto label$454;
		label$455:;
		if( KEY$1 != 44 ) goto label$453;
		label$454:;
		{
			ISCAN$1 = 51;
		}
		goto label$316;
		label$453:;
		if( KEY$1 == 62 ) goto label$457;
		label$458:;
		if( KEY$1 != 46 ) goto label$456;
		label$457:;
		{
			ISCAN$1 = 52;
		}
		goto label$316;
		label$456:;
		if( KEY$1 == 123 ) goto label$460;
		label$461:;
		if( KEY$1 != 91 ) goto label$459;
		label$460:;
		{
			ISCAN$1 = 26;
		}
		goto label$316;
		label$459:;
		if( KEY$1 == 125 ) goto label$463;
		label$464:;
		if( KEY$1 != 93 ) goto label$462;
		label$463:;
		{
			ISCAN$1 = 27;
		}
		goto label$316;
		label$462:;
		if( KEY$1 == 58 ) goto label$466;
		label$467:;
		if( KEY$1 != 59 ) goto label$465;
		label$466:;
		{
			ISCAN$1 = 39;
		}
		goto label$316;
		label$465:;
		if( KEY$1 == 34 ) goto label$469;
		label$470:;
		if( KEY$1 != 39 ) goto label$468;
		label$469:;
		{
			ISCAN$1 = 40;
		}
		goto label$316;
		label$468:;
		if( KEY$1 == 96 ) goto label$472;
		label$473:;
		if( KEY$1 != 126 ) goto label$471;
		label$472:;
		{
			ISCAN$1 = 41;
		}
		goto label$316;
		label$471:;
		if( KEY$1 == 124 ) goto label$475;
		label$476:;
		if( KEY$1 != 92 ) goto label$474;
		label$475:;
		{
			ISCAN$1 = 43;
		}
		goto label$316;
		label$474:;
		if( KEY$1 == 63 ) goto label$478;
		label$479:;
		if( KEY$1 != 47 ) goto label$477;
		label$478:;
		{
			ISCAN$1 = 53;
		}
		goto label$316;
		label$477:;
		if( KEY$1 < -128 ) goto label$480;
		if( KEY$1 > -1 ) goto label$480;
		label$481:;
		{
			ISCAN$1 = -KEY$1;
		}
		label$480:;
		label$316:;
	}
	if( KEY$1 <= 0 ) goto label$483;
	*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (KEY$1 << 1)) + 256) = (short)128;
	label$483:;
	integer vr$11050 = abs( ISCAN$1 );
	*(short*)((ubyte*)_ZN2FB10SCANSTATE$E + (vr$11050 << 1)) = (short)-1;
	if( (integer)_ZN2FB15SCREENECHOISON$E == 0 ) goto label$485;
	{
		if( KEY$1 <= 0 ) goto label$487;
		putchar( KEY$1 );
		label$487:;
	}
	label$485:;
	label$484:;
	label$315:;
}

static void ONKEYRELEASED( integer KEY$1 )
{
	label$488:;
	integer ISCAN$1;
	ISCAN$1 = KEY$1;
	{
		if( KEY$1 != -15 ) goto label$491;
		label$492:;
		{
			goto label$489;
		}
		goto label$490;
		label$491:;
		if( KEY$1 != -17 ) goto label$493;
		label$494:;
		{
			KEY$1 = -72;
			ISCAN$1 = 72;
		}
		goto label$490;
		label$493:;
		if( KEY$1 != -18 ) goto label$495;
		label$496:;
		{
			KEY$1 = -77;
			ISCAN$1 = 77;
		}
		goto label$490;
		label$495:;
		if( KEY$1 != -19 ) goto label$497;
		label$498:;
		{
			KEY$1 = -80;
			ISCAN$1 = 80;
		}
		goto label$490;
		label$497:;
		if( KEY$1 != -20 ) goto label$499;
		label$500:;
		{
			KEY$1 = -75;
			ISCAN$1 = 75;
		}
		goto label$490;
		label$499:;
		if( KEY$1 != -23 ) goto label$501;
		label$502:;
		{
			KEY$1 = 27;
			ISCAN$1 = 1;
		}
		goto label$490;
		label$501:;
		if( KEY$1 != 10 ) goto label$503;
		label$504:;
		{
			KEY$1 = 13;
			ISCAN$1 = 28;
		}
		goto label$490;
		label$503:;
		if( KEY$1 != -5 ) goto label$505;
		label$506:;
		{
			ISCAN$1 = 93;
		}
		goto label$490;
		label$505:;
		if( KEY$1 != 8 ) goto label$507;
		label$508:;
		{
			ISCAN$1 = 14;
		}
		goto label$490;
		label$507:;
		if( KEY$1 != 9 ) goto label$509;
		label$510:;
		{
			ISCAN$1 = 15;
		}
		goto label$490;
		label$509:;
		if( KEY$1 != 32 ) goto label$511;
		label$512:;
		{
			ISCAN$1 = 57;
		}
		goto label$490;
		label$511:;
		if( KEY$1 == 97 ) goto label$514;
		label$515:;
		if( KEY$1 != 65 ) goto label$513;
		label$514:;
		{
			ISCAN$1 = 30;
		}
		goto label$490;
		label$513:;
		if( KEY$1 == 98 ) goto label$517;
		label$518:;
		if( KEY$1 != 66 ) goto label$516;
		label$517:;
		{
			ISCAN$1 = 48;
		}
		goto label$490;
		label$516:;
		if( KEY$1 == 99 ) goto label$520;
		label$521:;
		if( KEY$1 != 67 ) goto label$519;
		label$520:;
		{
			ISCAN$1 = 46;
		}
		goto label$490;
		label$519:;
		if( KEY$1 == 100 ) goto label$523;
		label$524:;
		if( KEY$1 != 68 ) goto label$522;
		label$523:;
		{
			ISCAN$1 = 32;
		}
		goto label$490;
		label$522:;
		if( KEY$1 == 101 ) goto label$526;
		label$527:;
		if( KEY$1 != 69 ) goto label$525;
		label$526:;
		{
			ISCAN$1 = 18;
		}
		goto label$490;
		label$525:;
		if( KEY$1 == 102 ) goto label$529;
		label$530:;
		if( KEY$1 != 70 ) goto label$528;
		label$529:;
		{
			ISCAN$1 = 33;
		}
		goto label$490;
		label$528:;
		if( KEY$1 == 103 ) goto label$532;
		label$533:;
		if( KEY$1 != 71 ) goto label$531;
		label$532:;
		{
			ISCAN$1 = 34;
		}
		goto label$490;
		label$531:;
		if( KEY$1 == 104 ) goto label$535;
		label$536:;
		if( KEY$1 != 72 ) goto label$534;
		label$535:;
		{
			ISCAN$1 = 35;
		}
		goto label$490;
		label$534:;
		if( KEY$1 == 105 ) goto label$538;
		label$539:;
		if( KEY$1 != 73 ) goto label$537;
		label$538:;
		{
			ISCAN$1 = 23;
		}
		goto label$490;
		label$537:;
		if( KEY$1 == 106 ) goto label$541;
		label$542:;
		if( KEY$1 != 74 ) goto label$540;
		label$541:;
		{
			ISCAN$1 = 36;
		}
		goto label$490;
		label$540:;
		if( KEY$1 == 107 ) goto label$544;
		label$545:;
		if( KEY$1 != 75 ) goto label$543;
		label$544:;
		{
			ISCAN$1 = 37;
		}
		goto label$490;
		label$543:;
		if( KEY$1 == 108 ) goto label$547;
		label$548:;
		if( KEY$1 != 76 ) goto label$546;
		label$547:;
		{
			ISCAN$1 = 38;
		}
		goto label$490;
		label$546:;
		if( KEY$1 == 109 ) goto label$550;
		label$551:;
		if( KEY$1 != 77 ) goto label$549;
		label$550:;
		{
			ISCAN$1 = 50;
		}
		goto label$490;
		label$549:;
		if( KEY$1 == 110 ) goto label$553;
		label$554:;
		if( KEY$1 != 78 ) goto label$552;
		label$553:;
		{
			ISCAN$1 = 49;
		}
		goto label$490;
		label$552:;
		if( KEY$1 == 111 ) goto label$556;
		label$557:;
		if( KEY$1 != 79 ) goto label$555;
		label$556:;
		{
			ISCAN$1 = 24;
		}
		goto label$490;
		label$555:;
		if( KEY$1 == 112 ) goto label$559;
		label$560:;
		if( KEY$1 != 80 ) goto label$558;
		label$559:;
		{
			ISCAN$1 = 25;
		}
		goto label$490;
		label$558:;
		if( KEY$1 == 113 ) goto label$562;
		label$563:;
		if( KEY$1 != 81 ) goto label$561;
		label$562:;
		{
			ISCAN$1 = 16;
		}
		goto label$490;
		label$561:;
		if( KEY$1 == 114 ) goto label$565;
		label$566:;
		if( KEY$1 != 82 ) goto label$564;
		label$565:;
		{
			ISCAN$1 = 19;
		}
		goto label$490;
		label$564:;
		if( KEY$1 == 115 ) goto label$568;
		label$569:;
		if( KEY$1 != 83 ) goto label$567;
		label$568:;
		{
			ISCAN$1 = 31;
		}
		goto label$490;
		label$567:;
		if( KEY$1 == 116 ) goto label$571;
		label$572:;
		if( KEY$1 != 84 ) goto label$570;
		label$571:;
		{
			ISCAN$1 = 20;
		}
		goto label$490;
		label$570:;
		if( KEY$1 == 117 ) goto label$574;
		label$575:;
		if( KEY$1 != 85 ) goto label$573;
		label$574:;
		{
			ISCAN$1 = 22;
		}
		goto label$490;
		label$573:;
		if( KEY$1 == 118 ) goto label$577;
		label$578:;
		if( KEY$1 != 86 ) goto label$576;
		label$577:;
		{
			ISCAN$1 = 47;
		}
		goto label$490;
		label$576:;
		if( KEY$1 == 119 ) goto label$580;
		label$581:;
		if( KEY$1 != 87 ) goto label$579;
		label$580:;
		{
			ISCAN$1 = 17;
		}
		goto label$490;
		label$579:;
		if( KEY$1 == 120 ) goto label$583;
		label$584:;
		if( KEY$1 != 88 ) goto label$582;
		label$583:;
		{
			ISCAN$1 = 45;
		}
		goto label$490;
		label$582:;
		if( KEY$1 == 121 ) goto label$586;
		label$587:;
		if( KEY$1 != 89 ) goto label$585;
		label$586:;
		{
			ISCAN$1 = 21;
		}
		goto label$490;
		label$585:;
		if( KEY$1 == 122 ) goto label$589;
		label$590:;
		if( KEY$1 != 90 ) goto label$588;
		label$589:;
		{
			ISCAN$1 = 44;
		}
		goto label$490;
		label$588:;
		if( KEY$1 == 33 ) goto label$592;
		label$593:;
		if( KEY$1 != 49 ) goto label$591;
		label$592:;
		{
			ISCAN$1 = 2;
		}
		goto label$490;
		label$591:;
		if( KEY$1 == 64 ) goto label$595;
		label$596:;
		if( KEY$1 != 50 ) goto label$594;
		label$595:;
		{
			ISCAN$1 = 3;
		}
		goto label$490;
		label$594:;
		if( KEY$1 == 35 ) goto label$598;
		label$599:;
		if( KEY$1 != 51 ) goto label$597;
		label$598:;
		{
			ISCAN$1 = 4;
		}
		goto label$490;
		label$597:;
		if( KEY$1 == 36 ) goto label$601;
		label$602:;
		if( KEY$1 != 52 ) goto label$600;
		label$601:;
		{
			ISCAN$1 = 5;
		}
		goto label$490;
		label$600:;
		if( KEY$1 == 37 ) goto label$604;
		label$605:;
		if( KEY$1 != 53 ) goto label$603;
		label$604:;
		{
			ISCAN$1 = 6;
		}
		goto label$490;
		label$603:;
		if( KEY$1 == 94 ) goto label$607;
		label$608:;
		if( KEY$1 != 54 ) goto label$606;
		label$607:;
		{
			ISCAN$1 = 7;
		}
		goto label$490;
		label$606:;
		if( KEY$1 == 38 ) goto label$610;
		label$611:;
		if( KEY$1 != 55 ) goto label$609;
		label$610:;
		{
			ISCAN$1 = 8;
		}
		goto label$490;
		label$609:;
		if( KEY$1 == 42 ) goto label$613;
		label$614:;
		if( KEY$1 != 56 ) goto label$612;
		label$613:;
		{
			ISCAN$1 = 9;
		}
		goto label$490;
		label$612:;
		if( KEY$1 == 40 ) goto label$616;
		label$617:;
		if( KEY$1 != 57 ) goto label$615;
		label$616:;
		{
			ISCAN$1 = 10;
		}
		goto label$490;
		label$615:;
		if( KEY$1 == 41 ) goto label$619;
		label$620:;
		if( KEY$1 != 48 ) goto label$618;
		label$619:;
		{
			ISCAN$1 = 11;
		}
		goto label$490;
		label$618:;
		if( KEY$1 == 95 ) goto label$622;
		label$623:;
		if( KEY$1 != 45 ) goto label$621;
		label$622:;
		{
			ISCAN$1 = 12;
		}
		goto label$490;
		label$621:;
		if( KEY$1 == 43 ) goto label$625;
		label$626:;
		if( KEY$1 != 61 ) goto label$624;
		label$625:;
		{
			ISCAN$1 = 13;
		}
		goto label$490;
		label$624:;
		if( KEY$1 == 60 ) goto label$628;
		label$629:;
		if( KEY$1 != 44 ) goto label$627;
		label$628:;
		{
			ISCAN$1 = 51;
		}
		goto label$490;
		label$627:;
		if( KEY$1 == 62 ) goto label$631;
		label$632:;
		if( KEY$1 != 46 ) goto label$630;
		label$631:;
		{
			ISCAN$1 = 52;
		}
		goto label$490;
		label$630:;
		if( KEY$1 == 123 ) goto label$634;
		label$635:;
		if( KEY$1 != 91 ) goto label$633;
		label$634:;
		{
			ISCAN$1 = 26;
		}
		goto label$490;
		label$633:;
		if( KEY$1 == 125 ) goto label$637;
		label$638:;
		if( KEY$1 != 93 ) goto label$636;
		label$637:;
		{
			ISCAN$1 = 27;
		}
		goto label$490;
		label$636:;
		if( KEY$1 == 58 ) goto label$640;
		label$641:;
		if( KEY$1 != 59 ) goto label$639;
		label$640:;
		{
			ISCAN$1 = 39;
		}
		goto label$490;
		label$639:;
		if( KEY$1 == 34 ) goto label$643;
		label$644:;
		if( KEY$1 != 39 ) goto label$642;
		label$643:;
		{
			ISCAN$1 = 40;
		}
		goto label$490;
		label$642:;
		if( KEY$1 == 96 ) goto label$646;
		label$647:;
		if( KEY$1 != 126 ) goto label$645;
		label$646:;
		{
			ISCAN$1 = 41;
		}
		goto label$490;
		label$645:;
		if( KEY$1 == 124 ) goto label$649;
		label$650:;
		if( KEY$1 != 92 ) goto label$648;
		label$649:;
		{
			ISCAN$1 = 43;
		}
		goto label$490;
		label$648:;
		if( KEY$1 == 63 ) goto label$652;
		label$653:;
		if( KEY$1 != 47 ) goto label$651;
		label$652:;
		{
			ISCAN$1 = 53;
		}
		goto label$490;
		label$651:;
		if( KEY$1 < -128 ) goto label$654;
		if( KEY$1 > -1 ) goto label$654;
		label$655:;
		{
			ISCAN$1 = -KEY$1;
		}
		label$654:;
		label$490:;
	}
	if( KEY$1 <= 0 ) goto label$657;
	*(short*)(((ubyte*)_ZN2FB10CODESTATE$E + (KEY$1 << 1)) + 256) = (short)0;
	label$657:;
	integer vr$11055 = abs( ISCAN$1 );
	*(short*)((ubyte*)_ZN2FB10SCANSTATE$E + (vr$11055 << 1)) = (short)0;
	*(short*)((ubyte*)_ZN2FB10SCANSTATE$E + 28) = (short)0;
	label$489:;
}

static void* memcpy( void* PTARGET$1, void* PSOURCE$1, uinteger IAMOUNT$1 )
{
	void* fb$result$1;
	__builtin_memset( &fb$result$1, 0, 4 );
	label$666:;
	__asm__ __volatile__( "ldr  r0,  %0\n"  "ldr  r1,  %1\n"  "ldr  r2,  %2\n"  "cmp  r2,  #0\n"  "ble  9f\n"  "cmp  r2,  #7\n"  "bhi  4f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "strb  r3,  [r1],#1\n"  "b  9f\n"  "4:and  r4,r1,#3\n"  "orr  r4,r0,LSL  #30\n"  "and  r0,#-4\n"  "and  r1,#-4\n"  "ldr  r3,8f\n"  "ldr  r15,[r3,r4,ROR  #28]\n"  "0:  subs  r2,  #32\n"  "blo  4f\n"  "ldmia  r0  !,{r3-r10}\n"  "stmia  r1  !,{r3-r10}\n"  "b  0b\n"  "4:adds  r2,  #32\n"  "beq  9f\n"  "5:subs  r2,  #16\n"  "blo  4f\n"  "ldmia  r0  !,{r3,r4,r5,r6}\n"  "stmia  r1  !,{r3,r4,r5,r6}\n"  "subs  r2,  #16\n"  "blo  4f\n"  "ldmia  r0  !,{r6,r7,r8,r9}\n"  "stmia  r1  !,{r6,r7,r8,r9}\n"  "b  5b\n"  "4:adds  r2,  #16\n"  "beq  9f\n"  "5:subs  r2,  #4\n"  "blo  6f\n"  "ldr  r6,[r0],#4\n"  "str  r6,[r1],#4\n"  "subs  r2,  #4\n"  "blo  6f\n"  "ldr  r6,[r0],#4\n"  "str  r6,[r1],#4\n"  "b  5b\n"  "6:adds  r2,#4\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "strb  r3,  [r1],#1\n"  "b  9f\n"  "1:  subs  r2,  #16\n"  "blo  4f\n"  "ldmia  r0  !,  {r5-r9}\n"  "5:mov  r4,  r5,  LSR  #8\n"  "orr  r4,  r6,  LSL  #24\n"  "mov  r5,  r6,  LSR  #8\n"  "orr  r5,  r7,  LSL  #24\n"  "mov  r6,  r7,  LSR  #8\n"  "orr  r6,  r8,  LSL  #24\n"  "mov  r7,  r8,  LSR  #8\n"  "orr  r7,  r9,  LSL  #24\n"  "stmia  r1  !,{r4-r7}\n"  "mov  r5,r9\n"  "subs  r2,  #16\n"  "ldmplia  r0  !,{r6-r9}\n"  "bpl  5b\n"  "adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  7f\n"  "ldr  r6,  [r0],#4\n"  "b  5f\n"  "4:adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  6f\n"  "ldmia  r0  !,{r5,r6}\n"  "5:mov  r4,  r5,  LSR  #8\n"  "orr  r4,  r6,  LSL  #24\n"  "str  r4,[r1],#4\n"  "mov  r5,r6\n"  "subs  r2,  #4\n"  "ldrpl  r6,  [r0],#4\n"  "bpl  5b\n"  "7:adds  r2,  #4\n"  "beq  9f\n"  "lsr  r5,  #8\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "lsr  r5,  #8\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "lsr  r5,  #8\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "6:adds  r2,#4\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "strb  r3,  [r1],#1\n"  "b  9f\n"  "2:  subs  r2,  #16\n"  "blo  4f\n"  "ldmia  r0  !,  {r5-r9}\n"  "5:mov  r4,  r5,  LSR  #16\n"  "orr  r4,  r6,  LSL  #16\n"  "mov  r5,  r6,  LSR  #16\n"  "orr  r5,  r7,  LSL  #16\n"  "mov  r6,  r7,  LSR  #16\n"  "orr  r6,  r8,  LSL  #16\n"  "mov  r7,  r8,  LSR  #16\n"  "orr  r7,  r9,  LSL  #16\n"  "stmia  r1  !,{r4-r7}\n"  "mov  r5,r9\n"  "subs  r2,  #16\n"  "ldmplia  r0  !,{r6-r9}\n"  "bpl  5b\n"  "adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  7f\n"  "ldr  r6,  [r0],#4\n"  "b  5f\n"  "4:adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  6f\n"  "ldmia  r0  !,{r5,r6}\n"  "5:mov  r4,  r5,  LSR  #16\n"  "orr  r4,  r6,  LSL  #16\n"  "str  r4,[r1],#4\n"  "mov  r5,r6\n"  "subs  r2,  #4\n"  "ldrpl  r6,  [r0],#4\n"  "bpl  5b\n"  "7:adds  r2,  #4\n"  "beq  9f\n"  "lsr  r5,  #16\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "lsr  r5,  #8\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "ldrb  r5,  [r0]\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "6:adds  r2,#4\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "strb  r3,  [r1],#1\n"  "b  9f\n"  "3:  subs  r2,  #16\n"  "blo  4f\n"  "ldmia  r0  !,  {r5-r9}\n"  "5:mov  r4,  r5,  LSR  #24\n"  "orr  r4,  r6,  LSL  #8\n"  "mov  r5,  r6,  LSR  #24\n"  "orr  r5,  r7,  LSL  #8\n"  "mov  r6,  r7,  LSR  #24\n"  "orr  r6,  r8,  LSL  #8\n"  "mov  r7,  r8,  LSR  #24\n"  "orr  r7,  r9,  LSL  #8\n"  "stmia  r1  !,{r4-r7}\n"  "mov  r5,r9\n"  "subs  r2,  #16\n"  "ldmplia  r0  !,{r6-r9}\n"  "bpl  5b\n"  "adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  7f\n"  "ldr  r6,  [r0],#4\n"  "b  5f\n"  "4:adds  r2,  #16\n"  "beq  9f\n"  "subs  r2,  #4\n"  "blo  6f\n"  "ldmia  r0  !,{r5,r6}\n"  "5:mov  r4,  r5,  LSR  #24\n"  "orr  r4,  r6,  LSL  #8\n"  "str  r4,[r1],#4\n"  "mov  r5,r6\n"  "subs  r2,  #4\n"  "ldrpl  r6,  [r0],#4\n"  "bpl  5b\n"  "7:adds  r2,  #4\n"  "beq  9f\n"  "lsr  r5,  #24\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "ldr  r5,[r0]\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "lsr  r5,  #8\n"  "subs  r2,  #1\n"  "strb  r5,  [r1],#1\n"  "beq  9f\n"  "6:adds  r2,#4\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "subs  r2,  #1\n"  "strb  r3,  [r1],#1\n"  "beq  9f\n"  "ldrb  r3,  [r0],#1\n"  "strb  r3,  [r1],#1\n"  "b  9f\n"  "10:  ldr  r4,  [r0]\n"  "ldr  r5,  [r1]\n"  "and  r5,  #0xFF\n"  "sub  r2,  #3\n"  "orr  r5,  r4,  LSL  #8\n"  "str  r5,  [r1],#4\n"  "b  3b\n"  "11:  ldr  r4,  [r0,#1]\n"  "ldr  r5,  [r1]\n"  "and  r5,  #0xFF\n"  "sub  r2,  #3\n"  "orr  r5,  r4,  LSL  #8\n"  "str  r5,  [r1],#4\n"  "add  r0,  #4\n"  "b  0b\n"  "12:  ldrh  r4,  [r0,#2]\n"  "ldrb  r6,  [r0,#4]!\n"  "ldr  r5,  [r1]\n"  "and  r5,  #0xFF\n"  "sub  r2,  #3\n"  "orr  r4,  r6,  LSL  #16\n"  "orr  r5,  r4,  LSL  #8\n"  "str  r5,  [r1],#4\n"  "b  1b\n"  "13:  ldrb  r4,  [r0,#3]\n"  "ldrh  r6,  [r0,#4]!\n"  "ldr  r5,  [r1]\n"  "and  r5,  #0xFF\n"  "sub  r2,  #3\n"  "orr  r4,  r6,  LSL  #8\n"  "orr  r5,  r4,  LSL  #8\n"  "str  r5,  [r1],#4\n"  "b  2b\n"  "8:   .word  8f\n"  "8:.word  0b\n"  ".word  1b\n"  ".word  2b\n"  ".word  3b\n"  ".word  10b\n"  ".word  11b\n"  ".word  12b\n"  ".word  13b\n"  ".word  20f\n"  ".word  21f\n"  ".word  22f\n"  ".word  23f\n"  ".word  30f\n"  ".word  31f\n"  ".word  32f\n"  ".word  33f\n"  "20:  ldrh  r4,  [r0]\n"  "sub  r2,  #2\n"  "strh  r4,  [r1,#2]\n"  "add  r1,#4\n"  "b  2b\n"  "21:  ldr  r4,  [r0,#1]\n"  "sub  r2,  #2\n"  "strh  r4,  [r1,#2]\n"  "add  r1,#4\n"  "b  3b\n"  "22:  ldrh  r4,  [r0,#2]\n"  "sub  r2,  #2\n"  "strh  r4,  [r1,#2]\n"  "add  r1,#4\n"  "add  r0,#4\n"  "b  0b\n"  "23:  ldrb  r4,  [r0,#3]\n"  "ldrb  r5,  [r0,#4]!\n"  "sub  r2,  #2\n"  "orr  r4,  r5,  LSL  #8\n"  "strh  r4,  [r1,#2]\n"  "add  r1,#4\n"  "b  1b\n"  "30:  ldrb  r4,  [r0]\n"  "sub  r2,  #1\n"  "strb  r4,  [r1,#3]\n"  "add  r1,#4\n"  "b  1b\n"  "31:  ldrb  r4,  [r0,#1]\n"  "sub  r2,  #1\n"  "strb  r4,  [r1,#3]\n"  "add  r1,#4\n"  "b  2b\n"  "32:  ldrb  r4,  [r0,#2]\n"  "sub  r2,  #1\n"  "strb  r4,  [r1,#3]\n"  "add  r1,#4\n"  "b  3b\n"  "33:  ldrb  r4,  [r0,#3]\n"  "sub  r2,  #1\n"  "strb  r4,  [r1,#3]\n"  "add  r1,#4\n"  "add  r0,#4\n"  "b  0b\n"  "9:\n"  :   : "m" (PSOURCE$1) , "m" (PTARGET$1) , "m" (IAMOUNT$1)  : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"   );
	fb$result$1 = (void*)0;
	goto label$667;
	label$667:;
	return fb$result$1;
}

static void FB_EXCEPTION( void )
{
	label$2852:;
	printf( (char*)"\nException!!! \n" );
	fb_Sleep( -1 );
	label$2853:;
}

static void _ZN12PARSERSTRUCTC1Ev( struct PARSERSTRUCT* THIS$1 )
{
	__builtin_memset( (string*)THIS$1, 0, 12 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 12), 0, 4 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 16), 0, 4 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 20), 0, 4 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 24), 0, 4 );
	*(long*)((ubyte*)THIS$1 + 28) = -1;
	*(long*)((ubyte*)THIS$1 + 32) = 0;
	__builtin_memset( (long*)((ubyte*)THIS$1 + 36), 0, 4 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 40), 0, 4 );
	__builtin_memset( (long*)((ubyte*)THIS$1 + 44), 0, 4 );
	*(long*)((ubyte*)THIS$1 + 48) = 1536;
	*(long*)((ubyte*)THIS$1 + 52) = 1536;
	label$3819:;
	label$3820:;
}

static void _ZN12PARSERSTRUCTaSERS_( struct PARSERSTRUCT* THIS$1, struct PARSERSTRUCT* __FB_RHS__$1 )
{
	label$3823:;
	string* vr$11079 = fb_StrAssign( (void*)THIS$1, -1, (void*)__FB_RHS__$1, -1, 0 );
	*(long*)((ubyte*)THIS$1 + 12) = *(long*)((ubyte*)__FB_RHS__$1 + 12);
	*(long*)((ubyte*)THIS$1 + 16) = *(long*)((ubyte*)__FB_RHS__$1 + 16);
	*(long*)((ubyte*)THIS$1 + 20) = *(long*)((ubyte*)__FB_RHS__$1 + 20);
	*(long*)((ubyte*)THIS$1 + 24) = *(long*)((ubyte*)__FB_RHS__$1 + 24);
	*(long*)((ubyte*)THIS$1 + 28) = *(long*)((ubyte*)__FB_RHS__$1 + 28);
	*(long*)((ubyte*)THIS$1 + 32) = *(long*)((ubyte*)__FB_RHS__$1 + 32);
	*(long*)((ubyte*)THIS$1 + 36) = *(long*)((ubyte*)__FB_RHS__$1 + 36);
	*(long*)((ubyte*)THIS$1 + 40) = *(long*)((ubyte*)__FB_RHS__$1 + 40);
	*(long*)((ubyte*)THIS$1 + 44) = *(long*)((ubyte*)__FB_RHS__$1 + 44);
	*(long*)((ubyte*)THIS$1 + 48) = *(long*)((ubyte*)__FB_RHS__$1 + 48);
	*(long*)((ubyte*)THIS$1 + 52) = *(long*)((ubyte*)__FB_RHS__$1 + 52);
	label$3824:;
}

static void _ZN12PARSERSTRUCTD1Ev( struct PARSERSTRUCT* THIS$1 )
{
	label$3825:;
	label$3826:;
	fb_StrDelete( (string*)THIS$1 );
}

static void _ZN3CPU7CPUCOREC1Ev( struct CPU$CPUCORE* THIS$1 )
{
	__builtin_memset( (ubyte*)THIS$1, 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 1), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 2), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 3), 0, 1 );
	__builtin_memset( (struct CPU$CPUFLAGS*)((ubyte*)THIS$1 + 4), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 5), 0, 1 );
	__builtin_memset( (ushort*)((ubyte*)THIS$1 + 6), 0, 2 );
	__builtin_memset( (ushort*)((ubyte*)THIS$1 + 8), 0, 2 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 10), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 11), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 12), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 13), 0, 1 );
	__builtin_memset( (ubyte*)((ubyte*)THIS$1 + 14), 0, 1 );
	*(ulong*)((ubyte*)THIS$1 + 16) = 1024u;
	__builtin_memset( (ulong*)((ubyte*)THIS$1 + 20), 0, 4 );
	__builtin_memset( (ulong*)((ubyte*)THIS$1 + 24), 0, 4 );
	__builtin_memset( (ulong*)((ubyte*)THIS$1 + 28), 0, 4 );
	label$4730:;
	label$4731:;
}

                               static void _GLOBAL__I( void )
{
	label$5395:;
	_ZN12PARSERSTRUCTC1Ev( &G_TPARSER$ );
	_ZN3CPU7CPUCOREC1Ev( &_ZN3CPU7G_TCPU$E );
	label$5396:;
}

__attribute__(( destructor )) static void _GLOBAL__D( void )
{
	label$5398:;
	_ZN12PARSERSTRUCTD1Ev( &G_TPARSER$ );
	label$5399:;
}

// Total compilation time: 0.2982921463374737 seconds.
