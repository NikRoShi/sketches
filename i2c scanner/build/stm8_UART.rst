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
      00855D                         60 _init_UART:
      00855D 88               [ 1]   61 	push	a
                                     62 ;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      00855E 72 16 50 C7      [ 1]   63 	bset	0x50c7, #3
                                     64 ;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008562 72 1A 50 11      [ 1]   65 	bset	0x5011, #5
                                     66 ;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      008566 72 1A 50 12      [ 1]   67 	bset	0x5012, #5
                                     68 ;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      00856A 72 1A 50 13      [ 1]   69 	bset	0x5013, #5
                                     70 ;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      00856E 72 1D 50 11      [ 1]   71 	bres	0x5011, #6
                                     72 ;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008572 72 1D 50 12      [ 1]   73 	bres	0x5012, #6
                                     74 ;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      008576 1E 06            [ 2]   75 	ldw	x, (0x06, sp)
      008578 89               [ 2]   76 	pushw	x
      008579 1E 06            [ 2]   77 	ldw	x, (0x06, sp)
      00857B 89               [ 2]   78 	pushw	x
      00857C 4B 00            [ 1]   79 	push	#0x00
      00857E 4B 24            [ 1]   80 	push	#0x24
      008580 4B F4            [ 1]   81 	push	#0xf4
      008582 4B 00            [ 1]   82 	push	#0x00
      008584 CD 86 90         [ 4]   83 	call	__divulong
      008587 5B 08            [ 2]   84 	addw	sp, #8
                                     85 ;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      008589 9E               [ 1]   86 	ld	a, xh
      00858A 90 5F            [ 1]   87 	clrw	y
      00858C A4 F0            [ 1]   88 	and	a, #240
      00858E 90 97            [ 1]   89 	ld	yl, a
      008590 9F               [ 1]   90 	ld	a, xl
      008591 A4 0F            [ 1]   91 	and	a, #0x0f
      008593 6B 01            [ 1]   92 	ld	(0x01, sp), a
      008595 90 9F            [ 1]   93 	ld	a, yl
      008597 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008599 C7 52 33         [ 1]   95 	ld	0x5233, a
                                     96 ;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      00859C A6 10            [ 1]   97 	ld	a, #0x10
      00859E 62               [ 2]   98 	div	x, a
      00859F 9F               [ 1]   99 	ld	a, xl
      0085A0 C7 52 32         [ 1]  100 	ld	0x5232, a
                                    101 ;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      0085A3 C6 52 35         [ 1]  102 	ld	a, 0x5235
      0085A6 AA 0C            [ 1]  103 	or	a, #0x0c
      0085A8 C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	../../my_STM8_libraries/stm8_UART.c: 20: }
      0085AB 1E 02            [ 2]  106 	ldw	x, (2, sp)
      0085AD 5B 07            [ 2]  107 	addw	sp, #7
      0085AF FC               [ 2]  108 	jp	(x)
                                    109 ;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function sendByte_UART
                                    112 ;	-----------------------------------------
      0085B0                        113 _sendByte_UART:
      0085B0 88               [ 1]  114 	push	a
      0085B1 6B 01            [ 1]  115 	ld	(0x01, sp), a
                                    116 ;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7)));
      0085B3                        117 00101$:
      0085B3 C6 52 30         [ 1]  118 	ld	a, 0x5230
      0085B6 2A FB            [ 1]  119 	jrpl	00101$
                                    120 ;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
      0085B8 AE 52 31         [ 2]  121 	ldw	x, #0x5231
      0085BB 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      0085BD F7               [ 1]  123 	ld	(x), a
                                    124 ;	../../my_STM8_libraries/stm8_UART.c: 25: }	
      0085BE 84               [ 1]  125 	pop	a
      0085BF 81               [ 4]  126 	ret
                                    127 ;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function sendString_UART
                                    130 ;	-----------------------------------------
      0085C0                        131 _sendString_UART:
                                    132 ;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      0085C0                        133 00101$:
      0085C0 F6               [ 1]  134 	ld	a, (x)
      0085C1 26 01            [ 1]  135 	jrne	00117$
      0085C3 81               [ 4]  136 	ret
      0085C4                        137 00117$:
                                    138 ;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      0085C4 89               [ 2]  139 	pushw	x
      0085C5 CD 85 B0         [ 4]  140 	call	_sendByte_UART
      0085C8 85               [ 2]  141 	popw	x
                                    142 ;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      0085C9 5C               [ 1]  143 	incw	x
      0085CA 20 F4            [ 2]  144 	jra	00101$
                                    145 ;	../../my_STM8_libraries/stm8_UART.c: 32: }
      0085CC 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
                                    148 ;	-----------------------------------------
                                    149 ;	 function sendLine_UART
                                    150 ;	-----------------------------------------
      0085CD                        151 _sendLine_UART:
                                    152 ;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
      0085CD A6 0D            [ 1]  153 	ld	a, #0x0d
      0085CF CD 85 B0         [ 4]  154 	call	_sendByte_UART
                                    155 ;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
      0085D2 A6 0A            [ 1]  156 	ld	a, #0x0a
                                    157 ;	../../my_STM8_libraries/stm8_UART.c: 37: }
      0085D4 CC 85 B0         [ 2]  158 	jp	_sendByte_UART
                                    159 ;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function sendInt_UART
                                    162 ;	-----------------------------------------
      0085D7                        163 _sendInt_UART:
      0085D7 52 0F            [ 2]  164 	sub	sp, #15
                                    165 ;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
      0085D9 1F 0D            [ 2]  166 	ldw	(0x0d, sp), x
      0085DB 26 07            [ 1]  167 	jrne	00113$
                                    168 ;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
      0085DD A6 30            [ 1]  169 	ld	a, #0x30
      0085DF 5B 0F            [ 2]  170 	addw	sp, #15
                                    171 ;	../../my_STM8_libraries/stm8_UART.c: 42: return;
      0085E1 CC 85 B0         [ 2]  172 	jp	_sendByte_UART
                                    173 ;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
      0085E4                        174 00113$:
      0085E4 4F               [ 1]  175 	clr	a
      0085E5                        176 00103$:
      0085E5 1E 0D            [ 2]  177 	ldw	x, (0x0d, sp)
      0085E7 27 2F            [ 1]  178 	jreq	00115$
                                    179 ;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      0085E9 97               [ 1]  180 	ld	xl, a
      0085EA 88               [ 1]  181 	push	a
      0085EB 9F               [ 1]  182 	ld	a, xl
      0085EC 49               [ 1]  183 	rlc	a
      0085ED 4F               [ 1]  184 	clr	a
      0085EE A2 00            [ 1]  185 	sbc	a, #0x00
      0085F0 95               [ 1]  186 	ld	xh, a
      0085F1 84               [ 1]  187 	pop	a
      0085F2 4C               [ 1]  188 	inc	a
      0085F3 58               [ 2]  189 	sllw	x
      0085F4 1F 0B            [ 2]  190 	ldw	(0x0b, sp), x
      0085F6 96               [ 1]  191 	ldw	x, sp
      0085F7 5C               [ 1]  192 	incw	x
      0085F8 72 FB 0B         [ 2]  193 	addw	x, (0x0b, sp)
      0085FB 16 0D            [ 2]  194 	ldw	y, (0x0d, sp)
      0085FD 17 0B            [ 2]  195 	ldw	(0x0b, sp), y
      0085FF 89               [ 2]  196 	pushw	x
      008600 1E 0D            [ 2]  197 	ldw	x, (0x0d, sp)
      008602 90 AE 00 0A      [ 2]  198 	ldw	y, #0x000a
      008606 65               [ 2]  199 	divw	x, y
      008607 85               [ 2]  200 	popw	x
      008608 72 A9 00 30      [ 2]  201 	addw	y, #0x0030
      00860C FF               [ 2]  202 	ldw	(x), y
                                    203 ;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
      00860D 1E 0B            [ 2]  204 	ldw	x, (0x0b, sp)
      00860F 90 AE 00 0A      [ 2]  205 	ldw	y, #0x000a
      008613 65               [ 2]  206 	divw	x, y
      008614 1F 0D            [ 2]  207 	ldw	(0x0d, sp), x
      008616 20 CD            [ 2]  208 	jra	00103$
                                    209 ;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
      008618                        210 00115$:
      008618 6B 0F            [ 1]  211 	ld	(0x0f, sp), a
      00861A                        212 00106$:
      00861A 7B 0F            [ 1]  213 	ld	a, (0x0f, sp)
      00861C A1 00            [ 1]  214 	cp	a, #0x00
      00861E 2D 19            [ 1]  215 	jrsle	00109$
                                    216 ;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
      008620 0A 0F            [ 1]  217 	dec	(0x0f, sp)
      008622 7B 0F            [ 1]  218 	ld	a, (0x0f, sp)
      008624 97               [ 1]  219 	ld	xl, a
      008625 49               [ 1]  220 	rlc	a
      008626 4F               [ 1]  221 	clr	a
      008627 A2 00            [ 1]  222 	sbc	a, #0x00
      008629 95               [ 1]  223 	ld	xh, a
      00862A 58               [ 2]  224 	sllw	x
      00862B 1F 0B            [ 2]  225 	ldw	(0x0b, sp), x
      00862D 96               [ 1]  226 	ldw	x, sp
      00862E 5C               [ 1]  227 	incw	x
      00862F 72 FB 0B         [ 2]  228 	addw	x, (0x0b, sp)
      008632 E6 01            [ 1]  229 	ld	a, (0x1, x)
      008634 CD 85 B0         [ 4]  230 	call	_sendByte_UART
      008637 20 E1            [ 2]  231 	jra	00106$
      008639                        232 00109$:
                                    233 ;	../../my_STM8_libraries/stm8_UART.c: 58: }
      008639 5B 0F            [ 2]  234 	addw	sp, #15
      00863B 81               [ 4]  235 	ret
                                    236 ;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
                                    237 ;	-----------------------------------------
                                    238 ;	 function available_UART
                                    239 ;	-----------------------------------------
      00863C                        240 _available_UART:
                                    241 ;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
      00863C 72 0B 52 30 03   [ 2]  242 	btjf	0x5230, #5, 00102$
      008641 A6 01            [ 1]  243 	ld	a, #0x01
      008643 81               [ 4]  244 	ret
      008644                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
      008644 4F               [ 1]  247 	clr	a
                                    248 ;	../../my_STM8_libraries/stm8_UART.c: 64: }
      008645 81               [ 4]  249 	ret
                                    250 ;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
                                    251 ;	-----------------------------------------
                                    252 ;	 function read_UART
                                    253 ;	-----------------------------------------
      008646                        254 _read_UART:
                                    255 ;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
      008646 C6 52 31         [ 1]  256 	ld	a, 0x5231
                                    257 ;	../../my_STM8_libraries/stm8_UART.c: 69: }
      008649 81               [ 4]  258 	ret
                                    259 ;	../../my_STM8_libraries/stm8_UART.c: 71: void sendHex_UART(uint8_t num)
                                    260 ;	-----------------------------------------
                                    261 ;	 function sendHex_UART
                                    262 ;	-----------------------------------------
      00864A                        263 _sendHex_UART:
      00864A 52 03            [ 2]  264 	sub	sp, #3
                                    265 ;	../../my_STM8_libraries/stm8_UART.c: 73: uint8_t high = num >> 4;
      00864C 97               [ 1]  266 	ld	xl, a
      00864D 4E               [ 1]  267 	swap	a
      00864E A4 0F            [ 1]  268 	and	a, #0x0f
                                    269 ;	../../my_STM8_libraries/stm8_UART.c: 74: uint8_t low = num &= ~0xF0;
      008650 88               [ 1]  270 	push	a
      008651 9F               [ 1]  271 	ld	a, xl
      008652 A4 0F            [ 1]  272 	and	a, #0x0f
      008654 6B 04            [ 1]  273 	ld	(0x04, sp), a
      008656 84               [ 1]  274 	pop	a
                                    275 ;	../../my_STM8_libraries/stm8_UART.c: 76: if (high < 10) sendByte_UART(high + '0');
      008657 6B 01            [ 1]  276 	ld	(0x01, sp), a
      008659 A1 0A            [ 1]  277 	cp	a, #0x0a
      00865B 24 07            [ 1]  278 	jrnc	00102$
      00865D 7B 01            [ 1]  279 	ld	a, (0x01, sp)
      00865F AB 30            [ 1]  280 	add	a, #0x30
      008661 CD 85 B0         [ 4]  281 	call	_sendByte_UART
      008664                        282 00102$:
                                    283 ;	../../my_STM8_libraries/stm8_UART.c: 77: if (low >= 10) sendByte_UART(high - 10 + 'A');
      008664 7B 03            [ 1]  284 	ld	a, (0x03, sp)
      008666 A1 0A            [ 1]  285 	cp	a, #0x0a
      008668 4F               [ 1]  286 	clr	a
      008669 49               [ 1]  287 	rlc	a
      00866A 6B 02            [ 1]  288 	ld	(0x02, sp), a
      00866C 26 07            [ 1]  289 	jrne	00104$
      00866E 7B 01            [ 1]  290 	ld	a, (0x01, sp)
      008670 AB 37            [ 1]  291 	add	a, #0x37
      008672 CD 85 B0         [ 4]  292 	call	_sendByte_UART
      008675                        293 00104$:
                                    294 ;	../../my_STM8_libraries/stm8_UART.c: 79: if (low < 10) sendByte_UART(low + '0');
      008675 7B 02            [ 1]  295 	ld	a, (0x02, sp)
      008677 27 07            [ 1]  296 	jreq	00106$
      008679 7B 03            [ 1]  297 	ld	a, (0x03, sp)
      00867B AB 30            [ 1]  298 	add	a, #0x30
      00867D CD 85 B0         [ 4]  299 	call	_sendByte_UART
      008680                        300 00106$:
                                    301 ;	../../my_STM8_libraries/stm8_UART.c: 80: if (low >= 10) sendByte_UART(low - 10 + 'A');
      008680 0D 02            [ 1]  302 	tnz	(0x02, sp)
      008682 26 09            [ 1]  303 	jrne	00109$
      008684 7B 03            [ 1]  304 	ld	a, (0x03, sp)
      008686 AB 37            [ 1]  305 	add	a, #0x37
      008688 5B 03            [ 2]  306 	addw	sp, #3
      00868A CC 85 B0         [ 2]  307 	jp	_sendByte_UART
      00868D                        308 00109$:
                                    309 ;	../../my_STM8_libraries/stm8_UART.c: 81: }
      00868D 5B 03            [ 2]  310 	addw	sp, #3
      00868F 81               [ 4]  311 	ret
                                    312 	.area CODE
                                    313 	.area CONST
                                    314 	.area INITIALIZER
                                    315 	.area CABS (ABS)
