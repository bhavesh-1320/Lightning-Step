({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Lightning_Step__MC_Name__c' }, target: '_blank'}}
        ]);
        var action = cmp.get("c.getInsurance");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var resonse =response.getReturnValue();
                if(resonse.includes('success'))
                {
                    helper.getInsuranceList(cmp,helper); 
                    cmp.set("v.ShowSpinnerIns",false);
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
                        console.log( 'Entered' );
                        cmp.set("v.ShowSpinnerIns",false);
                        //helper.hideSpinner(cmp);   
                        var resultsToast = $A.get("e.force:showToast"); 
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
        helper.getInsuranceList(cmp, helper);
        cmp.set("v.records", cmp.get("v.records") + ((pageNumber-1)*cmp.get("v.pageSize")+cmp.get("v.dataSize")));
    },
    // this function call on click on the previous page button  
    handlePrev : function(cmp, event, helper) {        
        var pageNumber = cmp.get("v.pageNumber");
        cmp.set("v.pageNumber", pageNumber-1);
        helper.getInsuranceList(cmp, helper);
        cmp.set("v.records", cmp.get("v.records") - 10);
        cmp.set("v.isLastPage", false);
    },            
    
})