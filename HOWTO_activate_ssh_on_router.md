# How To activate SSH on an ASUS router and generate the keys

Reference : [Tutorial from Home Assistant](https://community.home-assistant.io/t/how-i-got-asuswrt-device-tracker-working-with-ssh-key-files/47787)

The goal of this document is to list the actions that needs to be done when you want to connect to an ASUS domestic router using ssh, but with a rsa key (not login - password).

This has been tested on an ASUS WIFIZEN and Home assistant as client. THe keys are generated on a linux computer.

1. on a linux computer, install putty:

    ```Shell
    sudo apt install putty
    ```

2. Generate the keys

    * Generate ppk keys
  
        ***Attention !!!! no passphrase must be given as the Asus router has no option to give a passphrase*** (just press enter)
        This will generate a file called *asus_zenwifi.ppk* in the current directory

        ```Shell
        puttygen -t rsa -b 4096 -C "RSA key for ASUS ZenWifi" -o asus_zenwifi.ppk
        ```

    * Convert private key to open ssh.
  
        This will generate a file called *asus_zenwifi_private* in the current directory. It's important here not having an extension (home assistant seems not needing it ???)

        ```Shell
        puttygen asus_zenwifi.ppk -O private-openssh -o asus_zenwifi_private
        ```

    * Convert public key to open ssh (not useful in our case for our Asus router)
  
        This will generate a file called *asus_zenwifi_public* in the current directory.

        ```Shell
        puttygen asus_zenwifi.ppk -O public-openssh -o asus_zenwifi_public
        ```

    * Extract public RSA key

        No file is generated here, but the key is prompted in the command prompt. Just copy it.

        ```shell
        puttygen -L asus_zenwifi.ppk 
        ```

3. Install te keys

    * Private key

        Go to your home assistant and copy the private key (in open ssh !!!) in /config/ssh of home assistant ***without*** extension and change privileges. Copying the file can be done using the samba extension. Changing the privileges can be done with the *SSH & Web Terminal* Addon which has the option to start an ssh session from the web interface.

        ```shell
        chmod 600 /config/ssh/asus_zenwifi
        ```

    * Public key

        On the router, fill in the RSA key in the *Admin* section

### Run script on router startup
Plug an usb device in the router and in a terminal on the router, add these lines

```shell
    nvram set script_usbmount="/jffs/scriptname"
    nvram commit
```

where scriptname is the script you want to execute