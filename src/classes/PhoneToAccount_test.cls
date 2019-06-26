@isTest
public class PhoneToAccount_test 
{
    
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        PhoneToAccount.getAcc(Null);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Phone number is required.', error_description);
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        PhoneToAccount.getAcc('987654321098');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Given phone number is invalid', error_description);
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        PhoneToAccount.getAcc('9876543210');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('No relevant data found.', message);
    }
    
    
	public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
    	
        Account acc = new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testacc';
        acc.Phone = '9876543210';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'testlName';
        con.HomePhone = '9876543210';
        con.MobilePhone = '9876543210';
        con.Phone = '9876543210';
        insert con;
        
        PhoneToAccount.getAcc('9876543210');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String account_name = (String) result.get('account_name');

        System.assertEquals(acc.Name, account_name);
    }
    
    public testMethod  static void testPostMethod5()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
    	
        Account acc = new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testacc';
        acc.Phone = '9876543210';
        insert acc;
        
        PhoneToAccount.getAcc('9876543210');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String account_name = (String) result.get('account_name');

        System.assertEquals(acc.Name, account_name);
    }
    
    public testMethod  static void testPostMethod6()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/phone';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
    	
        Contact con = new Contact();
        con.FirstName = 'testFName';
        con.LastName = 'testlName';
        con.HomePhone = '9876543210';
        con.MobilePhone = '9876543210';
        con.Phone = '9876543210';
        insert con;
        
        PhoneToAccount.getAcc('9876543210');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String contact_name = (String) result.get('contact_name');

        System.assertEquals(con.FirstName+' '+con.LastName, contact_name);
    }
    
}