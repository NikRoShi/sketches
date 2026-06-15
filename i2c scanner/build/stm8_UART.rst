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
                                     12 	.globl _sendByte_UART
                                     13 	.globl _sendString_UART
                                     14 	.globl _sendLine_UART
                                     15 	.globl _sendInt_UART
                                     16 	.globl _available_UART
                                     17 	.globl _read_UART
                                     18 	.globl _sendHex_UART
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
                                     56 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
                                     57 ;	-----------------------------------------
                                     58 ;	 function init_UART
                                     59 ;	-----------------------------------------
      008504                         60 _init_UART:
      008504 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      008505 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008509 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      00850D 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      008511 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      008515 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008519 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      00851D 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      00851F 89               [ 2]   76 	pushw	x
      008520 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      008522 89               [ 2]   78 	pushw	x
      008523 4B 00            [ 1]   79 	push	#0x00
      008525 4B 24            [ 1]   80 	push	#0x24
      008527 4B F4            [ 1]   81 	push	#0xf4
      008529 4B 00            [ 1]   82 	push	#0x00
      00852B CD 86 28         [ 4]   83 	call	__divulong
      00852E 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      008530 9E               [ 1]   86 	ld	a, xh
      008531 90 5F            [ 1]   87 	clrw	y
      008533 A4 F0            [ 1]   88 	and	a, #240
      008535 90 97            [ 1]   89 	ld	yl, a
      008537 9F               [ 1]   90 	ld	a, xl
      008538 A4 0F            [ 1]   91 	and	a, #0x0f
      00853A 6B 01            [ 1]   92 	ld	(0x01, sp), a
      00853C 90 9F            [ 1]   93 	ld	a, yl
      00853E 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008540 C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      008543 A6 10            [ 1]   97 	ld	a, #0x10
      008545 62               [ 2]   98 	div	x, a
      008546 9F               [ 1]   99 	ld	a, xl
      008547 C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      00854A C6 52 35         [ 1]  102 	ld	a, 0x5235
      00854D AA 0C            [ 1]  103 	or	a, #0x0c
      00854F C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      008552 1E 02            [ 2]  106 	ldw	x, (2, sp)
      008554 5B 07            [ 2]  107 	addw	sp, #7
      008556 FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      008557                        113 _sendByte_UART:
      008557 88               [ 1]  114 	push	a
      008558 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      00855A                        117 00101$:
      00855A C6 52 30         [ 1]  118 	ld	a, 0x5230
      00855D 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      00855F AE 52 31         [ 2]  121 	ldw	x, #0x5231
      008562 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      008564 F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      008565 84               [ 1]  125 	pop	a
      008566 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      008567                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      008567                        133 00101$:
      008567 F6               [ 1]  134 	ld	a, (x)
      008568 26 01            [ 1]  135 	jrne	00117$
      00856A 81               [ 4]  136 	ret
      00856B                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      00856B 89               [ 2]  139 	pushw	x
      00856C CD 85 57         [ 4]  140 	call	_sendByte_UART
      00856F 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008570 5C               [ 1]  143 	incw	x
      008571 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      008573 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      008574                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      008574 A6 0D            [ 1]  153 	ld	a, #0x0d
      008576 CD 85 57         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      008579 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      00857B CC 85 57         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      00857E                        163 _sendInt_UART:
      00857E 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      008580 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      008582 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      008584 A6 30            [ 1]  169 	ld	a, #0x30
      008586 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      008588 CC 85 57         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      00858B                        174 00113$:
      00858B 4F               [ 1]  175 	clr	a
      00858C                        176 00103$:
      00858C 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      00858E 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008590 97               [ 1]  180 	ld	xl, a
      008591 88               [ 1]  181 	push	a
      008592 9F               [ 1]  182 	ld	a, xl
      008593 49               [ 1]  183 	rlc	a
      008594 4F               [ 1]  184 	clr	a
      008595 A2 00            [ 1]  185 	sbc	a, #0x00
      008597 95               [ 1]  186 	ld	xh, a
      008598 84               [ 1]  187 	pop	a
      008599 4C               [ 1]  188 	inc	a
      00859A 58               [ 2]  189 	sllw	x
      00859B 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      00859D 96               [ 1]  191 	ldw	x, sp
      00859E 5C               [ 1]  192 	incw	x
      00859F 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      0085A2 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      0085A4 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      0085A6 89               [ 2]  196 	pushw	x
      0085A7 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      0085A9 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      0085AD 65               [ 2]  199 	divw	x, y
      0085AE 85               [ 2]  200 	popw	x
      0085AF 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      0085B3 FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      0085B4 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      0085B6 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      0085BA 65               [ 2]  206 	divw	x, y
      0085BB 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      0085BD 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      0085BF                        210 00115$:
      0085BF 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      0085C1                        212 00106$:
      0085C1 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      0085C3 A1 00            [ 1]  214 	cp	a, #0x00
      0085C5 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0085C7 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      0085C9 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      0085CB 97               [ 1]  219 	ld	xl, a
      0085CC 49               [ 1]  220 	rlc	a
      0085CD 4F               [ 1]  221 	clr	a
      0085CE A2 00            [ 1]  222 	sbc	a, #0x00
      0085D0 95               [ 1]  223 	ld	xh, a
      0085D1 58               [ 2]  224 	sllw	x
      0085D2 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      0085D4 96               [ 1]  226 	ldw	x, sp
      0085D5 5C               [ 1]  227 	incw	x
      0085D6 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      0085D9 E6 01            [ 1]  229 	ld	a, (0x1, x)
      0085DB CD 85 57         [ 4]  230 	call	_sendByte_UART
      0085DE 20 E1            [ 2]  231 	jra	00106$
      0085E0                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      0085E0 5B 0F            [ 2]  234 	addw	sp, #15
      0085E2 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      0085E3                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0085E3 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      0085E8 A6 01            [ 1]  243 	ld	a, #0x01
      0085EA 81               [ 4]  244 	ret
      0085EB                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      0085EB 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      0085EC 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      0085ED                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0085ED C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      0085F0 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      0085F1                        263 _sendHex_UART:
      0085F1 88               [ 1]  264 	push	a
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t high = (num >> 4) & 0x0F;
      0085F2 97               [ 1]  266 	ld	xl, a
      0085F3 4E               [ 1]  267 	swap	a
      0085F4 A4 0F            [ 1]  268 	and	a, #15
                                    269 ;	../../my_STM8_libraries/stm8_UART.c: 74: uint8_t low = num & 0x0F;
      0085F6 88               [ 1]  270 	push	a
      0085F7 9F               [ 1]  271 	ld	a, xl
      0085F8 A4 0F            [ 1]  272 	and	a, #0x0f
      0085FA 6B 02            [ 1]  273 	ld	(0x02, sp), a
      0085FC 84               [ 1]  274 	pop	a
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: if (high <= 9) sendByte_UART(high + '0');
      0085FD 97               [ 1]  276 	ld	xl, a
      0085FE A1 09            [ 1]  277 	cp	a, #0x09
      008600 22 08            [ 1]  278 	jrugt	00102$
      008602 9F               [ 1]  279 	ld	a, xl
      008603 AB 30            [ 1]  280 	add	a, #0x30
      008605 CD 85 57         [ 4]  281 	call	_sendByte_UART
      008608 20 06            [ 2]  282 	jra	00103$
      00860A                        283 00102$:
                                    284 ;	../../my_STM8_libraries/stm8_UART.c: 77: else sendByte_UART(high - 10 + 'A');
      00860A 9F               [ 1]  285 	ld	a, xl
      00860B AB 37            [ 1]  286 	add	a, #0x37
      00860D CD 85 57         [ 4]  287 	call	_sendByte_UART
      008610                        288 00103$:
                                    289 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (low <= 9) sendByte_UART(low + '0');
      008610 7B 01            [ 1]  290 	ld	a, (0x01, sp)
      008612 88               [ 1]  291 	push	a
      008613 7B 02            [ 1]  292 	ld	a, (0x02, sp)
      008615 A1 09            [ 1]  293 	cp	a, #0x09
      008617 84               [ 1]  294 	pop	a
      008618 22 06            [ 1]  295 	jrugt	00105$
      00861A AB 30            [ 1]  296 	add	a, #0x30
      00861C 84               [ 1]  297 	pop	a
      00861D CC 85 57         [ 2]  298 	jp	_sendByte_UART
      008620                        299 00105$:
                                    300 ;	../../my_STM8_libraries/stm8_UART.c: 80: else sendByte_UART(low - 10 + 'A');
      008620 AB 37            [ 1]  301 	add	a, #0x37
      008622 84               [ 1]  302 	pop	a
      008623 CC 85 57         [ 2]  303 	jp	_sendByte_UART
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008626 84               [ 1]  305 	pop	a
      008627 81               [ 4]  306 	ret
                                    307 	.area CODE
                                    308 	.area CONST
                                    309 	.area INITIALIZER
                                    310 	.area CABS (ABS)
