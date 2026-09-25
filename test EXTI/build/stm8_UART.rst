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
      008B51                         60 _init_UART:
      008B51 52 02            [ 2]   61 	sub	sp, #2
      008B53 6B 02            [ 1]   62 	ld	(0x02, sp), a
                                     63 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008B55 90 5F            [ 1]   64 	clrw	y
      008B57 89               [ 2]   65 	pushw	x
      008B58 90 89            [ 2]   66 	pushw	y
      008B5A 4B 00            [ 1]   67 	push	#0x00
      008B5C 4B 24            [ 1]   68 	push	#0x24
      008B5E 4B F4            [ 1]   69 	push	#0xf4
      008B60 4B 00            [ 1]   70 	push	#0x00
      008B62 CD 8C EA         [ 4]   71 	call	__divulong
      008B65 5B 08            [ 2]   72 	addw	sp, #8
                                     73 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008B67 9F               [ 1]   74 	ld	a, xl
      008B68 A4 0F            [ 1]   75 	and	a, #0x0f
      008B6A 6B 01            [ 1]   76 	ld	(0x01, sp), a
      008B6C 9E               [ 1]   77 	ld	a, xh
      008B6D A4 F0            [ 1]   78 	and	a, #0xf0
      008B6F 1A 01            [ 1]   79 	or	a, (0x01, sp)
      008B71 C7 52 33         [ 1]   80 	ld	0x5233, a
                                     81 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008B74 A6 10            [ 1]   82 	ld	a, #0x10
      008B76 62               [ 2]   83 	div	x, a
      008B77 9F               [ 1]   84 	ld	a, xl
      008B78 C7 52 32         [ 1]   85 	ld	0x5232, a
                                     86 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008B7B 72 16 52 35      [ 1]   87 	bset	0x5235, #3
                                     88 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008B7F 72 14 52 35      [ 1]   89 	bset	0x5235, #2
                                     90 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008B83 C6 52 35         [ 1]   91 	ld	a, 0x5235
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: if (rxInterrupt == ENABLE) UART1_CR2 |= UART1_CR2_RIEN;
      008B86 88               [ 1]   93 	push	a
      008B87 7B 03            [ 1]   94 	ld	a, (0x03, sp)
      008B89 4A               [ 1]   95 	dec	a
      008B8A 84               [ 1]   96 	pop	a
      008B8B 26 07            [ 1]   97 	jrne	00102$
      008B8D AA 20            [ 1]   98 	or	a, #0x20
      008B8F C7 52 35         [ 1]   99 	ld	0x5235, a
      008B92 20 05            [ 2]  100 	jra	00104$
      008B94                        101 00102$:
                                    102 ;	../../my_STM8_libraries/stm8_UART.c: 16: else  UART1_CR2 &= ~UART1_CR2_RIEN;
      008B94 A4 DF            [ 1]  103 	and	a, #0xdf
      008B96 C7 52 35         [ 1]  104 	ld	0x5235, a
      008B99                        105 00104$:
                                    106 ;	../../my_STM8_libraries/stm8_UART.c: 17: }
      008B99 5B 02            [ 2]  107 	addw	sp, #2
      008B9B 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 18: uint8_t write_UART(uint8_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function write_UART
                                    112 ;	-----------------------------------------
      008B9C                        113 _write_UART:
      008B9C 90 97            [ 1]  114 	ld	yl, a
                                    115 ;	../../my_STM8_libraries/stm8_UART.c: 22: while (!(UART1_SR & UART1_SR_TXE))
      008B9E AE C3 50         [ 2]  116 	ldw	x, #0xc350
      008BA1                        117 00103$:
      008BA1 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008BA4 2B 06            [ 1]  119 	jrmi	00105$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: if (--timeout == 0) return 0;
      008BA6 5A               [ 2]  121 	decw	x
      008BA7 5D               [ 2]  122 	tnzw	x
      008BA8 26 F7            [ 1]  123 	jrne	00103$
      008BAA 4F               [ 1]  124 	clr	a
      008BAB 81               [ 4]  125 	ret
      008BAC                        126 00105$:
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: UART1_DR = data;
      008BAC AE 52 31         [ 2]  128 	ldw	x, #0x5231
      008BAF 90 9F            [ 1]  129 	ld	a, yl
      008BB1 F7               [ 1]  130 	ld	(x), a
                                    131 ;	../../my_STM8_libraries/stm8_UART.c: 28: return 1;
      008BB2 A6 01            [ 1]  132 	ld	a, #0x01
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 29: }
      008BB4 81               [ 4]  134 	ret
                                    135 ;	../../my_STM8_libraries/stm8_UART.c: 30: uint8_t print_UART(char *str)
                                    136 ;	-----------------------------------------
                                    137 ;	 function print_UART
                                    138 ;	-----------------------------------------
      008BB5                        139 _print_UART:
                                    140 ;	../../my_STM8_libraries/stm8_UART.c: 32: while (*str != 0)
      008BB5                        141 00104$:
      008BB5 F6               [ 1]  142 	ld	a, (x)
      008BB6 27 0D            [ 1]  143 	jreq	00106$
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 34: if (write_UART(*str) == 1)
      008BB8 89               [ 2]  145 	pushw	x
      008BB9 CD 8B 9C         [ 4]  146 	call	_write_UART
      008BBC 85               [ 2]  147 	popw	x
      008BBD 4A               [ 1]  148 	dec	a
      008BBE 26 03            [ 1]  149 	jrne	00102$
                                    150 ;	../../my_STM8_libraries/stm8_UART.c: 36: str++;
      008BC0 5C               [ 1]  151 	incw	x
      008BC1 20 F2            [ 2]  152 	jra	00104$
      008BC3                        153 00102$:
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 38: else return 0;
      008BC3 4F               [ 1]  155 	clr	a
      008BC4 81               [ 4]  156 	ret
      008BC5                        157 00106$:
                                    158 ;	../../my_STM8_libraries/stm8_UART.c: 40: return 1;
      008BC5 A6 01            [ 1]  159 	ld	a, #0x01
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 41: }
      008BC7 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_UART.c: 42: uint8_t printInt_UART(uint16_t data)
                                    163 ;	-----------------------------------------
                                    164 ;	 function printInt_UART
                                    165 ;	-----------------------------------------
      008BC8                        166 _printInt_UART:
      008BC8 52 08            [ 2]  167 	sub	sp, #8
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 47: if (data == 0)
      008BCA 5D               [ 2]  169 	tnzw	x
      008BCB 26 09            [ 1]  170 	jrne	00115$
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 49: write_UART('0');
      008BCD A6 30            [ 1]  172 	ld	a, #0x30
      008BCF CD 8B 9C         [ 4]  173 	call	_write_UART
                                    174 ;	../../my_STM8_libraries/stm8_UART.c: 50: return 1;
      008BD2 A6 01            [ 1]  175 	ld	a, #0x01
      008BD4 20 4E            [ 2]  176 	jra	00111$
                                    177 ;	../../my_STM8_libraries/stm8_UART.c: 52: while (data != 0)
      008BD6                        178 00115$:
      008BD6 0F 08            [ 1]  179 	clr	(0x08, sp)
      008BD8                        180 00103$:
      008BD8 5D               [ 2]  181 	tnzw	x
      008BD9 27 2A            [ 1]  182 	jreq	00117$
                                    183 ;	../../my_STM8_libraries/stm8_UART.c: 54: buf[i] = (data % 10) + '0';
      008BDB 89               [ 2]  184 	pushw	x
      008BDC 5F               [ 1]  185 	clrw	x
      008BDD 7B 0A            [ 1]  186 	ld	a, (0x0a, sp)
      008BDF 97               [ 1]  187 	ld	xl, a
      008BE0 89               [ 2]  188 	pushw	x
      008BE1 96               [ 1]  189 	ldw	x, sp
      008BE2 1C 00 07         [ 2]  190 	addw	x, #7
      008BE5 72 FB 01         [ 2]  191 	addw	x, (1, sp)
      008BE8 1F 05            [ 2]  192 	ldw	(0x05, sp), x
      008BEA 5B 02            [ 2]  193 	addw	sp, #2
      008BEC 85               [ 2]  194 	popw	x
      008BED 89               [ 2]  195 	pushw	x
      008BEE 90 AE 00 0A      [ 2]  196 	ldw	y, #0x000a
      008BF2 65               [ 2]  197 	divw	x, y
      008BF3 85               [ 2]  198 	popw	x
      008BF4 90 9F            [ 1]  199 	ld	a, yl
      008BF6 AB 30            [ 1]  200 	add	a, #0x30
      008BF8 16 01            [ 2]  201 	ldw	y, (0x01, sp)
      008BFA 90 F7            [ 1]  202 	ld	(y), a
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 55: data /= 10;
      008BFC 90 AE 00 0A      [ 2]  204 	ldw	y, #0x000a
      008C00 65               [ 2]  205 	divw	x, y
                                    206 ;	../../my_STM8_libraries/stm8_UART.c: 56: i++;
      008C01 0C 08            [ 1]  207 	inc	(0x08, sp)
      008C03 20 D3            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 58: while (i > 0)
      008C05                        210 00117$:
      008C05                        211 00108$:
      008C05 0D 08            [ 1]  212 	tnz	(0x08, sp)
      008C07 27 19            [ 1]  213 	jreq	00110$
                                    214 ;	../../my_STM8_libraries/stm8_UART.c: 60: i--;
      008C09 0A 08            [ 1]  215 	dec	(0x08, sp)
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 61: if (write_UART(buf[i]) == 0) return 0;
      008C0B 5F               [ 1]  217 	clrw	x
      008C0C 7B 08            [ 1]  218 	ld	a, (0x08, sp)
      008C0E 97               [ 1]  219 	ld	xl, a
      008C0F 89               [ 2]  220 	pushw	x
      008C10 96               [ 1]  221 	ldw	x, sp
      008C11 1C 00 05         [ 2]  222 	addw	x, #5
      008C14 72 FB 01         [ 2]  223 	addw	x, (1, sp)
      008C17 5B 02            [ 2]  224 	addw	sp, #2
      008C19 F6               [ 1]  225 	ld	a, (x)
      008C1A CD 8B 9C         [ 4]  226 	call	_write_UART
      008C1D 4D               [ 1]  227 	tnz	a
      008C1E 26 E5            [ 1]  228 	jrne	00108$
      008C20 4F               [ 1]  229 	clr	a
                                    230 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 1;
      008C21 C5                     231 	.byte 0xc5
      008C22                        232 00110$:
      008C22 A6 01            [ 1]  233 	ld	a, #0x01
      008C24                        234 00111$:
                                    235 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008C24 5B 08            [ 2]  236 	addw	sp, #8
      008C26 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_UART.c: 65: uint8_t line_UART(void)
                                    239 ;	-----------------------------------------
                                    240 ;	 function line_UART
                                    241 ;	-----------------------------------------
      008C27                        242 _line_UART:
                                    243 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\r') == 0) return 0;
      008C27 A6 0D            [ 1]  244 	ld	a, #0x0d
      008C29 CD 8B 9C         [ 4]  245 	call	_write_UART
      008C2C 4D               [ 1]  246 	tnz	a
      008C2D 26 02            [ 1]  247 	jrne	00102$
      008C2F 4F               [ 1]  248 	clr	a
      008C30 81               [ 4]  249 	ret
      008C31                        250 00102$:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 68: if (write_UART('\n') == 0) return 0;
      008C31 A6 0A            [ 1]  252 	ld	a, #0x0a
      008C33 CD 8B 9C         [ 4]  253 	call	_write_UART
      008C36 4D               [ 1]  254 	tnz	a
      008C37 26 02            [ 1]  255 	jrne	00104$
      008C39 4F               [ 1]  256 	clr	a
      008C3A 81               [ 4]  257 	ret
      008C3B                        258 00104$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 69: return 1;
      008C3B A6 01            [ 1]  260 	ld	a, #0x01
                                    261 ;	../../my_STM8_libraries/stm8_UART.c: 70: }
      008C3D 81               [ 4]  262 	ret
                                    263 ;	../../my_STM8_libraries/stm8_UART.c: 71: static char nibbleToHex(uint8_t nibble)
                                    264 ;	-----------------------------------------
                                    265 ;	 function nibbleToHex
                                    266 ;	-----------------------------------------
      008C3E                        267 _nibbleToHex:
                                    268 ;	../../my_STM8_libraries/stm8_UART.c: 73: if (nibble < 10) return nibble + '0';
      008C3E 97               [ 1]  269 	ld	xl, a
      008C3F A1 0A            [ 1]  270 	cp	a, #0x0a
      008C41 24 04            [ 1]  271 	jrnc	00102$
      008C43 9F               [ 1]  272 	ld	a, xl
      008C44 AB 30            [ 1]  273 	add	a, #0x30
      008C46 81               [ 4]  274 	ret
      008C47                        275 00102$:
                                    276 ;	../../my_STM8_libraries/stm8_UART.c: 74: else return nibble - 10 + 'A';
      008C47 9F               [ 1]  277 	ld	a, xl
      008C48 AB 37            [ 1]  278 	add	a, #0x37
                                    279 ;	../../my_STM8_libraries/stm8_UART.c: 75: }
      008C4A 81               [ 4]  280 	ret
                                    281 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t printHex_UART(uint8_t data)
                                    282 ;	-----------------------------------------
                                    283 ;	 function printHex_UART
                                    284 ;	-----------------------------------------
      008C4B                        285 _printHex_UART:
      008C4B 88               [ 1]  286 	push	a
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t high = data >> 4;
      008C4C 97               [ 1]  288 	ld	xl, a
      008C4D 4E               [ 1]  289 	swap	a
      008C4E A4 0F            [ 1]  290 	and	a, #0x0f
      008C50 41               [ 1]  291 	exg	a, xl
                                    292 ;	../../my_STM8_libraries/stm8_UART.c: 79: uint8_t low = data & 0x0F;
      008C51 A4 0F            [ 1]  293 	and	a, #0x0f
      008C53 6B 01            [ 1]  294 	ld	(0x01, sp), a
                                    295 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008C55 9F               [ 1]  296 	ld	a, xl
      008C56 CD 8C 3E         [ 4]  297 	call	_nibbleToHex
      008C59 CD 8B 9C         [ 4]  298 	call	_write_UART
      008C5C 4D               [ 1]  299 	tnz	a
      008C5D 26 03            [ 1]  300 	jrne	00102$
      008C5F 4F               [ 1]  301 	clr	a
      008C60 20 0F            [ 2]  302 	jra	00105$
      008C62                        303 00102$:
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 82: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008C62 7B 01            [ 1]  305 	ld	a, (0x01, sp)
      008C64 CD 8C 3E         [ 4]  306 	call	_nibbleToHex
      008C67 CD 8B 9C         [ 4]  307 	call	_write_UART
      008C6A 4D               [ 1]  308 	tnz	a
      008C6B 26 02            [ 1]  309 	jrne	00104$
      008C6D 4F               [ 1]  310 	clr	a
                                    311 ;	../../my_STM8_libraries/stm8_UART.c: 83: return 1;
      008C6E C5                     312 	.byte 0xc5
      008C6F                        313 00104$:
      008C6F A6 01            [ 1]  314 	ld	a, #0x01
      008C71                        315 00105$:
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 84: }
      008C71 5B 01            [ 2]  317 	addw	sp, #1
      008C73 81               [ 4]  318 	ret
                                    319 ;	../../my_STM8_libraries/stm8_UART.c: 85: uint8_t isDataReceived_UART(void)
                                    320 ;	-----------------------------------------
                                    321 ;	 function isDataReceived_UART
                                    322 ;	-----------------------------------------
      008C74                        323 _isDataReceived_UART:
                                    324 ;	../../my_STM8_libraries/stm8_UART.c: 87: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008C74 72 0A 52 30 02   [ 2]  325 	btjt	0x5230, #5, 00102$
      008C79 4F               [ 1]  326 	clr	a
      008C7A 81               [ 4]  327 	ret
      008C7B                        328 00102$:
                                    329 ;	../../my_STM8_libraries/stm8_UART.c: 88: return 1;
      008C7B A6 01            [ 1]  330 	ld	a, #0x01
                                    331 ;	../../my_STM8_libraries/stm8_UART.c: 89: }
      008C7D 81               [ 4]  332 	ret
                                    333 ;	../../my_STM8_libraries/stm8_UART.c: 90: uint8_t getData_UART(void)
                                    334 ;	-----------------------------------------
                                    335 ;	 function getData_UART
                                    336 ;	-----------------------------------------
      008C7E                        337 _getData_UART:
                                    338 ;	../../my_STM8_libraries/stm8_UART.c: 92: return UART1_DR;
      008C7E C6 52 31         [ 1]  339 	ld	a, 0x5231
                                    340 ;	../../my_STM8_libraries/stm8_UART.c: 93: }
      008C81 81               [ 4]  341 	ret
                                    342 	.area CODE
                                    343 	.area CONST
                                    344 	.area INITIALIZER
                                    345 	.area CABS (ABS)
