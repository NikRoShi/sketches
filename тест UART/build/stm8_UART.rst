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
                                     17 	.globl _isDataReceived_UART
                                     18 	.globl _getData_UART
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; global & static initialisations
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area GSINIT
                                     47 ;--------------------------------------------------------
                                     48 ; Home
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area HOME
                                     52 ;--------------------------------------------------------
                                     53 ; code
                                     54 ;--------------------------------------------------------
                                     55 	.area CODE
                                     56 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint16_t baudrate)
                                     57 ;	-----------------------------------------
                                     58 ;	 function init_UART
                                     59 ;	-----------------------------------------
      008600                         60 _init_UART:
      008600 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008601 90 5F            [ 1]   63 	clrw	y
      008603 89               [ 2]   64 	pushw	x
      008604 90 89            [ 2]   65 	pushw	y
      008606 4B 00            [ 1]   66 	push	#0x00
      008608 4B 24            [ 1]   67 	push	#0x24
      00860A 4B F4            [ 1]   68 	push	#0xf4
      00860C 4B 00            [ 1]   69 	push	#0x00
      00860E CD 87 13         [ 4]   70 	call	__divulong
      008611 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008613 9F               [ 1]   73 	ld	a, xl
      008614 A4 0F            [ 1]   74 	and	a, #0x0f
      008616 6B 01            [ 1]   75 	ld	(0x01, sp), a
      008618 9E               [ 1]   76 	ld	a, xh
      008619 A4 F0            [ 1]   77 	and	a, #0xf0
      00861B 1A 01            [ 1]   78 	or	a, (0x01, sp)
      00861D C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008620 A6 10            [ 1]   81 	ld	a, #0x10
      008622 62               [ 2]   82 	div	x, a
      008623 9F               [ 1]   83 	ld	a, xl
      008624 C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008627 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      00862B 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      00862F 84               [ 1]   90 	pop	a
      008630 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      008631                         96 _write_UART:
      008631 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      008633 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      008636                        100 00103$:
      008636 C6 52 30         [ 1]  101 	ld	a, 0x5230
      008639 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      00863B 5A               [ 2]  104 	decw	x
      00863C 5D               [ 2]  105 	tnzw	x
      00863D 26 F7            [ 1]  106 	jrne	00103$
      00863F 4F               [ 1]  107 	clr	a
      008640 81               [ 4]  108 	ret
      008641                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      008641 AE 52 31         [ 2]  111 	ldw	x, #0x5231
      008644 90 9F            [ 1]  112 	ld	a, yl
      008646 F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      008647 A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      008649 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      00864A                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      00864A                        124 00104$:
      00864A F6               [ 1]  125 	ld	a, (x)
      00864B 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      00864D 89               [ 2]  128 	pushw	x
      00864E CD 86 31         [ 4]  129 	call	_write_UART
      008651 85               [ 2]  130 	popw	x
      008652 4A               [ 1]  131 	dec	a
      008653 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      008655 5C               [ 1]  134 	incw	x
      008656 20 F2            [ 2]  135 	jra	00104$
      008658                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      008658 4F               [ 1]  138 	clr	a
      008659 81               [ 4]  139 	ret
      00865A                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      00865A A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      00865C 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      00865D                        149 _printInt_UART:
      00865D 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      00865F 5D               [ 2]  152 	tnzw	x
      008660 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      008662 A6 30            [ 1]  155 	ld	a, #0x30
      008664 CD 86 31         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008667 A6 01            [ 1]  158 	ld	a, #0x01
      008669 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      00866B                        161 00115$:
      00866B 0F 08            [ 1]  162 	clr	(0x08, sp)
      00866D                        163 00103$:
      00866D 5D               [ 2]  164 	tnzw	x
      00866E 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008670 89               [ 2]  167 	pushw	x
      008671 5F               [ 1]  168 	clrw	x
      008672 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      008674 97               [ 1]  170 	ld	xl, a
      008675 89               [ 2]  171 	pushw	x
      008676 96               [ 1]  172 	ldw	x, sp
      008677 1C 00 07         [ 2]  173 	addw	x, #7
      00867A 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      00867D 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      00867F 5B 02            [ 2]  176 	addw	sp, #2
      008681 85               [ 2]  177 	popw	x
      008682 89               [ 2]  178 	pushw	x
      008683 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008687 65               [ 2]  180 	divw	x, y
      008688 85               [ 2]  181 	popw	x
      008689 90 9F            [ 1]  182 	ld	a, yl
      00868B AB 30            [ 1]  183 	add	a, #0x30
      00868D 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      00868F 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      008691 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      008695 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      008696 0C 08            [ 1]  190 	inc	(0x08, sp)
      008698 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      00869A                        193 00117$:
      00869A                        194 00108$:
      00869A 0D 08            [ 1]  195 	tnz	(0x08, sp)
      00869C 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      00869E 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      0086A0 5F               [ 1]  200 	clrw	x
      0086A1 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      0086A3 97               [ 1]  202 	ld	xl, a
      0086A4 89               [ 2]  203 	pushw	x
      0086A5 96               [ 1]  204 	ldw	x, sp
      0086A6 1C 00 05         [ 2]  205 	addw	x, #5
      0086A9 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      0086AC 5B 02            [ 2]  207 	addw	sp, #2
      0086AE F6               [ 1]  208 	ld	a, (x)
      0086AF CD 86 31         [ 4]  209 	call	_write_UART
      0086B2 4D               [ 1]  210 	tnz	a
      0086B3 26 E5            [ 1]  211 	jrne	00108$
      0086B5 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      0086B6 C5                     214 	.byte 0xc5
      0086B7                        215 00110$:
      0086B7 A6 01            [ 1]  216 	ld	a, #0x01
      0086B9                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      0086B9 5B 08            [ 2]  219 	addw	sp, #8
      0086BB 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      0086BC                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      0086BC A6 0D            [ 1]  227 	ld	a, #0x0d
      0086BE CD 86 31         [ 4]  228 	call	_write_UART
      0086C1 4D               [ 1]  229 	tnz	a
      0086C2 26 02            [ 1]  230 	jrne	00102$
      0086C4 4F               [ 1]  231 	clr	a
      0086C5 81               [ 4]  232 	ret
      0086C6                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      0086C6 A6 0A            [ 1]  235 	ld	a, #0x0a
      0086C8 CD 86 31         [ 4]  236 	call	_write_UART
      0086CB 4D               [ 1]  237 	tnz	a
      0086CC 26 02            [ 1]  238 	jrne	00104$
      0086CE 4F               [ 1]  239 	clr	a
      0086CF 81               [ 4]  240 	ret
      0086D0                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      0086D0 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      0086D2 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      0086D3                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      0086D3 97               [ 1]  252 	ld	xl, a
      0086D4 A1 0A            [ 1]  253 	cp	a, #0x0a
      0086D6 24 04            [ 1]  254 	jrnc	00102$
      0086D8 9F               [ 1]  255 	ld	a, xl
      0086D9 AB 30            [ 1]  256 	add	a, #0x30
      0086DB 81               [ 4]  257 	ret
      0086DC                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      0086DC 9F               [ 1]  260 	ld	a, xl
      0086DD AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      0086DF 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      0086E0                        268 _printHex_UART:
      0086E0 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      0086E1 97               [ 1]  271 	ld	xl, a
      0086E2 4E               [ 1]  272 	swap	a
      0086E3 A4 0F            [ 1]  273 	and	a, #0x0f
      0086E5 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      0086E6 A4 0F            [ 1]  276 	and	a, #0x0f
      0086E8 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      0086EA 9F               [ 1]  279 	ld	a, xl
      0086EB CD 86 D3         [ 4]  280 	call	_nibbleToHex
      0086EE CD 86 31         [ 4]  281 	call	_write_UART
      0086F1 4D               [ 1]  282 	tnz	a
      0086F2 26 03            [ 1]  283 	jrne	00102$
      0086F4 4F               [ 1]  284 	clr	a
      0086F5 20 0F            [ 2]  285 	jra	00105$
      0086F7                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      0086F7 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      0086F9 CD 86 D3         [ 4]  289 	call	_nibbleToHex
      0086FC CD 86 31         [ 4]  290 	call	_write_UART
      0086FF 4D               [ 1]  291 	tnz	a
      008700 26 02            [ 1]  292 	jrne	00104$
      008702 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      008703 C5                     295 	.byte 0xc5
      008704                        296 00104$:
      008704 A6 01            [ 1]  297 	ld	a, #0x01
      008706                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008706 5B 01            [ 2]  300 	addw	sp, #1
      008708 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      008709                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if (UART1_SR & UART1_SR_RXNE == 0) return 0;
      008709 C6 52 30         [ 1]  308 	ld	a, 0x5230
                                    309 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      00870C A6 01            [ 1]  310 	ld	a, #0x01
                                    311 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      00870E 81               [ 4]  312 	ret
                                    313 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    314 ;	-----------------------------------------
                                    315 ;	 function getData_UART
                                    316 ;	-----------------------------------------
      00870F                        317 _getData_UART:
                                    318 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      00870F C6 52 31         [ 1]  319 	ld	a, 0x5231
                                    320 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      008712 81               [ 4]  321 	ret
                                    322 	.area CODE
                                    323 	.area CONST
                                    324 	.area INITIALIZER
                                    325 	.area CABS (ABS)
