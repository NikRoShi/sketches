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
      0084C2                         60 _init_UART:
      0084C2 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      0084C3 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      0084C7 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      0084CB 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      0084CF 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      0084D3 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      0084D7 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      0084DB 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      0084DD 89               [ 2]   76 	pushw	x
      0084DE 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      0084E0 89               [ 2]   78 	pushw	x
      0084E1 4B 00            [ 1]   79 	push	#0x00
      0084E3 4B 24            [ 1]   80 	push	#0x24
      0084E5 4B F4            [ 1]   81 	push	#0xf4
      0084E7 4B 00            [ 1]   82 	push	#0x00
      0084E9 CD 85 CE         [ 4]   83 	call	__divulong
      0084EC 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      0084EE 9E               [ 1]   86 	ld	a, xh
      0084EF 90 5F            [ 1]   87 	clrw	y
      0084F1 A4 F0            [ 1]   88 	and	a, #240
      0084F3 90 97            [ 1]   89 	ld	yl, a
      0084F5 9F               [ 1]   90 	ld	a, xl
      0084F6 A4 0F            [ 1]   91 	and	a, #0x0f
      0084F8 6B 01            [ 1]   92 	ld	(0x01, sp), a
      0084FA 90 9F            [ 1]   93 	ld	a, yl
      0084FC 1A 01            [ 1]   94 	or	a, (0x01, sp)
      0084FE C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      008501 A6 10            [ 1]   97 	ld	a, #0x10
      008503 62               [ 2]   98 	div	x, a
      008504 9F               [ 1]   99 	ld	a, xl
      008505 C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008508 C6 52 35         [ 1]  102 	ld	a, 0x5235
      00850B AA 0C            [ 1]  103 	or	a, #0x0c
      00850D C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      008510 1E 02            [ 2]  106 	ldw	x, (2, sp)
      008512 5B 07            [ 2]  107 	addw	sp, #7
      008514 FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      008515                        113 _sendByte_UART:
      008515 88               [ 1]  114 	push	a
      008516 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      008518                        117 00101$:
      008518 C6 52 30         [ 1]  118 	ld	a, 0x5230
      00851B 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      00851D AE 52 31         [ 2]  121 	ldw	x, #0x5231
      008520 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      008522 F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      008523 84               [ 1]  125 	pop	a
      008524 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      008525                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      008525                        133 00101$:
      008525 F6               [ 1]  134 	ld	a, (x)
      008526 26 01            [ 1]  135 	jrne	00117$
      008528 81               [ 4]  136 	ret
      008529                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008529 89               [ 2]  139 	pushw	x
      00852A CD 85 15         [ 4]  140 	call	_sendByte_UART
      00852D 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      00852E 5C               [ 1]  143 	incw	x
      00852F 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      008531 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      008532                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      008532 A6 0D            [ 1]  153 	ld	a, #0x0d
      008534 CD 85 15         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      008537 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      008539 CC 85 15         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      00853C                        163 _sendInt_UART:
      00853C 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      00853E 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      008540 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      008542 A6 30            [ 1]  169 	ld	a, #0x30
      008544 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      008546 CC 85 15         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      008549                        174 00113$:
      008549 4F               [ 1]  175 	clr	a
      00854A                        176 00103$:
      00854A 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      00854C 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      00854E 97               [ 1]  180 	ld	xl, a
      00854F 88               [ 1]  181 	push	a
      008550 9F               [ 1]  182 	ld	a, xl
      008551 49               [ 1]  183 	rlc	a
      008552 4F               [ 1]  184 	clr	a
      008553 A2 00            [ 1]  185 	sbc	a, #0x00
      008555 95               [ 1]  186 	ld	xh, a
      008556 84               [ 1]  187 	pop	a
      008557 4C               [ 1]  188 	inc	a
      008558 58               [ 2]  189 	sllw	x
      008559 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      00855B 96               [ 1]  191 	ldw	x, sp
      00855C 5C               [ 1]  192 	incw	x
      00855D 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      008560 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      008562 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      008564 89               [ 2]  196 	pushw	x
      008565 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      008567 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      00856B 65               [ 2]  199 	divw	x, y
      00856C 85               [ 2]  200 	popw	x
      00856D 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      008571 FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      008572 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      008574 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      008578 65               [ 2]  206 	divw	x, y
      008579 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      00857B 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      00857D                        210 00115$:
      00857D 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      00857F                        212 00106$:
      00857F 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      008581 A1 00            [ 1]  214 	cp	a, #0x00
      008583 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      008585 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      008587 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      008589 97               [ 1]  219 	ld	xl, a
      00858A 49               [ 1]  220 	rlc	a
      00858B 4F               [ 1]  221 	clr	a
      00858C A2 00            [ 1]  222 	sbc	a, #0x00
      00858E 95               [ 1]  223 	ld	xh, a
      00858F 58               [ 2]  224 	sllw	x
      008590 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      008592 96               [ 1]  226 	ldw	x, sp
      008593 5C               [ 1]  227 	incw	x
      008594 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      008597 E6 01            [ 1]  229 	ld	a, (0x1, x)
      008599 CD 85 15         [ 4]  230 	call	_sendByte_UART
      00859C 20 E1            [ 2]  231 	jra	00106$
      00859E                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      00859E 5B 0F            [ 2]  234 	addw	sp, #15
      0085A0 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      0085A1                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0085A1 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      0085A6 A6 01            [ 1]  243 	ld	a, #0x01
      0085A8 81               [ 4]  244 	ret
      0085A9                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      0085A9 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      0085AA 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      0085AB                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0085AB C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      0085AE 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      0085AF                        263 _sendHex_UART:
      0085AF 88               [ 1]  264 	push	a
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 75: sendByte_UART(hex[num >> 4]);
      0085B0 6B 01            [ 1]  266 	ld	(0x01, sp), a
      0085B2 4E               [ 1]  267 	swap	a
      0085B3 A4 0F            [ 1]  268 	and	a, #0x0f
      0085B5 5F               [ 1]  269 	clrw	x
      0085B6 97               [ 1]  270 	ld	xl, a
      0085B7 D6 80 31         [ 1]  271 	ld	a, (_sendHex_UART_hex_65536_30+0, x)
      0085BA CD 85 15         [ 4]  272 	call	_sendByte_UART
                                    273 ;	../../my_STM8_libraries/stm8_UART.c: 76: sendByte_UART(hex[num & 0x0F]);
      0085BD 7B 01            [ 1]  274 	ld	a, (0x01, sp)
      0085BF A4 0F            [ 1]  275 	and	a, #0x0f
      0085C1 97               [ 1]  276 	ld	xl, a
      0085C2 4F               [ 1]  277 	clr	a
      0085C3 95               [ 1]  278 	ld	xh, a
      0085C4 1C 80 31         [ 2]  279 	addw	x, #(_sendHex_UART_hex_65536_30+0)
      0085C7 F6               [ 1]  280 	ld	a, (x)
      0085C8 84               [ 1]  281 	pop	a
      0085C9 CC 85 15         [ 2]  282 	jp	_sendByte_UART
                                    283 ;	../../my_STM8_libraries/stm8_UART.c: 77: }
      0085CC 84               [ 1]  284 	pop	a
      0085CD 81               [ 4]  285 	ret
                                    286 	.area CODE
                                    287 	.area CONST
      008031                        288 _sendHex_UART_hex_65536_30:
      008031 30 31 32 33 34 35 36   289 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      008041 00                     290 	.db 0x00
                                    291 	.area INITIALIZER
                                    292 	.area CABS (ABS)
