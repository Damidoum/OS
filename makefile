CC = gcc
AS = as
LD = ld

CFLAGS  = -Wall -nostdlib -nostdinc -ffreestanding -m32 -march=i386
LDFLAGS = --warn-common
ASFLAGS = -32

PWD = $(shell pwd)
KERNEL_OBJ = ./build/kernel.elf
KERNEL_ISO = kernel.iso 
OBJECTS = ./core/main.o ./boot/multiboot.o

$(KERNEL_ISO): $(KERNEL_OBJ)
	mkdir -p ../iso/boot/grub
	cp $< ../iso/boot/
	echo 'set timeout=0' > ../iso/boot/grub/grub.cfg
	echo 'set default=0' >> ../iso/boot/grub/grub.cfg
	echo '' >> ../iso/boot/grub/grub.cfg
	echo 'menuentry "My Operating System" {' >> ../iso/boot/grub/grub.cfg
	echo '	multiboot /boot/kernel.elf' >> ../iso/boot/grub/grub.cfg
	echo '	boot' >> ../iso/boot/grub/grub.cfg
	echo '}' >> ../iso/boot/grub/grub.cfg
	grub-mkrescue --output=$@ ../iso

$(KERNEL_OBJ): $(OBJECTS)
	$(LD) $(LDFLAGS) -T ./build/linker.ld -o $@ $^ 
	-nm -C $@ | cut -d ' ' -f 1,3 > ./build/os.map

%.o: %.c
	$(CC) -I$(PWD) -c $< $(CFLAGS) -o $@

%.o: %.s
	$(AS) -I$(PWD) -c $< $(ASFLAGS) -o $@

clean:
	$(RM) *.img *.o mtoolsrc *~ menu.txt *.img *.elf *.bin *.map
	$(RM) boot/*.o boot/*~
	$(RM) core/*.o core/*~
