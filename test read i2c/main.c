#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_I2C.h"
#include "stm8_UART.h"

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_I2C();
	init_UART(9600);
	
	uint8_t i2cData;
	
	print_UART("start");
	line_UART();

    while (1)
    {
		if (readByte_I2C(0x68, &i2cData) == 1)
		{
			print_UART("data is 0x");
			printHex_UART(i2cData);
			line_UART();
		}
		else 
		{
			print_UART("fail");
			line_UART();
		}
    }
}
