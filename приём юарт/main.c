#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIM4.h"
#include "stm8_UART.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIM4();
}

void main(void) {
	
	CLK_CKDIVR = 0x00;
		
	init_TIM4();
	init_UART(9600);
	
	enableInterrupts();
	
	PD_DDR |= (1 << 2) | (1 << 3);
	PD_CR1 |= (1 << 2) | (1 << 3);
	
	while(1) {
		if (available_UART() == 1) {
			switch (read_UART()) {
				case '1':
					PD_ODR ^= (1 << 3);
					break;
				case '2':
					PD_ODR ^= (1 << 2);
					break;
			}
		}
	}
}