#!/bin/bash

OFFSET=56
E2LS="e2ls"
E2CP="e2cp -p"
export LANG=C

list_recursive() {
    ${E2LS} -c -l "${1}" | cut -b ${OFFSET}- | while read line
    do
        if [[ z$line == "z" ]] ; then
            continue
        fi
        path="$(echo ${1}/${line}|sed s://:/:g)"
        path_raw=$(echo ${path}|sed 's/^[^:]*://g')
        errormsg=$(${E2LS} -l "${path}/test" 2>&1 >/dev/null)
        if [[ "${errormsg}" == *"Ext2 inode is not a directory"* ]];then
            ${E2CP} "${path}" "${dest}${path_raw}"
        else
            mkdir -p "${dest}${path_raw}"
            list_recursive "${path}"
        fi
    done
}

if [[ "${1}" == *":"* ]];then
    prefix="${1}"
else
    prefix="${1}:"
fi

dest=${2}

list_recursive ${prefix}
