#ifndef LIB_REGISTRY_H
#define LIB_REGISTRY_H

#include "../shared_memory.h"

// Helper macros for counting
#define _EXPAND(x) x
#define _GET_NTH_ARG(_1, _2, _3, _4, _5, N, ...) N
#define _COUNT_ARGS(...) _EXPAND(_GET_NTH_ARG(__VA_ARGS__, 5, 4, 3, 2, 1))

// Macro to create the jump table
#define MAKE_JUMP_TABLE(...) \
    const JumpTable jump_table __attribute__((section(".jump_table"))) = { \
        .num_functions = _COUNT_ARGS(__VA_ARGS__), \
        .functions = { __VA_ARGS__ } \
    }

#endif /* LIB_REGISTRY_H */ 