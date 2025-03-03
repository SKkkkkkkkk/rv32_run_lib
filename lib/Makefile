# Library Functions Makefile
include ../config.mk

# Output files
LIB_NAME = lib_funcs
TARGET = $(LIB_BUILD_DIR)/$(LIB_NAME).so
ELF_FILE = $(LIB_BUILD_DIR)/lib_func.elf
OBJS = $(LIB_BUILD_DIR)/lib_func.o
LINK_SCRIPT = $(LIB_BUILD_DIR)/link.ld
# Disassembly files
DISASM = $(LIB_BUILD_DIR)/lib_func.dis
DISASM_SOURCE = $(LIB_BUILD_DIR)/lib_func_source.dis

# Source files
SRCS = lib_func.c
DEPS = $(OBJS:%.o=%.d)

# Default target
.PHONY: all clean help disasm
all: $(TARGET) disasm

# Object files compilation with dependency generation
$(LIB_BUILD_DIR)/%.o: %.c | $(LIB_BUILD_DIR)
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Include generated dependency files
-include $(DEPS)

# Linker script generation
$(LINK_SCRIPT): link.ld.S | $(LIB_BUILD_DIR)
	@echo "Generating linker script $@"
	$(CC) -E -P -x assembler-with-cpp -D__LINKER__ -I../ -o $@ $<

# Linking
$(ELF_FILE): $(OBJS) $(LINK_SCRIPT)
	@echo "Linking $@"
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -T$(LINK_SCRIPT) -o $@

# Binary creation
$(TARGET): $(ELF_FILE)
	@echo "Creating binary $@"
	$(OBJCOPY) -O binary $< $@

# Disassembly generation
disasm: $(ELF_FILE)
	@echo "Generating full disassembly to $(DISASM)"
	$(OBJDUMP) -D $< > $(DISASM)
	@echo "Generating source-interleaved disassembly to $(DISASM_SOURCE)"
	$(OBJDUMP) -S $< > $(DISASM_SOURCE)

# Directory creation
$(LIB_BUILD_DIR):
	mkdir -p $@

# Clean up
clean:
	@echo "Cleaning library build files..."
	rm -rf $(LIB_BUILD_DIR)

# Help information
help:
	@echo "Available targets:"
	@echo "  all       - Build library (default)"
	@echo "  clean     - Remove build artifacts"
	@echo "  help      - Display this help message"
	@echo "  disasm    - Generate disassembly files"