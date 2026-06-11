#include <stdint.h>
#include <stm8/my_stm8s.h>
#include <stm8/stm8_time.h>
#include <stm8/stm8_UART.h>


void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {	// Обработчик прерывания TIM4 (для millis)

    TIM4_SR &= ~(1 << 0); // Очистка флага UIF (лучше через &= ~)
    tim4_tick();
}

void main(void) {
    
    CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
    
    
	init_UART(9600);	// 2. Инициализируем периферию
    time_init();   		// Настройка TIM4
    
    
    enableInterrupts();	// 3. Разрешаем прерывания
    
    uint32_t timer0 = 0;
    
    while(1) {
        if (millis() - timer0 >= 333) {
            timer0 = millis();
            sendString_UART("hello world!");
            sendLine_UART();
        }
    }
}