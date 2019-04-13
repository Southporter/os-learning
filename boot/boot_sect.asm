[org 0x7c00]
KERNEL_OFFSET equ 0x1000

  mov [BOOT_DRIVE], dl

  mov bp, 0x9000
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_ln

  call load_kernel

  call switch_to_protected_mode

  jmp $

  ; Modular code
  %include "bit16/print/print_ln.asm"
  %include "bit16/disk/disk_load.asm"
  %include "gdt.asm"
  %include "bit32/print/print_ln.asm"
  %include "switch_to_protected.asm"

[bits 16]

load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_ln

  mov bx, KERNEL_OFFSET
  mov dh, 15
  mov dl, [BOOT_DRIVE]
  call disk_load

  ret

[bits 32]

BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_ln_32

  call KERNEL_OFFSET

  ; Global variables
  BOOT_DRIVE db 0
  MSG_REAL_MODE db "Started in real mode",0
  MSG_PROT_MODE db "Ended in protected",0
  MSG_LOAD_KERNEL db "Loading kernel into memory.",0

times 510-($-$$) db 0
  dw 0xaa55

