#!/usr/bin/bash
# Enable root login
sudo sed -e 's/^PermitRootLogin.*/PermitRootLogin without-password/g' -i /etc/ssh/sshd_config
sudo sed -e 's/^AllowUsers.*/AllowUsers centos root/g' -i /etc/ssh/sshd_config
sudo -s
cd
sudo sed -e 's/no-port/#no-port/g' -i ~/.ssh/authorized_keys
sudo sed -e 's/ssh-rsa/\nssh-rsa/g' -i ~/.ssh/authorized_keys

# Install nfs utils
yum install nfs-utils -y

# Create gsods user (if does not exist)
id -u gsods  &>/dev/null || useradd gsods

# Create a mountpoint to pivot:/dbagigashare
#if [ ! -d /dbagigashare ]; then
#  mkdir /dbagigashare
#  echo '${pivot_ip}:/dbagigashare   /dbagigashare   nfs defaults 0 0' >> /etc/fstab
#fi

LINE="${pivot_ip}:/dbagigashare    /dbagigashare   nfs defaults 0 0"
FILE=/etc/fstab
grep -q ${pivot_ip}:/dbagigashare ${FILE} || echo ${LINE} >> {$FILE}


mount /dbagigashare

# Create local folders if does not exist:
mkdir -p /dbagigalogs /dbagigadata /dbagiga
exit
exit

