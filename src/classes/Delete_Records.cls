@RestResource(urlMapping='/v1/delete_records')
global with sharing class Delete_Records 
{
    
    @HttpPost
    global static void delRec(String type, String type_IdORtype_No)
    {
        RestResponse response = RestContext.response;
        
        try
        {
            if(String.isBlank(type) || String.isBlank(type_IdORtype_No))
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','Missing data' );
                gen.writeStringField('error_description','Required parameters data are missing or blank.' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);
            }
            else
            {
                if(type.equalsIgnoreCase('case'))
                {
                    list<Case> lstcase = new list<case>();
                    lstcase = [SELECT Id, CaseNumber from Case where CaseNumber =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstcase))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else{
                        if(lstCase.size()>0)
                        {
                            if(!crud.isDeletable(lstCase[0]))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else
                            {
                                delete lstCase[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                }
                else if(type.equalsIgnoreCase('lead'))
                {
                    list<Lead> lstlead = new list<Lead>();
                    lstlead = [SELECT Id, Lead_No__c from Lead where Lead_No__c =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstlead))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else
                    {
                        if(lstlead.size()>0)
                        {
                            if(!CRUD.isDeletable(lstlead))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else{
                                delete lstlead[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                    
                }
                else if(type.equalsIgnoreCase('contact'))
                {
                    list<Contact> lstContact = new list<Contact>();
                    lstContact = [SELECT Id from Contact where Id =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstContact))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else
                    {
                        if(lstContact.size()>0)
                        {
                            if(!crud.isDeletable(lstContact[0]))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else
                            {
                                delete lstContact[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                }
                else if(type.equalsIgnoreCase('account'))
                {
                    list<Account> lstAccount = new list<Account>();
                    lstAccount = [SELECT Id from Account where Id =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstAccount))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else
                    {
                        if(lstAccount.size()>0)
                        {
                            if(!CRUD.isDeletable(lstAccount[0]))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else
                            {
                                delete lstAccount[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                }
                else if(type.equalsIgnoreCase('task'))
                {
                    list<Task> lstTask = new list<Task>();
                    lstTask = [SELECT Id from Task where Id =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstTask))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else
                    {
                        if(lstTask.size()>0)
                        {
                            if(!CRUD.isDeletable(lstTask[0]))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else
                            {
                                delete lstTask[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
                            gen.writeEndObject();
                            String jsonString = gen.getAsString();
                            response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                }
                else if(type.equalsIgnoreCase('opportunity'))
                {
                    list<Opportunity> lstOpp = new list<Opportunity>();
                    lstOpp = [SELECT Id from Opportunity where Id =: type_IdORtype_No];
                    if(!CRUD.isAccessible(lstOpp))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else
                    {
                        if(lstOpp.size()>0)
                        {
                            if(!CRUD.isDeletable(lstOpp[0]))
                            {
                                APPLICATION_EXCEPTION.notDeleteable();
                            }
                            else
                            {
                                delete lstOpp[0];
                                JSONGenerator gen= JSON.createGenerator(true);
                                gen.writeStartObject();
                                gen.writeStringField('message', 'The record of type '+type+' with id/no '+type_IdORtype_No+' is deleted sucessfully.');
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
                            gen.writeStringField('error','No record');
                            gen.writeStringField('error_description','there is no record of type '+type+' with the given id/no.');
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
                    gen.writeStringField('error','invalid type' );
                    gen.writeStringField('error_description','type parameter is not correct.' );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
            }
        }
        Catch(Exception ex)
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','Exception found');
            gen.writeStringField('error_description',''+ex.getMessage());
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
    }
}