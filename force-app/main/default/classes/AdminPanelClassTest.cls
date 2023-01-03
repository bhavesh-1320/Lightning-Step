@isTest
public class AdminPanelClassTest {
    
    // This is used for test Show Login Details with Owner Key.
    public static testmethod void testShowLoginDetail() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.showLoginDetail();
        Test.stopTest();
        //Assert
        System.assert(response !=null);
        System.assertEquals(response, '910288b4-3c7f-4f32-95ec-cb4ca6a62af4 VlnZ7SQlokjfG9rFCkiU8H8BQ4XZH5JoxcXR4lVb 910288b4-3c7f-4f32-95ec-cb4ca6a62af4');
    }
    
    // This is used for test Edit Login Details.
    public static testmethod void testEditloginDetail() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==',Lightning_Step__Bearer_Token__c = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        String clientId = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        String clientScrect = 'DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==';
       	String apiKey = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        //Act
        Test.startTest();
        String response = AdminPanelClass.EditloginDetail(clientId,clientScrect, apiKey);
        Test.stopTest();

        //Assert
        System.assert(response !=null);
    } 
    
    // This is used for test Edit Login Details if record is not exist.
    public static testmethod void testEditloginDetailSecond() {
        //Arrange
        String clientId = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==';
        String clientScrect = 'DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==';
        String apiKey = 'DDNyoPqe0nkEFQkaeVycVkiaaW2';
        //Act
        Test.startTest();
        String response = AdminPanelClass.EditloginDetail(clientId,clientScrect,apiKey);
        Test.stopTest();
        //Assert
        System.assert(response !=null);
    }
    
    //It checks that the custom setting Api credential has some value.
    public static testmethod void testshowdetail() {
        //Arrange
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c = 'QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        //Act
        Test.startTest();
        Boolean response = AdminPanelClass.showdetail();
        Test.stopTest();
        //Assert
        System.assert(response);
    }
    
    //It checks that the custom setting Api credential is not correct or exist.
    public static testmethod void testshowdetailSecond() {
        //Act
        Test.startTest();
        Boolean response = AdminPanelClass.showdetail();
        Test.stopTest();
        //Assert
        System.assert(response == false);
    }
    
    //It checks the owner key record when Default user checkbox is check.
    public static testmethod void testOwnerKeyRecord() {
        //Arrange
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        //Act
        Test.startTest();
        String response = AdminPanelClass.OwnerKeyRecord();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'SetAsDefaultUser');
    }
    
    //It checks the owner key record when Default user checkbox is not check.
    public static testmethod void testOwnerKeyRecordSecond() {
        //Arrange
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = false);
        Insert ownerKeyUser;
        //Act
        Test.startTest();
        String response = AdminPanelClass.OwnerKeyRecord();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'NotSetAsDefaultUser');
    }
    
    //It checks the owner key record is not exist.
    public static testmethod void testOwnerKeyRecordThird() {
        //Act
        Test.startTest();
        String response = AdminPanelClass.OwnerKeyRecord();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'RecDoestNotExist');
    }
    
    //It Insert or updste the user specific owner key
    public static testmethod void testSaveOwnerKeyPerUser() {
        
        //Arrange 
        String currentUser = UserInfo.getUserId();
        String ownweKey = 'PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==';
        Boolean defaultUser = true;
        //Act
        Test.startTest();
        String response = AdminPanelClass.SaveOwnerKeyPerUser(currentUser,ownweKey,defaultUser);
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'Success');
    }
    
    // test Sync details when location and program custom setting records exist.
    public static testmethod void testgetSyncDetail() {
        
        //Arrange 
        Lightning_Step__StoreLastModifiedOfLocationSync__c loc = new Lightning_Step__StoreLastModifiedOfLocationSync__c(Lightning_Step__lastModfiied__c = String.valueOf(System.today()));
        Insert loc;
        Lightning_Step__LastModifiedOfprogram__c pro = new Lightning_Step__LastModifiedOfprogram__c(Lightning_Step__LastModifiedDate__c = String.valueOf(System.today()));
        Insert pro; 
        //Act
        Test.startTest();
        String response = AdminPanelClass.getSyncDetail();
        Test.stopTest();
        //Assert
        System.assertEquals(response, String.valueOf(System.today()) + ',' + String.valueOf(System.today()));
    }
    
    // test Sync details when location custom setting records exist.
    public static testmethod void testgetSyncDetail1() {
        
        //Arrange 
        Lightning_Step__StoreLastModifiedOfLocationSync__c loc = new Lightning_Step__StoreLastModifiedOfLocationSync__c(Lightning_Step__lastModfiied__c = String.valueOf(System.today()));
        Insert loc;
        //Act
        Test.startTest();
        String response = AdminPanelClass.getSyncDetail();
        Test.stopTest();
        //Assert
        System.assertEquals(response, String.valueOf(System.today()) + ',nodate');
    }
    
    // test Sync details when Program custom setting records exist.
    public static testmethod void testgetSyncDetail2() {
        
        //Arrange 
        Lightning_Step__LastModifiedOfprogram__c pro = new Lightning_Step__LastModifiedOfprogram__c(Lightning_Step__LastModifiedDate__c = String.valueOf(System.today()));
        Insert pro;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.getSyncDetail();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'nodate,'+String.valueOf(System.today()));
    }
    
    // test Sync details when location and Program custom setting records not exist.
    public static testmethod void testgetSyncDetail3() {
        //Act
        Test.startTest();
        String response = AdminPanelClass.getSyncDetail();
        Test.stopTest();
        //Assert
        System.assertEquals(response, null);
    }
    
    //test current user is a Owner Key defualt user.
    public static testmethod void testCheckSetAsDefault() {
        
        //Arrange 
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.CheckSetAsDefault();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'SetAsDefaultUser');
    }
    
    //test current user is not a Owner Key defualt user.
    public static testmethod void testCheckSetAsDefault1() {
        //Arrange 
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = false);
        Insert ownerKeyUser;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.CheckSetAsDefault();
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'NotSetAsDefaultUser');
    }
    
    //This is used to update Default user. 
    public static testmethod void testUpdateDefaultUserVal() {
        //Arrange 
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.UpdateDefaultUserVal(currentUser);
        Test.stopTest();
        //Assert
        System.assertEquals(response, 'success');
    }
    
    //This is used to fatch User List 
    public static testmethod void testgetUserList() {
        //Arrange 
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = false);
        Insert ownerKeyUser;
        
        //Act
        Test.startTest();
        List<Lightning_Step__OwnerKeyValPerUser__c> response = AdminPanelClass.getUserList();
        Test.stopTest();
        //Assert
        System.assertEquals(response.size(),1);
    }
    
    //This is used to check User Credentials  
    public static testmethod void testcheckMarketingUserWithUserCredentials() {
        //Arrange 
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        //Act
        Test.startTest();
        String response = AdminPanelClass.checkMarketingUserWithUserCredentials();
        Test.stopTest();
        //Assert
        System.assertEquals(response,'success');
    }
    
    //This is used to check User Credentials  
    public static testmethod void testcheckMarketingUserWithoutUserCredentials() {
        //Act
        Test.startTest();
        String response = AdminPanelClass.checkMarketingUserWithUserCredentials();
        Test.stopTest();
        //Assert
        System.assert(response.contains('Client Id and Secret key is Missing.'));
    }
    
    //This is used to check User Credentials  
    public static testmethod void testcheckMarketingUserWithNotMarketingUser() {
        //Act
        string userId=UserInfo.getUserId();
        User userRecord = [SELECT Id,UserPermissionsMarketingUser FROM User WHERE Id=:userId LIMIT 1];
        userRecord.UserPermissionsMarketingUser = false;
        Test.startTest();
        update userRecord;
        System.debug('userRecord '+userRecord);
        String response = AdminPanelClass.checkMarketingUserWithUserCredentials();
        Test.stopTest();
        //Assert
        System.assert(response.contains('You are not a Marketing User'));
    }
}