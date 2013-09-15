all: geofft.bin

geofft.bin: geofft.hex
	xxd -r -p geofft.bin > geofft.hex
