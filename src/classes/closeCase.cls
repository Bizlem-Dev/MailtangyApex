@RestResource(urlMapping='/v1/closecase')
global with sharing class closeCase 
{
    @HttpPost
    global static void close(String casenumber,string reason )
    {
        RestResponse response = RestContext.response;
        try{
            
            if(String.isBlank(casenumber))
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','Case Number is empty' );
                gen.writeStringField('error_description','Please enter a case number you want to close' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);
            }
            else if(String.isBlank(reason))
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','No Reason' );
                gen.writeStringField('error_description','Please enter a reason to close the case' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);            
            }
            else
            {
                list<case> c=new list<case>();
                c=[select id from case where CaseNumber =:casenumber];
                if(!CRUD.isAccessible(c))
                {
                    APPLICATION_EXCEPTION.notAccessible();
                }
                else
                {
                    if(c.size()<1)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('error','No case found' );
                        gen.writeStringField('error_description','Please enter a valid case number' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    else
                    {
                        c[0].status='Closed';
                        c[0].Reason_for_closing_the_case__c=reason;
                        
                        if(!CRUD.isUpdateable(c[0]))
                        {
                            APPLICATION_EXCEPTION.notCreateable();
                        }
                        else
                        {
                        update c[0];
                        response.statusCode=200;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('message','Case closed and reason saved successfully' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                        }
                    }
                }
            }
        }
        catch(exception ex)
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