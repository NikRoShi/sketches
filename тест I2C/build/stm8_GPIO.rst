                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_GPIO
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _pinMode
                                     11 	.globl _writePin
                                     12 	.globl _togglePin
                                     13 	.globl _readPin
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	../../libs/stm8_GPIO.c: 3: void pinMode(volatile uint8_t* port, uint8_t pin, uint8_t mode) {
                                     52 ;	-----------------------------------------
                                     53 ;	 function pinMode
                                     54 ;	-----------------------------------------
      00822D                         55 _pinMode:
      00822D 52 06            [ 2]   56 	sub	sp, #6
                                     57 ;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      00822F 1F 05            [ 2]   58 	ldw	(0x05, sp), x
      008231 5C               [ 1]   59 	incw	x
      008232 5C               [ 1]   60 	incw	x
      008233 88               [ 1]   61 	push	a
      008234 A6 01            [ 1]   62 	ld	a, #0x01
      008236 6B 02            [ 1]   63 	ld	(0x02, sp), a
      008238 84               [ 1]   64 	pop	a
      008239 4D               [ 1]   65 	tnz	a
      00823A 27 05            [ 1]   66 	jreq	00153$
      00823C                         67 00152$:
      00823C 08 01            [ 1]   68 	sll	(0x01, sp)
      00823E 4A               [ 1]   69 	dec	a
      00823F 26 FB            [ 1]   70 	jrne	00152$
      008241                         71 00153$:
                                     72 ;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      008241 16 05            [ 2]   73 	ldw	y, (0x05, sp)
      008243 72 A9 00 03      [ 2]   74 	addw	y, #0x0003
      008247 17 02            [ 2]   75 	ldw	(0x02, sp), y
                                     76 ;	../../libs/stm8_GPIO.c: 4: if (mode == OUTPUT) {
      008249 0D 09            [ 1]   77 	tnz	(0x09, sp)
      00824B 26 0E            [ 1]   78 	jrne	00113$
                                     79 ;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      00824D F6               [ 1]   80 	ld	a, (x)
      00824E 1A 01            [ 1]   81 	or	a, (0x01, sp)
      008250 F7               [ 1]   82 	ld	(x), a
                                     83 ;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      008251 1E 02            [ 2]   84 	ldw	x, (0x02, sp)
      008253 F6               [ 1]   85 	ld	a, (x)
      008254 1A 01            [ 1]   86 	or	a, (0x01, sp)
      008256 1E 02            [ 2]   87 	ldw	x, (0x02, sp)
      008258 F7               [ 1]   88 	ld	(x), a
      008259 20 5B            [ 2]   89 	jra	00115$
      00825B                         90 00113$:
                                     91 ;	../../libs/stm8_GPIO.c: 8: else if (mode == OUTPUT_FAST) {
      00825B 7B 09            [ 1]   92 	ld	a, (0x09, sp)
      00825D 4A               [ 1]   93 	dec	a
      00825E 26 17            [ 1]   94 	jrne	00110$
                                     95 ;	../../libs/stm8_GPIO.c: 9: *(port + 2) |= (1 << pin);
      008260 F6               [ 1]   96 	ld	a, (x)
      008261 1A 01            [ 1]   97 	or	a, (0x01, sp)
      008263 F7               [ 1]   98 	ld	(x), a
                                     99 ;	../../libs/stm8_GPIO.c: 10: *(port + 3) |= (1 << pin);
      008264 1E 02            [ 2]  100 	ldw	x, (0x02, sp)
      008266 F6               [ 1]  101 	ld	a, (x)
      008267 1A 01            [ 1]  102 	or	a, (0x01, sp)
      008269 1E 02            [ 2]  103 	ldw	x, (0x02, sp)
      00826B F7               [ 1]  104 	ld	(x), a
                                    105 ;	../../libs/stm8_GPIO.c: 11: *(port + 4) |= (1 << pin);
      00826C 1E 05            [ 2]  106 	ldw	x, (0x05, sp)
      00826E 1C 00 04         [ 2]  107 	addw	x, #0x0004
      008271 F6               [ 1]  108 	ld	a, (x)
      008272 1A 01            [ 1]  109 	or	a, (0x01, sp)
      008274 F7               [ 1]  110 	ld	(x), a
      008275 20 3F            [ 2]  111 	jra	00115$
      008277                        112 00110$:
                                    113 ;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008277 7B 01            [ 1]  114 	ld	a, (0x01, sp)
      008279 43               [ 1]  115 	cpl	a
      00827A 6B 04            [ 1]  116 	ld	(0x04, sp), a
                                    117 ;	../../libs/stm8_GPIO.c: 13: else if (mode == INPUT) {
      00827C 7B 09            [ 1]  118 	ld	a, (0x09, sp)
      00827E A1 02            [ 1]  119 	cp	a, #0x02
      008280 26 0E            [ 1]  120 	jrne	00107$
                                    121 ;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008282 F6               [ 1]  122 	ld	a, (x)
      008283 14 04            [ 1]  123 	and	a, (0x04, sp)
      008285 F7               [ 1]  124 	ld	(x), a
                                    125 ;	../../libs/stm8_GPIO.c: 15: *(port + 3) &= ~(1 << pin);
      008286 1E 02            [ 2]  126 	ldw	x, (0x02, sp)
      008288 F6               [ 1]  127 	ld	a, (x)
      008289 14 04            [ 1]  128 	and	a, (0x04, sp)
      00828B 1E 02            [ 2]  129 	ldw	x, (0x02, sp)
      00828D F7               [ 1]  130 	ld	(x), a
      00828E 20 26            [ 2]  131 	jra	00115$
      008290                        132 00107$:
                                    133 ;	../../libs/stm8_GPIO.c: 17: else if (mode == INPUT_PULLUP) {
      008290 7B 09            [ 1]  134 	ld	a, (0x09, sp)
      008292 A1 03            [ 1]  135 	cp	a, #0x03
      008294 26 0E            [ 1]  136 	jrne	00104$
                                    137 ;	../../libs/stm8_GPIO.c: 18: *(port + 2) &= ~(1 << pin);
      008296 F6               [ 1]  138 	ld	a, (x)
      008297 14 04            [ 1]  139 	and	a, (0x04, sp)
      008299 F7               [ 1]  140 	ld	(x), a
                                    141 ;	../../libs/stm8_GPIO.c: 19: *(port + 3) |= (1 << pin);
      00829A 1E 02            [ 2]  142 	ldw	x, (0x02, sp)
      00829C F6               [ 1]  143 	ld	a, (x)
      00829D 1A 01            [ 1]  144 	or	a, (0x01, sp)
      00829F 1E 02            [ 2]  145 	ldw	x, (0x02, sp)
      0082A1 F7               [ 1]  146 	ld	(x), a
      0082A2 20 12            [ 2]  147 	jra	00115$
      0082A4                        148 00104$:
                                    149 ;	../../libs/stm8_GPIO.c: 21: else if (mode == OUTPUT_OD) {
      0082A4 7B 09            [ 1]  150 	ld	a, (0x09, sp)
      0082A6 A1 04            [ 1]  151 	cp	a, #0x04
      0082A8 26 0C            [ 1]  152 	jrne	00115$
                                    153 ;	../../libs/stm8_GPIO.c: 22: *(port + 2) |= (1 << pin);  // DDR = 1 (Выход)
      0082AA F6               [ 1]  154 	ld	a, (x)
      0082AB 1A 01            [ 1]  155 	or	a, (0x01, sp)
      0082AD F7               [ 1]  156 	ld	(x), a
                                    157 ;	../../libs/stm8_GPIO.c: 23: *(port + 3) &= ~(1 << pin); // CR1 = 0 (Open Drain)
      0082AE 1E 02            [ 2]  158 	ldw	x, (0x02, sp)
      0082B0 F6               [ 1]  159 	ld	a, (x)
      0082B1 14 04            [ 1]  160 	and	a, (0x04, sp)
      0082B3 1E 02            [ 2]  161 	ldw	x, (0x02, sp)
      0082B5 F7               [ 1]  162 	ld	(x), a
      0082B6                        163 00115$:
                                    164 ;	../../libs/stm8_GPIO.c: 25: }
      0082B6 5B 06            [ 2]  165 	addw	sp, #6
      0082B8 85               [ 2]  166 	popw	x
      0082B9 84               [ 1]  167 	pop	a
      0082BA FC               [ 2]  168 	jp	(x)
                                    169 ;	../../libs/stm8_GPIO.c: 27: void writePin(volatile uint8_t* port, uint8_t pin, uint8_t state) {
                                    170 ;	-----------------------------------------
                                    171 ;	 function writePin
                                    172 ;	-----------------------------------------
      0082BB                        173 _writePin:
      0082BB 52 04            [ 2]  174 	sub	sp, #4
                                    175 ;	../../libs/stm8_GPIO.c: 29: *port |= (1 << pin);
      0082BD 1F 03            [ 2]  176 	ldw	(0x03, sp), x
      0082BF 88               [ 1]  177 	push	a
      0082C0 A6 01            [ 1]  178 	ld	a, #0x01
      0082C2 6B 02            [ 1]  179 	ld	(0x02, sp), a
      0082C4 84               [ 1]  180 	pop	a
      0082C5 4D               [ 1]  181 	tnz	a
      0082C6 27 05            [ 1]  182 	jreq	00114$
      0082C8                        183 00113$:
      0082C8 08 01            [ 1]  184 	sll	(0x01, sp)
      0082CA 4A               [ 1]  185 	dec	a
      0082CB 26 FB            [ 1]  186 	jrne	00113$
      0082CD                        187 00114$:
      0082CD F6               [ 1]  188 	ld	a, (x)
      0082CE 6B 02            [ 1]  189 	ld	(0x02, sp), a
                                    190 ;	../../libs/stm8_GPIO.c: 28: if (state == HIGH) {
      0082D0 7B 07            [ 1]  191 	ld	a, (0x07, sp)
      0082D2 4A               [ 1]  192 	dec	a
      0082D3 26 07            [ 1]  193 	jrne	00102$
                                    194 ;	../../libs/stm8_GPIO.c: 29: *port |= (1 << pin);
      0082D5 7B 02            [ 1]  195 	ld	a, (0x02, sp)
      0082D7 1A 01            [ 1]  196 	or	a, (0x01, sp)
      0082D9 F7               [ 1]  197 	ld	(x), a
      0082DA 20 06            [ 2]  198 	jra	00104$
      0082DC                        199 00102$:
                                    200 ;	../../libs/stm8_GPIO.c: 31: else {*port &= ~(1 << pin);}
      0082DC 7B 01            [ 1]  201 	ld	a, (0x01, sp)
      0082DE 43               [ 1]  202 	cpl	a
      0082DF 14 02            [ 1]  203 	and	a, (0x02, sp)
      0082E1 F7               [ 1]  204 	ld	(x), a
      0082E2                        205 00104$:
                                    206 ;	../../libs/stm8_GPIO.c: 32: }
      0082E2 5B 04            [ 2]  207 	addw	sp, #4
      0082E4 85               [ 2]  208 	popw	x
      0082E5 84               [ 1]  209 	pop	a
      0082E6 FC               [ 2]  210 	jp	(x)
                                    211 ;	../../libs/stm8_GPIO.c: 34: void togglePin(volatile uint8_t* port, uint8_t pin) {
                                    212 ;	-----------------------------------------
                                    213 ;	 function togglePin
                                    214 ;	-----------------------------------------
      0082E7                        215 _togglePin:
      0082E7 52 04            [ 2]  216 	sub	sp, #4
      0082E9 1F 03            [ 2]  217 	ldw	(0x03, sp), x
      0082EB 6B 02            [ 1]  218 	ld	(0x02, sp), a
                                    219 ;	../../libs/stm8_GPIO.c: 35: *port ^= (1 << pin);
      0082ED 1E 03            [ 2]  220 	ldw	x, (0x03, sp)
      0082EF F6               [ 1]  221 	ld	a, (x)
      0082F0 88               [ 1]  222 	push	a
      0082F1 A6 01            [ 1]  223 	ld	a, #0x01
      0082F3 6B 02            [ 1]  224 	ld	(0x02, sp), a
      0082F5 7B 03            [ 1]  225 	ld	a, (0x03, sp)
      0082F7 27 05            [ 1]  226 	jreq	00104$
      0082F9                        227 00103$:
      0082F9 08 02            [ 1]  228 	sll	(0x02, sp)
      0082FB 4A               [ 1]  229 	dec	a
      0082FC 26 FB            [ 1]  230 	jrne	00103$
      0082FE                        231 00104$:
      0082FE 84               [ 1]  232 	pop	a
      0082FF 18 01            [ 1]  233 	xor	a, (0x01, sp)
      008301 F7               [ 1]  234 	ld	(x), a
                                    235 ;	../../libs/stm8_GPIO.c: 36: }
      008302 5B 04            [ 2]  236 	addw	sp, #4
      008304 81               [ 4]  237 	ret
                                    238 ;	../../libs/stm8_GPIO.c: 38: uint8_t readPin(volatile uint8_t* port, uint8_t pin) {
                                    239 ;	-----------------------------------------
                                    240 ;	 function readPin
                                    241 ;	-----------------------------------------
      008305                        242 _readPin:
      008305 52 07            [ 2]  243 	sub	sp, #7
      008307 1F 06            [ 2]  244 	ldw	(0x06, sp), x
      008309 6B 05            [ 1]  245 	ld	(0x05, sp), a
                                    246 ;	../../libs/stm8_GPIO.c: 39: if (*(port +1) & (1 << pin)) {
      00830B 1E 06            [ 2]  247 	ldw	x, (0x06, sp)
      00830D E6 01            [ 1]  248 	ld	a, (0x1, x)
      00830F 88               [ 1]  249 	push	a
      008310 5F               [ 1]  250 	clrw	x
      008311 5C               [ 1]  251 	incw	x
      008312 7B 06            [ 1]  252 	ld	a, (0x06, sp)
      008314 27 04            [ 1]  253 	jreq	00113$
      008316                        254 00112$:
      008316 58               [ 2]  255 	sllw	x
      008317 4A               [ 1]  256 	dec	a
      008318 26 FC            [ 1]  257 	jrne	00112$
      00831A                        258 00113$:
      00831A 84               [ 1]  259 	pop	a
      00831B 6B 02            [ 1]  260 	ld	(0x02, sp), a
      00831D 0F 01            [ 1]  261 	clr	(0x01, sp)
      00831F 9F               [ 1]  262 	ld	a, xl
      008320 14 02            [ 1]  263 	and	a, (0x02, sp)
      008322 6B 04            [ 1]  264 	ld	(0x04, sp), a
      008324 0F 03            [ 1]  265 	clr	(0x03, sp)
      008326 1E 03            [ 2]  266 	ldw	x, (0x03, sp)
      008328 27 03            [ 1]  267 	jreq	00102$
                                    268 ;	../../libs/stm8_GPIO.c: 40: return 1;
      00832A A6 01            [ 1]  269 	ld	a, #0x01
                                    270 ;	../../libs/stm8_GPIO.c: 42: return 0;
      00832C 21                     271 	.byte 0x21
      00832D                        272 00102$:
      00832D 4F               [ 1]  273 	clr	a
      00832E                        274 00103$:
                                    275 ;	../../libs/stm8_GPIO.c: 43: }
      00832E 5B 07            [ 2]  276 	addw	sp, #7
      008330 81               [ 4]  277 	ret
                                    278 	.area CODE
                                    279 	.area CONST
                                    280 	.area INITIALIZER
                                    281 	.area CABS (ABS)
