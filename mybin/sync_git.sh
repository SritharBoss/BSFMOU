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

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

cat "$file" | while read line 
do
	cd $line;
	echo "Processing --> $line"
	
	if [[ $(git pull) ]]; then
		if [[ $(git status -s | wc -l) > 0 ]]; then
			if [[ "$line" == '/mnt/Data/Docs' ]]; then
				notify-send -i "$HOME/.icons/tick.svg" "Auto Committed : $line" "$(git status -s)";
				git add . && git commit -m 'Auto Commit from crontab' && git push;
			else
				notify-send -i "$HOME/.icons/warning.png" "Sync Pending $line" "$(git status -s)";
			fi
		fi
	else
		echo "Error while pulling" >> /home/srithar/log/cron_status.txt; exit 1
	fi
done

echo "Git Sync Done.." >> /home/srithar/log/cron_status.txt