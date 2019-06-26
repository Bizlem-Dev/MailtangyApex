@isTest
public class Delete_Records_test 
{
    public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Delete_Records.delRec('', '');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Required parameters data are missing or blank.', error_description);
        
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
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
        
        Delete_Records.delRec('case', cse.CaseNumber);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type case with id/no '+cse.CaseNumber+' is deleted sucessfully.', message);
    }
    
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
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
        
        Delete_Records.delRec('case', '37547');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type case with the given id/no.', error_description);
        
    }
    
    public testMethod  static void testPostMethod4()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Lead testlead = new Lead();
        testlead.lastName = 'test_lastName';
        testlead.Company = 'testCompant';
        testlead.Status = 'test_Status';
        insert testlead;
        
        Lead led = new Lead();
        led = [Select id, Lead_No__c from Lead where id =: testlead.Id];
        
        Delete_Records.delRec('lead', led.Lead_No__c);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type lead with id/no '+led.Lead_No__c+' is deleted sucessfully.', message);
    }
    
    public testMethod  static void testPostMethod5()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Lead testlead = new Lead();
        testlead.lastName = 'test_lastName';
        testlead.Company = 'testCompant';
        testlead.Status = 'test_Status';
        insert testlead;
        
        Lead led = new Lead();
        led = [Select id, Lead_No__c from Lead where id =: testlead.Id];
        
        Delete_Records.delRec('lead', '425');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type lead with the given id/no.', error_description);
    }
    
    public testMethod  static void testPostMethod6()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Contact con = new Contact();
        con.lastName = 'test_lastName';
        insert con;
        
        Contact cont = new Contact();
        cont = [Select id from Contact where id =: con.Id];
        
        Delete_Records.delRec('Contact', cont.Id);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type Contact with id/no '+cont.Id+' is deleted sucessfully.', message);
    }
    
    public testMethod  static void testPostMethod7()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Contact con = new Contact();
        con.lastName = 'test_lastName';
        insert con;
        
        Contact cont = new Contact();
        cont = [Select id from Contact where id =: con.Id];
        
        Delete_Records.delRec('Contact', '256');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type Contact with the given id/no.', error_description);
    }
    
    public testMethod  static void testPostMethod8()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Account acc = new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'test_Name';
        insert acc;
        
        Account acct = new Account();
        acct = [Select id from Account where id =: acc.Id];
        Delete_Records.delRec('Account', acct.Id);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type Account with id/no '+acct.Id+' is deleted sucessfully.', message);
    }
    public testMethod  static void testPostMethod9()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Account acc = new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'test_Name';
        insert acc;
        
        Account acct = new Account();
        acct = [Select id from Account where id =: acc.Id];
        
        Delete_Records.delRec('Account', '256');
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type Account with the given id/no.', error_description);
    }
    
    public testMethod  static void testPostMethod10()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Task api_task = new Task();
        api_task.OwnerId = UserInfo.getUserId();
        api_task.Subject = 'Subject';
        api_task.Priority = 'High';
        api_task.Description = 'Comments';
        api_task.Status = 'New';
        insert api_task;
        
        Task tsk = new Task();
        tsk = [Select id from Task where id =: api_task.Id];
        
        Delete_Records.delRec('Task', tsk.ID);
        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type Task with id/no '+tsk.ID+' is deleted sucessfully.', message);
    }
    
    public testMethod  static void testPostMethod11()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Task api_task = new Task();
        api_task.OwnerId = UserInfo.getUserId();
        api_task.Subject = 'Subject';
        api_task.Priority = 'High';
        api_task.Description = 'Comments';
        api_task.Status = 'New';
        insert api_task;
        
        Task tsk = new Task();
        tsk = [Select id from Task where id =: api_task.Id];
        
        Delete_Records.delRec('Task', '5345');

        Test.stopTest();
        
                // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type Task with the given id/no.', error_description);
    }
    
    public testMethod  static void testPostMethod12()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Opportunity opp = new Opportunity();
        opp.Name = 'testName';
        opp.CloseDate = System.today()+1;
        opp.StageName = 'Prospecting';
        insert opp;
        
        Opportunity opt = new Opportunity();
        opt = [Select id from Opportunity where id =: opp.Id];
        
        Delete_Records.delRec('Opportunity', opt.id);

        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('The record of type Opportunity with id/no '+opt.id+' is deleted sucessfully.', message);
    }
    
    public testMethod  static void testPostMethod13()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Opportunity opp = new Opportunity();
        opp.Name = 'testName';
        opp.CloseDate = System.today()+1;
        opp.StageName = 'Prospecting';
        insert opp;
        
        Opportunity opt = new Opportunity();
        opt = [Select id from Opportunity where id =: opp.Id];
        
        Delete_Records.delRec('Opportunity', '253');

        Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('there is no record of type Opportunity with the given id/no.', error_description);
    }
    
    public testMethod  static void testPostMethod14()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/delete_records';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        Delete_Records.delRec('type', '5353');
        test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('type parameter is not correct.', error_description);
    }
}