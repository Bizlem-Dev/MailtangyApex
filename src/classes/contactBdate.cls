@RestResource(urlMapping='/v1/todayBday')
global with sharing class contactBdate 
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
    global static void getContactBday(String cemail)
    {
        list<Contact> con = new list<Contact>();
        RestResponse response = RestContext.response;
        try
        {
            if(String.isBlank(cemail))
            {
                
                Date d = System.today();
                con = [select id,AccountId, name,FirstName, LastName,Account.Name, Fax, HomePhone, MobilePhone ,Salutation , Email, Birthdate from Contact where CALENDAR_MONTH(Birthdate) =: d.month() AND DAY_IN_MONTH(Birthdate) =: d.day() ];
                if(!CRUD.isAccessible(con))
                {
                    APPLICATION_EXCEPTION.notAccessible();
                }
                else{
                    if(con.size() == 0)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('message','NO customer has birthday today' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    else
                    {
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeNumberField('No_of_Customers_have_birthday_today',con.size() );
                        gen.writeFieldName('Customers_Data');
                        gen.writeStartArray();
                        for(Contact c1: con)
                        {
                            gen.writeStartObject();
                            if(String.isBlank(c1.Name))
                            {
                                gen.writeNullField('Contact_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_Name',c1.Name);
                            }
                            
                            if(String.isBlank(c1.Salutation))
                            {
                                gen.writeNullField('Salutation');
                            }
                            else
                            {
                                gen.writeStringField('Salutation',c1.Salutation);
                            }
                            
                            if(String.isBlank(c1.FirstName))
                            {
                                gen.writeNullField('Contact_First_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_First_Name',c1.FirstName);
                            }
                            
                            if(String.isBlank(c1.LastName))
                            {
                                gen.writeNullField('Contact_Last_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_Last_Name',c1.LastName);
                            }
                            
                            if(String.isBlank(c1.AccountId))
                            {
                                gen.writeNullField('AccountId');
                            }
                            else
                            {
                                gen.writeStringField('AccountId',c1.AccountId);
                            }
                            
                            if(String.isBlank(c1.Account.Name))
                            {
                                gen.writeNullField('Account_Name');
                            }
                            else
                            {
                                gen.writeStringField('Account_Name',c1.Account.Name);
                            }
                            
                            if(String.isBlank(c1.HomePhone))
                            {
                                gen.writeNullField('Home_Phone');
                            }
                            else
                            {
                                gen.writeStringField('Home_Phone', c1.HomePhone);
                            }
                            
                            if(String.isBlank(c1.Fax))
                            {
                                gen.writeNullField('Fax_number');
                            }
                            else
                            {
                                gen.writeStringField('Fax_number', c1.Fax);
                            }
                            
                            if(String.isBlank(c1.MobilePhone))
                            {
                                gen.writeNullField('Mobile_Phone');
                            }
                            else
                            {
                                gen.writeStringField('Mobile_Phone', c1.MobilePhone);
                            }
                            
                            if(String.isBlank(c1.Email))
                            {
                                gen.writeNullField('Email');
                            }
                            else
                            {
                                gen.writeStringField('Email', c1.Email);
                            }
                            
                            gen.writeDateField('Birthdate', c1.Birthdate);
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
                if(!validateEmail(cemail))
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
                else{
                    Date d = System.today();
                    con = [select id,AccountId, name,FirstName, LastName,Account.Name, Fax, HomePhone, MobilePhone ,Salutation , Email, Birthdate from Contact where CALENDAR_MONTH(Birthdate) =: d.month() AND DAY_IN_MONTH(Birthdate) =: d.day() AND email =: cemail];
                    if(!CRUD.isAccessible(con))
                    {
                        APPLICATION_EXCEPTION.notAccessible();
                    }
                    else{
                    if(con.size() == 0)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('message','There is no relevant data.' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    else
                    {
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeNumberField('No of Customers have birthday today',con.size() );
                        gen.writeFieldName('Customers_Data');
                        gen.writeStartArray();
                        for(Contact c1: con)
                        {
                            gen.writeStartObject();
                            if(String.isBlank(c1.Name))
                            {
                                gen.writeNullField('Contact_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_Name',c1.Name);
                            }
                            
                            if(String.isBlank(c1.Salutation))
                            {
                                gen.writeNullField('Salutation');
                            }
                            else
                            {
                                gen.writeStringField('Salutation',c1.Salutation);
                            }
                            
                            if(String.isBlank(c1.FirstName))
                            {
                                gen.writeNullField('Contact_First_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_First_Name',c1.FirstName);
                            }
                            
                            if(String.isBlank(c1.LastName))
                            {
                                gen.writeNullField('Contact_Last_Name');
                            }
                            else
                            {
                                gen.writeStringField('Contact_Last_Name',c1.LastName);
                            }
                            
                            if(String.isBlank(c1.AccountId))
                            {
                                gen.writeNullField('AccountId');
                            }
                            else
                            {
                                gen.writeStringField('AccountId',c1.AccountId);
                            }
                            
                            if(String.isBlank(c1.Account.Name))
                            {
                                gen.writeNullField('Account_Name');
                            }
                            else
                            {
                                gen.writeStringField('Account_Name',c1.Account.Name);
                            }
                            
                            if(String.isBlank(c1.HomePhone))
                            {
                                gen.writeNullField('Home_Phone');
                            }
                            else
                            {
                                gen.writeStringField('Home_Phone', c1.HomePhone);
                            }
                            
                            if(String.isBlank(c1.Fax))
                            {
                                gen.writeNullField('Fax_number');
                            }
                            else
                            {
                                gen.writeStringField('Fax_number', c1.Fax);
                            }
                            
                            if(String.isBlank(c1.MobilePhone))
                            {
                                gen.writeNullField('Mobile_Phone');
                            }
                            else
                            {
                                gen.writeStringField('Mobile_Phone', c1.MobilePhone);
                            }
                            
                            gen.writeStringField('Email', c1.Email);
                            gen.writeDateField('Birthdate', c1.Birthdate);
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
        catch(Exception ex)
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error', 'invalid request');
            gen.writeStringField('error_description',ex.getMessage());
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
    }
}