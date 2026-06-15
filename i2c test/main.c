#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_I2C.h"
#include "stm8_TIME.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_I2C();
	init_TIME();
	
	start_I2C();
	writeAddr_I2C(0x3F);
	
    while (1)
    {
		writeByte_I2C(0x08);
		delay(333);
		writeByte_I2C(0x00);
		delay(333);
    }
}
