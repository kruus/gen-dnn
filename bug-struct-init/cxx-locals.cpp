/** \file
 * This only tests some extremely simple cases. */
#include <stddef.h>

extern "C" {
extern int hash; // print at exit to try avoiding over-optimization
extern int clobberhash_impl(char const* const p, size_t const psz);
}

extern "C" {
struct A {
	int a;
    int z;
	//int pad[1023];
    //int pad[257];
};
struct B {
	int B;
	A a;
};
}//extern "C"

#include <iostream>
#include <iomanip>
using namespace std;

inline size_t nz_bytes(char const* const p, size_t psz){
    size_t nz = 0U;
    for(size_t i=0; i<psz; ++i){
        if( p[i] != '\0' ) ++nz;
    }
    return nz;
}

template<typename T>
inline size_t nz_bytes(T const* const t){
    char const* const p = reinterpret_cast<char const*>(t);
    size_t const psz = sizeof(T);
    return nz_bytes(p, psz);
};

/** clobber memory, setting it to nonzero characters, modifying "C" 'hash', and
 * returning number of original non-zero chars in memory region of \c t. */
template<typename T>
inline int clobberhash(T * const t){
    char * const p = reinterpret_cast<char *>(t);
    size_t const psz = sizeof(T);
    return clobberhash_impl(p, psz);
}
    
struct NullBuffer : public std::streambuf
{
    // the function called when buffer needs to output data
    int overflow(int c) { return c; }
};
NullBuffer null_buffer;
std::ostream no_out(&null_buffer);

inline ostream& check(bool cond, char const* str, char const* file, size_t line){
    if(cond){
        return no_out;
    }else{
        cout<<"\n"<<file<<":"<<line<<" failed check "<<str<<" ";
        return cout;
    }
}
#define EXPAND(...) __VA_ARGS__
#define CHECK(...) check((EXPAND(__VA_ARGS__)),#__VA_ARGS__,__FILE__,__LINE__)
#define SHOW(STUFF) do{cout<<right<<setw(30)<<#STUFF<<left<<" "<<STUFF<<endl;}while(0)
int main(int,char**){
    int bogus = 0;
#if defined(__ve) // compile with -minit-stack=0xbadfaced or something
    if(1){
        A a;
        B b;
        SHOW(sizeof(A));
        SHOW(sizeof(B));
        SHOW(nz_bytes(&a));
        // surprise: nc++ zeroed very simple cases where it does not strictly need to.
        // (independent of -minit-zero=0xdeadbeef or zero setting).
        // But this is not really an error :)
        CHECK(nz_bytes(&a) == sizeof(A))
                <<" MAY be indeterminate, but not required. "<<endl;
        SHOW(nz_bytes(&b));
        CHECK(nz_bytes(&b) == sizeof(B))
                <<" MAY be indeterminate, but not required. "<<endl;
    }
#endif
    if(1){
        char name[16]=""; // C++ must zero-initialize excess chars
        //SHOW(nz_bytes(&name[0], 16));
        CHECK(nz_bytes(&name[0], 16) == 0)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
        char len8[16]="12345678";
        //SHOW( nz_bytes(&len8[0], 16));
        CHECK(nz_bytes(&len8[0], 16) == 8U)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
        bogus += clobberhash(name);
        bogus += clobberhash(len8);
        bogus += clobberhash(name);
        bogus += clobberhash(len8);
    }
    if(1){
        char name[16]=""; // C++ must zero-initialize excess chars
        CHECK(nz_bytes(&name[0], 16) == 0)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
        char len8[16]="12345678";
        CHECK(nz_bytes(&len8[0], 16) == 8)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
        bogus += clobberhash(name);
        bogus += clobberhash(len8);
    }
    if(1){ // statics always get initialized
        static A static_a;
        CHECK(nz_bytes(&static_a) == 0)
                <<"statics always get initialized"<<endl;
        static B static_b;
        CHECK(nz_bytes(&static_b) == 0)
                <<"statics always get initialized"<<endl;
    }
    // value-initialization for non-union class type without constuctors:
    //
    // value-initialization was introduced in c++03. Before that, default intialization
    // was equivalent to new T() and specified zero-initialization.
    // Before C++11 the way to value-initialize was "T object = T();"
    //
    // < c++11: "otherwise zero-initialized" (not statics or base class)
    // >= c++11: object zero-initialized and then if nontrivial, [implicit] default constructor
    // >= c++14: (as above, but after zero-initialization, also do nontrivial default
    //           initialization if the default constructor is deleted).
    //
    // The key is that zero-intialization MUST be performed before default
    // intialization.  Even if default initialization is a no-op.
    //
    // default-intialized means:
    // >= c++11: default constructor is called.
    //   A and B may use the Trivial default constructor (no-op)
    //   all C types (POD) are trivially constructible
    //
    // T{} [after c++11] is mostly equivalent to T(),
    //    except if aggregate-initialization makes sense.
    //
    if(1){ // nameless temporary T() is value-initialized (any C++)
        auto a = A();
        auto b =B();
        SHOW(nz_bytes(&a));
        SHOW(nz_bytes(&b));
        CHECK(nz_bytes(&a) == 0) // nc++ -minit-stack=0xbad4face FAILURES
                <<"assign from nameless A() must be value-initialized"<<endl;
        CHECK(nz_bytes(&b) == 0)
                <<"assign from nameless A() must be value-initialized"<<endl;
        bogus += clobberhash(&a);
        bogus += clobberhash(&b);
    }
    // if CXX zeroes stack frame, repeating *might* be a stronger test...
    if(1){ // nameless temporary T() is value-initialized (any C++)
        auto a = A();
        auto b =B();
        SHOW(nz_bytes(&a));
        SHOW(nz_bytes(&b));
        CHECK(nz_bytes(&a) == 0) // nc++ -minit-stack=0xbad4face FAILURES
                <<"assign from nameless A() must be value-initialized"<<endl;
        CHECK(nz_bytes(&b) == 0)
                <<"assign from nameless A() must be value-initialized"<<endl;
        bogus += clobberhash(&a);
        bogus += clobberhash(&b);
    }
    if(1){ // nameless temporary T{} is value-initialized (>= c++11)
        auto a = A{};   // aggregate-init N/A
        auto b =B{};
        SHOW(nz_bytes(&a));
        SHOW(nz_bytes(&b));
        CHECK(nz_bytes(&a) == 0)
                <<"assign from nameless A() must be value-initialized"<<endl;
        CHECK(nz_bytes(&b) == 0)
                <<"assign from nameless A() must be value-initialized"<<endl;
    }
    cout<<"\nGoodbye -- bogus = "<<bogus<<endl;

}//"C"

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
