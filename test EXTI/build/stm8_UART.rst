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
      008BA7                         60 _init_UART:
      008BA7 52 02            [ 2]   61 	sub	sp, #2
      008BA9 6B 02            [ 1]   62 	ld	(0x02, sp), a
                                     63 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008BAB 90 5F            [ 1]   64 	clrw	y
      008BAD 89               [ 2]   65 	pushw	x
      008BAE 90 89            [ 2]   66 	pushw	y
      008BB0 4B 00            [ 1]   67 	push	#0x00
      008BB2 4B 24            [ 1]   68 	push	#0x24
      008BB4 4B F4            [ 1]   69 	push	#0xf4
      008BB6 4B 00            [ 1]   70 	push	#0x00
      008BB8 CD 8D 40         [ 4]   71 	call	__divulong
      008BBB 5B 08            [ 2]   72 	addw	sp, #8
                                     73 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008BBD 9F               [ 1]   74 	ld	a, xl
      008BBE A4 0F            [ 1]   75 	and	a, #0x0f
      008BC0 6B 01            [ 1]   76 	ld	(0x01, sp), a
      008BC2 9E               [ 1]   77 	ld	a, xh
      008BC3 A4 F0            [ 1]   78 	and	a, #0xf0
      008BC5 1A 01            [ 1]   79 	or	a, (0x01, sp)
      008BC7 C7 52 33         [ 1]   80 	ld	0x5233, a
                                     81 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008BCA A6 10            [ 1]   82 	ld	a, #0x10
      008BCC 62               [ 2]   83 	div	x, a
      008BCD 9F               [ 1]   84 	ld	a, xl
      008BCE C7 52 32         [ 1]   85 	ld	0x5232, a
                                     86 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008BD1 72 16 52 35      [ 1]   87 	bset	0x5235, #3
                                     88 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008BD5 72 14 52 35      [ 1]   89 	bset	0x5235, #2
                                     90 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008BD9 C6 52 35         [ 1]   91 	ld	a, 0x5235
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: if (rxInterrupt == ENABLE) UART1_CR2 |= UART1_CR2_RIEN;
      008BDC 88               [ 1]   93 	push	a
      008BDD 7B 03            [ 1]   94 	ld	a, (0x03, sp)
      008BDF 4A               [ 1]   95 	dec	a
      008BE0 84               [ 1]   96 	pop	a
      008BE1 26 07            [ 1]   97 	jrne	00102$
      008BE3 AA 20            [ 1]   98 	or	a, #0x20
      008BE5 C7 52 35         [ 1]   99 	ld	0x5235, a
      008BE8 20 05            [ 2]  100 	jra	00104$
      008BEA                        101 00102$:
                                    102 ;	../../my_STM8_libraries/stm8_UART.c: 16: else  UART1_CR2 &= ~UART1_CR2_RIEN;
      008BEA A4 DF            [ 1]  103 	and	a, #0xdf
      008BEC C7 52 35         [ 1]  104 	ld	0x5235, a
      008BEF                        105 00104$:
                                    106 ;	../../my_STM8_libraries/stm8_UART.c: 17: }
      008BEF 5B 02            [ 2]  107 	addw	sp, #2
      008BF1 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 18: uint8_t write_UART(uint8_t data)
                                    110 ;	-----------------------------------------
                                    111 ;	 function write_UART
                                    112 ;	-----------------------------------------
      008BF2                        113 _write_UART:
      008BF2 90 97            [ 1]  114 	ld	yl, a
                                    115 ;	../../my_STM8_libraries/stm8_UART.c: 22: while (!(UART1_SR & UART1_SR_TXE))
      008BF4 AE C3 50         [ 2]  116 	ldw	x, #0xc350
      008BF7                        117 00103$:
      008BF7 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008BFA 2B 06            [ 1]  119 	jrmi	00105$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: if (--timeout == 0) return 0;
      008BFC 5A               [ 2]  121 	decw	x
      008BFD 5D               [ 2]  122 	tnzw	x
      008BFE 26 F7            [ 1]  123 	jrne	00103$
      008C00 4F               [ 1]  124 	clr	a
      008C01 81               [ 4]  125 	ret
      008C02                        126 00105$:
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: UART1_DR = data;
      008C02 AE 52 31         [ 2]  128 	ldw	x, #0x5231
      008C05 90 9F            [ 1]  129 	ld	a, yl
      008C07 F7               [ 1]  130 	ld	(x), a
                                    131 ;	../../my_STM8_libraries/stm8_UART.c: 28: return 1;
      008C08 A6 01            [ 1]  132 	ld	a, #0x01
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 29: }
      008C0A 81               [ 4]  134 	ret
                                    135 ;	../../my_STM8_libraries/stm8_UART.c: 30: uint8_t print_UART(char *str)
                                    136 ;	-----------------------------------------
                                    137 ;	 function print_UART
                                    138 ;	-----------------------------------------
      008C0B                        139 _print_UART:
                                    140 ;	../../my_STM8_libraries/stm8_UART.c: 32: while (*str != 0)
      008C0B                        141 00104$:
      008C0B F6               [ 1]  142 	ld	a, (x)
      008C0C 27 0D            [ 1]  143 	jreq	00106$
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 34: if (write_UART(*str) == 1)
      008C0E 89               [ 2]  145 	pushw	x
      008C0F CD 8B F2         [ 4]  146 	call	_write_UART
      008C12 85               [ 2]  147 	popw	x
      008C13 4A               [ 1]  148 	dec	a
      008C14 26 03            [ 1]  149 	jrne	00102$
                                    150 ;	../../my_STM8_libraries/stm8_UART.c: 36: str++;
      008C16 5C               [ 1]  151 	incw	x
      008C17 20 F2            [ 2]  152 	jra	00104$
      008C19                        153 00102$:
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 38: else return 0;
      008C19 4F               [ 1]  155 	clr	a
      008C1A 81               [ 4]  156 	ret
      008C1B                        157 00106$:
                                    158 ;	../../my_STM8_libraries/stm8_UART.c: 40: return 1;
      008C1B A6 01            [ 1]  159 	ld	a, #0x01
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 41: }
      008C1D 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_UART.c: 42: uint8_t printInt_UART(uint16_t data)
                                    163 ;	-----------------------------------------
                                    164 ;	 function printInt_UART
                                    165 ;	-----------------------------------------
      008C1E                        166 _printInt_UART:
      008C1E 52 08            [ 2]  167 	sub	sp, #8
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 47: if (data == 0)
      008C20 5D               [ 2]  169 	tnzw	x
      008C21 26 09            [ 1]  170 	jrne	00115$
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 49: write_UART('0');
      008C23 A6 30            [ 1]  172 	ld	a, #0x30
      008C25 CD 8B F2         [ 4]  173 	call	_write_UART
                                    174 ;	../../my_STM8_libraries/stm8_UART.c: 50: return 1;
      008C28 A6 01            [ 1]  175 	ld	a, #0x01
      008C2A 20 4E            [ 2]  176 	jra	00111$
                                    177 ;	../../my_STM8_libraries/stm8_UART.c: 52: while (data != 0)
      008C2C                        178 00115$:
      008C2C 0F 08            [ 1]  179 	clr	(0x08, sp)
      008C2E                        180 00103$:
      008C2E 5D               [ 2]  181 	tnzw	x
      008C2F 27 2A            [ 1]  182 	jreq	00117$
                                    183 ;	../../my_STM8_libraries/stm8_UART.c: 54: buf[i] = (data % 10) + '0';
      008C31 89               [ 2]  184 	pushw	x
      008C32 5F               [ 1]  185 	clrw	x
      008C33 7B 0A            [ 1]  186 	ld	a, (0x0a, sp)
      008C35 97               [ 1]  187 	ld	xl, a
      008C36 89               [ 2]  188 	pushw	x
      008C37 96               [ 1]  189 	ldw	x, sp
      008C38 1C 00 07         [ 2]  190 	addw	x, #7
      008C3B 72 FB 01         [ 2]  191 	addw	x, (1, sp)
      008C3E 1F 05            [ 2]  192 	ldw	(0x05, sp), x
      008C40 5B 02            [ 2]  193 	addw	sp, #2
      008C42 85               [ 2]  194 	popw	x
      008C43 89               [ 2]  195 	pushw	x
      008C44 90 AE 00 0A      [ 2]  196 	ldw	y, #0x000a
      008C48 65               [ 2]  197 	divw	x, y
      008C49 85               [ 2]  198 	popw	x
      008C4A 90 9F            [ 1]  199 	ld	a, yl
      008C4C AB 30            [ 1]  200 	add	a, #0x30
      008C4E 16 01            [ 2]  201 	ldw	y, (0x01, sp)
      008C50 90 F7            [ 1]  202 	ld	(y), a
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 55: data /= 10;
      008C52 90 AE 00 0A      [ 2]  204 	ldw	y, #0x000a
      008C56 65               [ 2]  205 	divw	x, y
                                    206 ;	../../my_STM8_libraries/stm8_UART.c: 56: i++;
      008C57 0C 08            [ 1]  207 	inc	(0x08, sp)
      008C59 20 D3            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 58: while (i > 0)
      008C5B                        210 00117$:
      008C5B                        211 00108$:
      008C5B 0D 08            [ 1]  212 	tnz	(0x08, sp)
      008C5D 27 19            [ 1]  213 	jreq	00110$
                                    214 ;	../../my_STM8_libraries/stm8_UART.c: 60: i--;
      008C5F 0A 08            [ 1]  215 	dec	(0x08, sp)
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 61: if (write_UART(buf[i]) == 0) return 0;
      008C61 5F               [ 1]  217 	clrw	x
      008C62 7B 08            [ 1]  218 	ld	a, (0x08, sp)
      008C64 97               [ 1]  219 	ld	xl, a
      008C65 89               [ 2]  220 	pushw	x
      008C66 96               [ 1]  221 	ldw	x, sp
      008C67 1C 00 05         [ 2]  222 	addw	x, #5
      008C6A 72 FB 01         [ 2]  223 	addw	x, (1, sp)
      008C6D 5B 02            [ 2]  224 	addw	sp, #2
      008C6F F6               [ 1]  225 	ld	a, (x)
      008C70 CD 8B F2         [ 4]  226 	call	_write_UART
      008C73 4D               [ 1]  227 	tnz	a
      008C74 26 E5            [ 1]  228 	jrne	00108$
      008C76 4F               [ 1]  229 	clr	a
                                    230 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 1;
      008C77 C5                     231 	.byte 0xc5
      008C78                        232 00110$:
      008C78 A6 01            [ 1]  233 	ld	a, #0x01
      008C7A                        234 00111$:
                                    235 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008C7A 5B 08            [ 2]  236 	addw	sp, #8
      008C7C 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_UART.c: 65: uint8_t line_UART(void)
                                    239 ;	-----------------------------------------
                                    240 ;	 function line_UART
                                    241 ;	-----------------------------------------
      008C7D                        242 _line_UART:
                                    243 ;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\r') == 0) return 0;
      008C7D A6 0D            [ 1]  244 	ld	a, #0x0d
      008C7F CD 8B F2         [ 4]  245 	call	_write_UART
      008C82 4D               [ 1]  246 	tnz	a
      008C83 26 02            [ 1]  247 	jrne	00102$
      008C85 4F               [ 1]  248 	clr	a
      008C86 81               [ 4]  249 	ret
      008C87                        250 00102$:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 68: if (write_UART('\n') == 0) return 0;
      008C87 A6 0A            [ 1]  252 	ld	a, #0x0a
      008C89 CD 8B F2         [ 4]  253 	call	_write_UART
      008C8C 4D               [ 1]  254 	tnz	a
      008C8D 26 02            [ 1]  255 	jrne	00104$
      008C8F 4F               [ 1]  256 	clr	a
      008C90 81               [ 4]  257 	ret
      008C91                        258 00104$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 69: return 1;
      008C91 A6 01            [ 1]  260 	ld	a, #0x01
                                    261 ;	../../my_STM8_libraries/stm8_UART.c: 70: }
      008C93 81               [ 4]  262 	ret
                                    263 ;	../../my_STM8_libraries/stm8_UART.c: 71: static char nibbleToHex(uint8_t nibble)
                                    264 ;	-----------------------------------------
                                    265 ;	 function nibbleToHex
                                    266 ;	-----------------------------------------
      008C94                        267 _nibbleToHex:
                                    268 ;	../../my_STM8_libraries/stm8_UART.c: 73: if (nibble < 10) return nibble + '0';
      008C94 97               [ 1]  269 	ld	xl, a
      008C95 A1 0A            [ 1]  270 	cp	a, #0x0a
      008C97 24 04            [ 1]  271 	jrnc	00102$
      008C99 9F               [ 1]  272 	ld	a, xl
      008C9A AB 30            [ 1]  273 	add	a, #0x30
      008C9C 81               [ 4]  274 	ret
      008C9D                        275 00102$:
                                    276 ;	../../my_STM8_libraries/stm8_UART.c: 74: else return nibble - 10 + 'A';
      008C9D 9F               [ 1]  277 	ld	a, xl
      008C9E AB 37            [ 1]  278 	add	a, #0x37
                                    279 ;	../../my_STM8_libraries/stm8_UART.c: 75: }
      008CA0 81               [ 4]  280 	ret
                                    281 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t printHex_UART(uint8_t data)
                                    282 ;	-----------------------------------------
                                    283 ;	 function printHex_UART
                                    284 ;	-----------------------------------------
      008CA1                        285 _printHex_UART:
      008CA1 88               [ 1]  286 	push	a
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t high = data >> 4;
      008CA2 97               [ 1]  288 	ld	xl, a
      008CA3 4E               [ 1]  289 	swap	a
      008CA4 A4 0F            [ 1]  290 	and	a, #0x0f
      008CA6 41               [ 1]  291 	exg	a, xl
                                    292 ;	../../my_STM8_libraries/stm8_UART.c: 79: uint8_t low = data & 0x0F;
      008CA7 A4 0F            [ 1]  293 	and	a, #0x0f
      008CA9 6B 01            [ 1]  294 	ld	(0x01, sp), a
                                    295 ;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008CAB 9F               [ 1]  296 	ld	a, xl
      008CAC CD 8C 94         [ 4]  297 	call	_nibbleToHex
      008CAF CD 8B F2         [ 4]  298 	call	_write_UART
      008CB2 4D               [ 1]  299 	tnz	a
      008CB3 26 03            [ 1]  300 	jrne	00102$
      008CB5 4F               [ 1]  301 	clr	a
      008CB6 20 0F            [ 2]  302 	jra	00105$
      008CB8                        303 00102$:
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 82: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008CB8 7B 01            [ 1]  305 	ld	a, (0x01, sp)
      008CBA CD 8C 94         [ 4]  306 	call	_nibbleToHex
      008CBD CD 8B F2         [ 4]  307 	call	_write_UART
      008CC0 4D               [ 1]  308 	tnz	a
      008CC1 26 02            [ 1]  309 	jrne	00104$
      008CC3 4F               [ 1]  310 	clr	a
                                    311 ;	../../my_STM8_libraries/stm8_UART.c: 83: return 1;
      008CC4 C5                     312 	.byte 0xc5
      008CC5                        313 00104$:
      008CC5 A6 01            [ 1]  314 	ld	a, #0x01
      008CC7                        315 00105$:
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 84: }
      008CC7 5B 01            [ 2]  317 	addw	sp, #1
      008CC9 81               [ 4]  318 	ret
                                    319 ;	../../my_STM8_libraries/stm8_UART.c: 85: uint8_t isDataReceived_UART(void)
                                    320 ;	-----------------------------------------
                                    321 ;	 function isDataReceived_UART
                                    322 ;	-----------------------------------------
      008CCA                        323 _isDataReceived_UART:
                                    324 ;	../../my_STM8_libraries/stm8_UART.c: 87: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008CCA 72 0A 52 30 02   [ 2]  325 	btjt	0x5230, #5, 00102$
      008CCF 4F               [ 1]  326 	clr	a
      008CD0 81               [ 4]  327 	ret
      008CD1                        328 00102$:
                                    329 ;	../../my_STM8_libraries/stm8_UART.c: 88: return 1;
      008CD1 A6 01            [ 1]  330 	ld	a, #0x01
                                    331 ;	../../my_STM8_libraries/stm8_UART.c: 89: }
      008CD3 81               [ 4]  332 	ret
                                    333 ;	../../my_STM8_libraries/stm8_UART.c: 90: uint8_t getData_UART(void)
                                    334 ;	-----------------------------------------
                                    335 ;	 function getData_UART
                                    336 ;	-----------------------------------------
      008CD4                        337 _getData_UART:
                                    338 ;	../../my_STM8_libraries/stm8_UART.c: 92: return UART1_DR;
      008CD4 C6 52 31         [ 1]  339 	ld	a, 0x5231
                                    340 ;	../../my_STM8_libraries/stm8_UART.c: 93: }
      008CD7 81               [ 4]  341 	ret
                                    342 	.area CODE
                                    343 	.area CONST
                                    344 	.area INITIALIZER
                                    345 	.area CABS (ABS)
