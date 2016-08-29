%option noyywrap

%{

#include <stdio.h>
#include <time.h>

int numpalavras = 0;

%}

%%

[a-z]+	numpalavras++; 
.|\n|\r


%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	printf("Número de palavras: %d\n", numpalavras);
	return 0;
}
