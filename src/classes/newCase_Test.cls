@isTest
public class newCase_Test 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        insert con;
        newCase.createCase('test@test.com', 'testSubject', 'teststatus', 'testorigin', acc.id, con.Id, 'Email', 'testing', 'High', 'description', 'test@web.com', 'webCompany', '9876543210', 'testwebName');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String message = (String) result.get('message');
	System.assertEquals(message, 'Case created successfully');
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        RestResponse response =  new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        insert con;
        newCase.createCase('testWrongEmail', 'testSubject', 'teststatus', 'testorigin', acc.id, con.Id, 'Email', 'testing', 'High', 'description', 'test@web.com', 'webCompany', '9876543210', 'testwebName');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Email is not in correct format.');
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        
        RestResponse response =  new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        insert con;
        newCase.createCase('test@test.com', 'testSubject', 'teststatus', 'testorigin', '14324', con.Id, 'Email', 'testing', 'High', 'description', 'test@web.com', 'webCompany', '9876543210', 'testwebName');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Either accountID or ContactId didnot match.');
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        
        RestResponse response =  new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        insert con;
        newCase.createCase('test@test.com', '', 'teststatus', 'testorigin', '14324', con.Id, 'Email', 'testing', 'High', 'description', 'test@web.com', 'webCompany', '9876543210', 'testwebName');
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'Required parameters data are missing.');
    }
}