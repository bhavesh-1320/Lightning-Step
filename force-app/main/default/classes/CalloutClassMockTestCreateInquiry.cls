@isTest
global class CalloutClassMockTestCreateInquiry implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"success": true,"code": 0,"locale": "en","message": "OK","data": {"inquiry_id": 477,"episode_id": 536,"demographic_id": 578,"payor_id": 441}}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}