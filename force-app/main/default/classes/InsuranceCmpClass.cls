public class InsuranceCmpClass {
    //Fetch Insurance
    @auraEnabled
    public static String getInsurance()
    {
        try {
            
            string result;
            string upsertSuccess;
            string accessToken;
            string locationpayload;
            string pubkey;
            string seckey1;
            result = CalloutClass.calloutForMcContract();
            if(result!='bad Value' && result != 'Permission Issue')
            {
                upsertSuccess='success'+','+string.valueOfGmt(System.now());  
                return 'success'+','+string.valueOfGmt(System.now());
            }
            else
            {
                upsertSuccess='Error Occured';  
            }
            return upsertSuccess;
        }
        catch (exception e)
        {
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Lightning_Step__LMR_Insurance__c> getInsuranceRecs( String pageSize, String pageNumber )
    {
        try {
            Integer psize = Integer.valueOf(pageSize);
            Integer pnumber = Integer.valueOf(pageNumber)-1;
            return [SELECT Id, Lightning_Step__MC_Contract_ID__c, Lightning_Step__MC_Name__c FROM Lightning_Step__LMR_Insurance__c ORDER BY Lightning_Step__MC_Name__c LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber) ];
        } catch (Exception e) {
            return null;
        }
    }
}