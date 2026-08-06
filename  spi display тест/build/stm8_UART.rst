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
      008BEE                         60 _init_UART:
      008BEE 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      008BEF 90 5F            [ 1]   63 	clrw	y
      008BF1 89               [ 2]   64 	pushw	x
      008BF2 90 89            [ 2]   65 	pushw	y
      008BF4 4B 00            [ 1]   66 	push	#0x00
      008BF6 4B 24            [ 1]   67 	push	#0x24
      008BF8 4B F4            [ 1]   68 	push	#0xf4
      008BFA 4B 00            [ 1]   69 	push	#0x00
      008BFC CD 8D 05         [ 4]   70 	call	__divulong
      008BFF 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008C01 9F               [ 1]   73 	ld	a, xl
      008C02 A4 0F            [ 1]   74 	and	a, #0x0f
      008C04 6B 01            [ 1]   75 	ld	(0x01, sp), a
      008C06 9E               [ 1]   76 	ld	a, xh
      008C07 A4 F0            [ 1]   77 	and	a, #0xf0
      008C09 1A 01            [ 1]   78 	or	a, (0x01, sp)
      008C0B C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008C0E A6 10            [ 1]   81 	ld	a, #0x10
      008C10 62               [ 2]   82 	div	x, a
      008C11 9F               [ 1]   83 	ld	a, xl
      008C12 C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008C15 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008C19 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      008C1D 84               [ 1]   90 	pop	a
      008C1E 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      008C1F                         96 _write_UART:
      008C1F 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      008C21 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      008C24                        100 00103$:
      008C24 C6 52 30         [ 1]  101 	ld	a, 0x5230
      008C27 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      008C29 5A               [ 2]  104 	decw	x
      008C2A 5D               [ 2]  105 	tnzw	x
      008C2B 26 F7            [ 1]  106 	jrne	00103$
      008C2D 4F               [ 1]  107 	clr	a
      008C2E 81               [ 4]  108 	ret
      008C2F                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      008C2F AE 52 31         [ 2]  111 	ldw	x, #0x5231
      008C32 90 9F            [ 1]  112 	ld	a, yl
      008C34 F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      008C35 A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      008C37 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      008C38                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      008C38                        124 00104$:
      008C38 F6               [ 1]  125 	ld	a, (x)
      008C39 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      008C3B 89               [ 2]  128 	pushw	x
      008C3C CD 8C 1F         [ 4]  129 	call	_write_UART
      008C3F 85               [ 2]  130 	popw	x
      008C40 4A               [ 1]  131 	dec	a
      008C41 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      008C43 5C               [ 1]  134 	incw	x
      008C44 20 F2            [ 2]  135 	jra	00104$
      008C46                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      008C46 4F               [ 1]  138 	clr	a
      008C47 81               [ 4]  139 	ret
      008C48                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      008C48 A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      008C4A 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008C4B                        149 _printInt_UART:
      008C4B 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      008C4D 5D               [ 2]  152 	tnzw	x
      008C4E 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      008C50 A6 30            [ 1]  155 	ld	a, #0x30
      008C52 CD 8C 1F         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008C55 A6 01            [ 1]  158 	ld	a, #0x01
      008C57 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      008C59                        161 00115$:
      008C59 0F 08            [ 1]  162 	clr	(0x08, sp)
      008C5B                        163 00103$:
      008C5B 5D               [ 2]  164 	tnzw	x
      008C5C 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008C5E 89               [ 2]  167 	pushw	x
      008C5F 5F               [ 1]  168 	clrw	x
      008C60 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      008C62 97               [ 1]  170 	ld	xl, a
      008C63 89               [ 2]  171 	pushw	x
      008C64 96               [ 1]  172 	ldw	x, sp
      008C65 1C 00 07         [ 2]  173 	addw	x, #7
      008C68 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008C6B 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008C6D 5B 02            [ 2]  176 	addw	sp, #2
      008C6F 85               [ 2]  177 	popw	x
      008C70 89               [ 2]  178 	pushw	x
      008C71 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008C75 65               [ 2]  180 	divw	x, y
      008C76 85               [ 2]  181 	popw	x
      008C77 90 9F            [ 1]  182 	ld	a, yl
      008C79 AB 30            [ 1]  183 	add	a, #0x30
      008C7B 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008C7D 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      008C7F 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      008C83 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      008C84 0C 08            [ 1]  190 	inc	(0x08, sp)
      008C86 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      008C88                        193 00117$:
      008C88                        194 00108$:
      008C88 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008C8A 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      008C8C 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      008C8E 5F               [ 1]  200 	clrw	x
      008C8F 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      008C91 97               [ 1]  202 	ld	xl, a
      008C92 89               [ 2]  203 	pushw	x
      008C93 96               [ 1]  204 	ldw	x, sp
      008C94 1C 00 05         [ 2]  205 	addw	x, #5
      008C97 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      008C9A 5B 02            [ 2]  207 	addw	sp, #2
      008C9C F6               [ 1]  208 	ld	a, (x)
      008C9D CD 8C 1F         [ 4]  209 	call	_write_UART
      008CA0 4D               [ 1]  210 	tnz	a
      008CA1 26 E5            [ 1]  211 	jrne	00108$
      008CA3 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      008CA4 C5                     214 	.byte 0xc5
      008CA5                        215 00110$:
      008CA5 A6 01            [ 1]  216 	ld	a, #0x01
      008CA7                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      008CA7 5B 08            [ 2]  219 	addw	sp, #8
      008CA9 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      008CAA                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      008CAA A6 0D            [ 1]  227 	ld	a, #0x0d
      008CAC CD 8C 1F         [ 4]  228 	call	_write_UART
      008CAF 4D               [ 1]  229 	tnz	a
      008CB0 26 02            [ 1]  230 	jrne	00102$
      008CB2 4F               [ 1]  231 	clr	a
      008CB3 81               [ 4]  232 	ret
      008CB4                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      008CB4 A6 0A            [ 1]  235 	ld	a, #0x0a
      008CB6 CD 8C 1F         [ 4]  236 	call	_write_UART
      008CB9 4D               [ 1]  237 	tnz	a
      008CBA 26 02            [ 1]  238 	jrne	00104$
      008CBC 4F               [ 1]  239 	clr	a
      008CBD 81               [ 4]  240 	ret
      008CBE                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      008CBE A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      008CC0 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      008CC1                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      008CC1 97               [ 1]  252 	ld	xl, a
      008CC2 A1 0A            [ 1]  253 	cp	a, #0x0a
      008CC4 24 04            [ 1]  254 	jrnc	00102$
      008CC6 9F               [ 1]  255 	ld	a, xl
      008CC7 AB 30            [ 1]  256 	add	a, #0x30
      008CC9 81               [ 4]  257 	ret
      008CCA                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      008CCA 9F               [ 1]  260 	ld	a, xl
      008CCB AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      008CCD 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      008CCE                        268 _printHex_UART:
      008CCE 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      008CCF 97               [ 1]  271 	ld	xl, a
      008CD0 4E               [ 1]  272 	swap	a
      008CD1 A4 0F            [ 1]  273 	and	a, #0x0f
      008CD3 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      008CD4 A4 0F            [ 1]  276 	and	a, #0x0f
      008CD6 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008CD8 9F               [ 1]  279 	ld	a, xl
      008CD9 CD 8C C1         [ 4]  280 	call	_nibbleToHex
      008CDC CD 8C 1F         [ 4]  281 	call	_write_UART
      008CDF 4D               [ 1]  282 	tnz	a
      008CE0 26 03            [ 1]  283 	jrne	00102$
      008CE2 4F               [ 1]  284 	clr	a
      008CE3 20 0F            [ 2]  285 	jra	00105$
      008CE5                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008CE5 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      008CE7 CD 8C C1         [ 4]  289 	call	_nibbleToHex
      008CEA CD 8C 1F         [ 4]  290 	call	_write_UART
      008CED 4D               [ 1]  291 	tnz	a
      008CEE 26 02            [ 1]  292 	jrne	00104$
      008CF0 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      008CF1 C5                     295 	.byte 0xc5
      008CF2                        296 00104$:
      008CF2 A6 01            [ 1]  297 	ld	a, #0x01
      008CF4                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008CF4 5B 01            [ 2]  300 	addw	sp, #1
      008CF6 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      008CF7                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008CF7 72 0A 52 30 02   [ 2]  308 	btjt	0x5230, #5, 00102$
      008CFC 4F               [ 1]  309 	clr	a
      008CFD 81               [ 4]  310 	ret
      008CFE                        311 00102$:
                                    312 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      008CFE A6 01            [ 1]  313 	ld	a, #0x01
                                    314 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      008D00 81               [ 4]  315 	ret
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    317 ;	-----------------------------------------
                                    318 ;	 function getData_UART
                                    319 ;	-----------------------------------------
      008D01                        320 _getData_UART:
                                    321 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      008D01 C6 52 31         [ 1]  322 	ld	a, 0x5231
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      008D04 81               [ 4]  324 	ret
                                    325 	.area CODE
                                    326 	.area CONST
                                    327 	.area INITIALIZER
                                    328 	.area CABS (ABS)
