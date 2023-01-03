({
    getInsuranceList : function(cmp,helper) {
        var action = cmp.get("c.getInsuranceRecs");
        var pageSize = cmp.get("v.pageSize").toString();
        var pageNumber = cmp.get("v.pageNumber").toString();
        action.setParams({
            'pageSize' : pageSize,
            'pageNumber' : pageNumber
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.sort((a, b) => (a.Lightning_Step__MC_Name__c > b.Lightning_Step__MC_Name__c) ? 1 : -1);
                if(records.length >= 10) {
                    cmp.set("v.showHeader", true);
                }
                records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                if(records.length < cmp.get("v.pageSize")){
                    cmp.set("v.isLastPage", true);
                } else{
                    cmp.set("v.isLastPage", false);
                } 
                helper.hideSpinner(cmp);
                cmp.set("v.dataSize", records.length);
                cmp.set("v.insuranceList", records);
            }
        });
        $A.enqueueAction(action);
        
    },
    
    showSpinner: function (cmp) {
        var spinner = cmp.find("mySpinner");
        $A.util.removeClass(spinner,"slds-hide");
    },
    
    ToastOwnerKeyFunction : function(component) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error!',
            message: 'You do not have any Default User for Processing. Please check User Info and Client id and Client Secret',
            type: 'error', 
        });
        toastEvent.fire();
    },
    //To hide the spinner
    hideSpinner: function (cmp) {
        console.log('Call');
        var spinner = cmp.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    }
})