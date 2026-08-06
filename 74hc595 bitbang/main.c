#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_TIME.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

void BB_transmite(uint8_t data)
{	
	writePin(PD, 2, LOW);	// latc в low
	writePin(PC, 5, LOW);	// clk в low
	writePin(PC, 6, LOW);	// data в low
	
	for (uint8_t a; a < 8; a++)
	{
		if (data & 1)
		{
			writePin(PC, 6, HIGH);	// data в high
			writePin(PC, 5, HIGH);	// clk в high
			writePin(PC, 5, LOW);	// clk в low
		}
		else
		{
			writePin(PC, 6, LOW);	// data в low
			writePin(PC, 5, HIGH);	// clk в high
			writePin(PC, 5, LOW);	// clk в low
		}
		data = data >> 1;
	}
	
	writePin(PD, 2, HIGH);	// latc в high
	writePin(PD, 2, LOW);	// latc в low
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_TIME();
	
	uint8_t i = 0;
	
	pinMode(PC, 5, OUTPUT); // CLK
	pinMode(PC, 6, OUTPUT);	// data
	pinMode(PD, 2, OUTPUT);	// latc
	
    while (1)
    {
		BB_transmite(0);
		for (i; i < 255; i++) {
			BB_transmite(i);
			delay(50);
		}
		i = 0;
    }
}
