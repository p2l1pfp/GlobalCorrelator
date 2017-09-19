# GlobalCorrelator

Minimal project to test an example HLS IP.  A block RAM with values filled from a coe init-file are provided to the HLS IP.  The output is watched with ILA.

_n.b. this runs in Vivado 2016.2 right now because the BRAM IP was built in that version_

## Preparing the HLS IP
```
cd ../HLSIPs
vivado_hls -f run_hls.tcl
cd -
```

## Opening the Project 
The project is built on the fly from a Tcl script.  

After setting up Vivado (settings and licenses), do:
```
vivado -mode batch -source build.tcl
vivado GlobalCorrelator/GlobalCorrelator.xpr &
```

## Running the Simulation
From the Flow Navigator, select `Run Synthesis`.
From the Flow Navigator, select `Run Simulation`.

## Updating the Project
You can edit the VHDL in the Vivado GUI or in your favorite Unix text editor.


## Obselete for now...

At least for now, we will try to use the automatically generated Tcl script to build the project.
To generate it, select File > Write Project Tcl... to create an output file called build.tcl with "Do not import sources" selected.  Alternatively, you can do this in the Tcl Console:
```
write_project_tcl -no_copy_sources -force {/home/kreis/GlobalCorrelator/build.tcl}
```

Conveniently, at the top of the generated Tcl script, it will tell you the files you should be sure to check into git.
