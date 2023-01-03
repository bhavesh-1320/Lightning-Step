@isTest
public class CustomLookupControllerTest {
    
    public static testmethod void testgetResults() {
        //Arrange
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        
        Lightning_Step__Program__c program  = new Lightning_Step__Program__c(Lightning_Step__Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test', Lightning_Step__Program_Id__c = '12', Name = 'test',Lightning_Step__Data_Validation__c = true);
        Insert program;
        
        String ObjectName = 'Lightning_Step__Program__c';
        String fieldName = 'Lightning_Step__program_Name__c';
        String value = 'te';
        
        Test.startTest();
        List<Object> response = CustomLookupController.getResults(ObjectName, fieldName, value);
        Test.stopTest();
        System.assert(response != null);
    }
}