({
    successMethod : function(component, event, helper) {
        var isDateError = component.get("v.dateValidationError");
        if(isDateError != true){
            component.set("v.ShowSpinnerLoc",true);
            var recordId = component.get("v.recordId");
            var action = component.get("c.AdmitClient");
            action.setParams({
                "InquiryId" : recordId
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                
                if(state == "SUCCESS"){
                    var returnedData = response.getReturnValue();
                    if(returnedData.includes('success')){
                        helper.showToastMessage(component, event, helper,'Success','Admit Client','Client is Admitted');
                        helper.refreshPage(component);
                        helper.closeAction(component);        
                    }
                    else
                        if(returnedData=='EmptyOwnerType')
                        {
                            helper.updateInquiry(component, event, helper);
                            helper.showToastMessage(component, event, helper,'error','Client Admission failed','Owner key is Empty');
                            helper.closeAction(component);  
                            
                        }
                        else
                            if(returnedData=='Client Id and Secret Key Missing')
                            {
                                helper.updateInquiry(component, event, helper);
                                helper.showToastMessage(component, event, helper,'error','Error','Client Id and Secret key is Missing.');
                                helper.closeAction(component);    
                            }
                            else
                            {
                                helper.updateInquiry(component, event, helper);
                                helper.showToastMessage(component, event, helper,'error','Error',returnedData);
                                helper.closeAction(component);     
                            }                
                }
                else
                {
                    helper.updateInquiry(component, event, helper);
                    helper.showToastMessage(component,event,helper,'error','Error',state);
                }
            })
            $A.enqueueAction(action);
        }
        
    },
    myChange: function(component, event, helper){
        var myAttri = component.find("myAtt").get("v.value");
        if(myAttri != '') {
            component.set("v.locationId",myAttri);
            component.set("v.showProgram",true);
        } else {
            component.set("v.showProgram",false);
        }
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
            component.set("v.dateValidationError" , true);
        }else{
            component.set("v.dateValidationError" , false);
            
        }
        component.set("v.submissionDatefield",component.find("dob").get("v.value"));
        
    },
    HandlerselectedLookUpRecord :function(component,event,helper)
    {
        var response = JSON.parse(JSON.stringify(component.get("v.selectedLookUpRecord")));
        component.set("v.selectedProgramId",response.Id);
    },
    handleLoad : function(component, event, helper){
        $A.util.addClass(component.find("spinner"), "slds-hide");    
        component.set("v.showsubmissionDate",true);
    },
    doInit:function(component,event,helper)
    {
        var action2 = component.get("c.isSetup");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var returnedDataValue = response.getReturnValue();
                if(returnedDataValue) {
                    helper.showAdmitClient(component, event, helper);
                } else {
                    component.set("v.ShowErrorMessage",'Client Id and Secret key is Missing.');
                    component.set("v.showModel",false);
                    component.set("v.showError",true);
                    window.setTimeout(
                        $A.getCallback(function() {
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();  
                        }),2000
                    );
                }
            }
        })
        $A.enqueueAction(action2);
    },
    closeModal:function(component,event,helper)
    {
        helper.closeAction(component);     
    },
    handleSucess :function(component,event,helper) {
        
    }
})