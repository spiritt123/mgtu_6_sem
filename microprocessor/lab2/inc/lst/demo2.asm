.include "m8515def.inc"		;файл определений для ATmega8515
.def temp = r16				;временный регистр
.equ led = 0				;0-о бит порта PB
.equ sw0 = 2				;2-й бит порта PD
.equ sw1 = 3				;3-й бит порта PD
.org $000
	;***Таблица векторов прерываний, начиная с адреса $000***
	rjmp INIT				;обработка сброса
	rjmp led_on1			;на обработку запроса INT0	
rjmp led_on2			;на обработку запроса INT1	
;***Инициализация SP, портов, регистра маски***
INIT:		ldi temp,$5F		;установка
		out SPL,temp		; указателя стека
		ldi temp,$02		; на последнюю
		out SPH,temp		; ячейку ОЗУ
		ser temp			;инициализация выводов 
		out DDRB,temp		; порта PB на вывод
		out PORTB,temp		;погасить СД
		clr temp			;инициализация 
		out DDRD,temp		; порта PD на ввод
		ldi temp,0b00001100	;включение ‘подтягивающих’ 
		out PORTD,temp		; резисторов порта PD
		ldi temp,((1<<INT0)|(1<<INT1));разрешение прерываний
		out GICR,temp		; в 6,7 битах регистра маски GICR
		ldi temp,0 		;обработка прерываний 
		out MCUCR,temp		; по низкому уровню
		sei				;глобальное разрешение прерываний	
loop:    	
        nop				;режим ожиданий
   	    rjmp loop
led_on1:
        cbi PORTB,led
        rcall delay1
        sbi PORTB,led
wait_0: 	sbis pind,sw0
        rjmp wait_0
        reti
led_on2:
        cbi PORTB,led
        rcall delay2
        sbi PORTB,led
wait_1: 	
        sbis pind,sw1
        rjmp wait_1
        reti
delay1:    
        nop 
;для подпрограммы задержки 1 c
        ret
delay2: 	     ;подпрограмма задержки 2 c
        rcall delay1
        rcall delay1
        ret
