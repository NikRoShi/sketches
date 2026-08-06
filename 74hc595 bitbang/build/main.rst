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
                                     12 	.globl _BB_transmite
                                     13 	.globl _TIM4_UPD_OVF_IRQHandler
                                     14 	.globl _delay
                                     15 	.globl _init_TIME
                                     16 	.globl _tick_TIME
                                     17 	.globl _writePin
                                     18 	.globl _pinMode
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; Stack segment in internal ram
                                     29 ;--------------------------------------------------------
                                     30 	.area	SSEG
      000007                         31 __start__stack:
      000007                         32 	.ds	1
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; interrupt vector
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
      008000                         51 __interrupt_vect:
      008000 82 00 80 6B             52 	int s_GSINIT ; reset
      008004 82 00 00 00             53 	int 0x000000 ; trap
      008008 82 00 00 00             54 	int 0x000000 ; int0
      00800C 82 00 00 00             55 	int 0x000000 ; int1
      008010 82 00 00 00             56 	int 0x000000 ; int2
      008014 82 00 00 00             57 	int 0x000000 ; int3
      008018 82 00 00 00             58 	int 0x000000 ; int4
      00801C 82 00 00 00             59 	int 0x000000 ; int5
      008020 82 00 00 00             60 	int 0x000000 ; int6
      008024 82 00 00 00             61 	int 0x000000 ; int7
      008028 82 00 00 00             62 	int 0x000000 ; int8
      00802C 82 00 00 00             63 	int 0x000000 ; int9
      008030 82 00 00 00             64 	int 0x000000 ; int10
      008034 82 00 00 00             65 	int 0x000000 ; int11
      008038 82 00 00 00             66 	int 0x000000 ; int12
      00803C 82 00 00 00             67 	int 0x000000 ; int13
      008040 82 00 00 00             68 	int 0x000000 ; int14
      008044 82 00 00 00             69 	int 0x000000 ; int15
      008048 82 00 00 00             70 	int 0x000000 ; int16
      00804C 82 00 00 00             71 	int 0x000000 ; int17
      008050 82 00 00 00             72 	int 0x000000 ; int18
      008054 82 00 00 00             73 	int 0x000000 ; int19
      008058 82 00 00 00             74 	int 0x000000 ; int20
      00805C 82 00 00 00             75 	int 0x000000 ; int21
      008060 82 00 00 00             76 	int 0x000000 ; int22
      008064 82 00 80 8E             77 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     78 ;--------------------------------------------------------
                                     79 ; global & static initialisations
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area GSINIT
                                     83 	.area GSFINAL
                                     84 	.area GSINIT
      00806B                         85 __sdcc_init_data:
                                     86 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   87 	ldw x, #l_DATA
      00806E 27 07            [ 1]   88 	jreq	00002$
      008070                         89 00001$:
      008070 72 4F 00 00      [ 1]   90 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   91 	decw x
      008075 26 F9            [ 1]   92 	jrne	00001$
      008077                         93 00002$:
      008077 AE 00 06         [ 2]   94 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   95 	jreq	00004$
      00807C                         96 00003$:
      00807C D6 80 87         [ 1]   97 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]   98 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]   99 	decw	x
      008083 26 F7            [ 1]  100 	jrne	00003$
      008085                        101 00004$:
                                    102 ; stm8_genXINIT() end
                                    103 	.area GSFINAL
      008085 CC 80 68         [ 2]  104 	jp	__sdcc_program_startup
                                    105 ;--------------------------------------------------------
                                    106 ; Home
                                    107 ;--------------------------------------------------------
                                    108 	.area HOME
                                    109 	.area HOME
      008068                        110 __sdcc_program_startup:
      008068 CC 81 22         [ 2]  111 	jp	_main
                                    112 ;	return from main will return to caller
                                    113 ;--------------------------------------------------------
                                    114 ; code
                                    115 ;--------------------------------------------------------
                                    116 	.area CODE
                                    117 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
                                    118 ;	-----------------------------------------
                                    119 ;	 function TIM4_UPD_OVF_IRQHandler
                                    120 ;	-----------------------------------------
      00808E                        121 _TIM4_UPD_OVF_IRQHandler:
      00808E 4F               [ 1]  122 	clr	a
      00808F 62               [ 2]  123 	div	x, a
                                    124 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      008090 72 11 53 44      [ 1]  125 	bres	0x5344, #0
                                    126 ;	main.c: 8: tick_TIME();
      008094 CD 87 F6         [ 4]  127 	call	_tick_TIME
                                    128 ;	main.c: 9: }
      008097 80               [11]  129 	iret
                                    130 ;	main.c: 11: void BB_transmite(uint8_t data)
                                    131 ;	-----------------------------------------
                                    132 ;	 function BB_transmite
                                    133 ;	-----------------------------------------
      008098                        134 _BB_transmite:
      008098 52 02            [ 2]  135 	sub	sp, #2
      00809A 6B 01            [ 1]  136 	ld	(0x01, sp), a
                                    137 ;	main.c: 13: writePin(PD, 2, LOW);	// latc в low
      00809C 4B 00            [ 1]  138 	push	#0x00
      00809E A6 02            [ 1]  139 	ld	a, #0x02
      0080A0 AE 50 0F         [ 2]  140 	ldw	x, #0x500f
      0080A3 CD 82 D9         [ 4]  141 	call	_writePin
                                    142 ;	main.c: 14: writePin(PC, 5, LOW);	// clk в low
      0080A6 4B 00            [ 1]  143 	push	#0x00
      0080A8 A6 05            [ 1]  144 	ld	a, #0x05
      0080AA AE 50 0A         [ 2]  145 	ldw	x, #0x500a
      0080AD CD 82 D9         [ 4]  146 	call	_writePin
                                    147 ;	main.c: 15: writePin(PC, 6, LOW);	// data в low
      0080B0 4B 00            [ 1]  148 	push	#0x00
      0080B2 A6 06            [ 1]  149 	ld	a, #0x06
      0080B4 AE 50 0A         [ 2]  150 	ldw	x, #0x500a
      0080B7 CD 82 D9         [ 4]  151 	call	_writePin
      0080BA 0F 02            [ 1]  152 	clr	(0x02, sp)
      0080BC                        153 00106$:
                                    154 ;	main.c: 17: for (uint8_t a; a < 8; a++)
      0080BC 7B 02            [ 1]  155 	ld	a, (0x02, sp)
      0080BE A1 08            [ 1]  156 	cp	a, #0x08
      0080C0 24 49            [ 1]  157 	jrnc	00104$
                                    158 ;	main.c: 19: if (data & 1)
      0080C2 7B 01            [ 1]  159 	ld	a, (0x01, sp)
      0080C4 44               [ 1]  160 	srl	a
      0080C5 24 20            [ 1]  161 	jrnc	00102$
                                    162 ;	main.c: 21: writePin(PC, 6, HIGH);	// data в high
      0080C7 4B 01            [ 1]  163 	push	#0x01
      0080C9 A6 06            [ 1]  164 	ld	a, #0x06
      0080CB AE 50 0A         [ 2]  165 	ldw	x, #0x500a
      0080CE CD 82 D9         [ 4]  166 	call	_writePin
                                    167 ;	main.c: 22: writePin(PC, 5, HIGH);	// clk в high
      0080D1 4B 01            [ 1]  168 	push	#0x01
      0080D3 A6 05            [ 1]  169 	ld	a, #0x05
      0080D5 AE 50 0A         [ 2]  170 	ldw	x, #0x500a
      0080D8 CD 82 D9         [ 4]  171 	call	_writePin
                                    172 ;	main.c: 23: writePin(PC, 5, LOW);	// clk в low
      0080DB 4B 00            [ 1]  173 	push	#0x00
      0080DD A6 05            [ 1]  174 	ld	a, #0x05
      0080DF AE 50 0A         [ 2]  175 	ldw	x, #0x500a
      0080E2 CD 82 D9         [ 4]  176 	call	_writePin
      0080E5 20 1E            [ 2]  177 	jra	00103$
      0080E7                        178 00102$:
                                    179 ;	main.c: 27: writePin(PC, 6, LOW);	// data в low
      0080E7 4B 00            [ 1]  180 	push	#0x00
      0080E9 A6 06            [ 1]  181 	ld	a, #0x06
      0080EB AE 50 0A         [ 2]  182 	ldw	x, #0x500a
      0080EE CD 82 D9         [ 4]  183 	call	_writePin
                                    184 ;	main.c: 28: writePin(PC, 5, HIGH);	// clk в high
      0080F1 4B 01            [ 1]  185 	push	#0x01
      0080F3 A6 05            [ 1]  186 	ld	a, #0x05
      0080F5 AE 50 0A         [ 2]  187 	ldw	x, #0x500a
      0080F8 CD 82 D9         [ 4]  188 	call	_writePin
                                    189 ;	main.c: 29: writePin(PC, 5, LOW);	// clk в low
      0080FB 4B 00            [ 1]  190 	push	#0x00
      0080FD A6 05            [ 1]  191 	ld	a, #0x05
      0080FF AE 50 0A         [ 2]  192 	ldw	x, #0x500a
      008102 CD 82 D9         [ 4]  193 	call	_writePin
      008105                        194 00103$:
                                    195 ;	main.c: 31: data = data >> 1;
      008105 04 01            [ 1]  196 	srl	(0x01, sp)
                                    197 ;	main.c: 17: for (uint8_t a; a < 8; a++)
      008107 0C 02            [ 1]  198 	inc	(0x02, sp)
      008109 20 B1            [ 2]  199 	jra	00106$
      00810B                        200 00104$:
                                    201 ;	main.c: 34: writePin(PD, 2, HIGH);	// latc в high
      00810B 4B 01            [ 1]  202 	push	#0x01
      00810D A6 02            [ 1]  203 	ld	a, #0x02
      00810F AE 50 0F         [ 2]  204 	ldw	x, #0x500f
      008112 CD 82 D9         [ 4]  205 	call	_writePin
                                    206 ;	main.c: 35: writePin(PD, 2, LOW);	// latc в low
      008115 4B 00            [ 1]  207 	push	#0x00
      008117 A6 02            [ 1]  208 	ld	a, #0x02
      008119 AE 50 0F         [ 2]  209 	ldw	x, #0x500f
      00811C CD 82 D9         [ 4]  210 	call	_writePin
                                    211 ;	main.c: 36: }
      00811F 5B 02            [ 2]  212 	addw	sp, #2
      008121 81               [ 4]  213 	ret
                                    214 ;	main.c: 38: int main(void)
                                    215 ;	-----------------------------------------
                                    216 ;	 function main
                                    217 ;	-----------------------------------------
      008122                        218 _main:
      008122 88               [ 1]  219 	push	a
                                    220 ;	main.c: 40: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008123 35 00 50 C6      [ 1]  221 	mov	0x50c6+0, #0x00
                                    222 ;	main.c: 42: init_TIME();
      008127 CD 88 0A         [ 4]  223 	call	_init_TIME
                                    224 ;	main.c: 44: uint8_t i = 0;
      00812A 0F 01            [ 1]  225 	clr	(0x01, sp)
                                    226 ;	main.c: 46: pinMode(PC, 5, OUTPUT); // CLK
      00812C 4B 00            [ 1]  227 	push	#0x00
      00812E A6 05            [ 1]  228 	ld	a, #0x05
      008130 AE 50 0A         [ 2]  229 	ldw	x, #0x500a
      008133 CD 82 4B         [ 4]  230 	call	_pinMode
                                    231 ;	main.c: 47: pinMode(PC, 6, OUTPUT);	// data
      008136 4B 00            [ 1]  232 	push	#0x00
      008138 A6 06            [ 1]  233 	ld	a, #0x06
      00813A AE 50 0A         [ 2]  234 	ldw	x, #0x500a
      00813D CD 82 4B         [ 4]  235 	call	_pinMode
                                    236 ;	main.c: 48: pinMode(PD, 2, OUTPUT);	// latc
      008140 4B 00            [ 1]  237 	push	#0x00
      008142 A6 02            [ 1]  238 	ld	a, #0x02
      008144 AE 50 0F         [ 2]  239 	ldw	x, #0x500f
      008147 CD 82 4B         [ 4]  240 	call	_pinMode
                                    241 ;	main.c: 50: while (1)
      00814A                        242 00103$:
                                    243 ;	main.c: 52: BB_transmite(0);
      00814A 4F               [ 1]  244 	clr	a
      00814B CD 80 98         [ 4]  245 	call	_BB_transmite
                                    246 ;	main.c: 53: for (i; i < 255; i++) {
      00814E 7B 01            [ 1]  247 	ld	a, (0x01, sp)
      008150                        248 00106$:
      008150 A1 FF            [ 1]  249 	cp	a, #0xff
      008152 24 11            [ 1]  250 	jrnc	00101$
                                    251 ;	main.c: 54: BB_transmite(i);
      008154 88               [ 1]  252 	push	a
      008155 CD 80 98         [ 4]  253 	call	_BB_transmite
      008158 4B 32            [ 1]  254 	push	#0x32
      00815A 5F               [ 1]  255 	clrw	x
      00815B 89               [ 2]  256 	pushw	x
      00815C 4B 00            [ 1]  257 	push	#0x00
      00815E CD 88 72         [ 4]  258 	call	_delay
      008161 84               [ 1]  259 	pop	a
                                    260 ;	main.c: 53: for (i; i < 255; i++) {
      008162 4C               [ 1]  261 	inc	a
      008163 20 EB            [ 2]  262 	jra	00106$
      008165                        263 00101$:
                                    264 ;	main.c: 57: i = 0;
      008165 0F 01            [ 1]  265 	clr	(0x01, sp)
      008167 20 E1            [ 2]  266 	jra	00103$
                                    267 ;	main.c: 59: }
      008169 84               [ 1]  268 	pop	a
      00816A 81               [ 4]  269 	ret
                                    270 	.area CODE
                                    271 	.area CONST
                                    272 	.area INITIALIZER
                                    273 	.area CABS (ABS)
