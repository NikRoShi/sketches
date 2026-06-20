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
                                     16 	.globl _readByte_I2C
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
      008018 D6 80 39         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 40         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 6: int main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008040                         95 _main:
      008040 88               [ 1]   96 	push	a
                                     97 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008041 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	main.c: 10: init_I2C();
      008045 CD 82 3E         [ 4]  100 	call	_init_I2C
                                    101 ;	main.c: 11: init_UART(9600);
      008048 4B 80            [ 1]  102 	push	#0x80
      00804A 4B 25            [ 1]  103 	push	#0x25
      00804C 5F               [ 1]  104 	clrw	x
      00804D 89               [ 2]  105 	pushw	x
      00804E CD 85 62         [ 4]  106 	call	_init_UART
                                    107 ;	main.c: 15: sendString_UART("start");
      008051 AE 80 24         [ 2]  108 	ldw	x, #(___str_0+0)
      008054 CD 85 C5         [ 4]  109 	call	_sendString_UART
                                    110 ;	main.c: 16: sendLine_UART();
      008057 CD 85 D2         [ 4]  111 	call	_sendLine_UART
                                    112 ;	main.c: 18: if (readByte_I2C(0x68, &i2cData) == 1)
      00805A 96               [ 1]  113 	ldw	x, sp
      00805B 5C               [ 1]  114 	incw	x
      00805C A6 68            [ 1]  115 	ld	a, #0x68
      00805E CD 83 39         [ 4]  116 	call	_readByte_I2C
      008061 4A               [ 1]  117 	dec	a
      008062 26 10            [ 1]  118 	jrne	00102$
                                    119 ;	main.c: 20: sendString_UART("data is 0x");
      008064 AE 80 2A         [ 2]  120 	ldw	x, #(___str_1+0)
      008067 CD 85 C5         [ 4]  121 	call	_sendString_UART
                                    122 ;	main.c: 21: sendHex_UART(i2cData);
      00806A 7B 01            [ 1]  123 	ld	a, (0x01, sp)
      00806C CD 86 4F         [ 4]  124 	call	_sendHex_UART
                                    125 ;	main.c: 22: sendLine_UART();
      00806F CD 85 D2         [ 4]  126 	call	_sendLine_UART
      008072 20 09            [ 2]  127 	jra	00108$
      008074                        128 00102$:
                                    129 ;	main.c: 26: sendString_UART("fail");
      008074 AE 80 35         [ 2]  130 	ldw	x, #(___str_2+0)
      008077 CD 85 C5         [ 4]  131 	call	_sendString_UART
                                    132 ;	main.c: 27: sendLine_UART();
      00807A CD 85 D2         [ 4]  133 	call	_sendLine_UART
                                    134 ;	main.c: 30: while (1)
      00807D                        135 00108$:
                                    136 ;	main.c: 32: if (readByte_I2C(0x68, &i2cData) == 1)
      00807D 96               [ 1]  137 	ldw	x, sp
      00807E 5C               [ 1]  138 	incw	x
      00807F A6 68            [ 1]  139 	ld	a, #0x68
      008081 CD 83 39         [ 4]  140 	call	_readByte_I2C
      008084 4A               [ 1]  141 	dec	a
      008085 26 10            [ 1]  142 	jrne	00105$
                                    143 ;	main.c: 34: sendString_UART("data is 0x");
      008087 AE 80 2A         [ 2]  144 	ldw	x, #(___str_1+0)
      00808A CD 85 C5         [ 4]  145 	call	_sendString_UART
                                    146 ;	main.c: 35: sendHex_UART(i2cData);
      00808D 7B 01            [ 1]  147 	ld	a, (0x01, sp)
      00808F CD 86 4F         [ 4]  148 	call	_sendHex_UART
                                    149 ;	main.c: 36: sendLine_UART();
      008092 CD 85 D2         [ 4]  150 	call	_sendLine_UART
      008095 20 E6            [ 2]  151 	jra	00108$
      008097                        152 00105$:
                                    153 ;	main.c: 40: sendString_UART("fail");
      008097 AE 80 35         [ 2]  154 	ldw	x, #(___str_2+0)
      00809A CD 85 C5         [ 4]  155 	call	_sendString_UART
                                    156 ;	main.c: 41: sendLine_UART();
      00809D CD 85 D2         [ 4]  157 	call	_sendLine_UART
      0080A0 20 DB            [ 2]  158 	jra	00108$
                                    159 ;	main.c: 44: }
      0080A2 84               [ 1]  160 	pop	a
      0080A3 81               [ 4]  161 	ret
                                    162 	.area CODE
                                    163 	.area CONST
                                    164 	.area CONST
      008024                        165 ___str_0:
      008024 73 74 61 72 74         166 	.ascii "start"
      008029 00                     167 	.db 0x00
                                    168 	.area CODE
                                    169 	.area CONST
      00802A                        170 ___str_1:
      00802A 64 61 74 61 20 69 73   171 	.ascii "data is 0x"
             20 30 78
      008034 00                     172 	.db 0x00
                                    173 	.area CODE
                                    174 	.area CONST
      008035                        175 ___str_2:
      008035 66 61 69 6C            176 	.ascii "fail"
      008039 00                     177 	.db 0x00
                                    178 	.area CODE
                                    179 	.area INITIALIZER
                                    180 	.area CABS (ABS)
