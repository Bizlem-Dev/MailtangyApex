@RestResource(urlMapping='/v1/constrainData')
global with sharing class ConstrainData 
{
    @HttpPost
    global static void getConstrain(String FirstName, String LastName, String Constrain)
    {
        RestResponse response = RestContext.response;
        if(String.isNotBlank(constrain))
        {
            if(Constrain.equalsIgnoreCase('user') || Constrain.equalsIgnoreCase('contact') || Constrain.equalsIgnoreCase('lead'))
            {
                if(String.isNotBlank(LastName))
                {
                    if(Constrain.equalsIgnoreCase('user'))
                    {
                        list<User> allUser = new list<USER>();
                        allUser = [ SELECT Alias,Email,Fax,FirstName,IsActive,LastName,MobilePhone FROM User where lastName =: LastName];
                        
                        if(!CRUD.isAccessible(allUser))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allUser.size());
                            gen.writeFieldName('userdata');
                            gen.writeStartArray();
                            for(user u : allUser)
                            {
                                gen.writeStartObject();
                                if(String.isBlank(u.FirstName))
                                {
                                    gen.writeNullfield('FirstName');
                                }
                                else
                                {
                                    gen.writeStringField('FirstName',u.FirstName);
                                }
                                
                                if(String.isBlank(u.LastName))
                                {
                                    gen.writeNullfield('LastName');
                                }
                                else
                                {
                                    gen.writeStringField('LastName',u.LastName);
                                }
                                
                                if(String.isBlank(u.Alias))
                                {
                                    gen.writeNullfield('Alias');
                                }
                                else
                                {
                                    gen.writeStringField('Alias',u.Alias);
                                }
                                
                                if(String.isBlank(u.Email))
                                {
                                    gen.writeNullfield('Email');
                                }
                                else
                                {
                                    gen.writeStringField('Email',u.Email);
                                }
                                
                                if(String.isBlank(u.Fax))
                                {
                                    gen.writeNullfield('Fax');
                                }
                                else
                                {
                                    gen.writeStringField('Fax',u.Fax);
                                }
                                
                                if(String.isBlank(u.MobilePhone))
                                {
                                    gen.writeNullfield('MobilePhone');
                                }
                                else
                                {
                                    gen.writeStringField('MobilePhone',u.MobilePhone);
                                }
                                gen.writeEndObject();
                                
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('contact'))
                    {
                        list<contact> allcontact = new list<contact>();
                        allcontact = [ SELECT AccountId,Fax,FirstName,Email,LastName,Phone FROM Contact where lastName =: LastName];
                        if(!CRUD.isAccessible(allcontact))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allcontact.size());
                            gen.writeFieldName('contactdata');
                            gen.writeStartArray();
                            for(contact u : allcontact)
                            {
                                gen.writeStartObject();
                                if(String.isBlank(u.FirstName))
                                {
                                    gen.writeNullfield('FirstName');
                                }
                                else
                                {
                                    gen.writeStringField('FirstName',u.FirstName);
                                }
                                
                                if(String.isBlank(u.LastName))
                                {
                                    gen.writeNullfield('LastName');
                                }
                                else
                                {
                                    gen.writeStringField('LastName',u.LastName);
                                }
                                
                                if(String.isBlank(u.AccountId))
                                {
                                    gen.writeNullfield('AccountId');
                                }
                                else
                                {
                                    gen.writeStringField('AccountId',u.AccountId);
                                }
                                
                                if(String.isBlank(u.Email))
                                {
                                    gen.writeNullfield('Email');
                                }
                                else
                                {
                                    gen.writeStringField('Email',u.Email);
                                }
                                
                                if(String.isBlank(u.Fax))
                                {
                                    gen.writeNullfield('Fax');
                                }
                                else
                                {
                                    gen.writeStringField('Fax',u.Fax);
                                }
                                
                                if(String.isBlank(u.Phone))
                                {
                                    gen.writeNullfield('Phone');
                                }
                                else
                                {
                                    gen.writeStringField('Phone',u.Phone);
                                }
                                gen.writeEndObject();
                                
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('lead'))
                    {
                        list<lead> alllead = new list<lead>();
                        alllead = [ SELECT Email,Fax,FirstName,LastName,Salutation,Status,Phone FROM Lead where lastName =: LastName];
                        if(!CRUD.isAccessible(alllead))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',alllead.size());
                            gen.writeFieldName('leaddata');
                            gen.writeStartArray();
                            for(lead u : alllead)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Salutation))
                                {
                                    gen.writeNullfield('Salutation');
                                }
                                else
                                {
                                    gen.writeStringField('Salutation',u.Salutation);
                                }
                                
                                if(String.isBlank(u.FirstName))
                                {
                                    gen.writeNullfield('FirstName');
                                }
                                else
                                {
                                    gen.writeStringField('FirstName',u.FirstName);
                                }
                                
                                if(String.isBlank(u.LastName))
                                {
                                    gen.writeNullfield('LastName');
                                }
                                else
                                {
                                    gen.writeStringField('LastName',u.LastName);
                                }
                                
                                if(String.isBlank(u.Status))
                                {
                                    gen.writeNullfield('Status');
                                }
                                else
                                {
                                    gen.writeStringField('Status',u.Status);
                                }
                                
                                if(String.isBlank(u.Email))
                                {
                                    gen.writeNullfield('Email');
                                }
                                else
                                {
                                    gen.writeStringField('Email',u.Email);
                                }
                                
                                if(String.isBlank(u.Fax))
                                {
                                    gen.writeNullfield('Fax');
                                }
                                else
                                {
                                    gen.writeStringField('Fax',u.Fax);
                                }
                                
                                if(String.isBlank(u.Phone))
                                {
                                    gen.writeNullfield('Phone');
                                }
                                else
                                {
                                    gen.writeStringField('Phone',u.Phone);
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
                else
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','input error' );
                    gen.writeStringField('error_description','LAST NAME can not be NULL for given constrain.' );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);   
                }
            }
            else if(Constrain.equalsIgnoreCase('account') || Constrain.equalsIgnoreCase('asset') || Constrain.equalsIgnoreCase('Campaign') || Constrain.equalsIgnoreCase('product')|| Constrain.equalsIgnoreCase('opportunity'))
            {
                if(String.isNotBlank(LastName) || String.isNotBlank(FirstName))
                {
                    if(Constrain.equalsIgnoreCase('account'))
                    {
                        list<account> allaccount = new list<account>();
                        allaccount = [ SELECT bizlem__Email__c,Fax,Name,Phone,Type,Website FROM Account where Name =: FirstName OR Name =: LastName];
                        if(!CRUD.isAccessible(allaccount))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allaccount.size());
                            gen.writeFieldName('accountdata');
                            gen.writeStartArray();
                            for(account u : allaccount)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Name))
                                {
                                    gen.writeNullfield('Name');
                                }
                                else
                                {
                                    gen.writeStringField('Name',u.Name);
                                }
                                
                                if(String.isBlank(u.bizlem__Email__c))
                                {
                                    gen.writeNullfield('Email');
                                }
                                else
                                {
                                    gen.writeStringField('Email',u.bizlem__Email__c);
                                }
                                
                                if(String.isBlank(u.Type))
                                {
                                    gen.writeNullfield('Type');
                                }
                                else
                                {
                                    gen.writeStringField('Type',u.Type);
                                }
                                
                                if(String.isBlank(u.Website))
                                {
                                    gen.writeNullfield('Website');
                                }
                                else
                                {
                                    gen.writeStringField('Website',u.Website);
                                }
                                
                                
                                if(String.isBlank(u.Fax))
                                {
                                    gen.writeNullfield('Fax');
                                }
                                else
                                {
                                    gen.writeStringField('Fax',u.Fax);
                                }
                                
                                if(String.isBlank(u.Phone))
                                {
                                    gen.writeNullfield('Phone');
                                }
                                else
                                {
                                    gen.writeStringField('Phone',u.Phone);
                                }
                                gen.writeEndObject();
                                
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('asset'))
                    {
                        list<asset> allasset = new list<asset>();
                        allasset = [ SELECT AccountId,ContactId,Name,Product2Id,ProductCode,Status FROM Asset where Name =: FirstName OR Name =: LastName];
                        if(!CRUD.isAccessible(allasset))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allasset.size());
                            gen.writeFieldName('assetdata');
                            gen.writeStartArray();
                            for(asset u : allasset)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Name))
                                {
                                    gen.writeNullfield('Name');
                                }
                                else
                                {
                                    gen.writeStringField('Name',u.Name);
                                }
                                
                                if(String.isBlank(u.AccountId))
                                {
                                    gen.writeNullfield('AccountId');
                                }
                                else
                                {
                                    gen.writeStringField('AccountId',u.AccountId);
                                }
                                
                                if(String.isBlank(u.ContactId))
                                {
                                    gen.writeNullfield('ContactId');
                                }
                                else
                                {
                                    gen.writeStringField('ContactId',u.ContactId);
                                }
                                
                                if(String.isBlank(u.ProductCode))
                                {
                                    gen.writeNullfield('ProductCode');
                                }
                                else
                                {
                                    gen.writeStringField('ProductCode',u.ProductCode);
                                }
                                
                                if(String.isBlank(u.Status))
                                {
                                    gen.writeNullfield('Status');
                                }
                                else
                                {
                                    gen.writeStringField('Status',u.Status);
                                }
                                gen.writeEndObject();
                                
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('campaign'))
                    {
                        list<campaign> allcampaign = new list<campaign>();
                        allcampaign = [ SELECT IsActive,Name,NumberOfContacts,NumberOfLeads,NumberOfOpportunities,StartDate,Status FROM Campaign where Name =: FirstName OR Name =: LastName];
                        if(!CRUD.isAccessible(allcampaign))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allcampaign.size());
                            gen.writeFieldName('campaigndata');
                            gen.writeStartArray();
                            for(campaign u : allcampaign)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Name))
                                {
                                    gen.writeNullfield('Name');
                                }
                                else
                                {
                                    gen.writeStringField('Name',u.Name);
                                }
                                
                                if(u.IsActive == NUll)
                                {
                                    gen.writeNullfield('IsActive');
                                }
                                else
                                {
                                    gen.writeBooleanField('IsActive',u.IsActive);
                                }
                                
                                if(u.NumberOfContacts == NUll)
                                {
                                    gen.writeNullfield('NumberOfContacts');
                                }
                                else
                                {
                                    gen.writeNumberField('NumberOfContacts',u.NumberOfContacts);
                                }
                                
                                if(u.NumberOfLeads == NUll)
                                {
                                    gen.writeNullfield('NumberOfLeads');
                                }
                                else
                                {
                                    gen.writeNumberField('NumberOfLeads',u.NumberOfLeads);
                                }
                                
                                if(u.NumberOfOpportunities == NUll)
                                {
                                    gen.writeNullfield('NumberOfOpportunities');
                                }
                                else
                                {
                                    gen.writeNumberField('NumberOfOpportunities',u.NumberOfOpportunities);
                                }
                                
                                if(u.StartDate == NUll)
                                {
                                    gen.writeNullfield('StartDate');
                                }
                                else
                                {
                                    gen.writeDateField('StartDate',u.StartDate);
                                }
                                
                                if(String.isBlank(u.Status))
                                {
                                    gen.writeNullfield('Status');
                                }
                                else
                                {
                                    gen.writeStringField('Status',u.Status);
                                }
                                gen.writeEndObject();
                                
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('product'))
                    {
                        list<Product2> allProduct = new list<Product2>();
                        allProduct = [ SELECT IsActive,Name,ProductCode FROM Product2 where Name =: FirstName OR Name =: LastName];
                        if(!CRUD.isAccessible(allProduct))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allProduct.size());
                            gen.writeFieldName('Productdata');
                            gen.writeStartArray();
                            for(Product2 u : allProduct)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Name))
                                {
                                    gen.writeNullfield('Name');
                                }
                                else
                                {
                                    gen.writeStringField('Name',u.Name);
                                }
                                
                                if(u.IsActive == NUll)
                                {
                                    gen.writeNullfield('IsActive');
                                }
                                else
                                {
                                    gen.writeBooleanField('IsActive',u.IsActive);
                                }
                                
                                if(String.isBlank(u.ProductCode))
                                {
                                    gen.writeNullfield('ProductCode');
                                }
                                else
                                {
                                    gen.writeStringField('ProductCode',u.ProductCode);
                                }
                                
                                gen.writeEndObject();
                            }
                            gen.writeEndArray();
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    else if(Constrain.equalsIgnoreCase('opportunity'))
                    {
                        list<opportunity> allopportunity = new list<opportunity>();
                        allopportunity = [ SELECT AccountId,CloseDate,LeadSource,Name,Type FROM Opportunity where Name =: FirstName OR Name =: LastName];
                        if(!CRUD.isAccessible(allopportunity))
                        {
                            APPLICATION_EXCEPTION.notAccessible(); 
                        }
                        else
                        {
                            JSONGenerator gen = JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeNumberField('Number_of_records',allopportunity.size());
                            gen.writeFieldName('opportunitydata');
                            gen.writeStartArray();
                            for(opportunity u : allopportunity)
                            {
                                gen.writeStartObject();
                                
                                if(String.isBlank(u.Name))
                                {
                                    gen.writeNullfield('Name');
                                }
                                else
                                {
                                    gen.writeStringField('Name',u.Name);
                                }
                                
                                if(String.isBlank(u.AccountId))
                                {
                                    gen.writeNullfield('AccountId');
                                }
                                else
                                {
                                    gen.writeStringField('AccountId',u.AccountId);
                                }
                                
                                if(u.CloseDate == NUll)
                                {
                                    gen.writeNullfield('CloseDate');
                                }
                                else
                                {
                                    gen.writeDateField('CloseDate',u.CloseDate);
                                }
                                
                                if(String.isBlank(u.LeadSource))
                                {
                                    gen.writeNullfield('LeadSource');
                                }
                                else
                                {
                                    gen.writeStringField('LeadSource',u.LeadSource);
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
                else
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','input error' );
                    gen.writeStringField('error_description','LAST NAME AND FIRST NAME can not be NULL for given constrain.' );
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
                gen.writeStringField('error','input error' );
                gen.writeStringField('error_description','the input constrain can not be queried.' );
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
            gen.writeStringField('error','input error' );
            gen.writeStringField('error_description','CONSTRAIN can not be NULL.' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
    }
}