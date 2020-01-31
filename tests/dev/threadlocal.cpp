#include <iostream>
#include <mutex>
#include <thread>

using namespace std;
mutex coutMutex; // shared with all threads

#if 0 //defined(__ve)
//
// This is copied from https://github.com/llvm-mirror/libcxxabi/blob/master/src/cxa_thread_atexit.cpp
//
namespace {
// This implementation is used if the C library does not provide
// __cxa_thread_atexit_impl() for us.  It has a number of limitations that are
// difficult to impossible to address without ..._impl():
//
// - dso_symbol is ignored.  This means that a shared library may be unloaded
//   (via dlclose()) before its thread_local destructors have run.
//
// - thread_local destructors for the main thread are run by the destructor of
//   a static object.  This is later than expected; they should run before the
//   destructors of any objects with static storage duration.
//
// - thread_local destructors on non-main threads run on the first iteration
//   through the __libccpp_tls_key destructors.
//   std::notify_all_at_thread_exit() and similar functions must be careful to
//   wait until the second iteration to provide their intended ordering
//   guarantees.
//
// Another limitation, though one shared with ..._impl(), is that any
// thread_locals that are first initialized after non-thread_local global
// destructors begin to run will not be destroyed.  [basic.start.term] states
// that all thread_local destructors are sequenced before the destruction of
// objects with static storage duration, resulting in a contradiction if a
// thread_local is constructed after that point.  Thus we consider such
// programs ill-formed, and don't bother to run those destructors.  (If the
// program terminates abnormally after such a thread_local is constructed,
// the destructor is not expected to run and thus there is no contradiction.
// So construction still has to work.)

struct DtorList {
    Dtor dtor;
    void* obj;
    DtorList* next;
};

// The linked list of thread-local destructors to run
__thread DtorList* dtors = nullptr;
// True if the destructors are currently scheduled to run on this thread
__thread bool dtors_alive = false;
// Used to trigger destructors on thread exit; value is ignored
std::__libcpp_tls_key dtors_key;

void run_dtors(void*) {
    while (auto head = dtors) {
        dtors = head->next;
        head->dtor(head->obj);
        ::free(head);
    }

    dtors_alive = false;
}

struct DtorsManager {
    DtorsManager() {
        // There is intentionally no matching std::__libcpp_tls_delete call, as
        // __cxa_thread_atexit() may be called arbitrarily late (for example, from
        // global destructors or atexit() handlers).
        if (std::__libcpp_tls_create(&dtors_key, run_dtors) != 0) {
            abort_message("std::__libcpp_tls_create() failed in __cxa_thread_atexit()");
        }
    }

    ~DtorsManager() {
        // std::__libcpp_tls_key destructors do not run on threads that call exit()
        // (including when the main thread returns from main()), so we explicitly
        // call the destructor here.  This runs at exit time (potentially earlier
        // if libc++abi is dlclose()'d).  Any thread_locals initialized after this
        // point will not be destroyed.
        run_dtors(nullptr);
    }
};
} // anon::

extern "C"
{
    extern int __cxa_thread_atexit_impl(void (*dtor)(void*),
            void *obj, void *dso_symbol) throw();

    int __cxa_thread_atexit(Dtor dtor, void* obj, void* dso_symbol) throw() {
#if 1 // defined(HAVE___CXA_THREAD_ATEXIT_IMPL)
        __cxa_thread_atexit_impl(dtor, obj, dso_symbol);
#else
#error "// see https://github.com/llvm-mirror/libcxxabi/blob/master/src/cxa_thread_atexit.cpp"
#endif
    }
}
#endif // defined(__ve)

#if 0
// For g++, adding this skips running the destructors when threads are joined.
extern "C" int __cxa_thread_atexit(void (*dtor)(void*), void* obj, void* dso_symbol) 
{
    return 1;
}
#endif

struct TlsInt {
    int t_num;
    TlsInt(){
        lock_guard<mutex> guard(coutMutex);
        cout<<" t_num default constructor, t_num @ "<<(void*)this<<endl;
    }
    TlsInt& operator=(int const i) {
        int const old = t_num;
        t_num = i;
        lock_guard<mutex> guard(coutMutex);
        cout<<" t_num @ "<<(void*)this<<" : "<<old<<" --> "<<t_num<<endl;
        return *this;
    }
    ~TlsInt(){
        lock_guard<mutex> guard(coutMutex);
        cout<<" destroying t_num @ "<<(void*)this<<" t_num = "<<t_num<<endl;
    }
};

thread_local TlsInt tlsint; // each thread gets an object

void setTlsInt(int const num){ // each thread assigns to its object
    tlsint = num;
    this_thread::yield();
    lock_guard<mutex> guard(coutMutex);
    cout<<" I did important things with my TlsInt = "<<tlsint.t_num<<endl;
}

int main(){
    thread t1(setTlsInt,1); 
    thread t2(setTlsInt,2); 
    thread t3(setTlsInt,3); 
    thread t4(setTlsInt,4); 
    t1.join();
    t2.join();
    t3.join();
    t4.join();
    cout<<"\nGoodbye!"<<endl;
}
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
