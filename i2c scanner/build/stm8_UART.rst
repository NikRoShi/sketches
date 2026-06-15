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
      008502                         60 _init_UART:
      008502 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      008503 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008507 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      00850B 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      00850F 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      008513 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008517 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      00851B 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      00851D 89               [ 2]   76 	pushw	x
      00851E 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      008520 89               [ 2]   78 	pushw	x
      008521 4B 00            [ 1]   79 	push	#0x00
      008523 4B 24            [ 1]   80 	push	#0x24
      008525 4B F4            [ 1]   81 	push	#0xf4
      008527 4B 00            [ 1]   82 	push	#0x00
      008529 CD 86 26         [ 4]   83 	call	__divulong
      00852C 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      00852E 9E               [ 1]   86 	ld	a, xh
      00852F 90 5F            [ 1]   87 	clrw	y
      008531 A4 F0            [ 1]   88 	and	a, #240
      008533 90 97            [ 1]   89 	ld	yl, a
      008535 9F               [ 1]   90 	ld	a, xl
      008536 A4 0F            [ 1]   91 	and	a, #0x0f
      008538 6B 01            [ 1]   92 	ld	(0x01, sp), a
      00853A 90 9F            [ 1]   93 	ld	a, yl
      00853C 1A 01            [ 1]   94 	or	a, (0x01, sp)
      00853E C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      008541 A6 10            [ 1]   97 	ld	a, #0x10
      008543 62               [ 2]   98 	div	x, a
      008544 9F               [ 1]   99 	ld	a, xl
      008545 C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008548 C6 52 35         [ 1]  102 	ld	a, 0x5235
      00854B AA 0C            [ 1]  103 	or	a, #0x0c
      00854D C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      008550 1E 02            [ 2]  106 	ldw	x, (2, sp)
      008552 5B 07            [ 2]  107 	addw	sp, #7
      008554 FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      008555                        113 _sendByte_UART:
      008555 88               [ 1]  114 	push	a
      008556 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      008558                        117 00101$:
      008558 C6 52 30         [ 1]  118 	ld	a, 0x5230
      00855B 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      00855D AE 52 31         [ 2]  121 	ldw	x, #0x5231
      008560 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      008562 F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      008563 84               [ 1]  125 	pop	a
      008564 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      008565                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      008565                        133 00101$:
      008565 F6               [ 1]  134 	ld	a, (x)
      008566 26 01            [ 1]  135 	jrne	00117$
      008568 81               [ 4]  136 	ret
      008569                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008569 89               [ 2]  139 	pushw	x
      00856A CD 85 55         [ 4]  140 	call	_sendByte_UART
      00856D 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      00856E 5C               [ 1]  143 	incw	x
      00856F 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      008571 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      008572                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      008572 A6 0D            [ 1]  153 	ld	a, #0x0d
      008574 CD 85 55         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      008577 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      008579 CC 85 55         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      00857C                        163 _sendInt_UART:
      00857C 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      00857E 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      008580 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      008582 A6 30            [ 1]  169 	ld	a, #0x30
      008584 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      008586 CC 85 55         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      008589                        174 00113$:
      008589 4F               [ 1]  175 	clr	a
      00858A                        176 00103$:
      00858A 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      00858C 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      00858E 97               [ 1]  180 	ld	xl, a
      00858F 88               [ 1]  181 	push	a
      008590 9F               [ 1]  182 	ld	a, xl
      008591 49               [ 1]  183 	rlc	a
      008592 4F               [ 1]  184 	clr	a
      008593 A2 00            [ 1]  185 	sbc	a, #0x00
      008595 95               [ 1]  186 	ld	xh, a
      008596 84               [ 1]  187 	pop	a
      008597 4C               [ 1]  188 	inc	a
      008598 58               [ 2]  189 	sllw	x
      008599 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      00859B 96               [ 1]  191 	ldw	x, sp
      00859C 5C               [ 1]  192 	incw	x
      00859D 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      0085A0 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      0085A2 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      0085A4 89               [ 2]  196 	pushw	x
      0085A5 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      0085A7 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      0085AB 65               [ 2]  199 	divw	x, y
      0085AC 85               [ 2]  200 	popw	x
      0085AD 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      0085B1 FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      0085B2 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      0085B4 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      0085B8 65               [ 2]  206 	divw	x, y
      0085B9 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      0085BB 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      0085BD                        210 00115$:
      0085BD 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      0085BF                        212 00106$:
      0085BF 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      0085C1 A1 00            [ 1]  214 	cp	a, #0x00
      0085C3 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0085C5 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      0085C7 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      0085C9 97               [ 1]  219 	ld	xl, a
      0085CA 49               [ 1]  220 	rlc	a
      0085CB 4F               [ 1]  221 	clr	a
      0085CC A2 00            [ 1]  222 	sbc	a, #0x00
      0085CE 95               [ 1]  223 	ld	xh, a
      0085CF 58               [ 2]  224 	sllw	x
      0085D0 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      0085D2 96               [ 1]  226 	ldw	x, sp
      0085D3 5C               [ 1]  227 	incw	x
      0085D4 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      0085D7 E6 01            [ 1]  229 	ld	a, (0x1, x)
      0085D9 CD 85 55         [ 4]  230 	call	_sendByte_UART
      0085DC 20 E1            [ 2]  231 	jra	00106$
      0085DE                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      0085DE 5B 0F            [ 2]  234 	addw	sp, #15
      0085E0 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      0085E1                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0085E1 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      0085E6 A6 01            [ 1]  243 	ld	a, #0x01
      0085E8 81               [ 4]  244 	ret
      0085E9                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      0085E9 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      0085EA 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      0085EB                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0085EB C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      0085EE 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      0085EF                        263 _sendHex_UART:
      0085EF 88               [ 1]  264 	push	a
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t high = (num >> 4) & 0x0F;
      0085F0 97               [ 1]  266 	ld	xl, a
      0085F1 4E               [ 1]  267 	swap	a
      0085F2 A4 0F            [ 1]  268 	and	a, #15
                                    269 ;	../../my_STM8_libraries/stm8_UART.c: 74: uint8_t low = num & 0x0F;
      0085F4 88               [ 1]  270 	push	a
      0085F5 9F               [ 1]  271 	ld	a, xl
      0085F6 A4 0F            [ 1]  272 	and	a, #0x0f
      0085F8 6B 02            [ 1]  273 	ld	(0x02, sp), a
      0085FA 84               [ 1]  274 	pop	a
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: if (high < 10) sendByte_UART(high + '0');
      0085FB 97               [ 1]  276 	ld	xl, a
      0085FC A1 0A            [ 1]  277 	cp	a, #0x0a
      0085FE 24 08            [ 1]  278 	jrnc	00102$
      008600 9F               [ 1]  279 	ld	a, xl
      008601 AB 30            [ 1]  280 	add	a, #0x30
      008603 CD 85 55         [ 4]  281 	call	_sendByte_UART
      008606 20 06            [ 2]  282 	jra	00103$
      008608                        283 00102$:
                                    284 ;	../../my_STM8_libraries/stm8_UART.c: 77: else sendByte_UART(high - 10 + 'A');
      008608 9F               [ 1]  285 	ld	a, xl
      008609 AB 37            [ 1]  286 	add	a, #0x37
      00860B CD 85 55         [ 4]  287 	call	_sendByte_UART
      00860E                        288 00103$:
                                    289 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (low < 10) sendByte_UART(low + '0');
      00860E 7B 01            [ 1]  290 	ld	a, (0x01, sp)
      008610 88               [ 1]  291 	push	a
      008611 7B 02            [ 1]  292 	ld	a, (0x02, sp)
      008613 A1 0A            [ 1]  293 	cp	a, #0x0a
      008615 84               [ 1]  294 	pop	a
      008616 24 06            [ 1]  295 	jrnc	00105$
      008618 AB 30            [ 1]  296 	add	a, #0x30
      00861A 84               [ 1]  297 	pop	a
      00861B CC 85 55         [ 2]  298 	jp	_sendByte_UART
      00861E                        299 00105$:
                                    300 ;	../../my_STM8_libraries/stm8_UART.c: 80: else sendByte_UART(low - 10 + 'A');
      00861E AB 37            [ 1]  301 	add	a, #0x37
      008620 84               [ 1]  302 	pop	a
      008621 CC 85 55         [ 2]  303 	jp	_sendByte_UART
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      008624 84               [ 1]  305 	pop	a
      008625 81               [ 4]  306 	ret
                                    307 	.area CODE
                                    308 	.area CONST
                                    309 	.area INITIALIZER
                                    310 	.area CABS (ABS)
