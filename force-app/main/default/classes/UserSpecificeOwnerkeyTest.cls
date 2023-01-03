@isTest
public class UserSpecificeOwnerkeyTest {
    
    public static testmethod void testfetchValuesOfUser() {
        Test.startTest();
        List<object> listUser = UserSpecificeOwnerkey.fetchValues();
        Test.stopTest();
        System.assert(listUser != null);
    }
    
    public static testmethod void testEditUserDetail() {
        String currentUser = UserInfo.getUserId();
        String ownerKey = '33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52';
        Boolean DefaultVal = true;
        Test.startTest();
        List<object> response = UserSpecificeOwnerkey.EditUserDetail(currentUser,ownerKey,DefaultVal);
        Test.stopTest();
        System.assert(response != null);
    }
    
    public static testmethod void testEditUserDetailFalse() {
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        Delete ownerKeyUser;
        String currentUser = UserInfo.getUserId();
        String ownerKey = '33cc9ea795b7b43220d4aa862c7a7981ce41e2fe0b74cc76ed6871a732cf1f0bdcccd61fdaa6ec52';
        Boolean DefaultVal = true;
        
        Test.startTest();
        List<object> response = UserSpecificeOwnerkey.EditUserDetail(currentUser,ownerKey,DefaultVal);
        Test.stopTest();
        System.assert(response == null);
    }
    public static testmethod void testGetUserDetail() {
        String currentUser = UserInfo.getUserId();
        Test.startTest();
        String response = UserSpecificeOwnerkey.GetUserDetail(currentUser);
        Test.stopTest();
        System.assert(response != null);
    }
    
    public static testmethod void testDeleteUser() {
        String currentUser = UserInfo.getUserId();
        Test.startTest();
        String response = UserSpecificeOwnerkey.DeleteUser(currentUser);
        Test.stopTest();
        System.assert(response == 'success');
    }
    
    public static testmethod void testCheckUserDefaultVal() {
        String currentUser = UserInfo.getUserId();
        Test.startTest();
        String response = UserSpecificeOwnerkey.CheckUserDefaultVal(currentUser);
        Test.stopTest();
        System.assert(response == 'DefaultUser');
    }
    
    public static testmethod void testCheckUserDefaultValFalse() {
        
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = [Select Id,Lightning_Step__Set_User_as_default_user__c from Lightning_Step__OwnerKeyValPerUser__c];
        ownerKeyUser.Lightning_Step__Set_User_as_default_user__c = false;
        update ownerKeyUser;
        String currentUser = UserInfo.getUserId();
        Test.startTest();
        String response = UserSpecificeOwnerkey.CheckUserDefaultVal(currentUser);
        Test.stopTest();
        System.assert(response == 'NotDefaultuser');
    }
    
    @TestSetup
    static void setup()
    {
        String currentUser = UserInfo.getUserId();
        Lightning_Step__OwnerKeyValPerUser__c ownerKeyUser = new Lightning_Step__OwnerKeyValPerUser__c(Lightning_Step__OwnerKey__c='PZQQi9aFMwnFWSA2uI5c8Xw+XvlgJfUWlSl//M2ns94S4n70wa+SYgVJcrtkn2sKHQx2/+XdRYPI69TtFwor/Mt0rzIQfjNyOn8R6u7Js8ilwMxKrkwAj6cDJaC+itO1+dymcG9angBk3X0g7OxmvQ==',Lightning_Step__UserId__c=currentUser,Name='test',Lightning_Step__Set_User_as_default_user__c = true);
        Insert ownerKeyUser;
    }
    
}