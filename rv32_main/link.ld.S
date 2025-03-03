#include "../shared_memory.h"

SECTIONS
{
  . = EXE_BASE;

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