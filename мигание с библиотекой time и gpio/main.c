#include <stdint.h>
#include <stm8/my_stm8s.h>
#include <stm8/stm8_time.h>
#include <stm8/stm8_gpio.h>

void tim4_inerrupts(void) __interrupt(23)
{
    TIM4_SR = 0;
    tim4_tick();
}


void main(void)
{
	pinMode(PORT_B, 5, OUTPUT);
	
	time_init();
	enableInterrupts();
	
	uint32_t timer0 = 0;
	uint8_t flag = 0;
	
	while(1)
	{
		if (millis() - timer0 >= 333 && flag == 0)
		{
			timer0 = millis();
			flag = 1;
			digitalWrite(PORT_B, 5, HIGH);
		}
		if (millis() - timer0 >= 333 && flag == 1)
		{
			timer0 = millis();
			flag = 0;
			digitalWrite(PORT_B, 5, LOW);
		}
	}
}