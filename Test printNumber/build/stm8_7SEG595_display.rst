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
      00000C                         34 _currentPosition:
      00000C                         35 	.ds 1
      00000D                         36 _a:
      00000D                         37 	.ds 1
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
      0080F6                         71 _clear_display:
                                     72 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      0080F6 4F               [ 1]   73 	clr	a
      0080F7                         74 00103$:
      0080F7 A1 08            [ 1]   75 	cp	a, #0x08
      0080F9 25 01            [ 1]   76 	jrc	00118$
      0080FB 81               [ 4]   77 	ret
      0080FC                         78 00118$:
                                     79 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 39: displayBuffer[i] = DISPLAY_BLANK;
      0080FC 5F               [ 1]   80 	clrw	x
      0080FD 97               [ 1]   81 	ld	xl, a
      0080FE 1C 00 04         [ 2]   82 	addw	x, #(_displayBuffer+0)
      008101 88               [ 1]   83 	push	a
      008102 A6 FF            [ 1]   84 	ld	a, #0xff
      008104 F7               [ 1]   85 	ld	(x), a
      008105 84               [ 1]   86 	pop	a
                                     87 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
      008106 4C               [ 1]   88 	inc	a
      008107 20 EE            [ 2]   89 	jra	00103$
                                     90 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 41: }
      008109 81               [ 4]   91 	ret
                                     92 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 43: void init_display(volatile uint8_t *port, uint8_t pin)
                                     93 ;	-----------------------------------------
                                     94 ;	 function init_display
                                     95 ;	-----------------------------------------
      00810A                         96 _init_display:
      00810A 52 02            [ 2]   97 	sub	sp, #2
      00810C 1F 01            [ 2]   98 	ldw	(0x01, sp), x
      00810E C7 00 03         [ 1]   99 	ld	_latchPin+0, a
                                    100 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 45: latchPort = port;
      008111 1E 01            [ 2]  101 	ldw	x, (0x01, sp)
      008113 CF 00 01         [ 2]  102 	ldw	_latchPort+0, x
                                    103 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: currentPosition = 0;
      008116 72 5F 00 0C      [ 1]  104 	clr	_currentPosition+0
                                    105 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 48: clear_display();
      00811A CD 80 F6         [ 4]  106 	call	_clear_display
                                    107 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      00811D 4B 04            [ 1]  108 	push	#0x04
      00811F 4B 00            [ 1]  109 	push	#0x00
      008121 4B 18            [ 1]  110 	push	#0x18
      008123 4F               [ 1]  111 	clr	a
      008124 CD 88 6E         [ 4]  112 	call	_init_SPI
                                    113 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 51: pinMode(latchPort, latchPin, OUTPUT);
      008127 4B 00            [ 1]  114 	push	#0x00
      008129 C6 00 03         [ 1]  115 	ld	a, _latchPin+0
      00812C CE 00 01         [ 2]  116 	ldw	x, _latchPort+0
      00812F CD 82 C3         [ 4]  117 	call	_pinMode
                                    118 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: writePin(latchPort, latchPin, LOW);
      008132 4B 00            [ 1]  119 	push	#0x00
      008134 C6 00 03         [ 1]  120 	ld	a, _latchPin+0
      008137 CE 00 01         [ 2]  121 	ldw	x, _latchPort+0
      00813A CD 83 51         [ 4]  122 	call	_writePin
                                    123 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: }
      00813D 5B 02            [ 2]  124 	addw	sp, #2
      00813F 81               [ 4]  125 	ret
                                    126 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 55: void setDigit(uint8_t position, uint8_t digit)
                                    127 ;	-----------------------------------------
                                    128 ;	 function setDigit
                                    129 ;	-----------------------------------------
      008140                        130 _setDigit:
                                    131 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (position > 7) return;
      008140 A1 07            [ 1]  132 	cp	a, #0x07
      008142 22 1A            [ 1]  133 	jrugt	00105$
                                    134 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 58: if (digit > 9) return;
      008144 88               [ 1]  135 	push	a
      008145 7B 04            [ 1]  136 	ld	a, (0x04, sp)
      008147 A1 09            [ 1]  137 	cp	a, #0x09
      008149 84               [ 1]  138 	pop	a
      00814A 22 12            [ 1]  139 	jrugt	00105$
                                    140 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: displayBuffer[position] = digitTable[digit];
      00814C 5F               [ 1]  141 	clrw	x
      00814D 97               [ 1]  142 	ld	xl, a
      00814E 1C 00 04         [ 2]  143 	addw	x, #(_displayBuffer+0)
      008151 90 5F            [ 1]  144 	clrw	y
      008153 7B 03            [ 1]  145 	ld	a, (0x03, sp)
      008155 90 97            [ 1]  146 	ld	yl, a
      008157 72 A9 80 90      [ 2]  147 	addw	y, #(_digitTable+0)
      00815B 90 F6            [ 1]  148 	ld	a, (y)
      00815D F7               [ 1]  149 	ld	(x), a
      00815E                        150 00105$:
                                    151 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: }
      00815E 85               [ 2]  152 	popw	x
      00815F 84               [ 1]  153 	pop	a
      008160 FC               [ 2]  154 	jp	(x)
                                    155 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 62: void refresh_display(void)
                                    156 ;	-----------------------------------------
                                    157 ;	 function refresh_display
                                    158 ;	-----------------------------------------
      008161                        159 _refresh_display:
                                    160 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(displayBuffer[currentPosition]);
      008161 5F               [ 1]  161 	clrw	x
      008162 C6 00 0C         [ 1]  162 	ld	a, _currentPosition+0
      008165 97               [ 1]  163 	ld	xl, a
      008166 D6 00 04         [ 1]  164 	ld	a, (_displayBuffer+0, x)
      008169 CD 88 EC         [ 4]  165 	call	_write_SPI
                                    166 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 65: write_SPI(positionTable[currentPosition]);
      00816C 5F               [ 1]  167 	clrw	x
      00816D C6 00 0C         [ 1]  168 	ld	a, _currentPosition+0
      008170 97               [ 1]  169 	ld	xl, a
      008171 D6 80 88         [ 1]  170 	ld	a, (_positionTable+0, x)
      008174 CD 88 EC         [ 4]  171 	call	_write_SPI
                                    172 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, HIGH);
      008177 4B 01            [ 1]  173 	push	#0x01
      008179 C6 00 03         [ 1]  174 	ld	a, _latchPin+0
      00817C CE 00 01         [ 2]  175 	ldw	x, _latchPort+0
      00817F CD 83 51         [ 4]  176 	call	_writePin
                                    177 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 68: writePin(latchPort, latchPin, LOW);
      008182 4B 00            [ 1]  178 	push	#0x00
      008184 C6 00 03         [ 1]  179 	ld	a, _latchPin+0
      008187 CE 00 01         [ 2]  180 	ldw	x, _latchPort+0
      00818A CD 83 51         [ 4]  181 	call	_writePin
                                    182 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: currentPosition++;
      00818D 72 5C 00 0C      [ 1]  183 	inc	_currentPosition+0
                                    184 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: if (currentPosition > 7) currentPosition = 0;
      008191 C6 00 0C         [ 1]  185 	ld	a, _currentPosition+0
      008194 A1 07            [ 1]  186 	cp	a, #0x07
      008196 22 01            [ 1]  187 	jrugt	00110$
      008198 81               [ 4]  188 	ret
      008199                        189 00110$:
      008199 72 5F 00 0C      [ 1]  190 	clr	_currentPosition+0
                                    191 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 72: }
      00819D 81               [ 4]  192 	ret
                                    193 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 73: void printNumber(uint32_t number)
                                    194 ;	-----------------------------------------
                                    195 ;	 function printNumber
                                    196 ;	-----------------------------------------
      00819E                        197 _printNumber:
                                    198 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 75: while (number)
      00819E                        199 00101$:
      00819E 1E 05            [ 2]  200 	ldw	x, (0x05, sp)
      0081A0 26 04            [ 1]  201 	jrne	00116$
      0081A2 1E 03            [ 2]  202 	ldw	x, (0x03, sp)
      0081A4 27 34            [ 1]  203 	jreq	00103$
      0081A6                        204 00116$:
                                    205 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 77: setDigit(a, number % 10);
      0081A6 4B 0A            [ 1]  206 	push	#0x0a
      0081A8 5F               [ 1]  207 	clrw	x
      0081A9 89               [ 2]  208 	pushw	x
      0081AA 4B 00            [ 1]  209 	push	#0x00
      0081AC 1E 09            [ 2]  210 	ldw	x, (0x09, sp)
      0081AE 89               [ 2]  211 	pushw	x
      0081AF 1E 09            [ 2]  212 	ldw	x, (0x09, sp)
      0081B1 89               [ 2]  213 	pushw	x
      0081B2 CD 8A BB         [ 4]  214 	call	__modulong
      0081B5 5B 08            [ 2]  215 	addw	sp, #8
      0081B7 9F               [ 1]  216 	ld	a, xl
      0081B8 88               [ 1]  217 	push	a
      0081B9 C6 00 0D         [ 1]  218 	ld	a, _a+0
      0081BC CD 81 40         [ 4]  219 	call	_setDigit
                                    220 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 78: number /= 10;
      0081BF 4B 0A            [ 1]  221 	push	#0x0a
      0081C1 5F               [ 1]  222 	clrw	x
      0081C2 89               [ 2]  223 	pushw	x
      0081C3 4B 00            [ 1]  224 	push	#0x00
      0081C5 1E 09            [ 2]  225 	ldw	x, (0x09, sp)
      0081C7 89               [ 2]  226 	pushw	x
      0081C8 1E 09            [ 2]  227 	ldw	x, (0x09, sp)
      0081CA 89               [ 2]  228 	pushw	x
      0081CB CD 8B 23         [ 4]  229 	call	__divulong
      0081CE 5B 08            [ 2]  230 	addw	sp, #8
      0081D0 1F 05            [ 2]  231 	ldw	(0x05, sp), x
      0081D2 17 03            [ 2]  232 	ldw	(0x03, sp), y
                                    233 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 79: a++;
      0081D4 72 5C 00 0D      [ 1]  234 	inc	_a+0
      0081D8 20 C4            [ 2]  235 	jra	00101$
      0081DA                        236 00103$:
                                    237 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 81: a = 0;
      0081DA 72 5F 00 0D      [ 1]  238 	clr	_a+0
                                    239 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 82: }
      0081DE 1E 01            [ 2]  240 	ldw	x, (1, sp)
      0081E0 5B 06            [ 2]  241 	addw	sp, #6
      0081E2 FC               [ 2]  242 	jp	(x)
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
      00809A                        266 __xinit__currentPosition:
      00809A 00                     267 	.db #0x00	; 0
      00809B                        268 __xinit__a:
      00809B 00                     269 	.db #0x00	; 0
                                    270 	.area CABS (ABS)
