public with sharing class NewConnectedApp 
{
    @future
    public static void createCapp()
    {
            //Create ConnectedApp
            MetadataService.MetadataPort cAppservice = new MetadataService.MetadataPort();
            cAppservice.SessionHeader = new MetadataService.SessionHeader_element();
            cAppservice.SessionHeader.sessionId = UserInfo.getSessionId();
            MetadataService.ConnectedApp connectedApp = new MetadataService.ConnectedApp();
            connectedApp.fullName = 'bizlem';
            connectedApp.contactEmail = userinfo.getUserEmail();
            connectedApp.label = 'bizlem';
            MetadataService.ConnectedAppOauthConfig cp = new MetadataService.ConnectedAppOauthConfig();
            cp.callbackUrl = 'https://35.188.249.145:8443/SFDC';
            cp.consumerKey = '3MVG9ZL0ppGP5UrAs2Jg_acdCMhisGRAJLpM.JfhXbWTMUXz9U_CHAMANBhaikkTh3nTELXdJo9m3s';
            cp.consumerSecret = '8387158423079651754';
            cp.scopes = new List<String>{'RefreshToken','Full'};
                connectedApp.oauthConfig =cp;
            List<MetadataService.SaveResult> results = cAppservice.createMetadata(new MetadataService.Metadata[] { connectedApp });
    }
}