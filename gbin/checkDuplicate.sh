#!/bin/bash

# Author: Srithar
# Created: 10th July 2023
# Last Modified: 10th July 2023

# Description:
# Compare one with another in the given directory
# If any Duplicate file Found, it will print it in the console

arg=$1

[ -z "$arg" ] && arg="."

count=$(find "$arg" -type f 2>/dev/null | head -n 1000 | wc -l)

if [ $count == 1000 ]; then
	echo "Too Many Files to Compare.. Exiting.." && exit 1;
fi

# Iterate over files in the current directory

IFS=$'\n'

declare -A arr

for file1 in $(find "$arg" -type f); do
	if [ "$file1" != "${arr[$file1]}" ]; then
		for file2 in $(find "$arg" -type f); do
			if [ "$file1" != "$file2" ] ; then
				b=$(cmp "$file1" "$file2" | wc -l)
				[ $b -eq 0 ] && echo "Duplicate --> $file1 --> $file2" && arr["$file2"]="$file2";
			fi
		done
	fi
done

read -p "Press Any Key To Close"

exit 0;