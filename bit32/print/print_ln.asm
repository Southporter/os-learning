[bits 32]

VIDEO_MEMORY equ 0xb8000
BLACK_ON_WHITE equ 0x0b

print_ln_32:
  pusha
  mov edx, VIDEO_MEMORY

print_loop:
  mov al, [ebx]
  mov ah, BLACK_ON_WHITE

  cmp al, 0
  je print_done

  mov [edx], ax

  add ebx, 1
  add edx, 2

  jmp print_loop

print_done:
  popa
  ret
