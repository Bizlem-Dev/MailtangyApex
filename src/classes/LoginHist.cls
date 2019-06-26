@RestResource(urlMapping='/v1/getLogin_History')
global with sharing class LoginHist 
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
    global static void getHistory(String email)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        if(String.isBlank(email))
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
        
        else if(!validateEmail(email))
        {
            System.debug('wrongFormat');
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','Wrong Email' );
            gen.writeStringField('error_description','Email is not in correct format.' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);   
            
        }
        else if(String.isNotBlank(email))
        {
            try
            {
                list<USER> usr = new list<USER>();
                usr = [SELECT id, email from USER where email =: email];
                if(!CRUD.isAccessible(usr))
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
                    else if(usr.size()>0)
                    {
                        list<LoginHistory> lh = new list<LoginHistory>();
                        lh = [SELECT Application,Browser,CountryIso,LoginTime,LoginType,Platform,SourceIp,Status,UserId FROM LoginHistory where userId =:usr[0].id];
                        JSONGenerator gen= JSON.createGenerator(true);
                        
                        gen.writeStartObject();
                        gen.writeFieldName('login_history');
                        gen.writeStartArray();
                        for(LoginHistory lh1: lh)
                        {
                            gen.writeStartObject();
                            gen.writeStringField('Application',''+ lh1.Application);
                            gen.writeStringField('Browser', ''+lh1.Browser);
                            gen.writeStringField('CountryIso', lh1.CountryIso);
                            gen.writeDateTimeField('LoginTime', lh1.LoginTime);
                            gen.writeStringField('Platform', lh1.Platform);
                            gen.writeStringField('Source_IP', lh1.sourceIP);
                            gen.writeEndObject();     
                        }
                        gen.writeEndArray();
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
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
        
        
    }
    
}