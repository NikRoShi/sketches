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
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
                                     56 ;	-----------------------------------------
                                     57 ;	 function init_UART
                                     58 ;	-----------------------------------------
      008529                         59 _init_UART:
      008529 88               [ 1]   60 	push	a
                                     61 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      00852A 72 16 50 C7      [ 1]   62 	bset	0x50c7, #3
                                     63 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      00852E 72 1A 50 11      [ 1]   64 	bset	0x5011, #5
                                     65 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      008532 72 1A 50 12      [ 1]   66 	bset	0x5012, #5
                                     67 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      008536 72 1A 50 13      [ 1]   68 	bset	0x5013, #5
                                     69 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      00853A 72 1D 50 11      [ 1]   70 	bres	0x5011, #6
                                     71 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      00853E 72 1D 50 12      [ 1]   72 	bres	0x5012, #6
                                     73 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      008542 1E 06            [ 2]   74 	ldw	x, (0x06, sp)
      008544 89               [ 2]   75 	pushw	x
      008545 1E 06            [ 2]   76 	ldw	x, (0x06, sp)
      008547 89               [ 2]   77 	pushw	x
      008548 4B 00            [ 1]   78 	push	#0x00
      00854A 4B 24            [ 1]   79 	push	#0x24
      00854C 4B F4            [ 1]   80 	push	#0xf4
      00854E 4B 00            [ 1]   81 	push	#0x00
      008550 CD 86 16         [ 4]   82 	call	__divulong
      008553 5B 08            [ 2]   83 	addw	sp, #8
                                     84 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      008555 9E               [ 1]   85 	ld	a, xh
      008556 90 5F            [ 1]   86 	clrw	y
      008558 A4 F0            [ 1]   87 	and	a, #240
      00855A 90 97            [ 1]   88 	ld	yl, a
      00855C 9F               [ 1]   89 	ld	a, xl
      00855D A4 0F            [ 1]   90 	and	a, #0x0f
      00855F 6B 01            [ 1]   91 	ld	(0x01, sp), a
      008561 90 9F            [ 1]   92 	ld	a, yl
      008563 1A 01            [ 1]   93 	or	a, (0x01, sp)
      008565 C7 52 33         [ 1]   94 	ld	0x5233, a
                                     95 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      008568 A6 10            [ 1]   96 	ld	a, #0x10
      00856A 62               [ 2]   97 	div	x, a
      00856B 9F               [ 1]   98 	ld	a, xl
      00856C C7 52 32         [ 1]   99 	ld	0x5232, a
                                    100 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      00856F C6 52 35         [ 1]  101 	ld	a, 0x5235
      008572 AA 0C            [ 1]  102 	or	a, #0x0c
      008574 C7 52 35         [ 1]  103 	ld	0x5235, a
                                    104 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      008577 1E 02            [ 2]  105 	ldw	x, (2, sp)
      008579 5B 07            [ 2]  106 	addw	sp, #7
      00857B FC               [ 2]  107 	jp	(x)
                                    108 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    109 ;	-----------------------------------------
                                    110 ;	 function sendByte_UART
                                    111 ;	-----------------------------------------
      00857C                        112 _sendByte_UART:
      00857C 88               [ 1]  113 	push	a
      00857D 6B 01            [ 1]  114 	ld	(0x01, sp), a
                                    115 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      00857F                        116 00101$:
      00857F C6 52 30         [ 1]  117 	ld	a, 0x5230
      008582 2A FB            [ 1]  118 	jrpl	00101$
                                    119 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      008584 AE 52 31         [ 2]  120 	ldw	x, #0x5231
      008587 7B 01            [ 1]  121 	ld	a, (0x01, sp)
      008589 F7               [ 1]  122 	ld	(x), a
                                    123 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      00858A 84               [ 1]  124 	pop	a
      00858B 81               [ 4]  125 	ret
                                    126 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    127 ;	-----------------------------------------
                                    128 ;	 function sendString_UART
                                    129 ;	-----------------------------------------
      00858C                        130 _sendString_UART:
                                    131 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      00858C                        132 00101$:
      00858C F6               [ 1]  133 	ld	a, (x)
      00858D 26 01            [ 1]  134 	jrne	00117$
      00858F 81               [ 4]  135 	ret
      008590                        136 00117$:
                                    137 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008590 89               [ 2]  138 	pushw	x
      008591 CD 85 7C         [ 4]  139 	call	_sendByte_UART
      008594 85               [ 2]  140 	popw	x
                                    141 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008595 5C               [ 1]  142 	incw	x
      008596 20 F4            [ 2]  143 	jra	00101$
                                    144 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      008598 81               [ 4]  145 	ret
                                    146 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function sendLine_UART
                                    149 ;	-----------------------------------------
      008599                        150 _sendLine_UART:
                                    151 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      008599 A6 0D            [ 1]  152 	ld	a, #0x0d
      00859B CD 85 7C         [ 4]  153 	call	_sendByte_UART
                                    154 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      00859E A6 0A            [ 1]  155 	ld	a, #0x0a
                                    156 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      0085A0 CC 85 7C         [ 2]  157 	jp	_sendByte_UART
                                    158 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    159 ;	-----------------------------------------
                                    160 ;	 function sendInt_UART
                                    161 ;	-----------------------------------------
      0085A3                        162 _sendInt_UART:
      0085A3 52 0F            [ 2]  163 	sub	sp, #15
                                    164 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      0085A5 1F 0D            [ 2]  165 	ldw	(0x0d, sp), x
      0085A7 26 07            [ 1]  166 	jrne	00113$
                                    167 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      0085A9 A6 30            [ 1]  168 	ld	a, #0x30
      0085AB 5B 0F            [ 2]  169 	addw	sp, #15
                                    170 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      0085AD CC 85 7C         [ 2]  171 	jp	_sendByte_UART
                                    172 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      0085B0                        173 00113$:
      0085B0 4F               [ 1]  174 	clr	a
      0085B1                        175 00103$:
      0085B1 1E 0D            [ 2]  176 	ldw	x, (0x0d, sp)
      0085B3 27 2F            [ 1]  177 	jreq	00115$
                                    178 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      0085B5 97               [ 1]  179 	ld	xl, a
      0085B6 88               [ 1]  180 	push	a
      0085B7 9F               [ 1]  181 	ld	a, xl
      0085B8 49               [ 1]  182 	rlc	a
      0085B9 4F               [ 1]  183 	clr	a
      0085BA A2 00            [ 1]  184 	sbc	a, #0x00
      0085BC 95               [ 1]  185 	ld	xh, a
      0085BD 84               [ 1]  186 	pop	a
      0085BE 4C               [ 1]  187 	inc	a
      0085BF 58               [ 2]  188 	sllw	x
      0085C0 1F 0B            [ 2]  189 	ldw	(0x0b, sp), x
      0085C2 96               [ 1]  190 	ldw	x, sp
      0085C3 5C               [ 1]  191 	incw	x
      0085C4 72 FB 0B         [ 2]  192 	addw	x, (0x0b, sp)
      0085C7 16 0D            [ 2]  193 	ldw	y, (0x0d, sp)
      0085C9 17 0B            [ 2]  194 	ldw	(0x0b, sp), y
      0085CB 89               [ 2]  195 	pushw	x
      0085CC 1E 0D            [ 2]  196 	ldw	x, (0x0d, sp)
      0085CE 90 AE 00 0A      [ 2]  197 	ldw	y, #0x000a
      0085D2 65               [ 2]  198 	divw	x, y
      0085D3 85               [ 2]  199 	popw	x
      0085D4 72 A9 00 30      [ 2]  200 	addw	y, #0x0030
      0085D8 FF               [ 2]  201 	ldw	(x), y
                                    202 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      0085D9 1E 0B            [ 2]  203 	ldw	x, (0x0b, sp)
      0085DB 90 AE 00 0A      [ 2]  204 	ldw	y, #0x000a
      0085DF 65               [ 2]  205 	divw	x, y
      0085E0 1F 0D            [ 2]  206 	ldw	(0x0d, sp), x
      0085E2 20 CD            [ 2]  207 	jra	00103$
                                    208 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      0085E4                        209 00115$:
      0085E4 6B 0F            [ 1]  210 	ld	(0x0f, sp), a
      0085E6                        211 00106$:
      0085E6 7B 0F            [ 1]  212 	ld	a, (0x0f, sp)
      0085E8 A1 00            [ 1]  213 	cp	a, #0x00
      0085EA 2D 19            [ 1]  214 	jrsle	00109$
                                    215 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0085EC 0A 0F            [ 1]  216 	dec	(0x0f, sp)
      0085EE 7B 0F            [ 1]  217 	ld	a, (0x0f, sp)
      0085F0 97               [ 1]  218 	ld	xl, a
      0085F1 49               [ 1]  219 	rlc	a
      0085F2 4F               [ 1]  220 	clr	a
      0085F3 A2 00            [ 1]  221 	sbc	a, #0x00
      0085F5 95               [ 1]  222 	ld	xh, a
      0085F6 58               [ 2]  223 	sllw	x
      0085F7 1F 0B            [ 2]  224 	ldw	(0x0b, sp), x
      0085F9 96               [ 1]  225 	ldw	x, sp
      0085FA 5C               [ 1]  226 	incw	x
      0085FB 72 FB 0B         [ 2]  227 	addw	x, (0x0b, sp)
      0085FE E6 01            [ 1]  228 	ld	a, (0x1, x)
      008600 CD 85 7C         [ 4]  229 	call	_sendByte_UART
      008603 20 E1            [ 2]  230 	jra	00106$
      008605                        231 00109$:
                                    232 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      008605 5B 0F            [ 2]  233 	addw	sp, #15
      008607 81               [ 4]  234 	ret
                                    235 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    236 ;	-----------------------------------------
                                    237 ;	 function available_UART
                                    238 ;	-----------------------------------------
      008608                        239 _available_UART:
                                    240 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      008608 72 0B 52 30 03   [ 2]  241 	btjf	0x5230, #5, 00102$
      00860D A6 01            [ 1]  242 	ld	a, #0x01
      00860F 81               [ 4]  243 	ret
      008610                        244 00102$:
                                    245 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      008610 4F               [ 1]  246 	clr	a
                                    247 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008611 81               [ 4]  248 	ret
                                    249 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    250 ;	-----------------------------------------
                                    251 ;	 function read_UART
                                    252 ;	-----------------------------------------
      008612                        253 _read_UART:
                                    254 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      008612 C6 52 31         [ 1]  255 	ld	a, 0x5231
                                    256 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      008615 81               [ 4]  257 	ret
                                    258 	.area CODE
                                    259 	.area CONST
                                    260 	.area INITIALIZER
                                    261 	.area CABS (ABS)
