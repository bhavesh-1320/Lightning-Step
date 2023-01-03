@isTest
public class HelperValidateTest {
    
    public static testmethod void testvalidateInsertProgram() {
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        String response;
        Test.startTest();
        Lightning_Step__Program__c program1  = new Lightning_Step__Program__c(Lightning_Step__Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test', Lightning_Step__Program_Id__c = '12', Name = 'test');
        try {
            Insert program1;
        } catch(Exception e) {
            response = e.getMessage();
        }
        Test.stopTest();
        
        System.assert(response.contains('You are not allowed to manually create/update the Program records. These records are synced from server automatically.'));
    }
    
    public static testmethod void testvalidateUpdateProgram() {
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        String response;
        Test.startTest();
        Lightning_Step__Program__c program1  = new Lightning_Step__Program__c(Lightning_Step__Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test', Lightning_Step__Program_Id__c = '12', Name = 'test',Lightning_Step__Data_Validation__c = true);
        Insert program1;
        
        Lightning_Step__Program__c program = [Select Id,Lightning_Step__Data_Validation__c from Lightning_Step__Program__c where Lightning_Step__program_Name__c = 'test' limit 1];
        program.Lightning_Step__Data_Validation__c = false;
        try {
            update program;
        } catch(Exception e) {
            response = e.getMessage();
        }
        Test.stopTest();
        
        System.assert(response.contains('You are not allowed to manually create/update the Program records. These records are synced from server automatically.'));
    }
    
    public static testmethod void testvalidateInsertLocation() {
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test');
        String response;
        Test.startTest();
        try {
            Insert loc;
        } catch(Exception e) {
            response = e.getMessage();
        }
        Test.stopTest();
        
        System.assert(response.contains('You are not allowed to manually create/update the Location records. These records are synced from server automatically.'));
    }
    
    public static testmethod void testvalidateUpdateLocation() {
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        String response;
        Test.startTest();
        
        Lightning_Step__Location__c location = [Select Id,Lightning_Step__Data_Validation__c from Lightning_Step__Location__c where Lightning_Step__Location_Name__c = 'test' limit 1];
        location.Lightning_Step__Data_Validation__c = false;
        try {
            update location;
        } catch(Exception e) {
            response = e.getMessage();
        }
        Test.stopTest();
        
        System.assert(response.contains('You are not allowed to manually create/update the Location records. These records are synced from server automatically.'));
    }
    
    public static testmethod void testvalidateInsertContact() {
        
        Lightning_Step__API_EndPoints__c accessTokenURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/oauth/token',Name = 'Access Token');
        Insert accessTokenURL;
        
        Lightning_Step__API_EndPoints__c inquiryCreationURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_make_inquiry?',Name = 'Inquiry Creation');
        Insert inquiryCreationURL;
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(accessTokenURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(inquiryCreationURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestCreateContact());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        String response;
        Test.startTest();
        Lightning_Step__Inquiry__c inquiry = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234567890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539',Lightning_Step__Date_of_Submission__c = System.today() + 5,Lightning_Step__Zip_Postal_code__c = '12345',Lightning_Step__State_Province__c = 'TX',Lightning_Step__Postal_Code__c = '12345',Lightning_Step__Payor_Zip_Code__c = '12345',Lightning_Step__Payor_State__c = 'TX',Lightning_Step__Payor_Fax__c = '1234567890',Lightning_Step__Payor_City__c = 'City',Lightning_Step__Payor_Address__c = 'Test');
        Insert inquiry;
        
        Lightning_Step__Lightning_Step_Contact__c lsCon = new Lightning_Step__Lightning_Step_Contact__c( Lightning_Step__First_Name__c = 'test', Lightning_Step__Last_Name__c = 'test', Lightning_Step__Inquiry__c = inquiry.Id);
        
        try {
            Insert lsCon;
        } catch(Exception e) {
            response = e.getMessage();
        }
        Test.stopTest();
        
        System.assert(response.contains('You are not allowed to create the Contacts records from the Contact Tab. Create it from Inquiry only.'));
    }
}