#include "../shared_memory.h"
.section .text
.global _start
_start:
    la sp, (EXE_BASE + EXE_SIZE)
    call main
    j .