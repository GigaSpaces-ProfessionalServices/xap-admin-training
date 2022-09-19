#!/bin/bash
dest_download=/dbagigashare/current

if [ `whoami` != "root" ];then
		echo "This script must be run as root."
		exit
fi

read -p "Please enter the destination folder for downloads [$dest_download]: " user_dest_download

if [ ! -z ${user_dest_download} ];then
	dest_download=$user_dest_download
fi

wget_cmd="wget --no-check-certificate -P"
mkdir -p  ${dest_download}
${wget_cmd} ${dest_download}/unzip 				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/unzip/unzip-6.0-21.el7.x86_64.rpm
${wget_cmd} ${dest_download}/gs 				-N https://gigaspaces-releases-eu.s3.amazonaws.com/insightedge/16.1.1/gigaspaces-smart-dih-enterprise-16.1.1.zip
${wget_cmd} ${dest_download}/gs/config/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/gs/xap_logging.properties
${wget_cmd} ${dest_download}/gs/config/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/gs/space.properties
${wget_cmd} ${dest_download}/gs/config/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/gs/spaceproperty.properties
${wget_cmd} ${dest_download}/gs/config/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/gs/TieredCriteria.tab
${wget_cmd} ${dest_download}/db2/jars/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/db2/db2jcc_license_cu-4.16.53.jar
${wget_cmd} ${dest_download}/db2/jars/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/db2/db2jcc-4.26.14.jar
${wget_cmd} ${dest_download}/db2/scripts/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/db2/load_JOTBMF11_MATI_ISKY.sh
${wget_cmd} ${dest_download}/mssql/files/			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/mssql/SQLJDBCDriver.conf
${wget_cmd} ${dest_download}/mssql/files/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/mssql/udkods2.keytab
${wget_cmd} ${dest_download}/mssql/jars/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/mssql/mssqlFeeder-1.0.0.jar
${wget_cmd} ${dest_download}/mssql/scripts/			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/mssql/load_JOTBMF01_TN_MATI.sh                         
${wget_cmd} ${dest_download}/nb 				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/nb/nb-infra-0.0.21.tar.gz
${wget_cmd} ${dest_download}/nb/applicative/			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/nb/nb.conf.template
${wget_cmd} ${dest_download}/nb/management/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/nb/nb.conf.template
${wget_cmd} ${dest_download}/grafana/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/grafana/grafana-7.3.7-1.x86_64.rpm
${wget_cmd} ${dest_download}/grafana/				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/grafana/gs_config.yaml
${wget_cmd} ${dest_download}/grafana/catalog/jars/ 		-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/grafana/catalogue-service.jar                        
${wget_cmd} ${dest_download}/influx 				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/influxdb/influxdb-1.8.4.x86_64.rpm
${wget_cmd} ${dest_download}/kafka/ 				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/kafka/kafka_2.13-2.8.1.tgz
${wget_cmd} ${dest_download}/zk/ 				-N https://dlcdn.apache.org/zookeeper/zookeeper-3.6.3/apache-zookeeper-3.6.3-bin.tar.gz
${wget_cmd} ${dest_download}/kafka/ 				-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/jolokia/jolokia-agent.jar
${wget_cmd} ${dest_download}/telegraf/ 				-N https://dl.influxdata.com/telegraf/releases/telegraf-1.19.3-1.x86_64.rpm
${wget_cmd} ${dest_download}/kapacitor/ 			-N https://repos.influxdata.com/rhel/8/x86_64/stable/kapacitor-1.6.2-1.x86_64.rpm
${wget_cmd} ${dest_download}/kapacitor/ 			-N http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/jq-1.6-2.el7.x86_64.rpm
${wget_cmd} ${dest_download}/kapacitor/ 			-N http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/oniguruma-6.8.2-1.el7.x86_64.rpm
${wget_cmd} ${dest_download}/security/config/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/security/ldap-security-config.xml
${wget_cmd} ${dest_download}/security/jars/ 			-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/security/spring-ldap-core-2.3.3.RELEASE.jar
${wget_cmd} ${dest_download}/security/jars/         		-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/security/spring-security-ldap-5.1.7.RELEASE.jar
${wget_cmd} ${dest_download}/security/jars/         		-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/security/VaultSupport-1.0-SNAPSHOT.jar
${wget_cmd} ${dest_download}/security/cef/jars/     		-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/security/CEFLogger-1.0-SNAPSHOT.jar
${wget_cmd} ${dest_download}/data-integration/di-manager/   	-N https://giga-di.s3.eu-west-1.amazonaws.com/di-packages/manualBuild/di-manager-0.0.12.4.tar.gz 
${wget_cmd} ${dest_download}/data-integration/di-mdm/   	-N https://giga-di.s3.eu-west-1.amazonaws.com/di-packages/manualBuild/di-mdm-0.0.12.4.tar.gz 
${wget_cmd} ${dest_download}/data-integration/di-flink/		-N https://giga-di.s3.eu-west-1.amazonaws.com/Flink/flink-1.15.0-bin-scala_2.12.tgz
${wget_cmd} ${dest_download}/jdk/                       	-N https://tapangigaspaces.s3.us-east-2.amazonaws.com/odsx/install/java/jdk-11.0.11_linux-x64_bin.rpm
