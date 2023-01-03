public class DemoClass 
{
	public static void methodOne()
    {
         Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://testapi.lightningstep.com/oauth/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String payload = 'grant_type='+EncodingUtil.urlEncode('client_credentials','UTF-8')+'&scope='+EncodingUtil.urlEncode('*','UTF-8')+'&client_id='+EncodingUtil.urlEncode('910288b4-3c7f-4f32-95ec-cb4ca6a62af4','UTF-8')+'&client_secret='+EncodingUtil.urlEncode('VlnZ7SQlokjfG9rFCkiU8H8BQ4XZH5JoxcXR4lVb','UTF-8');
		System.debug(payload);
          request.setBody(payload);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            LightingSt data=(LightingSt)JSON.deserializeStrict(response.getBody(), LightingSt.class);  
            System.debug(data.access_token);
        }
    }
    
    
    public class LightingSt {

	public String token_type;
	public Integer expires_in;
	public String access_token;
    }
}