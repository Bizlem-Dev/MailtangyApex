@isTest
public class closeCase_test 
{
	public testMethod  static void testPostMethod1()
    {
    	RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/closecase';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case testcase = new Case();
        testcase.Status = 'New';
        testcase.Origin = 'Phone';
        testcase.Subject = 'test_Subject';
        insert testCase;
        
        Case cse = new Case();
        cse = [Select id, CaseNumber from case where id =: testCase.Id];
        
        CloseCase.close(cse.CaseNumber, 'Testreason');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String message = (String) result.get('message');
	System.assertEquals(message, 'Case closed and reason saved successfully');
        
    }
    
    public testMethod  static void testPostMethod2()
    {
    	RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/closecase';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case testcase = new Case();
        testcase.Status = 'New';
        testcase.Origin = 'Phone';
        testcase.Subject = 'test_Subject';
        insert testCase;
        
        Case cse = new Case();
        cse = [Select id, CaseNumber from case where id =: testCase.Id];
        
        CloseCase.close(cse.CaseNumber, '');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Please enter a reason to close the case');
    }
    
    public testMethod  static void testPostMethod3()
    {
    	RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/closecase';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case testcase = new Case();
        testcase.Status = 'New';
        testcase.Origin = 'Phone';
        testcase.Subject = 'test_Subject';
        insert testCase;
        
        Case cse = new Case();
        cse = [Select id, CaseNumber from case where id =: testCase.Id];
        
        CloseCase.close(Null, '');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Please enter a case number you want to close');
    }
    
    public testMethod  static void testPostMethod4()
    {
    	RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/closecase';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case testcase = new Case();
        testcase.Status = 'New';
        testcase.Origin = 'Phone';
        testcase.Subject = 'test_Subject';
        insert testCase;
        
        Case cse = new Case();
        cse = [Select id, CaseNumber from case where id =: testCase.Id];
        
        CloseCase.close('0138', 'Testreason');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Please enter a valid case number');
    }
}