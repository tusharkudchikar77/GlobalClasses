/**
* @author Tushar Kudchikar
* @date 08/30/2017 
*
* @group NEU
* @group-content ../../ApexDocContent/PicklistHelper.htm
*
* @description Contains helper methods for working with Picklists, including methods to 
* convert multivalue picklists to Lists, add values, delete values, check to see if a multi value
* picklist has a particular value, etc.
* Change History
*
*   Tag		Author				Date		Incident No.	Requested-BY		Description     
* *****************************************************************************************************************
*   1.0.0	Tushar Kudchikar		08/30/2017	N/A					
*/
public class PicklistHelper {
	
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Adds a value to packed string representing a multivalue picklist,after first making sure
	 * it is not already present.
 	 * @param currentPickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param newValue String representation of the value to be added to the multi-value picklist
	 * @return String representation of the updated multivalue picklist, values separated by ; 
 	*/
  	public static String addValue (String currentPickList, String newValue) {
    	// No new value.
    	if (newValue == null)
      		return currentPickList;
		
		Set<String> picklistSet = explodeToSet(currentPickList);
		if (!picklistSet.contains(newValue)) {
			picklistSet.add(newValue);
			return implodeFromSet(picklistSet);
		} else // Already in list.
			return currentPicklist; 	
  	}
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Adds values contained in a Set to packed string representing a multivalue picklist.  Each value is represented in the packed String only once.
 	 * @param currentPickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param newValuesSet Set<String> representation of the values to be added to the multi-value picklist
	 * @return String representation of the updated multivalue picklist, values separated by ; 
 	*/
  	public static String addValues (String currentPickList, Set<String> newValuesSet) {
  		// No new value(s).
  		if ((newValuesSet == null) || (newValuesSet.size() < 1))
  			return currentPickList;
  			
  		Set<String> picklistSet = explodeToSet(currentPickList);
  		picklistSet.addAll(newValuesSet);
  		
  		return implodeFromSet(picklistSet);
  	}
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Determines whether a specific value is present in the packed multi-value picklist.
 	 * @param pckList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param value String representation of the value to be checked for.
	 * @return Boolean true if the value is part of the list.  false, otherwise.
 	 */
  	public static boolean containsValue (String pickList, String value) {    
    	return explodeToSet(picklist).contains (value);
  	} 
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Determines whether any of the values in the set are present in the packed multi-value picklist.
 	 * @param pckList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param value Set<String> containing the values to check for.
	 * @return Boolean true if any of the values in the set are part of the list.  false, otherwise.
 	 */
  	public static boolean containsAnyValues (String pickList, Set<String> valueSet) {
  		Set<String> picklistSet = explodeToSet(picklist);
  		
  		if (valueSet == null)
  			return false;
  			
  		for (String value : valueSet) {
  			if (picklistSet.contains(value))
  				return true;
  		}
			
		return false;
  	}
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Removes a value from packed string representing a multivalue picklist, after first making sure
	 * it is present.  All values matching delValue are removed.
 	 * @param currentPickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param deleteValue String representation of the value to be removed from the multi-value picklist
	 * @return String representation of the updated multivalue picklist, values separated by ; 
 	*/
  	public static String deleteValue (String currentPickList, String deleteValue) {
    	// No delete value
    	if (deleteValue == null)
      		return currentPickList;
  
  		Set<String> picklistSet = explodeToSet(currentPickList);
		if (picklistSet.contains(deleteValue)) {
			picklistSet.remove(deleteValue);
			return implodeFromSet(picklistSet);
		} else // Not in list.
			return currentPicklist; 	  		
  	}
  	
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Returns true if the picklists have the same values, and false otherwise.
 	 * @param pickList1 String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param pickList2 String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;	 
 	 * @return Boolean true if both picklists have the same values, and false otherwise.
 	*/
  	public static boolean arePicklistsEqual (String picklist1, String picklist2) {
  		Set<String> pl1Set = explodeToSet(picklist1);
  		Set<String> pl2Set = explodeToSet(picklist2);
  		
  		return pl1Set.equals(pl2Set);
  	}
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Removes a Set of values from packed string representing a multivalue picklist.
	 *  All values in the deleteValuesSet that are in the picklist are removed.
 	 * @param currentPickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @param deleteValuesSet Set<String> representation of the set of values to be removed from the multi-value picklist
	 * @return String representation of the updated multivalue picklist, values separated by ; 
 	*/
	public static String deleteValues (String currentPickList, Set<String> deleteValuesSet) {
		// No delete values
		if ((deleteValuesSet == null) || (deleteValuesSet.size() < 1))
			return currentPickList;
			
		Set<String> picklistSet = explodeToSet(currentPickList);
		picklistSet.removeAll(deleteValuesSet);
		
		return implodeFromSet(picklistSet);
	}
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Converts packed multi-value picklist into a list of values.
 	 * @param pickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
	 * @return String[] String array representation of the multivalue picklist, with each value present in a separate array entry. 
 	*/
  	public static String[] explode (String pickList) {
    	if (pickList == null)
      		return new String[0];
    	else {
      		String[] pickArr = pickList.split(';');
      
      		Integer idx = 0;
      
      		while (idx < pickArr.size()) {
      
        		if ((pickArr[idx] == null) || (pickArr[idx].trim().length() < 1))
          			pickArr.remove (idx);
        		else
          			idx++;              
      		}
      
      		return pickArr;
    	}                
  	} 
  
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Converts packed multi-value picklist into a Set of values.
 	 * @param pickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
	 * @return Set<String> Set of Strings representing all the values in the multivalue picklist, with each value present as a separate entry in the set. 
 	*/
  	public static Set<String> explodeToSet (String pickList) {
  		
  		Set<String> picklistSet = new Set<String>();
  		picklistSet.addAll(explode(picklist));
  		
  		return (picklistSet);
  	}
  	
  	
  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Converts a String Array into a Packed String, separating values by a ;
 	 * @param pickArr String[] Array of picklist values
	 * @return String Packed String representation of the multivalue picklist, with each value separated by a ;. 
 	*/
  	public static String implode (String[] pickArr) {
    	if ((pickArr == null) || (pickArr.size() < 1))
      		return null;
    	else {
      		boolean containsEntries = false;
      		String pickList = null;
      		for (Integer i=0; i < pickArr.size(); i++) {
        		if ((pickArr[i] != null) && (pickArr[i].trim().length() > 0)) {
        			if (!containsEntries) {  
          				pickList = pickArr[i];
          				containsEntries = true;
        			} else
          				pickList = pickList + ';' + pickArr[i];   
        		}
      		}   
      		return pickList;
    	}  
  	}

  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Converts a Set<String> into a Packed String, separating values by a ;
 	 * @param pickArr Set<String> of picklist values
	 * @return String Packed String representation of the multivalue picklist, with each value separated by a ;. 
 	*/
  	public static String implodeFromSet (Set<String> pickValSet) {
    	if ((pickValSet == null) || (pickValSet.size() < 1))
      		return null;
    	else {
      		boolean containsEntries = false;
      		String pickList = null;
			for (String pickVal : pickValSet) {
        		if ((pickVal != null) && (pickVal.trim().length() > 0)) {
        			if (!containsEntries) {  
          				pickList = pickVal;
          				containsEntries = true;
        			} else
          				pickList = pickList + ';' + pickVal;   				
        		}
			}
      		return pickList;
    	}  
  	}


  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Counts the number of values present in a multi-value picklist.
 	 * @param pickList String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
	 * @return Integer count of entries present in the picklist. 
 	*/
  	public static Integer countEntries (String pickList) {
    
    	return explode (pickList).size();
  	}

  	/**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Gets a list of Picklist values from the specified SbjectField.
 	 * @param picklistField SObjectField to extract Picklist values from.
	 * @return List<String> containing all the possible picklist values.
 	*/
  	public static List<String> getPicklistValues(Schema.sObjectField picklistField) {
    	List<String> pickVals = new List<String>();
      	List<Schema.PicklistEntry> picklistEntries =  picklistField.getDescribe().getPicklistValues();
      	for(Schema.PicklistEntry anEntry: picklistEntries) {
     		pickVals.add(anEntry.getValue());      
    	}  
    	return pickVals;
   	}  
    
    /**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Finds the first position in the picklistValues array which matches the desired picklist value .
 	 * @param picklistValues The list of possible picklist values.
 	 * @param picklist
	 * @return Integer index (starting at 0) of the first item in the list matching the picklistValue, or null if none were found. 
 	*/
    public static Integer getIndex(List<String> picklistList, String picklistValue) {
    	if ((picklistList != null) && (picklistValue != null)) {    		
    		for (Integer i=0; i < picklistList.size(); i++) { 
      			if (picklistValue.equals(picklistList[i]))
        			return i;
    		}
    	}
    	
    	return null;
  	}
  
    /**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Finds the first position in the picklistEntry List which matches the desired picklist value .
 	 * @param picklistEntryList The list of possible picklist values (of type List<Schema.PicklistEntry>)
 	 * @param picklistValue String value to search for.
	 * @return Integer index (starting at 0) of the first item in the list matching the picklistValue, or null if none were found. 
 	*/
  	public static Integer getIndex(List<Schema.PicklistEntry> picklistEntryList, String picklistValue) {
    	if ((picklistEntryList != null) && (picklistValue != null)) {    		
    		for (Integer i=0; i < picklistEntryList.size(); i++) {
	      		if(picklistEntryList[i].getValue().equals(picklistValue))
    	    		return i;
      		}
    	}
    	return null;
  	}
  
    /**
 	 * @author Tushar Kudchikar
	 * @date 08/30/2017
	 * @description Combines two string representations of multi value picklists into a single list, with no repeating values.
 	 * @param picklist1  String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
  	 * @param picklist2  String value representing the packed form of the multi-value picklist.  Each value in the 
 	 * picklist is separated by a ;
 	 * @return String representation of the two multivalue picklists combined into a single list. 
 	*/
  	public static String mergePicklists(String picklist1, String picklist2) {
    
    	String[] pl1Arr = explode(picklist1);
    	String[] pl2Arr = explode(picklist2);
    
    	Set<String> plSet = new Set<String>();
    	
    	plSet.addAll(pl1Arr);
    	plSet.addAll(pl2Arr);
    
    	return implodeFromSet(plSet);    	
  	}
  
}
