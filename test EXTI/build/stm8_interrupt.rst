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
                                    141 ;	../../my_STM8_libraries/stm8_interrupt.c: 26: switch (port)
      008721 A1 00            [ 1]  142 	cp	a, #0x00
      008723 27 0F            [ 1]  143 	jreq	00101$
      008725 A1 02            [ 1]  144 	cp	a, #0x02
      008727 27 2D            [ 1]  145 	jreq	00104$
      008729 A1 04            [ 1]  146 	cp	a, #0x04
      00872B 27 4B            [ 1]  147 	jreq	00107$
      00872D A1 06            [ 1]  148 	cp	a, #0x06
      00872F 27 69            [ 1]  149 	jreq	00110$
      008731 CC 87 BA         [ 2]  150 	jp	00114$
                                    151 ;	../../my_STM8_libraries/stm8_interrupt.c: 28: case EXTI_PORTA:
      008734                        152 00101$:
                                    153 ;	../../my_STM8_libraries/stm8_interrupt.c: 29: if (EXTIPinMaskA == 0) previousStateA = PA_IDR;
      008734 C6 00 10         [ 1]  154 	ld	a, _EXTIPinMaskA+0
      008737 26 05            [ 1]  155 	jrne	00103$
      008739 55 50 01 00 0F   [ 1]  156 	mov	_previousStateA+0, 0x5001
      00873E                        157 00103$:
                                    158 ;	../../my_STM8_libraries/stm8_interrupt.c: 30: EXTIPinMaskA |= (1 << pin);
      00873E 7B 03            [ 1]  159 	ld	a, (0x03, sp)
      008740 97               [ 1]  160 	ld	xl, a
      008741 A6 01            [ 1]  161 	ld	a, #0x01
      008743 88               [ 1]  162 	push	a
      008744 9F               [ 1]  163 	ld	a, xl
      008745 4D               [ 1]  164 	tnz	a
      008746 27 05            [ 1]  165 	jreq	00170$
      008748                        166 00169$:
      008748 08 01            [ 1]  167 	sll	(1, sp)
      00874A 4A               [ 1]  168 	dec	a
      00874B 26 FB            [ 1]  169 	jrne	00169$
      00874D                        170 00170$:
      00874D 84               [ 1]  171 	pop	a
      00874E CA 00 10         [ 1]  172 	or	a, _EXTIPinMaskA+0
      008751 C7 00 10         [ 1]  173 	ld	_EXTIPinMaskA+0, a
                                    174 ;	../../my_STM8_libraries/stm8_interrupt.c: 31: break;
      008754 20 64            [ 2]  175 	jra	00114$
                                    176 ;	../../my_STM8_libraries/stm8_interrupt.c: 32: case EXTI_PORTB:
      008756                        177 00104$:
                                    178 ;	../../my_STM8_libraries/stm8_interrupt.c: 33: if (EXTIPinMaskB == 0) previousStateB = PB_IDR;
      008756 C6 00 13         [ 1]  179 	ld	a, _EXTIPinMaskB+0
      008759 26 05            [ 1]  180 	jrne	00106$
      00875B 55 50 06 00 12   [ 1]  181 	mov	_previousStateB+0, 0x5006
      008760                        182 00106$:
                                    183 ;	../../my_STM8_libraries/stm8_interrupt.c: 34: EXTIPinMaskB |= (1 << pin);
      008760 7B 03            [ 1]  184 	ld	a, (0x03, sp)
      008762 97               [ 1]  185 	ld	xl, a
      008763 A6 01            [ 1]  186 	ld	a, #0x01
      008765 88               [ 1]  187 	push	a
      008766 9F               [ 1]  188 	ld	a, xl
      008767 4D               [ 1]  189 	tnz	a
      008768 27 05            [ 1]  190 	jreq	00173$
      00876A                        191 00172$:
      00876A 08 01            [ 1]  192 	sll	(1, sp)
      00876C 4A               [ 1]  193 	dec	a
      00876D 26 FB            [ 1]  194 	jrne	00172$
      00876F                        195 00173$:
      00876F 84               [ 1]  196 	pop	a
      008770 CA 00 13         [ 1]  197 	or	a, _EXTIPinMaskB+0
      008773 C7 00 13         [ 1]  198 	ld	_EXTIPinMaskB+0, a
                                    199 ;	../../my_STM8_libraries/stm8_interrupt.c: 35: break;
      008776 20 42            [ 2]  200 	jra	00114$
                                    201 ;	../../my_STM8_libraries/stm8_interrupt.c: 36: case EXTI_PORTC:
      008778                        202 00107$:
                                    203 ;	../../my_STM8_libraries/stm8_interrupt.c: 37: if (EXTIPinMaskC == 0) previousStateC = PC_IDR;
      008778 C6 00 16         [ 1]  204 	ld	a, _EXTIPinMaskC+0
      00877B 26 05            [ 1]  205 	jrne	00109$
      00877D 55 50 0B 00 15   [ 1]  206 	mov	_previousStateC+0, 0x500b
      008782                        207 00109$:
                                    208 ;	../../my_STM8_libraries/stm8_interrupt.c: 38: EXTIPinMaskC |= (1 << pin);
      008782 7B 03            [ 1]  209 	ld	a, (0x03, sp)
      008784 97               [ 1]  210 	ld	xl, a
      008785 A6 01            [ 1]  211 	ld	a, #0x01
      008787 88               [ 1]  212 	push	a
      008788 9F               [ 1]  213 	ld	a, xl
      008789 4D               [ 1]  214 	tnz	a
      00878A 27 05            [ 1]  215 	jreq	00176$
      00878C                        216 00175$:
      00878C 08 01            [ 1]  217 	sll	(1, sp)
      00878E 4A               [ 1]  218 	dec	a
      00878F 26 FB            [ 1]  219 	jrne	00175$
      008791                        220 00176$:
      008791 84               [ 1]  221 	pop	a
      008792 CA 00 16         [ 1]  222 	or	a, _EXTIPinMaskC+0
      008795 C7 00 16         [ 1]  223 	ld	_EXTIPinMaskC+0, a
                                    224 ;	../../my_STM8_libraries/stm8_interrupt.c: 39: break;
      008798 20 20            [ 2]  225 	jra	00114$
                                    226 ;	../../my_STM8_libraries/stm8_interrupt.c: 40: case EXTI_PORTD:
      00879A                        227 00110$:
                                    228 ;	../../my_STM8_libraries/stm8_interrupt.c: 41: if (EXTIPinMaskD == 0) previousStateD = PD_IDR;
      00879A C6 00 19         [ 1]  229 	ld	a, _EXTIPinMaskD+0
      00879D 26 05            [ 1]  230 	jrne	00112$
      00879F 55 50 10 00 18   [ 1]  231 	mov	_previousStateD+0, 0x5010
      0087A4                        232 00112$:
                                    233 ;	../../my_STM8_libraries/stm8_interrupt.c: 42: EXTIPinMaskD |= (1 << pin);
      0087A4 7B 03            [ 1]  234 	ld	a, (0x03, sp)
      0087A6 97               [ 1]  235 	ld	xl, a
      0087A7 A6 01            [ 1]  236 	ld	a, #0x01
      0087A9 88               [ 1]  237 	push	a
      0087AA 9F               [ 1]  238 	ld	a, xl
      0087AB 4D               [ 1]  239 	tnz	a
      0087AC 27 05            [ 1]  240 	jreq	00179$
      0087AE                        241 00178$:
      0087AE 08 01            [ 1]  242 	sll	(1, sp)
      0087B0 4A               [ 1]  243 	dec	a
      0087B1 26 FB            [ 1]  244 	jrne	00178$
      0087B3                        245 00179$:
      0087B3 84               [ 1]  246 	pop	a
      0087B4 CA 00 19         [ 1]  247 	or	a, _EXTIPinMaskD+0
      0087B7 C7 00 19         [ 1]  248 	ld	_EXTIPinMaskD+0, a
                                    249 ;	../../my_STM8_libraries/stm8_interrupt.c: 44: }
      0087BA                        250 00114$:
                                    251 ;	../../my_STM8_libraries/stm8_interrupt.c: 45: }
      0087BA 85               [ 2]  252 	popw	x
      0087BB 84               [ 1]  253 	pop	a
      0087BC FC               [ 2]  254 	jp	(x)
                                    255 ;	../../my_STM8_libraries/stm8_interrupt.c: 46: void clear_EXTI_pin(uint8_t port, uint8_t pin)
                                    256 ;	-----------------------------------------
                                    257 ;	 function clear_EXTI_pin
                                    258 ;	-----------------------------------------
      0087BD                        259 _clear_EXTI_pin:
      0087BD 97               [ 1]  260 	ld	xl, a
                                    261 ;	../../my_STM8_libraries/stm8_interrupt.c: 51: EXTIPinMaskA &= ~(1 << pin);
      0087BE 7B 03            [ 1]  262 	ld	a, (0x03, sp)
      0087C0 95               [ 1]  263 	ld	xh, a
      0087C1 A6 01            [ 1]  264 	ld	a, #0x01
      0087C3 88               [ 1]  265 	push	a
      0087C4 9E               [ 1]  266 	ld	a, xh
      0087C5 4D               [ 1]  267 	tnz	a
      0087C6 27 05            [ 1]  268 	jreq	00129$
      0087C8                        269 00128$:
      0087C8 08 01            [ 1]  270 	sll	(1, sp)
      0087CA 4A               [ 1]  271 	dec	a
      0087CB 26 FB            [ 1]  272 	jrne	00128$
      0087CD                        273 00129$:
      0087CD 84               [ 1]  274 	pop	a
      0087CE 43               [ 1]  275 	cpl	a
      0087CF 95               [ 1]  276 	ld	xh, a
                                    277 ;	../../my_STM8_libraries/stm8_interrupt.c: 48: switch (port)
      0087D0 9F               [ 1]  278 	ld	a, xl
      0087D1 A1 00            [ 1]  279 	cp	a, #0x00
      0087D3 27 11            [ 1]  280 	jreq	00101$
      0087D5 9F               [ 1]  281 	ld	a, xl
      0087D6 A1 02            [ 1]  282 	cp	a, #0x02
      0087D8 27 15            [ 1]  283 	jreq	00102$
      0087DA 9F               [ 1]  284 	ld	a, xl
      0087DB A1 04            [ 1]  285 	cp	a, #0x04
      0087DD 27 19            [ 1]  286 	jreq	00103$
      0087DF 9F               [ 1]  287 	ld	a, xl
      0087E0 A1 06            [ 1]  288 	cp	a, #0x06
      0087E2 27 1D            [ 1]  289 	jreq	00104$
      0087E4 20 22            [ 2]  290 	jra	00106$
                                    291 ;	../../my_STM8_libraries/stm8_interrupt.c: 50: case EXTI_PORTA:
      0087E6                        292 00101$:
                                    293 ;	../../my_STM8_libraries/stm8_interrupt.c: 51: EXTIPinMaskA &= ~(1 << pin);
      0087E6 9E               [ 1]  294 	ld	a, xh
      0087E7 C4 00 10         [ 1]  295 	and	a, _EXTIPinMaskA+0
      0087EA C7 00 10         [ 1]  296 	ld	_EXTIPinMaskA+0, a
                                    297 ;	../../my_STM8_libraries/stm8_interrupt.c: 52: break;
      0087ED 20 19            [ 2]  298 	jra	00106$
                                    299 ;	../../my_STM8_libraries/stm8_interrupt.c: 53: case EXTI_PORTB:
      0087EF                        300 00102$:
                                    301 ;	../../my_STM8_libraries/stm8_interrupt.c: 54: EXTIPinMaskB &= ~(1 << pin);
      0087EF 9E               [ 1]  302 	ld	a, xh
      0087F0 C4 00 13         [ 1]  303 	and	a, _EXTIPinMaskB+0
      0087F3 C7 00 13         [ 1]  304 	ld	_EXTIPinMaskB+0, a
                                    305 ;	../../my_STM8_libraries/stm8_interrupt.c: 55: break;
      0087F6 20 10            [ 2]  306 	jra	00106$
                                    307 ;	../../my_STM8_libraries/stm8_interrupt.c: 56: case EXTI_PORTC:
      0087F8                        308 00103$:
                                    309 ;	../../my_STM8_libraries/stm8_interrupt.c: 57: EXTIPinMaskC &= ~(1 << pin);
      0087F8 9E               [ 1]  310 	ld	a, xh
      0087F9 C4 00 16         [ 1]  311 	and	a, _EXTIPinMaskC+0
      0087FC C7 00 16         [ 1]  312 	ld	_EXTIPinMaskC+0, a
                                    313 ;	../../my_STM8_libraries/stm8_interrupt.c: 58: break;
      0087FF 20 07            [ 2]  314 	jra	00106$
                                    315 ;	../../my_STM8_libraries/stm8_interrupt.c: 59: case EXTI_PORTD:
      008801                        316 00104$:
                                    317 ;	../../my_STM8_libraries/stm8_interrupt.c: 60: EXTIPinMaskD &= ~(1 << pin);
      008801 9E               [ 1]  318 	ld	a, xh
      008802 C4 00 19         [ 1]  319 	and	a, _EXTIPinMaskD+0
      008805 C7 00 19         [ 1]  320 	ld	_EXTIPinMaskD+0, a
                                    321 ;	../../my_STM8_libraries/stm8_interrupt.c: 62: }
      008808                        322 00106$:
                                    323 ;	../../my_STM8_libraries/stm8_interrupt.c: 63: }
      008808 85               [ 2]  324 	popw	x
      008809 84               [ 1]  325 	pop	a
      00880A FC               [ 2]  326 	jp	(x)
                                    327 ;	../../my_STM8_libraries/stm8_interrupt.c: 64: void setInterruptPriority(uint8_t interrupt, uint8_t priorityLevel)
                                    328 ;	-----------------------------------------
                                    329 ;	 function setInterruptPriority
                                    330 ;	-----------------------------------------
      00880B                        331 _setInterruptPriority:
      00880B 52 02            [ 2]  332 	sub	sp, #2
                                    333 ;	../../my_STM8_libraries/stm8_interrupt.c: 66: volatile uint8_t *priorityReg = &ITC_SPR1 + (interrupt >> 2);
      00880D 90 97            [ 1]  334 	ld	yl, a
      00880F 44               [ 1]  335 	srl	a
      008810 44               [ 1]  336 	srl	a
      008811 5F               [ 1]  337 	clrw	x
      008812 97               [ 1]  338 	ld	xl, a
      008813 1C 7F 70         [ 2]  339 	addw	x, #0x7f70
                                    340 ;	../../my_STM8_libraries/stm8_interrupt.c: 67: *priorityReg &= ~(3 << ((interrupt & 3) << 1));
      008816 F6               [ 1]  341 	ld	a, (x)
      008817 6B 02            [ 1]  342 	ld	(0x02, sp), a
      008819 90 9F            [ 1]  343 	ld	a, yl
      00881B A4 03            [ 1]  344 	and	a, #0x03
      00881D 48               [ 1]  345 	sll	a
      00881E 6B 01            [ 1]  346 	ld	(0x01, sp), a
      008820 A6 03            [ 1]  347 	ld	a, #0x03
      008822 88               [ 1]  348 	push	a
      008823 7B 02            [ 1]  349 	ld	a, (0x02, sp)
      008825 27 05            [ 1]  350 	jreq	00104$
      008827                        351 00103$:
      008827 08 01            [ 1]  352 	sll	(1, sp)
      008829 4A               [ 1]  353 	dec	a
      00882A 26 FB            [ 1]  354 	jrne	00103$
      00882C                        355 00104$:
      00882C 84               [ 1]  356 	pop	a
      00882D 43               [ 1]  357 	cpl	a
      00882E 14 02            [ 1]  358 	and	a, (0x02, sp)
      008830 F7               [ 1]  359 	ld	(x), a
                                    360 ;	../../my_STM8_libraries/stm8_interrupt.c: 68: *priorityReg |= (priorityLevel << ((interrupt & 3) << 1));
      008831 F6               [ 1]  361 	ld	a, (x)
      008832 6B 02            [ 1]  362 	ld	(0x02, sp), a
      008834 7B 05            [ 1]  363 	ld	a, (0x05, sp)
      008836 88               [ 1]  364 	push	a
      008837 7B 02            [ 1]  365 	ld	a, (0x02, sp)
      008839 27 05            [ 1]  366 	jreq	00106$
      00883B                        367 00105$:
      00883B 08 01            [ 1]  368 	sll	(1, sp)
      00883D 4A               [ 1]  369 	dec	a
      00883E 26 FB            [ 1]  370 	jrne	00105$
      008840                        371 00106$:
      008840 84               [ 1]  372 	pop	a
      008841 1A 02            [ 1]  373 	or	a, (0x02, sp)
      008843 F7               [ 1]  374 	ld	(x), a
                                    375 ;	../../my_STM8_libraries/stm8_interrupt.c: 69: }
      008844 5B 02            [ 2]  376 	addw	sp, #2
      008846 85               [ 2]  377 	popw	x
      008847 84               [ 1]  378 	pop	a
      008848 FC               [ 2]  379 	jp	(x)
                                    380 	.area CODE
                                    381 	.area CONST
                                    382 	.area INITIALIZER
      00804D                        383 __xinit__previousStateA:
      00804D 00                     384 	.db #0x00	; 0
      00804E                        385 __xinit__EXTIPinMaskA:
      00804E 00                     386 	.db #0x00	; 0
      00804F                        387 __xinit__EXTI_FlagA:
      00804F 00                     388 	.db #0x00	; 0
      008050                        389 __xinit__previousStateB:
      008050 00                     390 	.db #0x00	; 0
      008051                        391 __xinit__EXTIPinMaskB:
      008051 00                     392 	.db #0x00	; 0
      008052                        393 __xinit__EXTI_FlagB:
      008052 00                     394 	.db #0x00	; 0
      008053                        395 __xinit__previousStateC:
      008053 00                     396 	.db #0x00	; 0
      008054                        397 __xinit__EXTIPinMaskC:
      008054 00                     398 	.db #0x00	; 0
      008055                        399 __xinit__EXTI_FlagC:
      008055 00                     400 	.db #0x00	; 0
      008056                        401 __xinit__previousStateD:
      008056 00                     402 	.db #0x00	; 0
      008057                        403 __xinit__EXTIPinMaskD:
      008057 00                     404 	.db #0x00	; 0
      008058                        405 __xinit__EXTI_FlagD:
      008058 00                     406 	.db #0x00	; 0
                                    407 	.area CABS (ABS)
