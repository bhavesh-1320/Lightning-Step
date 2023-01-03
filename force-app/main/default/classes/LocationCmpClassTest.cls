@isTest
public class LocationCmpClassTest {
    
    //Test Location API when User is Default User.
    public static testmethod void testGetLocation() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Program and Location'),new CalloutClassMockTestProgrambyLocation('Location'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Test.startTest();
        //Act
        String response = LocationCmpClass.getLocation();
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Test Location API when User is not a Default User.
    public static testmethod void testGetLocationExistUser() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Program and Location'),new CalloutClassMockTestProgrambyLocation('Location'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        
        Lightning_Step__StoreLastModifiedOfLocationSync__c existDataLoc = new Lightning_Step__StoreLastModifiedOfLocationSync__c(Lightning_Step__lastModfiied__c = String.valueOf(System.today()));
        Insert existDataLoc;
        
        Test.startTest();
        //Act
        String response = LocationCmpClass.getLocation();
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Test Program API when User is Default User.
    public static testmethod void testGetPrograms() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Program and Location'),new CalloutClassMockTestProgrambyLocation('Location'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        String response = LocationCmpClass.getProgram();
        Test.stopTest();
        
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    //Test Program API when User is not a Default User.
    public static testmethod void testGetProgramExistUser() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Access Token'),new CalloutClassMockTestForAccessToken());
        endpoint2TestResp.put(mapOfEndPointURL.get('Program and Location'),new CalloutClassMockTestProgrambyLocation('Location'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        
        
        Lightning_Step__LastModifiedOfprogram__c existDataPro = new Lightning_Step__LastModifiedOfprogram__c(Lightning_Step__LastModifiedDate__c = String.valueOf(System.today()));
        Insert existDataPro;
        
        //Act
        String response = LocationCmpClass.getProgram();
        Test.stopTest();
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
    }
    
    public static testmethod void testGetProgramRec() {
        
        Location__c loc = new Location__c(Name = 'test',Location_Id__c = '11',Location_Name__c = 'test',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        
        Program__c program1  = new Program__c(Locations__c = loc.Id, program_Name__c = 'test1', Program_Id__c = '12', Name = 'test1',Lightning_Step__Data_Validation__c = true);
        Insert program1;
        
        Program__c program2  = new Program__c(Locations__c = loc.Id, program_Name__c = 'test2', Program_Id__c = '13', Name = 'test2',Lightning_Step__Data_Validation__c = true);
        Insert program2;
        
        Program__c program3  = new Program__c(Locations__c = loc.Id, program_Name__c = 'test3', Program_Id__c = '14', Name = 'test3',Lightning_Step__Data_Validation__c = true);
        Insert program3;
        
        Program__c program4  = new Program__c(Locations__c = loc.Id, program_Name__c = 'test4', Program_Id__c = '15', Name = 'test4',Lightning_Step__Data_Validation__c = true);
        Insert program4;
        
        Test.startTest();
        List<Program__c> listOfResponse = LocationCmpClass.getProgramRec('1','4');
        Test.stopTest();
        System.assert(listOfResponse != null);
    }
    
    // Get Location records.
    public static testmethod void testGetLocationRec() {
        
        Location__c loc = new Location__c(Name = 'test1',Location_Id__c = '11',Location_Name__c = 'test1',Lightning_Step__Data_Validation__c = true);
        Insert loc;
        Test.startTest();
        List<Location__c> listOfResponse = LocationCmpClass.getLocationRec('1','1');
        Test.stopTest();
        System.assert(listOfResponse != null);
    }
    
    @TestSetup
    static void setup()
    {      
        Lightning_Step__API_EndPoints__c accessTokenURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/oauth/token',Name = 'Access Token');
        Insert accessTokenURL;
        
        Lightning_Step__API_EndPoints__c programByLocation = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/showProgramsByLocation',Name = 'Program and Location');
        Insert programByLocation;
        
        
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
    }
}