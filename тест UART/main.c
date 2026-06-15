#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_UART.h"

void main(void) {
    
    CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
    
	init_UART(9600);	// 2. Инициализируем периферию
	
	for (uint8_t i = 32; i < 128; i++)
	{
		sendByte_UART(i);
	}
	sendLine_UART();
	
    while(1)
    {
            
    }
}
