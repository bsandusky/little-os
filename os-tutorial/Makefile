# Build environment
CONTAINER_COMMAND = docker run
CONTAINER_FLAGS = --rm -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = fedora:dev
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)

# Source code
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h)
C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c)
OBJ = $(C_SOURCES:.c=.o cpu/interrupt.o)

# GDB Debug
GDB = /usr/local/i386elfgcc/bin/i386-elf-gdb
# -g: Use debugging symbols in gcc
CFLAGS = -g -m32 -ffreestanding -c

all: os-image.bin

kernel.bin: boot/kernel_entry.o $(OBJ)
	$(DOCKER) ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# for debugging with GDB
kernel.elf: boot/kernel_entry.o $(OBJ)
	$(DOCKER) ld -m elf_i386 -o $@ -Ttext 0x1000 $^

# generic rule for compiling c source code
%.o: %.c $(HEADERS)
	$(DOCKER) gcc $(CFLAGS) $< -o $@

# assemble kernel entry
%.o: %.asm
	$(DOCKER) nasm $< -f elf -I 'boot/' -I 'cpu/' -o $@

# assemble the boot binary
%.bin: %.asm
	$(DOCKER) nasm $< -f bin -I 'boot/' -I 'cpu/' -o $@

os-image.bin: boot/boot.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -drive format=raw,if=floppy,file=$<

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin kernel.elf
	qemu-system-i386 -S -s -drive format=raw,if=floppy,file=$< -d guest_errors,int &
	$(GDB) -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

clean:
	rm -fr *.bin *.dis *.o *.elf
	rm -fr kernel/*.o boot/*.bin boot/*.o drivers/*.o cpu/*.o

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

image.dis: os-image.bin
	ndisasm -b 32 $< > $@