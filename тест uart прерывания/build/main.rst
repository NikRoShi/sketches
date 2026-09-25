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
                                     12 	.globl _UART1_RX_IRQHandler
                                     13 	.globl _writePin
                                     14 	.globl _pinMode
                                     15 	.globl _getData_UART
                                     16 	.globl _init_UART
                                     17 	.globl _key
                                     18 	.globl _ledFlag
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
      00000C                         27 _ledFlag::
      00000C                         28 	.ds 1
      00000D                         29 _key::
      00000D                         30 	.ds 1
                                     31 ;--------------------------------------------------------
                                     32 ; Stack segment in internal ram
                                     33 ;--------------------------------------------------------
                                     34 	.area	SSEG
      000016                         35 __start__stack:
      000016                         36 	.ds	1
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
      008000 82 00 80 57             56 	int s_GSINIT ; reset
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
      008050 82 00 80 90             76 	int _UART1_RX_IRQHandler ; int18
                                     77 ;--------------------------------------------------------
                                     78 ; global & static initialisations
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area GSINIT
                                     82 	.area GSFINAL
                                     83 	.area GSINIT
      008057                         84 __sdcc_init_data:
                                     85 ; stm8_genXINIT() start
      008057 AE 00 0B         [ 2]   86 	ldw x, #l_DATA
      00805A 27 07            [ 1]   87 	jreq	00002$
      00805C                         88 00001$:
      00805C 72 4F 00 00      [ 1]   89 	clr (s_DATA - 1, x)
      008060 5A               [ 2]   90 	decw x
      008061 26 F9            [ 1]   91 	jrne	00001$
      008063                         92 00002$:
      008063 AE 00 0A         [ 2]   93 	ldw	x, #l_INITIALIZER
      008066 27 09            [ 1]   94 	jreq	00004$
      008068                         95 00003$:
      008068 D6 80 85         [ 1]   96 	ld	a, (s_INITIALIZER - 1, x)
      00806B D7 00 0B         [ 1]   97 	ld	(s_INITIALIZED - 1, x), a
      00806E 5A               [ 2]   98 	decw	x
      00806F 26 F7            [ 1]   99 	jrne	00003$
      008071                        100 00004$:
                                    101 ; stm8_genXINIT() end
                                    102 	.area GSFINAL
      008071 CC 80 54         [ 2]  103 	jp	__sdcc_program_startup
                                    104 ;--------------------------------------------------------
                                    105 ; Home
                                    106 ;--------------------------------------------------------
                                    107 	.area HOME
                                    108 	.area HOME
      008054                        109 __sdcc_program_startup:
      008054 CC 80 BA         [ 2]  110 	jp	_main
                                    111 ;	return from main will return to caller
                                    112 ;--------------------------------------------------------
                                    113 ; code
                                    114 ;--------------------------------------------------------
                                    115 	.area CODE
                                    116 ;	main.c: 9: void UART1_RX_IRQHandler(void) __interrupt(IRQ_UART1_RX) {
                                    117 ;	-----------------------------------------
                                    118 ;	 function UART1_RX_IRQHandler
                                    119 ;	-----------------------------------------
      008090                        120 _UART1_RX_IRQHandler:
      008090 4F               [ 1]  121 	clr	a
      008091 62               [ 2]  122 	div	x, a
                                    123 ;	main.c: 11: key = getData_UART();
      008092 CD 8A CA         [ 4]  124 	call	_getData_UART
                                    125 ;	main.c: 13: if (key == 's' || key == 'S') ledFlag = 0;
      008095 C7 00 0D         [ 1]  126 	ld	_key+0, a
      008098 A1 73            [ 1]  127 	cp	a, #0x73
      00809A 27 07            [ 1]  128 	jreq	00101$
      00809C C6 00 0D         [ 1]  129 	ld	a, _key+0
      00809F A1 53            [ 1]  130 	cp	a, #0x53
      0080A1 26 04            [ 1]  131 	jrne	00102$
      0080A3                        132 00101$:
      0080A3 72 5F 00 0C      [ 1]  133 	clr	_ledFlag+0
      0080A7                        134 00102$:
                                    135 ;	main.c: 14: if (key == 'r' || key == 'R') ledFlag = 1;
      0080A7 C6 00 0D         [ 1]  136 	ld	a, _key+0
      0080AA A1 72            [ 1]  137 	cp	a, #0x72
      0080AC 27 07            [ 1]  138 	jreq	00104$
      0080AE C6 00 0D         [ 1]  139 	ld	a, _key+0
      0080B1 A1 52            [ 1]  140 	cp	a, #0x52
      0080B3 26 04            [ 1]  141 	jrne	00107$
      0080B5                        142 00104$:
      0080B5 35 01 00 0C      [ 1]  143 	mov	_ledFlag+0, #0x01
      0080B9                        144 00107$:
                                    145 ;	main.c: 15: }
      0080B9 80               [11]  146 	iret
                                    147 ;	main.c: 17: int main(void)
                                    148 ;	-----------------------------------------
                                    149 ;	 function main
                                    150 ;	-----------------------------------------
      0080BA                        151 _main:
                                    152 ;	main.c: 19: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      0080BA 35 00 50 C6      [ 1]  153 	mov	0x50c6+0, #0x00
                                    154 ;	main.c: 21: pinMode(PB, 5, OUTPUT);
      0080BE 4B 00            [ 1]  155 	push	#0x00
      0080C0 A6 05            [ 1]  156 	ld	a, #0x05
      0080C2 AE 50 05         [ 2]  157 	ldw	x, #0x5005
      0080C5 CD 82 BC         [ 4]  158 	call	_pinMode
                                    159 ;	main.c: 23: init_UART(9600, ENABLE);
      0080C8 A6 01            [ 1]  160 	ld	a, #0x01
      0080CA AE 25 80         [ 2]  161 	ldw	x, #0x2580
      0080CD CD 89 9D         [ 4]  162 	call	_init_UART
                                    163 ;	main.c: 24: enableInterrupts();
      0080D0 9A               [ 1]  164 	rim
                                    165 ;	main.c: 26: while (1)
      0080D1                        166 00105$:
                                    167 ;	main.c: 28: if (ledFlag) writePin(PB, 5, HIGH);
      0080D1 C6 00 0C         [ 1]  168 	ld	a, _ledFlag+0
      0080D4 27 0C            [ 1]  169 	jreq	00102$
      0080D6 4B 01            [ 1]  170 	push	#0x01
      0080D8 A6 05            [ 1]  171 	ld	a, #0x05
      0080DA AE 50 05         [ 2]  172 	ldw	x, #0x5005
      0080DD CD 83 4A         [ 4]  173 	call	_writePin
      0080E0 20 EF            [ 2]  174 	jra	00105$
      0080E2                        175 00102$:
                                    176 ;	main.c: 29: else writePin(PB, 5, LOW);
      0080E2 4B 00            [ 1]  177 	push	#0x00
      0080E4 A6 05            [ 1]  178 	ld	a, #0x05
      0080E6 AE 50 05         [ 2]  179 	ldw	x, #0x5005
      0080E9 CD 83 4A         [ 4]  180 	call	_writePin
      0080EC 20 E3            [ 2]  181 	jra	00105$
                                    182 ;	main.c: 31: }
      0080EE 81               [ 4]  183 	ret
                                    184 	.area CODE
                                    185 	.area CONST
                                    186 	.area INITIALIZER
      008086                        187 __xinit__ledFlag:
      008086 01                     188 	.db #0x01	; 1
      008087                        189 __xinit__key:
      008087 72                     190 	.db #0x72	; 114	'r'
                                    191 	.area CABS (ABS)
