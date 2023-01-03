({
    showAdmitClientStatus :function(component, event, helper) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.CheckAdmitStatus");
        action.setParams({
            "inquiryId" : recordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS"){
                var returnedData = response.getReturnValue();
                component.set("v.isStatus",false);
                if(returnedData.includes('success')){
                    var data=returnedData.split(',');
                    var status=data[1];
                    component.set("v.status",status);
                    $A.get('e.force:refreshView').fire();
                    window.setTimeout(
                        $A.getCallback(function() {
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();  
                        }),2000
                    );
                    
                } else if(returnedData=='IdExist') { 
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": 'error',
                        "title": 'Error',
                        "message":'Inquiry Id or Client Id does not exist / Client is not Admitted yet'
                    });
                    resultsToast.fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();   
                } else if(returnedData=='Client Id And Secret Key Missing') {
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": 'error',
                        "title": 'Error',
                        "message":'Client Id And Secret Key Missing.'
                    });
                    resultsToast.fire();
                } else {
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": 'error',
                        "title": 'Error',
                        "message":returnedData
                    });
                    resultsToast.fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();          
                }
            }
        })
        $A.enqueueAction(action);
    }
})