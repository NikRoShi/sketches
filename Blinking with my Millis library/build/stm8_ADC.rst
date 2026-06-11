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
      008111                         56 _init_ADC:
      008111 88               [ 1]   57 	push	a
      008112 95               [ 1]   58 	ld	xh, a
                                     59 ;	../../my_STM8_libraries/stm8_ADC.c: 5: CLK_PCKENR2 |= (1 << 3);	//включить тактирование адс
      008113 72 16 50 CA      [ 1]   60 	bset	0x50ca, #3
                                     61 ;	../../my_STM8_libraries/stm8_ADC.c: 7: ADC_CSR &= ~0x0F;        // Очистить старый канал
      008117 C6 54 00         [ 1]   62 	ld	a, 0x5400
      00811A A4 F0            [ 1]   63 	and	a, #0xf0
      00811C C7 54 00         [ 1]   64 	ld	0x5400, a
                                     65 ;	../../my_STM8_libraries/stm8_ADC.c: 8: ADC_CSR |= (channel & 0x0F); // Записать номер канала
      00811F C6 54 00         [ 1]   66 	ld	a, 0x5400
      008122 6B 01            [ 1]   67 	ld	(0x01, sp), a
      008124 9E               [ 1]   68 	ld	a, xh
      008125 A4 0F            [ 1]   69 	and	a, #0x0f
      008127 1A 01            [ 1]   70 	or	a, (0x01, sp)
      008129 C7 54 00         [ 1]   71 	ld	0x5400, a
                                     72 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      00812C 41               [ 1]   73 	exg	a, xl
      00812D 9E               [ 1]   74 	ld	a, xh
      00812E 41               [ 1]   75 	exg	a, xl
                                     76 ;	../../my_STM8_libraries/stm8_ADC.c: 10: if (channel < 8) 			//отключаем триггер шмидта на выбраном канале
      00812F 9E               [ 1]   77 	ld	a, xh
      008130 A1 08            [ 1]   78 	cp	a, #0x08
      008132 24 19            [ 1]   79 	jrnc	00102$
                                     80 ;	../../my_STM8_libraries/stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
      008134 C6 54 07         [ 1]   81 	ld	a, 0x5407
      008137 88               [ 1]   82 	push	a
      008138 A6 01            [ 1]   83 	ld	a, #0x01
      00813A 6B 02            [ 1]   84 	ld	(0x02, sp), a
      00813C 9F               [ 1]   85 	ld	a, xl
      00813D 4D               [ 1]   86 	tnz	a
      00813E 27 05            [ 1]   87 	jreq	00113$
      008140                         88 00112$:
      008140 08 02            [ 1]   89 	sll	(0x02, sp)
      008142 4A               [ 1]   90 	dec	a
      008143 26 FB            [ 1]   91 	jrne	00112$
      008145                         92 00113$:
      008145 84               [ 1]   93 	pop	a
      008146 1A 01            [ 1]   94 	or	a, (0x01, sp)
      008148 C7 54 07         [ 1]   95 	ld	0x5407, a
      00814B 20 1A            [ 2]   96 	jra	00103$
      00814D                         97 00102$:
                                     98 ;	../../my_STM8_libraries/stm8_ADC.c: 13: ADC_TDRH |= (1 << (channel - 8));
      00814D C6 54 06         [ 1]   99 	ld	a, 0x5406
      008150 6B 01            [ 1]  100 	ld	(0x01, sp), a
      008152 1D 00 08         [ 2]  101 	subw	x, #8
      008155 A6 01            [ 1]  102 	ld	a, #0x01
      008157 88               [ 1]  103 	push	a
      008158 9F               [ 1]  104 	ld	a, xl
      008159 4D               [ 1]  105 	tnz	a
      00815A 27 05            [ 1]  106 	jreq	00115$
      00815C                        107 00114$:
      00815C 08 01            [ 1]  108 	sll	(1, sp)
      00815E 4A               [ 1]  109 	dec	a
      00815F 26 FB            [ 1]  110 	jrne	00114$
      008161                        111 00115$:
      008161 84               [ 1]  112 	pop	a
      008162 1A 01            [ 1]  113 	or	a, (0x01, sp)
      008164 C7 54 06         [ 1]  114 	ld	0x5406, a
      008167                        115 00103$:
                                    116 ;	../../my_STM8_libraries/stm8_ADC.c: 15: ADC_CR2 |= (1 << 3);		//выравнивание вправо
      008167 72 16 54 02      [ 1]  117 	bset	0x5402, #3
                                    118 ;	../../my_STM8_libraries/stm8_ADC.c: 17: ADC_CR1 &= ~(0b111 << 4);	//очищаем значение делителя
      00816B C6 54 01         [ 1]  119 	ld	a, 0x5401
      00816E A4 8F            [ 1]  120 	and	a, #0x8f
      008170 C7 54 01         [ 1]  121 	ld	0x5401, a
                                    122 ;	../../my_STM8_libraries/stm8_ADC.c: 18: ADC_CR1 |= (0b100 << 4);	//устанавливаем делитьеть на 8(2Мгц для ADC)
      008173 72 1C 54 01      [ 1]  123 	bset	0x5401, #6
                                    124 ;	../../my_STM8_libraries/stm8_ADC.c: 20: ADC_CR1 |= (1 << 0);		//запускаем ADON(прогрев)
      008177 72 10 54 01      [ 1]  125 	bset	0x5401, #0
                                    126 ;	../../my_STM8_libraries/stm8_ADC.c: 21: }
      00817B 84               [ 1]  127 	pop	a
      00817C 81               [ 4]  128 	ret
                                    129 ;	../../my_STM8_libraries/stm8_ADC.c: 23: void start_ADC(void) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function start_ADC
                                    132 ;	-----------------------------------------
      00817D                        133 _start_ADC:
                                    134 ;	../../my_STM8_libraries/stm8_ADC.c: 24: ADC_CR1 |= (1 << 0);		//вторая запись в адон запускает преобразование
      00817D 72 10 54 01      [ 1]  135 	bset	0x5401, #0
                                    136 ;	../../my_STM8_libraries/stm8_ADC.c: 25: }
      008181 81               [ 4]  137 	ret
                                    138 ;	../../my_STM8_libraries/stm8_ADC.c: 27: uint8_t isReady_ADC(void) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function isReady_ADC
                                    141 ;	-----------------------------------------
      008182                        142 _isReady_ADC:
                                    143 ;	../../my_STM8_libraries/stm8_ADC.c: 28: if (ADC_CSR & (1 << 7)) {return 1;}	//1 если значение готово
      008182 C6 54 00         [ 1]  144 	ld	a, 0x5400
      008185 2A 03            [ 1]  145 	jrpl	00102$
      008187 A6 01            [ 1]  146 	ld	a, #0x01
      008189 81               [ 4]  147 	ret
      00818A                        148 00102$:
                                    149 ;	../../my_STM8_libraries/stm8_ADC.c: 29: return 0;
      00818A 4F               [ 1]  150 	clr	a
                                    151 ;	../../my_STM8_libraries/stm8_ADC.c: 30: }
      00818B 81               [ 4]  152 	ret
                                    153 ;	../../my_STM8_libraries/stm8_ADC.c: 32: uint16_t getValue_ADC (void) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function getValue_ADC
                                    156 ;	-----------------------------------------
      00818C                        157 _getValue_ADC:
      00818C 52 04            [ 2]  158 	sub	sp, #4
                                    159 ;	../../my_STM8_libraries/stm8_ADC.c: 33: uint16_t val = ADC_DRL;
      00818E C6 54 05         [ 1]  160 	ld	a, 0x5405
      008191 97               [ 1]  161 	ld	xl, a
      008192 0F 01            [ 1]  162 	clr	(0x01, sp)
                                    163 ;	../../my_STM8_libraries/stm8_ADC.c: 34: val |= (uint16_t)ADC_DRH << 8;
      008194 C6 54 04         [ 1]  164 	ld	a, 0x5404
      008197 0F 04            [ 1]  165 	clr	(0x04, sp)
      008199 1A 01            [ 1]  166 	or	a, (0x01, sp)
      00819B 01               [ 1]  167 	rrwa	x
      00819C 1A 04            [ 1]  168 	or	a, (0x04, sp)
      00819E 97               [ 1]  169 	ld	xl, a
                                    170 ;	../../my_STM8_libraries/stm8_ADC.c: 36: ADC_CSR &= ~(1 << 7);
      00819F 72 1F 54 00      [ 1]  171 	bres	0x5400, #7
                                    172 ;	../../my_STM8_libraries/stm8_ADC.c: 38: return val;
                                    173 ;	../../my_STM8_libraries/stm8_ADC.c: 39: }
      0081A3 5B 04            [ 2]  174 	addw	sp, #4
      0081A5 81               [ 4]  175 	ret
                                    176 	.area CODE
                                    177 	.area CONST
                                    178 	.area INITIALIZER
                                    179 	.area CABS (ABS)
