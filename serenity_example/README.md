##### Step 1: Setup the work area

```
ipbb init p2fwk-work
cd p2fwk-work
#ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git
#ipbb add git https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git -b ephemeral/phase2-vC
ipbb add git https://github.com/ipbus/ipbus-firmware 
cd src
git clone https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git -b serenity_dc_ku115
git clone https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git   -b ephemeral/phase2-vC
cd ..
```

##### Step 2: Create an ipbb project area


```
cd src
git clone https://github.com/violatingcp/GlobalCorrelator_HLS.git -b serenity
cd GlobalCorrelator_HLS
vivado_hls run_hls_fullpfalgo_w_puppi.tcl 
cd -
git clone https://github.com/violatingcp/GlobalCorrelator.git
cp -r GlobalCorrelator/serenity_example/ku115dc/     emp-fwk/projects/examples/ 
cp -r GlobalCorrelator/serenity_example/ku115dc_pfp/ emp-fwk/projects/examples/ 
comment https://gitlab.cern.ch/p2-xware/firmware/emp-fwk/blob/master/boards/serenity/dc_ku115_so1/firmware/cfg/ku115dc.dep#L7
cd ..
ipbb proj create vivado serenity_now_pfp emp-fwk:projects/examples/ku115dc_pfp  -t top.dep
cd proj/serenity_now_pfp
```

##### Step 3: Setup, build and package the bitfile

```
ipbb vivado project
cp ../src/GlobalCorrelator/serenity_example/includePFP.tcl .
vivado -mode batch -source includePFP.tcl
ipbb vivado synth -j4 impl -j4
ipbb vivado package
```

##### Step 4: Run on the serenity

```
open vivado (lxplus)
connect to greg-special port : 3191
select remote server
choose digilent target the one with the KU115
program bitfile
ssh cmx@greg-usb2eth-2
source emp-toolbox/env.sh 
sudo /home/cmx/PCIe/uHAL/pcie_reconnect_xilinx.sh
export UHAL_ENABLE_IPBUS_PCIE=true
cd sioni_pf_test
./pf_pattern_file_test.sh
```

##### Helper: Serenity commands

```
cd ~/PCIe/uHAL/ipbus-software/uhal/Serenity/
source setup.sh
./bin/Power_OFF.exe ./etc/uhal/Serenity/serenity_connections.xml
./bin/Power_ON.exe ./etc/uhal/Serenity/serenity_connections.xml
Monitor
./bin/LTM4677_status.exe ./etc/uhal/Serenity/serenity_connections.xml 
./bin/SI5345.exe --c etc/uhal/Serenity/serenity_connections.xml --source ./SI5345_100MHz_settings.txt
./bin/NDM3Z_status.exe ./etc/uhal/Serenity/serenity_connections.xml
Program
./bin/jsm.exe --c ./etc/uhal/Serenity/serenity_connections.xml --source 1 --target 1

```



