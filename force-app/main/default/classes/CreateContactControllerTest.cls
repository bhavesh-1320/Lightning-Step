@isTest
public class CreateContactControllerTest {
    
    // Test Create Contact API Callout when Current User as a Default User.
    public static testmethod void testCreateContact() {
        
        Lightning_Step__Lightning_Step_Contact__c lsCon = [Select Id from Lightning_Step__Lightning_Step_Contact__c limit 1];
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Contact Creation'),new CalloutClassMockTestCreateContact());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.CreateContact(lsCon.Id);
        Test.stopTest();
        
        System.assertEquals(response, 'success');
    }
    
    // Test Create Contact API Callout when Current User is not a Default User.
    public static testmethod void testFalseUserCreateContact() {
        
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = false;
        update ownerKeyUser;
        
        Lightning_Step__Lightning_Step_Contact__c lsCon = [Select Id from Lightning_Step__Lightning_Step_Contact__c limit 1];
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Contact Creation'),new CalloutClassMockTestCreateContact());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.CreateContact(lsCon.Id);
        Test.stopTest();
        
        System.assertEquals(response, 'success');
    }
    
    // Test Admit Client API Callout when Current User as a Default User.
    public static testmethod void testAdmitClient() {
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c limit 1];
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Admit Client'),new CalloutClassMockTestAdmitClient());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.AdmitClient(inquiry.Id);
        Test.stopTest();
        
        System.assert(response.contains('success'));
    }
    
    // Test Admit Client API Callout when Current User is not a Default User.
    public static testmethod void testfalseUserAdmitClient() {
        
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c limit 1];
        
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = false;
        update ownerKeyUser;
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Admit Client'),new CalloutClassMockTestAdmitClient());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.AdmitClient(inquiry.Id);
        Test.stopTest();
        System.assert(response.contains('success'));
    }
   
    // Test Admit client status API Callout when Current User is a Default User.
    public static testmethod void testCheckAdmitStatus() {
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c limit 1];
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Admission Status'),new CalloutClassMockTestAdmitClientStatus());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.CheckAdmitStatus(inquiry.Id);
        Test.stopTest();
        System.assert(response.contains('success'));
    }
    

    // Test Admit client status API Callout when Current User is not a Default User.
    public static testmethod void testfalseUserCheckAdmitStatus() {
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c limit 1];
        
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = false;
        update ownerKeyUser;
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Admission Status'),new CalloutClassMockTestAdmitClientStatus());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        String response = CreateContactController.CheckAdmitStatus(inquiry.Id);
        Test.stopTest();
        System.assert(response.contains('success'));
    } 
     
    // Test Lookup filter with Search Key
    public static testmethod void testfetchLookUpValues() {
        
        Lightning_Step__Location__c loc = [Select Id from Lightning_Step__Location__c limit 1];
        
        Test.startTest();
        List<object> response = CreateContactController.fetchLookUpValues(loc.Id,'Lightning_Step__Program__c','te');
        Test.stopTest();
        
        System.assert(response != null);
        System.assertEquals(response.size(), 2);
    } 
    
    // Test Lookup filter without Search Key
    public static testmethod void testfetchLookUpValueswithNullSearchKey() {
        
        Lightning_Step__Location__c loc = [Select Id from Lightning_Step__Location__c limit 1];
        
        Test.startTest();
        List<object> response = CreateContactController.fetchLookUpValues(loc.Id,'Lightning_Step__Program__c','');
        Test.stopTest();
        
        System.assert(response != null);
        System.assertEquals(response.size(), 2);
    }
    
    // Test client already exist
    public static testmethod void testAdmitClientfalse() {
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c limit 1];
        
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestCreateInquiry());
        
        inquiry.Lightning_Step__Client_Id__c = '12';
        update inquiry;
        Test.startTest();
        Boolean condition = CreateContactController.isAdmitClient(inquiry.Id);
        Test.stopTest();
        System.assert(condition == false);
    }
    
    // Test client not already exist
    public static testmethod void testisAdmitClient() {
        
        Lightning_Step__Inquiry__c inquiry = [Select Id from Lightning_Step__Inquiry__c where Lightning_Step__First_Name__c='test2' limit 1 ];
        
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestCreateInquiry());
        Test.startTest();
        Boolean condition = CreateContactController.isAdmitClient(inquiry.Id);
        Test.stopTest();
        System.assert(condition);
    }
   
    // test User Credentials
    public static testmethod void testIsSetupWithUserCredentials() {
        
        Test.startTest();
        Boolean isSetup = CreateContactController.isSetup();
        Test.stopTest();
        System.assert(isSetup);
    }
    
    // test User Credentials
    public static testmethod void testIsSetupWithoutUserCredentials() {
        
        Lightning_Step__API_Keys__c ownerKey = [Select Id from Lightning_Step__API_Keys__c];
        delete ownerKey;
        
        Test.startTest();
        Boolean isSetup = CreateContactController.isSetup();
        Test.stopTest();
        System.assert(!isSetup);
    }
    
    @TestSetup
    static void setup()
    {
        Lightning_Step__API_EndPoints__c accessTokenURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/oauth/token',Name = 'Access Token');
        Insert accessTokenURL;
        
        Lightning_Step__API_EndPoints__c inquiryCreationURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_make_inquiry?',Name = 'Inquiry Creation');
        Insert inquiryCreationURL;
        
        Lightning_Step__API_EndPoints__c showBulkAdmissionStatusURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/showBulkAdmissionStatus?',Name = 'Bulk Admission Status Check');
        Insert showBulkAdmissionStatusURL;
        
        Lightning_Step__API_EndPoints__c contactCreationURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_make_contact?',Name = 'Contact Creation');
        Insert contactCreationURL;
        
        Lightning_Step__API_EndPoints__c admitClientURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_admit_client?',Name = 'Admit Client');
        Insert admitClientURL;
        
        Lightning_Step__API_EndPoints__c showAdmissionURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/show_admission_status',Name = 'Admission Status');
        Insert showAdmissionURL;
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(accessTokenURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(inquiryCreationURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestCreateInquiry());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        Lightning_Step__Inquiry__c inquiry = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test1',Lightning_Step__Client_Id__c ='457',Lightning_Step__Payor_City__c='City',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_Zip_Code__c='30201',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234537890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539');
        Insert inquiry;
        
        Lightning_Step__Lightning_Step_Contact__c lsCon = new Lightning_Step__Lightning_Step_Contact__c( Lightning_Step__First_Name__c = 'test', Lightning_Step__Last_Name__c = 'test', Lightning_Step__Inquiry__c = inquiry.Id,Lightning_Step__Data_Validation__c = true);
        Insert lsCon;
        
        Lightning_Step__Inquiry__c inquirywithoutClient = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test2',Lightning_Step__Payor_City__c='City',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_Zip_Code__c='30201',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234537890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539');
        Insert inquirywithoutClient;
        
        Lightning_Step__Lightning_Step_Contact__c lsConwithoutClient = new Lightning_Step__Lightning_Step_Contact__c( Lightning_Step__First_Name__c = 'test', Lightning_Step__Last_Name__c = 'test', Lightning_Step__Inquiry__c = inquirywithoutClient.Id,Lightning_Step__Data_Validation__c = true);
        Insert lsConwithoutClient;
        
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        
        Lightning_Step__Program__c program1  = new Lightning_Step__Program__c(Lightning_Step__Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test', Lightning_Step__Program_Id__c = '12', Name = 'test',Lightning_Step__Data_Validation__c = true);
        Insert program1;
        
        Lightning_Step__Program__c program2  = new Lightning_Step__Program__c(Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test1', Lightning_Step__Program_Id__c = '12', Name = 'test1',Lightning_Step__Data_Validation__c = true);
        Insert program2;
    }
}