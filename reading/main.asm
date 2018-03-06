[org 0x7c00]

  mov bx, HELLO_WORLD
  call print_ln

  mov bx, GOODBYE
  call print_ln

  jmp $

  %include "print_ln.asm"

HELLO_WORLD:
  db "Hello, World", 0

GOODBYE:
  db "See ya later", 0

times 510-($-$$) db 0
  dw 0xaa55
