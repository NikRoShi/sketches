                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_7SEG595_display
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _writePin
                                     12 	.globl _pinMode
                                     13 	.globl _write_SPI
                                     14 	.globl _init_SPI
                                     15 	.globl _clear_display
                                     16 	.globl _init_display
                                     17 	.globl _setDigit
                                     18 	.globl _refresh_display
                                     19 	.globl _printNumber
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
      000001                         24 _latchPort:
      000001                         25 	.ds 2
      000003                         26 _latchPin:
      000003                         27 	.ds 1
      000004                         28 _displayBuffer:
      000004                         29 	.ds 8
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
      00000D                         34 _currentPosition:
      00000D                         35 	.ds 1
      00000E                         36 _a:
      00000E                         37 	.ds 1
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 
                                     43 ; default segment ordering for linker
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area CONST
                                     48 	.area INITIALIZER
                                     49 	.area CODE
                                     50 
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
                                     58 ;--------------------------------------------------------
                                     59 ; Home
                                     60 ;--------------------------------------------------------
                                     61 	.area HOME
                                     62 	.area HOME
                                     63 ;--------------------------------------------------------
                                     64 ; code
                                     65 ;--------------------------------------------------------
                                     66 	.area CODE
                                     67 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 35: void clear_display(void) 
                                     68 ;	-----------------------------------------
                                     69 ;	 function clear_display
                                     70 ;	-----------------------------------------
      008098                         71 _clear_display:
                                     72 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      008098 4F               [ 1]   73 	clr	a
      008099                         74 00103$:
      008099 A1 08            [ 1]   75 	cp	a, #0x08
      00809B 25 01            [ 1]   76 	jrc	00118$
      00809D 81               [ 4]   77 	ret
      00809E                         78 00118$:
                                     79 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 39: displayBuffer[i] = DISPLAY_BLANK;
      00809E 5F               [ 1]   80 	clrw	x
      00809F 97               [ 1]   81 	ld	xl, a
      0080A0 1C 00 04         [ 2]   82 	addw	x, #(_displayBuffer+0)
      0080A3 88               [ 1]   83 	push	a
      0080A4 A6 FF            [ 1]   84 	ld	a, #0xff
      0080A6 F7               [ 1]   85 	ld	(x), a
      0080A7 84               [ 1]   86 	pop	a
                                     87 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      0080A8 4C               [ 1]   88 	inc	a
      0080A9 20 EE            [ 2]   89 	jra	00103$
                                     90 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 41: }
      0080AB 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 43: void init_display(volatile uint8_t *port, uint8_t pin)
                                     93 ;	-----------------------------------------
                                     94 ;	 function init_display
                                     95 ;	-----------------------------------------
      0080AC                         96 _init_display:
      0080AC 52 02            [ 2]   97 	sub	sp, #2
      0080AE 1F 01            [ 2]   98 	ldw	(0x01, sp), x
      0080B0 C7 00 03         [ 1]   99 	ld	_latchPin+0, a
                                    100 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 45: latchPort = port;
      0080B3 1E 01            [ 2]  101 	ldw	x, (0x01, sp)
      0080B5 CF 00 01         [ 2]  102 	ldw	_latchPort+0, x
                                    103 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: currentPosition = 0;
      0080B8 72 5F 00 0D      [ 1]  104 	clr	_currentPosition+0
                                    105 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 48: clear_display();
      0080BC CD 80 98         [ 4]  106 	call	_clear_display
                                    107 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      0080BF 4B 04            [ 1]  108 	push	#0x04
      0080C1 4B 00            [ 1]  109 	push	#0x00
      0080C3 4B 18            [ 1]  110 	push	#0x18
      0080C5 4F               [ 1]  111 	clr	a
      0080C6 CD 8A 71         [ 4]  112 	call	_init_SPI
                                    113 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 51: pinMode(latchPort, latchPin, OUTPUT);
      0080C9 4B 00            [ 1]  114 	push	#0x00
      0080CB C6 00 03         [ 1]  115 	ld	a, _latchPin+0
      0080CE CE 00 01         [ 2]  116 	ldw	x, _latchPort+0
      0080D1 CD 82 65         [ 4]  117 	call	_pinMode
                                    118 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: writePin(latchPort, latchPin, LOW);
      0080D4 4B 00            [ 1]  119 	push	#0x00
      0080D6 C6 00 03         [ 1]  120 	ld	a, _latchPin+0
      0080D9 CE 00 01         [ 2]  121 	ldw	x, _latchPort+0
      0080DC CD 82 F3         [ 4]  122 	call	_writePin
                                    123 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: }
      0080DF 5B 02            [ 2]  124 	addw	sp, #2
      0080E1 81               [ 4]  125 	ret
                                    126 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 55: void setDigit(uint8_t position, uint8_t digit)
                                    127 ;	-----------------------------------------
                                    128 ;	 function setDigit
                                    129 ;	-----------------------------------------
      0080E2                        130 _setDigit:
                                    131 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (position > 7) return;
      0080E2 A1 07            [ 1]  132 	cp	a, #0x07
      0080E4 22 1A            [ 1]  133 	jrugt	00105$
                                    134 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 58: if (digit > 9) return;
      0080E6 88               [ 1]  135 	push	a
      0080E7 7B 04            [ 1]  136 	ld	a, (0x04, sp)
      0080E9 A1 09            [ 1]  137 	cp	a, #0x09
      0080EB 84               [ 1]  138 	pop	a
      0080EC 22 12            [ 1]  139 	jrugt	00105$
                                    140 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: displayBuffer[position] = digitTable[digit];
      0080EE 5F               [ 1]  141 	clrw	x
      0080EF 97               [ 1]  142 	ld	xl, a
      0080F0 1C 00 04         [ 2]  143 	addw	x, #(_displayBuffer+0)
      0080F3 90 5F            [ 1]  144 	clrw	y
      0080F5 7B 03            [ 1]  145 	ld	a, (0x03, sp)
      0080F7 90 97            [ 1]  146 	ld	yl, a
      0080F9 72 A9 80 40      [ 2]  147 	addw	y, #(_digitTable+0)
      0080FD 90 F6            [ 1]  148 	ld	a, (y)
      0080FF F7               [ 1]  149 	ld	(x), a
      008100                        150 00105$:
                                    151 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: }
      008100 85               [ 2]  152 	popw	x
      008101 84               [ 1]  153 	pop	a
      008102 FC               [ 2]  154 	jp	(x)
                                    155 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 62: void refresh_display(void)
                                    156 ;	-----------------------------------------
                                    157 ;	 function refresh_display
                                    158 ;	-----------------------------------------
      008103                        159 _refresh_display:
                                    160 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(displayBuffer[currentPosition]);
      008103 5F               [ 1]  161 	clrw	x
      008104 C6 00 0D         [ 1]  162 	ld	a, _currentPosition+0
      008107 97               [ 1]  163 	ld	xl, a
      008108 D6 00 04         [ 1]  164 	ld	a, (_displayBuffer+0, x)
      00810B CD 8A EF         [ 4]  165 	call	_write_SPI
                                    166 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 65: write_SPI(positionTable[currentPosition]);
      00810E 5F               [ 1]  167 	clrw	x
      00810F C6 00 0D         [ 1]  168 	ld	a, _currentPosition+0
      008112 97               [ 1]  169 	ld	xl, a
      008113 D6 80 38         [ 1]  170 	ld	a, (_positionTable+0, x)
      008116 CD 8A EF         [ 4]  171 	call	_write_SPI
                                    172 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, HIGH);
      008119 4B 01            [ 1]  173 	push	#0x01
      00811B C6 00 03         [ 1]  174 	ld	a, _latchPin+0
      00811E CE 00 01         [ 2]  175 	ldw	x, _latchPort+0
      008121 CD 82 F3         [ 4]  176 	call	_writePin
                                    177 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 68: writePin(latchPort, latchPin, LOW);
      008124 4B 00            [ 1]  178 	push	#0x00
      008126 C6 00 03         [ 1]  179 	ld	a, _latchPin+0
      008129 CE 00 01         [ 2]  180 	ldw	x, _latchPort+0
      00812C CD 82 F3         [ 4]  181 	call	_writePin
                                    182 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: currentPosition++;
      00812F 72 5C 00 0D      [ 1]  183 	inc	_currentPosition+0
                                    184 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: if (currentPosition > 7) currentPosition = 0;
      008133 C6 00 0D         [ 1]  185 	ld	a, _currentPosition+0
      008136 A1 07            [ 1]  186 	cp	a, #0x07
      008138 22 01            [ 1]  187 	jrugt	00110$
      00813A 81               [ 4]  188 	ret
      00813B                        189 00110$:
      00813B 72 5F 00 0D      [ 1]  190 	clr	_currentPosition+0
                                    191 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 72: }
      00813F 81               [ 4]  192 	ret
                                    193 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 73: void printNumber(uint32_t number)
                                    194 ;	-----------------------------------------
                                    195 ;	 function printNumber
                                    196 ;	-----------------------------------------
      008140                        197 _printNumber:
                                    198 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 75: while (number)
      008140                        199 00101$:
      008140 1E 05            [ 2]  200 	ldw	x, (0x05, sp)
      008142 26 04            [ 1]  201 	jrne	00116$
      008144 1E 03            [ 2]  202 	ldw	x, (0x03, sp)
      008146 27 34            [ 1]  203 	jreq	00103$
      008148                        204 00116$:
                                    205 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 77: setDigit(a, number % 10);
      008148 4B 0A            [ 1]  206 	push	#0x0a
      00814A 5F               [ 1]  207 	clrw	x
      00814B 89               [ 2]  208 	pushw	x
      00814C 4B 00            [ 1]  209 	push	#0x00
      00814E 1E 09            [ 2]  210 	ldw	x, (0x09, sp)
      008150 89               [ 2]  211 	pushw	x
      008151 1E 09            [ 2]  212 	ldw	x, (0x09, sp)
      008153 89               [ 2]  213 	pushw	x
      008154 CD 8C D8         [ 4]  214 	call	__modulong
      008157 5B 08            [ 2]  215 	addw	sp, #8
      008159 9F               [ 1]  216 	ld	a, xl
      00815A 88               [ 1]  217 	push	a
      00815B C6 00 0E         [ 1]  218 	ld	a, _a+0
      00815E CD 80 E2         [ 4]  219 	call	_setDigit
                                    220 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 78: number /= 10;
      008161 4B 0A            [ 1]  221 	push	#0x0a
      008163 5F               [ 1]  222 	clrw	x
      008164 89               [ 2]  223 	pushw	x
      008165 4B 00            [ 1]  224 	push	#0x00
      008167 1E 09            [ 2]  225 	ldw	x, (0x09, sp)
      008169 89               [ 2]  226 	pushw	x
      00816A 1E 09            [ 2]  227 	ldw	x, (0x09, sp)
      00816C 89               [ 2]  228 	pushw	x
      00816D CD 8D 40         [ 4]  229 	call	__divulong
      008170 5B 08            [ 2]  230 	addw	sp, #8
      008172 1F 05            [ 2]  231 	ldw	(0x05, sp), x
      008174 17 03            [ 2]  232 	ldw	(0x03, sp), y
                                    233 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 79: a++;
      008176 72 5C 00 0E      [ 1]  234 	inc	_a+0
      00817A 20 C4            [ 2]  235 	jra	00101$
      00817C                        236 00103$:
                                    237 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 81: a = 0;
      00817C 72 5F 00 0E      [ 1]  238 	clr	_a+0
                                    239 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 82: }
      008180 1E 01            [ 2]  240 	ldw	x, (1, sp)
      008182 5B 06            [ 2]  241 	addw	sp, #6
      008184 FC               [ 2]  242 	jp	(x)
                                    243 	.area CODE
                                    244 	.area CONST
      008038                        245 _positionTable:
      008038 08                     246 	.db #0x08	; 8
      008039 04                     247 	.db #0x04	; 4
      00803A 02                     248 	.db #0x02	; 2
      00803B 01                     249 	.db #0x01	; 1
      00803C 80                     250 	.db #0x80	; 128
      00803D 40                     251 	.db #0x40	; 64
      00803E 20                     252 	.db #0x20	; 32
      00803F 10                     253 	.db #0x10	; 16
      008040                        254 _digitTable:
      008040 C0                     255 	.db #0xc0	; 192
      008041 F9                     256 	.db #0xf9	; 249
      008042 A4                     257 	.db #0xa4	; 164
      008043 B0                     258 	.db #0xb0	; 176
      008044 99                     259 	.db #0x99	; 153
      008045 92                     260 	.db #0x92	; 146
      008046 82                     261 	.db #0x82	; 130
      008047 F8                     262 	.db #0xf8	; 248
      008048 80                     263 	.db #0x80	; 128
      008049 90                     264 	.db #0x90	; 144
                                    265 	.area INITIALIZER
      00804B                        266 __xinit__currentPosition:
      00804B 00                     267 	.db #0x00	; 0
      00804C                        268 __xinit__a:
      00804C 00                     269 	.db #0x00	; 0
                                    270 	.area CABS (ABS)
