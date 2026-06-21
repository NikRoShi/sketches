#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_I2C.h"
#include "stm8_UART.h"
#include "stm8_TIME.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

uint8_t BCDtoDEC(uint8_t bcd) 
{
	return (((bcd >> 4) * 10) + (bcd & 0x0F));
}

int main(void)
{
	uint8_t buf[2];
	
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_I2C();
	init_TIME();
	init_UART(9600);
	
    while (1)
    {
		if (readBuffer2_I2C(0x68, 0x00, buf) == 0)
		{
			print_UART("fail");
			line_UART();
		}
		else
		{
			print_UART("second is ");
			printInt_UART(BCDtoDEC(buf[0]));
			line_UART();
			print_UART("minutes is ");
			printInt_UART(BCDtoDEC(buf[1]));
			line_UART();
			line_UART();
		}
    }
}
