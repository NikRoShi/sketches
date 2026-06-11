#include <stdint.h>
#include <my_stm8s.h>

volatile uint16_t ms_counter = 0;
uint16_t last_time = 0;

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
{
    TIM4_SR = 0;
    ms_counter++;
}

void tim4_init(void)
{
    TIM4_CR1 = 0;      // выключаем таймер

    TIM4_PSCR = 0x07;  // prescaler = 128
    TIM4_ARR  = 128;   // 1 мс

    TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
    TIM4_SR  = 0;      // сброс флагов

    TIM4_CR1 |= 0x01;  // включаем таймер
}

#define LED_MASK (1 << 5)

int main(void)
{
    PB_DDR |= LED_MASK;
    PB_CR1 |= LED_MASK;
	
	CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц

    tim4_init();
    enableInterrupts();   // глобально разрешаем прерывания

    while (1)
    {
        if ((uint16_t)(ms_counter - last_time) >= 1000)
        {
            PB_ODR ^= LED_MASK;   // переключаем светодиод
            last_time = ms_counter;
        }
    }
}