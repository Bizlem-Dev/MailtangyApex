@RestResource(urlMapping='/v1/alltasks')
global with sharing class AllCreatedTask 
{
    
    public static Boolean validateEmail(String email) {         //validate email method
        Boolean res = true;
        
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';         //Email validation
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        
        if (!MyMatcher.matches()) 
            res = false;
        return res;  
    }
    
    @HttpPost
    global static void gettasks(String rm_email)
    {
        RestResponse response = RestContext.response;
        if(String.isBlank(rm_email))
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','Missing data' );
            gen.writeStringField('error_description','Required parameters data are missing.' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
        else if(!validateEmail(rm_email))
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','Wrong Email' );
            gen.writeStringField('error_description','Email is not in correct format.' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
        else
        {
            list<Lead> allLeads = new list<Lead>();
            list<Contact> allContacts = new list<Contact>();
            list<Id> allLeadsID = new list<Id>();
            list<Id> allContactsId = new list<Id>();
            list<task> all_created_tasks = new list<task>();
            
            allLeads = [select id, Email from Lead where Email =: rm_Email];
            allContacts = [SELECt Id, Email from Contact where Email=: rm_email ];
            if(!CRUD.isAccessible(allLeads) && !CRUD.isAccessible(allContacts))
            {
                APPLICATION_EXCEPTION.notAccessible();
            }
            else
            {
                for(lead l :allLeads)
                {
                    allLeadsID.add(l.Id);
                }
                
                for(Contact c :allContacts)
                {
                    allContactsID.add(c.Id);
                }
                
                
                all_created_tasks = [SELECT OwnerId,Priority,ActivityDate,Whatid,Status,Subject,CreatedBy.Name,LastModifiedBy.Name FROM Task WHERE whoID IN: allLeadsID OR WhoId IN: allContactsID];
                if(!CRUD.isAccessible(all_created_tasks))
                {
                    APPLICATION_EXCEPTION.notAccessible(); 
                }
                else
                {
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeNumberField('Number_of_records',all_created_tasks.size());
                    gen.writeFieldName('taskdata');
                    gen.writeStartArray();
                    for(Task t : all_created_tasks)
                    {
                        gen.writeStartObject();
                        
                        if(String.isBlank(t.OwnerId))
                        {
                            gen.writeNullfield('AssignedTo');
                        }
                        else
                        {
                            gen.writeStringField('AssignedTo',t.OwnerId);
                        }
                        
                        if(String.isBlank(t.Subject))
                        {
                            gen.writeNullfield('Subject');
                        }
                        else
                        {
                            gen.writeStringField('Subject',t.Subject);
                        }
                        
                        if(String.isBlank(t.Status))
                        {
                            gen.writeNullfield('Status');
                        }
                        else
                        {
                            gen.writeStringField('Status',t.Status);
                        }
                        
                        gen.writeStringField('Name',rm_email);
                        
                        if(t.ActivityDate == NUll)
                        {
                            gen.writeNullfield('DueDate');
                        }
                        else
                        {
                            gen.writeDateField('DueDate',t.ActivityDate);
                        }
                        
                        if(String.isBlank(t.WhatId))
                        {
                            gen.writeNullfield('RelatedTo');
                        }
                        else
                        {
                            gen.writeStringField('RelatedTo',t.WhatId);
                        }
                        
                        if(String.isBlank(t.Priority))
                        {
                            gen.writeNullfield('Priority');
                        }
                        else
                        {
                            gen.writeStringField('Priority',t.Priority);
                        }
                        
                        if(String.isBlank(t.CreatedBy.Name))
                        {
                            gen.writeNullfield('CreatedBy');
                        }
                        else
                        {
                            gen.writeStringField('CreatedBy',t.CreatedBy.Name);
                        }
                        
                        if(String.isBlank(t.lastModifiedBy.Name))
                        {
                            gen.writeNullfield('lastModifiedBy');
                        }
                        else
                        {
                            gen.writeStringField('lastModifiedBy',t.lastModifiedBy.Name);
                        }
                        
                        gen.writeEndObject();
                    }
                    gen.writeEndArray();
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
            }
        }
        
    }
}