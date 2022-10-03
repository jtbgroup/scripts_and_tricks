# How To install SSH on a server and generate the keys for the client

Reference : [Tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-2)

The goal of this document is to have a tutorial for installing ssh on a remote server and generate the key on a computer to connect using the keys and not a login / password which is less secure.

We assume Ubuntu server is installed on server and an admin user (called sammy) is accessible.

## Install SSH

1. Access the server and login as admin.
2. Install ssh

```sh
sudo apt update
sudo apt install openssh-server
```

3. Verify the service is running

```sh
sudo systemctl status ssh
```

4. Connect the server using ssh

```sh
sudo ssh sammy@your_server_address
```

## Generate and install keys

1. On the device that wants ssh access to the remote server:  
Attention to the encryption method (here `ed25519`)  
It's better to use a passphrase to increase security

```sh
ssh-keygen -t ed25519
```

2. Install the key

```sh
ssh-copy-id sammy@your_server_address
```

## Disable the ssh acces by login / password

1. Edit sshd_config

```sh
sudo nano /etc/ssh/sshd_config
```

Find the line in the file that includes PasswordAuthentication (or create the line if it doesn't exist), make sure it is not commented out with a # at the beginning of the line, and change it to no

```txt
PasswordAuthentication no
```

2. Reload the system

```shell
sudo systemctl reload sshd
```

## Store your configs

In `~/.ssh/config` file, add one bloc per target

```yaml
Host hypernc
    HostName hostname_Or_Ip
    User myUser
    Port 22
    IdentityFile ~/.ssh/mykeylocation.key
```