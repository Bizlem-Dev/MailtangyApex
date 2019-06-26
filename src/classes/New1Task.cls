@RestResource(urlMapping='/v1/create_task1')
global with sharing class New1Task
{
  /*  @HttpPost
    global static void newTask(String Assigned_To, String Subject, String Due_Date, String Priority, String Comments, String Status, String Name, String Related_To, String remindDate)       
    {
        RestResponse response = RestContext.response;
        Date sfDue_date;
        DateTime sfremind_date;
        try
        {
            if(String.isBlank(Assigned_To) || String.isBlank(Subject) || String.isBlank(Comments) || String.isBlank(Status))
            {
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','Missing data' );
                gen.writeStringField('error_description','Required parameters data are missing or blank.' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);
            }
            else
            {
                list<User> getusr = new list<User>();
                getusr = [SELECT id, Name from User where id =: Assigned_To];
                 //Case c1 = new case();

                if(getusr.size() < 1)
                {
                   // list<User> Usr = new list<User>();
                   // Usr = [SELECT Phone, Id FROM User WHERE Id = : UserInfo.getUserId()];
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error','incorrect data ');
                    gen.writeStringField('error_description','The given Assign_to Id is does not exist.' );
                    gen.writeEndObject();
                    String jsonString = gen.getAsString();
                    response.responseBody=blob.valueOf(jsonString);
                }
                else
                {
                    if(String.isNotBlank(Due_Date))
                    {
                        String[] ddate_time = Due_date.split('T');
                        if(ddate_time[0] != Null && ddate_time[1] != Null)
                        {
                            String ddate = ddate_time[0];
                            String dtime = ddate_time[1];
                            String[] sdate = ddate.split('-');
                            //String[] stime = dtime.split(':');
                            sfDue_date = Date.newInstance(Integer.valueOf(sdate[0]), Integer.valueOf(sdate[1]), Integer.valueOf(sdate[2]));
                        }
                    }
                    if(String.isNotBlank(remindDate))
                    {
                        String[] rdate_time = remindDate.split('T');
                        if(rdate_time[0] != Null && rdate_time[1] != Null)
                        {
                            String rdate = rdate_time[0];
                            String rtime = rdate_time[1];
                            String[] sdate = rdate.split('-');
                            String[] stime = rtime.split(':');
                            sfremind_date = Datetime.newInstance(Integer.valueOf(sdate[0]), Integer.valueOf(sdate[1]), Integer.valueOf(sdate[2]), Integer.valueOf(stime[0]), Integer.valueOf(stime[1]), Integer.valueOf(stime[2].replace('Z','')));
                        }
                    }
                    
                    Task api_task = new Task();
                    api_task.OwnerId = Assigned_To;
                    api_task.Subject = Subject;
                    api_task.ActivityDate = sfDue_date;
                    api_task.Priority = Priority;
                    api_task.Description = Comments;
                    api_task.Status = Status;
                    api_task.WhoId = Name;
                    api_task.WhatId = Related_To;
                    api_task.IsReminderSet = true;
                    api_task.ReminderDateTime = sfremind_date;
                    insert api_task;
                    
                    Task tsk = new Task();
                    tsk = [SELECT Id, OwnerId from task where Id =: api_task.id];
                    
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('message','Task created successfully' );
                    gen.writeStringField('ownerId',''+tsk.OwnerId);
                    gen.writeStringField('TaskId',''+tsk.Id );
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
            gen.writeStringField('error','Exception' );
            gen.writeStringField('error_description',''+ex.getMessage());
            gen.writeEndObject();
            String jsonString = gen.getAsString();
            response.responseBody=blob.valueOf(jsonString);
        }
    }*/
}