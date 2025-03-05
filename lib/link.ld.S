#include "../shared_memory.h"

SECTIONS
{
  . = LIBFUNCS_BASE;

  .jump_table :
  {
    LONG((__extern_func_end - __extern_func_start) / 4);  /* num_functions */
    __extern_func_start = .;
    *(.extern_func)
    __extern_func_end = .;
  }
  
  .text :
  {
    *(.text*)
  }
  
  .data :
  {
    *(.data*)
  }
  
  .bss :
  {
    *(.bss*)
  }
}