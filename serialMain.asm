    ;This is the emiter module 
    #include "configurationBits.h"
    
    #define BR9600 0x19  ; Actually it should be 5.51. 
    #define ASYNH8b b'00100100' ; Asyncronous mode, high speed, enable 
   
    org 0
    bcf BAUDCON,BRG16 ; Baud rate generator 8 bits 'old school'
    movlw b'00100000'
    movwf TXSTA ;
    movlw 0xFF
    movwf SPBRG ;Charging the adecuate value to generate 9600 bauds
    bcf TRISC,6 ;Setting data direction for tx pin 
    bsf RCSTA,SPEN; enabling tx pin
    
    bcf TRISC,2
    bcf LATC,2 
    
data7    movlw 0x07
    nop
    nop
wait    btfss PIR1,TXIF
    bra wait
    btg LATC,2
    movwf TXREG
    bra data7 

    END