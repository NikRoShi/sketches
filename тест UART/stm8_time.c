#include <stdint.h>
#include <stm8/my_stm8s.h>
#include <stm8/stm8_time.h>

static volatile uint32_t _millis = 0;

void tim4_tick(void)
{
    _millis++;
}

void time_init(void)
{
    _millis = 0;

    CLK_CKDIVR = 0x00;

    TIM4_CR1 = 0;
    TIM4_PSCR = 0x07;
    TIM4_ARR  = 124;

    TIM4_IER |= 0x01;
    TIM4_SR = 0;
    TIM4_CR1 |= 0x01;
}

uint32_t millis(void)
{
    uint32_t ms;

    disableInterrupts();
    ms = _millis;
    enableInterrupts();

    return ms;
}
