#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include "platform.h"
#include "xbasic_axistream.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xaxidma.h"
#include "xtmrctr.h"
#include "temp.h"

#define MM2S_CONTROL_REGISTER 0x00
#define MM2S_STATUS_REGISTER 0x04
#define MM2S_START_ADDRESS 0x18
#define MM2S_LENGTH 0x28

#define S2MM_CONTROL_REGISTER 0x30
#define S2MM_STATUS_REGISTER 0x34
#define S2MM_DESTINATION_ADDRESS 0x48
#define S2MM_LENGTH 0x58

XScuGic ScuGic;
XAxiDma AxiDma;

volatile static int RunExample = 0;
volatile static int ResultExample = 0;
XBasic_axistream xbasic_dev;
XBasic_axistream_Config xbasic_config = {
	0,
	XPAR_BASIC_AXISTREAM_S_AXI_CTRL_BUS_BASEADDR
};
int XBasicSetup(){
  return XBasic_axistream_CfgInitialize(&xbasic_dev,&xbasic_config);
}
void XBasicStart(void *InstancePtr){
  XBasic_axistream *pExample = (XBasic_axistream *)InstancePtr;
  XBasic_axistream_InterruptEnable(pExample,1);
  XBasic_axistream_InterruptGlobalEnable(pExample);
  XBasic_axistream_Start(pExample);
}
void XBasicIsr(void *InstancePtr){
  XBasic_axistream *pExample = (XBasic_axistream *)InstancePtr;
  XBasic_axistream_InterruptGlobalDisable(pExample);
  XBasic_axistream_InterruptDisable(pExample,0xffffffff);
  XBasic_axistream_InterruptClear(pExample,1);
  ResultExample = 1;
  if(RunExample){XBasic_axistream_Start(pExample);}
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
  result = XScuGic_Connect(&ScuGic,XPAR_FABRIC_BASIC_AXISTREAM_INTERRUPT_INTR,(Xil_InterruptHandler)XBasicIsr,&xbasic_dev);
  if(result != XST_SUCCESS){return result;}
  XScuGic_Enable(&ScuGic,XPAR_FABRIC_BASIC_AXISTREAM_INTERRUPT_INTR);
  return XST_SUCCESS;
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
void setup() { 
  int status = XBasicSetup();
  if(status != XST_SUCCESS){ print("Error: example setup failed\n");  }
  status =  XBasicSetupInterrupt();
  if(status != XST_SUCCESS){print("Error: interrupt setup failed\n"); }
  XBasicStart(&xbasic_dev);
}

int init_dma(){
  XAxiDma_Config *CfgPtr = XAxiDma_LookupConfig(XPAR_DMA_CONTROLLER_DEVICE_ID);
  if(!CfgPtr){print("Error looking for AXI DMA config\n\r"); return XST_FAILURE;}
  int status = XAxiDma_CfgInitialize(&AxiDma,CfgPtr);
  if(status != XST_SUCCESS){ print("Error initializing DMA\n\r"); return XST_FAILURE;}
  //XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,XAXIDMA_DEVICE_TO_DMA);
  //XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,XAXIDMA_DMA_TO_DEVICE);
  return XST_SUCCESS;
}
void dma_set(unsigned int* dma_virtual_address, int offset, unsigned int value) {
  dma_virtual_address[offset>>2] = value;
}
unsigned int dma_get(unsigned int* dma_virtual_address, int offset) {
  return dma_virtual_address[offset>>2];
}
void dma_s2mm_status(unsigned int* dma_virtual_address) {
  unsigned int status = dma_get(dma_virtual_address, S2MM_STATUS_REGISTER);
  printf("Stream to memory-mapped status (0x%08x@0x%02x):", status, S2MM_STATUS_REGISTER);
  if (status & 0x00000001) printf(" halted"); else printf(" running");
  if (status & 0x00000002) printf(" idle");
  if (status & 0x00000008) printf(" SGIncld");
  if (status & 0x00000010) printf(" DMAIntErr");
  if (status & 0x00000020) printf(" DMASlvErr");
  if (status & 0x00000040) printf(" DMADecErr");
  if (status & 0x00000100) printf(" SGIntErr");
  if (status & 0x00000200) printf(" SGSlvErr");
  if (status & 0x00000400) printf(" SGDecErr");
  if (status & 0x00001000) printf(" IOC_Irq");
  if (status & 0x00002000) printf(" Dly_Irq");
  if (status & 0x00004000) printf(" Err_Irq");
  printf("\n");
}

void dma_mm2s_status(unsigned int* dma_virtual_address) {
  unsigned int status = dma_get(dma_virtual_address, MM2S_STATUS_REGISTER);
  printf("Memory-mapped to axistream status (0x%08x@0x%02x):", status, MM2S_STATUS_REGISTER);
  if (status & 0x00000001) printf(" halted"); else printf(" running");
  if (status & 0x00000002) printf(" idle");
  if (status & 0x00000008) printf(" SGIncld");
  if (status & 0x00000010) printf(" DMAIntErr");
  if (status & 0x00000020) printf(" DMASlvErr");
  if (status & 0x00000040) printf(" DMADecErr");
  if (status & 0x00000100) printf(" SGIntErr");
  if (status & 0x00000200) printf(" SGSlvErr");
  if (status & 0x00000400) printf(" SGDecErr");
  if (status & 0x00001000) printf(" IOC_Irq");
  if (status & 0x00002000) printf(" Dly_Irq");
  if (status & 0x00004000) printf(" Err_Irq");
  printf("\n");
}
int dma_mm2s_sync(unsigned int* dma_virtual_address) {
  unsigned int mm2s_status =  dma_get(dma_virtual_address, MM2S_STATUS_REGISTER);
  while(!(mm2s_status & 1<<12) || !(mm2s_status & 1<<1) ){
    dma_s2mm_status(dma_virtual_address);
    dma_mm2s_status(dma_virtual_address);
    mm2s_status =  dma_get(dma_virtual_address, MM2S_STATUS_REGISTER);
  }
  return 0;
}
int dma_s2mm_sync(unsigned int* dma_virtual_address) {
  unsigned int s2mm_status = dma_get(dma_virtual_address, S2MM_STATUS_REGISTER);
  while(!(s2mm_status & 1<<12) || !(s2mm_status & 1<<1)){
    dma_s2mm_status(dma_virtual_address);
    dma_mm2s_status(dma_virtual_address);
    s2mm_status = dma_get(dma_virtual_address, S2MM_STATUS_REGISTER);
  }
  return 0;
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
int main() {
  init_platform();
  init_timer();
  unsigned int* virtual_source_address      = (unsigned int*) 0x0e000000;
  unsigned int* virtual_destination_address = (unsigned int*) 0x0f000000;
  unsigned int lNEvents = 32;
  for(int i0 = 0;  i0 < 10*lNEvents; i0++) virtual_source_address[i0]       = i0;
  for(int i0 = 0;  i0 < 10*lNEvents; i0++) virtual_destination_address[i0]  = 9999;
  u32 dma_size_in  = sizeof(u32)*10*lNEvents;
  u32 dma_size_out = sizeof(u32)*10*lNEvents;
  for(int i0 = 0; i0 < 5; i0++) { 
    printf("1:Source memory block:      "); memdump(virtual_source_address+10*i0,      10*sizeof(u32));
  }
  for(int i0 = 0; i0 < 5; i0++) { 
    printf("1:Destination memory block: "); memdump(virtual_destination_address+10*i0, 10*sizeof(u32));
  }
  init_dma();  
  setup();
  XBasicStart(&xbasic_dev);
  
  Xil_DCacheFlushRange((unsigned int)virtual_source_address,dma_size_in);
  Xil_DCacheFlushRange((unsigned int)virtual_destination_address,dma_size_out);

  int start   = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0);
  int status = XAxiDma_SimpleTransfer(&AxiDma, (u32) virtual_source_address,dma_size_in, XAXIDMA_DMA_TO_DEVICE);
  if (status != XST_SUCCESS) {print("Error: DMA transfer to Vivado HLS block failed\n"); return XST_FAILURE;}
  while (XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE)) ;  //==> Stream is not very stable can be commented
  status    = XAxiDma_SimpleTransfer(&AxiDma, (u32) virtual_destination_address,dma_size_out,XAXIDMA_DEVICE_TO_DMA);
  if (status != XST_SUCCESS) {print("Error: DMA transfer from Vivado HLS block failed\n"); return XST_FAILURE;}
  while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA)) ;  //==> Stream is not stable => I just comment it
  int stop    = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, TIMER_COUNTER_0); 

  for(int i0 = 0; i0 < 5; i0++) { 
    printf("2:Source memory block:      "); memdump(virtual_source_address+10*i0,      10*sizeof(u32));
  }
  for(int i0 = 0; i0 < 5; i0++) { 
    printf("2:Destination memory block: "); memdump(virtual_destination_address+10*i0, 10*sizeof(u32));
  }
  //timing 
  int overhead = getOverhead(1);
  printf(" total time is %i clocks overhead is %i \n\r",(stop-start-overhead),overhead);
  return 1;
}

/*
Basic example that demonstrates low level memory transfers 
int main() {
  init_platform();
  setup();
  XBasicStart(&xbasic_dev);
  unsigned int* virtual_address             = (unsigned int*) 0x40400000;
  unsigned int* virtual_source_address      = (unsigned int*) 0x0e000000;
  unsigned int* virtual_destination_address = (unsigned int*) 0x0f000000;//mmap(NULL, 65535, PROT_READ | PROT_WRITE, MAP_SHARED, dh, 0x0f000000); // Memory 
  for(int i0 = 0; i0 < 10; i0++) virtual_source_address[i0] = 0x11223344; // Write random stuff to source block
  memset(virtual_destination_address, 0, 32); // Clear destination block
  
  printf("Source memory block:      "); memdump(virtual_source_address, 32);
  printf("Destination memory block: "); memdump(virtual_destination_address, 32);

  printf("Resetting DMA\n");
  dma_set(virtual_address, S2MM_CONTROL_REGISTER, 4);
  dma_set(virtual_address, MM2S_CONTROL_REGISTER, 4);
  dma_s2mm_status(virtual_address);
  dma_mm2s_status(virtual_address);

  printf("Halting DMA\n");
  dma_set(virtual_address, S2MM_CONTROL_REGISTER, 0);
  dma_set(virtual_address, MM2S_CONTROL_REGISTER, 0);
  dma_s2mm_status(virtual_address);
  dma_mm2s_status(virtual_address);

  Xil_DCacheFlushRange((unsigned int)virtual_source_address,sizeof(32)*10);
  Xil_DCacheFlushRange((unsigned int)virtual_destination_address,sizeof(32));
  
  printf("Writing destination address\n");
  dma_set(virtual_address, S2MM_DESTINATION_ADDRESS, 0x0f000000); // Write destination address
  dma_s2mm_status(virtual_address);

  printf("Writing source address...\n");
  dma_set(virtual_address, MM2S_START_ADDRESS, 0x0e000000); // Write source address
  dma_mm2s_status(virtual_address);

  printf("Starting S2MM channel with all interrupts masked...\n");
  dma_set(virtual_address, S2MM_CONTROL_REGISTER, 0xf001);
  dma_s2mm_status(virtual_address);

  printf("Starting MM2S channel with all interrupts masked...\n");
  dma_set(virtual_address, MM2S_CONTROL_REGISTER, 0xf001);
  dma_mm2s_status(virtual_address);
  
  printf("Writing S2MM transfer length...\n");
  dma_set(virtual_address, S2MM_LENGTH, 32);
  dma_s2mm_status(virtual_address);

  printf("Writing MM2S transfer length...\n");
  dma_set(virtual_address, MM2S_LENGTH, 32);
  dma_mm2s_status(virtual_address);
  return;

  printf("Waiting for MM2S synchronization...\n");
  dma_mm2s_sync(virtual_address);

  printf("Waiting for S2MM sychronization...\n");
  dma_s2mm_sync(virtual_address); // If this locks up make sure all memory ranges are assigned under Address Editor!
  
  dma_s2mm_status(virtual_address);
  dma_mm2s_status(virtual_address);
  
  printf("Source memory block:      "); memdump(virtual_source_address, 32);
  printf("Destination memory block: "); memdump(virtual_destination_address, 32);
  unsigned int test0 = dma_get(virtual_address,MM2S_START_ADDRESS);
  unsigned int test1 = dma_get(virtual_address,S2MM_DESTINATION_ADDRESS);
  printf("....test-0....%i \n",test0);
  printf("....test-1....%i \n",test1);
  return 1;      
}
*/
