#!/bin/bash
pivot_ip=`hostname -i`
aws_user=centos
ssh_key=./aharon_ami.pem
listfile=./hosts.txt
clear
echo "ODSX lab script #1"
echo "=================="

if [ `whoami` != "root" ];then
		echo "This script must be run as root."
		exit
fi


read -p "Pleae enter the aws user [$aws_user] :" aws_new_user
if [ ! -z $aws_new_user ]; then
        aws_user=$aws_new_user
fi

if [ `grep $aws_user /etc/passwd |wc -l` = 0 ];then
        echo "User $aws_user does not exist. "
        exit
fi

read -p "Please enter the pivot private ip or hostname (don't use localhost/127.0.0.1) [$pivot_ip]: " user_pivot
if [ ! -z "$user_pivot" ]; then
	pivot_ip=$user_pivot
fi

if [[ "$user_pivot" == "127.0.0.1" || "$user_pivot" == "localhost" ]]; then
        echo "localhost is not allowed."
	exit
fi


read -p "Please provide the hosts text file wich contains all the aws instances ips EXCLUDING Pivot ip [$listfile]: " user_listfile
if [ ! -z "$user_listfile" ]; then
        listfile=$user_listfile
fi

if [ -z "$listfile" ]; then
        echo "You must provide an IPs/hostnames list file and full path for ssh-key."
        echo "i.e: ./fixRootLogin.sh hosts_list.txt ./aharon_ami.pem"
        echo "examlpe of a host file list:"
        echo
        echo "ip1"
        echo "ip2"
        echo "ip3"
        echo "hostname4"

        exit
elif [ ! -f "$listfile" ]; then
         echo "The file $listfile does not exit."
         exit
elif [ -z $ssh_key ]; then
        echo "Please specify a ssh-key path."
        exit
elif [ ! -f "$ssh_key" ]; then
         echo "$ssh_key does not exit."
         exit
fi


echo
echo "
Pivot IP: ${pivot_ip}
ssh_key: ${ssh_key}
Remote aws hosts ip: `cat $listfile`

The following steps will be done:

On pivot:

1. Create required local folders
2. Install NFS server (/dbagigashare will be shared for all the remote hosts)
3. Allow SSH to Pivot as root (blocked by default in aws)
4. Install the required rpms.
5. Create gsods user

On remote hosts:

1. Creates required local folders
2. Allow SSH to Pivot as root (blocked by default in aws)
3. create gsods user
"

read -p "Press Y/y to continue or any key to exit." continue
if [[ "$continue" == "Y" || "$continue" == "y" ]]; then
        echo "Script #1 is running..."
else
	exit
fi

# In pivot: set NFS server, set permissions, create gsods user, install required packages
sudo -i << EOF
id -u gsods  &>/dev/null || useradd gsods

mkdir -p /dbagigashare /dbagiga
chmod -R 777 /dbagigashare /dbagiga

yum install nfs-utils vim wget unzip -y
echo "/dbagigashare *" > /etc/exports
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
EOF

# Allow to connect to Pivot  via SSH as root
sed -e 's/^PermitRootLogin.*/PermitRootLogin without-password/g' -i /etc/ssh/sshd_config
sed -e 's/^AllowUsers.*/AllowUsers ${aws_user} root/g' -i /etc/ssh/sshd_config
sed -e 's/no-port/#no-port/g' -i ~/.ssh/authorized_keys
sed -e 's/ssh-rsa/\nssh-rsa/g' -i ~/.ssh/authorized_keys

# set permissions for the pem file.
chmod 400 $ssh_key
while read current_host;
do
        ssh -tt -i ${ssh_key} -o ConnectTimeout=3 -o PasswordAuthentication=no -o StrictHostKeyChecking=no ${aws_user}@${current_host} <<:
        #!/usr/bin/bash
        set +x #echo off

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
        rm -rf /dbagigashare
        # Create a mountpoint to pivot:/dbagigashare
        if [ ! -d /dbagigashare ]; then
          mkdir /dbagigashare
	  echo '${pivot_ip}:/dbagigashare   /dbagigashare   nfs defaults 0 0' >> /etc/fstab
        fi
	mount -a

        # Create local folders: 
	mkdir -p /dbagigalogs /dbagigadata /dbagiga

        exit
        exit
:
sleep 2
done < $listfile


