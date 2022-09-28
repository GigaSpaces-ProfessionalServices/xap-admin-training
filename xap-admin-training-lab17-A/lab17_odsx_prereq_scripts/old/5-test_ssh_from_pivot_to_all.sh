#!/bin/bash
echo
read -p "linux user (ec2-user, centos, root etc.): " awsuser
read -p "command to excute: " execmd
read -p "aws hosts file: " hostsfile
read -p "ssh_key file: " sshkey

for host in $(cat ${hostsfile});do
	
	echo "Connecting to:" ${host}
	ssh -i ${sshkey} -o ConnectTimeout=3 -o PasswordAuthentication=no -o StrictHostKeyChecking=no  ${awsuser}@${host} '[[ `df -h | grep "/dbagiga" |wc -l` -eq 1 ]] && echo ${host}: OK || echo FAILED' 
	echo "============================================================"
	echo
done


