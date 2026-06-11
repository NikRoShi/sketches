#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIME.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;
	
    PB_DDR |= (1 << 5);
    PB_CR1 |= (1 << 5);

	init_TIME();
    enableInterrupts();

    uint32_t timer0 = 0;
    int8_t step = 5;
    uint16_t value = 0;

    while (1)
    {
		value = value + step;
		if (value > 950) step = -5;
		if (value < 50) step = 5;
        
        if (get_ms() - timer0 >= value) {
            timer0 = get_ms();
            PB_ODR ^= (1 << 5);
        }
    }
}
