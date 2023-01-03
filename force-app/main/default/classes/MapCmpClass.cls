public class MapCmpClass {
    //Syncing picklist fields
    @AuraEnabled
    public static Map<String, Map<String, Map<String, String>>> getPickFields(){
        try{
            EntityDefinition edf = [SELECT DeveloperName,QualifiedApiName,NewUrl,(SELECT Id, Label, DurableId FROM Fields) FROM EntityDefinition WHERE QualifiedApiName = 'Lightning_Step__Inquiry__c' LIMIT 1];
            Map<String, String> fieldIdMap = new Map<String, String>();
            for( Integer i = 0; i<edf.Fields.size(); i++ ){
                String dId = (String)edf.Fields[i].get('DurableId');
                dId = dId.substring( dId.indexOf('.')+1 );
                fieldIdMap.put( (String)edf.Fields[i].get('Label'), dId );
            }
            System.debug(fieldIdMap);
            Map<String, Map<String, String>> insEmpMap = CalloutClass.calloutForPicklistFields( 'insemployer' );
            fillFieldValues( insEmpMap, 'Employer', 'Lightning_Step__Employer__c', fieldIdMap.get('Employer') );
            
            Map<String, Map<String, String>> ethnicityMap = CalloutClass.calloutForPicklistFields( 'ethnicity' );
            fillFieldValues( ethnicityMap, 'Ethnicity', 'Lightning_Step__Ethnicity__c', fieldIdMap.get('Ethnicity') );
            
            Map<String, Map<String, String>> metContMap = CalloutClass.calloutForPicklistFields( 'compref' );
            fillFieldValues( metContMap, 'Preferred Method to Contact', 'Lightning_Step__Preferred_Method_to_Contact__c', fieldIdMap.get('Preferred Method to Contact') );
            
            Map<String, Map<String, String>> livSitMap = CalloutClass.calloutForPicklistFields( 'livingsituation' );
            fillFieldValues( livSitMap, 'Living Situation', 'Lightning_Step__Living_Situation__c', fieldIdMap.get('Living Situation') );
            
            Map<String, Map<String, String>> empstatusMap = CalloutClass.calloutForPicklistFields( 'empstatus' );
            fillFieldValues( empstatusMap, 'Employment Status', 'Lightning_Step__Employment_Status__c', fieldIdMap.get('Employment Status') );
            
            Map<String, Map<String, String>> sexorientationMap = CalloutClass.calloutForPicklistFields( 'sexorientation' );
            fillFieldValues( sexorientationMap, 'Sexual Orientation', 'Lightning_Step__Sexual_Orientation__c', fieldIdMap.get('Sexual Orientation') );
            
            Map<String, Map<String, String>> gender_identityMap = CalloutClass.calloutForPicklistFields( 'gender_identity' );
            fillFieldValues( gender_identityMap, 'Gender Identity', 'Lightning_Step__Gender_Identity__c', fieldIdMap.get('Gender Identity') );
            
            Map<String, Map<String, String>> preferred_pronounsMap = CalloutClass.calloutForPicklistFields( 'preferred_pronouns' );
            fillFieldValues( preferred_pronounsMap, 'Preferred Pronouns', 'Lightning_Step__Preferred_Pronouns__c', fieldIdMap.get('Preferred Pronouns') );
            
            Map<String, Map<String, String>> languageMap = CalloutClass.calloutForPicklistFields( 'language' );
            fillFieldValues( languageMap, 'Prefer Language', 'Lightning_Step__Prefer_Language__c', fieldIdMap.get('Prefer Language') );
            
            Map<String, Map<String, String>> priority_populationMap = CalloutClass.calloutForPicklistFields( 'priority_population' );
            fillFieldValues( priority_populationMap, 'Priority Population', 'Lightning_Step__Priority_Population__c', fieldIdMap.get('Priority Population') );
            
            Map<String, Map<String, String>> reltoinsuredMap = CalloutClass.calloutForPicklistFields( 'reltoinsured' );
            fillFieldValues( reltoinsuredMap, 'Client Relationship to insured', 'Lightning_Step__Lead_Relationship_to_insured__c', fieldIdMap.get('Client Relationship to insured') );
            
            
            Map<String, Map<String, String>> substancelistMap = CalloutClass.calloutForPicklistFields( 'substancelist' );
            fillFieldValues( substancelistMap, 'Substance of Choice', 'Lightning_Step__Substance_of_Choice__c', fieldIdMap.get('Substance of Choice') );
            
            Map<String, Map<String, String>> primaryreasonMap = CalloutClass.calloutForPicklistFields( 'primaryreason' );
            fillFieldValues( primaryreasonMap, 'Primary Reason for Call', 'Lightning_Step__Primary_Reason_for_Call__c', fieldIdMap.get('Primary Reason for Call') );
            
            Map<String, Map<String, String>> residencetypeMap = CalloutClass.calloutForPicklistFields( 'residencetype' );
            fillFieldValues( residencetypeMap, 'Residence Type', 'Lightning_Step__Residence_Type__c', fieldIdMap.get('Residence Type') );
            
            Map<String, Map<String, String>> maritalstatusMap = CalloutClass.calloutForPicklistFields( 'obh_maritalstatus' );
            fillFieldValues( maritalstatusMap, 'Marital Status', 'Lightning_Step__Marital_Status__c', fieldIdMap.get('Marital Status') );
            
            Map<String, Map<String, String>> dispoMap = CalloutClass.calloutForPicklistFields( 'obhdisposition' );
            fillFieldValues( dispoMap, 'Case Disposition', 'Lightning_Step__Case_Disposition__c', fieldIdMap.get('Case Disposition') );
            
            Map<String, Map<String, String>> countryMap = CalloutClass.calloutForPicklistFields( 'Country' );
            fillFieldValues( countryMap, 'Country', 'Lightning_Step__Country__c', fieldIdMap.get( 'Country' ) );
            
            Map<String, Map<String, String>> stateMap = CalloutClass.calloutForPicklistFields( 'State' );
            fillFieldValues( stateMap, 'State/Province:', 'Lightning_Step__State_Province__c', fieldIdMap.get('State/Province:') );
            
            Map<String, Map<String, String>> pvtPayMap = CalloutClass.calloutForPicklistFields( 'privatetype' );
            fillFieldValues( pvtPayMap, 'Private Pay Type', 'Lightning_Step__Private_Pay_Type_Pick__c', fieldIdMap.get('Private Pay Type') );
            
            Map<String, Map<String, String>> groupNMap = CalloutClass.calloutForPicklistFields( 'groupname' );
            fillFieldValues( groupNMap, 'Group Name', 'Lightning_Step__Group_Name__c', fieldIdMap.get('Group Name') );
            
            Map<String, Map<String, String>> refSrcMap = CalloutClass.calloutForPicklistFields( 'refsrctype' );
            fillFieldValues( refSrcMap, 'Referral Source Type', 'Lightning_Step__Referral_Source_Type__c', fieldIdMap.get('Referral Source Type') );
            
            Map<String, Map<String, String>> incRangeMap = CalloutClass.calloutForPicklistFields( 'incomerange' );
            fillFieldValues( incRangeMap, 'Income Range', 'Lightning_Step__Income_Range__c', fieldIdMap.get('Income Range') );
            
            Map<String, Map<String, String>> homeInsMap = CalloutClass.calloutForPicklistFields( 'homeinsurance' );
            fillFieldValues( homeInsMap, 'Home Insurance Company', 'Lightning_Step__Home_Insurance_Company__c', fieldIdMap.get('Home Insurance Company') );
            
            Map<String, Map<String, Map<String, String>>> finalMap = new Map<String, Map<String, Map<String, String>>>();
            finalMap.put( 'Employer', insEmpMap );
            finalMap.put( 'Ethnicity', ethnicityMap );
            finalMap.put( 'prefToCont', metContMap );
            finalMap.put( 'livingsituation', livSitMap );
            finalMap.put( 'empstatus', empstatusMap );
            finalMap.put( 'sexorientation', sexorientationMap );
            finalMap.put( 'gender_identity', gender_identityMap );
            finalMap.put( 'preferred_pronouns', preferred_pronounsMap );
            finalMap.put( 'language', languageMap );
            finalMap.put( 'priority_population', priority_populationMap );
            finalMap.put( 'reltoinsured', reltoinsuredMap );
            finalMap.put( 'substancelist', substancelistMap );
            finalMap.put( 'primaryreason', primaryreasonMap );
            finalMap.put( 'residencetype', residencetypeMap );
            finalMap.put( 'obh_maritalstatus', maritalstatusMap );
            finalMap.put( 'obhdisposition', dispoMap );
            finalMap.put( 'countries', countryMap );
            finalMap.put( 'states', stateMap );
            finalMap.put( 'privatetype', pvtPayMap );
            finalMap.put( 'groupname', groupNMap );
            finalMap.put( 'refsrctype', refSrcMap );
            finalMap.put( 'incomerange', incRangeMap );
            finalMap.put( 'homeinsurance', homeInsMap );
            System.debug(finalMap);
            return finalMap;   
        } catch( Exception e ){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'Get Pick Fields';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            return null;
        }
        
    }
    public static void fillFieldValues( Map<String, Map<String, String>> mainMap, String fieldLabel, String fieldApiName, String fieldId ){
        Map<String, String> fieldInfo = new Map<String, String>();
        fieldInfo.put( 'label', fieldLabel );
        fieldInfo.put( 'apiName', fieldApiName );
        fieldInfo.put( 'fieldId', fieldId );
        mainMap.put( 'fieldInfo', fieldInfo );
    }
    @AuraEnabled
    public static String syncPickFields( Map<String, String> pickValuesMap, String fLabel, String fieldName, String fieldId ){
        try{
            System.debug(pickValuesMap);
            System.debug(fLabel);
            System.debug( fieldName );
            System.debug( fieldId );
            Set<String> valueSet = new Set<String>();
            String jsonPayload = '{"Metadata" : {"label" : "'+fLabel+'","type" : "Picklist","valueSet" : {"restricted" : true,"valueSetDefinition" : {"sorted" : true,"value" : [ ';
            if(pickValuesMap.isEmpty()){
                pickValuesMap.put( 'Unknown', 'Unknown' );
            }
            for( String key : pickValuesMap.keySet() ){
                if( !valueSet.contains( pickValuesMap.get(key) ) ){
                    jsonPayload += '{"label" : "'+pickValuesMap.get(key)+'","valueName" : "'+key+'"} , ';
                    valueSet.add( pickValuesMap.get(key) );    
                }
            }
            jsonPayload=jsonPayload.removeEnd(' , ');
            jsonPayload+=']},"valueSetName" : null,"valueSettings" : []}},"FullName" : "Lightning_Step__Inquiry__c.'+fieldName+'"}';
            System.debug(jsonPayload);
            String res = CalloutClass.calloutForPicklistSync( jsonPayload, fieldId );        
            return res;
        }catch( Exception e ){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'Sync Pick Step Error';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            return null;
        }
    }
    //Mapping Field
    @AuraEnabled
    public static List<Lightning_Step__Field_Mapping__c> checkObjName( String objApi ){
        String q = 'SELECT Id FROM '+objApi+' LIMIT 1';
        Database.query( q );
        return [SELECT Lightning_Step__Inquiry_Field_API_Name__c, 
                Lightning_Step__Object_Field_API_Name__c FROM 
                Lightning_Step__Field_Mapping__c
                WHERE Lightning_Step__Object_API_Name__c = :objApi
               ];
    }
    @AuraEnabled
    public static List<String> getObjFields( String searchSt, String objApi ){
        searchSt = searchSt.toLowerCase();
        System.debug('S:'+searchSt);
        SObjectType objToken = Schema.getGlobalDescribe().get(objApi);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap(); 
        
        Set<String> fieldSet = fields.keySet();
        List<String> fieldsList = new List<String>();
        for(String s:fieldSet)
        {
            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            if( selectedField.getName() == 'Id' || selectedField.getName() == 'id' ){
                if( s.contains(searchSt) )	fieldsList.add(selectedField.getName());
            }
            if(selectedField.isUpdateable() && selectedField.getName() != 'OwnerId'){
                if( s.contains(searchSt) )	fieldsList.add(selectedField.getName());    
            }            
        }
        System.debug('LeadField');
        System.debug(fieldsList);
        System.debug('Object Name:'+objApi);
        System.debug('Search:'+searchSt);
        return fieldsList;
    }
    @Auraenabled
    public static String saveMapping( Map<String, Map<String,String>> fieldMap, String objApi ){
        try{
            System.debug(fieldMap);
            if( fieldMap.isEmpty() ){
                return 'null';
            }
            List<Lightning_Step__Field_Mapping__c> fieldMappings = new List<Lightning_Step__Field_Mapping__c>();
            Set<Id> delRecIds = new Set<Id>();
            for( String key : fieldMap.keySet() ){
                Map<String, String> objFieldMapId = fieldMap.get(key); 
                System.debug(key+':'+objFieldMapId.get( 'objField' )+','+objFieldMapId.get( 'mapId' ));
                if( objFieldMapId.get( 'mapId' ) != null && (objFieldMapId.get( 'objField' ) == null || objFieldMapId.get( 'objField' ) == '' || objFieldMapId.get( 'objField' ) == ' ' )){
                    delRecIds.add( objFieldMapId.get( 'mapId' ) );
                }else{
                    Lightning_Step__Field_Mapping__c fieldMapping = new Lightning_Step__Field_Mapping__c();
                    fieldMapping.Lightning_Step__Inquiry_Field_API_Name__c = key;
                    fieldMapping.Lightning_Step__Object_Field_API_Name__c = objFieldMapId.get( 'objField' );
                    fieldMapping.Lightning_Step__Object_API_Name__c = objApi;
                    fieldMapping.Id = objFieldMapId.get( 'mapId' );
                    fieldMappings.add( fieldMapping );
                }
            }
            UPSERT fieldMappings;
            if( delRecIds.size() > 0 ){
            	DELETE [SELECT Id FROM Lightning_Step__Field_Mapping__c WHERE Id IN :delRecIds];    
            }
            return 'inserted';
        } catch( Exception e ){
            System.debug('-->'+fieldMap);
            return e.getMessage();
        }
    }
    @AuraEnabled
    public static Map<String, String> getInqFields( String start ){
        SObjectType objToken = Schema.getGlobalDescribe().get('Lightning_Step__Inquiry__c');
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap(); 
        
        Set<String> fieldSet = fields.keySet();
        Map<String, String> objFielApiMap = new Map< String, String >();
        Map<String, String> inqFieldMap = new Map< String, String >();
        Integer i = 1;
        Integer st = Integer.valueOf(start);
        for(String s:fieldSet)
        {
            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            if(selectedField.isUpdateable()){
                objFielApiMap.put( selectedField.getName(), selectedField.getLabel() );
            }
        }
        objFielApiMap.remove('OwnerId');
        objFielApiMap.remove( 'Lightning_Step__episode_id__c' );
        objFielApiMap.remove( 'Lightning_Step__DemoGraphic_Id__c' );
        objFielApiMap.remove( 'Lightning_Step__Client_Id__c' );
        objFielApiMap.remove( 'Lightning_Step__mrn_Number__c' );
        objFielApiMap.remove( 'Lightning_Step__Inquiry_Status__c' );
        objFielApiMap.remove( 'Lightning_Step__Payor_ID__c' );
        objFielApiMap.remove( 'Lightning_Step__Last_Checked_Status__c' );
        objFielApiMap.remove( 'Lightning_Step__Mc_Contract__c' );
        objFielApiMap.remove( 'Lightning_Step__Last_Checked_Status__c' );
        objFielApiMap.remove( 'Lightning_Step__Last_Checked_Status__c' );
        objFielApiMap.remove('Lightning_Step__Inquiry_Status__c');
        objFielApiMap.remove('Lightning_Step__Inquiry_Id__c');
        objFielApiMap.remove('Lightning_Step__Private_Pay_Type__c');
        
        for( String s : objFielApiMap.keySet() ){
            Integer last = st+10;
            if( i>=st && i< last ){
                inqFieldMap.put( s, objFielApiMap.get(s) );
            }  
            ++i;
        }
        return inqFieldMap;
    }
    //Getting session id from VF page
    public static String fetchUserSessionId(){
        try{
            String sessionId = '';
            // Refer to the Page
            PageReference sessionIdPage = Page.SessionIdPage;
            // Get the content of the VF page
            System.debug('vfContent');
            System.debug(sessionIdPage.getContent());
            String vfContent = sessionIdPage.getContent().toString();
            // Find the position of Start and End
            System.debug(vfContent);
            Integer startPosition = vfContent.indexOf('Start') + 'Start'.length(),
                endPosition = vfContent.indexOf('End');
            // Get the Session Id
            sessionId = vfContent.substring(startPosition, endPosition);
            System.debug('sessionId '+sessionId);
            // Return Session Id
            return sessionId;            
        }catch( Exception e ){
            System.debug(e);
            return null;
        }
        
    }
}