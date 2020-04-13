# xap-admin-training - lab6

# GigaSpaces Ops Manager 

## Lab Goals

**1.** Explore from close GS Ops Manager windows <br />
**2.** Get familiar with GS Ops Manager capabilities<br />

## Lab Description
In this lab we will focus on GigaSpaces Ops Manager functionalities.<br>
To better know its capabilities you will use GS Ops manager ui demo tool for your convenience.

### 1 Download and run GS Ops manager demo tool:

*  git clone https://github.com/GigaSpaces-ProfessionalServices/ui-demo<br>
*  Open README.MD and follow it's instructions:<br>
       https://github.com/GigaSpaces-ProfessionalServices/ui-demo/blob/master/README.MD  <br> 
* Once done with the above readme continue with the next section **(2 UI DEMO)** 
       
### 2 UI DEMO

Open the ui demo:<br>
* http://localhost:8280/

![Screenshot](./Pictures/Picture1.png)

#### 1.1 CPU Alert:
* Choose ProductsCatalog Service and trigger the CPU Alert:<br>
![Screenshot](./Pictures/Picture2.png)
* Trouble shoot it in the GS Ops Manager:<br><br>
![Screenshot](./Pictures/Picture3.png)

#### 1.2 Memory Alert:
* Choose ProductsCatalog Service and trigger the Memory Alert:<br>
![Screenshot](./Pictures/Picture4.png)
* Trouble shoot it in the GS Ops Manager:<br><br>
![Screenshot](./Pictures/Picture5.png)

#### 1.3 Unavailability Alert:
* Choose Mirror Service and trigger the Unavailability Alert:<br>
![Screenshot](./Pictures/Picture6.png)
* Trouble shoot it in the GS Ops Manager:<br><br>
![Screenshot](./Pictures/Picture7.png)

#### 1.4 No-Backups Alert:
* Choose ProductsCatalog Service and trigger the No-Backups Alert:<br>
![Screenshot](./Pictures/Picture8.png)
* Trouble shoot it in the GS Ops Manager:<br><br>
![Screenshot](./Pictures/Picture9.png)<br>
![Screenshot](Pictures/Picture10.png)

#### 1.5 Create Containers:
* Select your host and click the Create button:<br>
![Screenshot](./Pictures/Picture11.png)
* Verify that you have a free GSC in the Web Management Console:<br><br>
![Screenshot](./Pictures/Picture12.png)

#### 1.6 Scale Up Service:
* Choose WebApplication Service and click the Scale up button:<br>
![Screenshot](./Pictures/Picture13.png)
* Verify WebAppliaction instance was incremented in the GS Ops Manager Services view:<br><br>
![Screenshot](./Pictures/Picture14.png)<br>
![Screenshot](./Pictures/Picture15.png)

#### 1.7 Scale Down Service:
* Choose WebApplication Service and click the Scale down button:<br>
![Screenshot](./Pictures/Picture16.png)
* Verify WebAppliaction instance was decremented in the GS Ops Manager Services view:<br><br>
![Screenshot](./Pictures/Picture17.png)

#### 1.8 Remove Containers:
* Open the Web Management Console and verify which GSC pid is empty with no service deploy on it:<br><br>
![Screenshot](./Pictures/Picture18.png)
* Select your host and Container to remove click the Remove button:<br>
![Screenshot](./Pictures/Picture19.png)
* Verify in the Web Management Console spare GSC was removed:<br><br>
![Screenshot](./Pictures/Picture20.png)

### 3 UI DEMO termination

From ui-demo folder run:<br>
* ./undeploy_all.sh<br>
![Screenshot](./Pictures/Picture21.png)
* Shut down XAP run time environment and roll back setenv-overrides.sh (delete or comment GS_GSC_OPTIONS line)



      


    