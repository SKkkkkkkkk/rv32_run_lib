#include "../shared_memory.h"

SECTIONS
{
  . = LIBFUNCS_BASE;

  .jump_table :
  {
    *(.jump_table)
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