

GGG = g++ -O3 -Wall -march=native -fomit-frame-pointer -fexpensive-optimizations
# GGG = clang++ -O3 -Wall -march=native -fomit-frame-pointer

OBJ = mpz_primality_main.o \
      mpz_primality.o \
      expression_parser.a

mpz: $(OBJ)
	$(GGG) -static -o mpz $(OBJ) -lgmp -lpthread -lm

mpz_primality_main.o: mpz_primality_main.cpp mpz_primality.h bison.gmp_expr.tab.h
	$(GGG) -c -o mpz_primality_main.o mpz_primality_main.cpp

mpz_primality.o: mpz_primality.cpp mpz_primality.h
	$(GGG) -c -o mpz_primality.o mpz_primality.cpp

expression_parser.a : bison.gmp_expr.o lex.gmp_expr.o bison.gmp_expr.tab.h
	ar vr expression_parser.a bison.gmp_expr.o lex.gmp_expr.o

bison.gmp_expr.o : bison.gmp_expr.tab.c bison.gmp_expr.h
	$(GGG) -c -o bison.gmp_expr.o bison.gmp_expr.tab.c

bison.gmp_expr.tab.c bison.gmp_expr.tab.h : parser.y
	bison -d parser.y

lex.gmp_expr.o : lex.gmp_expr.c
	$(GGG) -Wno-unused-function -DYY_BUF_SIZE=65540 -DYYLMAX=65540 -c -o lex.gmp_expr.o lex.gmp_expr.c

lex.gmp_expr.c : parser.l bison.gmp_expr.tab.h
	flex parser.l

check: mpz
	./mpz -st

clean:
	rm -f ./mpz $(OBJ) bison.gmp_expr.o bison.gmp_expr.tab.c bison.gmp_expr.tab.h lex.gmp_expr.o lex.gmp_expr.c


