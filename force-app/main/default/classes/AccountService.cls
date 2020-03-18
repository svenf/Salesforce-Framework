/**********************************************************************
 Name: AccountService
======================================================
Description: Service class around Account, mainly to illustrate the usage of selectors via interfaces to allow the mocking of queries in test classes
***********************************************************************/
public with sharing class AccountService 
{
    //Property to hold the instance of the necessary selector classes. Test visible has been set to allow a different assignment to mock the queries
    @TestVisible
    private static AccountInterface accountInstance = new AccountSelector();
    
    //Method to call the right query from the selector class and return the results
    public List<Account> getAccounts()
    {
        return accountInstance.selectById(new Set<String> {'Name1'});
    }
}
