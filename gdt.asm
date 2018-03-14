gdt_start:

gdt_null:
  dd 0x0
  dd 0x0

gdt_code:
  dw 0xffff
  dw 0x0
  db 0x0
  db 10011010b ; Present 1 / priveledge 00 / descriptor 1
               ; Type 1 (code) / conforming 0 / readable 1 / accessed 0
  db 11001111b ; granularity 1 / 32 bit 1 / 62 bit 0 / AVL 0
  db 0x0

gdt_data:
  dw 0xffff
  dw 0x0
  db 0x0
  db 10010010b
  db 11001111b
  db 0x0

gdt_end:

gdt_descriptor:
  dw gdt_end - gdt_start - 1
  dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
