public with sharing class UpdateLeadPageLayout 
{
	// Add custom field to page layout
    
    public Metadata.Layout buildLayout() {
        
        // Retrieve Lead layout and section 
        List<Metadata.Metadata> layouts = 
            Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {'Lead-Lead Layout'});
        
        Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
        Metadata.LayoutSection layoutSectionToEdit = null;
        List<Metadata.LayoutSection> layoutSections = layoutMd.layoutSections;
        for (Metadata.LayoutSection section : layoutSections) {
            
            if (System.equals(section.label, 'Lead Information')) {
                layoutSectionToEdit = section;
                break;
            }
        }
        
        // Add the field under Lead info section in the left column
        List<Metadata.LayoutColumn> layoutColumns = layoutSectionToEdit.layoutColumns;     
        List<Metadata.LayoutItem> layoutItems = layoutColumns.get(0).layoutItems;
        
        // Create a new layout item for the custom field
        Metadata.LayoutItem item1 = new Metadata.LayoutItem();
        item1.behavior = Metadata.UiBehavior.Edit;
        item1.field = 'bizlem__Lead_No__c';        
        
        
        layoutItems.add(item1);
         
        return layoutMd;
    }
}