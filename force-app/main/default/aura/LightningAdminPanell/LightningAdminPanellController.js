({
    //It shows the selected tab by the navigation bar
    handleOnSelect: function(component, event,helper) {
        event.preventDefault();
        //when selected value is Setup API
        if(event.getParam('name')=='Setup API'){
            var action2 = component.get("c.showdetail");
            action2.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    var response= response.getReturnValue();
                    if(response==true)
                    {
                        component.set("v.showlogin",true);
                        component.set("v.syncButton",false);
                        component.set("v.isOpenModalForUser",false);
                        component.set("v.showEdit",false);
                        component.set("v.ShowSetup",false);
                        component.set("v.showUserSpecific",false);
                        component.set("v.showSyncButton",false);
                        component.set("v.showUserownerKeyPage",false); 
                        component.set("v.homePage",false);
                        component.set("v.SelectOwnerKeyError",false);
                        component.set("v.checkEntry",false);
                        component.set("v.isProgramtab",false);
                        component.set("v.islocationtab",false);
                        component.set("v.isInsurancetab",false);
                        component.set("v.isMaptab",false);
                        helper.checkCredential(component, event, helper);
                    }
                    else
                    {
                        component.set("v.showlogin",false); 
                        component.set("v.showEdit",true);
                        component.set("v.syncButton",false);
                        component.set("v.isOpenModalForUser",false);
                        component.set("v.ShowSetup",false);
                        component.set("v.showUserSpecific",false);
                        component.set("v.showSyncButton",false);
                        component.set("v.showUserownerKeyPage",false); 
                        component.set("v.SelectOwnerKeyError",false);
                        component.set("v.checkEntry",false);
                        component.set("v.clientId",null);
                        component.set("v.clientSecret",null);
                        component.set("v.isProgramtab",false);
                        component.set("v.islocationtab",false);
                        component.set("v.isInsurancetab",false);
                        component.set("v.isMaptab",false);
                    }
                    
                }
            })
            $A.enqueueAction(action2);     
        }
        else
            //Selected value is OwnerKey
            if(event.getParam('name')=='OwnerKey'){
                var action1 = component.get("c.OwnerKeyRecord");
                action1.setCallback(this, function(response){
                    var state = response.getState();
                    if (state =="SUCCESS") {
                        var response= response.getReturnValue();
                        if(response!=null)
                        {
                            if(response=='SetAsDefaultUser')
                            {
                                component.set("v.ShowSetup",false);
                                component.set("v.DisableNewRecCancel",false);
                                component.set("v.showUserownerKeyPage",true);  
                                component.set("v.showEdit",false);
                                component.set("v.syncButton",false);
                                component.set("v.showlogin",false);
                                component.set("v.showUserSpecific",false);
                                component.set("v.showSyncButton",false);
                                component.set("v.isOpenModalForUser",false);
                                component.set("v.SelectOwnerKeyError",false);
                                component.set("v.checkEntry",false);
                                component.set("v.isProgramtab",false);
                                component.set("v.islocationtab",false);
                                component.set("v.isInsurancetab",false);
                                component.set("v.isMaptab",false);
                            }
                            else if(response=='NotSetAsDefaultUser')
                            {
                                component.set("v.ShowSetup",false); 
                                component.set("v.DisableNewRecCancel",false);
                                component.set("v.showUserownerKeyPage",true);  
                                component.set("v.showEdit",false);
                                component.set("v.syncButton",false);
                                component.set("v.showlogin",false);
                                component.set("v.showUserSpecific",false);
                                component.set("v.showSyncButton",false);
                                component.set("v.isOpenModalForUser",false);
                                component.set("v.SelectOwnerKeyError",false);
                                component.set("v.checkEntry",false);
                                component.set("v.islocationtab",false);
                                component.set("v.isProgramtab",false);
                                component.set("v.isInsurancetab",false);
                                component.set("v.isMaptab",false);
                                
                            }
                                else
                                    
                                {
                                    component.set("v.showEdit",false);
                                    component.set("v.syncButton",false);
                                    component.set("v.showlogin",false);
                                    component.set("v.ShowSetup",true);
                                    component.set("v.showUserSpecific",true);
                                    component.set("v.ShowSetAsDefaultUser",true);
                                    component.set("v.showSyncButton",false);
                                    component.set("v.isOpenModalForUser",false);
                                    component.set("v.SelectOwnerKeyError",false);
                                    component.set("v.DisableNewRecCancel",true);
                                    component.set("v.checkEntry",false);
                                    component.set("v.isProgramtab",false);
                                    component.set("v.islocationtab",false);
                                    component.set("v.isInsurancetab",false);
                                    component.set("v.isMaptab",false);
                                }
                            
                        }    
                    } 
                })
                $A.enqueueAction(action1);
            }
            else
                if(event.getParam('name')=='LocationTab'){
                    var action2 = component.get("c.checkMarketingUserWithUserCredentials");
                    action2.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state === "SUCCESS") {
                            var response= response.getReturnValue();
                            if(response == 'success') {
                                component.set("v.showSyncButton",false);
                                component.set("v.showlogin",false);
                                component.set("v.ShowSpinnerLoc",true);
                                component.set("v.islocationtab",true);
                                component.set("v.isProgramtab",false);
                                component.set("v.syncButton",false);
                                component.set("v.showEdit",false);
                                component.set("v.ShowSetup",false);
                                component.set("v.showUserSpecific",false);
                                component.set("v.showUserownerKeyPage",false);
                                component.set("v.isOpenModalForUser",false);
                                component.set("v.isInsurancetab",false);
                                component.set("v.isMaptab",false);
                            } else {
                                if(response == 'Client Id and Secret key is Missing.') {
                                    helper.ToastMakretingUserFunction(component,event,helper,'error','Error',response);
                                } else {
                                    helper.ToastMakretingUserFunction(component,event,helper,'warning','Warning',response);
                                }
                            }
                        }
                    });
                    $A.enqueueAction(action2); 
                }
                else
                    if(event.getParam('name')=='ProgramTab'){
                        var action4 = component.get("c.checkMarketingUserWithUserCredentials");
                        action4.setCallback(this, function(response) {
                            var state = response.getState();
                            if (state === "SUCCESS") {
                                var response= response.getReturnValue();
                                if(response == 'success') {
                                    component.set("v.showSyncButton",false);
                                    component.set("v.showlogin",false);
                                    component.set("v.ShowSpinner",true);
                                    component.set("v.islocationtab",false);
                                    component.set("v.isProgramtab",true);
                                    component.set("v.syncButton",false);
                                    component.set("v.showEdit",false);
                                    component.set("v.ShowSetup",false);
                                    component.set("v.showUserSpecific",false);
                                    component.set("v.showUserownerKeyPage",false);
                                    component.set("v.isOpenModalForUser",false);
                                    component.set("v.isInsurancetab",false);
                                    component.set("v.isMaptab",false);
                                } else {
                                    if(response == 'Client Id and Secret key is Missing.') {
                                        helper.ToastMakretingUserFunction(component,event,helper,'error','Error',response);
                                    } else {
                                        helper.ToastMakretingUserFunction(component,event,helper,'warning','Warning',response);
                                    }
                                }
                            }
                        });
                        $A.enqueueAction(action4);
                    }
        //Selected value is MapTab-Change
        if( event.getParam('name')== 'MapTab' ){
            component.set("v.showSyncButton",false);
            component.set("v.showlogin",false);
            component.set("v.ShowSpinnerMap",true);
            component.set("v.isMaptab",true);
            component.set("v.islocationtab",false);
            component.set("v.isProgramtab",false);
            component.set("v.syncButton",false);
            component.set("v.showEdit",false);
            component.set("v.ShowSetup",false);
            component.set("v.showUserSpecific",false);
            component.set("v.showUserownerKeyPage",false);
            component.set("v.isOpenModalForUser",false);
            component.set("v.isInsurancetab",false);
        }
        //Selected value is InsuranceTab-Change
        if( event.getParam('name')=='InsuranceTab' ){
            component.set("v.showSyncButton",false);
            component.set("v.showlogin",false);
            component.set("v.ShowSpinnerIns",true);
            component.set("v.islocationtab",false);
            component.set("v.isProgramtab",false);
            component.set("v.syncButton",false);
            component.set("v.showEdit",false);
            component.set("v.ShowSetup",false);
            component.set("v.showUserSpecific",false);
            component.set("v.showUserownerKeyPage",false);
            component.set("v.isOpenModalForUser",false);
            component.set("v.isInsurancetab",true);
            component.set("v.isMaptab",false);
        }
        
    },
    ShowSpinnerHandler:function(component, event, helper) 
    {
        helper.showHideSpinner(component); 
    },
    ShowSpinnerHandlerLoc:function(component, event, helper) 
    {
        helper.showHideSpinner(component); 
    },
    ShowSpinnerHandlerIns:function(component, event, helper) 
    {
        helper.showHideSpinner(component); 
        console.log('Finall');
    },
    ShowSpinnerHandlerMap:function(component, event, helper) 
    {
        helper.showHideSpinner(component);
    },
    //It runs when the page loads and set to setup API tab as default
    ShowLoginInformation:function(component, event, helper) {
        component.set("v.selectedItem",'Setup API')
        var action = component.get("c.showdetail");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var response= response.getReturnValue();
                if(response==true)
                {
                    component.set("v.showSecret", false);
                    component.set("v.showDiv", false);
                    component.set("v.showApi", false);
                    component.set("v.showApiDiv", false);
                    
                    component.set("v.showlogin",true);
                    component.set("v.syncButton",false);
                    component.set("v.showEdit",false);
                    component.set("v.ShowSetup",false);
                    component.set("v.showUserSpecific",false);
                    component.set("v.showOwnerKey",false);
                    component.set("v.showSyncButton",false);
                    component.set("v.showUserownerKeyPage",false); 
                    component.set("v.SelectOwnerKeyError",false);
                    component.set("v.checkEntry",false);
                    component.set("v.isProgramtab",false);
                    component.set("v.islocationtab",false);
                    component.set("v.isInsurancetab",false);
                    component.set("v.isMaptab",false);
                    helper.checkCredential(component, event, helper);
                    
                }
                else
                {
                    
                    component.set("v.showlogin",false); 
                    component.set("v.showEdit",true);
                    component.set("v.disabledbutton",true);
                    component.set("v.syncButton",false);
                    component.set("v.clientId",null);
                    component.set("v.clientSecret",null);
                    component.set("v.ShowSetup",false);
                    component.set("v.showUserSpecific",false);
                    component.set("v.showSyncButton",false);
                    component.set("v.showUserownerKeyPage",false); 
                    component.set("v.SelectOwnerKeyError",false);
                    component.set("v.checkEntry",false);
                    component.set("v.isProgramtab",false);
                    component.set("v.islocationtab",false);
                    component.set("v.isInsurancetab",false);
                    component.set("v.isMaptab",false);
                }
                
            }
        })
        
        
        
        $A.enqueueAction(action);
    },
    //render  client secret key in password and text  type
    ShowSecretKeyInView:function (component, event, helper) {
        var bool = component.get("v.showSecret");
        if(!bool) {
            var val = component.find("clientSecret").get("v.value");
            component.set("v.showSecret", true);
            component.find("clientSecretText").set("v.value", val);
            
        } else {
            component.set("v.showSecret", false);
        }
    },
    showApiKeyInView : function (component, event, helper) {
        var bool = component.get("v.showApi");
        if(!bool) {
            var val = component.find("apiKey").get("v.value");
            component.set("v.showApi", true);
            component.find("apiKeyText").set("v.value", val);
            
        } else {
            component.set("v.showApi", false);
        }
    },
    //Onclick of edit button on setup API credential
    EditLoginDetail:function(component, event, helper) {
        component.set("v.showSecret", false);
        component.set("v.showDiv", false);
        component.set("v.showApi", false);
        component.set("v.showApiDiv", false);
        
        component.set("v.showlogin",false);
        component.set("v.syncButton",false);
        component.set("v.ShowSetup",false);
        component.set("v.showUserSpecific",false);
        component.set("v.showSyncButton",false);
        component.set("v.showUserownerKeyPage",false); 
        component.set("v.showEdit",true); 
        component.set("v.isOpenModalForUser",false);
        component.set("v.SelectOwnerKeyError",false);
        component.set("v.checkEntry",false);
        component.set("v.isProgramtab",false);
        component.set("v.islocationtab",false);
        component.set("v.isInsurancetab",false);
        component.set("v.isMaptab",false);
    },
    
    //render client secret key in password and text type       
    ShowSecretKey:function (component, event, helper) {
        var bool = component.get("v.showDiv");
        if(!bool) {
            var val = component.find("clientSecret1").get("v.value");
            component.set("v.showDiv", true);
            component.find("passwordText").set("v.value", val);
        } else {
            component.set("v.showDiv", false);
        }
    },
    //render Api key in password and text type
    ShowApiKey:function (component, event, helper) {
        var bool = component.get("v.showApiDiv");
        if(!bool) {
            var val = component.find("apiKey1").get("v.value");
            component.set("v.showApiDiv", true);
            component.find("apiKeyText1").set("v.value", val);
        } else {
            component.set("v.showApiDiv", false);
        }
    },
    //To save the client Id and Secret Key in custom setting API credential        
    savePanelval:function(component, event, helper) {
        var clientId= component.find("ClientId1").get("v.value");
        var clientSecret;
        var bool = component.get("v.showDiv");
        if(bool) {
            clientSecret = component.find("passwordText").get("v.value");
        } else {
            clientSecret = component.find("clientSecret1").get("v.value");
        }
        //For API key
        var apiKey;
        var boolApi = component.get("v.showApiDiv");
        if(boolApi) {
            apiKey = component.find("apiKeyText1").get("v.value");
        } else {
            apiKey = component.find("apiKey1").get("v.value");
        }
        console.log( apiKey );
        console.log( 'ClientId:'+ clientId);
        console.log( 'ClientId:'+ clientSecret);
        console.log( 'ClientId:'+ apiKey);
        if(clientId=='' || clientId == undefined || clientSecret == undefined ||clientSecret=='' || clientSecret==' ' || apiKey=='' || apiKey==' ' || apiKey==undefined )
        {
            component.set("v.checkEntry",true);
        }
        else{
            component.set("v.checkEntry",false);
            var action = component.get("c.EditloginDetail");
            action.setParams({
                clientId:clientId,
                clientSecret:clientSecret,
                apiKey:apiKey
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.showEdit",false); 
                    component.set("v.showlogin",true);
                    component.set("v.syncButton",false);
                    component.set("v.disabledbutton",false);
                    component.set("v.ShowSetup",false);
                    component.set("v.showUserSpecific",false);
                    component.set("v.showOwnerKey",false);
                    component.set("v.showSyncButton",false);
                    component.set("v.showUserownerKeyPage",false);
                    component.set("v.homePage",false);
                    component.set("v.SelectOwnerKeyError",false);
                    component.set("v.checkEntry",false);
                    component.set("v.isProgramtab",false);
                    component.set("v.islocationtab",false);
                    component.set("v.isInsurancetab",false);
                    component.set("v.isMaptab",false);
                    var response= response.getReturnValue();
                    if(response!=null)
                    {
                        helper.ToastSuccessFunction(component); 
                        
                        component.set("v.showSecret", false);
                        component.set("v.showDiv", false);
                        component.find("clientSecretText").set("v.value", clientSecret);
                        component.find("clientSecret").set("v.value", clientSecret);
                        component.find("passwordText").set("v.value", clientSecret);
                        component.find("clientSecret1").set("v.value", clientSecret);
                        
                        component.set("v.showApi", false);
                        component.set("v.showApiDiv", false);
                        /*
                        var bool = component.get("v.showSecret");
                        var bool1 = component.get("v.showDiv");
                        if(!bool) {
                            component.set("v.showSecret", true);
                            component.find("clientSecretText").set("v.value", clientSecret);
                                                        
                        } if(bool){
                            component.set("v.showSecret", false);
                            component.find("clientSecret").set("v.value", clientSecret);
                        }
                        if(!bool1) {
                            component.set("v.showDiv", true);
                            component.find("passwordText").set("v.value", clientSecret);
                            component.find("clientSecret1").set("v.value", clientSecret);
                            
                        } if(bool1){
                            component.set("v.showDiv", false);
                            component.find("clientSecret1").set("v.value", clientSecret);
                            component.find("passwordText").set("v.value", clientSecret);
                        }*/
                    }
                }
            })
        }
        $A.enqueueAction(action);
    },
    //Cancel the edit in client Id and Secret Key
    cancelAction:function(component, event, helper) {
        helper.checkCredential(component, event, helper);
        component.set("v.ShowSetup",false);
        component.set("v.showEdit",false);
        component.set("v.syncButton",false);
        component.set("v.showlogin",true);
        component.set("v.showUserSpecific",false);
        component.set("v.showSyncButton",false);
        component.set("v.EditCOmpanyDefault",false);
        component.set("v.checkEntry",false);
        component.set("v.SelectOwnerKeyError",false);
        component.set("v.isProgramtab",false);
        component.set("v.islocationtab",false);
        component.set("v.isInsurancetab",false);
        
        component.set("v.showSecret", false);
        component.set("v.showDiv", false);
        component.set("v.showApi", false);
        component.set("v.showApiDiv", false);
        component.set("v.isMaptab",false);
    },
    //to change the owner type from company specific to user specific .this opens a modal popup for confrimation to chnage the owner key type
    
    
    
    //render owner key value in edit mode in user specific type        
    showNewUserpageFun:function (component, event, helper){
        var bool = component.get("v.showNewUserpage");
        if(!bool) {
            var val = component.find("ownerkeyvalForUser").get("v.value");
            component.set("v.showNewUserpage", true);
            component.find("ownerkeyvalForUsertext").set("v.value", val);
            
        } else {
            component.set("v.showNewUserpage", false);
        }
        
    },
    // save values in user specific owner key  
    saveOwnerKeyValperuser:function (component, event, helper) {
        var UserName= component.get("v.selectRecordName1");
        var UserId = component.get("v.selectRecordId1");
        var ownerKey;
        var bool = component.get("v.showNewUserpage") 
        if(bool) {
            ownerKey = component.find("ownerkeyvalForUsertext").get("v.value");
        } else {
            ownerKey= component.find("ownerkeyvalForUser").get("v.value");
        }
        var SetAsUserCheckBox=component.get("v.SelectAsDefaultUser");
        if(UserName==undefined ||UserName==' ' ||ownerKey==undefined||ownerKey==' ')
        {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error!',
                message: 'Please fill User name and owner key',
                type: 'error', 
            });
            toastEvent.fire(); 
        }
        else
        {
            var action = component.get("c.SaveOwnerKeyPerUser");
            action.setParams({
                UserId: UserId,
                ownerKey:ownerKey,
                setAsUser:SetAsUserCheckBox
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.showUserSpecific",false);
                    component.set("v.ShowSetup",false);
                    component.set("v.SelectAsDefaultUser",false);
                    var response= response.getReturnValue();
                    if(response=='Success')
                    {
                        component.set("v.showUserownerKeyPage",true);
                        component.set("v.DisableNewRecCancel",false);
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success!',
                            message: 'OwnerId Has Been Saved',
                            type: 'success', 
                        });
                        toastEvent.fire();
                        component.set("v.selectRecordId1",null);
                        component.find("ownerkeyvalForUser").set("v.value",null);
                        component.get("v.selectRecordName1",null);
                        var UserLookup = component.find("LookupCmp");
                        UserLookup.RefreshLookup();
                    }
                    else
                    {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error!',
                            message: response,
                            type: 'error', 
                        });
                        toastEvent.fire();
                        component.set("v.showUserownerKeyPage",true);
                        component.set("v.showEdit",false);
                        component.set("v.syncButton",false);
                        component.set("v.showlogin",false);
                        component.set("v.ShowSetup",false);
                        component.set("v.showUserSpecific",false);
                        component.set("v.showSyncButton",false);
                        component.set("v.isProgramtab",false);
                        component.set("v.islocationtab",false);
                        component.set("v.isInsurancetab",false);
                        component.set("v.isMaptab",false);
                    }     
                    
                }
                
            })
        }
        $A.enqueueAction(action); 
    },
    //cancel the action of update on user specific owner key                                                                
    cancelnewRecord:function (component, event, helper){
        component.set("v.showUserownerKeyPage",true);
        component.set("v.showEdit",false);
        component.set("v.syncButton",false);
        component.set("v.showlogin",false);
        component.set("v.ShowSetup",false);
        component.set("v.showUserSpecific",false);
        component.set("v.showSyncButton",false);
        component.set("v.isProgramtab",false);
        component.set("v.islocationtab",false);
        component.set("v.isInsurancetab",false);
        component.set("v.isMaptab",false);
        $A.enqueueAction(action);
    },
    //add more button is used add more user specific record 
    addMoreAction:function (component, event, helper) {
        helper.AddmoreOwnerKey(component, event, helper);
    },
    //check the select as default value 
    checkSelectAsDefaultValues:function(component,helper,event)
    {
        var checkBoxSelectedVal=event.getparam('checked');
        if(checkBoxSelectedVal==true)
        {
            component.set("v.ShowSetAsDefaultUser",false);
        }
    },
    
    ChangeDefaultuser:function(component,helper,event) 
    {
        component.set("v.isOpenModalForUser",true)
        var options = [];
        var action = component.get("c.getUserList");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var arr = response.getReturnValue() ;
                arr.forEach(function(element) {
                    options.push({ value:element.Lightning_Step__UserId__c, label: element.Lightning_Step__UserName__c});
                });
                component.set("v.statusOptions", options);
            }
        });
        $A.enqueueAction(action);
    },
    closeModel:function(component,event,helper)
    {
        component.set("v.isOpenModalForUser",false);   
    },
    handleOptionSelected: function (component, event) {
        var Userval=component.get("v.SelectedValue");
        var action = component.get("c.UpdateDefaultUserVal");
        action.setParams({
            UserId:Userval
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var response = response.getReturnValue() ; 
                if(response=='success')
                {
                    component.set("v.isOpenModalForUser",false);
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success!',
                        message: 'Default User Setting is Successfully Updated',
                        type: 'success', 
                    });
                    toastEvent.fire();
                    var UserTable = component.find("childCmp");
                    UserTable.RefreshTableView();
                }
                else
                {
                    component.set("v.isOpenModalForUser",false);
                    toastEvent.setParams({
                        title : 'Error!',
                        message:response,
                        type: 'error', 
                    });
                    toastEvent.fire();
                }
            }
        })
        $A.enqueueAction(action);
    }
})