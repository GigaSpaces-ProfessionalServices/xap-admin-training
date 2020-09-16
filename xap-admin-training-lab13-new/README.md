# xap-admin-training - lab13 - new

# Grid & Data Security

## Lab Goals

1. User Password Encryption <br />
2. Write to a secured Space which deployed to a secured Grid <br />

## Lab Description
In this lab we will focus on secured Grid/Space deployment.<br>
Authority and Authorization using XAP security management.<br>
Work with users with different roles.<br>

### User password encryption - Lab Exercise 1
#### Requirements: <br />
1. Edit the security-config.xml file <br />
2. encrypt and write the passwords for “gs-admin”, “gs-mngr” and “gs-viewer” <br /> 
3. use org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder <br />
4. Verify that you can login through the Ops Manager 

#### Solution


![Screenshot](Pictures/Picture1.png)

![Screenshot](Pictures/Picture2.png)

### Writing to a Secured Space - Lab Exercise 2
#### Requirements: <br />
1. Write a PU contains: <br />
    a) a secured embedded space configured in the pu.xml (use plain text for the user/password) <br />
    b) a Spring Bean for the Feeder <br />
       the Feeder will have 2 methods: <br />
            public GigaSpace gigaSpaceProxy() - for connecting to the secured space <br />
            public void afterPropertiesSet() - for writing data <br />
    

#### Questions <br />
1. What user will you use? <br />
2. What privileges this user should have?

#### Solution

##### 1. Edit the security-config.xml file and add SPACE_WRITE to user gs-admin

![Screenshot](Pictures/Picture3.png)

##### 2. Start the grid

        ./gs.sh host run-agent --manager
        
        
        
##### 3. Deploy the PU with the embedded space

        ./gs.sh --username gs-admin --password gs-admin pu deploy SecuredSpace ../SecuredSpace/target/SecuredSpace-1.0-SNAPSHOT.jar

##### 4. Verify that the Feeder has been succeeded to connect to the secured space and write the data

![Screenshot](Pictures/Picture4.png)
