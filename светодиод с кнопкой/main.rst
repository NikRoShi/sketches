                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _tim4_inerrupts
                                     12 	.globl _digitalRead
                                     13 	.globl _digitalWrite
                                     14 	.globl _pinMode
                                     15 	.globl _tim4_tick
                                     16 	.globl _time_init
                                     17 	.globl _millis
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; Stack segment in internal ram
                                     28 ;--------------------------------------------------------
                                     29 	.area SSEG
      000025                         30 __start__stack:
      000025                         31 	.ds	1
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 
                                     38 ; default segment ordering for linker
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area CONST
                                     43 	.area INITIALIZER
                                     44 	.area CODE
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; interrupt vector
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
      008000                         50 __interrupt_vect:
      008000 82 00 80 6B             51 	int s_GSINIT ; reset
      008004 82 00 00 00             52 	int 0x000000 ; trap
      008008 82 00 00 00             53 	int 0x000000 ; int0
      00800C 82 00 00 00             54 	int 0x000000 ; int1
      008010 82 00 00 00             55 	int 0x000000 ; int2
      008014 82 00 00 00             56 	int 0x000000 ; int3
      008018 82 00 00 00             57 	int 0x000000 ; int4
      00801C 82 00 00 00             58 	int 0x000000 ; int5
      008020 82 00 00 00             59 	int 0x000000 ; int6
      008024 82 00 00 00             60 	int 0x000000 ; int7
      008028 82 00 00 00             61 	int 0x000000 ; int8
      00802C 82 00 00 00             62 	int 0x000000 ; int9
      008030 82 00 00 00             63 	int 0x000000 ; int10
      008034 82 00 00 00             64 	int 0x000000 ; int11
      008038 82 00 00 00             65 	int 0x000000 ; int12
      00803C 82 00 00 00             66 	int 0x000000 ; int13
      008040 82 00 00 00             67 	int 0x000000 ; int14
      008044 82 00 00 00             68 	int 0x000000 ; int15
      008048 82 00 00 00             69 	int 0x000000 ; int16
      00804C 82 00 00 00             70 	int 0x000000 ; int17
      008050 82 00 00 00             71 	int 0x000000 ; int18
      008054 82 00 00 00             72 	int 0x000000 ; int19
      008058 82 00 00 00             73 	int 0x000000 ; int20
      00805C 82 00 00 00             74 	int 0x000000 ; int21
      008060 82 00 00 00             75 	int 0x000000 ; int22
      008064 82 00 80 B5             76 	int _tim4_inerrupts ; int23
                                     77 ;--------------------------------------------------------
                                     78 ; global & static initialisations
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area GSINIT
                                     82 	.area GSFINAL
                                     83 	.area GSINIT
      00806B CD 82 AA         [ 4]   84 	call	___sdcc_external_startup
      00806E 4D               [ 1]   85 	tnz	a
      00806F 27 03            [ 1]   86 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   87 	jp	__sdcc_program_startup
      008074                         88 __sdcc_init_data:
                                     89 ; stm8_genXINIT() start
      008074 AE 00 00         [ 2]   90 	ldw x, #l_DATA
      008077 27 07            [ 1]   91 	jreq	00002$
      008079                         92 00001$:
      008079 72 4F 00 00      [ 1]   93 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   94 	decw x
      00807E 26 F9            [ 1]   95 	jrne	00001$
      008080                         96 00002$:
      008080 AE 00 24         [ 2]   97 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]   98 	jreq	00004$
      008085                         99 00003$:
      008085 D6 80 90         [ 1]  100 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 00         [ 1]  101 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  102 	decw	x
      00808C 26 F7            [ 1]  103 	jrne	00003$
      00808E                        104 00004$:
                                    105 ; stm8_genXINIT() end
                                    106 	.area GSFINAL
      00808E CC 80 68         [ 2]  107 	jp	__sdcc_program_startup
                                    108 ;--------------------------------------------------------
                                    109 ; Home
                                    110 ;--------------------------------------------------------
                                    111 	.area HOME
                                    112 	.area HOME
      008068                        113 __sdcc_program_startup:
      008068 CC 80 BF         [ 2]  114 	jp	_main
                                    115 ;	return from main will return to caller
                                    116 ;--------------------------------------------------------
                                    117 ; code
                                    118 ;--------------------------------------------------------
                                    119 	.area CODE
                                    120 ;	main.c: 6: void tim4_inerrupts(void) __interrupt(23)
                                    121 ;	-----------------------------------------
                                    122 ;	 function tim4_inerrupts
                                    123 ;	-----------------------------------------
      0080B5                        124 _tim4_inerrupts:
      0080B5 4F               [ 1]  125 	clr	a
      0080B6 62               [ 2]  126 	div	x, a
                                    127 ;	main.c: 8: TIM4_SR = 0;
      0080B7 35 00 53 44      [ 1]  128 	mov	0x5344+0, #0x00
                                    129 ;	main.c: 9: tim4_tick();
      0080BB CD 82 68         [ 4]  130 	call	_tim4_tick
                                    131 ;	main.c: 10: }
      0080BE 80               [11]  132 	iret
                                    133 ;	main.c: 12: void main(void)
                                    134 ;	-----------------------------------------
                                    135 ;	 function main
                                    136 ;	-----------------------------------------
      0080BF                        137 _main:
      0080BF 52 09            [ 2]  138 	sub	sp, #9
                                    139 ;	main.c: 14: pinMode(PORT_A, 1, PIN_INPUT_PULLUP);
      0080C1 4B 02            [ 1]  140 	push	#0x02
      0080C3 4B 01            [ 1]  141 	push	#0x01
      0080C5 4F               [ 1]  142 	clr	a
      0080C6 CD 81 89         [ 4]  143 	call	_pinMode
                                    144 ;	main.c: 15: pinMode(PORT_B, 5, PIN_OUTPUT);
      0080C9 4B 01            [ 1]  145 	push	#0x01
      0080CB 4B 05            [ 1]  146 	push	#0x05
      0080CD A6 01            [ 1]  147 	ld	a, #0x01
      0080CF CD 81 89         [ 4]  148 	call	_pinMode
                                    149 ;	main.c: 17: time_init();
      0080D2 CD 82 7C         [ 4]  150 	call	_time_init
                                    151 ;	main.c: 18: enableInterrupts();
      0080D5 9A               [ 1]  152 	rim
                                    153 ;	main.c: 20: uint32_t timer0 = 0;
      0080D6 5F               [ 1]  154 	clrw	x
      0080D7 1F 03            [ 2]  155 	ldw	(0x03, sp), x
      0080D9 1F 01            [ 2]  156 	ldw	(0x01, sp), x
                                    157 ;	main.c: 22: uint8_t flag = 0;
      0080DB 0F 05            [ 1]  158 	clr	(0x05, sp)
                                    159 ;	main.c: 24: while(1)
      0080DD                        160 00116$:
                                    161 ;	main.c: 26: button = !digitalRead(PORT_A, 1);
      0080DD 4B 01            [ 1]  162 	push	#0x01
      0080DF 4F               [ 1]  163 	clr	a
      0080E0 CD 82 39         [ 4]  164 	call	_digitalRead
      0080E3 A0 01            [ 1]  165 	sub	a, #0x01
      0080E5 4F               [ 1]  166 	clr	a
      0080E6 49               [ 1]  167 	rlc	a
                                    168 ;	main.c: 27: if (button == 1 && flag == 0 && millis() - timer0 >= 50) {
      0080E7 6B 06            [ 1]  169 	ld	(0x06, sp), a
      0080E9 4A               [ 1]  170 	dec	a
      0080EA 26 05            [ 1]  171 	jrne	00184$
      0080EC A6 01            [ 1]  172 	ld	a, #0x01
      0080EE 6B 07            [ 1]  173 	ld	(0x07, sp), a
      0080F0 C5                     174 	.byte 0xc5
      0080F1                        175 00184$:
      0080F1 0F 07            [ 1]  176 	clr	(0x07, sp)
      0080F3                        177 00185$:
                                    178 ;	main.c: 29: flag = !flag;
      0080F3 7B 05            [ 1]  179 	ld	a, (0x05, sp)
      0080F5 A0 01            [ 1]  180 	sub	a, #0x01
      0080F7 4F               [ 1]  181 	clr	a
      0080F8 49               [ 1]  182 	rlc	a
      0080F9 6B 08            [ 1]  183 	ld	(0x08, sp), a
                                    184 ;	main.c: 27: if (button == 1 && flag == 0 && millis() - timer0 >= 50) {
      0080FB 0D 07            [ 1]  185 	tnz	(0x07, sp)
      0080FD 27 2E            [ 1]  186 	jreq	00111$
      0080FF 0D 05            [ 1]  187 	tnz	(0x05, sp)
      008101 26 2A            [ 1]  188 	jrne	00111$
      008103 CD 82 A0         [ 4]  189 	call	_millis
      008106 72 F0 03         [ 2]  190 	subw	x, (0x03, sp)
      008109 90 9F            [ 1]  191 	ld	a, yl
      00810B 12 02            [ 1]  192 	sbc	a, (0x02, sp)
      00810D 90 97            [ 1]  193 	ld	yl, a
      00810F 90 9E            [ 1]  194 	ld	a, yh
      008111 12 01            [ 1]  195 	sbc	a, (0x01, sp)
      008113 88               [ 1]  196 	push	a
      008114 A3 00 32         [ 2]  197 	cpw	x, #0x0032
      008117 90 9F            [ 1]  198 	ld	a, yl
      008119 A2 00            [ 1]  199 	sbc	a, #0x00
      00811B 84               [ 1]  200 	pop	a
      00811C A2 00            [ 1]  201 	sbc	a, #0x00
      00811E 25 0D            [ 1]  202 	jrc	00111$
                                    203 ;	main.c: 28: timer0 = millis();
      008120 CD 82 A0         [ 4]  204 	call	_millis
      008123 1F 03            [ 2]  205 	ldw	(0x03, sp), x
      008125 17 01            [ 2]  206 	ldw	(0x01, sp), y
                                    207 ;	main.c: 29: flag = !flag;
      008127 7B 08            [ 1]  208 	ld	a, (0x08, sp)
      008129 6B 05            [ 1]  209 	ld	(0x05, sp), a
      00812B 20 B0            [ 2]  210 	jra	00116$
      00812D                        211 00111$:
                                    212 ;	main.c: 32: else if (button == 1 && flag == 1) {
      00812D 7B 05            [ 1]  213 	ld	a, (0x05, sp)
      00812F 4A               [ 1]  214 	dec	a
      008130 26 05            [ 1]  215 	jrne	00190$
      008132 A6 01            [ 1]  216 	ld	a, #0x01
      008134 6B 09            [ 1]  217 	ld	(0x09, sp), a
      008136 C5                     218 	.byte 0xc5
      008137                        219 00190$:
      008137 0F 09            [ 1]  220 	clr	(0x09, sp)
      008139                        221 00191$:
      008139 0D 07            [ 1]  222 	tnz	(0x07, sp)
      00813B 27 0F            [ 1]  223 	jreq	00107$
      00813D 0D 09            [ 1]  224 	tnz	(0x09, sp)
      00813F 27 0B            [ 1]  225 	jreq	00107$
                                    226 ;	main.c: 33: digitalWrite(PORT_B, 5, LOW);
      008141 4B 00            [ 1]  227 	push	#0x00
      008143 4B 05            [ 1]  228 	push	#0x05
      008145 A6 01            [ 1]  229 	ld	a, #0x01
      008147 CD 81 E8         [ 4]  230 	call	_digitalWrite
      00814A 20 91            [ 2]  231 	jra	00116$
      00814C                        232 00107$:
                                    233 ;	main.c: 35: else if (button == 0 && flag == 1 && millis() - timer0 >= 50) {
      00814C 0D 06            [ 1]  234 	tnz	(0x06, sp)
      00814E 26 2D            [ 1]  235 	jrne	00102$
      008150 0D 09            [ 1]  236 	tnz	(0x09, sp)
      008152 27 29            [ 1]  237 	jreq	00102$
      008154 CD 82 A0         [ 4]  238 	call	_millis
      008157 51               [ 1]  239 	exgw	x, y
      008158 72 F2 03         [ 2]  240 	subw	y, (0x03, sp)
      00815B 9F               [ 1]  241 	ld	a, xl
      00815C 12 02            [ 1]  242 	sbc	a, (0x02, sp)
      00815E 97               [ 1]  243 	ld	xl, a
      00815F 9E               [ 1]  244 	ld	a, xh
      008160 12 01            [ 1]  245 	sbc	a, (0x01, sp)
      008162 88               [ 1]  246 	push	a
      008163 90 A3 00 32      [ 2]  247 	cpw	y, #0x0032
      008167 9F               [ 1]  248 	ld	a, xl
      008168 A2 00            [ 1]  249 	sbc	a, #0x00
      00816A 84               [ 1]  250 	pop	a
      00816B A2 00            [ 1]  251 	sbc	a, #0x00
      00816D 25 0E            [ 1]  252 	jrc	00102$
                                    253 ;	main.c: 36: timer0 = millis();
      00816F CD 82 A0         [ 4]  254 	call	_millis
      008172 1F 03            [ 2]  255 	ldw	(0x03, sp), x
      008174 17 01            [ 2]  256 	ldw	(0x01, sp), y
                                    257 ;	main.c: 37: flag = !flag;
      008176 7B 08            [ 1]  258 	ld	a, (0x08, sp)
      008178 6B 05            [ 1]  259 	ld	(0x05, sp), a
      00817A CC 80 DD         [ 2]  260 	jp	00116$
      00817D                        261 00102$:
                                    262 ;	main.c: 39: else digitalWrite(PORT_B, 5, HIGH);
      00817D 4B 01            [ 1]  263 	push	#0x01
      00817F 4B 05            [ 1]  264 	push	#0x05
      008181 A6 01            [ 1]  265 	ld	a, #0x01
      008183 CD 81 E8         [ 4]  266 	call	_digitalWrite
                                    267 ;	main.c: 41: }
      008186 CC 80 DD         [ 2]  268 	jp	00116$
                                    269 	.area CODE
                                    270 	.area CONST
                                    271 	.area INITIALIZER
                                    272 	.area CABS (ABS)
