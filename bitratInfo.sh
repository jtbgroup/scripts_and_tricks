#!/bin/bash
askedBitRate=""
askedBitRate_default="192"
mp3_path_default="/run/user/1000/gvfs/smb-share\:server\=jupiter\,share\=common\,user\=gautier/01_shared/03_music/01\ artists"
#mp3_path_default="/run/user/1000/gvfs/smb-share:server=jupiter,share=common,user=gautier/01_shared/03_music/01 artists"
mp3_path=""
pathPattern=""
showActivity=0
showActivity_default=0

 iterateInFolder(){
 	TagName="Audio Bitrate"
 	isFolderDisplayed=0
	folder="$1"/*

	for file in "$1"/*; do
		if [[ -d ${file} ]]; then
			 iterateInFolder "$file";
		else
			# BitRate="`exiftool -AudioBitrate  "$file" -p '$AudioBitrate'`"
			BitRate="`exiftool -AudioBitrate  "$file" `"
			rateis="${BitRate//[!0-9]/}"
			if [[ $rateis == "" ]]; then
				break;
			elif [[ $rateis -le $askedBitRate ]]; then
				if [ $isFolderDisplayed -eq 0 ]; then
					printf "++++++++++++ $folder\n";
					let isFolderDisplayed=1;
				fi
				echo "$rateis  >>>>> ${file##*/}";
			fi
		fi
	done
}

# exiftool -r -AudioBitrate  "${mp3_path}" -p '$AudioBitrate';

searchMethod1(){
	iterateInFolder "${mp3_path}" ;
}

proceedFilter(){
	BitRate="`exiftool -AudioBitrate  "$1" `"
	rateis="${BitRate//[!0-9]/}"
	if [[ $rateis != "" && $rateis -le $askedBitRate ]]; then
		printf "$rateis >>> $1\n";
	elif [[ $showActivity -eq 1 ]]; then
		printf '-';
	fi
}

searchMethod2(){
	read -p "   Path to search for: "$'\n'$"(default is empty, but an example is 'Z' or 'A' or 'Meta')"$'\n'$">" pathPattern;
	if [[ "$pathPattern" == "" ]]; then
		pathPattern="";
	fi


 	read -p "   Show search activity? (0 or 1): "$'\n'$"(default is $showActivity_default)"$'\n'$">" showActivity;
	if [[ "$showActivity" == "" ]]; then
		showActivity="$showActivity_default";
	fi

	clear
	printf ">>>>> Searching for files with bitrate <= $askedBitRate\n"
	printf ">>>>> in folder $mp3_path/$pathPattern*"
	printf "\n>>>>> "
	if [[ $showActivity -eq 1 ]]; then 
		printf "Activity will be shown";
	else
		printf "Activity will not be shown";
	fi
	printf "\n\n"

	export -f proceedFilter
	export askedBitRate
	export showActivity

	echo "$path"
	echo "$baseDir"
	find "${mp3_path}"/"$pathPattern"* -type f -exec bash -c 'proceedFilter "$0"' {} \;
}

readCommonInputs(){
	read -e -p "   Select base folder to search into:"$'\n'$"(default is $mp3_path_default)"$'\n'$">" mp3_path;
	if [[ "$mp3_path" == "" ]]; then
		mp3_path=${mp3_path_default};
	fi
	mp3_path=$(echo $mp3_path | sed "s/\\\//g")

	read -p "   Maximum bitrate (in kbps) to show:"$'\n'$"(default is $askedBitRate_default)"$'\n'$">" askedBitRate;
	if [[ "$askedBitRate" == "" ]]; then
		askedBitRate=${askedBitRate_default};
	fi
}

readCommonInputs
searchMethod2
