AS_OPTS = -c
C_OPTS= -std=gnu99 -g
DEBUG_PARSER = 
all: parser

lexer.c: oxout.l
	flex -o $@ $<

grammar.h grammar.c: oxout.y
	bison $(DEBUG_PARSER) -v -o grammar.c -d $<

functions.o: functions.c
	gcc $(C_OPTS) -c $< -o $@

parser.o: grammar.c
	gcc $(C_OPTS) -c $< -o $@

lexer.o: lexer.c grammar.h
	gcc $(C_OPTS) -c $<


parser: functions.o parser.o lexer.o
	gcc $(C_OPTS) $^ -o $@

grammar.ox: grammar.y
	echo "update grammar.ox"

ox oxout.l oxout.y: grammar.ox
	ox grammar.ox flex_input.lex


test: parser
	./$< < testFile

clean:
	rm *.o grammar.h grammar.c
	rm parser
	rm grammar.output
	rm oxout*
