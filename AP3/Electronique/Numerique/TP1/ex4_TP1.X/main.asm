; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    GPR_VAR        UDATA
    somme_Low	    RES     1      ; User variable linker places
    somme_High	    RES     1      ; User variable linker places
    incrementeur    RES     1      ; User variable linker places
    longueur	    RES	    1
	    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

calcul_somme:
    ;init
    MovWF longueur
    MovLW d'0'
    MovWF somme_Low
    MovWF somme_High
    MovLW d'0'
    MovWF incrementeur
     ; 1st loop
L1
    ; add incr to somme
    MovF somme_Low, 0
    ADDWF incrementeur, 0
    MovWF somme_Low
    ; overload management
    BNC NOVERLOAD
    INCF somme_High
NOVERLOAD
    ; if incr INF longeur
    INCF incrementeur
    MovF incrementeur, 0
    CPFSLT longueur
    ; if TRUE
    GOTO L1
    ; if FALSE
RETURN
 
DEBUT

    ; init
    MovLW '40'
  
    CALL calcul_somme
   
    GOTO $
    
    END