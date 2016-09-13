%option noyywrap 
 
%{ 
 
#include <stdio.h> 
#include <time.h> 
 
int numlines = 0;
int numComentarios = 0; 
int numLinhaBranca = 0;
int numDeStrings = 0;
%} 
 
%% 

\private([ \t]|[a-zA-Z]|[0-9]|"("|")")+\{     printf("%s ","Método: "); printf("%s\n",yytext);
\public([ \t]|[a-zA-Z]|[0-9]|"("|")")+\{     printf("%s ","Classe: "); printf("%s\n",yytext);
[ \t]+\n  numLinhaBranca++;
"//"    numComentarios++;
\"("/")?([a-zA-Z]|[0-9])+\" numDeStrings++; 
\n    numlines++; 
.
 
%% 
 
int main(int argc, char *argv[]){ 
    yyin = fopen(argv[1], "r"); 
    yylex(); 
    fclose(yyin); 
    printf("Número de linhas: %d\n", numlines);
    printf("Número de comentarios: %d\n", numComentarios);
    printf("Número de Linha em branco: %d\n", numLinhaBranca);
    printf("Número de Strings: %d\n", numDeStrings); 
    return 0; 
}

