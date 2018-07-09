#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>


int main(void)
{
    int eeprom_fd, ret;
    char eeprom_str[12] = "abcdefg";
    char eeprom_str_read[12];
    eeprom_fd = open("/sys/devices/platform/ocp/44e0b000.i2c/i2c-0/0-0050/eeprom", O_RDWR | O_TRUNC);
	if (eeprom_fd < 0) {
		perror("open eeprom device:");
        return -1;
	}

    lseek(eeprom_fd, 0, SEEK_SET);

    write(eeprom_fd, eeprom_str, sizeof(eeprom_str));

    lseek(eeprom_fd, 0, SEEK_SET);

    if (ret = read(eeprom_fd, eeprom_str_read, sizeof(eeprom_str_read)) < 0)
    {
        perror("read error");
        return -1;
    }

    printf("eeprom read : %s   \n", eeprom_str_read);

    close(eeprom_fd);
    return 0;
}

