trigger ValidateContacts on Lightning_Step__Lightning_Step_Contact__c (before insert) {
    if(trigger.isBefore) {
        if(trigger.isInsert) {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Lightning_Step_Contact__c') && fieldlevelsecurity.canReadField('Lightning_Step__Lightning_Step_Contact__c','Lightning_Step__Data_Validation__c')) {
                HelperValidate.validateInsertContact(trigger.new);
            }
        }
    }
}