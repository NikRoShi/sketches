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
      0089A4                         60 _init_UART:
      0089A4 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      0089A5 90 5F            [ 1]   63 	clrw	y
      0089A7 89               [ 2]   64 	pushw	x
      0089A8 90 89            [ 2]   65 	pushw	y
      0089AA 4B 00            [ 1]   66 	push	#0x00
      0089AC 4B 24            [ 1]   67 	push	#0x24
      0089AE 4B F4            [ 1]   68 	push	#0xf4
      0089B0 4B 00            [ 1]   69 	push	#0x00
      0089B2 CD 8B 23         [ 4]   70 	call	__divulong
      0089B5 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      0089B7 9F               [ 1]   73 	ld	a, xl
      0089B8 A4 0F            [ 1]   74 	and	a, #0x0f
      0089BA 6B 01            [ 1]   75 	ld	(0x01, sp), a
      0089BC 9E               [ 1]   76 	ld	a, xh
      0089BD A4 F0            [ 1]   77 	and	a, #0xf0
      0089BF 1A 01            [ 1]   78 	or	a, (0x01, sp)
      0089C1 C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      0089C4 A6 10            [ 1]   81 	ld	a, #0x10
      0089C6 62               [ 2]   82 	div	x, a
      0089C7 9F               [ 1]   83 	ld	a, xl
      0089C8 C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      0089CB 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      0089CF 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      0089D3 84               [ 1]   90 	pop	a
      0089D4 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      0089D5                         96 _write_UART:
      0089D5 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      0089D7 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      0089DA                        100 00103$:
      0089DA C6 52 30         [ 1]  101 	ld	a, 0x5230
      0089DD 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      0089DF 5A               [ 2]  104 	decw	x
      0089E0 5D               [ 2]  105 	tnzw	x
      0089E1 26 F7            [ 1]  106 	jrne	00103$
      0089E3 4F               [ 1]  107 	clr	a
      0089E4 81               [ 4]  108 	ret
      0089E5                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      0089E5 AE 52 31         [ 2]  111 	ldw	x, #0x5231
      0089E8 90 9F            [ 1]  112 	ld	a, yl
      0089EA F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      0089EB A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      0089ED 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      0089EE                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      0089EE                        124 00104$:
      0089EE F6               [ 1]  125 	ld	a, (x)
      0089EF 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      0089F1 89               [ 2]  128 	pushw	x
      0089F2 CD 89 D5         [ 4]  129 	call	_write_UART
      0089F5 85               [ 2]  130 	popw	x
      0089F6 4A               [ 1]  131 	dec	a
      0089F7 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      0089F9 5C               [ 1]  134 	incw	x
      0089FA 20 F2            [ 2]  135 	jra	00104$
      0089FC                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      0089FC 4F               [ 1]  138 	clr	a
      0089FD 81               [ 4]  139 	ret
      0089FE                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      0089FE A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      008A00 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008A01                        149 _printInt_UART:
      008A01 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      008A03 5D               [ 2]  152 	tnzw	x
      008A04 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      008A06 A6 30            [ 1]  155 	ld	a, #0x30
      008A08 CD 89 D5         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008A0B A6 01            [ 1]  158 	ld	a, #0x01
      008A0D 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      008A0F                        161 00115$:
      008A0F 0F 08            [ 1]  162 	clr	(0x08, sp)
      008A11                        163 00103$:
      008A11 5D               [ 2]  164 	tnzw	x
      008A12 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008A14 89               [ 2]  167 	pushw	x
      008A15 5F               [ 1]  168 	clrw	x
      008A16 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      008A18 97               [ 1]  170 	ld	xl, a
      008A19 89               [ 2]  171 	pushw	x
      008A1A 96               [ 1]  172 	ldw	x, sp
      008A1B 1C 00 07         [ 2]  173 	addw	x, #7
      008A1E 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008A21 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008A23 5B 02            [ 2]  176 	addw	sp, #2
      008A25 85               [ 2]  177 	popw	x
      008A26 89               [ 2]  178 	pushw	x
      008A27 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008A2B 65               [ 2]  180 	divw	x, y
      008A2C 85               [ 2]  181 	popw	x
      008A2D 90 9F            [ 1]  182 	ld	a, yl
      008A2F AB 30            [ 1]  183 	add	a, #0x30
      008A31 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008A33 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      008A35 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      008A39 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      008A3A 0C 08            [ 1]  190 	inc	(0x08, sp)
      008A3C 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      008A3E                        193 00117$:
      008A3E                        194 00108$:
      008A3E 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008A40 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      008A42 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      008A44 5F               [ 1]  200 	clrw	x
      008A45 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      008A47 97               [ 1]  202 	ld	xl, a
      008A48 89               [ 2]  203 	pushw	x
      008A49 96               [ 1]  204 	ldw	x, sp
      008A4A 1C 00 05         [ 2]  205 	addw	x, #5
      008A4D 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      008A50 5B 02            [ 2]  207 	addw	sp, #2
      008A52 F6               [ 1]  208 	ld	a, (x)
      008A53 CD 89 D5         [ 4]  209 	call	_write_UART
      008A56 4D               [ 1]  210 	tnz	a
      008A57 26 E5            [ 1]  211 	jrne	00108$
      008A59 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      008A5A C5                     214 	.byte 0xc5
      008A5B                        215 00110$:
      008A5B A6 01            [ 1]  216 	ld	a, #0x01
      008A5D                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      008A5D 5B 08            [ 2]  219 	addw	sp, #8
      008A5F 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      008A60                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      008A60 A6 0D            [ 1]  227 	ld	a, #0x0d
      008A62 CD 89 D5         [ 4]  228 	call	_write_UART
      008A65 4D               [ 1]  229 	tnz	a
      008A66 26 02            [ 1]  230 	jrne	00102$
      008A68 4F               [ 1]  231 	clr	a
      008A69 81               [ 4]  232 	ret
      008A6A                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      008A6A A6 0A            [ 1]  235 	ld	a, #0x0a
      008A6C CD 89 D5         [ 4]  236 	call	_write_UART
      008A6F 4D               [ 1]  237 	tnz	a
      008A70 26 02            [ 1]  238 	jrne	00104$
      008A72 4F               [ 1]  239 	clr	a
      008A73 81               [ 4]  240 	ret
      008A74                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      008A74 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      008A76 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      008A77                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      008A77 97               [ 1]  252 	ld	xl, a
      008A78 A1 0A            [ 1]  253 	cp	a, #0x0a
      008A7A 24 04            [ 1]  254 	jrnc	00102$
      008A7C 9F               [ 1]  255 	ld	a, xl
      008A7D AB 30            [ 1]  256 	add	a, #0x30
      008A7F 81               [ 4]  257 	ret
      008A80                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      008A80 9F               [ 1]  260 	ld	a, xl
      008A81 AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      008A83 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      008A84                        268 _printHex_UART:
      008A84 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      008A85 97               [ 1]  271 	ld	xl, a
      008A86 4E               [ 1]  272 	swap	a
      008A87 A4 0F            [ 1]  273 	and	a, #0x0f
      008A89 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      008A8A A4 0F            [ 1]  276 	and	a, #0x0f
      008A8C 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      008A8E 9F               [ 1]  279 	ld	a, xl
      008A8F CD 8A 77         [ 4]  280 	call	_nibbleToHex
      008A92 CD 89 D5         [ 4]  281 	call	_write_UART
      008A95 4D               [ 1]  282 	tnz	a
      008A96 26 03            [ 1]  283 	jrne	00102$
      008A98 4F               [ 1]  284 	clr	a
      008A99 20 0F            [ 2]  285 	jra	00105$
      008A9B                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      008A9B 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      008A9D CD 8A 77         [ 4]  289 	call	_nibbleToHex
      008AA0 CD 89 D5         [ 4]  290 	call	_write_UART
      008AA3 4D               [ 1]  291 	tnz	a
      008AA4 26 02            [ 1]  292 	jrne	00104$
      008AA6 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      008AA7 C5                     295 	.byte 0xc5
      008AA8                        296 00104$:
      008AA8 A6 01            [ 1]  297 	ld	a, #0x01
      008AAA                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008AAA 5B 01            [ 2]  300 	addw	sp, #1
      008AAC 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      008AAD                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      008AAD 72 0A 52 30 02   [ 2]  308 	btjt	0x5230, #5, 00102$
      008AB2 4F               [ 1]  309 	clr	a
      008AB3 81               [ 4]  310 	ret
      008AB4                        311 00102$:
                                    312 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      008AB4 A6 01            [ 1]  313 	ld	a, #0x01
                                    314 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      008AB6 81               [ 4]  315 	ret
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    317 ;	-----------------------------------------
                                    318 ;	 function getData_UART
                                    319 ;	-----------------------------------------
      008AB7                        320 _getData_UART:
                                    321 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      008AB7 C6 52 31         [ 1]  322 	ld	a, 0x5231
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      008ABA 81               [ 4]  324 	ret
                                    325 	.area CODE
                                    326 	.area CONST
                                    327 	.area INITIALIZER
                                    328 	.area CABS (ABS)
