#!/bin/bash

sudo apt-get -y --no-install-recommends install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

sudo adduser root libvirtd

if id -u ubuntu > /dev/null 2>&1; then 
  sudo adduser ubuntu libvirtd
fi


echo "#############################################################"
echo "Restart needed to get KVM happy"
echo "#############################################################"
