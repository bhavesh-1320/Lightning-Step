trigger ContentDocumentLinkTrigger on ContentDocumentLink (After insert) {
    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            //Upload document in lightning step
            ContentDocumentLinkTriggerHelper.uploadDocument( Trigger.newMap.keySet() );
        }
    }
}