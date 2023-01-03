public class ContentDocumentLinkTriggerHelper {
    @future(Callout=true)
    public static void uploadDocument( Set< Id > newDocIds ){
        List< ContentDocumentLink > contDocLinks = [SELECT Id, ContentDocument.FileExtension, 
                                                    LinkedEntityId , ContentDocument.Title, 
                                                    ContentDocument.LatestPublishedVersion.VersionData 
                                                    FROM ContentDocumentLink WHERE Id IN :newDocIds
                                                   ];
        Map< Id, List<ContentDocumentLink> > inqIdContLinkMap = new Map< Id, List<ContentDocumentLink> >(); 
        for( ContentDocumentLink contDocLink : contDocLinks ){
            String sObjName = contDocLink.LinkedEntityId.getSObjectType().getDescribe().getName();
            if( sObjName == 'Lightning_Step__Inquiry__c' ){
                if( !inqIdContLinkMap.containsKey( contDocLink.LinkedEntityId ) ){
                    inqIdContLinkMap.put( contDocLink.LinkedEntityId, new List<ContentDocumentLink>() );
                }
                inqIdContLinkMap.get( contDocLink.LinkedEntityId ).add( contDocLink );    
            }
        }
        if( !inqIdContLinkMap.isEmpty() ){
            List<Lightning_Step__Inquiry__c> inquiries = [SELECT Id, Lightning_Step__Inquiry_Id__c FROM Lightning_Step__Inquiry__c
                                                          WHERE Id IN :inqIdContLinkMap.keySet() 
                                                          AND Lightning_Step__Inquiry_Id__c != null
                                                         ];
            if( !inquiries.isEmpty() ){
                for( Lightning_Step__Inquiry__c inquiry : inquiries ){
                    List< ContentDocumentLink > contDocLinksOfInq = inqIdContLinkMap.get( inquiry.Id );
                    for( ContentDocumentLink contDocL : contDocLinksOfInq ){
                        String payLoad = '{"filename":"'+contDocL.ContentDocument.Title+'.';
                        payLoad+=contDocL.ContentDocument.FileExtension+'","mimetype": "text/plain",';
                        payLoad+='"inquiry_id":"'+inquiry.Lightning_Step__Inquiry_Id__c+'","content":"';
                        String encodedBody = EncodingUtil.base64Encode(contDocL.ContentDocument.LatestPublishedVersion.VersionData);
                        payLoad+=encodedBody+'"}';
                        System.debug(payLoad);
                        String response = CalloutClass.createDocument( payLoad );
                        System.debug(response);
                    }                                          
                }  
            }    
        }
    }
}