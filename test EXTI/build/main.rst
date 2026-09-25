                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _EXTI_A_IRQHandler
                                     13 	.globl _set_EXTI_pin
                                     14 	.globl _set_EXTI
                                     15 	.globl _line_UART
                                     16 	.globl _printInt_UART
                                     17 	.globl _init_UART
                                     18 	.globl _counter
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
      00000C                         27 _counter::
      00000C                         28 	.ds 1
                                     29 ;--------------------------------------------------------
                                     30 ; Stack segment in internal ram
                                     31 ;--------------------------------------------------------
                                     32 	.area	SSEG
      000021                         33 __start__stack:
      000021                         34 	.ds	1
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 
                                     41 ; default segment ordering for linker
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area CONST
                                     46 	.area INITIALIZER
                                     47 	.area CODE
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; interrupt vector
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
      008000                         53 __interrupt_vect:
      008000 82 00 80 1B             54 	int s_GSINIT ; reset
      008004 82 00 00 00             55 	int 0x000000 ; trap
      008008 82 00 00 00             56 	int 0x000000 ; int0
      00800C 82 00 00 00             57 	int 0x000000 ; int1
      008010 82 00 00 00             58 	int 0x000000 ; int2
      008014 82 00 80 5F             59 	int _EXTI_A_IRQHandler ; int3
                                     60 ;--------------------------------------------------------
                                     61 ; global & static initialisations
                                     62 ;--------------------------------------------------------
                                     63 	.area HOME
                                     64 	.area GSINIT
                                     65 	.area GSFINAL
                                     66 	.area GSINIT
      00801B                         67 __sdcc_init_data:
                                     68 ; stm8_genXINIT() start
      00801B AE 00 0B         [ 2]   69 	ldw x, #l_DATA
      00801E 27 07            [ 1]   70 	jreq	00002$
      008020                         71 00001$:
      008020 72 4F 00 00      [ 1]   72 	clr (s_DATA - 1, x)
      008024 5A               [ 2]   73 	decw x
      008025 26 F9            [ 1]   74 	jrne	00001$
      008027                         75 00002$:
      008027 AE 00 15         [ 2]   76 	ldw	x, #l_INITIALIZER
      00802A 27 09            [ 1]   77 	jreq	00004$
      00802C                         78 00003$:
      00802C D6 80 49         [ 1]   79 	ld	a, (s_INITIALIZER - 1, x)
      00802F D7 00 0B         [ 1]   80 	ld	(s_INITIALIZED - 1, x), a
      008032 5A               [ 2]   81 	decw	x
      008033 26 F7            [ 1]   82 	jrne	00003$
      008035                         83 00004$:
                                     84 ; stm8_genXINIT() end
                                     85 	.area GSFINAL
      008035 CC 80 18         [ 2]   86 	jp	__sdcc_program_startup
                                     87 ;--------------------------------------------------------
                                     88 ; Home
                                     89 ;--------------------------------------------------------
                                     90 	.area HOME
                                     91 	.area HOME
      008018                         92 __sdcc_program_startup:
      008018 CC 80 74         [ 2]   93 	jp	_main
                                     94 ;	return from main will return to caller
                                     95 ;--------------------------------------------------------
                                     96 ; code
                                     97 ;--------------------------------------------------------
                                     98 	.area CODE
                                     99 ;	main.c: 8: void EXTI_A_IRQHandler(void) __interrupt(IRQ_EXTI0)
                                    100 ;	-----------------------------------------
                                    101 ;	 function EXTI_A_IRQHandler
                                    102 ;	-----------------------------------------
      00805F                        103 _EXTI_A_IRQHandler:
                                    104 ;	main.c: 13: currentStateA = PA_IDR;
      00805F C6 50 01         [ 1]  105 	ld	a, 0x5001
                                    106 ;	main.c: 14: changedA = previousStateA ^ currentStateA;
      008062 97               [ 1]  107 	ld	xl, a
      008063 C8 00 0F         [ 1]  108 	xor	a, _previousStateA+0
                                    109 ;	main.c: 15: changedA &= EXTIPinMaskA;
      008066 C4 00 10         [ 1]  110 	and	a, _EXTIPinMaskA+0
                                    111 ;	main.c: 16: EXTI_FlagA |= changedA;
      008069 CA 00 11         [ 1]  112 	or	a, _EXTI_FlagA+0
      00806C C7 00 11         [ 1]  113 	ld	_EXTI_FlagA+0, a
                                    114 ;	main.c: 17: previousStateA = currentStateA;
      00806F 9F               [ 1]  115 	ld	a, xl
      008070 C7 00 0F         [ 1]  116 	ld	_previousStateA+0, a
                                    117 ;	main.c: 18: }
      008073 80               [11]  118 	iret
                                    119 ;	main.c: 20: int main(void)
                                    120 ;	-----------------------------------------
                                    121 ;	 function main
                                    122 ;	-----------------------------------------
      008074                        123 _main:
                                    124 ;	main.c: 22: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008074 35 00 50 C6      [ 1]  125 	mov	0x50c6+0, #0x00
                                    126 ;	main.c: 24: init_UART(9600, DISABLE);
      008078 4F               [ 1]  127 	clr	a
      008079 AE 25 80         [ 2]  128 	ldw	x, #0x2580
      00807C CD 8B 59         [ 4]  129 	call	_init_UART
                                    130 ;	main.c: 26: set_EXTI(EXTI_PORTA, FALLING);
      00807F 4B 02            [ 1]  131 	push	#0x02
      008081 4F               [ 1]  132 	clr	a
      008082 CD 86 EA         [ 4]  133 	call	_set_EXTI
                                    134 ;	main.c: 27: set_EXTI_pin(EXTI_PORTA, 1);
      008085 4B 01            [ 1]  135 	push	#0x01
      008087 4F               [ 1]  136 	clr	a
      008088 CD 87 21         [ 4]  137 	call	_set_EXTI_pin
                                    138 ;	main.c: 29: enableInterrupts();	
      00808B 9A               [ 1]  139 	rim
                                    140 ;	main.c: 30: while (1)
      00808C                        141 00104$:
                                    142 ;	main.c: 32: if (EXTI_FlagA & (1 << 1))
      00808C 72 03 00 11 FB   [ 2]  143 	btjf	_EXTI_FlagA+0, #1, 00104$
                                    144 ;	main.c: 34: EXTI_FlagA &= ~(1 << 1);
      008091 72 13 00 11      [ 1]  145 	bres	_EXTI_FlagA+0, #1
                                    146 ;	main.c: 35: counter++;
      008095 72 5C 00 0C      [ 1]  147 	inc	_counter+0
                                    148 ;	main.c: 36: printInt_UART(counter);
      008099 C6 00 0C         [ 1]  149 	ld	a, _counter+0
      00809C 5F               [ 1]  150 	clrw	x
      00809D 97               [ 1]  151 	ld	xl, a
      00809E CD 8B D0         [ 4]  152 	call	_printInt_UART
                                    153 ;	main.c: 37: line_UART();
      0080A1 CD 8C 2F         [ 4]  154 	call	_line_UART
      0080A4 20 E6            [ 2]  155 	jra	00104$
                                    156 ;	main.c: 40: }
      0080A6 81               [ 4]  157 	ret
                                    158 	.area CODE
                                    159 	.area CONST
                                    160 	.area INITIALIZER
      00804A                        161 __xinit__counter:
      00804A 00                     162 	.db #0x00	; 0
                                    163 	.area CABS (ABS)
