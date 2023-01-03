public class UserSpecificeOwnerkey {
    //fetches all the userspecific owner records
    @AuraEnabled
    public static list<wrapclass> fetchValues (){ 
        try{
            List<Lightning_Step__OwnerKeyValPerUser__c> newaccess = new List<Lightning_Step__OwnerKeyValPerUser__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                   newaccess = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c,LastModifiedDate  from Lightning_Step__OwnerKeyValPerUser__c];
               }
            list<wrapclass> wrapList = new list<wrapclass>();
            list<User>AllUser=[Select Id,Name from User]; 
            Map<string,string> MapOfUser=new Map<string,String>();
            for(User userInfo:AllUser)
            {
                MapOfUser.put(userInfo.Id,userInfo.name);
            }
            String algorithmName = 'AES256';
            String orgId = UserInfo.getOrganizationId();
            string keyValue='CYNTEXALABCYLS'+orgId;
            Blob pvtKey = Blob.valueOf(keyValue);
            for(integer i=0;i<newaccess.size();i++){
                wrapclass wrp = new wrapclass();
                wrp.row = i+1;   
                wrp.UserName=MapOfUser.get(newaccess[i].UserId__c);
                Blob pbKey = EncodingUtil.base64Decode(newaccess[i].OwnerKey__c);
                Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                wrp.OwnerKey=decr.toString();
                wrp.userId=newaccess[i].UserId__c;
                wrp.defaultUsers=newaccess[i].Set_User_as_default_user__c;
                wrapList.add(wrp);
                
            }
            return wrapList;
        }
        catch(exception e)
        {
            return null;
        }
    }
    public class wrapclass{        
        @auraEnabled public string UserName {get;set;}
        @auraEnabled public integer row {get;set;}
        @auraEnabled public string OwnerKey {get;set;}
        @auraEnabled public string UserId{get;set;}
        @auraEnabled public Boolean defaultUsers{get;set;}
        
    }
    //It updates the owner key of user specific 
    @auraEnabled
    public static list<wrapclass> EditUserDetail (string UserId,string ownerKey,boolean DefaultVal){
        try{
            list<wrapclass> wrapList = new list<wrapclass>();
            List<Lightning_Step__OwnerKeyValPerUser__c> newaccess = new List<Lightning_Step__OwnerKeyValPerUser__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                   newaccess = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c,LastModifiedDate  from Lightning_Step__OwnerKeyValPerUser__c Where UserId__c=:UserId limit 1];
               }
            if(newaccess.size()>0){
                String algorithmName = 'AES256';
                String orgId = UserInfo.getOrganizationId();
                string key='CYNTEXALABCYLS'+orgId;
                Blob privateKey = Blob.valueOf(key);
                Blob encryptedValue2 = Blob.valueOf(ownerKey);
                Blob encrptOwnerKey = Crypto.encryptWithManagedIV(algorithmName, privateKey, encryptedValue2);
                string encrptClientIdbase64 = EncodingUtil.base64Encode(encrptOwnerKey);
                newaccess[0].Lightning_Step__OwnerKey__c=encrptClientIdbase64;
                newaccess[0].Lightning_Step__Set_User_as_default_user__c=DefaultVal;
                if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__OwnerKeyValPerUser__c') &&
                   fieldlevelsecurity.canUpdateField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__Set_User_as_default_user__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c')) {
                       update  newaccess[0];                
                   }
                wrapList = fetchValues();
                return wrapList ;
            }
            else
            {
                return null;
            }
        }
        catch(exception e)
        {
            system.debug('e'+e);
            return null;
        }
    } 
    //Get the owner key value of selected user Id
    @auraEnabled
    public static string GetUserDetail (string UserId){
        try{
            Lightning_Step__OwnerKeyValPerUser__c newaccess = new Lightning_Step__OwnerKeyValPerUser__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c')) {
                newaccess = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c,LastModifiedDate  from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:UserId limit 1];
            }
            user getUser=[Select Id,Name from user where Id=:UserId limit 1];
            String algorithmName = 'AES256';
            String orgId = UserInfo.getOrganizationId();
            string keyValue='CYNTEXALABCYLS'+orgId;
            Blob pvtKey = Blob.valueOf(keyValue);
            Blob pbKey = EncodingUtil.base64Decode(newaccess.OwnerKey__c);
            
            Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
            
            string ownerKeydetail=decr.toString()+'&'+getUser.Name+'&'+getUser.Id+'&'+newaccess.Set_User_as_default_user__c; 
            
            return ownerKeydetail;
        }
        catch(exception e)
        {
            return null;
        }
    } 
    @auraEnabled
    public static string  DeleteUser(string userId)
    {
        try{
            Lightning_Step__OwnerKeyValPerUser__c UserInfo = new Lightning_Step__OwnerKeyValPerUser__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c')) {
                UserInfo = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c,LastModifiedDate from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:userId limit 1];
            }
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canDeleteObject('Lightning_Step__OwnerKeyValPerUser__c')) {
               delete UserInfo;
            }
            
            return 'success'; 
            
        }  
        catch(exception e)
        {
            system.debug('e'+e.getMessage());
            return e.getMessage();  
        }
    }
    @auraEnabled
    public static string  CheckUserDefaultVal(string userId)
        
    {  
        try{
            Lightning_Step__OwnerKeyValPerUser__c UserDetail = new Lightning_Step__OwnerKeyValPerUser__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c')) {
                UserDetail = [select Lightning_Step__OwnerKey__c,Lightning_Step__Set_User_as_default_user__c,Lightning_Step__UserId__c,LastModifiedDate from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:userId limit 1];
            }
            if(UserDetail.Lightning_Step__Set_User_as_default_user__c==true)
            {
                return 'DefaultUser';
                
            }
            else
            {
                return 'NotDefaultuser';
            }
        }
        catch(exception e)
        {
            return e.getMessage();
        }
    }
}