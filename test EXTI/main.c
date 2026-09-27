#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_UART.h"
#include "stm8_interrupt.h"

uint8_t counter = 0;

void EXTI_A_IRQHandler(void) __interrupt(IRQ_EXTI0)
{
	handlerPortA();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_UART(9600, DISABLE);
	
	set_EXTI(EXTI_PORTA, FALLING);
	set_EXTI_pin(EXTI_PORTA, 1);
	
	enableInterrupts();	
    while (1)
    {
		if (EXTI_FlagA & (1 << 1))
		{
			EXTI_FlagA &= ~(1 << 1);
			counter++;
			printInt_UART(counter);
			line_UART();
		}
    }
}
