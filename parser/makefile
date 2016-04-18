AS_OPTS = -c
C_OPTS= -std=gnu99 -g

all: parser

lexer.c: flex_input.lex
	flex -o $@ $<

grammar.h grammar.c: grammar.y
	yacc -o grammar.c -d $<

parser.o: grammar.c
	gcc $(C_OPTS) -c $< -o $@

lexer.o: lexer.c grammar.h
	gcc $(C_OPTS) -c $<


parser: parser.o lexer.o
	gcc $(C_OPTS) $^ -o $@

test: parser
	./$< < testFile

clean:
	rm *.o *.h *.c
	rm parser
