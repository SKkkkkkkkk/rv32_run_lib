#ifndef LIB_REGISTRY_H
#define LIB_REGISTRY_H

#include "../shared_memory.h"

// Register a function in the jump table
#define REGISTER_FUNCTION(func) \
    static uintptr_t _##func##_addr __attribute__((section(".extern_func"), used)) = (uintptr_t)func

#endif /* LIB_REGISTRY_H */ 