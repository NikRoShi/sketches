#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_UART.h"
#include "stm8_GPIO.h"

uint8_t ledFlag = 1;
uint8_t key = 'r';

void UART1_RX_IRQHandler(void) __interrupt(IRQ_UART1_RX) {
	
	key = getData_UART();
    
    if (key == 's' || key == 'S') ledFlag = 0;
    if (key == 'r' || key == 'R') ledFlag = 1;
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	pinMode(PB, 5, OUTPUT);
	
	init_UART(9600, ENABLE);
	enableInterrupts();
	
    while (1)
    {
		if (ledFlag) writePin(PB, 5, HIGH);
		else writePin(PB, 5, LOW);
    }
}
