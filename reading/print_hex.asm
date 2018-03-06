print_hex:
  pusha
  mov ah, 0x0e

set_up:
  mov cx, HEX_OUT + 5
  mov bx, 4
and_loop:
  cmp bx, 0
  je tty
  mov ex, 0x000f
  and ex, dx
  add ex, 0x30
  cmp ex, 0x39
  jle put_in_hex_out
  add ex, 0x7

put_in_hex_out:
  mov [cx], el
  sub cx, 1
  shr dx, 4
  jmp and_loop


done:
  mov al, 0x0a
  int 0x10
  mov al, 0x0d
  int 0x10
  popa
  ret


HEX_OUT:
  db '0x0000', 0
