/*******************************************************************************
* Copyright 2019 NEC Labs America
*
* BSD 2-clause license (as in vednn project)
*******************************************************************************/
#ifndef CONSISTENCY_HPP
#define CONSISTENCY_HPP
/** \file
 * We provide macros for consistency checks that are:
 *
 * - quiet [default]
 * - verbose
 *   - print failure location in debug mode,
 *   - for -DNDEBUG compile with -DDISABLE_VERBOSE, never print
 *   - for -DNDEBUG compile o/w, print if bit 3 is set: `mkldnn_verbose() & 0x04`
 *     - this is a questionable extension of mkldnn_set_verbose(int level)
 * - very verbose [print failure location even if -DNDEBUG
 *
 * For optimized compile (-DNEBUG) default must be to never print stuff,
 * but for temporary file scope debug you can choose a more verbose macro
 */

#include "verbose.hpp"
#include <cstdio>
#include <cstdlib>

namespace mkldnn {
namespace impl {

struct CondLoc { // Quiet default: never print, so struct is simpler
    bool cond;
};
// Q:: could templating this allow one to store the generic type of the evaluated expression
//     for futher downstream use?   Ex. evaluate condition *and* store (say) mkldnn_status?
struct CondLocV { // CondLoc with "verbose in debug compile" hint
    bool cond;
#if !defined(DISABLE_VERBOSE)
    char const* file;
    int line;
    char const* cond_msg;
#endif
};
struct CondLocVV { // CondLoc with "verbose always" hint (even in optimized -DNDEBUG mode)
    bool cond;
    char const* file;
    int line;
    char const* cond_msg;
};

/** \group Condition_Location macros */
//@{
#define COND_LOC(...) CondLoc{bool{!!(__VA_ARGS__)}}

#if !defined(DISABLE_VERBOSE)
/** verbose for debug: always, for opt: use \c (*mkldnn_verbose() & 0x04) flag */
#define COND_LOCV(...) CondLocV{bool{!!(__VA_ARGS__)}, __FILE__, __LINE__, #__VA_ARGS__}
#else
#define COND_LOCV(...) CondLocV{bool{!!(__VA_ARGS__)}}
#endif

/** CONV_LOCVV is always there, even for optimized compiles,
 * so use this very rarely, or for very serious failures. */
#define COND_LOCVV(...) CondLocVV{bool{!!(__VA_ARGS__)}, __FILE__, __LINE__, #__VA_ARGS__}
//@}

/** consistency checking helper.  Used with "AND_WANT(COND)", rather than "&& COND",
 * you can print out nicer failure checks. NDEBUG turns off all printing.
 *
 * Note: macro support is required for short-circuiting
 * C++ member function operator&& DOES NOT short-circuit !!!
 *
 * (So maybe I should avoid operator&& and use a function call?  But intended use
 * will just use macros, so file-level verbosity can be easily controlled, so it's
 * not so important an issue).
 */
struct Consistency {
    /** defaults to silent operation \c (pfx==nullptr).
     * Why? 1st test for nullptr means later checks could segfault.
     * You can change to not short-circuit, to allow reporting multiple failed checks,
     * either later via \c chk(), or when destructor runs. */
    Consistency(char const* pfx="Inconsistent!")
        : pfx(pfx), var(true)
    {}
    /** destructor is silent now that messages are printed 'as encountered' */
    ~Consistency() {
    }
    /** change the failure output pfx */
    void set_pfx(char const* newpfx) { if(newpfx) this->pfx = newpfx; }
    /** Using '&& COND_LOC(cond)' never prints [default behavior] */
    Consistency& operator &&(CondLoc const& cl){
        var = var && cl.cond;
        return *this;
    }
    /** Using '&& COND_LOCV(cond)' prints in debug mode [not if -DNDEBUG] */
    Consistency& operator &&(CondLocV const& cl){
        var = var && cl.cond;
        // 1. always print failures in debug compile.
        // 2. if -DNDEBUG and not -DDISABLE_VERBOSE,
        //    then check 3rd LSB of mkldnn runtime verbosity
#if !defined(DISABLE_VERBOSE)
        if (!cl.cond
#if defined(NDEBUG)
                // optimized compile can still use MKLDNN_VERBOSE=N bit 2 to to print consistency failures
                && (mkldnn_verbose()->level & 0x04)
#endif
           ){
            fprintf(stdout," %s [%s:%d] %s\n",
                    pfx, /*nclause,*/ cl.file, cl.line, cl.cond_msg);
            fflush(stdout);
        }
#endif
        return *this;
    }
    /** Using '&& COND_LOCVV(cond)' [V for verbose] prints always [even if -DNDEBUG] */
    Consistency& operator &&(CondLocVV const& cl){
        if (!cl.cond){
            var = false;
            fprintf(stdout," %s [%s:%d] %s\n",
                    pfx, /*nclause,*/ cl.file, cl.line, cl.cond_msg);
            fflush(stdout);
        }
        return *this;
    }
    operator bool (){ return var; }
  private:
    char const* pfx;
    bool var;
};
}//impl::
}//mkldnn::
/** \group Consistency Check macros
 * {S|A}CHK[V|VV] macros wrap printing behavior of consistency checks
 *        S=Short-circuit [default]
 *        A=All (run all checks, do not short-circuit, might be dangerous)
 *        quiet is default (never print)
 *        V=Verbose[print unless -DNDEBUG=1].
 *        V=Verbose[even print fails for -DNDEBUG=1].
 * suggested usage:
 * ```
 * Consistency ok;
 * SCHK(ok,foo!=nullptr); // repeat for other (short-circuited) checks
 * SCHK(ok,foo->bar==0);
 * ```
 * \c ok then casts to bool, as usual
 *
 * If you find a need to debug consistency checks in some file, then you might:
 * ```
 * #define MYCHK SCHKVV // very-verbose, switch back to SCHK when done debugging
 * Consistency ok;  // optionally override the warning string with a constructor parm
 * MYCHK(ok,cond1);
 * MYCHK(ok,cond2);
 * #undef MYCHK
 * ```
 *
 * If something should always be checked, (i.e. it throws an exception for which you want
 * slightly better debug output in debug compiles) you can give a better prefix on the message:
 * ```
 * Consistency ok("VIP thingamajig error:");
 * SCHKV(ok,cond1);
 * ```
 * or SCHKVV if the check will only run rarely.
 *
 * If you don't need short-circuited eval, you can detect multiple failed checks
 * with the ACHKVV [or ACHKV or ACHK] macros, which always evaluate the condition
 */
//@{
// "All"-check versions (not short-circuited) are easy,
// because we can use Consistency::operator&&
#define ACHK(CONSISTENCY,...) (bool)(CONSISTENCY && COND_LOC(__VA_ARGS__))
#define ACHKV(CONSISTENCY,...) (bool)(CONSISTENCY && COND_LOCV(__VA_ARGS__))
#define ACHKVV(CONSISTENCY,...) (bool)(CONSISTENCY && COND_LOCVV(__VA_ARGS__))
//
// Short-circuiting requires punting back to the C++ default "&&" operator
//#define SCHK(CONSISTENCY,...) do{ if(CONSISTENCY) { CONSISTENCY && COND_LOC(__VA_ARGS__); }}while(0)
//#define SCHKV(CONSISTENCY,...) do{ if(CONSISTENCY) { CONSISTENCY && COND_LOCV(__VA_ARGS__); }}while(0)
// ... or the ternary operator (for slightly more usage freedom) ...
#define SCHK(OK,...) (bool)((!OK)? OK: OK && COND_LOC(__VA_ARGS__))
#define SCHKV(OK,...) (bool)((!OK)? OK: OK && COND_LOCV(__VA_ARGS__))
#define SCHKVV(OK,...) (bool)((!OK)? OK: OK && COND_LOCVV(__VA_ARGS__))

/** Often \c Consistency variable is named 'ok',
 * so provide a default macro verbose for debug compilation.
 * NOTE: please do not commit with this set to SCHKVV.
 *       releases should use SCHKV, for fastest optimized code. */
#define OK_AND(...) SCHKVV(ok,__VA_ARGS__)

/** like CHECK from \ref utils.hpp , returning error code immediately, but using
 * 'Consistency ok;', to inherit failure printing in debug compiles. */
#define OK_CHECK(f) do { \
    status_t status; \
    OK_AND((status = (f)) == status::success); \
    if (ok) \
    return status; \
} while (0)

///@}

//----------------------------- normal end of header ----------------------------------------
#if defined MAIN

#include <iostream>
using namespace std;
using namespace mkldnn::impl

int main(int,char**){
    cout<<"CONSPRINT="<<CONSPRINT<<endl;
    int const b=7; // lucky seven
    int a=0;
    {
        bool ok = Consistency()         // this idiom DOES NOT SHORT-CIRCUIT
            && 1==1
            && 2==2
            && 3==33                    // Inconsistent! &&-clause #3
            && 4==4
            && (a=3,a==b) // expression list
            && (a=5,a==b)               // Inconstent!  &&-clause #6
            ;
        cout<<"normal A ok "<<ok<<endl;
    }
    {
        Consistency ok;
        (!ok? ok: ok && 1==1);          // could use ternary operator to short-circuit
        (!ok? ok: ok && 1==111);        // Inconsistent! &&-clause #2
        (!ok? ok: ok && 1==1);          // not evaluated...
        (!ok? ok: ok && 1==111);
        (!ok? ok: ok && 1==1);
        cout<<"normal B ok "<<ok<<endl;
    }
        // All CHecK, Short-circuiting CHecK, and Verbose versions
        // fooV verbose macro ONLY affects the normally-silent optimized compile
    {
        Consistency ok;                 // normal output: (silent if -DNDEBUG)
        SCHK(ok,1==1);
        SCHK(ok,a=13,a==b);             // Inconsistent! #2[a.cpp:193] a=13,a==b   SILENT
        SCHK(ok,1==1);
        SCHK(ok,1==3);                  // short-circuited
        SCHK(ok,a=7,a==b);
        cout<<"SCHK A ok "<<ok<<endl;
    }
    {
        Consistency ok("SCHK alt"); // alternate syntax (ok if use ternary operator to short-circuit)
        SCHK(ok,1==1)
        && SCHK(ok,a=13,a==b)             // Inconsistent! #2[a.cpp:193] a=13,a==b   SILENT
        && SCHK(ok,1==1)
        && SCHK(ok,1==3)                  // short-circuited
        && SCHK(ok,a=7,a==b)
        ;
        cout<<"SCHK alt ok "<<ok<<endl;
    }
    {
#define MYCHK SCHKV
        Consistency ok("SCHKV");        // verbose output: (also verbose if -DNDEBUG)
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"SCHKV ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK SCHKVV
        Consistency ok("SCHKVV");        // verbose output: (also verbose if -DNDEBUG)
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"SCHKVV ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK SCHKVV
        Consistency ok;        // same, but use default message
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"SCHKVV ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK ACHK
        Consistency ok("ACHK");        // verbose output: (also verbose if -DNDEBUG)
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"ACHK ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK ACHKV
        Consistency ok("ACHKV");        // verbose output: (also verbose if -DNDEBUG)
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"ACHKV ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK ACHKVV
        Consistency ok("ACHKVV");        // verbose output: (also verbose if -DNDEBUG)
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"ACHKVV ok "<<ok<<endl;
#undef MYCHK
    }
    {
#define MYCHK ACHKVV
        Consistency ok;        // same but use default message
        MYCHK(ok,1==1);
        MYCHK(ok,a=13,a==b);            // SCHKV #2[a.cpp:203] a=13,a==b
        MYCHK(ok,1==1);
        MYCHK(ok,a==7,a==b);            // short-circuited
        MYCHK(ok,1==1);
        cout<<"ACHKVV ok "<<ok<<endl;
#undef MYCHK
    }
}
#endif
// vim: et ts=4 sw=4 cindent cino=^=l0,\:0,N-s
#endif // CONSISTENCY_HPP
