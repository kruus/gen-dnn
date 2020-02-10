#include <stdlib.h>
#include <stdio.h>

struct pair
{
    int first;
    int second;
};

void dirty_stack() {
    unsigned char array_on_stack[1000];
    unsigned a = (unsigned)'a';
    for (unsigned i = 0; i < 1000; ++i){
        unsigned u = (unsigned)(i);
        array_on_stack[i] = (unsigned char)('a' + a%26);
        a = ((a<<13)|(a>>19)) + u;
    }
    // prevent compiler from ignoring 'array_on_stack'
    printf("\nPlease ignore this dirty_stack() data:\n%s\n", array_on_stack);
}    


typedef int pair::*ptr_to_member_type;

struct ptr_to_member_struct
{ ptr_to_member_type data; };

struct foo
{
    ptr_to_member_struct a;

    foo() : a() {}

    void check() const
    { if(a.data != 0) abort(); }
};

int main(void)
{
    dirty_stack();
    foo().check();
    printf("\nGoodbye: clang-7139 struct init bug test PASSED!\n\n");
} 
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
