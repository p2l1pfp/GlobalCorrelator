#ifndef SIMPLE_ALGO_STRUCT_H
#define SIMPLE_ALGO_STRUCT_H

#include "ap_int.h"

//#define __EXTENDED__
#ifndef __EXTENDED__
	struct simple_struct {
	    ap_int<32> inA;
	    ap_int<32> inB;
	    
	};
#else
	struct simple_struct {
	    ap_int<32> inA;
	    ap_int<32> inB;
	    ap_int<32> inC;
	    
	};
#endif

void simple_algo_struct_ref( simple_struct structA, ap_int<32> &outA );
void simple_algo_struct_hw( simple_struct structA, ap_int<32> &outA );

#endif
