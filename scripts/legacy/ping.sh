#!/bin/bash
#https://unix.stackexchange.com/questions/293107/bash-using-printf-in-order-to-print-in-special-format
list=(localhost google.com nowhere)
C=1
for M in "${list[@]}"
do
    machine_indented=$(printf '%-20s' "$M")
    machine_indented=${machine_indented// /.}

    if ping -q -c 1  "$M" &>/dev/null ;  then
        printf " (%2d) %s CONNECTION OK\n" "$C" "$machine_indented"
    else
        printf " (%2d) %s CONNECTION FAIL\n" "$C" "$machine_indented"
    fi
    ((C=C+1))
done
