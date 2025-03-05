#include "../shared_memory.h"
.section .text
.global _start
_start:
    la sp, (EXE_BASE + EXE_SIZE)
    call main
    li t0, 0x5555
    li t1, 0x100000
    sw t0, 0(t1)
    j . // should never reach here