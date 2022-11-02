%{
    // C Sintax analyser
    void yyerror(char *s);
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    extern int yylineno;
%}

%token NUM_INT NUM_REAL TCHAR STRING
%token ID
%token IF ELSE WHILE DO FOR RETURN PRINT MAIN BREAK CONTINUE SWITCH CASE DEFAULT HASH INCLUDE SCANF
%token INT FLOAT CHAR VOID
%token OPEN_BRACKET CLOSE_BRACKET OPEN_BRACE CLOSE_BRACE OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET
%token SEMICOLON COMMA COLON
%token ASSIGN PLUSASSIGN MINUSASSIGN MULTASSIGN DIVASSIGN MODASSIGN
%token PLUS MINUS MULTIPLY DIVIDE MODULO
%token EQUAL NOT_EQUAL GREATER LESS GREATER_EQUAL LESS_EQUAL
%token AND OR NOT
%token INCREMENT DECREMENT
%token COMMENT TERROR
%left MINUS PLUS
%left MULTIPLY DIVIDE MODULO
%left AND OR
%left INCREMENT DECREMENT
%left EQUAL NOT_EQUAL GREATER LESS GREATER_EQUAL LESS_EQUAL
%left COMMA
%right NOT


%start ini

%%

ini: prog {printf("TODO OK\n");}
;

prog: includes body
    | body
    ;

includes: includes include
    | include
    ;

include: HASH INCLUDE
    | error {printf("Error en la linea ");}

body: body stmts 
    | /* empty */ 
    // | error SEMICOLON {printf("hola");}
    ;

decls: decls type decl SEMICOLON 
    | type decl SEMICOLON 
    ;

decl: decl COMMA declt 
    | declt 
    // | error SEMICOLON {printf("hola");}
    ;

declt: ID 
    | assign_stmt 
    // | error SEMICOLON {printf("hola");}
    ;

type: INT 
    | FLOAT 
    | CHAR 
    | VOID 
    ;

stmts: stmts stmt 
    | stmt 
    | error {}
    ;

stmt: line_stmt SEMICOLON 
    | block_stmt
    | decls
    ;

line_stmt: assign_stmt 
    | return_stmt 
    | print_stmt 
    | scan_stmt 
    | BREAK 
    | CONTINUE 
    // | error SEMICOLON {printf("hola");}
    ;

assign_stmt: ID assign_op expr 
    | increase 
    | decrease 
    // | error SEMICOLON {printf("hola");}
    ;

assign_op: ASSIGN 
    | PLUSASSIGN 
    | MINUSASSIGN 
    | MULTASSIGN 
    | DIVASSIGN 
    | MODASSIGN 
    ;

block_stmt: block_header 
    | block_body 
    | block_body SEMICOLON
    ;

block_header: if_stmt 
    | while_stmt 
    | do_stmt 
    | for_stmt 
    | switch_stmt 
    ;

block_body: OPEN_BRACE stmts CLOSE_BRACE 
    ;

if_stmt: IF OPEN_BRACKET expr CLOSE_BRACKET stmt 
    | IF OPEN_BRACKET expr CLOSE_BRACKET stmt ELSE stmt 
    ;

while_stmt: WHILE OPEN_BRACKET logic_expr CLOSE_BRACKET stmt 
    ;

do_stmt: DO stmt WHILE OPEN_BRACKET logic_expr CLOSE_BRACKET SEMICOLON 
    ;

for_stmt: FOR OPEN_BRACKET type assign_stmt SEMICOLON logic_expr SEMICOLON assign_stmt CLOSE_BRACKET stmt 
    | FOR OPEN_BRACKET assign_stmt SEMICOLON logic_expr SEMICOLON assign_stmt CLOSE_BRACKET stmt 

switch_stmt: SWITCH OPEN_BRACKET expr CLOSE_BRACKET OPEN_BRACE cases CLOSE_BRACE 

cases: cases case 
    | /* empty */ 
    ;

case: CASE NUM_INT COLON stmts 
    | CASE TCHAR COLON stmts 
    | CASE STRING COLON stmts 
    | DEFAULT COLON stmts 


return_stmt: RETURN expr 
    | RETURN 
    ;

print_stmt: PRINT OPEN_BRACKET multiple_expr CLOSE_BRACKET 
    ;

multiple_expr: multiple_expr COMMA expr 
    | expr 
    ;

scan_stmt: SCANF OPEN_BRACKET ID CLOSE_BRACKET 
    | SCANF OPEN_BRACKET ID COMMA ID CLOSE_BRACKET
    | SCANF OPEN_BRACKET STRING COMMA ID CLOSE_BRACKET
    ;

increase: ID INCREMENT 
    | INCREMENT ID 
    ;

decrease: ID DECREMENT 
    | DECREMENT ID 
    ;

expr: NUM_INT 
    | arith_expr 
    | logic_expr 
    | ID
    | TCHAR
    | STRING
    ;

arith_expr: arith_expr PLUS simple_arithmetic 
    | arith_expr MINUS simple_arithmetic 
    | arith_expr MULTIPLY simple_arithmetic 
    | arith_expr DIVIDE simple_arithmetic 
    | arith_expr MODULO simple_arithmetic 
    | PLUS simple_arithmetic 
    | MINUS simple_arithmetic 
    | simple_arithmetic 
    ;

simple_arithmetic: ID 
    | NUM_INT 
    | NUM_REAL 
    | OPEN_BRACKET arith_expr CLOSE_BRACKET 
    | increase 
    | decrease 
    ;

logic_expr: logic_expr AND rel_expr 
    | logic_expr OR rel_expr 
    | NOT rel_expr 
    | rel_expr 
    ;

rel_expr: ID 
    | OPEN_BRACKET logic_expr CLOSE_BRACKET 
    /*Now coparisons*/ 
    | arith_expr EQUAL arith_expr 
    | arith_expr NOT_EQUAL arith_expr 
    | arith_expr GREATER arith_expr 
    | arith_expr LESS arith_expr 
    | arith_expr GREATER_EQUAL arith_expr 
    | arith_expr LESS_EQUAL arith_expr 
    ;

%%

int main(int argc, char **argv){
    extern FILE *yyin;
    yyin = fopen(argv[1], "r");
    
    return yyparse();
}

void yyerror(char *s){
    printf("Error: %s\nNext to line: %i\n\n", s, yylineno);
}