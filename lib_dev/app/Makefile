
CC = arm-none-linux-gnueabi-gcc

all:
	make -C ../src
	$(CC) show.c -o show_sn -L ../src/ -ldev
	$(CC) led_wtd_demo.c -o led_wtd_demo -L ../src/ -ldev

clean:
	rm show_sn  led_wtd_demo
	make clean -C ../src

