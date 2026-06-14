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
                                     12 	.globl _ping_I2C
                                     13 	.globl _init_I2C
                                     14 	.globl _writePin
                                     15 	.globl _pinMode
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; Stack segment in internal ram
                                     26 ;--------------------------------------------------------
                                     27 	.area	SSEG
      000007                         28 __start__stack:
      000007                         29 	.ds	1
                                     30 
                                     31 ;--------------------------------------------------------
                                     32 ; absolute external ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DABS (ABS)
                                     35 
                                     36 ; default segment ordering for linker
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area CONST
                                     41 	.area INITIALIZER
                                     42 	.area CODE
                                     43 
                                     44 ;--------------------------------------------------------
                                     45 ; interrupt vector
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
      008000                         48 __interrupt_vect:
      008000 82 00 80 07             49 	int s_GSINIT ; reset
                                     50 ;--------------------------------------------------------
                                     51 ; global & static initialisations
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
                                     54 	.area GSINIT
                                     55 	.area GSFINAL
                                     56 	.area GSINIT
      008007                         57 __sdcc_init_data:
                                     58 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   59 	ldw x, #l_DATA
      00800A 27 07            [ 1]   60 	jreq	00002$
      00800C                         61 00001$:
      00800C 72 4F 00 00      [ 1]   62 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   63 	decw x
      008011 26 F9            [ 1]   64 	jrne	00001$
      008013                         65 00002$:
      008013 AE 00 06         [ 2]   66 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   67 	jreq	00004$
      008018                         68 00003$:
      008018 D6 80 23         [ 1]   69 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   70 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   71 	decw	x
      00801F 26 F7            [ 1]   72 	jrne	00003$
      008021                         73 00004$:
                                     74 ; stm8_genXINIT() end
                                     75 	.area GSFINAL
      008021 CC 80 04         [ 2]   76 	jp	__sdcc_program_startup
                                     77 ;--------------------------------------------------------
                                     78 ; Home
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area HOME
      008004                         82 __sdcc_program_startup:
      008004 CC 80 2A         [ 2]   83 	jp	_main
                                     84 ;	return from main will return to caller
                                     85 ;--------------------------------------------------------
                                     86 ; code
                                     87 ;--------------------------------------------------------
                                     88 	.area CODE
                                     89 ;	main.c: 6: int main(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function main
                                     92 ;	-----------------------------------------
      00802A                         93 _main:
                                     94 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00802A 35 00 50 C6      [ 1]   95 	mov	0x50c6+0, #0x00
                                     96 ;	main.c: 10: pinMode(PORTC, 3, OUTPUT);
      00802E 4B 00            [ 1]   97 	push	#0x00
      008030 A6 03            [ 1]   98 	ld	a, #0x03
      008032 AE 50 0A         [ 2]   99 	ldw	x, #0x500a
      008035 CD 80 F1         [ 4]  100 	call	_pinMode
                                    101 ;	main.c: 12: init_I2C();
      008038 CD 81 F6         [ 4]  102 	call	_init_I2C
                                    103 ;	main.c: 14: if (ping_I2C(0x3F)) writePin(PORTC, 3, HIGH);
      00803B A6 3F            [ 1]  104 	ld	a, #0x3f
      00803D CD 82 0F         [ 4]  105 	call	_ping_I2C
      008040 4D               [ 1]  106 	tnz	a
      008041 27 0C            [ 1]  107 	jreq	00102$
      008043 4B 01            [ 1]  108 	push	#0x01
      008045 A6 03            [ 1]  109 	ld	a, #0x03
      008047 AE 50 0A         [ 2]  110 	ldw	x, #0x500a
      00804A CD 81 7F         [ 4]  111 	call	_writePin
      00804D 20 0A            [ 2]  112 	jra	00105$
      00804F                        113 00102$:
                                    114 ;	main.c: 15: else writePin(PORTC, 3, LOW);
      00804F 4B 00            [ 1]  115 	push	#0x00
      008051 A6 03            [ 1]  116 	ld	a, #0x03
      008053 AE 50 0A         [ 2]  117 	ldw	x, #0x500a
      008056 CD 81 7F         [ 4]  118 	call	_writePin
                                    119 ;	main.c: 17: while (1)
      008059                        120 00105$:
      008059 20 FE            [ 2]  121 	jra	00105$
                                    122 ;	main.c: 21: }
      00805B 81               [ 4]  123 	ret
                                    124 	.area CODE
                                    125 	.area CONST
                                    126 	.area INITIALIZER
                                    127 	.area CABS (ABS)
