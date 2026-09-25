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
      008B59                         60 _init_UART:
      008B59 52 02            [ 2]   61 	sub	sp, #2
      008B5B 6B 02            [ 1]   62 	ld	(0x02, sp), a
                                     63 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008B5D 90 5F            [ 1]   64 	clrw	y
      008B5F 89               [ 2]   65 	pushw	x
      008B60 90 89            [ 2]   66 	pushw	y
      008B62 4B 00            [ 1]   67 	push	#0x00
      008B64 4B 24            [ 1]   68 	push	#0x24
      008B66 4B F4            [ 1]   69 	push	#0xf4
      008B68 4B 00            [ 1]   70 	push	#0x00
      008B6A CD 8C F2         [ 4]   71 	call	__divulong
      008B6D 5B 08            [ 2]   72 	addw	sp, #8
                                     73 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008B6F 9F               [ 1]   74 	ld	a, xl
      008B70 A4 0F            [ 1]   75 	and	a, #0x0f
      008B72 6B 01            [ 1]   76 	ld	(0x01, sp), a
      008B74 9E               [ 1]   77 	ld	a, xh
      008B75 A4 F0            [ 1]   78 	and	a, #0xf0
      008B77 1A 01            [ 1]   79 	or	a, (0x01, sp)
      008B79 C7 52 33         [ 1]   80 	ld	0x5233, a
                                     81 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008B7C A6 10            [ 1]   82 	ld	a, #0x10
      008B7E 62               [ 2]   83 	div	x, a
      008B7F 9F               [ 1]   84 	ld	a, xl
      008B80 C7 52 32         [ 1]   85 	ld	0x5232, a
                                     86 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008B83 72 16 52 35      [ 1]   87 	bset	0x5235, #3
                                     88 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008B87 72 14 52 35      [ 1]   89 	bset	0x5235, #2
                                     90 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008B8B C6 52 35         [ 1]   91 	ld	a, 0x5235
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: if (rxInterrupt == ENABLE) UART1_CR2 |= UART1_CR2_RIEN;
      008B8E 88               [ 1]   93 	push	a
      008B8F 7B 03            [ 1]   94 	ld	a, (0x03, sp)
      008B91 4A               [ 1]   95 	dec	a
      008B92 84               [ 1]   96 	pop	a
      008B93 26 07            [ 1]   97 	jrne	00102$
      008B95 AA 20            [ 1]   98 	or	a, #0x20
      008B97 C7 52 35         [ 1]   99 	ld	0x5235, a
      008B9A 20 05            [ 2]  100 	jra	00104$
      008B9C                        101 00102$:
                                    102 ;	../../my_STM8_libraries/stm8_UART.c: 16: else  UART1_CR2 &= ~UART1_CR2_RIEN;
      008B9C A4 DF            [ 1]  103 	and	a, #0xdf
      008B9E C7 52 35         [ 1]  104 	ld	0x5235, a
      008BA1                        105 00104$:
                                    106 ;	../../my_STM8_libraries/stm8_UART.c: 17: }
      008BA1 5B 02            [ 2]  107 	addw	sp, #2
      008BA3 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 18: uint8_t write_UART(uint8_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function write_UART
                                    112 ;	-----------------------------------------
      008BA4                        113 _write_UART:
      008BA4 90 97            [ 1]  114 	ld	yl, a
                                    115 ;	../../my_STM8_libraries/stm8_UART.c: 22: while (!(UART1_SR & UART1_SR_TXE))
      008BA6 AE C3 50         [ 2]  116 	ldw	x, #0xc350
      008BA9                        117 00103$:
      008BA9 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008BAC 2B 06            [ 1]  119 	jrmi	00105$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: if (--timeout == 0) return 0;
      008BAE 5A               [ 2]  121 	decw	x
      008BAF 5D               [ 2]  122 	tnzw	x
      008BB0 26 F7            [ 1]  123 	jrne	00103$
      008BB2 4F               [ 1]  124 	clr	a
      008BB3 81               [ 4]  125 	ret
      008BB4                        126 00105$:
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: UART1_DR = data;
      008BB4 AE 52 31         [ 2]  128 	ldw	x, #0x5231
      008BB7 90 9F            [ 1]  129 	ld	a, yl
      008BB9 F7               [ 1]  130 	ld	(x), a
                                    131 ;	../../my_STM8_libraries/stm8_UART.c: 28: return 1;
      008BBA A6 01            [ 1]  132 	ld	a, #0x01
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 29: }
      008BBC 81               [ 4]  134 	ret
                                    135 ;	../../my_STM8_libraries/stm8_UART.c: 30: uint8_t print_UART(char *str)
                                    136 ;	-----------------------------------------
                                    137 ;	 function print_UART
                                    138 ;	-----------------------------------------
      008BBD                        139 _print_UART:
                                    140 ;	../../my_STM8_libraries/stm8_UART.c: 32: while (*str != 0)
      008BBD                        141 00104$:
      008BBD F6               [ 1]  142 	ld	a, (x)
      008BBE 27 0D            [ 1]  143 	jreq	00106$
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 34: if (write_UART(*str) == 1)
      008BC0 89               [ 2]  145 	pushw	x
      008BC1 CD 8B A4         [ 4]  146 	call	_write_UART
      008BC4 85               [ 2]  147 	popw	x
      008BC5 4A               [ 1]  148 	dec	a
      008BC6 26 03            [ 1]  149 	jrne	00102$
                                    150 ;	../../my_STM8_libraries/stm8_UART.c: 36: str++;
      008BC8 5C               [ 1]  151 	incw	x
      008BC9 20 F2            [ 2]  152 	jra	00104$
      008BCB                        153 00102$:
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 38: else return 0;
      008BCB 4F               [ 1]  155 	clr	a
      008BCC 81               [ 4]  156 	ret
      008BCD                        157 00106$:
                                    158 ;	../../my_STM8_libraries/stm8_UART.c: 40: return 1;
      008BCD A6 01            [ 1]  159 	ld	a, #0x01
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 41: }
      008BCF 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_UART.c: 42: uint8_t printInt_UART(uint16_t data)
                                    163 ;	-----------------------------------------
                                    164 ;	 function printInt_UART
                                    165 ;	-----------------------------------------
      008BD0                        166 _printInt_UART:
      008BD0 52 08            [ 2]  167 	sub	sp, #8
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 47: if (data == 0)
      008BD2 5D               [ 2]  169 	tnzw	x
      008BD3 26 09            [ 1]  170 	jrne	00115$
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 49: write_UART('0');
      008BD5 A6 30            [ 1]  172 	ld	a, #0x30
      008BD7 CD 8B A4         [ 4]  173 	call	_write_UART
                                    174 ;	../../my_STM8_libraries/stm8_UART.c: 50: return 1;
      008BDA A6 01            [ 1]  175 	ld	a, #0x01
      008BDC 20 4E            [ 2]  176 	jra	00111$
                                    177 ;	../../my_STM8_libraries/stm8_UART.c: 52: while (data != 0)
      008BDE                        178 00115$:
      008BDE 0F 08            [ 1]  179 	clr	(0x08, sp)
      008BE0                        180 00103$:
      008BE0 5D               [ 2]  181 	tnzw	x
      008BE1 27 2A            [ 1]  182 	jreq	00117$
                                    183 ;	../../my_STM8_libraries/stm8_UART.c: 54: buf[i] = (data % 10) + '0';
      008BE3 89               [ 2]  184 	pushw	x
      008BE4 5F               [ 1]  185 	clrw	x
      008BE5 7B 0A            [ 1]  186 	ld	a, (0x0a, sp)
      008BE7 97               [ 1]  187 	ld	xl, a
      008BE8 89               [ 2]  188 	pushw	x
      008BE9 96               [ 1]  189 	ldw	x, sp
      008BEA 1C 00 07         [ 2]  190 	addw	x, #7
      008BED 72 FB 01         [ 2]  191 	addw	x, (1, sp)
      008BF0 1F 05            [ 2]  192 	ldw	(0x05, sp), x
      008BF2 5B 02            [ 2]  193 	addw	sp, #2
      008BF4 85               [ 2]  194 	popw	x
      008BF5 89               [ 2]  195 	pushw	x
      008BF6 90 AE 00 0A      [ 2]  196 	ldw	y, #0x000a
      008BFA 65               [ 2]  197 	divw	x, y
      008BFB 85               [ 2]  198 	popw	x
      008BFC 90 9F            [ 1]  199 	ld	a, yl
      008BFE AB 30            [ 1]  200 	add	a, #0x30
      008C00 16 01            [ 2]  201 	ldw	y, (0x01, sp)
      008C02 90 F7            [ 1]  202 	ld	(y), a
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 55: data /= 10;
      008C04 90 AE 00 0A      [ 2]  204 	ldw	y, #0x000a
      008C08 65               [ 2]  205 	divw	x, y
                                    206 ;	../../my_STM8_libraries/stm8_UART.c: 56: i++;
      008C09 0C 08            [ 1]  207 	inc	(0x08, sp)
      008C0B 20 D3            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 58: while (i > 0)
      008C0D                        210 00117$:
      008C0D                        211 00108$:
      008C0D 0D 08            [ 1]  212 	tnz	(0x08, sp)
      008C0F 27 19            [ 1]  213 	jreq	00110$
                                    214 ;	../../my_STM8_libraries/stm8_UART.c: 60: i--;
      008C11 0A 08            [ 1]  215 	dec	(0x08, sp)
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 61: if (write_UART(buf[i]) == 0) return 0;
      008C13 5F               [ 1]  217 	clrw	x
      008C14 7B 08            [ 1]  218 	ld	a, (0x08, sp)
      008C16 97               [ 1]  219 	ld	xl, a
      008C17 89               [ 2]  220 	pushw	x
      008C18 96               [ 1]  221 	ldw	x, sp
      008C19 1C 00 05         [ 2]  222 	addw	x, #5
      008C1C 72 FB 01         [ 2]  223 	addw	x, (1, sp)
      008C1F 5B 02            [ 2]  224 	addw	sp, #2
      008C21 F6               [ 1]  225 	ld	a, (x)
      008C22 CD 8B A4         [ 4]  226 	call	_write_UART
      008C25 4D               [ 1]  227 	tnz	a
      008C26 26 E5            [ 1]  228 	jrne	00108$
      008C28 4F               [ 1]  229 	clr	a
                                    230 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 1;
      008C29 C5                     231 	.byte 0xc5
      008C2A                        232 00110$:
      008C2A A6 01            [ 1]  233 	ld	a, #0x01
      008C2C                        234 00111$:
                                    235 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008C2C 5B 08            [ 2]  236 	addw	sp, #8
      008C2E 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_UART.c: 65: uint8_t line_UART(void)
                                    239 ;	-----------------------------------------
                                    240 ;	 function line_UART
                                    241 ;	-----------------------------------------
      008C2F                        242 _line_UART:
                                    243 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\r') == 0) return 0;
      008C2F A6 0D            [ 1]  244 	ld	a, #0x0d
      008C31 CD 8B A4         [ 4]  245 	call	_write_UART
      008C34 4D               [ 1]  246 	tnz	a
      008C35 26 02            [ 1]  247 	jrne	00102$
      008C37 4F               [ 1]  248 	clr	a
      008C38 81               [ 4]  249 	ret
      008C39                        250 00102$:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 68: if (write_UART('\n') == 0) return 0;
      008C39 A6 0A            [ 1]  252 	ld	a, #0x0a
      008C3B CD 8B A4         [ 4]  253 	call	_write_UART
      008C3E 4D               [ 1]  254 	tnz	a
      008C3F 26 02            [ 1]  255 	jrne	00104$
      008C41 4F               [ 1]  256 	clr	a
      008C42 81               [ 4]  257 	ret
      008C43                        258 00104$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 69: return 1;
      008C43 A6 01            [ 1]  260 	ld	a, #0x01
                                    261 ;	../../my_STM8_libraries/stm8_UART.c: 70: }
      008C45 81               [ 4]  262 	ret
                                    263 ;	../../my_STM8_libraries/stm8_UART.c: 71: static char nibbleToHex(uint8_t nibble)
                                    264 ;	-----------------------------------------
                                    265 ;	 function nibbleToHex
                                    266 ;	-----------------------------------------
      008C46                        267 _nibbleToHex:
                                    268 ;	../../my_STM8_libraries/stm8_UART.c: 73: if (nibble < 10) return nibble + '0';
      008C46 97               [ 1]  269 	ld	xl, a
      008C47 A1 0A            [ 1]  270 	cp	a, #0x0a
      008C49 24 04            [ 1]  271 	jrnc	00102$
      008C4B 9F               [ 1]  272 	ld	a, xl
      008C4C AB 30            [ 1]  273 	add	a, #0x30
      008C4E 81               [ 4]  274 	ret
      008C4F                        275 00102$:
                                    276 ;	../../my_STM8_libraries/stm8_UART.c: 74: else return nibble - 10 + 'A';
      008C4F 9F               [ 1]  277 	ld	a, xl
      008C50 AB 37            [ 1]  278 	add	a, #0x37
                                    279 ;	../../my_STM8_libraries/stm8_UART.c: 75: }
      008C52 81               [ 4]  280 	ret
                                    281 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t printHex_UART(uint8_t data)
                                    282 ;	-----------------------------------------
                                    283 ;	 function printHex_UART
                                    284 ;	-----------------------------------------
      008C53                        285 _printHex_UART:
      008C53 88               [ 1]  286 	push	a
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t high = data >> 4;
      008C54 97               [ 1]  288 	ld	xl, a
      008C55 4E               [ 1]  289 	swap	a
      008C56 A4 0F            [ 1]  290 	and	a, #0x0f
      008C58 41               [ 1]  291 	exg	a, xl
                                    292 ;	../../my_STM8_libraries/stm8_UART.c: 79: uint8_t low = data & 0x0F;
      008C59 A4 0F            [ 1]  293 	and	a, #0x0f
      008C5B 6B 01            [ 1]  294 	ld	(0x01, sp), a
                                    295 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008C5D 9F               [ 1]  296 	ld	a, xl
      008C5E CD 8C 46         [ 4]  297 	call	_nibbleToHex
      008C61 CD 8B A4         [ 4]  298 	call	_write_UART
      008C64 4D               [ 1]  299 	tnz	a
      008C65 26 03            [ 1]  300 	jrne	00102$
      008C67 4F               [ 1]  301 	clr	a
      008C68 20 0F            [ 2]  302 	jra	00105$
      008C6A                        303 00102$:
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 82: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008C6A 7B 01            [ 1]  305 	ld	a, (0x01, sp)
      008C6C CD 8C 46         [ 4]  306 	call	_nibbleToHex
      008C6F CD 8B A4         [ 4]  307 	call	_write_UART
      008C72 4D               [ 1]  308 	tnz	a
      008C73 26 02            [ 1]  309 	jrne	00104$
      008C75 4F               [ 1]  310 	clr	a
                                    311 ;	../../my_STM8_libraries/stm8_UART.c: 83: return 1;
      008C76 C5                     312 	.byte 0xc5
      008C77                        313 00104$:
      008C77 A6 01            [ 1]  314 	ld	a, #0x01
      008C79                        315 00105$:
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 84: }
      008C79 5B 01            [ 2]  317 	addw	sp, #1
      008C7B 81               [ 4]  318 	ret
                                    319 ;	../../my_STM8_libraries/stm8_UART.c: 85: uint8_t isDataReceived_UART(void)
                                    320 ;	-----------------------------------------
                                    321 ;	 function isDataReceived_UART
                                    322 ;	-----------------------------------------
      008C7C                        323 _isDataReceived_UART:
                                    324 ;	../../my_STM8_libraries/stm8_UART.c: 87: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008C7C 72 0A 52 30 02   [ 2]  325 	btjt	0x5230, #5, 00102$
      008C81 4F               [ 1]  326 	clr	a
      008C82 81               [ 4]  327 	ret
      008C83                        328 00102$:
                                    329 ;	../../my_STM8_libraries/stm8_UART.c: 88: return 1;
      008C83 A6 01            [ 1]  330 	ld	a, #0x01
                                    331 ;	../../my_STM8_libraries/stm8_UART.c: 89: }
      008C85 81               [ 4]  332 	ret
                                    333 ;	../../my_STM8_libraries/stm8_UART.c: 90: uint8_t getData_UART(void)
                                    334 ;	-----------------------------------------
                                    335 ;	 function getData_UART
                                    336 ;	-----------------------------------------
      008C86                        337 _getData_UART:
                                    338 ;	../../my_STM8_libraries/stm8_UART.c: 92: return UART1_DR;
      008C86 C6 52 31         [ 1]  339 	ld	a, 0x5231
                                    340 ;	../../my_STM8_libraries/stm8_UART.c: 93: }
      008C89 81               [ 4]  341 	ret
                                    342 	.area CODE
                                    343 	.area CONST
                                    344 	.area INITIALIZER
                                    345 	.area CABS (ABS)
