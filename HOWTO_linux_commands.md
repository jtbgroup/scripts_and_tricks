# Useful LINUX Commands

Based on Ubuntu (desktop or server)

## Samba

## Install

```sh
sudo apt update
sudo apt install samba
```

## Manage service

```sh
# stop the service
sudo systemctl stop smbd
# disable the service and prevent from start at boot
sudo systemctl disable smbd
# permaenetly disable he service even when another process needs it
sudo systemctl mask smbd
```

## Configure

In /etc/samba/smb.conf

```text
[sambashare]
    comment = Samba on Ubuntu
    path = /home/gautier/sambashare
    read only = no
    browsable = yes
```
