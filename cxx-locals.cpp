
#include <iostream>
extern "C" {

struct A {
	int a;
	int pad[15];
};

struct B {
	int B;
	A a;
};

inline size_t nz_bytes(char const* const p, size_t psz){
    size_t nz = 0U;
    for(size_t i=0; i<psz; ++i){
        if( p[i] != '\0' ) ++nz;
    }
    return nz;
}

template<typename T>
inline size_t nz_bytes(typename T const* const t){
    size_t nz=0U;
    char const* const p = reinterpret_cast<char const*>(t);
    size_t const psz = sizeof(T);
    return nz_bytes(p, psz);
};

struct NullBuffer : public std::streambuf
{
    // the function called when buffer needs to output data
    int overflow(int c) { return c; }
};
NullBuffer null_buffer;
std::ostream no_out(&null_buffer)

using namespace std;
inline ostream& check(bool cond, char const* str, char const* file, size_t line){
    if(cond){
        cout<<"\n"<<file<<":"<<line<<" failed check "<<str<<" ";
        return cout;
    }else{
        return no_out;
    }
}
#define CHECK(COND) check(COND,#COND,__FILE__,__LINE__)
int main(int,char**){
#if defined(__ve) // compile with -minit-stack=0xdecabbed or something
    if(1){
        A a;
        B b;
        CHECK(nz_bytes(&a) == sizeof(A))
                <<" should b all-garbage with nc++ -minit-stack=0xdeadbeef"<<endl;
        CHECK(nz_bytes(&b) == sizeof(B))
                <<" should b all-garbage with nc++ -minit-stack=0xdeadbeef"<<endl;
    }
#endif
    if(1){
        char const name[16]=""; // C++ must zero-initialize excess chars
        CHECK(nz_bytes(&name[0], 16) == 16)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
        char const len8[16]="12345678";
        CHECK(nz_bytes(&len8[0], 16) == 8)
                <<"C++ must initialized remainder of char X[n]="" with zeroes"<<endl;
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
        CHECK(nz_bytes(&a) == 0)
                <<"assign from nameless A() must be value-intiialized"<<endl;
        auto b =B();
        CHECK(nz_bytes(&a) == 0)
                <<"assign from nameless A() must be value-intiialized"<<endl;
    }
    if(1){ // nameless temporary T{} is value-initialized (>= c++11)
        auto a = A{};
        CHECK(nz_bytes(&a) == 0)
                <<"assign from nameless A() must be value-intiialized"<<endl;
        auto b =B{};
        CHECK(nz_bytes(&a) == 0)
                <<"assign from nameless A() must be value-intiialized"<<endl;
    }

}//"C"

// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
