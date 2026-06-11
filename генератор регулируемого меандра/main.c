#include <stdint.h>
#include <stm8/my_stm8s.h>
#include <stm8/stm8_time.h>

#define ARR_MIN 33
#define ARR_MAX 1000

typedef enum {
	AIN2 = 0x02,
	AIN3 = 0x03,
	AIN4 = 0x04,
	AIN5 = 0x05,
	AIN6 = 0x06
} adc_port_t;

void TIM2_UPD_OVF_IRQHandler(void) __interrupt(13)
{
    TIM2_SR1 = 0;   // ОБЯЗАТЕЛЬНО первым делом

    PC_ODR ^= (1 << 4) | (1 << 5);
}

void tim4_inerrupts(void) __interrupt(23)
{
    TIM4_SR = 0;
    tim4_tick();
}

void tim2_init(void)
{
    TIM2_CR1 = 0;          // стоп таймера

    TIM2_PSCR = 4;         // prescaler = 16
    TIM2_ARRH = ARR_MAX >> 8;
    TIM2_ARRL = ARR_MAX & 0xFF;    //  частота 500гц по умолчанию

    TIM2_IER |= 0x01;      // update interrupt
    TIM2_SR1 = 0;          // сброс флага

    TIM2_CR1 |= 0x01;      // старт
}

void adc_init(void)
{
    ADC_CR2 &= ~(1 << 3);   // ALIGN = 0 → right aligned

    ADC_CR1 = (ADC_CR1 & ~0x70) | 0x70;  // делитель /18

    ADC_CR1 |= (1 << 0);   // включить ADC
}

uint8_t analogRead(adc_port_t channel)
{
	ADC_CSR = (ADC_CSR & ~0x0F) | channel;

    ADC_CR1 |=  (1 << 0);  // ADON = 1 → старт

    while (!(ADC_CSR & (1 << 7)));

    return ADC_DRH;
}

uint8_t adc_filter(uint8_t new_value)
{
    static uint16_t filtered = 0;

    filtered = filtered + new_value - (filtered >> 3);

    return filtered >> 3;
}

void main(void)
{
	CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
	
	PC_DDR |= (1 << 4) | (1 << 5);
	PC_CR1 |= (1 << 4) | (1 << 5);
    PC_ODR &= ~((1 << 4) | (1 << 5));
    PC_ODR |= (1 << 4);
	
	PD_DDR &= ~(1 << 5);
	PD_CR1 &= ~(1 << 5);
	PD_CR2 &= ~(1 << 5);

	adc_init();

    tim2_init();
	time_init();
	enableInterrupts();
	
	uint32_t timer0 = 0;
	
    while (1) {
		if (millis() - timer0 >= 10) {
			timer0 = millis();

			uint8_t pot = adc_filter(analogRead(AIN5));
			uint16_t arr = ARR_MAX - ((uint32_t)pot * (ARR_MAX - ARR_MIN)) / 255;

			TIM2_ARRH = arr >> 8;
			TIM2_ARRL = arr & 0xFF;
		}
	}
}