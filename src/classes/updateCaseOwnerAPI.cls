@RestResource(urlMapping='/v1/updateCaseOwner')
global with sharing class updateCaseOwnerAPI 
{
    
    public static Boolean validateEmail(String email) {			//validate email method
        Boolean res = true;
        
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; 		//Email validation
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        
        if (!MyMatcher.matches()) 
            res = false;
        return res;  
    }
    @HttpPost
    global static void getTagger(String email, String case_no)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        String casenumber = String.valueOf(case_no);
        
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
        else if(String.isNotBlank(email) && String.isNotBlank(casenumber))
        {
            try{
                list<USER> usr = new list<USER>();
                usr = [SELECT id, email from USER where email =: email];
                
                list<CASE> cse =  new list<CASE>();
                cse = [SELECT id,caseNumber from CASE where caseNumber =:casenumber];
                
                if(!CRUD.isAccessible(usr) && !CRUD.isAccessible(cse))
                {
                    APPLICATION_EXCEPTION.notAccessible();
                }
                else
                {
                    if(usr.size() == 0)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('error','Invalid Data' );
                        gen.writeStringField('error_description','For the given email there is no USER exist.' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    
                    if(cse.size() == 0)
                    {
                        response.statusCode=400;
                        JSONGenerator gen= JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('error','Invalid Data' );
                        gen.writeStringField('error_description','For the given case Number there is no CASE exist.' );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    
                    if(usr.size()>0 && cse.size()>0)
                    {
                        case cc = new case();
                        cc = [SELECT id, ownerId from CASE where id =: cse[0].id];  
                        
                        cc.OwnerId = usr[0].id;
                        
                        if(!CRUD.isUpdateable(cc))
                        {
                            APPLICATION_EXCEPTION.notUpdateable();
                        }
                        else
                        {
                            update cc;
                            
                            JSONGenerator gen= JSON.createGenerator(true);
                            gen.writeStartObject();
                            gen.writeStringField('message','the ownerId of caseNumber '+casenumber+' is sucessfuly updated.' );
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
                gen.writeStringField('error','Invalid Request' );
                gen.writeStringField('error_description',''+ex.getMessage() );
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
            gen.writeStringField('error','Required data missing' );
            gen.writeStringField('error_description','Some of the required data missing.' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
    }
}