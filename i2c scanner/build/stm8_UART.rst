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
      008506                         60 _init_UART:
      008506 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      008507 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      00850B 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      00850F 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      008513 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      008517 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      00851B 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      00851F 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      008521 89               [ 2]   76 	pushw	x
      008522 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      008524 89               [ 2]   78 	pushw	x
      008525 4B 00            [ 1]   79 	push	#0x00
      008527 4B 24            [ 1]   80 	push	#0x24
      008529 4B F4            [ 1]   81 	push	#0xf4
      00852B 4B 00            [ 1]   82 	push	#0x00
      00852D CD 86 60         [ 4]   83 	call	__divulong
      008530 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      008532 9E               [ 1]   86 	ld	a, xh
      008533 90 5F            [ 1]   87 	clrw	y
      008535 A4 F0            [ 1]   88 	and	a, #240
      008537 90 97            [ 1]   89 	ld	yl, a
      008539 9F               [ 1]   90 	ld	a, xl
      00853A A4 0F            [ 1]   91 	and	a, #0x0f
      00853C 6B 01            [ 1]   92 	ld	(0x01, sp), a
      00853E 90 9F            [ 1]   93 	ld	a, yl
      008540 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008542 C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      008545 A6 10            [ 1]   97 	ld	a, #0x10
      008547 62               [ 2]   98 	div	x, a
      008548 9F               [ 1]   99 	ld	a, xl
      008549 C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      00854C C6 52 35         [ 1]  102 	ld	a, 0x5235
      00854F AA 0C            [ 1]  103 	or	a, #0x0c
      008551 C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      008554 1E 02            [ 2]  106 	ldw	x, (2, sp)
      008556 5B 07            [ 2]  107 	addw	sp, #7
      008558 FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      008559                        113 _sendByte_UART:
      008559 88               [ 1]  114 	push	a
      00855A 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      00855C                        117 00101$:
      00855C C6 52 30         [ 1]  118 	ld	a, 0x5230
      00855F 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      008561 AE 52 31         [ 2]  121 	ldw	x, #0x5231
      008564 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      008566 F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      008567 84               [ 1]  125 	pop	a
      008568 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      008569                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      008569                        133 00101$:
      008569 F6               [ 1]  134 	ld	a, (x)
      00856A 26 01            [ 1]  135 	jrne	00117$
      00856C 81               [ 4]  136 	ret
      00856D                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      00856D 89               [ 2]  139 	pushw	x
      00856E CD 85 59         [ 4]  140 	call	_sendByte_UART
      008571 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008572 5C               [ 1]  143 	incw	x
      008573 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      008575 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      008576                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      008576 A6 0D            [ 1]  153 	ld	a, #0x0d
      008578 CD 85 59         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      00857B A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      00857D CC 85 59         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      008580                        163 _sendInt_UART:
      008580 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      008582 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      008584 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      008586 A6 30            [ 1]  169 	ld	a, #0x30
      008588 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      00858A CC 85 59         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      00858D                        174 00113$:
      00858D 4F               [ 1]  175 	clr	a
      00858E                        176 00103$:
      00858E 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      008590 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008592 97               [ 1]  180 	ld	xl, a
      008593 88               [ 1]  181 	push	a
      008594 9F               [ 1]  182 	ld	a, xl
      008595 49               [ 1]  183 	rlc	a
      008596 4F               [ 1]  184 	clr	a
      008597 A2 00            [ 1]  185 	sbc	a, #0x00
      008599 95               [ 1]  186 	ld	xh, a
      00859A 84               [ 1]  187 	pop	a
      00859B 4C               [ 1]  188 	inc	a
      00859C 58               [ 2]  189 	sllw	x
      00859D 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      00859F 96               [ 1]  191 	ldw	x, sp
      0085A0 5C               [ 1]  192 	incw	x
      0085A1 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      0085A4 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      0085A6 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      0085A8 89               [ 2]  196 	pushw	x
      0085A9 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      0085AB 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      0085AF 65               [ 2]  199 	divw	x, y
      0085B0 85               [ 2]  200 	popw	x
      0085B1 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      0085B5 FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      0085B6 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      0085B8 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      0085BC 65               [ 2]  206 	divw	x, y
      0085BD 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      0085BF 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      0085C1                        210 00115$:
      0085C1 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      0085C3                        212 00106$:
      0085C3 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      0085C5 A1 00            [ 1]  214 	cp	a, #0x00
      0085C7 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0085C9 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      0085CB 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      0085CD 97               [ 1]  219 	ld	xl, a
      0085CE 49               [ 1]  220 	rlc	a
      0085CF 4F               [ 1]  221 	clr	a
      0085D0 A2 00            [ 1]  222 	sbc	a, #0x00
      0085D2 95               [ 1]  223 	ld	xh, a
      0085D3 58               [ 2]  224 	sllw	x
      0085D4 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      0085D6 96               [ 1]  226 	ldw	x, sp
      0085D7 5C               [ 1]  227 	incw	x
      0085D8 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      0085DB E6 01            [ 1]  229 	ld	a, (0x1, x)
      0085DD CD 85 59         [ 4]  230 	call	_sendByte_UART
      0085E0 20 E1            [ 2]  231 	jra	00106$
      0085E2                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      0085E2 5B 0F            [ 2]  234 	addw	sp, #15
      0085E4 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      0085E5                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0085E5 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      0085EA A6 01            [ 1]  243 	ld	a, #0x01
      0085EC 81               [ 4]  244 	ret
      0085ED                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      0085ED 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      0085EE 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      0085EF                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0085EF C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      0085F2 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      0085F3                        263 _sendHex_UART:
      0085F3 52 14            [ 2]  264 	sub	sp, #20
      0085F5 6B 14            [ 1]  265 	ld	(0x14, sp), a
                                    266 ;	../../my_STM8_libraries/stm8_UART.c: 73: char hex[] = "0123456789ABCDEF";
      0085F7 A6 30            [ 1]  267 	ld	a, #0x30
      0085F9 6B 01            [ 1]  268 	ld	(0x01, sp), a
      0085FB A6 31            [ 1]  269 	ld	a, #0x31
      0085FD 6B 02            [ 1]  270 	ld	(0x02, sp), a
      0085FF A6 32            [ 1]  271 	ld	a, #0x32
      008601 6B 03            [ 1]  272 	ld	(0x03, sp), a
      008603 A6 33            [ 1]  273 	ld	a, #0x33
      008605 6B 04            [ 1]  274 	ld	(0x04, sp), a
      008607 A6 34            [ 1]  275 	ld	a, #0x34
      008609 6B 05            [ 1]  276 	ld	(0x05, sp), a
      00860B A6 35            [ 1]  277 	ld	a, #0x35
      00860D 6B 06            [ 1]  278 	ld	(0x06, sp), a
      00860F A6 36            [ 1]  279 	ld	a, #0x36
      008611 6B 07            [ 1]  280 	ld	(0x07, sp), a
      008613 A6 37            [ 1]  281 	ld	a, #0x37
      008615 6B 08            [ 1]  282 	ld	(0x08, sp), a
      008617 A6 38            [ 1]  283 	ld	a, #0x38
      008619 6B 09            [ 1]  284 	ld	(0x09, sp), a
      00861B A6 39            [ 1]  285 	ld	a, #0x39
      00861D 6B 0A            [ 1]  286 	ld	(0x0a, sp), a
      00861F A6 41            [ 1]  287 	ld	a, #0x41
      008621 6B 0B            [ 1]  288 	ld	(0x0b, sp), a
      008623 A6 42            [ 1]  289 	ld	a, #0x42
      008625 6B 0C            [ 1]  290 	ld	(0x0c, sp), a
      008627 A6 43            [ 1]  291 	ld	a, #0x43
      008629 6B 0D            [ 1]  292 	ld	(0x0d, sp), a
      00862B A6 44            [ 1]  293 	ld	a, #0x44
      00862D 6B 0E            [ 1]  294 	ld	(0x0e, sp), a
      00862F A6 45            [ 1]  295 	ld	a, #0x45
      008631 6B 0F            [ 1]  296 	ld	(0x0f, sp), a
      008633 A6 46            [ 1]  297 	ld	a, #0x46
      008635 6B 10            [ 1]  298 	ld	(0x10, sp), a
      008637 0F 11            [ 1]  299 	clr	(0x11, sp)
                                    300 ;	../../my_STM8_libraries/stm8_UART.c: 75: sendByte_UART(hex[num >> 4]);
      008639 7B 14            [ 1]  301 	ld	a, (0x14, sp)
      00863B 4E               [ 1]  302 	swap	a
      00863C A4 0F            [ 1]  303 	and	a, #0x0f
      00863E 96               [ 1]  304 	ldw	x, sp
      00863F 5C               [ 1]  305 	incw	x
      008640 89               [ 2]  306 	pushw	x
      008641 5F               [ 1]  307 	clrw	x
      008642 97               [ 1]  308 	ld	xl, a
      008643 72 FB 01         [ 2]  309 	addw	x, (1, sp)
      008646 5B 02            [ 2]  310 	addw	sp, #2
      008648 F6               [ 1]  311 	ld	a, (x)
      008649 CD 85 59         [ 4]  312 	call	_sendByte_UART
                                    313 ;	../../my_STM8_libraries/stm8_UART.c: 76: sendByte_UART(hex[num & 0x0F]);
      00864C 7B 14            [ 1]  314 	ld	a, (0x14, sp)
      00864E A4 0F            [ 1]  315 	and	a, #0x0f
      008650 6B 13            [ 1]  316 	ld	(0x13, sp), a
      008652 0F 12            [ 1]  317 	clr	(0x12, sp)
      008654 96               [ 1]  318 	ldw	x, sp
      008655 5C               [ 1]  319 	incw	x
      008656 72 FB 12         [ 2]  320 	addw	x, (0x12, sp)
      008659 F6               [ 1]  321 	ld	a, (x)
      00865A CD 85 59         [ 4]  322 	call	_sendByte_UART
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 77: }
      00865D 5B 14            [ 2]  324 	addw	sp, #20
      00865F 81               [ 4]  325 	ret
                                    326 	.area CODE
                                    327 	.area CONST
                                    328 	.area INITIALIZER
                                    329 	.area CABS (ABS)
