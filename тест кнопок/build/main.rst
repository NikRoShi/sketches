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
                                     13 	.globl _readPin
                                     14 	.globl _writePin
                                     15 	.globl _pinMode
                                     16 	.globl _get_ms
                                     17 	.globl _init_TIME
                                     18 	.globl _tick_TIME
                                     19 	.globl _butFlg3
                                     20 	.globl _butFlg2
                                     21 	.globl _butFlg1
                                     22 	.globl _timer
                                     23 	.globl _timBut3
                                     24 	.globl _timBut2
                                     25 	.globl _timBut1
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
      00000C                         34 _timBut1::
      00000C                         35 	.ds 4
      000010                         36 _timBut2::
      000010                         37 	.ds 4
      000014                         38 _timBut3::
      000014                         39 	.ds 4
      000018                         40 _timer::
      000018                         41 	.ds 4
      00001C                         42 _butFlg1::
      00001C                         43 	.ds 1
      00001D                         44 _butFlg2::
      00001D                         45 	.ds 1
      00001E                         46 _butFlg3::
      00001E                         47 	.ds 1
                                     48 ;--------------------------------------------------------
                                     49 ; Stack segment in internal ram
                                     50 ;--------------------------------------------------------
                                     51 	.area	SSEG
      000027                         52 __start__stack:
      000027                         53 	.ds	1
                                     54 
                                     55 ;--------------------------------------------------------
                                     56 ; absolute external ram data
                                     57 ;--------------------------------------------------------
                                     58 	.area DABS (ABS)
                                     59 
                                     60 ; default segment ordering for linker
                                     61 	.area HOME
                                     62 	.area GSINIT
                                     63 	.area GSFINAL
                                     64 	.area CONST
                                     65 	.area INITIALIZER
                                     66 	.area CODE
                                     67 
                                     68 ;--------------------------------------------------------
                                     69 ; interrupt vector
                                     70 ;--------------------------------------------------------
                                     71 	.area HOME
      008000                         72 __interrupt_vect:
      008000 82 00 80 6B             73 	int s_GSINIT ; reset
      008004 82 00 00 00             74 	int 0x000000 ; trap
      008008 82 00 00 00             75 	int 0x000000 ; int0
      00800C 82 00 00 00             76 	int 0x000000 ; int1
      008010 82 00 00 00             77 	int 0x000000 ; int2
      008014 82 00 00 00             78 	int 0x000000 ; int3
      008018 82 00 00 00             79 	int 0x000000 ; int4
      00801C 82 00 00 00             80 	int 0x000000 ; int5
      008020 82 00 00 00             81 	int 0x000000 ; int6
      008024 82 00 00 00             82 	int 0x000000 ; int7
      008028 82 00 00 00             83 	int 0x000000 ; int8
      00802C 82 00 00 00             84 	int 0x000000 ; int9
      008030 82 00 00 00             85 	int 0x000000 ; int10
      008034 82 00 00 00             86 	int 0x000000 ; int11
      008038 82 00 00 00             87 	int 0x000000 ; int12
      00803C 82 00 00 00             88 	int 0x000000 ; int13
      008040 82 00 00 00             89 	int 0x000000 ; int14
      008044 82 00 00 00             90 	int 0x000000 ; int15
      008048 82 00 00 00             91 	int 0x000000 ; int16
      00804C 82 00 00 00             92 	int 0x000000 ; int17
      008050 82 00 00 00             93 	int 0x000000 ; int18
      008054 82 00 00 00             94 	int 0x000000 ; int19
      008058 82 00 00 00             95 	int 0x000000 ; int20
      00805C 82 00 00 00             96 	int 0x000000 ; int21
      008060 82 00 00 00             97 	int 0x000000 ; int22
      008064 82 00 80 B5             98 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     99 ;--------------------------------------------------------
                                    100 ; global & static initialisations
                                    101 ;--------------------------------------------------------
                                    102 	.area HOME
                                    103 	.area GSINIT
                                    104 	.area GSFINAL
                                    105 	.area GSINIT
      00806B                        106 __sdcc_init_data:
                                    107 ; stm8_genXINIT() start
      00806B AE 00 0B         [ 2]  108 	ldw x, #l_DATA
      00806E 27 07            [ 1]  109 	jreq	00002$
      008070                        110 00001$:
      008070 72 4F 00 00      [ 1]  111 	clr (s_DATA - 1, x)
      008074 5A               [ 2]  112 	decw x
      008075 26 F9            [ 1]  113 	jrne	00001$
      008077                        114 00002$:
      008077 AE 00 1B         [ 2]  115 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]  116 	jreq	00004$
      00807C                        117 00003$:
      00807C D6 80 99         [ 1]  118 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 0B         [ 1]  119 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]  120 	decw	x
      008083 26 F7            [ 1]  121 	jrne	00003$
      008085                        122 00004$:
                                    123 ; stm8_genXINIT() end
                                    124 	.area GSFINAL
      008085 CC 80 68         [ 2]  125 	jp	__sdcc_program_startup
                                    126 ;--------------------------------------------------------
                                    127 ; Home
                                    128 ;--------------------------------------------------------
                                    129 	.area HOME
                                    130 	.area HOME
      008068                        131 __sdcc_program_startup:
      008068 CC 80 BF         [ 2]  132 	jp	_main
                                    133 ;	return from main will return to caller
                                    134 ;--------------------------------------------------------
                                    135 ; code
                                    136 ;--------------------------------------------------------
                                    137 	.area CODE
                                    138 ;	main.c: 15: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function TIM4_UPD_OVF_IRQHandler
                                    141 ;	-----------------------------------------
      0080B5                        142 _TIM4_UPD_OVF_IRQHandler:
      0080B5 4F               [ 1]  143 	clr	a
      0080B6 62               [ 2]  144 	div	x, a
                                    145 ;	main.c: 16: TIM4_SR &= ~(1 << 0);
      0080B7 72 11 53 44      [ 1]  146 	bres	0x5344, #0
                                    147 ;	main.c: 17: tick_TIME();
      0080BB CD 89 40         [ 4]  148 	call	_tick_TIME
                                    149 ;	main.c: 18: }
      0080BE 80               [11]  150 	iret
                                    151 ;	main.c: 20: int main(void)
                                    152 ;	-----------------------------------------
                                    153 ;	 function main
                                    154 ;	-----------------------------------------
      0080BF                        155 _main:
                                    156 ;	main.c: 22: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      0080BF 35 00 50 C6      [ 1]  157 	mov	0x50c6+0, #0x00
                                    158 ;	main.c: 23: init_TIME();
      0080C3 CD 89 54         [ 4]  159 	call	_init_TIME
                                    160 ;	main.c: 25: pinMode(PA, 1, INPUT_PULLUP);
      0080C6 4B 03            [ 1]  161 	push	#0x03
      0080C8 A6 01            [ 1]  162 	ld	a, #0x01
      0080CA AE 50 00         [ 2]  163 	ldw	x, #0x5000
      0080CD CD 83 0F         [ 4]  164 	call	_pinMode
                                    165 ;	main.c: 26: pinMode(PA, 2, INPUT_PULLUP);
      0080D0 4B 03            [ 1]  166 	push	#0x03
      0080D2 A6 02            [ 1]  167 	ld	a, #0x02
      0080D4 AE 50 00         [ 2]  168 	ldw	x, #0x5000
      0080D7 CD 83 0F         [ 4]  169 	call	_pinMode
                                    170 ;	main.c: 27: pinMode(PA, 3, INPUT_PULLUP);
      0080DA 4B 03            [ 1]  171 	push	#0x03
      0080DC A6 03            [ 1]  172 	ld	a, #0x03
      0080DE AE 50 00         [ 2]  173 	ldw	x, #0x5000
      0080E1 CD 83 0F         [ 4]  174 	call	_pinMode
                                    175 ;	main.c: 28: pinMode(PD, 3, OUTPUT);
      0080E4 4B 00            [ 1]  176 	push	#0x00
      0080E6 A6 03            [ 1]  177 	ld	a, #0x03
      0080E8 AE 50 0F         [ 2]  178 	ldw	x, #0x500f
      0080EB CD 83 0F         [ 4]  179 	call	_pinMode
                                    180 ;	main.c: 30: while (1)
      0080EE                        181 00108$:
                                    182 ;	main.c: 32: if (readPin(PA, 1) == 0 && butFlg1 == 0)
      0080EE A6 01            [ 1]  183 	ld	a, #0x01
      0080F0 AE 50 00         [ 2]  184 	ldw	x, #0x5000
      0080F3 CD 83 E5         [ 4]  185 	call	_readPin
      0080F6 4D               [ 1]  186 	tnz	a
      0080F7 26 1D            [ 1]  187 	jrne	00102$
      0080F9 C6 00 1C         [ 1]  188 	ld	a, _butFlg1+0
      0080FC 26 18            [ 1]  189 	jrne	00102$
                                    190 ;	main.c: 34: butFlg1 = 1;
      0080FE 35 01 00 1C      [ 1]  191 	mov	_butFlg1+0, #0x01
                                    192 ;	main.c: 35: timBut1 = get_ms();
      008102 CD 89 74         [ 4]  193 	call	_get_ms
      008105 CF 00 0E         [ 2]  194 	ldw	_timBut1+2, x
      008108 90 CF 00 0C      [ 2]  195 	ldw	_timBut1+0, y
                                    196 ;	main.c: 36: writePin(PD, 3, HIGH);
      00810C 4B 01            [ 1]  197 	push	#0x01
      00810E A6 03            [ 1]  198 	ld	a, #0x03
      008110 AE 50 0F         [ 2]  199 	ldw	x, #0x500f
      008113 CD 83 9D         [ 4]  200 	call	_writePin
      008116                        201 00102$:
                                    202 ;	main.c: 38: if (readPin(PA, 1) == 1 && butFlg1 == 1)
      008116 A6 01            [ 1]  203 	ld	a, #0x01
      008118 AE 50 00         [ 2]  204 	ldw	x, #0x5000
      00811B CD 83 E5         [ 4]  205 	call	_readPin
      00811E 4A               [ 1]  206 	dec	a
      00811F 26 CD            [ 1]  207 	jrne	00108$
      008121 C6 00 1C         [ 1]  208 	ld	a, _butFlg1+0
      008124 4A               [ 1]  209 	dec	a
      008125 26 C7            [ 1]  210 	jrne	00108$
                                    211 ;	main.c: 40: butFlg1 = 0;
      008127 72 5F 00 1C      [ 1]  212 	clr	_butFlg1+0
                                    213 ;	main.c: 41: timBut1 = get_ms();
      00812B CD 89 74         [ 4]  214 	call	_get_ms
      00812E CF 00 0E         [ 2]  215 	ldw	_timBut1+2, x
      008131 90 CF 00 0C      [ 2]  216 	ldw	_timBut1+0, y
                                    217 ;	main.c: 42: writePin(PD, 3, LOW);
      008135 4B 00            [ 1]  218 	push	#0x00
      008137 A6 03            [ 1]  219 	ld	a, #0x03
      008139 AE 50 0F         [ 2]  220 	ldw	x, #0x500f
      00813C CD 83 9D         [ 4]  221 	call	_writePin
      00813F 20 AD            [ 2]  222 	jra	00108$
                                    223 ;	main.c: 45: }
      008141 81               [ 4]  224 	ret
                                    225 	.area CODE
                                    226 	.area CONST
                                    227 	.area INITIALIZER
      00809A                        228 __xinit__timBut1:
      00809A 00 00 00 00            229 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      00809E                        230 __xinit__timBut2:
      00809E 00 00 00 00            231 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      0080A2                        232 __xinit__timBut3:
      0080A2 00 00 00 00            233 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      0080A6                        234 __xinit__timer:
      0080A6 00 00 00 00            235 	.byte #0x00, #0x00, #0x00, #0x00	; 0
      0080AA                        236 __xinit__butFlg1:
      0080AA 00                     237 	.db #0x00	; 0
      0080AB                        238 __xinit__butFlg2:
      0080AB 00                     239 	.db #0x00	; 0
      0080AC                        240 __xinit__butFlg3:
      0080AC 00                     241 	.db #0x00	; 0
                                    242 	.area CABS (ABS)
