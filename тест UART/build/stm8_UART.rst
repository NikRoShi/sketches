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
      0084AC                         60 _init_UART:
      0084AC 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      0084AD 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      0084B1 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      0084B5 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      0084B9 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      0084BD 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      0084C1 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      0084C5 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      0084C7 89               [ 2]   76 	pushw	x
      0084C8 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      0084CA 89               [ 2]   78 	pushw	x
      0084CB 4B 00            [ 1]   79 	push	#0x00
      0084CD 4B 24            [ 1]   80 	push	#0x24
      0084CF 4B F4            [ 1]   81 	push	#0xf4
      0084D1 4B 00            [ 1]   82 	push	#0x00
      0084D3 CD 85 D0         [ 4]   83 	call	__divulong
      0084D6 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      0084D8 9E               [ 1]   86 	ld	a, xh
      0084D9 90 5F            [ 1]   87 	clrw	y
      0084DB A4 F0            [ 1]   88 	and	a, #240
      0084DD 90 97            [ 1]   89 	ld	yl, a
      0084DF 9F               [ 1]   90 	ld	a, xl
      0084E0 A4 0F            [ 1]   91 	and	a, #0x0f
      0084E2 6B 01            [ 1]   92 	ld	(0x01, sp), a
      0084E4 90 9F            [ 1]   93 	ld	a, yl
      0084E6 1A 01            [ 1]   94 	or	a, (0x01, sp)
      0084E8 C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      0084EB A6 10            [ 1]   97 	ld	a, #0x10
      0084ED 62               [ 2]   98 	div	x, a
      0084EE 9F               [ 1]   99 	ld	a, xl
      0084EF C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      0084F2 C6 52 35         [ 1]  102 	ld	a, 0x5235
      0084F5 AA 0C            [ 1]  103 	or	a, #0x0c
      0084F7 C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      0084FA 1E 02            [ 2]  106 	ldw	x, (2, sp)
      0084FC 5B 07            [ 2]  107 	addw	sp, #7
      0084FE FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      0084FF                        113 _sendByte_UART:
      0084FF 88               [ 1]  114 	push	a
      008500 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      008502                        117 00101$:
      008502 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008505 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      008507 AE 52 31         [ 2]  121 	ldw	x, #0x5231
      00850A 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      00850C F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      00850D 84               [ 1]  125 	pop	a
      00850E 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      00850F                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      00850F                        133 00101$:
      00850F F6               [ 1]  134 	ld	a, (x)
      008510 26 01            [ 1]  135 	jrne	00117$
      008512 81               [ 4]  136 	ret
      008513                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008513 89               [ 2]  139 	pushw	x
      008514 CD 84 FF         [ 4]  140 	call	_sendByte_UART
      008517 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008518 5C               [ 1]  143 	incw	x
      008519 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      00851B 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      00851C                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      00851C A6 0D            [ 1]  153 	ld	a, #0x0d
      00851E CD 84 FF         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      008521 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      008523 CC 84 FF         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      008526                        163 _sendInt_UART:
      008526 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      008528 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      00852A 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      00852C A6 30            [ 1]  169 	ld	a, #0x30
      00852E 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      008530 CC 84 FF         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      008533                        174 00113$:
      008533 4F               [ 1]  175 	clr	a
      008534                        176 00103$:
      008534 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      008536 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008538 97               [ 1]  180 	ld	xl, a
      008539 88               [ 1]  181 	push	a
      00853A 9F               [ 1]  182 	ld	a, xl
      00853B 49               [ 1]  183 	rlc	a
      00853C 4F               [ 1]  184 	clr	a
      00853D A2 00            [ 1]  185 	sbc	a, #0x00
      00853F 95               [ 1]  186 	ld	xh, a
      008540 84               [ 1]  187 	pop	a
      008541 4C               [ 1]  188 	inc	a
      008542 58               [ 2]  189 	sllw	x
      008543 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      008545 96               [ 1]  191 	ldw	x, sp
      008546 5C               [ 1]  192 	incw	x
      008547 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      00854A 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      00854C 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      00854E 89               [ 2]  196 	pushw	x
      00854F 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      008551 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      008555 65               [ 2]  199 	divw	x, y
      008556 85               [ 2]  200 	popw	x
      008557 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      00855B FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      00855C 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      00855E 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      008562 65               [ 2]  206 	divw	x, y
      008563 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      008565 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      008567                        210 00115$:
      008567 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      008569                        212 00106$:
      008569 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      00856B A1 00            [ 1]  214 	cp	a, #0x00
      00856D 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      00856F 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      008571 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      008573 97               [ 1]  219 	ld	xl, a
      008574 49               [ 1]  220 	rlc	a
      008575 4F               [ 1]  221 	clr	a
      008576 A2 00            [ 1]  222 	sbc	a, #0x00
      008578 95               [ 1]  223 	ld	xh, a
      008579 58               [ 2]  224 	sllw	x
      00857A 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      00857C 96               [ 1]  226 	ldw	x, sp
      00857D 5C               [ 1]  227 	incw	x
      00857E 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      008581 E6 01            [ 1]  229 	ld	a, (0x1, x)
      008583 CD 84 FF         [ 4]  230 	call	_sendByte_UART
      008586 20 E1            [ 2]  231 	jra	00106$
      008588                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      008588 5B 0F            [ 2]  234 	addw	sp, #15
      00858A 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      00858B                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      00858B 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      008590 A6 01            [ 1]  243 	ld	a, #0x01
      008592 81               [ 4]  244 	ret
      008593                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      008593 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008594 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      008595                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      008595 C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      008598 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      008599                        263 _sendHex_UART:
      008599 88               [ 1]  264 	push	a
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t high = (num >> 4) & 0x0F;
      00859A 97               [ 1]  266 	ld	xl, a
      00859B 4E               [ 1]  267 	swap	a
      00859C A4 0F            [ 1]  268 	and	a, #15
                                    269 ;	../../my_STM8_libraries/stm8_UART.c: 74: uint8_t low = num & 0x0F;
      00859E 88               [ 1]  270 	push	a
      00859F 9F               [ 1]  271 	ld	a, xl
      0085A0 A4 0F            [ 1]  272 	and	a, #0x0f
      0085A2 6B 02            [ 1]  273 	ld	(0x02, sp), a
      0085A4 84               [ 1]  274 	pop	a
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: if (high <= 9) sendByte_UART(high + '0');
      0085A5 97               [ 1]  276 	ld	xl, a
      0085A6 A1 09            [ 1]  277 	cp	a, #0x09
      0085A8 22 08            [ 1]  278 	jrugt	00102$
      0085AA 9F               [ 1]  279 	ld	a, xl
      0085AB AB 30            [ 1]  280 	add	a, #0x30
      0085AD CD 84 FF         [ 4]  281 	call	_sendByte_UART
      0085B0 20 06            [ 2]  282 	jra	00103$
      0085B2                        283 00102$:
                                    284 ;	../../my_STM8_libraries/stm8_UART.c: 77: else sendByte_UART(high - 10 + 'A');
      0085B2 9F               [ 1]  285 	ld	a, xl
      0085B3 AB 37            [ 1]  286 	add	a, #0x37
      0085B5 CD 84 FF         [ 4]  287 	call	_sendByte_UART
      0085B8                        288 00103$:
                                    289 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (low <= 9) sendByte_UART(low + '0');
      0085B8 7B 01            [ 1]  290 	ld	a, (0x01, sp)
      0085BA 88               [ 1]  291 	push	a
      0085BB 7B 02            [ 1]  292 	ld	a, (0x02, sp)
      0085BD A1 09            [ 1]  293 	cp	a, #0x09
      0085BF 84               [ 1]  294 	pop	a
      0085C0 22 06            [ 1]  295 	jrugt	00105$
      0085C2 AB 30            [ 1]  296 	add	a, #0x30
      0085C4 84               [ 1]  297 	pop	a
      0085C5 CC 84 FF         [ 2]  298 	jp	_sendByte_UART
      0085C8                        299 00105$:
                                    300 ;	../../my_STM8_libraries/stm8_UART.c: 80: else sendByte_UART(low - 10 + 'A');
      0085C8 AB 37            [ 1]  301 	add	a, #0x37
      0085CA 84               [ 1]  302 	pop	a
      0085CB CC 84 FF         [ 2]  303 	jp	_sendByte_UART
                                    304 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      0085CE 84               [ 1]  305 	pop	a
      0085CF 81               [ 4]  306 	ret
                                    307 	.area CODE
                                    308 	.area CONST
                                    309 	.area INITIALIZER
                                    310 	.area CABS (ABS)
