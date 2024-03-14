#include "SymbolTable.h"
#include <string.h>
#define MAXFAULT 3

agenzina* array_agenzie[MAX_AGENZIE];
stanzetta* array_stanze[MAX_TIPO_STANZE];

void init(){
    printf("Sto iniziando il parsing\n");
}

void aggiungiStanza(char* tipostanza, int prezzo, int index){
    stanzetta *stanza = malloc(sizeof(stanzetta));
    stanza->prezzo = prezzo;
    stanza->tipostanza = strdup(tipostanza);
    array_stanze[index] = stanza;
    return;
}

void aggiungiAgenzia(char* nomeagenzia, char* codice, int partecipanti, int periodo, int index){
    agenzina *agenzia = malloc(sizeof(agenzina));
    agenzia->codice = strdup(codice);
    agenzia->nomeagenzia = strdup(nomeagenzia);
    agenzia->partecipanti = partecipanti;
    agenzia->periodo = periodo;
    array_agenzie[index] = agenzia;
    return;
}

void aggiungiPrenotazione(char* tipostanza, int prenotate, int index, int indexpren){
    prenotazione* pren = malloc(sizeof(prenotazione));
    pren->tipostanza = strdup(tipostanza);
    pren->prenotate = prenotate;
    array_agenzie[index]->array_pren[indexpren] = pren;
    return;
}

int cercaStanza(char* room){
    for(int i=0; i<MAX_TIPO_STANZE; i++){
        if(strcmp(room, array_stanze[i]->tipostanza) == 0){
            return array_stanze[i]->prezzo;
        }
    }
}

float applicaSconto(float prezzo, int partecipanti){
    if(partecipanti>=30 && partecipanti < 50){
        prezzo -= (prezzo*15)/100;
    }
    else if(partecipanti > 50){
        prezzo -= (prezzo*25)/100;
    }
    return prezzo;
}

float calcolaprezzo(int index){
    int prezzoattuale = 0;
    float prezzorelativo = 0.0;
    for(int i=0; i<MAX_AGENZIE; i++){
        prezzoattuale += cercaStanza(array_agenzie[index]->array_pren[i]->tipostanza) * array_agenzie[index]->periodo * array_agenzie[index]->partecipanti;
    }
    prezzorelativo = applicaSconto(prezzoattuale, array_agenzie[index]->partecipanti);
    return prezzorelativo;
    
}

void printTotal(){
    int index = 0;
    float guadagnotot = 0;
    for(index; index < MAX_AGENZIE; index++){
        float prezzofinale = 0;
        prezzofinale = calcolaprezzo(index);
        guadagnotot += prezzofinale;
        fprintf(stdout,"\"%s - %s - %f", array_agenzie[index]->nomeagenzia, array_agenzie[index]->codice, prezzofinale);
    }
    fprintf(stdout, "Il guadagno totale dell'Hotel ammonta a: %f", guadagnotot);
}