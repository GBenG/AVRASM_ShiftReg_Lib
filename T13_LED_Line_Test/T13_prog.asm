//////////////////////////////////////////////////////////////////////////////
////////////     Create by S.P.S 2012(c)                 		 /////////////
//////////////////////////////////////////////////////////////////////////////
////////////                                                     /////////////
////////////     ���� ������������ ������� �� 3� ���������       /////////////
////////////                                                     /////////////
//////////////////////////////////////////////////////////////////////////////

			.include "tn13def.inc"	; ���������� ATMega8
			.include "macro.asm"	; ��� ������� � ��� ���
			.include "shift164_macro.asm"
//--------------------------------------------------------

; RAM =====================================================
			.DSEG					; ���������� 

			.include "init_sh164.asm"

//////////////////////////////////////////////////////////////////////////////
////////////                      MINI SOURCE                    /////////////
//////////////////////////////////////////////////////////////////////////////

	.def 	En 		= R20		; ������� (������ ��������)
	.def	POS	 	= R21		; �������
	.def 	dCOUNT  = R22		; ������� ���������
	.def 	dBUF1   = R23		; ����� ��������� 1
	.def 	dBUF2   = R24		; ����� ��������� 2
	.def 	dBUF3   = R25		; ����� ��������� 3
	.def 	pBUF    = R26		; ����� �������

//////////////////////////////////////////////////////////////////////////////

; FLASH ===================================================
			.CSEG

//////////////////////////////////////////////////////////////////////////////
////////////                   PROGRAMM INIT                     /////////////
//////////////////////////////////////////////////////////////////////////////			


Reset:	//	ldi r16, high(RAMEND)
 		//	out SPH,r16 
 			ldi r16, low(RAMEND)
 			out SPL,r16
			
			.include "initial.asm"			; ��� ������������� ���.

			sei 

//////////////////////////////////////////////////////////////////////////////
////////////             		                	             /////////////
//////////////////////////////////////////////////////////////////////////////
preset:

	LDI R17,1				;������ ���� ��� � ������ 1�� �������

start:
	
	
	MOV	POS,R17
	RCALL DOTCONV			;������������� ��������� � ������� ���
	DDLOOP	1,155,155

	INC	R17					;�������� ������� ����
	CPI	R17,25
	BREQ preset

RJMP start

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
.include "shift164.asm"	
/////////////////////////////////////////////////////////////////
//////////////////////   �������   //////////////////////////////
/////////////////////////////////////////////////////////////////
DOTCONV:
//----------------------------- ���������� ----------------------
	CLR	dCOUNT

	CLR	dBUF1
	CLR	dBUF2
	CLR	dBUF3

	SBR	dBUF1,1<<0

	LDI	R16,24
	SUB	R16,POS
	MOV POS,R16
//----------------------------- �������� ------------------------
sr:	
	CP	dCOUNT,POS
	BREQ showd

	inc	dCOUNT

	CPI	dCOUNT,8
	BREQ	jb2

	LSL dBUF1

	RJMP sr
////////////////////////////////////////////////
jb2: 

	CLR	dBUF1
	SBR	dBUF2,1<<0
//------------------------
sr2:
	CP	dCOUNT,POS
	BREQ showd

	inc	dCOUNT

	CPI	dCOUNT,16
	BREQ	jb3

	LSL dBUF2

	RJMP sr2

jb3:

	CLR	dBUF2
	SBR	dBUF3,1<<0
//------------------------
sr3:
	CP	dCOUNT,POS
	BREQ showd

	inc	dCOUNT

	LSL dBUF3

	RJMP sr3

showd:

	OUTRsBUF	0,dBUF1
	OUTRsBUF	1,dBUF2
	OUTRsBUF	2,dBUF3

	RCALL	SHIFTOUT				;���� ���������� ������� �� ����������������� ������

RET

; EEPROM ==================================================
		.ESEG			; ������� EEPROM  
