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
      0080A7                         71 _clear_display:
                                     72 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      0080A7 4F               [ 1]   73 	clr	a
      0080A8                         74 00103$:
      0080A8 A1 08            [ 1]   75 	cp	a, #0x08
      0080AA 25 01            [ 1]   76 	jrc	00118$
      0080AC 81               [ 4]   77 	ret
      0080AD                         78 00118$:
                                     79 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 39: displayBuffer[i] = DISPLAY_BLANK;
      0080AD 5F               [ 1]   80 	clrw	x
      0080AE 97               [ 1]   81 	ld	xl, a
      0080AF 1C 00 04         [ 2]   82 	addw	x, #(_displayBuffer+0)
      0080B2 88               [ 1]   83 	push	a
      0080B3 A6 FF            [ 1]   84 	ld	a, #0xff
      0080B5 F7               [ 1]   85 	ld	(x), a
      0080B6 84               [ 1]   86 	pop	a
                                     87 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      0080B7 4C               [ 1]   88 	inc	a
      0080B8 20 EE            [ 2]   89 	jra	00103$
                                     90 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 41: }
      0080BA 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 43: void init_display(volatile uint8_t *port, uint8_t pin)
                                     93 ;	-----------------------------------------
                                     94 ;	 function init_display
                                     95 ;	-----------------------------------------
      0080BB                         96 _init_display:
      0080BB 52 02            [ 2]   97 	sub	sp, #2
      0080BD 1F 01            [ 2]   98 	ldw	(0x01, sp), x
      0080BF C7 00 03         [ 1]   99 	ld	_latchPin+0, a
                                    100 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 45: latchPort = port;
      0080C2 1E 01            [ 2]  101 	ldw	x, (0x01, sp)
      0080C4 CF 00 01         [ 2]  102 	ldw	_latchPort+0, x
                                    103 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: currentPosition = 0;
      0080C7 72 5F 00 0D      [ 1]  104 	clr	_currentPosition+0
                                    105 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 48: clear_display();
      0080CB CD 80 A7         [ 4]  106 	call	_clear_display
                                    107 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      0080CE 4B 04            [ 1]  108 	push	#0x04
      0080D0 4B 00            [ 1]  109 	push	#0x00
      0080D2 4B 18            [ 1]  110 	push	#0x18
      0080D4 4F               [ 1]  111 	clr	a
      0080D5 CD 8A 23         [ 4]  112 	call	_init_SPI
                                    113 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 51: pinMode(latchPort, latchPin, OUTPUT);
      0080D8 4B 00            [ 1]  114 	push	#0x00
      0080DA C6 00 03         [ 1]  115 	ld	a, _latchPin+0
      0080DD CE 00 01         [ 2]  116 	ldw	x, _latchPort+0
      0080E0 CD 82 74         [ 4]  117 	call	_pinMode
                                    118 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: writePin(latchPort, latchPin, LOW);
      0080E3 4B 00            [ 1]  119 	push	#0x00
      0080E5 C6 00 03         [ 1]  120 	ld	a, _latchPin+0
      0080E8 CE 00 01         [ 2]  121 	ldw	x, _latchPort+0
      0080EB CD 83 02         [ 4]  122 	call	_writePin
                                    123 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: }
      0080EE 5B 02            [ 2]  124 	addw	sp, #2
      0080F0 81               [ 4]  125 	ret
                                    126 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 55: void setDigit(uint8_t position, uint8_t digit)
                                    127 ;	-----------------------------------------
                                    128 ;	 function setDigit
                                    129 ;	-----------------------------------------
      0080F1                        130 _setDigit:
                                    131 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (position > 7) return;
      0080F1 A1 07            [ 1]  132 	cp	a, #0x07
      0080F3 22 1A            [ 1]  133 	jrugt	00105$
                                    134 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 58: if (digit > 9) return;
      0080F5 88               [ 1]  135 	push	a
      0080F6 7B 04            [ 1]  136 	ld	a, (0x04, sp)
      0080F8 A1 09            [ 1]  137 	cp	a, #0x09
      0080FA 84               [ 1]  138 	pop	a
      0080FB 22 12            [ 1]  139 	jrugt	00105$
                                    140 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: displayBuffer[position] = digitTable[digit];
      0080FD 5F               [ 1]  141 	clrw	x
      0080FE 97               [ 1]  142 	ld	xl, a
      0080FF 1C 00 04         [ 2]  143 	addw	x, #(_displayBuffer+0)
      008102 90 5F            [ 1]  144 	clrw	y
      008104 7B 03            [ 1]  145 	ld	a, (0x03, sp)
      008106 90 97            [ 1]  146 	ld	yl, a
      008108 72 A9 80 40      [ 2]  147 	addw	y, #(_digitTable+0)
      00810C 90 F6            [ 1]  148 	ld	a, (y)
      00810E F7               [ 1]  149 	ld	(x), a
      00810F                        150 00105$:
                                    151 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: }
      00810F 85               [ 2]  152 	popw	x
      008110 84               [ 1]  153 	pop	a
      008111 FC               [ 2]  154 	jp	(x)
                                    155 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 62: void refresh_display(void)
                                    156 ;	-----------------------------------------
                                    157 ;	 function refresh_display
                                    158 ;	-----------------------------------------
      008112                        159 _refresh_display:
                                    160 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(displayBuffer[currentPosition]);
      008112 5F               [ 1]  161 	clrw	x
      008113 C6 00 0D         [ 1]  162 	ld	a, _currentPosition+0
      008116 97               [ 1]  163 	ld	xl, a
      008117 D6 00 04         [ 1]  164 	ld	a, (_displayBuffer+0, x)
      00811A CD 8A A1         [ 4]  165 	call	_write_SPI
                                    166 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 65: write_SPI(positionTable[currentPosition]);
      00811D 5F               [ 1]  167 	clrw	x
      00811E C6 00 0D         [ 1]  168 	ld	a, _currentPosition+0
      008121 97               [ 1]  169 	ld	xl, a
      008122 D6 80 38         [ 1]  170 	ld	a, (_positionTable+0, x)
      008125 CD 8A A1         [ 4]  171 	call	_write_SPI
                                    172 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, HIGH);
      008128 4B 01            [ 1]  173 	push	#0x01
      00812A C6 00 03         [ 1]  174 	ld	a, _latchPin+0
      00812D CE 00 01         [ 2]  175 	ldw	x, _latchPort+0
      008130 CD 83 02         [ 4]  176 	call	_writePin
                                    177 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 68: writePin(latchPort, latchPin, LOW);
      008133 4B 00            [ 1]  178 	push	#0x00
      008135 C6 00 03         [ 1]  179 	ld	a, _latchPin+0
      008138 CE 00 01         [ 2]  180 	ldw	x, _latchPort+0
      00813B CD 83 02         [ 4]  181 	call	_writePin
                                    182 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: currentPosition++;
      00813E 72 5C 00 0D      [ 1]  183 	inc	_currentPosition+0
                                    184 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: if (currentPosition > 7) currentPosition = 0;
      008142 C6 00 0D         [ 1]  185 	ld	a, _currentPosition+0
      008145 A1 07            [ 1]  186 	cp	a, #0x07
      008147 22 01            [ 1]  187 	jrugt	00110$
      008149 81               [ 4]  188 	ret
      00814A                        189 00110$:
      00814A 72 5F 00 0D      [ 1]  190 	clr	_currentPosition+0
                                    191 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 72: }
      00814E 81               [ 4]  192 	ret
                                    193 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 73: void printNumber(uint32_t number)
                                    194 ;	-----------------------------------------
                                    195 ;	 function printNumber
                                    196 ;	-----------------------------------------
      00814F                        197 _printNumber:
                                    198 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 75: while (number)
      00814F                        199 00101$:
      00814F 1E 05            [ 2]  200 	ldw	x, (0x05, sp)
      008151 26 04            [ 1]  201 	jrne	00116$
      008153 1E 03            [ 2]  202 	ldw	x, (0x03, sp)
      008155 27 34            [ 1]  203 	jreq	00103$
      008157                        204 00116$:
                                    205 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 77: setDigit(a, number % 10);
      008157 4B 0A            [ 1]  206 	push	#0x0a
      008159 5F               [ 1]  207 	clrw	x
      00815A 89               [ 2]  208 	pushw	x
      00815B 4B 00            [ 1]  209 	push	#0x00
      00815D 1E 09            [ 2]  210 	ldw	x, (0x09, sp)
      00815F 89               [ 2]  211 	pushw	x
      008160 1E 09            [ 2]  212 	ldw	x, (0x09, sp)
      008162 89               [ 2]  213 	pushw	x
      008163 CD 8C 8A         [ 4]  214 	call	__modulong
      008166 5B 08            [ 2]  215 	addw	sp, #8
      008168 9F               [ 1]  216 	ld	a, xl
      008169 88               [ 1]  217 	push	a
      00816A C6 00 0E         [ 1]  218 	ld	a, _a+0
      00816D CD 80 F1         [ 4]  219 	call	_setDigit
                                    220 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 78: number /= 10;
      008170 4B 0A            [ 1]  221 	push	#0x0a
      008172 5F               [ 1]  222 	clrw	x
      008173 89               [ 2]  223 	pushw	x
      008174 4B 00            [ 1]  224 	push	#0x00
      008176 1E 09            [ 2]  225 	ldw	x, (0x09, sp)
      008178 89               [ 2]  226 	pushw	x
      008179 1E 09            [ 2]  227 	ldw	x, (0x09, sp)
      00817B 89               [ 2]  228 	pushw	x
      00817C CD 8C F2         [ 4]  229 	call	__divulong
      00817F 5B 08            [ 2]  230 	addw	sp, #8
      008181 1F 05            [ 2]  231 	ldw	(0x05, sp), x
      008183 17 03            [ 2]  232 	ldw	(0x03, sp), y
                                    233 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 79: a++;
      008185 72 5C 00 0E      [ 1]  234 	inc	_a+0
      008189 20 C4            [ 2]  235 	jra	00101$
      00818B                        236 00103$:
                                    237 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 81: a = 0;
      00818B 72 5F 00 0E      [ 1]  238 	clr	_a+0
                                    239 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 82: }
      00818F 1E 01            [ 2]  240 	ldw	x, (1, sp)
      008191 5B 06            [ 2]  241 	addw	sp, #6
      008193 FC               [ 2]  242 	jp	(x)
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
