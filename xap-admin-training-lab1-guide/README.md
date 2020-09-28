# xap-admin-training - lab1-guide

## XAP setup and installation

#### 1 setup

##### 1.1 Download and install XAP version 15.2:

1. Download XAP 15.2 from:

https://www.gigaspaces.com/downloads/

![snapshot](Pictures/Picture1.png)

2. Extract and setup as describe here:

https://docs.gigaspaces.com/latest/started/installation.html#DownloadingandInstalling


##### 1.2 Put `tryme` license to `gs-license.txt` file located at the root of xap installation directory.

##### 1.3 Go to `$GS_HOME/bin` open `setenv-overrides.sh` and set: <br>
   `JAVA_HOME` -> point to your java installation directory <br>
   `GS_LOOKUP_GROUPS` -> set any unique identifier
   
##### 1.4 Test your XAP Installation. <br>
   You will start a XAP process (gs-agent) and you will wait to see a message that the gs-agent started successfully with groups [<your user group>]
   
    cd $GS_HOME/bin
    ./gs.sh host run-agent --auto --gsc=2
   
   The following screen will appear:
   (Search for the message marked below):
   
![Screenshot](./Pictures/Picture2.png)
   
   If you see the above, you have successfully installed the courseware for our class.
   
##### 1.5	Stop processes
    Stop the gs-agent process (2 options):
    1. ctrl+c
    2. ./gs.sh host kill-agent

#### 2	Wiki and API Doc Exercise  

##### 2.1 Validate internet connectivity by opening a browser and going to GigaSpaces site: 
        www.gigaspaces.com
##### 2.2 Click on support-> Documents

![Screenshot](./Pictures/Picture3.png)


![Screenshot](./Pictures/Picture4.png)        

![Screenshot](./Pictures/Picture5.png)     