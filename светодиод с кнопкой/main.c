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
	pinMode(PORT_A, 1, PIN_INPUT_PULLUP);
	pinMode(PORT_B, 5, PIN_OUTPUT);
	
	time_init();
	enableInterrupts();
	
	uint32_t timer0 = 0;
	uint8_t button = 0;
	uint8_t flag = 0;
	
		while(1)
	{
		button = !digitalRead(PORT_A, 1);
		if (button == 1 && flag == 0 && millis() - timer0 >= 50) {
			timer0 = millis();
			flag = !flag;
			
		}
		else if (button == 1 && flag == 1) {
			digitalWrite(PORT_B, 5, LOW);
		}
		else if (button == 0 && flag == 1 && millis() - timer0 >= 50) {
			timer0 = millis();
			flag = !flag;
		}
		else digitalWrite(PORT_B, 5, HIGH);
	}
}