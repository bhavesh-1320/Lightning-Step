@isTest
public class InsuranceCmpClassTest {
	// Get Insurance records.
    public static testmethod void testGetInsRec() {   
        Lightning_Step__LMR_Insurance__c ins = new Lightning_Step__LMR_Insurance__c(Lightning_Step__MC_Name__c = 'test1',Lightning_Step__MC_Contract_ID__c = 11);
        Insert ins;
        Test.startTest();
        List<Lightning_Step__LMR_Insurance__c> listOfResponse = InsuranceCmpClass.getInsuranceRecs('1','1');
        Test.stopTest();
        System.assert(listOfResponse != null);
    }
    //Test Insurance API when User is Default User.
    public static testmethod void testGetInsurance() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        Lightning_Step__API_EndPoints__c insurance = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/v1/tableshow/mccontracts',Name = 'MC Contract Insurance');
        Insert insurance;
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('MC Contract Insurance'),new CalloutClassMockTestProgrambyLocation('Insurance'));
        Lightning_Step__API_Keys__c cred = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert cred;
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        String response = InsuranceCmpClass.getInsurance();
        Test.stopTest();
        
        
        //Assert
        System.assert(response != null);
        System.assert(response.contains('success'));
        DELETE cred;
        response = InsuranceCmpClass.getInsurance();
    }
}