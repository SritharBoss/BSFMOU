#!/bin/bash

# Author: Srithar
# Created: 18th July 2023
# Last Modified: 18th July 2023

# Description:
# Syncs the list of folders provided with github
# And sends notification when there's any changes

file="/mnt/Data/gitpath"

[[ -f "$1" ]] && file="$1"

echo -n "$(date "+%m-%d-%Y %H:%M --- ")" >> /home/srithar/log/cron_status.txt 2>&1


cat "$file" | while read line 
do
	cd $line;
	echo "Processing --> $line"
	if [[ $(git pull) ]]; then
		if [[ $(git status -s | wc -l) > 0 ]]; then
			notify-send "Sync Pending $line" "$(git status -s)";
		fi
	else
		echo "Error while pulling" >> /home/srithar/log/cron_status.txt; exit 1
	fi
done

echo "Git Sync Done.." >> /home/srithar/log/cron_status.txt