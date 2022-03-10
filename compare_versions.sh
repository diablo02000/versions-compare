#!/bin/bash

# Fill small string version length with 0
# param: ver_1: First version value.
# param: ver_2: Second version value.
function __fillVersionLength(){
    # Keep IFS before variable assignment.
    # It's use to split version string as array.
    local IFS="."
    #shellcheck disable=SC2206
    local -a L_VERSION1_ARR=(${1})
    #shellcheck disable=SC2206
    local -a L_VERSION2_ARR=(${2})

    # If ver_1 length is smaller than ver_2
    if [ "${#L_VERSION1_ARR[@]}" -lt "${#L_VERSION2_ARR[@]}" ];
    then
        # fill ver_1 with 0
        for ((i=${#L_VERSION1_ARR[@]}; i < ${#L_VERSION2_ARR[@]}; i++));
        do
            L_VERSION1_ARR["${i}"]=0
        done

    elif [ "${#L_VERSION1_ARR[@]}" -gt "${#L_VERSION2_ARR[@]}" ];
    then
        # fill ver_1 with 0
        for ((i=${#L_VERSION2_ARR[@]}; i < ${#L_VERSION1_ARR[@]}; i++));
        do
            L_VERSION2_ARR["${i}"]=0
        done
    fi

    # Return versions with same length.
    echo -e "${L_VERSION1_ARR[*]// /.} ${L_VERSION2_ARR[*]// /.}"
}

# Verify than both version are equals
# param version1: First version to compare.
# param version2: Second version to compare.
function versionsAreEquals(){
    local L_VERSION1="${1}"
    local L_VERSION2="${2}"

    # Fill version string to have same length
    IFS=" " read -r L_VERSION1 L_VERSION2 <<< "$(__fillVersionLength "${L_VERSION1}" "${L_VERSION2}")"

    # Check if versions are equal
    if [ "${L_VERSION1}" == "${L_VERSION2}" ];
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
    local L_VERSION1="${1}"
    local L_VERSION2="${2}"

    # Fill version string to have same length
    IFS=" " read -r L_VERSION1 L_VERSION2 <<< "$(__fillVersionLength "${L_VERSION1}" "${L_VERSION2}")"

    # Convert versions string to array
    IFS="." read -ra L_VERSION1_ARR <<< "${L_VERSION1}"
    IFS="." read -ra L_VERSION2_ARR <<< "${L_VERSION2}"

    for ((i=0; i < ${#L_VERSION1_ARR[@]}; i++));
    do
        if (( L_VERSION1_ARR[i] > L_VERSION2_ARR[i] ));
        then
            return 0
        elif (( L_VERSION1_ARR[i] < L_VERSION2_ARR[i] ));
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
    local L_VERSION1=${1}
    local L_VERSION2=${2}

    # Fill version string to have same length
    IFS=" " read -r L_VERSION1 L_VERSION2 <<< "$(__fillVersionLength "${L_VERSION1}" "${L_VERSION2}")"

    # Convert versions string to array
    IFS="." read -ra L_VERSION1_ARR <<< "${L_VERSION1}"
    IFS="." read -ra L_VERSION2_ARR <<< "${L_VERSION2}"

    for ((i=0; i < ${#L_VERSION1_ARR[@]}; i++));
    do
        if (( L_VERSION1_ARR[i] < L_VERSION2_ARR[i] ));
        then
            return 0
        elif (( L_VERSION1_ARR[i] > L_VERSION2_ARR[i] ));
        then
            return 1
        fi
    done

    return 1
}
