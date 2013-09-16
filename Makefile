SHELL=/bin/bash

all: geofft.img

clean:
	rm -f base_boot_sector.img geofft.bin geofft.bin.count base_boot_sector.img.bytes_to_use geofft.img

geofft.bin: geofft.hex
	xxd -r -p geofft.hex > geofft.bin

geofft.bin.count: geofft.bin
	wc -c geofft.bin > geofft.bin.count

base_boot_sector.img:
	sudo dd if=/dev/sda bs=512 count=1 > base_boot_sector.img

base_boot_sector.img.bytes_to_use: base_boot_sector.img geofft.bin.count
	echo 318 > base_boot_sector.img.bytes_to_use
# HACK: I did the math by hand. Whatever. I was going to use shell arithmetic.

geofft.img: base_boot_sector.img.bytes_to_use
	(cat < geofft.bin ; tail -c 318 base_boot_sector.img ) > geofft.img.new
	mv geofft.img.new geofft.img
