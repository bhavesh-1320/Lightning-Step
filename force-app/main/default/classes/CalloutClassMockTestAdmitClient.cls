@isTest
global class CalloutClassMockTestAdmitClient implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"success":true,"code":0,"locale":"en","message":"OK","data":{"inquiry_id":"539","client_id":355,"location_id":25,"program_id":"11","mrn":"20-09010"}}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}