#!/usr/bin/env bash
# set -e
# set -u
# set -o pipefail

export CC=$(which hfuzz-clang)
export CXX=$(which hfuzz-clang++)
export AFL=$(which honggfuzz)

for index in 1 2 3 4 5 6 7 8 9 10 11 12 14 15;
do
    timeout=10
    echo  ======== Compiling $index ========
    echo "#define PHI 1 // generated by code2inv" > include/example_$index.h
    ./start.sh -b bin -o output -t tests -e example_$index
    
    echo  ======== Executing $index ========
    timeout $timeout ./fuzz.sh -b bin -o output -t tests -e example_$index
done

rm -rf *.fuzz *.TXT