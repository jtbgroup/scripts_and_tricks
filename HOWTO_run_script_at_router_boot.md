# How To run a script at router boot

Reference: https://www.securityforrealpeople.com/2015/01/asus-bug-lets-those-on-your-local.html

Domestic Asus router have versatile configuration and only the parameters available in the UI are stored locally. This means that if you want to adapt for example your dnsmasq config file, your customization will disappear when the router boots. The method described here allows you to run a script at boot time using the feature of usb mount of the nvram.

Of yourse, your router needs a usb port for this... 

This method has been tested on a Asus Zenwifi.

**Attention: this trick will work as long as the router is not updated. If you update the firmware, you'll need to do this again.**

Plug an usb device in the router and in a terminal in the router. The content of the usb stick is not important. COnnect to your router using an ssh connection and type these lines:
```shell
    nvram set script_usbmount="/jffs/scriptname"
    nvram commit
```
where *scriptname* is the script you want to execute (assuming you copied your script in /jffs). 

Storing your script in /jffs is a good option as this folder is not deleted when rebooting.