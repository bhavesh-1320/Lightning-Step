global with sharing class ClientAdmissionStatus implements Database.Batchable<SObject>, Database.Stateful , Database.AllowsCallouts{
    List<Lightning_Step__Inquiry__c> inquiryList=new List<Lightning_Step__Inquiry__c>();
    List<Lightning_Step__Inquiry__c>responseList=new  List<Lightning_Step__Inquiry__c>();
    //Fetch all the Admitted Client from Salesforce Org.
    global Database.QueryLocator start(Database.BatchableContext BC){
        string status='Admitted';
        String query;
        if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c')) {
            query = 'SELECT Id,Lightning_Step__Inquiry_Id__c FROM Lightning_Step__Inquiry__c WHERE Lightning_Step__Status__c =:status';
            return Database.getQueryLocator(query);
        } else {
            return null;
        }
    }
    // Check all the admitted clients status from Lighting Step.
    global void execute (Database.Batchablecontext BC, list<Lightning_Step__Inquiry__c> listOfInquiry){
        List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
        if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
          fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')) {
            apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null Limit 1];
        }
        string pubkey;
        string seckey1;
        if(apiAccess.size()>0){
            String algorithmName1 = 'AES256';
            String orgId1 = UserInfo.getOrganizationId();
            string keyValue1='CYNTEXALABCYSP'+orgId1;
            Blob pvtKey1 = Blob.valueOf(keyValue1);
            Blob pbKey1 = EncodingUtil.base64Decode(apiAccess[0].Lightning_Step__Client_Secret__c);
            Blob scKey1 = EncodingUtil.base64Decode(apiAccess[0].Lightning_Step__Client_Secret_key__c);
            Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, pbKey1 );
            Blob decr2se = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, scKey1 );
            pubkey=decrpb.tostring();
            seckey1=decr2se.tostring();
            string accessToken= CalloutClass.getAccessToken(pubkey,seckey1);  
            if(accessToken!='The status code returned was not expected:')
            {
                string result;
                string payload;  
                List<Lightning_Step__OwnerKeyValPerUser__c> orgDefaultUser = new List<Lightning_Step__OwnerKeyValPerUser__c>();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                       orgDefaultUser = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c  from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__Set_User_as_default_user__c=true  limit 1];
                   }
                if(orgDefaultUser.size()>0)    
                {
                    String algorithmName = 'AES256';
                    String orgId = UserInfo.getOrganizationId();
                    string keyValue='CYNTEXALABCYLS'+orgId;
                    Blob pvtKey = Blob.valueOf(keyValue);
                    Blob pbKey = EncodingUtil.base64Decode(orgDefaultUser[0].Lightning_Step__OwnerKey__c);
                    Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                    
                    payload=decr.toString();  
                }
                
                else
                {
                    Lightning_Step__OwnerKeyValPerUser__c newaccess = new Lightning_Step__OwnerKeyValPerUser__c();
                    string userId=UserInfo.getUserId();
                    if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c')) {
                        newaccess = [select Lightning_Step__OwnerKey__c  from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:userId limit 1];
                    }
                    String algorithmName = 'AES256';
                    String orgId = UserInfo.getOrganizationId();
                    string keyValue='CYNTEXALABCYLS'+orgId;
                    Blob pvtKey = Blob.valueOf(keyValue);
                    Blob pbKey = EncodingUtil.base64Decode(newaccess.Lightning_Step__OwnerKey__c);
                    Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                    payload=decr.toString();
                }
                JSONGenerator jsonGen = JSON.createGenerator(true);
                jsonGen.writeStartArray();
                
                for(Lightning_Step__Inquiry__c inquiry:listOfInquiry)
                {
                    jsonGen.writeString(inquiry.Lightning_Step__Inquiry_Id__c);
                    
                }
                jsonGen.writeEndArray();
                
                String jsonData = jsonGen.getAsString();
                string Jsonpayload='{"owner_key":'+'"'+payload+'",'+'"inquiry_ids":'+jsonData+'}';
                string resultInquiry=CalloutClass.checkBulkStatus(accessToken,JsonPayload);
                Map<String, Object> m =  (Map<String, Object>)JSON.deserializeUntyped(resultInquiry);
                List<Object> ideals = (List<Object>) m.get('success'); 
                //Map<String,Object> mpParsed=new  Map<String,Object>();
                for(Object ideal : ideals)
                {
                    Map<String,Object> mpParsed=(Map<String,Object>) ideal;
                    Map<String,Object>Paresed=(Map<String,Object>)mpParsed.get('original');
                    Map<String,Object>Paresed1=(Map<String,Object>)Paresed.get('data');
                    Lightning_Step__Inquiry__c lt=new Inquiry__c();
                    lt.Lightning_Step__Inquiry_Id__c=string.valueOf(paresed1.get('inquiry_id'));
                    lt.Lightning_Step__Status__c=string.valueOf(paresed1.get('status'));
                    lt.Lightning_Step__Reason_Of_Discharge__c=string.valueOf(paresed1.get('dctype'));
                    lt.Lightning_Step__Last_Checked_Status__c=System.now();
                    if(paresed1.get('datedischarge')!=null){
                        string dischargedate=string.valueOf(paresed1.get('datedischarge')); 
                        lt.Lightning_Step__Discharge_Date__c=date.valueOf(dischargedate);
                    }
                    responseList.add(lt);
                }
            }
        }
        
    }
    
    // Update all the Admitted Client records.
    global void finish(Database.Batchablecontext BC){
        try{
            if(responseList.size()>0)
            {
                if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Discharge_Date__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_Of_Discharge__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__Inquiry__c') && 
                   fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Discharge_Date__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') && 
                   fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_Of_Discharge__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c')) {
                       update responseList;
                   }
            }
        }
        catch(exception e)
        {
            system.debug('e'+e.getMessage());
        }
    }
    
}