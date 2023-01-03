public class CustomLookupController {
    //Fetches all the user of the org
  @AuraEnabled
    public static List<SObJectResult> getResults(String ObjectName, String fieldName, String value) {
        try{
            
            value='%'+value+'%';
        List<SObJectResult> sObjectResultList = new List<SObJectResult>();
        for(sObject so : Database.Query(String.escapeSingleQuotes('Select Id,'+fieldName+' FROM '+ObjectName+' WHERE '+fieldName+' LIKE :value'  ))) {
            
            String fieldvalue = (String)so.get(fieldName);
            sObjectResultList.add(new SObjectResult(fieldvalue, so.Id));
        }
        return sObjectResultList;
        }
        catch(exception e)
        {
            return null;
        }
    }
    
    public class SObJectResult {
        @AuraEnabled
        public String recName;
        @AuraEnabled
        public Id recId;
        
        public SObJectResult(String recNameTemp, Id recIdTemp) {
            recName = recNameTemp;
            recId = recIdTemp;
        }
    }
}