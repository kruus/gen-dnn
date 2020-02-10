#include "boost_no_com_value_init.ipp"
#include <assert.h>
#include <stdio.h>

int main() {
    // num_failures should be zero!!
    const int num_failures =
        boost_no_complete_value_initialization::test();
    printf(" boost_no_com_value_init test had %d failures\n", num_failures);
    return num_failures;
}
// vim: et ts=4 sw=4 cindent cino=+2s,^=l0,\:0,N-s
