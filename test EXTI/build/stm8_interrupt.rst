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
                                     12 	.globl _EXTIPinMaskD
                                     13 	.globl _previousStateD
                                     14 	.globl _EXTI_FlagC
                                     15 	.globl _EXTIPinMaskC
                                     16 	.globl _previousStateC
                                     17 	.globl _EXTI_FlagB
                                     18 	.globl _EXTIPinMaskB
                                     19 	.globl _previousStateB
                                     20 	.globl _EXTI_FlagA
                                     21 	.globl _EXTIPinMaskA
                                     22 	.globl _previousStateA
                                     23 	.globl _set_EXTI
                                     24 	.globl _set_EXTI_pin
                                     25 	.globl _clear_EXTI_pin
                                     26 	.globl _setInterruptPriority
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area INITIALIZED
      00000F                         35 _previousStateA::
      00000F                         36 	.ds 1
      000010                         37 _EXTIPinMaskA::
      000010                         38 	.ds 1
      000011                         39 _EXTI_FlagA::
      000011                         40 	.ds 1
      000012                         41 _previousStateB::
      000012                         42 	.ds 1
      000013                         43 _EXTIPinMaskB::
      000013                         44 	.ds 1
      000014                         45 _EXTI_FlagB::
      000014                         46 	.ds 1
      000015                         47 _previousStateC::
      000015                         48 	.ds 1
      000016                         49 _EXTIPinMaskC::
      000016                         50 	.ds 1
      000017                         51 _EXTI_FlagC::
      000017                         52 	.ds 1
      000018                         53 _previousStateD::
      000018                         54 	.ds 1
      000019                         55 _EXTIPinMaskD::
      000019                         56 	.ds 1
      00001A                         57 _EXTI_FlagD::
      00001A                         58 	.ds 1
                                     59 ;--------------------------------------------------------
                                     60 ; absolute external ram data
                                     61 ;--------------------------------------------------------
                                     62 	.area DABS (ABS)
                                     63 
                                     64 ; default segment ordering for linker
                                     65 	.area HOME
                                     66 	.area GSINIT
                                     67 	.area GSFINAL
                                     68 	.area CONST
                                     69 	.area INITIALIZER
                                     70 	.area CODE
                                     71 
                                     72 ;--------------------------------------------------------
                                     73 ; global & static initialisations
                                     74 ;--------------------------------------------------------
                                     75 	.area HOME
                                     76 	.area GSINIT
                                     77 	.area GSFINAL
                                     78 	.area GSINIT
                                     79 ;--------------------------------------------------------
                                     80 ; Home
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area HOME
                                     84 ;--------------------------------------------------------
                                     85 ; code
                                     86 ;--------------------------------------------------------
                                     87 	.area CODE
                                     88 ;	../../my_STM8_libraries/stm8_interrupt.c: 19: void set_EXTI(uint8_t port, uint8_t mode)
                                     89 ;	-----------------------------------------
                                     90 ;	 function set_EXTI
                                     91 ;	-----------------------------------------
      0086EA                         92 _set_EXTI:
      0086EA 88               [ 1]   93 	push	a
      0086EB 97               [ 1]   94 	ld	xl, a
                                     95 ;	../../my_STM8_libraries/stm8_interrupt.c: 21: EXTI_CR1 &= ~(0b11 << port);
      0086EC C6 50 A0         [ 1]   96 	ld	a, 0x50a0
      0086EF 6B 01            [ 1]   97 	ld	(0x01, sp), a
      0086F1 9F               [ 1]   98 	ld	a, xl
      0086F2 02               [ 1]   99 	rlwa	x
      0086F3 A6 03            [ 1]  100 	ld	a, #0x03
      0086F5 01               [ 1]  101 	rrwa	x
      0086F6 4D               [ 1]  102 	tnz	a
      0086F7 27 06            [ 1]  103 	jreq	00104$
      0086F9                        104 00103$:
      0086F9 02               [ 1]  105 	rlwa	x
      0086FA 48               [ 1]  106 	sll	a
      0086FB 01               [ 1]  107 	rrwa	x
      0086FC 4A               [ 1]  108 	dec	a
      0086FD 26 FA            [ 1]  109 	jrne	00103$
      0086FF                        110 00104$:
      0086FF 9E               [ 1]  111 	ld	a, xh
      008700 43               [ 1]  112 	cpl	a
      008701 14 01            [ 1]  113 	and	a, (0x01, sp)
      008703 C7 50 A0         [ 1]  114 	ld	0x50a0, a
                                    115 ;	../../my_STM8_libraries/stm8_interrupt.c: 22: EXTI_CR1 |= mode << port;
      008706 C6 50 A0         [ 1]  116 	ld	a, 0x50a0
      008709 88               [ 1]  117 	push	a
      00870A 7B 05            [ 1]  118 	ld	a, (0x05, sp)
      00870C 6B 02            [ 1]  119 	ld	(0x02, sp), a
      00870E 9F               [ 1]  120 	ld	a, xl
      00870F 4D               [ 1]  121 	tnz	a
      008710 27 05            [ 1]  122 	jreq	00106$
      008712                        123 00105$:
      008712 08 02            [ 1]  124 	sll	(0x02, sp)
      008714 4A               [ 1]  125 	dec	a
      008715 26 FB            [ 1]  126 	jrne	00105$
      008717                        127 00106$:
      008717 84               [ 1]  128 	pop	a
      008718 1A 01            [ 1]  129 	or	a, (0x01, sp)
      00871A C7 50 A0         [ 1]  130 	ld	0x50a0, a
                                    131 ;	../../my_STM8_libraries/stm8_interrupt.c: 23: }
      00871D 84               [ 1]  132 	pop	a
      00871E 85               [ 2]  133 	popw	x
      00871F 84               [ 1]  134 	pop	a
      008720 FC               [ 2]  135 	jp	(x)
                                    136 ;	../../my_STM8_libraries/stm8_interrupt.c: 24: void set_EXTI_pin(uint8_t port, uint8_t pin)
                                    137 ;	-----------------------------------------
                                    138 ;	 function set_EXTI_pin
                                    139 ;	-----------------------------------------
      008721                        140 _set_EXTI_pin:
      008721 88               [ 1]  141 	push	a
                                    142 ;	../../my_STM8_libraries/stm8_interrupt.c: 26: switch (port)
      008722 A1 00            [ 1]  143 	cp	a, #0x00
      008724 27 12            [ 1]  144 	jreq	00101$
      008726 A1 02            [ 1]  145 	cp	a, #0x02
      008728 27 47            [ 1]  146 	jreq	00104$
      00872A A1 04            [ 1]  147 	cp	a, #0x04
      00872C 27 7B            [ 1]  148 	jreq	00107$
      00872E A1 06            [ 1]  149 	cp	a, #0x06
      008730 26 03            [ 1]  150 	jrne	00166$
      008732 CC 87 E1         [ 2]  151 	jp	00110$
      008735                        152 00166$:
      008735 CC 88 17         [ 2]  153 	jp	00114$
                                    154 ;	../../my_STM8_libraries/stm8_interrupt.c: 28: case EXTI_PORTA:
      008738                        155 00101$:
                                    156 ;	../../my_STM8_libraries/stm8_interrupt.c: 29: if (EXTIPinMaskA == 0) previousStateA = PA_IDR;
      008738 C6 00 10         [ 1]  157 	ld	a, _EXTIPinMaskA+0
      00873B 26 05            [ 1]  158 	jrne	00103$
      00873D 55 50 01 00 0F   [ 1]  159 	mov	_previousStateA+0, 0x5001
      008742                        160 00103$:
                                    161 ;	../../my_STM8_libraries/stm8_interrupt.c: 30: EXTIPinMaskA |= (1 << pin);
      008742 7B 04            [ 1]  162 	ld	a, (0x04, sp)
      008744 41               [ 1]  163 	exg	a, xl
      008745 A6 01            [ 1]  164 	ld	a, #0x01
      008747 41               [ 1]  165 	exg	a, xl
      008748 4D               [ 1]  166 	tnz	a
      008749 27 06            [ 1]  167 	jreq	00170$
      00874B                        168 00169$:
      00874B 41               [ 1]  169 	exg	a, xl
      00874C 48               [ 1]  170 	sll	a
      00874D 41               [ 1]  171 	exg	a, xl
      00874E 4A               [ 1]  172 	dec	a
      00874F 26 FA            [ 1]  173 	jrne	00169$
      008751                        174 00170$:
      008751 9F               [ 1]  175 	ld	a, xl
      008752 CA 00 10         [ 1]  176 	or	a, _EXTIPinMaskA+0
      008755 C7 00 10         [ 1]  177 	ld	_EXTIPinMaskA+0, a
                                    178 ;	../../my_STM8_libraries/stm8_interrupt.c: 31: PA_DDR &= ~(1 << pin);
      008758 C6 50 02         [ 1]  179 	ld	a, 0x5002
      00875B 6B 01            [ 1]  180 	ld	(0x01, sp), a
      00875D 9F               [ 1]  181 	ld	a, xl
      00875E 43               [ 1]  182 	cpl	a
      00875F 14 01            [ 1]  183 	and	a, (0x01, sp)
      008761 C7 50 02         [ 1]  184 	ld	0x5002, a
                                    185 ;	../../my_STM8_libraries/stm8_interrupt.c: 32: PA_CR2 |= (1 << pin);
      008764 C6 50 04         [ 1]  186 	ld	a, 0x5004
      008767 89               [ 2]  187 	pushw	x
      008768 1A 02            [ 1]  188 	or	a, (2, sp)
      00876A 85               [ 2]  189 	popw	x
      00876B C7 50 04         [ 1]  190 	ld	0x5004, a
                                    191 ;	../../my_STM8_libraries/stm8_interrupt.c: 33: break;
      00876E CC 88 17         [ 2]  192 	jp	00114$
                                    193 ;	../../my_STM8_libraries/stm8_interrupt.c: 34: case EXTI_PORTB:
      008771                        194 00104$:
                                    195 ;	../../my_STM8_libraries/stm8_interrupt.c: 35: if (EXTIPinMaskB == 0) previousStateB = PB_IDR;
      008771 C6 00 13         [ 1]  196 	ld	a, _EXTIPinMaskB+0
      008774 26 05            [ 1]  197 	jrne	00106$
      008776 55 50 06 00 12   [ 1]  198 	mov	_previousStateB+0, 0x5006
      00877B                        199 00106$:
                                    200 ;	../../my_STM8_libraries/stm8_interrupt.c: 36: EXTIPinMaskB |= (1 << pin);
      00877B 7B 04            [ 1]  201 	ld	a, (0x04, sp)
      00877D 41               [ 1]  202 	exg	a, xl
      00877E A6 01            [ 1]  203 	ld	a, #0x01
      008780 41               [ 1]  204 	exg	a, xl
      008781 4D               [ 1]  205 	tnz	a
      008782 27 06            [ 1]  206 	jreq	00173$
      008784                        207 00172$:
      008784 41               [ 1]  208 	exg	a, xl
      008785 48               [ 1]  209 	sll	a
      008786 41               [ 1]  210 	exg	a, xl
      008787 4A               [ 1]  211 	dec	a
      008788 26 FA            [ 1]  212 	jrne	00172$
      00878A                        213 00173$:
      00878A 9F               [ 1]  214 	ld	a, xl
      00878B CA 00 13         [ 1]  215 	or	a, _EXTIPinMaskB+0
      00878E C7 00 13         [ 1]  216 	ld	_EXTIPinMaskB+0, a
                                    217 ;	../../my_STM8_libraries/stm8_interrupt.c: 37: PB_DDR &= ~(1 << pin);
      008791 C6 50 07         [ 1]  218 	ld	a, 0x5007
      008794 6B 01            [ 1]  219 	ld	(0x01, sp), a
      008796 9F               [ 1]  220 	ld	a, xl
      008797 43               [ 1]  221 	cpl	a
      008798 14 01            [ 1]  222 	and	a, (0x01, sp)
      00879A C7 50 07         [ 1]  223 	ld	0x5007, a
                                    224 ;	../../my_STM8_libraries/stm8_interrupt.c: 38: PB_CR2 |= (1 << pin);
      00879D C6 50 09         [ 1]  225 	ld	a, 0x5009
      0087A0 89               [ 2]  226 	pushw	x
      0087A1 1A 02            [ 1]  227 	or	a, (2, sp)
      0087A3 85               [ 2]  228 	popw	x
      0087A4 C7 50 09         [ 1]  229 	ld	0x5009, a
                                    230 ;	../../my_STM8_libraries/stm8_interrupt.c: 39: break;
      0087A7 20 6E            [ 2]  231 	jra	00114$
                                    232 ;	../../my_STM8_libraries/stm8_interrupt.c: 40: case EXTI_PORTC:
      0087A9                        233 00107$:
                                    234 ;	../../my_STM8_libraries/stm8_interrupt.c: 41: if (EXTIPinMaskC == 0) previousStateC = PC_IDR;
      0087A9 C6 00 16         [ 1]  235 	ld	a, _EXTIPinMaskC+0
      0087AC 26 05            [ 1]  236 	jrne	00109$
      0087AE 55 50 0B 00 15   [ 1]  237 	mov	_previousStateC+0, 0x500b
      0087B3                        238 00109$:
                                    239 ;	../../my_STM8_libraries/stm8_interrupt.c: 42: EXTIPinMaskC |= (1 << pin);
      0087B3 7B 04            [ 1]  240 	ld	a, (0x04, sp)
      0087B5 41               [ 1]  241 	exg	a, xl
      0087B6 A6 01            [ 1]  242 	ld	a, #0x01
      0087B8 41               [ 1]  243 	exg	a, xl
      0087B9 4D               [ 1]  244 	tnz	a
      0087BA 27 06            [ 1]  245 	jreq	00176$
      0087BC                        246 00175$:
      0087BC 41               [ 1]  247 	exg	a, xl
      0087BD 48               [ 1]  248 	sll	a
      0087BE 41               [ 1]  249 	exg	a, xl
      0087BF 4A               [ 1]  250 	dec	a
      0087C0 26 FA            [ 1]  251 	jrne	00175$
      0087C2                        252 00176$:
      0087C2 9F               [ 1]  253 	ld	a, xl
      0087C3 CA 00 16         [ 1]  254 	or	a, _EXTIPinMaskC+0
      0087C6 C7 00 16         [ 1]  255 	ld	_EXTIPinMaskC+0, a
                                    256 ;	../../my_STM8_libraries/stm8_interrupt.c: 43: PC_DDR &= ~(1 << pin);
      0087C9 C6 50 0C         [ 1]  257 	ld	a, 0x500c
      0087CC 6B 01            [ 1]  258 	ld	(0x01, sp), a
      0087CE 9F               [ 1]  259 	ld	a, xl
      0087CF 43               [ 1]  260 	cpl	a
      0087D0 14 01            [ 1]  261 	and	a, (0x01, sp)
      0087D2 C7 50 0C         [ 1]  262 	ld	0x500c, a
                                    263 ;	../../my_STM8_libraries/stm8_interrupt.c: 44: PC_CR2 |= (1 << pin);
      0087D5 C6 50 0E         [ 1]  264 	ld	a, 0x500e
      0087D8 89               [ 2]  265 	pushw	x
      0087D9 1A 02            [ 1]  266 	or	a, (2, sp)
      0087DB 85               [ 2]  267 	popw	x
      0087DC C7 50 0E         [ 1]  268 	ld	0x500e, a
                                    269 ;	../../my_STM8_libraries/stm8_interrupt.c: 45: break;
      0087DF 20 36            [ 2]  270 	jra	00114$
                                    271 ;	../../my_STM8_libraries/stm8_interrupt.c: 46: case EXTI_PORTD:
      0087E1                        272 00110$:
                                    273 ;	../../my_STM8_libraries/stm8_interrupt.c: 47: if (EXTIPinMaskD == 0) previousStateD = PD_IDR;
      0087E1 C6 00 19         [ 1]  274 	ld	a, _EXTIPinMaskD+0
      0087E4 26 05            [ 1]  275 	jrne	00112$
      0087E6 55 50 10 00 18   [ 1]  276 	mov	_previousStateD+0, 0x5010
      0087EB                        277 00112$:
                                    278 ;	../../my_STM8_libraries/stm8_interrupt.c: 48: EXTIPinMaskD |= (1 << pin);
      0087EB 7B 04            [ 1]  279 	ld	a, (0x04, sp)
      0087ED 41               [ 1]  280 	exg	a, xl
      0087EE A6 01            [ 1]  281 	ld	a, #0x01
      0087F0 41               [ 1]  282 	exg	a, xl
      0087F1 4D               [ 1]  283 	tnz	a
      0087F2 27 06            [ 1]  284 	jreq	00179$
      0087F4                        285 00178$:
      0087F4 41               [ 1]  286 	exg	a, xl
      0087F5 48               [ 1]  287 	sll	a
      0087F6 41               [ 1]  288 	exg	a, xl
      0087F7 4A               [ 1]  289 	dec	a
      0087F8 26 FA            [ 1]  290 	jrne	00178$
      0087FA                        291 00179$:
      0087FA 9F               [ 1]  292 	ld	a, xl
      0087FB CA 00 19         [ 1]  293 	or	a, _EXTIPinMaskD+0
      0087FE C7 00 19         [ 1]  294 	ld	_EXTIPinMaskD+0, a
                                    295 ;	../../my_STM8_libraries/stm8_interrupt.c: 49: PD_DDR &= ~(1 << pin);
      008801 C6 50 11         [ 1]  296 	ld	a, 0x5011
      008804 6B 01            [ 1]  297 	ld	(0x01, sp), a
      008806 9F               [ 1]  298 	ld	a, xl
      008807 43               [ 1]  299 	cpl	a
      008808 14 01            [ 1]  300 	and	a, (0x01, sp)
      00880A C7 50 11         [ 1]  301 	ld	0x5011, a
                                    302 ;	../../my_STM8_libraries/stm8_interrupt.c: 50: PD_CR2 |= (1 << pin);
      00880D C6 50 13         [ 1]  303 	ld	a, 0x5013
      008810 89               [ 2]  304 	pushw	x
      008811 1A 02            [ 1]  305 	or	a, (2, sp)
      008813 85               [ 2]  306 	popw	x
      008814 C7 50 13         [ 1]  307 	ld	0x5013, a
                                    308 ;	../../my_STM8_libraries/stm8_interrupt.c: 52: }
      008817                        309 00114$:
                                    310 ;	../../my_STM8_libraries/stm8_interrupt.c: 53: }
      008817 84               [ 1]  311 	pop	a
      008818 85               [ 2]  312 	popw	x
      008819 84               [ 1]  313 	pop	a
      00881A FC               [ 2]  314 	jp	(x)
                                    315 ;	../../my_STM8_libraries/stm8_interrupt.c: 54: void clear_EXTI_pin(uint8_t port, uint8_t pin)
                                    316 ;	-----------------------------------------
                                    317 ;	 function clear_EXTI_pin
                                    318 ;	-----------------------------------------
      00881B                        319 _clear_EXTI_pin:
      00881B 88               [ 1]  320 	push	a
      00881C 97               [ 1]  321 	ld	xl, a
                                    322 ;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
      00881D 7B 04            [ 1]  323 	ld	a, (0x04, sp)
      00881F 95               [ 1]  324 	ld	xh, a
      008820 A6 01            [ 1]  325 	ld	a, #0x01
      008822 88               [ 1]  326 	push	a
      008823 9E               [ 1]  327 	ld	a, xh
      008824 4D               [ 1]  328 	tnz	a
      008825 27 05            [ 1]  329 	jreq	00129$
      008827                        330 00128$:
      008827 08 01            [ 1]  331 	sll	(1, sp)
      008829 4A               [ 1]  332 	dec	a
      00882A 26 FB            [ 1]  333 	jrne	00128$
      00882C                        334 00129$:
      00882C 84               [ 1]  335 	pop	a
      00882D 43               [ 1]  336 	cpl	a
      00882E 6B 01            [ 1]  337 	ld	(0x01, sp), a
                                    338 ;	../../my_STM8_libraries/stm8_interrupt.c: 56: switch (port)
      008830 9F               [ 1]  339 	ld	a, xl
      008831 A1 00            [ 1]  340 	cp	a, #0x00
      008833 27 11            [ 1]  341 	jreq	00101$
      008835 9F               [ 1]  342 	ld	a, xl
      008836 A1 02            [ 1]  343 	cp	a, #0x02
      008838 27 26            [ 1]  344 	jreq	00102$
      00883A 9F               [ 1]  345 	ld	a, xl
      00883B A1 04            [ 1]  346 	cp	a, #0x04
      00883D 27 3B            [ 1]  347 	jreq	00103$
      00883F 9F               [ 1]  348 	ld	a, xl
      008840 A1 06            [ 1]  349 	cp	a, #0x06
      008842 27 50            [ 1]  350 	jreq	00104$
      008844 20 66            [ 2]  351 	jra	00106$
                                    352 ;	../../my_STM8_libraries/stm8_interrupt.c: 58: case EXTI_PORTA:
      008846                        353 00101$:
                                    354 ;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
      008846 7B 01            [ 1]  355 	ld	a, (0x01, sp)
      008848 C4 00 10         [ 1]  356 	and	a, _EXTIPinMaskA+0
      00884B C7 00 10         [ 1]  357 	ld	_EXTIPinMaskA+0, a
                                    358 ;	../../my_STM8_libraries/stm8_interrupt.c: 60: PA_DDR &= ~(1 << pin);
      00884E C6 50 02         [ 1]  359 	ld	a, 0x5002
      008851 14 01            [ 1]  360 	and	a, (0x01, sp)
      008853 C7 50 02         [ 1]  361 	ld	0x5002, a
                                    362 ;	../../my_STM8_libraries/stm8_interrupt.c: 61: PA_CR2 &= ~(1 << pin);
      008856 C6 50 04         [ 1]  363 	ld	a, 0x5004
      008859 14 01            [ 1]  364 	and	a, (0x01, sp)
      00885B C7 50 04         [ 1]  365 	ld	0x5004, a
                                    366 ;	../../my_STM8_libraries/stm8_interrupt.c: 62: break;
      00885E 20 4C            [ 2]  367 	jra	00106$
                                    368 ;	../../my_STM8_libraries/stm8_interrupt.c: 63: case EXTI_PORTB:
      008860                        369 00102$:
                                    370 ;	../../my_STM8_libraries/stm8_interrupt.c: 64: EXTIPinMaskB &= ~(1 << pin);
      008860 7B 01            [ 1]  371 	ld	a, (0x01, sp)
      008862 C4 00 13         [ 1]  372 	and	a, _EXTIPinMaskB+0
      008865 C7 00 13         [ 1]  373 	ld	_EXTIPinMaskB+0, a
                                    374 ;	../../my_STM8_libraries/stm8_interrupt.c: 65: PB_DDR &= ~(1 << pin);
      008868 C6 50 07         [ 1]  375 	ld	a, 0x5007
      00886B 14 01            [ 1]  376 	and	a, (0x01, sp)
      00886D C7 50 07         [ 1]  377 	ld	0x5007, a
                                    378 ;	../../my_STM8_libraries/stm8_interrupt.c: 66: PB_CR2 &= ~(1 << pin);
      008870 C6 50 09         [ 1]  379 	ld	a, 0x5009
      008873 14 01            [ 1]  380 	and	a, (0x01, sp)
      008875 C7 50 09         [ 1]  381 	ld	0x5009, a
                                    382 ;	../../my_STM8_libraries/stm8_interrupt.c: 67: break;
      008878 20 32            [ 2]  383 	jra	00106$
                                    384 ;	../../my_STM8_libraries/stm8_interrupt.c: 68: case EXTI_PORTC:
      00887A                        385 00103$:
                                    386 ;	../../my_STM8_libraries/stm8_interrupt.c: 69: EXTIPinMaskC &= ~(1 << pin);
      00887A 7B 01            [ 1]  387 	ld	a, (0x01, sp)
      00887C C4 00 16         [ 1]  388 	and	a, _EXTIPinMaskC+0
      00887F C7 00 16         [ 1]  389 	ld	_EXTIPinMaskC+0, a
                                    390 ;	../../my_STM8_libraries/stm8_interrupt.c: 70: PC_DDR &= ~(1 << pin);
      008882 C6 50 0C         [ 1]  391 	ld	a, 0x500c
      008885 14 01            [ 1]  392 	and	a, (0x01, sp)
      008887 C7 50 0C         [ 1]  393 	ld	0x500c, a
                                    394 ;	../../my_STM8_libraries/stm8_interrupt.c: 71: PC_CR2 &= ~(1 << pin);
      00888A C6 50 0E         [ 1]  395 	ld	a, 0x500e
      00888D 14 01            [ 1]  396 	and	a, (0x01, sp)
      00888F C7 50 0E         [ 1]  397 	ld	0x500e, a
                                    398 ;	../../my_STM8_libraries/stm8_interrupt.c: 72: break;
      008892 20 18            [ 2]  399 	jra	00106$
                                    400 ;	../../my_STM8_libraries/stm8_interrupt.c: 73: case EXTI_PORTD:
      008894                        401 00104$:
                                    402 ;	../../my_STM8_libraries/stm8_interrupt.c: 74: EXTIPinMaskD &= ~(1 << pin);
      008894 7B 01            [ 1]  403 	ld	a, (0x01, sp)
      008896 C4 00 19         [ 1]  404 	and	a, _EXTIPinMaskD+0
      008899 C7 00 19         [ 1]  405 	ld	_EXTIPinMaskD+0, a
                                    406 ;	../../my_STM8_libraries/stm8_interrupt.c: 75: PD_DDR &= ~(1 << pin);
      00889C C6 50 11         [ 1]  407 	ld	a, 0x5011
      00889F 14 01            [ 1]  408 	and	a, (0x01, sp)
      0088A1 C7 50 11         [ 1]  409 	ld	0x5011, a
                                    410 ;	../../my_STM8_libraries/stm8_interrupt.c: 76: PD_CR2 &= ~(1 << pin);
      0088A4 C6 50 13         [ 1]  411 	ld	a, 0x5013
      0088A7 14 01            [ 1]  412 	and	a, (0x01, sp)
      0088A9 C7 50 13         [ 1]  413 	ld	0x5013, a
                                    414 ;	../../my_STM8_libraries/stm8_interrupt.c: 78: }
      0088AC                        415 00106$:
                                    416 ;	../../my_STM8_libraries/stm8_interrupt.c: 79: }
      0088AC 84               [ 1]  417 	pop	a
      0088AD 85               [ 2]  418 	popw	x
      0088AE 84               [ 1]  419 	pop	a
      0088AF FC               [ 2]  420 	jp	(x)
                                    421 ;	../../my_STM8_libraries/stm8_interrupt.c: 80: void setInterruptPriority(uint8_t interrupt, uint8_t priorityLevel)
                                    422 ;	-----------------------------------------
                                    423 ;	 function setInterruptPriority
                                    424 ;	-----------------------------------------
      0088B0                        425 _setInterruptPriority:
      0088B0 52 02            [ 2]  426 	sub	sp, #2
                                    427 ;	../../my_STM8_libraries/stm8_interrupt.c: 82: volatile uint8_t *priorityReg = &ITC_SPR1 + (interrupt >> 2);
      0088B2 90 97            [ 1]  428 	ld	yl, a
      0088B4 44               [ 1]  429 	srl	a
      0088B5 44               [ 1]  430 	srl	a
      0088B6 5F               [ 1]  431 	clrw	x
      0088B7 97               [ 1]  432 	ld	xl, a
      0088B8 1C 7F 70         [ 2]  433 	addw	x, #0x7f70
                                    434 ;	../../my_STM8_libraries/stm8_interrupt.c: 83: *priorityReg &= ~(3 << ((interrupt & 3) << 1));
      0088BB F6               [ 1]  435 	ld	a, (x)
      0088BC 6B 02            [ 1]  436 	ld	(0x02, sp), a
      0088BE 90 9F            [ 1]  437 	ld	a, yl
      0088C0 A4 03            [ 1]  438 	and	a, #0x03
      0088C2 48               [ 1]  439 	sll	a
      0088C3 6B 01            [ 1]  440 	ld	(0x01, sp), a
      0088C5 A6 03            [ 1]  441 	ld	a, #0x03
      0088C7 88               [ 1]  442 	push	a
      0088C8 7B 02            [ 1]  443 	ld	a, (0x02, sp)
      0088CA 27 05            [ 1]  444 	jreq	00104$
      0088CC                        445 00103$:
      0088CC 08 01            [ 1]  446 	sll	(1, sp)
      0088CE 4A               [ 1]  447 	dec	a
      0088CF 26 FB            [ 1]  448 	jrne	00103$
      0088D1                        449 00104$:
      0088D1 84               [ 1]  450 	pop	a
      0088D2 43               [ 1]  451 	cpl	a
      0088D3 14 02            [ 1]  452 	and	a, (0x02, sp)
      0088D5 F7               [ 1]  453 	ld	(x), a
                                    454 ;	../../my_STM8_libraries/stm8_interrupt.c: 84: *priorityReg |= (priorityLevel << ((interrupt & 3) << 1));
      0088D6 F6               [ 1]  455 	ld	a, (x)
      0088D7 6B 02            [ 1]  456 	ld	(0x02, sp), a
      0088D9 7B 05            [ 1]  457 	ld	a, (0x05, sp)
      0088DB 88               [ 1]  458 	push	a
      0088DC 7B 02            [ 1]  459 	ld	a, (0x02, sp)
      0088DE 27 05            [ 1]  460 	jreq	00106$
      0088E0                        461 00105$:
      0088E0 08 01            [ 1]  462 	sll	(1, sp)
      0088E2 4A               [ 1]  463 	dec	a
      0088E3 26 FB            [ 1]  464 	jrne	00105$
      0088E5                        465 00106$:
      0088E5 84               [ 1]  466 	pop	a
      0088E6 1A 02            [ 1]  467 	or	a, (0x02, sp)
      0088E8 F7               [ 1]  468 	ld	(x), a
                                    469 ;	../../my_STM8_libraries/stm8_interrupt.c: 85: }
      0088E9 5B 02            [ 2]  470 	addw	sp, #2
      0088EB 85               [ 2]  471 	popw	x
      0088EC 84               [ 1]  472 	pop	a
      0088ED FC               [ 2]  473 	jp	(x)
                                    474 	.area CODE
                                    475 	.area CONST
                                    476 	.area INITIALIZER
      00804D                        477 __xinit__previousStateA:
      00804D 00                     478 	.db #0x00	; 0
      00804E                        479 __xinit__EXTIPinMaskA:
      00804E 00                     480 	.db #0x00	; 0
      00804F                        481 __xinit__EXTI_FlagA:
      00804F 00                     482 	.db #0x00	; 0
      008050                        483 __xinit__previousStateB:
      008050 00                     484 	.db #0x00	; 0
      008051                        485 __xinit__EXTIPinMaskB:
      008051 00                     486 	.db #0x00	; 0
      008052                        487 __xinit__EXTI_FlagB:
      008052 00                     488 	.db #0x00	; 0
      008053                        489 __xinit__previousStateC:
      008053 00                     490 	.db #0x00	; 0
      008054                        491 __xinit__EXTIPinMaskC:
      008054 00                     492 	.db #0x00	; 0
      008055                        493 __xinit__EXTI_FlagC:
      008055 00                     494 	.db #0x00	; 0
      008056                        495 __xinit__previousStateD:
      008056 00                     496 	.db #0x00	; 0
      008057                        497 __xinit__EXTIPinMaskD:
      008057 00                     498 	.db #0x00	; 0
      008058                        499 __xinit__EXTI_FlagD:
      008058 00                     500 	.db #0x00	; 0
                                    501 	.area CABS (ABS)
