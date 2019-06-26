@IsTest
private class MailtangyEmailQueueRestAPITest {

    @isTest static void testGetDataById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ap5.salesforce.com/services/apexrest/api/MailtangyEmailQueue/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        List<Mailtangy_Email_Queue__c> MEQLst= MailtangyEmailQueueRestAPI.GetMailtangyEmailQueuelist();
        // Verify results
        System.assert(MEQLst!= null);
    }

    @isTest static void testDeleteCase() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ap5.salesforce.com/services/apexrest/api/MailtangyEmailQueue/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        MailtangyEmailQueueRestAPI.deleteMailtangyEmailQueue();
        // Verify record is deleted
        List<Mailtangy_Email_Queue__c > MEQ= [SELECT Id FROM Mailtangy_Email_Queue__c  WHERE Id=:recordId];
        System.assert(MEQ.size() == 0);
    }

    @isTest static void testCreateData() {
        String reqData='{ "mongodb_Id" :  "5a55cbc48bc65294632ab016", "source":"gmail",  "to":  "ghanshyamgupta446@gmail.com", "from": "Akhilesh Yadav <akhilesh@bizlem.com>", "subject": "I want to know the prize of Intruder!", "seen":  "0",  "receiveddate" :  "10/14/2011 11:46 AM", "messagebody" : "", "attachfiles" : "true", "attachpath" : "", "auto_nlp_reply" : "NO", "replies" : "", "fetcher_Output" : "", "nlp_Output" : "", "sentiment_Output" : "Text", "summerizer_Output" : "Text", "lead_OwnerId" : "0057F000001VppsQAC", "leadId" : "00Q7F000002jKls", "lead_No" : "L-26", "case_OwnerId" : "0057F000001VppsQAC", "caseId" : "5007F00000ApSNi", "contact_id" : "0037F00000F0WjzQAF", "account_id" : "0017F00000JfNHzQAN", "case_no" : "00001129", "flag" : "1", "parameter_1" : "text", "parameter_2" : "text", "parameter_3" : "text", "parameter_4" : "text", "parameter_5" : "text"  }';
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri =
            'https://ap5.salesforce.com/services/apexrest/api/MailtangyEmailQueue/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(reqData);
        RestContext.request = request;
        RestContext.response = res;
    
        // Update status of existing record to Working
        MailtangyEmailQueueRestAPI.doPost();
        // Verify record was updated
        List<Mailtangy_Email_Queue__c > MEQ= [SELECT Id FROM Mailtangy_Email_Queue__c Limit 1];
        if(res.responseBody == Blob.valueOf('{"result" : "success","data":"{"RecordId":"Insufficient Access"}"}')){
            System.assert(MEQ.size()==0);
        }
        else{
            System.assert(MEQ.size()==1);
        }
    }  

    // Helper method
    static Id createTestRecord() {
        // Create test record
        Mailtangy_Email_Queue__c MEQ= new Mailtangy_Email_Queue__c();
        insert MEQ;
        return MEQ.Id;
    }          
    
}