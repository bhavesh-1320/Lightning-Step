public with sharing class batchforCreateInquiry implements Database.Batchable<SObject>, Database.Stateful , Database.AllowsCallouts   {
    List<Lightning_Step__Inquiry__c> inquiryList = new List<Lightning_Step__Inquiry__c>();
    List<Lightning_Step__Inquiry__c> UpdatedinquiryList = new List<Lightning_Step__Inquiry__c>();
    //constructor for fetching Inqury data record.
    public batchforCreateInquiry(List<Lightning_Step__Inquiry__c> InquiryParam) {
        if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__First_Name__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Last_Name__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__DOB__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Gender__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__city__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__home_phone__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__address__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__email__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_Zip_Code__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_State__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_Fax__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Postal_Code__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__State_Province__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Funding_Source__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Work_Phone__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_City__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_Address__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Plan_Priority__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Primary_Phone__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_E_mail__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Policy__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Priority_Population__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__mccontract_id__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Preferred_Method_to_Contact__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Lead_Relationship_to_insured__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Marital_Status__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Purpose_of_Call_Primary_Reason_for_Call__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Age__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_First_Name__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Status__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Last_Name__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_ID__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_DOB__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Potential_for_Admission__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Member_Id__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Status__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Gender__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Household_Composition__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Social_Security_Number__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Occupation__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Prefer_Language__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Income_Range__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insurance_Program__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Substance_of_Choice__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Race__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Substances__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Ethnicity__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Precipitating_Event_Curren_Situation__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Employment_Status__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Phone__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Benefits_Phone__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Group_Number__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Pre_Cert_Phone__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Projected_Admission_Date__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Present_Legal_Issues__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Plan__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Legal_History__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Preferred_Pronouns__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Previous_CD_Treatment__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Case_Disposition__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Previous_MH_Treatment__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Sexual_Orientation__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Medical_Issues__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Gender_Identity__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Mental_Health_Issues__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Policy_Home_State__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Current_Medications__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Fax__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Potential_Eating_Disorder__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Verification_Status__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Sleep_Apnea__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Private_Pay_Type_Pick__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Provide_detail_for_any_areas_checked__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Program__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Admission_Source__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Zip_Postal_code__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Programs__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__mrn_Number__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Reason_For_Status__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Result_of_Call__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Middle_Name__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insurance_Company__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Relation_to_Potential_Client__c') &&fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Primary_Reason_for_Call__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_First_Name__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_Last_Name__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_Primary_Phone__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_Mobile_Phone__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__How_did_you_hear_about_us__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_is_Referral_Source__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Caller_Organization__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Middle_Name__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_mobile_phone__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Work_Phone__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Address__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_City__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Postal_Code__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Additional_Note__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Living_Situation__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Residence_Type__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Religious_Preference__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_Country__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Insured_State__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Country__c') &&
           fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Location_Id__c')&&
           fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Program_Id__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Group_Name__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Salutation__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Suffix__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Alternate_First_Name__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Prefers_to_Be_Called__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Place_of_Birth__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Employer__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c', 'Lightning_Step__Address_Line_2__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c', 'Lightning_Step__Referral_Source_Type__c')&&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c', 'Lightning_Step__Home_Insurance_Company__c') &&
           fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c', 'Lightning_Step__Maiden_Name__c')
          ) {
               inquiryList=[SELECT  Id , Lightning_Step__First_Name__c,Lightning_Step__Last_Name__c,Lightning_Step__Inquiry_Id__c,Lightning_Step__DOB__c,Lightning_Step__Gender__c,Lightning_Step__city__c,Lightning_Step__home_phone__c,Lightning_Step__email__c,Lightning_Step__address__c, 
                            Lightning_Step__Payor_Zip_Code__c,Lightning_Step__Work_Phone__c, Lightning_Step__Payor_State__c, Lightning_Step__Payor_City__c,Lightning_Step__Payor_Address__c, Lightning_Step__Plan_Priority__c, 
                            Lightning_Step__Funding_Source__c, Lightning_Step__Primary_Phone__c,Lightning_Step__Payor_Fax__c,
                            Lightning_Step__Postal_Code__c,Lightning_Step__State_Province__c,
                            Lightning_Step__Caller_E_mail__c, Lightning_Step__Policy__c, Lightning_Step__mccontract_id__c,
                            Lightning_Step__Purpose_of_Call_Primary_Reason_for_Call__c,Lightning_Step__Lead_Relationship_to_insured__c,
                            Lightning_Step__Insured_First_Name__c, Lightning_Step__Insured_Last_Name__c,
                            Lightning_Step__Insured_DOB__c, Lightning_Step__Member_Id__c, Lightning_Step__Insured_Gender__c,
                            Lightning_Step__Social_Security_Number__c, Lightning_Step__Prefer_Language__c,
                            Lightning_Step__Priority_Population__c, Lightning_Step__Preferred_Method_to_Contact__c,
                            Lightning_Step__Age__c, Lightning_Step__Marital_Status__c,
                            Lightning_Step__Inquiry_Status__c, Lightning_Step__Payor_ID__c, Lightning_Step__Status__c,
                            Lightning_Step__Potential_for_Admission__c, Lightning_Step__Household_Composition__c,
                            Lightning_Step__Occupation__c, Lightning_Step__Income_Range__c, Lightning_Step__Insurance_Program__c,
                            Lightning_Step__Race__c, Lightning_Step__Ethnicity__c, Lightning_Step__Employment_Status__c,
                            Lightning_Step__Benefits_Phone__c, Lightning_Step__Pre_Cert_Phone__c,
							Lightning_Step__Present_Legal_Issues__c, Lightning_Step__Legal_History__c,
                            Lightning_Step__Previous_CD_Treatment__c, Lightning_Step__Previous_MH_Treatment__c,
                            Lightning_Step__Mental_Health_Issues__c, Lightning_Step__Medical_Issues__c,
                            Lightning_Step__Current_Medications__c, Lightning_Step__Potential_Eating_Disorder__c,
                            Lightning_Step__Sleep_Apnea__c, Lightning_Step__Provide_detail_for_any_areas_checked__c,
                            Lightning_Step__Substance_of_Choice__c, Lightning_Step__Substances__c,
                            Lightning_Step__Precipitating_Event_Curren_Situation__c, Lightning_Step__Insured_Phone__c,
                            Lightning_Step__Group_Number__c, Lightning_Step__Projected_Admission_Date__c,
                            Lightning_Step__Preferred_Pronouns__c, Lightning_Step__Plan__c, Lightning_Step__Case_Disposition__c,Lightning_Step__Sexual_Orientation__c,Lightning_Step__Gender_Identity__c, 
                            Lightning_Step__Policy_Home_State__c, Lightning_Step__Verification_Status__c, Lightning_Step__Fax__c,
                            Lightning_Step__Private_Pay_Type_Pick__c, Lightning_Step__Program__c, Lightning_Step__Admission_Source__c,
                            Lightning_Step__Programs__c, Lightning_Step__Reason_For_Status__c, Lightning_Step__Middle_Name__c,
                            Lightning_Step__Relation_to_Potential_Client__c, Lightning_Step__State__c,
                            Lightning_Step__Zip_Postal_code__c, Lightning_Step__mrn_Number__c, Lightning_Step__Result_of_Call__c,
                            Lightning_Step__Insurance_Company__c, Lightning_Step__Primary_Reason_for_Call__c, Lightning_Step__Caller_is_Referral_Source__c,
                            Lightning_Step__Locations__r.Lightning_Step__Location_Id__c, Lightning_Step__Program__r.Lightning_Step__Program_Id__c,
                            Lightning_Step__Caller_First_Name__c, Lightning_Step__Caller_Last_Name__c, Lightning_Step__Caller_Primary_Phone__c,
                            Lightning_Step__Caller_Mobile_Phone__c, Lightning_Step__How_did_you_hear_about_us__c, Lightning_Step__Caller_Organization__c,
                            Lightning_Step__Insured_Middle_Name__c, Lightning_Step__Insured_mobile_phone__c,
                            Lightning_Step__Insured_Work_Phone__c, Lightning_Step__Insured_Address__c,
                            Lightning_Step__Insured_City__c, Lightning_Step__Insured_Postal_Code__c, Lightning_Step__Additional_Note__c,
                            Lightning_Step__Living_Situation__c, Lightning_Step__Residence_Type__c, Lightning_Step__Religious_Preference__c,
                            Lightning_Step__Insured_Country__c, Lightning_Step__Insured_State__c, Lightning_Step__Country__c,
                            Lightning_Step__Group_Name__c, Lightning_Step__Suffix__c, Lightning_Step__Prefers_to_Be_Called__c, 
                            Lightning_Step__Salutation__c, Lightning_Step__Alternate_First_Name__c, 
                            Lightning_Step__Place_of_Birth__c, Lightning_Step__Employer__c, Lightning_Step__Address_Line_2__c,
                            Lightning_Step__Referral_Source_Type__c, Lightning_Step__Home_Insurance_Company__c,
                            Lightning_Step__Maiden_Name__c
                            from Lightning_Step__Inquiry__c where Id IN:InquiryParam ];
           }
    }
    //Start method for Batch class.
    public List<Lightning_Step__Inquiry__c> start(Database.BatchableContext Bc)
    {
        return inquiryList;
    }
    //Execute Batch class for sending Inquiry into Lightning Step.
    public void execute(Database.BatchableContext Bc, List<Lightning_Step__Inquiry__c> scope)
    {
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
                for(Lightning_Step__Inquiry__c newCreatedInquiry :scope)
                {
                    if(newCreatedInquiry.Lightning_Step__Inquiry_Id__c==null){
                        string JsonPayload;
                        if(newCreatedInquiry.Lightning_Step__Postal_Code__c != null) {
                            JsonPayload='{"fname":'+'"'+newCreatedInquiry.Lightning_Step__First_Name__c+'",'+'"lname":'+'"'+newCreatedInquiry.Lightning_Step__Last_Name__c+'",'+'"zip":'+'"'+newCreatedInquiry.Lightning_Step__Postal_Code__c +'",'+'"payoraddress":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Address__c+'",'+'"payorcity":'+'"'+newCreatedInquiry.Lightning_Step__Payor_City__c+'",'+'"fundingsrc":'+'"'+newCreatedInquiry.Lightning_Step__Funding_Source__c+'",'+'"payorfax":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Fax__c+'",'+'"payorusstate":'+'"'+newCreatedInquiry.Lightning_Step__Payor_State__c+'",'+'"wphone":'+'"'+newCreatedInquiry.Lightning_Step__Work_Phone__c+'",'+'"payorzip":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Zip_Code__c+'",'+'"address":'+'"'+newCreatedInquiry.Lightning_Step__address__c+'",'+'"city":'+'"'+newCreatedInquiry.Lightning_Step__City__c+'",'+'"hphone":'+'"'+newCreatedInquiry.Lightning_Step__Home_Phone__c+'",'+'"gender":'+'"'+newCreatedInquiry.Lightning_Step__GENDER__c+'",'+'"usstate":'+'"'+newCreatedInquiry.Lightning_Step__State_Province__c+'",'+'"email":'+'"'+newCreatedInquiry.Lightning_Step__Email__c+'",'+'"dob":'+'"'+newCreatedInquiry.Lightning_Step__DOB__c+'",'+'"payorset":'+'"'+'yes'+'",'+'"payorname":'+'"'+newCreatedInquiry.Lightning_Step__Insurance_Company__c+'",'+'"owner_key":'+'"'+payload+'",';
                            //new fields
                            JsonPayload+='"cphone":"'+newCreatedInquiry.Lightning_Step__Primary_Phone__c+'","calleremail":"'+newCreatedInquiry.Lightning_Step__Caller_E_mail__c+'", "poc":"'+newCreatedInquiry.Lightning_Step__Purpose_of_Call_Primary_Reason_for_Call__c+'", "insreltoclient":"'+newCreatedInquiry.Lightning_Step__Lead_Relationship_to_insured__c+'", "insfname":"'+newCreatedInquiry.Lightning_Step__Insured_First_Name__c+'", "inslname":"'+newCreatedInquiry.Lightning_Step__Insured_Last_Name__c+'", "insdob":"'+newCreatedInquiry.Lightning_Step__Insured_DOB__c+'", "insgender":"'+newCreatedInquiry.Lightning_Step__Insured_Gender__c+'","inshphone":"'+newCreatedInquiry.Lightning_Step__Insured_Phone__c+'","mccontract_id":"'+newCreatedInquiry.Lightning_Step__mccontract_id__c+'", "memberidnumber":"'+newCreatedInquiry.Lightning_Step__Member_Id__c+'", "groupnumber":"'+newCreatedInquiry.Lightning_Step__Group_Number__c+'", "ssn":"'+newCreatedInquiry.Lightning_Step__Social_Security_Number__c+'", "preflanguage":"'+newCreatedInquiry.Lightning_Step__Prefer_Language__c+'", "priority_population":"'+newCreatedInquiry.Lightning_Step__Priority_Population__c+'", "compref":"'+newCreatedInquiry.Lightning_Step__Preferred_Method_to_Contact__c+'", "maritalstatus":"'+newCreatedInquiry.Lightning_Step__Marital_Status__c+'", "inquirystatus":"'+newCreatedInquiry.Lightning_Step__Status__c+'", "pfa":"'+newCreatedInquiry.Lightning_Step__Potential_for_Admission__c;
                            JsonPayload+='", "occupation":"'+newCreatedInquiry.Lightning_Step__Occupation__c+'", "race":"'+newCreatedInquiry.Lightning_Step__Race__c+'", "ethnicity":"'+newCreatedInquiry.Lightning_Step__Ethnicity__c+'", "obh_empstatus":"'+newCreatedInquiry.Lightning_Step__Employment_Status__c+'", "incomerange":"'+newCreatedInquiry.Lightning_Step__Income_Range__c+'", "benefitphone":"'+newCreatedInquiry.Lightning_Step__Benefits_Phone__c+'", "precertphone":"'+newCreatedInquiry.Lightning_Step__Pre_Cert_Phone__c+'", "policynumber":"'+newCreatedInquiry.Lightning_Step__Policy__c+'",';
                            JsonPayload+='"projdtadmission":"'+newCreatedInquiry.Lightning_Step__Projected_Admission_Date__c+'","preferred_pronouns":"'+newCreatedInquiry.Lightning_Step__Preferred_Pronouns__c+'","payorplan":"'+newCreatedInquiry.Lightning_Step__Plan__c+'",';
                            integer i = newCreatedInquiry.Lightning_Step__Present_Legal_Issues__c ? 1 : 0;
                            JsonPayload+='"islegalpresent":'+i+', "islegalhx":';
                            i = newCreatedInquiry.Lightning_Step__Legal_History__c ? 1 : 0;
                            JsonPayload+= i+', "isprevcdtx":';
                            i = newCreatedInquiry.Lightning_Step__Previous_CD_Treatment__c ? 1 : 0;
                            JsonPayload+= i+', "isprevmhtx":';
                            i = newCreatedInquiry.Lightning_Step__Previous_MH_Treatment__c ? 1 : 0;
                            JsonPayload+= i+', "ismh":';
                            i = newCreatedInquiry.Lightning_Step__Mental_Health_Issues__c ? 1 : 0;
                            JsonPayload+= i+', "ismedical":';
                            i = newCreatedInquiry.Lightning_Step__Medical_Issues__c ? 1 : 0;
                            JsonPayload+= i+', "ismedications":';
                            i = newCreatedInquiry.Lightning_Step__Current_Medications__c ? 1 : 0;
                            JsonPayload+= i+', "ised":';
                            i = newCreatedInquiry.Lightning_Step__Potential_Eating_Disorder__c ? 1 : 0;
                            JsonPayload+= i+', "apnea":';
                            i = newCreatedInquiry.Lightning_Step__Sleep_Apnea__c ? 1 : 0;
                            JsonPayload+=i;
                            JsonPayload+= ', "txtprescreen":"'+newCreatedInquiry.Lightning_Step__Provide_detail_for_any_areas_checked__c+'", "doc":"'+newCreatedInquiry.Lightning_Step__Substance_of_Choice__c+'", "txtsubdetail":"'+newCreatedInquiry.Lightning_Step__Substances__c+'", "precipevent":"'+newCreatedInquiry.Lightning_Step__Precipitating_Event_Curren_Situation__c+'",';
                            JsonPayload+= '"disposition_code":"'+newCreatedInquiry.Lightning_Step__Case_Disposition__c+'","sexualorientation":"'+newCreatedInquiry.Lightning_Step__Sexual_Orientation__c+'","genderidentity":"'+newCreatedInquiry.Lightning_Step__Gender_Identity__c+'","policyhomestate":"'+newCreatedInquiry.Lightning_Step__Policy_Home_State__c+'","vstatus":';
                            i = newCreatedInquiry.Lightning_Step__Verification_Status__c ? 1 : 0;
                            JsonPayload+= i+',"primaryreason_code":"'+newCreatedInquiry.Lightning_Step__Primary_Reason_for_Call__c+'","resultofcall":"'+newCreatedInquiry.Lightning_Step__Result_of_Call__c+'","mname":"'+newCreatedInquiry.Lightning_Step__Middle_Name__c+'","hse_comp":"'+newCreatedInquiry.Lightning_Step__Household_Composition__c+'","claim_code":"'+newCreatedInquiry.Lightning_Step__Insurance_Program__c+'","admissionsource":"'+newCreatedInquiry.Lightning_Step__Admission_Source__c+'",';
                            //Existing fields
                            JsonPayload+='"zip":"'+newCreatedInquiry.Lightning_Step__Postal_Code__c+'","usstate":"'+newCreatedInquiry.Lightning_Step__State_Province__c+'","reltoclient":"'+newCreatedInquiry.Lightning_Step__Relation_to_Potential_Client__c+'","reasonforstatus":"'+newCreatedInquiry.Lightning_Step__Reason_For_Status__c+'","planpriority":"'+newCreatedInquiry.Lightning_Step__Plan_Priority__c+'","location_id":"'+newCreatedInquiry.Lightning_Step__Locations__r.Lightning_Step__Location_Id__c+'","mrn":"'+newCreatedInquiry.Lightning_Step__mrn_Number__c+'","id":"'+newCreatedInquiry.Lightning_Step__Payor_ID__c+'",';
                            i = newCreatedInquiry.Lightning_Step__Caller_is_Referral_Source__c ? 1 : 0;
                            JsonPayload+='"privatetype":"'+newCreatedInquiry.Lightning_Step__Private_Pay_Type_Pick__c+'","potentialpgm_id":"'+newCreatedInquiry.Lightning_Step__Program__r.Lightning_Step__Program_Id__c+'","rsfax":"'+newCreatedInquiry.Lightning_Step__Fax__c+'", "isrefsrc":'+i+',';
                            JsonPayload += '"insmname":"'+newCreatedInquiry.Lightning_Step__Insured_Middle_Name__c+'","inscphone":"'+newCreatedInquiry.Lightning_Step__Insured_mobile_phone__c+'","inswphone":"'+newCreatedInquiry.Lightning_Step__Insured_Work_Phone__c+'","insaddress":"'+newCreatedInquiry.Lightning_Step__Insured_Address__c+'","inscity":"'+newCreatedInquiry.Lightning_Step__Insured_City__c+'","inszip":"'+newCreatedInquiry.Lightning_Step__Insured_Postal_Code__c+'","additionalnote":"'+newCreatedInquiry.Lightning_Step__Additional_Note__c+'",';
                            JsonPayload+='"livingsituation":"'+newCreatedInquiry.Lightning_Step__Living_Situation__c+'","residencetype":"'+newCreatedInquiry.Lightning_Step__Residence_Type__c+'","religion":"'+newCreatedInquiry.Lightning_Step__Religious_Preference__c+'","country":"'+newCreatedInquiry.Lightning_Step__Country__c+'","insusstate":"'+newCreatedInquiry.Lightning_Step__Insured_State__c+'","inscountry":"'+newCreatedInquiry.Lightning_Step__Insured_Country__c+'",';
                            JsonPayload+='"groupname":"'+newCreatedInquiry.Lightning_Step__Group_Name__c+'","suffix":"'+newCreatedInquiry.Lightning_Step__Suffix__c+'","salutation":"'+newCreatedInquiry.Lightning_Step__Salutation__c+'","birthplace":"'+newCreatedInquiry.Lightning_Step__Place_of_Birth__c+'","alias":"'+newCreatedInquiry.Lightning_Step__Prefers_to_Be_Called__c+'",';
                            i = newCreatedInquiry.Lightning_Step__Alternate_First_Name__c ?1 :0;
                            JsonPayload += '"isalias":'+i+',"refsrctype":"'+newCreatedInquiry.Lightning_Step__Referral_Source_Type__c+'","homeinsurance":"'+newCreatedInquiry.Lightning_Step__Home_Insurance_Company__c+'","maidenname":"'+newCreatedInquiry.Lightning_Step__Maiden_Name__c+'",';
                            JsonPayload+='"address2":"'+newCreatedInquiry.Lightning_Step__Address_Line_2__c+'","insemployer":"'+newCreatedInquiry.Lightning_Step__Employer__c+'","callerfname":"'+newCreatedInquiry.Lightning_Step__Caller_First_Name__c+'","callerlname":"'+newCreatedInquiry.Lightning_Step__Caller_Last_Name__c+'","callerhphone":"'+newCreatedInquiry.Lightning_Step__Caller_Primary_Phone__c+'","callercphone":"'+newCreatedInquiry.Lightning_Step__Caller_Mobile_Phone__c+'","howhear":"'+newCreatedInquiry.Lightning_Step__How_did_you_hear_about_us__c+'","orgname":"'+newCreatedInquiry.Lightning_Step__Caller_Organization__c+'"}';
                        } 
                        else {
                            JsonPayload='{"fname":'+'"'+newCreatedInquiry.Lightning_Step__First_Name__c+'",'+'"lname":'+'"'+newCreatedInquiry.Lightning_Step__Last_Name__c+'",'+'"payoraddress":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Address__c+'",'+'"payorcity":'+'"'+newCreatedInquiry.Lightning_Step__Payor_City__c+'",'+'"fundingsrc":'+'"'+newCreatedInquiry.Lightning_Step__Funding_Source__c+'",'+'"payorfax":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Fax__c+'",'+'"payorusstate":'+'"'+newCreatedInquiry.Lightning_Step__Payor_State__c+'",'+'"payorzip":'+'"'+newCreatedInquiry.Lightning_Step__Payor_Zip_Code__c+'",'+'"address":'+'"'+newCreatedInquiry.Lightning_Step__address__c+'",'+'"city":'+'"'+newCreatedInquiry.Lightning_Step__City__c+'",'+'"hphone":'+'"'+newCreatedInquiry.Lightning_Step__Home_Phone__c+'",'+'"wphone":'+'"'+newCreatedInquiry.Lightning_Step__Work_Phone__c+'",'+'"gender":'+'"'+newCreatedInquiry.Lightning_Step__GENDER__c+'",'+'"usstate":'+'"'+newCreatedInquiry.Lightning_Step__State_Province__c+'",'+'"email":'+'"'+newCreatedInquiry.Lightning_Step__Email__c+'",'+'"dob":'+'"'+newCreatedInquiry.Lightning_Step__DOB__c+'",'+'"payorset":'+'"'+'yes'+'",'+'"payorname":'+'"'+newCreatedInquiry.Lightning_Step__Insurance_Company__c+'",'+'"owner_key":'+'"'+payload+'",';
                        	//new fields
                            JsonPayload+='"cphone":"'+newCreatedInquiry.Lightning_Step__Primary_Phone__c+'","calleremail":"'+newCreatedInquiry.Lightning_Step__Caller_E_mail__c+'", "poc":"'+newCreatedInquiry.Lightning_Step__Purpose_of_Call_Primary_Reason_for_Call__c+'", "insreltoclient":"'+newCreatedInquiry.Lightning_Step__Lead_Relationship_to_insured__c+'", "insfname":"'+newCreatedInquiry.Lightning_Step__Insured_First_Name__c+'", "inslname":"'+newCreatedInquiry.Lightning_Step__Insured_Last_Name__c+'", "insdob":"'+newCreatedInquiry.Lightning_Step__Insured_DOB__c+'", "insgender":"'+newCreatedInquiry.Lightning_Step__Insured_Gender__c+'","inshphone":"'+newCreatedInquiry.Lightning_Step__Insured_Phone__c+'","mccontract_id":"'+newCreatedInquiry.Lightning_Step__mccontract_id__c+'", "memberidnumber":"'+newCreatedInquiry.Lightning_Step__Member_Id__c+'", "groupnumber":"'+newCreatedInquiry.Lightning_Step__Group_Number__c+'", "ssn":"'+newCreatedInquiry.Lightning_Step__Social_Security_Number__c+'", "preflanguage":"'+newCreatedInquiry.Lightning_Step__Prefer_Language__c+'", "priority_population":"'+newCreatedInquiry.Lightning_Step__Priority_Population__c+'", "compref":"'+newCreatedInquiry.Lightning_Step__Preferred_Method_to_Contact__c+'", "maritalstatus":"'+newCreatedInquiry.Lightning_Step__Marital_Status__c+'", "inquirystatus":"'+newCreatedInquiry.Lightning_Step__Status__c+'", "pfa":"'+newCreatedInquiry.Lightning_Step__Potential_for_Admission__c;
                            JsonPayload+='", "occupation":"'+newCreatedInquiry.Lightning_Step__Occupation__c+'", "race":"'+newCreatedInquiry.Lightning_Step__Race__c+'", "ethnicity":"'+newCreatedInquiry.Lightning_Step__Ethnicity__c+'", "obh_empstatus":"'+newCreatedInquiry.Lightning_Step__Employment_Status__c+'", "incomerange":"'+newCreatedInquiry.Lightning_Step__Income_Range__c+'", "benefitphone":"'+newCreatedInquiry.Lightning_Step__Benefits_Phone__c+'", "precertphone":"'+newCreatedInquiry.Lightning_Step__Pre_Cert_Phone__c+'", "policynumber":"'+newCreatedInquiry.Lightning_Step__Policy__c+'",';
                            JsonPayload+='"projdtadmission":"'+newCreatedInquiry.Lightning_Step__Projected_Admission_Date__c+'","preferred_pronouns":"'+newCreatedInquiry.Lightning_Step__Preferred_Pronouns__c+'","payorplan":"'+newCreatedInquiry.Lightning_Step__Plan__c+'",';
                            integer i = newCreatedInquiry.Lightning_Step__Present_Legal_Issues__c ? 1 : 0;
                            JsonPayload+='"islegalpresent":'+i+', "islegalhx":';
                            i = newCreatedInquiry.Lightning_Step__Legal_History__c ? 1 : 0;
                            JsonPayload+= i+', "isprevcdtx":';
                            i = newCreatedInquiry.Lightning_Step__Previous_CD_Treatment__c ? 1 : 0;
                            JsonPayload+= i+', "isprevmhtx":';
                            i = newCreatedInquiry.Lightning_Step__Previous_MH_Treatment__c ? 1 : 0;
                            JsonPayload+= i+', "ismh":';
                            i = newCreatedInquiry.Lightning_Step__Mental_Health_Issues__c ? 1 : 0;
                            JsonPayload+= i+', "ismedical":';
                            i = newCreatedInquiry.Lightning_Step__Medical_Issues__c ? 1 : 0;
                            JsonPayload+= i+', "ismedications":';
                            i = newCreatedInquiry.Lightning_Step__Current_Medications__c ? 1 : 0;
                            JsonPayload+= i+', "ised":';
                            i = newCreatedInquiry.Lightning_Step__Potential_Eating_Disorder__c ? 1 : 0;
                            JsonPayload+= i+', "apnea":';
                            i = newCreatedInquiry.Lightning_Step__Sleep_Apnea__c ? 1 : 0;
                            JsonPayload+=i;
                            JsonPayload+= ', "txtprescreen":"'+newCreatedInquiry.Lightning_Step__Provide_detail_for_any_areas_checked__c+'", "doc":"'+newCreatedInquiry.Lightning_Step__Substance_of_Choice__c+'", "txtsubdetail":"'+newCreatedInquiry.Lightning_Step__Substances__c+'", "precipevent":"'+newCreatedInquiry.Lightning_Step__Precipitating_Event_Curren_Situation__c+'",';
                            JsonPayload+= '"disposition_code":"'+newCreatedInquiry.Lightning_Step__Case_Disposition__c+'","sexualorientation":"'+newCreatedInquiry.Lightning_Step__Sexual_Orientation__c+'","genderidentity":"'+newCreatedInquiry.Lightning_Step__Gender_Identity__c+'","policyhomestate":"'+newCreatedInquiry.Lightning_Step__Policy_Home_State__c+'","vstatus":';
                            i = newCreatedInquiry.Lightning_Step__Verification_Status__c ? 1 : 0;
                            JsonPayload+= i+',"primaryreason_code":"'+newCreatedInquiry.Lightning_Step__Primary_Reason_for_Call__c+'","resultofcall":"'+newCreatedInquiry.Lightning_Step__Result_of_Call__c+'","mname":"'+newCreatedInquiry.Lightning_Step__Middle_Name__c+'","hse_comp":"'+newCreatedInquiry.Lightning_Step__Household_Composition__c+'","claim_code":"'+newCreatedInquiry.Lightning_Step__Insurance_Program__c+'","admissionsource":"'+newCreatedInquiry.Lightning_Step__Admission_Source__c+'",';
                            //Existing fields
                            JsonPayload+='"zip":"'+newCreatedInquiry.Lightning_Step__Postal_Code__c+'","usstate":"'+newCreatedInquiry.Lightning_Step__State_Province__c+'","reltoclient":"'+newCreatedInquiry.Lightning_Step__Relation_to_Potential_Client__c+'","reasonforstatus":"'+newCreatedInquiry.Lightning_Step__Reason_For_Status__c+'","planpriority":"'+newCreatedInquiry.Lightning_Step__Plan_Priority__c+'","location_id":"'+newCreatedInquiry.Lightning_Step__Locations__r.Lightning_Step__Location_Id__c+'","mrn":"'+newCreatedInquiry.Lightning_Step__mrn_Number__c+'","id":"'+newCreatedInquiry.Lightning_Step__Payor_ID__c+'",';
                            i = newCreatedInquiry.Lightning_Step__Caller_is_Referral_Source__c ? 1 : 0;
                            JsonPayload+='"privatetype":"'+newCreatedInquiry.Lightning_Step__Private_Pay_Type_Pick__c+'","potentialpgm_id":"'+newCreatedInquiry.Lightning_Step__Program__r.Lightning_Step__Program_Id__c+'","rsfax":"'+newCreatedInquiry.Lightning_Step__Fax__c+'", "isrefsrc":'+i+',';
                            JsonPayload += '"insmname":"'+newCreatedInquiry.Lightning_Step__Insured_Middle_Name__c+'","inscphone":"'+newCreatedInquiry.Lightning_Step__Insured_mobile_phone__c+'","inswphone":"'+newCreatedInquiry.Lightning_Step__Insured_Work_Phone__c+'","insaddress":"'+newCreatedInquiry.Lightning_Step__Insured_Address__c+'","inscity":"'+newCreatedInquiry.Lightning_Step__Insured_City__c+'","inszip":"'+newCreatedInquiry.Lightning_Step__Insured_Postal_Code__c+'","additionalnote":"'+newCreatedInquiry.Lightning_Step__Additional_Note__c+'",';
                            JsonPayload+='"livingsituation":"'+newCreatedInquiry.Lightning_Step__Living_Situation__c+'","residencetype":"'+newCreatedInquiry.Lightning_Step__Residence_Type__c+'","religion":"'+newCreatedInquiry.Lightning_Step__Religious_Preference__c+'","country":"'+newCreatedInquiry.Lightning_Step__Country__c+'","insusstate":"'+newCreatedInquiry.Lightning_Step__Insured_State__c+'","inscountry":"'+newCreatedInquiry.Lightning_Step__Insured_Country__c+'",';
                            JsonPayload+='"groupname":"'+newCreatedInquiry.Lightning_Step__Group_Name__c+'","suffix":"'+newCreatedInquiry.Lightning_Step__Suffix__c+'","salutation":"'+newCreatedInquiry.Lightning_Step__Salutation__c+'","birthplace":"'+newCreatedInquiry.Lightning_Step__Place_of_Birth__c+'","alias":"'+newCreatedInquiry.Lightning_Step__Prefers_to_Be_Called__c+'",';
                            i = newCreatedInquiry.Lightning_Step__Alternate_First_Name__c ?1 :0;
                            JsonPayload += '"isalias":'+i+',"refsrctype":"'+newCreatedInquiry.Lightning_Step__Referral_Source_Type__c+'","homeinsurance":"'+newCreatedInquiry.Lightning_Step__Home_Insurance_Company__c+'","maidenname":"'+newCreatedInquiry.Lightning_Step__Maiden_Name__c+'",';
                            JsonPayload+='"address2":"'+newCreatedInquiry.Lightning_Step__Address_Line_2__c+'","insemployer":"'+newCreatedInquiry.Lightning_Step__Employer__c+'","callerfname":"'+newCreatedInquiry.Lightning_Step__Caller_First_Name__c+'","callerlname":"'+newCreatedInquiry.Lightning_Step__Caller_Last_Name__c+'","callerhphone":"'+newCreatedInquiry.Lightning_Step__Caller_Primary_Phone__c+'","callercphone":"'+newCreatedInquiry.Lightning_Step__Caller_Mobile_Phone__c+'","howhear":"'+newCreatedInquiry.Lightning_Step__How_did_you_hear_about_us__c+'","orgname":"'+newCreatedInquiry.Lightning_Step__Caller_Organization__c+'"}';
                        }
                        JsonPayload = JsonPayload.replaceAll( 'null','' );
                        System.debug(JSON.serialize(JsonPayload));
                        System.debug( JsonPayload );
                        string resultInquiry=CalloutClass.createInquiry(accessToken,JsonPayload);
                        if(result!='The status code returned was not expected:')
                        {
                            System.debug('Res-->'+resultInquiry);
                            System.debug(payload);
                            Map<String, Object> m =  (Map<String, Object>)JSON.deserializeUntyped(resultInquiry);
                            Map<String, Object>  objectMap = (Map<String, Object>) m.get('data');
                            System.debug(objectMap);
                            newCreatedInquiry.Lightning_Step__Inquiry_Id__c=string.valueOf(objectMap.get('inquiry_id'));
                            newCreatedInquiry.Lightning_Step__DemoGraphic_Id__c=string.valueOf(objectMap.get('demographic_id'));
                            newCreatedInquiry.Lightning_Step__episode_id__c=string.valueOf(objectMap.get('episode_id'));
                            newCreatedInquiry.Lightning_Step__Payor_ID__c=string.valueOf(objectMap.get('payor_id'));
                            UpdatedinquiryList.add(newCreatedInquiry);
                        }     
                    }
                }
            }
        }
        
    }
    //Update the Inquiry
    public void finish(Database.BatchableContext Bc)
    {
        try
        {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Inquiry__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__DemoGraphic_Id__c') && fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__episode_id__c') &&
               fieldlevelsecurity.canReadField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_ID__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__Inquiry__c') && 
               fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Inquiry_Id__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__DemoGraphic_Id__c') && 
               fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__episode_id__c') && fieldlevelsecurity.canUpdateField('Lightning_Step__Inquiry__c','Lightning_Step__Payor_ID__c')) {
                   update UpdatedinquiryList;
               }
        }
        catch(Exception e)
        {
            system.debug('exception is '+e.getMessage());
        }
    }   
    
}