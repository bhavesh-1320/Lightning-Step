@isTest
global class CalloutClassMockFailureAdmitClientStatus implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('');
        response.setStatusCode(404);
        response.setStatus('Ok');
        return response; 
    }
}