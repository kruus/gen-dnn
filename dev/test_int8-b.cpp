#include "test_int8-a.cpp"

template<> int func(unsigned char const){ return 0; }
template<> int func(  signed char const){ return 1; }
//template<> int func(         int8_t const i){ return (int)i+1; }
