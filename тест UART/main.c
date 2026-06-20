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
	
	for (uint8_t i = 33; i < 127; i++)
	{
	write_UART(i);	
	}
	line_UART();
	delay(333);
	
	print_UART("Hello world!");
	line_UART();
	delay(333);
	
	printInt_UART(0);
	line_UART();
	printInt_UART(12345);
	line_UART();
	delay(333);
	
	printHex_UART(0xAB);
	line_UART();
	
    while(1)
    {
		 if (isDataReceived_UART())
		 {
			 char data = getData_UART();
			 if (data == 'n' || data == 'N') writePin(PORTC, 3, HIGH);
			 if (data == 'f' || data == 'F') writePin(PORTC, 3, LOW);
		 }
    }
}
