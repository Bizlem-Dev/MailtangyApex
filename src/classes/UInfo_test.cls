@isTest
public class UInfo_test 
{
	public testMethod  static void testPostMethod1()
    {
        Test.startTest();
        UInfo UI = new UInfo();
        Test.stopTest();
        
        // Verify result
        
        System.assertEquals(UI.Email, userInfo.getUserEmail());
    }
    
}