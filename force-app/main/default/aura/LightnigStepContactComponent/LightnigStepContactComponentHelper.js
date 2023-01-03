({
    showToast : function(component, event, helper,type,title,message) 
    {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "type": type,
            "title": title,
            "message":message 
        });
        resultsToast.fire();
    },
    deleteContact : function(component, event, helper, payload) {
        var deleteAction = component.get("c.deleteContact");
        deleteAction.setParams({
            "contactId" : payload.id
        });
        deleteAction.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state ',state);
        })
        $A.enqueueAction(deleteAction);
    },
    refreshPage : function(component, event, helper)
    {
        $A.get('e.force:refreshView').fire();
    },
    closeAction : function(component, event, helper)
    {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }
    
})