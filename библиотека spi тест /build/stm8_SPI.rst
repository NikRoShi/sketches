                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_SPI
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_SPI
                                     12 	.globl _exchange_SPI
                                     13 	.globl _write_SPI
                                     14 	.globl _read_SPI
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	../../my_STM8_libraries/stm8_SPI.c: 3: void init_SPI(uint8_t mode, uint8_t div, uint8_t firstBit, uint8_t masterSlave)
                                     53 ;	-----------------------------------------
                                     54 ;	 function init_SPI
                                     55 ;	-----------------------------------------
      008769                         56 _init_SPI:
      008769 88               [ 1]   57 	push	a
      00876A 6B 01            [ 1]   58 	ld	(0x01, sp), a
                                     59 ;	../../my_STM8_libraries/stm8_SPI.c: 5: SPI_CR1 &= ~(1 << 6);
      00876C 72 1D 52 00      [ 1]   60 	bres	0x5200, #6
                                     61 ;	../../my_STM8_libraries/stm8_SPI.c: 6: SPI_CR1 = 0;
      008770 35 00 52 00      [ 1]   62 	mov	0x5200+0, #0x00
                                     63 ;	../../my_STM8_libraries/stm8_SPI.c: 7: SPI_CR1 |= mode;
      008774 C6 52 00         [ 1]   64 	ld	a, 0x5200
      008777 1A 01            [ 1]   65 	or	a, (0x01, sp)
      008779 C7 52 00         [ 1]   66 	ld	0x5200, a
                                     67 ;	../../my_STM8_libraries/stm8_SPI.c: 8: SPI_CR1 |= div;
      00877C C6 52 00         [ 1]   68 	ld	a, 0x5200
      00877F 1A 04            [ 1]   69 	or	a, (0x04, sp)
      008781 C7 52 00         [ 1]   70 	ld	0x5200, a
                                     71 ;	../../my_STM8_libraries/stm8_SPI.c: 9: SPI_CR1 |= firstBit;
      008784 C6 52 00         [ 1]   72 	ld	a, 0x5200
      008787 1A 05            [ 1]   73 	or	a, (0x05, sp)
      008789 C7 52 00         [ 1]   74 	ld	0x5200, a
                                     75 ;	../../my_STM8_libraries/stm8_SPI.c: 10: SPI_CR1 |= masterSlave;
      00878C C6 52 00         [ 1]   76 	ld	a, 0x5200
      00878F 1A 06            [ 1]   77 	or	a, (0x06, sp)
      008791 C7 52 00         [ 1]   78 	ld	0x5200, a
                                     79 ;	../../my_STM8_libraries/stm8_SPI.c: 11: SPI_CR1 |= (1 << 6);
      008794 C6 52 00         [ 1]   80 	ld	a, 0x5200
      008797 AA 40            [ 1]   81 	or	a, #0x40
      008799 C7 52 00         [ 1]   82 	ld	0x5200, a
                                     83 ;	../../my_STM8_libraries/stm8_SPI.c: 12: }
      00879C 1E 02            [ 2]   84 	ldw	x, (2, sp)
      00879E 5B 06            [ 2]   85 	addw	sp, #6
      0087A0 FC               [ 2]   86 	jp	(x)
                                     87 ;	../../my_STM8_libraries/stm8_SPI.c: 13: uint8_t exchange_SPI(uint8_t data)
                                     88 ;	-----------------------------------------
                                     89 ;	 function exchange_SPI
                                     90 ;	-----------------------------------------
      0087A1                         91 _exchange_SPI:
      0087A1 52 03            [ 2]   92 	sub	sp, #3
      0087A3 6B 01            [ 1]   93 	ld	(0x01, sp), a
                                     94 ;	../../my_STM8_libraries/stm8_SPI.c: 17: while (!(SPI_SR & SPI_SR_TXE))
      0087A5 AE C3 50         [ 2]   95 	ldw	x, #0xc350
      0087A8 1F 02            [ 2]   96 	ldw	(0x02, sp), x
      0087AA                         97 00103$:
      0087AA 72 02 52 03 0A   [ 2]   98 	btjt	0x5203, #1, 00105$
                                     99 ;	../../my_STM8_libraries/stm8_SPI.c: 19: if (--timeout == 0) return 0;
      0087AF 1E 02            [ 2]  100 	ldw	x, (0x02, sp)
      0087B1 5A               [ 2]  101 	decw	x
      0087B2 1F 02            [ 2]  102 	ldw	(0x02, sp), x
      0087B4 26 F4            [ 1]  103 	jrne	00103$
      0087B6 4F               [ 1]  104 	clr	a
      0087B7 20 2B            [ 2]  105 	jra	00116$
      0087B9                        106 00105$:
                                    107 ;	../../my_STM8_libraries/stm8_SPI.c: 23: SPI_DR = data;
      0087B9 AE 52 04         [ 2]  108 	ldw	x, #0x5204
      0087BC 7B 01            [ 1]  109 	ld	a, (0x01, sp)
      0087BE F7               [ 1]  110 	ld	(x), a
                                    111 ;	../../my_STM8_libraries/stm8_SPI.c: 25: while (!(SPI_SR & SPI_SR_RXNE))
      0087BF AE C3 50         [ 2]  112 	ldw	x, #0xc350
      0087C2                        113 00108$:
      0087C2 72 00 52 03 07   [ 2]  114 	btjt	0x5203, #0, 00110$
                                    115 ;	../../my_STM8_libraries/stm8_SPI.c: 27: if (--timeout == 0) return 0;
      0087C7 5A               [ 2]  116 	decw	x
      0087C8 5D               [ 2]  117 	tnzw	x
      0087C9 26 F7            [ 1]  118 	jrne	00108$
      0087CB 4F               [ 1]  119 	clr	a
      0087CC 20 16            [ 2]  120 	jra	00116$
      0087CE                        121 00110$:
                                    122 ;	../../my_STM8_libraries/stm8_SPI.c: 31: uint8_t result = SPI_DR;
      0087CE C6 52 04         [ 1]  123 	ld	a, 0x5204
      0087D1 6B 03            [ 1]  124 	ld	(0x03, sp), a
                                    125 ;	../../my_STM8_libraries/stm8_SPI.c: 33: while (SPI_SR & SPI_SR_BSY)
      0087D3 AE C3 50         [ 2]  126 	ldw	x, #0xc350
      0087D6                        127 00113$:
      0087D6 C6 52 03         [ 1]  128 	ld	a, 0x5203
      0087D9 2A 07            [ 1]  129 	jrpl	00115$
                                    130 ;	../../my_STM8_libraries/stm8_SPI.c: 35: if (--timeout == 0) return 0;
      0087DB 5A               [ 2]  131 	decw	x
      0087DC 5D               [ 2]  132 	tnzw	x
      0087DD 26 F7            [ 1]  133 	jrne	00113$
      0087DF 4F               [ 1]  134 	clr	a
      0087E0 20 02            [ 2]  135 	jra	00116$
      0087E2                        136 00115$:
                                    137 ;	../../my_STM8_libraries/stm8_SPI.c: 37: return result;
      0087E2 7B 03            [ 1]  138 	ld	a, (0x03, sp)
      0087E4                        139 00116$:
                                    140 ;	../../my_STM8_libraries/stm8_SPI.c: 38: }
      0087E4 5B 03            [ 2]  141 	addw	sp, #3
      0087E6 81               [ 4]  142 	ret
                                    143 ;	../../my_STM8_libraries/stm8_SPI.c: 39: void write_SPI(uint8_t data)
                                    144 ;	-----------------------------------------
                                    145 ;	 function write_SPI
                                    146 ;	-----------------------------------------
      0087E7                        147 _write_SPI:
                                    148 ;	../../my_STM8_libraries/stm8_SPI.c: 41: (void)exchange_SPI(data);
                                    149 ;	../../my_STM8_libraries/stm8_SPI.c: 42: }
      0087E7 CC 87 A1         [ 2]  150 	jp	_exchange_SPI
                                    151 ;	../../my_STM8_libraries/stm8_SPI.c: 43: uint8_t read_SPI(void)
                                    152 ;	-----------------------------------------
                                    153 ;	 function read_SPI
                                    154 ;	-----------------------------------------
      0087EA                        155 _read_SPI:
                                    156 ;	../../my_STM8_libraries/stm8_SPI.c: 45: return exchange_SPI(0xFF);
      0087EA A6 FF            [ 1]  157 	ld	a, #0xff
                                    158 ;	../../my_STM8_libraries/stm8_SPI.c: 46: }
      0087EC CC 87 A1         [ 2]  159 	jp	_exchange_SPI
                                    160 	.area CODE
                                    161 	.area CONST
                                    162 	.area INITIALIZER
                                    163 	.area CABS (ABS)
