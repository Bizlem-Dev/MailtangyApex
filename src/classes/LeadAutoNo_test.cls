@isTEST
public class LeadAutoNo_test 
{
    public testMethod  static void testPostMethod1()
    {
        Test.startTest();
        Lead l = new Lead();
        l.lastName = 'test1';
        l.company = 'comp1';
        l.Status = 'open';
        
        insert l;
        
        Test.stopTest();
        
        //Verify Result
        System.assertEquals('test1', l.LastName);
    }
    
    public testMethod  static void testPostMethod2()
    {
        Test.startTest();
        last_Lead_no__c l = new last_Lead_no__c();
        l.Name = 'lastno';
        l.leadNo__c = '1';
        insert l;
        
        Lead l1 = new Lead();
        l1.lastName = 'test2';
        l1.company = 'comp2';
        l1.Status = 'open';
        insert l1;
        Test.stopTest();
        
        //Verify Result
        System.assertEquals('test2', l1.LastName);
    }
    
}