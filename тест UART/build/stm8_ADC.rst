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
      008102                         56 _init_ADC:
      008102 88               [ 1]   57 	push	a
      008103 95               [ 1]   58 	ld	xh, a
                                     59 ;	../../my_STM8_libraries/stm8_ADC.c: 5: CLK_PCKENR2 |= (1 << 3);	//включить тактирование адс
      008104 72 16 50 CA      [ 1]   60 	bset	0x50ca, #3
                                     61 ;	../../my_STM8_libraries/stm8_ADC.c: 7: ADC_CSR &= ~0x0F;        // Очистить старый канал
      008108 C6 54 00         [ 1]   62 	ld	a, 0x5400
      00810B A4 F0            [ 1]   63 	and	a, #0xf0
      00810D C7 54 00         [ 1]   64 	ld	0x5400, a
                                     65 ;	../../my_STM8_libraries/stm8_ADC.c: 8: ADC_CSR |= (channel & 0x0F); // Записать номер канала
      008110 C6 54 00         [ 1]   66 	ld	a, 0x5400
      008113 6B 01            [ 1]   67 	ld	(0x01, sp), a
      008115 9E               [ 1]   68 	ld	a, xh
      008116 A4 0F            [ 1]   69 	and	a, #0x0f
      008118 1A 01            [ 1]   70 	or	a, (0x01, sp)
      00811A C7 54 00         [ 1]   71 	ld	0x5400, a
                                     72 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      00811D 41               [ 1]   73 	exg	a, xl
      00811E 9E               [ 1]   74 	ld	a, xh
      00811F 41               [ 1]   75 	exg	a, xl
                                     76 ;	../../my_STM8_libraries/stm8_ADC.c: 10: if (channel < 8) 			//отключаем триггер шмидта на выбраном канале
      008120 9E               [ 1]   77 	ld	a, xh
      008121 A1 08            [ 1]   78 	cp	a, #0x08
      008123 24 19            [ 1]   79 	jrnc	00102$
                                     80 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      008125 C6 54 07         [ 1]   81 	ld	a, 0x5407
      008128 88               [ 1]   82 	push	a
      008129 A6 01            [ 1]   83 	ld	a, #0x01
      00812B 6B 02            [ 1]   84 	ld	(0x02, sp), a
      00812D 9F               [ 1]   85 	ld	a, xl
      00812E 4D               [ 1]   86 	tnz	a
      00812F 27 05            [ 1]   87 	jreq	00113$
      008131                         88 00112$:
      008131 08 02            [ 1]   89 	sll	(0x02, sp)
      008133 4A               [ 1]   90 	dec	a
      008134 26 FB            [ 1]   91 	jrne	00112$
      008136                         92 00113$:
      008136 84               [ 1]   93 	pop	a
      008137 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008139 C7 54 07         [ 1]   95 	ld	0x5407, a
      00813C 20 1A            [ 2]   96 	jra	00103$
      00813E                         97 00102$:
                                     98 ;	../../my_STM8_libraries/stm8_ADC.c: 13: ADC_TDRH |= (1 << (channel - 8));
      00813E C6 54 06         [ 1]   99 	ld	a, 0x5406
      008141 6B 01            [ 1]  100 	ld	(0x01, sp), a
      008143 1D 00 08         [ 2]  101 	subw	x, #8
      008146 A6 01            [ 1]  102 	ld	a, #0x01
      008148 88               [ 1]  103 	push	a
      008149 9F               [ 1]  104 	ld	a, xl
      00814A 4D               [ 1]  105 	tnz	a
      00814B 27 05            [ 1]  106 	jreq	00115$
      00814D                        107 00114$:
      00814D 08 01            [ 1]  108 	sll	(1, sp)
      00814F 4A               [ 1]  109 	dec	a
      008150 26 FB            [ 1]  110 	jrne	00114$
      008152                        111 00115$:
      008152 84               [ 1]  112 	pop	a
      008153 1A 01            [ 1]  113 	or	a, (0x01, sp)
      008155 C7 54 06         [ 1]  114 	ld	0x5406, a
      008158                        115 00103$:
                                    116 ;	../../my_STM8_libraries/stm8_ADC.c: 15: ADC_CR2 |= (1 << 3);		//выравнивание вправо
      008158 72 16 54 02      [ 1]  117 	bset	0x5402, #3
                                    118 ;	../../my_STM8_libraries/stm8_ADC.c: 17: ADC_CR1 &= ~(0b111 << 4);	//очищаем значение делителя
      00815C C6 54 01         [ 1]  119 	ld	a, 0x5401
      00815F A4 8F            [ 1]  120 	and	a, #0x8f
      008161 C7 54 01         [ 1]  121 	ld	0x5401, a
                                    122 ;	../../my_STM8_libraries/stm8_ADC.c: 18: ADC_CR1 |= (0b100 << 4);	//устанавливаем делитьеть на 8(2Мгц для ADC)
      008164 72 1C 54 01      [ 1]  123 	bset	0x5401, #6
                                    124 ;	../../my_STM8_libraries/stm8_ADC.c: 20: ADC_CR1 |= (1 << 0);		//запускаем ADON(прогрев)
      008168 72 10 54 01      [ 1]  125 	bset	0x5401, #0
                                    126 ;	../../my_STM8_libraries/stm8_ADC.c: 21: }
      00816C 84               [ 1]  127 	pop	a
      00816D 81               [ 4]  128 	ret
                                    129 ;	../../my_STM8_libraries/stm8_ADC.c: 23: void start_ADC(void) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function start_ADC
                                    132 ;	-----------------------------------------
      00816E                        133 _start_ADC:
                                    134 ;	../../my_STM8_libraries/stm8_ADC.c: 24: ADC_CR1 |= (1 << 0);		//вторая запись в адон запускает преобразование
      00816E 72 10 54 01      [ 1]  135 	bset	0x5401, #0
                                    136 ;	../../my_STM8_libraries/stm8_ADC.c: 25: }
      008172 81               [ 4]  137 	ret
                                    138 ;	../../my_STM8_libraries/stm8_ADC.c: 27: uint8_t isReady_ADC(void) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function isReady_ADC
                                    141 ;	-----------------------------------------
      008173                        142 _isReady_ADC:
                                    143 ;	../../my_STM8_libraries/stm8_ADC.c: 28: if (ADC_CSR & (1 << 7)) {return 1;}	//1 если значение готово
      008173 C6 54 00         [ 1]  144 	ld	a, 0x5400
      008176 2A 03            [ 1]  145 	jrpl	00102$
      008178 A6 01            [ 1]  146 	ld	a, #0x01
      00817A 81               [ 4]  147 	ret
      00817B                        148 00102$:
                                    149 ;	../../my_STM8_libraries/stm8_ADC.c: 29: return 0;
      00817B 4F               [ 1]  150 	clr	a
                                    151 ;	../../my_STM8_libraries/stm8_ADC.c: 30: }
      00817C 81               [ 4]  152 	ret
                                    153 ;	../../my_STM8_libraries/stm8_ADC.c: 32: uint16_t getValue_ADC (void) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function getValue_ADC
                                    156 ;	-----------------------------------------
      00817D                        157 _getValue_ADC:
      00817D 52 04            [ 2]  158 	sub	sp, #4
                                    159 ;	../../my_STM8_libraries/stm8_ADC.c: 33: uint16_t val = ADC_DRL;
      00817F C6 54 05         [ 1]  160 	ld	a, 0x5405
      008182 97               [ 1]  161 	ld	xl, a
      008183 0F 01            [ 1]  162 	clr	(0x01, sp)
                                    163 ;	../../my_STM8_libraries/stm8_ADC.c: 34: val |= (uint16_t)ADC_DRH << 8;
      008185 C6 54 04         [ 1]  164 	ld	a, 0x5404
      008188 0F 04            [ 1]  165 	clr	(0x04, sp)
      00818A 1A 01            [ 1]  166 	or	a, (0x01, sp)
      00818C 01               [ 1]  167 	rrwa	x
      00818D 1A 04            [ 1]  168 	or	a, (0x04, sp)
      00818F 97               [ 1]  169 	ld	xl, a
                                    170 ;	../../my_STM8_libraries/stm8_ADC.c: 36: ADC_CSR &= ~(1 << 7);
      008190 72 1F 54 00      [ 1]  171 	bres	0x5400, #7
                                    172 ;	../../my_STM8_libraries/stm8_ADC.c: 38: return val;
                                    173 ;	../../my_STM8_libraries/stm8_ADC.c: 39: }
      008194 5B 04            [ 2]  174 	addw	sp, #4
      008196 81               [ 4]  175 	ret
                                    176 	.area CODE
                                    177 	.area CONST
                                    178 	.area INITIALIZER
                                    179 	.area CABS (ABS)
