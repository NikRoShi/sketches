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
                                     56 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint16_t baudrate, uint8_t rxInterrupt)
                                     57 ;	-----------------------------------------
                                     58 ;	 function init_UART
                                     59 ;	-----------------------------------------
      00899D                         60 _init_UART:
      00899D 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      00899E 90 5F            [ 1]   63 	clrw	y
      0089A0 89               [ 2]   64 	pushw	x
      0089A1 90 89            [ 2]   65 	pushw	y
      0089A3 4B 00            [ 1]   66 	push	#0x00
      0089A5 4B 24            [ 1]   67 	push	#0x24
      0089A7 4B F4            [ 1]   68 	push	#0xf4
      0089A9 4B 00            [ 1]   69 	push	#0x00
      0089AB CD 8B 20         [ 4]   70 	call	__divulong
      0089AE 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      0089B0 9F               [ 1]   73 	ld	a, xl
      0089B1 A4 0F            [ 1]   74 	and	a, #0x0f
      0089B3 6B 01            [ 1]   75 	ld	(0x01, sp), a
      0089B5 9E               [ 1]   76 	ld	a, xh
      0089B6 A4 F0            [ 1]   77 	and	a, #0xf0
      0089B8 1A 01            [ 1]   78 	or	a, (0x01, sp)
      0089BA C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      0089BD A6 10            [ 1]   81 	ld	a, #0x10
      0089BF 62               [ 2]   82 	div	x, a
      0089C0 9F               [ 1]   83 	ld	a, xl
      0089C1 C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      0089C4 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      0089C8 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 15: if (rxInterrupt = ENABLE) UART1_CR2 |= UART1_CR2_RIEN;
      0089CC 72 1A 52 35      [ 1]   90 	bset	0x5235, #5
                                     91 ;	../../my_STM8_libraries/stm8_UART.c: 16: else  UART1_CR2 &= ~UART1_CR2_RIEN;
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 17: }
      0089D0 84               [ 1]   93 	pop	a
      0089D1 81               [ 4]   94 	ret
                                     95 ;	../../my_STM8_libraries/stm8_UART.c: 18: uint8_t write_UART(uint8_t data)
                                     96 ;	-----------------------------------------
                                     97 ;	 function write_UART
                                     98 ;	-----------------------------------------
      0089D2                         99 _write_UART:
      0089D2 90 97            [ 1]  100 	ld	yl, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 22: while (!(UART1_SR & UART1_SR_TXE))
      0089D4 AE C3 50         [ 2]  102 	ldw	x, #0xc350
      0089D7                        103 00103$:
      0089D7 C6 52 30         [ 1]  104 	ld	a, 0x5230
      0089DA 2B 06            [ 1]  105 	jrmi	00105$
                                    106 ;	../../my_STM8_libraries/stm8_UART.c: 24: if (--timeout == 0) return 0;
      0089DC 5A               [ 2]  107 	decw	x
      0089DD 5D               [ 2]  108 	tnzw	x
      0089DE 26 F7            [ 1]  109 	jrne	00103$
      0089E0 4F               [ 1]  110 	clr	a
      0089E1 81               [ 4]  111 	ret
      0089E2                        112 00105$:
                                    113 ;	../../my_STM8_libraries/stm8_UART.c: 27: UART1_DR = data;
      0089E2 AE 52 31         [ 2]  114 	ldw	x, #0x5231
      0089E5 90 9F            [ 1]  115 	ld	a, yl
      0089E7 F7               [ 1]  116 	ld	(x), a
                                    117 ;	../../my_STM8_libraries/stm8_UART.c: 28: return 1;
      0089E8 A6 01            [ 1]  118 	ld	a, #0x01
                                    119 ;	../../my_STM8_libraries/stm8_UART.c: 29: }
      0089EA 81               [ 4]  120 	ret
                                    121 ;	../../my_STM8_libraries/stm8_UART.c: 30: uint8_t print_UART(char *str)
                                    122 ;	-----------------------------------------
                                    123 ;	 function print_UART
                                    124 ;	-----------------------------------------
      0089EB                        125 _print_UART:
                                    126 ;	../../my_STM8_libraries/stm8_UART.c: 32: while (*str != 0)
      0089EB                        127 00104$:
      0089EB F6               [ 1]  128 	ld	a, (x)
      0089EC 27 0D            [ 1]  129 	jreq	00106$
                                    130 ;	../../my_STM8_libraries/stm8_UART.c: 34: if (write_UART(*str) == 1)
      0089EE 89               [ 2]  131 	pushw	x
      0089EF CD 89 D2         [ 4]  132 	call	_write_UART
      0089F2 85               [ 2]  133 	popw	x
      0089F3 4A               [ 1]  134 	dec	a
      0089F4 26 03            [ 1]  135 	jrne	00102$
                                    136 ;	../../my_STM8_libraries/stm8_UART.c: 36: str++;
      0089F6 5C               [ 1]  137 	incw	x
      0089F7 20 F2            [ 2]  138 	jra	00104$
      0089F9                        139 00102$:
                                    140 ;	../../my_STM8_libraries/stm8_UART.c: 38: else return 0;
      0089F9 4F               [ 1]  141 	clr	a
      0089FA 81               [ 4]  142 	ret
      0089FB                        143 00106$:
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 40: return 1;
      0089FB A6 01            [ 1]  145 	ld	a, #0x01
                                    146 ;	../../my_STM8_libraries/stm8_UART.c: 41: }
      0089FD 81               [ 4]  147 	ret
                                    148 ;	../../my_STM8_libraries/stm8_UART.c: 42: uint8_t printInt_UART(uint16_t data)
                                    149 ;	-----------------------------------------
                                    150 ;	 function printInt_UART
                                    151 ;	-----------------------------------------
      0089FE                        152 _printInt_UART:
      0089FE 52 08            [ 2]  153 	sub	sp, #8
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 47: if (data == 0)
      008A00 5D               [ 2]  155 	tnzw	x
      008A01 26 09            [ 1]  156 	jrne	00115$
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 49: write_UART('0');
      008A03 A6 30            [ 1]  158 	ld	a, #0x30
      008A05 CD 89 D2         [ 4]  159 	call	_write_UART
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 50: return 1;
      008A08 A6 01            [ 1]  161 	ld	a, #0x01
      008A0A 20 4E            [ 2]  162 	jra	00111$
                                    163 ;	../../my_STM8_libraries/stm8_UART.c: 52: while (data != 0)
      008A0C                        164 00115$:
      008A0C 0F 08            [ 1]  165 	clr	(0x08, sp)
      008A0E                        166 00103$:
      008A0E 5D               [ 2]  167 	tnzw	x
      008A0F 27 2A            [ 1]  168 	jreq	00117$
                                    169 ;	../../my_STM8_libraries/stm8_UART.c: 54: buf[i] = (data % 10) + '0';
      008A11 89               [ 2]  170 	pushw	x
      008A12 5F               [ 1]  171 	clrw	x
      008A13 7B 0A            [ 1]  172 	ld	a, (0x0a, sp)
      008A15 97               [ 1]  173 	ld	xl, a
      008A16 89               [ 2]  174 	pushw	x
      008A17 96               [ 1]  175 	ldw	x, sp
      008A18 1C 00 07         [ 2]  176 	addw	x, #7
      008A1B 72 FB 01         [ 2]  177 	addw	x, (1, sp)
      008A1E 1F 05            [ 2]  178 	ldw	(0x05, sp), x
      008A20 5B 02            [ 2]  179 	addw	sp, #2
      008A22 85               [ 2]  180 	popw	x
      008A23 89               [ 2]  181 	pushw	x
      008A24 90 AE 00 0A      [ 2]  182 	ldw	y, #0x000a
      008A28 65               [ 2]  183 	divw	x, y
      008A29 85               [ 2]  184 	popw	x
      008A2A 90 9F            [ 1]  185 	ld	a, yl
      008A2C AB 30            [ 1]  186 	add	a, #0x30
      008A2E 16 01            [ 2]  187 	ldw	y, (0x01, sp)
      008A30 90 F7            [ 1]  188 	ld	(y), a
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 55: data /= 10;
      008A32 90 AE 00 0A      [ 2]  190 	ldw	y, #0x000a
      008A36 65               [ 2]  191 	divw	x, y
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 56: i++;
      008A37 0C 08            [ 1]  193 	inc	(0x08, sp)
      008A39 20 D3            [ 2]  194 	jra	00103$
                                    195 ;	../../my_STM8_libraries/stm8_UART.c: 58: while (i > 0)
      008A3B                        196 00117$:
      008A3B                        197 00108$:
      008A3B 0D 08            [ 1]  198 	tnz	(0x08, sp)
      008A3D 27 19            [ 1]  199 	jreq	00110$
                                    200 ;	../../my_STM8_libraries/stm8_UART.c: 60: i--;
      008A3F 0A 08            [ 1]  201 	dec	(0x08, sp)
                                    202 ;	../../my_STM8_libraries/stm8_UART.c: 61: if (write_UART(buf[i]) == 0) return 0;
      008A41 5F               [ 1]  203 	clrw	x
      008A42 7B 08            [ 1]  204 	ld	a, (0x08, sp)
      008A44 97               [ 1]  205 	ld	xl, a
      008A45 89               [ 2]  206 	pushw	x
      008A46 96               [ 1]  207 	ldw	x, sp
      008A47 1C 00 05         [ 2]  208 	addw	x, #5
      008A4A 72 FB 01         [ 2]  209 	addw	x, (1, sp)
      008A4D 5B 02            [ 2]  210 	addw	sp, #2
      008A4F F6               [ 1]  211 	ld	a, (x)
      008A50 CD 89 D2         [ 4]  212 	call	_write_UART
      008A53 4D               [ 1]  213 	tnz	a
      008A54 26 E5            [ 1]  214 	jrne	00108$
      008A56 4F               [ 1]  215 	clr	a
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 1;
      008A57 C5                     217 	.byte 0xc5
      008A58                        218 00110$:
      008A58 A6 01            [ 1]  219 	ld	a, #0x01
      008A5A                        220 00111$:
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008A5A 5B 08            [ 2]  222 	addw	sp, #8
      008A5C 81               [ 4]  223 	ret
                                    224 ;	../../my_STM8_libraries/stm8_UART.c: 65: uint8_t line_UART(void)
                                    225 ;	-----------------------------------------
                                    226 ;	 function line_UART
                                    227 ;	-----------------------------------------
      008A5D                        228 _line_UART:
                                    229 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\r') == 0) return 0;
      008A5D A6 0D            [ 1]  230 	ld	a, #0x0d
      008A5F CD 89 D2         [ 4]  231 	call	_write_UART
      008A62 4D               [ 1]  232 	tnz	a
      008A63 26 02            [ 1]  233 	jrne	00102$
      008A65 4F               [ 1]  234 	clr	a
      008A66 81               [ 4]  235 	ret
      008A67                        236 00102$:
                                    237 ;	../../my_STM8_libraries/stm8_UART.c: 68: if (write_UART('\n') == 0) return 0;
      008A67 A6 0A            [ 1]  238 	ld	a, #0x0a
      008A69 CD 89 D2         [ 4]  239 	call	_write_UART
      008A6C 4D               [ 1]  240 	tnz	a
      008A6D 26 02            [ 1]  241 	jrne	00104$
      008A6F 4F               [ 1]  242 	clr	a
      008A70 81               [ 4]  243 	ret
      008A71                        244 00104$:
                                    245 ;	../../my_STM8_libraries/stm8_UART.c: 69: return 1;
      008A71 A6 01            [ 1]  246 	ld	a, #0x01
                                    247 ;	../../my_STM8_libraries/stm8_UART.c: 70: }
      008A73 81               [ 4]  248 	ret
                                    249 ;	../../my_STM8_libraries/stm8_UART.c: 71: static char nibbleToHex(uint8_t nibble)
                                    250 ;	-----------------------------------------
                                    251 ;	 function nibbleToHex
                                    252 ;	-----------------------------------------
      008A74                        253 _nibbleToHex:
                                    254 ;	../../my_STM8_libraries/stm8_UART.c: 73: if (nibble < 10) return nibble + '0';
      008A74 97               [ 1]  255 	ld	xl, a
      008A75 A1 0A            [ 1]  256 	cp	a, #0x0a
      008A77 24 04            [ 1]  257 	jrnc	00102$
      008A79 9F               [ 1]  258 	ld	a, xl
      008A7A AB 30            [ 1]  259 	add	a, #0x30
      008A7C 81               [ 4]  260 	ret
      008A7D                        261 00102$:
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 74: else return nibble - 10 + 'A';
      008A7D 9F               [ 1]  263 	ld	a, xl
      008A7E AB 37            [ 1]  264 	add	a, #0x37
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 75: }
      008A80 81               [ 4]  266 	ret
                                    267 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t printHex_UART(uint8_t data)
                                    268 ;	-----------------------------------------
                                    269 ;	 function printHex_UART
                                    270 ;	-----------------------------------------
      008A81                        271 _printHex_UART:
      008A81 88               [ 1]  272 	push	a
                                    273 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t high = data >> 4;
      008A82 97               [ 1]  274 	ld	xl, a
      008A83 4E               [ 1]  275 	swap	a
      008A84 A4 0F            [ 1]  276 	and	a, #0x0f
      008A86 41               [ 1]  277 	exg	a, xl
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 79: uint8_t low = data & 0x0F;
      008A87 A4 0F            [ 1]  279 	and	a, #0x0f
      008A89 6B 01            [ 1]  280 	ld	(0x01, sp), a
                                    281 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008A8B 9F               [ 1]  282 	ld	a, xl
      008A8C CD 8A 74         [ 4]  283 	call	_nibbleToHex
      008A8F CD 89 D2         [ 4]  284 	call	_write_UART
      008A92 4D               [ 1]  285 	tnz	a
      008A93 26 03            [ 1]  286 	jrne	00102$
      008A95 4F               [ 1]  287 	clr	a
      008A96 20 0F            [ 2]  288 	jra	00105$
      008A98                        289 00102$:
                                    290 ;	../../my_STM8_libraries/stm8_UART.c: 82: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008A98 7B 01            [ 1]  291 	ld	a, (0x01, sp)
      008A9A CD 8A 74         [ 4]  292 	call	_nibbleToHex
      008A9D CD 89 D2         [ 4]  293 	call	_write_UART
      008AA0 4D               [ 1]  294 	tnz	a
      008AA1 26 02            [ 1]  295 	jrne	00104$
      008AA3 4F               [ 1]  296 	clr	a
                                    297 ;	../../my_STM8_libraries/stm8_UART.c: 83: return 1;
      008AA4 C5                     298 	.byte 0xc5
      008AA5                        299 00104$:
      008AA5 A6 01            [ 1]  300 	ld	a, #0x01
      008AA7                        301 00105$:
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 84: }
      008AA7 5B 01            [ 2]  303 	addw	sp, #1
      008AA9 81               [ 4]  304 	ret
                                    305 ;	../../my_STM8_libraries/stm8_UART.c: 85: uint8_t isDataReceived_UART(void)
                                    306 ;	-----------------------------------------
                                    307 ;	 function isDataReceived_UART
                                    308 ;	-----------------------------------------
      008AAA                        309 _isDataReceived_UART:
                                    310 ;	../../my_STM8_libraries/stm8_UART.c: 87: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008AAA 72 0A 52 30 02   [ 2]  311 	btjt	0x5230, #5, 00102$
      008AAF 4F               [ 1]  312 	clr	a
      008AB0 81               [ 4]  313 	ret
      008AB1                        314 00102$:
                                    315 ;	../../my_STM8_libraries/stm8_UART.c: 88: return 1;
      008AB1 A6 01            [ 1]  316 	ld	a, #0x01
                                    317 ;	../../my_STM8_libraries/stm8_UART.c: 89: }
      008AB3 81               [ 4]  318 	ret
                                    319 ;	../../my_STM8_libraries/stm8_UART.c: 90: uint8_t getData_UART(void)
                                    320 ;	-----------------------------------------
                                    321 ;	 function getData_UART
                                    322 ;	-----------------------------------------
      008AB4                        323 _getData_UART:
                                    324 ;	../../my_STM8_libraries/stm8_UART.c: 92: return UART1_DR;
      008AB4 C6 52 31         [ 1]  325 	ld	a, 0x5231
                                    326 ;	../../my_STM8_libraries/stm8_UART.c: 93: }
      008AB7 81               [ 4]  327 	ret
                                    328 	.area CODE
                                    329 	.area CONST
                                    330 	.area INITIALIZER
                                    331 	.area CABS (ABS)
