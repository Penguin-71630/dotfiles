#!/bin/bash

export COLOREND="\x1b[0m"

export BLACK="\x1b[30m"
export RED="\x1b[31m"
export GREEN="\x1b[32m"
export YELLOW="\x1b[33m"
export BLUE="\x1b[34m"
export PURPLE="\x1b[35m"
export CYAN="\x1b[36m"
export WHITE="\x1b[37m"
export GRAY="\x1b[90m"

export BG_BLACK="\x1b[40m"
export BG_RED="\x1b[41m"
export BG_GREEN="\x1b[42m"
export BG_YELLOW="\x1b[43m"
export BG_BLUE="\x1b[44m"
export BG_PURPLE="\x1b[45m"
export BG_CYAN="\x1b[46m"
export BG_WHITE="\x1b[47m"
export BG_GRAY="\x1b[100m"

PrintUsage() {
    echo "Usage:  ./runcpp.sh <code.cpp> [-n|--nocompile] [-c|--compileonly]"
    echo
    echo "> The input files should be under \"testcases/\" directory."
    echo "> The \"testcases/\" directory should share the same path with CODEFILE. (Or you can modify the path in run.sh by yourself)"
    echo "> The input files should be named in the following manner:"
    echo "  1.in 2.in ... etc."
    echo
    echo "folder/"
    echo "  |- <code>.cpp"
    echo "  |- testcases/"
    echo "     |- 1.in"
    echo "     |- 2.in"
    echo "     |- ..."
    echo
    echo "Output file format:"
    echo "  1.ot 2.ot ... etc."
    echo
    echo "Stderr file format:"
    echo "  1.err 2.err ... etc."
    echo
}

if [ $# -eq 0 ]; then
    PrintUsage
    exit 0
elif [ "$1" = "--help" ]; then
    PrintUsage
    exit 0
elif ! [ -e "${1}" ]; then
    echo -e ${RED}"[CODEFILE NOT EXIST]"${COLOREND}
    echo
    PrintUsage
    exit 1
fi

codeFileName="$(basename "${1}" .cpp)"
codePath="$(dirname "${1}")"

# Parse Arguments
flagNoCompile=0
flagCompileOnly=0

args=$(getopt -o "nc" -l "nocompile,compileonly" -- "$@")
eval set -- "${args}"
while true; do
    case "${1}" in
    -n | --nocompile)
        flagNoCompile=1
        shift
        ;;
    -c | --compileonly)
        flagCompileOnly=1
        shift
        ;;
    *)
        shift
        break
        ;;
    esac
done

##################################################################################################################################################
RunTest() {
    startTime=$(date +%s%N)
    inputFile=$1
    inputFilePath="$(dirname "${inputFile}")"
    if ! [ -e "${inputFile}" ]; then
        return 1
    fi
    inputFileName="$(basename "${inputFile}" .in)"

    println thin
    echo -e ${CYAN}"[RUNNING ${inputFileName}]"${COLOREND}
    println

    println
    echo -e ${GRAY}"########## INPUT ###########"${COLOREND}
    cat "${inputFile}"
    println

    "${codePath}/${codeFileName}.out" <"${inputFile}" 1>"${inputFilePath}/${inputFileName}.ot" #2>"${inputFilePath}/${inputFileName}.err"
    testResult=$?

    echo -e ${GRAY}"########## STDERR ##########"${COLOREND}
    cat "${inputFilePath}/${inputFileName}.err"
    println

    echo -e ${GRAY}"########## OUTPUT ##########" ${COLOREND}
    cat "${inputFilePath}/${inputFileName}.ot"
    println

    endTime=$(date +%s%N)
    delta=$((${endTime} - ${startTime}))
    delta=$((${delta} / 1000000))

    println
    echo -e "("${BG_GRAY}"Time"${COLOREND}": ${delta}ms  |  "${BG_GRAY}"Return Value"${COLOREND}": ${testResult})"
    #println thin
    for i in $(seq 0 5); do
        println
    done

    return 0
}

RunWithoutInputFile() {
    startTime=$(date +%s%N)

    println thin
    echo -e ${CYAN}"[RUNNING without input file]"${COLOREND}
    println

    println
    echo -e ${GRAY}"########## INPUT ###########"${COLOREND}
    println

    println
    echo -e ${GRAY}"########## STDERR ##########"${COLOREND}

    # "${codePath}/${codeFileName}.out" 1>"${codePath}/${codeFileName}.ot" 2>"${codePath}/${codeFileName}.err"
    "${codePath}/${codeFileName}.out" 1>"${codePath}/${codeFileName}.ot"
    testResult=$?

    # println
    # echo -e ${GRAY}"########## STDERR ##########"${COLOREND}
    # cat "${codePath}/${codeFileName}.err"

    println
    echo -e ${GRAY}"########## OUTPUT ##########" ${COLOREND}
    cat "${codePath}/${codeFileName}.ot"

    endTime=$(date +%s%N)
    delta=$((${endTime} - ${startTime}))
    delta=$((${delta} / 1000000))

    println
    echo -e "("${BG_GRAY}"Time"${COLOREND}": ${delta}ms  |  "${BG_GRAY}"Return Value"${COLOREND}": ${testResult})"
    #println thin
    for i in $(seq 0 7); do
        println
    done

    return 0
}
##################################################################################################################################################

clear

println() {
    if [ "$1" = "bold" ]; then
        echo -e ${GRAY}=======================================${COLOREND}
    elif [ "$1" = "thin" ]; then
        echo -e ${GRAY}---------------------------------------${COLOREND}
    else
        echo
    fi
}

echo "> Code File:" "${1}"

println
#println bold

if [ $flagNoCompile -ne 1 ]; then
    echo -e ${CYAN}"[START COMPILE]"${COLOREND}
    println

    g++ -std=c++17 \
        -o "${codePath}"/"${codeFileName}".out \
        -O2 -Wall -Wextra \
        -g -fsanitize=undefined,address \
        -static-libasan \
        "${1}"

    compileResult=$?
    println
    echo -e ${GREEN}"[DONE COMPILE]"${COLOREND}
else
    echo -e ${CYAN}"[SKIP COMPILE]"${COLOREND}
    compileResult=0
fi

#println bold
println
println
println

if [ $compileResult -ne 0 ]; then
    println
    println
    echo [COMPILE ERROR]
    echo I will not run any test since your code is buggy.
    println
    println bold
    exit 1
fi

if [ $flagCompileOnly -eq 1 ]; then
    echo [COMPILE ONLY]
    exit 0
fi

outputOnly=0

if [ ! -d "${codePath}/testcases/" ] || [ -z "$(ls -A "${codePath}"/testcases/ | grep .in)" ]; then
    echo "> Directory \"testcases\" doesn't exists or no input file in that directory."
    echo "> Therefore I'm assuming that you're running an output-only program."
    outputOnly=1
fi

for inputFile in "${codePath}"/testcases/*.in; do
    RunTest "${inputFile}"
done

if [ $outputOnly -eq 1 ]; then
    RunWithoutInputFile
fi
