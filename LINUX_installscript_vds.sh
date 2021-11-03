#!/bin/bash
# Forked  respin respun forked stolen and modified by DasGeek
# Tested w/ Elementary OS Loki & Ubuntu 17 and 18.04 LTS 
# Forked and spooned from some forum post I can no longer find in a galaxy of the internet
# Thank you to BigDaddyLinux and Skrappjaw for contributing!
# Version 2.0.0


#///////////////////////////////////////////////////
#///////////////////////////////////////////////////
#					FUNCTIONS
#///////////////////////////////////////////////////
#///////////////////////////////////////////////////

echoInstallStart(){
	echo ""
	echo ""
	echo ""
	echo "*********************************"
	echo "*********************************"
	echo " 	Starting installation"
	echo "	$1"
	echo "*********************************"
	echo ""
}


echoInstallEnd(){
	echo ""
	echo "*********************************"
	echo "	Installation finished"
	echo "	$1"
	echo "*********************************"
	echo "*********************************"
	echo ""
}

installComix()
{
	echoInstallStart "Comix"
	apt install comix -y
	echoInstallEnd "Comix"
}

basicConfig(){
	apt-get install xserver-xorg-input-synaptics
	usermod -a -G audio $CURRENT_USER
}

installAmarok(){
	echoInstallStart "Amarok"
	apt install amarok -y
	apt install phonon-backend-vlc -y
	apt install cuetools -y
	apt install flac -y
	apt install shntool -y
	echoInstallEnd "Amarok"
}

installArdour(){
	echoInstallStart "Ardour"
	apt install ardour -y
	echoInstallEnd "Ardour"
}

installGladish(){
	echoInstallStart "Gladish"
	apt install laditools -y
	apt install gladish -y
	echoInstallEnd "Gladish"
}

installEID(){
	echoInstallStart "eid"
	apt install pcscd -y
	apt install libccid -y
	apt install libacr38u -y
	apt-get purge *beid*
	echoInstallEnd "eid"
}

installRemina(){
	echoInstallStart "Remina"
	sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
	sudo apt-get update
	apt install remmina -y
	apt install remmina-plugin-rdp -y
	apt install libfreerdp-plugins-standard -y
	echoInstallEnd "Remina"
}
installGparted(){
	echoInstallStart "GParted"
	apt install gparted -y
	echoInstallEnd "GParted"
}
installVirtualBox(){
	echoInstallStart "Virtualbox"
	sudo apt install virtualbox -y
	adduser $CURRENT_USER vboxusers
	echoInstallEnd "Virtualbox"
}

installFlatPack(){
	echoInstallStart "Flatpak Repository"
	apt install flatpak -y
	echoInstallEnd "Flatpak Repository"
}

installSnapsnaps(){
	echoInstallStart "Snap Repository"
	sudo apt install snapd -y
	echoInstallEnd "Snap Repository"
}

installKxStudio(){
	# FROM : https://kx.studio/Repositories and http://linuxmao.org/KXStudio#A_partir_d_Ubuntu

	echoInstallStart "KXStudio Repository"
	sudo apt-get install apt-transport-https software-properties-common wget -y
	wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.5.1~kxstudio3_all.deb
	sudo dpkg -i kxstudio-repos_9.5.1~kxstudio3_all.deb
	apt get update
	sudo apt-get install libglibmm-2.4-1v5 -y
	wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb
	sudo dpkg -i kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb
	apt update
	apt upgrade
	echoInstallEnd "KXStudio Repository"
}

installLowLatencyKernel(){
	echoInstallStart "Low latency kernel"
	apt install linux-lowlatency -y
	echoInstallEnd "Low latency kernel"
}

installEtcher(){
	echoInstallStart "Etcher"
	cd /home/$CURRENT_USER/Downloads
	wget -O etcher.zip https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-electron-1.4.4-linux-x64.zip
	sudo apt install unzip -y
	unzip etcher*.zip
	chmod +x ~/Downloads/etcher-*.AppImage
	echoInstallEnd "Etcher"
}

installGnomeSystemTools(){
	echoInstallStart "Gnome Sysem Tools"
	apt install gnome-system-tools -y
	echoInstallEnd "Gnome Sysem Tools"
}

installGnomeTweakTool(){
	echoInstallStart "Gnome Tweak Tools"
	apt install gnome-tweak-tool -y
	echoInstallEnd "Gnome Tweak Tools"
}

installCantata(){
	echoInstallStart "Cantata"
	add-apt-repository ppa:ubuntuhandbook1/cantata-qt
	apt update
	apt install cantata mpd -y
	echoInstallEnd "Cantata"
}

installWine(){
	echoInstallStart "Wine"
	sudo dpkg --add-architecture i386
	wget -nc https://dl.winehq.org/wine-builds/Release.key
	sudo apt-key add Release.key
	sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
	sudo apt-get update
	apt install winehq-stable -y
	echoInstallEnd "Wine"
}

installCustoUbuntuStudio(){
	echoInstallStart "Custo Ubuntu Studio"
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/handle-brightness-keys --create -t bool -s true
	apt install ibus -y
	apt install xfce4-pulseaudio-plugin -y
	echoInstallEnd "Custo Ubuntu Studio"
}

installChrome(){
	echoInstallStart "Google Chrome"
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	apt-get update 
	apt-get install google-chrome-stable -y
	echoInstallEnd "Google Chrome"
}

installFireFox(){
	echoInstallStart "Firefox"
	apt install firefox -y
	echoInstallEnd "Firefox"
}

installFileZilla(){
	echoInstallStart "Filezilla"
	apt install filezilla -y
	echoInstallEnd "Filezilla"
}

installGthumb(){
	echoInstallStart "gThumb"
	apt install gthumb -y
	echoInstallEnd "gThumb"
}

installGimp(){
	echoInstallStart "GIMP"
	apt install snapd
	snap install gimp
	echoInstallEnd "GIMP"
}

installJackd(){
	echoInstallStart "Jackd";
	apt install jack -y
	apt install pulseaudio-module-jack -y
	apt install jackd2-firewire jackd2 jackd -y
	apt install vlc-plugin-jack -y
	adduser $CURRENT_USER audio
	echoInstallEnd "Jackd"
}

installQJackCtl(){
	echoInstallStart "qjackctl"
	apt install qjackctl -y
	echoInstallEnd "qjackctl"
}	

installPatchage(){
	echoInstallStart "Patchage"
	apt install patchage -y
	echoInstallEnd "Patchage"
}


installGuitarix(){
	echoInstallStart "Guitarix"
	apt install guitarix -y
	echoInstallEnd "Guitarix"
}

installTuxguitar(){
	echoInstallStart "Tux Guitar"
	apt install tuxguitar -y
	echoInstallEnd "Tux Guitar"
}

installCalfPlugins(){
	echoInstallStart "Calf Plugins"
	apt install calf-plugins -y

#	apt install libtool m4 automake libexpat1 libexpat1-dev libglib2.0-dev fluidsynth -y
#	wget -P /home/$CURRENT_USER/Downloads http://calf-studio-gear.org/files/$CALF_VERSION_NAME.tar.gz 
#	tar -xzf /home/$CURRENT_USER/Downloads/$CALF_VERSION_NAME.tar.gz -C /home/$CURRENT_USER/Downloads/ -v
#	echo "Script executed from: ${PWD}"
#	cd /home/$CURRENT_USER/Downloads/$CALF_VERSION_NAME
#	echo "Script executed from: ${PWD}"
#	./autogen.sh
#	make -j8
#	make install

	echoInstallEnd "Calf Plugins"
}

installSteveHarrisPlugins(){
	echoInstallStart "Steve Harris plugins LV2"
	apt install swh-lv2 -y
	echoInstallEnd "Steve Harris plugins LV2"
}

installTapPlugins(){
	echoInstallStart "TAP plugins"
	apt install tap-plugins -y
	echoInstallEnd "TAP plugins"
}

installHydrogen(){
	echoInstallStart "Hydrogen"
	apt install hydrogen -y
	echoInstallEnd "Hydrogen"

}

installYoshimi(){
	echoInstallStart "Yoshimi"
	apt install yoshimi -y
	echoInstallEnd "Yoshimi"
}

installDrumgizmo(){
	echoInstallStart "Drumgizmo"
	apt install drumgizmo -y
	echoInstallEnd "Drumgizmo"
}

installNvidiaDriver(){
	echoInstallStart "NVidia Drivers"
	sudo ubuntu-drivers autoinstall
	echoInstallEnd "Nvidia Drivers"
}

installFluidSynth(){
	echoInstallStart "Fluidsynth soundfonts"
	apt install fluid-soundfont-gm -y
	apt install fluid-soundfont-gs -y
	echoInstallEnd "Fluidsynth soundfonts"
}

installLmms(){
	echoInstallStart "LMSS"
	apt install lmms -y
	echoInstallEnd "LMMS"
}

installZynaddSubFx(){
	echoInstallStart "ZynAddSubFX"
	apt install zynaddsubfx -y
	echoInstallEnd "ZynAddSubFX"
}

installZynFusion(){
	cd /home/$CURRENT_USER/Downloads
	sudo apt-get install build-essential git ruby libtool libmxml-dev automake cmake libfftw3-dev libjack-jackd2-dev liblo-dev libz-dev libasound2-dev mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libcairo2-dev libfontconfig1-dev bison
	git clone https://github.com/zynaddsubfx/zyn-fusion-build
	cd zyn-fusion-build
	ruby build-linux.rb
	tar -jxvf zyn-fusion-linux-64bit-3.0.3-patch1-release.tar.bz2
	cd zyn-fusion
	sudo bash ./install-linux.sh
}


installQSynth(){
	echoInstallStart "QSynth"
	apt install qsynth -y
	echoInstallEnd "QSynth"
}

installLupp(){
	echoInstallStart "Lupp"
	apt install luppp -y
	echoInstallEnd "Luppp"
}

installAudacity(){
	echoInstallStart "Audacity"
	apt install audacity -y
	echoInstallEnd "Audacity"
}


installFfmpeg(){
	echoInstallStart "ffmpeg"
	sudo apt remove ffmpeg -y
	apt install snapd
	snap install ffmpeg --classic
	echoInstallEnd "ffmpeg"
}

installFlacon(){
	echoInstallStart "Flacon"
	sudo add-apt-repository --yes ppa:flacon/ppa
	apt-get update
	apt install flacon -y
	echoInstallEnd "Flacon"
} 


installPicardMusicbrainz(){
	echoInstallStart "PicardMusicbrainz"
	sudo add-apt-repository --yes ppa:musicbrainz-developers/stable
	sudo apt-get update
	pat install picard -y
	echoInstallEnd "PicardMusicbrainz"
} 


installMixx(){
	echoInstallStart "Mixxx"
	add-apt-repository --yes ppa:mixxx/mixxx
	apt-get update
	apt install mixxx -y
	echoInstallEnd "Mixxx"
}

installCadence(){
	installKxStudio
	echoInstallStart "Cadence"
	apt install cadence -y
	apt install catia -y
	echoInstallEnd "Cadence"
}

installZitaAt1(){
	echoInstallStart "Zita at1"
	apt install zita-at1 -y
	echoInstallEnd "Zita at1"
}

installZitaAt1Plugin(){
	echoInstallStart "Zita at1 as plugin"
	apt install lv2-dev fftw-dev gcc
	cd /home/$CURRENT_USER/Downloads
	git clone git://github.com/x42/fat1.lv2.git
	cd fat1.lv2
	make submodules
	make
	sudo make install PREFIX=/usr
	echoInstallEnd "Zita at1 as plugin"
}

installKXStudioPlugins(){
	echoInstallStart "KX Studio Plugins"
	apt install triceratops-lv2 -y
	apt install holap -y
	apt install synthv1 -y
	apt install mda-lv2 -y
	echoInstallEnd "KX Studio Plugins"
}

installSoundconverter(){
	echoInstallStart "Soundconverter"
	apt install soundconverter -y
	echoInstallEnd "Soundconverter"
}
				
installSoundjuicer(){
	echoInstallStart "Sound-juicer"
	apt install sound-juicer -y
	echoInstallEnd "Sound-juicer"
}

installVlc(){
	echoInstallStart "VLC"
	apt install vlc -y
	echoInstallEnd "VLC"
}

installFractalTools(){
	echoInstallStart "Fractal tools"
	apt install wine-stable winetricks -y
	sudo add-apt-repository --yes ppa:albaguirre/axe-fx2
	apt-get update
	apt install axefx2-usb-firmware
	apt install snd-usb-audio-dkms
	wget --directory-prefix=/home/$CURRENT_USER/Downloads http://www.fractalaudio.com/downloads/axe-edit/Axe-Edit-Win-v3p14p2.exe
	wget --directory-prefix=/home/$CURRENT_USER/Downloads http://www.fractalaudio.com/downloads/fractal-bot/Fractal-Bot-Win-v2p8p2.zip
	wget --directory-prefix=/home/$CURRENT_USER/Downloads http://archive.axefx.fr/Drivers/Axe-Fx_II_USB_Driver_Setup_Linux_106.zip
	nautilus -s /home/$CURRENT_USER/Downloads/ &
	echoInstallEnd "Fractal tools"
}

installMuse3(){
	echoInstallStart "Muse3"
	apt install build-essential cmake libsndfile1-dev libsamplerate0-dev libjack-jackd2-dev ladspa-sdk qt5-default qttools5-dev qttools5-dev-tools liblo-dev dssi-dev lv2-dev libsamplerate0-dev libsndfile1-dev git libfluidsynth-dev libgtkmm-2.4-dev librtaudio-dev libqt5svg5-dev libinstpatch-dev
	apt install python3-pyqt4 -y
	cd /home/$CURRENT_USER/Downloads
	git clone https://github.com/muse-sequencer/muse.git
	cd muse/muse3
	./compile_muse.sh
	cd build
	sudo make install
	cd /home/$CURRENT_USER/Downloads
	rm -R muse
	echoInstallEnd "Muse3"
}

installReaper(){
	echoInstallStart "Reaper"
	apt install libc6 libstdc++ libgdk3.0-cil -y
	cd /home/$CURRENT_USER/Downloads
	wget https://www.reaper.fm/files/5.x/reaper5965_linux_x86_64.tar.xz
	tar -xvf reaper5965_linux_x86_64.tar.xz
	cd reaper_linux_x86_64
	./install-reaper.sh
	echoInstallEnd "Reaper"
}

installA2j(){
	echoInstallStart "a2j"
	apt install a2jmidid -y
	echoInstallEnd "a2j"
}

installGit(){
	echoInstallStart "Git"			
	apt install git -y
	echoInstallEnd "Git"
}

installJdk8(){
	echoInstallStart "OpenJDK8"
	apt install openjdk-8-jdk -y
	apt install openjfx -y
	echoInstallEnd "OpenJDK8"
}

installJdk11(){
	echoInstallStart "OpenJDK11"
	apt install openjdk-11-jdk -y
	apt install openjfx -y
	echoInstallEnd "OpenJDK11"
}

installOpenJK(){
	echoInstallStart "OpenJDK"
	apt install openjfx -y
	echoInstallEnd "OpenJDK"
}

installSublimeText(){
	echoInstallStart "Sublime text"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update
	sudo apt install sublime-text -y
	echoInstallEnd "Sublime text"
}

installSteam(){
	echoInstallStart "Steam"			
	apt install steam -y
	echoInstallEnd "Steam"
}

installFlightGear(){
	echoInstallStart "Flightgear"
	apt install flightgear -y
	echoInstallEnd "Flightgear"
}

installPiaVPN(){
	echoInstallStart "PIA VPN Network Manager Version"
	cd /home/$CURRENT_USER/Downloads		
	wget https://www.privateinternetaccess.com/installer/install_ubuntu.sh
	sudo sh ./install_ubuntu.sh
	echo "After entering username, go to network manager and turn on VPN and select from PIA locations, enter password and boom!"
	echoInstallEnd "PIA VPN Network Manager Version"
}

installPiaVPNGui(){
	echoInstallStart "PIA VPN GUI Version"
	alias directory_change='(cd ~/Downloads )'
	directory_change	
	wget -nc -O piavpn.tar.gz https://installers.privateinternetaccess.com/download/pia-v80-installer-linux.tar.gz
	tar -xzf piavpn.tar.gz
	mv pia-v80-installer-linux.sh piavpn.sh
	chmod +x piavpn.sh
	CURRENT_USER=$(who | awk 'NR==1{print $1}')
	sudo chown -R $CURRENT_USER:$CURRENT_USER ~/.pia_manager
	sudo -u "$CURRENT_USER" ./piavpn.sh
	rm -rf piavpn.tar.gz
	echoInstallEnd "PIA VPN GUI Version"
}

installSoftPackHomeStudio(){
	installJackd
	installQJackCtl
	installArdour
	installCalfPlugins
	installHydrogen
	installFluidSynth
	installZynaddSubFx
	installDrumgizmo
	installYoshimi
	installGuitarix
	installA2j
}

installSoftPackMusic(){
	installAmarok
	installMixx
	installSoundjuicer
	installSoundconverter
	installFfmpeg
	installFlacon
	installVlc
}

modifyFSTAB(){
	echo "===== Modify FSTAB"
	apt install cifs-utils -y
	cp /etc/fstab /etc/fstan.bak
	sudo su -c "printf '\n\n#----> START VDS FSTAB v1.0\n\n## FSTAB is called after the network connection is established. If no connection is available, the resource will not be mounted.' >> /etc/fstab"
	sudo su -c "printf '\n## In case of wifi, be sure the network is available for all users.' >> /etc/fstab"
	sudo su -c "printf '\n# THIS IS AN OLD STYLE Connection type' >> /etc/fstab"
	sudo su -c "printf '\n\n# CUSTOM : auto mount the NAS with NFS -- requires package nfs-common' >> /etc/fstab"
	sudo su -c "printf '\n# 192.168.0.10:/volume1/common   /media/jupiter   nfs    rsize=8192,wsize=8192,timeo=14,intr' >> /etc/fstab"
	sudo su -c "printf '\n\n# CUSTOM : auto mount the NAS with CIFS -- requires package cifs-utils' >> /etc/fstab"
	sudo su -c "printf '\n# the credential file must be RW for root only (chmod 600). Credentials=user on the NAS used to connect the server.' >> /etc/fstab"
	sudo su -c "printf '\n# uid=linux user that will access the resources, gid=group used to access the resources' >> /etc/fstab"
	sudo su -c "printf '\n//192.168.0.10/common	/media/jupiter cifs noauto,x-systemd.automount,x-systemd.device-timeout=10,_netdev,credentials=/home/gautier/.smbcredentials,iocharset=utf8,uid=gautier,gid=users,sec=ntlm,vers=1.0 0 0' >> /etc/fstab"
	sudo su -c "printf '\n\n#----> STOP VDS FSTAB v1.0\n' >> /etc/fstab"

	printf "\n\n===== Modify Credentials\n"
	touch /home/$CURRENT_USER/.smbcredentials
	chown $CURRENT_USER /home/$CURRENT_USER/.smbcredentials
	printf "username=$CURRENT_USER\n" >> /home/$CURRENT_USER/.smbcredentials
	printf "password=$CURRENT_USER\n" >> /home/$CURRENT_USER/.smbcredentials
	gedit /home/$CURRENT_USER/.smbcredentials &
	echo "<<<===== Modifying fstab done"
}

menuInstallSoft(){
	clear
	displayMenuInstallSoft
}

menuInstallSoftPack(){
	clear
	displayMenuInstallSoftPack
}

actionCleanAfterUpdate(){
	clear
	echo ""
	echo ">>>   Running Clean Up And Update"
	echo ""
	apt update
	apt upgrade
	apt-get autoremove
	displayMenuAction
}

exitAction(){
	clear
	echo "Bye !!! "
	exit 0
}


displayMenuAction(){
	# Store menu options selected by the user
	INPUT=/tmp/menu.sh.$$

	# Storage file for displaying cal and date command output
	OUTPUT=/tmp/output.sh.$$

	### display main menu ###
	dialog --backtitle "Linux Shell Script Tutorial" \
	--title "[ M A I N - M E N U ]" \
	--cancel-label "Exit" \
	--menu "You can use the UP/DOWN arrow keys, the first \n\
	letter of the choice as a hot key, or the \n\
	number keys 1-9 to choose an option.\n\
	Choose the TASK" 20 50 6 \
	1 "Modify FSTAB" \
	2 "Install a Software" \
	3 "Install a pack of Software" \
	4 "Update and Clean" \
	9 "Exit to the shell" 2>"${INPUT}"

	if [[ $? -ne 0 ]]; then
		exitAction
	fi	
		
	menuitem=$(<"${INPUT}")
	

	# make decision 
	case $menuitem in
		1) modifyFSTAB;;
		2) menuInstallSoft;;
		3) menuInstallSoftPack;;
		4) actionCleanAfterUpdate;;
		9) exitAction;;
		*) exitAction;;
	esac
}

displayMenuInstallSoftPack(){
	# Store menu options selected by the user
	INPUT=/tmp/menu.sh.$$

	# Storage file for displaying cal and date command output
	OUTPUT=/tmp/output.sh.$$

	### display main menu ###
	dialog \
	--cancel-label "Back" \
	--menu "Choose a pack of software to install at once.\n\
	Choose the TASK" 15 50 4 \
	1 "Home Studio Tools" \
	2 "Media Tools" 2>"${INPUT}"


	if [[ $? -ne 0 ]]; then
		displayMenuAction
	fi

	clear	
	menuitem=$(<"${INPUT}")
	
	# make decision 
	case $menuitem in
		1) installSoftPackHomeStudio;;
		2) installSoftPackMusic;;
		*) echo "no pack selected";;
	esac

	echo ""
	echo ""
	echo ""
  	read -p "--------------------------> Installation finished, press Enter to continue" 	
	displayMenuAction
}

displayMenuInstallSoft(){
	cmd=(dialog --separate-output --checklist "Select options:" 25 90 20)
	options=(
		#A	"<----Category: Software Repositories---->" on
			repo_flatpak "	Install Flatpak Repository" off
			repo_snaps "	Install Snaps Repository" off
			repo_kxstudio "	Install KXStudio Repository" off
		
		#B	"<----Category: System---->" on
			syst_low_latency_kernel "	Low Latency Kernel" off
			syst_nvidia_driver "	NVidia Drivers" off
			syst_eid "	eid" off
			syst_etcher "	Etcher" off
			syst_gnome_system_tools "	Gnome System Tool" off
			syst_gnome_tweak_tools "	Gnome Tweak Tool" off
			syst_gparted "	Gparted" off
			syst_virtualbox "	Virtualbox" off
			syst_remina "	Remina (remote desktop client)" off
			syst_wine "	Wine (Windows emulator)" off
			syst_ubuntu_studio "	Customizations after installing Ubuntu Studio" off
			
		#C	"<----Category: Internet---->" on	
		 	inet_firefox "	Firefox Browser" off     	
			inet_google_chrome "	Google Chrome browser" off
			inet_filezilla "	Filezilla" off
			
		#D	"<----Category: Utilities---->" on
			util_comix "	Comix" off
			util_gimp "	GIMP" off
			util_gthumb "	gThumb" off
		
		#E	"<----Category: Music---->" on
			msic_amarok "	Amarok media player" off
		  	msic_ffmpeg "	ffmpeg (latest) (SNAP)" off
			msic_flacon "	Music files extractor (flac, cue, ...)" off
			msic_PicardMusicbrainz "	MusicBrainz tag editor" off
		 	msic_soundconverter "	Audio formats converter" off
			msic_soundjuicer "	CD Ripper" off
			msic_vlc "	VLC" off
			msic_mixxx "	DJ Mixing player" off

		#F	"<----Category: Home Studio---->" on	
			homs_a2j "	Midi bridge for jack" off
			homs_ardour "	Multitrack Editor" off
			homs_audacity "	Audacity multi track editor" off
			homs_cadence "	Cadence suite (Catia, cadence, ...). Requires KXStudio repo." off
			homs_kxstudio_plugins "	Holap, Triceratops, ... plugins & Synth" off
			homs_calf-plugins "	Several effect plugins - Calf" off
			homs_SteveHarris-plugins "	Several effect plugins - Steve Harris" off
			homs_TAP-plugins "	Several effect plugins - TAP" off
			homs_drumgizmo "	Drumgizmo" off
			homs_fluidsynth "	Fluidsynth soundfonts" off
			homs_fractal_tools "	Fractal Axe FX Tools" off
			homs_gladish "	Gladish" off
			homs_guitarix "	Guitar Preamp simulator" off
			homs_hydrogen "	Drumkit" off
			homs_jackd "	Jackd + vlc-plugin-jack + pulseaudio-module-jack" off
			homs_lmms "	LMMS" off
			homs_luppp "	Luppp Live loop station. Requires KXStudio repo" off
			homs_muse3 "	MuSe3 Midi sequencer" off
			homs_qjackctl "	Qjackctl" off
			homs_qsynth "	QSynth synthetizer" off
			homs_patchage "	Patchage" off
			homs_reaper "	Reaper sequencer" off
			homs_tuxguitar "	Guitar Tablature reader (ptb)" off
			homs_yoshimi "	Synthetizer (for of ZynAddSubFX)" off
			homs_zita_at1 "	Zita at1 pitch correction" off
			homs_zita_at1_plugin "	Zita at1 pitch correction as plugin for Ardour" off
			# homs_zynaddsubfx "	ZynAddSubFX Synthetizer. Requires KXStudio repo."  off
			homs_zynfusion "	Zyn-Fusion Synthetizer."  off

		#G	"<----Category: Development---->" on
			deve_openjdk "	OpenJDK" off
			deve_jdk8 "	OpenJDK 8" off
			deve_jdk11 "	OpenJDK 11" off
			deve_git "	Git code revision tool" off
			deve_sublime_text "	Sublime Text" off # any option can be set to default to "on"
					
		#H	"<----Category: Games---->" on		
			game_flightgear "	Flightgear" off
			game_steam "	Steam (Valve)" off

		#I "<----Category: Security---->" on
			secu_pia_vpn "	PIA VPN (Network Mgr Version)" off
			secu_pia_vpn_gui "	PIA VPN GUI Version" off
	)
 
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    returnCode=$?

    if [[ $returnCode -eq 0 ]]; then
    	clear
		for choice in $choices
			do
			    case $choice in
			# Section A ------------repos----------------------

				repo_flatpak) installFlatPack;;
				repo_snapsnaps)	installSnapsnaps;;
				repo_kxstudio) installKxStudio;;

			# Section B -------System---------------------------

				syst_low_latency_kernel) installLowLatencyKernel;;
				syst_eid) installEID;;
				syst_etcher) installEtcher;;
				syst_gnome_system_tools) installGnomeSystemTools;;
				syst_gnome_tweak_tools) installGnomeTweakTool;;
				syst_gparted) installGparted;;
				syst_remina) installRemina;;
				syst_virtualbox) installVirtualBox;;
				syst_wine) installWine;;
				syst_ubuntu_studio) installCustoUbuntuStudio;;
				syst_nvidia_driver) installNvidiaDriver;;
				
			# Section C --------internet-------------------------
				
				inet_google_chrome) installChrome;;
				inet_firefox) installFireFox;;
				inet_filezilla) installFileZilla;;

			# Section D -----------utilities-----------------------
				
				util_gthumb) installGthumb;;
				util_comix) installComix;;
				util_gimp) installGimp;;

			# Section E -------------Music---------------------

				msic_amarok) installAmarok;;
				msic_ffmpeg) installFfmpeg;;
				msic_flacon) installFlacon;;
				msic_PicardMusicbrainz) installPicardMusicbrainz;;
				msic_soundconverter) installSoundconverter;;
				msic_soundjuicer) installSoundjuicer;;
				msic_vlc) installVlc;;
				msi_mixxx) installMixx;;

			# Section F -------------Home Studio--------------------

				homs_jackd) installJackd;;
				homs_qjackctl) installQJackCtl;;
				homs_patchage) installPatchage;;
				homs_gladish) installGladish;;
				homs_ardour) installArdour;;
				homs_guitarix) installGuitarix;;
				homs_calf-plugins) installCalfPlugins;;
				homs_hydrogen) installHydrogen;;
				homs_yoshimi) installYoshimi;;
				homs_fractal_tools) installFractalTools;;
				homs_drumgizmo) installDrumgizmo;;
				homs_muse3)installMuse3;;
				homs_reaper) installReaper;;
				homs_fluidsynth) installFluidSynth;;
				homs_audacity) installAudacity;;
				homs_lmms) installLmms;;
				homs_luppp) installLupp;;
				homs_qsynth) installQSynth;;
				# homs_zynaddsubfx) installZynaddSubFx;;
				homs_zynfusion) installZynFusion;;
				homs_cadence) installCadence;;
				homs_kxstudio_plugins) installKXStudioPlugins;; 
				homs_zita_at1)  installZitaAt1;;
				homs_zita_at1_plugin)  installZitaAt1Plugin;;
				homs_a2j) installA2j;;
				homs_SteveHarris-plugins) installSteveHarrisPlugins;;
				homs_TAP-plugins) installTapPlugins;;
				homs_tuxguitar) installTuxguitar;;

			# Section G -------------Development---------------------	
				
				deve_git) installGit;;
				deve_openjdk) installOpenJK;;
				deve_jdk8) installJdk8;;
				deve_jdk11) installJdk11;;
		  		deve_sublime_text) installSublimeText;;
				
			# Section H -----------Games-----------------------	
				
				game_steam) installSteam;;
				game_flightgear) installFlightGear;;
		
			# Section I ----------Security------------------------	

				secu_pia_vpn) installPiaVPN;;
				secu_pia_vpn_gui) installPiaVPNGui;;
			
			
			#	########################################################
			#	########################################################
			#	########################################################
			#	########################################################
			#	########################################################
			#	########################################################
			#	########################################################
			#	########################################################
			#
			# UNUSED
				notes_simplenote)
					#Simplenote (SNAP)
					echo "Installing Simplenote"
					apt install snapd
					snap install simplenote
					;;
			
				1_social)
					#Mumble Client (SNAP)
					echo "Mumble"
					apt install snapd
					snap install mumble		
					;;		

				2_social)
					#Zoom
					echo "Installing Zoom Meeting Client"
					echo "Installing dependency first First"				
					apt install libxcb-xtest0 -y
					cd ~/Downloads		
					wget https://zoom.us/client/latest/zoom_amd64.deb
					sudo dpkg -i zoom_amd64.deb
					rm -rf zoom_amd64.deb
					;;

				3_social)
					#Telegram
					echo "Telegram Snap"
					sudo apt install snapd
					sudo snap install telegram-desktop
					;;

				4_social)
					#Discord
					sudo apt install snapd
					sudo snap install discord
					;;

				5_social)	
					#Hexchat
					echo "=====>>> Installing Hexchat"
					apt install hexchat -y
					;;
				
				6_social) 
					#Signal
					echo "=====>>> Installing Signal Messenger"
					sudo apt-get install curl -y
					curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -				
	         		echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	    			sudo apt update && sudo apt install signal-desktop -y
	    			;;
					
				1_tweak)
					#Elementary OS Tweaks
					echo "=====>>> Installing Elementary Tweaks"
					sudo apt-get install software-properties-common
					sudo apt-get update
					sudo apt-get install elementary-tweaks -y
					;;

				2_tweak)
					#Ubuntu Restricted Extras
					echo "=====>>> Installing Ubuntu Restricted Extras"
					apt install ubuntu-restricted-extras -y
					;;
				
				4_tweak) 
					#Install monitor move window script Xfce
					echo "=====>>> Monitor move window script"
					wget https://raw.githubusercontent.com/dasgeekchannel/move-to-next-monitor/master/move-to-next-monitor
					cd ~/Documents
					CURRENT_USER=$(who | awk 'NR==1{print $1}')
					chmod +x ~/Documents/move-to-next-monitor
			  	  	chown -R $CURRENT_USER:$CURRENT_USER ~/Documents/move-to-next-monitor
					;;
					
				1_media)
					#SMPlayer
					echo "SMPlayer"
					apt install smplayer -y
					;;

				2_media) 
					#Pithos
					echo "installing Pithos"
					apt install pithos -y
					;;

				3_media) 
					#Google Desktop Player (SNAP)
					echo "Installing Google Desktop Player"
					apt install snapd
					snap install google-play-music-desktop-player
					;;
				
				2_gaming)
					#Lutris
					echo "=====>>> Installing Lutris"
					ver=$(lsb_release -sr); if [ $ver != "17.10" -a $ver != "17.04" -a $ver != "16.04" ]; then ver=16.04; fi
					echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
					wget -q http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | sudo apt-key add -
					sudo apt-get update
					sudo apt-get install lutris -y
					;;

				3_gaming) 
					#DOSBox-X (SNAP)
					echo "Installing DOSBox-X"
					apt install snapd
					snap install dosbox-x
					;;
				
				4_gaming)
					#ScummVM (SNAP)
					echo "Installing ScummVM"
					apt install snapd
					snap install scummvm
					;;

				5_gaming) 
					#Gnome Twitch Client
					echo "installing Gnome Twitch"
					apt install gnome-twitch -y
					;;
					
				musicstudio_kxstudio) 
					#Advanced Jack Audio Setup
					echo "installing KXStudio Jack"
					# Get user name for permissions
					#echo "Enter your username"
					#read -p 'Username: ' uservar
					# Install required dependencies if needed
#					apt-get install apt-transport-https software-properties-common wget
#					wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.5.1~kxstudio3_all.deb
					# Install it
#					sudo dpkg -i kxstudio-repos_9.5.1~kxstudio3_all.deb
#					apt-get install libglibmm-2.4-1v5 -y
#					wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb
#					dpkg -i kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb
#					CURRENT_USER=$(who | awk 'NR==1{print $1}')
#						sudo usermod -a -G audio $CURRENT_USER
#						sudo apt update && sudo apt upgrade -y
#						apt install jackd2-firewire -y
#						# apt install -y jackd2 carla-git cadence non-mixer pulseaudio-module-jack mididings -y
#						apt install -y jackd2 carla-git cadence pulseaudio-module-jack mididings -y
#						# Download auto script github
#						cd ~/
#						mkdir jacksetup
#						cd ~/jacksetup
#						wget https://raw.githubusercontent.com/Skrappjaw/audio-scripts/master/start_jack.sh
#						chmod +x ~/jacksetup/start_jack.sh
#						chown -R $CURRENT_USER:$CURRENT_USER ~/jacksetup
					# Optional to put script into autostart
					#cd ~/
					#cp ~/jacksetup/start_jack.sh /etc/init.d/
					#update-rc.d start_jack.sh defaults
#					rm kxstudio-repos_9.5.1~kxstudio3_all.deb
#					rm kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb



					# FROM : https://kx.studio/Repositories
					# Install required dependencies if needed
					sudo apt-get install libglibmm-2.4-1v5

					# Download package file
					wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb

					# Install it
					sudo dpkg -i kxstudio-repos-gcc5_9.5.1~kxstudio3_all.deb


					echo "Installing KXStudio done"
					;; 
				
				2_internet)
					#Vivaldi
					echo "=====>>> Installing Vivaldi"
					cd ~/Downloads				
					wget https://downloads.vivaldi.com/stable/vivaldi-stable_1.14.1077.55-1_amd64.deb
					dpkg -i vivaldi-stable_1.14.1077.55-1_amd64.deb
					apt-get install -f -y
					rm -rf vivaldi-stable_1.14.1077.55-1_amd64.deb
					;;

				4_internet) #get-iplayer (SNAP)
					echo "get-iplayer"
					apt install snapd
					snap install get-iplayer
					;;

				1_edit)
					#Kdenlive
					echo "Kdenlive"
					apt-get install kdenlive -y
					apt-get install breeze-icon-theme -y
					apt-get install vlc -y
					;;
					
				2_edit)	
					#Shotwell
					echo "Installing Shotwell"
					apt install shotwell -y
					;;            
	    		
				4_edit)
					#OBS Studio (SNAP)
					echo "Installing OBS Studio"
					apt install snapd
					snap install obs-studio
					#sudo apt-get install ffmpeg -y
					#sudo add-apt-repository ppa:obsproject/obs-studio
	 				#sudo apt-get update && sudo apt-get install obs-studio -y
					;;	
					
				1_coding) 	
					#Python Tools (Dev Testing)
					echo "=====>>> Installing Python Tools"
					#Install PIP
					sudo apt-get install -y python3-pip
					#Install packages and dev tools
					sudo apt-get install build-essential libssl-dev libffi-dev python-dev -y
					#Pycharm 
					apt install openjdk-8-jdk -y
					apt install python3-setuptools -y
					#Install SNAP
					sudo apt install snapd -y
					sudo snap install pycharm-professional
					;;

				3_coding)	
					#Atom
					echo "=====>>> Installing Atom"				
					cd ~/Downloads			
					wget -O atom-amd64.deb https://atom.io/download/deb			
					dpkg -i atom-amd64.deb
					apt-get install -f -y
					rm -rf atom-amd64.deb
					apm install atom-html-preview
					;;

				4_coding)	
					#Putty
					echo "=====>>> Putty"
					apt install putty -y
					;;

				5_coding)
					#Visual Studio Code
					echo "=====>>> Visual Studio Code"
					wget -O visualstudio.deb https://go.microsoft.com/fwlink/?LinkID=760868
					dpkg -i visualstudio.deb
					;;
		
				6_coding)	
					#Install Gedit
					echo "=====>>> Gedit"
					apt install gedit -y
					;;
					
				utility_tilix) 
					#Tilix (Tiling Terminal)
					echo "=====>>> Installing Tilix"
					apt install tilix -y
					echo "<<<===== Installing Tilix done"
					;;

				utility_terminator)
					#Terminator
					echo "=====>>> Installing Skynet/Terminator"
					apt install terminator -y
					;;

				utility_synology) 
					#Synology NAS Assistant & Backup
					echo "=====>>> Installing Syn Assist, CloudStation Backup"
					wget -O synassistant.deb https://global.download.synology.com/download/Tools/Assistant/6.1-15163/Ubuntu/x86_64/synology-assistant_6.1-15163_amd64.deb
					sudo dpkg -i synassistant*.deb
					apt-get install -f -y
					rm -rf synassistant*.deb
					wget -O cloudback.deb https://global.download.synology.com/download/Tools/CloudStationBackup/4.2.6-4408/Ubuntu/Installer/x86_64/synology-cloud-station-backup-4408.x86_64.deb
					sudo dpkg -i cloudback*.deb
					apt-get install -f -y
					rm -rf cloudback*.deb
					;;

				7_utility) 
					#Gnome-do
					echo "=====>>> Installing GnomeDo"
					apt install gnome-do -y
					apt install gnome-do-plugins -y
					;;

				8_utility) 
					#Install Catfish
					echo "=====>>> Installing Catfish"
					sudo apt install catfish -y
					;;

				9_utility) 
					#Guvcview
					echo "=====>>> installing Guvcview"
					apt install libgsl2 -y
					apt install libguvcview-1.1-1 -y
					apt install guvcview -y
					;;

				10_utility) 
					#Cheese
					echo "=====>>> Installing Cheese"
					apt install cheese -y
					;;
				
				11_utility) 
					#Fish
					echo "=====>>> Installing Fish"
					apt install fish -y
					echo "<<<===== Installing Fish done"
					;;
			esac
		done
  		echo ""
  		echo ""
		echo ""
  		read -p "--------------------------> Installation finished, press Enter to continue" 	
    fi

    displayMenuAction
}


#///////////////////////////////////////////////////
#///////////////////////////////////////////////////
#					SCRIPT OPTIONS
#///////////////////////////////////////////////////
#///////////////////////////////////////////////////
DIALOG_OK=0
DIALOG_CANCEL=1

AUTO_UPDATE=true;

parameters='o'
	while getopts $parameters option
	do
		case $option in
			o)
				AUTO_UPDATE=false;
              	;;
     #                 e)
      #                        echo "Exécution des commandes de l'option e"
       #                       echo "Liste des arguments à traiter : $OPTARG"
        #                      echo "Indice de la prochaine option à traiter : $OPTIND"
         #                     ;;
         	\?)
				echo "$OPTARG : invalid argument"
				exit 1
				;;
              esac
      done

#///////////////////////////////////////////////////
#///////////////////////////////////////////////////
#					START SCRIPT
#///////////////////////////////////////////////////
#///////////////////////////////////////////////////

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript" 
   	exit 1
else
	#variables
	CURRENT_USER=$(who | awk 'NR==1{print $1}')
	CALF_VERSION_NAME='calf-0.90.2'

	#Update and Upgrade
	if [[ '$AUTO_UPDATE' = true ]]; then
		echo "--> Updating and Upgrading"
		apt-get update && sudo apt-get upgrade -y
	else
		echo "Auto update disabled"
	fi

	sudo apt-get install dialog 


	displayMenuAction
fi