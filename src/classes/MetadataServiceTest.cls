@isTest
public class MetadataServiceTest 
{
	@IsTest
    static void testMetadataService()
    {
        Test.startTest();
        new MetadataService.ConnectedAppOauthConfig();
        new MetadataService.ConnectedAppAttribute();
        new MetadataService.ConnectedAppIpRange();
        new MetadataService.ConnectedAppMobileDetailConfig();
        new MetadataService.ConnectedApp();
        new MetadataService.ConnectedAppSamlConfig();
        new MetadataService.ConnectedAppCanvasConfig();
        new MetadataService.SaveResult();
        new MetadataService.createMetadata_element();
        new MetadataService.createMetadataResponse_element();
        new MetadataService.SessionHeader_element();
        new MetadataService.DebuggingInfo_element();
        new MetadataService.DebuggingHeader_element();
        new MetadataService.LogInfo();
        new MetadataService.Error();
        new MetadataService.CallOptions_element();
        new MetadataService.AllOrNoneHeader_element();
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        MetadataService.RemoteSiteSetting rss = new MetadataService.RemoteSiteSetting();
        metaDataPort.createMetadata(null);
        System.assertEquals(NULL, metaDataPort.createMetadata(null));
        Test.stopTest();
    }
}