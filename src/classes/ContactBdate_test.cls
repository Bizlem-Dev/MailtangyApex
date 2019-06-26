@isTest
public class ContactBdate_test 
{
	public testMethod  static void testPostMethod1()
    {
        // Create test data
        Contact con = new Contact();
        
        con.LastName = 'lastName';
        con.Birthdate = System.today();
        con.Email = 'test@email.com';
        
        insert con;

        // Set REST context
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        RestContext.request.httpMethod = 'POST';

        // Execute test
        Test.startTest();
        contactBdate.getContactBday('test@email.com');
        Test.stopTest();

        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        List<Object> customersData = (List<Object>) result.get('Customers_Data');

        System.assertEquals(1, customersData.size(),
            'Incorrect number of customers returned');

        Map<String, Object> firstCustomer = (Map<String, Object>) customersData[0];

        System.assertEquals(con.LastName, firstCustomer.get('Contact_Last_Name'),
            'Incorrect customer data returned');
        System.assertEquals(con.Email, firstCustomer.get('Email'),
            'Incorrect customer data returned');
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Birthdate = System.today();
        con.Email = 'test@email.com';
        insert con;
        contactBdate.getContactBday(Null);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        List<Object> customersData = (List<Object>) result.get('Customers_Data');

        System.assertEquals(1, customersData.size());
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Birthdate = System.today()+1;
        con.Email = 'test@email.com';
        insert con;
        contactBdate.getContactBday('test@email.com');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('There is no relevant data.', message);
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Birthdate = System.today()+1;
        con.Email = 'test@email.com';
        insert con;
        contactBdate.getContactBday(Null);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('NO customer has birthday today', message);
    }
    
    public testMethod  static void testPostMethod5()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.name = 'testAcc';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Salutation = 'Mr.';
        con.FirstName = 'first';
        con.AccountId = acc.Id;
        con.HomePhone = '9999999999';
        con.MobilePhone = '9999999999';
        con.Fax = '99999';
        con.Birthdate = System.today();
        insert con;
        contactBdate.getContactBday(Null);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        List<Object> customersData = (List<Object>) result.get('Customers_Data');

        System.assertEquals(1, customersData.size());
    }
    
    public testMethod  static void testPostMethod6()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        
        Account acc =  new Account();
        acc.email__c='test@gmail.com';
        acc.name = 'testAcc';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Salutation = 'Mr.';
        con.FirstName = 'first';
        con.AccountId = acc.Id;
        con.HomePhone = '9999999999';
        con.MobilePhone = '9999999999';
        con.Fax = '99999';
        con.Birthdate = System.today();
        con.Email = 'test@email.com';
        insert con;
        contactBdate.getContactBday('test@email.com');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        List<Object> customersData = (List<Object>) result.get('Customers_Data');

        System.assertEquals(1, customersData.size());
    }
    
    public testMethod  static void testPostMethod7()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/todayBday';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        Contact con = new Contact();
        con.LastName = 'lastName';
        con.Birthdate = System.today()+1;
        con.Email = 'test@te.com';
        insert con;
        contactBdate.getContactBday('Null');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Email is not in correct format.', error_description);
    }
}