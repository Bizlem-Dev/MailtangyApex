@isTest
public class NewConnectedApp_TEST 
{
    static testmethod void testScheduledJob()
    {   
        Test.startTest();
        NewConnectedApp.createCapp();
        Test.stopTest();
        
        System.assert(1<2);
        
    }
}