#!/bin/bash
mount_path_default="//192.168.0.10/common/01_shared/03_music/01\ artists"
mount_path=$mp3_path_default
pathPattern="Z"
mount_name="/mnt/replayGainScript"
mount_user=""
mount_user_default="gautier"


executeMP3(){
	printf ">>> album for mp3 is $1 \n"
	mp3gain -a -c "$1"/*.mp3
}

executeFLAC(){
	printf ">>> album for flac is $1 \n"
	metaflac --add-replay-gain "$1"/*.flac
}

executeFolder(){
	album=${1}
	foundSongs=false	
	sizeMP3=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.mp3" -type f | wc -l)
	sizeFLAC=$(find "$album" -maxdepth 1 -mindepth 1 -name "*.flac" -type f | wc -l)
	if [[ $sizeMP3 > 0 && $sizeFLAC > 0 ]]; then
		printf "Mix of format, the following folder should be checked first : \n"
		printf "\t\t$album\n"
	elif [[ $sizeMP3 == 0 && $sizeFLAC == 0 ]]; then
		printf "No song found in the right format, the following folder should be checked first : \n"
		printf "\t\t$album\n"
	elif [[ $sizeMP3 > 0 ]]; then
		printf "$album\n"
		executeMP3 "$album"
	elif [[ $sizeFLAC > 0 ]]; then
		executeFLAC "$album\n"
	fi
}

replaygain(){
	path="${mount_name}"/$pathPattern"*"
	printf "\n\n\nStarting replay gain from path is "$path"\n"
	
	
	export -f executeFolder
	export -f executeMP3
	export -f executeFLAC
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
	
	read -p "   Path to search for: "$'\n'$"(default is 'Z', but an example is 'Z' or 'A' or 'Meta')"$'\n'$">" pathPattern;
	if [[ "$pathPattern" == "" ]]; then
		pathPattern="Z";
	fi
}

umountJ(){
	sleep 0.5
	printf "\n>>> UMOUNT STARTED : $mount_name\n"
	umount "$mount_name" 
	printf "umount ok\n"
	rm "$mount_name" -v -r
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
	
#	mkdir /mnt/jupiter
	mount -t cifs "$mount_path" "$mount_name" -o username="$mount_user",uid=gautier,gid=users
	printf "<<< MOUNT FINISHED : $mount_name\n"
}


# #####################################
#		STARTUP
# #####################################
if [[ $EUID -ne 0 ]]; then
   	printf "This script must be run as root type: sudo ./<script>\n" 
   	exit 1
else
	apt install cifs-utils

	readInputs
	mountJ
	replaygain
	umountJ
fi