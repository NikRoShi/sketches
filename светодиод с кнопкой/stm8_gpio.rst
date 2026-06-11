                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_gpio
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _pinMode
                                     11 	.globl _digitalWrite
                                     12 	.globl _togglePin
                                     13 	.globl _digitalRead
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
      000001                         22 _gpio_ports:
      000001                         23 	.ds 32
                                     24 ;--------------------------------------------------------
                                     25 ; absolute external ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DABS (ABS)
                                     28 
                                     29 ; default segment ordering for linker
                                     30 	.area HOME
                                     31 	.area GSINIT
                                     32 	.area GSFINAL
                                     33 	.area CONST
                                     34 	.area INITIALIZER
                                     35 	.area CODE
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; global & static initialisations
                                     39 ;--------------------------------------------------------
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area GSINIT
                                     44 ;--------------------------------------------------------
                                     45 ; Home
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
                                     48 	.area HOME
                                     49 ;--------------------------------------------------------
                                     50 ; code
                                     51 ;--------------------------------------------------------
                                     52 	.area CODE
                                     53 ;	stm8_gpio.c: 42: void pinMode(Port_t port, uint8_t pin, PinMode_t mode)
                                     54 ;	-----------------------------------------
                                     55 ;	 function pinMode
                                     56 ;	-----------------------------------------
      008189                         57 _pinMode:
      008189 52 06            [ 2]   58 	sub	sp, #6
      00818B 97               [ 1]   59 	ld	xl, a
                                     60 ;	stm8_gpio.c: 44: GPIO_Port *p = &gpio_ports[port];
      00818C A6 08            [ 1]   61 	ld	a, #0x08
      00818E 42               [ 4]   62 	mul	x, a
      00818F 1C 00 01         [ 2]   63 	addw	x, #(_gpio_ports+0)
                                     64 ;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
      008192 90 93            [ 1]   65 	ldw	y, x
      008194 A6 01            [ 1]   66 	ld	a, #0x01
      008196 6B 01            [ 1]   67 	ld	(0x01, sp), a
      008198 7B 09            [ 1]   68 	ld	a, (0x09, sp)
      00819A 27 05            [ 1]   69 	jreq	00124$
      00819C                         70 00123$:
      00819C 08 01            [ 1]   71 	sll	(0x01, sp)
      00819E 4A               [ 1]   72 	dec	a
      00819F 26 FB            [ 1]   73 	jrne	00123$
      0081A1                         74 00124$:
                                     75 ;	stm8_gpio.c: 48: *p->CR1 |=  (1 << pin);   // push-pull
      0081A1 72 A9 00 04      [ 2]   76 	addw	y, #0x0004
      0081A5 17 02            [ 2]   77 	ldw	(0x02, sp), y
                                     78 ;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
      0081A7 EE 02            [ 2]   79 	ldw	x, (0x2, x)
      0081A9 1F 04            [ 2]   80 	ldw	(0x04, sp), x
      0081AB F6               [ 1]   81 	ld	a, (x)
      0081AC 97               [ 1]   82 	ld	xl, a
                                     83 ;	stm8_gpio.c: 46: if (mode == PIN_OUTPUT) {
      0081AD 7B 0A            [ 1]   84 	ld	a, (0x0a, sp)
      0081AF 4A               [ 1]   85 	dec	a
      0081B0 26 0F            [ 1]   86 	jrne	00105$
                                     87 ;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
      0081B2 9F               [ 1]   88 	ld	a, xl
      0081B3 1A 01            [ 1]   89 	or	a, (0x01, sp)
      0081B5 1E 04            [ 2]   90 	ldw	x, (0x04, sp)
      0081B7 F7               [ 1]   91 	ld	(x), a
                                     92 ;	stm8_gpio.c: 48: *p->CR1 |=  (1 << pin);   // push-pull
      0081B8 1E 02            [ 2]   93 	ldw	x, (0x02, sp)
      0081BA FE               [ 2]   94 	ldw	x, (x)
      0081BB F6               [ 1]   95 	ld	a, (x)
      0081BC 1A 01            [ 1]   96 	or	a, (0x01, sp)
      0081BE F7               [ 1]   97 	ld	(x), a
      0081BF 20 22            [ 2]   98 	jra	00107$
      0081C1                         99 00105$:
                                    100 ;	stm8_gpio.c: 51: *p->DDR &= ~(1 << pin);   // input
      0081C1 7B 01            [ 1]  101 	ld	a, (0x01, sp)
      0081C3 43               [ 1]  102 	cpl	a
      0081C4 6B 06            [ 1]  103 	ld	(0x06, sp), a
      0081C6 9F               [ 1]  104 	ld	a, xl
      0081C7 14 06            [ 1]  105 	and	a, (0x06, sp)
                                    106 ;	stm8_gpio.c: 50: else if (mode == PIN_INPUT) {
      0081C9 0D 0A            [ 1]  107 	tnz	(0x0a, sp)
      0081CB 26 0C            [ 1]  108 	jrne	00102$
                                    109 ;	stm8_gpio.c: 51: *p->DDR &= ~(1 << pin);   // input
      0081CD 1E 04            [ 2]  110 	ldw	x, (0x04, sp)
      0081CF F7               [ 1]  111 	ld	(x), a
                                    112 ;	stm8_gpio.c: 52: *p->CR1 &= ~(1 << pin);   // floating
      0081D0 1E 02            [ 2]  113 	ldw	x, (0x02, sp)
      0081D2 FE               [ 2]  114 	ldw	x, (x)
      0081D3 F6               [ 1]  115 	ld	a, (x)
      0081D4 14 06            [ 1]  116 	and	a, (0x06, sp)
      0081D6 F7               [ 1]  117 	ld	(x), a
      0081D7 20 0A            [ 2]  118 	jra	00107$
      0081D9                        119 00102$:
                                    120 ;	stm8_gpio.c: 55: *p->DDR &= ~(1 << pin);   // input
      0081D9 1E 04            [ 2]  121 	ldw	x, (0x04, sp)
      0081DB F7               [ 1]  122 	ld	(x), a
                                    123 ;	stm8_gpio.c: 56: *p->CR1 |= (1 << pin);
      0081DC 1E 02            [ 2]  124 	ldw	x, (0x02, sp)
      0081DE FE               [ 2]  125 	ldw	x, (x)
      0081DF F6               [ 1]  126 	ld	a, (x)
      0081E0 1A 01            [ 1]  127 	or	a, (0x01, sp)
      0081E2 F7               [ 1]  128 	ld	(x), a
      0081E3                        129 00107$:
                                    130 ;	stm8_gpio.c: 58: }
      0081E3 1E 07            [ 2]  131 	ldw	x, (7, sp)
      0081E5 5B 0A            [ 2]  132 	addw	sp, #10
      0081E7 FC               [ 2]  133 	jp	(x)
                                    134 ;	stm8_gpio.c: 60: void digitalWrite(Port_t port, uint8_t pin, PinState_t state)
                                    135 ;	-----------------------------------------
                                    136 ;	 function digitalWrite
                                    137 ;	-----------------------------------------
      0081E8                        138 _digitalWrite:
      0081E8 52 02            [ 2]  139 	sub	sp, #2
      0081EA 97               [ 1]  140 	ld	xl, a
                                    141 ;	stm8_gpio.c: 62: GPIO_Port *p = &gpio_ports[port];
      0081EB A6 08            [ 1]  142 	ld	a, #0x08
      0081ED 42               [ 4]  143 	mul	x, a
      0081EE 1C 00 01         [ 2]  144 	addw	x, #(_gpio_ports+0)
                                    145 ;	stm8_gpio.c: 65: *p->ODR |=  (1 << pin);
      0081F1 A6 01            [ 1]  146 	ld	a, #0x01
      0081F3 6B 01            [ 1]  147 	ld	(0x01, sp), a
      0081F5 7B 05            [ 1]  148 	ld	a, (0x05, sp)
      0081F7 27 05            [ 1]  149 	jreq	00114$
      0081F9                        150 00113$:
      0081F9 08 01            [ 1]  151 	sll	(0x01, sp)
      0081FB 4A               [ 1]  152 	dec	a
      0081FC 26 FB            [ 1]  153 	jrne	00113$
      0081FE                        154 00114$:
      0081FE FE               [ 2]  155 	ldw	x, (x)
      0081FF F6               [ 1]  156 	ld	a, (x)
      008200 6B 02            [ 1]  157 	ld	(0x02, sp), a
                                    158 ;	stm8_gpio.c: 64: if (state == HIGH)
      008202 7B 06            [ 1]  159 	ld	a, (0x06, sp)
      008204 4A               [ 1]  160 	dec	a
      008205 26 07            [ 1]  161 	jrne	00102$
                                    162 ;	stm8_gpio.c: 65: *p->ODR |=  (1 << pin);
      008207 7B 02            [ 1]  163 	ld	a, (0x02, sp)
      008209 1A 01            [ 1]  164 	or	a, (0x01, sp)
      00820B F7               [ 1]  165 	ld	(x), a
      00820C 20 06            [ 2]  166 	jra	00104$
      00820E                        167 00102$:
                                    168 ;	stm8_gpio.c: 67: *p->ODR &= ~(1 << pin);
      00820E 7B 01            [ 1]  169 	ld	a, (0x01, sp)
      008210 43               [ 1]  170 	cpl	a
      008211 14 02            [ 1]  171 	and	a, (0x02, sp)
      008213 F7               [ 1]  172 	ld	(x), a
      008214                        173 00104$:
                                    174 ;	stm8_gpio.c: 68: }
      008214 1E 03            [ 2]  175 	ldw	x, (3, sp)
      008216 5B 06            [ 2]  176 	addw	sp, #6
      008218 FC               [ 2]  177 	jp	(x)
                                    178 ;	stm8_gpio.c: 70: void togglePin(Port_t port, uint8_t pin)
                                    179 ;	-----------------------------------------
                                    180 ;	 function togglePin
                                    181 ;	-----------------------------------------
      008219                        182 _togglePin:
      008219 88               [ 1]  183 	push	a
      00821A 97               [ 1]  184 	ld	xl, a
                                    185 ;	stm8_gpio.c: 72: GPIO_Port *p = &gpio_ports[port];
      00821B A6 08            [ 1]  186 	ld	a, #0x08
      00821D 42               [ 4]  187 	mul	x, a
      00821E 1C 00 01         [ 2]  188 	addw	x, #(_gpio_ports+0)
                                    189 ;	stm8_gpio.c: 73: *p->ODR ^= (1 << pin);
      008221 FE               [ 2]  190 	ldw	x, (x)
      008222 F6               [ 1]  191 	ld	a, (x)
      008223 88               [ 1]  192 	push	a
      008224 A6 01            [ 1]  193 	ld	a, #0x01
      008226 6B 02            [ 1]  194 	ld	(0x02, sp), a
      008228 7B 05            [ 1]  195 	ld	a, (0x05, sp)
      00822A 27 05            [ 1]  196 	jreq	00104$
      00822C                        197 00103$:
      00822C 08 02            [ 1]  198 	sll	(0x02, sp)
      00822E 4A               [ 1]  199 	dec	a
      00822F 26 FB            [ 1]  200 	jrne	00103$
      008231                        201 00104$:
      008231 84               [ 1]  202 	pop	a
      008232 18 01            [ 1]  203 	xor	a, (0x01, sp)
      008234 F7               [ 1]  204 	ld	(x), a
                                    205 ;	stm8_gpio.c: 74: }
      008235 84               [ 1]  206 	pop	a
      008236 85               [ 2]  207 	popw	x
      008237 84               [ 1]  208 	pop	a
      008238 FC               [ 2]  209 	jp	(x)
                                    210 ;	stm8_gpio.c: 76: uint8_t digitalRead(Port_t port, uint8_t pin)
                                    211 ;	-----------------------------------------
                                    212 ;	 function digitalRead
                                    213 ;	-----------------------------------------
      008239                        214 _digitalRead:
      008239 52 02            [ 2]  215 	sub	sp, #2
      00823B 97               [ 1]  216 	ld	xl, a
                                    217 ;	stm8_gpio.c: 78: GPIO_Port *p = &gpio_ports[port];
      00823C A6 08            [ 1]  218 	ld	a, #0x08
      00823E 42               [ 4]  219 	mul	x, a
      00823F 1C 00 01         [ 2]  220 	addw	x, #(_gpio_ports+0)
                                    221 ;	stm8_gpio.c: 79: return ((*p->IDR & (1 << pin)) != 0);
      008242 EE 06            [ 2]  222 	ldw	x, (0x6, x)
      008244 F6               [ 1]  223 	ld	a, (x)
      008245 88               [ 1]  224 	push	a
      008246 5F               [ 1]  225 	clrw	x
      008247 5C               [ 1]  226 	incw	x
      008248 7B 06            [ 1]  227 	ld	a, (0x06, sp)
      00824A 27 04            [ 1]  228 	jreq	00104$
      00824C                        229 00103$:
      00824C 58               [ 2]  230 	sllw	x
      00824D 4A               [ 1]  231 	dec	a
      00824E 26 FC            [ 1]  232 	jrne	00103$
      008250                        233 00104$:
      008250 84               [ 1]  234 	pop	a
      008251 6B 02            [ 1]  235 	ld	(0x02, sp), a
      008253 0F 01            [ 1]  236 	clr	(0x01, sp)
      008255 9F               [ 1]  237 	ld	a, xl
      008256 14 02            [ 1]  238 	and	a, (0x02, sp)
      008258 97               [ 1]  239 	ld	xl, a
      008259 4F               [ 1]  240 	clr	a
      00825A 95               [ 1]  241 	ld	xh, a
      00825B 5D               [ 2]  242 	tnzw	x
      00825C 26 02            [ 1]  243 	jrne	00106$
      00825E 4F               [ 1]  244 	clr	a
      00825F C5                     245 	.byte 0xc5
      008260                        246 00106$:
      008260 A6 01            [ 1]  247 	ld	a, #0x01
      008262                        248 00107$:
                                    249 ;	stm8_gpio.c: 80: }
      008262 5B 02            [ 2]  250 	addw	sp, #2
      008264 85               [ 2]  251 	popw	x
      008265 5B 01            [ 2]  252 	addw	sp, #1
      008267 FC               [ 2]  253 	jp	(x)
                                    254 	.area CODE
                                    255 	.area CONST
                                    256 	.area INITIALIZER
      008091                        257 __xinit__gpio_ports:
      008091 50 00                  258 	.dw #0x5000
      008093 50 02                  259 	.dw #0x5002
      008095 50 03                  260 	.dw #0x5003
      008097 50 01                  261 	.dw #0x5001
      008099 50 05                  262 	.dw #0x5005
      00809B 50 07                  263 	.dw #0x5007
      00809D 50 08                  264 	.dw #0x5008
      00809F 50 06                  265 	.dw #0x5006
      0080A1 50 0A                  266 	.dw #0x500a
      0080A3 50 0C                  267 	.dw #0x500c
      0080A5 50 0D                  268 	.dw #0x500d
      0080A7 50 0B                  269 	.dw #0x500b
      0080A9 50 0F                  270 	.dw #0x500f
      0080AB 50 11                  271 	.dw #0x5011
      0080AD 50 12                  272 	.dw #0x5012
      0080AF 50 10                  273 	.dw #0x5010
                                    274 	.area CABS (ABS)
