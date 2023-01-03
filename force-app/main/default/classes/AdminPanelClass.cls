public class AdminPanelClass {
    
    //This  is used to fetch the client Id and secret key
    @AuraEnabled
    public static string  showLoginDetail()
    {
        try{
            string logindetail;
            System.debug('HiiE');
            List<Lightning_Step__API_Keys__c> access = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') &&
              fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   access = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c, Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null AND Lightning_Step__Bearer_Token__c !=null Limit 1];
               }
				System.debug('Ac:'+access);
            if(access.size()>0){
                System.debug('HInside');
                String algorithmName = 'AES256';
                String orgId = UserInfo.getOrganizationId();
                string keyValue='CYNTEXALABCYSP'+orgId;
                Blob pvtKey = Blob.valueOf(keyValue);
                Blob pbKey = EncodingUtil.base64Decode(access[0].Lightning_Step__Client_Secret__c);
                Blob scKey = EncodingUtil.base64Decode(access[0].Lightning_Step__Client_Secret_key__c);
                Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                Blob decr2 = Crypto.decryptWithManagedIV(algorithmName, pvtKey, scKey );
                Blob bKey = EncodingUtil.base64Decode(access[0].Lightning_Step__Bearer_Token__c);
                Blob decr3 = Crypto.decryptWithManagedIV(algorithmName, pvtKey, bKey );
                logindetail=decr.toString()+' '+ decr2.toString()+' '+ decr3.toString();
                System.debug('Here:'+logindetail);
                
            }
            return logindetail;
        }
        catch(exception e)
        {
            System.debug(e);
            return null;
        }
        
    }
    //This is to update  or insert client Id and secret key and api key
    @AuraEnabled
    public static string EditloginDetail(string clientId ,string clientSecret, string apiKey)
    {
        try{
            System.debug('HEL');
            List<Lightning_Step__API_Keys__c> access = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   access = [select Lightning_Step__Client_Secret_key__c, Lightning_Step__Bearer_Token__c, Lightning_Step__Client_Secret__c,LastModifiedDate from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null AND Lightning_Step__Bearer_Token__c !=null Limit 1];
               }
            string modifiedDate;
            if(access.size()>0){
                String algorithmName = 'AES256';
                String orgId = UserInfo.getOrganizationId();
                string key='CYNTEXALABCYSP'+orgId;
                Blob privateKey = Blob.valueOf(key);
                Blob encryptedValue2 = Blob.valueOf(clientId);
                Blob encryptedValue3 = Blob.valueOf(clientSecret);
                Blob encrptClientId = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue2);
                string encrptClientIdbase64 = EncodingUtil.base64Encode(encrptClientId);
                Blob encrptSecretkey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue3);
                string encrptSecretkeybase64 = EncodingUtil.base64Encode(encrptSecretkey);
                
                Blob encryptedValue4 = Blob.valueOf(apiKey);                
                Blob encrptApiKey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue4);
                string encrptApiKeybase64 = EncodingUtil.base64Encode(encrptApiKey);
                
                access[0].Lightning_Step__Client_Secret__c=encrptClientIdbase64;
                access[0].Lightning_Step__Client_Secret_key__c=encrptSecretkeybase64;
                access[0].Lightning_Step__Bearer_Token__c = encrptApiKeybase64; 
                    
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__API_Keys__c') && 
                   fieldlevelsecurity.canUpdateField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') && 
                   fieldlevelsecurity.canUpdateField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') &&
                   fieldlevelsecurity.canUpdateField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                       update access[0];
                   }
                modifiedDate=string.valueOfGmt(access[0].lastmodifieddate);  
            }  
            else
            {
                String algorithmName = 'AES256';
                String orgId = UserInfo.getOrganizationId();
                string key='CYNTEXALABCYSP'+orgId;
                Blob privateKey = Blob.valueOf(key);
                Blob encryptedValue2 = Blob.valueOf(clientId);
                Blob encryptedValue3 = Blob.valueOf(clientSecret);
                Blob encrptClientId = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue2);
                string encrptClientIdbase64 = EncodingUtil.base64Encode(encrptClientId);
                Blob encrptSecretkey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue3);
                string encrptSecretkeybase64 = EncodingUtil.base64Encode(encrptSecretkey);
                
                Blob encryptedValue4 = Blob.valueOf(apiKey);                
                Blob encrptApiKey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue4);
                string encrptApiKeybase64 = EncodingUtil.base64Encode(encrptApiKey);
                System.debug('INSIDE:');
                List<Lightning_Step__API_Keys__c> newOwnerKeys= [select Lightning_Step__Client_Secret_key__c, Lightning_Step__Bearer_Token__c, Lightning_Step__Client_Secret__c,LastModifiedDate from Lightning_Step__API_Keys__c];
                Lightning_Step__API_Keys__c newOwnerKey;
                System.debug('NE:'+newOwnerKey);
                if( newOwnerKeys.size()>0 ){
                    newOwnerKey = newOwnerKeys[0];
                }else{
                    newOwnerKey = new Lightning_Step__API_Keys__c();
                }
                newOwnerKey.Lightning_Step__Client_Secret__c=encrptClientIdbase64;
                newOwnerKey.Lightning_Step__Client_Secret_key__c=encrptSecretkeybase64;
                newOwnerKey.Lightning_Step__Bearer_Token__c = encrptApiKeybase64;
                
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canCreateObject('Lightning_Step__API_Keys__c')) {
                   upsert newOwnerKey;
                }
                Lightning_Step__API_Keys__c newaccess = new Lightning_Step__API_Keys__c();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') && 
                   fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                       newaccess = [select Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c,LastModifiedDate, Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where Id=:newOwnerKey.Id];
                   }
                modifiedDate=string.valueOfGmt(newaccess.lastmodifieddate);      
            }
            return modifiedDate;
        }
        catch(exception e)
        {
            System.debug(e);
            return null;
        }
    }
    //It checks that the custom setting Api credential has some value or not
    @AuraEnabled
    public static boolean showdetail()
    {
        try{
            List<Lightning_Step__API_Keys__c> access = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   access = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c, 
                             Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where 
                             Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null 
                             AND Lightning_Step__Bearer_Token__c != null Limit 1];
               }
            if(access.size()>0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch(exception e)
        {
            return null;    
        }
    }
    //It checks the owner key record for both the type 
    @AuraEnabled
    public static string  OwnerKeyRecord(){
        try{
            List<Lightning_Step__OwnerKeyValPerUser__c> OwnerKeyList = new List<Lightning_Step__OwnerKeyValPerUser__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                   OwnerKeyList = [SELECT Id, Lightning_Step__OwnerKey__c,Lightning_Step__UserId__c,Lightning_Step__Set_User_as_default_user__c FROM Lightning_Step__OwnerKeyValPerUser__c];
               }
            boolean SetAsDefault=false;
            if(OwnerKeyList.size()>0)
            {
                for(Lightning_Step__OwnerKeyValPerUser__c ownerKey:OwnerKeyList)
                {
                    if(ownerKey.Lightning_Step__Set_User_as_default_user__c==true)
                    {
                        SetAsDefault=true;
                        break;
                    }
                }
                if(SetAsDefault==true)
                {
                    return 'SetAsDefaultUser';
                }
                else
                {
                    return 'NotSetAsDefaultUser';  
                }
            }
            else
            {
                return 'RecDoestNotExist';
            }
            
            
        }
        catch(exception  e)
        {
            return null;
        }
    }
    //Insert or updste the user specific owner key
    @AuraEnabled
    public static String SaveOwnerKeyPerUser(String UserId,String ownerKey,boolean setAsUser)
    {
        try{
            List<User> UserList=[SELECT Name FROM user WHERE Id=:UserId LIMIT 1];
            String algorithmName = 'AES256';
            String orgId = UserInfo.getOrganizationId();
            string key='CYNTEXALABCYLS'+orgId;
            Blob privateKey = Blob.valueOf(key);
            Blob encryptedValue2 = Blob.valueOf(ownerKey);
            Blob encrptOwnerKey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue2);
            string encrptClientIdbase64 = EncodingUtil.base64Encode(encrptOwnerKey);
            Lightning_Step__OwnerKeyValPerUser__c newOwnerKey= new Lightning_Step__OwnerKeyValPerUser__c();
            newOwnerKey.Name='OwnerKey'+UserId;
            newOwnerKey.Lightning_Step__OwnerKey__c=encrptClientIdbase64;
            newOwnerKey.Lightning_Step__UserId__c=UserId;
            newOwnerKey.Lightning_Step__UserName__c=UserList[0].Name;
            newOwnerKey.Lightning_Step__Set_User_as_default_user__c=setAsUser;
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canCreateObject('Lightning_Step__OwnerKeyValPerUser__c')) {
                insert newOwnerKey;
            }
            return 'Success';
        }
        catch(exception e)
        {
            string exceptionGenerated=e.getMessage();
            if(exceptionGenerated.contains('There is already an item in this list')) {
                exceptionGenerated = 'User Already Exist with this Owner Key';
            }
            
            return exceptionGenerated;
        }
        
    }
    //It fetches the last sync detail from the custom setting
    @auraEnabled
    public static string getSyncDetail()
    {
        try{
            list<Lightning_Step__StoreLastModifiedOfLocationSync__c> locLastModified = new list<Lightning_Step__StoreLastModifiedOfLocationSync__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__StoreLastModifiedOfLocationSync__c') && fieldlevelsecurity.canReadField('Lightning_Step__StoreLastModifiedOfLocationSync__c','Lightning_Step__lastModfiied__c')) {
                locLastModified = [Select Lightning_Step__lastModfiied__c from Lightning_Step__StoreLastModifiedOfLocationSync__c limit 1];
            }
            list<Lightning_Step__LastModifiedOfprogram__c> locLastModifiedProgram = new list<Lightning_Step__LastModifiedOfprogram__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__LastModifiedOfprogram__c') && fieldlevelsecurity.canReadField('Lightning_Step__LastModifiedOfprogram__c','Lightning_Step__LastModifiedDate__c')) {
                locLastModifiedProgram = [Select Lightning_Step__LastModifiedDate__c from Lightning_Step__LastModifiedOfprogram__c limit 1];
            }
            if(locLastModified.size()>0 && locLastModifiedProgram.size()>0 ){
                return locLastModified[0].Lightning_Step__lastModfiied__c+','+locLastModifiedProgram[0].Lightning_Step__LastModifiedDate__c;
            }
            else
                if(locLastModified.size()>0 && locLastModifiedProgram.size()==0)
            {
                return locLastModified[0].Lightning_Step__lastModfiied__c+','+'nodate';
                
            }
            else
                if(locLastModified.size()==0 && locLastModifiedProgram.size()>0)
            {
                return 'nodate' +','+locLastModifiedProgram[0].Lightning_Step__LastModifiedDate__c;
            }
            else
            {
                return null;
            }
            
        }
        catch(exception e)
        {
            return e.getMessage();
        }
    }
    
    //to check owner key is set for default user
    @AuraEnabled
    public static string  CheckSetAsDefault()
    {
        try{
            List<Lightning_Step__OwnerKeyValPerUser__c> OwnerKeyList = new List<Lightning_Step__OwnerKeyValPerUser__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                   OwnerKeyList = [SELECT Id, Lightning_Step__OwnerKey__c,Lightning_Step__UserId__c,Lightning_Step__Set_User_as_default_user__c FROM Lightning_Step__OwnerKeyValPerUser__c];
               }
            boolean SetAsDefault=false;
            if(OwnerKeyList.size()>0)
            {
                for(Lightning_Step__OwnerKeyValPerUser__c ownerKey:OwnerKeyList)
                {
                    if(ownerKey.Lightning_Step__Set_User_as_default_user__c==true)
                    {
                        SetAsDefault=true;
                        break;
                    }
                }
                
                if(SetAsDefault==true)
                {
                    return 'SetAsDefaultUser';
                }
                else
                {
                    return 'NotSetAsDefaultUser';  
                    
                }
            }
            else
            {
                return null;   
            }
            
        }
        catch(Exception e)
        {
            return e.getMessage();
        }
    }
    
    //This is used to return all the records of Owner key users.
    @AuraEnabled 
    public static List<Lightning_Step__OwnerKeyValPerUser__c> getUserList()
    {
        try {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserName__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                   return [SELECT Lightning_Step__UserName__c,Lightning_Step__UserId__c FROM Lightning_Step__OwnerKeyValPerUser__c WHERE Lightning_Step__Set_User_as_default_user__c=false ];
               } else {
                   return null;
               }
        } catch(exception e) {
            return null;
        }
        
    }
    
    //This is used to update Default user. 
    @AuraEnabled 
    public static string  UpdateDefaultUserVal(string UserId)
    {
        try{
            List<Lightning_Step__OwnerKeyValPerUser__c> ChangeDefaultUser = new List<Lightning_Step__OwnerKeyValPerUser__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c')) {
                   ChangeDefaultUser = [SELECT Id, Lightning_Step__Set_User_as_default_user__c FROM Lightning_Step__OwnerKeyValPerUser__c WHERE Lightning_Step__Set_User_as_default_user__c=true LIMIT 1];
               }
            if(ChangeDefaultUser.size()>0 && fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c')){
                ChangeDefaultUser[0].Lightning_Step__Set_User_as_default_user__c=false;
                update ChangeDefaultUser[0];
            }
            Lightning_Step__OwnerKeyValPerUser__c changeSelecteduser = new Lightning_Step__OwnerKeyValPerUser__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c')) {
                changeSelecteduser = [SELECT Id, Lightning_Step__Set_User_as_default_user__c FROM Lightning_Step__OwnerKeyValPerUser__c WHERE Lightning_Step__UserId__c=:UserId];
            }
            changeSelecteduser.Lightning_Step__Set_User_as_default_user__c=true;
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') &&
              fieldlevelsecurity.canUpdateObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c')) {
                 update changeSelecteduser;
            }
            return 'success';
        }
        catch(exception e)
        {
            return e.getMessage();
        }
    } 
    
    //This is used to check current user is Marketing User or not.
    @AuraEnabled 
    public static String checkMarketingUserWithUserCredentials()
    {
        try {
            String response;
            string userId=UserInfo.getUserId();
            User userRecord = [SELECT Id,UserPermissionsMarketingUser FROM User WHERE Id=:userId LIMIT 1];
            if(userRecord.UserPermissionsMarketingUser) {
                List<Lightning_Step__API_Keys__c> access = new List<Lightning_Step__API_Keys__c>();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')) {
                       access = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c,LastModifiedDate from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null];
                   }
                if(access.size() > 0) {
                    response = 'success';
                } else {
                    response = 'Client Id and Secret key is Missing.';
                }
            } else {
                response = 'You are not a Marketing User. Please go to Setup-->Search User-->Select User and Edit-->Check Marketing User-->Click Save';
            }
            return response;
        } catch(Exception e) {
            return e.getMessage();
        }
        
    }
}