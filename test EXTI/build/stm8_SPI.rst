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
      008A71                         56 _init_SPI:
      008A71 88               [ 1]   57 	push	a
      008A72 6B 01            [ 1]   58 	ld	(0x01, sp), a
                                     59 ;	../../my_STM8_libraries/stm8_SPI.c: 5: SPI_CR1 &= ~(1 << 6);
      008A74 72 1D 52 00      [ 1]   60 	bres	0x5200, #6
                                     61 ;	../../my_STM8_libraries/stm8_SPI.c: 6: SPI_CR1 = 0;
      008A78 35 00 52 00      [ 1]   62 	mov	0x5200+0, #0x00
                                     63 ;	../../my_STM8_libraries/stm8_SPI.c: 7: SPI_CR1 |= mode;
      008A7C C6 52 00         [ 1]   64 	ld	a, 0x5200
      008A7F 1A 01            [ 1]   65 	or	a, (0x01, sp)
      008A81 C7 52 00         [ 1]   66 	ld	0x5200, a
                                     67 ;	../../my_STM8_libraries/stm8_SPI.c: 8: SPI_CR1 |= div;
      008A84 C6 52 00         [ 1]   68 	ld	a, 0x5200
      008A87 1A 04            [ 1]   69 	or	a, (0x04, sp)
      008A89 C7 52 00         [ 1]   70 	ld	0x5200, a
                                     71 ;	../../my_STM8_libraries/stm8_SPI.c: 9: SPI_CR1 |= firstBit;
      008A8C C6 52 00         [ 1]   72 	ld	a, 0x5200
      008A8F 1A 05            [ 1]   73 	or	a, (0x05, sp)
      008A91 C7 52 00         [ 1]   74 	ld	0x5200, a
                                     75 ;	../../my_STM8_libraries/stm8_SPI.c: 10: SPI_CR1 |= masterSlave;
      008A94 C6 52 00         [ 1]   76 	ld	a, 0x5200
      008A97 1A 06            [ 1]   77 	or	a, (0x06, sp)
      008A99 C7 52 00         [ 1]   78 	ld	0x5200, a
                                     79 ;	../../my_STM8_libraries/stm8_SPI.c: 11: SPI_CR1 |= (1 << 6);
      008A9C C6 52 00         [ 1]   80 	ld	a, 0x5200
      008A9F AA 40            [ 1]   81 	or	a, #0x40
      008AA1 C7 52 00         [ 1]   82 	ld	0x5200, a
                                     83 ;	../../my_STM8_libraries/stm8_SPI.c: 12: }
      008AA4 1E 02            [ 2]   84 	ldw	x, (2, sp)
      008AA6 5B 06            [ 2]   85 	addw	sp, #6
      008AA8 FC               [ 2]   86 	jp	(x)
                                     87 ;	../../my_STM8_libraries/stm8_SPI.c: 13: uint8_t exchange_SPI(uint8_t data)
                                     88 ;	-----------------------------------------
                                     89 ;	 function exchange_SPI
                                     90 ;	-----------------------------------------
      008AA9                         91 _exchange_SPI:
      008AA9 52 03            [ 2]   92 	sub	sp, #3
      008AAB 6B 01            [ 1]   93 	ld	(0x01, sp), a
                                     94 ;	../../my_STM8_libraries/stm8_SPI.c: 17: while (!(SPI_SR & SPI_SR_TXE))
      008AAD AE C3 50         [ 2]   95 	ldw	x, #0xc350
      008AB0 1F 02            [ 2]   96 	ldw	(0x02, sp), x
      008AB2                         97 00103$:
      008AB2 72 02 52 03 0A   [ 2]   98 	btjt	0x5203, #1, 00105$
                                     99 ;	../../my_STM8_libraries/stm8_SPI.c: 19: if (--timeout == 0) return 0;
      008AB7 1E 02            [ 2]  100 	ldw	x, (0x02, sp)
      008AB9 5A               [ 2]  101 	decw	x
      008ABA 1F 02            [ 2]  102 	ldw	(0x02, sp), x
      008ABC 26 F4            [ 1]  103 	jrne	00103$
      008ABE 4F               [ 1]  104 	clr	a
      008ABF 20 2B            [ 2]  105 	jra	00116$
      008AC1                        106 00105$:
                                    107 ;	../../my_STM8_libraries/stm8_SPI.c: 23: SPI_DR = data;
      008AC1 AE 52 04         [ 2]  108 	ldw	x, #0x5204
      008AC4 7B 01            [ 1]  109 	ld	a, (0x01, sp)
      008AC6 F7               [ 1]  110 	ld	(x), a
                                    111 ;	../../my_STM8_libraries/stm8_SPI.c: 25: while (!(SPI_SR & SPI_SR_RXNE))
      008AC7 AE C3 50         [ 2]  112 	ldw	x, #0xc350
      008ACA                        113 00108$:
      008ACA 72 00 52 03 07   [ 2]  114 	btjt	0x5203, #0, 00110$
                                    115 ;	../../my_STM8_libraries/stm8_SPI.c: 27: if (--timeout == 0) return 0;
      008ACF 5A               [ 2]  116 	decw	x
      008AD0 5D               [ 2]  117 	tnzw	x
      008AD1 26 F7            [ 1]  118 	jrne	00108$
      008AD3 4F               [ 1]  119 	clr	a
      008AD4 20 16            [ 2]  120 	jra	00116$
      008AD6                        121 00110$:
                                    122 ;	../../my_STM8_libraries/stm8_SPI.c: 31: uint8_t result = SPI_DR;
      008AD6 C6 52 04         [ 1]  123 	ld	a, 0x5204
      008AD9 6B 03            [ 1]  124 	ld	(0x03, sp), a
                                    125 ;	../../my_STM8_libraries/stm8_SPI.c: 33: while (SPI_SR & SPI_SR_BSY)
      008ADB AE C3 50         [ 2]  126 	ldw	x, #0xc350
      008ADE                        127 00113$:
      008ADE C6 52 03         [ 1]  128 	ld	a, 0x5203
      008AE1 2A 07            [ 1]  129 	jrpl	00115$
                                    130 ;	../../my_STM8_libraries/stm8_SPI.c: 35: if (--timeout == 0) return 0;
      008AE3 5A               [ 2]  131 	decw	x
      008AE4 5D               [ 2]  132 	tnzw	x
      008AE5 26 F7            [ 1]  133 	jrne	00113$
      008AE7 4F               [ 1]  134 	clr	a
      008AE8 20 02            [ 2]  135 	jra	00116$
      008AEA                        136 00115$:
                                    137 ;	../../my_STM8_libraries/stm8_SPI.c: 37: return result;
      008AEA 7B 03            [ 1]  138 	ld	a, (0x03, sp)
      008AEC                        139 00116$:
                                    140 ;	../../my_STM8_libraries/stm8_SPI.c: 38: }
      008AEC 5B 03            [ 2]  141 	addw	sp, #3
      008AEE 81               [ 4]  142 	ret
                                    143 ;	../../my_STM8_libraries/stm8_SPI.c: 39: void write_SPI(uint8_t data)
                                    144 ;	-----------------------------------------
                                    145 ;	 function write_SPI
                                    146 ;	-----------------------------------------
      008AEF                        147 _write_SPI:
                                    148 ;	../../my_STM8_libraries/stm8_SPI.c: 41: (void)exchange_SPI(data);
                                    149 ;	../../my_STM8_libraries/stm8_SPI.c: 42: }
      008AEF CC 8A A9         [ 2]  150 	jp	_exchange_SPI
                                    151 ;	../../my_STM8_libraries/stm8_SPI.c: 43: uint8_t read_SPI(void)
                                    152 ;	-----------------------------------------
                                    153 ;	 function read_SPI
                                    154 ;	-----------------------------------------
      008AF2                        155 _read_SPI:
                                    156 ;	../../my_STM8_libraries/stm8_SPI.c: 45: return exchange_SPI(0xFF);
      008AF2 A6 FF            [ 1]  157 	ld	a, #0xff
                                    158 ;	../../my_STM8_libraries/stm8_SPI.c: 46: }
      008AF4 CC 8A A9         [ 2]  159 	jp	_exchange_SPI
                                    160 	.area CODE
                                    161 	.area CONST
                                    162 	.area INITIALIZER
                                    163 	.area CABS (ABS)
