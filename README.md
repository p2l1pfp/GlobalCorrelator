# ParticleFlow

Vivado project for developing Particle Flow and Fast PUPPI firmware.  

## Opening the Project 
The project is built on the fly from a Tcl script.  

After setting up Vivado (settings and licenses), do:
```
vivado -mode batch -source build.tcl
vivado ParticeFlow/ParticeFlow.xpr &
```

## Running the Simulation
From the Flow Navigator, select Run Simulation.

## Updating the Project
You can edit the VHDL in the Vivado GUI or in your favorite Unix text editor.

At least for now, we will try to use the automatically generated Tcl script to build the project.
To generate it, select File > Write Project Tcl... to create an output file called build.tcl with "Do not import sources" selected.  Alternatively, you can do this in the Tcl Console:
```
write_project_tcl -no_copy_sources -force {/home/kreis/ParticleFlow/build.tcl}
```

Conveniently, at the top of the generated Tcl script, it will tell you the files you should be sure to check into git.