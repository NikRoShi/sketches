#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_TIME.h"
#include "stm8_GPIO.h"

uint32_t timBut1 = 0;
uint32_t timBut2 = 0;
uint32_t timBut3 = 0;
uint32_t timer = 0;

uint8_t butFlg1 = 0;
uint8_t butFlg2 = 0;
uint8_t butFlg3 = 0;

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	init_TIME();
	
	pinMode(PA, 1, INPUT_PULLUP);
	pinMode(PA, 2, INPUT_PULLUP);
	pinMode(PA, 3, INPUT_PULLUP);
	pinMode(PD, 3, OUTPUT);
	
    while (1)
    {
		if (readPin(PA, 1) == 0 && butFlg1 == 0)
		{
			butFlg1 = 1;
			timBut1 = get_ms();
			writePin(PD, 3, HIGH);
		}
		if (readPin(PA, 1) == 1 && butFlg1 == 1)
		{
			butFlg1 = 0;
			timBut1 = get_ms();
			writePin(PD, 3, LOW);
		}
    }
}
