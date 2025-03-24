#!/bin/bash
function handle_input()
{
    local args=$(getopt -o "" -l "nation:,height:,is-student:,english-level:" -- "$@")
    eval set -- "${args}"
    while true
    do
        case "${1}" in
            --nation)
                _NATION=${2}
                shift 2
            ;;
            --height)
                _HEIGHT=${2}
                shift 2
            ;;
            --is-student)
                _IS_STUDENT=${2}
                shift 2
            ;;
            --english-level)
                _ENGLISH_LEVEL=${2}
                shift 2
            ;;
            --)
                shift
                break
            ;;
        esac
    done

}

function main()
{
    handle_input $@

    if [ "${_NATION}" != "" ]
    then
      eval echo "nation is ${_NATION}"
    fi

    if [ "${_HEIGHT}" == "" ]
    then
        echo "height is null"
    fi

    if [ "${_IS_STUDENT}" == false ]
    then
        echo "is not student"
    fi

    if [ "${_ENGLISH_LEVEL}" == "" ]
    then
        echo "can't speak english"
    fi
}
main $@


