#include <stm8/stm8_UART.h>

void init_UART(uint32_t baudRate) {
	// 1. ВКЛЮЧАЕМ ТАКТИРОВАНИЕ UART1 (Важнейший шаг!)
	CLK_PCKENR1 |= (1 << 3); 
	// настраиваем пины
	// tx
	PD_DDR |= (1 << TX_PIN);
	PD_CR1 |= (1 << TX_PIN);
	PD_CR2 |= (1 << TX_PIN);
	// rx
	PD_DDR &= ~(1 << RX_PIN);
	PD_CR1 &= ~(1 << RX_PIN);
	// задаём скорость передачи
	uint16_t uart_div = (uint32_t)(16000000 / baudRate);
	UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
	UART1_BRR1 = (uart_div >> 4) & 0x00FF;
	// включаем передачу и приём
	UART1_CR2 |= (1 << 3) | (1 << 2);
}

void sendByte_UART(uint8_t byte) {
	while(!(UART1_SR & (1 << 7))) {}
	UART1_DR = byte;
}	

void sendString_UART(const char *str) {
    while (*str) {               // Пока текущий символ не '\0' (не ноль)
        sendByte_UART(*str);     // Отправляем текущий символ
        str++;                   // Переходим к следующему адресу в памяти
    }
}

void sendLine_UART(void) {
	sendByte_UART('\r');
	sendByte_UART('\n');
}

void sendInt_UART(uint8_t num) {
    if (num == 0) {
        sendByte_UART('0');
        return;
    }

    uint8_t digits[3]; // Максимум 3 цифры для 255
    int8_t i = 0;

    // Разбираем число на цифры с конца
    while (num > 0) {
        digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
        num /= 10;
    }

    // Выводим цифры в обратном порядке
    while (i > 0) {
        sendByte_UART(digits[--i]);
    }
}