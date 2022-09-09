# ODSX Lab-B

## Lab Summary
   
     1. Tiered Storage
        1.1 Build jar (This jar will be deployed as tiered storage)
        1.2 Deploy
        1.3 Update cache policy
        1.4 List
        1.5 Undeploy
        
### 1. Tiered Storage (MENU -> TIEREDSTORAGE)
    
   - Detailed explaination : https://docs.gigaspaces.com/latest/admin/intelligent-tiering-details.html?Highlight=tiered%20storage
    
#### 1.1 Build jar
    
- Build jar : https://github.com/GigaSpaces-ProfessionalServices/CSM-Magic-Tools/tree/master/Bi_Optional_pu  
  - Check out project and build jar

tapan@tapan-laptop:~/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu$ mvn clean install
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$1 (file:/usr/share/maven/lib/guice.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$1
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
[INFO] Scanning for projects...
[INFO] 
[INFO] ---------------------< com.gs.bll:bi_optional_pu >----------------------
[INFO] Building bi_optional_pu 0.1
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ bi_optional_pu ---
[INFO] Deleting /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ bi_optional_pu ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 5 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ bi_optional_pu ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target/classes
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ bi_optional_pu ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ bi_optional_pu ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 1 source file to /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target/test-classes
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ bi_optional_pu ---
[INFO] Surefire report directory: /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target/surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------

Results :

Tests run: 0, Failures: 0, Errors: 0, Skipped: 0

[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ bi_optional_pu ---
[INFO] Building jar: /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target/bi_optional_pu-0.1.jar
[INFO] 
[INFO] --- maven-install-plugin:2.4:install (default-install) @ bi_optional_pu ---
[INFO] Installing /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/target/bi_optional_pu-0.1.jar to /home/tapan/.m2/repository/com/gs/bll/bi_optional_pu/0.1/bi_optional_pu-0.1.jar
[INFO] Installing /home/tapan/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu/pom.xml to /home/tapan/.m2/repository/com/gs/bll/bi_optional_pu/0.1/bi_optional_pu-0.1.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.298 s
[INFO] Finished at: 2022-09-09T07:20:26+05:30
[INFO] ------------------------------------------------------------------------
tapan@tapan-laptop:~/Gigaspace/Bank_Leumi/GS_Aharon/CSM/CSM-Magic-Tools/Bi_Optional_pu$    

#### 1.2 Deploy
  - Specify source path of this jar at time of Deploy Step
  - It will provide you an option for to create GSC
  - You can specify zone, number of partitions, space property at time of deployment

 - Run odsx -> Go to Tiered Storage
 
 ![Screenshot](./pictures/odsx_sox_tieredstorage_install_1.png)
 - Jar deployment should be successfull. 
 ![Screenshot](./pictures/odsx_sox_tieredstorage_install_2.png)
 - Verify it on broser old UI
 ![Screenshot](./pictures/odsx_sox_tieredstorage_install_3.png)
 - Verify it on browser OPS manager
 - Space deployed as Tiered Storage
 - Default criteria should be visible in configuration
 ![Screenshot](./pictures/odsx_sox_tieredstorage_install_4.png) 

#### Start Feeder
 - Go to any manager machine and start feeder to feed data inot objects
 - Or you can deploy feeder as pu by OPS manager or CLI
 
 - By default it will loaded with default criteria file TieredCriteria.tab
 - Verify the deployment on OPS manager
 
  ![Screenshot](./pictures/odsx_sox_tieredstorage_feeder.png)  
 
 #### 1.3 Update Cache Policy
 
  - Modify your criteria / space property required to update from source file
  - Select space which you want to apply udpdate cache policy
  - One can select individual couple partition or all available partitions
    - It will restart backup from couple 
    - Once backup partition restarted it will wait for space to become healthy
 
     ![Screenshot](./pictures/odsx_sox_tieredstorage_criteria_updated.png)
     
     
 
  - This step will demote the selected couple partition
  - After completion of update cache policy Go to OPS manager and see the updated criteria on overview
     
   ![Screenshot](./pictures/odsx_sox_tieredstorage_updatepolicy.png)
   
   ![Screenshot](./pictures/odsx_sox_tieredstorage_updatepolicy_comp.png)
 
   - You can observe after changing the TieredCriteria.tab file based on updated criteria data feeded without downtime of space
 
   ![Screenshot](./pictures/odsx_sox_tieredstorage_updatepolicy_ui.png)
 
 #### 1.4 List
   - Verify it on odsx
   - ![Screenshot](./pictures/odsx_sox_tieredstorage_list.png)
  
 
 #### 1.5 Undeploy
 
 - It will list all available spaces on cluster
 - You can remove / undeploy either one or all available spaces from cluster 
 
     ![Screenshot](./pictures/odsx_sox_tieredstorage_undeploy.png)
 