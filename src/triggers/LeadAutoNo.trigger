trigger LeadAutoNo on Lead (before insert) 
{
    List<last_Lead_no__c> lno = last_Lead_no__c.getall().values();
    String lastValue = '';
    try
    {
        if(lno.size() == 0)
        {
            Integer tempVal = 1;
            for(Lead led : Trigger.New)
            {
                led.Lead_No__c = 'L-'+(tempVal);
                tempVal = tempVal+1;
            }
            
            last_Lead_no__c l = new last_Lead_no__c();
            l.Name = 'lastno';
            l.leadNo__c = String.valueOf(tempVal-1);
            
            if(!CRUD.isCreateable(l))
            {
                APPLICATION_EXCEPTION.notCreateable();
            }
            else
            {
                insert l;
            }
        }
        else
        {
            lastValue = lno[0].leadNo__c;
            for(Lead led : Trigger.New)
            {
                lastValue = String.valueOf(Integer.valueOf(lastValue)+1);
                led.Lead_No__c = 'L-'+lastValue;
            }
            lno[0].leadNo__c = lastValue;
            update lno;
        }
    }
    catch(Exception ex)
    {
        System.debug(ex.getCause());
        System.debug(ex.getMessage());
    }
}