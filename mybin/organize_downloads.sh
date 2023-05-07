#!/bin/bash

dir='/mnt/Data/Downloads'

#Moving Documents
mv $dir/*.PDF $dir/*.txt $dir/*.pdf  /mnt/Data/Downloads/Documents 2>/dev/null
mv $dir/*.xlsx $dir/*.doc $dir/*.docx $dir/*.xlx  /mnt/Data/Downloads/Documents/OfficeDocuments/ 2>/dev/null

#Images
mv $dir/*.jpg $dir/*.jpeg $dir/*.svg $dir/*.png  /mnt/Data/Downloads/Pictures 2>/dev/null

#Programs
mv $dir/*.msi $dir/*.exe  /mnt/Data/Downloads/Programs/Windows 2>/dev/null
mv $dir/*.deb  /mnt/Data/Downloads/Programs/Linux 2>/dev/null

#Compressed
mv $dir/*.tar $dir/*.zip $dir/*.gz /mnt/Data/Downloads/Compressed 2>/dev/null

#Torrent
mv $dir/*.torrent /mnt/Data/Downloads/Torrent 2>/dev/null

#Misc


echo "$(date "+%m-%d-%Y %H:%M --- ")[organize_download] Successfully Completed" >> /home/srithar/log/cron_status.txt 2>&1

exit 0;
