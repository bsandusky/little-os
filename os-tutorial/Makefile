CONTAINER_COMMAND = docker run
CONTAINER_FLAGS = --rm -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = fedora:dev
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)

all: os-image.bin

boot.bin: boot.asm
	$(DOCKER) nasm $< -f bin -o $@

kernel.bin: kernel_entry.o kernel.o
	$(DOCKER) ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o: kernel.c
	$(DOCKER) gcc -m32 -ffreestanding -c $< -o $@

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

image.dis: os-image.bin
	ndisasm -b 32 $< > $@

kernel_entry.o: kernel_entry.asm
	$(DOCKER) nasm $< -f elf -o $@

os-image.bin: boot.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -drive format=raw,if=floppy,file=$<

clean:
	rm -fr *.bin *.dis *.o os-image.bin *.map