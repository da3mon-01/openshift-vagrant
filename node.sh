#!/bin/bash
hostnamectl set-hostname node
if [[ ! -d /root/.ssh ]] ; then
	mkdir -p /root/.ssh
fi
cat /vagrant/vagrant.pub >> /root/.ssh/authorized_keys
chown root:root -R /root/.ssh
yum install -y wget git vim parted docker net-tools bind-utils iptables-services bridge-utils bash-completion python-six;
parted /dev/sdb -a optimal --script mklabel msdos mkpart primary 0% 100% set 1 lvm on
parted /dev/sdb --script print all
pvcreate /dev/sdb1
echo "List of PVs:"
pvs
vgcreate docker-vg /dev/sdb1
echo "List of VGs:"
vgs
echo "VG=docker-vg" >> /etc/sysconfig/docker-storage-setup
docker-storage-setup