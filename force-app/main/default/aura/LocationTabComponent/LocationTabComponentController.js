({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Location Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Synced Date', fieldName:'LastModifiedDate', type: 'date', typeAttributes: {  
                day: 'numeric',  
                month: 'numeric',  
                year: 'numeric',  
            }}, 
            
        ]);
            var action = cmp.get("c.getLocation");
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            var resonse =response.getReturnValue();
            if(resonse.includes('success'))
            {
            helper.getLocationList(cmp,helper); 
            cmp.set("v.ShowSpinnerLoc",false);
            }
            else if(response=='NotMarketingUser')
            {
            helper.hideSpinner(cmp);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
            title : 'Error!',
            message:  'Please Select the marketing User Checkbox to Perform this Operation',
            type: 'error', 
            });
            toastEvent.fire();  
            }
            else
            {
            helper.hideSpinner(cmp);    
            resultsToast.setParams({
            "type": "Error",
            "title": 'Error',
            "message": resonse
            });
            resultsToast.fire();
            }
            }
            
            });
            
            $A.enqueueAction(action);
            },
            handleNext : function(cmp, event, helper) { 
            cmp.set("v.isLastPage", true);
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber+1);
            helper.getProgramList(cmp, helper);
            cmp.set("v.records", cmp.get("v.records") + ((pageNumber-1)*cmp.get("v.pageSize")+cmp.get("v.dataSize")));
            },
            // this function call on click on the previous page button  
            handlePrev : function(cmp, event, helper) {        
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber-1);
            helper.getProgramList(cmp, helper);
            cmp.set("v.records", cmp.get("v.records") - 10);
            },           
            
            })