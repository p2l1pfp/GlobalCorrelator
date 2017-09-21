# GlobalCorrelator

Minimal project to test an example HLS IP.  A block RAM with values filled from a coe init-file are provided to the HLS IP.  The output is watched with ILA.

_n.b. this runs in Vivado 2016.2 right now because the BRAM IP was built in that version_

_This current example can be run on the Pulsar with part number: xc7vx690tffg1927-2.  
You also need to know the clock pins for your setup.  Pulsar has a 200 MHz LVDS on pins AU15 (+) and AV15 (-).
This is defined in the `xdc/constraints.xdc` file_

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
vivado top/top.xpr &
```

## Running the Synthesis/Implementation
From the Flow Navigator, select `Run Synthesis`.
From the Flow Navigator, select `Run Implementation` then generate bitfile.

Alternatively, you can add this to the bottom of the `build.tcl` to get the bit file directly with these lines:
```
update_compile_order -fileset sources_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
```

This will make two files you will need:
`top/top.runs/impl_1/top.bit`
`top/top.runs/impl_1/debug_nets.ltx`

## Running on the Pulsar board

   * Power on board, connect JTAG
   * Open up Vivado, "Open Hardware Manager"
   * Under the "Hardware window" push "autoconnect", you should see your device in the list "xc7vx..."
   * Right click on the device and choose "Program Device...", choose the `top.bit` and `debug_nets.ltx` files that were created in the last step.  When the device is programmed, you should see as one of the IPs `hw_ila_1`
   * Et voila!  You should see traces as seen by `hw_ila_1`

## Updating the Project
You can edit the VHDL in the Vivado GUI or in your favorite Unix text editor.


## Obselete for now...

At least for now, we will try to use the automatically generated Tcl script to build the project.
To generate it, select File > Write Project Tcl... to create an output file called build.tcl with "Do not import sources" selected.  Alternatively, you can do this in the Tcl Console:
```
write_project_tcl -no_copy_sources -force {/home/kreis/GlobalCorrelator/build.tcl}
```

Conveniently, at the top of the generated Tcl script, it will tell you the files you should be sure to check into git.
