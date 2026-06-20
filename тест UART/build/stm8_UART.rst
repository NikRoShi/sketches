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
                                     13 	.globl _print_UART
                                     14 	.globl _printInt_UART
                                     15 	.globl _line_UART
                                     16 	.globl _printHex_UART
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint16_t baudrate)
                                     55 ;	-----------------------------------------
                                     56 ;	 function init_UART
                                     57 ;	-----------------------------------------
      0085C0                         58 _init_UART:
      0085C0 88               [ 1]   59 	push	a
                                     60 ;	../../my_STM8_libraries/stm8_UART.c: 7: PD_DDR |= (1 << TX_PIN);
      0085C1 72 1A 50 11      [ 1]   61 	bset	0x5011, #5
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_CR1 |= (1 << TX_PIN);
      0085C5 72 1A 50 12      [ 1]   63 	bset	0x5012, #5
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 10: uartdiv = F_CPU / baudrate;
      0085C9 90 5F            [ 1]   65 	clrw	y
      0085CB 89               [ 2]   66 	pushw	x
      0085CC 90 89            [ 2]   67 	pushw	y
      0085CE 4B 00            [ 1]   68 	push	#0x00
      0085D0 4B 24            [ 1]   69 	push	#0x24
      0085D2 4B F4            [ 1]   70 	push	#0xf4
      0085D4 4B 00            [ 1]   71 	push	#0x00
      0085D6 CD 86 CD         [ 4]   72 	call	__divulong
      0085D9 5B 08            [ 2]   73 	addw	sp, #8
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      0085DB 9F               [ 1]   75 	ld	a, xl
      0085DC A4 0F            [ 1]   76 	and	a, #0x0f
      0085DE 6B 01            [ 1]   77 	ld	(0x01, sp), a
      0085E0 9E               [ 1]   78 	ld	a, xh
      0085E1 A4 F0            [ 1]   79 	and	a, #0xf0
      0085E3 1A 01            [ 1]   80 	or	a, (0x01, sp)
      0085E5 C7 52 33         [ 1]   81 	ld	0x5233, a
                                     82 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      0085E8 A6 10            [ 1]   83 	ld	a, #0x10
      0085EA 62               [ 2]   84 	div	x, a
      0085EB 9F               [ 1]   85 	ld	a, xl
      0085EC C7 52 32         [ 1]   86 	ld	0x5232, a
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 15: UART1_CR2 |= UART1_CR2_TEN;
      0085EF 72 16 52 35      [ 1]   88 	bset	0x5235, #3
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 16: }
      0085F3 84               [ 1]   90 	pop	a
      0085F4 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 17: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      0085F5                         96 _write_UART:
      0085F5 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 21: while (!(UART1_SR & UART1_SR_TXE))
      0085F7 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      0085FA                        100 00103$:
      0085FA C6 52 30         [ 1]  101 	ld	a, 0x5230
      0085FD 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 23: if (--timeout == 0) return 0;
      0085FF 5A               [ 2]  104 	decw	x
      008600 5D               [ 2]  105 	tnzw	x
      008601 26 F7            [ 1]  106 	jrne	00103$
      008603 4F               [ 1]  107 	clr	a
      008604 81               [ 4]  108 	ret
      008605                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 26: UART1_DR = data;
      008605 AE 52 31         [ 2]  111 	ldw	x, #0x5231
      008608 90 9F            [ 1]  112 	ld	a, yl
      00860A F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 27: return 1;
      00860B A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 28: }
      00860D 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 29: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      00860E                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 31: while (*str != 0)
      00860E                        124 00104$:
      00860E F6               [ 1]  125 	ld	a, (x)
      00860F 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 33: if (write_UART(*str) == 1)
      008611 89               [ 2]  128 	pushw	x
      008612 CD 85 F5         [ 4]  129 	call	_write_UART
      008615 85               [ 2]  130 	popw	x
      008616 4A               [ 1]  131 	dec	a
      008617 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 35: str++;
      008619 5C               [ 1]  134 	incw	x
      00861A 20 F2            [ 2]  135 	jra	00104$
      00861C                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 37: else return 0;
      00861C 4F               [ 1]  138 	clr	a
      00861D 81               [ 4]  139 	ret
      00861E                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 39: return 1;
      00861E A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 40: }
      008620 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 41: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008621                        149 _printInt_UART:
      008621 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 46: if (data == 0)
      008623 5D               [ 2]  152 	tnzw	x
      008624 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 48: write_UART('0');
      008626 A6 30            [ 1]  155 	ld	a, #0x30
      008628 CD 85 F5         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 49: return 1;
      00862B A6 01            [ 1]  158 	ld	a, #0x01
      00862D 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 51: while (data != 0)
      00862F                        161 00115$:
      00862F 0F 08            [ 1]  162 	clr	(0x08, sp)
      008631                        163 00103$:
      008631 5D               [ 2]  164 	tnzw	x
      008632 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 53: buf[i] = (data % 10) + '0';
      008634 89               [ 2]  167 	pushw	x
      008635 5F               [ 1]  168 	clrw	x
      008636 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      008638 97               [ 1]  170 	ld	xl, a
      008639 89               [ 2]  171 	pushw	x
      00863A 96               [ 1]  172 	ldw	x, sp
      00863B 1C 00 07         [ 2]  173 	addw	x, #7
      00863E 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008641 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008643 5B 02            [ 2]  176 	addw	sp, #2
      008645 85               [ 2]  177 	popw	x
      008646 89               [ 2]  178 	pushw	x
      008647 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      00864B 65               [ 2]  180 	divw	x, y
      00864C 85               [ 2]  181 	popw	x
      00864D 90 9F            [ 1]  182 	ld	a, yl
      00864F AB 30            [ 1]  183 	add	a, #0x30
      008651 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008653 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 54: data /= 10;
      008655 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      008659 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 55: i++;
      00865A 0C 08            [ 1]  190 	inc	(0x08, sp)
      00865C 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 57: while (i > 0)
      00865E                        193 00117$:
      00865E                        194 00108$:
      00865E 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008660 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 59: i--;
      008662 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 60: if (write_UART(buf[i]) == 0) return 0;
      008664 5F               [ 1]  200 	clrw	x
      008665 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      008667 97               [ 1]  202 	ld	xl, a
      008668 89               [ 2]  203 	pushw	x
      008669 96               [ 1]  204 	ldw	x, sp
      00866A 1C 00 05         [ 2]  205 	addw	x, #5
      00866D 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      008670 5B 02            [ 2]  207 	addw	sp, #2
      008672 F6               [ 1]  208 	ld	a, (x)
      008673 CD 85 F5         [ 4]  209 	call	_write_UART
      008676 4D               [ 1]  210 	tnz	a
      008677 26 E5            [ 1]  211 	jrne	00108$
      008679 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 62: return 1;
      00867A C5                     214 	.byte 0xc5
      00867B                        215 00110$:
      00867B A6 01            [ 1]  216 	ld	a, #0x01
      00867D                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 63: }
      00867D 5B 08            [ 2]  219 	addw	sp, #8
      00867F 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 64: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      008680                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 66: if (write_UART('\r') == 0) return 0;
      008680 A6 0D            [ 1]  227 	ld	a, #0x0d
      008682 CD 85 F5         [ 4]  228 	call	_write_UART
      008685 4D               [ 1]  229 	tnz	a
      008686 26 02            [ 1]  230 	jrne	00102$
      008688 4F               [ 1]  231 	clr	a
      008689 81               [ 4]  232 	ret
      00868A                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\n') == 0) return 0;
      00868A A6 0A            [ 1]  235 	ld	a, #0x0a
      00868C CD 85 F5         [ 4]  236 	call	_write_UART
      00868F 4D               [ 1]  237 	tnz	a
      008690 26 02            [ 1]  238 	jrne	00104$
      008692 4F               [ 1]  239 	clr	a
      008693 81               [ 4]  240 	ret
      008694                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 68: return 1;
      008694 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      008696 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 70: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      008697                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 72: if (nibble < 10) return nibble + '0';
      008697 97               [ 1]  252 	ld	xl, a
      008698 A1 0A            [ 1]  253 	cp	a, #0x0a
      00869A 24 04            [ 1]  254 	jrnc	00102$
      00869C 9F               [ 1]  255 	ld	a, xl
      00869D AB 30            [ 1]  256 	add	a, #0x30
      00869F 81               [ 4]  257 	ret
      0086A0                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 73: else return nibble - 10 + 'A';
      0086A0 9F               [ 1]  260 	ld	a, xl
      0086A1 AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 74: }
      0086A3 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      0086A4                        268 _printHex_UART:
      0086A4 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 77: uint8_t high = data >> 4;
      0086A5 97               [ 1]  271 	ld	xl, a
      0086A6 4E               [ 1]  272 	swap	a
      0086A7 A4 0F            [ 1]  273 	and	a, #0x0f
      0086A9 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t low = data & 0x0F;
      0086AA A4 0F            [ 1]  276 	and	a, #0x0f
      0086AC 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 80: if (write_UART(nibbleToHex(high)) == 0) return 0;
      0086AE 9F               [ 1]  279 	ld	a, xl
      0086AF CD 86 97         [ 4]  280 	call	_nibbleToHex
      0086B2 CD 85 F5         [ 4]  281 	call	_write_UART
      0086B5 4D               [ 1]  282 	tnz	a
      0086B6 26 03            [ 1]  283 	jrne	00102$
      0086B8 4F               [ 1]  284 	clr	a
      0086B9 20 0F            [ 2]  285 	jra	00105$
      0086BB                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(low)) == 0) return 0;
      0086BB 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      0086BD CD 86 97         [ 4]  289 	call	_nibbleToHex
      0086C0 CD 85 F5         [ 4]  290 	call	_write_UART
      0086C3 4D               [ 1]  291 	tnz	a
      0086C4 26 02            [ 1]  292 	jrne	00104$
      0086C6 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 82: return 1;
      0086C7 C5                     295 	.byte 0xc5
      0086C8                        296 00104$:
      0086C8 A6 01            [ 1]  297 	ld	a, #0x01
      0086CA                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 83: }
      0086CA 5B 01            [ 2]  300 	addw	sp, #1
      0086CC 81               [ 4]  301 	ret
                                    302 	.area CODE
                                    303 	.area CONST
                                    304 	.area INITIALIZER
                                    305 	.area CABS (ABS)
