#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include "platform.h"
#include "xbasic_bram.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xtmrctr.h"
#include "temp.h"

XScuGic ScuGic;
volatile static int RunExample = 0;
volatile static int ResultExample = 0;
XBasic_bram xbasic_dev;
XBasic_bram_Config*   xbasic_cfg;

void init_basic() { 
  int status = 0; 
  xbasic_cfg = XBasic_bram_LookupConfig(XPAR_XBASIC_BRAM_0_DEVICE_ID);
  if(xbasic_cfg) { status = XBasic_bram_CfgInitialize(&xbasic_dev,xbasic_cfg);
    if(status != XST_SUCCESS) { printf("failed to init");}
  }
}
int XBasicSetup(){
  return XBasic_bram_CfgInitialize(&xbasic_dev,xbasic_cfg);
}
void XBasicStart(void *InstancePtr){
  XBasic_bram *pExample = (XBasic_bram *)InstancePtr;
  XBasic_bram_InterruptEnable(pExample,1);
  XBasic_bram_InterruptGlobalEnable(pExample);
  XBasic_bram_Start(pExample);
}
void XBasicIsr(void *InstancePtr){
  XBasic_bram *pExample = (XBasic_bram *)InstancePtr;
  XBasic_bram_InterruptGlobalDisable(pExample);
  XBasic_bram_InterruptDisable(pExample,0xffffffff);
  XBasic_bram_InterruptClear(pExample,1);
  ResultExample = 1;
  if(RunExample){XBasic_bram_Start(pExample);}
}
int XBasicSetupInterrupt() {
  XScuGic_Config *pCfg = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
  if (pCfg == NULL){print("Interrupt Configuration Lookup Failed\n\r"); return XST_FAILURE;}
  int result = XScuGic_CfgInitialize(&ScuGic,pCfg,pCfg->CpuBaseAddress);
  if(result != XST_SUCCESS){return result;}
  result = XScuGic_SelfTest(&ScuGic);
  if(result != XST_SUCCESS){return result;}
  Xil_ExceptionInit();
  Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler,&ScuGic);
  Xil_ExceptionEnable();
  result = XScuGic_Connect(&ScuGic,XPAR_FABRIC_BASIC_BRAM_INTERRUPT_INTR,(Xil_InterruptHandler)XBasicIsr,&xbasic_dev);
  if(result != XST_SUCCESS){return result;}
  XScuGic_Enable(&ScuGic,XPAR_FABRIC_BASIC_BRAM_INTERRUPT_INTR);
  return XST_SUCCESS;
}
void setup() { 
  int status = XBasicSetup();
  if(status != XST_SUCCESS){ print("Error: example setup failed\n");  }
  status =  XBasicSetupInterrupt();
  if(status != XST_SUCCESS){print("Error: interrupt setup failed\n"); }
  XBasicStart(&xbasic_dev);
}
void memdump(void* virtual_address, int byte_count) {
  char *p = virtual_address;
  int offset;
  for (offset = 0; offset < byte_count; offset++) {
    printf("%02x", p[offset]);
    if (offset % 4 == 3) { printf(" "); }
  }
  printf("\n");
}
void init_timer() { 
  TmrCtrLowLevelExample(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
}
int getOverhead(int iN) { 
  int fn_test_start = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  int fn_test_end   = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  int function_call_overhead = fn_test_end - fn_test_start;   			
  int loop_test_start = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  for (int i = 0; i<1000; i++);
  int loop_test_end = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  int per_loop_overhead = (loop_test_end - loop_test_start + 500) / 1000;		
  int overhead = iN*function_call_overhead+(2*function_call_overhead)+(per_loop_overhead*iN);
  return overhead;
}
int main() {
  init_platform();
  init_timer();
  init_basic();

  //Going through block-ram controller interface
  u32* virtual_source_address      = (u32*) 0x40000000;
  u32* virtual_destination_address = (u32*) 0x42000000;

  unsigned int lNEvents = 32;
  for(int i0 = 0;  i0 < 10*lNEvents; i0++) virtual_source_address[i0]       = i0;
  for(int i0 = 0;  i0 < 10*lNEvents; i0++) virtual_destination_address[i0]  = 9999;
  for(int i0 = 0; i0 < 5; i0++) {printf("1:Source memory block:      "); memdump(virtual_source_address+10*i0,      10*sizeof(u32));}
  for(int i0 = 0; i0 < 5; i0++) {printf("1:Destination memory block: "); memdump(virtual_destination_address+10*i0, 10*sizeof(u32));}

  XBasic_bram_Start(&xbasic_dev);
  int start   = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  while(!XBasic_bram_IsDone(&xbasic_dev));
  int stop    = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0); 

  for(int i0 = 0; i0 < 5; i0++) {printf("2:Source memory block:      "); memdump(virtual_source_address+10*i0,      10*sizeof(u32));}
  for(int i0 = 0; i0 < 5; i0++) {printf("2:Destination memory block: "); memdump(virtual_destination_address+10*i0, 10*sizeof(u32));}

  //timing 
  int overhead = getOverhead(1);
  printf(" total time is %i clocks overhead is %i \n\r",(stop-start-overhead),overhead);
  return 1;
}
