#ifndef SIMPLE_ALGO_STRUCT_H
#define SIMPLE_ALGO_STRUCT_H

#include "ap_int.h"

typedef ap_int<32> value_t;

//#define __EXTENDED__
#define __MEMBERS__
#ifndef __EXTENDED__
	struct simple_struct {
	    value_t inA;
	    value_t inB;
	    #ifdef __MEMBERS__
	    void clear() {inA = 0; inB = 0;}
	    value_t sum() {return inA+inB;}
	    #endif
	};
#else
	struct simple_struct {
	    value_t inA;
	    value_t inB;
	    value_t inC;
	    #ifdef __MEMBERS__
	    void clear() {inA = 0; inB = 0;}
	    value_t sum() {return inA+inB;}
	    #endif
	};
#endif
#ifndef __MEMBERS__
inline void clear(simple_struct & structA) {
	structA.inA = 0; structA.inB = 0;
	#ifdef __EXTENDED__
	structA.inC = 0;
	#endif
}
#endif

void simple_algo_struct_ref( simple_struct structA, value_t &outA );
void simple_algo_struct_hw( simple_struct structA, value_t &outA );

#endif
