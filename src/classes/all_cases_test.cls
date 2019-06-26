@isTest(seeAllData=true)
public class all_cases_test 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/open_close_cases';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Case oc = new Case();
        oc.Status = 'New';
        oc.Origin = 'Phone';
        insert oc;
        
        
        all_cases.getCases(userinfo.getUserEmail());
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String contactEmail = (String) result.get('contactEmail');
	System.assertNotEquals(contactEmail, userinfo.getUserEmail());
        
    }
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/open_close_cases';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Case oc = new Case();
        oc.Status = 'Closed';
        oc.Origin = 'Phone';
        insert oc;
        
        all_cases.getCases(''+userinfo.getUserEmail());
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String contactEmail = (String) result.get('contactEmail');
	System.assertNotEquals(contactEmail, userinfo.getUserEmail());
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/open_close_cases';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        all_cases.getCases(NULL);
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Required parameters data are missing.');
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/open_close_cases';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        
        Test.startTest();
        all_cases.getCases('wrongEmailFormat');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Email is not in correct format.');
    }
    
}