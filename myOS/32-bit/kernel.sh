nasm bootloader.asm -f bin -o bootloader.bin
nasm OS.asm -f bin -o OS.bin
cat bootloader.bin OS.bin > os.bin
sudo dd if=os.bin of=/dev/sdb conv=notrunc
rm bootloader.bin
rm OS.bin
rm os.bin