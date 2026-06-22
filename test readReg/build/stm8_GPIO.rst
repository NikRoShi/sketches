                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_GPIO
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _pinMode
                                     12 	.globl _writePin
                                     13 	.globl _togglePin
                                     14 	.globl _readPin
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
                                     52 ;	../../my_STM8_libraries/stm8_GPIO.c: 3: void pinMode(volatile uint8_t* port, uint8_t pin, uint8_t mode) {
                                     53 ;	-----------------------------------------
                                     54 ;	 function pinMode
                                     55 ;	-----------------------------------------
      0081DC                         56 _pinMode:
      0081DC 52 06            [ 2]   57 	sub	sp, #6
                                     58 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081DE 1F 05            [ 2]   59 	ldw	(0x05, sp), x
      0081E0 5C               [ 1]   60 	incw	x
      0081E1 5C               [ 1]   61 	incw	x
                                     62 ;	../../my_STM8_libraries/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      0081E2 16 05            [ 2]   63 	ldw	y, (0x05, sp)
      0081E4 72 A9 00 03      [ 2]   64 	addw	y, #0x0003
      0081E8 17 01            [ 2]   65 	ldw	(0x01, sp), y
                                     66 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081EA 88               [ 1]   67 	push	a
      0081EB A6 01            [ 1]   68 	ld	a, #0x01
      0081ED 6B 04            [ 1]   69 	ld	(0x04, sp), a
      0081EF 84               [ 1]   70 	pop	a
      0081F0 4D               [ 1]   71 	tnz	a
      0081F1 27 05            [ 1]   72 	jreq	00143$
      0081F3                         73 00142$:
      0081F3 08 03            [ 1]   74 	sll	(0x03, sp)
      0081F5 4A               [ 1]   75 	dec	a
      0081F6 26 FB            [ 1]   76 	jrne	00142$
      0081F8                         77 00143$:
                                     78 ;	../../my_STM8_libraries/stm8_GPIO.c: 4: if (mode == OUTPUT) {
      0081F8 0D 09            [ 1]   79 	tnz	(0x09, sp)
      0081FA 26 0E            [ 1]   80 	jrne	00113$
                                     81 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081FC F6               [ 1]   82 	ld	a, (x)
      0081FD 1A 03            [ 1]   83 	or	a, (0x03, sp)
      0081FF F7               [ 1]   84 	ld	(x), a
                                     85 ;	../../my_STM8_libraries/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      008200 1E 01            [ 2]   86 	ldw	x, (0x01, sp)
      008202 F6               [ 1]   87 	ld	a, (x)
      008203 1A 03            [ 1]   88 	or	a, (0x03, sp)
      008205 1E 01            [ 2]   89 	ldw	x, (0x01, sp)
      008207 F7               [ 1]   90 	ld	(x), a
      008208 20 5B            [ 2]   91 	jra	00115$
      00820A                         92 00113$:
                                     93 ;	../../my_STM8_libraries/stm8_GPIO.c: 8: else if (mode == OUTPUT_FAST) {
      00820A 7B 09            [ 1]   94 	ld	a, (0x09, sp)
      00820C 4A               [ 1]   95 	dec	a
      00820D 26 17            [ 1]   96 	jrne	00110$
                                     97 ;	../../my_STM8_libraries/stm8_GPIO.c: 9: *(port + 2) |= (1 << pin);
      00820F F6               [ 1]   98 	ld	a, (x)
      008210 1A 03            [ 1]   99 	or	a, (0x03, sp)
      008212 F7               [ 1]  100 	ld	(x), a
                                    101 ;	../../my_STM8_libraries/stm8_GPIO.c: 10: *(port + 3) |= (1 << pin);
      008213 1E 01            [ 2]  102 	ldw	x, (0x01, sp)
      008215 F6               [ 1]  103 	ld	a, (x)
      008216 1A 03            [ 1]  104 	or	a, (0x03, sp)
      008218 1E 01            [ 2]  105 	ldw	x, (0x01, sp)
      00821A F7               [ 1]  106 	ld	(x), a
                                    107 ;	../../my_STM8_libraries/stm8_GPIO.c: 11: *(port + 4) |= (1 << pin);
      00821B 1E 05            [ 2]  108 	ldw	x, (0x05, sp)
      00821D 1C 00 04         [ 2]  109 	addw	x, #0x0004
      008220 F6               [ 1]  110 	ld	a, (x)
      008221 1A 03            [ 1]  111 	or	a, (0x03, sp)
      008223 F7               [ 1]  112 	ld	(x), a
      008224 20 3F            [ 2]  113 	jra	00115$
      008226                        114 00110$:
                                    115 ;	../../my_STM8_libraries/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008226 7B 03            [ 1]  116 	ld	a, (0x03, sp)
      008228 43               [ 1]  117 	cpl	a
      008229 6B 04            [ 1]  118 	ld	(0x04, sp), a
                                    119 ;	../../my_STM8_libraries/stm8_GPIO.c: 13: else if (mode == INPUT) {
      00822B 7B 09            [ 1]  120 	ld	a, (0x09, sp)
      00822D A1 02            [ 1]  121 	cp	a, #0x02
      00822F 26 0E            [ 1]  122 	jrne	00107$
                                    123 ;	../../my_STM8_libraries/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008231 F6               [ 1]  124 	ld	a, (x)
      008232 14 04            [ 1]  125 	and	a, (0x04, sp)
      008234 F7               [ 1]  126 	ld	(x), a
                                    127 ;	../../my_STM8_libraries/stm8_GPIO.c: 15: *(port + 3) &= ~(1 << pin);
      008235 1E 01            [ 2]  128 	ldw	x, (0x01, sp)
      008237 F6               [ 1]  129 	ld	a, (x)
      008238 14 04            [ 1]  130 	and	a, (0x04, sp)
      00823A 1E 01            [ 2]  131 	ldw	x, (0x01, sp)
      00823C F7               [ 1]  132 	ld	(x), a
      00823D 20 26            [ 2]  133 	jra	00115$
      00823F                        134 00107$:
                                    135 ;	../../my_STM8_libraries/stm8_GPIO.c: 17: else if (mode == INPUT_PULLUP) {
      00823F 7B 09            [ 1]  136 	ld	a, (0x09, sp)
      008241 A1 03            [ 1]  137 	cp	a, #0x03
      008243 26 0E            [ 1]  138 	jrne	00104$
                                    139 ;	../../my_STM8_libraries/stm8_GPIO.c: 18: *(port + 2) &= ~(1 << pin);
      008245 F6               [ 1]  140 	ld	a, (x)
      008246 14 04            [ 1]  141 	and	a, (0x04, sp)
      008248 F7               [ 1]  142 	ld	(x), a
                                    143 ;	../../my_STM8_libraries/stm8_GPIO.c: 19: *(port + 3) |= (1 << pin);
      008249 1E 01            [ 2]  144 	ldw	x, (0x01, sp)
      00824B F6               [ 1]  145 	ld	a, (x)
      00824C 1A 03            [ 1]  146 	or	a, (0x03, sp)
      00824E 1E 01            [ 2]  147 	ldw	x, (0x01, sp)
      008250 F7               [ 1]  148 	ld	(x), a
      008251 20 12            [ 2]  149 	jra	00115$
      008253                        150 00104$:
                                    151 ;	../../my_STM8_libraries/stm8_GPIO.c: 21: else if (mode == OUTPUT_OD) {
      008253 7B 09            [ 1]  152 	ld	a, (0x09, sp)
      008255 A1 04            [ 1]  153 	cp	a, #0x04
      008257 26 0C            [ 1]  154 	jrne	00115$
                                    155 ;	../../my_STM8_libraries/stm8_GPIO.c: 22: *(port + 2) |= (1 << pin);  // DDR = 1 (Выход)
      008259 F6               [ 1]  156 	ld	a, (x)
      00825A 1A 03            [ 1]  157 	or	a, (0x03, sp)
      00825C F7               [ 1]  158 	ld	(x), a
                                    159 ;	../../my_STM8_libraries/stm8_GPIO.c: 23: *(port + 3) &= ~(1 << pin); // CR1 = 0 (Open Drain)
      00825D 1E 01            [ 2]  160 	ldw	x, (0x01, sp)
      00825F F6               [ 1]  161 	ld	a, (x)
      008260 14 04            [ 1]  162 	and	a, (0x04, sp)
      008262 1E 01            [ 2]  163 	ldw	x, (0x01, sp)
      008264 F7               [ 1]  164 	ld	(x), a
      008265                        165 00115$:
                                    166 ;	../../my_STM8_libraries/stm8_GPIO.c: 25: }
      008265 5B 06            [ 2]  167 	addw	sp, #6
      008267 85               [ 2]  168 	popw	x
      008268 84               [ 1]  169 	pop	a
      008269 FC               [ 2]  170 	jp	(x)
                                    171 ;	../../my_STM8_libraries/stm8_GPIO.c: 27: void writePin(volatile uint8_t* port, uint8_t pin, uint8_t state) {
                                    172 ;	-----------------------------------------
                                    173 ;	 function writePin
                                    174 ;	-----------------------------------------
      00826A                        175 _writePin:
      00826A 52 04            [ 2]  176 	sub	sp, #4
                                    177 ;	../../my_STM8_libraries/stm8_GPIO.c: 29: *port |= (1 << pin);
      00826C 1F 03            [ 2]  178 	ldw	(0x03, sp), x
      00826E 6B 01            [ 1]  179 	ld	(0x01, sp), a
      008270 F6               [ 1]  180 	ld	a, (x)
      008271 6B 02            [ 1]  181 	ld	(0x02, sp), a
      008273 A6 01            [ 1]  182 	ld	a, #0x01
      008275 88               [ 1]  183 	push	a
      008276 7B 02            [ 1]  184 	ld	a, (0x02, sp)
      008278 27 05            [ 1]  185 	jreq	00112$
      00827A                        186 00111$:
      00827A 08 01            [ 1]  187 	sll	(1, sp)
      00827C 4A               [ 1]  188 	dec	a
      00827D 26 FB            [ 1]  189 	jrne	00111$
      00827F                        190 00112$:
      00827F 7B 08            [ 1]  191 	ld	a, (0x08, sp)
      008281 4A               [ 1]  192 	dec	a
      008282 84               [ 1]  193 	pop	a
      008283 26 05            [ 1]  194 	jrne	00102$
                                    195 ;	../../my_STM8_libraries/stm8_GPIO.c: 29: *port |= (1 << pin);
      008285 1A 02            [ 1]  196 	or	a, (0x02, sp)
      008287 F7               [ 1]  197 	ld	(x), a
      008288 20 04            [ 2]  198 	jra	00104$
      00828A                        199 00102$:
                                    200 ;	../../my_STM8_libraries/stm8_GPIO.c: 31: else {*port &= ~(1 << pin);}
      00828A 43               [ 1]  201 	cpl	a
      00828B 14 02            [ 1]  202 	and	a, (0x02, sp)
      00828D F7               [ 1]  203 	ld	(x), a
      00828E                        204 00104$:
                                    205 ;	../../my_STM8_libraries/stm8_GPIO.c: 32: }
      00828E 5B 04            [ 2]  206 	addw	sp, #4
      008290 85               [ 2]  207 	popw	x
      008291 84               [ 1]  208 	pop	a
      008292 FC               [ 2]  209 	jp	(x)
                                    210 ;	../../my_STM8_libraries/stm8_GPIO.c: 34: void togglePin(volatile uint8_t* port, uint8_t pin) {
                                    211 ;	-----------------------------------------
                                    212 ;	 function togglePin
                                    213 ;	-----------------------------------------
      008293                        214 _togglePin:
      008293 52 03            [ 2]  215 	sub	sp, #3
      008295 1F 02            [ 2]  216 	ldw	(0x02, sp), x
      008297 90 97            [ 1]  217 	ld	yl, a
                                    218 ;	../../my_STM8_libraries/stm8_GPIO.c: 35: *port ^= (1 << pin);
      008299 1E 02            [ 2]  219 	ldw	x, (0x02, sp)
      00829B F6               [ 1]  220 	ld	a, (x)
      00829C 88               [ 1]  221 	push	a
      00829D A6 01            [ 1]  222 	ld	a, #0x01
      00829F 6B 02            [ 1]  223 	ld	(0x02, sp), a
      0082A1 90 9F            [ 1]  224 	ld	a, yl
      0082A3 4D               [ 1]  225 	tnz	a
      0082A4 27 05            [ 1]  226 	jreq	00104$
      0082A6                        227 00103$:
      0082A6 08 02            [ 1]  228 	sll	(0x02, sp)
      0082A8 4A               [ 1]  229 	dec	a
      0082A9 26 FB            [ 1]  230 	jrne	00103$
      0082AB                        231 00104$:
      0082AB 84               [ 1]  232 	pop	a
      0082AC 18 01            [ 1]  233 	xor	a, (0x01, sp)
      0082AE F7               [ 1]  234 	ld	(x), a
                                    235 ;	../../my_STM8_libraries/stm8_GPIO.c: 36: }
      0082AF 5B 03            [ 2]  236 	addw	sp, #3
      0082B1 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_GPIO.c: 38: uint8_t readPin(volatile uint8_t* port, uint8_t pin) {
                                    239 ;	-----------------------------------------
                                    240 ;	 function readPin
                                    241 ;	-----------------------------------------
      0082B2                        242 _readPin:
      0082B2 52 07            [ 2]  243 	sub	sp, #7
      0082B4 1F 06            [ 2]  244 	ldw	(0x06, sp), x
      0082B6 6B 05            [ 1]  245 	ld	(0x05, sp), a
                                    246 ;	../../my_STM8_libraries/stm8_GPIO.c: 39: if (*(port +1) & (1 << pin)) {
      0082B8 1E 06            [ 2]  247 	ldw	x, (0x06, sp)
      0082BA E6 01            [ 1]  248 	ld	a, (0x1, x)
      0082BC 88               [ 1]  249 	push	a
      0082BD 5F               [ 1]  250 	clrw	x
      0082BE 5C               [ 1]  251 	incw	x
      0082BF 7B 06            [ 1]  252 	ld	a, (0x06, sp)
      0082C1 27 04            [ 1]  253 	jreq	00111$
      0082C3                        254 00110$:
      0082C3 58               [ 2]  255 	sllw	x
      0082C4 4A               [ 1]  256 	dec	a
      0082C5 26 FC            [ 1]  257 	jrne	00110$
      0082C7                        258 00111$:
      0082C7 84               [ 1]  259 	pop	a
      0082C8 6B 02            [ 1]  260 	ld	(0x02, sp), a
      0082CA 0F 01            [ 1]  261 	clr	(0x01, sp)
      0082CC 9F               [ 1]  262 	ld	a, xl
      0082CD 14 02            [ 1]  263 	and	a, (0x02, sp)
      0082CF 6B 04            [ 1]  264 	ld	(0x04, sp), a
      0082D1 9E               [ 1]  265 	ld	a, xh
      0082D2 14 01            [ 1]  266 	and	a, (0x01, sp)
      0082D4 6B 03            [ 1]  267 	ld	(0x03, sp), a
      0082D6 1E 03            [ 2]  268 	ldw	x, (0x03, sp)
      0082D8 27 03            [ 1]  269 	jreq	00102$
                                    270 ;	../../my_STM8_libraries/stm8_GPIO.c: 40: return 1;
      0082DA A6 01            [ 1]  271 	ld	a, #0x01
                                    272 ;	../../my_STM8_libraries/stm8_GPIO.c: 42: return 0;
      0082DC 21                     273 	.byte 0x21
      0082DD                        274 00102$:
      0082DD 4F               [ 1]  275 	clr	a
      0082DE                        276 00103$:
                                    277 ;	../../my_STM8_libraries/stm8_GPIO.c: 43: }
      0082DE 5B 07            [ 2]  278 	addw	sp, #7
      0082E0 81               [ 4]  279 	ret
                                    280 	.area CODE
                                    281 	.area CONST
                                    282 	.area INITIALIZER
                                    283 	.area CABS (ABS)
