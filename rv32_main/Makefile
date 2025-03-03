# RV32 Main Application Makefile
include ../config.mk

# Output files
PROJ_NAME = rv32_main
TARGET = $(MAIN_BUILD_DIR)/$(PROJ_NAME).bin
ELF_FILE = $(MAIN_BUILD_DIR)/$(PROJ_NAME).elf
OBJS = $(MAIN_BUILD_DIR)/start.o $(MAIN_BUILD_DIR)/main.o
LINK_SCRIPT = $(MAIN_BUILD_DIR)/link.ld
# Disassembly files
DISASM = $(MAIN_BUILD_DIR)/$(PROJ_NAME).dis
DISASM_SOURCE = $(MAIN_BUILD_DIR)/$(PROJ_NAME)_source.dis

# Source files
SRCS = main.c start.S
DEPS = $(MAIN_BUILD_DIR)/main.d

# Default target
.PHONY: all clean help disasm
all: $(TARGET) disasm

# Disassembly generation
disasm: $(ELF_FILE)
	@echo "Generating full disassembly to $(DISASM)"
	$(OBJDUMP) -D $< > $(DISASM)
	@echo "Generating source-interleaved disassembly to $(DISASM_SOURCE)"
	$(OBJDUMP) -S $< > $(DISASM_SOURCE)

# Linker script generation
$(LINK_SCRIPT): link.ld.S | $(MAIN_BUILD_DIR)
	@echo "Generating linker script $@"
	$(CC) -E -P -x assembler-with-cpp -I../ -D__LINKER__ -o $@ $<

# Assembly compilation
$(MAIN_BUILD_DIR)/%.o: %.S | $(MAIN_BUILD_DIR)
	@echo "Assembling $<"
	$(CC) $(CFLAGS) -c $< -o $@

# C file compilation with dependency generation
$(MAIN_BUILD_DIR)/%.o: %.c | $(MAIN_BUILD_DIR)
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Include generated dependency files
-include $(DEPS)

# Linking
$(ELF_FILE): $(OBJS) $(LINK_SCRIPT)
	@echo "Linking $@"
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -T$(LINK_SCRIPT) -o $@

# Binary creation
$(TARGET): $(ELF_FILE)
	@echo "Creating binary $@"
	$(OBJCOPY) -O binary $< $@

# Directory creation
$(MAIN_BUILD_DIR):
	mkdir -p $@

# Clean up
clean:
	@echo "Cleaning main application build files..."
	rm -rf $(MAIN_BUILD_DIR)

# Help information
help:
	@echo "Available targets:"
	@echo "  all       - Build application and generate disassembly (default)"
	@echo "  clean     - Remove build artifacts"
	@echo "  help      - Display this help message"
	@echo "  disasm    - Generate disassembly files"