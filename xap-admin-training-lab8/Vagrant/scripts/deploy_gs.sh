#!/bin/bash

function installRemoteJava {
	#sudo yum -y install java-1.8.0-openjdk	
	yum -y install java-1.8.0-openjdk	
	echo "install Remote JDK - Done!"
}

function installZip {
	#sudo yum -y install unzip	
	yum -y install unzip	
	echo "install ZIP - Done!"
}

function installWget {
	#sudo yum -y install wget	
	yum -y install wget	
	echo "install wget - Done!"
}

function downloadGS {
	wget https://gigaspaces-releases-eu.s3.amazonaws.com/xap/15.2.0/gigaspaces-xap-enterprise-15.2.0.zip	
	echo "download GS - Done!"
}

function unzipGS {
        unzip gigaspaces-xap-enterprise-15.2.0.zip	
	chown -R vagrant:vagrant gigaspaces-xap-enterprise-15.2.0
	echo "unzipping GS - Done!"
}

function activateGS {
        echo "tryme">gigaspaces-xap-enterprise-15.2.0/gs-license.txt 
	echo "activating GS - Done!"
}

function startGS {
echo "#!/bin/bash" > /home/vagrant/start_GS.sh
        echo " su - vagrant -c \"  /usr/bin/nohup /home/vagrant/gigaspaces-xap-enterprise-15.2.0/bin/gs.sh host run-agent --auto > /home/vagrant/start_GS.out &\"" >> /home/vagrant/start_GS.sh
	chown vagrant:vagrant /home/vagrant/start_GS.sh
	chmod 777 /home/vagrant/start_GS.sh
	/home/vagrant/start_GS.sh
	echo "starting GS - Done!"
        echo "GS Web-UI http://localhost:8099"
        echo "GS Ops Manager http://localhost:8090"
}

if [ "$1" == "-h" ]; then
  echo "For cluster setup:"
  echo "Usage: `basename $0` [GS_Manager_Host1,GS_Manager_Host2,GS_Manager_Host3]"
  echo "For none cluster installation (one host) no paramter is required, the installation will be based on machine localhost"
  exit 0
fi
echo "setup java"
installRemoteJava
echo "setp zip"
installZip
echo "install wget"
installWget
echo "Download GS"
downloadGS
echo "unzipping GS"
unzipGS
echo "activating GS"
activateGS
if [ "$1" != "" ]; then
	echo "setting manager GS"
	echo -e "\nexport GS_MANAGER_SERVERS=$1">>gigaspaces-xap-enterprise-15.2.0/bin/setenv-overrides.sh 	
	echo "setting manager GS - Done!"
fi
echo "starting GS"
startGS

