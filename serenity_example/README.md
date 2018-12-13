##### Step 1: Setup the work area

```
ipbb init p2fwk-work
cd p2fwk-work
ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git
ipbb add git https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git -b ephemeral/phase2-vC
ipbb add git https://github.com/ipbus/ipbus-firmware -b task/extended-examples
ipbb add git https://github.com/ipbus/ipbus-firmware -b task/extended-examples
ipbb add git https://github.com/p2l1pfp/GlobalCorrelator_HLS -b mp7
```

##### Step 2: Create an ipbb project area


```
git clone https://github.com/violatingcp/GlobalCorrelator.git
cp -r GlobalCorrelator/serenity_example/ku115dc/ src/emp-fwk/projects/examples/ 
ipbb proj create vivado serenity_now emp-fwk:projects/examples/ku115dc  -t top.dep
cd proj/serenity_now
```

##### Step 3: Setup, build and package the bitfile

```
ipbb vivado project
ipbb vivado synth -j4 impl -j4
ipbb vivado package
```



