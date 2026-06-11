#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"

void main(void) {
	
	CLK_CKDIVR = 0;
	
	pinMode(PORTA, 1, INPUT_PULLUP);
	pinMode(PORTD, 3, OUTPUT);
	while(1) {
		if (readPin(PORTA, 1) == 0) {
			writePin(PORTD, 3, HIGH);
		}
		else writePin(PORTD, 3, LOW);
	}
}