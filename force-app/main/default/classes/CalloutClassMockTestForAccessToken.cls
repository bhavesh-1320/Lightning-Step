@isTest
global class CalloutClassMockTestForAccessToken implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody('{"token_type":"Bearer","expires_in":31536000,"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MTAyODhiNC0zYzdmLTRmMzItOTVlYy1jYjRjYTZhNjJhZjQiLCJqdGkiOiIzMzAxOGI1NTMyOTBiN2IxMmYyN2JlNTAzZGFjZWFmMDE1ZmVkYjU2OWUyM2Y5ZDIxNTk4M2EwNGNmMDBmMGQwYjUwODc0MTgxOTYyMDRjYiIsImlhdCI6MTU5OTA1MTA0MywibmJmIjoxNTk5MDUxMDQzLCJleHAiOjE2MzA1ODcwNDMsInN1YiI6IiIsInNjb3BlcyI6W119.pf_BPgUb80uFO4RvWfmS8aH2FQP4u4XMeyP7ItHwUdxSeC1_oDERUr_8OGd0BMd58S-BIVCbz3Epug0vMoJj6_a2c_aO6RLQ--a7QiHSztqlrFodLtfAbT9pdJSXuDn6SpnwdN_Xv_uuzCN5nuy1whfstt8B6zNfdMnwVPU36eZCP_4622vSWjER2D2f9Yub5WCq9prV7BSZIflKrj-pxPzO4sh4o7prrZ4RWbpRd6QuuE8ag4lu7Er6NR8AWvVTYAb3wQ8cHaQBUCpYVOH1SPGG5Rnn-SDpJ4I9g3T0kKbACYnF50T0s2weh5w3EtgFBbs8nWTHhmjMvLaNUOv0XxJ06Hs0fBdZ8GFUGIBxnBF1i5lKT23i9dOEeT6DpQrJsX6emU1p6-zjPHUf7Ja2f03BkG9YTjagTnkcgC-vMwKvXTWhRawrY_Kw0yLOC2FGB01A4yLsi3sc2KQDLi8MVs73ArQHtuyt-_Lx8SpiKeUS--cidRmeGzUgmhEq6BPgCw_mKTYo6bnWR2VumKM43wlYBoo1wjD45EbmRp5MR8q4-WF04bLkiXHU9nzi4P0ARbCrs0lG0d4K9OufFyLtXqzaZFKEacK8PUgDeclXahHfxBvdF_95oRRRpvd1_2-NBojsWUv-9cr8dm4x6FYkiuKYegwQh4M-FT-Ecq7Q6CQ"}');
        response.setStatusCode(200);
        response.setStatus('Ok');
        return response; 
    }
}