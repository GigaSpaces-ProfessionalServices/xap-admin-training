# xap-admin-training - lab13

# Grid Security

## Lab Goals

1. Experience secured pu deployment process. <br />
2. Get familiar with GigaSpaces authority and authorization <br />

## Lab Description
In this lab we will focus on secured pu deployment.<br>
Authority and Authorization using XAP security management.<br>
Work with users with different roles.<br>


#### 1	Start gs-agent

1.1 Navigate to %XAP_HOME/bin <br />

1.2 Edit setenv-overrides.sh and add:<br>
    `export GS_MANAGER_OPTIONS=-Dcom.gs.manager.rest.ssl.enabled=false`<br>
    `export GS_OPTIONS_EXT=-Dcom.gs.security.enabled=true`
        
1.2 Start gs-agent with local Manager server and 4 GSCs:

    ./gs.sh host run-agent --auto --gsc=4
    
#### 2	Create GigaSpaces roles & users

1. Create 2 roles:<br>
1.1 Grid control role which controls all runtime components of the grid (create GSC, deploy pu etc.)but can't perform any operation on the space data.<br>
2.1 Data control role which can do any data operations in the space (write, read etc.) but can't touch any of the grid runtime components.<br>
2. Create 2 users:<br>
2.1 Grid control user - attach the Grid control role to this user.<br>
2.2 Data control user - attach the Data control role to this user.<br>

For the above please follow:<br>
https://docs.gigaspaces.com/latest/started/xap-tutorial-part10.html?Highlight=security%20managment#ManagingRoles

#### 3	Deploy BillBuddy_Space
    
3.1 Open %XAP_TRAINING_HOME%/xap-admin-training-lab13 project with intellij (open pom.xml) <br />
3.2 Run mvn install <br />

    ~/xap-admin-training/xap-admin-training-lab13$ mvn install
    
    
    [INFO] Reactor Summary:
    [INFO] 
    [INFO] lab13 ............................................... SUCCESS [  0.204 s]
    [INFO] BillBuddyModel ..................................... SUCCESS [  1.087 s]
    [INFO] BillBuddy_Space .................................... SUCCESS [  0.207 s]
    [INFO] BillBuddyAccountFeeder ............................. SUCCESS [  0.189 s]
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS

3.3 IntelliJ path Variables (under preferences)

###### Add GS_LOOKUP_GROUPS & GS_LOOKUP_LOCATORS

3.4 Run mvn xap:intellij

###### This will add the predefined Run Configuration Application to your Intellij IDE.

    ~/xap-admin-training/xap-admin-training-lab13$ mvn xap:intellij
    
    [INFO] lab13 ............................................... SUCCESS [  0.586 s]
    [INFO] BillBuddyModel ..................................... SKIPPED
    [INFO] BillBuddy_Space .................................... SKIPPED
    [INFO] BillBuddyAccountFeeder ............................. SKIPPED
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS

3.5 Open a new Terminal and navigate to %XAP_TRAINING_HOME%/gigaspaces-xap/bin/ <br />

    cd %XAP_HOME/bin
           
3.6 Use XAP CLI to deploy BillBuddy_Space <br>
* use Grid control user to deploy the pu.

1.  `./gs.sh --username <Grid control user> --password <Grid control password>`
2.  `pu deploy BillBuddySpace ~/xap-admin-training/xap-admin-training-lab13/BillBuddy_Space/target/BillBuddy_Space.jar` 

#### 4	Run BillBuddyAccountFeeder from Intellij

4.1 From the Intellij run configuration select BillBuddyAccountFeeder and run it.

###### This application writes Users, Merchants and Contracts to the Space
 
4.2 Validate Users and Merchants were written to the space using the web Management Console (localhost:8099). <br />
 Go to: Spaces Tab -> Data Types. <br />
 
![Screenshot](Pictures/Picture1.png)

4.3 Query the list of Users by executing the following SQL: <br />
Click the Data Type Name and the sql will be created for you: <br />

    SELECT * FROM com.gs.billbuddy.model.User WHERE rownum<5000
    
###### Note: Fully qualified class name is required.

![Screenshot](Pictures/Picture2.png)

