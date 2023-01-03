({
	getLeadRecord : function(component, event, helper) {
        var recordId=component.get("v.recordId");
        var obName = component.get("v.sObjectName");
        console.log('LeadRecs');
        console.log( recordId );
        console.log( obName );
        var action = component.get("c.getLeadData");
        action.setParams({
            "leadId" : recordId, "objName": obName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS"){
                var returnedData = response.getReturnValue();
				component.set("v.showForm",true);
                component.set("v.leadRecord",returnedData); 
                if(returnedData.Lightning_Step__DOB__c != null) {
                    component.set("v.myDate",returnedData.Lightning_Step__DOB__c);
                    component.set("v.submissionDatefield",returnedData.Lightning_Step__DOB__c);
                }
            }
        })
        $A.enqueueAction(action);
         
    }, 
    showerror:function(component,event,helper){
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "type": "Error",
            "title": 'Error',
            "message":"Inquiry Record Already Exist"
        });
        resultsToast.fire();
        $A.get('e.force:refreshView').fire();
        
    },
    createInquiry : function(component,event,helper) {
        var recordId=component.get("v.recordId");
        var action = component.get("c.checkInquiryRec");
        action.setParams({
            "leadId" : recordId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS"){
                var returnedData = response.getReturnValue();
                if(returnedData=='false')
                {
                    component.set("v.showError",false);
                    helper.getLeadRecord(component, event, helper)
                }
                else
                {
                    component.set("v.ErrorMessage",'Inquiry Already Exist');
                    component.set("v.showError",true);
                    component.set("v.showForm",false); 
                }
            }
        })
        $A.enqueueAction(action);
    }, 
    showToast : function(component, event, helper,type,title,message) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "type": type,
            "title": title,
            "message":message 
        });
        resultsToast.fire();
    }, 
})