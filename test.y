%{

	#include<stdio.h>
	#include<string.h>
	int yylex();
	void yyerror(const char* s);
	char f_name[1000];
	int * mystack[100];
	int top =-1;
%}

%union{
	char *sval;
}

%type <sval> GET FROM WHERE AND OR INSERT RECORD INTO UPDATE IN SET TO DELETE COMMA FILE1 VAL FIELD COND_OP RECORD_VAL NEXT COND COND_REC FIELD_LIST
%token GET FROM WHERE AND OR INSERT RECORD INTO UPDATE IN SET TO DELETE COMMA FILE1 VAL FIELD COND_OP
%%
S: G|I|U|D
; 
G: GET FIELD_LIST FROM FILE1 WHERE COND_REC					{strcpy(f_name,$4);get($4,mystack[top]);}							
;
I: INSERT RECORD RECORD_VAL INTO FILE1 			{insert($3,$5);}
;
U: UPDATE RECORD IN FILE1 SET FIELD TO VAL WHERE COND_REC		{strcpy(f_name,$4);update($4,$6,$8,mystack[top]);}
;
D: DELETE RECORD FROM FILE1 WHERE COND_REC 		{strcpy(f_name,$4);delete($4,mystack[top]);}
;
FIELD_LIST: FIELD COMMA FIELD_LIST			{char temp[100]; strcpy(temp,$1);strcat(temp,"@");strcat(temp,$3);strcpy($$,temp);}
			|
			FIELD
			;
COND_REC: COND_REC OR NEXT	{char temp[100]; strcpy(temp,$1); strcat(temp,"@"); strcat(temp,"or"); strcat(temp,"@"); strcat(temp,$3);strcpy($$,temp);int * arr_cond1 , arr_cond2; arr_cond1=mystack[top];top--; arr_cond2=mystack[top];top--;top++;mystack[top]=merge_or(arr_cond1,arr_cond2);}
			|NEXT
;
NEXT: NEXT AND COND 	{char temp[100]; strcpy(temp,$1); strcat(temp,"@"); strcat(temp,"and"); strcat(temp,"@"); strcat(temp,$3);strcpy($$,temp);int * arr_cond1 , arr_cond2; arr_cond1=mystack[top];top--; arr_cond2=mystack[top];top--;top++;mystack[top]=merge_and(arr_cond1,arr_cond2);}
	   |COND
;
COND : FIELD COND_OP  VAL 	{char temp[100]; strcpy(temp,$1); strcat(temp,"@"); strcat(temp,$2); strcat(temp,"@"); strcat(temp,$3);strcpy($$,temp);int * arr_cond =check_cond(temp,f_name); top++; mystack[top]=arr_cond;}
;
RECORD_VAL : VAL COMMA RECORD_VAL	{char temp[100]; strcpy(temp,$1);strcat(temp,"@");strcat(temp,$3);strcpy($$,temp);}
			 | VAL 				
			 ;
%%
