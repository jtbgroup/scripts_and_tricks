# Scope
This tutorial is to be followed to install the Garmin IQ SDK in eclipse running on Ubintu 20.04

Reference: [Garmin forum](https://forums.garmin.com/developer/connect-iq/i/bug-reports/simulator-not-working-on-ubuntu-19-04)

### 1. TUTO

https://askubuntu.com/questions/1135065/cant-run-pulse-secure-on-ubuntu-19-04-because-libwebkitgtk-1-0-so-0-is-missing

I rewrote the instructions as how I executed them. After that, the simulator worked:

To get the simulator to work

* Lets make debs and extra folders:

		sudo mkdir /opt/eclipse/garmin/extra

* Download below packages from archice.ubuntu.com to /usr/local/pulse/debs:

		cd /opt/eclipse/garmin/extra
		sudo wget archive.ubuntu.com/.../libicu60_60.2-3ubuntu3_amd64.deb
		sudo wget archive.ubuntu.com/.../libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb
		sudo wget archive.ubuntu.com/.../libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb

* Extract *.deb files in /opt/eclipse/garmin/extra

		cd /opt/eclipse/garmin/extra
		sudo dpkg -x libicu60_60.2-3ubuntu3_amd64.deb .
		sudo dpkg -x libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb .
		sudo dpkg -x libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb .

* Which to normal user and export LD_LIBRARY_PATH in command line:

		export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/eclipse/garmin/extra/usr/lib/x86_64-linux-gnu/

* Now start the simulator, or eclipse within this shell


### 2. ENV VAR
If you want to persist the variable on your system, add the following lines at the end of the file ~/.bashrc

	# lines added to assign Env variable needed for the sdk
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/eclipse/garmin/extra/usr/lib/x86_64-linux-gnu/
