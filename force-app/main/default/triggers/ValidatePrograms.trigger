trigger ValidatePrograms on Lightning_Step__Program__c (before insert, before update) {

    if(trigger.isBefore) {
        if(trigger.isInsert) {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canReadField('Lightning_Step__Program__c','Lightning_Step__Data_Validation__c')) {
                HelperValidate.validateInsertProgram(trigger.new);
            }
        }
        if(trigger.isUpdate) {
            if(fieldlevelsecurity.canReadObject('Lightning_Step__Program__c') && fieldlevelsecurity.canUpdateObject('Lightning_Step__Program__c')) {
                HelperValidate.validateUpdateProgram(trigger.new,trigger.oldMap);
            }
        }
    }
}