@isTest
global class CalloutClassMockTestProgrambyLocation implements HttpCalloutMock {
    // Implement this interface method
    global String className;
    global CalloutClassMockTestProgrambyLocation( String cName ){
        className = cName;
    }
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        if( className == 'Location' ){
            response = getLocation();
        }else if( className == 'Insurance' ){
            response = getInsurance();
            System.debug('IN->'+response);
        }else if( className == 'Doc' ){
            response = getDoc();
            System.debug('R-->'+response);
        }else if( className == 'PicklistFields' ){
            response = getPickFields();
        }else if( className == 'State' ){
            response = getStates();
        }else if( className == 'UpdatePickFields' ){
            response = getUpPickVal();
        }
        return response; 
    }
    public static HttpResponse getLocation(){
        HttpResponse response = new HttpResponse();
        //Previous response
        //response.setBody('{"Detox Main Location": [{"location_name": "Detox Main Location","location_id": 23,"program_name": "Inpatient Residential","program_id": 17}],"Allen Test": [{"location_name": "Allen Test","location_id": 25,"program_name": "Detoxification","program_id": 3},{"location_name": "Allen Test","location_id": 25,"program_name": "Residential","program_id": 11}],"MH Res Location": [{"location_name": "MH Res Location","location_id": 27,"program_name": "Mh Residential","program_id": 43}]}');
        response.setBody('[{"location_name": "Allen Test","location_id": 25,"pgm_id": 57,"pgmname": "001 Program","subprogram_id": 57}]');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
    public static HttpResponse getInsurance(){
        HttpResponse response = new HttpResponse();
        response.setBody('[{"id":1,"name":"Blue Cross Blue Shield of Texas","address1":"12345 Old Highway Route 6","address2":"","city":"Austin","state":"TX","zip":"75689","phone":"","ext":"","contact_person":"","contract_date":"2017-01-01","contract_enddate":null,"claim_code":"CI","provider_number":"BN09836","provider_code":"","islegacy":0,"ub04legacycode":"","cmslegacycode":"","useppscode":0,"ppscode":null,"etin":null,"government":null,"electronic_submission":1,"useretailrate":1,"sfname":"Dwight","slname":"Sills","staff_id":21,"eie":0,"locationpayor":0,"bundledpayor":0,"oon":0,"nohcpcs":0,"notaxonomy":0,"novaluecodes":0,"usevaluecodes":0,"valuecodes":null,"usemodifierrules":0,"modifierrules":null,"primarydx":0,"noitemize":0,"nogroupnumber":0,"renderingfacility":0,"billingfacility":1,"altnpi":0,"npi":"","facilityname":"","expectedrevenue":null,"isactive":1,"created_at":"2016-11-28 09:52:36","updated_at":"2018-10-31 08:26:49","lastupdatedby_id":94,"suprequired":0,"sup_id":0,"exceptionlist_id":0,"reporting_code":null,"payorlocations":[],"bundledservices":[],"mccservices":[{"id":5,"eie":0,"service":"Intensive Outpatient Program (IOP)","service_id":1,"mccontract_id":1,"authreqyn":"No","threshold":null,"copayyn":null,"dedyn":null,"hcpcsreqyn":"No","hcpcs":null,"revcodereqyn":"Yes","revcode":"0906","cptcodereqyn":"No","cptcode":null,"admittypecode":"3","dcstatuscode":null,"posmodifier":null,"noitemize":1,"onedos":0,"billingdx":null,"primarydxtype":"ABJ","norenderingprovider":0,"renderingfacility":0,"altfacility":1,"altnpi":1,"alttaxid":0,"altaddress":1,"altpaytoaddress":0,"npi":"2222222222222","taxid":null,"facilityaddress":"Test Address","facilitycity":"Katy","facilitystate":"TX","facilityzip":"77494","altpaytoname":0,"paytoname":null,"paytoaddress":null,"paytocity":null,"paytostate":null,"paytozip":null,"useremark":null,"remark":"","startdate":"1999-12-31","enddate":null,"taxonomyyn":"Yes","valuecodesyn":null,"created_at":"2019-12-19 22:49:44","updated_at":"2019-12-19 22:49:44","location_id":null,"oon":0,"credentialtype":null}]}]');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
    public static HttpResponse getDoc(){
        HttpResponse response = new HttpResponse();
        response.setBody('{"inquiry_id":12,"fname":"Test","lname":"123","modelname":"exdoc","src":"API Import","docsize":null,"datedoc":"2022-03-02","staff_id":167,"sfname":"Jagrat","slname":"Cyntexa"}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
    public static HttpResponse getPickFields(){
        HttpResponse response = new HttpResponse();
        response.setBody('{"payload": [{"id": 713,"metavalue": "Other"},{"id": 714,"metavalue": "Bi-Sexual"},{ "id": 716, "metavalue": "Homosexual"}],"datetimestamp": "2022-04-12_03:32:43"}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
    public static HttpResponse getStates(){
        HttpResponse response = new HttpResponse();
        response.setBody('{"AK": "AK","AL": "AL","AR": "AR"}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
    public static HttpResponse getUpPickVal(){
        HttpResponse response = new HttpResponse();
        response.setBody('');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response;
    }
}