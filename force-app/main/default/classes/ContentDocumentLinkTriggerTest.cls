@isTest
public class ContentDocumentLinkTriggerTest {
	@isTest
    public static void unitTest1(){
        Test.startTest();
        Lightning_Step__Inquiry__c inq =new Lightning_Step__Inquiry__c(Lightning_Step__First_Name__c='Test',Lightning_Step__Last_Name__c='123',
                                                                       Lightning_Step__GENDER__c='Male',Lightning_Step__DOB__c=System.Today(),
                                                                       Lightning_Step__Home_Phone__c='1234567890',Lightning_Step__Email__c='ab@gmail.com',
                                                                       Lightning_Step__City__c='Ab', Lightning_Step__Postal_Code__c='12354',Lightning_Step__Address__c='abb',
                                                                       Lightning_Step__State_Province__c='Ak',Lightning_Step__Payor_Address__c='ab',Lightning_Step__Payor_Fax__c='aa',
                                                                       Lightning_Step__Payor_City__c='aaa',Lightning_Step__Payor_State__c='Ak',Lightning_Step__Payor_Zip_Code__c='12345',
                                                                       Lightning_Step__Inquiry_Id__c='123'
                                                                      );
        insert inq; 
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        Lightning_Step__API_EndPoints__c doc = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = '',Name = 'Upload Document');
        Insert doc;
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('https://testapi.lightningstep.com/api/v1/uploadeddoccreate?',new CalloutClassMockTestProgrambyLocation('Doc'));
        
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        ContentVersion content=new ContentVersion(); 
        content.Title='Header_Picture1'; 
        content.PathOnClient='/' + content.Title + '.jpg'; 
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        content.VersionData=bodyBlob; 
        //content.LinkedEntityId=sub.id;
        content.origin = 'H';
        insert content;
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=inq.id;
        contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
        contentlink.ShareType = 'I';
        contentlink.Visibility = 'AllUsers'; 
        
        
        insert contentlink;
        System.assert(contentlink.Id != null);
        Test.stopTest();
    }
}