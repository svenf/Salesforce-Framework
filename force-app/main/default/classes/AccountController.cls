/**********************************************************************
 Name: AccountController
======================================================
Description: Example controller class to illustrate the usage of service and selector classes
***********************************************************************/
public with sharing class AccountController 
{
    @AuraEnabled    
    public static list<Account> getAccounts()
    {
        AccountService aservice = new AccountService();
        return aservice.getAccounts();
    }
}