# Common configuration for all makefiles
# Toolchain settings
CROSS_COMPILE ?= riscv64-unknown-elf-
CC = $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

# Build type (debug/release)
BUILD_TYPE ?= debug

# Common flags for both build types
COMMON_FLAGS = -march=rv32g -mabi=ilp32 -nostdlib -ffreestanding -Wall -I..

ifeq ($(BUILD_TYPE),debug)
    CFLAGS_OPT = -O0 -g
else ifeq ($(BUILD_TYPE),release)
    CFLAGS_OPT = -O2
else
    $(error Invalid BUILD_TYPE: $(BUILD_TYPE). Use 'debug' or 'release')
endif

# Build output directory - each component uses its own local build dir
LIB_BUILD_DIR = build/$(BUILD_TYPE)
MAIN_BUILD_DIR = build/$(BUILD_TYPE)

# Compiler and linker flags
CFLAGS = $(COMMON_FLAGS) $(CFLAGS_OPT)
LDFLAGS = -nostdlib -ffreestanding

# Don't create directories here, let individual Makefiles handle it