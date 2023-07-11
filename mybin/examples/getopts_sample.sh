#!/bin/bash

# Author: Srithar
# Created Date: 07-May-2023


while getopts "f:c:" opt; do
	case "$opt" in
		f) echo "You have given f option ${OPTARG}";;
		c) echo "You have given c option ${OPTARG}";;
		*) echo "Invalid Option";;
	esac
done
