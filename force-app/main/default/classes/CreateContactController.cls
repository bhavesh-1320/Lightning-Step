public class CreateContactController {
    //It create contact in lightning step
    @AuraEnabled
    public static String CreateContact(string ConId)
    {
        try{
            List<Lightning_Step__Lightning_Step_Contact__c> Contact = new List<Lightning_Step__Lightning_Step_Contact__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Lightning_Step_Contact__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Last_Name__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Gender__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Direct_Phone__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Home_Phone__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Role__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Category__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__E_Mail__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Relation_to_Client__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Address__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Address_Line_2__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__City__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__State_Province__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Postal_Code__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Office_Phone__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Fax__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__DOB__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Lightning_Step_Contact_Id__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Mobile_Phone__c')) {
                   Contact=[SELECT Id,Lightning_Step__Last_Name__c,Lightning_Step__Mobile_Phone__c,Lightning_Step__First_Name__c, Lightning_Step__Gender__c,Lightning_Step__Direct_Phone__c, 
                            Lightning_Step__Home_Phone__c, Lightning_Step__Role__c, Lightning_Step__Category__c,Lightning_Step__E_Mail__c,
                            Lightning_Step__Relation_to_Client__c, Lightning_Step__Address__c, Lightning_Step__Address_Line_2__c,Lightning_Step__Organization__c, 
                            Lightning_Step__City__c, Lightning_Step__State_Province__c, Lightning_Step__Postal_Code__c, Lightning_Step__Office_Phone__c,
                            Lightning_Step__Fax__c, Lightning_Step__DOB__c,Lightning_Step__Lightning_Step_Contact_Id__c, Lightning_Step__Inquiry__c FROM Lightning_Step__Lightning_Step_Contact__c WHERE Id=:ConId LIMIT 1];
               }
            List<Lightning_Step__Inquiry__c> Inquiry = new List<Lightning_Step__Inquiry__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__First_Name__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Name__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Client_Id__c')) {
                   Inquiry = [SELECT Id,Lightning_Step__Client_Id__c, Lightning_Step__Inquiry_Id__c,Lightning_Step__First_Name__c,Lightning_Step__Last_Name__c FROM Lightning_Step__Inquiry__c  WHERE Id=:contact[0].Lightning_Step__Inquiry__c LIMIT 1];
               }
            String locationpayload;
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
                    
                    locationpayload=decr.toString();  
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
                    locationpayload=decr.toString();
                }
                string JsonPayload='{"fname":'+'"'+contact[0].Lightning_Step__First_Name__c+'",'+'"lname":'+'"'+contact[0].Lightning_Step__Last_Name__c+'",'+'"fax":'+'"'+contact[0].Lightning_Step__Fax__c+'",'+'"city":'+'"'+contact[0].Lightning_Step__City__c+'",'+'"usstate":'+'"'+contact[0].Lightning_Step__State_Province__c+'",'+'"zip":'+'"'+contact[0].Lightning_Step__Postal_Code__c+'",'+'"address":'+'"'+contact[0].Lightning_Step__Address__c+'",'+'"address2":'+'"'+contact[0].Lightning_Step__Address_Line_2__c+'",'+'"reltoclient":'+'"'+contact[0].Lightning_Step__Relation_to_Client__c+'",'+'"category":'+'"'+contact[0].Lightning_Step__Category__c+'",'+'"role":'+'"'+contact[0].Lightning_Step__Role__c+'",'+'"role":'+'"'+contact[0].Lightning_Step__Role__c+'",'+'"ophone":'+'"'+contact[0].Lightning_Step__Office_Phone__c+'",'+'"orgname":'+'"'+contact[0].Lightning_Step__Organization__c+'",'+'"hphone":'+'"'+contact[0].Lightning_Step__Home_Phone__c+'",'+'"email":'+'"'+contact[0].Lightning_Step__E_Mail__c+'",'+'"dphone":'+'"'+contact[0].Lightning_Step__Direct_Phone__c+'",'+'"cphone":'+'"'+contact[0].Lightning_Step__Mobile_Phone__c+'",'+'"inquiry_id":'+'"'+Inquiry[0].Lightning_Step__Inquiry_Id__c+'",'+'"owner_key":'+'"'+locationpayload+'"}';
                JsonPayload=JsonPayload.replace('null', '');
                string accessToken = CalloutClass.getAccessToken(pubkey,seckey1);
                if(accessToken == 'Client Id and Client Secret is Invalid') {
                    return accessToken;
                }
                if(!accessToken.contains('The status code returned was not expected:'))
                {
                    string ResultOfCreateContact=CalloutClass.createContact(accessToken,JsonPayload);
                    if(ResultOfCreateContact.contains('Owner Key')) {
                        return ResultOfCreateContact;
                    }
                    if(ResultOfCreateContact.contains('The status code returned was not expected:'))  
                    { 
                        return ResultOfCreateContact;
                    }
                    else
                    {
                        Map<String, Object> m =  (Map<String, Object>)JSON.deserializeUntyped(ResultOfCreateContact);
                        Map<String, Object>  objectMap = (Map<String, Object>) m.get('data');
                        if(Inquiry[0].Lightning_Step__Inquiry_Id__c==string.valueOf(ObjectMap.get('inquiry_id')))
                        {
                            contact[0].Lightning_Step__Lightning_Step_Contact_Id__c= string.valueOf(objectMap.get('contact_id')); 
                            if(fieldlevelsecurity.canReadObject('Lightning_Step__Lightning_Step_Contact__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Lightning_Step_Contact_Id__c') &&
                              fieldlevelsecurity.canUpdateObject('Lightning_Step__Lightning_Step_Contact__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Lightning_Step_Contact_Id__c')) {
                                 update contact[0];
                            }
                        }
                        return 'success';  
                    }
                }
                else
                {
                    return accessToken;
                }
            }
            else
            {
                return  'Client Id and Secret key Missing';
            }
        }
        catch(exception e)
        {
            return null;
        }
    }
    //It creates an Admission in lightning step 
    @AuraEnabled
    public static String AdmitClient(string InquiryId)
    {
        try{
            List<Lightning_Step__Inquiry__c> Inquiry = new List<Lightning_Step__Inquiry__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__First_Name__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Name__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__inquiry_Id__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Date_of_Submission__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Locations__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Program__c')) {
                   Inquiry=[SELECT Id, Lightning_Step__inquiry_Id__c,Lightning_Step__First_Name__c,Lightning_Step__Last_Name__c,Lightning_Step__Program__r.Program_Id__c,Lightning_Step__Program__c,Lightning_Step__Locations__c,Lightning_Step__Locations__r.Location_Id__c,Lightning_Step__Date_of_Submission__c FROM Lightning_Step__Inquiry__c  WHERE Id=:InquiryId LIMIT 1];
               }
            String locationpayload;
            
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
                    
                    locationpayload=decr.toString();  
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
                    
                    locationpayload=decr.toString();
                    // locationpayload=newaccess.OwnerKey__c;
                }
                string Submissiondate =string.valueOfGmt(Inquiry[0].Lightning_Step__Date_of_Submission__c);
                string JsonPayload='{'+'"inquiry_id":'+'"'+Inquiry[0].Lightning_Step__inquiry_Id__c+'",'+'"location_id":'+'"'+Inquiry[0].Lightning_Step__Locations__r.Location_Id__c+'",'+'"dateadmission":'+'"'+Submissiondate+'",'+'"program_id":'+'"'+Inquiry[0].Lightning_Step__Program__r.Program_Id__c+'",'+'"owner_key":'+'"'+locationpayload+'"}';
                string accessToken=CalloutClass.getAccessToken(pubkey,seckey1);
                if(accessToken == 'Client Id and Client Secret key is Invalid') {
                    return accessToken;
                }
                if(!accessToken.contains('The status code returned was not expected:'))
                {
                    string ResultOfCreateContact=CalloutClass.admitClient(accessToken,JsonPayload);
                    if(ResultOfCreateContact.contains('Owner Key')) {
                        return ResultOfCreateContact;
                    }
                    if(ResultOfCreateContact.contains('The status code returned was not expected:'))  
                    { 
                        return ResultOfCreateContact;
                    }
                    else
                    {
                        Map<String, Object> m =  (Map<String, Object>)JSON.deserializeUntyped(ResultOfCreateContact);
                        Map<String, Object>  objectMap = (Map<String, Object>) m.get('data'); 
                        Inquiry[0].Lightning_Step__Client_Id__c=string.valueOf(objectMap.get('client_id'));
                        Inquiry[0].Lightning_Step__mrn_Number__c=string.valueOf(objectMap.get('mrn'));
                        Inquiry[0].Lightning_Step__status__c='Admitted';
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Client_Id__c') &&
                           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__mrn_Number__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__status__c') &&
                           fieldlevelsecurity.canUpdateObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__status__c') &&
                           fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Client_Id__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__mrn_Number__c')) {
                               update Inquiry[0];
                           }
                        return 'success'+','+string.valueof(objectMap.get('inquiry_id'))+','+string.valueof(objectMap.get('client_id'))+','+string.valueof(objectMap.get('mrn'));  
                    }
                }
                else
                {
                    return accessToken;
                }
            } 
            
            else
            {
                return 'Client Id and Secret Key Missing';
            }
        }
        catch ( exception e)
        {
            return null;
        }
    }
    //it checks the admission status of client in lightning step
    @AuraEnabled
    public static String CheckAdmitStatus(string inquiryId)
    {
        try{
            
            List<Lightning_Step__Inquiry__c> Inquiry = new List<Lightning_Step__Inquiry__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__First_Name__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Name__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__inquiry_Id__c') &&
                fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__status__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Client_Id__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_Of_Discharge__c')) {
                   Inquiry=[SELECT Id, Lightning_Step__Client_Id__c ,Lightning_Step__inquiry_Id__c,Lightning_Step__status__c,Lightning_Step__First_Name__c,Lightning_Step__Last_Name__c,Lightning_Step__Reason_Of_Discharge__c FROM Lightning_Step__Inquiry__c  WHERE Id=:inquiryId LIMIT 1];
               }
            String locationpayload;
            
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
                
                if(Inquiry[0].inquiry_Id__c!=null && Inquiry[0].Lightning_Step__Client_Id__c!=null){
                    
                    List<Lightning_Step__OwnerKeyValPerUser__c> orgDefaultUser = new List<Lightning_Step__OwnerKeyValPerUser__c>();
                    string result;
                    string payload;  
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
                        
                        locationpayload=decr.toString();  
                    }
                    else
                    {
                        Lightning_Step__OwnerKeyValPerUser__c newaccess = new Lightning_Step__OwnerKeyValPerUser__c();
                        string userId=UserInfo.getUserId();
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
                          fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                            newaccess = [select Lightning_Step__OwnerKey__c  from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:userId limit 1];
                        }
                        String algorithmName = 'AES256';
                        String orgId = UserInfo.getOrganizationId();
                        string keyValue='CYNTEXALABCYLS'+orgId;
                        Blob pvtKey = Blob.valueOf(keyValue);
                        Blob pbKey = EncodingUtil.base64Decode(newaccess.Lightning_Step__OwnerKey__c);
                        Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                        
                        locationpayload=decr.toString();
                    }
                    //string JsonPayload='{"inquiry_id":'+'"'+Inquiry[0].inquiry_Id__c+'",'+'"owner_key":'+'"'+locationpayload+'"}';
                    Map<String, String> JsonPayload = new Map<String, String>();
                    JsonPayload.put('inquiry_id',Inquiry[0].Lightning_Step__inquiry_Id__c);
                    JsonPayload.put('owner_key',locationpayload);
                    string accessToken=CalloutClass.getAccessToken(pubkey,seckey1);
                    if(accessToken == 'Client Id and Client Secret key is Invalid') {
                        return accessToken;
                    }
                    if(!accessToken.contains('The status code returned was not expected:'))
                    {
                        string ResultOfCreateContact=CalloutClass.admissionClientStatus(accessToken,JSON.Serialize(JsonPayload));
                        if(ResultOfCreateContact.contains('Owner Key')) {
                            return ResultOfCreateContact;
                        }
                        if(ResultOfCreateContact.contains('The status code returned was not expected:'))  
                        { 
                            return ResultOfCreateContact;
                        }
                        else
                        {
                            Map<String, Object> m =  (Map<String, Object>)JSON.deserializeUntyped(ResultOfCreateContact);
                            Map<String, Object>  objectMap = (Map<String, Object>) m.get('data');
                            if(string.valueOf(ObjectMap.get('status'))=='Discharged')
                            { 
                                Inquiry[0].Lightning_Step__Status__c= string.valueOf(objectMap.get('status'));
                                if(string.valueOf(objectMap.get('datedischarge')) != null) {
                                    string dischargedate=string.valueOf(objectMap.get('datedischarge')); 
                                    Inquiry[0].Lightning_Step__Discharge_Date__c= date.valueOf(dischargedate);
                                }
                                Inquiry[0].Lightning_Step__Reason_Of_Discharge__c= string.valueOf(ObjectMap.get('dctype'));
                                Inquiry[0].Lightning_Step__Last_Checked_Status__c=System.now();
                                if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') &&
                                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Discharge_Date__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_Of_Discharge__c') &&
                                   fieldlevelsecurity.canUpdateObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_Of_Discharge__c') &&
                                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c') &&
                                   fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Discharge_Date__c')) {
                                       
                                       update Inquiry[0];
                                   }
                                return 'success'+','+string.valueOf(objectMap.get('status')); 
                            }
                            else
                            {
                                Inquiry[0].Lightning_Step__Status__c= string.valueOf(objectMap.get('status'));
                                Inquiry[0].Lightning_Step__Last_Checked_Status__c=System.now();
                                
                                if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') &&
                                   fieldlevelsecurity.canUpdateObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') &&
                                   fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Checked_Status__c')) {
                                       update Inquiry[0];
                                   }
                                
                                update Inquiry[0];
                                return 'success'+','+string.valueOf(objectMap.get('status'));
                                
                            }
                        }
                    }
                    else
                    {
                        return accessToken;
                    }
                }
                else
                {
                    return 'IdExist';
                } 
            }
            else
            {
                return 'Client Id And Secret Key Missing';
            }
        }
        catch(exception e)
        {
            return null;
        }
    }
    
    // It will return list of Program records according to Location Id and Search Key.
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(Id locationId, String ObjectName,String searchKeyWord) {
        try {
            List < sObject > returnList = new List < sObject > ();
            
            // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5  
            String sQuery = '';
            String searchString = '%'+searchKeyWord+'%';
            if(String.isNotBlank(searchKeyWord)){
                
                sQuery =  'select id, Name from ' +ObjectName + ' where Lightning_Step__Locations__c =:locationId AND Name LIKE :searchString order by createdDate DESC LIMIT 5';
            }else{
                sQuery =  'select id, Name from ' +ObjectName + ' where Lightning_Step__Locations__c =:locationId order by createdDate DESC LIMIT 5';
            }
            List <sObject> lstOfRecords = new List <sObject> ();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Name')) {
                lstOfRecords = Database.query(sQuery);
            }
            for (sObject obj: lstOfRecords) {
                returnList.add(obj);
            }
            return returnList;
        } catch(Exception e) {
            return null;
        }
    }

    // It will check client already admit or not in the Inquiry record.
	@AuraEnabled
    public static Boolean isAdmitClient(string inquiryId) {
        
        try {
            Boolean isAdmit;
            Lightning_Step__Inquiry__c Inquiry = new Lightning_Step__Inquiry__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Client_Id__c')) {
                Inquiry = [SELECT Id, Lightning_Step__Client_Id__c FROM Inquiry__c  WHERE Id =:inquiryId LIMIT 1];
            }
            if(Inquiry.Lightning_Step__Client_Id__c == null) {
                return True;
            } else {
                return False;
            }
            
        } catch(Exception e) {
            return null;
        }
    }    
    
    // It will check client already admit or not in the Inquiry record.
    @AuraEnabled
    public static void deleteContact(string contactId) {
        try {
            Lightning_Step__Lightning_Step_Contact__c con = new Lightning_Step__Lightning_Step_Contact__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Lightning_Step_Contact__c')) {
                con = [SELECT Id FROM Lightning_Step__Lightning_Step_Contact__c  WHERE Id =:contactId LIMIT 1];
                
            }
            if(con != null) {
                if(fieldlevelsecurity.canDeleteObject('Lightning_Step__Lightning_Step_Contact__c') && fieldlevelsecurity.canReadObject('Lightning_Step__Lightning_Step_Contact__c')) {
                    delete con;
                }
            }
        } catch(Exception e) {
            
        }
    }     
    
    @AuraEnabled
    public static Boolean isSetup() {
        try {
            Boolean setup;
            List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')) {
                   apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null Limit 1];
               }
            if(apiAccess.size() == 0) {
                setup = false;
            } else {
                setup = true;
            }
            return setup;
        } catch(Exception e) {
            return false;
        }
    }
}