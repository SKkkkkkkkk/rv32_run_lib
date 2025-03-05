# RV32 Runtime Library Environment

A lightweight runtime environment for RISC-V 32-bit applications that enables dynamic library function calls through a jump table mechanism.

## Features

- Dynamic library function loading and execution
- Automatic function registration via linker sections
- QEMU RISC-V emulation support
- Jump table mechanism for function calls
- Debug and release build configurations

## Prerequisites

- RISC-V GNU Toolchain (`riscv32-unknown-elf-*`)
- QEMU with RISC-V support

## Quick Start

```bash
# Build the project (debug mode)
make # or CROSS_COMPILE=riscv32-unknown-elf- make

# Build in release mode
make release

# Run in QEMU(waiting for GDB connection with '-S -s')
make run

# Debug with GDB(connect with qemu)
make gdb
```

## Project Structure

```
.
├── config.mk          # Build configuration
├── Makefile          # Top-level makefile
├── qemu.sh           # QEMU execution script
├── shared_memory.h   # Memory layout definitions
├── lib/              # Library component
│   ├── lib_func.c    # Library functions
│   ├── lib_registry.h # Function registration macros
│   └── Makefile     
└── rv32_main/        # Main application
    ├── main.c        # Entry point
    ├── start.S       # Startup code
    └── Makefile
```

## Memory Layout

- `0x80000000`: Executable base (EXE_BASE)
- `0x80001000`: Library functions base (LIBFUNCS_BASE)
- `0x80002000`: Shared memory region (SHARED_MEM_BASE) (yet to be implemented)

## Development Guide

### Adding New Library Functions

1. Include the registry header in your source file:
   ```c
   #include "lib_registry.h"
   ```

2. Implement your function with the standard signature:
   ```c
   int your_function(void* args) {
       // Your implementation here
       return 0;
   }
   ```

3. Register the function using the `REGISTER_FUNCTION` macro:
   ```c
   REGISTER_FUNCTION(your_function);
   ```

4. Rebuild the project

### Build Options

```bash
make lib      # Build library only
make main     # Build main application
make clean    # Clean build artifacts
```

## Architecture

The system uses a jump table mechanism to enable dynamic function calls between the main executable and library:

- Functions are automatically registered in a dedicated linker section
- The jump table is constructed at link time
- The main program accesses library functions through the jump table
- UART output (0x10000000) is available for debug printing

For detailed implementation information, refer to the source code documentation.