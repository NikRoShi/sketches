#include <stm8s.h>

void delay(void)
{
    for (volatile long i = 0; i < 30000; i++);  // простая пауза
}

void main(void)
{
    // Настраиваем PB5 как выход
    PB_DDR |= (1 << 5);   // направление: выход
    PB_CR1 |= (1 << 5);   // режим push-pull (тянет и к Vcc, и к GND)

    while (1)
    {
        // Инвертируем (переключаем)
        PB_ODR ^= (1 << 5);
        delay();
    }
}
