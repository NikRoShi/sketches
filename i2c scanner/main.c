#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_I2C.h"
#include "stm8_UART.h"

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_UART(9600);
	init_I2C();
	
	sendString_UART("--Star scanning--");
	sendLine_UART();
	for (uint8_t i; i < 255; i++)
	{
		if (ping_I2C(i) == 1)
		{
			sendString_UART("devise in ");
			sendHex_UART(i);
			sendLine_UART();
		}
	}
	sendString_UART("--end scanning--");
	sendLine_UART();
    while (1)
    {

    }
}
