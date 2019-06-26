public with sharing class UInfo 
{
    public String Name {get; set; }
    public String FName {get; set; }
    public String LName {get; set; }
    public String Email {get; set; }
    public String Role {get; set; }
    public String Company {get; set; }
    public String Title {get; set; }
    public String Ext {get; set; }
    public String Fax {get; set; }
    public String Mobile {get; set; }
    public String Phone {get; set; }
    Public Id uid;
   
    public UInfo()
    {
        uid = UserInfo.getUserId();
        User u = new User();
        u = [SELECT Extension,Fax,FirstName,LastName,Name,email,UserRole.Name,companyname,Title,Phone,Mobilephone FROM User where id=: uid ];
        if(!CRUD.isAccessible(u))
        {
            APPLICATION_EXCEPTION.notAccessible();
        }
        else
        {
        Name = u.Name;
        Fname = u.FirstName;
        LName = u.LastName;
        email = u.Email;
        Company = u.CompanyName;
        Title = u.Title;
        Ext = u.Extension;
        Fax = u.Fax;
        Phone = u.Phone;
        Mobile = u.MobilePhone;
        Role = u.userRole.Name;
        }
    }
}