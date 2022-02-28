.include "m8515def.inc"
.def temp = r16
.def reg_led = r20
.equ START = 0
.equ STOP = 1
;файл определений для ATmega8515
;временный регистр
;состояние регистра светодиодов
;0-й разряд порта PD
;1-й разряд порта PD
.org $000
rjmp init
;***Инициализация***
INIT:
 ldi reg_led,0xF3
 ;сброс reg_led.0 для включения LED0
ldildildir21,0
r22,3
r23,0
sec
 ;C=1
set
 ;T=1 – флаг направления
ser temp
 ;инициализация,
 устанавливает
 все
единицы
out DDRC,temp
 ; порта PB на вывод, записав туда единицы
out PORTC,temp
 ;погасить СД, все единицы на порт, чтобы
все свето. были выключены
clr temp
 ;инициализация
out DDRD,temp
 ; порта PD на ввод, для первых двух
кнопок
ldi temp,0x03
 ;включение подтягивающих
out PORTD,temp
 ; резисторов порта PD
WAITSTART:
sbic PIND,START
rjmp WAITSTART
;ожидание
; нажатия
; кнопки START
;
 rol reg_led ;начатие со второго
LOOP: out PORTC,reg_led ;включение СД
;***Задержка (два вложенных цикла)***
cp r23,r22
breq CHANGE_T_TO_RIGTHT
cp r21,r22
breq CHANGE_T_TO_LEFT
d1:
d2:
d3:
decldi r17,5
ldi r18,254
ldi r19,255
r19
brne d3
dec r18
brne d2
dec r17
brne d1
sbic PIND,STOP
rjmp MM
rjmp WAITSTART
;если замкнута кнопка STOP, то
; переход
; для проверки кнопки START,
MM:
brts LEFT
 ;переход, если флаг T установлен
sbrs reg_led,0
 ;пропуск следующей команды,
;T=1
 -
 переключение
 флага
направления
ror reg_led
cp r21,r22
breq CHANGE_T_TO_LEFT
 ;сдвиг reg_led вправо на 1 разряд
inc r21
ror reg_led
rjmp LOOP
LEFT: sbrs reg_led,7
 ;пропуск следующей команды,
set
 ; если 7-й разряд reg_led установлен
rol reg_led
 ;сдвиг reg_led влево на 1 разряд
inc r23
rjmp LOOP
CHANGE_T_TO_RIGTHT:
clt
ldi r21,0
ldi r23,0
rjmp LOOP
CHANGE_T_TO_LEFT:
set
ldi r21,0
rjmp LOOP
