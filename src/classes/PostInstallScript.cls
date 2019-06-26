public with sharing class PostInstallScript implements InstallHandler{
    
    // Deploy post-install metadata  
    public void onInstall(InstallContext context) 
    {
        try
        {  
            //NewConnectedApp.createCapp();
            DeployMetadata deployUtil = new DeployMetadata();
            List<Metadata.DeployContainer> lstcontainer = deployUtil.constructDeploymentRequest();
            for(Metadata.DeployContainer container : lstcontainer)
            {
                deployUtil.deploy(container);
            }
            
        }catch(Exception ex)
        {
            Messaging.SingleEmailMessage emailTobeSent = new Messaging.SingleEmailMessage();
            List<String> listEmailMembers = new list<String>();
            listEmailMembers.add('akshit.huria94@gmail.com');
            //listEmailMembers.add('youmailid.com');
            emailTobeSent.setToAddresses(listEmailMembers);
            emailTobeSent.setSubject('Hi i have entered into exception');
            emailTobeSent.setHtmlBody('Message : ' + ex.getMessage() + 'Line no : ' + ex.getLineNumber() + ' getStackTraceString ' + ex.getStackTraceString() + '' + ex.getCause());
            Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailTobeSent});
        }
    }
    
    
}