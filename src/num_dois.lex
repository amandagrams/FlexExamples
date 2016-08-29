%option noyywrap

%{

#include <stdio.h>
#include <time.h>

int numfrases = 0;

%}

%%

"."|";" numfrases++;
.|\n|\r


%%

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    printf("Número de frases do arquivo: %d\n", numfrases);
    return 0;
}
