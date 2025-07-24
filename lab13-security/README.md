# lab13-gs_admin_training

# Grid Security

## Lab Goals

1. Experience secured pu deployment process.
2. Get familiar with GigaSpaces authority and authorization.

## Lab Description
* In this lab we will focus on secured pu deployment.
* Authority and Authorization using GS security management.
* Work with users with different roles.

#### 1	Start gs-agent

1.1 Navigate to the GigaSpaces installation home/bin/
`cd $GS_HOME/bin`

1.2 Edit setenv-overrides.sh and add:

```
export GS_MANAGER_OPTIONS="-Dcom.gs.manager.rest.ssl.enabled=false "
export GS_OPTIONS_EXT="-Dcom.gs.security.enabled=true "
```

1.3 Start gs-agent with local Manager server and 4 GSCs:
```
./gs.sh host run-agent --auto --gsc=4
```

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
    
3.1 Open %GS_ADMIN_TRAINING_HOME%/lab13-gs_admin_training project with Intellij (open pom.xml) <br />
3.2 Run mvn install <br />

    ~/gs-admin-training/lab13-gs_admin_training$ mvn install
    
    
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

3.4 Copy the runConfigurations directory to the Intellij .idea directory to enable the Java Application configurations. Restart Intellij.
```
cd gs-admin-tranining/lab13-gs_admin_training
cp -r runConfigurations .idea/
```

3.5 Open a new Terminal and navigate to the GigaSpaces installation home/bin/
```
cd $GS_HOME/bin
```
3.6 Use gs CLI to deploy BillBuddy_Space <br>
* use Grid control user to deploy the pu.

1.  `./gs.sh --username <Grid control user> --password <Grid control password>`
2.  `pu deploy BillBuddySpace ~/gs-admin-training/lab13-gs_admin_training/BillBuddy_Space/target/BillBuddy_Space.jar` 

#### 4	Run BillBuddyAccountFeeder from Intellij

4.1 From the Intellij select configuration BillBuddyAccountFeeder and run it.

###### This application writes Users, Merchants and Contracts to the Space
 
4.2 Validate Users and Merchants were written to the space using the web Management Console (localhost:8099). <br />
 Go to: Spaces Tab -> Data Types. <br />
 
![Screenshot](Pictures/Picture1.png)

4.3 Query the list of Users by executing the following SQL: <br />
Click the Data Type Name and the sql will be created for you: <br />

    SELECT * FROM com.gs.billbuddy.model.User WHERE rownum<5000
    
###### Note: Fully qualified class name is required.

![Screenshot](Pictures/Picture2.png)

