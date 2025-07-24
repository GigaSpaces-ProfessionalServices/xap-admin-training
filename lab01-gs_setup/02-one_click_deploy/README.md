# gs-admin-training - lab01-one_click_deploy

## One-Click-Deploy
This section of the lab provides an alternative to a manual installation previously described in the introduction.

For help please run:
`./deploy-gs.sh -h`

For interactive mode run:  
`./deploy-gs.sh`

For silent (unattended) mode run:  
`./deploy-gs.sh --silent`

When running the script on aws RHEL instance please copy the following files to the AWS instance:  

```
scp -i lab_training_by_am.pem ~/gs-admin-training/lab01-gs_setup/02-one_click_deploy/deploy-gs.sh centos@<aws public IP>:.
scp -i lab_training_by_am.pem ~/gs-admin-training/lab01-gs_setup/02-one_click_deploy/gs_installation.properties centos@<aws public IP>:.
```
