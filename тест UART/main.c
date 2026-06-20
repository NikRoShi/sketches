#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_TIME.h"
#include "stm8_UART.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

void main(void) {
    
    CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
    
	init_UART(9600);	// 2. Инициализируем периферию
	init_TIME();
	
	pinMode(PORTC, 3, OUTPUT);
	
    while(1)
    {
          if (write_UART('A') == 0) 
          {
			  writePin(PORTC, 3, HIGH);
		  }
		  writePin(PORTC, 3, LOW);
          delay(1000);  
    }
}
