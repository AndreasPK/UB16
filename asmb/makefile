AS_OPTS = -c 
C_OPTS= -std=gnu99


all: asmb.o 

main.o: main.c
	gcc $(C_OPTS) -g -c $< -o $@


asmb.o: asmb.s
	gcc -c -g $< 

clean:
	rm *.o
