echo 1 > /sys/class/gpio/gpio112/value
echo 1 > /sys/class/gpio/gpio113/value
echo 1 > /sys/class/gpio/gpio29/value


echo "1234567890\n" > /sys/devices/platform/omap/omap_i2c.1/i2c-1/1-0050/eeprom

cat /sys/devices/platform/omap/omap_i2c.1/i2c-1/1-0050/eeprom
