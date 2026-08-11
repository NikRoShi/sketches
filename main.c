#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIME.h"
#include "stm8_7SEG595_display.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
	refresh_display();
}

void main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_TIME();
	init_display(PD, 3);
	
	setDigit(0, 1);
	setDigit(1, 2);
	setDigit(2, 3);
	setDigit(3, 4);
	setDigit(4, 5);
	setDigit(5, 6);
	setDigit(6, 7);
	setDigit(7, 8);

	while(1)
	{

	}
}