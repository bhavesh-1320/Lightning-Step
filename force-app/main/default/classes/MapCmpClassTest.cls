@isTest
public class MapCmpClassTest {
	@isTest
    static void unitTest1(){
        Map<String, String> inqNameLabelMap = MapCmpClass.getInqFields('1');
        List<Lightning_Step__Field_Mapping__c> prevMaps = MapCmpClass.checkObjName('Lead');
        System.assert(prevMaps.size() == 0);
        List<String> searchFields = MapCmpClass.getObjFields( 'lea', 'Lead' );
        System.assert(searchFields.size()>0);
        Map<String, Map<String,String>> upsetingBody = new Map<String, Map<String,String>>();
        upsetingBody.put( 'Lightning_Step__Insured_First_Name__c', new Map<String,String>() );
        upsetingBody.get( 'Lightning_Step__Insured_First_Name__c' ).put( null, 'FirstName' );
        String response = MapCmpClass.saveMapping( upsetingBody, 'Lead' );
    	System.assert(response=='inserted');
    }
    public static testmethod void testGetPickFields() {
        
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        Lightning_Step__API_EndPoints__c pickFields = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/v1/tableexport',Name = 'Picklist Fields');
        Insert pickFields;
        Lightning_Step__API_EndPoints__c stateApi = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://apitest.lightningstep.com/api/v1/demographicstatelist',Name = 'Demographic States');
        INSERT stateApi;
        
        Lightning_Step__API_EndPoints__c countryApi = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://testapi.lightningstep.com/api/v1/demographiccountrylist',Name = 'Demographic Countries');
        INSERT countryApi;
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Picklist Fields'),new CalloutClassMockTestProgrambyLocation('PicklistFields'));
        endpoint2TestResp.put( mapOfEndPointURL.get('Demographic States'),new CalloutClassMockTestProgrambyLocation('State') );
        endpoint2TestResp.put( mapOfEndPointURL.get('Demographic Countries'),new CalloutClassMockTestProgrambyLocation('State') );
        Lightning_Step__API_Keys__c cred = new Lightning_Step__API_Keys__c(Lightning_Step__Client_Secret_key__c='DDNyoPqe0nkEFQkaeVycVkiaaW2+czh/8N2v0w64sW5T2FMZyuMAHosyjTwZ3e80B7V4DPUysxrcX32liSZo+A==',Lightning_Step__Client_Secret__c ='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==', Lightning_Step__Bearer_Token__c='QSN8vPwURnwC1WmNjDhZlha7wQd4i+1QY5/LOtwi8CQlV+sYYvsmjYdAphG87zAKgtQBX/Tk6xsjdNYD+uiWqQ==');
        Insert cred;
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        Map<String, Map<String, Map<String, String>>> response = MapCmpClass.getPickFields();
        Test.stopTest();
        
        
        //Assert
        System.assert(response != null);
        //System.assert(response.contains('success'));
        //DELETE cred;
        //response = InsuranceCmpClass.getInsurance();
    }
    public static testmethod void testSyncPickFields() {
        Map<String, String> values = new Map<String, String>();
        values.put( 'Ak','Ak' );
        values.put( 'AL','AL' );
        Map<String,String> mapOfEndPointURL = new Map<String,String>();
        Lightning_Step__API_EndPoints__c pickFields = new Lightning_Step__API_EndPoints__c(Lightning_Step__End_Point_URL__c = 'https://lightningstep-dev-ed.my.salesforce.com/services/data/v41.0/tooling/sobjects/CustomField/',Name = 'Tooling Api');
        Insert pickFields;
        List<Lightning_Step__API_EndPoints__c> endPointURLS = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c];
        for(Lightning_Step__API_EndPoints__c endPointURL : endPointURLS) {
            mapOfEndPointURL.put(endPointURL.Name,endPointURL.Lightning_Step__End_Point_URL__c);
        }
        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put(mapOfEndPointURL.get('Tooling Api'),new CalloutClassMockTestProgrambyLocation('UpdatePickFields'));   
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);
        Test.startTest();
        //Act
        String response = MapCmpClass.syncPickFields( values, 'Employer', 'Lightning_Step__Employer__c', '123456789' );
        Test.stopTest();
        
        
        //Assert
        System.assert(response != null);
        
    }
}