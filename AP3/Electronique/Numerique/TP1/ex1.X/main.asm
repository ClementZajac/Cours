; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    
    GPR_VAR        UDATA
    COMPTEUR         RES        1      ; User variable linker places
    LONGUEUR         RES        1      ; User variable linker places
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

DEBUT
    MovLW d'9'
    MovWF LONGUEUR
L1
    MovLW d'0'
    MovWF COMPTEUR
L2
    INCF COMPTEUR
    MovF LONGUEUR, 0
    CPFSLT COMPTEUR
    GOTO L1                          ; loop forever
    GOTO L2
    END