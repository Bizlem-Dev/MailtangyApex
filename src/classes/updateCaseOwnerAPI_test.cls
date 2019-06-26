@isTest
public class updateCaseOwnerAPI_test 
{
	public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/updateCaseOwner';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case c = new Case();
        c.Status = 'New';
        c.Origin = 'Phone';
        insert c;
        Case c1 = new Case();
        c1 = [SELECT id, CaseNumber, Owner.Email from Case where id=: c.Id];
        
        updateCaseOwnerAPI.getTagger(UserInfo.getUserEmail(), c1.CaseNumber); 
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('the ownerId of caseNumber '+c1.CaseNumber+' is sucessfuly updated.', message);
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/updateCaseOwner';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case c = new Case();
        c.Status = 'New';
        c.Origin = 'Phone';
        insert c;
        Case c1 = new Case();
        c1 = [SELECT id, CaseNumber, Owner.Email from Case where id=: c.Id];
        
        updateCaseOwnerAPI.getTagger('wrongEmail', c1.CaseNumber); 
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Email is not in correct format.', error_description);
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/updateCaseOwner';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case c = new Case();
        c.Status = 'New';
        c.Origin = 'Phone';
        insert c;
        Case c1 = new Case();
        c1 = [SELECT id, CaseNumber, Owner.Email from Case where id=: c.Id];
        
        updateCaseOwnerAPI.getTagger('nouser@test.com', c1.CaseNumber); 
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('For the given email there is no USER exist.', error_description);
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/updateCaseOwner';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Case c = new Case();
        c.Status = 'New';
        c.Origin = 'Phone';
        insert c;
        Case c1 = new Case();
        c1 = [SELECT id, CaseNumber, Owner.Email from Case where id=: c.Id];
        
        updateCaseOwnerAPI.getTagger(UserInfo.getUserEmail(), '145'); 
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('For the given case Number there is no CASE exist.', error_description);
    }
    
    public testMethod  static void testPostMethod5()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/updateCaseOwner';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        
        updateCaseOwnerAPI.getTagger(UserInfo.getUserEmail(), Null); 
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Some of the required data missing.', error_description);
    }
}