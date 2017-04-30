typedef struct burm_state *STATEPTR_TYPE;

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "passes.h"

/*
  An expression always results in a value stored in rax.
  An term is similar to an expression but can store it's value in an arbitrary register.
  A constant is .. a constant. It can only be used by loading it's value. (Either as term or expression)
*/

long int ssaID = 0;

#ifndef ALLOC
#define ALLOC(n) malloc(n)
#endif

#ifndef burm_assert
#define burm_assert(x,y) if (!(x)) { extern void abort(void); y; abort(); }
#endif

#define burm_code_NT 1
#define burm_arguments_NT 2
#define burm_condition_NT 3
#define burm_expr_NT 4
#define burm_argexpr_NT 5
#define burm_statement_NT 6
#define burm_variable_NT 7
#define burm_term_NT 8
#define burm_constant_NT 9
#define burm_doexpr_NT 10
#define burm_taddr_NT 11
#define burm_vaddr_NT 12
int burm_max_nt = 12;

struct burm_state {
	int op;
	STATEPTR_TYPE left, right;
	short cost[13];
	struct {
		unsigned burm_code:3;
		unsigned burm_arguments:2;
		unsigned burm_condition:1;
		unsigned burm_expr:4;
		unsigned burm_argexpr:1;
		unsigned burm_statement:3;
		unsigned burm_variable:1;
		unsigned burm_term:3;
		unsigned burm_constant:4;
		unsigned burm_doexpr:1;
		unsigned burm_taddr:1;
		unsigned burm_vaddr:1;
	} rule;
};

static short burm_nts_0[] = { burm_arguments_NT, 0 };
static short burm_nts_1[] = { 0 };
static short burm_nts_2[] = { burm_condition_NT, 0 };
static short burm_nts_3[] = { burm_expr_NT, 0 };
static short burm_nts_4[] = { burm_argexpr_NT, 0 };
static short burm_nts_5[] = { burm_statement_NT, 0 };
static short burm_nts_6[] = { burm_variable_NT, 0 };
static short burm_nts_7[] = { burm_term_NT, burm_expr_NT, 0 };
static short burm_nts_8[] = { burm_term_NT, burm_term_NT, 0 };
static short burm_nts_9[] = { burm_term_NT, 0 };
static short burm_nts_10[] = { burm_constant_NT, 0 };
static short burm_nts_11[] = { burm_doexpr_NT, 0 };
static short burm_nts_12[] = { burm_variable_NT, burm_expr_NT, 0 };
static short burm_nts_13[] = { burm_taddr_NT, burm_expr_NT, 0 };
static short burm_nts_14[] = { burm_vaddr_NT, burm_expr_NT, 0 };
static short burm_nts_15[] = { burm_constant_NT, burm_constant_NT, 0 };
static short burm_nts_16[] = { burm_term_NT, burm_constant_NT, 0 };
static short burm_nts_17[] = { burm_variable_NT, burm_constant_NT, 0 };

short *burm_nts[] = {
	0,	/* 0 */
	burm_nts_0,	/* 1 */
	burm_nts_1,	/* 2 */
	burm_nts_0,	/* 3 */
	burm_nts_2,	/* 4 */
	burm_nts_3,	/* 5 */
	burm_nts_4,	/* 6 */
	burm_nts_3,	/* 7 */
	burm_nts_5,	/* 8 */
	burm_nts_3,	/* 9 */
	burm_nts_1,	/* 10 */
	burm_nts_6,	/* 11 */
	burm_nts_6,	/* 12 */
	burm_nts_3,	/* 13 */
	burm_nts_3,	/* 14 */
	burm_nts_7,	/* 15 */
	burm_nts_7,	/* 16 */
	burm_nts_7,	/* 17 */
	burm_nts_8,	/* 18 */
	burm_nts_8,	/* 19 */
	burm_nts_9,	/* 20 */
	burm_nts_9,	/* 21 */
	burm_nts_10,	/* 22 */
	burm_nts_10,	/* 23 */
	burm_nts_1,	/* 24 */
	burm_nts_3,	/* 25 */
	burm_nts_3,	/* 26 */
	burm_nts_1,	/* 27 */
	burm_nts_11,	/* 28 */
	burm_nts_1,	/* 29 */
	burm_nts_12,	/* 30 */
	burm_nts_13,	/* 31 */
	burm_nts_14,	/* 32 */
	burm_nts_9,	/* 33 */
	burm_nts_6,	/* 34 */
	burm_nts_3,	/* 35 */
	burm_nts_9,	/* 36 */
	burm_nts_15,	/* 37 */
	burm_nts_15,	/* 38 */
	burm_nts_10,	/* 39 */
	burm_nts_15,	/* 40 */
	burm_nts_10,	/* 41 */
	burm_nts_15,	/* 42 */
	burm_nts_15,	/* 43 */
	burm_nts_16,	/* 44 */
	burm_nts_12,	/* 45 */
	burm_nts_17,	/* 46 */
};

char burm_arity[] = {
	0,	/* 0 */
	1,	/* 1=ARG */
	1,	/* 2=FUNCTION */
	0,	/* 3=NOOP */
	1,	/* 4=RETURNSTAT */
	0,	/* 5=DOSTAT */
	1,	/* 6=VARDEF */
	2,	/* 7=VARASSIGN */
	1,	/* 8=TERMSTAT */
	0,	/* 9=STATS */
	1,	/* 10=EXPRTERM */
	0,	/* 11=CONSTTERM */
	0,	/* 12=CALLTERM */
	0,	/* 13=VARTERM */
	2,	/* 14=LESSEXPR */
	1,	/* 15=READEXPR */
	2,	/* 16=EQUALEXPR */
	2,	/* 17=OREXPR */
	2,	/* 18=MULTEXPR */
	2,	/* 19=PLUSEXPR */
	1,	/* 20=MINUSEXPR */
	1,	/* 21=NOTEXPR */
	0,	/* 22=VARUSE */
	0,	/* 23=GUARDEDLIST */
	0,	/* 24=GUARDED */
	0,	/* 25=FCALL */
	1,	/* 26=ARGEXPR */
	0,	/* 27=LASTARG */
	0,	/* 28=EXPR */
	1,	/* 29=ADDRWRITE */
	0,	/* 30=CONT */
	0,	/* 31=BRK */
	0,	/* 32=ENDGUARD */
	1,	/* 33=CONDITION */
};

static short burm_decode_code[] = {
	0,
	1,
	4,
	6,
	8,
};

static short burm_decode_arguments[] = {
	0,
	2,
	3,
};

static short burm_decode_condition[] = {
	0,
	5,
};

static short burm_decode_expr[] = {
	0,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	21,
	22,
	26,
	45,
	46,
};

static short burm_decode_argexpr[] = {
	0,
	7,
};

static short burm_decode_statement[] = {
	0,
	9,
	28,
	30,
	31,
	32,
	35,
	36,
};

static short burm_decode_variable[] = {
	0,
	10,
};

static short burm_decode_term[] = {
	0,
	11,
	23,
	24,
	25,
	44,
};

static short burm_decode_constant[] = {
	0,
	27,
	37,
	38,
	39,
	40,
	41,
	42,
	43,
};

static short burm_decode_doexpr[] = {
	0,
	29,
};

static short burm_decode_taddr[] = {
	0,
	33,
};

static short burm_decode_vaddr[] = {
	0,
	34,
};

int burm_rule(STATEPTR_TYPE state, int goalnt) {
	burm_assert(goalnt >= 1 && goalnt <= 12, PANIC("Bad goal nonterminal %d in burm_rule\n", goalnt));
	if (!state)
		return 0;
	switch (goalnt) {
	case burm_code_NT:
		return burm_decode_code[state->rule.burm_code];
	case burm_arguments_NT:
		return burm_decode_arguments[state->rule.burm_arguments];
	case burm_condition_NT:
		return burm_decode_condition[state->rule.burm_condition];
	case burm_expr_NT:
		return burm_decode_expr[state->rule.burm_expr];
	case burm_argexpr_NT:
		return burm_decode_argexpr[state->rule.burm_argexpr];
	case burm_statement_NT:
		return burm_decode_statement[state->rule.burm_statement];
	case burm_variable_NT:
		return burm_decode_variable[state->rule.burm_variable];
	case burm_term_NT:
		return burm_decode_term[state->rule.burm_term];
	case burm_constant_NT:
		return burm_decode_constant[state->rule.burm_constant];
	case burm_doexpr_NT:
		return burm_decode_doexpr[state->rule.burm_doexpr];
	case burm_taddr_NT:
		return burm_decode_taddr[state->rule.burm_taddr];
	case burm_vaddr_NT:
		return burm_decode_vaddr[state->rule.burm_vaddr];
	default:
		burm_assert(0, PANIC("Bad goal nonterminal %d in burm_rule\n", goalnt));
	}
	return 0;
}

static void burm_closure_condition(STATEPTR_TYPE, int);
static void burm_closure_expr(STATEPTR_TYPE, int);
static void burm_closure_argexpr(STATEPTR_TYPE, int);
static void burm_closure_statement(STATEPTR_TYPE, int);
static void burm_closure_variable(STATEPTR_TYPE, int);
static void burm_closure_term(STATEPTR_TYPE, int);
static void burm_closure_constant(STATEPTR_TYPE, int);
static void burm_closure_doexpr(STATEPTR_TYPE, int);

static void burm_closure_condition(STATEPTR_TYPE p, int c) {
	if (c + 5 < p->cost[burm_code_NT]) {
		p->cost[burm_code_NT] = c + 5;
		p->rule.burm_code = 2;
	}
}

static void burm_closure_expr(STATEPTR_TYPE p, int c) {
	if (c + 10 < p->cost[burm_term_NT]) {
		p->cost[burm_term_NT] = c + 10;
		p->rule.burm_term = 4;
		burm_closure_term(p, c + 10);
	}
}

static void burm_closure_argexpr(STATEPTR_TYPE p, int c) {
	if (c + 5 < p->cost[burm_code_NT]) {
		p->cost[burm_code_NT] = c + 5;
		p->rule.burm_code = 3;
	}
}

static void burm_closure_statement(STATEPTR_TYPE p, int c) {
	if (c + 5 < p->cost[burm_code_NT]) {
		p->cost[burm_code_NT] = c + 5;
		p->rule.burm_code = 4;
	}
}

static void burm_closure_variable(STATEPTR_TYPE p, int c) {
	if (c + 5 < p->cost[burm_expr_NT]) {
		p->cost[burm_expr_NT] = c + 5;
		p->rule.burm_expr = 1;
		burm_closure_expr(p, c + 5);
	}
	if (c + 6 < p->cost[burm_term_NT]) {
		p->cost[burm_term_NT] = c + 6;
		p->rule.burm_term = 1;
		burm_closure_term(p, c + 6);
	}
}

static void burm_closure_term(STATEPTR_TYPE p, int c) {
	if (c + 10 < p->cost[burm_expr_NT]) {
		p->cost[burm_expr_NT] = c + 10;
		p->rule.burm_expr = 10;
		burm_closure_expr(p, c + 10);
	}
}

static void burm_closure_constant(STATEPTR_TYPE p, int c) {
	if (c + 20 < p->cost[burm_term_NT]) {
		p->cost[burm_term_NT] = c + 20;
		p->rule.burm_term = 2;
		burm_closure_term(p, c + 20);
	}
	if (c + 19 < p->cost[burm_expr_NT]) {
		p->cost[burm_expr_NT] = c + 19;
		p->rule.burm_expr = 11;
		burm_closure_expr(p, c + 19);
	}
}

static void burm_closure_doexpr(STATEPTR_TYPE p, int c) {
	if (c + 5 < p->cost[burm_statement_NT]) {
		p->cost[burm_statement_NT] = c + 5;
		p->rule.burm_statement = 2;
		burm_closure_statement(p, c + 5);
	}
}

STATEPTR_TYPE burm_state(int op, STATEPTR_TYPE left, STATEPTR_TYPE right) {
	int c;
	STATEPTR_TYPE p, l = left, r = right;

	if (burm_arity[op] > 0) {
		p = (STATEPTR_TYPE)ALLOC(sizeof *p);
		burm_assert(p, PANIC("ALLOC returned NULL in burm_state\n"));
		p->op = op;
		p->left = l;
		p->right = r;
		p->rule.burm_code = 0;
		p->cost[1] =
		p->cost[2] =
		p->cost[3] =
		p->cost[4] =
		p->cost[5] =
		p->cost[6] =
		p->cost[7] =
		p->cost[8] =
		p->cost[9] =
		p->cost[10] =
		p->cost[11] =
		p->cost[12] =
			32767;
	}
	switch (op) {
	case 1: /* ARG */
		assert(l);
		{	/* arguments: ARG(arguments) */
			c = l->cost[burm_arguments_NT] + 5;
			if (c + 0 < p->cost[burm_arguments_NT]) {
				p->cost[burm_arguments_NT] = c + 0;
				p->rule.burm_arguments = 2;
			}
		}
		break;
	case 2: /* FUNCTION */
		assert(l);
		{	/* code: FUNCTION(arguments) */
			c = l->cost[burm_arguments_NT] + 5;
			if (c + 0 < p->cost[burm_code_NT]) {
				p->cost[burm_code_NT] = c + 0;
				p->rule.burm_code = 1;
			}
		}
		break;
	case 3: /* NOOP */
		{
			static struct burm_state z = { 3, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 4: /* RETURNSTAT */
		assert(l);
		{	/* statement: RETURNSTAT(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 1;
				burm_closure_statement(p, c + 0);
			}
		}
		break;
	case 5: /* DOSTAT */
		{
			static struct burm_state z = { 5, 0, 0,
				{	0,
					15,	/* code: statement */
					32767,
					32767,
					32767,
					32767,
					10,	/* statement: doexpr */
					32767,
					32767,
					32767,
					5,	/* doexpr: DOSTAT */
					32767,
					32767,
				},{
					4,	/* code: statement */
					0,
					0,
					0,
					0,
					2,	/* statement: doexpr */
					0,
					0,
					0,
					1,	/* doexpr: DOSTAT */
					0,
					0,
				}
			};
			return &z;
		}
	case 6: /* VARDEF */
		assert(l);
		{	/* statement: VARDEF(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 6;
				burm_closure_statement(p, c + 0);
			}
		}
		break;
	case 7: /* VARASSIGN */
		assert(l && r);
		{	/* statement: VARASSIGN(vaddr,expr) */
			c = l->cost[burm_vaddr_NT] + r->cost[burm_expr_NT] + 3;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 5;
				burm_closure_statement(p, c + 0);
			}
		}
		{	/* statement: VARASSIGN(taddr,expr) */
			c = l->cost[burm_taddr_NT] + r->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 4;
				burm_closure_statement(p, c + 0);
			}
		}
		{	/* statement: VARASSIGN(variable,expr) */
			c = l->cost[burm_variable_NT] + r->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 3;
				burm_closure_statement(p, c + 0);
			}
		}
		break;
	case 8: /* TERMSTAT */
		assert(l);
		{	/* statement: TERMSTAT(term) */
			c = l->cost[burm_term_NT] + 5;
			if (c + 0 < p->cost[burm_statement_NT]) {
				p->cost[burm_statement_NT] = c + 0;
				p->rule.burm_statement = 7;
				burm_closure_statement(p, c + 0);
			}
		}
		break;
	case 9: /* STATS */
		{
			static struct burm_state z = { 9, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 10: /* EXPRTERM */
		assert(l);
		{	/* expr: EXPRTERM(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 12;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 11: /* CONSTTERM */
		{
			static struct burm_state z = { 11, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					19,	/* expr: constant */
					32767,
					32767,
					32767,
					20,	/* term: constant */
					0,	/* constant: CONSTTERM */
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					11,	/* expr: constant */
					0,
					0,
					0,
					2,	/* term: constant */
					1,	/* constant: CONSTTERM */
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 12: /* CALLTERM */
		{
			static struct burm_state z = { 12, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 13: /* VARTERM */
		{
			static struct burm_state z = { 13, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 14: /* LESSEXPR */
		assert(l && r);
		{	/* constant: LESSEXPR(constant,constant) */
			c = l->cost[burm_constant_NT] + r->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 8;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: LESSEXPR(term,term) */
			c = l->cost[burm_term_NT] + r->cost[burm_term_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 7;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 15: /* READEXPR */
		assert(l);
		{	/* expr: READEXPR(term) */
			c = l->cost[burm_term_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 9;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 16: /* EQUALEXPR */
		assert(l && r);
		{	/* constant: EQUALEXPR(constant,constant) */
			c = l->cost[burm_constant_NT] + r->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 7;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: EQUALEXPR(term,term) */
			c = l->cost[burm_term_NT] + r->cost[burm_term_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 8;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 17: /* OREXPR */
		assert(l && r);
		{	/* constant: OREXPR(constant,constant) */
			c = l->cost[burm_constant_NT] + r->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 5;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: OREXPR(term,expr) */
			c = l->cost[burm_term_NT] + r->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 6;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 18: /* MULTEXPR */
		assert(l && r);
		{	/* constant: MULTEXPR(constant,constant) */
			c = l->cost[burm_constant_NT] + r->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 3;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: MULTEXPR(term,expr) */
			c = l->cost[burm_term_NT] + r->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 5;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 19: /* PLUSEXPR */
		assert(l && r);
		{	/* expr: PLUSEXPR(variable,constant) */
			c = l->cost[burm_variable_NT] + r->cost[burm_constant_NT] + 994;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 14;
				burm_closure_expr(p, c + 0);
			}
		}
		{	/* expr: PLUSEXPR(variable,expr) */
			c = l->cost[burm_variable_NT] + r->cost[burm_expr_NT] + 994;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 13;
				burm_closure_expr(p, c + 0);
			}
		}
		{	/* term: PLUSEXPR(term,constant) */
			c = l->cost[burm_term_NT] + r->cost[burm_constant_NT] + 994;
			if (c + 0 < p->cost[burm_term_NT]) {
				p->cost[burm_term_NT] = c + 0;
				p->rule.burm_term = 5;
				burm_closure_term(p, c + 0);
			}
		}
		{	/* constant: PLUSEXPR(constant,constant) */
			c = l->cost[burm_constant_NT] + r->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 2;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: PLUSEXPR(term,expr) */
			c = l->cost[burm_term_NT] + r->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 4;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 20: /* MINUSEXPR */
		assert(l);
		{	/* constant: MINUSEXPR(constant) */
			c = l->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 6;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: MINUSEXPR(expr) */
			c = l->cost[burm_expr_NT] + 99;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 3;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 21: /* NOTEXPR */
		assert(l);
		{	/* constant: NOTEXPR(constant) */
			c = l->cost[burm_constant_NT] + 0;
			if (c + 0 < p->cost[burm_constant_NT]) {
				p->cost[burm_constant_NT] = c + 0;
				p->rule.burm_constant = 4;
				burm_closure_constant(p, c + 0);
			}
		}
		{	/* expr: NOTEXPR(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_expr_NT]) {
				p->cost[burm_expr_NT] = c + 0;
				p->rule.burm_expr = 2;
				burm_closure_expr(p, c + 0);
			}
		}
		break;
	case 22: /* VARUSE */
		{
			static struct burm_state z = { 22, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					10,	/* expr: variable */
					32767,
					32767,
					5,	/* variable: VARUSE */
					11,	/* term: variable */
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					1,	/* expr: variable */
					0,
					0,
					1,	/* variable: VARUSE */
					1,	/* term: variable */
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 23: /* GUARDEDLIST */
		{
			static struct burm_state z = { 23, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 24: /* GUARDED */
		{
			static struct burm_state z = { 24, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 25: /* FCALL */
		{
			static struct burm_state z = { 25, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					15,	/* expr: term */
					32767,
					32767,
					32767,
					5,	/* term: FCALL */
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					10,	/* expr: term */
					0,
					0,
					0,
					3,	/* term: FCALL */
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 26: /* ARGEXPR */
		assert(l);
		{	/* argexpr: ARGEXPR(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_argexpr_NT]) {
				p->cost[burm_argexpr_NT] = c + 0;
				p->rule.burm_argexpr = 1;
				burm_closure_argexpr(p, c + 0);
			}
		}
		break;
	case 27: /* LASTARG */
		{
			static struct burm_state z = { 27, 0, 0,
				{	0,
					32767,
					5,	/* arguments: LASTARG */
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					1,	/* arguments: LASTARG */
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 28: /* EXPR */
		{
			static struct burm_state z = { 28, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 29: /* ADDRWRITE */
		assert(l);
		{	/* vaddr: ADDRWRITE(variable) */
			c = l->cost[burm_variable_NT] + 99;
			if (c + 0 < p->cost[burm_vaddr_NT]) {
				p->cost[burm_vaddr_NT] = c + 0;
				p->rule.burm_vaddr = 1;
			}
		}
		{	/* taddr: ADDRWRITE(term) */
			c = l->cost[burm_term_NT] + 5;
			if (c + 0 < p->cost[burm_taddr_NT]) {
				p->cost[burm_taddr_NT] = c + 0;
				p->rule.burm_taddr = 1;
			}
		}
		break;
	case 30: /* CONT */
		{
			static struct burm_state z = { 30, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 31: /* BRK */
		{
			static struct burm_state z = { 31, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 32: /* ENDGUARD */
		{
			static struct burm_state z = { 32, 0, 0,
				{	0,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				}
			};
			return &z;
		}
	case 33: /* CONDITION */
		assert(l);
		{	/* condition: CONDITION(expr) */
			c = l->cost[burm_expr_NT] + 5;
			if (c + 0 < p->cost[burm_condition_NT]) {
				p->cost[burm_condition_NT] = c + 0;
				p->rule.burm_condition = 1;
				burm_closure_condition(p, c + 0);
			}
		}
		break;
	default:
		burm_assert(0, PANIC("Bad operator %d in burm_state\n", op));
	}
	return p;
}

#ifdef STATE_LABEL
static void burm_label1(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_label\n"));
	switch (burm_arity[OP_LABEL(p)]) {
	case 0:
		STATE_LABEL(p) = burm_state(OP_LABEL(p), 0, 0);
		break;
	case 1:
		burm_label1(LEFT_CHILD(p));
		STATE_LABEL(p) = burm_state(OP_LABEL(p),
			STATE_LABEL(LEFT_CHILD(p)), 0);
		break;
	case 2:
		burm_label1(LEFT_CHILD(p));
		burm_label1(RIGHT_CHILD(p));
		STATE_LABEL(p) = burm_state(OP_LABEL(p),
			STATE_LABEL(LEFT_CHILD(p)),
			STATE_LABEL(RIGHT_CHILD(p)));
		break;
	}
}

STATEPTR_TYPE burm_label(NODEPTR_TYPE p) {
	burm_label1(p);
	return STATE_LABEL(p)->rule.burm_code ? STATE_LABEL(p) : 0;
}

NODEPTR_TYPE *burm_kids(NODEPTR_TYPE p, int eruleno, NODEPTR_TYPE kids[]) {
	burm_assert(p, PANIC("NULL tree in burm_kids\n"));
	burm_assert(kids, PANIC("NULL kids in burm_kids\n"));
	switch (eruleno) {
	case 41: /* constant: MINUSEXPR(constant) */
	case 39: /* constant: NOTEXPR(constant) */
	case 36: /* statement: TERMSTAT(term) */
	case 35: /* statement: VARDEF(expr) */
	case 34: /* vaddr: ADDRWRITE(variable) */
	case 33: /* taddr: ADDRWRITE(term) */
	case 26: /* expr: EXPRTERM(expr) */
	case 20: /* expr: READEXPR(term) */
	case 14: /* expr: MINUSEXPR(expr) */
	case 13: /* expr: NOTEXPR(expr) */
	case 9: /* statement: RETURNSTAT(expr) */
	case 7: /* argexpr: ARGEXPR(expr) */
	case 5: /* condition: CONDITION(expr) */
	case 3: /* arguments: ARG(arguments) */
	case 1: /* code: FUNCTION(arguments) */
		kids[0] = LEFT_CHILD(p);
		break;
	case 29: /* doexpr: DOSTAT */
	case 27: /* constant: CONSTTERM */
	case 24: /* term: FCALL */
	case 10: /* variable: VARUSE */
	case 2: /* arguments: LASTARG */
		break;
	case 28: /* statement: doexpr */
	case 25: /* term: expr */
	case 23: /* term: constant */
	case 22: /* expr: constant */
	case 21: /* expr: term */
	case 12: /* expr: variable */
	case 11: /* term: variable */
	case 8: /* code: statement */
	case 6: /* code: argexpr */
	case 4: /* code: condition */
		kids[0] = p;
		break;
	case 46: /* expr: PLUSEXPR(variable,constant) */
	case 45: /* expr: PLUSEXPR(variable,expr) */
	case 44: /* term: PLUSEXPR(term,constant) */
	case 43: /* constant: LESSEXPR(constant,constant) */
	case 42: /* constant: EQUALEXPR(constant,constant) */
	case 40: /* constant: OREXPR(constant,constant) */
	case 38: /* constant: MULTEXPR(constant,constant) */
	case 37: /* constant: PLUSEXPR(constant,constant) */
	case 32: /* statement: VARASSIGN(vaddr,expr) */
	case 31: /* statement: VARASSIGN(taddr,expr) */
	case 30: /* statement: VARASSIGN(variable,expr) */
	case 19: /* expr: EQUALEXPR(term,term) */
	case 18: /* expr: LESSEXPR(term,term) */
	case 17: /* expr: OREXPR(term,expr) */
	case 16: /* expr: MULTEXPR(term,expr) */
	case 15: /* expr: PLUSEXPR(term,expr) */
		kids[0] = LEFT_CHILD(p);
		kids[1] = RIGHT_CHILD(p);
		break;
	default:
		burm_assert(0, PANIC("Bad external rule number %d in burm_kids\n", eruleno));
	}
	return kids;
}

int burm_op_label(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_op_label\n"));
	return OP_LABEL(p);
}

STATEPTR_TYPE burm_state_label(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_state_label\n"));
	return STATE_LABEL(p);
}

NODEPTR_TYPE burm_child(NODEPTR_TYPE p, int index) {
	burm_assert(p, PANIC("NULL tree in burm_child\n"));
	switch (index) {
	case 0:	return LEFT_CHILD(p);
	case 1:	return RIGHT_CHILD(p);
	}
	burm_assert(0, PANIC("Bad index %d in burm_child\n", index));
	return 0;
}

#endif

char codeBuffer[2048];

void defVar(NODEPTR_TYPE bnode)
{
  //assignSSA(bnode);
  //mapSSA(bnode);
}

void emit(const char* what, NODEPTR_TYPE bnode )
{
  if(strcmp(what, "FUNCTION") == 0)
  {
    sprintf(codeBuffer,
    "\n#Function %s\n.global %s\n%s:\n\n"
    "push %%rbp\n"
    "movq %%rsp, %%rbp\n",
    bnode->name, bnode->name, bnode->name);
  }
  else if(strcmp(what, "ARGEXPR") == 0)
  {
    sprintf(codeBuffer,
    "#ARGEXPR\n"
    "movq %%rax, %s\n", regNames[bnode->reg]);
  }
  else if(strcmp(what, "CONDITION") == 0)
  {
    sprintf(codeBuffer,
      "#GUARD JMP\n"
      "cmp $0, %%rax\n"
      "jge end_guard_%d\n", bnode->dostat.guardID);
  }
  else if(strcmp(what, "DOSTAT") == 0)
  {
    fprintf(stderr, "do Not handeled in burg\n");
  }
  //Move variable to register of node
  else if(strcmp(what, "VAR2REG") == 0)
  {
    psymList var = symFind(bnode->symbols, bnode->name);
    sprintf(codeBuffer,
    "#VAR2REG var: %3$s\n"
    "movq %1$s, %2$s\n",
    getVarPos(var), regNames[bnode->reg], bnode->name
    );
  }
  else if(strcmp(what, "RETURN") == 0)
  {
    sprintf(codeBuffer,
    "leave\n"
    "ret #RETURN expr -> do nothing as expr results are always in rax\n");
  }
  else if(strcmp(what, "MINUSEXPR") == 0)
  {
    sprintf(codeBuffer,
    "#MINUSEXPR\n"
    "neg %%rax\n"
    );
  }
  else if(strcmp(what, "NOTEXPR") == 0)
  {
    sprintf(codeBuffer,
    "#NOTEXPR\n"
    "not %%rax\n");
  }
  else if(strcmp(what, "PLUSEXPR") == 0)
  {
    sprintf(codeBuffer,
    "#PLUSEXPR %%rax = %1$s + %%rax\n"
    "addq %1$s, %%rax\n",
    regNames[LEFT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "MULTEXPR") == 0)
  {
    //asm_mv(mv1, RIGHT_CHILD(bnode)->reg, bnode->reg);
    sprintf(codeBuffer,
    "#MULTEXPR %%rax = %1$s * %2$s\n"
    "movq %2$s, %%rax\n"
    "imulq %1$s, %%rax \n",
    regNames[LEFT_CHILD(bnode)->reg], regNames[RIGHT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "OREXPR") == 0)
  {
    sprintf(codeBuffer,
    "#OREXPR %%rax = %1$s or %2$s\n"
    "movq %2$s, %%rax\n"
    "or %1$s, %%rax\n",
    regNames[LEFT_CHILD(bnode)->reg], regNames[RIGHT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "LESSEXPR") == 0)
  {
    //-1 == TRUE und 0 == FALSE (Whyyyyyy)
    sprintf(codeBuffer,
      "#LESSEXPR %%rax := %2$s < %1$s\n"
      "xor %%rax, %%rax\n"
      "cmp %1$s, %2$s \n" // p3 < p2
      "setl %%al\n" // true -> (rax = 1)
      "neg %%al\n"
      "movsx %%al, %%rax\n",
      regNames[RIGHT_CHILD(bnode)->reg], regNames[LEFT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "EQUALEXPR") == 0)
  {
    //-1 == TRUE und 0 == FALSE (Whyyyyyy)
    sprintf(codeBuffer,
      "#EQUALEXPR\n"
      "xor %%rax, %%rax\n"
      "cmp %1$s, %2$s \n"
      "setz %%al\n"
      "neg %%al\n"
      "movsx %%al, %%rax\n",
      regNames[RIGHT_CHILD(bnode)->reg], regNames[LEFT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "READEXPR") == 0)
  {
    sprintf(codeBuffer,
      "#READEXPR\n"
      "movq (%1$s), %%rax # %%rax := *%1$s\n",
      regNames[LEFT_CHILD(bnode)->reg]);
  }
  else if(strcmp(what, "CONSTEXPR") == 0)
  {
    sprintf(codeBuffer,
    "#CONSTEXPR\n"
    "mov $%ld, %%rax\n ", bnode->value
    );
  }
  else if(strcmp(what, "CONSTTERM") == 0)
  {
    sprintf(codeBuffer,
      "#CONSTTERM\n"
      "movq $%1$ld, %2$s # %2$s := (const) %1$ld\n",
      bnode->value, regNames[bnode->reg]);
  }
  else if(strcmp(what, "MEMVARWRITE") == 0)
  {
    //*var = expr;
    sprintf(codeBuffer,
      "#WRITE TO ADDR STORED IN VAR\n"
      "movq %1$s, (%2$s) # *%2$s := %1$s\n",
      regNames[RIGHT_CHILD(bnode)->reg], regNames[LEFT_CHILD(bnode)->reg]);
  }
  //Create a new variable in a register
  else if(strcmp(what, "VARDEF") == 0)
  {
    psymList var = symFind(bnode->symbols, bnode->name);
    var->pos.reg = newReg();
    var->pos.location = VAR_REG;
    pushVariable(var);
    //registers[var->pos.reg]->isVar = 1;
    //bnode->reg=var->pos.reg;
    sprintf(codeBuffer,
      "#WRITE TO VAR(DEF)\n"
      "movq %1$s, %2$s # %2$s := %1$s\n",
      regNames[LEFT_CHILD(bnode)->reg], getVarPos(var));
  }
  else if(strcmp(what, "VARASSIGN") == 0)
  {
    psymList var = symFind(bnode->symbols, bnode->children[0]->name);
    sprintf(codeBuffer,
      "#WRITE TO VAR(VARASSIGN)\n"
      "movq %1$s, %2$s # %2$s := %1$s\n",
      regNames[RIGHT_CHILD(bnode)->reg], getVarPos(var));
  }
  else if(strcmp(what, "EXPR2TERM") == 0)
  {
    sprintf(codeBuffer,
      "#EXPR2TERM %1$s = %%rax\n"
      "movq %%rax, %1$s\n",
      regNames[bnode->reg]);
  }
  else if(strcmp(what, "TERM2EXPR") == 0)
  {
    sprintf(codeBuffer,
      "#TERM2EXPR %%rax = %1$s\n"
      "movq %1$s, %%rax\n",
      regNames[bnode->reg]);
  }
  else
  {
    fprintf(stderr, "Invalid code node: %s\n", what);
    return;
  }

  puts(codeBuffer);
}

extern int yyparse(void);
void burm_reduce(NODEPTR_TYPE bnode, int goalnt);
psymList ts;

/*int getRegNumber(psymList list, const char* name)
{
  return symFind(list, name)->pos.reg;
}*/

/*void allocateParams(psymList par)
{
  if(par == NULL)
    return;
  allocateParams(par->next);
  int i = newArgReg();
  par->reg = i;
  //printf("r%d = arg %s\n", i, par->name);
}*/

void invoke_burm(NODEPTR_TYPE root) {
	burm_label(root);
	burm_reduce(root, 1);
}

void burm_reduce(NODEPTR_TYPE bnode, int goalnt)
{
  int ruleNo = burm_rule (STATE_LABEL(bnode), goalnt);
  short *nts = burm_nts[ruleNo];
  NODEPTR_TYPE kids[100];
  int i;

  if (ruleNo==0) {
    fprintf(stderr, "tree cannot be derived from start symbol");
    exit(1);
  }
  burm_kids (bnode, ruleNo, kids);
  for (i = 0; nts[i]; i++)
    burm_reduce (kids[i], nts[i]);    /* reduce kids */

#if DEBUG
  printf ("%s", burm_string[ruleNo]);  /* display rule */
#endif

  switch (ruleNo) {
  case 10:
 bnode->reg = 13;//getRegNumber(bnode->symbols, bnode->name);
    break;
  case 11:
 bnode->reg = newReg(); emit("VAR2REG", bnode);
    break;
  case 12:
 bnode->reg = 0; emit("VAR2REG", bnode);
    break;
  case 13:
 bnode->reg=0; emit("NOTEXPR", bnode);
    break;
  case 14:
 bnode->reg=0; emit("MINUSEXPR", bnode);
    break;
  case 15:
 bnode->reg = 0; emit("PLUSEXPR", bnode); freeReg(kids[0]->reg);
    break;
  case 16:
 bnode->reg = 0; emit("MULTEXPR", bnode); freeReg(kids[0]->reg);
    break;
  case 30:
 emit("VARASSIGN", bnode);
    break;
  case 17:
 bnode->reg = 0; emit("OREXPR", bnode); freeReg(kids[0]->reg);
    break;
  case 31:
 bnode->reg = kids[0]->reg; emit("MEMVARWRITE", bnode); freeReg(kids[0]->reg);
    break;
  case 18:
 bnode->reg = 0; emit("LESSEXPR", bnode); freeReg(kids[0]->reg); freeReg(kids[1]->reg);
    break;
  case 32:
 bnode->reg = kids[0]->reg; emit("MEMVARWRITE", bnode);
    break;
  case 19:
 bnode->reg = 0; emit("EQUALEXPR", bnode); freeReg(kids[0]->reg); freeReg(kids[1]->reg);
    break;
  case 33:
 bnode->reg = kids[0]->reg;
    break;
  case 34:
 exit(5);//avoid variable special casing for stack  bnode->reg = kids[0]->reg;
    break;
  case 35:
 emit("VARDEF", bnode);
    break;
  case 36:
 freeReg(kids[0]->reg);
    break;
  case 37:
 bnode->value = kids[0]->value + kids[1]->value;
    break;
  case 38:
 bnode->value = kids[0]->value * kids[1]->value;
    break;
  case 39:
 bnode->value = ~ kids[0]->value;
    break;
  case 1:
 emit("FUNCTION", bnode);
    break;
  case 2:

    break;
  case 3:

    break;
  case 4:

    break;
  case 5:
 emit("CONDITION", bnode);
    break;
  case 6:

    break;
  case 7:
 emit("ARGEXPR", bnode);//register set in generateCall
    break;
  case 8:

    break;
  case 9:
 emit("RETURN", bnode);
    break;
  case 20:
 bnode->reg = 0; emit("READEXPR", bnode); freeReg(kids[0]->reg);
    break;
  case 21:
 emit("TERM2EXPR", bnode); freeReg(kids[0]->reg);
    break;
  case 22:
 bnode->reg = 0; emit("CONSTEXPR", bnode);
    break;
  case 23:
 bnode->reg = newReg(); emit("CONSTTERM", bnode);
    break;
  case 24:
 generateCall(bnode);
    break;
  case 25:
 bnode->reg = newReg(); emit("EXPR2TERM", bnode);
    break;
  case 26:
 bnode->reg = 0;// emit("EXPR2TERM", bnode);
    break;
  case 40:
 bnode->value = kids[0]->value | kids[1]->value;
    break;
  case 27:

    break;
  case 41:
 bnode->value = - (kids[0]->value);
    break;
  case 28:
 fprintf(stderr, "DOSTAT: Do not supported.\n"); //printf("do stuff\n"); exit(5);
    break;
  case 42:
 bnode->value = (kids[0]->value == kids[1]->value) ? (-1) : 0;
    break;
  case 29:
 emit("DOSTAT", bnode);
    break;
  case 43:
 bnode->value = (kids[0]->value < kids[1]->value) ? (-1) : 0;
    break;
  case 44:
 bnode->reg = kids[0]->reg; printf("addq $%ld, %s\n", kids[1]->value, regNames[kids[0]->reg]);
    break;
  case 45:
 bnode->reg = 0; printf("\x23VAR_P_EXPR\naddq %s, %%rax\n", getVarPos(symFind(kids[0]->symbols, kids[0]->name)));
    break;
  case 46:
 bnode->reg = 0; printf("\x23VAR_P_CONST\nmovq %1$ld, %%rax\naddq %2$s, %%rax\n", kids[1]->value, getVarPos(symFind(kids[0]->symbols, kids[0]->name)));
    break;
  default:    assert (0);
  }
}
