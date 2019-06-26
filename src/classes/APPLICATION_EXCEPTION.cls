public with sharing class APPLICATION_EXCEPTION extends Exception {

    public static void notAccessible()
    {
        throw new APPLICATION_EXCEPTION('user do not have permission to ACCESS the data.');
    }
    
    public static void notCreateable()
    {
        throw new APPLICATION_EXCEPTION('user do not have permission to INSERT the data.');
    }
    
    public static void notUpdateable()
    {
        throw new APPLICATION_EXCEPTION('user do not have permission to UPDATE the data.');
    }
    
    public static void notDeleteable()
    {
        throw new APPLICATION_EXCEPTION('user do not have permission to DELETE the data.');
    }
}