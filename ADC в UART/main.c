#include <stdint.h>
#include <stm8/stm8_REG.h>
#include <stm8/stm8_TIM4.h>
#include <stm8/stm8_ADC.h>
#include <stm8/stm8_UART.h>

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIM4();
}

void main(void) {
	CLK_CKDIVR = 0;
	
	PC_DDR &= ~(1 << 4);
	PC_CR1 &= ~(1 << 4);
	PC_CR2 &= ~(1 << 4);
	
	init_ADC(AIN2);
	init_TIM4();
	init_UART(9600);
	
	uint32_t timer_ADC = 0;
	uint32_t timer_print = 0;
	uint16_t value_ADC = 0;
	while(1){
		if (millis() - timer_ADC >= 50) {
			timer_ADC = millis();
			start_ADC();
		}
		if (isReady_ADC()) {value_ADC = getValue_ADC();}
		if (millis() - timer_print >= 333) {
			timer_print = millis();
			sendString_UART("adc value: ");
			sendInt_UART(value_ADC);
			sendLine_UART();
		}
	}
}