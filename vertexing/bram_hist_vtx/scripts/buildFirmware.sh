#!/bin/bash
set -e # Exit on error.

if [ -f buildToolSetup.sh ] ; then
    source buildToolSetup.sh
fi

if [ -z ${XILINX_VIVADO:+x} ] ; then
    echo "Xilinx Vivado environment has not been sourced. Exiting."
    exit 1
else
    echo "Found Xilinx Vivado at" ${XILINX_VIVADO}
fi

BUILD_DIR="build/"
cd $BUILD_DIR

source ipbb/env.sh

cd mp7pf/proj/mp7pf_build/

ipbb vivado reset synth impl
python checkTiming.py
