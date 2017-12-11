#!/bin/bash
if [[ "$1" == "" ]]; then 
    echo "Usage: $BASH_SOURCE testbench.vhd";
    exit 1;
fi;
TESTBASE=$(basename $1);
HERE=$(dirname $BASH_SOURCE);
cd $HERE || exit 1;

if test \! -f hdl/$TESTBASE; then
    echo "Missing testbench source file $TESTBASE in $HERE/hdl ";
    exit 2;
fi;

#if false; then #uncomment to skip the compilation & running and debug the validation part of this script

rm -r xsim.dir/ 2> /dev/null || true 

## compilation (algo)
DEPFILE=../firmware/cfg/bram_hist_vtx.dep
test -f $DEPFILE || exit 4;
for F in $(awk '/^src +-c +regionizer +/{print $4}' $DEPFILE); do
    xvhdl ../../../regionizer/firmware/hdl/$F || exit 4;
    grep -q ERROR xvhdl.log && exit 4;
done;
for F in $(awk '/^src +[a-zA-Z0-9_-]+\.vhd/{print $2}' $DEPFILE); do
    xvhdl ../firmware/hdl/$F || exit 4;
    grep -q ERROR xvhdl.log && exit 4;
done;
## compilation (testbench)
DEPFILE=cfg/testbench.dep
test -f $DEPFILE || exit 4;
for F in $(awk '/^src +-c +regionizer +/{print $4}' $DEPFILE); do
    xvhdl ../../../regionizer/testbench/hdl/$F || exit 4;
    grep -q ERROR xvhdl.log && exit 4;
done;
for F in $(awk '/^src +[a-zA-Z0-9_-]+\.vhd/{print $2}' $DEPFILE) $TESTBASE; do
    xvhdl $HERE/hdl/$F || exit 4;
    grep -q ERROR xvhdl.log && exit 4;
done;

## elaboration
xelab testbench -s test -debug all || exit 5;
grep -q ERROR xelab.log && exit 5;

## simulation
if [[ "$2" == "--gui" ]]; then
    xsim test --gui
    exit 0;
fi;

xsim test -R || exit 6;
grep -q ERROR xsim.log && exit 6;

#fi #uncomment to skip the compilation & running and debug the validation part of this script

COMP_SCRIPT="mp7_pattern_diff.py"
if which $COMP_SCRIPT > /dev/null 2>&1; then
    ## determine output file name
    OUTFILE=$(perl -ne 's/--.*//; m/file.*open write_mode.*"(.*_hdltb.txt)/ and print "$1\n";' hdl/$TESTBASE)
    if [[ "$OUTFILE" == "" ]] || test \! -f $OUTFILE ; then
        echo "Could not find output file $OUTFILE for this testbench"; 
        exit 0; # this step is optional
    fi;

    ## look for reference file
    REFFILE=data/${OUTFILE/_hdltb/}
    if test \! -f $REFFILE; then
        echo "Could not find reference file $REFFILE for this testbench"; 
        exit 0; # this step is optional
    fi;

    ## run comparison
    echo "Doing pattern comparison of $OUTFILE vs reference $REFFILE";
    echo "  $   $COMP_SCRIPT $REFFILE $OUTFILE --ac";
    $COMP_SCRIPT $REFFILE $OUTFILE --ac;
fi
