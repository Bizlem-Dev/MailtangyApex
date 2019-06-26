@RestResource(urlMapping='/v1/tagger')
global with sharing class TaggerApi
{
    static String gEmail = '';
    static String gSubject = '';
    Static String cId = '';
    Static String aId = '';
    Static RestResponse response = RestContext.response;
    
    @HttpPost
    global static void getTagger(String email, String subject)
    {
        RestRequest request = RestContext.request;
        
        
        String casequery = 'SELECT id, ownerId, caseNumber, email__c, subject,status FROM CASE ';
        String leadquery = 'SELECT id, ownerId, Lead_No__c, title FROM Lead ';
        String accountquery = 'SELECT id from ACCOUNT ';
        String contactquery = 'SELECT id from Contact ';
        
        String casecond = '';
        String emailcond = '';
        String Accountcond = '';
        String Leadcond = '';
        
        Boolean check=false;
        Map<String, Object> results = request.params;
        
        
        String lemail=String.valueOf(email);
        String lsubject=String.valueOf(subject);
        
        gemail = lemail;
        gsubject = lsubject;
        
        if(String.isNotBlank(email) && String.isNotBlank(subject))
        {
            //Leadcond+='AND email=\''+lemail+'\' AND Description=\''+lsubject+'\' ';
            Leadcond += 'AND email=\''+lemail+'\' '; 
            emailcond += 'AND email=\''+lemail+'\' '; 
            accountCond += 'AND Email__c=\''+lemail+'\' ';            
            check=true;
        }
        else        //required parameters value missing
        {
            response.statusCode=400;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('error','invalid_request' );
            gen.writeStringField('error_description','required parameters value(s) is(are) missing' );
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
        
        
        
        if(check)
        {
            try
            {
                Leadcond = Leadcond.replaceFirst('AND', 'WHERE');
                emailcond = emailcond.replaceFirst('AND', 'WHERE');
                Accountcond = Accountcond.replaceFirst('AND', 'WHERE');
                
                //Contact Data
                Contactquery += emailcond;
                list<Contact> cont = new list<Contact>();
                cont = Database.query(Contactquery);
                
                
                //Account Data
                    Accountcond = Accountcond.replaceFirst('AND', 'WHERE');
                    Accountquery+=Accountcond;
                    list<Account> acc = new list<Account>();
                    acc = Database.query(Accountquery);
                    if(acc.size()>=1)
                    {
                        aId = acc[0].Id;
                    }
                
                if(cont.size()>=1)
                {
                    cId = cont[0].Id;
                    //CASE data
                    //casecond+='AND ContactId=\''+cont[0].ID+'\' AND subject=\''+lsubject+'\' ';
                    casecond+=' AND ContactId=\''+cont[0].Id+'\' ';
                    casecond = casecond.replaceFirst('AND', 'WHERE');
                    casequery+= casecond;
                    list<Case> c = new list<Case>();
                    c = Database.query(caseQuery);
                    if(c.size()>= 1)
                    {
                        list<Wrapcase> listwc = new list<Wrapcase>();
                        for(Case cc:c)
                        {
                            listwc.add(new Wrapcase(cc));
                            
                        }
                        String totalcase = String.valueOf(c.size());
                        JSONGenerator gen= JSON.createGenerator(true);
                        
                        gen.writeStartObject();
                        gen.writeStringField('ContactId', cont[0].Id);
                        gen.writeStringField('AccountId', aId);
                        gen.writeStringField('total_case', totalcase);      //CASE JSON creation
                        gen.writeFieldName('case_data');
                        gen.writeStartArray();
                        for(Wrapcase wc1: listwc)
                        {
                            gen.writeStartObject();
                            gen.writeStringField('caseID',''+ wc1.cc.ID);
                            gen.writeStringField('ownerId', ''+wc1.cc.ownerId);
                            gen.writeStringField('caseNumber', String.valueOf(wc1.cc.CaseNumber));
                            gen.writeStringField('caseSubjectMatch', String.valueOf(wc1.csmatch));
                            gen.writeStringField('status', String.valueOf(wc1.cc.status));
                            gen.writeEndObject();     
                        }
                        gen.writeEndArray();
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                    else
                    {
                        String jsonString = leadData(leadquery,LeadCond);  
                        response.responseBody=blob.valueOf(jsonString);
                    }
                }
                else
                {
                    String jsonString = leadData(leadquery,LeadCond);  
                    response.responseBody=blob.valueOf(jsonString);    
                }
                
                
                
                
            }
            catch(Exception ex)
            {
                if(ex.getTypeName() == 'System.ListException')      //no account/no contact
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','invalid_request' );
                    gen.writeStringField('error_description','For this Email there is no account/contact.' );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
                
                else
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','invalid_request' );
                    gen.writeStringField('error_description',''+ex );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
            }
        }
        
    }
    public Static String leadData(String leadquery, String LeadCond)
    {
        //LEADS data
        leadquery+= Leadcond;
        list<Lead> l = new list<Lead>();
        l = Database.query(leadQuery);
        if(l.size()>=1)
        {    
            list<Wraplead> listwl = new list<Wraplead>();
                        for(Lead ll:l)
                        {
                            listwl.add(new Wraplead(ll));
                            
                        }
            JSONGenerator gen= JSON.createGenerator(true);    
            gen.writeStartObject();
            gen.writeStringField('ContactId', ''+cId);
            gen.writeStringField('AccountId', aId);
            gen.writeStringField('total_leads',String.valueOf(l.size()));
            gen.writeFieldName('leads_data');
            gen.writeStartArray();
            for(Wraplead wc1: listwl)
                        {   
                            /*
                            gen.writeStartObject();
                            gen.writeStringField('caseID',''+ wc1.cc.ID);
                            gen.writeStringField('ownerId', ''+wc1.cc.ownerId);
                            gen.writeStringField('caseNumber', String.valueOf(wc1.cc.CaseNumber));
                            gen.writeStringField('caseSubjectMatch', String.valueOf(wc1.csmatch));
                            gen.writeStringField('status', String.valueOf(wc1.cc.status));
                            gen.writeEndObject();     
                            */
                            gen.writeStartObject();
                            gen.writeStringField('LeadId',''+ wc1.ll.ID);
                            gen.writeStringField('Lead_No', wc1.ll.Lead_No__c);
                            gen.writeStringField('LeadSubjectMatch', String.valueOf(wc1.csmatch));
                            gen.writeStringField('LeadownerId', ''+wc1.ll.ownerId);
                            gen.writeEndObject();    
                        }
            /*          
            for(Lead l1: l)
            {
                gen.writeStartObject();
                gen.writeStringField('LeadId',''+ l1.ID);
                gen.writeStringField('Lead_No', l1.Lead_No__c);
                gen.writeStringField('LeadownerId', ''+l1.ownerId);
                gen.writeEndObject();     
            }
            */
            gen.writeEndArray();
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            return jsonString;
        }
        else
        {
            response.statusCode = 200;
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('ContactId', ''+cId);
            gen.writeStringField('AccountId', aId);
            gen.writeStringField('total_leads','0' );
            gen.writeFieldName('leads_data');
            gen.writeStartArray();
            gen.writeEndArray();
            gen.writeStringField('total_case','0' );
            gen.writeFieldName('case_data');
            gen.writeStartArray();
            gen.writeEndArray();
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            return jsonString;
        }
    }
    
    public class wrapCase {
        public CASE cc;
        public Integer csmatch;
        
        public wrapCase(CASE c) {
            cc = c;
            if( c.subject == gsubject )
            {
                csmatch = 1;
            }
            else{
                csmatch = 0;
            }
        }
    }
    public class wrapLead {
        public LEAD ll;
        public Integer csmatch;
        
        public wrapLead(LEAD l) {
            ll = l;
            if( l.title == gsubject )
            {
                csmatch = 1;
            }
            else{
                csmatch = 0;
            }
        }
    }
}