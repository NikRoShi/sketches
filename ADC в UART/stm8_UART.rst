                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_UART
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _init_UART
                                     11 	.globl _sendByte_UART
                                     12 	.globl _sendString_UART
                                     13 	.globl _sendLine_UART
                                     14 	.globl _sendInt_UART
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
                                     53 ;	-----------------------------------------
                                     54 ;	 function init_UART
                                     55 ;	-----------------------------------------
      008211                         56 _init_UART:
      008211 88               [ 1]   57 	push	a
                                     58 ;	stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      008212 72 16 50 C7      [ 1]   59 	bset	0x50c7, #3
                                     60 ;	stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008216 72 1A 50 11      [ 1]   61 	bset	0x5011, #5
                                     62 ;	stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      00821A 72 1A 50 12      [ 1]   63 	bset	0x5012, #5
                                     64 ;	stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      00821E 72 1A 50 13      [ 1]   65 	bset	0x5013, #5
                                     66 ;	stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      008222 72 1D 50 11      [ 1]   67 	bres	0x5011, #6
                                     68 ;	stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008226 72 1D 50 12      [ 1]   69 	bres	0x5012, #6
                                     70 ;	stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      00822A 1E 06            [ 2]   71 	ldw	x, (0x06, sp)
      00822C 89               [ 2]   72 	pushw	x
      00822D 1E 06            [ 2]   73 	ldw	x, (0x06, sp)
      00822F 89               [ 2]   74 	pushw	x
      008230 4B 00            [ 1]   75 	push	#0x00
      008232 4B 24            [ 1]   76 	push	#0x24
      008234 4B F4            [ 1]   77 	push	#0xf4
      008236 4B 00            [ 1]   78 	push	#0x00
      008238 CD 82 EC         [ 4]   79 	call	__divulong
      00823B 5B 08            [ 2]   80 	addw	sp, #8
                                     81 ;	stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      00823D 9E               [ 1]   82 	ld	a, xh
      00823E 90 5F            [ 1]   83 	clrw	y
      008240 A4 F0            [ 1]   84 	and	a, #240
      008242 6B 01            [ 1]   85 	ld	(0x01, sp), a
      008244 9F               [ 1]   86 	ld	a, xl
      008245 A4 0F            [ 1]   87 	and	a, #0x0f
      008247 1A 01            [ 1]   88 	or	a, (0x01, sp)
      008249 C7 52 33         [ 1]   89 	ld	0x5233, a
                                     90 ;	stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      00824C A6 10            [ 1]   91 	ld	a, #0x10
      00824E 62               [ 2]   92 	div	x, a
      00824F 9F               [ 1]   93 	ld	a, xl
      008250 C7 52 32         [ 1]   94 	ld	0x5232, a
                                     95 ;	stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008253 C6 52 35         [ 1]   96 	ld	a, 0x5235
      008256 AA 0C            [ 1]   97 	or	a, #0x0c
      008258 C7 52 35         [ 1]   98 	ld	0x5235, a
                                     99 ;	stm8_UART.c: 20: }
      00825B 1E 02            [ 2]  100 	ldw	x, (2, sp)
      00825D 5B 07            [ 2]  101 	addw	sp, #7
      00825F FC               [ 2]  102 	jp	(x)
                                    103 ;	stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    104 ;	-----------------------------------------
                                    105 ;	 function sendByte_UART
                                    106 ;	-----------------------------------------
      008260                        107 _sendByte_UART:
      008260 88               [ 1]  108 	push	a
      008261 6B 01            [ 1]  109 	ld	(0x01, sp), a
                                    110 ;	stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      008263                        111 00101$:
      008263 C6 52 30         [ 1]  112 	ld	a, 0x5230
      008266 2A FB            [ 1]  113 	jrpl	00101$
                                    114 ;	stm8_UART.c: 24: UART1_DR = byte;
      008268 AE 52 31         [ 2]  115 	ldw	x, #0x5231
      00826B 7B 01            [ 1]  116 	ld	a, (0x01, sp)
      00826D F7               [ 1]  117 	ld	(x), a
                                    118 ;	stm8_UART.c: 25: }	
      00826E 84               [ 1]  119 	pop	a
      00826F 81               [ 4]  120 	ret
                                    121 ;	stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    122 ;	-----------------------------------------
                                    123 ;	 function sendString_UART
                                    124 ;	-----------------------------------------
      008270                        125 _sendString_UART:
                                    126 ;	stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      008270                        127 00101$:
      008270 F6               [ 1]  128 	ld	a, (x)
      008271 26 01            [ 1]  129 	jrne	00121$
      008273 81               [ 4]  130 	ret
      008274                        131 00121$:
                                    132 ;	stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008274 89               [ 2]  133 	pushw	x
      008275 CD 82 60         [ 4]  134 	call	_sendByte_UART
      008278 85               [ 2]  135 	popw	x
                                    136 ;	stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008279 5C               [ 1]  137 	incw	x
      00827A 20 F4            [ 2]  138 	jra	00101$
                                    139 ;	stm8_UART.c: 32: }
      00827C 81               [ 4]  140 	ret
                                    141 ;	stm8_UART.c: 34: void sendLine_UART(void) {
                                    142 ;	-----------------------------------------
                                    143 ;	 function sendLine_UART
                                    144 ;	-----------------------------------------
      00827D                        145 _sendLine_UART:
                                    146 ;	stm8_UART.c: 35: sendByte_UART('\r');
      00827D A6 0D            [ 1]  147 	ld	a, #0x0d
      00827F CD 82 60         [ 4]  148 	call	_sendByte_UART
                                    149 ;	stm8_UART.c: 36: sendByte_UART('\n');
      008282 A6 0A            [ 1]  150 	ld	a, #0x0a
                                    151 ;	stm8_UART.c: 37: }
      008284 CC 82 60         [ 2]  152 	jp	_sendByte_UART
                                    153 ;	stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function sendInt_UART
                                    156 ;	-----------------------------------------
      008287                        157 _sendInt_UART:
      008287 52 0F            [ 2]  158 	sub	sp, #15
                                    159 ;	stm8_UART.c: 40: if (num == 0) {
      008289 1F 0D            [ 2]  160 	ldw	(0x0d, sp), x
      00828B 26 07            [ 1]  161 	jrne	00113$
                                    162 ;	stm8_UART.c: 41: sendByte_UART('0');
      00828D A6 30            [ 1]  163 	ld	a, #0x30
      00828F 5B 0F            [ 2]  164 	addw	sp, #15
                                    165 ;	stm8_UART.c: 42: return;
      008291 CC 82 60         [ 2]  166 	jp	_sendByte_UART
                                    167 ;	stm8_UART.c: 49: while (num > 0) {
      008294                        168 00113$:
      008294 4F               [ 1]  169 	clr	a
      008295                        170 00103$:
      008295 1E 0D            [ 2]  171 	ldw	x, (0x0d, sp)
      008297 27 2F            [ 1]  172 	jreq	00115$
                                    173 ;	stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008299 97               [ 1]  174 	ld	xl, a
      00829A 88               [ 1]  175 	push	a
      00829B 9F               [ 1]  176 	ld	a, xl
      00829C 49               [ 1]  177 	rlc	a
      00829D 4F               [ 1]  178 	clr	a
      00829E A2 00            [ 1]  179 	sbc	a, #0x00
      0082A0 95               [ 1]  180 	ld	xh, a
      0082A1 84               [ 1]  181 	pop	a
      0082A2 4C               [ 1]  182 	inc	a
      0082A3 58               [ 2]  183 	sllw	x
      0082A4 1F 0B            [ 2]  184 	ldw	(0x0b, sp), x
      0082A6 96               [ 1]  185 	ldw	x, sp
      0082A7 5C               [ 1]  186 	incw	x
      0082A8 72 FB 0B         [ 2]  187 	addw	x, (0x0b, sp)
      0082AB 16 0D            [ 2]  188 	ldw	y, (0x0d, sp)
      0082AD 17 0B            [ 2]  189 	ldw	(0x0b, sp), y
      0082AF 89               [ 2]  190 	pushw	x
      0082B0 1E 0D            [ 2]  191 	ldw	x, (0x0d, sp)
      0082B2 90 AE 00 0A      [ 2]  192 	ldw	y, #0x000a
      0082B6 65               [ 2]  193 	divw	x, y
      0082B7 85               [ 2]  194 	popw	x
      0082B8 72 A9 00 30      [ 2]  195 	addw	y, #0x0030
      0082BC FF               [ 2]  196 	ldw	(x), y
                                    197 ;	stm8_UART.c: 51: num /= 10;
      0082BD 1E 0B            [ 2]  198 	ldw	x, (0x0b, sp)
      0082BF 90 AE 00 0A      [ 2]  199 	ldw	y, #0x000a
      0082C3 65               [ 2]  200 	divw	x, y
      0082C4 1F 0D            [ 2]  201 	ldw	(0x0d, sp), x
      0082C6 20 CD            [ 2]  202 	jra	00103$
                                    203 ;	stm8_UART.c: 55: while (i > 0) {
      0082C8                        204 00115$:
      0082C8 6B 0F            [ 1]  205 	ld	(0x0f, sp), a
      0082CA                        206 00106$:
      0082CA 7B 0F            [ 1]  207 	ld	a, (0x0f, sp)
      0082CC A1 00            [ 1]  208 	cp	a, #0x00
      0082CE 2D 19            [ 1]  209 	jrsle	00109$
                                    210 ;	stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0082D0 0A 0F            [ 1]  211 	dec	(0x0f, sp)
      0082D2 7B 0F            [ 1]  212 	ld	a, (0x0f, sp)
      0082D4 97               [ 1]  213 	ld	xl, a
      0082D5 49               [ 1]  214 	rlc	a
      0082D6 4F               [ 1]  215 	clr	a
      0082D7 A2 00            [ 1]  216 	sbc	a, #0x00
      0082D9 95               [ 1]  217 	ld	xh, a
      0082DA 58               [ 2]  218 	sllw	x
      0082DB 1F 0B            [ 2]  219 	ldw	(0x0b, sp), x
      0082DD 96               [ 1]  220 	ldw	x, sp
      0082DE 5C               [ 1]  221 	incw	x
      0082DF 72 FB 0B         [ 2]  222 	addw	x, (0x0b, sp)
      0082E2 E6 01            [ 1]  223 	ld	a, (0x1, x)
      0082E4 CD 82 60         [ 4]  224 	call	_sendByte_UART
      0082E7 20 E1            [ 2]  225 	jra	00106$
      0082E9                        226 00109$:
                                    227 ;	stm8_UART.c: 58: }
      0082E9 5B 0F            [ 2]  228 	addw	sp, #15
      0082EB 81               [ 4]  229 	ret
                                    230 	.area CODE
                                    231 	.area CONST
                                    232 	.area INITIALIZER
                                    233 	.area CABS (ABS)
