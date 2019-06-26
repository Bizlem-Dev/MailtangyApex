@RestResource(urlMapping='/api/MailtangyEmailQueue/*')
global with sharing class MailtangyEmailQueueRestAPI
{
    public String mongodb_Id,source,to,frm,typ,subject,seen,receiveddate,messagebody,attachfiles,attachpath,auto_nlp_reply,replies,fetcher_Output,nlp_Output,sentiment_Output,summerizer_Output,lead_OwnerId,leadId,lead_No,case_OwnerId,caseId,contact_id,account_id,case_no,flag,parameter_1,parameter_2,parameter_3,parameter_4,parameter_5;
    
    public static MailtangyEmailQueueRestAPI parse(String jsonString) 
    {
        return (MailtangyEmailQueueRestAPI)JSON.deserialize(jsonString, MailtangyEmailQueueRestAPI.class);
    }
    
    @HttpGet
    global static List<Mailtangy_Email_Queue__c> GetMailtangyEmailQueuelist() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String recId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        // List<Mailtangy_Email_Queue__c> result = [SELECT Id, Name FROM Mailtangy_Email_Queue__c];
        
        // for now 
        List<Mailtangy_Email_Queue__c> result = [SELECT Id, Name FROM Mailtangy_Email_Queue__c limit 1000];
        if(!CRUD.isAccessible(result))
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
            return null;
        }
        else
        {  
            return result;
        }
    }
    
    @HttpDelete
    global static void deleteMailtangyEmailQueue() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String recId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Mailtangy_Email_Queue__c result = [SELECT Id, Name FROM Mailtangy_Email_Queue__c WHERE Id = :recId ];
        
        //delete result;
        // Check if the user has delete access on the Mailtangy_Email_Queue object
        if (!Mailtangy_Email_Queue__c.sObjectType.getDescribe().isDeletable()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
            // return null;
        }
        else{
            delete result;
        }
        
        
    }
    
    @HttpPost
    // global static void PostMailtangyEmailQueue(String data) 
    global static void doPost() 
    {
        RestResponse response = RestContext.response;
        response.addHeader('content-type' ,'Application/Json' );
        
        string jsonStr='';
        if (null != RestContext.request.requestBody) {
            jsonStr = RestContext.request.requestBody.toString();
        }
        if(jsonStr!='')
        {
            try
            {
                MailtangyEmailQueueRestAPI result = MailtangyEmailQueueRestAPI.parse(jsonStr);
                System.debug(result);
                Mailtangy_Email_Queue__c MEQ=new Mailtangy_Email_Queue__c();
                MEQ.source__c=result.source;
                MEQ.mongodb_Id__c=result.mongodb_Id;
                MEQ.to__c=result.to;
                MEQ.From__c=result.frm;
                MEQ.Type__c=result.typ;
                MEQ.Subject__c=result.subject;
                MEQ.Seen__c=result.seen;
                
                //convert  string to datetime
                
                String rcDate  = result.receiveddate;
                
                //String dateInString = DateTime.parse(rcDate);
                MEQ.Received_Date__c=Datetime.parse(rcDate);
                MEQ.Messagebody__c=result.messagebody;
                MEQ.Attachfiles__c=result.attachfiles;
                MEQ.Attachpath__c=result.attachpath;
                MEQ.Auto_Nlp_Reply__c=result.auto_nlp_reply;
                MEQ.Replies__c=result.replies;
                MEQ.Fetcher_Output__c=result.fetcher_Output;
                MEQ.Nlp_Output__c=result.nlp_Output;
                MEQ.Sentiment_Output__c=result.sentiment_Output;
                MEQ.Summerizer_Output__c=result.summerizer_Output;
                MEQ.Lead_OwnerId__c=result.lead_OwnerId;
                MEQ.Lead__c=result.leadId;
                MEQ.Lead_No__c=result.lead_No;
                MEQ.Case_OwnerId__c=result.case_OwnerId;
                MEQ.Case_Id__c=result.caseId;
                MEQ.Contact_Id__c=result.contact_id;
                MEQ.Account_Id__c=result.account_id;
                MEQ.Case_No__c=result.case_no;
                MEQ.Flag__c=result.flag;
                MEQ.Parameter_1__c=result.parameter_1;
                MEQ.Parameter_2__c=result.parameter_2;
                MEQ.Parameter_3__c=result.parameter_3;
                MEQ.Parameter_4__c=result.parameter_4;
                MEQ.Parameter_5__c=result.parameter_5;
                
                
                //insert MEQ;
                //response.statusCode = 200;
                //response.responseBody = Blob.valueOf('{"result" : "success","data":"{"RecordId":"'+MEQ.Id+'"}"}');
                
                // New Code
                if(CRUD.isCreateable(MEQ)){
                    insert MEQ;
                    response.statusCode = 200;
                    response.responseBody = Blob.valueOf('{"result" : "success","data":"{"RecordId":"'+MEQ.Id+'"}"}');
                }else{
                    //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Insufficient Access'));
                    response.statusCode = 200;
                    response.responseBody = Blob.valueOf('{"result" : "success","data":"{"RecordId":"Insufficient Access"}"}');
                }
                
                
                
            }catch(Exception e){
                response.statusCode = 501;
                response.responseBody = Blob.valueOf('{"result" : "Error","Message":"'+e.getMessage()+'"}');
            }
            
        } else{
            response.statusCode = 404;
            response.responseBody = Blob.valueOf('{"result" : "Error","Message":Invalid Request""}');
        }       
    }
}