KERNEL_SOURCE = $(wildcard kernel/*.c)
KERNEL_HEADERS = $(wildcard kernel/*.h)
DRIVER_SOURCE = $(wildcard drivers/*.c)
DRIVER_HEADERS = $(wildcard drivers/*.h)


KERNEL_OBJ = ${KERNEL_SOURCE:.c=.o}
DRIVER_OBJ = ${DRIVER_SOURCE:.c=.o}

#default
all: os-image

run: all
	qemu-system-x86_64 os-image

os-image: boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel_entry.o kernel.o drivers.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o: ${KERNEL_SOURCE} ${KERNEL_HEADERS}
	gcc -ffreestanding -c $< -o $@

drivers.o: ${DRIVER_SOURCE} ${DRIVER_HEADERS}
	gcc -ffreestanding -c $< -o $@

kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf -o $@

boot_sect.bin: boot/boot_sect.asm
	nasm $< -f bin -I './boot' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image *.map
	rm -rf kernel/*.o boot/*.bin drivers/*.o

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
