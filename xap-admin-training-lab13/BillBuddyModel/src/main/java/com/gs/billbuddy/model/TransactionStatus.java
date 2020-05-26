package com.gs.billbuddy.model;

/** 
* TransactionStatus class is an Enum which indicate transaction status
* between user and merchant or between merchant to BillBuddy 
* 
* @author 123Completed
*/
public enum TransactionStatus {NEW,
	AUDITED,
    OPEN,
    CLOSED,
    CANCELLED,
    PROCESSED;
}
