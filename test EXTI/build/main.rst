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
                                     13 	.globl _handlerPortA
                                     14 	.globl _set_EXTI_pin
                                     15 	.globl _set_EXTI
                                     16 	.globl _line_UART
                                     17 	.globl _printInt_UART
                                     18 	.globl _init_UART
                                     19 	.globl _counter
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
      00000C                         28 _counter::
      00000C                         29 	.ds 1
                                     30 ;--------------------------------------------------------
                                     31 ; Stack segment in internal ram
                                     32 ;--------------------------------------------------------
                                     33 	.area	SSEG
      000021                         34 __start__stack:
      000021                         35 	.ds	1
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; absolute external ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DABS (ABS)
                                     41 
                                     42 ; default segment ordering for linker
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area CONST
                                     47 	.area INITIALIZER
                                     48 	.area CODE
                                     49 
                                     50 ;--------------------------------------------------------
                                     51 ; interrupt vector
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
      008000                         54 __interrupt_vect:
      008000 82 00 80 1B             55 	int s_GSINIT ; reset
      008004 82 00 00 00             56 	int 0x000000 ; trap
      008008 82 00 00 00             57 	int 0x000000 ; int0
      00800C 82 00 00 00             58 	int 0x000000 ; int1
      008010 82 00 00 00             59 	int 0x000000 ; int2
      008014 82 00 80 5F             60 	int _EXTI_A_IRQHandler ; int3
                                     61 ;--------------------------------------------------------
                                     62 ; global & static initialisations
                                     63 ;--------------------------------------------------------
                                     64 	.area HOME
                                     65 	.area GSINIT
                                     66 	.area GSFINAL
                                     67 	.area GSINIT
      00801B                         68 __sdcc_init_data:
                                     69 ; stm8_genXINIT() start
      00801B AE 00 0B         [ 2]   70 	ldw x, #l_DATA
      00801E 27 07            [ 1]   71 	jreq	00002$
      008020                         72 00001$:
      008020 72 4F 00 00      [ 1]   73 	clr (s_DATA - 1, x)
      008024 5A               [ 2]   74 	decw x
      008025 26 F9            [ 1]   75 	jrne	00001$
      008027                         76 00002$:
      008027 AE 00 15         [ 2]   77 	ldw	x, #l_INITIALIZER
      00802A 27 09            [ 1]   78 	jreq	00004$
      00802C                         79 00003$:
      00802C D6 80 49         [ 1]   80 	ld	a, (s_INITIALIZER - 1, x)
      00802F D7 00 0B         [ 1]   81 	ld	(s_INITIALIZED - 1, x), a
      008032 5A               [ 2]   82 	decw	x
      008033 26 F7            [ 1]   83 	jrne	00003$
      008035                         84 00004$:
                                     85 ; stm8_genXINIT() end
                                     86 	.area GSFINAL
      008035 CC 80 18         [ 2]   87 	jp	__sdcc_program_startup
                                     88 ;--------------------------------------------------------
                                     89 ; Home
                                     90 ;--------------------------------------------------------
                                     91 	.area HOME
                                     92 	.area HOME
      008018                         93 __sdcc_program_startup:
      008018 CC 80 65         [ 2]   94 	jp	_main
                                     95 ;	return from main will return to caller
                                     96 ;--------------------------------------------------------
                                     97 ; code
                                     98 ;--------------------------------------------------------
                                     99 	.area CODE
                                    100 ;	main.c: 8: void EXTI_A_IRQHandler(void) __interrupt(IRQ_EXTI0)
                                    101 ;	-----------------------------------------
                                    102 ;	 function EXTI_A_IRQHandler
                                    103 ;	-----------------------------------------
      00805F                        104 _EXTI_A_IRQHandler:
      00805F 4F               [ 1]  105 	clr	a
      008060 62               [ 2]  106 	div	x, a
                                    107 ;	main.c: 10: handlerPortA();
      008061 CD 88 A4         [ 4]  108 	call	_handlerPortA
                                    109 ;	main.c: 11: }
      008064 80               [11]  110 	iret
                                    111 ;	main.c: 13: int main(void)
                                    112 ;	-----------------------------------------
                                    113 ;	 function main
                                    114 ;	-----------------------------------------
      008065                        115 _main:
                                    116 ;	main.c: 15: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008065 35 00 50 C6      [ 1]  117 	mov	0x50c6+0, #0x00
                                    118 ;	main.c: 17: init_UART(9600, DISABLE);
      008069 4F               [ 1]  119 	clr	a
      00806A AE 25 80         [ 2]  120 	ldw	x, #0x2580
      00806D CD 8B A7         [ 4]  121 	call	_init_UART
                                    122 ;	main.c: 19: set_EXTI(EXTI_PORTA, FALLING);
      008070 4B 02            [ 1]  123 	push	#0x02
      008072 4F               [ 1]  124 	clr	a
      008073 CD 86 DB         [ 4]  125 	call	_set_EXTI
                                    126 ;	main.c: 20: set_EXTI_pin(EXTI_PORTA, 1);
      008076 4B 01            [ 1]  127 	push	#0x01
      008078 4F               [ 1]  128 	clr	a
      008079 CD 87 38         [ 4]  129 	call	_set_EXTI_pin
                                    130 ;	main.c: 22: enableInterrupts();	
      00807C 9A               [ 1]  131 	rim
                                    132 ;	main.c: 23: while (1)
      00807D                        133 00104$:
                                    134 ;	main.c: 25: if (EXTI_FlagA & (1 << 1))
      00807D 72 03 00 11 FB   [ 2]  135 	btjf	_EXTI_FlagA+0, #1, 00104$
                                    136 ;	main.c: 27: EXTI_FlagA &= ~(1 << 1);
      008082 72 13 00 11      [ 1]  137 	bres	_EXTI_FlagA+0, #1
                                    138 ;	main.c: 28: counter++;
      008086 72 5C 00 0C      [ 1]  139 	inc	_counter+0
                                    140 ;	main.c: 29: printInt_UART(counter);
      00808A C6 00 0C         [ 1]  141 	ld	a, _counter+0
      00808D 5F               [ 1]  142 	clrw	x
      00808E 97               [ 1]  143 	ld	xl, a
      00808F CD 8C 1E         [ 4]  144 	call	_printInt_UART
                                    145 ;	main.c: 30: line_UART();
      008092 CD 8C 7D         [ 4]  146 	call	_line_UART
      008095 20 E6            [ 2]  147 	jra	00104$
                                    148 ;	main.c: 33: }
      008097 81               [ 4]  149 	ret
                                    150 	.area CODE
                                    151 	.area CONST
                                    152 	.area INITIALIZER
      00804A                        153 __xinit__counter:
      00804A 00                     154 	.db #0x00	; 0
                                    155 	.area CABS (ABS)
