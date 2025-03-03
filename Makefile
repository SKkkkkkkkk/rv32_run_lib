# Top-level Makefile for the entire project
include config.mk

# Directories
LIB_DIR = lib
MAIN_DIR = rv32_main

# Default target
.PHONY: all clean run help lib main gdb debug release

all: debug

debug:
	$(MAKE) build BUILD_TYPE=debug

release:
	$(MAKE) build BUILD_TYPE=release

build: lib main

# Build the library functions
lib:
	@echo "Building library functions ($(BUILD_TYPE))..."
	$(MAKE) -C $(LIB_DIR) BUILD_TYPE=$(BUILD_TYPE)

# Build the main application
main: lib
	@echo "Building main application ($(BUILD_TYPE))..."
	$(MAKE) -C $(MAIN_DIR) BUILD_TYPE=$(BUILD_TYPE)

# Run the application in QEMU - uses current BUILD_TYPE (defaults to debug)
run: build
	@echo "Running the application ($(BUILD_TYPE))..."
	BUILD_TYPE=$(BUILD_TYPE) ./qemu.sh

# Debug with GDB (works with both debug and release builds)
gdb: build
	@if [ "$(BUILD_TYPE)" = "release" ]; then \
		echo "Warning: Using release build for debugging. Debug symbols may be limited."; \
	fi
	@echo "Starting GDB debugging session ($(BUILD_TYPE) build)..."
	riscv64-unknown-elf-gdb $(MAIN_DIR)/build/$(BUILD_TYPE)/rv32_main.elf \
		-ex "set architecture riscv:rv32" \
		-ex "set confirm off" \
		-ex "target extended-remote localhost:1234" \
		-ex "add-symbol-file $(LIB_DIR)/build/$(BUILD_TYPE)/lib_func.elf" \
		-ex "restore $(LIB_DIR)/build/$(BUILD_TYPE)/lib_funcs.so binary 0x80001000" \
		-ex "layout regs" \
		-ex "break _start" \
		-ex "continue"

# Clean everything
clean:
	@echo "Cleaning everything..."
	$(MAKE) -C $(LIB_DIR) clean BUILD_TYPE=debug
	$(MAKE) -C $(MAIN_DIR) clean BUILD_TYPE=debug
	$(MAKE) -C $(LIB_DIR) clean BUILD_TYPE=release
	$(MAKE) -C $(MAIN_DIR) clean BUILD_TYPE=release
	@echo "All build files removed successfully."

# Help information
help:
	@echo "===== RV32 Project Build System ====="
	@echo "Available targets:"
	@echo "  debug     - Build both library and main application in debug mode (default)"
	@echo "  release   - Build both library and main application in release mode"
	@echo "  lib       - Build only the library functions"
	@echo "  main      - Build only the main application" 
	@echo "  run       - Build and run in QEMU (uses current BUILD_TYPE)"
	@echo "  gdb       - Start GDB with both main and library symbols loaded"
	@echo "             (works with both debug and release builds)"
	@echo "  clean     - Remove all build artifacts"
	@echo "  help      - Display this help message"
	@echo ""
	@echo "Build type selection:"
	@echo "  make [target] BUILD_TYPE=debug   - Build with debug info (default)"
	@echo "  make [target] BUILD_TYPE=release - Build with optimizations"
	@echo ""
	@echo "Examples:"
	@echo "  make                  - Build everything in debug mode"
	@echo "  make release          - Build everything in release mode"
	@echo "  make run              - Build and run with debug info (default)"
	@echo "  make run BUILD_TYPE=release  - Build and run optimized version"
	@echo "  make gdb BUILD_TYPE=debug    - Debug with full debug symbols"
	@echo "  make gdb BUILD_TYPE=release  - Debug release build (limited symbols)"
	@echo ""
	@echo "For more specific help:"
	@echo "  make -C $(LIB_DIR) help   - Library functions help"
	@echo "  make -C $(MAIN_DIR) help  - Main application help"