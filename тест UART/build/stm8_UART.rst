                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_UART
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_UART
                                     12 	.globl _write_UART
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint16_t baudrate)
                                     51 ;	-----------------------------------------
                                     52 ;	 function init_UART
                                     53 ;	-----------------------------------------
      008595                         54 _init_UART:
      008595 88               [ 1]   55 	push	a
                                     56 ;	../../my_STM8_libraries/stm8_UART.c: 7: PD_DDR |= (1 << TX_PIN);
      008596 72 1A 50 11      [ 1]   57 	bset	0x5011, #5
                                     58 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_CR1 |= (1 << TX_PIN);
      00859A 72 1A 50 12      [ 1]   59 	bset	0x5012, #5
                                     60 ;	../../my_STM8_libraries/stm8_UART.c: 10: uartdiv = F_CPU / baudrate;
      00859E 90 5F            [ 1]   61 	clrw	y
      0085A0 89               [ 2]   62 	pushw	x
      0085A1 90 89            [ 2]   63 	pushw	y
      0085A3 4B 00            [ 1]   64 	push	#0x00
      0085A5 4B 24            [ 1]   65 	push	#0x24
      0085A7 4B F4            [ 1]   66 	push	#0xf4
      0085A9 4B 00            [ 1]   67 	push	#0x00
      0085AB CD 85 DD         [ 4]   68 	call	__divulong
      0085AE 5B 08            [ 2]   69 	addw	sp, #8
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      0085B0 9F               [ 1]   71 	ld	a, xl
      0085B1 A4 0F            [ 1]   72 	and	a, #0x0f
      0085B3 6B 01            [ 1]   73 	ld	(0x01, sp), a
      0085B5 9E               [ 1]   74 	ld	a, xh
      0085B6 A4 F0            [ 1]   75 	and	a, #0xf0
      0085B8 1A 01            [ 1]   76 	or	a, (0x01, sp)
      0085BA C7 52 33         [ 1]   77 	ld	0x5233, a
                                     78 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      0085BD A6 10            [ 1]   79 	ld	a, #0x10
      0085BF 62               [ 2]   80 	div	x, a
      0085C0 9F               [ 1]   81 	ld	a, xl
      0085C1 C7 52 32         [ 1]   82 	ld	0x5232, a
                                     83 ;	../../my_STM8_libraries/stm8_UART.c: 15: UART1_CR2 |= UART1_CR2_TEN;
      0085C4 72 16 52 35      [ 1]   84 	bset	0x5235, #3
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: }
      0085C8 84               [ 1]   86 	pop	a
      0085C9 81               [ 4]   87 	ret
                                     88 ;	../../my_STM8_libraries/stm8_UART.c: 17: uint8_t write_UART(uint8_t data)
                                     89 ;	-----------------------------------------
                                     90 ;	 function write_UART
                                     91 ;	-----------------------------------------
      0085CA                         92 _write_UART:
      0085CA 88               [ 1]   93 	push	a
      0085CB 6B 01            [ 1]   94 	ld	(0x01, sp), a
                                     95 ;	../../my_STM8_libraries/stm8_UART.c: 21: while (!(UART1_SR & UART1_SR_TXE))
      0085CD                         96 00103$:
      0085CD C6 52 30         [ 1]   97 	ld	a, 0x5230
      0085D0 2A FB            [ 1]   98 	jrpl	00103$
                                     99 ;	../../my_STM8_libraries/stm8_UART.c: 26: UART1_DR = data;
      0085D2 AE 52 31         [ 2]  100 	ldw	x, #0x5231
      0085D5 7B 01            [ 1]  101 	ld	a, (0x01, sp)
      0085D7 F7               [ 1]  102 	ld	(x), a
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 27: return 1;
      0085D8 A6 01            [ 1]  104 	ld	a, #0x01
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 28: }
      0085DA 5B 01            [ 2]  106 	addw	sp, #1
      0085DC 81               [ 4]  107 	ret
                                    108 	.area CODE
                                    109 	.area CONST
                                    110 	.area INITIALIZER
                                    111 	.area CABS (ABS)
