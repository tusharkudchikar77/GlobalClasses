/**
* @author Tushar Kudchikar
* @date 08/26/2017
*
* @group 
* @group-content ../../ApexDocContent/ObjectIDHelper.htm
*
* @description Contains methods to resolve commonly needed IDs for RecordTypes, Queues, Users, etc.  
* 
*
*   Tag		Author				Date		Incident No.	Requested-BY		Description     
* *****************************************************************************************************************
*   1.0.0	Tushar Kudchikar		08/10/2017	N/A						                       
*
*/
public class ObjectIDHelper {

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Retrieves Recordtype Id using Object's API Name and the RecordType's Name.  
	 * Filtered to Active RecordTypes only
  	 * @param name Name of the RecordType
	 * @param objectType API name of the Object to retrieve the RecordType for.
	 * @return Id The Id of the Recordtype, or null if none was found.
 	*/	
	public static ID retrieveRecordTypeId (String name, String objectType) {
    	RecordType[] recordTypeList = [select R.Id from RecordType R where R.Name = :name and R.SObjectType = :objectType and R.isActive=true]; 
    
    	return (recordTypeList.size() > 0) ? recordTypeList[0].Id : null;    
  	}  

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Retrieves Recordtype Id using Object API Name and the RecordType's Developer Name.  
	 * Filtered to Active Recordtypes only
  	 * @param developerName Developer Name of the RecordType 
	 * @param objectType API name of the Object to retrieve the RecordType for.
	 * @return Id The Id of the Recordtype, or null if none was found.
 	*/	
  	public static ID retrieveRecordTypeIdByDName (String developerName, String objectType) {
    	RecordType[] recordTypeList = [select R.Id from RecordType R where R.DeveloperName = :developerName and R.SObjectType = :objectType and R.isActive=true]; 

    	return (recordTypeList.size() > 0) ? recordTypeList[0].Id : null;    
  	}

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Creates a map of Recordtype Ids keyed by RecordType's Developer Name for a specific object.  
	 * Filtered to Active Recordtypes only.
	 * @param objectType API name of the Object to retrieve the RecordTypes for.
	 * @return Map<String,Id> A Map containing the RecordType Ids, keyed by RecordType Developer Name.
 	*/	
	public static Map<String, Id> retrieveActiveRecordTypeIdsByObjectType_dName (String objectType) {
    	Map<String, Id> recMap = new Map<String, Id>();
        
    	for (RecordType rec : [select R.Id, R.DeveloperName from RecordType R where R.IsActive=true and R.SobjectType=:objectType]) 
      		recMap.put (rec.DeveloperName, rec.Id);
    
    	return recMap;    
  	}

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Creates a map of Recordtype Ids keyed by RecordType's Name for a specific object.  
	 * Filtered to Active Recordtypes only.
	 * @param objectType API name of the Object to retrieve the RecordType's for.
	 * @return Map<String,Id> A Map containing the RecordType Ids, keyed by RecordType Name.
 	*/	
  	public static Map<String, Id> retrieveActiveRecordTypeIdsByObjectType (String objectType) {
    	Map<String, Id> recMap = new Map<String, Id>();
    
    	for (RecordType rec : [select R.Id, R.Name from RecordType R where R.IsActive=true and R.SobjectType=:objectType])
      		recMap.put (rec.Name, rec.Id);
        
    	return recMap;    
  	}

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Retrieve's a user's Id via their alias.  If more than one user are returned for that alias, will return the first record's id.  
	 * @param alias A User's Alias.
	 * @return ID the User Id of the record found, or null.
 	*/	      
	public static ID retrieveUserIdByAlias (String alias) {
    	User[] userList = [select U.Id from User U where U.Alias = :alias]; 
    
    	return (userList.size() > 0) ? userList[0].Id : null;        
  	}  

	/**
 	 * @author Tushar Kudchikar
	 * @date 08/10/2017
	 * @description Creates a map of Queue Ids keyed by the Queue's Name for a specific object.  
	 * @param objectType API name of the Object to retrieve the Queue's for.
	 * @return Map<String,Id> A Map containing the Queue Ids, keyed by Queue Name.
 	*/	
  	public static Map<String, Id>  retrieveQueueIdsByObjectType(String objectType) {
    	Map<String, Id> queueMap = new Map<String, Id>();d
  
    	for (QueueSObject qso : [select Q.Queue.Name, Q.QueueId from QueueSObject Q where SObjectType =:objectType]) 
      		queueMap.put (qso.Queue.Name, qso.QueueId);

    	return queueMap;
  	}

}dddd
