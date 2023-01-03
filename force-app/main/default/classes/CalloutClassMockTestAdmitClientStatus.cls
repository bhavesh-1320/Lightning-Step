@isTest
global class CalloutClassMockTestAdmitClientStatus implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"success": true,"code": 0,"locale": "en","message": "OK","data": {"inquiry_id": 477,"client_id": 301,"episode_id": 441,"mrn": "20-08071","fname": "Jagrat","lname": "TestA","status": "Discharged","datedischarge": "2020-08-17","dateadmission": "2020-08-17","datetransfer": null,"dateaction": "2020-08-17","dctype": "At Staff Request"}}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}