CC=gcc
CFLAGS=-m32 -std=c99

ASM=nasm
AFLAGS=-f elf32

all:turtle

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -lm
turtle.o: turtle.asm
	$(ASM) $(AFLAGS) turtle.asm
turtle: main.o turtle.o
	$(CC) $(CFLAGS) main.o turtle.o -o turtle -lm
clean: 
	rm *.o
	rm turtle
