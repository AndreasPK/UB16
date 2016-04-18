/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_GRAMMAR_H_INCLUDED
# define YY_YY_GRAMMAR_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    END = 258,
    RETURN = 259,
    VAR = 260,
    DO = 261,
    CONTINUE = 262,
    BREAK = 263,
    OR = 264,
    NOT = 265,
    SEMIC = 266,
    BRACEL = 267,
    BRACER = 268,
    COMMA = 269,
    ASSIGN = 270,
    COLON = 271,
    ARROWR = 272,
    STAR = 273,
    PLUS = 274,
    LESS = 275,
    EQUAL = 276,
    MINUS = 277,
    CIRCUMFLEX = 278,
    ID = 279,
    NUMBER = 280
  };
#endif
/* Tokens.  */
#define END 258
#define RETURN 259
#define VAR 260
#define DO 261
#define CONTINUE 262
#define BREAK 263
#define OR 264
#define NOT 265
#define SEMIC 266
#define BRACEL 267
#define BRACER 268
#define COMMA 269
#define ASSIGN 270
#define COLON 271
#define ARROWR 272
#define STAR 273
#define PLUS 274
#define LESS 275
#define EQUAL 276
#define MINUS 277
#define CIRCUMFLEX 278
#define ID 279
#define NUMBER 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 8 "grammar.y" /* yacc.c:1909  */

  long number;
  char* name;

#line 109 "grammar.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GRAMMAR_H_INCLUDED  */
