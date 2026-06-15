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
                                     12 	.globl _sendHex_UART
                                     13 	.globl _sendLine_UART
                                     14 	.globl _sendString_UART
                                     15 	.globl _init_UART
                                     16 	.globl _ping_I2C
                                     17 	.globl _init_I2C
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; Stack segment in internal ram
                                     28 ;--------------------------------------------------------
                                     29 	.area	SSEG
      000007                         30 __start__stack:
      000007                         31 	.ds	1
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 
                                     38 ; default segment ordering for linker
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area CONST
                                     43 	.area INITIALIZER
                                     44 	.area CODE
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; interrupt vector
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
      008000                         50 __interrupt_vect:
      008000 82 00 80 07             51 	int s_GSINIT ; reset
                                     52 ;--------------------------------------------------------
                                     53 ; global & static initialisations
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area GSINIT
      008007                         59 __sdcc_init_data:
                                     60 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   61 	ldw x, #l_DATA
      00800A 27 07            [ 1]   62 	jreq	00002$
      00800C                         63 00001$:
      00800C 72 4F 00 00      [ 1]   64 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   65 	decw x
      008011 26 F9            [ 1]   66 	jrne	00001$
      008013                         67 00002$:
      008013 AE 00 06         [ 2]   68 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   69 	jreq	00004$
      008018                         70 00003$:
      008018 D6 80 51         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   72 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   73 	decw	x
      00801F 26 F7            [ 1]   74 	jrne	00003$
      008021                         75 00004$:
                                     76 ; stm8_genXINIT() end
                                     77 	.area GSFINAL
      008021 CC 80 04         [ 2]   78 	jp	__sdcc_program_startup
                                     79 ;--------------------------------------------------------
                                     80 ; Home
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area HOME
      008004                         84 __sdcc_program_startup:
      008004 CC 80 58         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 6: int main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008058                         95 _main:
      008058 88               [ 1]   96 	push	a
                                     97 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008059 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	main.c: 10: init_UART(9600);
      00805D 4B 80            [ 1]  100 	push	#0x80
      00805F 4B 25            [ 1]  101 	push	#0x25
      008061 5F               [ 1]  102 	clrw	x
      008062 89               [ 2]  103 	pushw	x
      008063 CD 85 02         [ 4]  104 	call	_init_UART
                                    105 ;	main.c: 11: init_I2C();
      008066 CD 82 3B         [ 4]  106 	call	_init_I2C
                                    107 ;	main.c: 13: sendString_UART("--Star scanning--");
      008069 AE 80 24         [ 2]  108 	ldw	x, #(___str_0+0)
      00806C CD 85 65         [ 4]  109 	call	_sendString_UART
                                    110 ;	main.c: 14: sendLine_UART();
      00806F CD 85 72         [ 4]  111 	call	_sendLine_UART
      008072 0F 01            [ 1]  112 	clr	(0x01, sp)
      008074                        113 00108$:
                                    114 ;	main.c: 15: for (uint8_t i; i < 255; i++)
      008074 7B 01            [ 1]  115 	ld	a, (0x01, sp)
      008076 A1 FF            [ 1]  116 	cp	a, #0xff
      008078 24 1A            [ 1]  117 	jrnc	00103$
                                    118 ;	main.c: 17: if (ping_I2C(i) == 1)
      00807A 7B 01            [ 1]  119 	ld	a, (0x01, sp)
      00807C CD 82 C7         [ 4]  120 	call	_ping_I2C
      00807F 4A               [ 1]  121 	dec	a
      008080 26 0E            [ 1]  122 	jrne	00109$
                                    123 ;	main.c: 19: sendString_UART("devise in ");
      008082 AE 80 36         [ 2]  124 	ldw	x, #(___str_1+0)
      008085 CD 85 65         [ 4]  125 	call	_sendString_UART
                                    126 ;	main.c: 20: sendHex_UART(i);
      008088 7B 01            [ 1]  127 	ld	a, (0x01, sp)
      00808A CD 85 EF         [ 4]  128 	call	_sendHex_UART
                                    129 ;	main.c: 21: sendLine_UART();
      00808D CD 85 72         [ 4]  130 	call	_sendLine_UART
      008090                        131 00109$:
                                    132 ;	main.c: 15: for (uint8_t i; i < 255; i++)
      008090 0C 01            [ 1]  133 	inc	(0x01, sp)
      008092 20 E0            [ 2]  134 	jra	00108$
      008094                        135 00103$:
                                    136 ;	main.c: 24: sendString_UART("--end scanning--");
      008094 AE 80 41         [ 2]  137 	ldw	x, #(___str_2+0)
      008097 CD 85 65         [ 4]  138 	call	_sendString_UART
                                    139 ;	main.c: 25: sendLine_UART();
      00809A CD 85 72         [ 4]  140 	call	_sendLine_UART
                                    141 ;	main.c: 26: while (1)
      00809D                        142 00105$:
      00809D 20 FE            [ 2]  143 	jra	00105$
                                    144 ;	main.c: 30: }
      00809F 84               [ 1]  145 	pop	a
      0080A0 81               [ 4]  146 	ret
                                    147 	.area CODE
                                    148 	.area CONST
                                    149 	.area CONST
      008024                        150 ___str_0:
      008024 2D 2D 53 74 61 72 20   151 	.ascii "--Star scanning--"
             73 63 61 6E 6E 69 6E
             67 2D 2D
      008035 00                     152 	.db 0x00
                                    153 	.area CODE
                                    154 	.area CONST
      008036                        155 ___str_1:
      008036 64 65 76 69 73 65 20   156 	.ascii "devise in "
             69 6E 20
      008040 00                     157 	.db 0x00
                                    158 	.area CODE
                                    159 	.area CONST
      008041                        160 ___str_2:
      008041 2D 2D 65 6E 64 20 73   161 	.ascii "--end scanning--"
             63 61 6E 6E 69 6E 67
             2D 2D
      008051 00                     162 	.db 0x00
                                    163 	.area CODE
                                    164 	.area INITIALIZER
                                    165 	.area CABS (ABS)
