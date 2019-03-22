/*****************************************************/
/* Various timer routines.                           */
/* Al Aburto, aburto@nosc.mil, 18 Feb 1997           */
/*                                                   */
/* t = dtime() outputs the current time in seconds.  */
/* Use CAUTION as some of these routines will mess   */
/* up when timing across the hour mark!!!            */
/*                                                   */
/* For timing I use the 'user' time whenever         */
/* possible. Using 'user+sys' time is a separate     */
/* issue.                                            */
/*                                                   */
/* Example Usage:                                    */
/* [timer options added here]                        */
/* main()                                            */
/* {                                                 */
/* double starttime,benchtime,dtime();               */
/*                                                   */
/* starttime = dtime();                              */
/* [routine to time]                                 */
/* benchtime = dtime() - starttime;                  */
/* }                                                 */
/*                                                   */
/* [timer code below added here]                     */
/*****************************************************/

/***************************************************************/
/* Timer options. You MUST uncomment one of the options below  */
/* or compile, for example, with the '-DUNIX' option.          */
/***************************************************************/
/* #define TIMER_Amiga       */
/* #define TIMER_UNIX        */
/* #define TIMER_UNIX_Old    */
/* #define TIMER_VMS         */
/* #define TIMER_BORLAND_C   */
/* #define TIMER_MSC         */
/* #define TIMER_MAC         */
/* #define TIMER_IPSC        */
/* #define TIMER_FORTRAN_SEC */
/* #define TIMER_GTODay      */
/* #define TIMER_CTimer      */
/* #define TIMER_UXPM        */
/* #define TIMER_MAC_TMgr    */
/* #define TIMER_MAC_OSX     */
/* #define TIMER_MACH_OSX    */
/* #define TIMER_PARIX       */
/* #define TIMER_POSIX9      */
/* #define TIMER_WIN32_Old   */
/* #define TIMER_WIN32       */ //Already defined in Visual C
/* #define TIMER_POSIX6      */
/* #define TIMER_RISCOS      */
/* #define TIMER_VISUAL      */
/* #define TIMER_CODEWARRIOR */
/* #define TIMER_DEC_ALPHA   */
/* #define TIMER_LINUX       */
/***********************/
#include <math.h>

//#include "def.h"
#include "timers_b.h"
/*********************************/
/* Timer code.                   */
/*********************************/
/*******************/
/*  Amiga dtime()  */
/*******************/
#ifdef TIMER_Amiga
#include <ctype.h>
#define HZ 50
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 struct tt
       {
	long  days;
	long  minutes;
	long  ticks;
       } tt;
 DateStamp(&tt);
 q = ((double)(tt.ticks + (tt.minutes * 60L * 50L))) / (double)HZ;
 return q;
}
#endif
/*****************************************************/
/*  UNIX dtime(). This is the preferred UNIX timer.  */
/*  Provided by: Markku Kolkka, mk59200@cc.tut.fi    */
/*  HP-UX Addition by: Bo Thide', bt@irfu.se         */
/*****************************************************/
#ifdef TIMER_UNIX
#include <sys/time.h>
#include <sys/resource.h>
#ifdef hpux
#include <sys/syscall.h>
#define getrusage(a,b) syscall(SYS_getrusage,a,b)
#endif
struct rusage rusage;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 getrusage(RUSAGE_SELF,&rusage);
 q = (double)(rusage.ru_utime.tv_sec);
 q = q + (double)(rusage.ru_utime.tv_usec) * 1.0e-06;
 return q;
}
#endif
/***************************************************/
/*  UNIX_Old dtime(). This is the old UNIX timer.  */
/*  Make sure HZ is properly defined in param.h !! */
/***************************************************/
#ifdef TIMER_UNIX_Old
#include <sys/types.h>
//#include <times.h>
#include <sys/param.h>
#ifndef HZ
#define HZ 60
#endif
struct tms tms;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 times(&tms);
 q = (double)(tms.tms_utime) / (double)HZ;
 return q;
}
#endif
/*********************************************************/
/*  VMS dtime() for VMS systems.                         */
/*  Provided by: RAMO@uvphys.phys.UVic.CA                */
/*  Some people have run into problems with this timer.  */
/*********************************************************/
#ifdef TIMER_VMS
#include time

#ifndef HZ
#define HZ 100
#endif

struct tbuffer_t
      {
       int proc_user_time;
       int proc_system_time;
       int child_user_time;
       int child_system_time;
      };

struct tbuffer_t tms;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 times(&tms);
 q = (double)(tms.proc_user_time) / (double)HZ;
 return q;
}
#endif
/******************************/
/*  BORLAND C dtime() for DOS */
/******************************/
#ifdef TIMER_BORLAND_C
#include <ctype.h>
#include <dos.h>
#include <time.h>

#define HZ 100
struct time tnow;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 gettime(&tnow);
 q = 60.0 * (double)(tnow.ti_min);
 q = q + (double)(tnow.ti_sec);
 q = q + (double)(tnow.ti_hund)/(double)HZ;
 return q;
}
#endif
/**************************************/
/*  Microsoft C (MSC) dtime() for DOS */
/**************************************/
#ifdef TIMER_MSC
#include <time.h>
#include <ctype.h>
#define HZ CLOCKS_PER_SEC
clock_t tnow;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 tnow = clock();
 q = (double)tnow / (double)HZ;
 return q;
}
#endif
/*************************************/
/*  Macintosh (MAC) Think C dtime()  */
/*************************************/
#ifdef TIMER_MAC
#include <time.h>

#define HZ 60

/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 q = (double)clock() / (double)HZ;
 return q;
}
#endif
/************************************************************/
/*  iPSC/860 (IPSC) dtime() for i860.                       */
/*  Provided by: Dan Yergeau, yergeau@gloworm.Stanford.EDU  */
/************************************************************/
#ifdef TIMER_IPSC
extern double dclock();
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 q = dclock();
 return q;
}
#endif
/**************************************************/
/*  FORTRAN dtime() for Cray type systems.        */
/*  This is the preferred timer for Cray systems. */
/**************************************************/
#ifdef TIMER_FORTRAN_SEC
fortran double second();
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 second(&q);
 return q;
}
#endif
/***********************************************************/
/*  UNICOS C dtime() for Cray UNICOS systems.  Don't use   */
/*  unless absolutely necessary as returned time includes  */
/*  'user+system' time.  Provided by: R. Mike Dority,      */
/*  dority@craysea.cray.com                                */
/***********************************************************/
#ifdef TIMER_CTimer
#include <time.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
 double    q;
 clock_t   clock(void);
 q = (double)clock() / (double)CLOCKS_PER_SEC;
 return q;
}
#endif
/********************************************/
/* Another UNIX timer using gettimeofday(). */
/* However, getrusage() is preferred.       */
/********************************************/
#ifdef TIMER_GTODay
#include <stdlib.h>
#include <sys/time.h>
struct timeval tnow;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 gettimeofday(&tnow,NULL);
 q = (double)tnow.tv_sec + (double)tnow.tv_usec * 1.0e-6;
 return q;
}
#endif
/*****************************************************/
/*  Fujitsu UXP/M timer.                             */
/*  Provided by: Mathew Lim, ANUSF, M.Lim@anu.edu.au */
/*****************************************************/
#ifdef TIMER_UXPM
#include <sys/types.h>
#include <sys/timesu.h>
struct tmsu rusage;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 timesu(&rusage);
 q = (double)(rusage.tms_utime) * 1.0e-06;
 return q;
}
#endif
/**********************************************/
/*    Macintosh (MAC_TMgr) Think C dtime()    */
/*   requires Think C Language Extensions or  */
/*    #include <MacHeaders> in the prefix     */
/*  provided by Francis H Schiffer 3rd (fhs)  */
/*         skipschiffer@genie.geis.com        */
/**********************************************/
#ifdef TIMER_MAC_TMgr
#include <Timer.h>
#include <stdlib.h>

static TMTask   mgrTimer;
static Boolean  mgrInited = false;
static double   mgrClock;

#define RMV_TIMER RmvTime( (QElemPtr)&mgrTimer )
#define MAX_TIME  1800000000L
/* MAX_TIME limits time between calls to */
/* dtime( ) to no more than 30 minutes   */
/* this limitation could be removed by   */
/* creating a completion routine to sum  */
/* 30 minute segments (fhs 1994 feb 9)   */

static void Remove_timer( )
{
 RMV_TIMER;
 mgrInited = false;
}

double  dtime( )
{
 if( mgrInited ) {
   RMV_TIMER;
   mgrClock += (MAX_TIME + mgrTimer.tmCount)*1.0e-6;
 } else {
   if( _atexit( &Remove_timer ) == 0 ) mgrInited = true;
   mgrClock = 0.0;
 }

 if ( mgrInited )
   {
    mgrTimer.tmAddr = NULL;
    mgrTimer.tmCount = 0;
    mgrTimer.tmWakeUp = 0;
    mgrTimer.tmReserved = 0;
    InsTime( (QElemPtr)&mgrTimer );
    PrimeTime( (QElemPtr)&mgrTimer, -MAX_TIME );
   }
 return( mgrClock );
}
#endif
/***********************************************************/
/*  Parsytec GCel timer.                                   */
/*  Provided by: Georg Wambach, gw@informatik.uni-koeln.de */
/***********************************************************/
#ifdef TIMER_PARIX
#include <sys/time.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 q = (double) (TimeNowHigh()) / (double) CLK_TCK_HIGH;
 return q;
}
#endif
/************************************************/
/*  Sun Solaris POSIX dtime() routine           */
/*  Provided by: Case Larsen, CTLarsen.lbl.gov  */
/************************************************/
#ifdef TIMER_POSIX9
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/rusage.h>

#ifdef __hpux
#include <sys/syscall.h>
#endif

struct rusage rusage;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;

 getrusage(RUSAGE_SELF,&rusage);

 q = (double)(rusage.ru_utime.tv_sec);
 q = q + (double)(rusage.ru_utime.tv_nsec) * 1.0e-09;

 return q;
}
#endif
/********************************************************************/
/*  Sun Solaris POSIX dtime() routine                               */
/*  Provided by: Lionel Lacassagne http://www.ief.u-psud.fr/~lacas  */
/* for machine with only 1e-6 POSIX timer                           */
/********************************************************************/
#ifdef TIMER_POSIX6
#include <sys/time.h>
#include <sys/resource.h>
//#include <sys/rusage.h>
#ifdef __hpux
#include <sys/syscall.h>
#endif
struct rusage rusage;
/* ------------- */
double dtime(void)
/* ------------- */
{
    double q;
    getrusage(RUSAGE_SELF,&rusage);
    q = (double)(rusage.ru_utime.tv_sec);
    q = q + (double)(rusage.ru_utime.tv_usec) * 1.0e-06;

    return q;
}
#endif
/****************************************************/
/*  Windows NT (32 bit) dtime() routine             */
/*  Provided by: Piers Haken, piersh@microsoft.com  */
/****************************************************/
#ifdef TIMER_WIN32_Old
#include <windows.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 q = (double)GetTickCount() * 1.0e-03;
 return q;
}
#endif
/********************************************************************/
/*  Windows NT (32 bit) dtime() routine for Visual CodeWarrior      */
/*  Provided by: Lionel Lacassagne lionel.lacassagne@lis.jussieu.fr */
/********************************************************************/
#ifdef TIMER_WIN32
#ifndef TIMER_WIN32_Old
#include <math.h>
#include <windows.h>
#include <winnt.h>
#include <winbase.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
  double q;
  static double f;
  static int    first_time = 1;
  static LARGE_INTEGER ticks_count;
  static LARGE_INTEGER liFrequency;

  if(first_time) {
    QueryPerformanceFrequency(&liFrequency);
    f = (double)liFrequency.HighPart * 4294967296.0 +
        (double)liFrequency.LowPart;
    f = 1.0 / f;
    first_time=0;
  }

  QueryPerformanceCounter(&ticks_count);
  q = (double)ticks_count.HighPart * 4294967296.0 +
      (double)ticks_count.LowPart;

  return(q*f);
}
/* ***************************************************/
/* readTSC: reads the TimeStampCounter               */
/* Provided by: by Richard Heathfield                */
/* web: http://www.ese-metz.fr/~dedu/docs/timer.html */
/* link: http://www.csd.uu.se/~mikpe/linux/perfctr   */
/* link: http://icl.cs.utk.edu/projects/papi         */
/* ***************************************************/
/* ------------------- */
__int64 i64cycle0 (void)
/* ------------------ */
{
  _int64 t;
  unsigned int a,b;
  unsigned int *c = (unsigned int *)&t;
  _asm {
    _emit 0x0f;
    _emit 0x31;
    mov a,eax;
    mov b,edx;
  }
  c[0]=a;c[1]=b;
  return t;
}

#endif
#endif

#if defined(TIMER_WIN32)
#ifndef TIMER_WIN32_Old
#include <math.h>
#include <windows.h>
#include <winnt.h>
#include <winbase.h>
/* ***************************************************/
/* readTSC: reads the TimeStampCounter               */
/* Provided by:  Daniel Etiemble                     */
/* web: http://www.lri.fr/~de                        */
/* ***************************************************/
#define CPUID __asm __emit 0fh __asm __emit 0a2h
#define RDTSC __asm __emit 0fh __asm __emit 031h
/* ------------------------ */
unsigned __int64 readTSC(void)
/* ------------------------ */
{
	// for compatibility with previous version

    unsigned cycles_low, cycles_high;
    __asm {
        pushad
        CPUID
        RDTSC
        mov	cycles_high, edx
        mov	cycles_low, eax
        popad
				}
    return ((unsigned __int64)cycles_high << 32) | cycles_low;
}

/* -------------------------- */
unsigned __int64 i64cycle(void)
/* -------------------------- */
{
    unsigned cycles_low, cycles_high;
    __asm {
        pushad
        CPUID
        RDTSC
        mov	cycles_high, edx
        mov	cycles_low, eax
        popad
				}
    return ((unsigned __int64)cycles_high << 32) | cycles_low;
}
/* ------------- */
double dcycle(void)
/* ------------- */
{
	return (double) i64cycle();
}
#endif // TIMER_WIN32_Old
#endif // TIMER_WIN32

//#if defined(__APPLE__) && defined(i386)
#if defined(_i386_) || defined(__x86_64__)
#include <math.h>
/* ***************************************************/
/* readTSC: reads the TimeStampCounter               */
/* Provided by:  Daniel Etiemble                     */
/* web: http://www.lri.fr/~de                        */
/* ***************************************************/
#define CPUID __asm __emit 0fh __asm __emit 0a2h
#define RDTSC __asm __emit 0fh __asm __emit 031h
/* ------------------------------ */
unsigned long long int readTSC(void)
/* ------------------------------ */
{
    long long t;
    asm volatile (".byte 0x0f,0x31" : "=A" (t));
    return t;
}
/* ------------------------------- */
unsigned long long int i64cycle(void)
/* ------------------------------- */
{
    long long t;
    asm volatile (".byte 0x0f,0x31" : "=A" (t));
    return t;
}
/* ------------- */
double dcycle(void)
/* ------------- */
{
    int a;
	return (double) i64cycle();
}
#endif
/*****************************************************/
/* Time according to POSIX.1  -  <J.Pelan@qub.ac.uk> */
/* Ref: "POSIX Programmer's Guide"  O'Reilly & Assoc.*/
/*****************************************************/
#ifdef TIMER_POSIX1
#define _POSIX_SOURCE 1
#include <unistd.h>
#include <limits.h>
#include <sys/times.h>
struct tms tms;
/* ------------ */
double dtime(void)
/* ------------ */
{
 double q;
 times(&tms);
 q = (double)tms.tms_utime / (double)CLK_TCK;
 return q;
}
#endif
/********************************************************************/
/*  RISC-OS dtime() routine                                         */
/*  Provided by: Lionel Lacassagne lionel.lacassagne@lis.jussieu.fr */
/********************************************************************/
#ifdef TIMER_RISCOS
#include <time.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
  double q, f;
  f = (double) CLOCKS_PER_SEC;
  q = (double) clock();
  return(f/q);
}
#endif
/********************************************************************/
/*  DEC_ALPHA dtime() routine                                       */
/*  Provided by: Lionel Lacassagne lionel.lacassagne@lis.jussieu.fr */
/*  (include realtime library during link with -lrt)                */
/********************************************************************/
#ifdef TIMER_DEC_ALPHA
#include <time.h>
#include <timers.h>
/* ------------ */
double dtime(void)
/* ------------ */
{
  struct timespec tp;
  double q;
  clock_gettime(CLOCK_REALTIME, &tp);
  q = (double) tp.tv_sec + 1.0e-9 * (double) tp.tv_nsec;/**/
  return q;
}
#endif
/*********************************************************************/
/*  LINUX readTSC routine                                            */
/*  Provided by: Guillaume Girard                                    */
/*  www.delorie.com/djgpp/doc/brennan/brennan_att_inline_djgpp.html) */
/*********************************************************************/

#ifdef TIMER_LINUX0
// The following macro reads the TimeStampCounter on the Pentium
//   and puts the 64 bit result into llptr.
#define RDTSC(llptr) ({ \
__asm__ __volatile__ ( \
        ".byte 0x0f; .byte 0x31" \
        : "=A" (llptr) \
        : : "eax", "edx"); })
// Reads the TimeStampCounter on the Pentium and returns a 64 bit result.
// usage: printf ("%qi\n", prectime());
// Received from Guillaume Girard
/* ------------------- */
long long i64cycle (void)
/* ------------------- */
{
  long long t;
  asm (".byte 0x0f,0x31"  /* opcode 0x0f31 */
       : "=A" (t)         /* output parameters : edx:eax -> t */
       :                  /* no input register */
       : "%eax", "%edx"); /* registers destroyed in asm */
  return t;
}
#endif // TIMER_LINUX0
/********************************************************************/
/*  LINUX routine                                                   */
/*  Provided by: Guillaume Girard                                   */
/********************************************************************/
#ifdef TIMER_LINUX
/* ------------------- */
long long i64cycle (void)
/* ------------------- */
{
  long long t;
  asm volatile (".byte 0x0f,0x31" : "=A" (t));
  return t;
}
#endif
/********************************************************************/
/*  MIPS SGI's Processor routine                                    */
/*  Provided by: Xavier Cavin                                       */
/********************************************************************/
#if defined(TIMER_MIPS) || defined(TIMER_SGI)
#include <time.h>
__uint64_t readTSC (void)
{
  struct timespec tp;
  clock_gettime (CLOCK_SGI_CYCLE, &tp);
  return (__uint64_t)(tp.tv_sec * (__uint64_t)1000000000) + (__uint64_t)tp.tv_nsec;
}
/* ------------ */
double dtime(void)
/* ------------ */
{
  return (double) (readTSC()/1000000.0);
}
#endif
/********************************************************************/
/* MAC OS X timer                                                   */
/* Provided by: Loic Oudot                                          */
/********************************************************************/
#ifdef TIMER_MAC_OSX
//#if defined(TIMER_MAC_OSX) || defined(__APPLE_CC__) || defined(__APPLE__)
//#include <CoreServices/CoreServices.h>

//Timer.h
/* ------------ */
double dtime(void)
/* ------------ */
{
    double lo, hi;
    UnsignedWide t;

    Microseconds(&t);
    lo = (double) t.lo;
    hi = (double) t.hi
    return (lo + 4294967296.0 * hi)*1e-6;
}
#endif
///********************************************************************/
///* MACH OS X timer                                                  */
///* Provided by: Ian Ollmann, Ph.D. iano@cco.caltech.edu             */
///* based on a post on SIMDTech.org                                  */
///********************************************************************/
//#if (defined(TIMER_MACH_OSX) || defined(__APPLE__)) && !defined(MAC_OSX) && !defined(TIMER_POSIX6)
//#include <stdint.h>
//#include <string.h> // memset
//#include <mach/mach_time.h>
////Framework Kernel
//
///* ------------ */
//double dtime(void)
///* ------------ */
//{
//    static int first_time = 1;
//    static double conversion = 0.0;
//
//
//    static mach_timebase_info_data_t timebase;
//    static kern_return_t err;
//
//    uint64_t t = mach_absolute_time();
//
//    if(first_time) {
//        memset( &timebase, 0, sizeof( timebase ));
//        err = mach_timebase_info( &timebase );
//        //if( 0 != err ) return err;
//        if(err != 0) return 0.0;
//        conversion = 1e-9 * (double) timebase.numer / (double) timebase.denom;
//        //printf("numer = %d denom = %d\n", timebase.numer, timebase.denom);
//        first_time = 0;
//    }
//    return conversion * (double) t;/**/
//}
//#endif

/********************************************************************/
/* PowerPC cycle                                                    */
/* Provided by: Kazutomo Yoshii  kazutomo at mcs.anl.gov            */
/* http://www.mcs.anl.gov/~kazutomo/rdtsc.html                      */
/*                                                                  */
/********************************************************************/
#if defined(_ARCH_PPC)
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
// keyword "static" has been removed

#define PPC_TB 75
//#define PPC_TB 1
/* ------------------------------------- */
__inline__ unsigned long long readTSC(void)
/* ------------------------------------- */
{
    unsigned long long int result=0;
    unsigned long int upper, lower,tmp;
    __asm__ volatile(
                     "0:                  \n"
                     "\tmftbu   %0           \n"
                     "\tmftb    %1           \n"
                     "\tmftbu   %2           \n"
                     "\tcmpw    %2,%0        \n"
                     "\tbne     0b         \n"
                     : "=r"(upper),"=r"(lower),"=r"(tmp)
                     );
    result = upper;
    result = result<<32;
    result = result|lower;

    return(result*PPC_TB);
}

/* -------------------------------------- */
__inline__ unsigned long long i64cycle(void)
/* -------------------------------------- */
{
    unsigned long long int result=0;
    unsigned long int upper, lower,tmp;
    __asm__ volatile(
                     "0:                  \n"
                     "\tmftbu   %0           \n"
                     "\tmftb    %1           \n"
                     "\tmftbu   %2           \n"
                     "\tcmpw    %2,%0        \n"
                     "\tbne     0b         \n"
                     : "=r"(upper),"=r"(lower),"=r"(tmp)
                     );
    result = upper;
    result = result<<32;
    result = result|lower;

    return(75*result*PPC_TB);
}
/* ------------- */
double dcycle(void)
/* ------------- */
{
    unsigned long long int result=0;
    unsigned long int upper, lower,tmp;
    __asm__ volatile(
                     "0:                  \n"
                     "\tmftbu   %0           \n"
                     "\tmftb    %1           \n"
                     "\tmftbu   %2           \n"
                     "\tcmpw    %2,%0        \n"
                     "\tbne     0b         \n"
                     : "=r"(upper),"=r"(lower),"=r"(tmp)
                     );
    result = upper;
    result = result<<32;
    result = result|lower;

    return (double)(result*PPC_TB);
}
#undef PPC_TB
#endif

#if defined(TIMER_WIN64)
#include <time.h>

double dtime(void)
/* ------------ */
{
	clock_t t1;
	t1 = clock();
	return ( ((double)t1)/CLOCKS_PER_SEC);
}
#endif
