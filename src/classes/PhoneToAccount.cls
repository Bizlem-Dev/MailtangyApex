@RestResource(urlMapping='/v1/phone')
global with sharing class PhoneToAccount
{
    @HttpPost
    global static void getAcc(String phone)
    {
        list<Account> acc = new list<Account>();
        list<Contact> con = new list<Contact>();
        
        RestResponse response = RestContext.response;
        try
        {
            if(String.isBlank(phone))
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','invalid data.' );
                gen.writeStringField('error_description','Phone number is required.' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString); 
            }
            else if(String.valueOf(phone).length()>10 || String.valueOf(phone).length()<10)
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','Invalid Phone Number' );
                gen.writeStringField('error_description','Given phone number is invalid' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString); 
            }
            else
            {
                String acphone = String.valueOf(phone);
                acc = [select id, Name, Phone from Account where Phone  =:acphone];
                con = [select id, Name from Contact where Phone =: acphone OR MobilePhone =: acphone OR HomePhone =: acPhone];
                if(!CRUD.isAccessible(acc) && !crud.isAccessible(con))
                {
                    APPLICATION_EXCEPTION.notAccessible();
                }
                else
                {
                if(acc.size() == 0 && con.size() == 0)
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('message','No relevant data found.' );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString); 
                }
                else
                {
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    
                    if(acc.size() == 0)
                    {
                        gen.writeStringField('contact_name', con[0].Name);
                        gen.writeStringField('contactId', con[0].id);
                    }
                    else if(con.size() == 0)
                    {
                        gen.writeStringField('account_name', acc[0].Name);
                        gen.writeStringField('accountId', acc[0].id);
                    }
                    
                    else
                    {
                        gen.writeStringField('account_name', acc[0].Name);
                        gen.writeStringField('accountId', acc[0].id);
                        gen.writeStringField('contact_name', con[0].Name);
                        gen.writeStringField('contactId', con[0].id);
                    }
                    
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString); 
                }
                }
            }
        }
        catch(Exception ex)
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','Exception' );
            gen.writeStringField('error_description',''+ex.getMessage() );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString); 
        }
    }
}