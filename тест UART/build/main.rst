                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _TIM4_UPD_OVF_IRQHandler
                                     13 	.globl _getData_UART
                                     14 	.globl _isDataReceived_UART
                                     15 	.globl _printHex_UART
                                     16 	.globl _line_UART
                                     17 	.globl _printInt_UART
                                     18 	.globl _print_UART
                                     19 	.globl _write_UART
                                     20 	.globl _init_UART
                                     21 	.globl _delay
                                     22 	.globl _init_TIME
                                     23 	.globl _tick_TIME
                                     24 	.globl _writePin
                                     25 	.globl _pinMode
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
                                     34 ;--------------------------------------------------------
                                     35 ; Stack segment in internal ram
                                     36 ;--------------------------------------------------------
                                     37 	.area	SSEG
      000007                         38 __start__stack:
      000007                         39 	.ds	1
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; absolute external ram data
                                     43 ;--------------------------------------------------------
                                     44 	.area DABS (ABS)
                                     45 
                                     46 ; default segment ordering for linker
                                     47 	.area HOME
                                     48 	.area GSINIT
                                     49 	.area GSFINAL
                                     50 	.area CONST
                                     51 	.area INITIALIZER
                                     52 	.area CODE
                                     53 
                                     54 ;--------------------------------------------------------
                                     55 ; interrupt vector
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
      008000                         58 __interrupt_vect:
      008000 82 00 80 6B             59 	int s_GSINIT ; reset
      008004 82 00 00 00             60 	int 0x000000 ; trap
      008008 82 00 00 00             61 	int 0x000000 ; int0
      00800C 82 00 00 00             62 	int 0x000000 ; int1
      008010 82 00 00 00             63 	int 0x000000 ; int2
      008014 82 00 00 00             64 	int 0x000000 ; int3
      008018 82 00 00 00             65 	int 0x000000 ; int4
      00801C 82 00 00 00             66 	int 0x000000 ; int5
      008020 82 00 00 00             67 	int 0x000000 ; int6
      008024 82 00 00 00             68 	int 0x000000 ; int7
      008028 82 00 00 00             69 	int 0x000000 ; int8
      00802C 82 00 00 00             70 	int 0x000000 ; int9
      008030 82 00 00 00             71 	int 0x000000 ; int10
      008034 82 00 00 00             72 	int 0x000000 ; int11
      008038 82 00 00 00             73 	int 0x000000 ; int12
      00803C 82 00 00 00             74 	int 0x000000 ; int13
      008040 82 00 00 00             75 	int 0x000000 ; int14
      008044 82 00 00 00             76 	int 0x000000 ; int15
      008048 82 00 00 00             77 	int 0x000000 ; int16
      00804C 82 00 00 00             78 	int 0x000000 ; int17
      008050 82 00 00 00             79 	int 0x000000 ; int18
      008054 82 00 00 00             80 	int 0x000000 ; int19
      008058 82 00 00 00             81 	int 0x000000 ; int20
      00805C 82 00 00 00             82 	int 0x000000 ; int21
      008060 82 00 00 00             83 	int 0x000000 ; int22
      008064 82 00 80 9B             84 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     85 ;--------------------------------------------------------
                                     86 ; global & static initialisations
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
                                     89 	.area GSINIT
                                     90 	.area GSFINAL
                                     91 	.area GSINIT
      00806B                         92 __sdcc_init_data:
                                     93 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   94 	ldw x, #l_DATA
      00806E 27 07            [ 1]   95 	jreq	00002$
      008070                         96 00001$:
      008070 72 4F 00 00      [ 1]   97 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   98 	decw x
      008075 26 F9            [ 1]   99 	jrne	00001$
      008077                        100 00002$:
      008077 AE 00 06         [ 2]  101 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]  102 	jreq	00004$
      00807C                        103 00003$:
      00807C D6 80 94         [ 1]  104 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]  105 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]  106 	decw	x
      008083 26 F7            [ 1]  107 	jrne	00003$
      008085                        108 00004$:
                                    109 ; stm8_genXINIT() end
                                    110 	.area GSFINAL
      008085 CC 80 68         [ 2]  111 	jp	__sdcc_program_startup
                                    112 ;--------------------------------------------------------
                                    113 ; Home
                                    114 ;--------------------------------------------------------
                                    115 	.area HOME
                                    116 	.area HOME
      008068                        117 __sdcc_program_startup:
      008068 CC 80 A5         [ 2]  118 	jp	_main
                                    119 ;	return from main will return to caller
                                    120 ;--------------------------------------------------------
                                    121 ; code
                                    122 ;--------------------------------------------------------
                                    123 	.area CODE
                                    124 ;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    125 ;	-----------------------------------------
                                    126 ;	 function TIM4_UPD_OVF_IRQHandler
                                    127 ;	-----------------------------------------
      00809B                        128 _TIM4_UPD_OVF_IRQHandler:
      00809B 4F               [ 1]  129 	clr	a
      00809C 62               [ 2]  130 	div	x, a
                                    131 ;	main.c: 8: TIM4_SR &= ~(1 << 0);
      00809D 72 11 53 44      [ 1]  132 	bres	0x5344, #0
                                    133 ;	main.c: 9: tick_TIME();
      0080A1 CD 85 50         [ 4]  134 	call	_tick_TIME
                                    135 ;	main.c: 10: }
      0080A4 80               [11]  136 	iret
                                    137 ;	main.c: 12: void main(void) {
                                    138 ;	-----------------------------------------
                                    139 ;	 function main
                                    140 ;	-----------------------------------------
      0080A5                        141 _main:
                                    142 ;	main.c: 14: CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
      0080A5 35 00 50 C6      [ 1]  143 	mov	0x50c6+0, #0x00
                                    144 ;	main.c: 16: init_UART(9600);	// 2. Инициализируем периферию
      0080A9 AE 25 80         [ 2]  145 	ldw	x, #0x2580
      0080AC CD 86 00         [ 4]  146 	call	_init_UART
                                    147 ;	main.c: 17: init_TIME();
      0080AF CD 85 64         [ 4]  148 	call	_init_TIME
                                    149 ;	main.c: 19: pinMode(PORTC, 3, OUTPUT);
      0080B2 4B 00            [ 1]  150 	push	#0x00
      0080B4 A6 03            [ 1]  151 	ld	a, #0x03
      0080B6 AE 50 0A         [ 2]  152 	ldw	x, #0x500a
      0080B9 CD 81 D7         [ 4]  153 	call	_pinMode
                                    154 ;	main.c: 21: for (uint8_t i = 33; i < 127; i++)
      0080BC A6 21            [ 1]  155 	ld	a, #0x21
      0080BE                        156 00114$:
      0080BE A1 7F            [ 1]  157 	cp	a, #0x7f
      0080C0 24 08            [ 1]  158 	jrnc	00101$
                                    159 ;	main.c: 23: write_UART(i);	
      0080C2 88               [ 1]  160 	push	a
      0080C3 CD 86 31         [ 4]  161 	call	_write_UART
      0080C6 84               [ 1]  162 	pop	a
                                    163 ;	main.c: 21: for (uint8_t i = 33; i < 127; i++)
      0080C7 4C               [ 1]  164 	inc	a
      0080C8 20 F4            [ 2]  165 	jra	00114$
      0080CA                        166 00101$:
                                    167 ;	main.c: 25: line_UART();
      0080CA CD 86 BC         [ 4]  168 	call	_line_UART
                                    169 ;	main.c: 26: delay(333);
      0080CD 4B 4D            [ 1]  170 	push	#0x4d
      0080CF 4B 01            [ 1]  171 	push	#0x01
      0080D1 5F               [ 1]  172 	clrw	x
      0080D2 89               [ 2]  173 	pushw	x
      0080D3 CD 85 CC         [ 4]  174 	call	_delay
                                    175 ;	main.c: 28: print_UART("Hello world!");
      0080D6 AE 80 88         [ 2]  176 	ldw	x, #(___str_0+0)
      0080D9 CD 86 4A         [ 4]  177 	call	_print_UART
                                    178 ;	main.c: 29: line_UART();
      0080DC CD 86 BC         [ 4]  179 	call	_line_UART
                                    180 ;	main.c: 30: delay(333);
      0080DF 4B 4D            [ 1]  181 	push	#0x4d
      0080E1 4B 01            [ 1]  182 	push	#0x01
      0080E3 5F               [ 1]  183 	clrw	x
      0080E4 89               [ 2]  184 	pushw	x
      0080E5 CD 85 CC         [ 4]  185 	call	_delay
                                    186 ;	main.c: 32: printInt_UART(0);
      0080E8 5F               [ 1]  187 	clrw	x
      0080E9 CD 86 5D         [ 4]  188 	call	_printInt_UART
                                    189 ;	main.c: 33: line_UART();
      0080EC CD 86 BC         [ 4]  190 	call	_line_UART
                                    191 ;	main.c: 34: printInt_UART(12345);
      0080EF AE 30 39         [ 2]  192 	ldw	x, #0x3039
      0080F2 CD 86 5D         [ 4]  193 	call	_printInt_UART
                                    194 ;	main.c: 35: line_UART();
      0080F5 CD 86 BC         [ 4]  195 	call	_line_UART
                                    196 ;	main.c: 36: delay(333);
      0080F8 4B 4D            [ 1]  197 	push	#0x4d
      0080FA 4B 01            [ 1]  198 	push	#0x01
      0080FC 5F               [ 1]  199 	clrw	x
      0080FD 89               [ 2]  200 	pushw	x
      0080FE CD 85 CC         [ 4]  201 	call	_delay
                                    202 ;	main.c: 38: printHex_UART(0xAB);
      008101 A6 AB            [ 1]  203 	ld	a, #0xab
      008103 CD 86 E0         [ 4]  204 	call	_printHex_UART
                                    205 ;	main.c: 39: line_UART();
      008106 CD 86 BC         [ 4]  206 	call	_line_UART
                                    207 ;	main.c: 41: while(1)
      008109                        208 00111$:
                                    209 ;	main.c: 43: if (isDataReceived_UART())
      008109 CD 87 09         [ 4]  210 	call	_isDataReceived_UART
      00810C 4D               [ 1]  211 	tnz	a
      00810D 27 FA            [ 1]  212 	jreq	00111$
                                    213 ;	main.c: 45: if (getData_UART() == 'n' || getData_UART() == 'N') writePin(PORTC, 3, HIGH);
      00810F CD 87 0F         [ 4]  214 	call	_getData_UART
      008112 A1 6E            [ 1]  215 	cp	a, #0x6e
      008114 27 07            [ 1]  216 	jreq	00102$
      008116 CD 87 0F         [ 4]  217 	call	_getData_UART
      008119 A1 4E            [ 1]  218 	cp	a, #0x4e
      00811B 26 0A            [ 1]  219 	jrne	00103$
      00811D                        220 00102$:
      00811D 4B 01            [ 1]  221 	push	#0x01
      00811F A6 03            [ 1]  222 	ld	a, #0x03
      008121 AE 50 0A         [ 2]  223 	ldw	x, #0x500a
      008124 CD 82 65         [ 4]  224 	call	_writePin
      008127                        225 00103$:
                                    226 ;	main.c: 46: if (getData_UART() == 'f' || getData_UART() == 'F') writePin(PORTC, 3, LOW);
      008127 CD 87 0F         [ 4]  227 	call	_getData_UART
      00812A A1 66            [ 1]  228 	cp	a, #0x66
      00812C 27 07            [ 1]  229 	jreq	00105$
      00812E CD 87 0F         [ 4]  230 	call	_getData_UART
      008131 A1 46            [ 1]  231 	cp	a, #0x46
      008133 26 D4            [ 1]  232 	jrne	00111$
      008135                        233 00105$:
      008135 4B 00            [ 1]  234 	push	#0x00
      008137 A6 03            [ 1]  235 	ld	a, #0x03
      008139 AE 50 0A         [ 2]  236 	ldw	x, #0x500a
      00813C CD 82 65         [ 4]  237 	call	_writePin
      00813F 20 C8            [ 2]  238 	jra	00111$
                                    239 ;	main.c: 49: }
      008141 81               [ 4]  240 	ret
                                    241 	.area CODE
                                    242 	.area CONST
                                    243 	.area CONST
      008088                        244 ___str_0:
      008088 48 65 6C 6C 6F 20 77   245 	.ascii "Hello world!"
             6F 72 6C 64 21
      008094 00                     246 	.db 0x00
                                    247 	.area CODE
                                    248 	.area INITIALIZER
                                    249 	.area CABS (ABS)
