#ifndef SHARED_MEMORY_H
#define SHARED_MEMORY_H

// Memory Layout
#define RAM_BASE        0x80000000

#define EXE_BASE        RAM_BASE
#define EXE_SIZE        0x1000

#define LIBFUNCS_BASE   (EXE_BASE + EXE_SIZE)
#define LIBFUNCS_SIZE   0x1000

// Shared Memory
#define SHARED_MEM_BASE (LIBFUNCS_BASE + LIBFUNCS_SIZE)
#define SHARED_MEM_SIZE 0x1000

// 控制区偏移量
#define CMD_OFFSET      0x0
#define PARAM_OFFSET    0x4
#define RESULT_OFFSET   0x8
#define STATUS_OFFSET   0xC

// 状态定义
#define STATUS_IDLE         0
#define STATUS_NEW_CMD      1
#define STATUS_EXECUTING    2
#define STATUS_DONE         3
#define STATUS_ERROR        4

// 函数跳转表结构
#ifndef __ASSEMBLER__
#include <stdint.h>
typedef int (*func_ptr)(void* args);
typedef struct {
    uintptr_t num_functions;
    func_ptr functions[];
} JumpTable;
#endif /* __ASSEMBLER__ */


#endif /* SHARED_MEMORY_H */