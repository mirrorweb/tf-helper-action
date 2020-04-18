#!/usr/bin/env bash

readonly delimiter=":::"
declare -A args

for arg in "$@";do
    if [[ $arg == *$delimiter* ]];then
        subcommand="$(echo $arg | awk -F':::' '{print $1}')"
        options="$(echo $arg | awk -F':::' '{print $2}')"
        if [[ ${subcommand} == "pushconfig" ]]; then
            echo tfh ${subcommand} ${options}
        elif [[ ${subcommand} == "pushvars" ]]; then
            echo tfh ${subcommand} ${options}
        elif [[ ${subcommand} == 'pullvars' ]]; then
            echo tfh ${subcommand} ${options}
        else
            echo "tfh subcommand ${subcommand} not yet supported"
        fi
    fi
done

# End
