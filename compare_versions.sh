#!/bin/bash

# Compare 2 versions and echo:
# * 0 if same version.
# * 1 if v1 is newer than v2.
# * -1 if v1 is older than v2.
function compare(){

	local v1="${1}"
	local v2="${2}"

	# check if versions are the same.
	if [[ ${v1} == ${v2} ]];
	then
		return 0
	fi

	# Convert versions in list
	IFS='.' read -r -a v1 <<< "${v1}"
	IFS='.' read -r -a v2 <<< "${v2}"

	# Fill empty field in v1 if v2 size
	# is longer than v2
	for ((i=${#v1[@]}; i<${#v2[@]}; i++ ))
	do
		v1[${i}]=0
	done

	# compare each v1 fields to v2
	for ((i=0; i<${#v1[@]}; i++))
    	do
		# Catch if idx value doesn't exist in v2
        	if [[ -z ${v2[i]} ]]
        	then
            		v2[i]=0
        	fi

		# if v1 is newer than v2
        	if ((10#${v1[i]} > 10#${v2[i]}))
        	then
            		return 1
        	fi

		# if v1 is older than v2
        	if ((10#${v1[i]} < 10#${v2[i]}))
        	then
            		return 2
        	fi
    	done

    	return 0
}

# Check if version is newer
function is_newer(){
	local v1="${1}"
	local v2="${2}"

	compare ${v1} ${v2}

	if [[ $? == 1 ]];
	then
		return 0
	else
		return 1
	fi
}

# Check if version is newer
function is_older(){
	local v1="${1}"
	local v2="${2}"

	compare ${v1} ${v2}

	if [[ $? == 2 ]];
	then
		return 0
	else
		return 1
	fi
}

# Check if versions are the same
function is_equal(){
	local v1="${1}"
	local v2="${2}"

	compare ${v1} ${v2}

	if [[ $? == 0 ]];
	then
		return 0
	else
		return 1
	fi
}
