@isTest
public class MultiRequestMock implements HttpCalloutMock {
    Map<String, HttpCalloutMock> requests;
    public MultiRequestMock(Map<String, HttpCalloutMock> requests) {
        this.requests = requests;
    }
    public HTTPResponse respond(HTTPRequest req) {
        Integer lastPosition = req.getEndpoint().indexOf('?') != -1 ? req.getEndpoint().indexOf('?'): req.getEndpoint().length();
        System.debug('Last');
        System.debug(req.getEndpoint().substring(0, lastPosition));
        if(req.getEndpoint().substring(0, lastPosition) == 'https://testapi.lightningstep.com/api/api_make_contact') {
            HttpCalloutMock mock = requests.get('https://testapi.lightningstep.com/api/api_make_contact?');
            return mock.respond(req);
        } 
        if(req.getEndpoint().substring(0, lastPosition) == 'https://testapi.lightningstep.com/api/api_admit_client') {
            HttpCalloutMock mock = requests.get('https://testapi.lightningstep.com/api/api_admit_client?');
            return mock.respond(req);
        } 
       if(req.getEndpoint().substring(0, lastPosition) == 'https://testapi.lightningstep.com/api/api_make_inquiry') {
            HttpCalloutMock mock = requests.get('https://testapi.lightningstep.com/api/api_make_inquiry?');
            return mock.respond(req);
        } 
        if(req.getEndpoint().substring(0, lastPosition) == 'https://testapi.lightningstep.com/api/showBulkAdmissionStatus') {
            HttpCalloutMock mock = requests.get('https://testapi.lightningstep.com/api/showBulkAdmissionStatus?');
            return mock.respond(req);
        } 
        else {
            HttpCalloutMock mock = requests.get(req.getEndpoint().substring(0, lastPosition));  
            System.debug('END');
            if( req.getEndpoint().substring(0, lastPosition).contains('123456789') ){
                mock = requests.get(req.getEndpoint().substring(0, req.getEndpoint().indexOf('123456789')));
            }
            System.debug(req.getEndpoint().substring(0, lastPosition));
            return mock.respond(req);
        }
    }
    public void addRequestMock(String url, HttpCalloutMock mock) {
        requests.put(url, mock);
    }
}