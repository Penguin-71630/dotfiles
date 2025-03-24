#!/bin/sh

usage() {
    echo "Usage: verilate verilog.v testbench.cpp"
    exit 1
}

if [ "$#" -ne 2 ]; then
    echo "Illegal number of arguments."
    usage
fi


fileName=$(basename "${1}" .v)
benchName=$(basename "${2}" .cpp)

verilator -Wall --cc "${fileName}.v" --exe "${benchName}.cpp" --trace
make -C obj_dir -f "V${fileName}.mk" "V${fileName}"
./obj_dir/"V${fileName}"

