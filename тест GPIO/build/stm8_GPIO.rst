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
      0080FA                         55 _pinMode:
      0080FA 52 06            [ 2]   56 	sub	sp, #6
                                     57 ;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      0080FC 1F 05            [ 2]   58 	ldw	(0x05, sp), x
      0080FE 5C               [ 1]   59 	incw	x
      0080FF 5C               [ 1]   60 	incw	x
      008100 88               [ 1]   61 	push	a
      008101 A6 01            [ 1]   62 	ld	a, #0x01
      008103 6B 02            [ 1]   63 	ld	(0x02, sp), a
      008105 84               [ 1]   64 	pop	a
      008106 4D               [ 1]   65 	tnz	a
      008107 27 05            [ 1]   66 	jreq	00143$
      008109                         67 00142$:
      008109 08 01            [ 1]   68 	sll	(0x01, sp)
      00810B 4A               [ 1]   69 	dec	a
      00810C 26 FB            [ 1]   70 	jrne	00142$
      00810E                         71 00143$:
                                     72 ;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      00810E 16 05            [ 2]   73 	ldw	y, (0x05, sp)
      008110 72 A9 00 03      [ 2]   74 	addw	y, #0x0003
      008114 17 02            [ 2]   75 	ldw	(0x02, sp), y
                                     76 ;	../../libs/stm8_GPIO.c: 4: if (mode == OUTPUT) {
      008116 0D 09            [ 1]   77 	tnz	(0x09, sp)
      008118 26 0E            [ 1]   78 	jrne	00110$
                                     79 ;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
      00811A F6               [ 1]   80 	ld	a, (x)
      00811B 1A 01            [ 1]   81 	or	a, (0x01, sp)
      00811D F7               [ 1]   82 	ld	(x), a
                                     83 ;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
      00811E 1E 02            [ 2]   84 	ldw	x, (0x02, sp)
      008120 F6               [ 1]   85 	ld	a, (x)
      008121 1A 01            [ 1]   86 	or	a, (0x01, sp)
      008123 1E 02            [ 2]   87 	ldw	x, (0x02, sp)
      008125 F7               [ 1]   88 	ld	(x), a
      008126 20 47            [ 2]   89 	jra	00112$
      008128                         90 00110$:
                                     91 ;	../../libs/stm8_GPIO.c: 8: else if (mode == OUTPUT_FAST) {
      008128 7B 09            [ 1]   92 	ld	a, (0x09, sp)
      00812A 4A               [ 1]   93 	dec	a
      00812B 26 17            [ 1]   94 	jrne	00107$
                                     95 ;	../../libs/stm8_GPIO.c: 9: *(port + 2) |= (1 << pin);
      00812D F6               [ 1]   96 	ld	a, (x)
      00812E 1A 01            [ 1]   97 	or	a, (0x01, sp)
      008130 F7               [ 1]   98 	ld	(x), a
                                     99 ;	../../libs/stm8_GPIO.c: 10: *(port + 3) |= (1 << pin);
      008131 1E 02            [ 2]  100 	ldw	x, (0x02, sp)
      008133 F6               [ 1]  101 	ld	a, (x)
      008134 1A 01            [ 1]  102 	or	a, (0x01, sp)
      008136 1E 02            [ 2]  103 	ldw	x, (0x02, sp)
      008138 F7               [ 1]  104 	ld	(x), a
                                    105 ;	../../libs/stm8_GPIO.c: 11: *(port + 4) |= (1 << pin);
      008139 1E 05            [ 2]  106 	ldw	x, (0x05, sp)
      00813B 1C 00 04         [ 2]  107 	addw	x, #0x0004
      00813E F6               [ 1]  108 	ld	a, (x)
      00813F 1A 01            [ 1]  109 	or	a, (0x01, sp)
      008141 F7               [ 1]  110 	ld	(x), a
      008142 20 2B            [ 2]  111 	jra	00112$
      008144                        112 00107$:
                                    113 ;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      008144 7B 01            [ 1]  114 	ld	a, (0x01, sp)
      008146 43               [ 1]  115 	cpl	a
      008147 6B 04            [ 1]  116 	ld	(0x04, sp), a
                                    117 ;	../../libs/stm8_GPIO.c: 13: else if (mode == INPUT) {
      008149 7B 09            [ 1]  118 	ld	a, (0x09, sp)
      00814B A1 02            [ 1]  119 	cp	a, #0x02
      00814D 26 0E            [ 1]  120 	jrne	00104$
                                    121 ;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
      00814F F6               [ 1]  122 	ld	a, (x)
      008150 14 04            [ 1]  123 	and	a, (0x04, sp)
      008152 F7               [ 1]  124 	ld	(x), a
                                    125 ;	../../libs/stm8_GPIO.c: 15: *(port + 3) &= ~(1 << pin);
      008153 1E 02            [ 2]  126 	ldw	x, (0x02, sp)
      008155 F6               [ 1]  127 	ld	a, (x)
      008156 14 04            [ 1]  128 	and	a, (0x04, sp)
      008158 1E 02            [ 2]  129 	ldw	x, (0x02, sp)
      00815A F7               [ 1]  130 	ld	(x), a
      00815B 20 12            [ 2]  131 	jra	00112$
      00815D                        132 00104$:
                                    133 ;	../../libs/stm8_GPIO.c: 17: else if (mode == INPUT_PULLUP) {
      00815D 7B 09            [ 1]  134 	ld	a, (0x09, sp)
      00815F A1 03            [ 1]  135 	cp	a, #0x03
      008161 26 0C            [ 1]  136 	jrne	00112$
                                    137 ;	../../libs/stm8_GPIO.c: 18: *(port + 2) &= ~(1 << pin);
      008163 F6               [ 1]  138 	ld	a, (x)
      008164 14 04            [ 1]  139 	and	a, (0x04, sp)
      008166 F7               [ 1]  140 	ld	(x), a
                                    141 ;	../../libs/stm8_GPIO.c: 19: *(port + 3) |= (1 << pin);
      008167 1E 02            [ 2]  142 	ldw	x, (0x02, sp)
      008169 F6               [ 1]  143 	ld	a, (x)
      00816A 1A 01            [ 1]  144 	or	a, (0x01, sp)
      00816C 1E 02            [ 2]  145 	ldw	x, (0x02, sp)
      00816E F7               [ 1]  146 	ld	(x), a
      00816F                        147 00112$:
                                    148 ;	../../libs/stm8_GPIO.c: 21: }
      00816F 5B 06            [ 2]  149 	addw	sp, #6
      008171 85               [ 2]  150 	popw	x
      008172 84               [ 1]  151 	pop	a
      008173 FC               [ 2]  152 	jp	(x)
                                    153 ;	../../libs/stm8_GPIO.c: 23: void writePin(volatile uint8_t* port, uint8_t pin, uint8_t state) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function writePin
                                    156 ;	-----------------------------------------
      008174                        157 _writePin:
      008174 52 04            [ 2]  158 	sub	sp, #4
                                    159 ;	../../libs/stm8_GPIO.c: 25: *port |= (1 << pin);
      008176 1F 03            [ 2]  160 	ldw	(0x03, sp), x
      008178 88               [ 1]  161 	push	a
      008179 A6 01            [ 1]  162 	ld	a, #0x01
      00817B 6B 02            [ 1]  163 	ld	(0x02, sp), a
      00817D 84               [ 1]  164 	pop	a
      00817E 4D               [ 1]  165 	tnz	a
      00817F 27 05            [ 1]  166 	jreq	00114$
      008181                        167 00113$:
      008181 08 01            [ 1]  168 	sll	(0x01, sp)
      008183 4A               [ 1]  169 	dec	a
      008184 26 FB            [ 1]  170 	jrne	00113$
      008186                        171 00114$:
      008186 F6               [ 1]  172 	ld	a, (x)
      008187 6B 02            [ 1]  173 	ld	(0x02, sp), a
                                    174 ;	../../libs/stm8_GPIO.c: 24: if (state == HIGH) {
      008189 7B 07            [ 1]  175 	ld	a, (0x07, sp)
      00818B 4A               [ 1]  176 	dec	a
      00818C 26 07            [ 1]  177 	jrne	00102$
                                    178 ;	../../libs/stm8_GPIO.c: 25: *port |= (1 << pin);
      00818E 7B 02            [ 1]  179 	ld	a, (0x02, sp)
      008190 1A 01            [ 1]  180 	or	a, (0x01, sp)
      008192 F7               [ 1]  181 	ld	(x), a
      008193 20 06            [ 2]  182 	jra	00104$
      008195                        183 00102$:
                                    184 ;	../../libs/stm8_GPIO.c: 27: else {*port &= ~(1 << pin);}
      008195 7B 01            [ 1]  185 	ld	a, (0x01, sp)
      008197 43               [ 1]  186 	cpl	a
      008198 14 02            [ 1]  187 	and	a, (0x02, sp)
      00819A F7               [ 1]  188 	ld	(x), a
      00819B                        189 00104$:
                                    190 ;	../../libs/stm8_GPIO.c: 28: }
      00819B 5B 04            [ 2]  191 	addw	sp, #4
      00819D 85               [ 2]  192 	popw	x
      00819E 84               [ 1]  193 	pop	a
      00819F FC               [ 2]  194 	jp	(x)
                                    195 ;	../../libs/stm8_GPIO.c: 30: void togglePin(volatile uint8_t* port, uint8_t pin) {
                                    196 ;	-----------------------------------------
                                    197 ;	 function togglePin
                                    198 ;	-----------------------------------------
      0081A0                        199 _togglePin:
      0081A0 52 04            [ 2]  200 	sub	sp, #4
      0081A2 1F 03            [ 2]  201 	ldw	(0x03, sp), x
      0081A4 6B 02            [ 1]  202 	ld	(0x02, sp), a
                                    203 ;	../../libs/stm8_GPIO.c: 31: *port ^= (1 << pin);
      0081A6 1E 03            [ 2]  204 	ldw	x, (0x03, sp)
      0081A8 F6               [ 1]  205 	ld	a, (x)
      0081A9 88               [ 1]  206 	push	a
      0081AA A6 01            [ 1]  207 	ld	a, #0x01
      0081AC 6B 02            [ 1]  208 	ld	(0x02, sp), a
      0081AE 7B 03            [ 1]  209 	ld	a, (0x03, sp)
      0081B0 27 05            [ 1]  210 	jreq	00104$
      0081B2                        211 00103$:
      0081B2 08 02            [ 1]  212 	sll	(0x02, sp)
      0081B4 4A               [ 1]  213 	dec	a
      0081B5 26 FB            [ 1]  214 	jrne	00103$
      0081B7                        215 00104$:
      0081B7 84               [ 1]  216 	pop	a
      0081B8 18 01            [ 1]  217 	xor	a, (0x01, sp)
      0081BA F7               [ 1]  218 	ld	(x), a
                                    219 ;	../../libs/stm8_GPIO.c: 32: }
      0081BB 5B 04            [ 2]  220 	addw	sp, #4
      0081BD 81               [ 4]  221 	ret
                                    222 ;	../../libs/stm8_GPIO.c: 34: uint8_t readPin(volatile uint8_t* port, uint8_t pin) {
                                    223 ;	-----------------------------------------
                                    224 ;	 function readPin
                                    225 ;	-----------------------------------------
      0081BE                        226 _readPin:
      0081BE 52 07            [ 2]  227 	sub	sp, #7
      0081C0 1F 06            [ 2]  228 	ldw	(0x06, sp), x
      0081C2 6B 05            [ 1]  229 	ld	(0x05, sp), a
                                    230 ;	../../libs/stm8_GPIO.c: 35: if (*(port +1) & (1 << pin)) {
      0081C4 1E 06            [ 2]  231 	ldw	x, (0x06, sp)
      0081C6 E6 01            [ 1]  232 	ld	a, (0x1, x)
      0081C8 88               [ 1]  233 	push	a
      0081C9 5F               [ 1]  234 	clrw	x
      0081CA 5C               [ 1]  235 	incw	x
      0081CB 7B 06            [ 1]  236 	ld	a, (0x06, sp)
      0081CD 27 04            [ 1]  237 	jreq	00113$
      0081CF                        238 00112$:
      0081CF 58               [ 2]  239 	sllw	x
      0081D0 4A               [ 1]  240 	dec	a
      0081D1 26 FC            [ 1]  241 	jrne	00112$
      0081D3                        242 00113$:
      0081D3 84               [ 1]  243 	pop	a
      0081D4 6B 02            [ 1]  244 	ld	(0x02, sp), a
      0081D6 0F 01            [ 1]  245 	clr	(0x01, sp)
      0081D8 9F               [ 1]  246 	ld	a, xl
      0081D9 14 02            [ 1]  247 	and	a, (0x02, sp)
      0081DB 6B 04            [ 1]  248 	ld	(0x04, sp), a
      0081DD 0F 03            [ 1]  249 	clr	(0x03, sp)
      0081DF 1E 03            [ 2]  250 	ldw	x, (0x03, sp)
      0081E1 27 03            [ 1]  251 	jreq	00102$
                                    252 ;	../../libs/stm8_GPIO.c: 36: return 1;
      0081E3 A6 01            [ 1]  253 	ld	a, #0x01
                                    254 ;	../../libs/stm8_GPIO.c: 38: return 0;
      0081E5 21                     255 	.byte 0x21
      0081E6                        256 00102$:
      0081E6 4F               [ 1]  257 	clr	a
      0081E7                        258 00103$:
                                    259 ;	../../libs/stm8_GPIO.c: 39: }
      0081E7 5B 07            [ 2]  260 	addw	sp, #7
      0081E9 81               [ 4]  261 	ret
                                    262 	.area CODE
                                    263 	.area CONST
                                    264 	.area INITIALIZER
                                    265 	.area CABS (ABS)
