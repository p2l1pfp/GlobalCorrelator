#include "simple_algo_blackbox.h"

//--------------------------------------------------------
void rtl_simple_algo_blackbox(data_t  a1, data_t  a2, data_t  a3, data_t  a4,
							  data_t  b1, data_t  b2, data_t  b3, data_t  b4,
							  data_t &z1, data_t &z2, data_t &z3, data_t &z4) {
	#pragma HLS inline=off
	z1=a1+b1;
	z2=a2+b2;
	z3=a3+b3;
	z4=a4+b4;
}

//--------------------------------------------------------
void simple_algo_blackbox(data_t  a1, data_t  a2, data_t  a3, data_t  a4,
						  data_t  b1, data_t  b2, data_t  b3, data_t  b4,
						  data_t &sigma) {
	data_t tmp1, tmp2,tmp3, tmp4;
	rtl_simple_algo_blackbox(a1, a2, a3, a4, b1, b2, b3, b4, tmp1, tmp2, tmp3, tmp4);
	sigma = tmp1 + tmp2 + tmp3 + tmp4;
}