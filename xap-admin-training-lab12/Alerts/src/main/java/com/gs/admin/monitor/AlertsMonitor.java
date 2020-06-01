package com.gs.admin.monitor;

import org.openspaces.admin.Admin;
import org.openspaces.admin.AdminFactory;
import org.openspaces.admin.alert.Alert;
import org.openspaces.admin.alert.AlertManager;
import org.openspaces.admin.alert.config.parser.XmlAlertConfigurationParser;
import org.openspaces.admin.alert.events.AlertTriggeredEventListener;
import java.util.HashMap;
import java.util.Map;

public class AlertsMonitor {

    public AlertsMonitor() {
        System.out.println("Warning: No lookup group input, using defualt Avi_17");
        init("Avi_17");
    }

    public AlertsMonitor(String lookupgroup) {
        System.out.println("Using lookup group: " + lookupgroup);
        init(lookupgroup);
    }

    public void init(String lookupgroup) {
        System.out.println("Creating new Monitor");
        Map<String, String> environment = new HashMap<String, String>(System.getenv());
        AdminFactory factory = new AdminFactory();
        factory.addGroup(lookupgroup);
        Admin admin = factory.createAdmin();

        AlertManager alertManager = admin.getAlertManager();
        alertManager.configure(new XmlAlertConfigurationParser(environment.get("XAPHOMEDIR")+"/config/alerts/alerts.xml").parse());

        alertManager.getAlertTriggered().add(new AlertTriggeredEventListener() {

            @Override
            public void alertTriggered(Alert alert) {
                System.out.println("I am Getting a Picked up Alert");
                System.out.println(alert.toString());
            }


        });

        System.out.println("Activating monitoring Thread");
        Thread t = new Thread(new AlertsMonitorThread());
        t.start();
        System.out.println("Creating new Monitor is done");
    }


    // Thread class in charge of creating a payment every second
    private class AlertsMonitorThread implements Runnable {
        private long defaultDelay = 3000;

        public void run() {
            try {
                System.out.println("Alert Monitoring thread has start");
                while (true) {
                    Thread.sleep(defaultDelay);
                    System.out.println("Alert Monitoring thread alive");
                }
            } catch (InterruptedException e) {
                System.out.println("Alert Monitoring thread has failed");
            }
        }
    }
}
