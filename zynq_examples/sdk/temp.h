/*
 * temp.h
 *
 *  Created on: 19.10.2012
 *      Author: peters
 */

#ifndef TEMP_H_
#define TEMP_H_


/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are only defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define TMRCTR_BASEADDR		XPAR_TMRCTR_0_BASEADDR

/*
 * This example only uses the 1st of the 2 timer counters contained in a
 * single timer counter hardware device
 */
#define TIMER_COUNTER_0	 0x0

/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

int TmrCtrLowLevelExample(u32 TmrCtrBaseAddress, u8 TimerCounter);

/************************** Variable Definitions *****************************/




#endif /* TEMP_H_ */
