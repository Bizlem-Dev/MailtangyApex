public with sharing class CampaignInfo 
{
    list<Campaign> campList;
    list<CampaignMember> campMembList{get; set; }
    Id selectedCampId{get; set; }
    List<SelectOption> options{get; Set; }
    
    
	Public CampaignInfo()
    {
        campList = new list<Campaign>();
        campMembList = new list<CampaignMember>();
        options = new List<SelectOption>();
    }
    public void pageLoad()
    {
        campList = [SELECT ID, Name FROM Campaign WHERE IsActive = true AND IsDeleted = False ];
        for(Campaign camp : campList)
        {
            options.add(new SelectOption(camp.Id, camp.Name));
        }
    }
    Public void campSelected()
    {
        campMembList = [SELECT Email,Name,Type FROM CampaignMember WHERE CampaignId =: selectedCampId ];
    }
}