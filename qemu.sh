#!/bin/bash

# Allow overriding build type, default to debug
BUILD_TYPE=${BUILD_TYPE:-debug}

# Use paths relative to project root with build type
MAIN_BIN="rv32_main/build/$BUILD_TYPE/rv32_main.bin"
LIB_SO="lib/build/$BUILD_TYPE/lib_funcs.so"
MAIN_ELF="rv32_main/build/$BUILD_TYPE/rv32_main.elf"

qemu-system-riscv32 -machine virt -smp 1 -nographic \
  -bios "$MAIN_BIN" \
  -device loader,file="$LIB_SO",addr=0x80001000 \
  -s -S

# When running GDB, use:
# riscv64-unknown-elf-gdb "$MAIN_ELF" -ex="tar ext:1234" -ex="restore $LIB_SO binary 0x80001000"