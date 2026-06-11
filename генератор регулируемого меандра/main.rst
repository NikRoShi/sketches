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
                                     11 	.globl _adc_filter
                                     12 	.globl _analogRead
                                     13 	.globl _adc_init
                                     14 	.globl _tim2_init
                                     15 	.globl _tim4_inerrupts
                                     16 	.globl _TIM2_UPD_OVF_IRQHandler
                                     17 	.globl _tim4_tick
                                     18 	.globl _time_init
                                     19 	.globl _millis
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
      000001                         24 _adc_filter_filtered_10000_15:
      000001                         25 	.ds 2
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area INITIALIZED
                                     30 ;--------------------------------------------------------
                                     31 ; Stack segment in internal ram
                                     32 ;--------------------------------------------------------
                                     33 	.area SSEG
      000007                         34 __start__stack:
      000007                         35 	.ds	1
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; absolute external ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DABS (ABS)
                                     41 
                                     42 ; default segment ordering for linker
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area CONST
                                     47 	.area INITIALIZER
                                     48 	.area CODE
                                     49 
                                     50 ;--------------------------------------------------------
                                     51 ; interrupt vector
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
      008000                         54 __interrupt_vect:
      008000 82 00 80 6B             55 	int s_GSINIT ; reset
      008004 82 00 00 00             56 	int 0x000000 ; trap
      008008 82 00 00 00             57 	int 0x000000 ; int0
      00800C 82 00 00 00             58 	int 0x000000 ; int1
      008010 82 00 00 00             59 	int 0x000000 ; int2
      008014 82 00 00 00             60 	int 0x000000 ; int3
      008018 82 00 00 00             61 	int 0x000000 ; int4
      00801C 82 00 00 00             62 	int 0x000000 ; int5
      008020 82 00 00 00             63 	int 0x000000 ; int6
      008024 82 00 00 00             64 	int 0x000000 ; int7
      008028 82 00 00 00             65 	int 0x000000 ; int8
      00802C 82 00 00 00             66 	int 0x000000 ; int9
      008030 82 00 00 00             67 	int 0x000000 ; int10
      008034 82 00 00 00             68 	int 0x000000 ; int11
      008038 82 00 00 00             69 	int 0x000000 ; int12
      00803C 82 00 80 99             70 	int _TIM2_UPD_OVF_IRQHandler ; int13
      008040 82 00 00 00             71 	int 0x000000 ; int14
      008044 82 00 00 00             72 	int 0x000000 ; int15
      008048 82 00 00 00             73 	int 0x000000 ; int16
      00804C 82 00 00 00             74 	int 0x000000 ; int17
      008050 82 00 00 00             75 	int 0x000000 ; int18
      008054 82 00 00 00             76 	int 0x000000 ; int19
      008058 82 00 00 00             77 	int 0x000000 ; int20
      00805C 82 00 00 00             78 	int 0x000000 ; int21
      008060 82 00 00 00             79 	int 0x000000 ; int22
      008064 82 00 80 A6             80 	int _tim4_inerrupts ; int23
                                     81 ;--------------------------------------------------------
                                     82 ; global & static initialisations
                                     83 ;--------------------------------------------------------
                                     84 	.area HOME
                                     85 	.area GSINIT
                                     86 	.area GSFINAL
                                     87 	.area GSINIT
      00806B CD 82 66         [ 4]   88 	call	___sdcc_external_startup
      00806E 4D               [ 1]   89 	tnz	a
      00806F 27 03            [ 1]   90 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   91 	jp	__sdcc_program_startup
      008074                         92 __sdcc_init_data:
                                     93 ; stm8_genXINIT() start
      008074 AE 00 02         [ 2]   94 	ldw x, #l_DATA
      008077 27 07            [ 1]   95 	jreq	00002$
      008079                         96 00001$:
      008079 72 4F 00 00      [ 1]   97 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   98 	decw x
      00807E 26 F9            [ 1]   99 	jrne	00001$
      008080                        100 00002$:
      008080 AE 00 04         [ 2]  101 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]  102 	jreq	00004$
      008085                        103 00003$:
      008085 D6 80 94         [ 1]  104 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 02         [ 1]  105 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  106 	decw	x
      00808C 26 F7            [ 1]  107 	jrne	00003$
      00808E                        108 00004$:
                                    109 ; stm8_genXINIT() end
                                    110 ;	main.c: 65: static uint16_t filtered = 0;
      00808E 5F               [ 1]  111 	clrw	x
      00808F CF 00 01         [ 2]  112 	ldw	_adc_filter_filtered_10000_15+0, x
                                    113 	.area GSFINAL
      008092 CC 80 68         [ 2]  114 	jp	__sdcc_program_startup
                                    115 ;--------------------------------------------------------
                                    116 ; Home
                                    117 ;--------------------------------------------------------
                                    118 	.area HOME
                                    119 	.area HOME
      008068                        120 __sdcc_program_startup:
      008068 CC 81 1F         [ 2]  121 	jp	_main
                                    122 ;	return from main will return to caller
                                    123 ;--------------------------------------------------------
                                    124 ; code
                                    125 ;--------------------------------------------------------
                                    126 	.area CODE
                                    127 ;	main.c: 16: void TIM2_UPD_OVF_IRQHandler(void) __interrupt(13)
                                    128 ;	-----------------------------------------
                                    129 ;	 function TIM2_UPD_OVF_IRQHandler
                                    130 ;	-----------------------------------------
      008099                        131 _TIM2_UPD_OVF_IRQHandler:
                                    132 ;	main.c: 18: TIM2_SR1 = 0;   // ОБЯЗАТЕЛЬНО первым делом
      008099 35 00 53 04      [ 1]  133 	mov	0x5304+0, #0x00
                                    134 ;	main.c: 20: PC_ODR ^= (1 << 4) | (1 << 5);
      00809D C6 50 0A         [ 1]  135 	ld	a, 0x500a
      0080A0 A8 30            [ 1]  136 	xor	a, #0x30
      0080A2 C7 50 0A         [ 1]  137 	ld	0x500a, a
                                    138 ;	main.c: 21: }
      0080A5 80               [11]  139 	iret
                                    140 ;	main.c: 23: void tim4_inerrupts(void) __interrupt(23)
                                    141 ;	-----------------------------------------
                                    142 ;	 function tim4_inerrupts
                                    143 ;	-----------------------------------------
      0080A6                        144 _tim4_inerrupts:
      0080A6 4F               [ 1]  145 	clr	a
      0080A7 62               [ 2]  146 	div	x, a
                                    147 ;	main.c: 25: TIM4_SR = 0;
      0080A8 35 00 53 44      [ 1]  148 	mov	0x5344+0, #0x00
                                    149 ;	main.c: 26: tim4_tick();
      0080AC CD 81 C9         [ 4]  150 	call	_tim4_tick
                                    151 ;	main.c: 27: }
      0080AF 80               [11]  152 	iret
                                    153 ;	main.c: 29: void tim2_init(void)
                                    154 ;	-----------------------------------------
                                    155 ;	 function tim2_init
                                    156 ;	-----------------------------------------
      0080B0                        157 _tim2_init:
                                    158 ;	main.c: 31: TIM2_CR1 = 0;          // стоп таймера
      0080B0 35 00 53 00      [ 1]  159 	mov	0x5300+0, #0x00
                                    160 ;	main.c: 33: TIM2_PSCR = 4;         // prescaler = 16
      0080B4 35 04 53 0E      [ 1]  161 	mov	0x530e+0, #0x04
                                    162 ;	main.c: 34: TIM2_ARRH = ARR_MAX >> 8;
      0080B8 35 03 53 0F      [ 1]  163 	mov	0x530f+0, #0x03
                                    164 ;	main.c: 35: TIM2_ARRL = ARR_MAX & 0xFF;    //  частота 500гц по умолчанию
      0080BC 35 E8 53 10      [ 1]  165 	mov	0x5310+0, #0xe8
                                    166 ;	main.c: 37: TIM2_IER |= 0x01;      // update interrupt
      0080C0 72 10 53 03      [ 1]  167 	bset	0x5303, #0
                                    168 ;	main.c: 38: TIM2_SR1 = 0;          // сброс флага
      0080C4 35 00 53 04      [ 1]  169 	mov	0x5304+0, #0x00
                                    170 ;	main.c: 40: TIM2_CR1 |= 0x01;      // старт
      0080C8 72 10 53 00      [ 1]  171 	bset	0x5300, #0
                                    172 ;	main.c: 41: }
      0080CC 81               [ 4]  173 	ret
                                    174 ;	main.c: 43: void adc_init(void)
                                    175 ;	-----------------------------------------
                                    176 ;	 function adc_init
                                    177 ;	-----------------------------------------
      0080CD                        178 _adc_init:
                                    179 ;	main.c: 45: ADC_CR2 &= ~(1 << 3);   // ALIGN = 0 → right aligned
      0080CD 72 17 54 02      [ 1]  180 	bres	0x5402, #3
                                    181 ;	main.c: 47: ADC_CR1 = (ADC_CR1 & ~0x70) | 0x70;  // делитель /18
      0080D1 C6 54 01         [ 1]  182 	ld	a, 0x5401
      0080D4 A4 8F            [ 1]  183 	and	a, #0x8f
      0080D6 AA 70            [ 1]  184 	or	a, #0x70
      0080D8 C7 54 01         [ 1]  185 	ld	0x5401, a
                                    186 ;	main.c: 49: ADC_CR1 |= (1 << 0);   // включить ADC
      0080DB 72 10 54 01      [ 1]  187 	bset	0x5401, #0
                                    188 ;	main.c: 50: }
      0080DF 81               [ 4]  189 	ret
                                    190 ;	main.c: 52: uint8_t analogRead(adc_port_t channel)
                                    191 ;	-----------------------------------------
                                    192 ;	 function analogRead
                                    193 ;	-----------------------------------------
      0080E0                        194 _analogRead:
      0080E0 88               [ 1]  195 	push	a
      0080E1 6B 01            [ 1]  196 	ld	(0x01, sp), a
                                    197 ;	main.c: 54: ADC_CSR = (ADC_CSR & ~0x0F) | channel;
      0080E3 C6 54 00         [ 1]  198 	ld	a, 0x5400
      0080E6 A4 F0            [ 1]  199 	and	a, #0xf0
      0080E8 1A 01            [ 1]  200 	or	a, (0x01, sp)
      0080EA C7 54 00         [ 1]  201 	ld	0x5400, a
                                    202 ;	main.c: 56: ADC_CR1 |=  (1 << 0);  // ADON = 1 → старт
      0080ED 72 10 54 01      [ 1]  203 	bset	0x5401, #0
                                    204 ;	main.c: 58: while (!(ADC_CSR & (1 << 7)));
      0080F1                        205 00101$:
      0080F1 C6 54 00         [ 1]  206 	ld	a, 0x5400
      0080F4 2A FB            [ 1]  207 	jrpl	00101$
                                    208 ;	main.c: 60: return ADC_DRH;
      0080F6 C6 54 04         [ 1]  209 	ld	a, 0x5404
                                    210 ;	main.c: 61: }
      0080F9 5B 01            [ 2]  211 	addw	sp, #1
      0080FB 81               [ 4]  212 	ret
                                    213 ;	main.c: 63: uint8_t adc_filter(uint8_t new_value)
                                    214 ;	-----------------------------------------
                                    215 ;	 function adc_filter
                                    216 ;	-----------------------------------------
      0080FC                        217 _adc_filter:
      0080FC 52 02            [ 2]  218 	sub	sp, #2
                                    219 ;	main.c: 67: filtered = filtered + new_value - (filtered >> 3);
      0080FE 90 CE 00 01      [ 2]  220 	ldw	y, _adc_filter_filtered_10000_15+0
      008102 6B 02            [ 1]  221 	ld	(0x02, sp), a
      008104 0F 01            [ 1]  222 	clr	(0x01, sp)
      008106 72 F9 01         [ 2]  223 	addw	y, (0x01, sp)
      008109 CE 00 01         [ 2]  224 	ldw	x, _adc_filter_filtered_10000_15+0
      00810C 54               [ 2]  225 	srlw	x
      00810D 54               [ 2]  226 	srlw	x
      00810E 54               [ 2]  227 	srlw	x
      00810F 17 01            [ 2]  228 	ldw	(0x01, sp), y
      008111 50               [ 2]  229 	negw	x
      008112 72 FB 01         [ 2]  230 	addw	x, (0x01, sp)
                                    231 ;	main.c: 69: return filtered >> 3;
      008115 CF 00 01         [ 2]  232 	ldw	_adc_filter_filtered_10000_15+0, x
      008118 54               [ 2]  233 	srlw	x
      008119 54               [ 2]  234 	srlw	x
      00811A 54               [ 2]  235 	srlw	x
      00811B 9F               [ 1]  236 	ld	a, xl
                                    237 ;	main.c: 70: }
      00811C 5B 02            [ 2]  238 	addw	sp, #2
      00811E 81               [ 4]  239 	ret
                                    240 ;	main.c: 72: void main(void)
                                    241 ;	-----------------------------------------
                                    242 ;	 function main
                                    243 ;	-----------------------------------------
      00811F                        244 _main:
      00811F 52 0C            [ 2]  245 	sub	sp, #12
                                    246 ;	main.c: 74: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
      008121 35 00 50 C6      [ 1]  247 	mov	0x50c6+0, #0x00
                                    248 ;	main.c: 76: PC_DDR |= (1 << 4) | (1 << 5);
      008125 C6 50 0C         [ 1]  249 	ld	a, 0x500c
      008128 AA 30            [ 1]  250 	or	a, #0x30
      00812A C7 50 0C         [ 1]  251 	ld	0x500c, a
                                    252 ;	main.c: 77: PC_CR1 |= (1 << 4) | (1 << 5);
      00812D C6 50 0D         [ 1]  253 	ld	a, 0x500d
      008130 AA 30            [ 1]  254 	or	a, #0x30
      008132 C7 50 0D         [ 1]  255 	ld	0x500d, a
                                    256 ;	main.c: 78: PC_ODR &= ~((1 << 4) | (1 << 5));
      008135 C6 50 0A         [ 1]  257 	ld	a, 0x500a
      008138 A4 CF            [ 1]  258 	and	a, #0xcf
      00813A C7 50 0A         [ 1]  259 	ld	0x500a, a
                                    260 ;	main.c: 79: PC_ODR |= (1 << 4);
      00813D 72 18 50 0A      [ 1]  261 	bset	0x500a, #4
                                    262 ;	main.c: 81: PD_DDR &= ~(1 << 5);
      008141 72 1B 50 11      [ 1]  263 	bres	0x5011, #5
                                    264 ;	main.c: 82: PD_CR1 &= ~(1 << 5);
      008145 72 1B 50 12      [ 1]  265 	bres	0x5012, #5
                                    266 ;	main.c: 83: PD_CR2 &= ~(1 << 5);
      008149 72 1B 50 13      [ 1]  267 	bres	0x5013, #5
                                    268 ;	main.c: 85: adc_init();
      00814D CD 80 CD         [ 4]  269 	call	_adc_init
                                    270 ;	main.c: 87: tim2_init();
      008150 CD 80 B0         [ 4]  271 	call	_tim2_init
                                    272 ;	main.c: 88: time_init();
      008153 CD 81 DD         [ 4]  273 	call	_time_init
                                    274 ;	main.c: 89: enableInterrupts();
      008156 9A               [ 1]  275 	rim
                                    276 ;	main.c: 91: uint32_t timer0 = 0;
      008157 5F               [ 1]  277 	clrw	x
      008158 1F 03            [ 2]  278 	ldw	(0x03, sp), x
      00815A 1F 01            [ 2]  279 	ldw	(0x01, sp), x
                                    280 ;	main.c: 93: while (1) {
      00815C                        281 00104$:
                                    282 ;	main.c: 94: if (millis() - timer0 >= 10) {
      00815C CD 82 01         [ 4]  283 	call	_millis
      00815F 1F 07            [ 2]  284 	ldw	(0x07, sp), x
      008161 17 05            [ 2]  285 	ldw	(0x05, sp), y
      008163 1E 07            [ 2]  286 	ldw	x, (0x07, sp)
      008165 72 F0 03         [ 2]  287 	subw	x, (0x03, sp)
      008168 1F 0B            [ 2]  288 	ldw	(0x0b, sp), x
      00816A 7B 06            [ 1]  289 	ld	a, (0x06, sp)
      00816C 12 02            [ 1]  290 	sbc	a, (0x02, sp)
      00816E 6B 0A            [ 1]  291 	ld	(0x0a, sp), a
      008170 7B 05            [ 1]  292 	ld	a, (0x05, sp)
      008172 12 01            [ 1]  293 	sbc	a, (0x01, sp)
      008174 88               [ 1]  294 	push	a
      008175 1E 0C            [ 2]  295 	ldw	x, (0x0c, sp)
      008177 A3 00 0A         [ 2]  296 	cpw	x, #0x000a
      00817A 7B 0B            [ 1]  297 	ld	a, (0x0b, sp)
      00817C A2 00            [ 1]  298 	sbc	a, #0x00
      00817E 84               [ 1]  299 	pop	a
      00817F A2 00            [ 1]  300 	sbc	a, #0x00
      008181 25 D9            [ 1]  301 	jrc	00104$
                                    302 ;	main.c: 95: timer0 = millis();
      008183 CD 82 01         [ 4]  303 	call	_millis
      008186 1F 03            [ 2]  304 	ldw	(0x03, sp), x
      008188 17 01            [ 2]  305 	ldw	(0x01, sp), y
                                    306 ;	main.c: 97: uint8_t pot = adc_filter(analogRead(AIN5));
      00818A A6 05            [ 1]  307 	ld	a, #0x05
      00818C CD 80 E0         [ 4]  308 	call	_analogRead
      00818F CD 80 FC         [ 4]  309 	call	_adc_filter
                                    310 ;	main.c: 98: uint16_t arr = ARR_MAX - ((uint32_t)pot * (ARR_MAX - ARR_MIN)) / 255;
      008192 5F               [ 1]  311 	clrw	x
      008193 0F 09            [ 1]  312 	clr	(0x09, sp)
      008195 88               [ 1]  313 	push	a
      008196 89               [ 2]  314 	pushw	x
      008197 4F               [ 1]  315 	clr	a
      008198 88               [ 1]  316 	push	a
      008199 4B C7            [ 1]  317 	push	#0xc7
      00819B 4B 03            [ 1]  318 	push	#0x03
      00819D 5F               [ 1]  319 	clrw	x
      00819E 89               [ 2]  320 	pushw	x
      00819F CD 82 68         [ 4]  321 	call	__mullong
      0081A2 5B 08            [ 2]  322 	addw	sp, #8
      0081A4 4B FF            [ 1]  323 	push	#0xff
      0081A6 4B 00            [ 1]  324 	push	#0x00
      0081A8 4B 00            [ 1]  325 	push	#0x00
      0081AA 4B 00            [ 1]  326 	push	#0x00
      0081AC 89               [ 2]  327 	pushw	x
      0081AD 90 89            [ 2]  328 	pushw	y
      0081AF CD 82 0B         [ 4]  329 	call	__divulong
      0081B2 5B 08            [ 2]  330 	addw	sp, #8
      0081B4 1F 0B            [ 2]  331 	ldw	(0x0b, sp), x
      0081B6 AE 03 E8         [ 2]  332 	ldw	x, #0x03e8
      0081B9 72 F0 0B         [ 2]  333 	subw	x, (0x0b, sp)
                                    334 ;	main.c: 100: TIM2_ARRH = arr >> 8;
      0081BC 9E               [ 1]  335 	ld	a, xh
      0081BD C7 53 0F         [ 1]  336 	ld	0x530f, a
                                    337 ;	main.c: 101: TIM2_ARRL = arr & 0xFF;
      0081C0 9F               [ 1]  338 	ld	a, xl
      0081C1 C7 53 10         [ 1]  339 	ld	0x5310, a
      0081C4 20 96            [ 2]  340 	jra	00104$
                                    341 ;	main.c: 104: }
      0081C6 5B 0C            [ 2]  342 	addw	sp, #12
      0081C8 81               [ 4]  343 	ret
                                    344 	.area CODE
                                    345 	.area CONST
                                    346 	.area INITIALIZER
                                    347 	.area CABS (ABS)
