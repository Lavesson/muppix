void main(void) {
	char* string = "Well, this is embarrassing. I seem to be a pretty retarded OS.\0";
	char *video = (char*)0xB8000;
	while ( *string != 0 ) {
		*video++ = *string++;
		*video++ = 0x1f;
	}
}
