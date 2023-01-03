({
    init: function (cmp, event, helper) {
        helper.getInquiryFields( cmp, event, helper );
    },
    mapObj : function(cmp, event, helper) {
        helper.mapPrevValue( cmp, event, helper );
    },
    syncPickField : function(cmp, event, helper) {
        console.log('Hel');
        var spinner = cmp.find("mySpinner");
        $A.util.removeClass(spinner,"slds-hide");
        var action = cmp.get("c.getPickFields");
        console.log('Hel');
        var found = false;
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('Response');
            console.log( response );
            if (state === "SUCCESS") {
                var value =response.getReturnValue();
                if(value != null && value!=undefined)
                {
                    console.log( 'Value' );
                    console.log( value );
                    for( var val in value ){
                        var action2 = cmp.get("c.syncPickFields");
                        console.log( 'val:' );
                        console.log( value[val] );
                        console.log( value[val].fieldInfo );
                        console.log( value[val].fieldInfo.label );
                        action2.setParams( {pickValuesMap : value[val].Values, fLabel: value[val].fieldInfo.label, fieldName:value[val].fieldInfo.apiName, fieldId:value[val].fieldInfo.fieldId } );
                        action2.setCallback(this, function(response){
                            
                            var state = response.getState();
                            console.log( response );
                            if (state === "SUCCESS") {
                                if( response.getReturnValue() == null || response.getReturnValue() ==undefined ){
                                    found = true;
                                }
                            }else{
                                found = true;
                            }
                        })
                        $A.enqueueAction( action2 );
                    }
                }else{
                    found = true;
                }
                window.setTimeout(
                    $A.getCallback(function() {
                        var spinner = cmp.find("mySpinner");
                        $A.util.addClass(spinner, "slds-hide");
                        if( !found ){
                            helper.ToastFunction( cmp, 'Picklist Fields Synced', 'Success', 'Values Synced!!' );
                        }else{
                            helper.ToastFunction( cmp, 'Error Occured', 'Error', 'Error' );
                        }
                    }), 30000
                );
            }
            else{
                var spinner = cmp.find("mySpinner");
                $A.util.addClass(spinner, "slds-hide");
                var value =response.getReturnValue();
                console.log( 'Value' );
                console.log( value );
                helper.ToastFunction( cmp, 'Error Occured', 'Error', 'Error' );
            }
        })
        $A.enqueueAction( action );
    },
    saveRecs : function(cmp, event, helper) { 
        var wMap = cmp.get("v.lstKeyMap");
        var warn = helper.insertValuesFunc( cmp, event, helper );
        if( warn ){
            helper.ToastFunction( cmp, 'Please select correct values', 'Warning', 'Incorrect values' );
        }else{
            var objInqFiels = cmp.get("v.InsertMap");
            var action = cmp.get( 'c.saveMapping' );
            action.setParams( {fieldMap : objInqFiels, objApi : cmp.get('v.objectName')} );
            action.setCallback( this, function(response){
                if (response.getState() === "SUCCESS") {
                    if( response.getReturnValue() == 'null' ){
                        helper.ToastFunction( cmp, 'At least one field should be mapped', 'Warning', 'Warning!!' );    
                    }else if( response.getReturnValue() == 'inserted' ){
                        helper.ToastFunction( cmp, 'Fields Mapped', 'Success', 'Success!!' );
                        var a = cmp.get('c.handleCancel');
                        $A.enqueueAction(a);
                    }
                    console.log('Hello');
                }else{
                    console.log('Bye');
                }
            } );
            $A.enqueueAction( action );
        }
        
    },
    handleCancel : function(cmp, event, helper) {
        var a = cmp.get('c.clearOption');
        $A.enqueueAction(a);
        cmp.set( 'v.objectName', undefined );
        cmp.set( 'v.showTable', false );
        cmp.set( 'v.lstKeyMap', undefined );
        
        cmp.set( 'v.pageNumber', 1 );
        cmp.set( 'v.showHeader', false );
        cmp.set( 'v.pageSize', 10 );
        
        cmp.set( 'v.isLastPage', false );
        cmp.set( 'v.dataSize', 0 );
        cmp.set( 'v.ShowSpinnerMap', false );
        
        cmp.set( 'v.records', 10 );
        cmp.set( 'v.dataSize', 0 );
        
        cmp.set( 'v.start', 1 );
        cmp.set( 'v.InsertMap', undefined );
        cmp.set( 'v.openDropDown', false );
        
        cmp.set( 'v.showInput', false );
        cmp.set( 'v.objUnedit', false );
        cmp.set( 'v.updatedValues', undefined );
        var a = cmp.get('c.init');
        $A.enqueueAction(a);
    },
    handleNext : function(cmp, event, helper) { 
        var warn = helper.insertValuesFunc( cmp, event, helper );
        if( warn ){
            helper.ToastFunction( cmp, 'Please select correct values', 'Warning', 'Incorrect values' );
        }else{
            cmp.set("v.isLastPage", true);
            cmp.set( "v.start", cmp.get( "v.start" )+10 );
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber+1);
            helper.getInquiryFields(cmp, event, helper);
            helper.mapPrevValue( cmp, event, helper );
            cmp.set("v.records", cmp.get("v.records") + ((pageNumber-1)*cmp.get("v.pageSize")+cmp.get("v.dataSize")));
        }
    },
    // this function call on click on the previous page button  
    handlePrev : function(cmp, event, helper) {   
        var warn = helper.insertValuesFunc( cmp, event, helper );
        if( warn ){
            helper.ToastFunction( cmp, 'Please select correct values', 'Warning', 'Incorrect values' );
        }else{
            var pageNumber = cmp.get("v.pageNumber");
            cmp.set("v.pageNumber", pageNumber-1);
            cmp.set("v.records", cmp.get("v.records") - 10);
            cmp.set( "v.start", cmp.get( "v.start" )-10 );
            helper.getInquiryFields(cmp, event, helper);
            helper.mapPrevValue( cmp, event, helper );
            cmp.set("v.isLastPage", false);
        }
    },
    searchHandler : function (component, event, helper) {
        const searchString = event.target.value;
        console.log( searchString );
        var rowIndex = event.target.getAttribute("data-row-index");
        var wholeMap = component.get( 'v.lstKeyMap');
        wholeMap[rowIndex].value=undefined;
        component.set("v.lstKeyMap", wholeMap);
        var upVal = component.get('v.updatedValues');
        if( upVal == undefined ){
            upVal = {};
        }
        upVal[wholeMap[rowIndex].fieldName] = '';
        console.log( searchString );
        if( searchString.length > 1 ){
            wholeMap[rowIndex].showWarning = true;
            component.set("v.lstKeyMap", wholeMap);
           helper.searchRecords(component, searchString, rowIndex);
        }else{
    		component.set("v.openDropDown", false);
            var wholeMap = component.get( 'v.lstKeyMap');
            var changeEle = wholeMap[rowIndex];
            changeEle.values = [];
            changeEle.showWarning = true;
            if( searchString.length < 1 ){
            	changeEle.showWarning = false;    
            }
            component.set( 'v.lstKeyMap', wholeMap);
        }
        component.set( 'v.updatedValues', upVal );
    },

    optionClickHandler : function (component, event, helper) {
        const selectedValue = event.target.closest('li').dataset.value;
        var rowIndex = event.target.closest('li').dataset.index;
        console.log( rowIndex );
        var wMap = component.get( 'v.lstKeyMap');
        var changeEle = wMap[rowIndex];
        changeEle.value = selectedValue;
        changeEle.showWarning = false;
        console.log( wMap );
        component.set("v.lstKeyMap", wMap);
        component.set("v.openDropDown", false);
        
    },

    clearOption : function (component, event, helper) {
        var index = event.currentTarget.id;
        var wholeMap = component.get( 'v.lstKeyMap');
        wholeMap[index].value='';
        var upVal = component.get('v.updatedValues');
        if( upVal == undefined ){
            upVal = {};
        }
        upVal[wholeMap[index].fieldName] = '';
        component.set("v.lstKeyMap", wholeMap);
        component.set("v.openDropDown", false);
        component.set( 'v.updatedValues', upVal );
    },
    
})