# xap-admin-training - Lab10

# Hot Deploy Procedure

## Lab Goals

Get experience with Hot Deploy procedure using Rest. <br /> 
The Hot Deploy is required in the following cases: <br /> 
 
###### 1. Changes in pu business logic
###### 2. Changes in Data type schema
###### 3. Changes in GS version
###### 4. Changes in host OS or Java version

## Lab Description
In this lab we will focus on Hot Deploy when there is a
###### Changes in pu business logic

We will:
###### Add the Custom Rest Upgrade Plugin
###### Run the BillBuddy application. - as you did already at lab5
###### Change the BillBuddy application logic.
###### Create a new JAR with this change.
###### Upload the new JAR
###### Make the application to use the new jar with-out any downtime. 

### Add the Custom Rest Upgrade Plugin

#### 1  clone the plugin

    $ git clone https://github.com/GigaSpaces-ProfessionalServices/CustomRestPlugins.git
    Cloning into 'CustomRestPlugins'...
    remote: Enumerating objects: 12, done.
    remote: Counting objects: 100% (12/12), done.
    remote: Compressing objects: 100% (7/7), done.
    remote: Total 12 (delta 1), reused 12 (delta 1), pack-reused 0
    Unpacking objects: 100% (12/12), 3.04 KiB | 389.00 KiB/s, done.
    

#### 2  Build the project
        
    $ cd CustomRestPlugins/
    $ mvn install
    [INFO] ------------------------------------------------------------------------
    [INFO] Reactor Summary for CustomRestPlugins 1.0-SNAPSHOT:
    [INFO] 
    [INFO] CustomRestPlugins .................................. SUCCESS [  0.180 s]
    [INFO] updatePlugin ....................................... SUCCESS [  0.963 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  1.217 s
    [INFO] Finished at: 2020-04-21T18:33:28+03:00
    [INFO] ------------------------------------------------------------------------

#### 3  Copy updatePlugin/target/updatePlugin.jar to ${XAP_HOME}/lib/platform/manager/plugins/
 
### Run the BillBuddy application. - as you did already at lab5

#### 1	Start gs-agent

1.1 Navigate to $XAP_HOME/bin <br />
        
1.2 Start gs-agent with local Manager server and 4 GSCs:

    ./gs.sh host run-agent --auto --gsc=4
    
#### 2	Deploy BillBuddy_Space
    
2.1 Open $XAP_TRAINING_HOME/xap-admin-training-Lab10 project with intellij (open pom.xml) <br />
2.2 Run mvn install <br />

    ~/xap-admin-training/xap-admin-training-Lab10$ mvn install
    
    
    [INFO] Reactor Summary:
    [INFO] 
    [INFO] Lab10 ............................................... SUCCESS [  0.204 s]
    [INFO] BillBuddyModel ..................................... SUCCESS [  1.087 s]
    [INFO] BillBuddy_Space .................................... SUCCESS [  0.207 s]
    [INFO] BillBuddyAccountFeeder ............................. SUCCESS [  0.189 s]
    [INFO] BillBuddyCurrentProfitDistributedExecutor .......... SUCCESS [  0.225 s]
    [INFO] BillBuddyWebApplication ............................ SUCCESS [  0.349 s]
    [INFO] BillBuddyPaymentFeeder ............................. SUCCESS [  0.190 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS

2.3 IntelliJ path Variables (under preferences)

###### Add GS_LOOKUP_GROUPS & GS_LOOKUP_LOCATORS

2.4 Run mvn xap:intellij

###### This will add the predefined Run Configuration Application to your Intellij IDE.

    ~/xap-admin-training/xap-admin-training-Lab10$ mvn xap:intellij
    
    [INFO] Lab10 ............................................... SUCCESS [  0.586 s]
    [INFO] BillBuddyModel ..................................... SKIPPED
    [INFO] BillBuddy_Space .................................... SKIPPED
    [INFO] BillBuddyAccountFeeder ............................. SKIPPED
    [INFO] BillBuddyCurrentProfitDistributedExecutor .......... SKIPPED
    [INFO] BillBuddyWebApplication ............................ SKIPPED
    [INFO] BillBuddyPaymentFeeder ............................. SKIPPED
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS

2.5 Open a new Terminal and navigate to %XAP_HOME%/gigaspaces-xap/bin/ <br />

    cd $XAP_HOME/bin
           
2.6 Use XAP CLI to deploy BillBuddy_Space
 
    ./gs.sh pu deploy BillBuddy-Space ~/xap-admin-training/xap-admin-training-Lab10/BillBuddy_Space/target/BillBuddy_Space.jar 

#### 3	Run BillBuddyAccountFeeder from Intellij

3.1 From the Intellij run configuration select BillBuddyAccountFeeder and run it.

###### This application writes Users, Merchants and Contracts to the Space
 
3.2 Validate Users and Merchants were written to the space using the web Management Console (localhost:8099). <br />
 Go to: Spaces Tab -> Data Types. <br />
 
![Screenshot](./Pictures/Picture1.png)

3.3 Query the list of Users by executing the following SQL: <br />
Click the Data Type Name and the sql will be created for you: <br />

    SELECT * FROM com.gs.billbuddy.model.User WHERE rownum<5000
    
###### Note: Fully qualified class name is required.

![Screenshot](./Pictures/Picture2.png)

#### 4	Run BillBuddyPaymentFeeder project
The BillBuddyPaymentFeeder application creates payments by randomly choosing a user, 
a merchant and an amount and performs the initial process of a payment. 
This includes deposit and withdrawal updates of each party’s balance appropriately. 
After the payment is initially processed it is written to the space for further processing. 
A new Payment is created every second.
 
4.1 Run the BillBuddyPaymentFeeder using Intellij: 
Use the same instructions as used for the BillBuddyAccountFeeder.

4.2 Validate Payments were written to the space. 
Click the Payment Data Type Name as you did in section 3.3
 
4.3 Go to the statistics operations and see that a payment is actually added every second.

![Screenshot](./Pictures/Picture3.png)

4.4 Go to the Data Types view. Which objects counts are increasing?

## 6 Hot Deploy

### 6.1 Change the BillBuddy application logic - we will just change a log message.

6.1.1 Open com/gs/billbuddy/events/ProcessingFeePollingEventContainer.java class with IntelliJ <br />
6.1.2 verify that you see this line at the end of the class: <br />

    log.info("ProcessingFeeTransaction updates merchants transactionFeeAmount. Merchant: " + merchant.getName() +
                        " new transactionFeeAmount is " + merchant.getFeeAmount());
                        
6.1.3 Open the GSA console and verify that you see this printing rolling for each Merchant. <br />

![Screenshot](./Pictures/Picture4.png)

6.1.4 Go to the Intellij and change something in this log message. For example: <br />

      log.info("ProcessingFeeTransaction updates merchants transactionFeeAmount. Merchant: " + merchant.getName() +
                            " ** My new JAR ** - new transactionFeeAmount is " + merchant.getFeeAmount());
          
          
 ### 6.2 Create a new JAR 
         
6.2.1 Run mvn install <br />
    
    ~/xap-admin-training/xap-admin-training-Lab10$ mvn install
    
    [INFO] ------------------------------------------------------------------------
    [INFO] Reactor Summary:
    [INFO] 
    [INFO] Lab10 .............................................. SUCCESS [  0.215 s]
    [INFO] BillBuddyModel ..................................... SUCCESS [  1.354 s]
    [INFO] BillBuddy_Space .................................... SUCCESS [  0.693 s]
    [INFO] BillBuddyAccountFeeder ............................. SUCCESS [  0.242 s]
    [INFO] BillBuddyCurrentProfitDistributedExecutor .......... SUCCESS [  0.172 s]
    [INFO] BillBuddyWebApplication ............................ SUCCESS [  0.400 s]
    [INFO] BillBuddyPaymentFeeder ............................. SUCCESS [  0.234 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS

    
6.2.2 Rename the jar name <br /> 
   
    cd ~/xap-admin-training/xap-admin-training-lab10/BillBuddy_Space/target
    mv BillBuddy_Space.jar BillBuddy_Space_V2.jar
 			

### 6.3 Upload the new JAR

6.3.1 Open the REST Manager API and navigate to Processing Units<br>
 PUT /pus/resources (http://localhost:8090/v2/index.html#!/Processing_Units/put_pus_resources) <br />
6.3.2 Click on "Choose File" button and select BillBuddy_Space_V2.jar <br />

![Screenshot](./Pictures/Picture5.png)

6.3.3 Click on "Try it out!" button and verify that the response code is 201. <br />

![Screenshot](./Pictures/Picture6.png)

6.3.4 Verify that the new jar has been successfully uploaded: <br />

![Screenshot](./Pictures/Picture7.png)

### 6.4 Update the PU code using the plugin

6.4.1 Run the following curl command <br />

        curl -X PUT --header 'Accept: application/json' 'http://localhost:8090/v2/update/updatePu?oldResource=BillBuddy_Space.jar&newResource=BillBuddy_Space_V2.jar'
        
6.4.2 Verify that the return code is 0 <br />

        echo $?
        0
        
6.4.3 you should receive a successful message

![Screenshot](Pictures/Picture8.png)

        
6.4.5 verify that the new jar has been removed: <br />

![Screenshot](./Pictures/Picture9.png)

### 6.5 Use the new PU
#### 6.5.1 Restart the Containers <br />
First restart backup only after primary:<br>
![Screenshot](./Pictures/Picture10.png)

6.5.2 Go to the GSA console and verify the change in the log message.

![Screenshot](./Pictures/Picture11.png)