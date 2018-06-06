ARCH = x86_64
AS = $(DOCKER) nasm
ASFLAGS = -f bin
AS_INPUT = boot_sect_disk.asm
AS_OUTPUT = $(AS_INPUT).bin
CONTAINER_COMMAND = docker run
CONTAINER_FLAGS =  --rm -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = bsandusky/muslbox:0.1
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)

# CC = $(DOCKER) gcc
# CFLAGS = -m32 -nostdlib -nostdinc  -fno-builtin  -fno-stack-protector  \
# -nostartfiles  -nodefaultlibs  -Wall  -Wextra  -Werror  -c
# LDFLAGS = -m elf_i386 -T link.ld
# OBJECTS = boot_sect_simple.bin

# all: kernel.elf

assemble:
	$(AS) $(ASFLAGS) $(AS_INPUT) -o $(AS_OUTPUT)

run: 
	qemu-system-$(ARCH) -drive format=raw,file=$(AS_OUTPUT)

# kernel.elf: $(OBJECTS)
# 	$(DOCKER) ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

# clean: 
# 	rm -rf *.o kernel.elf