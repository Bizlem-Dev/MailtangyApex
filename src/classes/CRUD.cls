public with sharing class CRUD {

    // Note: These numbers should correspond to a single binary bit being 1
    private static final Integer ISACCESSIBLE = 1;
    private static final Integer ISUPDATEABLE = 2;
    private static final Integer ISCREATEABLE = 4;
    private static final Integer ISDELETABLE = 8;

    public static Boolean checkPermission(List<sObject> records, Integer permissions) {
        
        boolean returnval = true;
        
        for (sObject record : records) {
            // Verify object-level permission
            Schema.DescribeSObjectResult objectDescribe = 
                record.getSObjectType().getDescribe();

            if ((permissions & ISACCESSIBLE) != 0 && !objectDescribe.isAccessible()) {
				returnval = false;                
            }

            if ((permissions & ISUPDATEABLE) != 0 && !objectDescribe.isUpdateable()) {
                returnval = false;
            }

            if ((permissions & ISCREATEABLE) != 0 && !objectDescribe.isCreateable()) {
                returnval = false;
            }

            if ((permissions & ISDELETABLE) != 0 && !objectDescribe.isDeletable()) {
                returnval = false;
            }

            // Verify field-level permission
            Map<String, Schema.SObjectField> allFields = objectDescribe.fields.getMap();
            Map<String, Object> populatedFields = record.getPopulatedFieldsAsMap();

            for (String fieldName : populatedFields.keySet()) {
                Schema.SObjectField sobjectField;
                Schema.DescribeFieldResult fieldDescribe;

                if (fieldName == 'Id')
                    continue;

                sobjectField = allFields.get(fieldName);

                if (sObjectField == null) {
                    System.debug('WARNING: CRUD: Field ' + fieldName + ' not found');
                    continue;
                }

                fieldDescribe = sobjectField.getDescribe();

                if ((permissions & ISACCESSIBLE) != 0 && !fieldDescribe.isAccessible()) {
                    returnval = false;
                }

                if ((permissions & ISUPDATEABLE) != 0 && !fieldDescribe.isUpdateable()) {
                    returnval = false;
                }

                if ((permissions & ISCREATEABLE) != 0 && !fieldDescribe.isCreateable()) {
                    returnval = false;
                }
            }

        }

        return returnval;
    }

    public static Boolean isAccessible(List<sObject> records) {
        return checkPermission(records, ISACCESSIBLE);
    }

    public static Boolean isAccessible(sObject record) {
        return isAccessible(new List<sObject> {record});
    }

    public static Boolean isUpdateable(List<sObject> records) {
        return checkPermission(records, ISUPDATEABLE);
    }

    public static Boolean isUpdateable(sObject record) {
        return isUpdateable(new List<sObject> {record});
    }

    public static Boolean isCreateable(List<sObject> records) {
        return checkPermission(records, ISCREATEABLE);
    }

    public static Boolean isCreateable(sObject record) {
        return isCreateable(new List<sObject> {record});
    }

    public static Boolean isDeletable(List<sObject> records) {
        return checkPermission(records, ISDELETABLE);
    }

    public static Boolean isDeletable(sObject record) {
        return isDeletable(new List<sObject> {record});
    }

    public class PermissionException extends Exception {}

}