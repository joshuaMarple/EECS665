LEX=lex
YACC=yacc
CC=gcc

LFLAGS=
YFLAGS= -v
CFLAGS=-Wall -Wno-unused-label -Wno-unused -I. -DNDEBUG

all: parser

parser: parser.yacc.o Scanner.lex.o
	$(CC) -o $@ $+

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.lex.c: %.l
	$(LEX) $(LFLAGS) -o $@ $<

%.yacc.c: %.y
	$(YACC) $(YFLAGS) -d -o $@ $<

%.png: %.dot
	dot -Tpng -o $@ $<

test: all
	./parser < test.c > test.dot

clean:
	$(RM) *.o
	$(RM) *.lex.c
	$(RM) *.yacc.c
	$(RM) *.yacc.h
	$(RM) *.yacc.output
	$(RM) *.dot
	$(RM) *.png
	$(RM) parser

.PHONY: clean all test
