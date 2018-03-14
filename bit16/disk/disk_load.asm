disk_load:
  push dx ; Save drive info for later use

  mov ah, 0x02 ; Set interupt to read from disk
  mov al, dh ; Set the drive number
  mov ch, 0x00 ; Start at cylinder 1
  mov dh, 0x00 ; track 1
  mov cl, 0x02 ; read from 2nd sector (1 indexed)

  int 0x13 ; BIOS interupt

  jc disk_error ; Error occured if carry bit set

  pop dx ; Pull back the number of disks to read
  cmp dh, al ; See if the interup read the correct number of sectors
  jne disk_error ; Error occured
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_ln
  jmp $

DISK_ERROR_MSG db "Error reading disk",0
