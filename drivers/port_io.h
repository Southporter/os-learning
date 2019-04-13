#ifndef PORT_IO_H
#define PORT_IO_H

unsigned char getByteFromPort(unsigned short port);
unsigned char getWordFromPort(unsigned short port);
void sendByteToPort(unsigned short port, unsigned char data);
void sendWordToPort(unsigned short port, unsigned short data);

#endif
