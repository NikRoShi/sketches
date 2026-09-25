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
      008AB4                         60 _init_UART:
      008AB4 52 02            [ 2]   61 	sub	sp, #2
      008AB6 6B 02            [ 1]   62 	ld	(0x02, sp), a
                                     63 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008AB8 90 5F            [ 1]   64 	clrw	y
      008ABA 89               [ 2]   65 	pushw	x
      008ABB 90 89            [ 2]   66 	pushw	y
      008ABD 4B 00            [ 1]   67 	push	#0x00
      008ABF 4B 24            [ 1]   68 	push	#0x24
      008AC1 4B F4            [ 1]   69 	push	#0xf4
      008AC3 4B 00            [ 1]   70 	push	#0x00
      008AC5 CD 8C 4D         [ 4]   71 	call	__divulong
      008AC8 5B 08            [ 2]   72 	addw	sp, #8
                                     73 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008ACA 9F               [ 1]   74 	ld	a, xl
      008ACB A4 0F            [ 1]   75 	and	a, #0x0f
      008ACD 6B 01            [ 1]   76 	ld	(0x01, sp), a
      008ACF 9E               [ 1]   77 	ld	a, xh
      008AD0 A4 F0            [ 1]   78 	and	a, #0xf0
      008AD2 1A 01            [ 1]   79 	or	a, (0x01, sp)
      008AD4 C7 52 33         [ 1]   80 	ld	0x5233, a
                                     81 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008AD7 A6 10            [ 1]   82 	ld	a, #0x10
      008AD9 62               [ 2]   83 	div	x, a
      008ADA 9F               [ 1]   84 	ld	a, xl
      008ADB C7 52 32         [ 1]   85 	ld	0x5232, a
                                     86 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008ADE 72 16 52 35      [ 1]   87 	bset	0x5235, #3
                                     88 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008AE2 72 14 52 35      [ 1]   89 	bset	0x5235, #2
                                     90 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008AE6 C6 52 35         [ 1]   91 	ld	a, 0x5235
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: if (rxInterrupt == ENABLE) UART1_CR2 |= UART1_CR2_RIEN;
      008AE9 88               [ 1]   93 	push	a
      008AEA 7B 03            [ 1]   94 	ld	a, (0x03, sp)
      008AEC 4A               [ 1]   95 	dec	a
      008AED 84               [ 1]   96 	pop	a
      008AEE 26 07            [ 1]   97 	jrne	00102$
      008AF0 AA 20            [ 1]   98 	or	a, #0x20
      008AF2 C7 52 35         [ 1]   99 	ld	0x5235, a
      008AF5 20 05            [ 2]  100 	jra	00104$
      008AF7                        101 00102$:
                                    102 ;	../../my_STM8_libraries/stm8_UART.c: 16: else  UART1_CR2 &= ~UART1_CR2_RIEN;
      008AF7 A4 DF            [ 1]  103 	and	a, #0xdf
      008AF9 C7 52 35         [ 1]  104 	ld	0x5235, a
      008AFC                        105 00104$:
                                    106 ;	../../my_STM8_libraries/stm8_UART.c: 17: }
      008AFC 5B 02            [ 2]  107 	addw	sp, #2
      008AFE 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 18: uint8_t write_UART(uint8_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function write_UART
                                    112 ;	-----------------------------------------
      008AFF                        113 _write_UART:
      008AFF 90 97            [ 1]  114 	ld	yl, a
                                    115 ;	../../my_STM8_libraries/stm8_UART.c: 22: while (!(UART1_SR & UART1_SR_TXE))
      008B01 AE C3 50         [ 2]  116 	ldw	x, #0xc350
      008B04                        117 00103$:
      008B04 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008B07 2B 06            [ 1]  119 	jrmi	00105$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: if (--timeout == 0) return 0;
      008B09 5A               [ 2]  121 	decw	x
      008B0A 5D               [ 2]  122 	tnzw	x
      008B0B 26 F7            [ 1]  123 	jrne	00103$
      008B0D 4F               [ 1]  124 	clr	a
      008B0E 81               [ 4]  125 	ret
      008B0F                        126 00105$:
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: UART1_DR = data;
      008B0F AE 52 31         [ 2]  128 	ldw	x, #0x5231
      008B12 90 9F            [ 1]  129 	ld	a, yl
      008B14 F7               [ 1]  130 	ld	(x), a
                                    131 ;	../../my_STM8_libraries/stm8_UART.c: 28: return 1;
      008B15 A6 01            [ 1]  132 	ld	a, #0x01
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 29: }
      008B17 81               [ 4]  134 	ret
                                    135 ;	../../my_STM8_libraries/stm8_UART.c: 30: uint8_t print_UART(char *str)
                                    136 ;	-----------------------------------------
                                    137 ;	 function print_UART
                                    138 ;	-----------------------------------------
      008B18                        139 _print_UART:
                                    140 ;	../../my_STM8_libraries/stm8_UART.c: 32: while (*str != 0)
      008B18                        141 00104$:
      008B18 F6               [ 1]  142 	ld	a, (x)
      008B19 27 0D            [ 1]  143 	jreq	00106$
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 34: if (write_UART(*str) == 1)
      008B1B 89               [ 2]  145 	pushw	x
      008B1C CD 8A FF         [ 4]  146 	call	_write_UART
      008B1F 85               [ 2]  147 	popw	x
      008B20 4A               [ 1]  148 	dec	a
      008B21 26 03            [ 1]  149 	jrne	00102$
                                    150 ;	../../my_STM8_libraries/stm8_UART.c: 36: str++;
      008B23 5C               [ 1]  151 	incw	x
      008B24 20 F2            [ 2]  152 	jra	00104$
      008B26                        153 00102$:
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 38: else return 0;
      008B26 4F               [ 1]  155 	clr	a
      008B27 81               [ 4]  156 	ret
      008B28                        157 00106$:
                                    158 ;	../../my_STM8_libraries/stm8_UART.c: 40: return 1;
      008B28 A6 01            [ 1]  159 	ld	a, #0x01
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 41: }
      008B2A 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_UART.c: 42: uint8_t printInt_UART(uint16_t data)
                                    163 ;	-----------------------------------------
                                    164 ;	 function printInt_UART
                                    165 ;	-----------------------------------------
      008B2B                        166 _printInt_UART:
      008B2B 52 08            [ 2]  167 	sub	sp, #8
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 47: if (data == 0)
      008B2D 5D               [ 2]  169 	tnzw	x
      008B2E 26 09            [ 1]  170 	jrne	00115$
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 49: write_UART('0');
      008B30 A6 30            [ 1]  172 	ld	a, #0x30
      008B32 CD 8A FF         [ 4]  173 	call	_write_UART
                                    174 ;	../../my_STM8_libraries/stm8_UART.c: 50: return 1;
      008B35 A6 01            [ 1]  175 	ld	a, #0x01
      008B37 20 4E            [ 2]  176 	jra	00111$
                                    177 ;	../../my_STM8_libraries/stm8_UART.c: 52: while (data != 0)
      008B39                        178 00115$:
      008B39 0F 08            [ 1]  179 	clr	(0x08, sp)
      008B3B                        180 00103$:
      008B3B 5D               [ 2]  181 	tnzw	x
      008B3C 27 2A            [ 1]  182 	jreq	00117$
                                    183 ;	../../my_STM8_libraries/stm8_UART.c: 54: buf[i] = (data % 10) + '0';
      008B3E 89               [ 2]  184 	pushw	x
      008B3F 5F               [ 1]  185 	clrw	x
      008B40 7B 0A            [ 1]  186 	ld	a, (0x0a, sp)
      008B42 97               [ 1]  187 	ld	xl, a
      008B43 89               [ 2]  188 	pushw	x
      008B44 96               [ 1]  189 	ldw	x, sp
      008B45 1C 00 07         [ 2]  190 	addw	x, #7
      008B48 72 FB 01         [ 2]  191 	addw	x, (1, sp)
      008B4B 1F 05            [ 2]  192 	ldw	(0x05, sp), x
      008B4D 5B 02            [ 2]  193 	addw	sp, #2
      008B4F 85               [ 2]  194 	popw	x
      008B50 89               [ 2]  195 	pushw	x
      008B51 90 AE 00 0A      [ 2]  196 	ldw	y, #0x000a
      008B55 65               [ 2]  197 	divw	x, y
      008B56 85               [ 2]  198 	popw	x
      008B57 90 9F            [ 1]  199 	ld	a, yl
      008B59 AB 30            [ 1]  200 	add	a, #0x30
      008B5B 16 01            [ 2]  201 	ldw	y, (0x01, sp)
      008B5D 90 F7            [ 1]  202 	ld	(y), a
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 55: data /= 10;
      008B5F 90 AE 00 0A      [ 2]  204 	ldw	y, #0x000a
      008B63 65               [ 2]  205 	divw	x, y
                                    206 ;	../../my_STM8_libraries/stm8_UART.c: 56: i++;
      008B64 0C 08            [ 1]  207 	inc	(0x08, sp)
      008B66 20 D3            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 58: while (i > 0)
      008B68                        210 00117$:
      008B68                        211 00108$:
      008B68 0D 08            [ 1]  212 	tnz	(0x08, sp)
      008B6A 27 19            [ 1]  213 	jreq	00110$
                                    214 ;	../../my_STM8_libraries/stm8_UART.c: 60: i--;
      008B6C 0A 08            [ 1]  215 	dec	(0x08, sp)
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 61: if (write_UART(buf[i]) == 0) return 0;
      008B6E 5F               [ 1]  217 	clrw	x
      008B6F 7B 08            [ 1]  218 	ld	a, (0x08, sp)
      008B71 97               [ 1]  219 	ld	xl, a
      008B72 89               [ 2]  220 	pushw	x
      008B73 96               [ 1]  221 	ldw	x, sp
      008B74 1C 00 05         [ 2]  222 	addw	x, #5
      008B77 72 FB 01         [ 2]  223 	addw	x, (1, sp)
      008B7A 5B 02            [ 2]  224 	addw	sp, #2
      008B7C F6               [ 1]  225 	ld	a, (x)
      008B7D CD 8A FF         [ 4]  226 	call	_write_UART
      008B80 4D               [ 1]  227 	tnz	a
      008B81 26 E5            [ 1]  228 	jrne	00108$
      008B83 4F               [ 1]  229 	clr	a
                                    230 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 1;
      008B84 C5                     231 	.byte 0xc5
      008B85                        232 00110$:
      008B85 A6 01            [ 1]  233 	ld	a, #0x01
      008B87                        234 00111$:
                                    235 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008B87 5B 08            [ 2]  236 	addw	sp, #8
      008B89 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_UART.c: 65: uint8_t line_UART(void)
                                    239 ;	-----------------------------------------
                                    240 ;	 function line_UART
                                    241 ;	-----------------------------------------
      008B8A                        242 _line_UART:
                                    243 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\r') == 0) return 0;
      008B8A A6 0D            [ 1]  244 	ld	a, #0x0d
      008B8C CD 8A FF         [ 4]  245 	call	_write_UART
      008B8F 4D               [ 1]  246 	tnz	a
      008B90 26 02            [ 1]  247 	jrne	00102$
      008B92 4F               [ 1]  248 	clr	a
      008B93 81               [ 4]  249 	ret
      008B94                        250 00102$:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 68: if (write_UART('\n') == 0) return 0;
      008B94 A6 0A            [ 1]  252 	ld	a, #0x0a
      008B96 CD 8A FF         [ 4]  253 	call	_write_UART
      008B99 4D               [ 1]  254 	tnz	a
      008B9A 26 02            [ 1]  255 	jrne	00104$
      008B9C 4F               [ 1]  256 	clr	a
      008B9D 81               [ 4]  257 	ret
      008B9E                        258 00104$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 69: return 1;
      008B9E A6 01            [ 1]  260 	ld	a, #0x01
                                    261 ;	../../my_STM8_libraries/stm8_UART.c: 70: }
      008BA0 81               [ 4]  262 	ret
                                    263 ;	../../my_STM8_libraries/stm8_UART.c: 71: static char nibbleToHex(uint8_t nibble)
                                    264 ;	-----------------------------------------
                                    265 ;	 function nibbleToHex
                                    266 ;	-----------------------------------------
      008BA1                        267 _nibbleToHex:
                                    268 ;	../../my_STM8_libraries/stm8_UART.c: 73: if (nibble < 10) return nibble + '0';
      008BA1 97               [ 1]  269 	ld	xl, a
      008BA2 A1 0A            [ 1]  270 	cp	a, #0x0a
      008BA4 24 04            [ 1]  271 	jrnc	00102$
      008BA6 9F               [ 1]  272 	ld	a, xl
      008BA7 AB 30            [ 1]  273 	add	a, #0x30
      008BA9 81               [ 4]  274 	ret
      008BAA                        275 00102$:
                                    276 ;	../../my_STM8_libraries/stm8_UART.c: 74: else return nibble - 10 + 'A';
      008BAA 9F               [ 1]  277 	ld	a, xl
      008BAB AB 37            [ 1]  278 	add	a, #0x37
                                    279 ;	../../my_STM8_libraries/stm8_UART.c: 75: }
      008BAD 81               [ 4]  280 	ret
                                    281 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t printHex_UART(uint8_t data)
                                    282 ;	-----------------------------------------
                                    283 ;	 function printHex_UART
                                    284 ;	-----------------------------------------
      008BAE                        285 _printHex_UART:
      008BAE 88               [ 1]  286 	push	a
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t high = data >> 4;
      008BAF 97               [ 1]  288 	ld	xl, a
      008BB0 4E               [ 1]  289 	swap	a
      008BB1 A4 0F            [ 1]  290 	and	a, #0x0f
      008BB3 41               [ 1]  291 	exg	a, xl
                                    292 ;	../../my_STM8_libraries/stm8_UART.c: 79: uint8_t low = data & 0x0F;
      008BB4 A4 0F            [ 1]  293 	and	a, #0x0f
      008BB6 6B 01            [ 1]  294 	ld	(0x01, sp), a
                                    295 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008BB8 9F               [ 1]  296 	ld	a, xl
      008BB9 CD 8B A1         [ 4]  297 	call	_nibbleToHex
      008BBC CD 8A FF         [ 4]  298 	call	_write_UART
      008BBF 4D               [ 1]  299 	tnz	a
      008BC0 26 03            [ 1]  300 	jrne	00102$
      008BC2 4F               [ 1]  301 	clr	a
      008BC3 20 0F            [ 2]  302 	jra	00105$
      008BC5                        303 00102$:
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 82: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008BC5 7B 01            [ 1]  305 	ld	a, (0x01, sp)
      008BC7 CD 8B A1         [ 4]  306 	call	_nibbleToHex
      008BCA CD 8A FF         [ 4]  307 	call	_write_UART
      008BCD 4D               [ 1]  308 	tnz	a
      008BCE 26 02            [ 1]  309 	jrne	00104$
      008BD0 4F               [ 1]  310 	clr	a
                                    311 ;	../../my_STM8_libraries/stm8_UART.c: 83: return 1;
      008BD1 C5                     312 	.byte 0xc5
      008BD2                        313 00104$:
      008BD2 A6 01            [ 1]  314 	ld	a, #0x01
      008BD4                        315 00105$:
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 84: }
      008BD4 5B 01            [ 2]  317 	addw	sp, #1
      008BD6 81               [ 4]  318 	ret
                                    319 ;	../../my_STM8_libraries/stm8_UART.c: 85: uint8_t isDataReceived_UART(void)
                                    320 ;	-----------------------------------------
                                    321 ;	 function isDataReceived_UART
                                    322 ;	-----------------------------------------
      008BD7                        323 _isDataReceived_UART:
                                    324 ;	../../my_STM8_libraries/stm8_UART.c: 87: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008BD7 72 0A 52 30 02   [ 2]  325 	btjt	0x5230, #5, 00102$
      008BDC 4F               [ 1]  326 	clr	a
      008BDD 81               [ 4]  327 	ret
      008BDE                        328 00102$:
                                    329 ;	../../my_STM8_libraries/stm8_UART.c: 88: return 1;
      008BDE A6 01            [ 1]  330 	ld	a, #0x01
                                    331 ;	../../my_STM8_libraries/stm8_UART.c: 89: }
      008BE0 81               [ 4]  332 	ret
                                    333 ;	../../my_STM8_libraries/stm8_UART.c: 90: uint8_t getData_UART(void)
                                    334 ;	-----------------------------------------
                                    335 ;	 function getData_UART
                                    336 ;	-----------------------------------------
      008BE1                        337 _getData_UART:
                                    338 ;	../../my_STM8_libraries/stm8_UART.c: 92: return UART1_DR;
      008BE1 C6 52 31         [ 1]  339 	ld	a, 0x5231
                                    340 ;	../../my_STM8_libraries/stm8_UART.c: 93: }
      008BE4 81               [ 4]  341 	ret
                                    342 	.area CODE
                                    343 	.area CONST
                                    344 	.area INITIALIZER
                                    345 	.area CABS (ABS)
