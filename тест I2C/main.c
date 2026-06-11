#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_TIME.h"
#include "stm8_UART.h"
#include "stm8_I2C.h"

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

void main(void) {
    CLK_CKDIVR = 0;
	init_TIME();
    init_UART(9600);
    init_I2C();
	enableInterrupts();
	
    //настройка PB4, PB5 как Open Drain
    pinMode(PORTD, 5, OUTPUT);
	
    //настройка PB4, PB5 как Open Drain
    pinMode(PORTB, 4, OUTPUT_OD);
	pinMode(PORTB, 5, OUTPUT_OD);
	
	// Настройка датчика: 0x27 означает:
	// Опрос температуры x1, Опрос давления x1, Режим Normal
	if (start_I2C() && sendAddress_I2C(0xEC)) {
		write_I2C(0xF4); // Регистр ctrl_meas
		write_I2C(0x2E); // Значение настроек
		stop_I2C();
		sendString_UART("Sensor Configured!\r\n");
	}

    while(1) {
        if (start_I2C() && sendAddress_I2C(0xEC)) {
            write_I2C(0xFA); // Начальный регистр температуры
            
            start_I2C();     // Restart
            sendAddress_I2C(0xED); // Переходим на чтение
            
            // Читаем 3 байта подряд
            uint32_t msb  = readAck_I2C();
            uint32_t lsb  = readAck_I2C();
            uint32_t xlsb = readNack_I2C(); 
            
            // Самая надежная формула склейки для BMP280
            // Данные - это 20-битное число: [MSB][LSB][XLSB_high_4_bits]
            uint32_t raw_temp = (msb << 12) | (lsb << 4) | (xlsb >> 4);
            
            sendString_UART("Raw Temp: ");
            sendInt_UART(raw_temp); 
            sendLine_UART();
        }
        
        delay(500); // Пауза полсекунды
    }
}


