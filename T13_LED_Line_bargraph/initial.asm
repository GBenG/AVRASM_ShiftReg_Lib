
	//	.def	uBUF		= R18

//************************************************************************

; Internal Hardware Init  ======================================
 
			
//-------------------------------------------- PORTs

	//	SETB	DDRX,Y,R16	; �����

	//	CLRB	DDRX,Y,R16	; ����
	//	SETB	PORTX,Y,R16	; ��������


	SETB	DDRB,2,R16	; �����		; DATA
	CLRB	PORTB,2,R16	; [0]

	SETB	DDRB,1,R16	; �����		; ENBL
	CLRB	PORTB,1,R16	; [0]

	SETB	DDRB,0,R16	; �����		; CLK
	SETB	PORTB,0,R16	; [0]

	CLRB	DDRB,3,R16	; ����		; ADC
//	SETB	PORTB,3,R16	; ��������


PUSH	R20
PUSH	R20
 
; End Internal Hardware Init ===================================




