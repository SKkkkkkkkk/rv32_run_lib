#include "../shared_memory.h"

static int lib_data = 1;

// 示例函数0
int func0(void* args) {
    return (*(int*)args)++ + lib_data;
}

// 示例函数1
int func1(void* args) {
    return (*(int*)args)-- - lib_data;
}

// 跳转表
JumpTable jump_table
__attribute__((section(".jump_table")))
= {
    .num_functions = 2,
    .functions = {
        func0, 
        func1
    }
};