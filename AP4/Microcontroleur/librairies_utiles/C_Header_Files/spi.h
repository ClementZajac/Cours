/*
 * File:   spi.h
 * Author: lal
 *
 * Created on 9 avril 2015, 11:12
 */

#ifndef _SPI_H
#define	_SPI_H

#include "general.h"


// MCP23S08 SPI slave device
#define SPI_SLAVE_ID            0x40
#define SPI_SLAVE_ADDR          0x00      // A1=0,A0=0
#define SPI_SLAVE_WRITE         WRITE
#define SPI_SLAVE_READ          READ

// MCP23S08 registers definition (default, see datasheet)
#define SPI_SLAVE_IODIR         0x00
#define SPI_SLAVE_IPOL          0x01
#define SPI_SLAVE_GPINTEN       0x02
#define SPI_SLAVE_DEFVAL        0x03
#define SPI_SLAVE_INTCON        0x04
#define SPI_SLAVE_IOCON         0x05
#define SPI_SLAVE_GPPU          0x06
#define SPI_SLAVE_INTF          0x07
#define SPI_SLAVE_INTCAP        0x08
#define SPI_SLAVE_GPIO          0x09
#define SPI_SLAVE_OLAT          0x0a

// PIC18F46K22 SPI master mode
#define SPI_SCK_DIR             TRISDbits.TRISD0
#define SPI_SDI_DIR             TRISDbits.TRISD1
#define SPI_SDO_DIR             TRISDbits.TRISD4

#define SPI_SS_DIR              TRISEbits.TRISE0
#define SPI_SS_LAT              LATEbits.LATE0

#define SPI_SS_DISABLE          OUTP_HIGH
#define SPI_SS_ENABLE           OUTP_LOW

#define SPI_RESET_DIR           TRISEbits.TRISE1
#define SPI_RESET_LAT           LATEbits.LATE1

#define SPI_RESET_DISABLE       OUTP_HIGH
#define SPI_RESET_ENABLE        OUTP_LOW


void SPIInit(void);                                                     // init SPI in master mode
void SPIWrite(UINT8_T regAddr, UINT8_T data_out);                       // write data to MCP23S08 register
UINT8_T SPIRead(UINT8_T regAddr);                                       // read data from MCP23S08 register
UINT8_T SPIReadWrite(UINT8_T mode, UINT8_T regAddr, UINT8_T data_out);  // read after write

#endif	/* _SPI_H */

