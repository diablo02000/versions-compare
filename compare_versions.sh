#!/bin/bash

# Add 0 to the smallest string until both
# strings have the same length
function _fillStringLength(){

    # Convert both string in array
    IFS="." read -ra string1 <<< "${1}"
    IFS="." read -ra string2 <<< "${2}"

    # If string1 length is smaller than string2
    if [ "${#string1[@]}" -lt "${#string2[@]}" ];
    then
        # fill string1 with 0
        for ((i=${#string1[@]}; i < ${#string2[@]}; i++));
        do
            string1["${i}"]=0
        done
    # If string1 length is greater than string2
    elif [ "${#string1[@]}" -gt "${#string2[@]}" ];
    then
        # fill string2 with 0
        for ((i=${#string2[@]}; i < ${#string1[@]}; i++));
        do
            string2["${i}"]=0
        done
    fi

    # Return both string with same length.
    echo -e "${string1[*]// /.} ${string2[*]// /.}"
}

# Verify than both version are equals
# param version1: First version to compare.
# param version2: Second version to compare.
function versionsAreEquals(){
    local version1="${1}"
    local version2="${2}"

    # Update versions format to have same length
    IFS=" " read -r version1 version2 <<< "$(_fillStringLength "${version1}" "${version2}")"

    # Check if versions are equal
    if [ "${version1}" == "${version2}" ];
    then
        return 0
    else
        return 1
    fi
}

# Verify than version are newer than another version
# param version1: First version to compare.
# param version2: Second version to compare.
function versionIsNewer(){
    local version1="${1}"
    local version2="${2}"

    # Update versions format to have same length
    IFS=" " read -r version1 version2 <<< "$(_fillStringLength "${version1}" "${version2}")"

    # Convert versions string to array
    IFS="." read -ra version1_list <<< "${version1}"
    IFS="." read -ra version2_list <<< "${version2}"

    for ((i=0; i < ${#version1_list[@]}; i++));
    do
        if (( version1_list[i] > version2_list[i] ));
        then
            return 0
        elif (( version1_list[i] < version2_list[i] ));
        then
            return 1
        fi
    done

    return 1
}


# Verify than version are older than another version
# param version1: First version to compare.
# param version2: Second version to compare.
function versionIsOlder(){
    local version1=${1}
    local version2=${2}

    # Update versions format to have same length
    IFS=" " read -r version1 version2 <<< "$(_fillStringLength "${version1}" "${version2}")"

    # Convert versions string to array
    IFS="." read -ra version1_list <<< "${version1}"
    IFS="." read -ra version2_list <<< "${version2}"

    for ((i=0; i < ${#version1_list[@]}; i++));
    do
        if (( version1_list[i] < version2_list[i] ));
        then
            return 0
        elif (( version1_list[i] > version2_list[i] ));
        then
            return 1
        fi
    done

    return 1
}
