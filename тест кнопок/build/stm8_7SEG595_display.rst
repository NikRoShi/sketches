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
      00001F                         34 _currentPosition:
      00001F                         35 	.ds 1
      000020                         36 _a:
      000020                         37 	.ds 1
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
      008142                         71 _clear_display:
                                     72 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      008142 4F               [ 1]   73 	clr	a
      008143                         74 00103$:
      008143 A1 08            [ 1]   75 	cp	a, #0x08
      008145 25 01            [ 1]   76 	jrc	00118$
      008147 81               [ 4]   77 	ret
      008148                         78 00118$:
                                     79 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 39: displayBuffer[i] = DISPLAY_BLANK;
      008148 5F               [ 1]   80 	clrw	x
      008149 97               [ 1]   81 	ld	xl, a
      00814A 1C 00 04         [ 2]   82 	addw	x, #(_displayBuffer+0)
      00814D 88               [ 1]   83 	push	a
      00814E A6 FF            [ 1]   84 	ld	a, #0xff
      008150 F7               [ 1]   85 	ld	(x), a
      008151 84               [ 1]   86 	pop	a
                                     87 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      008152 4C               [ 1]   88 	inc	a
      008153 20 EE            [ 2]   89 	jra	00103$
                                     90 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 41: }
      008155 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 43: void init_display(volatile uint8_t *port, uint8_t pin)
                                     93 ;	-----------------------------------------
                                     94 ;	 function init_display
                                     95 ;	-----------------------------------------
      008156                         96 _init_display:
      008156 52 02            [ 2]   97 	sub	sp, #2
      008158 1F 01            [ 2]   98 	ldw	(0x01, sp), x
      00815A C7 00 03         [ 1]   99 	ld	_latchPin+0, a
                                    100 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 45: latchPort = port;
      00815D 1E 01            [ 2]  101 	ldw	x, (0x01, sp)
      00815F CF 00 01         [ 2]  102 	ldw	_latchPort+0, x
                                    103 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: currentPosition = 0;
      008162 72 5F 00 1F      [ 1]  104 	clr	_currentPosition+0
                                    105 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 48: clear_display();
      008166 CD 81 42         [ 4]  106 	call	_clear_display
                                    107 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      008169 4B 04            [ 1]  108 	push	#0x04
      00816B 4B 00            [ 1]  109 	push	#0x00
      00816D 4B 18            [ 1]  110 	push	#0x18
      00816F 4F               [ 1]  111 	clr	a
      008170 CD 88 BA         [ 4]  112 	call	_init_SPI
                                    113 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 51: pinMode(latchPort, latchPin, OUTPUT);
      008173 4B 00            [ 1]  114 	push	#0x00
      008175 C6 00 03         [ 1]  115 	ld	a, _latchPin+0
      008178 CE 00 01         [ 2]  116 	ldw	x, _latchPort+0
      00817B CD 83 0F         [ 4]  117 	call	_pinMode
                                    118 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: writePin(latchPort, latchPin, LOW);
      00817E 4B 00            [ 1]  119 	push	#0x00
      008180 C6 00 03         [ 1]  120 	ld	a, _latchPin+0
      008183 CE 00 01         [ 2]  121 	ldw	x, _latchPort+0
      008186 CD 83 9D         [ 4]  122 	call	_writePin
                                    123 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: }
      008189 5B 02            [ 2]  124 	addw	sp, #2
      00818B 81               [ 4]  125 	ret
                                    126 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 55: void setDigit(uint8_t position, uint8_t digit)
                                    127 ;	-----------------------------------------
                                    128 ;	 function setDigit
                                    129 ;	-----------------------------------------
      00818C                        130 _setDigit:
                                    131 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (position > 7) return;
      00818C A1 07            [ 1]  132 	cp	a, #0x07
      00818E 22 1A            [ 1]  133 	jrugt	00105$
                                    134 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 58: if (digit > 9) return;
      008190 88               [ 1]  135 	push	a
      008191 7B 04            [ 1]  136 	ld	a, (0x04, sp)
      008193 A1 09            [ 1]  137 	cp	a, #0x09
      008195 84               [ 1]  138 	pop	a
      008196 22 12            [ 1]  139 	jrugt	00105$
                                    140 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: displayBuffer[position] = digitTable[digit];
      008198 5F               [ 1]  141 	clrw	x
      008199 97               [ 1]  142 	ld	xl, a
      00819A 1C 00 04         [ 2]  143 	addw	x, #(_displayBuffer+0)
      00819D 90 5F            [ 1]  144 	clrw	y
      00819F 7B 03            [ 1]  145 	ld	a, (0x03, sp)
      0081A1 90 97            [ 1]  146 	ld	yl, a
      0081A3 72 A9 80 90      [ 2]  147 	addw	y, #(_digitTable+0)
      0081A7 90 F6            [ 1]  148 	ld	a, (y)
      0081A9 F7               [ 1]  149 	ld	(x), a
      0081AA                        150 00105$:
                                    151 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: }
      0081AA 85               [ 2]  152 	popw	x
      0081AB 84               [ 1]  153 	pop	a
      0081AC FC               [ 2]  154 	jp	(x)
                                    155 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 62: void refresh_display(void)
                                    156 ;	-----------------------------------------
                                    157 ;	 function refresh_display
                                    158 ;	-----------------------------------------
      0081AD                        159 _refresh_display:
                                    160 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(displayBuffer[currentPosition]);
      0081AD 5F               [ 1]  161 	clrw	x
      0081AE C6 00 1F         [ 1]  162 	ld	a, _currentPosition+0
      0081B1 97               [ 1]  163 	ld	xl, a
      0081B2 D6 00 04         [ 1]  164 	ld	a, (_displayBuffer+0, x)
      0081B5 CD 89 38         [ 4]  165 	call	_write_SPI
                                    166 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 65: write_SPI(positionTable[currentPosition]);
      0081B8 5F               [ 1]  167 	clrw	x
      0081B9 C6 00 1F         [ 1]  168 	ld	a, _currentPosition+0
      0081BC 97               [ 1]  169 	ld	xl, a
      0081BD D6 80 88         [ 1]  170 	ld	a, (_positionTable+0, x)
      0081C0 CD 89 38         [ 4]  171 	call	_write_SPI
                                    172 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, HIGH);
      0081C3 4B 01            [ 1]  173 	push	#0x01
      0081C5 C6 00 03         [ 1]  174 	ld	a, _latchPin+0
      0081C8 CE 00 01         [ 2]  175 	ldw	x, _latchPort+0
      0081CB CD 83 9D         [ 4]  176 	call	_writePin
                                    177 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 68: writePin(latchPort, latchPin, LOW);
      0081CE 4B 00            [ 1]  178 	push	#0x00
      0081D0 C6 00 03         [ 1]  179 	ld	a, _latchPin+0
      0081D3 CE 00 01         [ 2]  180 	ldw	x, _latchPort+0
      0081D6 CD 83 9D         [ 4]  181 	call	_writePin
                                    182 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: currentPosition++;
      0081D9 72 5C 00 1F      [ 1]  183 	inc	_currentPosition+0
                                    184 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: if (currentPosition > 7) currentPosition = 0;
      0081DD C6 00 1F         [ 1]  185 	ld	a, _currentPosition+0
      0081E0 A1 07            [ 1]  186 	cp	a, #0x07
      0081E2 22 01            [ 1]  187 	jrugt	00110$
      0081E4 81               [ 4]  188 	ret
      0081E5                        189 00110$:
      0081E5 72 5F 00 1F      [ 1]  190 	clr	_currentPosition+0
                                    191 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 72: }
      0081E9 81               [ 4]  192 	ret
                                    193 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 73: void printNumber(uint32_t number)
                                    194 ;	-----------------------------------------
                                    195 ;	 function printNumber
                                    196 ;	-----------------------------------------
      0081EA                        197 _printNumber:
                                    198 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 75: while (number)
      0081EA                        199 00101$:
      0081EA 1E 05            [ 2]  200 	ldw	x, (0x05, sp)
      0081EC 26 04            [ 1]  201 	jrne	00116$
      0081EE 1E 03            [ 2]  202 	ldw	x, (0x03, sp)
      0081F0 27 34            [ 1]  203 	jreq	00103$
      0081F2                        204 00116$:
                                    205 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 77: setDigit(a, number % 10);
      0081F2 4B 0A            [ 1]  206 	push	#0x0a
      0081F4 5F               [ 1]  207 	clrw	x
      0081F5 89               [ 2]  208 	pushw	x
      0081F6 4B 00            [ 1]  209 	push	#0x00
      0081F8 1E 09            [ 2]  210 	ldw	x, (0x09, sp)
      0081FA 89               [ 2]  211 	pushw	x
      0081FB 1E 09            [ 2]  212 	ldw	x, (0x09, sp)
      0081FD 89               [ 2]  213 	pushw	x
      0081FE CD 8B 07         [ 4]  214 	call	__modulong
      008201 5B 08            [ 2]  215 	addw	sp, #8
      008203 9F               [ 1]  216 	ld	a, xl
      008204 88               [ 1]  217 	push	a
      008205 C6 00 20         [ 1]  218 	ld	a, _a+0
      008208 CD 81 8C         [ 4]  219 	call	_setDigit
                                    220 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 78: number /= 10;
      00820B 4B 0A            [ 1]  221 	push	#0x0a
      00820D 5F               [ 1]  222 	clrw	x
      00820E 89               [ 2]  223 	pushw	x
      00820F 4B 00            [ 1]  224 	push	#0x00
      008211 1E 09            [ 2]  225 	ldw	x, (0x09, sp)
      008213 89               [ 2]  226 	pushw	x
      008214 1E 09            [ 2]  227 	ldw	x, (0x09, sp)
      008216 89               [ 2]  228 	pushw	x
      008217 CD 8B 6F         [ 4]  229 	call	__divulong
      00821A 5B 08            [ 2]  230 	addw	sp, #8
      00821C 1F 05            [ 2]  231 	ldw	(0x05, sp), x
      00821E 17 03            [ 2]  232 	ldw	(0x03, sp), y
                                    233 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 79: a++;
      008220 72 5C 00 20      [ 1]  234 	inc	_a+0
      008224 20 C4            [ 2]  235 	jra	00101$
      008226                        236 00103$:
                                    237 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 81: a = 0;
      008226 72 5F 00 20      [ 1]  238 	clr	_a+0
                                    239 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 82: }
      00822A 1E 01            [ 2]  240 	ldw	x, (1, sp)
      00822C 5B 06            [ 2]  241 	addw	sp, #6
      00822E FC               [ 2]  242 	jp	(x)
                                    243 	.area CODE
                                    244 	.area CONST
      008088                        245 _positionTable:
      008088 08                     246 	.db #0x08	; 8
      008089 04                     247 	.db #0x04	; 4
      00808A 02                     248 	.db #0x02	; 2
      00808B 01                     249 	.db #0x01	; 1
      00808C 80                     250 	.db #0x80	; 128
      00808D 40                     251 	.db #0x40	; 64
      00808E 20                     252 	.db #0x20	; 32
      00808F 10                     253 	.db #0x10	; 16
      008090                        254 _digitTable:
      008090 C0                     255 	.db #0xc0	; 192
      008091 F9                     256 	.db #0xf9	; 249
      008092 A4                     257 	.db #0xa4	; 164
      008093 B0                     258 	.db #0xb0	; 176
      008094 99                     259 	.db #0x99	; 153
      008095 92                     260 	.db #0x92	; 146
      008096 82                     261 	.db #0x82	; 130
      008097 F8                     262 	.db #0xf8	; 248
      008098 80                     263 	.db #0x80	; 128
      008099 90                     264 	.db #0x90	; 144
                                    265 	.area INITIALIZER
      0080AD                        266 __xinit__currentPosition:
      0080AD 00                     267 	.db #0x00	; 0
      0080AE                        268 __xinit__a:
      0080AE 00                     269 	.db #0x00	; 0
                                    270 	.area CABS (ABS)
