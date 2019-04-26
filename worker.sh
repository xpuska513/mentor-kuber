#!/bin/bash

CREATE_DISK=true

echo "Auto-provision script for gluster + kubernetes cluster setup (workers)"

echo "Installing kubernetes and docker"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y docker-ce kubelet kubeadm kubectl

echo "Installing glusterfs-server and glusterfs-client"
sudo apt-get update

echo "Creating partitions"
if [[ $CREATE_DISK -eq 'true' ]]; then
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sdc
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
    # 100 MB boot parttion
  w # write the partition table
  q # and we're done
EOF
mkfs.ext4 /dev/sdc1
else
echo "Skipping partition creation"
fi
echo "Creating ceph user and gathering facts about osds"

