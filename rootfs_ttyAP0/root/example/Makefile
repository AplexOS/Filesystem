all:
	arm-none-linux-gnueabi-gcc -I ../include -o ${FILE} ${FILE}.c -lpthread -luk_arm -L ../lib
ftp:
	echo "open 192.168.2.10" > ftp.tmp
	echo "user root root" >> ftp.tmp
	echo "passive" >> ftp.tmp
	echo "send ${FILE} /root/example/${FILE}" >> ftp.tmp
	echo "send ${FILE}.c /root/example/${FILE}.c" >> ftp.tmp
	echo "bye" >> ftp.tmp
	ftp -i -in < ftp.tmp
	rm -rf ftp.tmp
