nasm bootloader.asm -f bin -o bootloader.bin
nasm OS.asm -f bin -o OS.bin
cat bootloader.bin OS.bin > os.bin
sudo dd if=os.bin of=/dev/sdb conv=notrunc
rm bootloader.bin
rm OS.bin
rm ~/Documents/'my OS'/myOS/dumps/os.bin
cp ~/Documents/'my OS'/myOS/OS/os.bin ~/Documents/'my OS'/myOS/dumps/os.bin
rm os.bin
cd
cd Documents/'my OS'/myOS/dumps
./dumps.sh