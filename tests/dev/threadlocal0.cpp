#include <iostream>
#include <sstream>
#include <string>
#include <mutex>
#include <thread>

std::mutex coutMutex;

thread_local std::string t_msg("hello from ");
thread_local int t_num=0;

void addThreadLocal(int const num){
    int t_num_was = t_num;
    t_num = num;
    std::ostringstream oss;
    oss << num;
    t_msg += oss.str();
    // protect std::cout
    std::lock_guard<std::mutex> guard(coutMutex);
    std::cout << " t_num " << t_num_was << " --> " << t_num;
    std::cout << " " << t_msg;
    std::cout << " &t_msg=" << &t_msg;
    std::cout << "\n" << std::endl;
}

int main(){
    std::cout << std::endl;

    std::thread t1(addThreadLocal,1); 
    std::thread t2(addThreadLocal,2); 
    std::thread t3(addThreadLocal,3); 
    std::thread t4(addThreadLocal,4); 

    t1.join();
    t2.join();
    t3.join();
    t4.join();
    std::cout<<"\nGoodbye!"<<std::endl;
}
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
