@isTest
private class CRUD_TEST {

    static testMethod void isRecordAccessible() {
        Test.startTest();
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);
       
        
        Boolean exceptionThrown;
        Opportunity accessibleOpp = new Opportunity(
            Name = 'An accessible Opportunity'
        );
        Opportunity inaccessibleOpp = new Opportunity(
            Name = 'An inaccessible Opportunity',
            ContractId = u.Id
        );

        System.runAs(u) {
            exceptionThrown = false;

            try {
                System.assertEquals(true, Crud.isAccessible(accessibleOpp),
                    'CRUD test failed for a accessible record');
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'CRUD test failed for a accessible record');
        }

        System.runAs(u) {
            exceptionThrown = false;

            try {
                Crud.isAccessible(inaccessibleOpp);
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'Exception not thrown for an inaccessible record');
        }

        Test.stopTest();
    }

    static testMethod void isRecordUpdateable() {
        Test.startTest();
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);
        
        Boolean exceptionThrown;
        Account updateableAcc = new Account(
            Name = 'An updateable Account'
        );

        System.runAs(u) {
            exceptionThrown = false;

            try {
                System.assertEquals(true, Crud.isUpdateable(updateableAcc),
                    'CRUD test failed for an updateable record');
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'CRUD test failed for an updateable record');
        }

        Test.stopTest();
    }

    static testMethod void isRecordCreatable() {
        Test.startTest();
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);
        
        Boolean exceptionThrown;
        Account creatableAcc = new Account(
            Name = 'Hello world'
        );

        System.runAs(u) {
            exceptionThrown = false;

            try {
                System.assertEquals(true, Crud.isCreateable(creatableAcc),
                    'CRUD test failed for a creatable record');
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'CRUD test failed for a creatable record');
        }

        Test.stopTest();
    }

    static testMethod void isRecordDeletable() {
        Test.startTest();
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);
        
        Boolean exceptionThrown;
        Account deletableRecord = new Account(
            Name = 'Hello account'
        );
        Case undeletableRecord = new Case();

        System.runAs(u) {
            exceptionThrown = false;

            try {
                System.assertEquals(true, Crud.isDeletable(deletableRecord),
                    'CRUD test failed for a deletabled record');
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'CRUD test failed for a deletable record');
        }

        System.runAs(u) {
            exceptionThrown = false;

            try {
                Crud.isDeletable(undeletableRecord);
            }
            catch(Exception e) {
                exceptionThrown = true;
            }

            System.assertEquals(false, exceptionThrown,
                'Exception not thrown for an undeletable record');
        }

        Test.stopTest();
    }
    
}