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

See in the following screenshot node3 is done (booted and ready)and right afterwords node2 is starting booting...<br><br>
![Screenshot](./Pictures/Picture1.png)

**Note:** For your convenient some more information on "How to Set Up a Local Linux Environment with Vagrant":<br>
`https://medium.com/@JohnFoderaro/how-to-set-up-a-local-linux-environment-with-vagrant-163f0ba4da77`


### 3 Explore the cluster:

Please enter the Web Management Console (Web UI)<br>
It should be available on all manager machines: node1,node2 and node3.<br>
On node4 you should'nt be able to use Web Management Console (Web UI) as it is a machine without XAP Manager.<br>

If you see the following, lab has been completed successfully by you :-)<br>

![Screenshot](./Pictures/Picture2.png)

**Tip:**<br>
To login to the machines goto the Vagrant directory and run:<br>
    `vagrant ssh node1` (e.g. login to node1)

### 4 explore Apache ZooKeeper under the hood (Optional Section if time permits)

* `git clone https://github.com/DeemOpen/zkui.git`<br>

* Follow the **Setup** instructions as appear in the readme:<br>
  https://github.com/DeemOpen/zkui/blob/master/README.md

* Explore GS ZK tree to better understand the concept.<br>








      


    