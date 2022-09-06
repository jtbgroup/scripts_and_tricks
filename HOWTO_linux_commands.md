# Useful LINUX Commands

Based on Ubuntu (desktop or server)

## Samba

### Install

```sh
sudo apt update
sudo apt install samba
```

### Manage service

```sh
# stop the service
sudo systemctl stop smbd
# disable the service and prevent from start at boot
sudo systemctl disable smbd
# permaenetly disable he service even when another process needs it
sudo systemctl mask smbd
```

### Configure

In /etc/samba/smb.conf

```text
[sambashare]
    comment = Samba on Ubuntu
    path = /home/gautier/sambashare
    read only = no
    browsable = yes
```

## Manage users

### rename a user

```sh
sudo adduser <new_username>
sudo rsync -aP ~<old_username>/ ~<new_username>
sudo chown <new_username> -R ~<new_username>
sudo usermod -a -G ftp,sudo,example <new_username>
```

Verify you can use the new username, then

```sh
sudo userdel -r <old_username>
```
