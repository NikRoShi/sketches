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
                                     11 	.globl _readPin
                                     12 	.globl _writePin
                                     13 	.globl _pinMode
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; Stack segment in internal ram
                                     24 ;--------------------------------------------------------
                                     25 	.area SSEG
      000007                         26 __start__stack:
      000007                         27 	.ds	1
                                     28 
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 
                                     34 ; default segment ordering for linker
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area CONST
                                     39 	.area INITIALIZER
                                     40 	.area CODE
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; interrupt vector
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
      008000                         46 __interrupt_vect:
      008000 82 00 80 07             47 	int s_GSINIT ; reset
                                     48 ;--------------------------------------------------------
                                     49 ; global & static initialisations
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area GSINIT
                                     53 	.area GSFINAL
                                     54 	.area GSINIT
      008007 CD 84 A1         [ 4]   55 	call	___sdcc_external_startup
      00800A 4D               [ 1]   56 	tnz	a
      00800B 27 03            [ 1]   57 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   58 	jp	__sdcc_program_startup
      008010                         59 __sdcc_init_data:
                                     60 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   61 	ldw x, #l_DATA
      008013 27 07            [ 1]   62 	jreq	00002$
      008015                         63 00001$:
      008015 72 4F 00 00      [ 1]   64 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   65 	decw x
      00801A 26 F9            [ 1]   66 	jrne	00001$
      00801C                         67 00002$:
      00801C AE 00 06         [ 2]   68 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   69 	jreq	00004$
      008021                         70 00003$:
      008021 D6 80 2C         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   72 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   73 	decw	x
      008028 26 F7            [ 1]   74 	jrne	00003$
      00802A                         75 00004$:
                                     76 ; stm8_genXINIT() end
                                     77 	.area GSFINAL
      00802A CC 80 04         [ 2]   78 	jp	__sdcc_program_startup
                                     79 ;--------------------------------------------------------
                                     80 ; Home
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area HOME
      008004                         84 __sdcc_program_startup:
      008004 CC 80 33         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 5: void main(void) {
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008033                         95 _main:
                                     96 ;	main.c: 7: CLK_CKDIVR = 0;
      008033 35 00 50 C6      [ 1]   97 	mov	0x50c6+0, #0x00
                                     98 ;	main.c: 9: pinMode(PORTA, 1, INPUT_PULLUP);
      008037 4B 03            [ 1]   99 	push	#0x03
      008039 A6 01            [ 1]  100 	ld	a, #0x01
      00803B AE 50 00         [ 2]  101 	ldw	x, #0x5000
      00803E CD 80 FA         [ 4]  102 	call	_pinMode
                                    103 ;	main.c: 10: pinMode(PORTD, 3, OUTPUT);
      008041 4B 00            [ 1]  104 	push	#0x00
      008043 A6 03            [ 1]  105 	ld	a, #0x03
      008045 AE 50 0F         [ 2]  106 	ldw	x, #0x500f
      008048 CD 80 FA         [ 4]  107 	call	_pinMode
                                    108 ;	main.c: 11: while(1) {
      00804B                        109 00105$:
                                    110 ;	main.c: 12: if (readPin(PORTA, 1) == 0) {
      00804B A6 01            [ 1]  111 	ld	a, #0x01
      00804D AE 50 00         [ 2]  112 	ldw	x, #0x5000
      008050 CD 81 BE         [ 4]  113 	call	_readPin
      008053 4D               [ 1]  114 	tnz	a
      008054 26 0C            [ 1]  115 	jrne	00102$
                                    116 ;	main.c: 13: writePin(PORTD, 3, HIGH);
      008056 4B 01            [ 1]  117 	push	#0x01
      008058 A6 03            [ 1]  118 	ld	a, #0x03
      00805A AE 50 0F         [ 2]  119 	ldw	x, #0x500f
      00805D CD 81 74         [ 4]  120 	call	_writePin
      008060 20 E9            [ 2]  121 	jra	00105$
      008062                        122 00102$:
                                    123 ;	main.c: 15: else writePin(PORTD, 3, LOW);
      008062 4B 00            [ 1]  124 	push	#0x00
      008064 A6 03            [ 1]  125 	ld	a, #0x03
      008066 AE 50 0F         [ 2]  126 	ldw	x, #0x500f
      008069 CD 81 74         [ 4]  127 	call	_writePin
      00806C 20 DD            [ 2]  128 	jra	00105$
                                    129 ;	main.c: 17: }
      00806E 81               [ 4]  130 	ret
                                    131 	.area CODE
                                    132 	.area CONST
                                    133 	.area INITIALIZER
                                    134 	.area CABS (ABS)
