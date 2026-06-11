#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIM4.h"
#include "stm8_PWM.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIM4();
}

void main (void) {
	CLK_CKDIVR = 0;
	
	init_TIM4();
	init_PWM(1023);
	startChannel_PWM(PD4);
	
	enableInterrupts();
	
	uint8_t direction = 1;
	uint16_t duty = 0;
	uint32_t timer1 = 0;
	
	while(1) {
		if (millis() - timer1 >= 1 && direction) {
			timer1 = millis();
			write_PWM(PD4, duty);
			duty++;
		}
		if (millis() - timer1 >= 1 && !direction) {
			timer1 = millis();
			write_PWM(PD4, duty);
			duty--;
		}
		if (duty >= 1023) {
			duty = 1023;
			direction = 0;
		}
		if (duty <= 0) {
			duty = 0;
			direction = 1;
		}
	}
}