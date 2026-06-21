#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_UART.h"
#include "stm8_I2C.h"

uint8_t BCDtoDEC(uint8_t bcd) 
{
	return (((bcd >> 4) * 10) + (bcd & 0x0F));
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_I2C();
	init_UART(9600);
	
	print_UART("start reading");
	line_UART();
	
	uint8_t data;
	
    while (1)
    {
		if (readReg_I2C(0x68, 0x00, &data) == 0)
		{
		print_UART("fail");
		line_UART();
		}
		print_UART("second is ");
		printInt_UART(BCDtoDEC(data));
		line_UART();
    }
}
