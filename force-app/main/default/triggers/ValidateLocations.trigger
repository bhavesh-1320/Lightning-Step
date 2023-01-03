trigger ValidateLocations on Lightning_Step__Location__c (before insert, before update) {
    if(trigger.isBefore) {
        if(trigger.isInsert) {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canReadField('Lightning_Step__Location__c','Lightning_Step__Data_Validation__c')) {
                HelperValidate.validateInsertLocation(trigger.new);
            }
        }
        if(trigger.isUpdate) {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Location__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__Location__c')) {
                HelperValidate.validateUpdateLocation(trigger.new,trigger.oldMap);
            }
        }
    }
}