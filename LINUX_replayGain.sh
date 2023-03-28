#!/bin/bash
tmpFile
mount_path_default="//192.168.1.13/common/01_shared/03_music/01\ artists"
mount_path=$mp3_path_default
pathPattern=""
mount_name="/mnt/replayGainScript"
mount_user=""
mount_user_default="gautier"
forceRecalculation


executeMp3Gain(){
	printf ">>> execute replaygain (mp3gain) \n"
	if [[ "$forceRecalculation" -eq "1" ]]; then
		printf "Force recalculation...\n"
		mp3gain -a -c -f -s r "$1/*.$2" 
	else
		mp3gain -a -c -f "$1/"*."$2"
	fi
}

executeMetaflac(){
	printf ">>> execute metaflac \n"
	currentDir=$(pwd)
	cd "$1"

	if [[ "$forceRecalculation" -eq "1" ]]; then
		printf "Force recalculation : removing all replayGain tags...\n"
		metaflac --remove-replay-gain ./*.flac
	fi


	containsReplaygainTags=1
	for f in *.flac; do
  		#echo "File -> $f"
  		trackGain=$(metaflac "$f" --show-tag=REPLAYGAIN_TRACK_GAIN)
  		albumGain=$(metaflac "$f" --show-tag=REPLAYGAIN_ALBUM_GAIN)
  		
  		if [[ -z $trackGain || -z $albumGain ]]; then
  			containsReplaygainTags=0
  			break
	  	else
	  		printf ">"$trackGain"<->"$albumGain"<"
	  		printf "\n"
  		fi
	done
	
	if [[ "$containsReplaygainTags" -eq "1" ]] ; then
  		printf "  => No need to replaygain\n"	
  	else
  		printf "  => Need to replaygain\n"
		metaflac --add-replay-gain --no-utf8-convert --show-tag=TITLE ./*.flac
  	fi
		

	cd $currentDir
}

# Vorbisgain parameters:
# -a = album calculation
# -f = fast (= do not recalculate gain if present)
# -r = recursive (album folder)
# -s = sliently skip any non-Vorbis files found.
executeVorbis(){
	printf ">>> execute replaygain (vorbisgain) \n"
	if [[ "$forceRecalculation" -eq "1" ]]; then
		printf "Force recalculation...\n"
		vorbisgain -a -r -s $1
	else
		vorbisgain -a -f -r -s $1
	fi
	
}

# wvgain parameters:
# -a = album calculation
# -c = clean tags
# -n = only new files (with no tags)
executeWvGain(){
	printf ">>> execute replaygain (vwgain) \n"
	if [[ "$forceRecalculation" -eq "1" ]]; then
		printf "Force recalculation...\n"
		vwgain -c $1
		vwgain -a $1
	else
		vwgain -a -n $1
	fi
	
}

executeFolder(){
	album=${1}
	printf "\n\nChecking album: $album\n"
	sizeMP3=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.mp3" -type f | wc -l)
	sizeFLAC=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.flac" -type f | wc -l)
	sizeM4A=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.m4a" -type f | wc -l)
	sizeMP4=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.mp4" -type f | wc -l)
	sizeOgg=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.ogg" -type f | wc -l)
	sizeWav=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.wav" -type f | wc -l)
	totalSize=$(($sizeMP3+$sizeFLAC+$sizeM4A+$sizeMP4+$sizeOgg+$sizeWav))
	
	if [[ $totalSize > $sizeMP3 && $totalSize > $sizeFLAC && $totalSize > $sizeM4A && $totalSize > $sizeMP4 && $totalSize > $sizeOgg && $totalSize > $sizeWav ]]; then
		printf "!!!! Mix of format, the following folder should be checked first : \n"
		printf "\t$album\n"
		echo "Mix of music formats : $album" >> ${tmpFile}
	elif [[ $sizeMP3 == 0 && $sizeFLAC == 0 && $sizeM4A == 0 && $sizeMP4 == 0 && $sizeOgg == 0 && $sizeWav == 0 ]]; then
		printf "!!!! No song found in the right format, the following folder should be checked first : \n"
		printf "\t$album\n"
		echo "No song of music format : $album" >> ${tmpFile}
	elif [[ $sizeMP3 > 0 ]]; then
		printf "This album contains MP3\n"
		executeMp3Gain "$album" "mp3"
	elif [[ $sizeFLAC > 0 ]]; then
		printf "This album contains FLAC\n"
		executeMetaflac "$album"
	elif [[ $sizeM4A > 0 ]]; then
		printf "This album contains M4A\n" "m4a"
		executeMp3Gain "$album"
	elif [[ $sizeMP4 > 0 ]]; then
		printf "This album contains MP4\n" 
		executeMp3Gain "$album" "mp4"
	elif [[ $sizeOgg > 0 ]]; then
		printf "This album contains Ogg\n" 
		executeVorbisGain "$album"
	elif [[ $sizeWav > 0 ]]; then
		printf "This album contains Wav\n" 
		executeWvGain "$album"
	fi
	printf "\n"
}

replaygain(){
	path="${mount_name}"/$pathPattern"*"
	printf "\n\n\nStarting replay gain from path is "$path"\n"
	
	export -f executeFolder
	export -f executeMp3Gain
	export -f executeMetaflac
	export -f executeVorbisGain
	export -f executeWvGain
	export forceRecalculation
	export tmpFile
	find $path -maxdepth 1 -mindepth 1 -type d -exec bash -c 'executeFolder "$0"' {} \;
}


readInputs(){
	read -e -p "   Select folder to mount as base dir into:"$'\n'$"(default is $mount_path_default)"$'\n'$">" mount_path;
	if [[ "$mp3_path" == "" ]]; then
		mount_path=${mount_path_default};
	fi
	mount_path=$(echo $mount_path | sed "s/\\\//g")
	
	read -e -p "   Select user for mounting:"$'\n'$"(default is $mount_user_default)"$'\n'$">" mount_user;
	if [[ "$mount_user" == "" ]]; then
		mount_user=${mount_user_default};
	fi
	
	read -p "   Path to search for: "$'\n'$"(default is '*', but an example is 'Z' or 'A' or 'Meta')"$'\n'$">" pathPattern;
	if [[ "$pathPattern" == "" ]]; then
		pathPattern="";
	fi
	
	read -p "   Force recalcuation: "$'\n'$"(default is '0', choose '0' or '1')"$'\n'$">" forceRecalculation;
	if [[ "$forceRecalculation" == "" ]]; then
		forceRecalculation="0";
	fi
}

umountJ(){
	sleep 0.5
	printf "\n>>> UMOUNT STARTED : $mount_name\n"
	umount "$mount_name" 
	printf "umount ok\n"
	rm $mount_name -v -r
	printf "remove ok\n"
	printf "<<< UMOUNT FINISHED : $mount_name\n"
}

mountJ(){
	printf "\n>>> MOUNT STARTED : $mount_name\n"
	if [ -d $mount_name ]; then 
		umountJ
		printf "folder $mount_name already exist. unounting first...\n"
	fi

	printf "creating folder $mount_name\n"
	mkdir $mount_name
	
	mount -t cifs "$mount_path" "$mount_name" -o username="$mount_user",uid=gautier,gid=users
	printf "<<< MOUNT FINISHED : $mount_name\n"
}

createTemp(){
	printf "creating temp file $tmpFile"
	rm /tmp/replayGainScript.*
	tmpFile=$(mktemp /tmp/replayGainScript.XXXXXXXXX)
}

readSummary(){
	printf "\n"
	printf "Summary : Folders with problems:\n"
	printf "********************************\n"
	cat $tmpFile
	printf "********************************\n"
	printf "deleting temp file $tmpFile\n"
	rm $tmpFile
}

# #####################################
#		STARTUP
# #####################################
if [[ $EUID -ne 0 ]]; then
   	printf "This script must be run as root type: sudo ./<script>\n" 
   	exit 1
else
	apt install cifs-utils flac mp3gain vorbisgain wavpack

	readInputs
	mountJ
	
	#mount_name="/home/gautier/Music/nas"
	#pathPattern="Adagi"
	
	createTemp
	replaygain
	readSummary
	umountJ
fi
