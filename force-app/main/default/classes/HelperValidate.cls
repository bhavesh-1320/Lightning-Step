public class HelperValidate {
    
    public static void validateInsertProgram(List<Lightning_Step__Program__c> programList) {
        for(Lightning_Step__Program__c program : programList) {
            if(!program.Lightning_Step__Data_Validation__c) {
                program.adderror('You are not allowed to manually create/update the Program records. These records are synced from server automatically.');
            }
        }
    }
    
    public static void validateUpdateProgram(List<Lightning_Step__Program__c> programList, Map<Id,Lightning_Step__Program__c> mapOfOldPrograms) {
        for(Lightning_Step__Program__c program : programList) {
            Lightning_Step__Program__c oldProgram = mapOfOldPrograms.get(program.Id);
            if(program.Lightning_Step__Data_Validation__c != oldProgram.Lightning_Step__Data_Validation__c && oldProgram.Lightning_Step__Data_Validation__c) {
                program.adderror('You are not allowed to manually create/update the Program records. These records are synced from server automatically.');
            }
        }
    }
    
    public static void validateInsertLocation(List<Lightning_Step__Location__c> locationList) {
        for(Lightning_Step__Location__c location : locationList) {
            if(!location.Lightning_Step__Data_Validation__c) {
                location.adderror('You are not allowed to manually create/update the Location records. These records are synced from server automatically.');
            }
        }
    }
    
    public static void validateUpdateLocation(List<Lightning_Step__Location__c> locationList, Map<Id,Lightning_Step__Location__c> mapOfOldlocations) {
        for(Lightning_Step__Location__c location : locationList) {
            Lightning_Step__Location__c oldlocation = mapOfOldlocations.get(location.Id);
            if(location.Lightning_Step__Data_Validation__c != oldlocation.Lightning_Step__Data_Validation__c && oldlocation.Lightning_Step__Data_Validation__c) {
                location.adderror('You are not allowed to manually create/update the Location records. These records are synced from server automatically.');
            }
        }
    }
    
    public static void validateInsertContact(List<Lightning_Step__Lightning_Step_Contact__c> conList) {
        for(Lightning_Step__Lightning_Step_Contact__c con : conList) {
            if(!con.Lightning_Step__Data_Validation__c) {
                con.adderror('You are not allowed to create the Contacts records from the Contact Tab. Create it from Inquiry only.');
            }
        }
    }
}