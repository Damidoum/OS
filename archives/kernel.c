void printf(char *str) {
  unsigned short *videoMemory = (unsigned short *)0xb8000;
  for (int i = 0; str[i] != '\0'; i++) {
    videoMemory[i] = (videoMemory[i] & 0xFF00) | str[i];
  }
}

void kernelMain(void *multiboot_structure, unsigned int magicnumber) {
  printf("Hello world! ");
  while (1) {
  }
}
