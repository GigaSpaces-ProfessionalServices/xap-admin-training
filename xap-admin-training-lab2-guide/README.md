# xap-admin-training - lab2-guide


## 	XAP Overview

###### Lab Goals
*   Be introduced and experienced Grid Service Components

###### Lab Description
In this lab you will start XAP infrastructure services. Inspect the runtime grid in the GS-UI.

## 1	Start XAP Infrastructure

    a.	Goto %XAP_TRAINING_HOME%\gigaspaces-xap\bin
    b.	./gs.sh host run-agent --auto --gsc=2
    c.	Start gs-ui:
        ./gs-ui.sh
    
## 2	Examine the running environment
    
    a. Examine the ‘gigaspaces-manager.log’ Check the GSM and GSCs have started and registered successfully 

![Screenshot](./Pictures/Picture1.png)

    b.	Go to the gs-ui application
    c.	Press the host tab
    d.	Press on the gsc processes to see the process information and log.
    
![Screenshot](./Pictures/Picture2.png)

    e.	Open your browser and got localhost:8099
    f.	Examine the webui console.
    g.	You will learn more about it at a later session.
    
![Screenshot](./Pictures/Picture3.png)
