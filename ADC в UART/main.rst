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
                                     12 	.globl _sendInt_UART
                                     13 	.globl _sendLine_UART
                                     14 	.globl _sendString_UART
                                     15 	.globl _init_UART
                                     16 	.globl _getValue_ADC
                                     17 	.globl _isReady_ADC
                                     18 	.globl _start_ADC
                                     19 	.globl _init_ADC
                                     20 	.globl _tick_TIM4
                                     21 	.globl _init_TIM4
                                     22 	.globl _millis
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
                                     31 ;--------------------------------------------------------
                                     32 ; Stack segment in internal ram
                                     33 ;--------------------------------------------------------
                                     34 	.area SSEG
      000005                         35 __start__stack:
      000005                         36 	.ds	1
                                     37 
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
                                     52 ; interrupt vector
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
      008000                         55 __interrupt_vect:
      008000 82 00 80 6B             56 	int s_GSINIT ; reset
      008004 82 00 00 00             57 	int 0x000000 ; trap
      008008 82 00 00 00             58 	int 0x000000 ; int0
      00800C 82 00 00 00             59 	int 0x000000 ; int1
      008010 82 00 00 00             60 	int 0x000000 ; int2
      008014 82 00 00 00             61 	int 0x000000 ; int3
      008018 82 00 00 00             62 	int 0x000000 ; int4
      00801C 82 00 00 00             63 	int 0x000000 ; int5
      008020 82 00 00 00             64 	int 0x000000 ; int6
      008024 82 00 00 00             65 	int 0x000000 ; int7
      008028 82 00 00 00             66 	int 0x000000 ; int8
      00802C 82 00 00 00             67 	int 0x000000 ; int9
      008030 82 00 00 00             68 	int 0x000000 ; int10
      008034 82 00 00 00             69 	int 0x000000 ; int11
      008038 82 00 00 00             70 	int 0x000000 ; int12
      00803C 82 00 00 00             71 	int 0x000000 ; int13
      008040 82 00 00 00             72 	int 0x000000 ; int14
      008044 82 00 00 00             73 	int 0x000000 ; int15
      008048 82 00 00 00             74 	int 0x000000 ; int16
      00804C 82 00 00 00             75 	int 0x000000 ; int17
      008050 82 00 00 00             76 	int 0x000000 ; int18
      008054 82 00 00 00             77 	int 0x000000 ; int19
      008058 82 00 00 00             78 	int 0x000000 ; int20
      00805C 82 00 00 00             79 	int 0x000000 ; int21
      008060 82 00 00 00             80 	int 0x000000 ; int22
      008064 82 00 80 A1             81 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     82 ;--------------------------------------------------------
                                     83 ; global & static initialisations
                                     84 ;--------------------------------------------------------
                                     85 	.area HOME
                                     86 	.area GSINIT
                                     87 	.area GSFINAL
                                     88 	.area GSINIT
      00806B CD 83 47         [ 4]   89 	call	___sdcc_external_startup
      00806E 4D               [ 1]   90 	tnz	a
      00806F 27 03            [ 1]   91 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   92 	jp	__sdcc_program_startup
      008074                         93 __sdcc_init_data:
                                     94 ; stm8_genXINIT() start
      008074 AE 00 00         [ 2]   95 	ldw x, #l_DATA
      008077 27 07            [ 1]   96 	jreq	00002$
      008079                         97 00001$:
      008079 72 4F 00 00      [ 1]   98 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   99 	decw x
      00807E 26 F9            [ 1]  100 	jrne	00001$
      008080                        101 00002$:
      008080 AE 00 04         [ 2]  102 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]  103 	jreq	00004$
      008085                        104 00003$:
      008085 D6 80 9C         [ 1]  105 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 00         [ 1]  106 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  107 	decw	x
      00808C 26 F7            [ 1]  108 	jrne	00003$
      00808E                        109 00004$:
                                    110 ; stm8_genXINIT() end
                                    111 	.area GSFINAL
      00808E CC 80 68         [ 2]  112 	jp	__sdcc_program_startup
                                    113 ;--------------------------------------------------------
                                    114 ; Home
                                    115 ;--------------------------------------------------------
                                    116 	.area HOME
                                    117 	.area HOME
      008068                        118 __sdcc_program_startup:
      008068 CC 80 AB         [ 2]  119 	jp	_main
                                    120 ;	return from main will return to caller
                                    121 ;--------------------------------------------------------
                                    122 ; code
                                    123 ;--------------------------------------------------------
                                    124 	.area CODE
                                    125 ;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    126 ;	-----------------------------------------
                                    127 ;	 function TIM4_UPD_OVF_IRQHandler
                                    128 ;	-----------------------------------------
      0080A1                        129 _TIM4_UPD_OVF_IRQHandler:
      0080A1 4F               [ 1]  130 	clr	a
      0080A2 62               [ 2]  131 	div	x, a
                                    132 ;	main.c: 8: TIM4_SR &= ~(1 << 0);
      0080A3 72 11 53 44      [ 1]  133 	bres	0x5344, #0
                                    134 ;	main.c: 9: tick_TIM4();
      0080A7 CD 81 44         [ 4]  135 	call	_tick_TIM4
                                    136 ;	main.c: 10: }
      0080AA 80               [11]  137 	iret
                                    138 ;	main.c: 12: void main(void) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function main
                                    141 ;	-----------------------------------------
      0080AB                        142 _main:
      0080AB 52 0A            [ 2]  143 	sub	sp, #10
                                    144 ;	main.c: 13: CLK_CKDIVR = 0;
      0080AD 35 00 50 C6      [ 1]  145 	mov	0x50c6+0, #0x00
                                    146 ;	main.c: 15: PC_DDR &= ~(1 << 4);
      0080B1 72 19 50 0C      [ 1]  147 	bres	0x500c, #4
                                    148 ;	main.c: 16: PC_CR1 &= ~(1 << 4);
      0080B5 72 19 50 0D      [ 1]  149 	bres	0x500d, #4
                                    150 ;	main.c: 17: PC_CR2 &= ~(1 << 4);
      0080B9 72 19 50 0E      [ 1]  151 	bres	0x500e, #4
                                    152 ;	main.c: 19: init_ADC(AIN2);
      0080BD A6 02            [ 1]  153 	ld	a, #0x02
      0080BF CD 81 86         [ 4]  154 	call	_init_ADC
                                    155 ;	main.c: 20: init_TIM4();
      0080C2 CD 81 58         [ 4]  156 	call	_init_TIM4
                                    157 ;	main.c: 21: init_UART(9600);
      0080C5 4B 80            [ 1]  158 	push	#0x80
      0080C7 4B 25            [ 1]  159 	push	#0x25
      0080C9 5F               [ 1]  160 	clrw	x
      0080CA 89               [ 2]  161 	pushw	x
      0080CB CD 82 11         [ 4]  162 	call	_init_UART
                                    163 ;	main.c: 23: uint32_t timer_ADC = 0;
      0080CE 5F               [ 1]  164 	clrw	x
      0080CF 1F 03            [ 2]  165 	ldw	(0x03, sp), x
      0080D1 1F 01            [ 2]  166 	ldw	(0x01, sp), x
                                    167 ;	main.c: 24: uint32_t timer_print = 0;
      0080D3 5F               [ 1]  168 	clrw	x
      0080D4 1F 07            [ 2]  169 	ldw	(0x07, sp), x
      0080D6 1F 05            [ 2]  170 	ldw	(0x05, sp), x
                                    171 ;	main.c: 25: uint16_t value_ADC = 0;
      0080D8 5F               [ 1]  172 	clrw	x
      0080D9 1F 09            [ 2]  173 	ldw	(0x09, sp), x
                                    174 ;	main.c: 26: while(1){
      0080DB                        175 00108$:
                                    176 ;	main.c: 27: if (millis() - timer_ADC >= 50) {
      0080DB CD 81 7C         [ 4]  177 	call	_millis
      0080DE 90 9F            [ 1]  178 	ld	a, yl
      0080E0 72 F0 03         [ 2]  179 	subw	x, (0x03, sp)
      0080E3 12 02            [ 1]  180 	sbc	a, (0x02, sp)
      0080E5 90 97            [ 1]  181 	ld	yl, a
      0080E7 90 9E            [ 1]  182 	ld	a, yh
      0080E9 12 01            [ 1]  183 	sbc	a, (0x01, sp)
      0080EB 88               [ 1]  184 	push	a
      0080EC A3 00 32         [ 2]  185 	cpw	x, #0x0032
      0080EF 90 9F            [ 1]  186 	ld	a, yl
      0080F1 A2 00            [ 1]  187 	sbc	a, #0x00
      0080F3 84               [ 1]  188 	pop	a
      0080F4 A2 00            [ 1]  189 	sbc	a, #0x00
      0080F6 25 0A            [ 1]  190 	jrc	00102$
                                    191 ;	main.c: 28: timer_ADC = millis();
      0080F8 CD 81 7C         [ 4]  192 	call	_millis
      0080FB 1F 03            [ 2]  193 	ldw	(0x03, sp), x
      0080FD 17 01            [ 2]  194 	ldw	(0x01, sp), y
                                    195 ;	main.c: 29: start_ADC();
      0080FF CD 81 EF         [ 4]  196 	call	_start_ADC
      008102                        197 00102$:
                                    198 ;	main.c: 31: if (isReady_ADC()) {value_ADC = getValue_ADC();}
      008102 CD 81 F4         [ 4]  199 	call	_isReady_ADC
      008105 4D               [ 1]  200 	tnz	a
      008106 27 05            [ 1]  201 	jreq	00104$
      008108 CD 81 FE         [ 4]  202 	call	_getValue_ADC
      00810B 1F 09            [ 2]  203 	ldw	(0x09, sp), x
      00810D                        204 00104$:
                                    205 ;	main.c: 32: if (millis() - timer_print >= 333) {
      00810D CD 81 7C         [ 4]  206 	call	_millis
      008110 90 9F            [ 1]  207 	ld	a, yl
      008112 72 F0 07         [ 2]  208 	subw	x, (0x07, sp)
      008115 12 06            [ 1]  209 	sbc	a, (0x06, sp)
      008117 90 97            [ 1]  210 	ld	yl, a
      008119 90 9E            [ 1]  211 	ld	a, yh
      00811B 12 05            [ 1]  212 	sbc	a, (0x05, sp)
      00811D 88               [ 1]  213 	push	a
      00811E A3 01 4D         [ 2]  214 	cpw	x, #0x014d
      008121 90 9F            [ 1]  215 	ld	a, yl
      008123 A2 00            [ 1]  216 	sbc	a, #0x00
      008125 84               [ 1]  217 	pop	a
      008126 A2 00            [ 1]  218 	sbc	a, #0x00
      008128 25 B1            [ 1]  219 	jrc	00108$
                                    220 ;	main.c: 33: timer_print = millis();
      00812A CD 81 7C         [ 4]  221 	call	_millis
      00812D 1F 07            [ 2]  222 	ldw	(0x07, sp), x
      00812F 17 05            [ 2]  223 	ldw	(0x05, sp), y
                                    224 ;	main.c: 34: sendString_UART("adc value: ");
      008131 AE 80 91         [ 2]  225 	ldw	x, #(___str_0+0)
      008134 CD 82 70         [ 4]  226 	call	_sendString_UART
                                    227 ;	main.c: 35: sendInt_UART(value_ADC);
      008137 1E 09            [ 2]  228 	ldw	x, (0x09, sp)
      008139 CD 82 87         [ 4]  229 	call	_sendInt_UART
                                    230 ;	main.c: 36: sendLine_UART();
      00813C CD 82 7D         [ 4]  231 	call	_sendLine_UART
      00813F 20 9A            [ 2]  232 	jra	00108$
                                    233 ;	main.c: 39: }
      008141 5B 0A            [ 2]  234 	addw	sp, #10
      008143 81               [ 4]  235 	ret
                                    236 	.area CODE
                                    237 	.area CONST
                                    238 	.area CONST
      008091                        239 ___str_0:
      008091 61 64 63 20 76 61 6C   240 	.ascii "adc value: "
             75 65 3A 20
      00809C 00                     241 	.db 0x00
                                    242 	.area CODE
                                    243 	.area INITIALIZER
                                    244 	.area CABS (ABS)
