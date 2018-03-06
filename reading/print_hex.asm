print_hex:
  pusha

set_up:
  mov bx, HEX_OUT + 5
  mov cx, 4
and_loop:
  cmp cx, 0
  je tty
  mov ax, 0x000f
  and ax, dx
  add al, 0x30
  cmp al, 0x39
  jle put_in_hex_out
  add al, 7

put_in_hex_out:
  mov [bx], al
  sub bx, 1
  shl dx, 4
  jmp and_loop

tty:
  mov bx, HEX_OUT
  call print_ln

  popa
  ret


HEX_OUT:
  db '0x0000', 0
