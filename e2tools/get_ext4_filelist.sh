#!/bin/sh

OFFSET=56
E2LS=e2ls
export LANG=C

list_recursive() {
    ${E2LS} -c -l "${1}" | cut -b ${OFFSET}- | while read line
    do
        if [[ z$line == "z" ]] ; then
            continue
        fi
        path="$(echo ${1}/${line}|sed s://:/:g)"
        errormsg=$(${E2LS} -l "${path}/test" 2>&1 >/dev/null)
        if [[ "${errormsg}" == *"Ext2 inode is not a directory"* ]];then
            echo "${path}"
        else
            list_recursive "${path}"
        fi
    done
}

if [[ "${1}" == *":"* ]];then
    prefix="${1}"
else
    prefix="${1}:"
fi

list_recursive $prefix
