# xap-admin-training - lab7

# GigaSpaces Metrics

## Lab Goals

**1.** Explore GS metrics framework. <br />
**2.** Get familiar with Grafana and influxDB<br />

## Lab Description
In this lab we will focus on GigaSpaces Metrics functionalities.<br>
To better know its capabilities you will use influxDB and Grafana to close the loop of GS metrics out of the box solution..

### 1 Download and install influxDB & Grafana

#### 1.1 Choose for your convenient 1 of the following 2 options:

* influxDB regular installation:<br>
https://www.influxdata.com/get-influxdb/

* influxDB docker deployment:<br>
https://hub.docker.com/_/influxdb

#### 1.2 Create mydb database

* Follow the instructions to create mydb database:<br>
https://docs.influxdata.com/influxdb/v1.3/introduction/getting_started/

**Tip:** For docker please use the following command first:<br>
`docker exec -it <container ID> /bin/bash`

### 2 Download and install Grafana

#### 2.1 Choose for your convenient 1 of the following 2 options:

* Grafana regular installation:<br>
https://grafana.com/get

* Grafana docker deployment:<br>
https://hub.docker.com/r/grafana/grafana

#### 2.2 Verify Grafana is up and running

* Click the following link:<br>
http://localhost:3000/ <br>
See that you can login admin/admin (skip the change password page)

### 3 Activate GS metrics

* Please follow:<br>
  https://docs.gigaspaces.com/latest/admin/web-management-monitoring.html#InstallingandConfiguringGrafana

### 4 Run GS in Demo mode

    $GS_HOME/bin/gs.sh demo
    
### 5 Explore Grafana dashboards

Please explore Grafana GS dashboard and see that metrics are arriving:<br>
https://docs.gigaspaces.com/latest/admin/web-management-monitoring.html#GettingStarted

### 6 Troubleshooting:

* Sometimes there is a need to change access from server (Default) to Browser.<br><br>
![Screenshot](./Pictures/Picture1.png)

* influxDB connectivity test can be done:<br><br>
![Screenshot](./Pictures/Picture2.png)

* When using docker sometime Grafana can't be reached by the gs-webui<br><br>
![Screenshot](./Pictures/Picture3.png)

To overcome the above please use the direct link:
http://localhost:3000/

### 7 Space dashboard:

Please use the GS benchmark tool as you did in lab4 and explore Space-demo dashboard:
![Screenshot](./Pictures/Picture4.png)


      


    