({
    init: function (cmp, event, helper) {
        //helper.showSpinner(cmp);
        cmp.set('v.columns', [
            {label: 'Program Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Location', fieldName: 'locationName', type: 'string', 
             typeAttributes: {label: { fieldName: 'Locations' }, target: '_blank'}},
            {label: 'Synced Date', fieldName:'LastModifiedDate', type: 'date', typeAttributes: {  
                day: 'numeric',  
                month: 'numeric',  
                year: 'numeric',  
            }}, 
            
        ]);
            var action = cmp.get("c.getProgram");
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            cmp.set("v.ShowSpinner",false);
            var resonse =response.getReturnValue();
            console.log('Response');
            console.log( resonse );
            if(resonse.includes('success'))
            {
            helper.getProgramList(cmp,helper);
            }
            else if(response=='NotMarketingUser')
            {
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
            resultsToast.setParams({
            "type": "Error",
            "title": 'Error',
            "message": resonse
            });
            resultsToast.fire();
            }
            } else {
            var resonse =response.getReturnValue();
            console.log('Response');
            console.log( resonse );
            helper.ToastOwnerKeyFunction(cmp);
            }
            });
            $A.enqueueAction(action);
            },
            handleNext : function(cmp, event, helper) { 
            cmp.set("v.isLastPage", true);
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber+1);
            helper.getProgramList(cmp, helper);
            },
            // this function call on click on the previous page button  
            handlePrev : function(cmp, event, helper) {   
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber-1);
            helper.getProgramList(cmp, helper);
            cmp.set("v.isLastPage", false);
            },           
            })