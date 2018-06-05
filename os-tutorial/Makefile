AS = $(DOCKER) nasm
ASFLAGS = -f bin
CONTAINER_COMMAND = docker run --rm
CONTAINER_FLAGS = -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = bsandusky/muslbox:0.1
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)

# CC = $(DOCKER) gcc
# CFLAGS = -m32 -nostdlib -nostdinc  -fno-builtin  -fno-stack-protector  \
# -nostartfiles  -nodefaultlibs  -Wall  -Wextra  -Werror  -c
# LDFLAGS = -m elf_i386 -T link.ld
# OBJECTS = boot_sect_simple.bin

# all: kernel.elf

assemble:
	$(AS) $(ASFLAGS) boot_sect_simple.asm -o boot_sect_simple.bin

run: 
	qemu-system-x86_64 boot_sect_simple.bin

# kernel.elf: $(OBJECTS)
# 	$(DOCKER) ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

# clean: 
# 	rm -rf *.o kernel.elf