#!/bin/bash
if [ `whoami` != "root" ];then
		echo "This script must be run as root."
		exit
fi

read -p "Please provide gs-odsx ZIP file full path: " user_odsx_path
if [ ! -f  $user_odsx_path ];then
	echo "The file does not exist."
	exit
else
	odsx_path=`readlink -f ${user_odsx_path}`
fi

# Extract gs-odsx ip file
unzip -qq -o $odsx_path -d /dbagiga

# Create a soft link
symlink=`echo $(basename ${odsx_path//.zip/})`
ln -nsf $symlink /dbagiga/gs-odsx

#Create a tryme license
echo "tryme" > /dbagigashare/current/gs/config/license/gs-license.txt
chmod 400 /dbagiga/gs-odsx/*.pem

# Run setup.sh to install odsx
cd /dbagiga/gs-odsx/scripts
./setup.sh

#copy files to /dbagigashare
cp /dbagiga/gs-odsx/config/metrics.xml.template /dbagigashare/current/gs/config/metrics/
cp /dbagiga/gs-odsx/config/nb.conf.template /dbagigashare/current/nb/management/
cp /dbagiga/gs-odsx/config/nb.conf.template /dbagigashare/current/nb/applicative/
cp /dbagiga/gs-odsx/config/app.yaml /dbagigashare/current/odsx/
cp /dbagiga/gs-odsx/config/host.yaml /dbagigashare/current/odsx/
cp /dbagiga/gs-odsx/config/app.config /dbagigashare/current/odsx/

echo
source ~/.bash_profile
source ~/.bashrc

echo
echo "========================================================"
echo "To use odsx:

        - Please update the file 'hosts.yaml' at /dbagigashare/current/odsx.
        - Run logout & login as root
        - cd /dbagiga/gs-odsx
        - ./odsx.py
"
