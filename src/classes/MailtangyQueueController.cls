public with sharing class MailtangyQueueController {
    
    public id selectedUserId {get;set;}
    public id selectedqueueId {get; set;}
    public string username{get; set;}
   // public List<SelectOption> queueList { get; set; }

    public List<MailQueue> lstMailQueue {get;set;}

    Public MailtangyQueueController()
    {
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        if(MyProflieName !='System Administrator'){
            selectedUserId=userinfo.getUserId();
            username=userinfo.getUserName();
        }
        getMailQueue();
       
    }
    public void getMailQueue(){
       lstMailQueue =new List<MailQueue>();
       List<Mailtangy_Email_Queue__c> lstMEQ = [SELECT Mongodb_Id__c,To__c,Contact_Id__c,Account_Id__c,Case_Id__c,Case_Id__r.Owner.name,Case_OwnerId__c,Case_No__c,Contact_Id__r.Name,Account_Id__r.Name,Case_Id__r.Status,Case_Id__r.Priority,Subject__c,Summerizer_Output__c,Sentiment_Output__c,Owner.Name,Received_Date__c FROM Mailtangy_Email_Queue__c where Flag__c!='1' order by Received_Date__c DESC ]; 
       for(Mailtangy_Email_Queue__c MEQ:lstMEQ ){
           lstMailQueue.add(new MailQueue(MEQ,false));
       }
    }
    public class MailQueue{
        public Mailtangy_Email_Queue__c  MEQ{get;set;}
        public Boolean selected{get;set;}
        public MailQueue(Mailtangy_Email_Queue__c  e,Boolean b) {
            MEQ=e;
            selected=b;
        }
    }
   /* public List<Mailtangy_Email_Queue__c>  getMailtangyEmailList(){
        lstMailQueue = [SELECT Case_No__c,Contact_Id__r.Name,Account_Id__r.Name,Subject__c,Summerizer_Output__c,Sentiment_Output__c,Owner.Name,Received_Date__c FROM Mailtangy_Email_Queue__c Limit 5];
        return null;
    }*/
    
   // public List<> facilities {set; get;}
   // public Facility__c facility {get;set;}
   
   public void saveRecord(){
       if(selectedUserId==null ){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select User'));
           return;
       }
       else{
           List<Id> lstId=new List<Id>();
           Date currDate=Date.today();
           List<Mailtangy_Email_Queue__c > lstMEQ=new List<Mailtangy_Email_Queue__c>();
           List<Mailtangy_Queue_History__c> lstMQH=new List<Mailtangy_Queue_History__c>();
           List<Case> lstCase=new List<case>();
           for(MailQueue MQ:lstMailQueue ){
               if(MQ.selected==true && MQ.MEQ.Case_Id__c!=null){
                   // insert history
                   Mailtangy_Queue_History__c MQH=new Mailtangy_Queue_History__c();
                   MQH.Case_No__c=MQ.MEQ.Case_No__c;
                   MQH.Current_Owner__c=selectedUserId;
                   MQH.Previous_Owner__c=MQ.MEQ.Case_OwnerId__c;
                   MQH.Date__c=currDate;
                   MQH.Mailtangy_Email_Queue__c=MQ.MEQ.Id;
                   lstMQH.add(MQH);
                   
                   // update MEQ data
                   MQ.MEQ.Case_OwnerId__c=selectedUserId;
                   MQ.MEQ.Flag__c='1';
                   lstId.add(MQ.MEQ.Id);
                   
                   //update case owner
                   Case c=new Case();
                   c.id=MQ.MEQ.Case_Id__c;
                   c.ownerId=selectedUserId;
                   lstCase.add(c);
                   
                   // update data in API
                   lstMEQ.add(MQ.MEQ);
               }
           
           }
           if(lstMEQ.size()>0){
             //  update lstMEQ;
             if(CRUD.isUpdateable(lstMEQ)){
                        update lstMEQ;
           }
            //   update lstCase;
            if(CRUD.isUpdateable(lstCase)){
                        update lstCase;
           }
               //insert lstMQH;
               //updateInMongo(lstId);
               if(CRUD.isCreateable(lstMQH)){
                        insert lstMQH;
                        updateInMongo(lstId);
                }else{
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Insufficient Access'));
                        return;
                }
               
           }
           else{
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select at least one record'));
               return;
           }
       }
        getMailQueue();
  
   }
 @Future(callout=true)
 public static void updateInMongo(List<Id> lstId){
     List<Mailtangy_Email_Queue__c > lstMEQ=[SELECT Mongodb_Id__c,To__c,Contact_Id__c,Account_Id__c,OwnerId,Case_No__c,Contact_Id__r.Name,Account_Id__r.Name,Case_Id__r.Status,Case_Id__r.Priority from Mailtangy_Email_Queue__c  where id in :lstId];
     for(Mailtangy_Email_Queue__c MEQ : lstMEQ){
        string body='{';
        body+='"mongoId":"'+MEQ.Mongodb_Id__c+'",';
        body+='"to":"'+MEQ.to__c+'",';
        body+='"contactId":"'+MEQ.Contact_Id__c+'",';
        body+='"AccountId":"'+MEQ.Account_Id__c+'",';
        body+='"change_ownerId":"'+MEQ.OwnerId+'",';
        body+='"priority":"'+MEQ.Case_Id__r.Priority+'",';
        body+='"status":"'+MEQ.Case_Id__r.Status+'"';
        body+='}';
        
        system.debug('body : '+body);
        HttpRequest reqI = new HttpRequest();
        reqI.setEndpoint('http://35.199.31.225:8080/SFDC/updateToAndOwnerInReceiverInboxServlet');
        reqI.setMethod('POST');
        reqI.setTimeout(30000);
        reqI.setHeader('Content-Type', 'application/json');
        reqI.setBody(body);
        Http httpI = new Http();
        HTTPResponse resI;
        
        try 
        {
            //Execute web service call here     
            resI = httpI.send(reqI);  
            system.debug('Mogo API Res : '+resI.getbody());
        } catch(Exception e) 
        {
           //throw e;
           system.debug('Error in Mogo API : '+e);
        }

     } 
    
 }
 public List<SelectOption> getselectValues1() 
 {

      List<SelectOption> options = new List<SelectOption>(); 
//            for (QueueSobject  q : [Select q.SobjectType, q.Id From QueueSobject q])
            // for now
            for (QueueSobject  q : [Select q.SobjectType, q.Id From QueueSobject q limit 1000])
            {
            options.add(new SelectOption(q.SobjectType,q.SobjectType)); 
            }
            return options;
 }
    
     public SelectOption[] getselectValues(){
      return New SelectOption[]{
            New SelectOption('Mother','Mother'),
            New SelectOption('Sister','Sister'),
            New SelectOption('Father','Father')

      };
   }


    /****** First Section Code start ******/
    
    public List<SelectOption> GetqueueList(){
        system.debug('#### Inside##### list');
       List<id> Idlist=new List<id>(); 
        List<SelectOption> options= new List<SelectOption>(); 
        for(QueueSobject a :[Select q.QueueId from QueueSobject q where q.SobjectType=:'Case']){
            Idlist.add(a.QueueId);
        }
        system.debug('##### Queue SObject #### : '+Idlist);
        List<group> grouplist=[select id, name, Type from group where id IN: Idlist];
        system.debug('@@@@ Queue is : '+grouplist);
        options.add(new SelectOption('','--Select--'));
        for(Group gp:grouplist){
            //system.debug('Inside for loop');
            options.add(new SelectOption(gp.id,gp.name));
        }
        system.debug('###queueList## : '+options);
        return options;      
    }
   public list<QueueUsersCase> QueueUsersCaseList{get; set;}
    
    
   
   public List<QueueUsersCase> getuserlist() {
       system.debug('#### selected QueueId is : '+selectedqueueId);
        //if(QueueUsersCaseList == null) {
            QueueUsersCaseList = new List<QueueUsersCase>();
            List<Id> UserOrGroupId = new List<Id> ();
            For(GroupMember mm :[select UserOrGroupId From GroupMember where groupId =: selectedqueueId]){
                UserOrGroupId.add(mm.UserOrGroupId);
            }
            List<User> userlist=[select id, Name, Username from user where id IN:UserOrGroupId];
            system.debug('UserOrGroupId : '+UserOrGroupId);
            system.debug('User List is : '+userlist);
            for(User u: userlist) {
                QueueUsersCaseList.add(new QueueUsersCase(u));
            }
       
       
        //}
        return QueueUsersCaseList;
    }
    
    public List<SelectOption> GetUserddList()
    {
       // List<id> Idlist=new List<id>(); 
        List<SelectOption> optionsUser= new List<SelectOption>(); 
        
        
       /* List<Id> UserOrGroupId = new List<Id> ();
            For(GroupMember mm :[select UserOrGroupId From GroupMember]){
                UserOrGroupId.add(mm.UserOrGroupId);
            }
            List<User> userlist=[select id, Name, Username from user where id IN:UserOrGroupId];
            system.debug('UserOrGroupId : '+UserOrGroupId);
            system.debug('User List is : '+userlist);
         optionsUser.add(new SelectOption('','--Select--'));
            for(User u: userlist) {
                
                optionsUser.add(new SelectOption(u.id,u.username));
               
            }*/
            
        List<Id> UserOrGroupId = new List<Id> ();
        For(GroupMember mm :[select UserOrGroupId From GroupMember where groupId =: selectedqueueId]){
            UserOrGroupId.add(mm.UserOrGroupId);
        }
        optionsUser.add(new SelectOption('','--Select--'));
        List<User> userlist=[select id, Name, Username from user where id IN:UserOrGroupId];
        for(User u: userlist) {
            optionsUser.add(new SelectOption(u.id,u.username));
        }
       
        return optionsUser;
    }
    
    public PageReference onchange()
    {
        QueueUsersCaseList=getuserlist();
        //PageReference ref = new PageReference('/apex/MailtangyQueuePageNew');
        PageReference ref=ApexPages.currentPage();
        return ref;
    }
    
   public class QueueUsersCase{
       public integer closecasecount {get; set;}
       public integer opencasecount {get; set;}
       public string username {get; set;}
       public string userid {get; set;}
       public QueueUsersCase(user u)
       {
           username=u.Name;
           userid=u.Username;
           closecasecount = [select count() from case where status='Closed' AND ownerid=:u.id];
           opencasecount = [select count() from case where status !='Closed' AND ownerid=:u.id];
           
       }
       
   }
   /**** First Section Code End ******/
    

}