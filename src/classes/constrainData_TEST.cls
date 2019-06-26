@isTest
public class constrainData_TEST 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.Email = 'test@test.com';
        Insert Con;
        ConstrainData.getConstrain('FirstName', 'testLastName', 'COntact');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        lead con = new lead();
        con.LastName = 'testLastName';
        con.Email = 'test@test.com';
        con.company = 'testCOM';
        Insert Con;
        ConstrainData.getConstrain('FirstName', 'testLastName', 'lead');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'LIVESTON',
                            FirstName='JASON',
                            Alias = 'jlv',
                            Email = 'jason.liveston@asdf.com',
                            Username = 'tes@constarin.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        ConstrainData.getConstrain('JASON', 'LIVESTON', 'user');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        ConstrainData.getConstrain('FirstName', '', 'lead');
        
        Test.stopTest();
        
        // Verify result
    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
        RestContext.response.responseBody.toString());
    String error_description = (String) result.get('error_description');
	System.assertEquals(error_description, 'LAST NAME can not be NULL for given constrain.');
    }
    
    public testMethod  static void testPostMethod5()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        account con = new account();
        con.NAme = 'testLastName';
        con.bizlem__Email__c = 'test@t.com';
        Insert Con;
        ConstrainData.getConstrain('FirstName', 'testLastName', 'account');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    public testMethod  static void testPostMethod6()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        account acc = new account();
        acc.NAme = 'testLastName';
        acc.bizlem__Email__c = 'test@t.com';
        Insert acc;
        
        asset ass = new asset();
        ass.NAme = 'testLastName';
        ass.AccountId = acc.id;
        //ass.ContactId = con.id;
        Insert ass;
        ConstrainData.getConstrain('FirstName', 'testLastName', 'asset');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod7()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        Campaign ca = new Campaign(Name='Test Campaign');
        insert ca;
        ConstrainData.getConstrain('Test Campaign', 'Campaigname', 'Campaign');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod8()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        Product2 pro = new Product2(Name='TestProduct');
        insert pro;
        ConstrainData.getConstrain('TestProduct', 'TestProduct', 'Product');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
        
    }
    
    public testMethod  static void testPostMethod9()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        Opportunity opp = new Opportunity();
        opp.name = 'TestOpp';
        opp.CloseDate = System.today();
        opp.StageName = 'Prospecting';
        insert opp;
        ConstrainData.getConstrain('TestOpp', 'TestOpp', 'Opportunity');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
    }
    
    public testMethod  static void testPostMethod10()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        ConstrainData.getConstrain('    ', '       ', 'Opportunity');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ed = (String) result.get('error_description');
        System.assertEquals(ed, 'LAST NAME AND FIRST NAME can not be NULL for given constrain.');
    }
    
    public testMethod  static void testPostMethod11()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        ConstrainData.getConstrain('tes', 'tes', 'Case');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ed = (String) result.get('error_description');
        System.assertEquals(ed, 'the input constrain can not be queried.');
    }
    
    public testMethod  static void testPostMethod12()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/constrainData';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        ConstrainData.getConstrain('tes', 'tes', '');
        
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ed = (String) result.get('error_description');
        System.assertEquals(ed, 'CONSTRAIN can not be NULL.');
    }
    
}