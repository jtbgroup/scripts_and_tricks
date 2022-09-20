# HOW TO use virtualization on Ubuntu Server

This page is about installing and using KVM virtualization on Ubuntu Server
Reference : https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/

## Update

``` shell
sudo apt update
```

## CPU Info

``` shell
egrep -c '(vmx|svm)' /proc/cpuinfo
```

OK if > 0

## Check virtualization possible

``` shell
kvm-ok
```

## If kvm-ok not possible

``` shell
sudo apt install -y cpu-checker
kvm-ok
```

## Install KVM

``` shell
sudo apt install -y qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils
```

## Enable virtualization

``` shell
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
```

... and confirm ok

``` shell
sudo systemctl status libvirtd
```

## Add user to KVM group

``` shell
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

## Add bridge for the network card

Follow this tutorial : https://levelup.gitconnected.com/how-to-setup-bridge-networking-with-kvm-on-ubuntu-20-04-9c560b3e3991

Example:

``` yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp3s0:
      dhcp4: true
  bridges:
    br0:
      interfaces: [ enp3s0 ]
      addresses: [192.168.1.20/24]
      - to: default
        via: 192.168.1.1
        metric: 100
      mtu: 1500
      nameservers:
        addresses: [192.168.1.1,8.8.8.8,8.8.4.4]
      parameters:
        stp: true
        forward-delay: 4
      dhcp4: yes
      dhcp6: no
  version: 2
```

``` shell
sudo netplan apply
ip add show
```

## Install a new VM

After dowloading the .iso file (ubuntu 22.04) and placing it in /tmp

``` shell
sudo virt-install \
--name front \
--ram 4096 \
--disk path=/var/lib/libvirt/images/front.img,bus=virtio,size=15 \
--vcpus 2 \
--os-variant ubuntu22.04 \
--network bridge:br0 \
--graphics none \
--console pty,target_type=serial \
--location /tmp/ubuntu-22.04-live-server-amd64.iso,kernel=casper/vmlinuz,initrd=casper/initrd \
--extra-args 'console=ttyS0,115200n8' 
```
