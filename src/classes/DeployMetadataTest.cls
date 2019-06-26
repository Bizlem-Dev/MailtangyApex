@IsTest
public class DeployMetadataTest {
    @IsTest
    static void testDeployment() {
        DeployMetadata deployMd = new DeployMetadata();
        
        List<Metadata.DeployContainer> container = deployMd.constructDeploymentRequest();
        for(Metadata.DeployContainer cc : container)
        {
            List<Metadata.Metadata> contents = cc.getMetadata();
            System.assertEquals(1, contents.size());
            
        }
    }
}