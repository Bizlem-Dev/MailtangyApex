@isTest
public class APPLICATION_EXCEPTION_TEST 
{
	public testMethod  static void testPostMethod1()
    {
        Test.startTest();
        try{
    	APPLICATION_EXCEPTION.notAccessible();
        }
        catch(Exception e)
        {
            System.assertEquals('user do not have permission to ACCESS the data.', e.getMessage());
        }
        Test.stopTest();
    }
    
    public testMethod  static void testPostMethod2()
    {
        Test.startTest();
        try{
    	APPLICATION_EXCEPTION.notCreateable();
        }
        catch(Exception e)
        {
            System.assertEquals('user do not have permission to INSERT the data.', e.getMessage());
        }
        Test.stopTest();
    }
    
    public testMethod  static void testPostMethod3()
    {
        Test.startTest();
        try{
    	APPLICATION_EXCEPTION.notDeleteable();
        }
        catch(Exception e)
        {
            System.assertEquals('user do not have permission to DELETE the data.', e.getMessage());
        }
        Test.stopTest();
    }
    
    public testMethod  static void testPostMethod4()
    {
        Test.startTest();
        try{
    	APPLICATION_EXCEPTION.notUpdateable();
        }
        catch(Exception e)
        {
        	System.assertEquals('user do not have permission to UPDATE the data.', e.getMessage());
        }
        Test.stopTest();
    }
}