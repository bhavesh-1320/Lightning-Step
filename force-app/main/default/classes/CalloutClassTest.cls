@isTest
public class CalloutClassTest {
    
    //Test Generate Success Access Token Callout
    public static testmethod void testSuccessAccessToken() {
        
        //Arrange
        String clientId = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        String clientSecret = 'DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==';    
        String algorithmName1 = 'AES256';
        String orgId1 = UserInfo.getOrganizationId();
        string keyValue1='CYNTEXALABCYSP'+orgId1;
        Blob pvtKey1 = Blob.valueOf(keyValue1);
        Blob pbKey1 = EncodingUtil.base64Decode(clientId);
        Blob scKey1 = EncodingUtil.base64Decode(clientSecret);
        Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, pbKey1 );
        Blob decr2se = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, scKey1 );
        String pubkey = decrpb.tostring();
        String seckey1 = decr2se.tostring();
        
        //Act
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestForAccessToken()); 
        String accessToken = CalloutClass.getAccessToken(pubkey,seckey1);
        Test.stopTest();
        //Assert
        System.assertEquals(accessToken, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MTAyODhiNC0zYzdmLTRmMzItOTVlYy1jYjRjYTZhNjJhZjQiLCJqdGkiOiIzMzAxOGI1NTMyOTBiN2IxMmYyN2JlNTAzZGFjZWFmMDE1ZmVkYjU2OWUyM2Y5ZDIxNTk4M2EwNGNmMDBmMGQwYjUwODc0MTgxOTYyMDRjYiIsImlhdCI6MTU5OTA1MTA0MywibmJmIjoxNTk5MDUxMDQzLCJleHAiOjE2MzA1ODcwNDMsInN1YiI6IiIsInNjb3BlcyI6W119.pf_BPgUb80uFO4RvWfmS8aH2FQP4u4XMeyP7ItHwUdxSeC1_oDERUr_8OGd0BMd58S-BIVCbz3Epug0vMoJj6_a2c_aO6RLQ--a7QiHSztqlrFodLtfAbT9pdJSXuDn6SpnwdN_Xv_uuzCN5nuy1whfstt8B6zNfdMnwVPU36eZCP_4622vSWjER2D2f9Yub5WCq9prV7BSZIflKrj-pxPzO4sh4o7prrZ4RWbpRd6QuuE8ag4lu7Er6NR8AWvVTYAb3wQ8cHaQBUCpYVOH1SPGG5Rnn-SDpJ4I9g3T0kKbACYnF50T0s2weh5w3EtgFBbs8nWTHhmjMvLaNUOv0XxJ06Hs0fBdZ8GFUGIBxnBF1i5lKT23i9dOEeT6DpQrJsX6emU1p6-zjPHUf7Ja2f03BkG9YTjagTnkcgC-vMwKvXTWhRawrY_Kw0yLOC2FGB01A4yLsi3sc2KQDLi8MVs73ArQHtuyt-_Lx8SpiKeUS--cidRmeGzUgmhEq6BPgCw_mKTYo6bnWR2VumKM43wlYBoo1wjD45EbmRp5MR8q4-WF04bLkiXHU9nzi4P0ARbCrs0lG0d4K9OufFyLtXqzaZFKEacK8PUgDeclXahHfxBvdF_95oRRRpvd1_2-NBojsWUv-9cr8dm4x6FYkiuKYegwQh4M-FT-Ecq7Q6CQ');
    }
    
    //Test Generate Access Token Failure Callout
    public static testmethod void testFailureAccessToken() {
        
        //Arrange
        
        String clientId = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        String clientSecret = 'DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==';    
        String algorithmName1 = 'AES256';
        String orgId1 = UserInfo.getOrganizationId();
        string keyValue1='CYNTEXALABCYSP'+orgId1;
        Blob pvtKey1 = Blob.valueOf(keyValue1);
        Blob pbKey1 = EncodingUtil.base64Decode(clientId);
        Blob scKey1 = EncodingUtil.base64Decode(clientSecret);
        Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, pbKey1 );
        Blob decr2se = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, scKey1 );
        String pubkey = decrpb.tostring();
        String seckey1 = decr2se.tostring();
        
        //Act
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestFailureAccessToken()); 
        String errorMessage =CalloutClass.getAccessToken(pubkey,seckey1);
        Test.stopTest();
        //Assert
        System.assertEquals(errorMessage, 'The status code returned was not expected: 404 Ok');
    }
    
    // Create Success Inquiry into Lightning Step.
    public static testmethod void testCreateInquiry() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestCreateInquiry()); 
        Test.startTest();
        String payload = '{"fname":"Testing One1","lname":"Query","address":"data","city":"data","hphone":"7898787876","gender":"Male","usstate":"AL","email":"data1demo@gmail.com","dob":"2004-09-09 00:00:00","payorset":"yes","payorname":"John Test Payor","payoraddress":"test","payorcity":"testing","fundingsrc":"Scholarship","owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        //Act
        String response = CalloutClass.createInquiry(accessToken,payload);
        Test.stopTest();
        
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    // Failed to create Inquiry into Lightning Step
    public static testmethod void testFailureCreateInquiry() {
        
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestFailureCreateInquiry()); 
        Test.startTest();
        String payload = '{"fname":"Testing One1","lname":"Query","address":"data","city":"data","hphone":"7898787876","gender":"Male","usstate":"AL","email":"data1demo@gmail.com","dob":"2004-09-09 00:00:00","payorset":"yes","payorname":"John Test Payor","payoraddress":"test","payorcity":"testing","fundingsrc":"Scholarship","owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.createInquiry(accessToken,payload);
        Test.stopTest();
        
        System.assertEquals(response, 'The status code returned was not expected: 404 Ok');
    }
    
    // Create Contact into Lightning Step.
    public static testmethod void testCreateContact() {
        
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestCreateContact()); 
        Test.startTest();
        String payload = '{"fname":"Testing One1","lname":"Query","inquiry_id":"507","owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.createContact(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    // Failed to create contact into Lightning Step.
    public static testmethod void testFailureCreateContact() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockFailureCreateContact()); 
        Test.startTest();
        String payload = '{"fname":"Testing One1","lname":"Query","inquiry_id":"507","owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.createContact(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assertEquals(response, 'The status code returned was not expected: 404 Ok');
    }
    
    //Admit client in the Inquiry in the Lighning Step.
    public static testmethod void testAdmitClient() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestAdmitClient()); 
        Test.startTest();
        String payload = '{"inquiry_id":"539","location_id":"25","dateadmission":"2020-09-09 00:00:00","program_id":"11","owner_key":"68bef50c083c2b88563ea092e520e59b07739158da7f1f6bb7f5637b407cb8b4a6f14cae4acc0861"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.admitClient(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Failed status to Admit the Client in Inquiry record in the Lightning Step.
    public static testmethod void testFailureAdmitClient() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockFailureAdmitClient()); 
        Test.startTest();
        String payload = '{"inquiry_id":"539","location_id":"25","dateadmission":"2020-09-09 00:00:00","program_id":"11","owner_key":"68bef50c083c2b88563ea092e520e59b07739158da7f1f6bb7f5637b407cb8b4a6f14cae4acc0861"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.admitClient(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assertEquals(response, 'The status code returned was not expected: 404 Ok');
    }
    
    // Test Admit client status callout from Lightning Step.
    public static testmethod void testAdmitClientStatus() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestAdmitClientStatus()); 
        Test.startTest();
        String payload = '{"inquiry_id": "477","owner_key": "33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.admissionClientStatus(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Failed to fetch Client Admit Status
    public static testmethod void testFailureAdmitClientStatus() {
        //Arrange
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockFailureAdmitClientStatus()); 
        Test.startTest();
        String payload = '{"inquiry_id": "477","owner_key": "33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52"}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.admissionClientStatus(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assertEquals(response, 'The status code returned was not expected: 404 Ok');
    }
    
    //Fetch Bulkified client status from Lightning Step.
    public static testmethod void testBulkAdmitClientStatus() {
        //Arrange
        
        JSONGenerator jsonGen = JSON.createGenerator(true);
        jsonGen.writeStartArray();
        
        jsonGen.writeString('539');
        jsonGen.writeString('544');
        jsonGen.writeEndArray();
        String jsonData = jsonGen.getAsString();
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockBulkAdmitClientStatus()); 
        Test.startTest();
        String payload = '{"owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52","inquiry_ids":'+jsonData+'}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.checkBulkStatus(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Failed to fetching Bulkified Admit clients status
    public static testmethod void testBulkFailureAdmitClientStatus() {
        //Arrange
        JSONGenerator jsonGen = JSON.createGenerator(true);
        jsonGen.writeStartArray();
        jsonGen.writeString('539');
        jsonGen.writeString('544');
        jsonGen.writeEndArray();
        String jsonData = jsonGen.getAsString();
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockFailureAdmitClientStatus()); 
        Test.startTest();
        String payload = '{"owner_key":"33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52","inquiry_ids":'+jsonData+'}';
        String accessToken = accessToken();
        
        //Act
        String response = CalloutClass.checkBulkStatus(accessToken,payload);
        Test.stopTest();
        
        //Assert
        System.assertEquals(response, 'The status code returned was not expected: 404 Ok');
    }
    
    //Fetch Programs and Locations from Lightning Step.
    public static testmethod void testForProgramLocation() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('https://testapi.lightningstep.com/oauth/token',new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put('https://testapi.lightningstep.com/api/showProgramsByLocation',new CalloutClassMockTestProgrambyLocation('Location'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        String response = CalloutClass.calloutForProgramLocation();
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Fetch MC Contract Insurance from Lightning Step.
    public static testmethod void testForInsurance() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('https://testapi.lightningstep.com/api/v1/tableshow/mccontracts',new CalloutClassMockTestProgrambyLocation('Insurance'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        String response = CalloutClass.calloutForMcContract();
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Create Document
    public static testmethod void testForDocument() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestProgrambyLocation('Doc'));
        
        Test.startTest();
        //Act
        String en = EncodingUtil.base64Encode(blob.valueOf('test'));
        String payLoad = '{"filename":"Test.txt","mimetype": "text/plain","inquiry_id":"12","content":"'+en+'"}';
        String response = CalloutClass.createDocument(payLoad);
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.debug(response);
        System.assert(response.contains('success'));
    }
    //Generate Access token Callout Method
    public static String accessToken() {
        String clientId = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        String clientSecret = 'DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==';    
        String algorithmName1 = 'AES256';
        String orgId1 = UserInfo.getOrganizationId();
        string keyValue1='CYNTEXALABCYSP'+orgId1;
        Blob pvtKey1 = Blob.valueOf(keyValue1);
        Blob pbKey1 = EncodingUtil.base64Decode(clientId);
        Blob scKey1 = EncodingUtil.base64Decode(clientSecret);
        Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, pbKey1 );
        Blob decr2se = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, scKey1 );
        String pubkey = decrpb.tostring();
        String seckey1 = decr2se.tostring();
        String accessToken = CalloutClass.getAccessToken(pubkey,seckey1);
        
        return accessToken;
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
        
        Lightning_Step__API_EndPoints__c programByLocation = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/showProgramsByLocation',Name = 'Program and Location');
        Insert programByLocation;
        
        Lightning_Step__Location__c loc = new Lightning_Step__Location__c(Name = 'test',Lightning_Step__Location_Id__c = '11',Lightning_Step__Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        
        Lightning_Step__Program__c program1  = new Lightning_Step__Program__c(Lightning_Step__Locations__c = loc.Id, Lightning_Step__program_Name__c = 'test', Lightning_Step__Program_Id__c = '12', Name = 'test',Lightning_Step__Data_Validation__c = true);
        Insert program1;
        
        Lightning_Step__API_EndPoints__c insurance = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/v1/tableshow/mccontracts',Name = 'MC Contract Insurance');
        Insert insurance;
        
        Lightning_Step__API_EndPoints__c doc = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/v1/uploadeddoccreate?',Name = 'Upload Document');
        Insert doc;
    }
}