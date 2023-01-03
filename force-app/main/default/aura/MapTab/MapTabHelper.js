({
    getInquiryFields : function( cmp, event, helper ){
        var action = cmp.get('c.getInqFields');
        var start = cmp.get("v.start").toString();
        action.setParams({
            'start' : start,
        });
        action.setCallback( this, function(response){
            var state = response.getState();
            helper.hideSpinner(cmp);
            if (state === "SUCCESS") {
                console.log( response.getReturnValue());
                cmp.set( 'v.showTable', true ); 
                var arrayOfMapKeys = [];
                var res = response.getReturnValue();
                var insMap = cmp.get( "v.InsertMap" );
                for (var singlekey in res) {
                    if( insMap == undefined  ){
                        arrayOfMapKeys.push({fieldName : singlekey, value:undefined, label:res[singlekey], values:[], mapId:undefined, showWarning:false });
                    }else if( insMap[singlekey] == undefined || insMap[singlekey] == '' || insMap[singlekey] == ' '){
                        arrayOfMapKeys.push({fieldName : singlekey, value:undefined, label:res[singlekey], values:[], mapId:undefined, showWarning:false });
                    }else{
                        var insVal = insMap[singlekey];
                        arrayOfMapKeys.push({fieldName : singlekey, value:insVal.objField, label:res[singlekey], values:[], mapId:insVal.mapId, showWarning:false });
                    }
                }
                cmp.set( 'v.lstKeyMap', arrayOfMapKeys );
                if( arrayOfMapKeys.length >= 10 ){
                    cmp.set( 'v.showHeader', true );
                }
                if( arrayOfMapKeys.length < cmp.get("v.pageSize")){
                    cmp.set("v.isLastPage", true);
                } else{
                    cmp.set("v.isLastPage", false);
                } 
                cmp.set("v.dataSize", arrayOfMapKeys.length);
            }else{
                helper.ToastFunction( cmp, 'Wrong Object API Name', 'error', 'Error!' );
                cmp.set( 'v.objectName', '' );
                var a = cmp.get('c.handleCancel');
                $A.enqueueAction(a);
            }
        } );
        $A.enqueueAction( action );
    }, 
    insertValuesFunc : function(cmp, event, helper) {
        var wholeMap = cmp.get( 'v.lstKeyMap');
        var objInqFiels = cmp.get( "v.InsertMap");
        if( objInqFiels == undefined ){
            objInqFiels = {};
        }
        for( var val of wholeMap ){
            if( (val.value == undefined || val.value == '' || val.value == ' ') && (val.mapId == undefined) ){
                console.log( 'MapId:'+val.mapId );
                if(objInqFiels.hasOwnProperty( val.fieldName ) ){
                    delete objInqFiels[val.fieldName];
                }
            }else{
                objInqFiels[ val.fieldName ] = {objField:val.value, mapId:val.mapId};
            }
            if( val.showWarning ){
                return true;
            }
        }
        cmp.set( "v.InsertMap", objInqFiels );
        console.log( wholeMap );
        console.log('Upserting values');
        for( var i in objInqFiels )
            console.log( i + ':' + objInqFiels[i].mapId + ',' + objInqFiels[i].objField );
    },
    mapPrevValue: function (cmp, event, helper) {
        var action = cmp.get( "c.checkObjName" );
        action.setParams( {objApi : cmp.get('v.objectName')} );
        action.setCallback(this,function(response){
            if (response.getState() === "SUCCESS") {
                cmp.set("v.showInput", true);
                cmp.set( "v.objUnedit", true );
                var values = response.getReturnValue();
                var objFieldMap={}
                for( var val of values ){
                    objFieldMap[val.Lightning_Step__Inquiry_Field_API_Name__c] = {mapId : val.Id, objFieldApi : val.Lightning_Step__Object_Field_API_Name__c};
                }
                var wholeMap = cmp.get("v.lstKeyMap");
                var upVal = cmp.get('v.updatedValues');
                if(upVal == undefined){
                    upVal = {};
                }
                for( var val of wholeMap ){
                    if( objFieldMap.hasOwnProperty( val.fieldName ) && val.value==undefined && (! upVal.hasOwnProperty( val.fieldName )) ){
                        var obj =objFieldMap[val.fieldName];
                        val.mapId = obj.mapId;
                        val.value = obj.objFieldApi;
                    }
                }
                cmp.set( "v.lstKeyMap", wholeMap );
                console.log( 'Map with prev values' );
                console.log( wholeMap );
            }else{
                cmp.set("v.showInput", false);
                cmp.set("v.objectName", undefined);
                helper.ToastFunction( cmp, 'Object Api Name is not correct', 'Error', 'Error!!' );
            }
        });
        $A.enqueueAction( action );
    },
    showSpinner: function (cmp) {
        var spinner = cmp.find("mySpinner");
        $A.util.removeClass(spinner,"slds-hide");
        console.log( 'mySpinnerm added' );
    },
    
    ToastFunction : function(component, msg, type, title) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: msg,
            type: type, 
        });
        toastEvent.fire();
    },
    //To hide the spinner
    hideSpinner: function (cmp) {
        var spinner = cmp.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
    
    //Test
    searchRecords : function(component, searchString, index) {
        var action = component.get("c.getObjFields");
        action.setParams( { searchSt : searchString, objApi : component.get("v.objectName") } );
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var serverResult = response.getReturnValue();
                var wholeMap = component.get( 'v.lstKeyMap');
                for( var val of wholeMap ){
                    val.values = [];
                }
                console.log( 'Values:' );
                console.log( serverResult );
                var changeEle = wholeMap[index];
                changeEle.values = serverResult;
                component.set("v.lstKeyMap", wholeMap);
                console.log('Hello', component.get("v.lstKeyMap") );
                if(serverResult.length>0){
                    component.set("v.openDropDown", true);
                }
            } else{
                var toastEvent = $A.get("e.force:showToast");
                if(toastEvent){
                    toastEvent.setParams({
                        "title": "ERROR",
                        "type": "error",
                        "message": "Something went wrong!! Check server logs!!"
                    });
                    toastEvent.fire();
                }
            }
        });
        $A.enqueueAction(action);
    }
})