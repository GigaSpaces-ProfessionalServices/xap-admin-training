#!/bin/bash

function installRemoteJava {
	echo "install Remote JDK"
	sudo yum -y install java-1.8.0-openjdk	
}

function installZip {
	echo "install ZIP"
	sudo yum -y install unzip	
}

function installWget {
	echo "install wget"
	sudo yum -y install wget	
}

function downloadGS {
	echo "download GS"
	wget https://gigaspaces-releases-eu.s3.amazonaws.com/xap/15.2.0/gigaspaces-xap-enterprise-15.2.0.zip	
}


echo "setup java"
installRemoteJava
echo "setp zip"
installZip
echo "install wget"
installWget
echo "Download GS"
downloadGS
