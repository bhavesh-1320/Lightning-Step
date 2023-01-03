({
    getDetailTable : function(component, event, helper) {
        var action = component.get("c.fetchValues");
        action.setParams({
        });
        action.setCallback(this,function(result){
            var state = result.getState();
            if(state == 'SUCCESS'){
                var res = result.getReturnValue();                
                component.set("v.wrapList",res);                        
            }
        });
        $A.enqueueAction(action);
    },
    DeleteUser:function(component,event,helper)
    {
        var action = component.get("c.DeleteUser");
        var userId=component.get("v.UserIdd");
        
        action.setParams({
            userId:userId,
        });
        action.setCallback(this,function(result){
            var state = result.getState();
            if(state == 'SUCCESS'){
                
                if(result.getReturnValue()=='success')
                {
                    component.set("v.ShowRemoveButton",false); 
                    component.set("v.showEdit",false);
                    component.set("v.showTable",true);
                    
                    helper.getDetailTable(component, event, helper);
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success!',
                        message: 'User Info is successfully deleted',
                        type: 'success', 
                    });
                    toastEvent.fire();
                }
                else
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error!',
                        message: result.getReturnValue(),
                        type: 'error', 
                    });
                    toastEvent.fire();
                    
                }
                
            }
        });
        $A.enqueueAction(action);
    }
})