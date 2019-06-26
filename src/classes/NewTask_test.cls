@isTest
public class NewTask_test 
{
	public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/create_task';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        NewTask.NewTask('TestSubject', '2018-12-15T15:36:35Z', 'High', 'test description or comments', 'New', '', '', '2018-12-15T14:36:35Z');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('Task created successfully', message);
        
    }
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/create_task';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        NewTask.NewTask('', '2018-12-15T15:36:35Z', 'High', 'test description or comments', 'New', '', '', '2018-12-15T14:36:35Z');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Required parameters data are missing or blank.', error_description);
        
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/create_task';
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
        insert con;
        
        NewTask.NewTask('TestSubject', '2018-12-15T15:36:35Z', 'High', 'test description or comments', 'New', con.Id, acc.Id, '2018-12-15T14:36:35Z');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('Task created successfully', message);
        
    }
    
}