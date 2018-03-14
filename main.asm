[org 0x7c00]

  ; BIOS stores the boot drive in dl
  mov [BOOT_DRIVE], dl

  ; Set up the stack
  mov bp, 0x8000
  mov sp, bp

  ; Set the write destination
  mov bx, 0x9000
  mov dh, 5  ; Read 5 sectors
  mov dl, [BOOT_DRIVE] ; Boot drive
  call disk_load

  mov dx, [0x9000]
  call print_hex

  mov dx, [0x9000 + 512]
  call print_hex

  mov dx, [0x9000 + 1024]
  call print_hex

  jmp $

  ; Modular code
  %include "./print/print_ln.asm"
  %include "./print/print_hex.asm"
  %include "./disk/disk_load.asm"

  ; Global variables
  BOOT_DRIVE: db 0

times 510-($-$$) db 0
  dw 0xaa55


; Create some extra disk space to read from
times 256 dw 0xdada
times 256 dw 0xface
times 256 dw 0xbacf
times 1024 dw 0xfffa
