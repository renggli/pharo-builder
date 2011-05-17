#include <stdio.h>
#include <stdlib.h>

void help(void) {
	printf("build-resize image width height\n");
}

int main(int argc, const char* argv[]) {

	// check number of arguments
	if (argc != 4) {
		help();
		return 1;
	}

	// extract arguments
	int width = atoi(argv[2]);
	int height = atoi(argv[3]);

	// check width
	if (width <= 0 || width > 0xFFFF) {
		fprintf(stderr, "build-resize: invalid width (%d)\n", width);
		return 1;
	}

	// check height
	if (height <= 0 || height > 0xFFFF) {
		fprintf(stderr, "build-resize: invalid height (%d)\n", height);
		return 1;
	}

	// open image
	FILE *fimage = fopen(argv[1], "rb+");
	if (fimage == NULL) {
		fprintf(stderr, "build-resize: invalid image (%s)\n", argv[1]);
		return 1;
	}

	// patch image file
	int size = (width << 16) | (height & 0xFFFF);
	fseek(fimage, 24, SEEK_SET);
	fwrite(&size, sizeof(size), 1, fimage);

	// close file
	fclose(fimage);

	// success
	return 0;

}
