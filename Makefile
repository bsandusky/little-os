AS = $(DOCKER) nasm
ASFLAGS = -f elf
CC = $(DOCKER) gcc
CFLAGS = -m32 -nostdlib -nostdinc  -fno-builtin  -fno-stack-protector  \
-nostartfiles  -nodefaultlibs  -Wall  -Wextra  -Werror  -c
CONTAINER_COMMAND = docker run --rm
CONTAINER_FLAGS = -v$(shell pwd):$(shell pwd) -w$(shell pwd)
CONTAINER = bsandusky/muslbox:0.1
DOCKER = $(CONTAINER_COMMAND) $(CONTAINER_FLAGS) $(CONTAINER)
LDFLAGS = -m elf_i386 -T link.ld
OBJECTS = loader.o kmain.o

all: kernel.elf

kernel.elf: $(OBJECTS)
	$(DOCKER) ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

run: 
	qemu-system-i386 -kernel kernel.elf

clean: 
	rm -rf *.o kernel.elf