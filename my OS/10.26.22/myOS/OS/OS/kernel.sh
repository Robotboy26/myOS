nasm bootloader.asm -f bin -o bootloader.bin
nasm test2.asm -f bin -o test2.bin
cat bootloader.bin test2.bin > os.bin
sudo dd if=os.bin of=/dev/sdb conv=notrunc
rm bootloader.bin
rm test2.bin
rm os.bin
