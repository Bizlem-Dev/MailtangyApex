@RestResource(urlMapping='/v1/create_lead')
global with sharing class LeadCreation 
{
    Static Boolean check = true;
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
    global static void createLead(String Salutation, String First_Name, String Last_Name, String Phone, String Mobile, 
                                  String Company, String Fax, String Title, String Email, String Lead_Source, String Website, 
                                  String Industry, String Lead_Status, Integer Annual_Revenue, String Rating, 
                                  Integer No_of_Employees, String Street, String City, String State_province, 
                                  String Zip_Postal_Code,String Country, String Product_Interest, String Current_Generator,
                                  String SIC_Code,String Primary, Integer Number_of_Locations, String Description)
    {
        RestResponse response = RestContext.response;
        
        if(String.isNotBlank(Email))
        {
            if(!validateEmail(email))
            {
                check = false;
                response.statusCode=400;
                JSONGenerator gen= JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('error','Wrong Email' );
                gen.writeStringField('error_description','Email is not in correct format.' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);   
                
            }
        }
        if(check == true)
        {
            if(String.isNotBlank(Last_Name) && String.isNotBlank(Company) && String.isNotBlank(Lead_Status))
            {
                try{
                    Lead led =  new Lead();
                    led.Salutation = Salutation;
                    led.FirstName = First_Name;
                    led.LastName = Last_Name;
                    led.Phone = Phone;
                    led.MobilePhone = Mobile;
                    led.Company = Company;
                    led.Fax = Fax;
                    led.Title = Title;
                    led.Email = Email;
                    led.LeadSource = Lead_Source;
                    led.Website = Website;
                    led.Industry = Industry;
                    led.Status = Lead_Status; 
                    led.AnnualRevenue = Annual_Revenue;
                    led.Rating = Rating;
                    led.NumberOfEmployees = No_of_Employees; 
                    led.Street = Street; 
                    led.City = City;
                    led.State = State_province;
                    led.PostalCode = Zip_Postal_Code;
                    led.Country = Country;
                    led.Lead_ProductInterest__c = Product_Interest;
                    led.Lead_CurrentGenerators__c = Current_Generator;
                    led.Lead_SICCode__c = SIC_Code;
                    led.Lead_Primary__c = Primary;
                    led.Lead_NumberofLocations__c = Number_of_Locations;
                    led.Description = Description;
                    
                    if(!CRUD.isCreateable(led))
                    {
                        APPLICATION_EXCEPTION.notCreateable();
                    }
                    else
                    {
                        insert led;
                        
                        Lead l1 = new Lead();
                        l1 = [SELECT id, Lead_No__c, OwnerID from LEAD where id =: led.Id];
                        response.statusCode =200;
                        JSONGenerator gen =  JSON.createGenerator(true);
                        gen.writeStartObject();
                        gen.writeStringField('message','Lead created successfully' );
                        gen.writeStringField('ownerId',''+l1.OwnerId );
                        gen.writeStringField('Lead_No.',''+l1.Lead_No__c );
                        gen.writeStringField('LeadId',''+l1.Id );
                        gen.writeEndObject();
                        String jsonString = gen.getAsString();
                        response.responseBody=blob.valueOf(jsonString);
                    }
                }
                catch(Exception ex)
                {
                    response.statusCode=400;
                    JSONGenerator gen= JSON.createGenerator(true);
                    gen.writeStartObject();
                    gen.writeStringField('error',String.valueOf(ex) );
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
                gen.writeStringField('error','Missing data' );
                gen.writeStringField('error_description','Required parameters data are missing.' );
                gen.writeEndObject();
                String jsonString = gen.getAsString();
                response.responseBody=blob.valueOf(jsonString);
            }
        }
    }
}