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
      0085F9                         60 _init_UART:
      0085F9 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      0085FA 90 5F            [ 1]   63 	clrw	y
      0085FC 89               [ 2]   64 	pushw	x
      0085FD 90 89            [ 2]   65 	pushw	y
      0085FF 4B 00            [ 1]   66 	push	#0x00
      008601 4B 24            [ 1]   67 	push	#0x24
      008603 4B F4            [ 1]   68 	push	#0xf4
      008605 4B 00            [ 1]   69 	push	#0x00
      008607 CD 87 10         [ 4]   70 	call	__divulong
      00860A 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      00860C 9F               [ 1]   73 	ld	a, xl
      00860D A4 0F            [ 1]   74 	and	a, #0x0f
      00860F 6B 01            [ 1]   75 	ld	(0x01, sp), a
      008611 9E               [ 1]   76 	ld	a, xh
      008612 A4 F0            [ 1]   77 	and	a, #0xf0
      008614 1A 01            [ 1]   78 	or	a, (0x01, sp)
      008616 C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008619 A6 10            [ 1]   81 	ld	a, #0x10
      00861B 62               [ 2]   82 	div	x, a
      00861C 9F               [ 1]   83 	ld	a, xl
      00861D C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008620 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008624 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      008628 84               [ 1]   90 	pop	a
      008629 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      00862A                         96 _write_UART:
      00862A 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      00862C AE C3 50         [ 2]   99 	ldw	x, #0xc350
      00862F                        100 00103$:
      00862F C6 52 30         [ 1]  101 	ld	a, 0x5230
      008632 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      008634 5A               [ 2]  104 	decw	x
      008635 5D               [ 2]  105 	tnzw	x
      008636 26 F7            [ 1]  106 	jrne	00103$
      008638 4F               [ 1]  107 	clr	a
      008639 81               [ 4]  108 	ret
      00863A                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      00863A AE 52 31         [ 2]  111 	ldw	x, #0x5231
      00863D 90 9F            [ 1]  112 	ld	a, yl
      00863F F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      008640 A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      008642 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      008643                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      008643                        124 00104$:
      008643 F6               [ 1]  125 	ld	a, (x)
      008644 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      008646 89               [ 2]  128 	pushw	x
      008647 CD 86 2A         [ 4]  129 	call	_write_UART
      00864A 85               [ 2]  130 	popw	x
      00864B 4A               [ 1]  131 	dec	a
      00864C 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      00864E 5C               [ 1]  134 	incw	x
      00864F 20 F2            [ 2]  135 	jra	00104$
      008651                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      008651 4F               [ 1]  138 	clr	a
      008652 81               [ 4]  139 	ret
      008653                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      008653 A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      008655 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008656                        149 _printInt_UART:
      008656 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      008658 5D               [ 2]  152 	tnzw	x
      008659 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      00865B A6 30            [ 1]  155 	ld	a, #0x30
      00865D CD 86 2A         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008660 A6 01            [ 1]  158 	ld	a, #0x01
      008662 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      008664                        161 00115$:
      008664 0F 08            [ 1]  162 	clr	(0x08, sp)
      008666                        163 00103$:
      008666 5D               [ 2]  164 	tnzw	x
      008667 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008669 89               [ 2]  167 	pushw	x
      00866A 5F               [ 1]  168 	clrw	x
      00866B 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      00866D 97               [ 1]  170 	ld	xl, a
      00866E 89               [ 2]  171 	pushw	x
      00866F 96               [ 1]  172 	ldw	x, sp
      008670 1C 00 07         [ 2]  173 	addw	x, #7
      008673 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008676 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008678 5B 02            [ 2]  176 	addw	sp, #2
      00867A 85               [ 2]  177 	popw	x
      00867B 89               [ 2]  178 	pushw	x
      00867C 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008680 65               [ 2]  180 	divw	x, y
      008681 85               [ 2]  181 	popw	x
      008682 90 9F            [ 1]  182 	ld	a, yl
      008684 AB 30            [ 1]  183 	add	a, #0x30
      008686 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008688 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      00868A 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      00868E 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      00868F 0C 08            [ 1]  190 	inc	(0x08, sp)
      008691 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      008693                        193 00117$:
      008693                        194 00108$:
      008693 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008695 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      008697 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      008699 5F               [ 1]  200 	clrw	x
      00869A 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      00869C 97               [ 1]  202 	ld	xl, a
      00869D 89               [ 2]  203 	pushw	x
      00869E 96               [ 1]  204 	ldw	x, sp
      00869F 1C 00 05         [ 2]  205 	addw	x, #5
      0086A2 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      0086A5 5B 02            [ 2]  207 	addw	sp, #2
      0086A7 F6               [ 1]  208 	ld	a, (x)
      0086A8 CD 86 2A         [ 4]  209 	call	_write_UART
      0086AB 4D               [ 1]  210 	tnz	a
      0086AC 26 E5            [ 1]  211 	jrne	00108$
      0086AE 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      0086AF C5                     214 	.byte 0xc5
      0086B0                        215 00110$:
      0086B0 A6 01            [ 1]  216 	ld	a, #0x01
      0086B2                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      0086B2 5B 08            [ 2]  219 	addw	sp, #8
      0086B4 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      0086B5                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      0086B5 A6 0D            [ 1]  227 	ld	a, #0x0d
      0086B7 CD 86 2A         [ 4]  228 	call	_write_UART
      0086BA 4D               [ 1]  229 	tnz	a
      0086BB 26 02            [ 1]  230 	jrne	00102$
      0086BD 4F               [ 1]  231 	clr	a
      0086BE 81               [ 4]  232 	ret
      0086BF                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      0086BF A6 0A            [ 1]  235 	ld	a, #0x0a
      0086C1 CD 86 2A         [ 4]  236 	call	_write_UART
      0086C4 4D               [ 1]  237 	tnz	a
      0086C5 26 02            [ 1]  238 	jrne	00104$
      0086C7 4F               [ 1]  239 	clr	a
      0086C8 81               [ 4]  240 	ret
      0086C9                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      0086C9 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      0086CB 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      0086CC                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      0086CC 97               [ 1]  252 	ld	xl, a
      0086CD A1 0A            [ 1]  253 	cp	a, #0x0a
      0086CF 24 04            [ 1]  254 	jrnc	00102$
      0086D1 9F               [ 1]  255 	ld	a, xl
      0086D2 AB 30            [ 1]  256 	add	a, #0x30
      0086D4 81               [ 4]  257 	ret
      0086D5                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      0086D5 9F               [ 1]  260 	ld	a, xl
      0086D6 AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      0086D8 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      0086D9                        268 _printHex_UART:
      0086D9 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      0086DA 97               [ 1]  271 	ld	xl, a
      0086DB 4E               [ 1]  272 	swap	a
      0086DC A4 0F            [ 1]  273 	and	a, #0x0f
      0086DE 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      0086DF A4 0F            [ 1]  276 	and	a, #0x0f
      0086E1 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      0086E3 9F               [ 1]  279 	ld	a, xl
      0086E4 CD 86 CC         [ 4]  280 	call	_nibbleToHex
      0086E7 CD 86 2A         [ 4]  281 	call	_write_UART
      0086EA 4D               [ 1]  282 	tnz	a
      0086EB 26 03            [ 1]  283 	jrne	00102$
      0086ED 4F               [ 1]  284 	clr	a
      0086EE 20 0F            [ 2]  285 	jra	00105$
      0086F0                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      0086F0 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      0086F2 CD 86 CC         [ 4]  289 	call	_nibbleToHex
      0086F5 CD 86 2A         [ 4]  290 	call	_write_UART
      0086F8 4D               [ 1]  291 	tnz	a
      0086F9 26 02            [ 1]  292 	jrne	00104$
      0086FB 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      0086FC C5                     295 	.byte 0xc5
      0086FD                        296 00104$:
      0086FD A6 01            [ 1]  297 	ld	a, #0x01
      0086FF                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      0086FF 5B 01            [ 2]  300 	addw	sp, #1
      008701 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      008702                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008702 72 0A 52 30 02   [ 2]  308 	btjt	0x5230, #5, 00102$
      008707 4F               [ 1]  309 	clr	a
      008708 81               [ 4]  310 	ret
      008709                        311 00102$:
                                    312 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      008709 A6 01            [ 1]  313 	ld	a, #0x01
                                    314 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      00870B 81               [ 4]  315 	ret
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    317 ;	-----------------------------------------
                                    318 ;	 function getData_UART
                                    319 ;	-----------------------------------------
      00870C                        320 _getData_UART:
                                    321 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      00870C C6 52 31         [ 1]  322 	ld	a, 0x5231
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      00870F 81               [ 4]  324 	ret
                                    325 	.area CODE
                                    326 	.area CONST
                                    327 	.area INITIALIZER
                                    328 	.area CABS (ABS)
