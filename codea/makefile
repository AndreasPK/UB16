AS_OPTS = -c
C_OPTS= -std=gnu99 -g -DUSE_IBURG -DBURM
DEBUG_PARSER = --debug
NAME = codea

all: $(NAME)

lexer.c: oxout.l
	flex -o $@ $<

grammar.h grammar.c: oxout.y
	bison $(DEBUG_PARSER) -v -o grammar.c -d $<

parser.o: grammar.c
	gcc $(C_OPTS) -c $< -o $@

lexer.o: lexer.c grammar.h
	gcc $(C_OPTS) -c $<

burg.c: burg.bfe
	bfe < $< | iburg > $@

burg.o: burg.c
	gcc -c $(C_OPTS) -D_BURM_WTF $< -o $@

tree.o: tree.c tree.h
	gcc $(C_OPTS) -c $< -o $@

symbolpass.o: symbolpass.c tree.h
	gcc $(C_OPTS) -c $< -o $@

$(NAME): tree.o parser.o lexer.o burg.o symbolpass.o
	gcc $(C_OPTS) $^ -o $@

grammar.ox: grammar.y
	echo "update grammar.ox"

ox oxout.l oxout.y: grammar.ox
	ox grammar.ox flex_input.lex


test: $(NAME)
	./$< < testFile
	echo Result: $$?

testAsm: $(NAME) testFile
	./$(NAME) < testFile > test.s
	gcc -g test.s -o test
	./test; echo Returned: $$?

clean:
	rm *.o grammar.h grammar.c lexer.c burg.c
	rm $(NAME)
	rm grammar.output
	rm oxout*
