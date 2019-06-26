public with sharing class UpdateCasePageLayout 
{
	// Add custom field to page layout
    
    public Metadata.Layout buildLayout() {
        
        // Retrieve Case layout and section 
        List<Metadata.Metadata> layouts = 
            Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {'Case-Case Layout'});
        
        Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
        Metadata.LayoutSection layoutSectionToEdit = null;
        List<Metadata.LayoutSection> layoutSections = layoutMd.layoutSections;
        for (Metadata.LayoutSection section : layoutSections) {
            
            if (System.equals(section.label, 'Case Information')) {
                layoutSectionToEdit = section;
                break;
            }
        }
        
        // Add the field under Case info section in the left column
        List<Metadata.LayoutColumn> layoutColumns = layoutSectionToEdit.layoutColumns;     
        List<Metadata.LayoutItem> layoutItems = layoutColumns.get(0).layoutItems;
        
        // Create a new layout item for the custom field
        Metadata.LayoutItem item1 = new Metadata.LayoutItem();
        item1.behavior = Metadata.UiBehavior.Edit;
        item1.field = 'bizlem__Email__c';
        
        Metadata.LayoutItem item2 = new Metadata.LayoutItem();
        item2.behavior = Metadata.UiBehavior.Edit;
        item2.field = 'bizlem__Reason_for_closing_the_case__c';
        
        layoutItems.add(item1);
        layoutItems.add(item2);
        
        return layoutMd;
    }
}