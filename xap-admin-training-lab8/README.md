# xap-admin-training - lab8

# GigaSpaces XAP manager 

## Lab Goals

**1.** See how easy it is to setup XAP cluster<br>
**2.** Get familiar with XAP Manager capabilities<br />

## Lab Description
In this lab we will focus on XAP Manager functionalities.<br>
To better know its capabilities you will set up 4 machine cluster based on Vagrant<br>

### 1 Setup Vagrant framework on your machine

#### 1.1 Install VirtualBox

https://www.virtualbox.org/wiki/Downloads

#### 1.2 Install Vagrant

https://www.vagrantup.com/downloads.html

### 2 “vagrant up” and Provisioning your Virtual Machine

**1)**   `cd ~/xap-admin-training/xap-admin-training-lab8/Vagrant` <br>
**2)**   `vagrant up` <br>
**3)**  Wait until all 4 virtual machines are booted and ready.

See in the following screenshot node-7 is done (booted and ready)and right afterwords node-6 is starting booting...<br><br>
![Screenshot](./Pictures/Picture1.png)

**Note:** For your convenient some more information on "How to Set Up a Local Linux Environment with Vagrant":<br>
`https://medium.com/@JohnFoderaro/how-to-set-up-a-local-linux-environment-with-vagrant-163f0ba4da77`

### 3 Set up XAP

To login to a vm please follow this screenshot:

![Screenshot](./Pictures/Picture2.png)

**1.**  unzip GS Software distribution.<br>
**2.** `cd $GS_HOME` and Update gs-license.txt with tryme.<br>
**3.** `cd $GS_HOME/bin` and set up **GS_MANAGER_SERVERS** in `setenv-overrides.sh` <br>
export GS_MANAGER_SERVERS=node5,node6,node7 <br>
**4.** ./gs.sh host run-agent --auto

**Once you are done with steps 1-4 on all 4 vms you are done! Cluster is ready to be use :-)**

### 4 Explore the cluster:

Please enter the Web Management Console (Web UI)<br>
It should be available on all manager machines: node-5,node-6 and node-7.<br>
On node-8 you should'nt be able to use Web Management Console (Web UI) as it is a machine without XAP Manager.<br>

If you see the following, lab has been completed successfully by you :-)<br>

![Screenshot](./Pictures/Picture3.png)

### 5 explore Apache ZooKeeper under the hood (Optional Section if time permits)

* `git clone https://github.com/DeemOpen/zkui.git`<br>

* Follow the **Setup** instructions as appear in the readme:<br>
  https://github.com/DeemOpen/zkui/blob/master/README.md

* Explore GS ZK tree to better understand the concept.<br>








      


    