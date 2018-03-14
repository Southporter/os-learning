[bits 16]
switch_to_protected_mode:
  cli

  lgdt [gdt_descriptor]

  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_protected_mode

init_protected_mode:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ax, CODE_SEG
  mov cs, ax

  mov ebp, 0x90000
  mov esp, ebp

  jmp BEGIN_PM
