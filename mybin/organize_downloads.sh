#!/bin/bash

dir='/mnt/Data/Downloads'
logpath='/home/srithar/log/cron_status.txt'


#Moving Documents
mv $dir/*.{pdf,PDF,txt}  $dir/Documents 2>/dev/null
mv $dir/*.{xlsx,doc,docx,xlx}  $dir/Documents/OfficeDocuments/ 2>/dev/null

#Images
mv $dir/*.{jpg,jpeg,svg,png}  $dir/Pictures 2>/dev/null

#Programs
mv $dir/*.{msi,exe}  $dir/Programs/Windows 2>/dev/null
mv $dir/*.deb  $dir/Programs/Linux 2>/dev/null
mv $dir/*.apk  $dir/Programs/Android 2>/dev/null

#Compressed
mv $dir/*.{tar,zip,gz} $dir/Compressed 2>/dev/null

#Torrent
mv $dir/*.torrent $dir/Torrent 2>/dev/null

#Misc


echo "$(date "+%m-%d-%Y %H:%M --- ")[organize_download] Successfully Completed" >> $logpath 2>&1

exit 0;
