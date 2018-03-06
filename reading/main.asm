[org 0x7c00]

  mov bx, HELLO_WORLD
  call print_ln

  mov bx, GOODBYE
  call print_ln

  mov dx, 0x1fb6
  call print_hex

  jmp $

  %include "print_ln.asm"
  %include "print_hex.asm"

HELLO_WORLD:
  db "Hello, World", 0

GOODBYE:
  db "See ya later", 0

times 510-($-$$) db 0
  dw 0xaa55
