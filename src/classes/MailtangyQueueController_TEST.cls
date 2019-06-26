@isTest
public class MailtangyQueueController_TEST 
{
	@IsTest
    static void testMethod1()
    {
    	Test.startTest();
        Account acc =  new Account();
        acc.email__c = 'test@gmail.com';
        acc.Name = 'testAcc';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'testFName';
        con.lastName = 'testlName';
        insert con;
        
        CASE cse = new CASE();
        cse.Status = 'New';
        cse.Priority = 'Medium';
        insert cse;
        
        CASE cse1 = new CASE();
        cse1.Status = 'Closed';
        cse1.Priority = 'Medium';
        insert cse1;
        
        Mailtangy_Email_Queue__c meq = new Mailtangy_Email_Queue__c();
        meq.Subject__c = 'testSubject';
        meq.Summerizer_Output__c = 'test Summerizer Output';
        meq.Sentiment_Output__c = 'testSentiment_Output__c';
        meq.Received_Date__c = system.now();
        meq.Account_Id__c = acc.id;
        meq.Contact_ID__c = con.id;
        meq.Case_ID__c = cse.Id;
        insert meq;
       
        MailtangyQueueController mqc = new MailtangyQueueController();
        mqc.selectedUserId = userInfo.getUserId();
        System.assertEquals(false, mqc.lstMailQueue[0].selected);
        for(Integer i = 0; i < mqc.lstMailQueue.size(); i++)
        {
            mqc.lstMailQueue[i].selected = true;
        }
        mqc.saveRecord();
        
        //Creating Group
        Group testGroup = new Group(Name='QUEUE NAME', Type='Queue');
        insert testGroup;
        
        //Creating QUEUE
        QueuesObject testQueue = new QueueSObject(QueueID = testGroup.id, SObjectType = 'Case');
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            //Associating queue with group AND to the Case object
            
            insert testQueue;
        }
        
        GroupMember member = new GroupMember();
		member.UserOrGroupId = userInfo.getUserId();
		member.GroupId = testGroup.Id;
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            //Associating member with group
            
            insert member;
        }
        
        List<SelectOption> options1 = new List<SelectOption>(); 
       	options1 = mqc.getselectValues1();
       	system.assertNotEquals(null, options1, 'The collection should be instantiated');
    	system.assert(!options1.isEmpty(), 'The collection should be populated');
        
        List<SelectOption> options = new List<SelectOption>(); 
        options = mqc.getselectValues();
        system.assertNotEquals(null, options, 'The collection should be instantiated');
    	system.assert(!options.isEmpty(), 'The collection should be populated');
        
        List<SelectOption> optionsQL = new List<SelectOption>();
        mqc.GetqueueList();
		system.assertNotEquals(null, optionsQL, 'The collection should be instantiated');
		
        List<SelectOption> optionsUL = new List<SelectOption>();
        mqc.selectedqueueId = testgroup.id;
		mqc.getuserlist();  
        system.assertNotEquals(null, optionsUL, 'The collection should be instantiated');
        
        List<SelectOption> optionsUDL = new List<SelectOption>();
        mqc.selectedqueueId = testgroup.ID;
        mqc.GetUserddList();
        system.assertNotEquals(null, optionsUDL, 'The collection should be instantiated');
                
        Test.stopTest();
    }
}