@isTest
global class CalloutClassMockBulkAdmitClientStatus implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"success": [{"headers": {},"original": {"success": true,"code": 0,"locale": "en","message": "OK","data": {"inquiry_id": 539,"client_id": 355,"episode_id": 506,"mrn": "20-09010","fname": "Bertha","lname": "Boxer","status": "Admitted","datedischarge": null,"dateadmission": "2020-09-09"}},"exception": null}]}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}