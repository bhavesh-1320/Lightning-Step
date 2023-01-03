({
    //It checks the client Id and secret key exists in custom setting
    checkCredential: function(component, event, helper)
    {
        var action = component.get("c.showLoginDetail");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var response= response.getReturnValue();
                var loginDetail=response.split(' ');
                var clientid=loginDetail[0];
                var secretKey=loginDetail[1];
                var bearerToken = loginDetail[2]; 
                component.set('v.clientId',clientid);
                component.set('v.clientSecret',secretKey);
                component.set('v.apiKey',bearerToken);
            }
        })
        
        $A.enqueueAction(action);  
    },
    // shows success message  on successfully saving the record
    ToastSuccessFunction : function(component) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success!',
            message: 'Client Id, Secret key and API Key has been succesfully added',
            type: 'success', 
        });
        toastEvent.fire();
    },
    ToastMakretingUserFunction : function(component,event,helper,type,title,message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: message,
            type: type, 
        });
        toastEvent.fire();
    },
    //it shows spinner on the page
    showSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
        console.log( 'mySpinner added' );
    },
    //it hide the spinner on the page
    hideSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
        console.log( 'mySpinner removed' );
    }, 
    showHideSpinner : function(component) {
        var showValue = component.get('v.ShowSpinner');
        var showValueLoc = component.get('v.ShowSpinnerLoc');
        var showValueIns = component.get('v.ShowSpinnerIns');
        var showValueMap = component.get('v.ShowSpinnerMap');
        console.log('ValMap:'+showValueMap);
        if(showValueMap) {
            var spinner = component.find("spinnerMap");
        	$A.util.removeClass(spinner, "slds-hide");
            console.log( 'spinnerMap:added' );
        } if(!showValueMap) {
            var spinner = component.find("spinnerMap");
        	$A.util.addClass(spinner, "slds-hide");
            console.log( 'spinnerMap:removed' );
        }
        
        if(showValueIns) {
            var spinner = component.find("spinnerIns");
        	$A.util.removeClass(spinner, "slds-hide");
        } if(!showValueIns){
            var spinner = component.find("spinnerIns");
        	$A.util.addClass(spinner, "slds-hide");
        }
        if(showValue) {
            var spinner = component.find("spinner");
        	$A.util.removeClass(spinner, "slds-hide");
        } if(!showValue){
            var spinner = component.find("spinner");
        	$A.util.addClass(spinner, "slds-hide");
        }
        if(showValueLoc) {
            var spinner = component.find("spinnerLoc");
        	$A.util.removeClass(spinner, "slds-hide");
        } if(!showValueLoc) {
            var spinner = component.find("spinnerLoc");
        	$A.util.addClass(spinner, "slds-hide");
        }
    },
    //shows success toast on saving owner key
    ToastSuccessOwnerKeyFunction : function(component) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success!',
            message: 'Owner Key has been succesfully added ',
            type: 'success', 
        });
        toastEvent.fire();
    },
    AddmoreOwnerKey:function(component,event,helper)
    {
        var action = component.get("c.CheckSetAsDefault");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var response= response.getReturnValue();
                if(response=='SetAsDefaultUser')
                {
                    component.set("v.ShowSetAsDefaultUser",false);
                    component.set("v.showUserownerKeyPage",false);
                    component.set("v.syncButton",false);
                    component.set("v.showlogin",false);
                    component.set("v.ShowSetup",true);
                    component.set("v.showUserSpecific",true);
                    component.set("v.showSyncButton",false);
                    component.set("v.isProgramtab",false);
                    component.set("v.islocationtab",false);
                    component.set("v.isInsurancetab",false);
                    component.set("v.isMaptab",false);
                }
                else if(response=='NotSetAsDefaultUser')
                {
                    component.set("v.ShowSetAsDefaultUser",true);
                    component.set("v.showUserownerKeyPage",false);
                    component.set("v.syncButton",false);
                    component.set("v.showlogin",false);
                    component.set("v.ShowSetup",true);
                    component.set("v.showUserSpecific",true);
                    component.set("v.showSyncButton",false);
                    component.set("v.isProgramtab",false);
                    component.set("v.islocationtab",false);
                    component.set("v.isInsurancetab",false);
                    component.set("v.isMaptab",false);
                }
            }
        })
        $A.enqueueAction(action);  
    }
    
    
})