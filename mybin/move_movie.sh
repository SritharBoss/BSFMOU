#/bin/bash

moviefolder="/mnt/Data/Movies"

TRIM(){
echo "$1" | sed -e 's/^[ ]*//g' -e 's/[ ]*$//g'
}

if [[ -z "$1" ]]; then
 echo "Please input the movie file";
 echo "USAGE : $0 <moviepath>"
 exit 1;
fi

if [[ ! -e "$1" ]]; then
 echo "File not found"
 exit 1;
fi

select lang in Tamil English Others/Malayalam Others/Telugu Others/Korean Others/Japanese Others/French Others/Spanish;
do
	moviefolder=$moviefolder
        movie="$(basename "$(echo $1)")"
        #pattern="^(.*?)\s*\((\d{4})\)"
        pattern="^([a-zA-Z0-9 ]*)\s*\(([0-9]{4})\)"
        if [[ $movie =~ $pattern ]];then
         moviename=$(TRIM "${BASH_REMATCH[1]}")
         year="${BASH_REMATCH[2]}"
         moviefolder="$moviefolder/$lang/$moviename ($year)"
         if [[ ! -d "$moviefolder"  ]];then
		mkdir "$moviefolder"
	 fi
	 if [[ -e "$moviefolder/$movie" ]]; then
		echo "File Already Exists"
		exit 1;
	 fi
         mv "$1" "$moviefolder"
        fi
 break
done
exit 0;

