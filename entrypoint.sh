#!/usr/bin/env bash

readonly delimiter=":::"

while IFS= read -r arg; do
    if [[ $arg == *$delimiter* ]];then
        subcommand="$(echo $arg | sed 's/^.*INPUT_.*="//' | awk -F':::' '{print $1}')"
        options="$(echo $arg | sed 's/^.*INPUT_.*="//' | awk -F':::' '{print $2}' | sed 's/"$//')"
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
done < <( env | grep 'INPUT_')

# End
