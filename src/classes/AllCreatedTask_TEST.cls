@isTest
public class AllCreatedTask_TEST 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/alltasks';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        AllCreatedTask.gettasks('');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ed = (String) result.get('error_description');
        System.assertEquals(ed, 'Required parameters data are missing.');
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/alltasks';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        AllCreatedTask.gettasks('InvalidEmail');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String ed = (String) result.get('error_description');
        System.assertEquals(ed, 'Email is not in correct format.');
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/alltasks';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        Contact con = new Contact();
        con.LastName = 'testLastName';
        con.Email = 'test@test.com';
        insert con;
        
        Task t = new Task();
        t.Subject = 'testSubject';
        t.WhoId = con.Id;
        t.Priority = 'High';
        t.Status = 'In Progress';
        Insert t;
        AllCreatedTask.gettasks('test@test.com');
        
        Test.stopTest();
        
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        Integer ed = (Integer)result.get('Number_of_records');
        System.assert(ed>=0);
        
    }
}