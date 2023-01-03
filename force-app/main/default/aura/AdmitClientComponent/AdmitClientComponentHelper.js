({
    hideSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.toggleClass(spinner, "slds-hide");
    },
    unhideForm:function (component, event, helper) 
    {
        var formData = component.find("dataForm");
        $A.util.toggleClass(formData, "slds-hide");
    },
    updateInquiry :function (component, event, helper) {
        event.preventDefault();  
        var fields = event.getParam('fields');
        fields.Lightning_Step__Locations__c = null;
        fields.Lightning_Step__Program__c = null;
        fields.Lightning_Step__Date_of_Submission__c = null;
        component.find('recordEditForm').submit(fields);
        component.set("v.ShowSpinnerLoc",false);
    },
    refreshPage:function(component,event,helper)
    {
        $A.get('e.force:refreshView').fire();
    },
    closeAction:function(component,event,helper)
    {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();            
    },
    showToastMessage : function(component,event,helper,type,title,message)
    {
        console.log('message ',message)
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "type": type,
            "title": title,
            "message":message 
        });
        resultsToast.fire();
    },
    showAdmitClient :function(component,event,helper) {
        var recordId = component.get("v.recordId");
        var action1 = component.get("c.isAdmitClient");
        action1.setParams({
            "inquiryId" : recordId
        });
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var returnedData1= response.getReturnValue();
                if(returnedData1) {
                    component.set("v.showError",false);
                    component.set("v.showModel",true);
                } else {
                    component.set("v.ShowErrorMessage",'Client Already Exist');
                    component.set("v.showError",true);
                    component.set("v.showModel",false);
                }
            }
        })
        $A.enqueueAction(action1);
    },
})