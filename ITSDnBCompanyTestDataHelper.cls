/** 
* @author Tushar Kudchikar
* @date 04/23/2019 
*
* @group ITSDnBComapny
* @group-content ../../ApexDocContent/ITSDnBCompanyTestDataHelper.htm
*
* @description This class is used to create the test data for Corporate relationship project
* 
* Change History
*
*   Tag     Author              Date           Requested-BY        Description     
* ********************************************************************************************************************************
*   1.0.0   Tushar Kudchikar    04/23/2019     Mike Mullaney       Test data for DnB Company trigger helper
*/
public without sharing class ITSDnBCompanyTestDataHelper {
    
    public static final String ORG_NUID_1 = 'TSTSTUID1';
    public static final String ORG_NUID_2 = 'TSTSTUID2';
    
    public static void setupCAPHTestData() {         
        
        Map<String,Id> acctRtMap = NEUSFIDHelper.retrieveActiveRecordTypeIdsByObjectType_dName('Account');
        List<Dandbcompany> dandbCompanyList = new List<Dandbcompany>();
        List<account> accountList = new List<account>();
        
        Dandbcompany dandbRecord1 = new Dandbcompany(Name ='XYZ Corporation 1',
                                                     DunsNumber ='123456',
                                                     GlobalUltimateDunsNumber ='123456');
        dandbCompanyList.add(dandbRecord1);
        
        Dandbcompany dandbRecord2 = new Dandbcompany(Name ='XYZ Corporation 2',
                                                     DunsNumber ='123457',
                                                     GlobalUltimateDunsNumber ='123457');
        dandbCompanyList.add(dandbRecord2);
        
        
        Account accParaentAccount1 = new Account (RecordTypeId = acctRtMap.get('Organization'),
                                                  NU_ID__c = ORG_NUID_1,
                                                  Name = 'XYZ Corporation 1',
                                                  website = 'xyz@test.com',
                                                  Phone = '8765675656',
                                                  Industry = 'Technology',
                                                  Ownership = 'Public',
                                                  DunsNumber ='123456',
                                                  GU_DUNSNumber__c ='123456',
                                                  DandbcompanyId = dandbRecord1.Id,
                                                  Description = 'Test');      
        accountList.add(accParaentAccount1);
        
        
        Account accChildTestData = new Account (RecordTypeId = acctRtMap.get('Organization'),
                                                parentid = accParaentAccount1.Id,
                                                Name = 'XYZ Corporation Child 1',
                                                website = 'xyz@test.com',
                                                Phone = '8765675656',
                                                Industry = 'Technology',
                                                Ownership = 'Public',
                                                DunsNumber ='123455',
                                                GU_DUNSNumber__c ='123456',
                                                DandbcompanyId = dandbRecord1.Id,
                                                Description = 'Test');      
        
        accountList.add(accChildTestData);
        
        Account accParaentAccount2 = new Account (RecordTypeId = acctRtMap.get('Organization'),
                                                  NU_ID__c = ORG_NUID_2,
                                                  Name = 'XYZ Corporation 2',
                                                  website = 'xyz1@test.com',
                                                  Phone = '8765675657',
                                                  Industry = 'Technology',
                                                  Ownership = 'Public',
                                                  DunsNumber ='123457',
                                                  GU_DUNSNumber__c ='123457',
                                                  DandbcompanyId = dandbRecord2.Id,
                                                  Description = 'Test');      
        
        accountList.add(accParaentAccount2);
                
        Account accChildAccount2 = new Account ( RecordTypeId = acctRtMap.get('Organization'),
                                                parentid = accParaentAccount2.Id,
                                                Name = 'XYZ Corporation Child 2',
                                                website = 'xyz1@test.com',
                                                Phone = '8765675658',
                                                Industry = 'Technology',
                                                Ownership = 'Public',
                                                DunsNumber ='123444',
                                                GU_DUNSNumber__c ='123457',    
                                                DandbcompanyId = dandbRecord2.Id,
                                                Description = 'Test');      
        
        accountList.add(accChildAccount2);
        
        insert dandbCompanyList;
        insert accountList;
        
    }
}