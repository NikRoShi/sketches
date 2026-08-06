#include <stdint.h>
#include "stm8_REG.h"
#include "stm8_GPIO.h"
#include "stm8_SPI.h"
#include "stm8_TIME.h"

#define DIGIT_ONE	0b00001000
#define DIGIT_TWO	0b00000100
#define DIGIT_THREE	0b00000010
#define DIGIT_FOUR	0b00000001
#define DIGIT_FIVE	0b10000000
#define DIGIT_SIX	0b01000000
#define DIGIT_SEVEN	0b00100000
#define DIGIT_EIGHT	0b00010000

#define SEG_A	0b11111110
#define SEG_B	0b11111101
#define SEG_C	0b11111011
#define SEG_D	0b11110111
#define SEG_E	0b11101111
#define SEG_F	0b11011111
#define SEG_G	0b10111111
#define SEG_DP	0b01111111

#define DELAY_TIME 200

uint8_t a = 0;
uint8_t b = 0;

void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
    TIM4_SR &= ~(1 << 0);
    tick_TIME();
}

int main(void)
{
	CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	
	init_TIME();
	init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
	pinMode(PD, 3, OUTPUT);
	
	/*
	write_SPI(0b10101010);	
	write_SPI(0b00001000);
	writePin(PD, 3, HIGH);
	writePin(PD, 3, LOW);
	*/
	
    while (1)
    {
		while (a < 8)
		{
			switch (a)
			{
				case 0:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_ONE);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 1:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_TWO);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 2:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_THREE);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 3:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_FOUR);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 4:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_FIVE);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 5:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_SIX);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 6:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_SEVEN);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
				case 7:
					write_SPI(0xFF);	//сбросили в ноль все микросхемы
					write_SPI(0x00);
					writePin(PD, 3, HIGH);
					writePin(PD, 3, LOW);
					while (b < 8)
					{
						write_SPI(~(1 << b));
						write_SPI(DIGIT_EIGHT);
						writePin(PD, 3, HIGH);
						writePin(PD, 3, LOW);
						b++;
						delay(DELAY_TIME);
					}
					b = 0;
				break;
			}
			a++;
		}
		a = 0;
    }
}
