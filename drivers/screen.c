#include "./screen.h"
#include "./port_io.h"

void printChar(char character, int col, int row, char colorByte) {
	unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

	if (!colorByte) {
		colorByte = WHITE_ON_BLACK;
	}

	int offset;
	if (col >= 0 && row >= 0) {
		offset = getScreenOffset(col, row);
	} else {
		offset = getCursor();
	}

	if (character == '\n') {
		int rows = offset / (2 * MAX_COLS);
		offset = getScreenOffset(79, rows);
	} else {
		vidmem[offset] = character;
		vidmem[offset + 1] = colorByte;
	}

	offset += 2;

	offset = handleScroll(offset);
	setCursor(offset);
}

void printAt(char* message, int col, int row) {
	if (col >= 0 && row >= 0) {
		setCursor(getScreenOffset(col, row));
	}

	int i = 0;
	while (message[i] != 0) {
		printChar(message[i++], col, row, GREEN_ON_BLACK);
	}
}

void print(char* message) {
	printAt(message, -1, -1);
}

void memoryCopy(char* source, char* dest, int numBytes) {
	for (int i = 0; i < numBytes; i++) {
		*(dest + i) = *(source + i);
	}
}

int handleScrolling(int offset) {
	if (offset < MAX_ROWS * MAX_COLS * 2) {
		return offset;
	}

	int i;
	for (i = 1; i < MAX_ROWS; i++) {
		memoryCopy(getScreenOffset(0, i) + VIDEO_ADDRESS,
							 getScreenOffset(0, i - 1) + VIDEO_ADDRESS,
							 MAX_COLS * 2);
	}

	char* lastLine = getScreenOffset(0, MAX_ROWS - 1) + VIDEO_ADDRESS;
	for (i = 0; i < MAX_COLS * 2; i++) {
		lastLine[i] = 0;
	}

	offset -= 2 * MAX_COLS;
	return offset;
}

int getCursor() {
	sendByteToPort(REG_SCREEN_CTRL, 14);
	int offset = getByteFromPort(REG_SCREEN_DATA) << 8;
	sendByteToPort(REG_SCREEN_CTRL, 15);
	offset += getByteFromPort(REG_SCREEN_DATA);

	return offset * 2;
}

void setCursor(int offset) {
	offset /= 2;

	sendByteToPort(REG_SCREEN_CTRL, 15);
	sendByteToPort(REG_SCREEN_DATA, offset);
	offset = offset >> 8;
	sendByteToPort(REG_SCREEN_CTRL, 14);
	sendByteToPort(REG_SCREEN_DATA, offset);
}

void clearScreen() {
	for (int row = 0; row < MAX_ROWS; row++) {
		for (int col = 0; col < MAX_COLS; col++) {
			printChar(' ', col, row, WHITE_ON_BLACK);
		}
	}

	setCursor(getScreenOffset(0, 0));
}
