all:
	arm-linux-gcc serial_test.c  -o serial_test
	sudo cp serial_test  /home/ecm_5410/aplex/filesystem/rootfs_test/bin -rf
	sync

clean:
	rm serial_test  -rf
	sync
