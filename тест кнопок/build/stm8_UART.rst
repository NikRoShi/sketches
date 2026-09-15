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
      0089F0                         60 _init_UART:
      0089F0 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      0089F1 90 5F            [ 1]   63 	clrw	y
      0089F3 89               [ 2]   64 	pushw	x
      0089F4 90 89            [ 2]   65 	pushw	y
      0089F6 4B 00            [ 1]   66 	push	#0x00
      0089F8 4B 24            [ 1]   67 	push	#0x24
      0089FA 4B F4            [ 1]   68 	push	#0xf4
      0089FC 4B 00            [ 1]   69 	push	#0x00
      0089FE CD 8B 6F         [ 4]   70 	call	__divulong
      008A01 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      008A03 9F               [ 1]   73 	ld	a, xl
      008A04 A4 0F            [ 1]   74 	and	a, #0x0f
      008A06 6B 01            [ 1]   75 	ld	(0x01, sp), a
      008A08 9E               [ 1]   76 	ld	a, xh
      008A09 A4 F0            [ 1]   77 	and	a, #0xf0
      008A0B 1A 01            [ 1]   78 	or	a, (0x01, sp)
      008A0D C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      008A10 A6 10            [ 1]   81 	ld	a, #0x10
      008A12 62               [ 2]   82 	div	x, a
      008A13 9F               [ 1]   83 	ld	a, xl
      008A14 C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008A17 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008A1B 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      008A1F 84               [ 1]   90 	pop	a
      008A20 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      008A21                         96 _write_UART:
      008A21 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      008A23 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      008A26                        100 00103$:
      008A26 C6 52 30         [ 1]  101 	ld	a, 0x5230
      008A29 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      008A2B 5A               [ 2]  104 	decw	x
      008A2C 5D               [ 2]  105 	tnzw	x
      008A2D 26 F7            [ 1]  106 	jrne	00103$
      008A2F 4F               [ 1]  107 	clr	a
      008A30 81               [ 4]  108 	ret
      008A31                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      008A31 AE 52 31         [ 2]  111 	ldw	x, #0x5231
      008A34 90 9F            [ 1]  112 	ld	a, yl
      008A36 F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      008A37 A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      008A39 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      008A3A                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      008A3A                        124 00104$:
      008A3A F6               [ 1]  125 	ld	a, (x)
      008A3B 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      008A3D 89               [ 2]  128 	pushw	x
      008A3E CD 8A 21         [ 4]  129 	call	_write_UART
      008A41 85               [ 2]  130 	popw	x
      008A42 4A               [ 1]  131 	dec	a
      008A43 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      008A45 5C               [ 1]  134 	incw	x
      008A46 20 F2            [ 2]  135 	jra	00104$
      008A48                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      008A48 4F               [ 1]  138 	clr	a
      008A49 81               [ 4]  139 	ret
      008A4A                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      008A4A A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      008A4C 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008A4D                        149 _printInt_UART:
      008A4D 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      008A4F 5D               [ 2]  152 	tnzw	x
      008A50 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      008A52 A6 30            [ 1]  155 	ld	a, #0x30
      008A54 CD 8A 21         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008A57 A6 01            [ 1]  158 	ld	a, #0x01
      008A59 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      008A5B                        161 00115$:
      008A5B 0F 08            [ 1]  162 	clr	(0x08, sp)
      008A5D                        163 00103$:
      008A5D 5D               [ 2]  164 	tnzw	x
      008A5E 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008A60 89               [ 2]  167 	pushw	x
      008A61 5F               [ 1]  168 	clrw	x
      008A62 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      008A64 97               [ 1]  170 	ld	xl, a
      008A65 89               [ 2]  171 	pushw	x
      008A66 96               [ 1]  172 	ldw	x, sp
      008A67 1C 00 07         [ 2]  173 	addw	x, #7
      008A6A 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008A6D 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008A6F 5B 02            [ 2]  176 	addw	sp, #2
      008A71 85               [ 2]  177 	popw	x
      008A72 89               [ 2]  178 	pushw	x
      008A73 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008A77 65               [ 2]  180 	divw	x, y
      008A78 85               [ 2]  181 	popw	x
      008A79 90 9F            [ 1]  182 	ld	a, yl
      008A7B AB 30            [ 1]  183 	add	a, #0x30
      008A7D 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008A7F 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      008A81 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      008A85 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      008A86 0C 08            [ 1]  190 	inc	(0x08, sp)
      008A88 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      008A8A                        193 00117$:
      008A8A                        194 00108$:
      008A8A 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008A8C 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      008A8E 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      008A90 5F               [ 1]  200 	clrw	x
      008A91 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      008A93 97               [ 1]  202 	ld	xl, a
      008A94 89               [ 2]  203 	pushw	x
      008A95 96               [ 1]  204 	ldw	x, sp
      008A96 1C 00 05         [ 2]  205 	addw	x, #5
      008A99 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      008A9C 5B 02            [ 2]  207 	addw	sp, #2
      008A9E F6               [ 1]  208 	ld	a, (x)
      008A9F CD 8A 21         [ 4]  209 	call	_write_UART
      008AA2 4D               [ 1]  210 	tnz	a
      008AA3 26 E5            [ 1]  211 	jrne	00108$
      008AA5 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      008AA6 C5                     214 	.byte 0xc5
      008AA7                        215 00110$:
      008AA7 A6 01            [ 1]  216 	ld	a, #0x01
      008AA9                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      008AA9 5B 08            [ 2]  219 	addw	sp, #8
      008AAB 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      008AAC                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      008AAC A6 0D            [ 1]  227 	ld	a, #0x0d
      008AAE CD 8A 21         [ 4]  228 	call	_write_UART
      008AB1 4D               [ 1]  229 	tnz	a
      008AB2 26 02            [ 1]  230 	jrne	00102$
      008AB4 4F               [ 1]  231 	clr	a
      008AB5 81               [ 4]  232 	ret
      008AB6                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      008AB6 A6 0A            [ 1]  235 	ld	a, #0x0a
      008AB8 CD 8A 21         [ 4]  236 	call	_write_UART
      008ABB 4D               [ 1]  237 	tnz	a
      008ABC 26 02            [ 1]  238 	jrne	00104$
      008ABE 4F               [ 1]  239 	clr	a
      008ABF 81               [ 4]  240 	ret
      008AC0                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      008AC0 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      008AC2 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      008AC3                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      008AC3 97               [ 1]  252 	ld	xl, a
      008AC4 A1 0A            [ 1]  253 	cp	a, #0x0a
      008AC6 24 04            [ 1]  254 	jrnc	00102$
      008AC8 9F               [ 1]  255 	ld	a, xl
      008AC9 AB 30            [ 1]  256 	add	a, #0x30
      008ACB 81               [ 4]  257 	ret
      008ACC                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      008ACC 9F               [ 1]  260 	ld	a, xl
      008ACD AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      008ACF 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      008AD0                        268 _printHex_UART:
      008AD0 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      008AD1 97               [ 1]  271 	ld	xl, a
      008AD2 4E               [ 1]  272 	swap	a
      008AD3 A4 0F            [ 1]  273 	and	a, #0x0f
      008AD5 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      008AD6 A4 0F            [ 1]  276 	and	a, #0x0f
      008AD8 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008ADA 9F               [ 1]  279 	ld	a, xl
      008ADB CD 8A C3         [ 4]  280 	call	_nibbleToHex
      008ADE CD 8A 21         [ 4]  281 	call	_write_UART
      008AE1 4D               [ 1]  282 	tnz	a
      008AE2 26 03            [ 1]  283 	jrne	00102$
      008AE4 4F               [ 1]  284 	clr	a
      008AE5 20 0F            [ 2]  285 	jra	00105$
      008AE7                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008AE7 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      008AE9 CD 8A C3         [ 4]  289 	call	_nibbleToHex
      008AEC CD 8A 21         [ 4]  290 	call	_write_UART
      008AEF 4D               [ 1]  291 	tnz	a
      008AF0 26 02            [ 1]  292 	jrne	00104$
      008AF2 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      008AF3 C5                     295 	.byte 0xc5
      008AF4                        296 00104$:
      008AF4 A6 01            [ 1]  297 	ld	a, #0x01
      008AF6                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008AF6 5B 01            [ 2]  300 	addw	sp, #1
      008AF8 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      008AF9                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008AF9 72 0A 52 30 02   [ 2]  308 	btjt	0x5230, #5, 00102$
      008AFE 4F               [ 1]  309 	clr	a
      008AFF 81               [ 4]  310 	ret
      008B00                        311 00102$:
                                    312 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      008B00 A6 01            [ 1]  313 	ld	a, #0x01
                                    314 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      008B02 81               [ 4]  315 	ret
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    317 ;	-----------------------------------------
                                    318 ;	 function getData_UART
                                    319 ;	-----------------------------------------
      008B03                        320 _getData_UART:
                                    321 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      008B03 C6 52 31         [ 1]  322 	ld	a, 0x5231
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      008B06 81               [ 4]  324 	ret
                                    325 	.area CODE
                                    326 	.area CONST
                                    327 	.area INITIALIZER
                                    328 	.area CABS (ABS)
