.include "m8515def.inc"		;файл определений для ATmega8515
.def temp = r16				;временный регистр
.equ led = 0				;0-й бит порта PB
.equ sw0 = 0				;0-й бит порта PA
.equ sw1 = 1				;1-й бит порта PA

.org $000
		rjmp INIT			;обработка сброса
	;***Инициализация МК***
INIT:		ldi temp,$5F		;установка
		out SPL,temp		; указателя стека
		ldi temp,$02		; на последнюю
		out SPH,temp		; ячейку ОЗУ
		ser temp			;инициализация выводов 
		out DDRB,temp		; порта PB на вывод
		out PORTB,temp		;погасить LED
		clr temp			;инициализация 
		out DDRA,temp		; порта PA на ввод

        ldi temp,0b00000011	;включение ‘подтягивающих’ 
		out PORTA,temp		; резисторов порта PA
test_sw0:	
        sbiс PINA,sw0		;проверка состояния
        rjmp test_sw1		; кнопки sw0
        cbi PORTB, led
        rcall delay1
        sbi PORTB,led
wait_0: 	
        sbis PINA,sw0
        rjmp wait_0
test_sw1:  
        sbiс PINA,sw1		;проверка состояния
		rjmp test_sw0		; кнопки sw1		
        cbi PORTB,led
        rcall delay2
        sbi PORTB,led
wait_1: 	
        sbis PINA,sw1
        rjmp wait_1
		rjmp test_sw0
delay1:        			 	; подпрограмма 1 с
		ret
delay2:         				; подпрограмма 2 с
        rcall delay1
        rcall delay1
		ret


