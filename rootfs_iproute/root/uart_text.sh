uart1_232=`uart4_test.sh ttyO1 ttyO1 9600`
uart1_485_read=`uart4_test.sh ttyO1 ttyO2 9600`
uart2_485_read=`uart4_test.sh ttyO2 ttyO1 9600`
uart3_485_read=`uart4_test.sh ttyO3 ttyUSB0 115200`
uart4_485_read=`uart4_test.sh ttyO4 ttyO5 9600`
uart5_485_read=`uart4_test.sh ttyO5 ttyO4 9600`
uart6_485_read=`uart4_test.sh ttyUSB0 ttyO3 9600`


if [ ${uart1_232:0:10}x = "hello_uart"x ]
then
	echo uart1_232 ok
else
	echo uart1_232 error
fi

if [ ${uart1_485_read:0:10}x = "hello_uart"x ]
then
	echo uart1_485_read ok
else
	echo uart1_485_read error
fi

if [ ${uart2_485_read:0:10}x = "hello_uart"x ]
then
	echo uart2_485_read ok
else
	echo uart2_485_read error
fi

if [ ${uart3_485_read:0:10}x = "hello_uart"x ]
then
	echo uart3_485_read ok
else
	echo uart3_485_read error
fi

if [ ${uart4_485_read:0:10}x = "hello_uart"x ]
then
	echo uart4_485_read ok
else
	echo uart4_485_read error
fi

if [ ${uart5_485_read:0:10}x = "hello_uart"x ]
then
	echo uart5_485_read ok
else
	echo uart5_485_read error
fi

if [ ${uart6_485_read:0:10}x = "hello_uart"x ]
then
	echo uart6_485_read ok
else
	echo uart6_485_read error
fi
