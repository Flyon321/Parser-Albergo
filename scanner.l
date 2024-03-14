%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include "parser.tab.h" 
%}

%option noyywrap
%option yylineno

cifre        [0-9]
mese         {cifre}{2}
anno         {cifre}{4}
DATA         {mese}-{anno}
numeri       {cifre}+
caratteri    [a-z]
CARATTERI    [A-Z]
SEP1         ^&&&$
STANZA       ({CARATTERI}{caratteri}*)([ ]*({caratteri}))*
SEP2         ^!!!$
agenzia      ({CARATTERI}|{caratteri}){caratteri}*
AGENZIA      \"({agenzia})([ ]*({agenzia}))*\"
AGENZIACOD   {cifre}{4}\/{CARATTERI}{2}
PAR_AP       \(
PAR_CH       \)
FRECCIA      \-\>
TRATTINO     \-
MAGGIORE     \>
PUNTOEVIRG   \;

%%

{SEP1}              {yylval.string = strdup(yytext); return sep1;}
{DATA}              {int date[2]; date[0] = atoi(strtok(yytext,"-")); date[1] = atoi(strtok(NULL,"-")); yylval.int_vec = &date;  return DATA;}
{STANZA}            {yylval.string = strdup(yytext); return stanza;}
{FRECCIA}           {yylval.string = strdup(yytext); return freccia;}
{SEP2}              {yylval.string = strdup(yytext); return sep2;}
{AGENZIA}           {yylval.string = strdup(yytext); return agenzia;}
{AGENZIACOD}        {yylval.string = strdup(yytext); return codice;}
{numeri}            {yylval.intero = atoi(yytext);  return numero;}
{PAR_AP}            {yylval.string = strdup(yytext); return apriparentesi;}
{PAR_CH}            {yylval.string = strdup(yytext); return chiudiparentesi;}
{MAGGIORE}          {yylval.string = strdup(yytext); return maggiore;}
{TRATTINO}          {yylval.string = strdup(yytext); return trattino;}
{PUNTOEVIRG}        {yylval.string = strdup(yytext); return puntoevirgola;}
\n                  ;

%%