#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_I2C.h"

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	pinMode(PORTC, 8, OUTPUT);
	
	init_I2C();
	if (ping_I2C(0x3F)) writePin(PORTC, 8, HIGH);
	else writePin(PORTC, 8, LOW);
	
    while (1)
    {

    }
}
