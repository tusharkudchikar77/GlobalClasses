/**
* @author Tushar Kudchikar 
* @date 04/19/2019
*
* @group ITSDnBCompany
* @group-content ../../ApexDocContent/ITSDnBCompanyTriggerHelper.htm
*
* @description Trigger helper class for ITSDnBCompanyTriggerHelper class
* Change History
*
*   Tag         Author              Date         Incident No.   Requested-BY      Description     
* ******************************************************************************************************************************
*   1.0.0       Tushar Kudchikar    04/19/2019   N/A            Mike Mullaney     DandBCompany trigger helper class
*
*/
public without sharing class ITSDnBCompanyTriggerHelper {
    
    /*
* @description helper method for after update trigger.
* @param oldDandBCompanyMap, newDandBCompanyMap
* @return   
*/    
    public static void handleAfterUpdate(Map<ID, DandBCompany> oldDandBCompanyMap, Map<ID, DandBCompany> newDandBCompanyMap) {
        
        Set<String> globalDUNSIdSet = new Set<String>();
        List<account> accountupdateList = new List<account>();
        Map<String,String> oldDandBGDUNSMap = new Map<String,String>();
        Map<String,String> newDandBGDUNSMap = new Map<String,String>();
        Map<String,String> parentIdMap = new Map<String,String>();
        
        for(Id dandbRecordId : newDandBCompanyMap.keySet()) {
            if(oldDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber != newDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber) {
                oldDandBGDUNSMap.put(oldDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber,newDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber);
                newDandBGDUNSMap.put(newDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber,dandbRecordId);
                globalDUNSIdSet.add(oldDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber);
                globalDUNSIdSet.add(newDandBCompanyMap.get(dandbRecordId).GlobalUltimateDunsNumber);
            }
        }
        
        // To query and capture the account details
        Map<Id,account> accountDetailMap = new Map<Id,account>([Select  Id,
                                                                Parentid,
                                                                GU_DUNSNumber__c,
                                                                NU_Id__c,
                                                                DandbcompanyId
                                                                From Account
                                                                Where GU_DUNSNumber__c IN: globalDUNSIdSet and 
                                                                recordtype.name=:NEUAccountConstants.ORGANIZATION_RT_DNAME]);
        
        if(accountDetailMap.size() > 0)
        {
            
            // To get the Parent record Id & Global DUNS Number
            for(account a : accountDetailMap.values()) {
                if(newDandBGDUNSMap.keyset().contains(a.GU_DUNSNumber__c) && a.parentid == null && a.NU_Id__c != '') {
                    parentIdMap.put(a.GU_DUNSNumber__c,a.Id);
                }
            }
            
            // To update the Parent record Id & Global DUNS Number for child account  
            for(account a : accountDetailMap.values()) {
                if(oldDandBGDUNSMap.keyset().contains(a.GU_DUNSNumber__c)) {
                    a.Parentid = parentIdMap.get(oldDandBGDUNSMap.get( a.GU_DUNSNumber__c));
                    a.GU_DUNSNumber__c = oldDandBGDUNSMap.get(a.GU_DUNSNumber__c);  
                    a.DandbcompanyId = null;
                    accountupdateList.add(a);
                }
            }
            
            update accountupdateList;
        }
    }    
}