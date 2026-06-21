                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_ADC
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_ADC
                                     12 	.globl _start_ADC
                                     13 	.globl _isReady_ADC
                                     14 	.globl _getValue_ADC
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	../../my_STM8_libraries/stm8_ADC.c: 4: void init_ADC(uint8_t channel) {
                                     53 ;	-----------------------------------------
                                     54 ;	 function init_ADC
                                     55 ;	-----------------------------------------
      00811D                         56 _init_ADC:
      00811D 88               [ 1]   57 	push	a
      00811E 95               [ 1]   58 	ld	xh, a
                                     59 ;	../../my_STM8_libraries/stm8_ADC.c: 5: CLK_PCKENR2 |= (1 << 3);	//включить тактирование адс
      00811F 72 16 50 CA      [ 1]   60 	bset	0x50ca, #3
                                     61 ;	../../my_STM8_libraries/stm8_ADC.c: 7: ADC_CSR &= ~0x0F;        // Очистить старый канал
      008123 C6 54 00         [ 1]   62 	ld	a, 0x5400
      008126 A4 F0            [ 1]   63 	and	a, #0xf0
      008128 C7 54 00         [ 1]   64 	ld	0x5400, a
                                     65 ;	../../my_STM8_libraries/stm8_ADC.c: 8: ADC_CSR |= (channel & 0x0F); // Записать номер канала
      00812B C6 54 00         [ 1]   66 	ld	a, 0x5400
      00812E 6B 01            [ 1]   67 	ld	(0x01, sp), a
      008130 9E               [ 1]   68 	ld	a, xh
      008131 A4 0F            [ 1]   69 	and	a, #0x0f
      008133 1A 01            [ 1]   70 	or	a, (0x01, sp)
      008135 C7 54 00         [ 1]   71 	ld	0x5400, a
                                     72 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      008138 41               [ 1]   73 	exg	a, xl
      008139 9E               [ 1]   74 	ld	a, xh
      00813A 41               [ 1]   75 	exg	a, xl
                                     76 ;	../../my_STM8_libraries/stm8_ADC.c: 10: if (channel < 8) 			//отключаем триггер шмидта на выбраном канале
      00813B 9E               [ 1]   77 	ld	a, xh
      00813C A1 08            [ 1]   78 	cp	a, #0x08
      00813E 24 19            [ 1]   79 	jrnc	00102$
                                     80 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      008140 C6 54 07         [ 1]   81 	ld	a, 0x5407
      008143 88               [ 1]   82 	push	a
      008144 A6 01            [ 1]   83 	ld	a, #0x01
      008146 6B 02            [ 1]   84 	ld	(0x02, sp), a
      008148 9F               [ 1]   85 	ld	a, xl
      008149 4D               [ 1]   86 	tnz	a
      00814A 27 05            [ 1]   87 	jreq	00113$
      00814C                         88 00112$:
      00814C 08 02            [ 1]   89 	sll	(0x02, sp)
      00814E 4A               [ 1]   90 	dec	a
      00814F 26 FB            [ 1]   91 	jrne	00112$
      008151                         92 00113$:
      008151 84               [ 1]   93 	pop	a
      008152 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008154 C7 54 07         [ 1]   95 	ld	0x5407, a
      008157 20 1A            [ 2]   96 	jra	00103$
      008159                         97 00102$:
                                     98 ;	../../my_STM8_libraries/stm8_ADC.c: 13: ADC_TDRH |= (1 << (channel - 8));
      008159 C6 54 06         [ 1]   99 	ld	a, 0x5406
      00815C 6B 01            [ 1]  100 	ld	(0x01, sp), a
      00815E 1D 00 08         [ 2]  101 	subw	x, #8
      008161 A6 01            [ 1]  102 	ld	a, #0x01
      008163 88               [ 1]  103 	push	a
      008164 9F               [ 1]  104 	ld	a, xl
      008165 4D               [ 1]  105 	tnz	a
      008166 27 05            [ 1]  106 	jreq	00115$
      008168                        107 00114$:
      008168 08 01            [ 1]  108 	sll	(1, sp)
      00816A 4A               [ 1]  109 	dec	a
      00816B 26 FB            [ 1]  110 	jrne	00114$
      00816D                        111 00115$:
      00816D 84               [ 1]  112 	pop	a
      00816E 1A 01            [ 1]  113 	or	a, (0x01, sp)
      008170 C7 54 06         [ 1]  114 	ld	0x5406, a
      008173                        115 00103$:
                                    116 ;	../../my_STM8_libraries/stm8_ADC.c: 15: ADC_CR2 |= (1 << 3);		//выравнивание вправо
      008173 72 16 54 02      [ 1]  117 	bset	0x5402, #3
                                    118 ;	../../my_STM8_libraries/stm8_ADC.c: 17: ADC_CR1 &= ~(0b111 << 4);	//очищаем значение делителя
      008177 C6 54 01         [ 1]  119 	ld	a, 0x5401
      00817A A4 8F            [ 1]  120 	and	a, #0x8f
      00817C C7 54 01         [ 1]  121 	ld	0x5401, a
                                    122 ;	../../my_STM8_libraries/stm8_ADC.c: 18: ADC_CR1 |= (0b100 << 4);	//устанавливаем делитьеть на 8(2Мгц для ADC)
      00817F 72 1C 54 01      [ 1]  123 	bset	0x5401, #6
                                    124 ;	../../my_STM8_libraries/stm8_ADC.c: 20: ADC_CR1 |= (1 << 0);		//запускаем ADON(прогрев)
      008183 72 10 54 01      [ 1]  125 	bset	0x5401, #0
                                    126 ;	../../my_STM8_libraries/stm8_ADC.c: 21: }
      008187 84               [ 1]  127 	pop	a
      008188 81               [ 4]  128 	ret
                                    129 ;	../../my_STM8_libraries/stm8_ADC.c: 23: void start_ADC(void) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function start_ADC
                                    132 ;	-----------------------------------------
      008189                        133 _start_ADC:
                                    134 ;	../../my_STM8_libraries/stm8_ADC.c: 24: ADC_CR1 |= (1 << 0);		//вторая запись в адон запускает преобразование
      008189 72 10 54 01      [ 1]  135 	bset	0x5401, #0
                                    136 ;	../../my_STM8_libraries/stm8_ADC.c: 25: }
      00818D 81               [ 4]  137 	ret
                                    138 ;	../../my_STM8_libraries/stm8_ADC.c: 27: uint8_t isReady_ADC(void) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function isReady_ADC
                                    141 ;	-----------------------------------------
      00818E                        142 _isReady_ADC:
                                    143 ;	../../my_STM8_libraries/stm8_ADC.c: 28: if (ADC_CSR & (1 << 7)) {return 1;}	//1 если значение готово
      00818E C6 54 00         [ 1]  144 	ld	a, 0x5400
      008191 2A 03            [ 1]  145 	jrpl	00102$
      008193 A6 01            [ 1]  146 	ld	a, #0x01
      008195 81               [ 4]  147 	ret
      008196                        148 00102$:
                                    149 ;	../../my_STM8_libraries/stm8_ADC.c: 29: return 0;
      008196 4F               [ 1]  150 	clr	a
                                    151 ;	../../my_STM8_libraries/stm8_ADC.c: 30: }
      008197 81               [ 4]  152 	ret
                                    153 ;	../../my_STM8_libraries/stm8_ADC.c: 32: uint16_t getValue_ADC (void) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function getValue_ADC
                                    156 ;	-----------------------------------------
      008198                        157 _getValue_ADC:
      008198 52 04            [ 2]  158 	sub	sp, #4
                                    159 ;	../../my_STM8_libraries/stm8_ADC.c: 33: uint16_t val = ADC_DRL;
      00819A C6 54 05         [ 1]  160 	ld	a, 0x5405
      00819D 97               [ 1]  161 	ld	xl, a
      00819E 0F 01            [ 1]  162 	clr	(0x01, sp)
                                    163 ;	../../my_STM8_libraries/stm8_ADC.c: 34: val |= (uint16_t)ADC_DRH << 8;
      0081A0 C6 54 04         [ 1]  164 	ld	a, 0x5404
      0081A3 0F 04            [ 1]  165 	clr	(0x04, sp)
      0081A5 1A 01            [ 1]  166 	or	a, (0x01, sp)
      0081A7 01               [ 1]  167 	rrwa	x
      0081A8 1A 04            [ 1]  168 	or	a, (0x04, sp)
      0081AA 97               [ 1]  169 	ld	xl, a
                                    170 ;	../../my_STM8_libraries/stm8_ADC.c: 36: ADC_CSR &= ~(1 << 7);
      0081AB 72 1F 54 00      [ 1]  171 	bres	0x5400, #7
                                    172 ;	../../my_STM8_libraries/stm8_ADC.c: 38: return val;
                                    173 ;	../../my_STM8_libraries/stm8_ADC.c: 39: }
      0081AF 5B 04            [ 2]  174 	addw	sp, #4
      0081B1 81               [ 4]  175 	ret
                                    176 	.area CODE
                                    177 	.area CONST
                                    178 	.area INITIALIZER
                                    179 	.area CABS (ABS)
