public class CalloutClass 
{
    //Generate Access Token
    public static String getAccessToken( string Pbkey, String ScKey)
    {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Access Token' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                   String payload = 'grant_type='+EncodingUtil.urlEncode('client_credentials','UTF-8')+'&scope='+EncodingUtil.urlEncode('*','UTF-8')+'&client_id='+EncodingUtil.urlEncode(Pbkey,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(ScKey,'UTF-8');
                   request.setBody(payload);
                   HttpResponse response = http.send(request);
                   
                   if(response.getStatusCode() == 401) {
                        
                       return 'Client Id and Client Secret is Invalid';
                   }
                   if (response.getStatusCode() != 200) {
                       return ('The status code returned was not expected: ' +
                               response.getStatusCode() + ' ' + response.getStatus());
                   } else {
                      
                       LightingSt data=(LightingSt)JSON.deserialize(response.getBody(), LightingSt.class);  
                       return data.access_token;
                   }
               } else {
                   return 'Permission Issue';
               }
        } catch(Exception e) {
            return e.getMessage();
        }
    }
    //Create Inquiry
    public static string createInquiry(String accessToken,String inquiryBody)
    {
        try {
            string result;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Inquiry Creation' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Authorization', 'Bearer '+accessToken);
                   request.setHeader('Content-Type', 'application/json');
                   request.setBody(inquiryBody);
                   HttpResponse response = http.send(request);
                   if (response.getStatusCode() != 200) {
                       result= 'The status code returned was not expected: ' +
                           response.getStatusCode() + ' ' + response.getStatus();
                       return result;
                   } else {
                       result=response.getBody();
                       return result;
                   }   
               } else {
                   return 'Permission Issue';
               }
            
        } catch(Exception e) {
            return e.getMessage();
        }
    }
    
    //Create Contact 
    public static string createContact(String accessToken,String contactBody)
    {
        try {
            string Result;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Contact Creation' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Authorization', 'Bearer '+accessToken);
                   request.setHeader('Content-Type', 'application/json');
                   request.setBody(contactBody);
                   HttpResponse response = http.send(request);
                  
                   if(response.getStatusCode() == 400) {
                       
                       return 'No Owner Key Specified or Invalid';
                   }
                   if (response.getStatusCode() != 200) {
                       Result='The status code returned was not expected: ' +
                           response.getStatusCode() + ' ' + response.getStatus();
                       return Result;
                   } else {
                       Result=response.getBody();
                       return Result;
                   }  
               } else {
                   return 'Permission Issue';
               }
        } catch(Exception e) {
            return e.getMessage();
        }
    }
    
    //Admit Client
    public static string admitClient(String accessToken,String admitClientBody)
    {
        try{
            string result;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Admit Client' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Authorization', 'Bearer '+accessToken);
                   request.setHeader('Content-Type', 'application/json');
                   request.setBody(admitClientBody);
                   System.debug('EndPoint:');
                   System.debug(endPointURL.Lightning_Step__End_Point_URL__c);
                   System.debug('AccessToken:');
                   System.debug( accessToken );
                   System.debug('ClientBody:');
                   System.debug(admitClientBody);
                   HttpResponse response = http.send(request);
                   System.debug('Res:');
                   System.debug( response );
                   if(response.getStatusCode() == 400) {
                        return 'No Owner Key Specified or Invalid';
                   }
                   if (response.getStatusCode() != 200) {
                       return'The status code returned was not expected: ' +
                           response.getStatusCode() + ' ' + response.getStatus();
                   } else {
                       result=response.getBody();
                       return result;
                   }
               } else {
                   return 'Permission Issue';
               }
        } catch(Exception e) {
            return e.getMessage();
        }
    }
    
    //Check Admission Status
    public static string admissionClientStatus(String accessToken,String admissionClientStatus)
    {
        try {
            string result;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Admission Status' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Authorization', 'Bearer '+accessToken);
                   request.setHeader('Content-Type', 'application/json');
                   request.setBody(admissionClientStatus);
                   HttpResponse response = http.send(request);
                   if(response.getStatusCode() == 400 ) {
                       return 'No Owner Key Specified or Invalid';
                   }
                   if (response.getStatusCode() != 200) {
                       result='The status code returned was not expected: ' +
                           response.getStatusCode() + ' ' + response.getStatus();
                       return result;
                   } else {
                       result=response.getBody();
                       return result;
                   }
               } else {
                   return 'Permission Issue';
               } 
        } catch(Exception e) {
            return e.getMessage();
        }
    }  
    //Check Admit Clients status
    public static string checkBulkStatus(String accessToken,String listOfAdmittedClientBody)
    {
        try{
            string Result;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Bulk Admission Status Check' limit 1];
                   request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                   request.setMethod('POST');
                   request.setHeader('Authorization', 'Bearer '+accessToken);
                   request.setHeader('Content-Type', 'application/json');
                   request.setBody(listOfAdmittedClientBody);
                   HttpResponse response = http.send(request);
                   if (response.getStatusCode() != 200) {
                       Result='The status code returned was not expected: ' +
                           response.getStatusCode() + ' ' + response.getStatus();
                       return Result;
                   } else {
                       Result=response.getBody();
                       return Result;
                   }
                   
               } else {
                   return 'Permission Issue';
               }
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    
    // Fetch Programs and Locations
    public static String calloutForProgramLocation() {
        try{
            String result;
            String pubkey;
            String seckey1;
            String ownerKey;
            String currentUser = UserInfo.getUserId();
            String orgId1 = UserInfo.getOrganizationId();
            
            List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')) {
                   apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null Limit 1];
               }
            if(apiAccess.size()>0){
                String algorithmName1 = 'AES256';
                string keyValue1='CYNTEXALABCYSP'+orgId1;
                Blob pvtKey1 = Blob.valueOf(keyValue1);
                Blob pbKey1 = EncodingUtil.base64Decode(apiAccess[0].Client_Secret__c);
                Blob scKey1 = EncodingUtil.base64Decode(apiAccess[0].Client_Secret_key__c);
                Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, pbKey1 );
                Blob decr2se = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, scKey1 );
                pubkey=decrpb.tostring();
                seckey1=decr2se.tostring();
            } 
            String accessToken = getAccessToken(pubkey,seckey1);
            if(!accessToken.contains('The status code returned was not expected:')) {
                Lightning_Step__OwnerKeyValPerUser__c ownerKeyConfig = new Lightning_Step__OwnerKeyValPerUser__c();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__OwnerKeyValPerUser__c') && fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__OwnerKey__c') &&
                   fieldlevelsecurity.canReadField('Lightning_Step__OwnerKeyValPerUser__c','Lightning_Step__UserId__c')) {
                       ownerKeyConfig = [select Lightning_Step__OwnerKey__c  from Lightning_Step__OwnerKeyValPerUser__c where Lightning_Step__UserId__c=:currentUser limit 1];
                   }
                Map<String, String> jsonObjectMap = new Map<String, String>();
                if(ownerKeyConfig != null)    
                {
                    String algorithmName = 'AES256';
                    String orgId = UserInfo.getOrganizationId();
                    string keyValue='CYNTEXALABCYLS'+orgId;
                    Blob pvtKey = Blob.valueOf(keyValue);
                    Blob pbKey = EncodingUtil.base64Decode(ownerKeyConfig.OwnerKey__c);
                    Blob decr = Crypto.decryptWithManagedIV(algorithmName, pvtKey, pbKey );
                    ownerKey=decr.toString();  
                }
                jsonObjectMap.put('owner_key', ownerKey);
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
                   fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                       endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Program and Location' limit 1];
                       request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                       request.setMethod('POST');
                       request.setHeader('Authorization', 'Bearer '+accessToken);
                       request.setHeader('Content-Type', 'application/json');
                       request.setBody(JSON.Serialize(jsonObjectMap));
                       HttpResponse response = http.send(request);
                       if(response.getStatusCode() == 200) {
                           String dateResponse = response.getBody();
                           Map<String,Lightning_Step__Location__c> MapOfLocationData = new  Map<String,Lightning_Step__Location__c>();
                           Map<String,List<Lightning_Step__Program__c>> mapOfProgramAndId = new Map<String,List<Lightning_Step__Program__c>>();
                           System.debug('Body');
                           System.debug(dateResponse);
                           List<Object> listOfdata = (List<Object>)JSON.deserializeUntyped(dateResponse);
                           for(Object obj : listOfdata) {
                               Map<String, Object> dataMap = (Map<String, Object>)obj;
                               String locationName = (String)dataMap.get('location_name');
                               Integer locationId = (Integer)dataMap.get('location_id');
                               String programName = (String)dataMap.get('pgmname');
                               Integer programId = (Integer)dataMap.get('pgm_id');
                               Lightning_Step__Location__c location = new Lightning_Step__Location__c(Name = locationName,Lightning_Step__Location_Name__c = locationName,Lightning_Step__Location_Id__c = String.valueOf(locationId));
                               MapOfLocationData.put(locationName, location);
                               Lightning_Step__Program__c program = new Lightning_Step__Program__c(Lightning_Step__Program_Id__c = String.valueOf(programId),Lightning_Step__Program_Name__c = programName,Name = programName);
                               List<Lightning_Step__Program__c> programList = new List<Lightning_Step__Program__c>();
                               if(mapOfProgramAndId.get(locationName) == null) {
                                   programList.add(program);
                                   mapOfProgramAndId.put(locationName,programList);
                               } else {
                                   programList = mapOfProgramAndId.get(locationName);
                                   programList.add(program);
                                   mapOfProgramAndId.put(locationName,programList);
                               }
                           }
                           List<Lightning_Step__Location__c> locationData = new  List<Lightning_Step__Location__c>();
                           for(Lightning_Step__Location__c location : MapOfLocationData.Values()) {
                               locationData.add(location);
                           }
                           
                           List <Lightning_Step__Location__c> locData = new List <Lightning_Step__Location__c>();
                           if(fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Location_Id__c') &&
                              fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Location_Name__c'))  {
                                  locData=[Select Id,Lightning_Step__Location_Id__c,Lightning_Step__Location_Name__c From Lightning_Step__Location__c];
                              }
                           List<Lightning_Step__Location__c>listOfNewLocation=new  List<Lightning_Step__Location__c>();
                           List<Lightning_Step__Location__c>updateOldLoacation=new  List<Lightning_Step__Location__c>();
                           Map<String,location__c> LocationMap=new  Map<String,location__c>();
                           for(Lightning_Step__Location__c location:locData) {
                               LocationMap.put(location.Lightning_Step__Location_Id__c,location);  
                           }
                           for(Lightning_Step__Location__c location:locationData) {
                               if(LocationMap.get(location.Lightning_Step__Location_Id__c) != null) {
                                   Lightning_Step__Location__c newLocation = new Lightning_Step__Location__c (Id = LocationMap.get(location.Lightning_Step__Location_Id__c).Id,Name = location.Name,Lightning_Step__Location_Name__c = location.Lightning_Step__Location_Name__c,Lightning_Step__Location_Id__c = location.Lightning_Step__Location_Id__c);
                                   updateOldLoacation.add(newLocation);
                               } else {
                                   location.Lightning_Step__Data_Validation__c = true;
                                   listOfNewLocation.add(location);
                               }
                           }
                           List<Lightning_Step__Location__c> listOfAllLocations = new List<Lightning_Step__Location__c>();
                           if(updateOldLoacation.size() > 0) {
                               if(fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Location_Id__c') &&
                                  fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Name') && fieldlevelsecurity.canUpdateField('Lightning_Step__Location__c','Name')  &&
                                  fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Location_Name__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__Location__c') &&
                                  fieldlevelsecurity.canUpdateField('Lightning_Step__Location__c','Lightning_Step__Location_Id__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Location__c','Lightning_Step__Location_Name__c'))  {
                                      Update updateOldLoacation;
                                  }
                               listOfAllLocations.addAll(updateOldLoacation);
                           }
                           
                           if(listOfNewLocation.size() > 0) {
                               if(fieldlevelsecurity.canCreateObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadObject('Lightning_Step__Location__c')) {
                                   Insert listOfNewLocation;
                               }
                               listOfAllLocations.addAll(listOfNewLocation);
                           }
                           Map<String,Id> locationName = new Map<String,Id>();
                           for(Lightning_Step__Location__c location : listOfAllLocations) {
                               locationName.put(location.Lightning_Step__Location_Name__c,location.Id);
                           }                
                           List <Lightning_Step__Program__c> proData = new  List <Lightning_Step__Program__c>();
                           if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Program_Id__c') &&
                              fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Name') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Program_Name__c') && 
                              fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Locations__c'))  {
                                  proData=[Select Id,Lightning_Step__Program_Id__c,Name,Lightning_Step__Program_Name__c,Lightning_Step__Locations__c From Lightning_Step__Program__c];
                              }
                           List<Lightning_Step__Program__c> programListData = new List<Lightning_Step__Program__c>();
                           for(String key : mapOfProgramAndId.KeySet()) {
                               List<Lightning_Step__Program__c> programListRecord = mapOfProgramAndId.get(key);
                               for(Lightning_Step__Program__c program : programListRecord) {
                                   program.Lightning_Step__Locations__c = locationName.get(key);
                                   programListData.add(program);
                               }
                           }
                           Map<String,Lightning_Step__Program__c> ProgramMap=new  Map<String,Lightning_Step__Program__c>();
                           for(Lightning_Step__Program__c program:proData) {
                               ProgramMap.put(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c,program);  
                           }
                           List<Lightning_Step__Program__c> oldPrograms = new List<Lightning_Step__Program__c>();
                           List<Lightning_Step__Program__c> newPrograms = new List<Lightning_Step__Program__c>();
                           Map<String,Lightning_Step__Program__c> mapOfNewPrograms = new Map<String,Lightning_Step__Program__c>();
                           Map<String,Lightning_Step__Program__c> mapOfOldPrograms = new Map<String,Lightning_Step__Program__c>();
                           for(Lightning_Step__Program__c program : programListData) {
                               if(ProgramMap.get(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c) != null) {
                                   if(ProgramMap.get(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c).Id != null) {
                                       Lightning_Step__Program__c newprogram = new Lightning_Step__Program__c(Id = ProgramMap.get(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c).Id,Name = program.Name,program_Id__c = program.Lightning_Step__Program_Id__c,Lightning_Step__Locations__c = program.Lightning_Step__Locations__c,Lightning_Step__Program_Name__c = program.Lightning_Step__Program_Name__c);
                                       mapOfOldPrograms.put(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c,newprogram);
                                   }
                               } else {
                                   mapOfNewPrograms.put(program.Lightning_Step__Program_Id__c + program.Lightning_Step__Locations__c,program);
                               }
                           }
                           for(Lightning_Step__Program__c pro : mapOfOldPrograms.values()) {
                               oldPrograms.add(pro);
                           }
                           for(Lightning_Step__Program__c pro : mapOfNewPrograms.values()) {
                               pro.Lightning_Step__Data_Validation__c = true;
                               newPrograms.add(pro);
                           }
                           
                           if(oldPrograms.size() > 0) {
                               if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Program_Id__c') &&
                                  fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Name') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Program_Name__c') && 
                                  fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Locations__c') &&
                                  fieldlevelsecurity.canUpdateObject('Lightning_Step__Program__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Program__c','Lightning_Step__Program_Id__c') &&
                                  fieldlevelsecurity.canUpdateField('Lightning_Step__Program__c','Name') && fieldlevelsecurity.canUpdateField('Lightning_Step__Program__c','Lightning_Step__Program_Name__c') && 
                                  fieldlevelsecurity.canUpdateField('Lightning_Step__Program__c','Lightning_Step__Locations__c')) {
                                      update oldPrograms;
                                  }
                           }
                           if(newPrograms.size() > 0) {
                               if(fieldlevelsecurity.canCreateObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadObject('Lightning_Step__Program__c')) {
                                   Insert newPrograms;
                               }
                           }
                           result = 'success'+','+string.valueOfGmt(System.now());
                       } else {
                           result = 'bad Value';  
                       }
                   } else {
                       result = 'bad Value';  
                   }
                return result;
            } else {
                return 'Permission Issue';
            }
        } 
        catch(Exception e) {
            /*Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'Lightning Step Error';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);*/
            return null;
        }
        
    }
    //Callout for Insurance
    public static String calloutForMcContract(){
        try{
            String result;
            String apikey;
            String ownerKey;
            String orgId1 = UserInfo.getOrganizationId();
            System.debug('Testt1');
            List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')
               && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c, Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null AND Lightning_Step__Bearer_Token__c!=null Limit 1];
               }
            if(apiAccess.size()>0){
                String algorithmName1 = 'AES256';
                string keyValue1='CYNTEXALABCYSP'+orgId1;
                Blob pvtKey1 = Blob.valueOf(keyValue1);
                Blob bKey = EncodingUtil.base64Decode(apiAccess[0].Lightning_Step__Bearer_Token__c);
                Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, bKey );
                apikey=decrpb.tostring();                
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
                   fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                       endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'MC Contract Insurance' limit 1];
                       request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                       request.setMethod('GET');
                       String bearer = 'Bearer '+ apiKey;
                       System.debug('BE:'+bearer);
                       request.setHeader('Authorization', bearer);
                       request.setHeader('Content-Type', 'application/json');
                       HttpResponse response = http.send(request);
                       System.debug(endPointURL.Lightning_Step__End_Point_URL__c);
                       System.debug(response.getBody());
                       System.debug( 'Status:'+ response.getStatusCode());
                       if(response.getStatusCode() == 200) {
                           Map<Decimal,String> mapOfMcContractIdName = new  Map<Decimal,String>();
                           JSON2Apex a = new JSON2Apex();
                           List<JSON2Apex> listData = a.parse( response.getBody() );
                           System.debug('List:'+listData);
                           for( JSON2Apex valueMap : listdata) {
                               if( valueMap.eie == 0 ){
                                   mapOfMcContractIdName.put( valueMap.id, valueMap.name );    
                               }
                           }
                           System.debug('MAPP:'+mapOfMcContractIdName);
                           Map<Decimal, Lightning_Step__LMR_Insurance__c> prevRecsMap = new Map<Decimal, Lightning_Step__LMR_Insurance__c>(); 
                           for( Lightning_Step__LMR_Insurance__c prevLmr : [SELECT Lightning_Step__MC_Contract_ID__c, Lightning_Step__MC_Name__c FROM Lightning_Step__LMR_Insurance__c WHERE Lightning_Step__MC_Contract_ID__c IN :mapOfMcContractIdName.keySet() ] ){
                               prevRecsMap.put( prevLmr.Lightning_Step__MC_Contract_ID__c, prevLmr );
                           }
                           List<Lightning_Step__LMR_Insurance__c> upsertRecs = new List< Lightning_Step__LMR_Insurance__c >();
                           for( Decimal i : mapOfMcContractIdName.keySet() ){
                               Lightning_Step__LMR_Insurance__c prevRec;
                               if( prevRecsMap.containsKey( i ) ){
                                   prevRec = prevRecsMap.get( i );
                                   prevRec.Lightning_Step__MC_Name__c = mapOfMcContractIdName.get( i );
                               }else{
                                   prevRec = new Lightning_Step__LMR_Insurance__c( Lightning_Step__MC_Contract_ID__c = i, Lightning_Step__MC_Name__c = mapOfMcContractIdName.get( i ) );
                               }
                               upsertRecs.add( prevRec );
                           }
                           if( upsertRecs != null ){
                               UPSERT upsertRecs;
                           }
                           result = 'success'+','+string.valueOfGmt(System.now());
                       } else {
                           result = 'bad Value';  
                       }
                   } else {
                       result = 'bad Value';  
                   }
                return result;
            } else {
                return 'Permission Issue';
            }
        } 
        catch(Exception e) {
            
            return null;
        }
    }
    //Upload Document
    public static String createDocument( String docBody ){
        try {
            String apikey;
            String orgId1 = UserInfo.getOrganizationId();
            List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')
               && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c, Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null AND Lightning_Step__Bearer_Token__c!=null Limit 1];
               }
            if(apiAccess.size()>0){
                String algorithmName1 = 'AES256';
                string keyValue1='CYNTEXALABCYSP'+orgId1;
                Blob pvtKey1 = Blob.valueOf(keyValue1);
                Blob bKey = EncodingUtil.base64Decode(apiAccess[0].Lightning_Step__Bearer_Token__c);
                Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, bKey );
                apikey=decrpb.tostring();
                string result;
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
                   fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                       Lightning_Step__API_EndPoints__c endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Upload Document' limit 1];
                       request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                       request.setMethod('POST');
                       request.setHeader('Authorization', 'Bearer '+apiKey);
                       request.setHeader('Content-Type', 'application/json');
                       request.setBody(docBody);
                       System.debug(request);
                       HttpResponse response = http.send(request);
                       System.debug('RES:'+response);
                       if (response.getStatusCode() != 200) {
                           result= 'The status code returned was not expected: ' +
                               response.getStatusCode() + ' ' + response.getStatus();
                       } else {
                           result=response.getBody()+' success';
                       }   
                   } 
                return result;
            } else {
                return 'Permission Issue';
            }
        } catch(Exception e) {
            return e.getMessage();
        }
    }
    //Sync picklist fields
    public static Map<String, Map<String, String>> calloutForPicklistFields( String metaKey ){
        try{
            String result;
            String apikey;
            String ownerKey;
            String orgId1 = UserInfo.getOrganizationId();
            System.debug('Testt1');
            List<Lightning_Step__API_Keys__c> apiAccess = new List<Lightning_Step__API_Keys__c>();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_Keys__c') && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret_key__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Client_Secret__c')
               && fieldlevelsecurity.canReadField('Lightning_Step__API_Keys__c','Lightning_Step__Bearer_Token__c')) {
                   apiAccess = [select  Lightning_Step__Client_Secret_key__c, Lightning_Step__Client_Secret__c, Lightning_Step__Bearer_Token__c from Lightning_Step__API_Keys__c where Lightning_Step__Client_Secret_key__c!=null AND Lightning_Step__Client_Secret__c!=null AND Lightning_Step__Bearer_Token__c!=null Limit 1];
               }
            if(apiAccess.size()>0){
                String algorithmName1 = 'AES256';
                string keyValue1='CYNTEXALABCYSP'+orgId1;
                Blob pvtKey1 = Blob.valueOf(keyValue1);
                Blob bKey = EncodingUtil.base64Decode(apiAccess[0].Lightning_Step__Bearer_Token__c);
                Blob decrpb = Crypto.decryptWithManagedIV(algorithmName1, pvtKey1, bKey );
                apikey=decrpb.tostring();                
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
                if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
                   fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                       System.debug(metaKey);
                       if( metaKey == 'Country' ){
                           System.debug('COOO');
                           endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Demographic Countries' limit 1];
                           return getDemoCountriesState( endPointURL.Lightning_Step__End_Point_URL__c, apikey );    
                       }else if(metaKey == 'State' ){
                           endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Demographic States' limit 1];
                           return getDemoCountriesState( endPointURL.Lightning_Step__End_Point_URL__c, apikey );
                       }else{
                           endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Picklist Fields' limit 1];
                           request.setEndpoint(endPointURL.Lightning_Step__End_Point_URL__c);
                           request.setMethod('POST');
                           String bearer = 'Bearer '+ apiKey;
                           System.debug('BE:'+bearer);
                           request.setHeader('Authorization', bearer);
                           request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                           String payload = 'table='+EncodingUtil.urlEncode('meta','UTF-8')+'&start_datetime='+EncodingUtil.urlEncode('0001-01-01 00:00:00','UTF-8')+'&response_type='+EncodingUtil.urlEncode('json','UTF-8')+'&record_id='+EncodingUtil.urlEncode('1','UTF-8')+'&query_array='+EncodingUtil.urlEncode('{"isactive":"1","eie":"0","metakey":"'+metaKey+'"}','UTF-8')+'&columns='+EncodingUtil.urlEncode('id,metavalue','UTF-8');
                           if( metaKey == 'obhdisposition' || metaKey == 'primaryreason' ){
                               payload = 'table='+EncodingUtil.urlEncode('meta','UTF-8')+'&start_datetime='+EncodingUtil.urlEncode('0001-01-01 00:00:00','UTF-8')+'&response_type='+EncodingUtil.urlEncode('json','UTF-8')+'&record_id='+EncodingUtil.urlEncode('1','UTF-8')+'&query_array='+EncodingUtil.urlEncode('{"isactive":"1","eie":"0","metakey":"'+metaKey+'"}','UTF-8')+'&columns='+EncodingUtil.urlEncode('id,metavalue,reporting_code','UTF-8');
                           }else if( metaKey == 'incomerange' ){
                               payload = 'table='+EncodingUtil.urlEncode('incomerange','UTF-8')+'&start_datetime='+EncodingUtil.urlEncode('2000-01-01 00:00:00','UTF-8')+'&response_type='+EncodingUtil.urlEncode('json','UTF-8')+'&record_id='+EncodingUtil.urlEncode('1','UTF-8')+'&end_datetime='+EncodingUtil.urlEncode('2022-12-31 23:59:59','UTF-8');
                           }
                           request.setBody(payload);
                           HttpResponse response = http.send(request);
                           System.debug(response.getBody());
                           System.debug( 'Status:'+ response.getStatusCode());
                           if(response.getStatusCode() == 200) {
                               Map<String, Object> jsonBodyMap = (Map<String, Object>)JSON.deserializeUntyped( response.getBody() );
                               List<Object> idValueList = (List<object>)jsonBodyMap.get( 'payload' );
                               Map<String, String> returnValue = new Map<String, String>();
                               Map<String, Map<String, String>> returnValueMap = new Map<String, Map<String, String>>();
                               for( Object value : idValueList ){
                                   Map<String, Object> valueMap = ( Map<String, Object> )value;
                                   Integer idVal = (Integer)valueMap.get('id');
                                   if( (String)valueMap.get( 'metavalue' ) == '' ){
                                       continue;
                                   }
                                   if( metaKey == 'obhdisposition' || metaKey == 'primaryreason' ){
                                       returnValue.put( (String)valueMap.get('reporting_code'), (String)valueMap.get( 'metavalue' ) );
                                   }
                                   else if( metaKey == 'ethnicity' || metaKey == 'compref' || metaKey == 'livingsituation' || metaKey == 'empstatus' || metaKey == 'sexorientation' || metaKey == 'gender_identity' || metaKey == 'preferred_pronouns' || metaKey == 'language' || metaKey == 'priority_population' || metaKey == 'reltoinsured' || metaKey == 'substancelist' || metaKey == 'residencetype' || metaKey == 'obh_maritalstatus' || metaKey == 'privatetype' || metaKey == 'refsrctype' ){
                                       returnValue.put( (String)valueMap.get('metavalue'), (String)valueMap.get( 'metavalue' ) );
                                   } 
                                   else if( metaKey == 'incomerange' ){
                                       returnValue.put( (String)valueMap.get('fullrange'), (String)valueMap.get( 'fullrange' ) );
                                   }
                                   else{
                                       returnValue.put( idVal+'', (String)valueMap.get( 'metavalue' ) );    
                                   }
                               }
                               returnValueMap.put( 'Values', returnValue );
                               return returnValueMap;
                           }
                       }
                   }
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'callPickField Return Null Step Error';
            message.plainTextBody = 'pickfield null';
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                return null;
            } else {
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'callPickField rNull Step Error';
            message.plainTextBody = 'Pick field null';
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                return null;
            }
        }
        catch(Exception e) {
            System.debug(e);
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'callPickField Step Error';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            return null;
        }
    }
    public static Map<String, Map<String, String>> getDemoCountriesState( String endpoint, String apiKey ){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            String bearer = 'Bearer '+ apiKey;
            request.setHeader('Authorization', bearer);
            HttpResponse res = http.send( request );
            System.debug(endpoint);
            System.debug(apiKey);
            System.debug(res.getBody());
            Map<String, Object> countryObjMap = (Map<String, Object>)JSON.deserializeUntyped( res.getBody() );
            Map<String, String> countryMap = new Map<String, String>();
            for( String key : countryObjMap.keySet() ){
                if( key == '' ){
                    continue;
                }
                countryMap.put( key, (String)countryObjMap.get( key ) );
            }
            Map<String, Map<String, String>> returnValueMap = new Map<String, Map<String, String>>();
            System.debug('Country:');
            System.debug(countryMap);
            returnValueMap.put( 'Values', countryMap );
            return returnValueMap;
        }catch( Exception e ){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'Demo countries Step Error';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
			return null;            
        }
    }
    public static String calloutForPicklistSync( String jsonPayload, String fieldId ){
        try{
            Lightning_Step__API_EndPoints__c endPointURL = new Lightning_Step__API_EndPoints__c();
            if(fieldlevelsecurity.canReadObject('Lightning_Step__API_EndPoints__c') && 
               fieldlevelsecurity.canReadField('Lightning_Step__API_EndPoints__c','Lightning_Step__End_Point_URL__c')) {
                   endPointURL = [Select Name,Lightning_Step__End_Point_URL__c from Lightning_Step__API_EndPoints__c where Name = 'Tooling Api' limit 1];
                   System.debug(jsonPayload);
                   String s = UserInfo.getSessionId();
                   Http h = new Http();
                   HttpRequest req = new HttpRequest();
                   req.setHeader( 'Content-Type', 'application/json' );
                   req.setEndpoint( endPointURL.Lightning_Step__End_Point_URL__c+fieldId );
                   System.debug('EndPoint:'+endPointURL.Lightning_Step__End_Point_URL__c+fieldId);
                   if( Test.isRunningTest() ){
                       req.setHeader('Authorization', 'Bearer 123456');
                   }else{
                       req.setHeader('Authorization', 'Bearer '+MapCmpClass.fetchUserSessionId());    
                   }
                   req.setMethod( 'PATCH' );
                   req.setBody( jsonPayload );
                   HttpResponse res = h.send( req );
                   System.debug(res.getBody());
                   System.debug(res.getBody().length());
                   if( res.getBody().length() == 0 ){
                       return 'Updated';
                   }
               }
            return null;
        }catch( Exception e ){
            System.debug(e.getMessage());
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // Set recipients to two contact IDs.
            // Replace IDs with valid record IDs in your org.
            message.toAddresses = new String[] { 'bhaveshhirdhani@cyntexa.com' };
            message.subject = 'Pick Sync Call Step Error';
            message.plainTextBody = e.getMessage();
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            return null;
        }
    }
    //For Insurance Records
    public class JSON2Apex {
        
        public Integer id;
        public String name;
        public Integer eie;
        
        public List<JSON2Apex> parse(String json) {
            return (List<JSON2Apex>) System.JSON.deserialize(json, List<JSON2Apex>.class);
        }
    }
	    
    public class LightingSt 
    {
        public String token_type;
        public Integer expires_in;
        public String access_token;
    }
    public class ResponseWrapper {
        
        public Boolean success;
        public Integer code;
        public String locale;
        public String message;
        public Object data;
    }
    
}