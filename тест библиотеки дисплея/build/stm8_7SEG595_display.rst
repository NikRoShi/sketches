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
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
      000001                         23 _latchPort:
      000001                         24 	.ds 2
      000003                         25 _latchPin:
      000003                         26 	.ds 1
      000004                         27 _displayBuffer:
      000004                         28 	.ds 8
                                     29 ;--------------------------------------------------------
                                     30 ; ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area INITIALIZED
      00000C                         33 _currentPosition:
      00000C                         34 	.ds 1
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; global & static initialisations
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area GSINIT
                                     53 	.area GSFINAL
                                     54 	.area GSINIT
                                     55 ;--------------------------------------------------------
                                     56 ; Home
                                     57 ;--------------------------------------------------------
                                     58 	.area HOME
                                     59 	.area HOME
                                     60 ;--------------------------------------------------------
                                     61 ; code
                                     62 ;--------------------------------------------------------
                                     63 	.area CODE
                                     64 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 34: void clear_display(void) 
                                     65 ;	-----------------------------------------
                                     66 ;	 function clear_display
                                     67 ;	-----------------------------------------
      0080F1                         68 _clear_display:
                                     69 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 36: for (uint8_t i = 0; i < 8; i++)
      0080F1 4F               [ 1]   70 	clr	a
      0080F2                         71 00103$:
      0080F2 A1 08            [ 1]   72 	cp	a, #0x08
      0080F4 25 01            [ 1]   73 	jrc	00118$
      0080F6 81               [ 4]   74 	ret
      0080F7                         75 00118$:
                                     76 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 38: displayBuffer[i] = DISPLAY_BLANK;
      0080F7 5F               [ 1]   77 	clrw	x
      0080F8 97               [ 1]   78 	ld	xl, a
      0080F9 1C 00 04         [ 2]   79 	addw	x, #(_displayBuffer+0)
      0080FC 88               [ 1]   80 	push	a
      0080FD A6 FF            [ 1]   81 	ld	a, #0xff
      0080FF F7               [ 1]   82 	ld	(x), a
      008100 84               [ 1]   83 	pop	a
                                     84 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 36: for (uint8_t i = 0; i < 8; i++)
      008101 4C               [ 1]   85 	inc	a
      008102 20 EE            [ 2]   86 	jra	00103$
                                     87 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 40: }
      008104 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 42: void init_display(volatile uint8_t *port, uint8_t pin)
                                     90 ;	-----------------------------------------
                                     91 ;	 function init_display
                                     92 ;	-----------------------------------------
      008105                         93 _init_display:
      008105 52 02            [ 2]   94 	sub	sp, #2
      008107 1F 01            [ 2]   95 	ldw	(0x01, sp), x
      008109 C7 00 03         [ 1]   96 	ld	_latchPin+0, a
                                     97 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 44: latchPort = port;
      00810C 1E 01            [ 2]   98 	ldw	x, (0x01, sp)
      00810E CF 00 01         [ 2]   99 	ldw	_latchPort+0, x
                                    100 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 46: currentPosition = 0;
      008111 72 5F 00 0C      [ 1]  101 	clr	_currentPosition+0
                                    102 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: clear_display();
      008115 CD 80 F1         [ 4]  103 	call	_clear_display
                                    104 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 49: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      008118 4B 04            [ 1]  105 	push	#0x04
      00811A 4B 00            [ 1]  106 	push	#0x00
      00811C 4B 18            [ 1]  107 	push	#0x18
      00811E 4F               [ 1]  108 	clr	a
      00811F CD 88 24         [ 4]  109 	call	_init_SPI
                                    110 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: pinMode(latchPort, latchPin, OUTPUT);
      008122 4B 00            [ 1]  111 	push	#0x00
      008124 C6 00 03         [ 1]  112 	ld	a, _latchPin+0
      008127 CE 00 01         [ 2]  113 	ldw	x, _latchPort+0
      00812A CD 82 79         [ 4]  114 	call	_pinMode
                                    115 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 52: writePin(latchPort, latchPin, LOW);
      00812D 4B 00            [ 1]  116 	push	#0x00
      00812F C6 00 03         [ 1]  117 	ld	a, _latchPin+0
      008132 CE 00 01         [ 2]  118 	ldw	x, _latchPort+0
      008135 CD 83 07         [ 4]  119 	call	_writePin
                                    120 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: }
      008138 5B 02            [ 2]  121 	addw	sp, #2
      00813A 81               [ 4]  122 	ret
                                    123 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: void setDigit(uint8_t position, uint8_t digit)
                                    124 ;	-----------------------------------------
                                    125 ;	 function setDigit
                                    126 ;	-----------------------------------------
      00813B                        127 _setDigit:
                                    128 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 56: if (position > 7) return;
      00813B A1 07            [ 1]  129 	cp	a, #0x07
      00813D 22 1A            [ 1]  130 	jrugt	00105$
                                    131 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (digit > 9) return;
      00813F 88               [ 1]  132 	push	a
      008140 7B 04            [ 1]  133 	ld	a, (0x04, sp)
      008142 A1 09            [ 1]  134 	cp	a, #0x09
      008144 84               [ 1]  135 	pop	a
      008145 22 12            [ 1]  136 	jrugt	00105$
                                    137 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 59: displayBuffer[position] = digitTable[digit];
      008147 5F               [ 1]  138 	clrw	x
      008148 97               [ 1]  139 	ld	xl, a
      008149 1C 00 04         [ 2]  140 	addw	x, #(_displayBuffer+0)
      00814C 90 5F            [ 1]  141 	clrw	y
      00814E 7B 03            [ 1]  142 	ld	a, (0x03, sp)
      008150 90 97            [ 1]  143 	ld	yl, a
      008152 72 A9 80 90      [ 2]  144 	addw	y, #(_digitTable+0)
      008156 90 F6            [ 1]  145 	ld	a, (y)
      008158 F7               [ 1]  146 	ld	(x), a
      008159                        147 00105$:
                                    148 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: }
      008159 85               [ 2]  149 	popw	x
      00815A 84               [ 1]  150 	pop	a
      00815B FC               [ 2]  151 	jp	(x)
                                    152 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: void refresh_display(void)
                                    153 ;	-----------------------------------------
                                    154 ;	 function refresh_display
                                    155 ;	-----------------------------------------
      00815C                        156 _refresh_display:
                                    157 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 63: write_SPI(displayBuffer[currentPosition]);
      00815C 5F               [ 1]  158 	clrw	x
      00815D C6 00 0C         [ 1]  159 	ld	a, _currentPosition+0
      008160 97               [ 1]  160 	ld	xl, a
      008161 D6 00 04         [ 1]  161 	ld	a, (_displayBuffer+0, x)
      008164 CD 88 A2         [ 4]  162 	call	_write_SPI
                                    163 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(positionTable[currentPosition]);
      008167 5F               [ 1]  164 	clrw	x
      008168 C6 00 0C         [ 1]  165 	ld	a, _currentPosition+0
      00816B 97               [ 1]  166 	ld	xl, a
      00816C D6 80 88         [ 1]  167 	ld	a, (_positionTable+0, x)
      00816F CD 88 A2         [ 4]  168 	call	_write_SPI
                                    169 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 66: writePin(latchPort, latchPin, HIGH);
      008172 4B 01            [ 1]  170 	push	#0x01
      008174 C6 00 03         [ 1]  171 	ld	a, _latchPin+0
      008177 CE 00 01         [ 2]  172 	ldw	x, _latchPort+0
      00817A CD 83 07         [ 4]  173 	call	_writePin
                                    174 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, LOW);
      00817D 4B 00            [ 1]  175 	push	#0x00
      00817F C6 00 03         [ 1]  176 	ld	a, _latchPin+0
      008182 CE 00 01         [ 2]  177 	ldw	x, _latchPort+0
      008185 CD 83 07         [ 4]  178 	call	_writePin
                                    179 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 69: currentPosition++;
      008188 72 5C 00 0C      [ 1]  180 	inc	_currentPosition+0
                                    181 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: if (currentPosition > 7) currentPosition = 0;
      00818C C6 00 0C         [ 1]  182 	ld	a, _currentPosition+0
      00818F A1 07            [ 1]  183 	cp	a, #0x07
      008191 22 01            [ 1]  184 	jrugt	00110$
      008193 81               [ 4]  185 	ret
      008194                        186 00110$:
      008194 72 5F 00 0C      [ 1]  187 	clr	_currentPosition+0
                                    188 ;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: }
      008198 81               [ 4]  189 	ret
                                    190 	.area CODE
                                    191 	.area CONST
      008088                        192 _positionTable:
      008088 08                     193 	.db #0x08	; 8
      008089 04                     194 	.db #0x04	; 4
      00808A 02                     195 	.db #0x02	; 2
      00808B 01                     196 	.db #0x01	; 1
      00808C 80                     197 	.db #0x80	; 128
      00808D 40                     198 	.db #0x40	; 64
      00808E 20                     199 	.db #0x20	; 32
      00808F 10                     200 	.db #0x10	; 16
      008090                        201 _digitTable:
      008090 C0                     202 	.db #0xc0	; 192
      008091 F9                     203 	.db #0xf9	; 249
      008092 A4                     204 	.db #0xa4	; 164
      008093 B0                     205 	.db #0xb0	; 176
      008094 99                     206 	.db #0x99	; 153
      008095 92                     207 	.db #0x92	; 146
      008096 82                     208 	.db #0x82	; 130
      008097 F8                     209 	.db #0xf8	; 248
      008098 80                     210 	.db #0x80	; 128
      008099 90                     211 	.db #0x90	; 144
                                    212 	.area INITIALIZER
      00809A                        213 __xinit__currentPosition:
      00809A 00                     214 	.db #0x00	; 0
                                    215 	.area CABS (ABS)
