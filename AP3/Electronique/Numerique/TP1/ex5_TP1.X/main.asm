
#include "p18f45k20.inc"
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

GPR_VAR        UDATA
    taille_tableau	RES	    1
    min	    RES	    1	
    max	    RES	    1
    iterator	RES	1
	    
	    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

cherche_min:
    ; init iterator
    MovF taille_tableau, 0
    MovWF iterator
    ; reset array
    MovLW 0x00
    MovWF FSR0L
    ; init min
    MovF INDF0, 0
    MovWF min
MIN_LOOP
    MovF POSTINC0, 0
    CPFSLT min
    MovWF min
    DECFSZ iterator
    GOTO MIN_LOOP
RETURN
    
cherche_max:
    ; init iterator
    MovF taille_tableau, 0
    MovWF iterator
    ; reset array
    MovLW 0x00
    MovWF FSR0L
    ; init max
    MovF INDF0, 0
    MovWF max
MAX_LOOP
    MovF POSTINC0, 0
    CPFSGT max
    MovWF max
    DECFSZ iterator
    GOTO MAX_LOOP
RETURN
    
ecrire_tableau:
    MovLW d'25'
    MovWF POSTINC0
    MovLW d'4'
    MovWF POSTINC0
    MovLW d'2'
    MovWF POSTINC0
    MovLW d'15'
    MovWF POSTINC0
    MovLW d'16'
    MovWF POSTINC0
    MovLW d'101'
    MovWF POSTINC0
    MovLW d'33'
    MovWF POSTINC0
    MovLW d'3'
    MovWF POSTINC0
    
    MovLW d'8'
    MovWF taille_tableau
RETURN
 
DEBUT

    ; init
    MovLW 0x01
    MovWF FSR0H
    MovLW 0x00
    MovLW FSR0L
  
    CALL ecrire_tableau
    CALL cherche_min
    CALL cherche_max
   
    GOTO $
    
    END