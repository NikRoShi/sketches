                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_interrupt
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _EXTI_FlagD
                                     12 	.globl _EXTI_FlagC
                                     13 	.globl _EXTI_FlagB
                                     14 	.globl _EXTI_FlagA
                                     15 	.globl _set_EXTI
                                     16 	.globl _set_EXTI_pin
                                     17 	.globl _clear_EXTI_pin
                                     18 	.globl _setInterruptPriority
                                     19 	.globl _handlerPortA
                                     20 	.globl _handlerPortB
                                     21 	.globl _handlerPortC
                                     22 	.globl _handlerPortD
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
      00000F                         31 _modeA:
      00000F                         32 	.ds 1
      000010                         33 _EXTIPinMaskA:
      000010                         34 	.ds 1
      000011                         35 _EXTI_FlagA::
      000011                         36 	.ds 1
      000012                         37 _modeB:
      000012                         38 	.ds 1
      000013                         39 _EXTIPinMaskB:
      000013                         40 	.ds 1
      000014                         41 _EXTI_FlagB::
      000014                         42 	.ds 1
      000015                         43 _modeC:
      000015                         44 	.ds 1
      000016                         45 _EXTIPinMaskC:
      000016                         46 	.ds 1
      000017                         47 _EXTI_FlagC::
      000017                         48 	.ds 1
      000018                         49 _modeD:
      000018                         50 	.ds 1
      000019                         51 _EXTIPinMaskD:
      000019                         52 	.ds 1
      00001A                         53 _EXTI_FlagD::
      00001A                         54 	.ds 1
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
                                     69 ; global & static initialisations
                                     70 ;--------------------------------------------------------
                                     71 	.area HOME
                                     72 	.area GSINIT
                                     73 	.area GSFINAL
                                     74 	.area GSINIT
                                     75 ;--------------------------------------------------------
                                     76 ; Home
                                     77 ;--------------------------------------------------------
                                     78 	.area HOME
                                     79 	.area HOME
                                     80 ;--------------------------------------------------------
                                     81 ; code
                                     82 ;--------------------------------------------------------
                                     83 	.area CODE
                                     84 ;	../../my_STM8_libraries/stm8_interrupt.c: 19: void set_EXTI(uint8_t port, uint8_t mode)
                                     85 ;	-----------------------------------------
                                     86 ;	 function set_EXTI
                                     87 ;	-----------------------------------------
      0086DB                         88 _set_EXTI:
      0086DB 88               [ 1]   89 	push	a
      0086DC 95               [ 1]   90 	ld	xh, a
                                     91 ;	../../my_STM8_libraries/stm8_interrupt.c: 21: EXTI_CR1 &= ~(0b11 << port);
      0086DD C6 50 A0         [ 1]   92 	ld	a, 0x50a0
      0086E0 6B 01            [ 1]   93 	ld	(0x01, sp), a
      0086E2 9E               [ 1]   94 	ld	a, xh
      0086E3 41               [ 1]   95 	exg	a, xl
      0086E4 A6 03            [ 1]   96 	ld	a, #0x03
      0086E6 41               [ 1]   97 	exg	a, xl
      0086E7 4D               [ 1]   98 	tnz	a
      0086E8 27 06            [ 1]   99 	jreq	00132$
      0086EA                        100 00131$:
      0086EA 41               [ 1]  101 	exg	a, xl
      0086EB 48               [ 1]  102 	sll	a
      0086EC 41               [ 1]  103 	exg	a, xl
      0086ED 4A               [ 1]  104 	dec	a
      0086EE 26 FA            [ 1]  105 	jrne	00131$
      0086F0                        106 00132$:
      0086F0 9F               [ 1]  107 	ld	a, xl
      0086F1 43               [ 1]  108 	cpl	a
      0086F2 14 01            [ 1]  109 	and	a, (0x01, sp)
      0086F4 C7 50 A0         [ 1]  110 	ld	0x50a0, a
                                    111 ;	../../my_STM8_libraries/stm8_interrupt.c: 22: EXTI_CR1 |= mode << port;
      0086F7 C6 50 A0         [ 1]  112 	ld	a, 0x50a0
      0086FA 88               [ 1]  113 	push	a
      0086FB 7B 05            [ 1]  114 	ld	a, (0x05, sp)
      0086FD 6B 02            [ 1]  115 	ld	(0x02, sp), a
      0086FF 9E               [ 1]  116 	ld	a, xh
      008700 4D               [ 1]  117 	tnz	a
      008701 27 05            [ 1]  118 	jreq	00134$
      008703                        119 00133$:
      008703 08 02            [ 1]  120 	sll	(0x02, sp)
      008705 4A               [ 1]  121 	dec	a
      008706 26 FB            [ 1]  122 	jrne	00133$
      008708                        123 00134$:
      008708 84               [ 1]  124 	pop	a
      008709 1A 01            [ 1]  125 	or	a, (0x01, sp)
      00870B C7 50 A0         [ 1]  126 	ld	0x50a0, a
                                    127 ;	../../my_STM8_libraries/stm8_interrupt.c: 23: if (port == EXTI_PORTA) modeA = mode;
      00870E 7B 04            [ 1]  128 	ld	a, (0x04, sp)
      008710 97               [ 1]  129 	ld	xl, a
      008711 9E               [ 1]  130 	ld	a, xh
      008712 4D               [ 1]  131 	tnz	a
      008713 26 04            [ 1]  132 	jrne	00102$
      008715 9F               [ 1]  133 	ld	a, xl
      008716 C7 00 0F         [ 1]  134 	ld	_modeA+0, a
      008719                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_interrupt.c: 24: if (port == EXTI_PORTB) modeB = mode;
      008719 9E               [ 1]  137 	ld	a, xh
      00871A A1 02            [ 1]  138 	cp	a, #0x02
      00871C 26 04            [ 1]  139 	jrne	00104$
      00871E 9F               [ 1]  140 	ld	a, xl
      00871F C7 00 12         [ 1]  141 	ld	_modeB+0, a
      008722                        142 00104$:
                                    143 ;	../../my_STM8_libraries/stm8_interrupt.c: 25: if (port == EXTI_PORTC) modeC = mode;
      008722 9E               [ 1]  144 	ld	a, xh
      008723 A1 04            [ 1]  145 	cp	a, #0x04
      008725 26 04            [ 1]  146 	jrne	00106$
      008727 9F               [ 1]  147 	ld	a, xl
      008728 C7 00 15         [ 1]  148 	ld	_modeC+0, a
      00872B                        149 00106$:
                                    150 ;	../../my_STM8_libraries/stm8_interrupt.c: 26: if (port == EXTI_PORTD) modeD = mode;
      00872B 9E               [ 1]  151 	ld	a, xh
      00872C A1 06            [ 1]  152 	cp	a, #0x06
      00872E 26 04            [ 1]  153 	jrne	00109$
      008730 9F               [ 1]  154 	ld	a, xl
      008731 C7 00 18         [ 1]  155 	ld	_modeD+0, a
      008734                        156 00109$:
                                    157 ;	../../my_STM8_libraries/stm8_interrupt.c: 27: }
      008734 84               [ 1]  158 	pop	a
      008735 85               [ 2]  159 	popw	x
      008736 84               [ 1]  160 	pop	a
      008737 FC               [ 2]  161 	jp	(x)
                                    162 ;	../../my_STM8_libraries/stm8_interrupt.c: 28: void set_EXTI_pin(uint8_t port, uint8_t pin)
                                    163 ;	-----------------------------------------
                                    164 ;	 function set_EXTI_pin
                                    165 ;	-----------------------------------------
      008738                        166 _set_EXTI_pin:
      008738 52 02            [ 2]  167 	sub	sp, #2
      00873A 97               [ 1]  168 	ld	xl, a
                                    169 ;	../../my_STM8_libraries/stm8_interrupt.c: 33: EXTIPinMaskA |= (1 << pin);
      00873B 7B 05            [ 1]  170 	ld	a, (0x05, sp)
      00873D 88               [ 1]  171 	push	a
      00873E A6 01            [ 1]  172 	ld	a, #0x01
      008740 6B 02            [ 1]  173 	ld	(0x02, sp), a
      008742 84               [ 1]  174 	pop	a
      008743 4D               [ 1]  175 	tnz	a
      008744 27 05            [ 1]  176 	jreq	00129$
      008746                        177 00128$:
      008746 08 01            [ 1]  178 	sll	(0x01, sp)
      008748 4A               [ 1]  179 	dec	a
      008749 26 FB            [ 1]  180 	jrne	00128$
      00874B                        181 00129$:
                                    182 ;	../../my_STM8_libraries/stm8_interrupt.c: 34: PA_DDR &= ~(1 << pin);
      00874B 7B 01            [ 1]  183 	ld	a, (0x01, sp)
      00874D 43               [ 1]  184 	cpl	a
      00874E 6B 02            [ 1]  185 	ld	(0x02, sp), a
                                    186 ;	../../my_STM8_libraries/stm8_interrupt.c: 30: switch (port)
      008750 9F               [ 1]  187 	ld	a, xl
      008751 A1 00            [ 1]  188 	cp	a, #0x00
      008753 27 11            [ 1]  189 	jreq	00101$
      008755 9F               [ 1]  190 	ld	a, xl
      008756 A1 02            [ 1]  191 	cp	a, #0x02
      008758 27 26            [ 1]  192 	jreq	00102$
      00875A 9F               [ 1]  193 	ld	a, xl
      00875B A1 04            [ 1]  194 	cp	a, #0x04
      00875D 27 3B            [ 1]  195 	jreq	00103$
      00875F 9F               [ 1]  196 	ld	a, xl
      008760 A1 06            [ 1]  197 	cp	a, #0x06
      008762 27 50            [ 1]  198 	jreq	00104$
      008764 20 66            [ 2]  199 	jra	00106$
                                    200 ;	../../my_STM8_libraries/stm8_interrupt.c: 32: case EXTI_PORTA:
      008766                        201 00101$:
                                    202 ;	../../my_STM8_libraries/stm8_interrupt.c: 33: EXTIPinMaskA |= (1 << pin);
      008766 7B 01            [ 1]  203 	ld	a, (0x01, sp)
      008768 CA 00 10         [ 1]  204 	or	a, _EXTIPinMaskA+0
      00876B C7 00 10         [ 1]  205 	ld	_EXTIPinMaskA+0, a
                                    206 ;	../../my_STM8_libraries/stm8_interrupt.c: 34: PA_DDR &= ~(1 << pin);
      00876E C6 50 02         [ 1]  207 	ld	a, 0x5002
      008771 14 02            [ 1]  208 	and	a, (0x02, sp)
      008773 C7 50 02         [ 1]  209 	ld	0x5002, a
                                    210 ;	../../my_STM8_libraries/stm8_interrupt.c: 35: PA_CR2 |= (1 << pin);
      008776 C6 50 04         [ 1]  211 	ld	a, 0x5004
      008779 1A 01            [ 1]  212 	or	a, (0x01, sp)
      00877B C7 50 04         [ 1]  213 	ld	0x5004, a
                                    214 ;	../../my_STM8_libraries/stm8_interrupt.c: 36: break;
      00877E 20 4C            [ 2]  215 	jra	00106$
                                    216 ;	../../my_STM8_libraries/stm8_interrupt.c: 37: case EXTI_PORTB:
      008780                        217 00102$:
                                    218 ;	../../my_STM8_libraries/stm8_interrupt.c: 38: EXTIPinMaskB |= (1 << pin);
      008780 7B 01            [ 1]  219 	ld	a, (0x01, sp)
      008782 CA 00 13         [ 1]  220 	or	a, _EXTIPinMaskB+0
      008785 C7 00 13         [ 1]  221 	ld	_EXTIPinMaskB+0, a
                                    222 ;	../../my_STM8_libraries/stm8_interrupt.c: 39: PB_DDR &= ~(1 << pin);
      008788 C6 50 07         [ 1]  223 	ld	a, 0x5007
      00878B 14 02            [ 1]  224 	and	a, (0x02, sp)
      00878D C7 50 07         [ 1]  225 	ld	0x5007, a
                                    226 ;	../../my_STM8_libraries/stm8_interrupt.c: 40: PB_CR2 |= (1 << pin);
      008790 C6 50 09         [ 1]  227 	ld	a, 0x5009
      008793 1A 01            [ 1]  228 	or	a, (0x01, sp)
      008795 C7 50 09         [ 1]  229 	ld	0x5009, a
                                    230 ;	../../my_STM8_libraries/stm8_interrupt.c: 41: break;
      008798 20 32            [ 2]  231 	jra	00106$
                                    232 ;	../../my_STM8_libraries/stm8_interrupt.c: 42: case EXTI_PORTC:
      00879A                        233 00103$:
                                    234 ;	../../my_STM8_libraries/stm8_interrupt.c: 43: EXTIPinMaskC |= (1 << pin);
      00879A 7B 01            [ 1]  235 	ld	a, (0x01, sp)
      00879C CA 00 16         [ 1]  236 	or	a, _EXTIPinMaskC+0
      00879F C7 00 16         [ 1]  237 	ld	_EXTIPinMaskC+0, a
                                    238 ;	../../my_STM8_libraries/stm8_interrupt.c: 44: PC_DDR &= ~(1 << pin);
      0087A2 C6 50 0C         [ 1]  239 	ld	a, 0x500c
      0087A5 14 02            [ 1]  240 	and	a, (0x02, sp)
      0087A7 C7 50 0C         [ 1]  241 	ld	0x500c, a
                                    242 ;	../../my_STM8_libraries/stm8_interrupt.c: 45: PC_CR2 |= (1 << pin);
      0087AA C6 50 0E         [ 1]  243 	ld	a, 0x500e
      0087AD 1A 01            [ 1]  244 	or	a, (0x01, sp)
      0087AF C7 50 0E         [ 1]  245 	ld	0x500e, a
                                    246 ;	../../my_STM8_libraries/stm8_interrupt.c: 46: break;
      0087B2 20 18            [ 2]  247 	jra	00106$
                                    248 ;	../../my_STM8_libraries/stm8_interrupt.c: 47: case EXTI_PORTD:
      0087B4                        249 00104$:
                                    250 ;	../../my_STM8_libraries/stm8_interrupt.c: 48: EXTIPinMaskD |= (1 << pin);
      0087B4 7B 01            [ 1]  251 	ld	a, (0x01, sp)
      0087B6 CA 00 19         [ 1]  252 	or	a, _EXTIPinMaskD+0
      0087B9 C7 00 19         [ 1]  253 	ld	_EXTIPinMaskD+0, a
                                    254 ;	../../my_STM8_libraries/stm8_interrupt.c: 49: PD_DDR &= ~(1 << pin);
      0087BC C6 50 11         [ 1]  255 	ld	a, 0x5011
      0087BF 14 02            [ 1]  256 	and	a, (0x02, sp)
      0087C1 C7 50 11         [ 1]  257 	ld	0x5011, a
                                    258 ;	../../my_STM8_libraries/stm8_interrupt.c: 50: PD_CR2 |= (1 << pin);
      0087C4 C6 50 13         [ 1]  259 	ld	a, 0x5013
      0087C7 1A 01            [ 1]  260 	or	a, (0x01, sp)
      0087C9 C7 50 13         [ 1]  261 	ld	0x5013, a
                                    262 ;	../../my_STM8_libraries/stm8_interrupt.c: 52: }
      0087CC                        263 00106$:
                                    264 ;	../../my_STM8_libraries/stm8_interrupt.c: 53: }
      0087CC 5B 02            [ 2]  265 	addw	sp, #2
      0087CE 85               [ 2]  266 	popw	x
      0087CF 84               [ 1]  267 	pop	a
      0087D0 FC               [ 2]  268 	jp	(x)
                                    269 ;	../../my_STM8_libraries/stm8_interrupt.c: 54: void clear_EXTI_pin(uint8_t port, uint8_t pin)
                                    270 ;	-----------------------------------------
                                    271 ;	 function clear_EXTI_pin
                                    272 ;	-----------------------------------------
      0087D1                        273 _clear_EXTI_pin:
      0087D1 88               [ 1]  274 	push	a
      0087D2 97               [ 1]  275 	ld	xl, a
                                    276 ;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
      0087D3 7B 04            [ 1]  277 	ld	a, (0x04, sp)
      0087D5 95               [ 1]  278 	ld	xh, a
      0087D6 A6 01            [ 1]  279 	ld	a, #0x01
      0087D8 88               [ 1]  280 	push	a
      0087D9 9E               [ 1]  281 	ld	a, xh
      0087DA 4D               [ 1]  282 	tnz	a
      0087DB 27 05            [ 1]  283 	jreq	00129$
      0087DD                        284 00128$:
      0087DD 08 01            [ 1]  285 	sll	(1, sp)
      0087DF 4A               [ 1]  286 	dec	a
      0087E0 26 FB            [ 1]  287 	jrne	00128$
      0087E2                        288 00129$:
      0087E2 84               [ 1]  289 	pop	a
      0087E3 43               [ 1]  290 	cpl	a
      0087E4 6B 01            [ 1]  291 	ld	(0x01, sp), a
                                    292 ;	../../my_STM8_libraries/stm8_interrupt.c: 56: switch (port)
      0087E6 9F               [ 1]  293 	ld	a, xl
      0087E7 A1 00            [ 1]  294 	cp	a, #0x00
      0087E9 27 11            [ 1]  295 	jreq	00101$
      0087EB 9F               [ 1]  296 	ld	a, xl
      0087EC A1 02            [ 1]  297 	cp	a, #0x02
      0087EE 27 26            [ 1]  298 	jreq	00102$
      0087F0 9F               [ 1]  299 	ld	a, xl
      0087F1 A1 04            [ 1]  300 	cp	a, #0x04
      0087F3 27 3B            [ 1]  301 	jreq	00103$
      0087F5 9F               [ 1]  302 	ld	a, xl
      0087F6 A1 06            [ 1]  303 	cp	a, #0x06
      0087F8 27 50            [ 1]  304 	jreq	00104$
      0087FA 20 66            [ 2]  305 	jra	00106$
                                    306 ;	../../my_STM8_libraries/stm8_interrupt.c: 58: case EXTI_PORTA:
      0087FC                        307 00101$:
                                    308 ;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
      0087FC 7B 01            [ 1]  309 	ld	a, (0x01, sp)
      0087FE C4 00 10         [ 1]  310 	and	a, _EXTIPinMaskA+0
      008801 C7 00 10         [ 1]  311 	ld	_EXTIPinMaskA+0, a
                                    312 ;	../../my_STM8_libraries/stm8_interrupt.c: 60: PA_DDR &= ~(1 << pin);
      008804 C6 50 02         [ 1]  313 	ld	a, 0x5002
      008807 14 01            [ 1]  314 	and	a, (0x01, sp)
      008809 C7 50 02         [ 1]  315 	ld	0x5002, a
                                    316 ;	../../my_STM8_libraries/stm8_interrupt.c: 61: PA_CR2 &= ~(1 << pin);
      00880C C6 50 04         [ 1]  317 	ld	a, 0x5004
      00880F 14 01            [ 1]  318 	and	a, (0x01, sp)
      008811 C7 50 04         [ 1]  319 	ld	0x5004, a
                                    320 ;	../../my_STM8_libraries/stm8_interrupt.c: 62: break;
      008814 20 4C            [ 2]  321 	jra	00106$
                                    322 ;	../../my_STM8_libraries/stm8_interrupt.c: 63: case EXTI_PORTB:
      008816                        323 00102$:
                                    324 ;	../../my_STM8_libraries/stm8_interrupt.c: 64: EXTIPinMaskB &= ~(1 << pin);
      008816 7B 01            [ 1]  325 	ld	a, (0x01, sp)
      008818 C4 00 13         [ 1]  326 	and	a, _EXTIPinMaskB+0
      00881B C7 00 13         [ 1]  327 	ld	_EXTIPinMaskB+0, a
                                    328 ;	../../my_STM8_libraries/stm8_interrupt.c: 65: PB_DDR &= ~(1 << pin);
      00881E C6 50 07         [ 1]  329 	ld	a, 0x5007
      008821 14 01            [ 1]  330 	and	a, (0x01, sp)
      008823 C7 50 07         [ 1]  331 	ld	0x5007, a
                                    332 ;	../../my_STM8_libraries/stm8_interrupt.c: 66: PB_CR2 &= ~(1 << pin);
      008826 C6 50 09         [ 1]  333 	ld	a, 0x5009
      008829 14 01            [ 1]  334 	and	a, (0x01, sp)
      00882B C7 50 09         [ 1]  335 	ld	0x5009, a
                                    336 ;	../../my_STM8_libraries/stm8_interrupt.c: 67: break;
      00882E 20 32            [ 2]  337 	jra	00106$
                                    338 ;	../../my_STM8_libraries/stm8_interrupt.c: 68: case EXTI_PORTC:
      008830                        339 00103$:
                                    340 ;	../../my_STM8_libraries/stm8_interrupt.c: 69: EXTIPinMaskC &= ~(1 << pin);
      008830 7B 01            [ 1]  341 	ld	a, (0x01, sp)
      008832 C4 00 16         [ 1]  342 	and	a, _EXTIPinMaskC+0
      008835 C7 00 16         [ 1]  343 	ld	_EXTIPinMaskC+0, a
                                    344 ;	../../my_STM8_libraries/stm8_interrupt.c: 70: PC_DDR &= ~(1 << pin);
      008838 C6 50 0C         [ 1]  345 	ld	a, 0x500c
      00883B 14 01            [ 1]  346 	and	a, (0x01, sp)
      00883D C7 50 0C         [ 1]  347 	ld	0x500c, a
                                    348 ;	../../my_STM8_libraries/stm8_interrupt.c: 71: PC_CR2 &= ~(1 << pin);
      008840 C6 50 0E         [ 1]  349 	ld	a, 0x500e
      008843 14 01            [ 1]  350 	and	a, (0x01, sp)
      008845 C7 50 0E         [ 1]  351 	ld	0x500e, a
                                    352 ;	../../my_STM8_libraries/stm8_interrupt.c: 72: break;
      008848 20 18            [ 2]  353 	jra	00106$
                                    354 ;	../../my_STM8_libraries/stm8_interrupt.c: 73: case EXTI_PORTD:
      00884A                        355 00104$:
                                    356 ;	../../my_STM8_libraries/stm8_interrupt.c: 74: EXTIPinMaskD &= ~(1 << pin);
      00884A 7B 01            [ 1]  357 	ld	a, (0x01, sp)
      00884C C4 00 19         [ 1]  358 	and	a, _EXTIPinMaskD+0
      00884F C7 00 19         [ 1]  359 	ld	_EXTIPinMaskD+0, a
                                    360 ;	../../my_STM8_libraries/stm8_interrupt.c: 75: PD_DDR &= ~(1 << pin);
      008852 C6 50 11         [ 1]  361 	ld	a, 0x5011
      008855 14 01            [ 1]  362 	and	a, (0x01, sp)
      008857 C7 50 11         [ 1]  363 	ld	0x5011, a
                                    364 ;	../../my_STM8_libraries/stm8_interrupt.c: 76: PD_CR2 &= ~(1 << pin);
      00885A C6 50 13         [ 1]  365 	ld	a, 0x5013
      00885D 14 01            [ 1]  366 	and	a, (0x01, sp)
      00885F C7 50 13         [ 1]  367 	ld	0x5013, a
                                    368 ;	../../my_STM8_libraries/stm8_interrupt.c: 78: }
      008862                        369 00106$:
                                    370 ;	../../my_STM8_libraries/stm8_interrupt.c: 79: }
      008862 84               [ 1]  371 	pop	a
      008863 85               [ 2]  372 	popw	x
      008864 84               [ 1]  373 	pop	a
      008865 FC               [ 2]  374 	jp	(x)
                                    375 ;	../../my_STM8_libraries/stm8_interrupt.c: 80: void setInterruptPriority(uint8_t interrupt, uint8_t priorityLevel)
                                    376 ;	-----------------------------------------
                                    377 ;	 function setInterruptPriority
                                    378 ;	-----------------------------------------
      008866                        379 _setInterruptPriority:
      008866 52 02            [ 2]  380 	sub	sp, #2
                                    381 ;	../../my_STM8_libraries/stm8_interrupt.c: 82: volatile uint8_t *priorityReg = &ITC_SPR1 + (interrupt >> 2);
      008868 90 97            [ 1]  382 	ld	yl, a
      00886A 44               [ 1]  383 	srl	a
      00886B 44               [ 1]  384 	srl	a
      00886C 5F               [ 1]  385 	clrw	x
      00886D 97               [ 1]  386 	ld	xl, a
      00886E 1C 7F 70         [ 2]  387 	addw	x, #0x7f70
                                    388 ;	../../my_STM8_libraries/stm8_interrupt.c: 83: *priorityReg &= ~(3 << ((interrupt & 3) << 1));
      008871 F6               [ 1]  389 	ld	a, (x)
      008872 6B 02            [ 1]  390 	ld	(0x02, sp), a
      008874 90 9F            [ 1]  391 	ld	a, yl
      008876 A4 03            [ 1]  392 	and	a, #0x03
      008878 48               [ 1]  393 	sll	a
      008879 6B 01            [ 1]  394 	ld	(0x01, sp), a
      00887B A6 03            [ 1]  395 	ld	a, #0x03
      00887D 88               [ 1]  396 	push	a
      00887E 7B 02            [ 1]  397 	ld	a, (0x02, sp)
      008880 27 05            [ 1]  398 	jreq	00104$
      008882                        399 00103$:
      008882 08 01            [ 1]  400 	sll	(1, sp)
      008884 4A               [ 1]  401 	dec	a
      008885 26 FB            [ 1]  402 	jrne	00103$
      008887                        403 00104$:
      008887 84               [ 1]  404 	pop	a
      008888 43               [ 1]  405 	cpl	a
      008889 14 02            [ 1]  406 	and	a, (0x02, sp)
      00888B F7               [ 1]  407 	ld	(x), a
                                    408 ;	../../my_STM8_libraries/stm8_interrupt.c: 84: *priorityReg |= (priorityLevel << ((interrupt & 3) << 1));
      00888C F6               [ 1]  409 	ld	a, (x)
      00888D 6B 02            [ 1]  410 	ld	(0x02, sp), a
      00888F 7B 05            [ 1]  411 	ld	a, (0x05, sp)
      008891 88               [ 1]  412 	push	a
      008892 7B 02            [ 1]  413 	ld	a, (0x02, sp)
      008894 27 05            [ 1]  414 	jreq	00106$
      008896                        415 00105$:
      008896 08 01            [ 1]  416 	sll	(1, sp)
      008898 4A               [ 1]  417 	dec	a
      008899 26 FB            [ 1]  418 	jrne	00105$
      00889B                        419 00106$:
      00889B 84               [ 1]  420 	pop	a
      00889C 1A 02            [ 1]  421 	or	a, (0x02, sp)
      00889E F7               [ 1]  422 	ld	(x), a
                                    423 ;	../../my_STM8_libraries/stm8_interrupt.c: 85: }
      00889F 5B 02            [ 2]  424 	addw	sp, #2
      0088A1 85               [ 2]  425 	popw	x
      0088A2 84               [ 1]  426 	pop	a
      0088A3 FC               [ 2]  427 	jp	(x)
                                    428 ;	../../my_STM8_libraries/stm8_interrupt.c: 86: void handlerPortA(void)
                                    429 ;	-----------------------------------------
                                    430 ;	 function handlerPortA
                                    431 ;	-----------------------------------------
      0088A4                        432 _handlerPortA:
                                    433 ;	../../my_STM8_libraries/stm8_interrupt.c: 88: uint8_t current = PA_IDR;
      0088A4 C6 50 01         [ 1]  434 	ld	a, 0x5001
      0088A7 95               [ 1]  435 	ld	xh, a
                                    436 ;	../../my_STM8_libraries/stm8_interrupt.c: 89: uint8_t event = 0;
      0088A8 4F               [ 1]  437 	clr	a
      0088A9 97               [ 1]  438 	ld	xl, a
                                    439 ;	../../my_STM8_libraries/stm8_interrupt.c: 90: if (modeA == FALLING)
      0088AA C6 00 0F         [ 1]  440 	ld	a, _modeA+0
      0088AD A1 02            [ 1]  441 	cp	a, #0x02
      0088AF 26 06            [ 1]  442 	jrne	00102$
                                    443 ;	../../my_STM8_libraries/stm8_interrupt.c: 92: event = (~current) & EXTIPinMaskA;
      0088B1 9E               [ 1]  444 	ld	a, xh
      0088B2 43               [ 1]  445 	cpl	a
      0088B3 C4 00 10         [ 1]  446 	and	a, _EXTIPinMaskA+0
      0088B6 97               [ 1]  447 	ld	xl, a
      0088B7                        448 00102$:
                                    449 ;	../../my_STM8_libraries/stm8_interrupt.c: 94: if (modeA == RISING)
      0088B7 C6 00 0F         [ 1]  450 	ld	a, _modeA+0
      0088BA 4A               [ 1]  451 	dec	a
      0088BB 26 05            [ 1]  452 	jrne	00104$
                                    453 ;	../../my_STM8_libraries/stm8_interrupt.c: 96: event = current & EXTIPinMaskA;
      0088BD 9E               [ 1]  454 	ld	a, xh
      0088BE C4 00 10         [ 1]  455 	and	a, _EXTIPinMaskA+0
      0088C1 97               [ 1]  456 	ld	xl, a
      0088C2                        457 00104$:
                                    458 ;	../../my_STM8_libraries/stm8_interrupt.c: 98: EXTI_FlagA |= event;
      0088C2 9F               [ 1]  459 	ld	a, xl
      0088C3 CA 00 11         [ 1]  460 	or	a, _EXTI_FlagA+0
      0088C6 C7 00 11         [ 1]  461 	ld	_EXTI_FlagA+0, a
                                    462 ;	../../my_STM8_libraries/stm8_interrupt.c: 99: }
      0088C9 81               [ 4]  463 	ret
                                    464 ;	../../my_STM8_libraries/stm8_interrupt.c: 100: void handlerPortB(void)
                                    465 ;	-----------------------------------------
                                    466 ;	 function handlerPortB
                                    467 ;	-----------------------------------------
      0088CA                        468 _handlerPortB:
                                    469 ;	../../my_STM8_libraries/stm8_interrupt.c: 102: uint8_t current = PB_IDR;
      0088CA C6 50 06         [ 1]  470 	ld	a, 0x5006
      0088CD 95               [ 1]  471 	ld	xh, a
                                    472 ;	../../my_STM8_libraries/stm8_interrupt.c: 103: uint8_t event = 0;
      0088CE 4F               [ 1]  473 	clr	a
      0088CF 97               [ 1]  474 	ld	xl, a
                                    475 ;	../../my_STM8_libraries/stm8_interrupt.c: 104: if (modeB == FALLING)
      0088D0 C6 00 12         [ 1]  476 	ld	a, _modeB+0
      0088D3 A1 02            [ 1]  477 	cp	a, #0x02
      0088D5 26 06            [ 1]  478 	jrne	00102$
                                    479 ;	../../my_STM8_libraries/stm8_interrupt.c: 106: event = (~current) & EXTIPinMaskB;
      0088D7 9E               [ 1]  480 	ld	a, xh
      0088D8 43               [ 1]  481 	cpl	a
      0088D9 C4 00 13         [ 1]  482 	and	a, _EXTIPinMaskB+0
      0088DC 97               [ 1]  483 	ld	xl, a
      0088DD                        484 00102$:
                                    485 ;	../../my_STM8_libraries/stm8_interrupt.c: 108: if (modeB == RISING)
      0088DD C6 00 12         [ 1]  486 	ld	a, _modeB+0
      0088E0 4A               [ 1]  487 	dec	a
      0088E1 26 05            [ 1]  488 	jrne	00104$
                                    489 ;	../../my_STM8_libraries/stm8_interrupt.c: 110: event = current & EXTIPinMaskB;
      0088E3 9E               [ 1]  490 	ld	a, xh
      0088E4 C4 00 13         [ 1]  491 	and	a, _EXTIPinMaskB+0
      0088E7 97               [ 1]  492 	ld	xl, a
      0088E8                        493 00104$:
                                    494 ;	../../my_STM8_libraries/stm8_interrupt.c: 112: EXTI_FlagB |= event;
      0088E8 9F               [ 1]  495 	ld	a, xl
      0088E9 CA 00 14         [ 1]  496 	or	a, _EXTI_FlagB+0
      0088EC C7 00 14         [ 1]  497 	ld	_EXTI_FlagB+0, a
                                    498 ;	../../my_STM8_libraries/stm8_interrupt.c: 113: }
      0088EF 81               [ 4]  499 	ret
                                    500 ;	../../my_STM8_libraries/stm8_interrupt.c: 114: void handlerPortC(void)
                                    501 ;	-----------------------------------------
                                    502 ;	 function handlerPortC
                                    503 ;	-----------------------------------------
      0088F0                        504 _handlerPortC:
                                    505 ;	../../my_STM8_libraries/stm8_interrupt.c: 116: uint8_t current = PC_IDR;
      0088F0 C6 50 0B         [ 1]  506 	ld	a, 0x500b
      0088F3 95               [ 1]  507 	ld	xh, a
                                    508 ;	../../my_STM8_libraries/stm8_interrupt.c: 117: uint8_t event = 0;
      0088F4 4F               [ 1]  509 	clr	a
      0088F5 97               [ 1]  510 	ld	xl, a
                                    511 ;	../../my_STM8_libraries/stm8_interrupt.c: 118: if (modeC == FALLING)
      0088F6 C6 00 15         [ 1]  512 	ld	a, _modeC+0
      0088F9 A1 02            [ 1]  513 	cp	a, #0x02
      0088FB 26 06            [ 1]  514 	jrne	00102$
                                    515 ;	../../my_STM8_libraries/stm8_interrupt.c: 120: event = (~current) & EXTIPinMaskC;
      0088FD 9E               [ 1]  516 	ld	a, xh
      0088FE 43               [ 1]  517 	cpl	a
      0088FF C4 00 16         [ 1]  518 	and	a, _EXTIPinMaskC+0
      008902 97               [ 1]  519 	ld	xl, a
      008903                        520 00102$:
                                    521 ;	../../my_STM8_libraries/stm8_interrupt.c: 122: if (modeC == RISING)
      008903 C6 00 15         [ 1]  522 	ld	a, _modeC+0
      008906 4A               [ 1]  523 	dec	a
      008907 26 05            [ 1]  524 	jrne	00104$
                                    525 ;	../../my_STM8_libraries/stm8_interrupt.c: 124: event = current & EXTIPinMaskC;
      008909 9E               [ 1]  526 	ld	a, xh
      00890A C4 00 16         [ 1]  527 	and	a, _EXTIPinMaskC+0
      00890D 97               [ 1]  528 	ld	xl, a
      00890E                        529 00104$:
                                    530 ;	../../my_STM8_libraries/stm8_interrupt.c: 126: EXTI_FlagC |= event;
      00890E 9F               [ 1]  531 	ld	a, xl
      00890F CA 00 17         [ 1]  532 	or	a, _EXTI_FlagC+0
      008912 C7 00 17         [ 1]  533 	ld	_EXTI_FlagC+0, a
                                    534 ;	../../my_STM8_libraries/stm8_interrupt.c: 127: }
      008915 81               [ 4]  535 	ret
                                    536 ;	../../my_STM8_libraries/stm8_interrupt.c: 128: void handlerPortD(void)
                                    537 ;	-----------------------------------------
                                    538 ;	 function handlerPortD
                                    539 ;	-----------------------------------------
      008916                        540 _handlerPortD:
                                    541 ;	../../my_STM8_libraries/stm8_interrupt.c: 130: uint8_t current = PD_IDR;
      008916 C6 50 10         [ 1]  542 	ld	a, 0x5010
      008919 95               [ 1]  543 	ld	xh, a
                                    544 ;	../../my_STM8_libraries/stm8_interrupt.c: 131: uint8_t event = 0;
      00891A 4F               [ 1]  545 	clr	a
      00891B 97               [ 1]  546 	ld	xl, a
                                    547 ;	../../my_STM8_libraries/stm8_interrupt.c: 132: if (modeD == FALLING)
      00891C C6 00 18         [ 1]  548 	ld	a, _modeD+0
      00891F A1 02            [ 1]  549 	cp	a, #0x02
      008921 26 06            [ 1]  550 	jrne	00102$
                                    551 ;	../../my_STM8_libraries/stm8_interrupt.c: 134: event = (~current) & EXTIPinMaskD;
      008923 9E               [ 1]  552 	ld	a, xh
      008924 43               [ 1]  553 	cpl	a
      008925 C4 00 19         [ 1]  554 	and	a, _EXTIPinMaskD+0
      008928 97               [ 1]  555 	ld	xl, a
      008929                        556 00102$:
                                    557 ;	../../my_STM8_libraries/stm8_interrupt.c: 136: if (modeD == RISING)
      008929 C6 00 18         [ 1]  558 	ld	a, _modeD+0
      00892C 4A               [ 1]  559 	dec	a
      00892D 26 05            [ 1]  560 	jrne	00104$
                                    561 ;	../../my_STM8_libraries/stm8_interrupt.c: 138: event = current & EXTIPinMaskD;
      00892F 9E               [ 1]  562 	ld	a, xh
      008930 C4 00 19         [ 1]  563 	and	a, _EXTIPinMaskD+0
      008933 97               [ 1]  564 	ld	xl, a
      008934                        565 00104$:
                                    566 ;	../../my_STM8_libraries/stm8_interrupt.c: 140: EXTI_FlagD |= event;
      008934 9F               [ 1]  567 	ld	a, xl
      008935 CA 00 1A         [ 1]  568 	or	a, _EXTI_FlagD+0
      008938 C7 00 1A         [ 1]  569 	ld	_EXTI_FlagD+0, a
                                    570 ;	../../my_STM8_libraries/stm8_interrupt.c: 141: }
      00893B 81               [ 4]  571 	ret
                                    572 	.area CODE
                                    573 	.area CONST
                                    574 	.area INITIALIZER
      00804D                        575 __xinit__modeA:
      00804D 00                     576 	.db #0x00	; 0
      00804E                        577 __xinit__EXTIPinMaskA:
      00804E 00                     578 	.db #0x00	; 0
      00804F                        579 __xinit__EXTI_FlagA:
      00804F 00                     580 	.db #0x00	; 0
      008050                        581 __xinit__modeB:
      008050 00                     582 	.db #0x00	; 0
      008051                        583 __xinit__EXTIPinMaskB:
      008051 00                     584 	.db #0x00	; 0
      008052                        585 __xinit__EXTI_FlagB:
      008052 00                     586 	.db #0x00	; 0
      008053                        587 __xinit__modeC:
      008053 00                     588 	.db #0x00	; 0
      008054                        589 __xinit__EXTIPinMaskC:
      008054 00                     590 	.db #0x00	; 0
      008055                        591 __xinit__EXTI_FlagC:
      008055 00                     592 	.db #0x00	; 0
      008056                        593 __xinit__modeD:
      008056 00                     594 	.db #0x00	; 0
      008057                        595 __xinit__EXTIPinMaskD:
      008057 00                     596 	.db #0x00	; 0
      008058                        597 __xinit__EXTI_FlagD:
      008058 00                     598 	.db #0x00	; 0
                                    599 	.area CABS (ABS)
