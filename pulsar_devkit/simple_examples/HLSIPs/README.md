# Vivado HLS Examples
<!-- MarkdownTOC -->

- Introduction
- Available Examples
- Directions

<!-- /MarkdownTOC -->

## Introduction
This folder contains examples of how one might use Xilinx Vivado HLS. Each program is meant to illustrate one aspect of Vivado HLS (i.e. how to use a struct). While an effort has been made to make these examples perform well, do not consider these fully optimized recommendations. Undoubtedly one will have to piece together several of these examples to form a more complete IP.

## Available Examples

The following is a list of available examples:

Example Name  | TCL File                     | Description
------------  | --------                     | -----------
Simple Algo   | run_simple_algo.tcl          | How to add two numbers 
Add 4 Vectors | run_simple_algo_add4vec.tcl  | How to add 4-vectors
Array         | run_simple_algo_array.tcl    | Basic example of how to use arrays
Division      | run_simple_algo_division.tcl | The simplest example of how to implement division using a LUT. Using a LUT is faster than allowing the FPGA to make a division core.
Find Max      | run_simple_algo_find_max.tcl | Example of how to implement linear and parallel find_max functions. There are three versions of the parallel find_max function; one that allow HLS to optimize the algorithm, one that is optimized by hand, and one that uses four comparisons at once rather than two. It turns out that the HLS optimization is the same as the by-hand optimization.
mT            | run_simple_algo_mt.tcl       | Example of forming a mT.
Sort          | run_simple_algo_sort.tcl     | Example of two sorting algorithms. Neither are deterministic in their length and thus a full timing report is not possible.
Stream        | run_simple_algo_stream.tcl   | Example of how to implement an hls::stream in a somewhat efficient manner. This code is fairly optimized, but might be optimized further using pragma statements.
Structs       | run_simple_algo_struct.tcl   | This code contains examples of using structs, a struct of arrays, arrays of structs, and bit shifting by an ap_fixed value. From these one can find that a struct of arrays and an array of structs use the same resources, but not the same ports.

## Directions

To run use the following command:
```bash
vivado_hls -f run_<your example>.tcl
```
