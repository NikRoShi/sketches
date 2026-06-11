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
      0085A0                         58 _init_UART:
      0085A0 88               [ 1]   59 	push	a
                                     60 ;	../../libs/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      0085A1 72 16 50 C7      [ 1]   61 	bset	0x50c7, #3
                                     62 ;	../../libs/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      0085A5 72 1A 50 11      [ 1]   63 	bset	0x5011, #5
                                     64 ;	../../libs/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      0085A9 72 1A 50 12      [ 1]   65 	bset	0x5012, #5
                                     66 ;	../../libs/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      0085AD 72 1A 50 13      [ 1]   67 	bset	0x5013, #5
                                     68 ;	../../libs/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      0085B1 72 1D 50 11      [ 1]   69 	bres	0x5011, #6
                                     70 ;	../../libs/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      0085B5 72 1D 50 12      [ 1]   71 	bres	0x5012, #6
                                     72 ;	../../libs/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      0085B9 1E 06            [ 2]   73 	ldw	x, (0x06, sp)
      0085BB 89               [ 2]   74 	pushw	x
      0085BC 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      0085BE 89               [ 2]   76 	pushw	x
      0085BF 4B 00            [ 1]   77 	push	#0x00
      0085C1 4B 24            [ 1]   78 	push	#0x24
      0085C3 4B F4            [ 1]   79 	push	#0xf4
      0085C5 4B 00            [ 1]   80 	push	#0x00
      0085C7 CD 86 89         [ 4]   81 	call	__divulong
      0085CA 5B 08            [ 2]   82 	addw	sp, #8
                                     83 ;	../../libs/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      0085CC 9E               [ 1]   84 	ld	a, xh
      0085CD 90 5F            [ 1]   85 	clrw	y
      0085CF A4 F0            [ 1]   86 	and	a, #240
      0085D1 6B 01            [ 1]   87 	ld	(0x01, sp), a
      0085D3 9F               [ 1]   88 	ld	a, xl
      0085D4 A4 0F            [ 1]   89 	and	a, #0x0f
      0085D6 1A 01            [ 1]   90 	or	a, (0x01, sp)
      0085D8 C7 52 33         [ 1]   91 	ld	0x5233, a
                                     92 ;	../../libs/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      0085DB A6 10            [ 1]   93 	ld	a, #0x10
      0085DD 62               [ 2]   94 	div	x, a
      0085DE 9F               [ 1]   95 	ld	a, xl
      0085DF C7 52 32         [ 1]   96 	ld	0x5232, a
                                     97 ;	../../libs/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      0085E2 C6 52 35         [ 1]   98 	ld	a, 0x5235
      0085E5 AA 0C            [ 1]   99 	or	a, #0x0c
      0085E7 C7 52 35         [ 1]  100 	ld	0x5235, a
                                    101 ;	../../libs/stm8_UART.c: 20: }
      0085EA 1E 02            [ 2]  102 	ldw	x, (2, sp)
      0085EC 5B 07            [ 2]  103 	addw	sp, #7
      0085EE FC               [ 2]  104 	jp	(x)
                                    105 ;	../../libs/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    106 ;	-----------------------------------------
                                    107 ;	 function sendByte_UART
                                    108 ;	-----------------------------------------
      0085EF                        109 _sendByte_UART:
      0085EF 88               [ 1]  110 	push	a
      0085F0 6B 01            [ 1]  111 	ld	(0x01, sp), a
                                    112 ;	../../libs/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      0085F2                        113 00101$:
      0085F2 C6 52 30         [ 1]  114 	ld	a, 0x5230
      0085F5 2A FB            [ 1]  115 	jrpl	00101$
                                    116 ;	../../libs/stm8_UART.c: 24: UART1_DR = byte;
      0085F7 AE 52 31         [ 2]  117 	ldw	x, #0x5231
      0085FA 7B 01            [ 1]  118 	ld	a, (0x01, sp)
      0085FC F7               [ 1]  119 	ld	(x), a
                                    120 ;	../../libs/stm8_UART.c: 25: }	
      0085FD 84               [ 1]  121 	pop	a
      0085FE 81               [ 4]  122 	ret
                                    123 ;	../../libs/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    124 ;	-----------------------------------------
                                    125 ;	 function sendString_UART
                                    126 ;	-----------------------------------------
      0085FF                        127 _sendString_UART:
                                    128 ;	../../libs/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      0085FF                        129 00101$:
      0085FF F6               [ 1]  130 	ld	a, (x)
      008600 26 01            [ 1]  131 	jrne	00121$
      008602 81               [ 4]  132 	ret
      008603                        133 00121$:
                                    134 ;	../../libs/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      008603 89               [ 2]  135 	pushw	x
      008604 CD 85 EF         [ 4]  136 	call	_sendByte_UART
      008607 85               [ 2]  137 	popw	x
                                    138 ;	../../libs/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      008608 5C               [ 1]  139 	incw	x
      008609 20 F4            [ 2]  140 	jra	00101$
                                    141 ;	../../libs/stm8_UART.c: 32: }
      00860B 81               [ 4]  142 	ret
                                    143 ;	../../libs/stm8_UART.c: 34: void sendLine_UART(void) {
                                    144 ;	-----------------------------------------
                                    145 ;	 function sendLine_UART
                                    146 ;	-----------------------------------------
      00860C                        147 _sendLine_UART:
                                    148 ;	../../libs/stm8_UART.c: 35: sendByte_UART('\r');
      00860C A6 0D            [ 1]  149 	ld	a, #0x0d
      00860E CD 85 EF         [ 4]  150 	call	_sendByte_UART
                                    151 ;	../../libs/stm8_UART.c: 36: sendByte_UART('\n');
      008611 A6 0A            [ 1]  152 	ld	a, #0x0a
                                    153 ;	../../libs/stm8_UART.c: 37: }
      008613 CC 85 EF         [ 2]  154 	jp	_sendByte_UART
                                    155 ;	../../libs/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    156 ;	-----------------------------------------
                                    157 ;	 function sendInt_UART
                                    158 ;	-----------------------------------------
      008616                        159 _sendInt_UART:
      008616 52 0F            [ 2]  160 	sub	sp, #15
                                    161 ;	../../libs/stm8_UART.c: 40: if (num == 0) {
      008618 1F 0D            [ 2]  162 	ldw	(0x0d, sp), x
      00861A 26 07            [ 1]  163 	jrne	00113$
                                    164 ;	../../libs/stm8_UART.c: 41: sendByte_UART('0');
      00861C A6 30            [ 1]  165 	ld	a, #0x30
      00861E 5B 0F            [ 2]  166 	addw	sp, #15
                                    167 ;	../../libs/stm8_UART.c: 42: return;
      008620 CC 85 EF         [ 2]  168 	jp	_sendByte_UART
                                    169 ;	../../libs/stm8_UART.c: 49: while (num > 0) {
      008623                        170 00113$:
      008623 4F               [ 1]  171 	clr	a
      008624                        172 00103$:
      008624 1E 0D            [ 2]  173 	ldw	x, (0x0d, sp)
      008626 27 2F            [ 1]  174 	jreq	00115$
                                    175 ;	../../libs/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      008628 97               [ 1]  176 	ld	xl, a
      008629 88               [ 1]  177 	push	a
      00862A 9F               [ 1]  178 	ld	a, xl
      00862B 49               [ 1]  179 	rlc	a
      00862C 4F               [ 1]  180 	clr	a
      00862D A2 00            [ 1]  181 	sbc	a, #0x00
      00862F 95               [ 1]  182 	ld	xh, a
      008630 84               [ 1]  183 	pop	a
      008631 4C               [ 1]  184 	inc	a
      008632 58               [ 2]  185 	sllw	x
      008633 1F 0B            [ 2]  186 	ldw	(0x0b, sp), x
      008635 96               [ 1]  187 	ldw	x, sp
      008636 5C               [ 1]  188 	incw	x
      008637 72 FB 0B         [ 2]  189 	addw	x, (0x0b, sp)
      00863A 16 0D            [ 2]  190 	ldw	y, (0x0d, sp)
      00863C 17 0B            [ 2]  191 	ldw	(0x0b, sp), y
      00863E 89               [ 2]  192 	pushw	x
      00863F 1E 0D            [ 2]  193 	ldw	x, (0x0d, sp)
      008641 90 AE 00 0A      [ 2]  194 	ldw	y, #0x000a
      008645 65               [ 2]  195 	divw	x, y
      008646 85               [ 2]  196 	popw	x
      008647 72 A9 00 30      [ 2]  197 	addw	y, #0x0030
      00864B FF               [ 2]  198 	ldw	(x), y
                                    199 ;	../../libs/stm8_UART.c: 51: num /= 10;
      00864C 1E 0B            [ 2]  200 	ldw	x, (0x0b, sp)
      00864E 90 AE 00 0A      [ 2]  201 	ldw	y, #0x000a
      008652 65               [ 2]  202 	divw	x, y
      008653 1F 0D            [ 2]  203 	ldw	(0x0d, sp), x
      008655 20 CD            [ 2]  204 	jra	00103$
                                    205 ;	../../libs/stm8_UART.c: 55: while (i > 0) {
      008657                        206 00115$:
      008657 6B 0F            [ 1]  207 	ld	(0x0f, sp), a
      008659                        208 00106$:
      008659 7B 0F            [ 1]  209 	ld	a, (0x0f, sp)
      00865B A1 00            [ 1]  210 	cp	a, #0x00
      00865D 2D 19            [ 1]  211 	jrsle	00109$
                                    212 ;	../../libs/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      00865F 0A 0F            [ 1]  213 	dec	(0x0f, sp)
      008661 7B 0F            [ 1]  214 	ld	a, (0x0f, sp)
      008663 97               [ 1]  215 	ld	xl, a
      008664 49               [ 1]  216 	rlc	a
      008665 4F               [ 1]  217 	clr	a
      008666 A2 00            [ 1]  218 	sbc	a, #0x00
      008668 95               [ 1]  219 	ld	xh, a
      008669 58               [ 2]  220 	sllw	x
      00866A 1F 0B            [ 2]  221 	ldw	(0x0b, sp), x
      00866C 96               [ 1]  222 	ldw	x, sp
      00866D 5C               [ 1]  223 	incw	x
      00866E 72 FB 0B         [ 2]  224 	addw	x, (0x0b, sp)
      008671 E6 01            [ 1]  225 	ld	a, (0x1, x)
      008673 CD 85 EF         [ 4]  226 	call	_sendByte_UART
      008676 20 E1            [ 2]  227 	jra	00106$
      008678                        228 00109$:
                                    229 ;	../../libs/stm8_UART.c: 58: }
      008678 5B 0F            [ 2]  230 	addw	sp, #15
      00867A 81               [ 4]  231 	ret
                                    232 ;	../../libs/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    233 ;	-----------------------------------------
                                    234 ;	 function available_UART
                                    235 ;	-----------------------------------------
      00867B                        236 _available_UART:
                                    237 ;	../../libs/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      00867B 72 0B 52 30 03   [ 2]  238 	btjf	0x5230, #5, 00102$
      008680 A6 01            [ 1]  239 	ld	a, #0x01
      008682 81               [ 4]  240 	ret
      008683                        241 00102$:
                                    242 ;	../../libs/stm8_UART.c: 63: return 0;
      008683 4F               [ 1]  243 	clr	a
                                    244 ;	../../libs/stm8_UART.c: 64: }
      008684 81               [ 4]  245 	ret
                                    246 ;	../../libs/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    247 ;	-----------------------------------------
                                    248 ;	 function read_UART
                                    249 ;	-----------------------------------------
      008685                        250 _read_UART:
                                    251 ;	../../libs/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      008685 C6 52 31         [ 1]  252 	ld	a, 0x5231
                                    253 ;	../../libs/stm8_UART.c: 69: }
      008688 81               [ 4]  254 	ret
                                    255 	.area CODE
                                    256 	.area CONST
                                    257 	.area INITIALIZER
                                    258 	.area CABS (ABS)
