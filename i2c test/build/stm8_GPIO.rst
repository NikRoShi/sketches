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
      0081AC                         56 _pinMode:
      0081AC 52 06            [ 2]   57 	sub	sp, #6
                                     58 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081AE 1F 05            [ 2]   59 	ldw	(0x05, sp), x
      0081B0 5C               [ 1]   60 	incw	x
      0081B1 5C               [ 1]   61 	incw	x
                                     62 ;	../../my_STM8_libraries/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      0081B2 16 05            [ 2]   63 	ldw	y, (0x05, sp)
      0081B4 72 A9 00 03      [ 2]   64 	addw	y, #0x0003
      0081B8 17 01            [ 2]   65 	ldw	(0x01, sp), y
                                     66 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081BA 88               [ 1]   67 	push	a
      0081BB A6 01            [ 1]   68 	ld	a, #0x01
      0081BD 6B 04            [ 1]   69 	ld	(0x04, sp), a
      0081BF 84               [ 1]   70 	pop	a
      0081C0 4D               [ 1]   71 	tnz	a
      0081C1 27 05            [ 1]   72 	jreq	00143$
      0081C3                         73 00142$:
      0081C3 08 03            [ 1]   74 	sll	(0x03, sp)
      0081C5 4A               [ 1]   75 	dec	a
      0081C6 26 FB            [ 1]   76 	jrne	00142$
      0081C8                         77 00143$:
                                     78 ;	../../my_STM8_libraries/stm8_GPIO.c: 4: if (mode == OUTPUT) {
      0081C8 0D 09            [ 1]   79 	tnz	(0x09, sp)
      0081CA 26 0E            [ 1]   80 	jrne	00113$
                                     81 ;	../../my_STM8_libraries/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0081CC F6               [ 1]   82 	ld	a, (x)
      0081CD 1A 03            [ 1]   83 	or	a, (0x03, sp)
      0081CF F7               [ 1]   84 	ld	(x), a
                                     85 ;	../../my_STM8_libraries/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      0081D0 1E 01            [ 2]   86 	ldw	x, (0x01, sp)
      0081D2 F6               [ 1]   87 	ld	a, (x)
      0081D3 1A 03            [ 1]   88 	or	a, (0x03, sp)
      0081D5 1E 01            [ 2]   89 	ldw	x, (0x01, sp)
      0081D7 F7               [ 1]   90 	ld	(x), a
      0081D8 20 5B            [ 2]   91 	jra	00115$
      0081DA                         92 00113$:
                                     93 ;	../../my_STM8_libraries/stm8_GPIO.c: 8: else if (mode == OUTPUT_FAST) {
      0081DA 7B 09            [ 1]   94 	ld	a, (0x09, sp)
      0081DC 4A               [ 1]   95 	dec	a
      0081DD 26 17            [ 1]   96 	jrne	00110$
                                     97 ;	../../my_STM8_libraries/stm8_GPIO.c: 9: *(port + 2) |= (1 << pin);
      0081DF F6               [ 1]   98 	ld	a, (x)
      0081E0 1A 03            [ 1]   99 	or	a, (0x03, sp)
      0081E2 F7               [ 1]  100 	ld	(x), a
                                    101 ;	../../my_STM8_libraries/stm8_GPIO.c: 10: *(port + 3) |= (1 << pin);
      0081E3 1E 01            [ 2]  102 	ldw	x, (0x01, sp)
      0081E5 F6               [ 1]  103 	ld	a, (x)
      0081E6 1A 03            [ 1]  104 	or	a, (0x03, sp)
      0081E8 1E 01            [ 2]  105 	ldw	x, (0x01, sp)
      0081EA F7               [ 1]  106 	ld	(x), a
                                    107 ;	../../my_STM8_libraries/stm8_GPIO.c: 11: *(port + 4) |= (1 << pin);
      0081EB 1E 05            [ 2]  108 	ldw	x, (0x05, sp)
      0081ED 1C 00 04         [ 2]  109 	addw	x, #0x0004
      0081F0 F6               [ 1]  110 	ld	a, (x)
      0081F1 1A 03            [ 1]  111 	or	a, (0x03, sp)
      0081F3 F7               [ 1]  112 	ld	(x), a
      0081F4 20 3F            [ 2]  113 	jra	00115$
      0081F6                        114 00110$:
                                    115 ;	../../my_STM8_libraries/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      0081F6 7B 03            [ 1]  116 	ld	a, (0x03, sp)
      0081F8 43               [ 1]  117 	cpl	a
      0081F9 6B 04            [ 1]  118 	ld	(0x04, sp), a
                                    119 ;	../../my_STM8_libraries/stm8_GPIO.c: 13: else if (mode == INPUT) {
      0081FB 7B 09            [ 1]  120 	ld	a, (0x09, sp)
      0081FD A1 02            [ 1]  121 	cp	a, #0x02
      0081FF 26 0E            [ 1]  122 	jrne	00107$
                                    123 ;	../../my_STM8_libraries/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008201 F6               [ 1]  124 	ld	a, (x)
      008202 14 04            [ 1]  125 	and	a, (0x04, sp)
      008204 F7               [ 1]  126 	ld	(x), a
                                    127 ;	../../my_STM8_libraries/stm8_GPIO.c: 15: *(port + 3) &= ~(1 << pin);
      008205 1E 01            [ 2]  128 	ldw	x, (0x01, sp)
      008207 F6               [ 1]  129 	ld	a, (x)
      008208 14 04            [ 1]  130 	and	a, (0x04, sp)
      00820A 1E 01            [ 2]  131 	ldw	x, (0x01, sp)
      00820C F7               [ 1]  132 	ld	(x), a
      00820D 20 26            [ 2]  133 	jra	00115$
      00820F                        134 00107$:
                                    135 ;	../../my_STM8_libraries/stm8_GPIO.c: 17: else if (mode == INPUT_PULLUP) {
      00820F 7B 09            [ 1]  136 	ld	a, (0x09, sp)
      008211 A1 03            [ 1]  137 	cp	a, #0x03
      008213 26 0E            [ 1]  138 	jrne	00104$
                                    139 ;	../../my_STM8_libraries/stm8_GPIO.c: 18: *(port + 2) &= ~(1 << pin);
      008215 F6               [ 1]  140 	ld	a, (x)
      008216 14 04            [ 1]  141 	and	a, (0x04, sp)
      008218 F7               [ 1]  142 	ld	(x), a
                                    143 ;	../../my_STM8_libraries/stm8_GPIO.c: 19: *(port + 3) |= (1 << pin);
      008219 1E 01            [ 2]  144 	ldw	x, (0x01, sp)
      00821B F6               [ 1]  145 	ld	a, (x)
      00821C 1A 03            [ 1]  146 	or	a, (0x03, sp)
      00821E 1E 01            [ 2]  147 	ldw	x, (0x01, sp)
      008220 F7               [ 1]  148 	ld	(x), a
      008221 20 12            [ 2]  149 	jra	00115$
      008223                        150 00104$:
                                    151 ;	../../my_STM8_libraries/stm8_GPIO.c: 21: else if (mode == OUTPUT_OD) {
      008223 7B 09            [ 1]  152 	ld	a, (0x09, sp)
      008225 A1 04            [ 1]  153 	cp	a, #0x04
      008227 26 0C            [ 1]  154 	jrne	00115$
                                    155 ;	../../my_STM8_libraries/stm8_GPIO.c: 22: *(port + 2) |= (1 << pin);  // DDR = 1 (Выход)
      008229 F6               [ 1]  156 	ld	a, (x)
      00822A 1A 03            [ 1]  157 	or	a, (0x03, sp)
      00822C F7               [ 1]  158 	ld	(x), a
                                    159 ;	../../my_STM8_libraries/stm8_GPIO.c: 23: *(port + 3) &= ~(1 << pin); // CR1 = 0 (Open Drain)
      00822D 1E 01            [ 2]  160 	ldw	x, (0x01, sp)
      00822F F6               [ 1]  161 	ld	a, (x)
      008230 14 04            [ 1]  162 	and	a, (0x04, sp)
      008232 1E 01            [ 2]  163 	ldw	x, (0x01, sp)
      008234 F7               [ 1]  164 	ld	(x), a
      008235                        165 00115$:
                                    166 ;	../../my_STM8_libraries/stm8_GPIO.c: 25: }
      008235 5B 06            [ 2]  167 	addw	sp, #6
      008237 85               [ 2]  168 	popw	x
      008238 84               [ 1]  169 	pop	a
      008239 FC               [ 2]  170 	jp	(x)
                                    171 ;	../../my_STM8_libraries/stm8_GPIO.c: 27: void writePin(volatile uint8_t* port, uint8_t pin, uint8_t state) {
                                    172 ;	-----------------------------------------
                                    173 ;	 function writePin
                                    174 ;	-----------------------------------------
      00823A                        175 _writePin:
      00823A 52 04            [ 2]  176 	sub	sp, #4
                                    177 ;	../../my_STM8_libraries/stm8_GPIO.c: 29: *port |= (1 << pin);
      00823C 1F 03            [ 2]  178 	ldw	(0x03, sp), x
      00823E 6B 01            [ 1]  179 	ld	(0x01, sp), a
      008240 F6               [ 1]  180 	ld	a, (x)
      008241 6B 02            [ 1]  181 	ld	(0x02, sp), a
      008243 A6 01            [ 1]  182 	ld	a, #0x01
      008245 88               [ 1]  183 	push	a
      008246 7B 02            [ 1]  184 	ld	a, (0x02, sp)
      008248 27 05            [ 1]  185 	jreq	00112$
      00824A                        186 00111$:
      00824A 08 01            [ 1]  187 	sll	(1, sp)
      00824C 4A               [ 1]  188 	dec	a
      00824D 26 FB            [ 1]  189 	jrne	00111$
      00824F                        190 00112$:
      00824F 7B 08            [ 1]  191 	ld	a, (0x08, sp)
      008251 4A               [ 1]  192 	dec	a
      008252 84               [ 1]  193 	pop	a
      008253 26 05            [ 1]  194 	jrne	00102$
                                    195 ;	../../my_STM8_libraries/stm8_GPIO.c: 29: *port |= (1 << pin);
      008255 1A 02            [ 1]  196 	or	a, (0x02, sp)
      008257 F7               [ 1]  197 	ld	(x), a
      008258 20 04            [ 2]  198 	jra	00104$
      00825A                        199 00102$:
                                    200 ;	../../my_STM8_libraries/stm8_GPIO.c: 31: else {*port &= ~(1 << pin);}
      00825A 43               [ 1]  201 	cpl	a
      00825B 14 02            [ 1]  202 	and	a, (0x02, sp)
      00825D F7               [ 1]  203 	ld	(x), a
      00825E                        204 00104$:
                                    205 ;	../../my_STM8_libraries/stm8_GPIO.c: 32: }
      00825E 5B 04            [ 2]  206 	addw	sp, #4
      008260 85               [ 2]  207 	popw	x
      008261 84               [ 1]  208 	pop	a
      008262 FC               [ 2]  209 	jp	(x)
                                    210 ;	../../my_STM8_libraries/stm8_GPIO.c: 34: void togglePin(volatile uint8_t* port, uint8_t pin) {
                                    211 ;	-----------------------------------------
                                    212 ;	 function togglePin
                                    213 ;	-----------------------------------------
      008263                        214 _togglePin:
      008263 52 03            [ 2]  215 	sub	sp, #3
      008265 1F 02            [ 2]  216 	ldw	(0x02, sp), x
      008267 90 97            [ 1]  217 	ld	yl, a
                                    218 ;	../../my_STM8_libraries/stm8_GPIO.c: 35: *port ^= (1 << pin);
      008269 1E 02            [ 2]  219 	ldw	x, (0x02, sp)
      00826B F6               [ 1]  220 	ld	a, (x)
      00826C 88               [ 1]  221 	push	a
      00826D A6 01            [ 1]  222 	ld	a, #0x01
      00826F 6B 02            [ 1]  223 	ld	(0x02, sp), a
      008271 90 9F            [ 1]  224 	ld	a, yl
      008273 4D               [ 1]  225 	tnz	a
      008274 27 05            [ 1]  226 	jreq	00104$
      008276                        227 00103$:
      008276 08 02            [ 1]  228 	sll	(0x02, sp)
      008278 4A               [ 1]  229 	dec	a
      008279 26 FB            [ 1]  230 	jrne	00103$
      00827B                        231 00104$:
      00827B 84               [ 1]  232 	pop	a
      00827C 18 01            [ 1]  233 	xor	a, (0x01, sp)
      00827E F7               [ 1]  234 	ld	(x), a
                                    235 ;	../../my_STM8_libraries/stm8_GPIO.c: 36: }
      00827F 5B 03            [ 2]  236 	addw	sp, #3
      008281 81               [ 4]  237 	ret
                                    238 ;	../../my_STM8_libraries/stm8_GPIO.c: 38: uint8_t readPin(volatile uint8_t* port, uint8_t pin) {
                                    239 ;	-----------------------------------------
                                    240 ;	 function readPin
                                    241 ;	-----------------------------------------
      008282                        242 _readPin:
      008282 52 07            [ 2]  243 	sub	sp, #7
      008284 1F 06            [ 2]  244 	ldw	(0x06, sp), x
      008286 6B 05            [ 1]  245 	ld	(0x05, sp), a
                                    246 ;	../../my_STM8_libraries/stm8_GPIO.c: 39: if (*(port +1) & (1 << pin)) {
      008288 1E 06            [ 2]  247 	ldw	x, (0x06, sp)
      00828A E6 01            [ 1]  248 	ld	a, (0x1, x)
      00828C 88               [ 1]  249 	push	a
      00828D 5F               [ 1]  250 	clrw	x
      00828E 5C               [ 1]  251 	incw	x
      00828F 7B 06            [ 1]  252 	ld	a, (0x06, sp)
      008291 27 04            [ 1]  253 	jreq	00111$
      008293                        254 00110$:
      008293 58               [ 2]  255 	sllw	x
      008294 4A               [ 1]  256 	dec	a
      008295 26 FC            [ 1]  257 	jrne	00110$
      008297                        258 00111$:
      008297 84               [ 1]  259 	pop	a
      008298 6B 02            [ 1]  260 	ld	(0x02, sp), a
      00829A 0F 01            [ 1]  261 	clr	(0x01, sp)
      00829C 9F               [ 1]  262 	ld	a, xl
      00829D 14 02            [ 1]  263 	and	a, (0x02, sp)
      00829F 6B 04            [ 1]  264 	ld	(0x04, sp), a
      0082A1 9E               [ 1]  265 	ld	a, xh
      0082A2 14 01            [ 1]  266 	and	a, (0x01, sp)
      0082A4 6B 03            [ 1]  267 	ld	(0x03, sp), a
      0082A6 1E 03            [ 2]  268 	ldw	x, (0x03, sp)
      0082A8 27 03            [ 1]  269 	jreq	00102$
                                    270 ;	../../my_STM8_libraries/stm8_GPIO.c: 40: return 1;
      0082AA A6 01            [ 1]  271 	ld	a, #0x01
                                    272 ;	../../my_STM8_libraries/stm8_GPIO.c: 42: return 0;
      0082AC 21                     273 	.byte 0x21
      0082AD                        274 00102$:
      0082AD 4F               [ 1]  275 	clr	a
      0082AE                        276 00103$:
                                    277 ;	../../my_STM8_libraries/stm8_GPIO.c: 43: }
      0082AE 5B 07            [ 2]  278 	addw	sp, #7
      0082B0 81               [ 4]  279 	ret
                                    280 	.area CODE
                                    281 	.area CONST
                                    282 	.area INITIALIZER
                                    283 	.area CABS (ABS)
