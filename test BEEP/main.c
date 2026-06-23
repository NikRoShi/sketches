#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIME.h"
#include "stm8_BEEP.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_TIME();
	init_BEEP(BEEP_2KHZ);
	
    while (1)
    {
		beep(HIGH);
		delay(100);
		beep(LOW);
		delay(100);
    }
}
