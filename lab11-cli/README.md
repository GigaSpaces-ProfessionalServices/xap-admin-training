# xap-admin-training - lab11

# GigaSpaces Command Line Interface

## Lab Goals

**1.** Explore from close GigaSpaces Command Line Interface <br />
**2.** Get familiar with GigaSpaces Command Line Interface capabilities<br />

## Lab Description
In this lab we will focus on GigaSpaces Command Line Interface.<br>
To better know its capabilities you will use GigaSpaces Command Line Interface for your convenience.

### 1 GigaSpaces Command Line Interface

Please perform the following steps:<br>

1. Run the grid without any GSC (only GS manager).<br>
2. Raise 6 GSC as following:<br>
    <b>2.1</b> 4 with zone statefull<br>
    <b>2.2</b> 2 with zone stateless<br>
3. Deploy BillBuddySpace on the 4 GSC with zone statefull, use the jar from lab5:<br>
   `~/xap-admin-training/xap-admin-training-lab5/BillBuddy_Space/target/BillBuddy_Space.jar` <br>
4. Deploy 2 instances of BillBuddyWebApplication, both instances should be located on 2 GSC of zone stateless<br>
   Use the war from lab5:<br>
   `~/xap-admin-training/xap-admin-training-lab5/BillBuddyWebApplication/target/BillBuddyWebApplication.war` <br>

**Note:** Please perform sections 1-4 **only** by using **GigaSpaces CLI**.<br><br>

Once done please use GigaSpaces Web Management Console (Web UI) to verify the outcome:<br><br>
![Screenshot](./Pictures/Picture1.png)
    





   