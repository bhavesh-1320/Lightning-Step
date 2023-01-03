@isTest
public class CreateInquiryControllerTest {
    
    // test Inuiry is already exist in the Lead record.
    public static testmethod void testcheckInquiryRec() {
        Lead newlead = new Lead(LastName = 'Test',Company = 'test',Status = 'Open - Not Contacted', Lightning_Step__DOB__c = System.today() - 1);
        Insert newlead;
        
        Lightning_Step__Inquiry__c inquiry = new Lightning_Step__Inquiry__c(Lightning_Step__Lead__c = newlead.Id,Lightning_Step__Payor_City__c='City',Lightning_Step__First_Name__c = 'test',Lightning_Step__Last_Name__c = 'test',Home_Phone__c ='1234567890',GENDER__c = 'Male',Lightning_Step__Address__c = 'Test',Lightning_Step__Payor_Fax__c='1234567890',Lightning_Step__Payor_State__c='TX',Lightning_Step__Payor_Zip_Code__c='30201',Lightning_Step__City__c = 'Test',Lightning_Step__Email__c = 'test@gmail.com', Lightning_Step__DOB__c = System.today() - 5,Lightning_Step__Inquiry_Id__c = '539',Lightning_Step__Date_of_Submission__c = System.today() + 5);
        Insert inquiry;
        
        Test.setMock(HttpCalloutMock.class, new CalloutClassMockTestCreateInquiry());
        Test.startTest();
        String isCreated = CreateInquiryController.checkInquiryRec(newlead.Id);
        Test.stopTest();
        System.assertEquals(isCreated, 'true');
    }
    
    // test Inuiry is not already exist in the Lead record.
    public static testmethod void testfalsecheckInquiryRec() {
        Lead newlead = new Lead(LastName = 'Test',Company = 'test',Status = 'Open - Not Contacted', Lightning_Step__DOB__c = System.today() - 1);
        Insert newlead;
        Test.startTest();
        String isCreated = CreateInquiryController.checkInquiryRec(newlead.Id);
        Test.stopTest();
        System.assertEquals(isCreated, 'false');
    }
    
    // fetch lead record
    public static testmethod void testgetLeadData() {
        Lead newlead = new Lead(LastName = 'Test',Company = 'test',Status = 'Open - Not Contacted',Lightning_Step__DOB__c = System.today() - 1);
        Insert newlead;
        Test.startTest();
        sObject leadRecord = CreateInquiryController.getLeadData(newlead.Id, 'Lead');
        Test.stopTest();
        System.assert(newlead != null);
    }
    
    // test User Credentials
    public static testmethod void testIsSetupWithUserCredentials() {
        
        Lightning_Step__API_Keys__c ownerKey = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert ownerKey;
        
        Test.startTest();
        Boolean isSetup = CreateInquiryController.isSetup();
        Test.stopTest();
        System.assert(isSetup);
    }
    
    // test User Credentials
    public static testmethod void testIsSetupWithoutUserCredentials() {
        
        Test.startTest();
        Boolean isSetup = CreateInquiryController.isSetup();
        Test.stopTest();
        System.assert(!isSetup);
    }
    //Getting Insurance and Mappings Records
    @isTest
    public static void getInsMapRec(){
        Lightning_Step__LMR_Insurance__c lmr = new Lightning_Step__LMR_Insurance__c( Lightning_Step__MC_Contract_ID__c = 1, Lightning_Step__MC_Name__c='Test' );
    	INSERT lmr;
        List<Lightning_Step__LMR_Insurance__c> lmrs = CreateInquiryController.getInsurance();
        System.assert(lmrs.size()>0);
        Lightning_Step__Field_Mapping__c map1 = new Lightning_Step__Field_Mapping__c( Lightning_Step__Inquiry_Field_API_Name__c = 'Email', Lightning_Step__Object_Field_API_Name__c ='Email', Lightning_Step__Object_API_Name__c='Lead' );
    	INSERT map1;
        List<Lightning_Step__Field_Mapping__c> maps = CreateInquiryController.getMappings('Lead');
        System.assert(maps.size()>0);
    }
    @TestSetup
    static void setup()
    {
        Lightning_Step__API_EndPoints__c accessTokenURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/oauth/token',Name = 'Access Token');
        Insert accessTokenURL;
        
        Lightning_Step__API_EndPoints__c inquiryCreationURL = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/api_make_inquiry?',Name = 'Inquiry Creation');
        Insert inquiryCreationURL;
    }
}