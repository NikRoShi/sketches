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
	
	init_display(PD, 3);
	init_TIME();
	enableInterrupts();

	while(1)
	{
		for (uint32_t a; a < 100000000; a++)
		{
			printNumber(a);
		}
		clear_display();
	}
}
