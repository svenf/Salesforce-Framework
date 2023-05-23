public without sharing class SObjectSelectorExample extends SObjectSelector {
    //Implementation of the abstract method to define the object to query on
    private Schema.SObjectType getSObjectType()
    {
        return Account.SObjectType;
    }      
}