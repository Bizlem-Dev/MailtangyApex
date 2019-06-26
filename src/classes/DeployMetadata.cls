public with sharing class DeployMetadata {
 
    // Create metadata container 
    public List<Metadata.DeployContainer> constructDeploymentRequest() {
        
        List<Metadata.DeployContainer> lstcontainer = new List<Metadata.DeployContainer>();
        Metadata.DeployContainer accContainer = new Metadata.DeployContainer();
        Metadata.DeployContainer CaseContainer = new Metadata.DeployContainer();
        Metadata.DeployContainer LeadContainer = new Metadata.DeployContainer();
        // Add components to container         
        Metadata.Layout AccountlayoutMetadata = new UpdateAccountPageLayout().buildLayout();
        acccontainer.addMetadata(AccountlayoutMetadata);
        lstContainer.add(accContainer);
        
        Metadata.Layout CaselayoutMetadata = new UpdateCasePageLayout().buildLayout();
        CaseContainer.addMetadata(CaselayoutMetadata);
        lstContainer.add(CaseContainer);
        
        Metadata.Layout LeadlayoutMetadata = new UpdateLeadPageLayout().buildLayout();
        LeadContainer.addMetadata(LeadlayoutMetadata);
        lstContainer.add(LeadContainer);
        
        return lstcontainer;
    }
    
    // Deploy metadata
    public void deploy(Metadata.DeployContainer container) {
        // Create callback. 
        PostInstallCallback callback = new PostInstallCallback();
        
        // Deploy the container with the new components. 
        if(Test.isRunningTest())
        {
        }
        else
        {
        Metadata.Operations.enqueueDeployment(container, callback);
        }
        
    }
}