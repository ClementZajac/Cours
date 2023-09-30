
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
    CPFSLT min
    MovWF min
RETURN
    
cherche_max:
    CPFSGT max
    MovWF max
RETURN
    
ecrire_tableau:
    CODE 0x100
	DB d'25',d'4',d'2',d'15',d'16',d'101',d'33',d'3'
    MovLW d'8'
    MovWF taille_tableau
RETURN
 
DEBUT
    CALL ecrire_tableau
   
        ; init iterator
    MovF taille_tableau, 0
    MovWF iterator
    ; reset array
    MovLW 0x01
    MovWF TBLPTRH
    MovLW 0x00
    MovWF TBLPTRL
    ; init max and min
    TBLRD *
    MovF TABLAT, 0
    MovWF max
    MovWF min
LOOP
    TBLRD *+
    MovF TABLAT, 0
    CALL cherche_min
    CALL cherche_max
    DECFSZ iterator
    GOTO LOOP
    GOTO $
    
    END