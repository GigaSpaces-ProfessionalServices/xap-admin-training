# xap-admin-training - lab14

# Kubernetes

## Lab Goals

Get experience with running XAP PU on Kubernetes cluster. <br /> 

## Lab Description
In this lab we will deploy the pre define xap demo application <br /> 
and then test vertical scaling. <br />

## Prerequisites
Before beginning to work with the data grid and xap, 
ensure that you have the following installed on your local machine or a VM: <br />

[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

[Helm](https://docs.helm.sh/using_helm/#quickstart-guide) <br />
Important: You must use Helm 2 with KubeGrid. 
Helm 3 contains a new chart version, which is a breaking change and is not currently supported by KubeGrid.
Helm 3 will be supported in XAP 15.5 release

[minikube](https://kubernetes.io/docs/setup/minikube/) <br />
##### 1. Configure memory and cpu:

    minikube config set memory 4096
    minikube config set cpus 2
    
##### 2. After installation, configure the VM driver 
(for example: in case you installed VirtualBox as the Hypervisor run the following):

    minikube config set vm-driver virtualbox
    
##### 3. Start Minikube:

    minikube start
    
    😄  minikube v1.10.1 on Darwin 10.15.4
    ✨  Using the virtualbox driver based on user configuration
    👍  Starting control plane node minikube in cluster minikube
    🔥  Creating virtualbox VM (CPUs=2, Memory=4096MB, Disk=20000MB) ...
    🐳  Preparing Kubernetes v1.18.2 on Docker 19.03.8 ...
    🔎  Verifying Kubernetes components...
    🌟  Enabled addons: default-storageclass, storage-provisioner
    🏄  Done! kubectl is now configured to use "minikube"
    
##### 4. In a separate terminal expose Minikube LoadBalancer:
 
    minikube tunnel
    

### 1. Deploying and Managing "xap demo" Data Grid
#### 1.1  Get the required GigaSpaces Helm charts
##### 1.1.1 run: helm init

    helm init

##### 1.1.2 Add xap Helm Repo to the Repo List 
 
    helm repo add gigaspaces https://resources.gigaspaces.com/helm-charts
    
##### 1.1.3 Fetch the GigaSpaces Helm Charts from the GigaSpaces Repository 
(The chart xap is unpacked in your current directory)

    helm fetch gigaspaces/xap --version=15.2.0 --untar
    
#### 1.2  install kubernetes xap demo
    navigate to your home dir
    helm install xap --name demo --set pu.service.lrmi.enabled=true
     
#### 1.3  View and monitor kubernetes deployment
##### 1.3.1 Verify that the pods are running

    Kubectl get pods
    NAME                 READY   STATUS    RESTARTS   AGE
    demo-xap-manager-0   1/1     Running   0          30m
    demo-xap-pu-0        1/1     Running   0          30m

##### 1.3.2 In a separate terminal open Minikube Dashboard. the browser will automatically open.

    minikube dashboard
       
![Screenshot](./Pictures/Picture1.png)

##### 1.3.3 Open Gigaspaces Ops Manager
###### 1.3.3.1 Get the manager ip by running "Kubectl get services", the manager ip will be the EXTERNAL-IP. in my case 10.106.182.8

    Kubectl get services
    NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                                        AGE
    demo-xap-manager-hs        ClusterIP      None             <none>           2181/TCP,2888/TCP,3888/TCP,4174/TCP            2m54s
    demo-xap-manager-service   LoadBalancer   10.98.144.38     10.98.144.38     8090:30296/TCP,4174:31624/TCP,8200:31230/TCP   2m54s
    demo-xap-pu-0-service      LoadBalancer   10.109.229.200   10.109.229.200   8200:30571/TCP                                 2m54s
    kubernetes                 ClusterIP      10.96.0.1        <none>           443/TCP                                        117m

                                   

###### 1.3.3.2 Open Gigaspaces Ops Manager by browsing to <EXTERNAL-IP>:8090 

![Screenshot](./Pictures/Picture2.png)

Click on "Monitor my services"
![Screenshot](./Pictures/Picture3.png)

Click on the "demo" service

![Screenshot](./Pictures/Picture4.png)

#### 1.4  Scaling with the GigaSpaces Helm Chart

Check the current "demo" service Max:RAM

![Screenshot](./Pictures/Picture5.png)

Increase its memory

    helm upgrade demo xap --set pu.resources.limits.memory=600Mi
    
Verify that Max:RAM equals to 450Mi. <br />
Note: it is not 600Mi because in <USER_HOME>/xap/charts/xap-manager/values.yaml file <br />
the configuration is "heap: limit-150Mi" <br /> 


![Screenshot](./Pictures/Picture6.png)

#### 1.5  Feed the demo space with Accounts from Lab-5

1. Edit src/main/java/com/gs/billbuddy/client/AccountFeeder.java <br />
2. Set xap-15.2.0 as the lookup group <br />
3. Set the EXTERNAL-IP as the lookup locator (see section 1.3.3.1) <br />
4. From the Intelij run BillBuddyAccountFeeder <br />
5. Watch the data in the Ops Manager <br />

![Screenshot](./Pictures/Picture7.png)

#### 1.6  Un-deploy demo
    helm del --purge demo
    
#### 1.7  delete minikube
    minikube delete
  
  
This is deploying the space but w/o backup and the feed account dosn't work

    helm install gigaspaces/xap-pu --name billbuddyspace --set manager.name=demo --set pu.ha=true,pu.antiAffinity.enabled=true --set pu.service.lrmi.enabled=true
    
    



