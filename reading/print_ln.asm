print_ln:
  push ax
  mov ah, 0x0e

begin:
  mov al, [bx]
  cmp al, 0
  je done
  int 0x10
  add bx, 1
  jmp begin

done:
  mov al, 0x0a
  int 0x10
  mov al, 0x0d
  int 0x10
  pop ax
  ret


