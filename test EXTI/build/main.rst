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
      008018 CC 80 6C         [ 2]   93 	jp	_main
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
                                    104 ;	main.c: 12: changedA = PA_IDR;
      00805F C6 50 01         [ 1]  105 	ld	a, 0x5001
                                    106 ;	main.c: 13: changedA &= EXTIPinMaskA;
      008062 C4 00 10         [ 1]  107 	and	a, _EXTIPinMaskA+0
                                    108 ;	main.c: 14: EXTI_FlagA |= changedA;
      008065 CA 00 11         [ 1]  109 	or	a, _EXTI_FlagA+0
      008068 C7 00 11         [ 1]  110 	ld	_EXTI_FlagA+0, a
                                    111 ;	main.c: 15: }
      00806B 80               [11]  112 	iret
                                    113 ;	main.c: 17: int main(void)
                                    114 ;	-----------------------------------------
                                    115 ;	 function main
                                    116 ;	-----------------------------------------
      00806C                        117 _main:
                                    118 ;	main.c: 19: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00806C 35 00 50 C6      [ 1]  119 	mov	0x50c6+0, #0x00
                                    120 ;	main.c: 21: init_UART(9600, DISABLE);
      008070 4F               [ 1]  121 	clr	a
      008071 AE 25 80         [ 2]  122 	ldw	x, #0x2580
      008074 CD 8B 51         [ 4]  123 	call	_init_UART
                                    124 ;	main.c: 23: set_EXTI(EXTI_PORTA, FALLING);
      008077 4B 02            [ 1]  125 	push	#0x02
      008079 4F               [ 1]  126 	clr	a
      00807A CD 86 E2         [ 4]  127 	call	_set_EXTI
                                    128 ;	main.c: 24: set_EXTI_pin(EXTI_PORTA, 1);
      00807D 4B 01            [ 1]  129 	push	#0x01
      00807F 4F               [ 1]  130 	clr	a
      008080 CD 87 19         [ 4]  131 	call	_set_EXTI_pin
                                    132 ;	main.c: 26: enableInterrupts();	
      008083 9A               [ 1]  133 	rim
                                    134 ;	main.c: 27: while (1)
      008084                        135 00104$:
                                    136 ;	main.c: 29: if (EXTI_FlagA & (1 << 1))
      008084 72 03 00 11 FB   [ 2]  137 	btjf	_EXTI_FlagA+0, #1, 00104$
                                    138 ;	main.c: 31: EXTI_FlagA &= ~(1 << 1);
      008089 72 13 00 11      [ 1]  139 	bres	_EXTI_FlagA+0, #1
                                    140 ;	main.c: 32: counter++;
      00808D 72 5C 00 0C      [ 1]  141 	inc	_counter+0
                                    142 ;	main.c: 33: printInt_UART(counter);
      008091 C6 00 0C         [ 1]  143 	ld	a, _counter+0
      008094 5F               [ 1]  144 	clrw	x
      008095 97               [ 1]  145 	ld	xl, a
      008096 CD 8B C8         [ 4]  146 	call	_printInt_UART
                                    147 ;	main.c: 34: line_UART();
      008099 CD 8C 27         [ 4]  148 	call	_line_UART
      00809C 20 E6            [ 2]  149 	jra	00104$
                                    150 ;	main.c: 37: }
      00809E 81               [ 4]  151 	ret
                                    152 	.area CODE
                                    153 	.area CONST
                                    154 	.area INITIALIZER
      00804A                        155 __xinit__counter:
      00804A 00                     156 	.db #0x00	; 0
                                    157 	.area CABS (ABS)
