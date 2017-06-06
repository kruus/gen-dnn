#include <cstdio>
#include <iostream>
using namespace std;

/** show sxc++ bug with snprintf behavior when compiling with
 * -Cdebug or -Cnoopt. */
int main(int,char**)
{
#define BUFLEN 5
    char buf[BUFLEN];
    char *ptr; int rem;
#define AGAIN do{ ptr=&buf[0]; rem=BUFLEN; }while(0)
    int r;
#define TRY(STRING) do{ \
    cout<<"buf["<<BUFLEN<<"], rem="<<rem<<" snprintf(&buf["<<ptr-&buf[0]<<"],"<<rem<<","<<STRING<<")"; \
    r = snprintf(ptr,rem,STRING); \
    if(r<=0) cout<<" [BAD: snprintf returned "<<r<<"]"; \
    ptr += r; \
    if( r >= rem ) rem=0; else rem -= r; \
    cout<<" --> <"<<buf<<">, r="<<r<<", new ptr=buf["<<ptr-&buf[0]<<"], "<<"rem="<<rem<<endl; \
}while(0)
    //
    AGAIN; TRY("four"); TRY("!"); TRY("oops");
    AGAIN; TRY("hello"); TRY("!");
    AGAIN; TRY("wee"); TRY("d"); TRY("s");
    AGAIN; TRY("Wor"); TRY("ld"); TRY("oops");
    cout<<"\nGoodbye"<<endl;
}
