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
                                     15 	.globl _available_UART
                                     16 	.globl _read_UART
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	../../libs/stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
                                     55 ;	-----------------------------------------
                                     56 ;	 function init_UART
                                     57 ;	-----------------------------------------
      0082E0                         58 _init_UART:
      0082E0 88               [ 1]   59 	push	a
                                     60 ;	../../libs/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      0082E1 72 16 50 C7      [ 1]   61 	bset	0x50c7, #3
                                     62 ;	../../libs/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      0082E5 72 1A 50 11      [ 1]   63 	bset	0x5011, #5
                                     64 ;	../../libs/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      0082E9 72 1A 50 12      [ 1]   65 	bset	0x5012, #5
                                     66 ;	../../libs/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      0082ED 72 1A 50 13      [ 1]   67 	bset	0x5013, #5
                                     68 ;	../../libs/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      0082F1 72 1D 50 11      [ 1]   69 	bres	0x5011, #6
                                     70 ;	../../libs/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      0082F5 72 1D 50 12      [ 1]   71 	bres	0x5012, #6
                                     72 ;	../../libs/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      0082F9 1E 06            [ 2]   73 	ldw	x, (0x06, sp)
      0082FB 89               [ 2]   74 	pushw	x
      0082FC 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      0082FE 89               [ 2]   76 	pushw	x
      0082FF 4B 00            [ 1]   77 	push	#0x00
      008301 4B 24            [ 1]   78 	push	#0x24
      008303 4B F4            [ 1]   79 	push	#0xf4
      008305 4B 00            [ 1]   80 	push	#0x00
      008307 CD 83 C9         [ 4]   81 	call	__divulong
      00830A 5B 08            [ 2]   82 	addw	sp, #8
                                     83 ;	../../libs/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      00830C 9E               [ 1]   84 	ld	a, xh
      00830D 90 5F            [ 1]   85 	clrw	y
      00830F A4 F0            [ 1]   86 	and	a, #240
      008311 6B 01            [ 1]   87 	ld	(0x01, sp), a
      008313 9F               [ 1]   88 	ld	a, xl
      008314 A4 0F            [ 1]   89 	and	a, #0x0f
      008316 1A 01            [ 1]   90 	or	a, (0x01, sp)
      008318 C7 52 33         [ 1]   91 	ld	0x5233, a
                                     92 ;	../../libs/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      00831B A6 10            [ 1]   93 	ld	a, #0x10
      00831D 62               [ 2]   94 	div	x, a
      00831E 9F               [ 1]   95 	ld	a, xl
      00831F C7 52 32         [ 1]   96 	ld	0x5232, a
                                     97 ;	../../libs/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008322 C6 52 35         [ 1]   98 	ld	a, 0x5235
      008325 AA 0C            [ 1]   99 	or	a, #0x0c
      008327 C7 52 35         [ 1]  100 	ld	0x5235, a
                                    101 ;	../../libs/stm8_UART.c: 20: }
      00832A 1E 02            [ 2]  102 	ldw	x, (2, sp)
      00832C 5B 07            [ 2]  103 	addw	sp, #7
      00832E FC               [ 2]  104 	jp	(x)
                                    105 ;	../../libs/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    106 ;	-----------------------------------------
                                    107 ;	 function sendByte_UART
                                    108 ;	-----------------------------------------
      00832F                        109 _sendByte_UART:
      00832F 88               [ 1]  110 	push	a
      008330 6B 01            [ 1]  111 	ld	(0x01, sp), a
                                    112 ;	../../libs/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      008332                        113 00101$:
      008332 C6 52 30         [ 1]  114 	ld	a, 0x5230
      008335 2A FB            [ 1]  115 	jrpl	00101$
                                    116 ;	../../libs/stm8_UART.c: 24: UART1_DR = byte;
      008337 AE 52 31         [ 2]  117 	ldw	x, #0x5231
      00833A 7B 01            [ 1]  118 	ld	a, (0x01, sp)
      00833C F7               [ 1]  119 	ld	(x), a
                                    120 ;	../../libs/stm8_UART.c: 25: }	
      00833D 84               [ 1]  121 	pop	a
      00833E 81               [ 4]  122 	ret
                                    123 ;	../../libs/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    124 ;	-----------------------------------------
                                    125 ;	 function sendString_UART
                                    126 ;	-----------------------------------------
      00833F                        127 _sendString_UART:
                                    128 ;	../../libs/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      00833F                        129 00101$:
      00833F F6               [ 1]  130 	ld	a, (x)
      008340 26 01            [ 1]  131 	jrne	00121$
      008342 81               [ 4]  132 	ret
      008343                        133 00121$:
                                    134 ;	../../libs/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008343 89               [ 2]  135 	pushw	x
      008344 CD 83 2F         [ 4]  136 	call	_sendByte_UART
      008347 85               [ 2]  137 	popw	x
                                    138 ;	../../libs/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008348 5C               [ 1]  139 	incw	x
      008349 20 F4            [ 2]  140 	jra	00101$
                                    141 ;	../../libs/stm8_UART.c: 32: }
      00834B 81               [ 4]  142 	ret
                                    143 ;	../../libs/stm8_UART.c: 34: void sendLine_UART(void) {
                                    144 ;	-----------------------------------------
                                    145 ;	 function sendLine_UART
                                    146 ;	-----------------------------------------
      00834C                        147 _sendLine_UART:
                                    148 ;	../../libs/stm8_UART.c: 35: sendByte_UART('\r');
      00834C A6 0D            [ 1]  149 	ld	a, #0x0d
      00834E CD 83 2F         [ 4]  150 	call	_sendByte_UART
                                    151 ;	../../libs/stm8_UART.c: 36: sendByte_UART('\n');
      008351 A6 0A            [ 1]  152 	ld	a, #0x0a
                                    153 ;	../../libs/stm8_UART.c: 37: }
      008353 CC 83 2F         [ 2]  154 	jp	_sendByte_UART
                                    155 ;	../../libs/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    156 ;	-----------------------------------------
                                    157 ;	 function sendInt_UART
                                    158 ;	-----------------------------------------
      008356                        159 _sendInt_UART:
      008356 52 0F            [ 2]  160 	sub	sp, #15
                                    161 ;	../../libs/stm8_UART.c: 40: if (num == 0) {
      008358 1F 0D            [ 2]  162 	ldw	(0x0d, sp), x
      00835A 26 07            [ 1]  163 	jrne	00113$
                                    164 ;	../../libs/stm8_UART.c: 41: sendByte_UART('0');
      00835C A6 30            [ 1]  165 	ld	a, #0x30
      00835E 5B 0F            [ 2]  166 	addw	sp, #15
                                    167 ;	../../libs/stm8_UART.c: 42: return;
      008360 CC 83 2F         [ 2]  168 	jp	_sendByte_UART
                                    169 ;	../../libs/stm8_UART.c: 49: while (num > 0) {
      008363                        170 00113$:
      008363 4F               [ 1]  171 	clr	a
      008364                        172 00103$:
      008364 1E 0D            [ 2]  173 	ldw	x, (0x0d, sp)
      008366 27 2F            [ 1]  174 	jreq	00115$
                                    175 ;	../../libs/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008368 97               [ 1]  176 	ld	xl, a
      008369 88               [ 1]  177 	push	a
      00836A 9F               [ 1]  178 	ld	a, xl
      00836B 49               [ 1]  179 	rlc	a
      00836C 4F               [ 1]  180 	clr	a
      00836D A2 00            [ 1]  181 	sbc	a, #0x00
      00836F 95               [ 1]  182 	ld	xh, a
      008370 84               [ 1]  183 	pop	a
      008371 4C               [ 1]  184 	inc	a
      008372 58               [ 2]  185 	sllw	x
      008373 1F 0B            [ 2]  186 	ldw	(0x0b, sp), x
      008375 96               [ 1]  187 	ldw	x, sp
      008376 5C               [ 1]  188 	incw	x
      008377 72 FB 0B         [ 2]  189 	addw	x, (0x0b, sp)
      00837A 16 0D            [ 2]  190 	ldw	y, (0x0d, sp)
      00837C 17 0B            [ 2]  191 	ldw	(0x0b, sp), y
      00837E 89               [ 2]  192 	pushw	x
      00837F 1E 0D            [ 2]  193 	ldw	x, (0x0d, sp)
      008381 90 AE 00 0A      [ 2]  194 	ldw	y, #0x000a
      008385 65               [ 2]  195 	divw	x, y
      008386 85               [ 2]  196 	popw	x
      008387 72 A9 00 30      [ 2]  197 	addw	y, #0x0030
      00838B FF               [ 2]  198 	ldw	(x), y
                                    199 ;	../../libs/stm8_UART.c: 51: num /= 10;
      00838C 1E 0B            [ 2]  200 	ldw	x, (0x0b, sp)
      00838E 90 AE 00 0A      [ 2]  201 	ldw	y, #0x000a
      008392 65               [ 2]  202 	divw	x, y
      008393 1F 0D            [ 2]  203 	ldw	(0x0d, sp), x
      008395 20 CD            [ 2]  204 	jra	00103$
                                    205 ;	../../libs/stm8_UART.c: 55: while (i > 0) {
      008397                        206 00115$:
      008397 6B 0F            [ 1]  207 	ld	(0x0f, sp), a
      008399                        208 00106$:
      008399 7B 0F            [ 1]  209 	ld	a, (0x0f, sp)
      00839B A1 00            [ 1]  210 	cp	a, #0x00
      00839D 2D 19            [ 1]  211 	jrsle	00109$
                                    212 ;	../../libs/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      00839F 0A 0F            [ 1]  213 	dec	(0x0f, sp)
      0083A1 7B 0F            [ 1]  214 	ld	a, (0x0f, sp)
      0083A3 97               [ 1]  215 	ld	xl, a
      0083A4 49               [ 1]  216 	rlc	a
      0083A5 4F               [ 1]  217 	clr	a
      0083A6 A2 00            [ 1]  218 	sbc	a, #0x00
      0083A8 95               [ 1]  219 	ld	xh, a
      0083A9 58               [ 2]  220 	sllw	x
      0083AA 1F 0B            [ 2]  221 	ldw	(0x0b, sp), x
      0083AC 96               [ 1]  222 	ldw	x, sp
      0083AD 5C               [ 1]  223 	incw	x
      0083AE 72 FB 0B         [ 2]  224 	addw	x, (0x0b, sp)
      0083B1 E6 01            [ 1]  225 	ld	a, (0x1, x)
      0083B3 CD 83 2F         [ 4]  226 	call	_sendByte_UART
      0083B6 20 E1            [ 2]  227 	jra	00106$
      0083B8                        228 00109$:
                                    229 ;	../../libs/stm8_UART.c: 58: }
      0083B8 5B 0F            [ 2]  230 	addw	sp, #15
      0083BA 81               [ 4]  231 	ret
                                    232 ;	../../libs/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    233 ;	-----------------------------------------
                                    234 ;	 function available_UART
                                    235 ;	-----------------------------------------
      0083BB                        236 _available_UART:
                                    237 ;	../../libs/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      0083BB 72 0B 52 30 03   [ 2]  238 	btjf	0x5230, #5, 00102$
      0083C0 A6 01            [ 1]  239 	ld	a, #0x01
      0083C2 81               [ 4]  240 	ret
      0083C3                        241 00102$:
                                    242 ;	../../libs/stm8_UART.c: 63: return 0;
      0083C3 4F               [ 1]  243 	clr	a
                                    244 ;	../../libs/stm8_UART.c: 64: }
      0083C4 81               [ 4]  245 	ret
                                    246 ;	../../libs/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    247 ;	-----------------------------------------
                                    248 ;	 function read_UART
                                    249 ;	-----------------------------------------
      0083C5                        250 _read_UART:
                                    251 ;	../../libs/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      0083C5 C6 52 31         [ 1]  252 	ld	a, 0x5231
                                    253 ;	../../libs/stm8_UART.c: 69: }
      0083C8 81               [ 4]  254 	ret
                                    255 	.area CODE
                                    256 	.area CONST
                                    257 	.area INITIALIZER
                                    258 	.area CABS (ABS)
