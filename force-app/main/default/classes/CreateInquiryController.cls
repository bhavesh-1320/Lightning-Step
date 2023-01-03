public class CreateInquiryController {

    // Check Inquiry record already exist or not on the Lead record.
    @AuraEnabled
    public static string checkInquiryRec(string leadId)
    {
        try {
            List<Lightning_Step__Inquiry__c> inquiryRec = new List<Lightning_Step__Inquiry__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Lead__c')) {
                inquiryRec = [SELECT Id FROM Lightning_Step__Inquiry__c WHERE Lightning_Step__Lead__c=:leadId];
            } 
            if(inquiryRec.size()==0)
            {
                return 'false';
            }
            else
            {
                return 'true';
            }
        } catch(Exception e) {
            return null;
        }
        
        
    }
    // fetch Lead record
    @AuraEnabled
    public static sObject getLeadData(string leadId, String objName)
    {
        try {
            System.debug(leadId);
            System.debug(objName);
            SObjectType objToken = Schema.getGlobalDescribe().get(objName);
            DescribeSObjectResult objDef = objToken.getDescribe();
            Map<String, SObjectField> fields = objDef.fields.getMap(); 
            
            Set<String> fieldSet = fields.keySet();
            List<String> objFieldList = new List< String >();
            for(String s:fieldSet)
            {
                SObjectField fieldToken = fields.get(s);
                DescribeFieldResult selectedField = fieldToken.getDescribe();
                if( selectedField.getName() == 'Gender_del__c' ){
                    continue;
                }
                if(selectedField.isUpdateable()){
                    objFieldList.add( selectedField.getName() );
                }
            }
            System.debug(objFieldList);
            String queryFields = 'SELECT ';
            integer checkCount = 0; 
            if(fieldlevelsecurity.canReadObject(objName)){
                for( String field : objFieldList ){
                    queryFields += field+' , ';
                    if( fieldlevelsecurity.canReadField(objName,field) ){
                        checkCount++;
                    }
                }
                if( checkCount == objFieldList.size() ){
                    queryFields = queryFields.removeEnd(' , ');
                    queryFields += ' FROM '+objName+' WHERE Id = :leadId LIMIT 1';
                    System.debug('QUERY');
                    System.debug(queryFields);
                    List<sObject> objFQuery = Database.query(queryFields);
                    System.debug(objFQuery);
                    if( objFQuery.size() > 0 ){
                        System.debug(objFQuery[0]);
                        return objFQuery[0];
                    }
                }
            }
            /*Lead lead = new Lead();
            if(fieldlevelsecurity.canReadObject('lead') && fieldlevelsecurity.canReadField('lead','FirstName') &&
               fieldlevelsecurity.canReadField('lead','LastName') && fieldlevelsecurity.canReadField('lead','Street') &&
               fieldlevelsecurity.canReadField('lead','Lightning_Step__Gender__c') && fieldlevelsecurity.canReadField('lead','Lightning_Step__DOB__c') &&
               fieldlevelsecurity.canReadField('lead','Lightning_Step__DOB__c') && fieldlevelsecurity.canReadField('lead','City') &&
               fieldlevelsecurity.canReadField('lead','State') && fieldlevelsecurity.canReadField('lead','PostalCode') &&
               fieldlevelsecurity.canReadField('lead','Phone') && fieldlevelsecurity.canReadField('lead','MobilePhone') &&
               fieldlevelsecurity.canReadField('lead','Email') && fieldlevelsecurity.canReadField('lead','Company')) {
                   lead = [SELECT Id ,FirstName, LastName,Street,Lightning_Step__Gender__c,Lightning_Step__DOB__c, City, State, PostalCode,
                           Phone, MobilePhone, Email, Company FROM Lead Where Id=:leadId LIMIT 1];
               } */
            return null;
        } catch(Exception e) {
            System.debug(e);
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'jagrat@cyntexa.com' };
            message.subject = 'Lightning Step Error';
            message.plainTextBody = e.getMessage()+'Lead Name:'+leadId+'Object'+objName;
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                             + results[0].errors[0].message);
            }
            return null;
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
    @AuraEnabled
    public static List< Lightning_Step__LMR_Insurance__c > getInsurance(){
        try{
            return [SELECT Id, Lightning_Step__MC_Contract_ID__c, Lightning_Step__MC_Name__c FROM Lightning_Step__LMR_Insurance__c];
        }catch( Exception e ){
            return null;
        }
    }
    @AuraEnabled
    public static List< Lightning_Step__Field_Mapping__c > getMappings( String objName ){
        try{
            System.debug('Ob:'+objName);
            return [SELECT Id, Lightning_Step__Inquiry_Field_API_Name__c, 
                    Lightning_Step__Object_Field_API_Name__c FROM Lightning_Step__Field_Mapping__c
                    WHERE Lightning_Step__Object_API_Name__c = :objName
                   ];
        }catch( Exception e ){
            return null;
        }
    }
}