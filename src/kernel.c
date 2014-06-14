void print(char*);

void main(void) {
	char* string = "Muppix 0.0.1\0";
	print(string);
}

void print(char* text) {	
	char *video = (char*)0xB8000;
	while ( *text != 0 ) {
		*video++ = *text++;
		*video++ = 0x0f;
	}
}
