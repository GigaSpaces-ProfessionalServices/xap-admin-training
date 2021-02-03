# xap-admin-training - lab16

# Storage Optimization

## Lab Goals

Expireance the powerful of the Storage Optimization feature <br />


## Lab Description
In this lab we will need to write 4 types of Space Objects. Each type will use a different Storage Optimization.<br/>
You will write each Space Object separately to the space and use Memory Analyzer (MAT) to measure its heap size. <br/>

### Lab Exercise
#### Requirements: <br />
###### 1. Create 4 different objects according to the following requirements: <br />

* Space id - Integer <br />
* Order Index key - String (will be filled with 1 char)<br />
* Equal and Order key - String  (will be filled with 1 char)<br />
* Ten properties - String  (will be filled with 5 chars)<br />
* Payload - String array  (will be filled with 150 chars)<br />

###### 2. Annotate the 4 Objects as follows  <br />

* The first will not have any optimization.<br>
* The second will use the Storage Types that has been introduced in version 15.2. See here: https://docs.gigaspaces.com/latest/dev-java/storage-types-controlling-serialization.html?Highlight=storage%20adapters <br/>
* The third will use the new Direct Storage Optimization that has been introduced in version 15.8. See here: https://docs.gigaspaces.com/15.8/dev-java/storage-optimization.html?Highlight=Storage%20optimization <br/>
* The fourth will use the new Sequential Storage Optimization that has been introduced in version 15.8. Same page. <br> 

###### 3. Start the Grid <br />
    ./gs.sh host run-agent --manager --gsc=1
    
###### 4. Deploy "demo" space with 1 partition (no backup) <br />   
    
###### 5. Write the first type to the space <br />

* Fill the first type with data.<br />
* Write 10K instances to the space.<br />
* Open the Ops Manager and verify that you see the entries.<br /> 

###### 6. Take heap dump <br />
* Open the Ops Manager and take the heap dump of the space.<br />
* un-deploy "demo" space 

###### 7. Analyze the heap dump <br />
* Launch the Memory Analyzer (MAT) and open the heap dump you have just created.<br />
* Verify its size.<br />
* Open OQL tab and run the following query for MyBigObjectNoStorageOpt:<br />
select * from com.gigaspaces.internal.server.storage.FlatEntryData where toString(_entryTypeDesc._typeDesc._typeName).contains("MyBigObjectNoStorageOpt") <br />
 
###### 8. Repeat steps 4-7 for each type <br />
* run the following query for MyBigObject152StorageOpt:<br /> 
select * from com.gigaspaces.internal.server.storage.FlatEntryData where toString(_entryTypeDesc._typeDesc._typeName).contains("MyBigObject152StorageOpt")

* run the following query for MyBigObject158Direct:<br /> 
select * from com.gigaspaces.internal.server.storage.HybridEntryData where toString(_entryTypeDesc._typeDesc._typeName).contains("MyBigObject158Direct")

* run the following query for MyBigObject158Sequential:<br /> 
select * from com.gigaspaces.internal.server.storage.HybridEntryData where toString(_entryTypeDesc._typeDesc._typeName).contains("MyBigObject158Sequential")


#### Solution

MyBigObjectNoStorageOpt - size 1,352 byte
![Screenshot](Pictures/Picture1.png)
![Screenshot](Pictures/Picture3.png)

MyBigObject152StorageOpt - size 936 byte
![Screenshot](Pictures/Picture4.png)
![Screenshot](Pictures/Picture6.png)

MyBigObject158Direct - size 472 byte
![Screenshot](Pictures/Picture7.png)


    * In the new HybridEntryData class it is nice to see the division between the serialized and the non-serialized properties.
    * The new Storage Optimization feature reduced the Space Object by ~60%
![Screenshot](Pictures/Picture9.png)

MyBigObject158Sequential - size 448 byte
![Screenshot](Pictures/Picture10.png)

    * In the new HybridEntryData class it is nice to see the division between the serialized and the non-serialized properties.
    * The new Storage Optimization feature reduced the Space Object by ~60%
![Screenshot](Pictures/Picture12.png)

![Screenshot](Pictures/Picture13.png)

