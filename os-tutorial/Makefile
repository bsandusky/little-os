# Build environment
CONTAINER_COMMAND = docker run
CONTAINER_FLAGS = --rm -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = fedora:dev
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)

# Source code
HEADERS = $(wildcard kernel/*.h drivers/*.h)
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
OBJ = $(C_SOURCES:.c=.o)

all: os-image.bin

kernel.bin: boot/kernel_entry.o $(OBJ)
	$(DOCKER) ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# generic rule for compiling c source code
%.o: %.c $(HEADERS)
	$(DOCKER) gcc -m32 -ffreestanding -c $< -o $@

# assemble kernel entry
%.o: %.asm
	$(DOCKER) nasm $< -f elf -o $@

# assemble the boot binary
%.bin: %.asm
	$(DOCKER) nasm $< -f bin -o $@

os-image.bin: boot/boot.bin kernel.bin
	cat $^ > $@

run: os-image.bin 
	qemu-system-i386 -drive format=raw,if=floppy,file=$<

clean:
	rm -fr *.bin *.dis *.o
	rm -fr kernel/*.o boot/*.bin drivers/*.0

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

image.dis: os-image.bin
	ndisasm -b 32 $< > $@

# boot.bin: boot.asm
# 	$(DOCKER) nasm $< -f bin -o $@

# kernel.o: kernel.c
# 	$(DOCKER) gcc -m32 -ffreestanding -c $< -o $@

# kernel_entry.o: kernel_entry.asm
# 	$(DOCKER) nasm $< -f elf -o $@