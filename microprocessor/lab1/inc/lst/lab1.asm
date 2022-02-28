.include "m8515def.inc"
.def temp = r16
.def reg_led = r20 
.equ START = 0 

.equ STOP = 1 
.org $000
rjmp init

INIT: ldi reg_led,0x3F 
sec 
clt 

ser temp 
out DDRA,temp 
out PORTA,temp 
clr temp 
out DDRD,temp 
ldi temp,0x03 
out PORTD,temp

WAITSTART:
sbic PIND,START 
rjmp WAITSTART 
LOOP: out PORTA,reg_led 

	ldi r19, 254
d1: ldi r17,210
d2: ldi r18,4
d3: dec r18
brne d3
dec r17
brne d2
dec r19
brne d1

sbic PIND,STOP
rjmp MM 
rjmp WAITSTART 
MM: brts LEFT 

mov r21, reg_led
andi r21, 0x01
brne R_OFFSET
set
ldi reg_led,0x03
clc
rjmp LOOP

R_OFFSET:
ror reg_led 
rjmp LOOP 

LEFT: 
mov r21, reg_led
andi r21, 0x3F
brne L_OFFSET
clt
ldi reg_led,0x3F
sec
rjmp LOOP

L_OFFSET:
rol reg_led 
rjmp LOOP
