#!/bin/bash

# Author: Srithar
# Created: 10th July 2023
# Last Modified: 10th July 2023

# Description:
# Compare one with another in the given directory
# If any Duplicate file Found, it will print it in the console

arg=$1

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
off='\033[0m'

[ -z "$arg" ] && arg="."

count=$(find "$arg" -type f 2>/dev/null | head -n 1000 | wc -l)

if [ $count == 1000 ]; then
	echo "Too Many Files to Compare.. Exiting.." && exit 1;
fi

# Iterate over files in the current directory

IFS=$'\n'

declare -A arr
i=0
progress=0
echo -e "${green}Started Scanning...... Scanning ${count} files... ${off}\n"

for file1 in $(find "$arg" -type f); do
	progress=$((progress+1));
	echo -en "${yellow}Scanning  $((progress*100/count))% ${off}\r"
	if [ "$file1" != "${arr[$file1]}" ]; then
		for file2 in $(find "$arg" -type f); do
			if [ "$file1" != "$file2" ] && cmp -s "$file1" "$file2"; then
				echo "Duplicate --> $file1 --> $file2" && arr["$file2"]="$file2" && i=$((i+1));
			fi
		done
	fi
done

[ $i -eq 0 ] && echo -en "\033[K${green}-------- No Duplicates Found -------- " || echo -en "\033[K\n$red-------- $i Duplicates Found -------- "

read -p "Press Any Key To Close"

exit 0;