AS_OPTS = -c 
C_OPTS= -std=gnu99


all: asmb.o main.o
	gcc -g $^ -o main

main.o: main.c
	gcc $(C_OPTS) -g -c $< -o $@


asmb.o: asmb.s
	gcc -c -g asmb.s 

clean:
	rm *.o
