Instructions : 
Note all of this needs to be done in root on t3desk009.mit.edu to be able to communicate with the zynq (ask Phil for the root password)
0. In Vivado go to file export hardware, pick a directory and export including the bistream
1. Open vivado sdk (in vivado file=>launch SDK) or type xsdk in the command
2. Choose workspace to be the exported directory if you launch from vivado it will do it automatically
3. Now build a software package File > new application project
      a. Pick a name (test) and make sure you create a board support package click next
      b. In the application window choose helloworld
4. Right click on the application project/src director and click on import > file then click on import files then add temp.h xtmr... and main_XXX.c (XXX corresponds to th project you want)
5. delete helloworld.c
6. Make sure it compiles. File click on application and make sure it refreshes
7. Now program the FPGA. Xilinx Tool > program fpga and load the bistream on the fgpa
8. Connect to output of board : for zedboard do this by typing minicom -s in the terminal and set the source is /dev/ttyACM0  then click exit (note this needs to be in root ask phil for the root password)
9. right click on application and select run > hardware (default debugger). You will now see output from the fpga coming out from the minicom