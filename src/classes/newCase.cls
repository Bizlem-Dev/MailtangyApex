@RestResource(urlMapping='/v1/case')
global with sharing class newCase
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
    global static void createCase(String email, String subject, String status, String case_origin, String accountId, String contactId, String type, String case_reason, String priority, String description, String web_email, String web_company, String web_phone, String web_name){
        
        //Boolean check=false;
        //RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        
        if(!validateEmail(email))
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
        else if(String.isNotBlank(email) && String.isNotBlank(subject) && String.isNotBlank(status) && String.isNotBlank(case_origin) && string.isNotBlank(accountId) && String.isNotBlank(contactId) )            
        {
            list<Account> acc = new list<Account>();
            acc = [select id from Account where id=: accountId];
            
            list<Contact> con = new list<Contact>();
            con = [select id from contact where id=: contactId];
            
            if(!CRUD.isAccessible(acc) && !CRUD.isAccessible(con))
            {
                APPLICATION_EXCEPTION.notAccessible();
            }
            
            else{
                if(acc.size()>0 && con.size()>0)
                {
                    try
                    {
                        Case c = new Case();
                        c.AccountId = accountId;
                        c.ContactId = contactId;
                        c.Status = status;
                        c.Origin = case_origin;
                        c.Subject = subject;
                        c.Description = description;
                        c.Type = type;
                        c.Reason = case_reason;
                        c.Priority = priority;
                        c.email__c = email;
                        c.SuppliedEmail = web_email;
                        c.SuppliedCompany = web_company;
                        c.SuppliedName = web_name;
                        c.SuppliedPhone = web_phone;
                        
                        if(!CRUD.isCreateable(c))
                        {
                            APPLICATION_EXCEPTION.notCreateable();
                        }
                        else{
                            insert c;
                            Case c1 = new case();
                            c1 = [select id, CaseNumber, OwnerId, Origin, status from Case where id =: c.Id];
                            
                            response.statusCode =200;
                            JSONGenerator gen =  JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeStringField('message','Case created successfully' );
                            gen.writeStringField('casenumber',''+c1.CaseNumber);
                            gen.writeStringField('ownerId',''+c1.OwnerId );
                            gen.writeStringField('caseId',''+c1.Id);
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                        
                    }
                    catch(Exception ex)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('error',String.valueOf(ex.getMessage()) );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                }
                else
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','invalid data ' );
                    gen.writeStringField('error_description', 'Either accountID or ContactId didnot match.');
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
            }
        }
        else
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
        
    }
}