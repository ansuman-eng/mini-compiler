%{
	#include "y.tab.h"
%}
DIGIT [0-9]
DIGIT1 [1-9]
ALPHA [a-zA-Z]
QUOTE ["]
NOT [!]
EQUAL [=]

%%
get return GET;
from return FROM;
where return WHERE;
and return AND;
or return OR;
insert return INSERT;
record return RECORD;
into return INTO;
update return UPDATE;
in return IN;
set return SET;
to return TO;
delete return DELETE;
[,] return COMMA;
({ALPHA}|_)({ALPHA}|{DIGIT}|_)*[.]txt {yylval.sval= (char*)malloc(sizeof(strlen(yytext))); strcpy(yylval.sval,yytext);return FILE1;}
({DIGIT1}{DIGIT}*|{QUOTE}.*{QUOTE}) {yylval.sval= (char*)malloc(sizeof(strlen(yytext))); strcpy(yylval.sval,yytext);return VAL;}
({ALPHA}|_)({ALPHA}|{DIGIT}|_)* {yylval.sval= (char*)malloc(sizeof(strlen(yytext))); strcpy(yylval.sval,yytext);return FIELD;}
([=<>]|>=|<=)	{yylval.sval= (char*)malloc(sizeof(strlen(yytext))); strcpy(yylval.sval,yytext);return COND_OP;}
%%
