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
      0086D9                         60 _init_UART:
      0086D9 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 7: uartdiv = F_CPU / baudrate;
      0086DA 90 5F            [ 1]   63 	clrw	y
      0086DC 89               [ 2]   64 	pushw	x
      0086DD 90 89            [ 2]   65 	pushw	y
      0086DF 4B 00            [ 1]   66 	push	#0x00
      0086E1 4B 24            [ 1]   67 	push	#0x24
      0086E3 4B F4            [ 1]   68 	push	#0xf4
      0086E5 4B 00            [ 1]   69 	push	#0x00
      0086E7 CD 87 F0         [ 4]   70 	call	__divulong
      0086EA 5B 08            [ 2]   71 	addw	sp, #8
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 9: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
      0086EC 9F               [ 1]   73 	ld	a, xl
      0086ED A4 0F            [ 1]   74 	and	a, #0x0f
      0086EF 6B 01            [ 1]   75 	ld	(0x01, sp), a
      0086F1 9E               [ 1]   76 	ld	a, xh
      0086F2 A4 F0            [ 1]   77 	and	a, #0xf0
      0086F4 1A 01            [ 1]   78 	or	a, (0x01, sp)
      0086F6 C7 52 33         [ 1]   79 	ld	0x5233, a
                                     80 ;	../../my_STM8_libraries/stm8_UART.c: 10: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
      0086F9 A6 10            [ 1]   81 	ld	a, #0x10
      0086FB 62               [ 2]   82 	div	x, a
      0086FC 9F               [ 1]   83 	ld	a, xl
      0086FD C7 52 32         [ 1]   84 	ld	0x5232, a
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_CR2 |= UART1_CR2_TEN;
      008700 72 16 52 35      [ 1]   86 	bset	0x5235, #3
                                     87 ;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_CR2 |= UART1_CR2_REN;
      008704 72 14 52 35      [ 1]   88 	bset	0x5235, #2
                                     89 ;	../../my_STM8_libraries/stm8_UART.c: 14: }
      008708 84               [ 1]   90 	pop	a
      008709 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint8_t write_UART(uint8_t data)
                                     93 ;	-----------------------------------------
                                     94 ;	 function write_UART
                                     95 ;	-----------------------------------------
      00870A                         96 _write_UART:
      00870A 90 97            [ 1]   97 	ld	yl, a
                                     98 ;	../../my_STM8_libraries/stm8_UART.c: 19: while (!(UART1_SR & UART1_SR_TXE))
      00870C AE C3 50         [ 2]   99 	ldw	x, #0xc350
      00870F                        100 00103$:
      00870F C6 52 30         [ 1]  101 	ld	a, 0x5230
      008712 2B 06            [ 1]  102 	jrmi	00105$
                                    103 ;	../../my_STM8_libraries/stm8_UART.c: 21: if (--timeout == 0) return 0;
      008714 5A               [ 2]  104 	decw	x
      008715 5D               [ 2]  105 	tnzw	x
      008716 26 F7            [ 1]  106 	jrne	00103$
      008718 4F               [ 1]  107 	clr	a
      008719 81               [ 4]  108 	ret
      00871A                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = data;
      00871A AE 52 31         [ 2]  111 	ldw	x, #0x5231
      00871D 90 9F            [ 1]  112 	ld	a, yl
      00871F F7               [ 1]  113 	ld	(x), a
                                    114 ;	../../my_STM8_libraries/stm8_UART.c: 25: return 1;
      008720 A6 01            [ 1]  115 	ld	a, #0x01
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 26: }
      008722 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_UART.c: 27: uint8_t print_UART(char *str)
                                    119 ;	-----------------------------------------
                                    120 ;	 function print_UART
                                    121 ;	-----------------------------------------
      008723                        122 _print_UART:
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 29: while (*str != 0)
      008723                        124 00104$:
      008723 F6               [ 1]  125 	ld	a, (x)
      008724 27 0D            [ 1]  126 	jreq	00106$
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 31: if (write_UART(*str) == 1)
      008726 89               [ 2]  128 	pushw	x
      008727 CD 87 0A         [ 4]  129 	call	_write_UART
      00872A 85               [ 2]  130 	popw	x
      00872B 4A               [ 1]  131 	dec	a
      00872C 26 03            [ 1]  132 	jrne	00102$
                                    133 ;	../../my_STM8_libraries/stm8_UART.c: 33: str++;
      00872E 5C               [ 1]  134 	incw	x
      00872F 20 F2            [ 2]  135 	jra	00104$
      008731                        136 00102$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 35: else return 0;
      008731 4F               [ 1]  138 	clr	a
      008732 81               [ 4]  139 	ret
      008733                        140 00106$:
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 37: return 1;
      008733 A6 01            [ 1]  142 	ld	a, #0x01
                                    143 ;	../../my_STM8_libraries/stm8_UART.c: 38: }
      008735 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 39: uint8_t printInt_UART(uint16_t data)
                                    146 ;	-----------------------------------------
                                    147 ;	 function printInt_UART
                                    148 ;	-----------------------------------------
      008736                        149 _printInt_UART:
      008736 52 08            [ 2]  150 	sub	sp, #8
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 44: if (data == 0)
      008738 5D               [ 2]  152 	tnzw	x
      008739 26 09            [ 1]  153 	jrne	00115$
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 46: write_UART('0');
      00873B A6 30            [ 1]  155 	ld	a, #0x30
      00873D CD 87 0A         [ 4]  156 	call	_write_UART
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 47: return 1;
      008740 A6 01            [ 1]  158 	ld	a, #0x01
      008742 20 4E            [ 2]  159 	jra	00111$
                                    160 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (data != 0)
      008744                        161 00115$:
      008744 0F 08            [ 1]  162 	clr	(0x08, sp)
      008746                        163 00103$:
      008746 5D               [ 2]  164 	tnzw	x
      008747 27 2A            [ 1]  165 	jreq	00117$
                                    166 ;	../../my_STM8_libraries/stm8_UART.c: 51: buf[i] = (data % 10) + '0';
      008749 89               [ 2]  167 	pushw	x
      00874A 5F               [ 1]  168 	clrw	x
      00874B 7B 0A            [ 1]  169 	ld	a, (0x0a, sp)
      00874D 97               [ 1]  170 	ld	xl, a
      00874E 89               [ 2]  171 	pushw	x
      00874F 96               [ 1]  172 	ldw	x, sp
      008750 1C 00 07         [ 2]  173 	addw	x, #7
      008753 72 FB 01         [ 2]  174 	addw	x, (1, sp)
      008756 1F 05            [ 2]  175 	ldw	(0x05, sp), x
      008758 5B 02            [ 2]  176 	addw	sp, #2
      00875A 85               [ 2]  177 	popw	x
      00875B 89               [ 2]  178 	pushw	x
      00875C 90 AE 00 0A      [ 2]  179 	ldw	y, #0x000a
      008760 65               [ 2]  180 	divw	x, y
      008761 85               [ 2]  181 	popw	x
      008762 90 9F            [ 1]  182 	ld	a, yl
      008764 AB 30            [ 1]  183 	add	a, #0x30
      008766 16 01            [ 2]  184 	ldw	y, (0x01, sp)
      008768 90 F7            [ 1]  185 	ld	(y), a
                                    186 ;	../../my_STM8_libraries/stm8_UART.c: 52: data /= 10;
      00876A 90 AE 00 0A      [ 2]  187 	ldw	y, #0x000a
      00876E 65               [ 2]  188 	divw	x, y
                                    189 ;	../../my_STM8_libraries/stm8_UART.c: 53: i++;
      00876F 0C 08            [ 1]  190 	inc	(0x08, sp)
      008771 20 D3            [ 2]  191 	jra	00103$
                                    192 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0)
      008773                        193 00117$:
      008773                        194 00108$:
      008773 0D 08            [ 1]  195 	tnz	(0x08, sp)
      008775 27 19            [ 1]  196 	jreq	00110$
                                    197 ;	../../my_STM8_libraries/stm8_UART.c: 57: i--;
      008777 0A 08            [ 1]  198 	dec	(0x08, sp)
                                    199 ;	../../my_STM8_libraries/stm8_UART.c: 58: if (write_UART(buf[i]) == 0) return 0;
      008779 5F               [ 1]  200 	clrw	x
      00877A 7B 08            [ 1]  201 	ld	a, (0x08, sp)
      00877C 97               [ 1]  202 	ld	xl, a
      00877D 89               [ 2]  203 	pushw	x
      00877E 96               [ 1]  204 	ldw	x, sp
      00877F 1C 00 05         [ 2]  205 	addw	x, #5
      008782 72 FB 01         [ 2]  206 	addw	x, (1, sp)
      008785 5B 02            [ 2]  207 	addw	sp, #2
      008787 F6               [ 1]  208 	ld	a, (x)
      008788 CD 87 0A         [ 4]  209 	call	_write_UART
      00878B 4D               [ 1]  210 	tnz	a
      00878C 26 E5            [ 1]  211 	jrne	00108$
      00878E 4F               [ 1]  212 	clr	a
                                    213 ;	../../my_STM8_libraries/stm8_UART.c: 60: return 1;
      00878F C5                     214 	.byte 0xc5
      008790                        215 00110$:
      008790 A6 01            [ 1]  216 	ld	a, #0x01
      008792                        217 00111$:
                                    218 ;	../../my_STM8_libraries/stm8_UART.c: 61: }
      008792 5B 08            [ 2]  219 	addw	sp, #8
      008794 81               [ 4]  220 	ret
                                    221 ;	../../my_STM8_libraries/stm8_UART.c: 62: uint8_t line_UART(void)
                                    222 ;	-----------------------------------------
                                    223 ;	 function line_UART
                                    224 ;	-----------------------------------------
      008795                        225 _line_UART:
                                    226 ;	../../my_STM8_libraries/stm8_UART.c: 64: if (write_UART('\r') == 0) return 0;
      008795 A6 0D            [ 1]  227 	ld	a, #0x0d
      008797 CD 87 0A         [ 4]  228 	call	_write_UART
      00879A 4D               [ 1]  229 	tnz	a
      00879B 26 02            [ 1]  230 	jrne	00102$
      00879D 4F               [ 1]  231 	clr	a
      00879E 81               [ 4]  232 	ret
      00879F                        233 00102$:
                                    234 ;	../../my_STM8_libraries/stm8_UART.c: 65: if (write_UART('\n') == 0) return 0;
      00879F A6 0A            [ 1]  235 	ld	a, #0x0a
      0087A1 CD 87 0A         [ 4]  236 	call	_write_UART
      0087A4 4D               [ 1]  237 	tnz	a
      0087A5 26 02            [ 1]  238 	jrne	00104$
      0087A7 4F               [ 1]  239 	clr	a
      0087A8 81               [ 4]  240 	ret
      0087A9                        241 00104$:
                                    242 ;	../../my_STM8_libraries/stm8_UART.c: 66: return 1;
      0087A9 A6 01            [ 1]  243 	ld	a, #0x01
                                    244 ;	../../my_STM8_libraries/stm8_UART.c: 67: }
      0087AB 81               [ 4]  245 	ret
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 68: static char nibbleToHex(uint8_t nibble)
                                    247 ;	-----------------------------------------
                                    248 ;	 function nibbleToHex
                                    249 ;	-----------------------------------------
      0087AC                        250 _nibbleToHex:
                                    251 ;	../../my_STM8_libraries/stm8_UART.c: 70: if (nibble < 10) return nibble + '0';
      0087AC 97               [ 1]  252 	ld	xl, a
      0087AD A1 0A            [ 1]  253 	cp	a, #0x0a
      0087AF 24 04            [ 1]  254 	jrnc	00102$
      0087B1 9F               [ 1]  255 	ld	a, xl
      0087B2 AB 30            [ 1]  256 	add	a, #0x30
      0087B4 81               [ 4]  257 	ret
      0087B5                        258 00102$:
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: else return nibble - 10 + 'A';
      0087B5 9F               [ 1]  260 	ld	a, xl
      0087B6 AB 37            [ 1]  261 	add	a, #0x37
                                    262 ;	../../my_STM8_libraries/stm8_UART.c: 72: }
      0087B8 81               [ 4]  263 	ret
                                    264 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t printHex_UART(uint8_t data)
                                    265 ;	-----------------------------------------
                                    266 ;	 function printHex_UART
                                    267 ;	-----------------------------------------
      0087B9                        268 _printHex_UART:
      0087B9 88               [ 1]  269 	push	a
                                    270 ;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t high = data >> 4;
      0087BA 97               [ 1]  271 	ld	xl, a
      0087BB 4E               [ 1]  272 	swap	a
      0087BC A4 0F            [ 1]  273 	and	a, #0x0f
      0087BE 41               [ 1]  274 	exg	a, xl
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: uint8_t low = data & 0x0F;
      0087BF A4 0F            [ 1]  276 	and	a, #0x0f
      0087C1 6B 01            [ 1]  277 	ld	(0x01, sp), a
                                    278 ;	../../my_STM8_libraries/stm8_UART.c: 78: if (write_UART(nibbleToHex(high)) == 0) return 0;
      0087C3 9F               [ 1]  279 	ld	a, xl
      0087C4 CD 87 AC         [ 4]  280 	call	_nibbleToHex
      0087C7 CD 87 0A         [ 4]  281 	call	_write_UART
      0087CA 4D               [ 1]  282 	tnz	a
      0087CB 26 03            [ 1]  283 	jrne	00102$
      0087CD 4F               [ 1]  284 	clr	a
      0087CE 20 0F            [ 2]  285 	jra	00105$
      0087D0                        286 00102$:
                                    287 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (write_UART(nibbleToHex(low)) == 0) return 0;
      0087D0 7B 01            [ 1]  288 	ld	a, (0x01, sp)
      0087D2 CD 87 AC         [ 4]  289 	call	_nibbleToHex
      0087D5 CD 87 0A         [ 4]  290 	call	_write_UART
      0087D8 4D               [ 1]  291 	tnz	a
      0087D9 26 02            [ 1]  292 	jrne	00104$
      0087DB 4F               [ 1]  293 	clr	a
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 80: return 1;
      0087DC C5                     295 	.byte 0xc5
      0087DD                        296 00104$:
      0087DD A6 01            [ 1]  297 	ld	a, #0x01
      0087DF                        298 00105$:
                                    299 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      0087DF 5B 01            [ 2]  300 	addw	sp, #1
      0087E1 81               [ 4]  301 	ret
                                    302 ;	../../my_STM8_libraries/stm8_UART.c: 82: uint8_t isDataReceived_UART(void)
                                    303 ;	-----------------------------------------
                                    304 ;	 function isDataReceived_UART
                                    305 ;	-----------------------------------------
      0087E2                        306 _isDataReceived_UART:
                                    307 ;	../../my_STM8_libraries/stm8_UART.c: 84: if ((UART1_SR & UART1_SR_RXNE) == 0) return 0;
      0087E2 72 0A 52 30 02   [ 2]  308 	btjt	0x5230, #5, 00102$
      0087E7 4F               [ 1]  309 	clr	a
      0087E8 81               [ 4]  310 	ret
      0087E9                        311 00102$:
                                    312 ;	../../my_STM8_libraries/stm8_UART.c: 85: return 1;
      0087E9 A6 01            [ 1]  313 	ld	a, #0x01
                                    314 ;	../../my_STM8_libraries/stm8_UART.c: 86: }
      0087EB 81               [ 4]  315 	ret
                                    316 ;	../../my_STM8_libraries/stm8_UART.c: 87: uint8_t getData_UART(void)
                                    317 ;	-----------------------------------------
                                    318 ;	 function getData_UART
                                    319 ;	-----------------------------------------
      0087EC                        320 _getData_UART:
                                    321 ;	../../my_STM8_libraries/stm8_UART.c: 89: return UART1_DR;
      0087EC C6 52 31         [ 1]  322 	ld	a, 0x5231
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 90: }
      0087EF 81               [ 4]  324 	ret
                                    325 	.area CODE
                                    326 	.area CONST
                                    327 	.area INITIALIZER
                                    328 	.area CABS (ABS)
