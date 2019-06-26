@RestResource(urlMapping='/v1/open_close_cases')
global with sharing class all_cases 
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
    global static void getCases(String rm_email)
    {
        RestResponse response = RestContext.response;
        String base_url = URL.getSalesforceBaseUrl().toExternalForm();
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
            list<Case> all_open_cases = new list<Case>();
            list<Case> all_closed_cases = new list<Case>();
            list<Case> today_open_cases = new list<Case>();
            list<Case> today_closed_cases = new list<Case>();
            
            all_open_cases = [Select id, caseNumber, status, Subject, Contact.Name, Contact.Email, CreatedDate from case where status != 'Closed' AND owner.Email =: rm_email];
            all_closed_cases = [Select id, caseNumber, status, Subject, Contact.Name, Contact.Email, ClosedDate from case where status = 'Closed' AND owner.Email =: rm_email];
            today_open_cases = [Select id, caseNumber, status, Subject, Contact.Name, Contact.Email, CreatedDate from case where status != 'Closed' AND CreatedDate >=: System.today() AND owner.Email =: rm_email];
            today_closed_cases = [Select id, caseNumber, status, Subject, Contact.Name, Contact.Email, ClosedDate from case where status = 'Closed' AND ClosedDate >=: System.today() AND owner.Email =: rm_email];
            
            if(!CRUD.isAccessible(all_open_cases) && !CRUD.isAccessible(all_closed_cases) && !CRUD.isAccessible(today_open_cases) && !CRUD.isAccessible(today_closed_cases))
            {
                APPLICATION_EXCEPTION.notAccessible();
            }
            else
            {
            
            response.statusCode =200;
            JSONGenerator gen =  JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeNumberField('total_open_case', all_open_cases.size());
            gen.writeFieldName('total_open_case_data');
            gen.writeStartArray();
            for(Case toc : all_open_cases)
            {
                gen.writeStartObject();
                gen.writeStringField('caseNumber', toc.CaseNumber);
                if(String.isBlank(toc.Subject))
                {
                    gen.writeNullField('caseSubject');
                }
                else{
                    gen.writeStringField('caseSubject', toc.Subject);
                }
                if(String.isBlank(toc.Status))
                {
                    gen.writeNullField('caseStatus');
                }
                else{
                    gen.writeStringField('caseStatus', toc.Status);
                }
                
                if(String.isBlank(toc.contact.Name))
                {
                    gen.writeNullField('contactName');
                }
                else{
                    gen.writeStringField('contactName', toc.Contact.Name);
                }
                
                if(String.isBlank(toc.contact.Email))
                {
                    gen.writeNullField('contactEmail');
                }
                else{
                    gen.writeStringField('contactEmail', toc.Contact.Email);
                }
                
                gen.writeStringField('classic_URL', base_url + '/' + toc.Id);
                gen.writeStringField('lightning_URL', base_url + '/one/one.app?source=aloha#/sObject/'+ toc.Id);
                gen.writeDateTimeField('dateTimeOpened', toc.CreatedDate);
                gen.writeEndObject();
            }
            gen.writeEndArray();
            
            gen.writeNumberField('total_close_case', all_closed_cases.size());
            gen.writeFieldName('total_close_case_data');
            gen.writeStartArray();
            for(Case tcc : all_closed_cases)
            {
                gen.writeStartObject();
                gen.writeStringField('caseNumber', tcc.CaseNumber);
                if(String.isBlank(tcc.Subject))
                {
                    gen.writeNullField('caseSubject');
                }
                else{
                    gen.writeStringField('caseSubject', tcc.Subject);
                }
                if(String.isBlank(tcc.Status))
                {
                    gen.writeNullField('caseStatus');
                }
                else{
                    gen.writeStringField('caseStatus', tcc.Status);
                }
                
                if(String.isBlank(tcc.contact.Name))
                {
                    gen.writeNullField('contactName');
                }
                else{
                    gen.writeStringField('contactName', tcc.contact.Name);
                }
                if(String.isBlank(tcc.contact.Email))
                {
                    gen.writeNullField('contactEmail');
                }
                else{
                    gen.writeStringField('contactEmail', tcc.Contact.Email);
                }
                gen.writeStringField('classic_URL', base_url + '/' + tcc.Id);
                gen.writeStringField('lightning_URL', base_url + '/one/one.app?source=aloha#/sObject/'+ tcc.Id);
                gen.writeDateTimeField('dateTimeClosed', tcc.ClosedDate);
                gen.writeEndObject();
            }
            gen.writeEndArray();
            
            gen.writeNumberField('total_open_case_today', today_open_cases.size());
            gen.writeFieldName('open_case_today_data');
            gen.writeStartArray();
            for(Case tdoc : today_open_cases)
            {
                gen.writeStartObject();
                gen.writeStringField('caseNumber', tdoc.CaseNumber);
                if(String.isBlank(tdoc.Subject))
                {
                    gen.writeNullField('caseSubject');
                }
                else{
                    gen.writeStringField('caseSubject', tdoc.Subject);
                }
                if(String.isBlank(tdoc.Status))
                {
                    gen.writeNullField('caseStatus');
                }
                else{
                    gen.writeStringField('caseStatus', tdoc.Status);
                }
                
                if(String.isBlank(tdoc.contact.Name))
                {
                    gen.writeNullField('contactName');
                }
                else{
                    gen.writeStringField('contactName', tdoc.contact.Name);
                }
                if(String.isBlank(tdoc.contact.Email))
                {
                    gen.writeNullField('contactEmail');
                }
                else{
                    gen.writeStringField('contactEmail', tdoc.Contact.Email);
                }
                gen.writeStringField('classic_URL', base_url + '/' + tdoc.Id);
                gen.writeStringField('lightning_URL', base_url + '/one/one.app?source=aloha#/sObject/'+ tdoc.Id);
                gen.writeDateTimeField('dateTimeOpened', tdoc.CreatedDate);
                gen.writeEndObject();
            }
            gen.writeEndArray();
            
            gen.writeNumberField('total_close_case_today', today_closed_cases.size());
            gen.writeFieldName('close_case_today_data');
            gen.writeStartArray();
            for(Case tdcc : today_closed_cases)
            {
                gen.writeStartObject();
                gen.writeStringField('caseNumber', tdcc.CaseNumber);
                if(String.isBlank(tdcc.Subject))
                {
                    gen.writeNullField('caseSubject');
                }
                else{
                    gen.writeStringField('caseSubject', tdcc.Subject);
                }
                if(String.isBlank(tdcc.Status))
                {
                    gen.writeNullField('caseStatus');
                }
                else{
                    gen.writeStringField('caseStatus', tdcc.Status);
                }
                
                if(String.isBlank(tdcc.contact.Name))
                {
                    gen.writeNullField('contactName');
                }
                else{
                    gen.writeStringField('contactName', tdcc.contact.Name);
                }
                if(String.isBlank(tdcc.contact.Email))
                {
                    gen.writeNullField('contactEmail');
                }
                else{
                    gen.writeStringField('contactEmail', tdcc.Contact.Email);
                }
                gen.writeStringField('classic_URL', base_url + '/' + tdcc.Id);
                gen.writeStringField('lightning_URL', base_url + '/one/one.app?source=aloha#/sObject/'+ tdcc.Id);
                gen.writeDateTimeField('dateTimeClosed', tdcc.ClosedDate);
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