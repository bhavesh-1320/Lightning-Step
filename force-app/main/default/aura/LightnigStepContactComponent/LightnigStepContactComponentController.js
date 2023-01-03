({
    successMethod : function(component, event, helper) {
        var isDateError = component.get("v.dateValidationError");
        if(isDateError != true){
            component.set("v.ShowSpinnerCon",true);
            var payload = event.getParams().response;
            var action = component.get("c.CreateContact");
            action.setParams({
                "ConId" : payload.id
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if(state == "SUCCESS"){
                    var returnedData = response.getReturnValue();
                    component.set("v.isContact",false);
                    if(returnedData.includes('success'))
                    {
                        helper.showToast(component, event, helper,'Success','Contact Created','Contact has been Successfully Created');
                        helper.refreshPage(component, event, helper);
                        helper.closeAction(component, event, helper);
                    } else if(returnedData=='IdExist')
                    {
                        helper.deleteContact(component, event, helper,payload);
                        helper.showToast(component, event, helper,'Error','Error','Contact For This Inquiry Already Exists');
                        helper.closeAction(component, event, helper);
                    } else if(returnedData=='Client Id and Secret key Missing') {
                        helper.deleteContact(component, event, helper,payload);
                        helper.showToast(component, event, helper,'error','Error','Client Id and Secret key is Missing.');
                        helper.closeAction(component, event, helper);   
                    } else {
                        helper.deleteContact(component, event, helper,payload);
                        helper.showToast(component, event, helper,'error','Error',returnedData);
                        helper.refreshPage(component, event, helper);
                        helper.closeAction(component, event, helper);  
                    }
                }
            })
            $A.enqueueAction(action);
        }
    },
    closeModal: function(component, event, helper) {
        helper.closeAction(component, event, helper);  
    },
    submissionDate :function(component,event,helper) {
        var today = new Date();        
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        // if date is less then 10, then append 0 before date   
        if(dd < 10){
            dd = '0' + dd;
        } 
        // if month is less then 10, then append 0 before date    
        if(mm < 10){
            mm = '0' + mm;
        }
        
        var todayFormattedDate = yyyy+'-'+mm+'-'+dd;
        if(component.get("v.myDate") != '' && component.get("v.myDate") < todayFormattedDate){
            component.set("v.dateValidationError" , false);
        }else{
            component.set("v.dateValidationError" , true);
        }
        
        component.set("v.submissionDatefield",component.find("dob").get("v.value"));
    },
    handleLoad : function(component,event,helper) {
        component.set("v.showsubmissionDate",true);
    },
    doInit : function(component,event,helper) {
        var action2 = component.get("c.isSetup");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var returnedDataValue = response.getReturnValue();
                if(!returnedDataValue) {
                    component.set("v.showError",true);
                    component.set("v.showModel",false);
                    window.setTimeout(
                        $A.getCallback(function() {
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();  
                        }),2000
                    );
                } else {
                    component.set("v.showError",false);
                    component.set("v.showModel",true);
                }
            }
        })
        $A.enqueueAction(action2);
    },
})