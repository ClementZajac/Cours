
; PIC18F45K20 Configuration Bit Settings

; Assembly source line config statements

#include "p18f45k20.inc"

; CONFIG1H
  CONFIG  FOSC = INTIO7         ; Oscillator Selection bits (Internal oscillator block, CLKOUT function on RA6, port function on RA7)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 18             ; Brown Out Reset Voltage bits (VBOR set to 1.8 V nominal)

; CONFIG2H
  CONFIG  WDTEN = OFF           ; Watchdog Timer Enable bit (WDT is controlled by SWDTEN bit of the WDTCON register)
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = PORTC        ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  HFOFST = ON           ; HFINTOSC Fast Start-up (HFINTOSC starts clocking the CPU without waiting for the oscillator to stablize.)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection Block 0 (Block 0 (000800-001FFFh) not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection Block 1 (Block 1 (002000-003FFFh) not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection Block 2 (Block 2 (004000-005FFFh) not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection Block 3 (Block 3 (006000-007FFFh) not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection Block 0 (Block 0 (000800-001FFFh) not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection Block 1 (Block 1 (002000-003FFFh) not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection Block 2 (Block 2 (004000-005FFFh) not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection Block 3 (Block 3 (006000-007FFFh) not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot Block (000000-0007FFh) not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection Block 0 (Block 0 (000800-001FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection Block 1 (Block 1 (002000-003FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection Block 2 (Block 2 (004000-005FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection Block 3 (Block 3 (006000-007FFFh) not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot Block (000000-0007FFh) not protected from table reads executed in other blocks)

GPR_VAR        UDATA
    ledState	RES	    1
    T0CON_TMP	RES	    1
;    min	    RES	    1	
;    max	    RES	    1
;    iterator	RES	1
	    
	    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

ISRHV     CODE    0x0008
    GOTO    HIGH_ISR
    
ISRH      CODE                     ; let linker place high ISR routine
HIGH_ISR
    MovFF T0CON, T0CON_TMP
    CALL reset_timer_mili
    CALL start_timer
    CALL routine_tempo
    MovFF T0CON_TMP, T0CON
    BTG T0CON, 7
    BCF INTCON, 1
    RETFIE  FAST
; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

init_routine_tempo:
    MovLW b'00000011'
    MovWF T0CON
    CALL reset_timer
RETURN
    
init_interrupt:
    BSF INTCON, 7
    BSF INTCON, 6
    BSF INTCON, 4
    BCF INTCON2, 6
RETURN

reset_timer:
    MovLW 0x0B
    MovWF TMR0H
    MovLW 0xDC
    MovWF TMR0L
    BCF INTCON, 2
RETURN
    

reset_timer_mili:
    MovLW 0xE7
    MovWF TMR0H
    MovLW 0x95
    MovWF TMR0L
    BCF INTCON, 2
    
RETURN
    
start_timer:
	BSF T0CON, 7
RETURN
 
routine_tempo:
LOOP0
    BTFSS INTCON, 2
    GOTO LOOP0
    CALL reset_timer
RETURN
    
 
DEBUT
    CALL init_interrupt
    ;init routine tempo
    CALL init_routine_tempo
    ;init oscilator
    BSF OSCCON, 6, 0
    BCF OSCCON, 5, 0
    BSF OSCCON, 4, 0
    BSF OSCCON, 1, 0
    ; init output
    CLRF TRISD, 0 
    MovLW b'10101010'
    MovWF ledState
    CALL start_timer
LOOP
    MovF ledState, 0
    XORLW h'FF'
    MovWF ledState
    MovWF PORTD
    CALL routine_tempo
    GOTO LOOP                          ; loop forever

    END