AS_OPTS = -c 
C_OPTS= -std=gnu99 -g 

all: scanner

scanner.c: flex_input.flex
	flex -o $@ $<

scanner.o: scanner.c
	gcc $(C_OPTS) -c $<

scanner: scanner.o
	gcc $(C_OPTS) $^ -o $@


clean:
	rm *.o
	rm scanner.c
	rm scanner
