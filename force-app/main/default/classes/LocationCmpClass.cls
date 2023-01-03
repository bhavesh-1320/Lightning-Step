public class LocationCmpClass {
    // Get Locations from Lighting Step.
    @auraEnabled
    public static string getLocation()
    {
        try {
            string userId=UserInfo.getUserId();
            List<user> ListofUser = new List<user>();
            if(fieldlevelsecurity.canReadObject('user') && fieldlevelsecurity.canReadField('user','UserPermissionsMarketingUser')) {
                ListofUser =  [SELECT Id FROM User WHERE UserPermissionsMarketingUser=true AND Id=:userId];
            }
            if(ListofUser.size()>0) {
                
                string result;
                string upsertSuccess;
                string accessToken;
                string locationpayload;
                string pubkey;
                string seckey1;
                result = CalloutClass.calloutForProgramLocation();
                if(result!='bad Value')
                {
                    upsertSuccess='success'+','+string.valueOfGmt(System.now());  
                    List<Lightning_Step__StoreLastModifiedOfLocationSync__c> ListModifiedLocation = new List<Lightning_Step__StoreLastModifiedOfLocationSync__c>();
                    if(fieldlevelsecurity.canReadObject('Lightning_Step__StoreLastModifiedOfLocationSync__c') && fieldlevelsecurity.canReadField('Lightning_Step__StoreLastModifiedOfLocationSync__c','Lightning_Step__lastModfiied__c')) {
                        ListModifiedLocation =  [Select Lightning_Step__lastModfiied__c from Lightning_Step__StoreLastModifiedOfLocationSync__c Limit 1];
                    }
                    if(ListModifiedLocation.size()>0){
                        ListModifiedLocation[0].Lightning_Step__lastModfiied__c=string.valueOfGmt(System.now());
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__StoreLastModifiedOfLocationSync__c') && fieldlevelsecurity.canReadField('Lightning_Step__StoreLastModifiedOfLocationSync__c','Lightning_Step__lastModfiied__c') &&
                           fieldlevelsecurity.canUpdateObject('Lightning_Step__StoreLastModifiedOfLocationSync__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__StoreLastModifiedOfLocationSync__c','Lightning_Step__lastModfiied__c')) {
                               update ListModifiedLocation[0];
                           }
                    }
                    else
                    {
                        Lightning_Step__StoreLastModifiedOfLocationSync__c locLastModified=new Lightning_Step__StoreLastModifiedOfLocationSync__c();
                        locLastModified.Lightning_Step__lastModfiied__c=string.valueOfGmt(System.now());
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__StoreLastModifiedOfLocationSync__c') && fieldlevelsecurity.canCreateObject('Lightning_Step__StoreLastModifiedOfLocationSync__c')) {
                            insert locLastModified;
                        }
                        
                    }
                    return 'success'+','+string.valueOfGmt(System.now());
                }
                else
                {
                    upsertSuccess='Error Occured';  
                }
                return upsertSuccess;
            }
            else
            {
                return 'NotNamrketingUser';
            }
            
        }
        catch (exception e)
        {
            System.debug(e.getMessage());
            return null;
        }
    }
    // Fetch Programs from Lighting Step.
    @auraEnabled
    public static string getProgram()
    {
        
        try{
            string userId=UserInfo.getUserId();
            List<user> ListofUser = new List<user>();
            if(fieldlevelsecurity.canReadObject('user') && fieldlevelsecurity.canReadField('user','UserPermissionsMarketingUser')) {
                ListofUser =  [SELECT Id FROM User WHERE UserPermissionsMarketingUser=true AND Id=:userId];
            }
            if(ListofUser.size()>0){
                string result;
                string upsertSuccess;
                string accessToken;
                string locationpayload;  
                string pubkey;
                string seckey1;
                result = CalloutClass.calloutForProgramLocation();
                if(result!='bad value')
                { 
                    List<Lightning_Step__LastModifiedOfprogram__c> ListProgramModified= new List<Lightning_Step__LastModifiedOfprogram__c>();
                    if(fieldlevelsecurity.canReadObject('Lightning_Step__LastModifiedOfprogram__c') && fieldlevelsecurity.canReadField('Lightning_Step__LastModifiedOfprogram__c','Lightning_Step__LastModifiedDate__c')) {
                        ListProgramModified = [Select Lightning_Step__LastModifiedDate__c from Lightning_Step__LastModifiedOfprogram__c limit 1];
                    }
                    if(ListProgramModified.size()>0)
                    {
                        ListProgramModified[0].Lightning_Step__LastModifiedDate__c=string.valueOfGmt(System.now());
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__LastModifiedOfprogram__c') && fieldlevelsecurity.canReadField('Lightning_Step__LastModifiedOfprogram__c','Lightning_Step__LastModifiedDate__c') &&
                           fieldlevelsecurity.canUpdateObject('Lightning_Step__LastModifiedOfprogram__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__LastModifiedOfprogram__c','Lightning_Step__LastModifiedDate__c')) {
                               update ListProgramModified;
                           }
                    }
                    else
                    {
                        Lightning_Step__LastModifiedOfprogram__c lastModified= new Lightning_Step__LastModifiedOfprogram__c();
                        lastModified.Lightning_Step__LastModifiedDate__c=string.valueOfGmt(System.now());
                        if(fieldlevelsecurity.canReadObject('Lightning_Step__LastModifiedOfprogram__c') && fieldlevelsecurity.canCreateObject('Lightning_Step__LastModifiedOfprogram__c')) {
                            insert lastModified;
                        }
                    }
                    return 'success'+','+string.valueOfGmt(System.now());
                }
                else
                    return 'Error Occured';         
            }
            else
            {
                return 'NotMarketingUser';
            }
        }
        catch(exception e)
        {
            System.debug(e.getMessage());
            return e.getMessage();
        }
    }
    @AuraEnabled
    public static List<Program__c> getProgramRec(String pageSize, String pageNumber)
    {
        try {
            Integer psize = Integer.valueOf(pageSize);
            Integer pnumber = Integer.valueOf(pageNumber)-1;
            List<Lightning_Step__Program__c> programList = new List<Lightning_Step__Program__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Locations__c')) {
                programList = [SELECT Id , Name ,LastModifieddate,Lightning_Step__Locations__r.Name,Lightning_Step__Locations__c FROM Lightning_Step__Program__c LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)];
            }
            return programList;
        } catch (Exception e) {
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Location__c> getLocationRec(String pageSize, String pageNumber)
    {
        try {
            Integer psize = Integer.valueOf(pageSize);
            Integer pnumber = Integer.valueOf(pageNumber)-1;
            List<Lightning_Step__Location__c> locationList = new List<Lightning_Step__Location__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Name')) {
                locationList = [SELECT Id , Name ,LastModifieddate FROM Lightning_Step__Location__c LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)];
            }
            return locationList;
        } catch (Exception e) {
            return null;
        }
    }
}