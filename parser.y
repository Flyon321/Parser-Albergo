%{
    #ifdef YYDEBUG
    yydebug = 1;
    #endif
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>
    #include <limits.h>
    #include "SymbolTable.h"

    int yylex();
    void yyerror(char* s);
    int i = 0;
    int y = 0;
    int z = 0;
%}

%union{
    char* string;
    int intero;
    int *int_vec;
}

%token <string> sep1 stanza freccia sep2 virgolette agenzia trattino codice apriparentesi chiudiparentesi maggiore puntoevirgola
%token <intero> numero
%token <int_vec> DATA
%start INIZIO
%%

INIZIO: DATA sep1 STANZE sep2 PRENOTAZIONI ;
STANZE: TIPOSTANZA STANZE | TIPOSTANZA ;
TIPOSTANZA: stanza freccia numero                          {aggiungiStanza($1, $3, i); i++;};
PRENOTAZIONI: PRENOTAZIONE PRENOTAZIONI | PRENOTAZIONE ;
PRENOTAZIONE: agenzia trattino codice trattino numero trattino numero trattino numero LISTACAMERE  {int periodo = $9-$7; aggiungiAgenzia($1, $3, $5, periodo, y);};
LISTACAMERE: apriparentesi CAMEREPRENOTATE chiudiparentesi ;
CAMEREPRENOTATE: CAMEREPRENOTATECONTINUA | CAMEREPRENOTATEFINE ;
CAMEREPRENOTATECONTINUA: stanza maggiore numero puntoevirgola CAMEREPRENOTATE {aggiungiPrenotazione($1, $3, y, z); z++;};
CAMEREPRENOTATEFINE: stanza maggiore numero {aggiungiPrenotazione($1, $3, y, z); z++; y++;};

%%

void yyerror(char *s){
    printf("Errore Sintattico: CONTROLLARE SINTASSI!");
}

extern FILE* yyin;

int main(int argc, char* argv[]){

    FILE* input_file = fopen(argv[1], "r");
    yyin = input_file;

	init();
	if(yyparse()==0){
		printTotal();
        printf("OK");
    }
    return 0;
}