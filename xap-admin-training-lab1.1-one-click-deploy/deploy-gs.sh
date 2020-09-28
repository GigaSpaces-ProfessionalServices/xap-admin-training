#!/bin/bash

if [ "$1" == "-h" ]; then
	 echo "Usage: `basename $0` --silent"
	 echo For silent installation with key value properties file
	 echo no parameters for interactive installation
	 exit 0
elif [ "$1" == "--silent" ]; then
        if [ -f gs_installation.properties ]; then
            source gs_installation.properties
        fi
        if [ -z "$host1" ]; then
        gsManagerServers=localhost
        host1=localhost
        else
        gsManagerServers=$host1
        fi
        if [ ! -z "$host2" ]; then
        gsManagerServers=$host1,$host2
        fi
        if [ ! -z "$host3" ]; then
        gsManagerServers=$host1,$host2,$host3
        fi
else
	echo List of available product types:
	echo [1] xap
	echo [2] insightedge

	while true; do
            read -p 'Select product type by name or number:[' -i 1']' -e gsType
	    case $gsType in
		1]1|1]|1]xap) gsType=xap; break;;
		1]2|1]insightedge) gsType=insightedge; break;;
		* ) echo 'Please enter product name or number: ';;
	    esac
	done

	echo List of available product versions:
	echo [1] 15.5.0
	echo [2] 15.2.0
	echo [3] 15.0.0

	while true; do
	    read -p 'Select product version by name or number:[' -i 1']' -e gsVersion
	    case $gsVersion in
		1]1|1]|1]15.5.0) gsVersion=15.5.0; break;;
		1]2|1]15.2.0) gsVersion=15.2.0; break;;
		1]3|1]15.0.0) gsVersion=15.0.0; break;;
		* ) echo 'Please enter product name or number: ';;
	    esac
	done

	echo List of available installation types:
	echo [1] local
	echo [2] cluster

	while true; do
	    read -p 'Select installation type:[' -i 1']' -e gsManagerServers
	    case $gsManagerServers in
		1]1|1]|1]local) read -p "To override default localhost enter machine host or ip: " -e host1;
                        if [ -z "$host1" ]
                        then
                            gsManagerServers=localhost
                            host1=localhost
                        else
                            gsManagerServers=$host1
                        fi;
			break;;
		1]2|1]cluster)
		echo please enter 3 GS manager hosts:
		read -p 'Enter Host #1:' -e host1;
		gsManagerServers=$host1
		read -p 'Enter Host #2:' -e host2;
		gsManagerServers=$gsManagerServers,$host2
		read -p 'Enter Host #3:' -e host3;
		gsManagerServers=$gsManagerServers,$host3
		 break;;
		* ) echo 'Please enter installation type by name or number: ';;
	    esac
	done
	read -p "To override default number of containers to rise [Default is none]: " -e containerCnt;
	if [ ! -z "$containerCnt" ]
    then
		read -p "To override default containers heap [Default is 512m] please specify units (m/g): " -e containerMem;
		if [ ! -z "$containerMem" ]
		then
		       export GS_GSC_OPTIONS="-Xmx$containerMem -Xms$containerMem"
		fi;
    fi;

    echo List of available machine OS types:
	echo [1] centos
	echo [2] ubuntu

	while true; do
            read -p 'Select machine os type by name or number:[' -i 1']' -e osType
	    case $osType in
		1]1|1]|1]centos) osType=centos; break;;
		1]2|1]ubuntu) osType=ubuntu; break;;
		* ) echo 'Please enter machine os type by name or number: ';;
	    esac
	done
fi

function installRemoteJava {
    if [ "$osType" == "centos" ]; then
	    sudo yum -y install java-1.8.0-openjdk
	elif [ "$osType" == "ubuntu" ]; then
	    sudo apt -y install openjdk-8-jdk
	fi
	echo "install Remote JDK - Done!"
}

function installZip {
    if [ "$osType" == "centos" ]; then
	    sudo yum -y install unzip
	elif [ "$osType" == "ubuntu" ]; then
	    sudo apt -y install unzip
	fi
	echo "install ZIP - Done!"
}

function installWget {
    if [ "$osType" == "centos" ]; then
	    sudo yum -y install wget
	elif [ "$osType" == "ubuntu" ]; then
	    sudo apt -y install wget
	fi
	echo "install wget - Done!"
}

function downloadGS {
	wget https://gigaspaces-releases-eu.s3.amazonaws.com/${gsType}/${gsVersion}/gigaspaces-${gsType}-enterprise-${gsVersion}.zip
	echo "download GS - Done!"
}

function unzipGS {
        unzip gigaspaces-${gsType}-enterprise-${gsVersion}.zip
	echo "unzipping GS - Done!"
}

function activateGS {
        if [ "$gsVersion" == "15.5.0" ]; then
		    license="Product=InsightEdge;Version=15.5;Type=ENTERPRISE;Customer=demo_DEV;Expiration=2020-Nov-24;Hash=YiiSYZQMIPSmOQYPCPS6"
        elif [ "$gsVersion" == "15.2.0" ]; then
		    license="Product=InsightEdge;Version=15.2;Type=ENTERPRISE;Customer=demo_DEV;Expiration=2020-Nov-24;Hash=YVPQhPkEWBRluNvMO9Sx"
	    elif [ "$gsVersion" == "15.0.0" ]; then
		    license="Product=InsightEdge;Version=15.0;Type=ENTERPRISE;Customer=demo_DEV;Expiration=2020-Nov-24;Hash=QpNXYXYUV6SQNWPRURZW"
        fi
        echo $license>gigaspaces-${gsType}-enterprise-${gsVersion}/gs-license.txt
	echo "activating GS - Done!"
}

function startGS {
	if [ -z "$containerCnt" ]
        then
		nohup gigaspaces-${gsType}-enterprise-${gsVersion}/bin/gs.sh host run-agent --auto &
        else
                if [ ! -z "$containerMem" ]
                then
                       export GS_GSC_OPTIONS="-Xmx$containerMem -Xms$containerMem"
                fi;
		nohup gigaspaces-${gsType}-enterprise-${gsVersion}/bin/gs.sh host run-agent --auto --gsc=$containerCnt &
        fi;
	echo "starting GS - Done!"
        echo "GS Web-UI http://localhost:8099"
        echo "GS Ops Manager http://localhost:8090"
}

function settingGsManagers {
        echo "settingGsManagers - Done!"
        echo "setting manager GS"
        echo -e "\nexport GS_MANAGER_SERVERS=$gsManagerServers">>gigaspaces-${gsType}-enterprise-${gsVersion}/bin/setenv-overrides.sh
        echo "setting manager GS - Done!"
}

function endAnnouncement {
echo "#######################################################"
echo "SUMMARY :  SYSTEM INSTALLED SUCCESSFULLY"
echo DATE `date +"%D"` / TIME `date +"%T"`
echo "VERSION ${gsType}"
echo "URL for OpsManager :  <http://$host1:8090>"
echo "URL for GS web-ui :   <http://$host1:8099>"
echo "Rest :   <http://$host1:8090/v2 >"
if [ "$gsType" == "insightedge" ]; then
echo "URL for Zeppelin NoteBook <http://$host1:9090>"
fi
echo "#######################################################"
}

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
echo "starting settingGsManagers"
settingGsManagers
echo "starting GS"
startGS
echo "ending the Installation"
endAnnouncement