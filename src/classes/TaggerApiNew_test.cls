@isTest
public class TaggerApiNew_test 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/taggernew';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        acc.Email__c = 'test@bizlem.com';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        con.Email = 'test@bizlem.com';
        insert con;
        
        Lead led =  new Lead();
        led.LastName = 'test_lastName';
        led.Company = 'testCompany';
        led.Status = 'open';
        led.Description = 'test_subject';
        insert led;
        
        Case cse = new Case();
        cse.Subject = 'test_subject';
        cse.ContactId = con.Id;
        cse.Status = 'New';
        cse.Origin = 'Phone';
        insert cse;
        
        TaggerApiNew.getTagger('test@bizlem.com', 'test_subject');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ContactId = (String) result.get('ContactId');

        System.assertEquals(''+con.id, ContactId);
        
        String AccountId = (String) result.get('AccountId');

        System.assertEquals(''+acc.id, AccountId);
        
    }
    
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/taggernew';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        acc.Email__c = 'test@bizlem.com';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        con.Email = 'test1@bizlem.com';
        insert con;
        
        Lead led =  new Lead();
        led.LastName = 'test_lastName';
        led.Company = 'testCompany';
        led.Status = 'open';
        led.Description = 'test_subject';
        led.email = 'test@bizlem.com';
        insert led;
        
        Case cse = new Case();
        cse.Subject = 'test_subject';
        cse.ContactId = con.Id;
        cse.Status = 'New';
        cse.Origin = 'Phone';
        insert cse;
        
        TaggerApiNew.getTagger('test@bizlem.com', 'test_subject');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        
        
        String AccountId = (String) result.get('AccountId');

        System.assertEquals(''+acc.id, AccountId);
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/taggernew';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAccount';
        acc.Email__c = 'test@bizlem.com';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.AccountId = acc.id;
        con.Email = 'test1@bizlem.com';
        insert con;
        
        Lead led =  new Lead();
        led.LastName = 'test_lastName';
        led.Company = 'testCompany';
        led.Status = 'open';
        led.Description = 'test_subject';
        insert led;
        
        Case cse = new Case();
        cse.Subject = 'test_subject';
        cse.ContactId = con.Id;
        cse.Status = 'New';
        cse.Origin = 'Phone';
        insert cse;
        
        TaggerApiNew.getTagger('test@bizlem.com', 'test_subject');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String AccountId = (String) result.get('AccountId');

        System.assertEquals(''+acc.id, AccountId);
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/taggernew';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        
        TaggerApiNew.getTagger('', '');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('required parameters value(s) is(are) missing', error_description);
    }
}