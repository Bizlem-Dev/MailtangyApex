@isTest
public class LeadCreation_test 
{
	public testMethod  static void testPostMethod1()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/create_lead';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        LeadCreation.createLead('Mr.', 'First_Name', 'Last_Name', '9876543210', '9876543210', 'Company', '9876543210', 'Title', 'test@t.com', 'Phone', 'Website', 'Industry', 'New', 123, 'googd', 12, 'Street', 'City', 'State_province', 'Zip_Postal_Code', 'Country', 'Product_Interest', 'Current_Generator', 'SIC_Code', 'Primary', 2, 'Description');
    	Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String message = (String) result.get('message');

        System.assertEquals('Lead created successfully', message);
    }
    
    public testMethod  static void testPostMethod2()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        LeadCreation.createLead('Mr.', 'First_Name', 'Last_Name', '9876543210', '9876543210', 'Company', '9876543210', 'Title', 'wrongEmail', 'Phone', 'Website', 'Industry', 'New', 123, 'googd', 12, 'Street', 'City', 'State_province', 'Zip_Postal_Code', 'Country', 'Product_Interest', 'Current_Generator', 'SIC_Code', 'Primary', 2, 'Description');
    	Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Email is not in correct format.', error_description);
    }
    public testMethod  static void testPostMethod3()
    {
        RestRequest request = new RestRequest();
        RestResponse response =  new RestResponse();
        request.requestURI = 'https://ap5.salesforce.com/services/apexrest/bizlem/v1/case';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        LeadCreation.createLead('Mr.', 'First_Name', Null, '9876543210', '9876543210', 'Company', '9876543210', 'Title', 'test@t.com', 'Phone', 'Website', 'Industry', 'New', 123, 'googd', 12, 'Street', 'City', 'State_province', 'Zip_Postal_Code', 'Country', 'Product_Interest', 'Current_Generator', 'SIC_Code', 'Primary', 2, 'Description');
    	Test.stopTest();
        
        // Verify result
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString());
        String error_description = (String) result.get('error_description');

        System.assertEquals('Required parameters data are missing.', error_description);
    }
    
}