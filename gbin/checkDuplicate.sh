#!/bin/bash

# Author: Srithar
# Created: 10th July 2023
# Last Modified: 10th July 2023

# Description:
# Compare one with another in the given directory
# If any Duplicate file Found, it will print it in the console


while getopts "p:d:hs:r" opt; do
	case "$opt" in
		p) arg="${OPTARG}";;
		d) depth="${OPTARG}";;
		h) echo -e "USAGE --> \np - Path to scan \nd - Max Depth to scan in sub directories" && exit 0;;
		s) size=$OPTARG;;
		r) remove="remove";;
		*) echo "Invalid Option; -h for Help" && exit 1;;
	esac
done

red='\033[01;31m'
green='\033[01;32m'
yellow='\033[0;33m'
off='\033[0m'

[ -z "$arg" ] && arg="." || [ "$arg" != "." ] && [ ! -e "$arg" ] && echo "Given Directory not exists.. " && exit 2;

find_cmd="find \"$arg\""

if [[ -n "$depth" ]]; then
  if [[ "$depth" =~ ^[0-9]+$ ]]; then
    find_cmd+=" -maxdepth $depth"
  else
    echo "Please provide valid Depth in Numbers."
    exit 3
  fi
fi

if [[ -n "$size" ]]; then
  if [[ "$size" =~ ^([+-][0-9]{1,6}[bcwkMG])$ ]]; then
    find_cmd+=" -size $size"
  else
    echo "Please provide valid Size Ex. +100k, +2048c, -10G"
    exit 4
  fi
fi

find_cmd+=" -type f"

count=$(eval "$find_cmd" 2>/dev/null | head -n 1000 | wc -l)

if [ $count == 1000 ]; then
	echo "Too Many Files to Compare.. Exiting.." && exit 5;
fi

# Iterate over files in the current directory

IFS=$'\n'

declare -A arr
i=0
progress=0
echo -e "${green}Total ${count} files... Directory --> $(realpath "$arg")${off}\n"

for file1 in $(eval "$find_cmd" 2>/dev/null); do
	progress=$((progress+1));
	echo -en "\033[K${yellow}Scanning  $((progress*100/count))% --> $file1 ${off}\r"
	if [ "$file1" != "${arr[$file1]}" ]; then
		for file2 in $(eval "$find_cmd" 2>/dev/null); do
			if [ "$file1" != "$file2" ] && cmp -s "$file1" "$file2"; then
				if [ "$remove" == "remove" ];then
					echo -en "\033[K"
					select s in "$file1" "$file2" "Skip"
					do
						if [ "$s" != "Skip" ]; then
							rm "$s" && echo -e "${red}Removed $s${off}" || echo "Error While Deleting $s"
						fi
					break
					done
				else
					echo "Duplicate --> $file1 --> $file2"
				fi
				arr["$file2"]="$file2"
				i=$((i+1));
			fi
		done
	fi
done

[ $i -eq 0 ] && echo -en "\033[K${green}-------- No Duplicates Found -------- " || echo -en "\033[K\n$red-------- $i Duplicates Found -------- "

read -n 1 -s -r -p "Press any key to continue"

echo

exit 0;