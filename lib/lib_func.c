#include "../shared_memory.h"
#include "lib_registry.h"

// QEMU virt UART address
#define UART0 ((volatile unsigned char *)0x10000000)

// Helper function to print a string to UART
static inline void uart_print(const char *str) {
    while (*str) {
        *UART0 = *str++;
    }
}

// Example function 0
int func0(void* args) {
    (void)args;
    uart_print("func0 called\n");
    return 0;
}
REGISTER_FUNCTION(func0);

// Example function 1
int func1(void* args) {
    (void)args;
    uart_print("func1 called\n");
    return 0;
}
REGISTER_FUNCTION(func1);