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
                                     12 	.globl _stop_I2C
                                     13 	.globl _readNack_I2C
                                     14 	.globl _readAck_I2C
                                     15 	.globl _write_I2C
                                     16 	.globl _sendAddress_I2C
                                     17 	.globl _start_I2C
                                     18 	.globl _init_I2C
                                     19 	.globl _sendInt_UART
                                     20 	.globl _sendLine_UART
                                     21 	.globl _sendString_UART
                                     22 	.globl _init_UART
                                     23 	.globl _delay
                                     24 	.globl _init_TIME
                                     25 	.globl _tick_TIME
                                     26 	.globl _pinMode
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area INITIALIZED
                                     35 ;--------------------------------------------------------
                                     36 ; Stack segment in internal ram
                                     37 ;--------------------------------------------------------
                                     38 	.area SSEG
      000007                         39 __start__stack:
      000007                         40 	.ds	1
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; absolute external ram data
                                     44 ;--------------------------------------------------------
                                     45 	.area DABS (ABS)
                                     46 
                                     47 ; default segment ordering for linker
                                     48 	.area HOME
                                     49 	.area GSINIT
                                     50 	.area GSFINAL
                                     51 	.area CONST
                                     52 	.area INITIALIZER
                                     53 	.area CODE
                                     54 
                                     55 ;--------------------------------------------------------
                                     56 ; interrupt vector
                                     57 ;--------------------------------------------------------
                                     58 	.area HOME
      008000                         59 __interrupt_vect:
      008000 82 00 80 6B             60 	int s_GSINIT ; reset
      008004 82 00 00 00             61 	int 0x000000 ; trap
      008008 82 00 00 00             62 	int 0x000000 ; int0
      00800C 82 00 00 00             63 	int 0x000000 ; int1
      008010 82 00 00 00             64 	int 0x000000 ; int2
      008014 82 00 00 00             65 	int 0x000000 ; int3
      008018 82 00 00 00             66 	int 0x000000 ; int4
      00801C 82 00 00 00             67 	int 0x000000 ; int5
      008020 82 00 00 00             68 	int 0x000000 ; int6
      008024 82 00 00 00             69 	int 0x000000 ; int7
      008028 82 00 00 00             70 	int 0x000000 ; int8
      00802C 82 00 00 00             71 	int 0x000000 ; int9
      008030 82 00 00 00             72 	int 0x000000 ; int10
      008034 82 00 00 00             73 	int 0x000000 ; int11
      008038 82 00 00 00             74 	int 0x000000 ; int12
      00803C 82 00 00 00             75 	int 0x000000 ; int13
      008040 82 00 00 00             76 	int 0x000000 ; int14
      008044 82 00 00 00             77 	int 0x000000 ; int15
      008048 82 00 00 00             78 	int 0x000000 ; int16
      00804C 82 00 00 00             79 	int 0x000000 ; int17
      008050 82 00 00 00             80 	int 0x000000 ; int18
      008054 82 00 00 00             81 	int 0x000000 ; int19
      008058 82 00 00 00             82 	int 0x000000 ; int20
      00805C 82 00 00 00             83 	int 0x000000 ; int21
      008060 82 00 00 00             84 	int 0x000000 ; int22
      008064 82 00 80 B7             85 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     86 ;--------------------------------------------------------
                                     87 ; global & static initialisations
                                     88 ;--------------------------------------------------------
                                     89 	.area HOME
                                     90 	.area GSINIT
                                     91 	.area GSFINAL
                                     92 	.area GSINIT
      00806B CD 86 E4         [ 4]   93 	call	___sdcc_external_startup
      00806E 4D               [ 1]   94 	tnz	a
      00806F 27 03            [ 1]   95 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   96 	jp	__sdcc_program_startup
      008074                         97 __sdcc_init_data:
                                     98 ; stm8_genXINIT() start
      008074 AE 00 00         [ 2]   99 	ldw x, #l_DATA
      008077 27 07            [ 1]  100 	jreq	00002$
      008079                        101 00001$:
      008079 72 4F 00 00      [ 1]  102 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]  103 	decw x
      00807E 26 F9            [ 1]  104 	jrne	00001$
      008080                        105 00002$:
      008080 AE 00 06         [ 2]  106 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]  107 	jreq	00004$
      008085                        108 00003$:
      008085 D6 80 B0         [ 1]  109 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 00         [ 1]  110 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  111 	decw	x
      00808C 26 F7            [ 1]  112 	jrne	00003$
      00808E                        113 00004$:
                                    114 ; stm8_genXINIT() end
                                    115 	.area GSFINAL
      00808E CC 80 68         [ 2]  116 	jp	__sdcc_program_startup
                                    117 ;--------------------------------------------------------
                                    118 ; Home
                                    119 ;--------------------------------------------------------
                                    120 	.area HOME
                                    121 	.area HOME
      008068                        122 __sdcc_program_startup:
      008068 CC 80 C1         [ 2]  123 	jp	_main
                                    124 ;	return from main will return to caller
                                    125 ;--------------------------------------------------------
                                    126 ; code
                                    127 ;--------------------------------------------------------
                                    128 	.area CODE
                                    129 ;	main.c: 8: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function TIM4_UPD_OVF_IRQHandler
                                    132 ;	-----------------------------------------
      0080B7                        133 _TIM4_UPD_OVF_IRQHandler:
      0080B7 4F               [ 1]  134 	clr	a
      0080B8 62               [ 2]  135 	div	x, a
                                    136 ;	main.c: 9: TIM4_SR &= ~(1 << 0);
      0080B9 72 11 53 44      [ 1]  137 	bres	0x5344, #0
                                    138 ;	main.c: 10: tick_TIME();
      0080BD CD 84 EF         [ 4]  139 	call	_tick_TIME
                                    140 ;	main.c: 11: }
      0080C0 80               [11]  141 	iret
                                    142 ;	main.c: 13: void main(void) {
                                    143 ;	-----------------------------------------
                                    144 ;	 function main
                                    145 ;	-----------------------------------------
      0080C1                        146 _main:
      0080C1 52 0B            [ 2]  147 	sub	sp, #11
                                    148 ;	main.c: 14: CLK_CKDIVR = 0;
      0080C3 35 00 50 C6      [ 1]  149 	mov	0x50c6+0, #0x00
                                    150 ;	main.c: 15: init_TIME();
      0080C7 CD 85 03         [ 4]  151 	call	_init_TIME
                                    152 ;	main.c: 16: init_UART(9600);
      0080CA 4B 80            [ 1]  153 	push	#0x80
      0080CC 4B 25            [ 1]  154 	push	#0x25
      0080CE 5F               [ 1]  155 	clrw	x
      0080CF 89               [ 2]  156 	pushw	x
      0080D0 CD 85 A0         [ 4]  157 	call	_init_UART
                                    158 ;	main.c: 17: init_I2C();
      0080D3 CD 83 31         [ 4]  159 	call	_init_I2C
                                    160 ;	main.c: 18: enableInterrupts();
      0080D6 9A               [ 1]  161 	rim
                                    162 ;	main.c: 21: pinMode(PORTD, 5, OUTPUT);
      0080D7 4B 00            [ 1]  163 	push	#0x00
      0080D9 A6 05            [ 1]  164 	ld	a, #0x05
      0080DB AE 50 0F         [ 2]  165 	ldw	x, #0x500f
      0080DE CD 82 2D         [ 4]  166 	call	_pinMode
                                    167 ;	main.c: 24: pinMode(PORTB, 4, OUTPUT_OD);
      0080E1 4B 04            [ 1]  168 	push	#0x04
      0080E3 A6 04            [ 1]  169 	ld	a, #0x04
      0080E5 AE 50 05         [ 2]  170 	ldw	x, #0x5005
      0080E8 CD 82 2D         [ 4]  171 	call	_pinMode
                                    172 ;	main.c: 25: pinMode(PORTB, 5, OUTPUT_OD);
      0080EB 4B 04            [ 1]  173 	push	#0x04
      0080ED A6 05            [ 1]  174 	ld	a, #0x05
      0080EF AE 50 05         [ 2]  175 	ldw	x, #0x5005
      0080F2 CD 82 2D         [ 4]  176 	call	_pinMode
                                    177 ;	main.c: 29: if (start_I2C() && sendAddress_I2C(0xEC)) {
      0080F5 CD 83 4E         [ 4]  178 	call	_start_I2C
      0080F8 4D               [ 1]  179 	tnz	a
      0080F9 27 1B            [ 1]  180 	jreq	00108$
      0080FB A6 EC            [ 1]  181 	ld	a, #0xec
      0080FD CD 83 65         [ 4]  182 	call	_sendAddress_I2C
      008100 4D               [ 1]  183 	tnz	a
      008101 27 13            [ 1]  184 	jreq	00108$
                                    185 ;	main.c: 30: write_I2C(0xF4); // Регистр ctrl_meas
      008103 A6 F4            [ 1]  186 	ld	a, #0xf4
      008105 CD 83 81         [ 4]  187 	call	_write_I2C
                                    188 ;	main.c: 31: write_I2C(0x2E); // Значение настроек
      008108 A6 2E            [ 1]  189 	ld	a, #0x2e
      00810A CD 83 81         [ 4]  190 	call	_write_I2C
                                    191 ;	main.c: 32: stop_I2C();
      00810D CD 83 B5         [ 4]  192 	call	_stop_I2C
                                    193 ;	main.c: 33: sendString_UART("Sensor Configured!\r\n");
      008110 AE 80 91         [ 2]  194 	ldw	x, #(___str_0+0)
      008113 CD 85 FF         [ 4]  195 	call	_sendString_UART
                                    196 ;	main.c: 36: while(1) {
      008116                        197 00108$:
                                    198 ;	main.c: 37: if (start_I2C() && sendAddress_I2C(0xEC)) {
      008116 CD 83 4E         [ 4]  199 	call	_start_I2C
      008119 4D               [ 1]  200 	tnz	a
      00811A 27 7A            [ 1]  201 	jreq	00105$
      00811C A6 EC            [ 1]  202 	ld	a, #0xec
      00811E CD 83 65         [ 4]  203 	call	_sendAddress_I2C
      008121 4D               [ 1]  204 	tnz	a
      008122 27 72            [ 1]  205 	jreq	00105$
                                    206 ;	main.c: 38: write_I2C(0xFA); // Начальный регистр температуры
      008124 A6 FA            [ 1]  207 	ld	a, #0xfa
      008126 CD 83 81         [ 4]  208 	call	_write_I2C
                                    209 ;	main.c: 40: start_I2C();     // Restart
      008129 CD 83 4E         [ 4]  210 	call	_start_I2C
                                    211 ;	main.c: 41: sendAddress_I2C(0xED); // Переходим на чтение
      00812C A6 ED            [ 1]  212 	ld	a, #0xed
      00812E CD 83 65         [ 4]  213 	call	_sendAddress_I2C
                                    214 ;	main.c: 44: uint32_t msb  = readAck_I2C();
      008131 CD 83 97         [ 4]  215 	call	_readAck_I2C
      008134 6B 03            [ 1]  216 	ld	(0x03, sp), a
      008136 0F 02            [ 1]  217 	clr	(0x02, sp)
                                    218 ;	main.c: 45: uint32_t lsb  = readAck_I2C();
      008138 CD 83 97         [ 4]  219 	call	_readAck_I2C
      00813B 6B 05            [ 1]  220 	ld	(0x05, sp), a
      00813D 0F 04            [ 1]  221 	clr	(0x04, sp)
                                    222 ;	main.c: 46: uint32_t xlsb = readNack_I2C(); 
      00813F CD 83 A4         [ 4]  223 	call	_readNack_I2C
      008142 6B 09            [ 1]  224 	ld	(0x09, sp), a
      008144 90 5F            [ 1]  225 	clrw	y
      008146 0F 06            [ 1]  226 	clr	(0x06, sp)
                                    227 ;	main.c: 50: uint32_t raw_temp = (msb << 12) | (lsb << 4) | (xlsb >> 4);
      008148 7B 03            [ 1]  228 	ld	a, (0x03, sp)
      00814A 6B 0A            [ 1]  229 	ld	(0x0a, sp), a
      00814C 0F 0B            [ 1]  230 	clr	(0x0b, sp)
      00814E 08 0B            [ 1]  231 	sll	(0x0b, sp)
      008150 09 0A            [ 1]  232 	rlc	(0x0a, sp)
      008152 08 0B            [ 1]  233 	sll	(0x0b, sp)
      008154 09 0A            [ 1]  234 	rlc	(0x0a, sp)
      008156 08 0B            [ 1]  235 	sll	(0x0b, sp)
      008158 09 0A            [ 1]  236 	rlc	(0x0a, sp)
      00815A 08 0B            [ 1]  237 	sll	(0x0b, sp)
      00815C 09 0A            [ 1]  238 	rlc	(0x0a, sp)
      00815E 1E 04            [ 2]  239 	ldw	x, (0x04, sp)
      008160 58               [ 2]  240 	sllw	x
      008161 58               [ 2]  241 	sllw	x
      008162 58               [ 2]  242 	sllw	x
      008163 58               [ 2]  243 	sllw	x
      008164 9E               [ 1]  244 	ld	a, xh
      008165 1A 0A            [ 1]  245 	or	a, (0x0a, sp)
      008167 95               [ 1]  246 	ld	xh, a
      008168 0F 01            [ 1]  247 	clr	(0x01, sp)
      00816A 90 5E            [ 1]  248 	swapw	y
      00816C 7B 09            [ 1]  249 	ld	a, (0x09, sp)
      00816E 04 01            [ 1]  250 	srl	(0x01, sp)
      008170 90 56            [ 2]  251 	rrcw	y
      008172 46               [ 1]  252 	rrc	a
      008173 04 01            [ 1]  253 	srl	(0x01, sp)
      008175 90 56            [ 2]  254 	rrcw	y
      008177 46               [ 1]  255 	rrc	a
      008178 04 01            [ 1]  256 	srl	(0x01, sp)
      00817A 90 56            [ 2]  257 	rrcw	y
      00817C 46               [ 1]  258 	rrc	a
      00817D 04 01            [ 1]  259 	srl	(0x01, sp)
      00817F 90 56            [ 2]  260 	rrcw	y
      008181 46               [ 1]  261 	rrc	a
      008182 6B 0B            [ 1]  262 	ld	(0x0b, sp), a
      008184 9F               [ 1]  263 	ld	a, xl
      008185 1A 0B            [ 1]  264 	or	a, (0x0b, sp)
      008187 97               [ 1]  265 	ld	xl, a
                                    266 ;	main.c: 52: sendString_UART("Raw Temp: ");
      008188 89               [ 2]  267 	pushw	x
      008189 AE 80 A6         [ 2]  268 	ldw	x, #(___str_1+0)
      00818C CD 85 FF         [ 4]  269 	call	_sendString_UART
      00818F 85               [ 2]  270 	popw	x
                                    271 ;	main.c: 53: sendInt_UART(raw_temp); 
      008190 CD 86 16         [ 4]  272 	call	_sendInt_UART
                                    273 ;	main.c: 54: sendLine_UART();
      008193 CD 86 0C         [ 4]  274 	call	_sendLine_UART
      008196                        275 00105$:
                                    276 ;	main.c: 57: delay(500); // Пауза полсекунды
      008196 4B F4            [ 1]  277 	push	#0xf4
      008198 4B 01            [ 1]  278 	push	#0x01
      00819A 5F               [ 1]  279 	clrw	x
      00819B 89               [ 2]  280 	pushw	x
      00819C CD 85 6C         [ 4]  281 	call	_delay
                                    282 ;	main.c: 59: }
      00819F CC 81 16         [ 2]  283 	jp	00108$
                                    284 	.area CODE
                                    285 	.area CONST
                                    286 	.area CONST
      008091                        287 ___str_0:
      008091 53 65 6E 73 6F 72 20   288 	.ascii "Sensor Configured!"
             43 6F 6E 66 69 67 75
             72 65 64 21
      0080A3 0D                     289 	.db 0x0d
      0080A4 0A                     290 	.db 0x0a
      0080A5 00                     291 	.db 0x00
                                    292 	.area CODE
                                    293 	.area CONST
      0080A6                        294 ___str_1:
      0080A6 52 61 77 20 54 65 6D   295 	.ascii "Raw Temp: "
             70 3A 20
      0080B0 00                     296 	.db 0x00
                                    297 	.area CODE
                                    298 	.area INITIALIZER
                                    299 	.area CABS (ABS)
