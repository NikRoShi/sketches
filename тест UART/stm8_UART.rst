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
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
                                     53 ;	-----------------------------------------
                                     54 ;	 function init_UART
                                     55 ;	-----------------------------------------
      008142                         56 _init_UART:
      008142 88               [ 1]   57 	push	a
                                     58 ;	stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
      008143 72 16 50 C7      [ 1]   59 	bset	0x50c7, #3
                                     60 ;	stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
      008147 72 1A 50 11      [ 1]   61 	bset	0x5011, #5
                                     62 ;	stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
      00814B 72 1A 50 12      [ 1]   63 	bset	0x5012, #5
                                     64 ;	stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
      00814F 72 1A 50 13      [ 1]   65 	bset	0x5013, #5
                                     66 ;	stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
      008153 72 1D 50 11      [ 1]   67 	bres	0x5011, #6
                                     68 ;	stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
      008157 72 1D 50 12      [ 1]   69 	bres	0x5012, #6
                                     70 ;	stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
      00815B 1E 06            [ 2]   71 	ldw	x, (0x06, sp)
      00815D 89               [ 2]   72 	pushw	x
      00815E 1E 06            [ 2]   73 	ldw	x, (0x06, sp)
      008160 89               [ 2]   74 	pushw	x
      008161 4B 00            [ 1]   75 	push	#0x00
      008163 4B 24            [ 1]   76 	push	#0x24
      008165 4B F4            [ 1]   77 	push	#0xf4
      008167 4B 00            [ 1]   78 	push	#0x00
      008169 CD 82 11         [ 4]   79 	call	__divulong
      00816C 5B 08            [ 2]   80 	addw	sp, #8
                                     81 ;	stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
      00816E 9E               [ 1]   82 	ld	a, xh
      00816F 90 5F            [ 1]   83 	clrw	y
      008171 A4 F0            [ 1]   84 	and	a, #240
      008173 6B 01            [ 1]   85 	ld	(0x01, sp), a
      008175 9F               [ 1]   86 	ld	a, xl
      008176 A4 0F            [ 1]   87 	and	a, #0x0f
      008178 1A 01            [ 1]   88 	or	a, (0x01, sp)
      00817A C7 52 33         [ 1]   89 	ld	0x5233, a
                                     90 ;	stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
      00817D A6 10            [ 1]   91 	ld	a, #0x10
      00817F 62               [ 2]   92 	div	x, a
      008180 9F               [ 1]   93 	ld	a, xl
      008181 C7 52 32         [ 1]   94 	ld	0x5232, a
                                     95 ;	stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
      008184 C6 52 35         [ 1]   96 	ld	a, 0x5235
      008187 AA 0C            [ 1]   97 	or	a, #0x0c
      008189 C7 52 35         [ 1]   98 	ld	0x5235, a
                                     99 ;	stm8_UART.c: 20: }
      00818C 1E 02            [ 2]  100 	ldw	x, (2, sp)
      00818E 5B 07            [ 2]  101 	addw	sp, #7
      008190 FC               [ 2]  102 	jp	(x)
                                    103 ;	stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
                                    104 ;	-----------------------------------------
                                    105 ;	 function sendByte_UART
                                    106 ;	-----------------------------------------
      008191                        107 _sendByte_UART:
      008191 88               [ 1]  108 	push	a
      008192 6B 01            [ 1]  109 	ld	(0x01, sp), a
                                    110 ;	stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
      008194                        111 00101$:
      008194 C6 52 30         [ 1]  112 	ld	a, 0x5230
      008197 2A FB            [ 1]  113 	jrpl	00101$
                                    114 ;	stm8_UART.c: 24: UART1_DR = byte;
      008199 AE 52 31         [ 2]  115 	ldw	x, #0x5231
      00819C 7B 01            [ 1]  116 	ld	a, (0x01, sp)
      00819E F7               [ 1]  117 	ld	(x), a
                                    118 ;	stm8_UART.c: 25: }	
      00819F 84               [ 1]  119 	pop	a
      0081A0 81               [ 4]  120 	ret
                                    121 ;	stm8_UART.c: 27: void sendString_UART(const char *str) {
                                    122 ;	-----------------------------------------
                                    123 ;	 function sendString_UART
                                    124 ;	-----------------------------------------
      0081A1                        125 _sendString_UART:
                                    126 ;	stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
      0081A1                        127 00101$:
      0081A1 F6               [ 1]  128 	ld	a, (x)
      0081A2 26 01            [ 1]  129 	jrne	00121$
      0081A4 81               [ 4]  130 	ret
      0081A5                        131 00121$:
                                    132 ;	stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
      0081A5 89               [ 2]  133 	pushw	x
      0081A6 CD 81 91         [ 4]  134 	call	_sendByte_UART
      0081A9 85               [ 2]  135 	popw	x
                                    136 ;	stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
      0081AA 5C               [ 1]  137 	incw	x
      0081AB 20 F4            [ 2]  138 	jra	00101$
                                    139 ;	stm8_UART.c: 32: }
      0081AD 81               [ 4]  140 	ret
                                    141 ;	stm8_UART.c: 34: void sendLine_UART(void) {
                                    142 ;	-----------------------------------------
                                    143 ;	 function sendLine_UART
                                    144 ;	-----------------------------------------
      0081AE                        145 _sendLine_UART:
                                    146 ;	stm8_UART.c: 35: sendByte_UART('\r');
      0081AE A6 0D            [ 1]  147 	ld	a, #0x0d
      0081B0 CD 81 91         [ 4]  148 	call	_sendByte_UART
                                    149 ;	stm8_UART.c: 36: sendByte_UART('\n');
      0081B3 A6 0A            [ 1]  150 	ld	a, #0x0a
                                    151 ;	stm8_UART.c: 37: }
      0081B5 CC 81 91         [ 2]  152 	jp	_sendByte_UART
                                    153 ;	stm8_UART.c: 39: void sendInt_UART(uint8_t num) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function sendInt_UART
                                    156 ;	-----------------------------------------
      0081B8                        157 _sendInt_UART:
      0081B8 52 06            [ 2]  158 	sub	sp, #6
                                    159 ;	stm8_UART.c: 40: if (num == 0) {
      0081BA 97               [ 1]  160 	ld	xl, a
      0081BB 4D               [ 1]  161 	tnz	a
      0081BC 26 07            [ 1]  162 	jrne	00113$
                                    163 ;	stm8_UART.c: 41: sendByte_UART('0');
      0081BE A6 30            [ 1]  164 	ld	a, #0x30
      0081C0 5B 06            [ 2]  165 	addw	sp, #6
                                    166 ;	stm8_UART.c: 42: return;
      0081C2 CC 81 91         [ 2]  167 	jp	_sendByte_UART
                                    168 ;	stm8_UART.c: 49: while (num > 0) {
      0081C5                        169 00113$:
      0081C5 0F 06            [ 1]  170 	clr	(0x06, sp)
      0081C7                        171 00103$:
      0081C7 9F               [ 1]  172 	ld	a, xl
      0081C8 4D               [ 1]  173 	tnz	a
      0081C9 27 27            [ 1]  174 	jreq	00115$
                                    175 ;	stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
      0081CB 7B 06            [ 1]  176 	ld	a, (0x06, sp)
      0081CD 6B 02            [ 1]  177 	ld	(0x02, sp), a
      0081CF 49               [ 1]  178 	rlc	a
      0081D0 4F               [ 1]  179 	clr	a
      0081D1 A2 00            [ 1]  180 	sbc	a, #0x00
      0081D3 6B 01            [ 1]  181 	ld	(0x01, sp), a
      0081D5 0C 06            [ 1]  182 	inc	(0x06, sp)
      0081D7 90 96            [ 1]  183 	ldw	y, sp
      0081D9 72 A9 00 03      [ 2]  184 	addw	y, #3
      0081DD 72 F9 01         [ 2]  185 	addw	y, (0x01, sp)
      0081E0 89               [ 2]  186 	pushw	x
      0081E1 4F               [ 1]  187 	clr	a
      0081E2 95               [ 1]  188 	ld	xh, a
      0081E3 A6 0A            [ 1]  189 	ld	a, #0x0a
      0081E5 62               [ 2]  190 	div	x, a
      0081E6 85               [ 2]  191 	popw	x
      0081E7 AB 30            [ 1]  192 	add	a, #0x30
      0081E9 90 F7            [ 1]  193 	ld	(y), a
                                    194 ;	stm8_UART.c: 51: num /= 10;
      0081EB 4F               [ 1]  195 	clr	a
      0081EC 95               [ 1]  196 	ld	xh, a
      0081ED A6 0A            [ 1]  197 	ld	a, #0x0a
      0081EF 62               [ 2]  198 	div	x, a
      0081F0 20 D5            [ 2]  199 	jra	00103$
                                    200 ;	stm8_UART.c: 55: while (i > 0) {
      0081F2                        201 00115$:
      0081F2                        202 00106$:
      0081F2 7B 06            [ 1]  203 	ld	a, (0x06, sp)
      0081F4 A1 00            [ 1]  204 	cp	a, #0x00
      0081F6 2D 16            [ 1]  205 	jrsle	00109$
                                    206 ;	stm8_UART.c: 56: sendByte_UART(digits[--i]);
      0081F8 0A 06            [ 1]  207 	dec	(0x06, sp)
      0081FA 7B 06            [ 1]  208 	ld	a, (0x06, sp)
      0081FC 96               [ 1]  209 	ldw	x, sp
      0081FD 1C 00 03         [ 2]  210 	addw	x, #3
      008200 89               [ 2]  211 	pushw	x
      008201 5F               [ 1]  212 	clrw	x
      008202 97               [ 1]  213 	ld	xl, a
      008203 72 FB 01         [ 2]  214 	addw	x, (1, sp)
      008206 5B 02            [ 2]  215 	addw	sp, #2
      008208 F6               [ 1]  216 	ld	a, (x)
      008209 CD 81 91         [ 4]  217 	call	_sendByte_UART
      00820C 20 E4            [ 2]  218 	jra	00106$
      00820E                        219 00109$:
                                    220 ;	stm8_UART.c: 58: }
      00820E 5B 06            [ 2]  221 	addw	sp, #6
      008210 81               [ 4]  222 	ret
                                    223 	.area CODE
                                    224 	.area CONST
                                    225 	.area INITIALIZER
                                    226 	.area CABS (ABS)
