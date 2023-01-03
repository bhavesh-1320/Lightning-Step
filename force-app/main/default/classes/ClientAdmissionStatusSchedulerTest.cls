@isTest
public class ClientAdmissionStatusSchedulerTest {
    
    // Run the Scheduler class for fetching the Admitted clients status with current user is not a Default user.
    public static testmethod void runSchedulerClass() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Inquiry Creation'),new CalloutClassMockTestCreateInquiry());
        endpoint2TestResp.put(mapOfEndPointURL.get('Bulk Admission Status Check'),new CalloutClassMockBulkAdmitClientStatus());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        List<Lightning_Step__Inquiry__c> inquires = [Select Id,Lightning_Step__Status__c from Lightning_Step__Inquiry__c Where Lightning_Step__First_Name__c like '%test%'];
        
        for(Lightning_Step__Inquiry__c inquiry : inquires) {
            inquiry.Lightning_Step__Status__c = 'Admitted';
        } 
        update inquires;
        Test.startTest();
        String CRON_EXP = '0 0 23 * * ?';
        
        String jobId = System.schedule('ScheduleApexClassTest',CRON_EXP, new ClientAdmissionStatusScheduler());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        Test.stopTest();
        
        System.assert(ct != null);
    }
    
    // Run the Scheduler class for fetching the Admitted clients status with Current User is a Default User.
    public static testmethod void runSchedulerClassWithoutDefaultUser() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = true;
        update ownerKeyUser;
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Inquiry Creation'),new CalloutClassMockTestCreateInquiry());
        endpoint2TestResp.put(mapOfEndPointURL.get('Bulk Admission Status Check'),new CalloutClassMockBulkAdmitClientStatus());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        List<Lightning_Step__Inquiry__c> inquires = [Select Id,Lightning_Step__Status__c from Lightning_Step__Inquiry__c Where Lightning_Step__First_Name__c like '%test%'];
        for(Lightning_Step__Inquiry__c inquiry : inquires) {
            inquiry.Lightning_Step__Status__c = 'Admitted';
        } 
        update inquires;
        Test.startTest();
        String CRON_EXP = '0 0 23 * * ?';
        
        String jobId = System.schedule('ScheduleApexClassTest',CRON_EXP, new ClientAdmissionStatusScheduler());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        Test.stopTest();
        
        System.assert(ct != null);
    }
    
    
    // Create test Setup method for create testing data records.
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
        
        Lightning_Step__API_EndPoints__c programByLocation = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/showProgramsByLocation',Name = 'Program and Location');
        Insert programByLocation;
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(accessTokenURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(inquiryCreationURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockTestCreateInquiry());
        endpoint2TestResp.put(showBulkAdmissionStatusURL.Lightning_Step__End_Point_URL__c,new CalloutClassMockBulkAdmitClientStatus());
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test1');
        Insert ownerKeyUser;
        
        Lightning_Step__Inquiry__c inquiry1 = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test1',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234537890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_City__c='City',Lightning_Step__Payor_Zip_Code__c='30201',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5);
    	Insert inquiry1;
        
        Lightning_Step__Inquiry__c inquiry2 = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test2',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234547890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_City__c='City',Lightning_Step__Payor_Zip_Code__c='30201',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5);
    	Insert inquiry2;
        
        Lightning_Step__Inquiry__c inquiry3 = new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c = 'test3',Lightning_Step__Last_Name__c = 'test',Lightning_Step__Home_Phone__c ='1234577890',Lightning_Step__GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_City__c='City',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_Zip_Code__c='30201',	 Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '541');
    	Insert inquiry3;
    }
}