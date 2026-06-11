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
                                     11 	.globl _TIM4_UPD_OVF_IRQHandler
                                     12 	.globl _sendLine_UART
                                     13 	.globl _sendString_UART
                                     14 	.globl _init_UART
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
      000005                         30 __start__stack:
      000005                         31 	.ds	1
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
      008064 82 00 80 A2             76 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     77 ;--------------------------------------------------------
                                     78 ; global & static initialisations
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area GSINIT
                                     82 	.area GSFINAL
                                     83 	.area GSINIT
      00806B CD 82 6C         [ 4]   84 	call	___sdcc_external_startup
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
      008080 AE 00 04         [ 2]   97 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]   98 	jreq	00004$
      008085                         99 00003$:
      008085 D6 80 9D         [ 1]  100 	ld	a, (s_INITIALIZER - 1, x)
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
      008068 CC 80 AC         [ 2]  114 	jp	_main
                                    115 ;	return from main will return to caller
                                    116 ;--------------------------------------------------------
                                    117 ; code
                                    118 ;--------------------------------------------------------
                                    119 	.area CODE
                                    120 ;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
                                    121 ;	-----------------------------------------
                                    122 ;	 function TIM4_UPD_OVF_IRQHandler
                                    123 ;	-----------------------------------------
      0080A2                        124 _TIM4_UPD_OVF_IRQHandler:
      0080A2 4F               [ 1]  125 	clr	a
      0080A3 62               [ 2]  126 	div	x, a
                                    127 ;	main.c: 9: TIM4_SR &= ~(1 << 0); // Очистка флага UIF (лучше через &= ~)
      0080A4 72 11 53 44      [ 1]  128 	bres	0x5344, #0
                                    129 ;	main.c: 10: tim4_tick();
      0080A8 CD 81 00         [ 4]  130 	call	_tim4_tick
                                    131 ;	main.c: 11: }
      0080AB 80               [11]  132 	iret
                                    133 ;	main.c: 13: void main(void) {
                                    134 ;	-----------------------------------------
                                    135 ;	 function main
                                    136 ;	-----------------------------------------
      0080AC                        137 _main:
      0080AC 52 0C            [ 2]  138 	sub	sp, #12
                                    139 ;	main.c: 15: CLK_CKDIVR = 0; 
      0080AE 35 00 50 C6      [ 1]  140 	mov	0x50c6+0, #0x00
                                    141 ;	main.c: 18: init_UART(9600);
      0080B2 4B 80            [ 1]  142 	push	#0x80
      0080B4 4B 25            [ 1]  143 	push	#0x25
      0080B6 5F               [ 1]  144 	clrw	x
      0080B7 89               [ 2]  145 	pushw	x
      0080B8 CD 81 42         [ 4]  146 	call	_init_UART
                                    147 ;	main.c: 19: time_init();   // Настройка TIM4
      0080BB CD 81 14         [ 4]  148 	call	_time_init
                                    149 ;	main.c: 22: enableInterrupts();
      0080BE 9A               [ 1]  150 	rim
                                    151 ;	main.c: 24: uint32_t timer0 = 0;
      0080BF 5F               [ 1]  152 	clrw	x
      0080C0 1F 03            [ 2]  153 	ldw	(0x03, sp), x
      0080C2 1F 01            [ 2]  154 	ldw	(0x01, sp), x
                                    155 ;	main.c: 26: while(1) {
      0080C4                        156 00104$:
                                    157 ;	main.c: 27: if (millis() - timer0 >= 333) {
      0080C4 CD 81 38         [ 4]  158 	call	_millis
      0080C7 1F 07            [ 2]  159 	ldw	(0x07, sp), x
      0080C9 17 05            [ 2]  160 	ldw	(0x05, sp), y
      0080CB 1E 07            [ 2]  161 	ldw	x, (0x07, sp)
      0080CD 72 F0 03         [ 2]  162 	subw	x, (0x03, sp)
      0080D0 1F 0B            [ 2]  163 	ldw	(0x0b, sp), x
      0080D2 7B 06            [ 1]  164 	ld	a, (0x06, sp)
      0080D4 12 02            [ 1]  165 	sbc	a, (0x02, sp)
      0080D6 6B 0A            [ 1]  166 	ld	(0x0a, sp), a
      0080D8 7B 05            [ 1]  167 	ld	a, (0x05, sp)
      0080DA 12 01            [ 1]  168 	sbc	a, (0x01, sp)
      0080DC 88               [ 1]  169 	push	a
      0080DD 1E 0C            [ 2]  170 	ldw	x, (0x0c, sp)
      0080DF A3 01 4D         [ 2]  171 	cpw	x, #0x014d
      0080E2 7B 0B            [ 1]  172 	ld	a, (0x0b, sp)
      0080E4 A2 00            [ 1]  173 	sbc	a, #0x00
      0080E6 84               [ 1]  174 	pop	a
      0080E7 A2 00            [ 1]  175 	sbc	a, #0x00
      0080E9 25 D9            [ 1]  176 	jrc	00104$
                                    177 ;	main.c: 28: timer0 = millis();
      0080EB CD 81 38         [ 4]  178 	call	_millis
      0080EE 1F 03            [ 2]  179 	ldw	(0x03, sp), x
      0080F0 17 01            [ 2]  180 	ldw	(0x01, sp), y
                                    181 ;	main.c: 29: sendString_UART("hello world!");
      0080F2 AE 80 91         [ 2]  182 	ldw	x, #(___str_0+0)
      0080F5 CD 81 A1         [ 4]  183 	call	_sendString_UART
                                    184 ;	main.c: 30: sendLine_UART(); // Если в sendString уже есть \r\n, то это лишнее
      0080F8 CD 81 AE         [ 4]  185 	call	_sendLine_UART
      0080FB 20 C7            [ 2]  186 	jra	00104$
                                    187 ;	main.c: 33: }
      0080FD 5B 0C            [ 2]  188 	addw	sp, #12
      0080FF 81               [ 4]  189 	ret
                                    190 	.area CODE
                                    191 	.area CONST
                                    192 	.area CONST
      008091                        193 ___str_0:
      008091 68 65 6C 6C 6F 20 77   194 	.ascii "hello world!"
             6F 72 6C 64 21
      00809D 00                     195 	.db 0x00
                                    196 	.area CODE
                                    197 	.area INITIALIZER
                                    198 	.area CABS (ABS)
