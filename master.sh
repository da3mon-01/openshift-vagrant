#!/bin/bash
hostnamectl set-hostname master
echo "192.168.33.10 master" >> /etc/hosts
echo "192.168.33.11 node" >> /etc/hosts
if [[ ! -d /root/.ssh ]] ; then
	mkdir -p /root/.ssh
fi
cp /vagrant/vagrant /root/.ssh/id_rsa
cat /vagrant/vagrant.pub >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chown root:root -R /root/.ssh
yum install -y wget parted vim docker git net-tools bind-utils iptables-services bridge-utils bash-completion python-six epel-release;
yum -y --enablerepo=epel install ansible pyOpenSSL;
echo "Creating Partition"
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

cd /root
git clone https://github.com/openshift/openshift-ansible
chown -R root:root openshift-ansible
echo "Copying sample inventory to /etc/ansible/hosts"
cat /vagrant/ansible_inventory >> /etc/ansible/hosts