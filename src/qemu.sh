rm -r bin
mkdir bin

nasm src/boot/mbr.asm -o bin/mbr.bin
nasm src/boot/bootloader.asm -o bin/bootloader.bin
nasm src/os.asm -o bin/os.asm
cat bin/bootloader.bin bin/os.bin > bin/mos.bin
sudo dd if=/dev/zero of=bin/disk.img count=8 bs=1048576
sudo dd if=bin/mbr.bin of=bin/disk.img conv=notrunc
sudo dd if=bin/mos.bin of=bin/disk.img bs=512 seek=16 conv=notrunc
sudo qemu-system-x86_64 -drive format=raw,file=bin/disk.img