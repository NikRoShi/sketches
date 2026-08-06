#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_SPI.h"
#include "stm8_TIME.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_TIME();
	init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
	pinMode(PD, 2, OUTPUT);
	
    while (1)
    {
		for (uint8_t i; i <= 255; i++)
		{
			write_SPI(i);
			writePin(PD, 2, HIGH);
			writePin(PD, 2, LOW);
			delay(50);
		}
    }
}
