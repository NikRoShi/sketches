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
                                     12 	.globl _sendLine_UART
                                     13 	.globl _sendByte_UART
                                     14 	.globl _init_UART
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; Stack segment in internal ram
                                     25 ;--------------------------------------------------------
                                     26 	.area	SSEG
      000007                         27 __start__stack:
      000007                         28 	.ds	1
                                     29 
                                     30 ;--------------------------------------------------------
                                     31 ; absolute external ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area DABS (ABS)
                                     34 
                                     35 ; default segment ordering for linker
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area CONST
                                     40 	.area INITIALIZER
                                     41 	.area CODE
                                     42 
                                     43 ;--------------------------------------------------------
                                     44 ; interrupt vector
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
      008000                         47 __interrupt_vect:
      008000 82 00 80 07             48 	int s_GSINIT ; reset
                                     49 ;--------------------------------------------------------
                                     50 ; global & static initialisations
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area GSINIT
      008007                         56 __sdcc_init_data:
                                     57 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   58 	ldw x, #l_DATA
      00800A 27 07            [ 1]   59 	jreq	00002$
      00800C                         60 00001$:
      00800C 72 4F 00 00      [ 1]   61 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   62 	decw x
      008011 26 F9            [ 1]   63 	jrne	00001$
      008013                         64 00002$:
      008013 AE 00 06         [ 2]   65 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   66 	jreq	00004$
      008018                         67 00003$:
      008018 D6 80 23         [ 1]   68 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   69 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   70 	decw	x
      00801F 26 F7            [ 1]   71 	jrne	00003$
      008021                         72 00004$:
                                     73 ; stm8_genXINIT() end
                                     74 	.area GSFINAL
      008021 CC 80 04         [ 2]   75 	jp	__sdcc_program_startup
                                     76 ;--------------------------------------------------------
                                     77 ; Home
                                     78 ;--------------------------------------------------------
                                     79 	.area HOME
                                     80 	.area HOME
      008004                         81 __sdcc_program_startup:
      008004 CC 80 2A         [ 2]   82 	jp	_main
                                     83 ;	return from main will return to caller
                                     84 ;--------------------------------------------------------
                                     85 ; code
                                     86 ;--------------------------------------------------------
                                     87 	.area CODE
                                     88 ;	main.c: 5: void main(void) {
                                     89 ;	-----------------------------------------
                                     90 ;	 function main
                                     91 ;	-----------------------------------------
      00802A                         92 _main:
                                     93 ;	main.c: 7: CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
      00802A 35 00 50 C6      [ 1]   94 	mov	0x50c6+0, #0x00
                                     95 ;	main.c: 9: init_UART(9600);	// 2. Инициализируем периферию
      00802E 4B 80            [ 1]   96 	push	#0x80
      008030 4B 25            [ 1]   97 	push	#0x25
      008032 5F               [ 1]   98 	clrw	x
      008033 89               [ 2]   99 	pushw	x
      008034 CD 84 AC         [ 4]  100 	call	_init_UART
                                    101 ;	main.c: 11: for (uint8_t i = 32; i < 128; i++)
      008037 A6 20            [ 1]  102 	ld	a, #0x20
      008039                        103 00106$:
      008039 A1 80            [ 1]  104 	cp	a, #0x80
      00803B 24 08            [ 1]  105 	jrnc	00101$
                                    106 ;	main.c: 13: sendByte_UART(i);
      00803D 88               [ 1]  107 	push	a
      00803E CD 84 FF         [ 4]  108 	call	_sendByte_UART
      008041 84               [ 1]  109 	pop	a
                                    110 ;	main.c: 11: for (uint8_t i = 32; i < 128; i++)
      008042 4C               [ 1]  111 	inc	a
      008043 20 F4            [ 2]  112 	jra	00106$
      008045                        113 00101$:
                                    114 ;	main.c: 15: sendLine_UART();
      008045 CD 85 1C         [ 4]  115 	call	_sendLine_UART
                                    116 ;	main.c: 17: while(1)
      008048                        117 00103$:
      008048 20 FE            [ 2]  118 	jra	00103$
                                    119 ;	main.c: 21: }
      00804A 81               [ 4]  120 	ret
                                    121 	.area CODE
                                    122 	.area CONST
                                    123 	.area INITIALIZER
                                    124 	.area CABS (ABS)
