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
	
	sendString_UART("start");
	sendLine_UART();
	
	if (readByte_I2C(0x68, &i2cData) == 1)
	{
		sendString_UART("data is 0x");
		sendHex_UART(i2cData);
		sendLine_UART();
	}
	else 
	{
		sendString_UART("fail");
		sendLine_UART();
	}

    while (1)
    {
		if (readByte_I2C(0x68, &i2cData) == 1)
		{
			sendString_UART("data is 0x");
			sendHex_UART(i2cData);
			sendLine_UART();
		}
		else 
		{
			sendString_UART("fail");
			sendLine_UART();
		}
    }
}
