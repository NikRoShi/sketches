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
	
	uint8_t data[7];
	
    while (1)
    {
		if (readBuffer_I2C(0x68, 0x00, data, 7) == 0)
		{
		print_UART("fail");
		line_UART();
		}
		print_UART("sec is ");
		printInt_UART(BCDtoDEC(data[0]));
		line_UART();
		print_UART("min is ");
		printInt_UART(BCDtoDEC(data[1]));
		line_UART();
		print_UART("hour is ");
		printInt_UART(BCDtoDEC(data[2]));
		line_UART();
		print_UART("day is ");
		printInt_UART(BCDtoDEC(data[3]));
		line_UART();
		print_UART("date is ");
		printInt_UART(BCDtoDEC(data[4]));
		line_UART();
		print_UART("month is ");
		printInt_UART(BCDtoDEC(data[5]));
		line_UART();
		print_UART("year is ");
		printInt_UART(BCDtoDEC(data[6]));
		line_UART();
		line_UART();
    }
}
