#!/bin/bash

mountJ(){
	if [ -d /mnt/jupiter ]; then 
		echo "folder /mnt/jupiter already exist"
	else
		mkdir /mnt/jupiter
	fi
	
	mkdir /mnt/jupiter
	mount -t cifs //192.168.1.10/common /mnt/jupiter -o username=gautier,uid=gautier,gid=users
	# xfce4-terminal --working-directory=/mnt/jupiter &
    konsole --workdir=/mnt/jupiter &
}

umountJ(){
	umount -t cifs /mnt/jupiter 
	rm /mnt/jupiter -v -r
}

choose1(){
  options=("mount" "unmount" "Quit")
  select opt in "${options[@]}"
  do
      case $opt in
          "mount")
             mountJ
             break
              ;;
          "unmount")
             umountJ
             break
              ;;
          "Quit")
              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done
}

choose2(){
  while true; do
    options=("mount" "unmount" "Quit")
   	echo ""
      echo "Choose an option:"
      select opt in "${options[@]}"; do
          case $REPLY in
              1) mountJ; break ;;
              2) umountJ; break ;;
              3) break 2 ;;
              *) echo "What's that?" >&2
          esac
      done
      echo ""
      echo ""
  done

  echo "Bye bye!"
}

# #####################################
#		STARTUP
# #####################################
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./<script>" 
   	exit 1
else
	apt install cifs-utils

	#choose1
	choose2	
fi