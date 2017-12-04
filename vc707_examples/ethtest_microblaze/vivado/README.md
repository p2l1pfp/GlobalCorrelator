Make the vivado project setups:

1. Open vivado.

2a. Pick a project and type :
source vc707_hpc2_axieth_v0.tcl

2b. vivado vc707_hpc2_axieth.xpr &

3. Run implementation/sythesis/generate bistream

4. File export hardware (include bitstream)
     a. Easisest is to use local directory

5. File launch SDK (now follow the SDK instructions)
     a. Import ethtest directory in ../sdk
