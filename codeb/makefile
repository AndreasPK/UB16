AS_OPTS = -c
C_OPTS= -std=gnu99 -D_GNU_SOURCE -g -DUSE_IBURG -DBURM
DEBUG_PARSER = --debug
NAME = codeb

all: $(NAME)

lexer.c: oxout.l
	flex -o $@ $<

grammar.h grammar.c: oxout.y
	bison $(DEBUG_PARSER) -v -o grammar.c -d $<

parser.o: grammar.c
	gcc $(C_OPTS) -c $< -o $@

lexer.o: lexer.c grammar.h
	gcc $(C_OPTS) -c $<

passes.o: passes.c passes.h
	gcc $(C_OPTS) -c $<

burg.c: burg.bfe
	bfe < $< | iburg > $@

burg.o: burg.c
	gcc -c $(C_OPTS) -D_BURM_WTF $< -o $@

symbolpass.o: symbolpass.c passes.h
	gcc $(C_OPTS) -c $< -o $@

$(NAME): passes.o parser.o lexer.o burg.o symbolpass.o
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
	rm *.o grammar.h grammar.c lexer.c burg.c -f
	rm $(NAME) -f
	rm grammar.output -f
	rm oxout* -f
