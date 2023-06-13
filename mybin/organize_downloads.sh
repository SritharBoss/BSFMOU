#!/bin/bash

# Author: Srithar
# Created: 13th June 2023
# Last Modified: 13th June 2023

# Description:
# Keeps a folder specified by the user clean by moving files into
# folders based on their file extensions

[ -n "$1" ] && dir="$1" || dir='/mnt/Data/Downloads'

echo "Path is --> $dir"

logpath='/home/srithar/log/cron_status.txt'

echo "Moving Started.."

[ ! -d "$dir/Documents" ] && mkdir "$dir/Documents"
[ ! -d "$dir/Documents/OfficeDocuments" ] && mkdir "$dir/Documents/OfficeDocuments"
[ ! -d "$dir/Pictures" ] && mkdir "$dir/Pictures"
[ ! -d "$dir/Programs" ] && mkdir "$dir/Programs"
[ ! -d "$dir/Programs/Windows" ] && mkdir "$dir/Programs/Windows"
[ ! -d "$dir/Programs/Linux" ] && mkdir "$dir/Programs/Linux"
[ ! -d "$dir/Programs/Android" ] && mkdir "$dir/Programs/Android"
[ ! -d "$dir/Compressed" ] && mkdir "$dir/Compressed"
[ ! -d "$dir/Torrents" ] && mkdir "$dir/Torrents"
[ ! -d "$dir/Scripts" ] && mkdir "$dir/Scripts"

files=$(ls -1 *.{pdf,PDF,txt,xlsx,doc,docx,xlx,csv,jpg,jpeg,svg,png,msi,exe,deb,apk,tar,zip,gz,rar,torrent,sh} 2>/dev/null | wc -l)

#Moving Documents
mv "$dir"/*.{pdf,PDF,txt}  $dir/Documents 2>/dev/null
mv "$dir"/*.{xlsx,doc,docx,xlx,csv} $dir/Documents/OfficeDocuments 2>/dev/null

#Images
mv "$dir"/*.{jpg,jpeg,svg,png}  $dir/Pictures 2>/dev/null

#Programs
mv "$dir"/*.{msi,exe}  $dir/Programs/Windows 2>/dev/null
mv "$dir"/*.deb  $dir/Programs/Linux 2>/dev/null
mv "$dir"/*.apk  $dir/Programs/Android 2>/dev/null

#Compressed
mv "$dir"/*.{tar,zip,gz,rar} $dir/Compressed 2>/dev/null

#Torrent
mv "$dir"/*.torrent $dir/Torrent 2>/dev/null

#Torrent
mv "$dir"/*.sh $dir/Scripts 2>/dev/null

#Misc

echo "Total Files Moved --> $files"


echo "$(date "+%m-%d-%Y %H:%M --- ")[organize_download] Successfully Completed. Files Moved --> $files" >> $logpath 2>&1

exit 0;
