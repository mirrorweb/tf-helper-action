#!/usr/bin/env bash

set -x

readonly delimiter=":::"
declare -A args

for arg in "$@";do
    if [[ $arg == *$delimiter* ]];then
        subcommand="$(echo $arg | awk -F':::' '{print $1}')"
        options="$(echo $arg | awk -F':::' '{print $2}')"
        if [[ ${subcommand} == "pushconfig" ]]; then
            tfh ${subcommand} ${options}
        elif [[ ${subcommand} == "pushvars" ]]; then
             tfh ${subcommand} ${options}
        elif [[ ${subcommand} == 'pullvars' ]]; then
            tfh ${subcommand} ${options}
        else
            echo "tfh subcommand ${subcommand} not yet supported"
        fi
    fi
done

# End
