%{
    #include<stdio.h>
    #include<stdbool.h>
    #include<malloc.h>

    int yywrap(void) 
    {
        return 1;
    }

    void AddPal(char* palavra);
    void NumFrase();
    double DenLex();
    double NumPalavraMedio();

    int numPalavras = 0;
    int numUnicas = 0;
    int numFrase = 0;

    struct Palavra
    {
       char* descricao;
    };

    struct Palavra lista[1000];

    int pos = 0;

%}

%s FRASE

%%

[A-Z][a-z]*                     { AddPal(yytext);  BEGIN(FRASE); }
<FRASE>[a-zA-Z][a-zA-Z]*        { AddPal(yytext); }
<FRASE>[0-9]+                   { AddPal(yytext); }
<FRASE>['\.']                   { NumFrase(); BEGIN(INITIAL); }
<FRASE>['\ '] 

%%

int main (int arc, char *argv[])
{
    yyin = fopen(argv[1], "r");

    for(int i=0; i<1000; i++)
    {
       lista[i].descricao = malloc(sizeof(char) * 1024);
    }    

    yylex();

    printf("Numero de palavras: %d \n", numPalavras);
    printf("Numero de palavras unicas: %d \n", numUnicas);
    printf("Numero de frases: %d \n", numFrase);
    printf("Numero medio de palavras por frase: %.2f \n", NumPalavraMedio());
    printf("Densidade lexica: %.2f \n\n", DenLex());
}

void AddPal(char* palavra)
{    
    numPalavras++;

    bool achaPalavrs = false; 

    for(int i=0; i<pos; i++)
    {	
        if(strcmp(lista[i].descricao,palavra) == 0)
        {
	    achaPalavrs = true;
	    break;
        }
    }

    if(achaPalavrs)
    {
        return;
    }
    
    numUnicas++;

    int length = sizeof(char) * (strlen(palavra) + 1);
    lista[pos].descricao = malloc(length);
    memset(lista[pos].descricao, 0, length);
    memcpy(lista[pos].descricao, palavra, length);

    pos++;
} 

void NumFrase()
{
    numFrase++;
}

double DenLex()
{
    double unicas = (double) numUnicas;
    double tPalavras = (double) numPalavras;
    double rDiv = unicas/tPalavras;

    return (rDiv)*100;
}

double NumPalavraMedio()
{
   double tPalavras = (double) numPalavras;
   double tFrases = (double) numFrase;
   return tPalavras / tFrases;
}



