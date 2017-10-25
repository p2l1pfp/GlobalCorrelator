# Regionizer

* reads in objects from 12 phi sectors, assuming 2 clock cycles to receive one object, and a max of 15 objects per sector (so, 30 clock cycles to read all)
* a new set of input objects is expected every 36 clock cycles (this corresponds to a time-multiplexing period of 6 BX if we stay with the current 240 MHz clock)
* objects in each sector are put into 3 bins of eta, with partial overlaps, sorted in pt, and cropped to a max of 8 objects per sector per eta
* then, things are reassembled to fill 18 detector regions (3 in eta, 6 in phi), with partial overlaps, and up to 20 objects per sector (pt-sorted, and with with eta and phi coordinates adjusted to be relative to the region center)
* the module then outputs each of the 18 sectors sequentially (one per clock cycle, but it can be changed easily), with the idea that it would be fed into the PF IP core
* there's a test bench that can read what is produced by the regionizer HLS code (https://github.com/p2l1pfp/GlobalCorrelator_HLS/pull/14) and produces output in that format.

Use `run_regionizer_tb.sh` to compile the VHDL and run behavioural simulation with the test bench.

