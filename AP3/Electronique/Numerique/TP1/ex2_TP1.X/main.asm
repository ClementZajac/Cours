; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    GPR_VAR        UDATA
    somme	    RES     1      ; User variable linker places
    incrementeur    RES     1      ; User variable linker places
    longueur	    RES	    1
	    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

DEBUT

    ; init
    MovLW d'0'
    MovWF incrementeur
    MovLW d'19'
    MovWF longueur
    MovLW d'0'
    MovWF somme
  
    
    ; 1st loop
L1
    MovF somme, 0
    ADDWF incrementeur, 0
    MovWF somme
    INCF incrementeur
    MovF incrementeur, 0
    CPFSLT longueur
    GOTO L1

    END