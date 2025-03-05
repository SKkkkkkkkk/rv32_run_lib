#include "../shared_memory.h"
#include <stdint.h>

int main() {
    JumpTable *jump_table = (JumpTable *)LIBFUNCS_BASE;
    int arg = 0, ret = 0; (void)ret;
    int i = 0;
    while ( i < jump_table->num_functions ) {
        ret = jump_table->functions[i](&arg);
        i++;
    }
    return 0;
}