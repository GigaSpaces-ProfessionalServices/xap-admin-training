# GS 1 click deploy script 

For help please run:<br>
* ./deploy-gs.sh -h

For interactive mode run:<br>
* ./deploy-gs.sh

For silent (unattended) mode run:<br>
* ./deploy-gs.sh --silent

When running the script on aws centos instance please copy the following files to the aws instance:<br>

1. scp -i lab_training_by_am.pem ~/xap-admin-training/xap-admin-training-lab1.1-one-click-deploy/deploy-gs.sh centos@\<aws public IP\>:.

2. scp -i lab_training_by_am.pem ~/xap-admin-training/xap-admin-training-lab1.1-one-click-deploy/gs_installation.properties centos@\<aws public IP\>:.

