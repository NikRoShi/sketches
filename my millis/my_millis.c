#include <stdint.h>
#include <stm8/my_stm8s.h>

volatile uint32_t ms_counter;

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
{
    TIM4_SR = 0;
    ms_counter++;
}

void tim4_init(void)
{
    TIM4_CR1 = 0;      // выключаем таймер

    TIM4_PSCR = 0x07;  // prescaler = 128
    TIM4_ARR  = 124;   // 1 мс

    TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
    TIM4_SR  = 0;      // сброс флагов

    TIM4_CR1 |= 0x01;  // включаем таймер
}

uint32_t millis(void)
{
	uint32_t t;
	
	disableInterrupts();
	t = ms_counter;
	enableInterrupts();
	
	return t;
}

#define LED_MASK (1 << 5)

int main(void) // здесь какбы начинается setup()
{
	PB_DDR |= LED_MASK;
    PB_CR1 |= LED_MASK;
	
	CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц

    tim4_init();
    enableInterrupts();   // глобально разрешаем прерывания
	
	uint32_t timer1 = 0;
	
	while(1) // здесь какбы заканчивается setup() и начинается loop()
	{
		if (millis() - timer1 >= 333)
		{
			timer1 = millis();
			PB_ODR ^= LED_MASK;   // переключаем светодиод
		}
	}
}
