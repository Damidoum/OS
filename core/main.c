#include "../boot/multiboot.h"

void printf(char *str) {
  unsigned short *videoMemory = (unsigned short *)0xb8000;
  for (int i = 0; str[i] != '\0'; i++) {
    videoMemory[i] = (videoMemory[i] & 0xFF00) | str[i];
  }
}

void kernelMain(unsigned long magic, unsigned long addr) {
  // multiboot_info_t *mbi;
  // mbi = (multiboot_info_t *)addr;
  printf("Welcome from GRUB to DamidoumOS");
  for (;;) {
    continue;
  }
  return;
}
