#!/bin/bash

moviefolder="/mnt/Data/Movies"

if [ -z "$1" ] || { [[ "$1" != *.mkv ]] && [[ "$1" != *.mp4 ]]; }; then
 echo "Please input the movie mkv/mp4 file";
 echo "For MKV file, you can give subtitle in the second argument"
 echo "USAGE : $0 <moviepath> Subtitle to MUX"
 exit 1;
fi

if [[ ! -e "$1" ]]; then
 echo "File not found"
 exit 1;
fi

TRIM(){
echo "$1" | sed -e 's/^[ ]*//g' -e 's/[ ]*$//g'
}

DOPROPEDIT(){

mkvpropedit "${movie}" --edit info --set "title=${movie%.*}" >/dev/null
echo "Title Updated";

num_attachments=$(mkvinfo "$movie" | grep "Track number" | tail -n 1 | grep -Eo 'Track number: [0-9]*'| grep -o '[0-9]*')

echo "Attchments Total : $num_attachments"

if [[ -n num_attachments ]]; then

for ((i=1; i<=$num_attachments; i++)); do
    mkvpropedit "$movie" --edit track:$i --set "name="SritharBoss"" >/dev/null
	echo "Attachment $i Updated"
done

fi

}

DOSUBMUX(){
 #movie="$(basename "$(echo $1)")"
 #movie_edit=$(echo "$movie" | sed 's/\([ -]*[([][a-zA-Z0-9]*.[a-zA-Z]\{2,6\}[])][ -]*\)//g')

 sub="$(basename "$(echo $2)")"
 sub_edit=$(echo "$sub" | sed 's/\([ -]*[([][a-zA-Z0-9]*.[a-zA-Z]\{2,6\}[])][ -]*\)//g')

 movie_ex_r=${movie_edit%.*}_SUB.mkv

 cd "$(dirname "$1")"

 [[ "$movie" != "$movie_edit" ]] && mv "$movie" "$movie_edit"
 [[ "$sub" != "$sub_edit" ]] && mv "$sub" "$sub_edit"

 mkvmerge -o "$movie_ex_r" "$movie_edit" --sub-charset 0:utf-8 --default-track 0:yes --track-name 0:"$sub_edit" && rm "$movie_edit" && rm "$sub_edit" && mv "$movie_ex_r" "$movie_edit"

}


select lang in Tamil English Others/Malayalam Others/Telugu Others/Korean Others/Japanese Others/French Others/Spanish;
do
	moviefolder=$moviefolder
    movie="$(basename "$(echo $1)")"
    pattern="^([a-zA-Z0-9 -:]*)\s*\(([0-9]{4})\)"
	cd "$(dirname "$1")"
	movie_edit=$(echo "$movie" | sed 's/\([ -]*[([][a-zA-Z0-9]*.[a-zA-Z]\{2,6\}[])][ -]*\)//g')
	[[ -n $2 ]] && [[ "$1" == *.mkv ]] && DOSUBMUX "$1" "$2" && exit 0;
	[[ "$1" == *.mkv ]] && DOPROPEDIT
	
	if [[ $movie =~ $pattern ]];then
		moviename=$(TRIM "${BASH_REMATCH[1]}")
		year="${BASH_REMATCH[2]}"
		moviefolder="$moviefolder/$lang/$moviename ($year)"
		[[ ! -d "$moviefolder"  ]] && mkdir "$moviefolder"
		[[ -e "$moviefolder/$movie" ]] && echo 'File Already Exists' && exit 1;
		mv "$1" "$moviefolder"
		echo File Moved
		[[ "$moviefolder/$movie" != "$moviefolder/$movie_edit" ]]  && mv "$moviefolder/$movie" "$moviefolder/$movie_edit"
	else
		echo "Filename is not in the pattern."
    fi
break
done
exit 0;
