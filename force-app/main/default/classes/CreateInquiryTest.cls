@isTest
public class CreateInquiryTest {
    
    //Create Inquiry using the Scheduler class with Default User.
    public static testmethod void createInquiry() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Inquiry Creation'),new CalloutClassMockTestCreateInquiry());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Test.startTest();
        Lightning_Step__Inquiry__c inquiry = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234567890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539',Lightning_Step__Date_of_Submission__c = System.today() + 5,Lightning_Step__Zip_Postal_code__c = '12345',Lightning_Step__State_Province__c = 'TX',Lightning_Step__Postal_Code__c = '12345',Lightning_Step__Payor_Zip_Code__c = '12345',Lightning_Step__Payor_State__c = 'TX',Lightning_Step__Payor_Fax__c = '1234567890',Lightning_Step__Payor_City__c = 'City',Lightning_Step__Payor_Address__c = 'Test');
        inquiry.Lightning_Step__Inquiry_Id__c = null;
        Insert inquiry;
        
        Lightning_Step__Inquiry__c inquiry1 = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234567890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539',Lightning_Step__Date_of_Submission__c = System.today() + 5,Lightning_Step__Zip_Postal_code__c = '12345',Lightning_Step__State_Province__c = 'TX',Lightning_Step__Payor_Zip_Code__c = '12345',Lightning_Step__Payor_State__c = 'TX',Lightning_Step__Payor_Fax__c = '1234567890',Lightning_Step__Payor_City__c = 'City',Lightning_Step__Payor_Address__c = 'Test');
        inquiry1.Lightning_Step__Inquiry_Id__c = null;
        Insert inquiry1;
        Test.stopTest();
        
        Lightning_Step__Inquiry__c createdInquiry = [Select Id, Lightning_Step__Inquiry_Id__c from Lightning_Step__Inquiry__c Where Lightning_Step__First_Name__c = 'test' LIMIT 1];
        System.assert(createdInquiry.Lightning_Step__Inquiry_Id__c != null);
          
    }
    
    //Create Inquiry using the Scheduler class without Default User.
    public static testmethod void createInquiryWithDefaultUser() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Inquiry Creation'),new CalloutClassMockTestCreateInquiry());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = true;
        update ownerKeyUser;
        
        Test.startTest();
        Lightning_Step__Inquiry__c inquiry = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test',Lightning_Step__Payor_City__c='City',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234567890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539',Lightning_Step__Date_of_Submission__c = System.today() + 5);
        Insert inquiry;
        Test.stopTest();
        
        Lightning_Step__Inquiry__c createdInquiry = [Select Id, Lightning_Step__Inquiry_Id__c from Lightning_Step__Inquiry__c Where Lightning_Step__First_Name__c = 'test' LIMIT 1];
        
        System.assert(createdInquiry.Lightning_Step__Inquiry_Id__c != null);
    }
    
    @TestSetup
    static void setup()
    {
        Lightning_Step__API_EndPoints__c accessTokenURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/oauth/token',Name = 'Access Token');
        Insert accessTokenURL;
        
        Lightning_Step__API_EndPoints__c inquiryCreationURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_make_inquiry?',Name = 'Inquiry Creation');
        Insert inquiryCreationURL;
        
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = false);
        Insert ownerKeyUser;
    }
}