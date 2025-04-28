# Shift registers peripheral AVR Assembler Library

ASM Library for simple operation with 74HC164 shift registers on AVR
Created by SPS :: 2012

![](https://img.shields.io/badge/version-1.2-red)

==============================================================================
The library consists of three files:

    shift164.asm          main library file

    init_sh164.asm        library initialization - here all necessary
                          settings are made

    shift164_macro.asm    macros for working with the library. 
                          Service macros are mandatory,
                          working macros can be customized or deleted entirely.
==============================================================================
Files are connected to the project with the command:

    .include "shift164_macro.asm"

==============================================================================
File placement in the project:

    shift164.asm          at the end of the program, before   .ESEG 

    init_sh164.asm        in the segment   .DSEG 

    shift164_macro.asm    at the very top, before   .DSEG

Just in case, each file’s header contains a note about its placement
and its functions.

==============================================================================
Working with the library:

To work with the library, you need to place its files in the project body
(see above), and configure the following parameters 
in the initialization file `init_sh164.asm`:

    bufsize    ; sending buffer size 0..RAMEND
               ; e.g., for a 14-bit buffer you need to allocate 2 bytes
    
    shport     ; PORTx to which the shift register is connected
    shpin      ; PINx of the port to which the shift register is connected
    shddr      ; DDRx of the port to which the shift register is connected
    shbit      ; Data output pin
    clbit      ; Clock strobe output pin

    BTCOUNT    ; Register for bit counter        0..7
    BUFCOUNT   ; Register for buffer counter     0..bitsize
    BUFREG     ; Intermediate buffer register

All registers are pushed onto the stack at the beginning of the send
function and used only within it. After sending, they are restored.
[!!!] If these registers are used in interrupts, 
interrupts must be disabled before calling the send function! 
Otherwise, there is a risk of corrupting the transmission.

For convenient access to the sending buffer `sBUF`, I wrote several macros:

    OUTsBUF       Write a BYTE into the sBUF buffer
                  @0 - Byte number in the buffer [0..bufsize]
                  @1 - Data

    OUTRsBUF      Write the CONTENT of a REGISTER into the sBUF buffer
                  @0 - Byte number in the buffer [0..bufsize]
                  @1 - Register being sent

    SETsBUF       Set a BIT in the sBUF buffer
                  @0 - Byte number in the buffer [0..bufsize]
                  @1 - Bit number within the specific byte [0..7]

    CLRsBUF       Clear a BIT in the sBUF buffer
                  @0 - Byte number in the buffer [0..bufsize]
                  @1 - Bit number within the specific byte [0..7]

To transmit data from the buffer to the registers, you just need to call the function:

    RCALL   SHIFTOUT

#### UPD

Added usage example **T13_LED_Line_bargraph**. 
A controller for an LED line consisting of 24 LEDs and 3 shift registers.
The example implements a cyclically moving dot.

### Instruction

```
//  //////////////////////////////////////////////////////////////////////////
//  /////////                                                      ///////////
//  /////////         Adding to the Project                        ///////////
//  /////////                                                      ///////////
//  //////////////////////////////////////////////////////////////////////////

==============================================================================
The library consists of three files:

	shift164.asm		main library file

	init_sh164.asm		initialization for the library – here you do all
				necessary settings

	shift164_macro.asm	macros for working with the library. 
				Service macros are mandatory, 
				while working macros can be customized or deleted.
==============================================================================
Files are connected to the project with the command:

	.include "shift164_macro.asm"

==============================================================================
File placement in the project:

	shift164.asm		at the end of the program, before   .ESEG 

	init_sh164.asm		in the segment   .DSEG 

	shift164_macro.asm	at the very top, before   .DSEG

Just in case, in each file's header, there is a reminder about its placement
and functions.

==============================================================================
Working with the library:

To work with the library, you need to place its files in the project body
(see above), and configure the following parameters 
in the initialization file `init_sh164.asm`:

	bufsize	 ; send buffer size 0..RAMEND
	         ; e.g., for a 14-bit buffer you need to allocate 2 bytes
	
	shport 	 ; PORTx of the port to which the shift register is connected
	shpin 	 ; PINx of the port
	shddr 	 ; DDRx of the port
	shbit	 ; Data output pin
	clbit	 ; Clock strobe pin

	BTCOUNT	 ; Register for bit counter 	0..7
	BUFCOUNT ; Register for buffer counter 	0..bitsize
	BUFREG   ; Intermediate buffer register

All registers are pushed onto the stack at the beginning of the sending
function and used only within it. After sending, they are restored.
[!!!] If these registers are used in interrupts, 
interrupts must be disabled before calling the sending function! 
Otherwise, there is a high risk of corrupting the transmission.

For convenient access to the sending buffer `sBUF`, several macros were created:

	OUTsBUF		Write a BYTE to the sBUF buffer
			@0 - Byte number in the buffer [0..bufsize]
			@1 - Data

	OUTRsBUF	Write the content of a REGISTER to the sBUF buffer
			@0 - Byte number in the buffer [0..bufsize]
			@1 - Register to be sent

	SETsBUF		Set a BIT in the sBUF buffer
			@0 - Byte number in the buffer [0..bufsize]
			@1 - Bit number within the specific byte [0..7]

	CLRsBUF		Clear a BIT in the sBUF buffer
			@0 - Byte number in the buffer [0..bufsize]
			@1 - Bit number within the specific byte [0..7]

To send data from the buffer to the registers, simply call the function:

	RCALL	SHIFTOUT

//////////////////////////////////////////////////////////////////////////////
// Enjoy! ////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
```


