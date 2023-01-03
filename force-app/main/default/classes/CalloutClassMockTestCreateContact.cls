@isTest
global class CalloutClassMockTestCreateContact implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"success":true,"code":0,"locale":"en","message":"OK","data":{"inquiry_id":"539","contact_id":342}}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}