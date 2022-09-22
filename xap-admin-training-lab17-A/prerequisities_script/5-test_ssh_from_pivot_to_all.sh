#!/bin/bash
echo
read -p "linux user (ec2-user, centos, root etc.): " awsuser
read -p "command to excute: " execmd
read -p "aws hosts file: " hostsfile
read -p "ssh_key file: " sshkey

for host in $(cat ${hostsfile});do
	
	echo "Connecting to:" ${host}
	echo 'ssh -i ${sshkey} ${awsuser}@${host} echo -e "Executing ... &&  ${execmd}"'
	ssh -i ${sshkey} ${awsuser}@${host} echo -e "Executing ... &&  ${execmd}"
	echo "============================================================"
	echo
done


