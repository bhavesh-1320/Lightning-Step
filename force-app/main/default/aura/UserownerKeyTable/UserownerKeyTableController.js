({
    //fetches list of user and its owner key
    myAction : function(component, event, helper) {
        helper.getDetailTable(component, event, helper);
    },
    //It fetches the value of owner key for the  selected user id
    editUserInfo:function(component, event, helper) {
        var userId=event.getSource().get("v.tabindex");
        var action = component.get("c.GetUserDetail");
        action.setParams({
            UserId:userId
        });
        action.setCallback(this,function(result){
            var state = result.getState();
            if(state == 'SUCCESS'){
                component.set("v.showTable",false);
                component.set("v.showEdit",true);
                var res = result.getReturnValue().split('&');  
                var userName=res[0];
                var ownerkey=res[1];
                var userIdd=res[2];
                var defaultuser=res[3];
                if(defaultuser!='false')
                {
                    component.set("v.showCheckbox",true);
                    component.set("v.SelectAsDefaultUser",true);
                } else {
                    component.set("v.showCheckbox",false);
                    component.set("v.SelectAsDefaultUser",false);
                }
                component.set("v.userName",ownerkey);
                component.set("v.clientOwnerKey",userName);
                component.set("v.UserIdd",userIdd);
            }
        });
        $A.enqueueAction(action);
    },
    //render the value of owner kry in password or text type
    showOwnerKey:function (component, event, helper) {
        var bool = component.get("v.showOwner");
        if(!bool) {
            var val = component.find("clientownerkey").get("v.value");
            component.set("v.showOwner", true);
            component.find("clientownerkeytext").set("v.value", val);
        } else {
            component.set("v.showOwner", false);
        }
    },
    // cancel action on edit popup
    cancelAction:function (component, event, helper) {
        component.set("v.showOwner", false); 
        component.set("v.showTable",true);
        component.set("v.showEdit",false);
        component.set("v.ShowRemoveButton",false); 
        helper.getDetailTable(component, event, helper);
        
    },
    //Saves the updated value of owner key
    savePanelval:function (component, event, helper) {
        var userId=component.get("v.UserIdd");
        console.log("Check",userId);
        var setAsDefault;
        var checkboxVal=component.get("v.SelectAsDefaultUser");
        console.log('checkboxVal '+checkboxVal)
        if(checkboxVal==true)
        {
            setAsDefault=true;
            component.set("v.defaultUsers",false);
        }
        else
        {
            setAsDefault=false;
        } 
        var ownerId;
        var showBlob = component.get("v.showOwner");
        if(showBlob) {
            ownerId = component.find("clientownerkeytext").get("v.value");
        } else {
             ownerId = component.find("clientownerkey").get("v.value");
        }
        console.log('ownerId ',ownerId);
        if(ownerId==''||ownerId==' '||ownerId==undefined )
        {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error!',
                message: 'Please fill owner key',
                type: 'error', 
            });
            toastEvent.fire();   
        }
        else
        {
            console.log('else  ');
            var action = component.get("c.EditUserDetail");
            action.setParams({
                UserId:userId,
                ownerKey:ownerId,
                DefaultVal:setAsDefault
            });
            action.setCallback(this,function(result){
                var state = result.getState();
                if(state == 'SUCCESS'){
                    component.set("v.showTable",true);
                    console.log('getsuccess',result.getReturnValue());
                    component.set("v.showEdit",false);
                    var res = result.getReturnValue();
                    if(res != null)
                    {
                        component.set("v.wrapList",res);    
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success!',
                            message: 'Owner Key value Successfully changed',
                            type: 'success', 
                        });
                        toastEvent.fire();
                    }
                    else
                    {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error!',
                            message: 'error Occured',
                            type: 'error', 
                        });
                        toastEvent.fire();
                        
                    }
                }
            });
            $A.enqueueAction(action);
            
        }
        
    } ,
    
    RemoveUserDetail:function (component, event, helper) {
        var action = component.get("c.CheckUserDefaultVal");
        var userId=component.get("v.UserIdd");
        
        action.setParams({
            userId:userId,
        });
        action.setCallback(this,function(result){
            var state = result.getState();
            if(state == 'SUCCESS'){
                
                if(result.getReturnValue()=='DefaultUser')
                {
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error!',
                        message: 'The user is the Company Default User You cannot Delete this',
                        type: 'error', 
                    });
                    toastEvent.fire();
                }
                else
                {
                    
                    helper.DeleteUser(component,event,helper);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    checkOwnerKeyVal:function(component, event, helper){
        var ownerKeyVal=event.getSource().get('v.clientOwnerKey');
        if(ownerKeyVal==' '|| ownerKeyVal==''||ownerKeyVal==undefined)
        {
            component.set("v.ShowRemoveButton",true); 
        }
        else{
            component.set("v.ShowRemoveButton",false); 
        }
    },
    
    checkSelectAsDefaultValues:function(component, event, helper){
        
        var checkBoxSelectedVal=event.getparam('checked');
        if(checkBoxSelectedVal==false)
        {
            component.set("v.SelectAsDefaultUser",false);
        }
    }
})