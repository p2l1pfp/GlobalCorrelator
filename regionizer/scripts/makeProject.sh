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
BASE_DIR=`pwd`

test -d $BUILD_DIR || mkdir $BUILD_DIR
cd $BUILD_DIR

# Anonymous checkout of ipbb
if test -d ipbb; then
    echo "Using existing ipbb tool";
else
    curl -L https://github.com/ipbus/ipbb/archive/v0.2.8.tar.gz | tar xvz
    mv ipbb-0.2.8 ipbb
fi;

source ipbb/env.sh

test -d mp7pf && rm -rf mp7pf
ipbb init mp7pf

mkdir mp7pf/src/pfMP7
pushd mp7pf/src/pfMP7
ln -sf ../../../../../regionizer .
popd

pushd mp7pf/src
## Get MP7 core firmware
ipbb add git https://gitlab.cern.ch/thea/mp7.git -b master-standalone
## Get IPbus firmware
ipbb add git https://github.com/ipbus/ipbus-firmware.git
popd


pushd mp7pf
ipbb proj create vivado mp7pf_build pfMP7:regionizer -t top.dep
popd

pushd mp7pf/proj/mp7pf_build/
ipbb vivado project reset
# Link in timing checker script.
if [ ! -f "checkTiming.py" ]; then
  ln -s ../../../../scripts/checkTiming.py
fi
popd
