CC=gcc
SCAN_BUILD_DIR = scan-build-out
EXE=output

all: main.o 537malloc.o tree.o 
	$(CC) -o $(EXE) main.o 537malloc.o tree.o

# main.c is your testcase file name
main.o: main.c
	$(CC) -Wall -Wextra -c main.c

# Include all your .o files in the below rule
obj: 537malloc.o tree.o

537malloc.o: 537malloc.c 537malloc.h tree.h
	$(CC) -Wall -Wextra -g -O0 -c 537malloc.c

tree.o: tree.c tree.h
	$(CC) -Wall -Wextra -g -O0 -c tree.c

clean:
	-rm *.o $(EXE)

scan-build: clean
	scan-build -o $(SCAN_BUILD_DIR) make

scan-view: scan-build
	firefox -new-window $(SCAN_BUILD_DIR)/*/index.html
