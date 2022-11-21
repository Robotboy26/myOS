echo now in dumps shell file
rm out.txt
rm outb.txt
rm outE.txt
xxd os.bin out.txt
xxd -p os.bin outp.txt
xxd -b os.bin outb.txt
xxd -E os.bin outE.txt