print_hex:
  pusha

set_up:
  mov bx, HEX_OUT + 5 ; Start at the end of the string
  mov cx, 0 ; Set up loop counter
and_loop:
  cmp cx, 4 ; Each hex set has 4 chars
  je tty    ; End of loop
  mov ax, 0x000f ; Mask the last byte
  and ax, dx
  add al, 0x30 ; Get the char value of the int
  cmp al, 0x39 ; If it's not an int,
  jle put_in_hex_out
  add al, 7    ; Adjust to fit a-f

put_in_hex_out:
  mov [bx], al ; Move the char value into the HEX_OUT string
  add cx, 1    ; increment loop counter
  sub bx, 1    ; move the string pointer to the left
  shr dx, 4    ; Rotate the passed in value to the next byte
  jmp and_loop ; Loop

tty:
  mov bx, HEX_OUT ;Finish up
  call print_ln

  popa
  ret


HEX_OUT:
  db '0x0000', 0
