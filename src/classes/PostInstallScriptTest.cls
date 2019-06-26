@isTest
public class PostInstallScriptTest 
{
    @isTest
    static void installertest()
    {
        Test.startTest();
        Integer beforeInstall = Limits.getEmailInvocations();
        PostInstallScript postinstall = new PostInstallScript();
    	Test.testInstall(postinstall, Null);
        system.assert(Limits.getEmailInvocations() >= beforeInstall);
        Test.stopTest();
    }
}