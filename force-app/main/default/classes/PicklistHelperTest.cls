/**
* @author Tushar Kudchikar
* @date 08/30/2017
*
* @group NEU
* @group-content ../../ApexDocContent/PicklistHelperTest.htm
*
* @description Contains tests for PicklistHelper.cls
*  
* Change History
*
*   Tag		Author				Date		Incident No.	Requested-BY		Description     
* *****************************************************************************************************************
*   1.0.0	Tushar Kudchikar		08/30/2017	N/A				                      
* 	
*/
@isTest
private class PicklistHelperTest {
	
	TestMethod static void testAddValue() {
	    System.debug ('testing PicklistHelper.addValue()...');
	    String[] curPicklistArr =   new String[] {'value1;value2',      	null,  'value1;value2',  	null};
    	String[] addListArr =     	new String[] {'value3',          		null,  'value1',      		'value1'};
    	String[] expectedValueAdd = new String[] {'value1;value2;value3',   null,   'value1;value2',   	'value1'};
    	for (Integer i = 0; i < curPicklistArr.size(); i++) {
      		System.debug ('PicklistHelper.addValue(\'' + curPicklistArr[i] + '\', \'' + addListArr[i] + '\')'); 
      		System.assertEquals (expectedValueAdd[i], PicklistHelper.addValue (curPicklistArr[i], addListArr[i]), 'PicklistHelper.addValue result unexpected.');  
    	}
	}

	TestMethod static void testAddValues() {
	    System.debug ('testing PicklistHelper.addValues()...');
	    String[] curPicklistArr =   		new String[] {			'value1;value2',      					null,  	'value1;value2',  				null};
    	List<Set<String>> addListArr =     	new List<Set<String>> {	new Set<String> {'value3', 'value4' },  null,  	new Set<String> { 'value1' },  	new Set<String> {'value1' } };
    	String[] expectedValueAdd = 		new String[] 		  {	'value1;value2;value3;value4',   		null,   'value1;value2',   				'value1'};
    	for (Integer i = 0; i < curPicklistArr.size(); i++) {
      		System.debug ('PicklistHelper.addValues(\'' + curPicklistArr[i] + '\', \'' + addListArr[i] + '\')'); 
      		System.assertEquals (expectedValueAdd[i], PicklistHelper.addValues (curPicklistArr[i], addListArr[i]), 'PicklistHelper.addValues result unexpected.');  
    	}
	}

	
	TestMethod static void testContainsValue() {
		System.debug ('testing PicklistHelper.containsValue()...');
		String curPicklist = 'value1;value2;value3';
		String[] containsValueArr = 			new String[] { null, 	'value1', 	'value2', 	'value3', 	'value4' };
		Boolean[] expectedContainsResultArr = 	new Boolean[] { false,	true,		true,		true,		false};
		
		for (Integer i=0; i < containsValueArr.size(); i++) {
      		System.debug ('PicklistHelper.containsValue(\'' + curPicklist + '\', \'' + containsValueArr[i] + '\')'); 
			System.assertEquals (expectedContainsResultArr[i], 
								 PicklistHelper.containsValue (curPicklist, containsValueArr[i]),
								 'PicklistHelper.containsValue result unexpected)');
		}
	}

	TestMethod static void testContainsAnyValues() {
		System.debug ('testing PicklistHelper.containsAnyValues()...');
		String curPicklist = 'value1;value2;value3';
		List<Set<String>> containsAnyValueArr = 			new List<Set<String>> { null, 	new Set<String> { 'value1' }, 	new Set<String> { 'value2' }, 	new Set<String> { 'value3' }, 	new Set<String> { 'value4' }, 	new Set<String> { 'value1', 'value5' }, new Set<String> { 'value4', 'value5' } };
		Boolean[] expectedContainsResultArr = 	new Boolean[] { 					false,	true,							true,							true,							false, 							true,									false};
		
		for (Integer i=0; i < containsAnyValueArr.size(); i++) {
      		System.debug ('PicklistHelper.containsAnyValues(\'' + curPicklist + '\', \'' + containsAnyValueArr[i] + '\')'); 
			System.assertEquals (expectedContainsResultArr[i], 
								 PicklistHelper.containsAnyValues (curPicklist, containsAnyValueArr[i]),
								 'PicklistHelper.containsAnyValues result unexpected)');
		}
	}


	TestMethod static void testDeleteValue() {
		System.debug ('testing PicklistHelper.deleteValue()...');
	    String[] curPicklistArr =   new String[] {'value1;value2',      null,  	'value1;value2',  	null};
	    String[] delListArr =     	new String[] {'value1',         	null,   'value3',       	'value1'};
	    String[] expectedValueDel = new String[] {'value2',         	null,   'value1;value2',   	null};    
	    for (Integer i = 0; i < curPicklistArr.size(); i++) {
	      System.debug ('PicklistHelper.deleteValue(\'' + curPicklistArr[i] + '\', \'' + delListArr[i] + '\')');
	      System.assertEquals (expectedValueDel[i], PicklistHelper.deleteValue (curPicklistArr[i], delListArr[i]), 'PicklistHelper.delValue result unexpected.');
	    }		
	}

	TestMethod static void testDeleteValues() {
		System.debug ('testing PicklistHelper.deleteValues()...');
	    List<String> curPicklistList =  new List<String> 		{ 'value1;value2',      		null,  	'value1;value2',  				null, 						'value1;value2', 						'value1;value2', 						'value1;value2' };
	    List<Set<String>> testList =    new List<Set<String>> 	{ new Set<String> { 'value1' }, null,   new Set<String> { 'value3' },   new Set<String> {'value1'}, new Set<String> { 'value1', 'value2' },	new Set<String> {'value1', 'value3' },	new Set<String> { 'value3', 'value4' } };
	    List<String> resultList = 		new List<String> 		{ 'value2',         			null,   'value1;value2',   				null,						null,										'value2',								'value1;value2' };    
	    for (Integer i = 0; i < curPicklistList.size(); i++) {
	      System.debug ('PicklistHelper.deleteValues(\'' + curPicklistList[i] + '\', \'' + testList[i] + '\')');
	      System.assertEquals (resultList[i], PicklistHelper.deleteValues (curPicklistList[i], testList[i]), 'PicklistHelper.deleteValues result unexpected.');
	    }		
	}

	TestMethod static void testExplode() {
    	System.debug ('testing PicklistHelper.explode()...');
    	String[] explodeListArr = new String[] { null, 'value1', 'value1;value2' };
    	Integer[] sizeExplodeListArr = new Integer[] { 0, 1, 2 };
    
    	for (Integer i = 0; i < explodeListArr.size(); i++) {
      		System.assertEquals(sizeExplodeListArr[i], PicklistHelper.explode (explodeListArr[i]).size(), 'PicklistHelper.explode \'' + explodeListArr[i] + '\') Size of Array incorrect');
    	}    		
	}
	TestMethod static void testExplodeToSet() {
    	System.debug ('testing PicklistHelper.explodeToSet()...');
    	String[] explodeListArr = new String[] { null, 'value1', 'value1;value2' };
    	Integer[] sizeExplodeListArr = new Integer[] { 0, 1, 2 };
    
    	for (Integer i = 0; i < explodeListArr.size(); i++) {
      		System.assertEquals(sizeExplodeListArr[i], PicklistHelper.explodeToSet (explodeListArr[i]).size(), 'PicklistHelper.explodeToSet \'' + explodeListArr[i] + '\') Size of Array incorrect');
    	}    		
	}	
	
	TestMethod static void testImplode() {
    	System.debug ('testing PicklistHelper.implode()...');
    	String[] implodeArr = new String[] {null, 'value1', ' ', 'value2', 'value3' };
    	String expectedImplodeValue = 'value1;value2;value3';
        
    	System.assertEquals(expectedImplodeValue, PicklistHelper.implode (implodeArr), 'PicklistHelper.implode() error');
    	System.assertEquals(null, PicklistHelper.implode(null), 'PicklistHelper.implode(null) should return null'); 
    	System.assertEquals(null, PicklistHelper.implode (new String[0]), 'PicklistHelper.implode (new String[0]) should return null');		
	}

	TestMethod static void testImplodeFromSet() {
    	System.debug ('testing PicklistHelper.implodeFromSet()...');
    	Set<String> implodeSet = new Set<String> {null, 'value1', ' ', 'value2', 'value3' };
    	String expectedImplodeValue = 'value1;value2;value3';
        
    	System.assertEquals(expectedImplodeValue, PicklistHelper.implodeFromSet (implodeSet), 'PicklistHelper.implodeFromSet() error');
    	System.assertEquals(null, PicklistHelper.implodeFromSet(null), 'PicklistHelper.implodeFromSet(null) should return null'); 
    	System.assertEquals(null, PicklistHelper.implodeFromSet (new Set<String>()), 'PicklistHelper.implodeFromSet (new Set<String>) should return null');		
	}
		
	TestMethod static void testCountEntries() {
    	System.debug ('testing PicklistHelper.countEntries()...');
    	System.assertEquals (0, PicklistHelper.countEntries(null), 'PicklistHelper.countEntries(null)');
    	System.assertEquals (1, PicklistHelper.countEntries('Student'), 'PicklistHelper.countEntries(Student)');
    	System.assertEquals (3, PicklistHelper.countEntries('Student;;Faculty;Alumni;;'), 'PicklistHelper.countEntries(Student;Faculty;Alumni;;)');
		
	}
			
  	TestMethod static void testGetIndex () {
    	System.debug ('testing PicklistHelper.getIndex(), PicklistHelper.getPicklistValues...');

    	//Test methods for new picklist functions added by TJV in 2012
    	//Use the INDUSTRY picklist on the Account level becuase we know its a default field with data in it.
    	List<String> accountIndustries = PicklistHelper.getPicklistValues(Account.Industry);
    	System.assertEquals(true, accountIndustries.size() > 0, 'No picklist values were returned from the schema');
    	Integer size = accountIndustries.size();
    	String lastValue = accountIndustries.get(size -1);
    	System.assertEquals(size -1, PicklistHelper.getIndex(accountIndustries, lastValue), 'Wrong value was returned when checking for index in list of strings' );
    	System.assertEquals(null, PicklistHelper.getIndex(accountIndustries, 'aFakeStringNotInThePicklist'), 'The GetIndex method returned a value rather than null');
    	System.assertEquals(size -1, PicklistHelper.getIndex(Account.Industry.getDescribe().getPicklistValues(), lastValue), 'Wrong value was returned when checking for index in list of Schema.PicklistEntry');
    	System.assertEquals(null, PicklistHelper.getIndex(Account.Industry.getDescribe().getPicklistValues(),  'aFakeStringNotInThePicklist'), 'The GetIndex method returned a value rather than null via Schema.PicklistEntry');
 	}
  
  	TestMethod static void testMergePickLists () {
       	System.debug ('testing PicklistHelper.mergePicklists()...');
    
    	String[] picklist1Arr =   new String[]{'value1;value2',      null,  'value1;value2',  null};
    	String[] picklist2Arr =   new String[]{'value1;value3',      null,   null,        'value1;value3'};
    
    	List<Set<String>> expectedValueSetList =  new List<Set<String>> {new Set<String>{'value3','value1','value2'},  
        									                             null,  
                                    									 new Set<String> {'value1','value2'},
                                    									 new Set<String> {'value1', 'value3'}
    	};
    
    	for (Integer i = 0; i < picklist1Arr.size(); i++) {
      		System.debug ('PicklistHelper.mergePicklists(\'' + picklist1Arr[i] + '\', \'' + picklist2Arr[i] + '\')'); 
      		String mergeResult = PicklistHelper.mergePicklists (picklist1Arr[i], picklist2Arr[i]);
      		String[] mergeResArr = PicklistHelper.explode(mergeResult);
      		if ((mergeResArr == null) || (mergeResArr.size() < 1))
        		System.assertEquals (null, expectedValueSetList[i], 'Empty Merge Result Expected');
      		else {
        		System.assertEquals (true, expectedValueSetList[i].containsAll(mergeResArr), 'Merge Result not correct');
      		}
    	}
    
  }
  
   TestMethod static void testArePickListsEqual () {
       	System.debug ('testing PicklistHelper.arePicklistsEqual()...');
    
    	String[] picklist1Arr =   new String[]		{'value1;value2',  	null,  	'value1;value2',  	null,				'value1',	'value1;value2'};
    	String[] picklist2Arr =   new String[]		{'value1;value3',   null,   null,        		'value1;value3',	'value1',	'value2;value1'};
    	Boolean[] expectedValueList = new Boolean[] {false,			 	true,	false,				false,				true,		true};
    	
    	for (Integer i = 0; i < picklist1Arr.size(); i++) {
      		System.debug ('PicklistHelper.arePicklistsEqual(\'' + picklist1Arr[i] + '\', \'' + picklist2Arr[i] + '\')'); 
      		Boolean result = PicklistHelper.arePicklistsEqual (picklist1Arr[i], picklist2Arr[i]);
      		System.assertEquals (	expectedValueList[i], 
      								PicklistHelper.arePicklistsEqual (picklist1Arr[i], picklist2Arr[i]), 
      								'PicklistHelper.arePicklistsEqual(\'' + picklist1Arr[i] + '\', \'' + picklist2Arr[i] + '\')');
    	}
  }
}