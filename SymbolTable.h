#include <stdio.h>
#include <stdlib.h>
#define MAX_TIPO_STANZE 10
#define MAX_PRENOTAZIONI 10
#define MAX_AGENZIE 10

extern FILE* yyin;
extern int yylineno;

typedef struct Stanza{
    char* tipostanza;
    int prezzo;
} stanzetta;


typedef struct Prenotazione{
    char* tipostanza;
    int prenotate;
} prenotazione;


typedef struct Agenzia{
    char* nomeagenzia;
    char* codice;
    int partecipanti;
    int periodo;
    prenotazione* array_pren[MAX_PRENOTAZIONI];
} agenzina;

void aggiungiStanza(char* tipostanza, int prezzo, int index);
void aggiungiAgenzia(char* nomeagenzia, char* codice, int partecipanti, int periodo, int index);
void aggiungiPrenotazione(char* tipostanza, int prenotate, int index, int indexpren);
void init();
void printTotal();
float calcolaprezzo();
int cercaStanza(char* room);