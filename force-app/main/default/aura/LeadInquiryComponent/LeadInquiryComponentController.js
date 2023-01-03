({
    doInit : function(component, event, helper) {
        var action2 = component.get("c.isSetup");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var returnedDataValue = response.getReturnValue();
                if(returnedDataValue) {
                    helper.createInquiry(component, event, helper);
                } else {
                    component.set("v.ErrorMessage",'Client Id and Secret Key is Missing.');
                    component.set("v.showError",true);
                    component.set("v.showForm",false); 
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
    handleAlternate : function(component, event, helper) {
        var val = component.find('Lightning_Step__Alternate_First_Name__c').get('v.value');
        component.set( 'v.alternateName', val );
    },
    loadSection:function(component,event,helper) {
        component.set("v.DOBSection",true);
        var action = component.get("c.getMappings");
                action.setParams( {objName:component.get("v.sObjectName")} );
                console.log('Test');
                action.setCallback( this, function( response ){
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var records =response.getReturnValue();
                        console.log(records);
                        console.log('Values');
                        for( var rec of records ){
                            console.log(rec);
                            var field = component.find(rec.Lightning_Step__Inquiry_Field_API_Name__c);
                            console.log( field );
                            console.log( rec.Lightning_Step__Inquiry_Field_API_Name__c );
                            if( field ){
                                var objFields = component.get( "v.leadRecord" );
                                console.log( 'ObjFields' );
                                console.log( objFields );
                                var val = objFields[rec.Lightning_Step__Object_Field_API_Name__c]
                                console.log( val );
                                field.set("v.value", val);    
                                if( rec.Lightning_Step__Inquiry_Field_API_Name__c == 'Lightning_Step__Funding_Source__c' ){
                                    component.set( 'v.fundSource', val );
                                }
                                
                            }    
                        }
                    }
                } );
                $A.enqueueAction( action );
        /*event.preventDefault();
        var fields = event.getParam('fields');
        console.log('Inside');
        fields.Lightning_Step__Email__c = 'bh@c.com';
        component.find('recordEditForm').submit(fields);*/
    },
    handleSubmit: function(component, event, helper) {
        if( component.get( 'v.selectedValue' ) != -1 ){
            event.preventDefault();
            var fields = event.getParam('fields');
            console.log('Inside');
            console.log( component.get( 'v.selectedValue' ) );
            fields.Lightning_Step__Mc_Contract__c = component.get( 'v.selectedValue' );
            component.find('recordEditForm').submit(fields);   
        }
        var fName = component.find('Lightning_Step__First_Name__c');
        console.log( fName );
    },
    onsuccess:function(component,event,helper)
    {

        component.set("v.showSpinner",true);
        var payload = event.getParams().response;
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "type": "Success",
            "title": 'Success',
            "message":"Inquiry has been Successfully Created"
        });
        resultsToast.fire();	
        var navService = component.find("navService");
        var pageReference = {    
            "type": "standard__recordPage",
            "attributes": {
                "recordId":payload.id,
                "objectApiName": "Lightning_Step__Inquiry__c",
                "actionName": "view"
            },
        };
        navService.navigate(pageReference);
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire(); 
        $A.get('e.force:refreshView').fire();
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
    closeModal : function(component,event,helper)
    {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire(); 
    },
    //For insurance
    handleFundingSource:function (cmp, event, helper) {
        var val = cmp.find('Lightning_Step__Funding_Source__c').get('v.value');
        console.log( 'FundSource:'+val );
        cmp.set( 'v.fundSource', val ); 
        if( val == 'Insurance' ){
            var action = cmp.get( 'c.getInsurance' );
            action.setCallback( this, function( response ){
                var state = response.getState();
                if(state == "SUCCESS") {
                	var returnedDataValue = response.getReturnValue();
                    console.log( returnedDataValue );
                    var insRecs = [];
                    var n = { id: -1, label: '--None--', selected: true };
                    insRecs.push( n );
                    for (var item of returnedDataValue){
                        var insRec = { id: item.Id, label:item.Lightning_Step__MC_Name__c };
                        insRecs.push( insRec );
                    }
                    insRecs.sort((a, b) => (a.label > b.label) ? 1 : -1);
                    console.log( insRecs );
                    cmp.set( "v.insOptions", insRecs );
                }
            } );
            $A.enqueueAction( action );  
        }else{
            cmp.set('v.selectedValue', -1);
        }
        console.log( cmp.get('v.selectedValue') );
    },
    onInsChange: function (cmp, event, helper) {
        var selPickListValue = event.getSource().get("v.value");
        console.log( cmp.get( 'v.insOptions' ) );
        cmp.set('v.selectedValue', selPickListValue);
        console.log( selPickListValue );
    }
})