
	//	.def	uBUF		= R18

//************************************************************************

; Internal Hardware Init  ======================================
 
			
//-------------------------------------------- PORTs

	//	SETB	DDRX,Y,R16	; выход

	//	CLRB	DDRX,Y,R16	; вход
	//	SETB	PORTX,Y,R16	; подтяжко


	SETB	DDRB,2,R16	; выход		; DATA
	CLRB	PORTB,2,R16	; [0]

	SETB	DDRB,1,R16	; выход		; ENBL
	CLRB	PORTB,1,R16	; [0]

	SETB	DDRB,0,R16	; выход		; CLK
	SETB	PORTB,0,R16	; [0]

	CLRB	DDRB,3,R16	; вход		; ADC
//	SETB	PORTB,3,R16	; подтяжко


PUSH	R20
PUSH	R20
 
; End Internal Hardware Init ===================================




