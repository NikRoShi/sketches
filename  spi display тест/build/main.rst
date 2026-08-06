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
                                     13 	.globl _delay
                                     14 	.globl _init_TIME
                                     15 	.globl _tick_TIME
                                     16 	.globl _write_SPI
                                     17 	.globl _init_SPI
                                     18 	.globl _writePin
                                     19 	.globl _pinMode
                                     20 	.globl _b
                                     21 	.globl _a
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DATA
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area INITIALIZED
      000001                         30 _a::
      000001                         31 	.ds 1
      000002                         32 _b::
      000002                         33 	.ds 1
                                     34 ;--------------------------------------------------------
                                     35 ; Stack segment in internal ram
                                     36 ;--------------------------------------------------------
                                     37 	.area	SSEG
      000009                         38 __start__stack:
      000009                         39 	.ds	1
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
      008064 82 00 80 90             84 	int _TIM4_UPD_OVF_IRQHandler ; int23
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
      008077 AE 00 08         [ 2]  101 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]  102 	jreq	00004$
      00807C                        103 00003$:
      00807C D6 80 87         [ 1]  104 	ld	a, (s_INITIALIZER - 1, x)
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
      008068 CC 80 9A         [ 2]  118 	jp	_main
                                    119 ;	return from main will return to caller
                                    120 ;--------------------------------------------------------
                                    121 ; code
                                    122 ;--------------------------------------------------------
                                    123 	.area CODE
                                    124 ;	main.c: 30: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
                                    125 ;	-----------------------------------------
                                    126 ;	 function TIM4_UPD_OVF_IRQHandler
                                    127 ;	-----------------------------------------
      008090                        128 _TIM4_UPD_OVF_IRQHandler:
      008090 4F               [ 1]  129 	clr	a
      008091 62               [ 2]  130 	div	x, a
                                    131 ;	main.c: 31: TIM4_SR &= ~(1 << 0);
      008092 72 11 53 44      [ 1]  132 	bres	0x5344, #0
                                    133 ;	main.c: 32: tick_TIME();
      008096 CD 8B 3E         [ 4]  134 	call	_tick_TIME
                                    135 ;	main.c: 33: }
      008099 80               [11]  136 	iret
                                    137 ;	main.c: 35: int main(void)
                                    138 ;	-----------------------------------------
                                    139 ;	 function main
                                    140 ;	-----------------------------------------
      00809A                        141 _main:
                                    142 ;	main.c: 37: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00809A 35 00 50 C6      [ 1]  143 	mov	0x50c6+0, #0x00
                                    144 ;	main.c: 39: init_TIME();
      00809E CD 8B 52         [ 4]  145 	call	_init_TIME
                                    146 ;	main.c: 40: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
      0080A1 4B 04            [ 1]  147 	push	#0x04
      0080A3 4B 00            [ 1]  148 	push	#0x00
      0080A5 4B 18            [ 1]  149 	push	#0x18
      0080A7 4F               [ 1]  150 	clr	a
      0080A8 CD 8A B8         [ 4]  151 	call	_init_SPI
                                    152 ;	main.c: 41: pinMode(PD, 3, OUTPUT);
      0080AB 4B 00            [ 1]  153 	push	#0x00
      0080AD A6 03            [ 1]  154 	ld	a, #0x03
      0080AF AE 50 0F         [ 2]  155 	ldw	x, #0x500f
      0080B2 CD 85 0D         [ 4]  156 	call	_pinMode
                                    157 ;	main.c: 52: while (a < 8)
      0080B5                        158 00134$:
      0080B5 C6 00 01         [ 1]  159 	ld	a, _a+0
      0080B8 A1 08            [ 1]  160 	cp	a, #0x08
      0080BA 25 03            [ 1]  161 	jrc	00237$
      0080BC CC 84 26         [ 2]  162 	jp	00136$
      0080BF                        163 00237$:
                                    164 ;	main.c: 54: switch (a)
      0080BF C6 00 01         [ 1]  165 	ld	a, _a+0
      0080C2 A1 07            [ 1]  166 	cp	a, #0x07
      0080C4 23 03            [ 2]  167 	jrule	00238$
      0080C6 CC 84 1F         [ 2]  168 	jp	00133$
      0080C9                        169 00238$:
      0080C9 5F               [ 1]  170 	clrw	x
      0080CA C6 00 01         [ 1]  171 	ld	a, _a+0
      0080CD 97               [ 1]  172 	ld	xl, a
      0080CE 58               [ 2]  173 	sllw	x
      0080CF DE 80 D3         [ 2]  174 	ldw	x, (#00239$, x)
      0080D2 FC               [ 2]  175 	jp	(x)
      0080D3                        176 00239$:
      0080D3 80 E3                  177 	.dw	#00101$
      0080D5 81 4B                  178 	.dw	#00105$
      0080D7 81 B3                  179 	.dw	#00109$
      0080D9 82 1B                  180 	.dw	#00113$
      0080DB 82 83                  181 	.dw	#00117$
      0080DD 82 EB                  182 	.dw	#00121$
      0080DF 83 53                  183 	.dw	#00125$
      0080E1 83 BA                  184 	.dw	#00129$
                                    185 ;	main.c: 56: case 0:
      0080E3                        186 00101$:
                                    187 ;	main.c: 57: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      0080E3 A6 FF            [ 1]  188 	ld	a, #0xff
      0080E5 CD 8B 36         [ 4]  189 	call	_write_SPI
                                    190 ;	main.c: 58: write_SPI(0x00);
      0080E8 4F               [ 1]  191 	clr	a
      0080E9 CD 8B 36         [ 4]  192 	call	_write_SPI
                                    193 ;	main.c: 59: writePin(PD, 3, HIGH);
      0080EC 4B 01            [ 1]  194 	push	#0x01
      0080EE A6 03            [ 1]  195 	ld	a, #0x03
      0080F0 AE 50 0F         [ 2]  196 	ldw	x, #0x500f
      0080F3 CD 85 9B         [ 4]  197 	call	_writePin
                                    198 ;	main.c: 60: writePin(PD, 3, LOW);
      0080F6 4B 00            [ 1]  199 	push	#0x00
      0080F8 A6 03            [ 1]  200 	ld	a, #0x03
      0080FA AE 50 0F         [ 2]  201 	ldw	x, #0x500f
      0080FD CD 85 9B         [ 4]  202 	call	_writePin
                                    203 ;	main.c: 61: while (b < 8)
      008100                        204 00102$:
      008100 C6 00 02         [ 1]  205 	ld	a, _b+0
      008103 A1 08            [ 1]  206 	cp	a, #0x08
      008105 24 3D            [ 1]  207 	jrnc	00104$
                                    208 ;	main.c: 63: write_SPI(~(1 << b));
      008107 C6 00 02         [ 1]  209 	ld	a, _b+0
      00810A 97               [ 1]  210 	ld	xl, a
      00810B A6 01            [ 1]  211 	ld	a, #0x01
      00810D 88               [ 1]  212 	push	a
      00810E 9F               [ 1]  213 	ld	a, xl
      00810F 4D               [ 1]  214 	tnz	a
      008110 27 05            [ 1]  215 	jreq	00242$
      008112                        216 00241$:
      008112 08 01            [ 1]  217 	sll	(1, sp)
      008114 4A               [ 1]  218 	dec	a
      008115 26 FB            [ 1]  219 	jrne	00241$
      008117                        220 00242$:
      008117 84               [ 1]  221 	pop	a
      008118 43               [ 1]  222 	cpl	a
      008119 CD 8B 36         [ 4]  223 	call	_write_SPI
                                    224 ;	main.c: 64: write_SPI(DIGIT_ONE);
      00811C A6 08            [ 1]  225 	ld	a, #0x08
      00811E CD 8B 36         [ 4]  226 	call	_write_SPI
                                    227 ;	main.c: 65: writePin(PD, 3, HIGH);
      008121 4B 01            [ 1]  228 	push	#0x01
      008123 A6 03            [ 1]  229 	ld	a, #0x03
      008125 AE 50 0F         [ 2]  230 	ldw	x, #0x500f
      008128 CD 85 9B         [ 4]  231 	call	_writePin
                                    232 ;	main.c: 66: writePin(PD, 3, LOW);
      00812B 4B 00            [ 1]  233 	push	#0x00
      00812D A6 03            [ 1]  234 	ld	a, #0x03
      00812F AE 50 0F         [ 2]  235 	ldw	x, #0x500f
      008132 CD 85 9B         [ 4]  236 	call	_writePin
                                    237 ;	main.c: 67: b++;
      008135 72 5C 00 02      [ 1]  238 	inc	_b+0
                                    239 ;	main.c: 68: delay(DELAY_TIME);
      008139 4B C8            [ 1]  240 	push	#0xc8
      00813B 5F               [ 1]  241 	clrw	x
      00813C 89               [ 2]  242 	pushw	x
      00813D 4B 00            [ 1]  243 	push	#0x00
      00813F CD 8B BA         [ 4]  244 	call	_delay
      008142 20 BC            [ 2]  245 	jra	00102$
      008144                        246 00104$:
                                    247 ;	main.c: 70: b = 0;
      008144 72 5F 00 02      [ 1]  248 	clr	_b+0
                                    249 ;	main.c: 71: break;
      008148 CC 84 1F         [ 2]  250 	jp	00133$
                                    251 ;	main.c: 72: case 1:
      00814B                        252 00105$:
                                    253 ;	main.c: 73: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      00814B A6 FF            [ 1]  254 	ld	a, #0xff
      00814D CD 8B 36         [ 4]  255 	call	_write_SPI
                                    256 ;	main.c: 74: write_SPI(0x00);
      008150 4F               [ 1]  257 	clr	a
      008151 CD 8B 36         [ 4]  258 	call	_write_SPI
                                    259 ;	main.c: 75: writePin(PD, 3, HIGH);
      008154 4B 01            [ 1]  260 	push	#0x01
      008156 A6 03            [ 1]  261 	ld	a, #0x03
      008158 AE 50 0F         [ 2]  262 	ldw	x, #0x500f
      00815B CD 85 9B         [ 4]  263 	call	_writePin
                                    264 ;	main.c: 76: writePin(PD, 3, LOW);
      00815E 4B 00            [ 1]  265 	push	#0x00
      008160 A6 03            [ 1]  266 	ld	a, #0x03
      008162 AE 50 0F         [ 2]  267 	ldw	x, #0x500f
      008165 CD 85 9B         [ 4]  268 	call	_writePin
                                    269 ;	main.c: 77: while (b < 8)
      008168                        270 00106$:
      008168 C6 00 02         [ 1]  271 	ld	a, _b+0
      00816B A1 08            [ 1]  272 	cp	a, #0x08
      00816D 24 3D            [ 1]  273 	jrnc	00108$
                                    274 ;	main.c: 79: write_SPI(~(1 << b));
      00816F C6 00 02         [ 1]  275 	ld	a, _b+0
      008172 97               [ 1]  276 	ld	xl, a
      008173 A6 01            [ 1]  277 	ld	a, #0x01
      008175 88               [ 1]  278 	push	a
      008176 9F               [ 1]  279 	ld	a, xl
      008177 4D               [ 1]  280 	tnz	a
      008178 27 05            [ 1]  281 	jreq	00245$
      00817A                        282 00244$:
      00817A 08 01            [ 1]  283 	sll	(1, sp)
      00817C 4A               [ 1]  284 	dec	a
      00817D 26 FB            [ 1]  285 	jrne	00244$
      00817F                        286 00245$:
      00817F 84               [ 1]  287 	pop	a
      008180 43               [ 1]  288 	cpl	a
      008181 CD 8B 36         [ 4]  289 	call	_write_SPI
                                    290 ;	main.c: 80: write_SPI(DIGIT_TWO);
      008184 A6 04            [ 1]  291 	ld	a, #0x04
      008186 CD 8B 36         [ 4]  292 	call	_write_SPI
                                    293 ;	main.c: 81: writePin(PD, 3, HIGH);
      008189 4B 01            [ 1]  294 	push	#0x01
      00818B A6 03            [ 1]  295 	ld	a, #0x03
      00818D AE 50 0F         [ 2]  296 	ldw	x, #0x500f
      008190 CD 85 9B         [ 4]  297 	call	_writePin
                                    298 ;	main.c: 82: writePin(PD, 3, LOW);
      008193 4B 00            [ 1]  299 	push	#0x00
      008195 A6 03            [ 1]  300 	ld	a, #0x03
      008197 AE 50 0F         [ 2]  301 	ldw	x, #0x500f
      00819A CD 85 9B         [ 4]  302 	call	_writePin
                                    303 ;	main.c: 83: b++;
      00819D 72 5C 00 02      [ 1]  304 	inc	_b+0
                                    305 ;	main.c: 84: delay(DELAY_TIME);
      0081A1 4B C8            [ 1]  306 	push	#0xc8
      0081A3 5F               [ 1]  307 	clrw	x
      0081A4 89               [ 2]  308 	pushw	x
      0081A5 4B 00            [ 1]  309 	push	#0x00
      0081A7 CD 8B BA         [ 4]  310 	call	_delay
      0081AA 20 BC            [ 2]  311 	jra	00106$
      0081AC                        312 00108$:
                                    313 ;	main.c: 86: b = 0;
      0081AC 72 5F 00 02      [ 1]  314 	clr	_b+0
                                    315 ;	main.c: 87: break;
      0081B0 CC 84 1F         [ 2]  316 	jp	00133$
                                    317 ;	main.c: 88: case 2:
      0081B3                        318 00109$:
                                    319 ;	main.c: 89: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      0081B3 A6 FF            [ 1]  320 	ld	a, #0xff
      0081B5 CD 8B 36         [ 4]  321 	call	_write_SPI
                                    322 ;	main.c: 90: write_SPI(0x00);
      0081B8 4F               [ 1]  323 	clr	a
      0081B9 CD 8B 36         [ 4]  324 	call	_write_SPI
                                    325 ;	main.c: 91: writePin(PD, 3, HIGH);
      0081BC 4B 01            [ 1]  326 	push	#0x01
      0081BE A6 03            [ 1]  327 	ld	a, #0x03
      0081C0 AE 50 0F         [ 2]  328 	ldw	x, #0x500f
      0081C3 CD 85 9B         [ 4]  329 	call	_writePin
                                    330 ;	main.c: 92: writePin(PD, 3, LOW);
      0081C6 4B 00            [ 1]  331 	push	#0x00
      0081C8 A6 03            [ 1]  332 	ld	a, #0x03
      0081CA AE 50 0F         [ 2]  333 	ldw	x, #0x500f
      0081CD CD 85 9B         [ 4]  334 	call	_writePin
                                    335 ;	main.c: 93: while (b < 8)
      0081D0                        336 00110$:
      0081D0 C6 00 02         [ 1]  337 	ld	a, _b+0
      0081D3 A1 08            [ 1]  338 	cp	a, #0x08
      0081D5 24 3D            [ 1]  339 	jrnc	00112$
                                    340 ;	main.c: 95: write_SPI(~(1 << b));
      0081D7 C6 00 02         [ 1]  341 	ld	a, _b+0
      0081DA 97               [ 1]  342 	ld	xl, a
      0081DB A6 01            [ 1]  343 	ld	a, #0x01
      0081DD 88               [ 1]  344 	push	a
      0081DE 9F               [ 1]  345 	ld	a, xl
      0081DF 4D               [ 1]  346 	tnz	a
      0081E0 27 05            [ 1]  347 	jreq	00248$
      0081E2                        348 00247$:
      0081E2 08 01            [ 1]  349 	sll	(1, sp)
      0081E4 4A               [ 1]  350 	dec	a
      0081E5 26 FB            [ 1]  351 	jrne	00247$
      0081E7                        352 00248$:
      0081E7 84               [ 1]  353 	pop	a
      0081E8 43               [ 1]  354 	cpl	a
      0081E9 CD 8B 36         [ 4]  355 	call	_write_SPI
                                    356 ;	main.c: 96: write_SPI(DIGIT_THREE);
      0081EC A6 02            [ 1]  357 	ld	a, #0x02
      0081EE CD 8B 36         [ 4]  358 	call	_write_SPI
                                    359 ;	main.c: 97: writePin(PD, 3, HIGH);
      0081F1 4B 01            [ 1]  360 	push	#0x01
      0081F3 A6 03            [ 1]  361 	ld	a, #0x03
      0081F5 AE 50 0F         [ 2]  362 	ldw	x, #0x500f
      0081F8 CD 85 9B         [ 4]  363 	call	_writePin
                                    364 ;	main.c: 98: writePin(PD, 3, LOW);
      0081FB 4B 00            [ 1]  365 	push	#0x00
      0081FD A6 03            [ 1]  366 	ld	a, #0x03
      0081FF AE 50 0F         [ 2]  367 	ldw	x, #0x500f
      008202 CD 85 9B         [ 4]  368 	call	_writePin
                                    369 ;	main.c: 99: b++;
      008205 72 5C 00 02      [ 1]  370 	inc	_b+0
                                    371 ;	main.c: 100: delay(DELAY_TIME);
      008209 4B C8            [ 1]  372 	push	#0xc8
      00820B 5F               [ 1]  373 	clrw	x
      00820C 89               [ 2]  374 	pushw	x
      00820D 4B 00            [ 1]  375 	push	#0x00
      00820F CD 8B BA         [ 4]  376 	call	_delay
      008212 20 BC            [ 2]  377 	jra	00110$
      008214                        378 00112$:
                                    379 ;	main.c: 102: b = 0;
      008214 72 5F 00 02      [ 1]  380 	clr	_b+0
                                    381 ;	main.c: 103: break;
      008218 CC 84 1F         [ 2]  382 	jp	00133$
                                    383 ;	main.c: 104: case 3:
      00821B                        384 00113$:
                                    385 ;	main.c: 105: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      00821B A6 FF            [ 1]  386 	ld	a, #0xff
      00821D CD 8B 36         [ 4]  387 	call	_write_SPI
                                    388 ;	main.c: 106: write_SPI(0x00);
      008220 4F               [ 1]  389 	clr	a
      008221 CD 8B 36         [ 4]  390 	call	_write_SPI
                                    391 ;	main.c: 107: writePin(PD, 3, HIGH);
      008224 4B 01            [ 1]  392 	push	#0x01
      008226 A6 03            [ 1]  393 	ld	a, #0x03
      008228 AE 50 0F         [ 2]  394 	ldw	x, #0x500f
      00822B CD 85 9B         [ 4]  395 	call	_writePin
                                    396 ;	main.c: 108: writePin(PD, 3, LOW);
      00822E 4B 00            [ 1]  397 	push	#0x00
      008230 A6 03            [ 1]  398 	ld	a, #0x03
      008232 AE 50 0F         [ 2]  399 	ldw	x, #0x500f
      008235 CD 85 9B         [ 4]  400 	call	_writePin
                                    401 ;	main.c: 109: while (b < 8)
      008238                        402 00114$:
      008238 C6 00 02         [ 1]  403 	ld	a, _b+0
      00823B A1 08            [ 1]  404 	cp	a, #0x08
      00823D 24 3D            [ 1]  405 	jrnc	00116$
                                    406 ;	main.c: 111: write_SPI(~(1 << b));
      00823F C6 00 02         [ 1]  407 	ld	a, _b+0
      008242 97               [ 1]  408 	ld	xl, a
      008243 A6 01            [ 1]  409 	ld	a, #0x01
      008245 88               [ 1]  410 	push	a
      008246 9F               [ 1]  411 	ld	a, xl
      008247 4D               [ 1]  412 	tnz	a
      008248 27 05            [ 1]  413 	jreq	00251$
      00824A                        414 00250$:
      00824A 08 01            [ 1]  415 	sll	(1, sp)
      00824C 4A               [ 1]  416 	dec	a
      00824D 26 FB            [ 1]  417 	jrne	00250$
      00824F                        418 00251$:
      00824F 84               [ 1]  419 	pop	a
      008250 43               [ 1]  420 	cpl	a
      008251 CD 8B 36         [ 4]  421 	call	_write_SPI
                                    422 ;	main.c: 112: write_SPI(DIGIT_FOUR);
      008254 A6 01            [ 1]  423 	ld	a, #0x01
      008256 CD 8B 36         [ 4]  424 	call	_write_SPI
                                    425 ;	main.c: 113: writePin(PD, 3, HIGH);
      008259 4B 01            [ 1]  426 	push	#0x01
      00825B A6 03            [ 1]  427 	ld	a, #0x03
      00825D AE 50 0F         [ 2]  428 	ldw	x, #0x500f
      008260 CD 85 9B         [ 4]  429 	call	_writePin
                                    430 ;	main.c: 114: writePin(PD, 3, LOW);
      008263 4B 00            [ 1]  431 	push	#0x00
      008265 A6 03            [ 1]  432 	ld	a, #0x03
      008267 AE 50 0F         [ 2]  433 	ldw	x, #0x500f
      00826A CD 85 9B         [ 4]  434 	call	_writePin
                                    435 ;	main.c: 115: b++;
      00826D 72 5C 00 02      [ 1]  436 	inc	_b+0
                                    437 ;	main.c: 116: delay(DELAY_TIME);
      008271 4B C8            [ 1]  438 	push	#0xc8
      008273 5F               [ 1]  439 	clrw	x
      008274 89               [ 2]  440 	pushw	x
      008275 4B 00            [ 1]  441 	push	#0x00
      008277 CD 8B BA         [ 4]  442 	call	_delay
      00827A 20 BC            [ 2]  443 	jra	00114$
      00827C                        444 00116$:
                                    445 ;	main.c: 118: b = 0;
      00827C 72 5F 00 02      [ 1]  446 	clr	_b+0
                                    447 ;	main.c: 119: break;
      008280 CC 84 1F         [ 2]  448 	jp	00133$
                                    449 ;	main.c: 120: case 4:
      008283                        450 00117$:
                                    451 ;	main.c: 121: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      008283 A6 FF            [ 1]  452 	ld	a, #0xff
      008285 CD 8B 36         [ 4]  453 	call	_write_SPI
                                    454 ;	main.c: 122: write_SPI(0x00);
      008288 4F               [ 1]  455 	clr	a
      008289 CD 8B 36         [ 4]  456 	call	_write_SPI
                                    457 ;	main.c: 123: writePin(PD, 3, HIGH);
      00828C 4B 01            [ 1]  458 	push	#0x01
      00828E A6 03            [ 1]  459 	ld	a, #0x03
      008290 AE 50 0F         [ 2]  460 	ldw	x, #0x500f
      008293 CD 85 9B         [ 4]  461 	call	_writePin
                                    462 ;	main.c: 124: writePin(PD, 3, LOW);
      008296 4B 00            [ 1]  463 	push	#0x00
      008298 A6 03            [ 1]  464 	ld	a, #0x03
      00829A AE 50 0F         [ 2]  465 	ldw	x, #0x500f
      00829D CD 85 9B         [ 4]  466 	call	_writePin
                                    467 ;	main.c: 125: while (b < 8)
      0082A0                        468 00118$:
      0082A0 C6 00 02         [ 1]  469 	ld	a, _b+0
      0082A3 A1 08            [ 1]  470 	cp	a, #0x08
      0082A5 24 3D            [ 1]  471 	jrnc	00120$
                                    472 ;	main.c: 127: write_SPI(~(1 << b));
      0082A7 C6 00 02         [ 1]  473 	ld	a, _b+0
      0082AA 97               [ 1]  474 	ld	xl, a
      0082AB A6 01            [ 1]  475 	ld	a, #0x01
      0082AD 88               [ 1]  476 	push	a
      0082AE 9F               [ 1]  477 	ld	a, xl
      0082AF 4D               [ 1]  478 	tnz	a
      0082B0 27 05            [ 1]  479 	jreq	00254$
      0082B2                        480 00253$:
      0082B2 08 01            [ 1]  481 	sll	(1, sp)
      0082B4 4A               [ 1]  482 	dec	a
      0082B5 26 FB            [ 1]  483 	jrne	00253$
      0082B7                        484 00254$:
      0082B7 84               [ 1]  485 	pop	a
      0082B8 43               [ 1]  486 	cpl	a
      0082B9 CD 8B 36         [ 4]  487 	call	_write_SPI
                                    488 ;	main.c: 128: write_SPI(DIGIT_FIVE);
      0082BC A6 80            [ 1]  489 	ld	a, #0x80
      0082BE CD 8B 36         [ 4]  490 	call	_write_SPI
                                    491 ;	main.c: 129: writePin(PD, 3, HIGH);
      0082C1 4B 01            [ 1]  492 	push	#0x01
      0082C3 A6 03            [ 1]  493 	ld	a, #0x03
      0082C5 AE 50 0F         [ 2]  494 	ldw	x, #0x500f
      0082C8 CD 85 9B         [ 4]  495 	call	_writePin
                                    496 ;	main.c: 130: writePin(PD, 3, LOW);
      0082CB 4B 00            [ 1]  497 	push	#0x00
      0082CD A6 03            [ 1]  498 	ld	a, #0x03
      0082CF AE 50 0F         [ 2]  499 	ldw	x, #0x500f
      0082D2 CD 85 9B         [ 4]  500 	call	_writePin
                                    501 ;	main.c: 131: b++;
      0082D5 72 5C 00 02      [ 1]  502 	inc	_b+0
                                    503 ;	main.c: 132: delay(DELAY_TIME);
      0082D9 4B C8            [ 1]  504 	push	#0xc8
      0082DB 5F               [ 1]  505 	clrw	x
      0082DC 89               [ 2]  506 	pushw	x
      0082DD 4B 00            [ 1]  507 	push	#0x00
      0082DF CD 8B BA         [ 4]  508 	call	_delay
      0082E2 20 BC            [ 2]  509 	jra	00118$
      0082E4                        510 00120$:
                                    511 ;	main.c: 134: b = 0;
      0082E4 72 5F 00 02      [ 1]  512 	clr	_b+0
                                    513 ;	main.c: 135: break;
      0082E8 CC 84 1F         [ 2]  514 	jp	00133$
                                    515 ;	main.c: 136: case 5:
      0082EB                        516 00121$:
                                    517 ;	main.c: 137: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      0082EB A6 FF            [ 1]  518 	ld	a, #0xff
      0082ED CD 8B 36         [ 4]  519 	call	_write_SPI
                                    520 ;	main.c: 138: write_SPI(0x00);
      0082F0 4F               [ 1]  521 	clr	a
      0082F1 CD 8B 36         [ 4]  522 	call	_write_SPI
                                    523 ;	main.c: 139: writePin(PD, 3, HIGH);
      0082F4 4B 01            [ 1]  524 	push	#0x01
      0082F6 A6 03            [ 1]  525 	ld	a, #0x03
      0082F8 AE 50 0F         [ 2]  526 	ldw	x, #0x500f
      0082FB CD 85 9B         [ 4]  527 	call	_writePin
                                    528 ;	main.c: 140: writePin(PD, 3, LOW);
      0082FE 4B 00            [ 1]  529 	push	#0x00
      008300 A6 03            [ 1]  530 	ld	a, #0x03
      008302 AE 50 0F         [ 2]  531 	ldw	x, #0x500f
      008305 CD 85 9B         [ 4]  532 	call	_writePin
                                    533 ;	main.c: 141: while (b < 8)
      008308                        534 00122$:
      008308 C6 00 02         [ 1]  535 	ld	a, _b+0
      00830B A1 08            [ 1]  536 	cp	a, #0x08
      00830D 24 3D            [ 1]  537 	jrnc	00124$
                                    538 ;	main.c: 143: write_SPI(~(1 << b));
      00830F C6 00 02         [ 1]  539 	ld	a, _b+0
      008312 97               [ 1]  540 	ld	xl, a
      008313 A6 01            [ 1]  541 	ld	a, #0x01
      008315 88               [ 1]  542 	push	a
      008316 9F               [ 1]  543 	ld	a, xl
      008317 4D               [ 1]  544 	tnz	a
      008318 27 05            [ 1]  545 	jreq	00257$
      00831A                        546 00256$:
      00831A 08 01            [ 1]  547 	sll	(1, sp)
      00831C 4A               [ 1]  548 	dec	a
      00831D 26 FB            [ 1]  549 	jrne	00256$
      00831F                        550 00257$:
      00831F 84               [ 1]  551 	pop	a
      008320 43               [ 1]  552 	cpl	a
      008321 CD 8B 36         [ 4]  553 	call	_write_SPI
                                    554 ;	main.c: 144: write_SPI(DIGIT_SIX);
      008324 A6 40            [ 1]  555 	ld	a, #0x40
      008326 CD 8B 36         [ 4]  556 	call	_write_SPI
                                    557 ;	main.c: 145: writePin(PD, 3, HIGH);
      008329 4B 01            [ 1]  558 	push	#0x01
      00832B A6 03            [ 1]  559 	ld	a, #0x03
      00832D AE 50 0F         [ 2]  560 	ldw	x, #0x500f
      008330 CD 85 9B         [ 4]  561 	call	_writePin
                                    562 ;	main.c: 146: writePin(PD, 3, LOW);
      008333 4B 00            [ 1]  563 	push	#0x00
      008335 A6 03            [ 1]  564 	ld	a, #0x03
      008337 AE 50 0F         [ 2]  565 	ldw	x, #0x500f
      00833A CD 85 9B         [ 4]  566 	call	_writePin
                                    567 ;	main.c: 147: b++;
      00833D 72 5C 00 02      [ 1]  568 	inc	_b+0
                                    569 ;	main.c: 148: delay(DELAY_TIME);
      008341 4B C8            [ 1]  570 	push	#0xc8
      008343 5F               [ 1]  571 	clrw	x
      008344 89               [ 2]  572 	pushw	x
      008345 4B 00            [ 1]  573 	push	#0x00
      008347 CD 8B BA         [ 4]  574 	call	_delay
      00834A 20 BC            [ 2]  575 	jra	00122$
      00834C                        576 00124$:
                                    577 ;	main.c: 150: b = 0;
      00834C 72 5F 00 02      [ 1]  578 	clr	_b+0
                                    579 ;	main.c: 151: break;
      008350 CC 84 1F         [ 2]  580 	jp	00133$
                                    581 ;	main.c: 152: case 6:
      008353                        582 00125$:
                                    583 ;	main.c: 153: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      008353 A6 FF            [ 1]  584 	ld	a, #0xff
      008355 CD 8B 36         [ 4]  585 	call	_write_SPI
                                    586 ;	main.c: 154: write_SPI(0x00);
      008358 4F               [ 1]  587 	clr	a
      008359 CD 8B 36         [ 4]  588 	call	_write_SPI
                                    589 ;	main.c: 155: writePin(PD, 3, HIGH);
      00835C 4B 01            [ 1]  590 	push	#0x01
      00835E A6 03            [ 1]  591 	ld	a, #0x03
      008360 AE 50 0F         [ 2]  592 	ldw	x, #0x500f
      008363 CD 85 9B         [ 4]  593 	call	_writePin
                                    594 ;	main.c: 156: writePin(PD, 3, LOW);
      008366 4B 00            [ 1]  595 	push	#0x00
      008368 A6 03            [ 1]  596 	ld	a, #0x03
      00836A AE 50 0F         [ 2]  597 	ldw	x, #0x500f
      00836D CD 85 9B         [ 4]  598 	call	_writePin
                                    599 ;	main.c: 157: while (b < 8)
      008370                        600 00126$:
      008370 C6 00 02         [ 1]  601 	ld	a, _b+0
      008373 A1 08            [ 1]  602 	cp	a, #0x08
      008375 24 3D            [ 1]  603 	jrnc	00128$
                                    604 ;	main.c: 159: write_SPI(~(1 << b));
      008377 C6 00 02         [ 1]  605 	ld	a, _b+0
      00837A 97               [ 1]  606 	ld	xl, a
      00837B A6 01            [ 1]  607 	ld	a, #0x01
      00837D 88               [ 1]  608 	push	a
      00837E 9F               [ 1]  609 	ld	a, xl
      00837F 4D               [ 1]  610 	tnz	a
      008380 27 05            [ 1]  611 	jreq	00260$
      008382                        612 00259$:
      008382 08 01            [ 1]  613 	sll	(1, sp)
      008384 4A               [ 1]  614 	dec	a
      008385 26 FB            [ 1]  615 	jrne	00259$
      008387                        616 00260$:
      008387 84               [ 1]  617 	pop	a
      008388 43               [ 1]  618 	cpl	a
      008389 CD 8B 36         [ 4]  619 	call	_write_SPI
                                    620 ;	main.c: 160: write_SPI(DIGIT_SEVEN);
      00838C A6 20            [ 1]  621 	ld	a, #0x20
      00838E CD 8B 36         [ 4]  622 	call	_write_SPI
                                    623 ;	main.c: 161: writePin(PD, 3, HIGH);
      008391 4B 01            [ 1]  624 	push	#0x01
      008393 A6 03            [ 1]  625 	ld	a, #0x03
      008395 AE 50 0F         [ 2]  626 	ldw	x, #0x500f
      008398 CD 85 9B         [ 4]  627 	call	_writePin
                                    628 ;	main.c: 162: writePin(PD, 3, LOW);
      00839B 4B 00            [ 1]  629 	push	#0x00
      00839D A6 03            [ 1]  630 	ld	a, #0x03
      00839F AE 50 0F         [ 2]  631 	ldw	x, #0x500f
      0083A2 CD 85 9B         [ 4]  632 	call	_writePin
                                    633 ;	main.c: 163: b++;
      0083A5 72 5C 00 02      [ 1]  634 	inc	_b+0
                                    635 ;	main.c: 164: delay(DELAY_TIME);
      0083A9 4B C8            [ 1]  636 	push	#0xc8
      0083AB 5F               [ 1]  637 	clrw	x
      0083AC 89               [ 2]  638 	pushw	x
      0083AD 4B 00            [ 1]  639 	push	#0x00
      0083AF CD 8B BA         [ 4]  640 	call	_delay
      0083B2 20 BC            [ 2]  641 	jra	00126$
      0083B4                        642 00128$:
                                    643 ;	main.c: 166: b = 0;
      0083B4 72 5F 00 02      [ 1]  644 	clr	_b+0
                                    645 ;	main.c: 167: break;
      0083B8 20 65            [ 2]  646 	jra	00133$
                                    647 ;	main.c: 168: case 7:
      0083BA                        648 00129$:
                                    649 ;	main.c: 169: write_SPI(0xFF);	//сбросили в ноль все микросхемы
      0083BA A6 FF            [ 1]  650 	ld	a, #0xff
      0083BC CD 8B 36         [ 4]  651 	call	_write_SPI
                                    652 ;	main.c: 170: write_SPI(0x00);
      0083BF 4F               [ 1]  653 	clr	a
      0083C0 CD 8B 36         [ 4]  654 	call	_write_SPI
                                    655 ;	main.c: 171: writePin(PD, 3, HIGH);
      0083C3 4B 01            [ 1]  656 	push	#0x01
      0083C5 A6 03            [ 1]  657 	ld	a, #0x03
      0083C7 AE 50 0F         [ 2]  658 	ldw	x, #0x500f
      0083CA CD 85 9B         [ 4]  659 	call	_writePin
                                    660 ;	main.c: 172: writePin(PD, 3, LOW);
      0083CD 4B 00            [ 1]  661 	push	#0x00
      0083CF A6 03            [ 1]  662 	ld	a, #0x03
      0083D1 AE 50 0F         [ 2]  663 	ldw	x, #0x500f
      0083D4 CD 85 9B         [ 4]  664 	call	_writePin
                                    665 ;	main.c: 173: while (b < 8)
      0083D7                        666 00130$:
      0083D7 C6 00 02         [ 1]  667 	ld	a, _b+0
      0083DA A1 08            [ 1]  668 	cp	a, #0x08
      0083DC 24 3D            [ 1]  669 	jrnc	00132$
                                    670 ;	main.c: 175: write_SPI(~(1 << b));
      0083DE C6 00 02         [ 1]  671 	ld	a, _b+0
      0083E1 97               [ 1]  672 	ld	xl, a
      0083E2 A6 01            [ 1]  673 	ld	a, #0x01
      0083E4 88               [ 1]  674 	push	a
      0083E5 9F               [ 1]  675 	ld	a, xl
      0083E6 4D               [ 1]  676 	tnz	a
      0083E7 27 05            [ 1]  677 	jreq	00263$
      0083E9                        678 00262$:
      0083E9 08 01            [ 1]  679 	sll	(1, sp)
      0083EB 4A               [ 1]  680 	dec	a
      0083EC 26 FB            [ 1]  681 	jrne	00262$
      0083EE                        682 00263$:
      0083EE 84               [ 1]  683 	pop	a
      0083EF 43               [ 1]  684 	cpl	a
      0083F0 CD 8B 36         [ 4]  685 	call	_write_SPI
                                    686 ;	main.c: 176: write_SPI(DIGIT_EIGHT);
      0083F3 A6 10            [ 1]  687 	ld	a, #0x10
      0083F5 CD 8B 36         [ 4]  688 	call	_write_SPI
                                    689 ;	main.c: 177: writePin(PD, 3, HIGH);
      0083F8 4B 01            [ 1]  690 	push	#0x01
      0083FA A6 03            [ 1]  691 	ld	a, #0x03
      0083FC AE 50 0F         [ 2]  692 	ldw	x, #0x500f
      0083FF CD 85 9B         [ 4]  693 	call	_writePin
                                    694 ;	main.c: 178: writePin(PD, 3, LOW);
      008402 4B 00            [ 1]  695 	push	#0x00
      008404 A6 03            [ 1]  696 	ld	a, #0x03
      008406 AE 50 0F         [ 2]  697 	ldw	x, #0x500f
      008409 CD 85 9B         [ 4]  698 	call	_writePin
                                    699 ;	main.c: 179: b++;
      00840C 72 5C 00 02      [ 1]  700 	inc	_b+0
                                    701 ;	main.c: 180: delay(DELAY_TIME);
      008410 4B C8            [ 1]  702 	push	#0xc8
      008412 5F               [ 1]  703 	clrw	x
      008413 89               [ 2]  704 	pushw	x
      008414 4B 00            [ 1]  705 	push	#0x00
      008416 CD 8B BA         [ 4]  706 	call	_delay
      008419 20 BC            [ 2]  707 	jra	00130$
      00841B                        708 00132$:
                                    709 ;	main.c: 182: b = 0;
      00841B 72 5F 00 02      [ 1]  710 	clr	_b+0
                                    711 ;	main.c: 184: }
      00841F                        712 00133$:
                                    713 ;	main.c: 185: a++;
      00841F 72 5C 00 01      [ 1]  714 	inc	_a+0
      008423 CC 80 B5         [ 2]  715 	jp	00134$
      008426                        716 00136$:
                                    717 ;	main.c: 187: a = 0;
      008426 72 5F 00 01      [ 1]  718 	clr	_a+0
                                    719 ;	main.c: 189: }
      00842A CC 80 B5         [ 2]  720 	jp	00134$
                                    721 	.area CODE
                                    722 	.area CONST
                                    723 	.area INITIALIZER
      008088                        724 __xinit__a:
      008088 00                     725 	.db #0x00	; 0
      008089                        726 __xinit__b:
      008089 00                     727 	.db #0x00	; 0
                                    728 	.area CABS (ABS)
