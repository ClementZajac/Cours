/*
 * File:   spi.c
 * Author: lal
 *
 * Created on 9 avril 2015, 07:44
 */

#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include "general.h"
#include "lcd.h"
#include "spi.h"

void SPIInit(void) {

    SPI_SCK_DIR = OUTP;                     // SCK
    ANSELDbits.ANSD0 = DISABLE;             // disable analog input for SCK
    SPI_SDI_DIR = INP;                      // SDI
    ANSELDbits.ANSD1 = DISABLE;             // disable analog input for SDI
    SPI_SDO_DIR = OUTP;                     // SDO
    ANSELDbits.ANSD4 = DISABLE;             // disable analog input for SDO


    SPI_SS_DIR = OUTP;                      // SS/
    SPI_SS_LAT = SPI_SS_DISABLE;            // disable SS/

    SPI_RESET_DIR = OUTP;                   // RESET/
    SPI_RESET_LAT = SPI_RESET_DISABLE;      // disable RESET/ (use power-on reset)

    SSP2STATbits.SMP = CLEAR;               // SMP=0 (input sampled at middle of output), CKE=1 (transmit from active to idle SCK state)
    SSP2STATbits.CKE = SET;
    SSP2CON1bits.SSPEN = SET;               // WCOL not used in SPI mode, SSPOV not used in SPI master mode
                                            // SSPEN set, CKP cleared (idle state low level)
                                            // SSP2CON1<3:0> = 0000 (clock = FOSC / 4) = 250kHz

//    SPIWrite(SPI_SLAVE_IOCON, 0x28);        // SEQOP = 1 (disabled), HAEN = 1 (enable address pins)
//    SPIWrite(SPI_SLAVE_IODIR, 0xff);        // GPIO as input
//    SPIWrite(SPI_SLAVE_GPPU, 0xff);         // internal pull-up

    SPIReadWrite(WRITE, SPI_SLAVE_IOCON, 0x28); // SEQOP = 1 (disabled), HAEN = 1 (enable address pins)
    SPIReadWrite(WRITE, SPI_SLAVE_IODIR, 0xff); // GPIO as input
    SPIReadWrite(WRITE, SPI_SLAVE_GPPU, 0xff);  // internal pull-up
}

UINT8_T SPIRead(UINT8_T regAddr) {
    UINT8_T dummy, data_in;

    SPI_SS_LAT = SPI_SS_ENABLE;             // enable slave

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = SPI_SLAVE_ID | ((SPI_SLAVE_ADDR << 1) & 0x06)| SPI_SLAVE_READ; // send opcode transmission
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = regAddr;                      // send register address
    _delay(10);
    while (!PIR3bits.SSP2IF);

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = 0x00;                         // initiate bus cycle
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    data_in = SSP2BUF;                      // read incoming data

    SPI_SS_LAT = SPI_SS_DISABLE;            // disable slave

    return(data_in);
}

void SPIWrite(UINT8_T regAddr, UINT8_T data_out) {
    UINT8_T dummy;

    SPI_SS_LAT = SPI_SS_ENABLE;             // enable slave

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = SPI_SLAVE_ID | ((SPI_SLAVE_ADDR << 1) & 0x06)| SPI_SLAVE_WRITE; // send opcode transmission
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = regAddr;                      // send register address
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = data_out;
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    SPI_SS_LAT = SPI_SS_DISABLE;            // disable slave
}

UINT8_T SPIReadWrite(UINT8_T mode, UINT8_T regAddr, UINT8_T data_out) { // data_out must be 0x00 if mode = READ
    UINT8_T dummy, data_in;

    SPI_SS_LAT = SPI_SS_ENABLE;             // enable slave

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = SPI_SLAVE_ID | ((SPI_SLAVE_ADDR << 1) & 0x06) | (mode == READ ? SPI_SLAVE_READ : SPI_SLAVE_WRITE); // send opcode transmission
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = regAddr;                      // send register address
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete

    dummy = SSP2BUF;                        // clear BF
    PIR3bits.SSP2IF = CLEAR;                // clear interrupt flag
    SSP2BUF = data_out;
    _delay(10);
    while (!PIR3bits.SSP2IF);               // wait until cycle complete
    data_in = SSP2BUF;

    SPI_SS_LAT = SPI_SS_DISABLE;            // disable slave

    return data_in;
}