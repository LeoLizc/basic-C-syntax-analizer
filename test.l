%{
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "y.tab.h"

extern void yyerror(char *s);
extern YYSTYPE yylval;
%}
%option yylineno

NENTERO -?[0-9]+
NFLOTANTE -?[0-9]+(\.[0-9]+)?([e|E][-|+]?[0-9]+)?
Main main
LIBRERIA stdio.h|string.h|ctype.h|stdbool.h
PARENT_A \(
PARENT_C \)
VOID void
inicio_key \{
fin_key \}
INT int
CHAR char
FLOAT float
op_asign \=
op_plus_asign \+\=
op_minus_asign \-\=
op_mult_asign \*\=
op_div_asign \/\=
op_mod_asign \%\=
op_mult \*
op_div \/
op_sum \+
op_sust \-
op_mod \%
incremento \+\+
decremento \-\-
IF if
ELSE else
SWTICH switch
PRINTF printf
SCANF scanf
COMA ,
DOS_PUNTOS :
PUNTO_COMA ;
IGUAL \=\=
DIFERENTE \!\=
MENOR_IGUAL \<\=
MAYOR_IGUAL \>\=
MAYOR \>
MENOR \<
AND \&\&
OR \|\|
NO \!
espacio [ ]
caracter \'.\'
IDENTIFICADOR [a-zA-Z|_][0-9a-zA-Z|_]*
FOR for
WHILE while
DO do
comentario_linea "//".*" "*
comentario_bloque \/\*(.*\n)*.*\*\/
cadena \".*\"
tabulacion \t*
salto_linea \n



%%

{espacio}           {}
{tabulacion}        {}
{salto_linea}       {}
{comentario_linea}  {}
{comentario_bloque} {}
{cadena}            {return STRING;}
{caracter}          {return TCHAR;}
{Main}              {return MAIN;}
{PARENT_A}          {return OPEN_BRACKET;}
{PARENT_C}          {return CLOSE_BRACKET;}
{VOID}              {return VOID;}
{inicio_key}        {return OPEN_BRACE;}
{fin_key}           {return CLOSE_BRACE;}
{INT}               {return INT;}
{CHAR}              {return CHAR;}
{FLOAT}             {return FLOAT;}
{incremento}        {return INCREMENT;}
{decremento}        {return DECREMENT;}
{op_plus_asign}     {return PLUSASSIGN;}
{op_minus_asign}    {return MINUSASSIGN;}
{op_mult_asign}     {return MULTASSIGN;}
{op_div_asign}      {return DIVASSIGN;}
{op_mod_asign}      {return MODASSIGN;}
{op_asign}          {return ASSIGN;}
{op_mult}           {return MULTIPLY;}
{op_div}            {return DIVIDE;}
{op_sum}            {return PLUS;}
{op_sust}           {return MINUS;}
{op_mod}            {return MODULO;}
{IF}                {return IF;}
{ELSE}              {return ELSE;}
{SWTICH}            {return SWITCH;}
{PRINTF}            {return PRINT;}
include             {return INCLUDE;}
{LIBRERIA}          {return LIBRARY;}
return              {return RETURN;}
break               {return BREAK;}
continue            {return CONTINUE;}
case                {return CASE;}
default             {return DEFAULT;}
{SCANF}             {return SCANF;}
{COMA}              {return COMMA;}
{DOS_PUNTOS}        {return COLON;}
{PUNTO_COMA}        {return SEMICOLON;}
{IGUAL}             {return EQUAL;}
{DIFERENTE}         {return NOT_EQUAL;}
{MENOR_IGUAL}       {return LESS_EQUAL;}
{MAYOR_IGUAL}       {return GREATER_EQUAL;}
{MAYOR}             {return GREATER;}
{MENOR}             {return LESS;}
{AND}               {return AND;}
{OR}                {return OR;}
{NO}                {return NOT;}
{NENTERO}           {return NUM_INT;}
{NFLOTANTE}         {return NUM_REAL;}
{FOR}               {return FOR;}
{WHILE}             {return WHILE;}
{DO}                {return DO;}
{NENTERO}{IDENTIFICADOR}  { return TERROR; }
{IDENTIFICADOR}     {return ID;}
. {yyerror("IDK");}


%%
int yywrap(){
    return 1;
}