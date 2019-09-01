/**
* @author Tushar Kudchikar
* @date 08/26/2017
*
* @group NEU
* @group-content ../../ApexDocContent/ObjectIDHelperTest.htm
*
* @description Contains tests for ObjectIDHelper.cls
*  
* Change History
*
*   Tag		Author				Date		Incident No.	Requested-BY		Description     
* *****************************************************************************************************************
*   1.0.0	Tushar Kudchikar		08/26/2017	N/A				                      
*
*/
@isTest
private class ObjectIDHelperTest {
 	TestMethod static void testRetrieveRecordTypeId () {
    	RecordType aRecTy = [select R.ID, R.Name, R.DeveloperName, R.SobjectType from RecordType R where R.IsActive=true limit 1];
      
    	System.assertEquals (aRecTy.Id, ObjectIDHelper.retrieveRecordTypeId (aRecTy.Name, aRecTy.SObjectType), 'retrieveRecordTypeId('+aRecTy.Name+', '+aRecTy.SObjectType+')');
    	System.assertEquals (aRecTy.Id, ObjectIDHelper.retrieveRecordTypeIdByDName(aRecTy.DeveloperName, aRecTy.SObjectType), 'retrieveRecordTypeIdByDName(' + aRecTy.DeveloperName + ', ' + aRecTy.SObjectType+')');
    	System.assertEquals (null, ObjectIDHelper.retrieveRecordTypeId (null, null), 'retrieveRecordTypeId(null, null)');   
    	System.assertEquals (null, ObjectIDHelper.retrieveRecordTypeIdByDName(null, null), 'retrieveRecordTypeIdByDName(null, null)');
  	}

  	TestMethod static void testRetrieveUserIdByAlias () {
    	User aUsr = [select U.ID, U.Alias from User U limit 1];
    
	    System.assertNotEquals (null, aUsr, 'aUsr');
      
    	Id retId = ObjectIDHelper.retrieveUserIdByAlias (aUsr.Alias);
    	
    	User rUsr = [Select U.Id, U.Alias from User U where U.Id = :retId limit 1];
      
    	System.assertEquals (aUsr.alias, rUsr.alias, 'retrieveUserIdByAlias('+aUsr.Alias+')');
    	System.assertEquals (null, ObjectIDHelper.retrieveUserIdByAlias (null), 'retrieveUserIdByAlias(null)');
	}    

  	TestMethod static void testRetrieveActiveRecordTypeIdsByObjectType() {
    
    	RecordType recTst = [select R.Id, R.Name, R.SobjectType from RecordType R where R.IsActive=true LIMIT 1];
        
    	Map<String, Id> recMap = ObjectIDHelper.retrieveActiveRecordTypeIdsByObjectType (recTst.SobjectType);
    
    	Integer i = [select count() from RecordType R where R.SObjectType=:recTst.SobjectType and R.IsActive=true]; 
    
    	System.assertNotEquals(null, recMap, 'recMap is not null');
    	System.assertEquals (i, recMap.size(), 'recMap should contain the same number of entries as active recordtypes');
    	System.assertEquals (recTst.Id, recMap.get(recTst.Name), 'recMap.get('+recTst.Name+')'); 
  	}

  	TestMethod static void testRetrieveActiveRecordTypeIdsByObjectType_dName() {
    
    	RecordType recTst = [select R.Id, R.Name, R.DeveloperName, R.SobjectType from RecordType R where R.IsActive=true LIMIT 1];
        
    	Map<String, Id> recMap = ObjectIDHelper.retrieveActiveRecordTypeIdsByObjectType_dName (recTst.SobjectType);
    
    	Integer i = [select count() from RecordType R where R.SObjectType=:recTst.SobjectType and R.IsActive=true]; 
    
    	System.assertNotEquals(null, recMap, 'recMap is not null');
    	System.assertEquals (i, recMap.size(), 'recMap should contain the same number of entries as active recordtypes');
    	System.assertEquals (recTst.Id, recMap.get(recTst.DeveloperName), 'recMap.get('+recTst.DeveloperName+')'); 
  	}
  	
  	TestMethod static void testRetrieveQueueIdsByObjectType() {
    	QueueSObject[] qsoArr = [select Q.QueueId, Q.Queue.Name, Q.SObjectType from QueueSObject Q LIMIT 1];
    
    	if (qsoArr.size() > 0) { //Reliant on the first queue being created before executing.
      		Map<String, Id> tqIMap = ObjectIDHelper.retrieveQueueIdsByObjectType(qsoArr[0].SObjectType);
      		System.assertEquals (qsoArr[0].QueueId, tqiMap.get(qsoArr[0].Queue.Name), 'ID returned from map should be same as in select statement' );
    	} else { // If no queues created, will execute this, confirm none are returned.
      		Map<String, Id> tqIMap = ObjectIDHelper.retrieveQueueIdsByObjectType('User');
      		System.assertEquals (0, tqIMap.size(), 'Should be no entries');    		
    	}
        
  	}
  	

}