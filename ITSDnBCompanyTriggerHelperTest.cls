/**
* @author Tushar Kudchikar
* @date 04/23/2019 
*
* @group ITSDnBComapny
* @group-content ../../ApexDocContent/ITSDnBCompanyTriggerHelperTest.htm
*
* @description Test class for ITSDnBCompanyTriggerHelper class
*
* Change History
*
*   Tag      Author              Date          Incident No.    Requested-BY      Description     
* **********************************************************************************************************************************
*   1.0.0    Tushar Kudchikar    04/23/2019    N/A             Mike Mullaney     Test class for ITSDnBCompanyTriggerHelper 
*
*/
@isTest
public class ITSDnBCompanyTriggerHelperTest {
    
    static testMethod void testMethodDandBComapnyUpdate() {
        
        ITSDnBCompanyTestDataHelper.setupCAPHTestData(); 
        
        List<Dandbcompany> dandbCompanyUpdateList = new List<Dandbcompany>();
        
        List<User> users = [select Id from User where IsActive = true and Profile.Name ='System Administrator - ITS' limit 1];
        
        System.runAs(users[0]) {
            Test.startTest(); 
            
            for(DandBCompany d: [Select Id,
                                  		GlobalUltimateDunsNumber 
                                   From DandBCompany 
                                  Where GlobalUltimateDunsNumber = '123457'])
            {
                d.GlobalUltimateDunsNumber = '123456';
                dandbCompanyUpdateList.add(d);
            }
            
            System.assert(dandbCompanyUpdateList.size() > 0 );
            update dandbCompanyUpdateList;
            
            account accountRecord = [select id,GU_DUNSNumber__c,DandbcompanyId from account where NU_ID__c='TSTSTUID2'];
            System.assertEquals('123456', accountRecord.GU_DUNSNumber__c);
            System.assertEquals(null, accountRecord.DandbcompanyId);
            Test.stopTest();     
        }
    }
}