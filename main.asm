[org 0x7c00]

  mov bp, 0x9000
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_ln

  call switch_to_protected_mode

  jmp $

  ; Modular code
  %include "./bit16/print/print_ln.asm"
  %include "gdt.asm"
  %include "./bit32/print/print_ln.asm"
  %include "switch_to_protected.asm"


[bits 32]

BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_ln_32

  jmp $

  ; Global variables
  MSG_REAL_MODE db "Started in real mode",0
  MSG_PROT_MODE db "Ended in protected",0

times 510-($-$$) db 0
  dw 0xaa55

