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
      00850C                         60 _init_UART:
      00850C 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      00850D 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008511 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      008515 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      008519 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      00851D 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008521 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      008525 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      008527 89               [ 2]   76 	pushw	x
      008528 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      00852A 89               [ 2]   78 	pushw	x
      00852B 4B 00            [ 1]   79 	push	#0x00
      00852D 4B 24            [ 1]   80 	push	#0x24
      00852F 4B F4            [ 1]   81 	push	#0xf4
      008531 4B 00            [ 1]   82 	push	#0x00
      008533 CD 86 66         [ 4]   83 	call	__divulong
      008536 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      008538 9E               [ 1]   86 	ld	a, xh
      008539 90 5F            [ 1]   87 	clrw	y
      00853B A4 F0            [ 1]   88 	and	a, #240
      00853D 90 97            [ 1]   89 	ld	yl, a
      00853F 9F               [ 1]   90 	ld	a, xl
      008540 A4 0F            [ 1]   91 	and	a, #0x0f
      008542 6B 01            [ 1]   92 	ld	(0x01, sp), a
      008544 90 9F            [ 1]   93 	ld	a, yl
      008546 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008548 C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      00854B A6 10            [ 1]   97 	ld	a, #0x10
      00854D 62               [ 2]   98 	div	x, a
      00854E 9F               [ 1]   99 	ld	a, xl
      00854F C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008552 C6 52 35         [ 1]  102 	ld	a, 0x5235
      008555 AA 0C            [ 1]  103 	or	a, #0x0c
      008557 C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      00855A 1E 02            [ 2]  106 	ldw	x, (2, sp)
      00855C 5B 07            [ 2]  107 	addw	sp, #7
      00855E FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      00855F                        113 _sendByte_UART:
      00855F 88               [ 1]  114 	push	a
      008560 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      008562                        117 00101$:
      008562 C6 52 30         [ 1]  118 	ld	a, 0x5230
      008565 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      008567 AE 52 31         [ 2]  121 	ldw	x, #0x5231
      00856A 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      00856C F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      00856D 84               [ 1]  125 	pop	a
      00856E 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      00856F                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      00856F                        133 00101$:
      00856F F6               [ 1]  134 	ld	a, (x)
      008570 26 01            [ 1]  135 	jrne	00117$
      008572 81               [ 4]  136 	ret
      008573                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008573 89               [ 2]  139 	pushw	x
      008574 CD 85 5F         [ 4]  140 	call	_sendByte_UART
      008577 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008578 5C               [ 1]  143 	incw	x
      008579 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      00857B 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      00857C                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      00857C A6 0D            [ 1]  153 	ld	a, #0x0d
      00857E CD 85 5F         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      008581 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      008583 CC 85 5F         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      008586                        163 _sendInt_UART:
      008586 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      008588 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      00858A 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      00858C A6 30            [ 1]  169 	ld	a, #0x30
      00858E 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      008590 CC 85 5F         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      008593                        174 00113$:
      008593 4F               [ 1]  175 	clr	a
      008594                        176 00103$:
      008594 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      008596 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008598 97               [ 1]  180 	ld	xl, a
      008599 88               [ 1]  181 	push	a
      00859A 9F               [ 1]  182 	ld	a, xl
      00859B 49               [ 1]  183 	rlc	a
      00859C 4F               [ 1]  184 	clr	a
      00859D A2 00            [ 1]  185 	sbc	a, #0x00
      00859F 95               [ 1]  186 	ld	xh, a
      0085A0 84               [ 1]  187 	pop	a
      0085A1 4C               [ 1]  188 	inc	a
      0085A2 58               [ 2]  189 	sllw	x
      0085A3 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      0085A5 96               [ 1]  191 	ldw	x, sp
      0085A6 5C               [ 1]  192 	incw	x
      0085A7 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      0085AA 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      0085AC 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      0085AE 89               [ 2]  196 	pushw	x
      0085AF 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      0085B1 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      0085B5 65               [ 2]  199 	divw	x, y
      0085B6 85               [ 2]  200 	popw	x
      0085B7 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      0085BB FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      0085BC 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      0085BE 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      0085C2 65               [ 2]  206 	divw	x, y
      0085C3 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      0085C5 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      0085C7                        210 00115$:
      0085C7 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      0085C9                        212 00106$:
      0085C9 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      0085CB A1 00            [ 1]  214 	cp	a, #0x00
      0085CD 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0085CF 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      0085D1 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      0085D3 97               [ 1]  219 	ld	xl, a
      0085D4 49               [ 1]  220 	rlc	a
      0085D5 4F               [ 1]  221 	clr	a
      0085D6 A2 00            [ 1]  222 	sbc	a, #0x00
      0085D8 95               [ 1]  223 	ld	xh, a
      0085D9 58               [ 2]  224 	sllw	x
      0085DA 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      0085DC 96               [ 1]  226 	ldw	x, sp
      0085DD 5C               [ 1]  227 	incw	x
      0085DE 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      0085E1 E6 01            [ 1]  229 	ld	a, (0x1, x)
      0085E3 CD 85 5F         [ 4]  230 	call	_sendByte_UART
      0085E6 20 E1            [ 2]  231 	jra	00106$
      0085E8                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      0085E8 5B 0F            [ 2]  234 	addw	sp, #15
      0085EA 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      0085EB                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0085EB 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      0085F0 A6 01            [ 1]  243 	ld	a, #0x01
      0085F2 81               [ 4]  244 	ret
      0085F3                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      0085F3 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      0085F4 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      0085F5                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0085F5 C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      0085F8 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      0085F9                        263 _sendHex_UART:
      0085F9 52 14            [ 2]  264 	sub	sp, #20
      0085FB 6B 14            [ 1]  265 	ld	(0x14, sp), a
                                    266 ;	../../my_STM8_libraries/stm8_UART.c: 73: char hex[] = "0123456789ABCDEF";
      0085FD A6 30            [ 1]  267 	ld	a, #0x30
      0085FF 6B 01            [ 1]  268 	ld	(0x01, sp), a
      008601 A6 31            [ 1]  269 	ld	a, #0x31
      008603 6B 02            [ 1]  270 	ld	(0x02, sp), a
      008605 A6 32            [ 1]  271 	ld	a, #0x32
      008607 6B 03            [ 1]  272 	ld	(0x03, sp), a
      008609 A6 33            [ 1]  273 	ld	a, #0x33
      00860B 6B 04            [ 1]  274 	ld	(0x04, sp), a
      00860D A6 34            [ 1]  275 	ld	a, #0x34
      00860F 6B 05            [ 1]  276 	ld	(0x05, sp), a
      008611 A6 35            [ 1]  277 	ld	a, #0x35
      008613 6B 06            [ 1]  278 	ld	(0x06, sp), a
      008615 A6 36            [ 1]  279 	ld	a, #0x36
      008617 6B 07            [ 1]  280 	ld	(0x07, sp), a
      008619 A6 37            [ 1]  281 	ld	a, #0x37
      00861B 6B 08            [ 1]  282 	ld	(0x08, sp), a
      00861D A6 38            [ 1]  283 	ld	a, #0x38
      00861F 6B 09            [ 1]  284 	ld	(0x09, sp), a
      008621 A6 39            [ 1]  285 	ld	a, #0x39
      008623 6B 0A            [ 1]  286 	ld	(0x0a, sp), a
      008625 A6 41            [ 1]  287 	ld	a, #0x41
      008627 6B 0B            [ 1]  288 	ld	(0x0b, sp), a
      008629 A6 42            [ 1]  289 	ld	a, #0x42
      00862B 6B 0C            [ 1]  290 	ld	(0x0c, sp), a
      00862D A6 43            [ 1]  291 	ld	a, #0x43
      00862F 6B 0D            [ 1]  292 	ld	(0x0d, sp), a
      008631 A6 44            [ 1]  293 	ld	a, #0x44
      008633 6B 0E            [ 1]  294 	ld	(0x0e, sp), a
      008635 A6 45            [ 1]  295 	ld	a, #0x45
      008637 6B 0F            [ 1]  296 	ld	(0x0f, sp), a
      008639 A6 46            [ 1]  297 	ld	a, #0x46
      00863B 6B 10            [ 1]  298 	ld	(0x10, sp), a
      00863D 0F 11            [ 1]  299 	clr	(0x11, sp)
                                    300 ;	../../my_STM8_libraries/stm8_UART.c: 75: sendByte_UART(hex[num >> 4]);
      00863F 7B 14            [ 1]  301 	ld	a, (0x14, sp)
      008641 4E               [ 1]  302 	swap	a
      008642 A4 0F            [ 1]  303 	and	a, #0x0f
      008644 96               [ 1]  304 	ldw	x, sp
      008645 5C               [ 1]  305 	incw	x
      008646 89               [ 2]  306 	pushw	x
      008647 5F               [ 1]  307 	clrw	x
      008648 97               [ 1]  308 	ld	xl, a
      008649 72 FB 01         [ 2]  309 	addw	x, (1, sp)
      00864C 5B 02            [ 2]  310 	addw	sp, #2
      00864E F6               [ 1]  311 	ld	a, (x)
      00864F CD 85 5F         [ 4]  312 	call	_sendByte_UART
                                    313 ;	../../my_STM8_libraries/stm8_UART.c: 76: sendByte_UART(hex[num & 0x0F]);
      008652 7B 14            [ 1]  314 	ld	a, (0x14, sp)
      008654 A4 0F            [ 1]  315 	and	a, #0x0f
      008656 6B 13            [ 1]  316 	ld	(0x13, sp), a
      008658 0F 12            [ 1]  317 	clr	(0x12, sp)
      00865A 96               [ 1]  318 	ldw	x, sp
      00865B 5C               [ 1]  319 	incw	x
      00865C 72 FB 12         [ 2]  320 	addw	x, (0x12, sp)
      00865F F6               [ 1]  321 	ld	a, (x)
      008660 CD 85 5F         [ 4]  322 	call	_sendByte_UART
                                    323 ;	../../my_STM8_libraries/stm8_UART.c: 77: }
      008663 5B 14            [ 2]  324 	addw	sp, #20
      008665 81               [ 4]  325 	ret
                                    326 	.area CODE
                                    327 	.area CONST
                                    328 	.area INITIALIZER
                                    329 	.area CABS (ABS)
