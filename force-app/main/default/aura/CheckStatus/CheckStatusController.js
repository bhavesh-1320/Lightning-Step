({
    //It fetches the status of client in lightning step
    doinit : function(component, event, helper) {
        var action2 = component.get("c.isSetup");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var returnedDataValue = response.getReturnValue();
                if(returnedDataValue) {
                    component.set("v.showModel",true);
                    component.set("v.showError",false);
                    helper.showAdmitClientStatus(component, event, helper);
                } else {
                    component.set("v.showError",true);
                    component.set("v.showModel",false);
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
    }
})