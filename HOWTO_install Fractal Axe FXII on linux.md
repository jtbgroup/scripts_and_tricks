# How To install Linx drivers for Fractal AXE FXII

## Sources

* https://wiki.fractalaudio.com/wiki/index.php?title=USB#Linux
* https://forum.fractalaudio.com/threads/usb-driver-for-apple-silicon.168158/

## Install procedure

1. Grab fxload from https://sourceforge.net/projects/linux-hotplug/files/fxload/
2. Grab drivers from http://archive.axefx.fr/AxeFX%20II/Drivers/Axe-Fx_II_USB_Driver_Setup_Linux_106.zip. The zip contains the .hex you need as the shell script to install the drivers.
3. Extract fxload and the drivers
4. Go to the driver folder (probably called "Axe-Fx_II_USB_Driver_Setup") and type
   ``` shell
   sudo ./axefx2setup.sh
   ```
   There, you'll be asked to give the path to fxload. Thank you autocompletion...
   Accept the Conditions and follow the install procedure.