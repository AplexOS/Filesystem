CC = arm-linux-gnueabihf-gcc

all:
	make -C ../src
	$(CC) main.c -o test_tty -L ../src/ -laplex_tty

clean:
	rm -rf test_tty
	make clean -C ../src


