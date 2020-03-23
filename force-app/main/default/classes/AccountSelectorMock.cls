/**********************************************************************
 Name: AccountSelectorMock
======================================================
Description: Mock version of the account selector. 
***********************************************************************/
public inherited sharing class AccountSelectorMock implements AccountInterface
{
    //List of accounts, which can be filled with accounts without inserting them to execute tests in a faster way
    public List<Account> lsAccounts = new List<Account>();
 
    //There is a selectById method in the real selector, which is also present in the interface, so it has to be implemented
    //Instead of performing the query, the method returns the list property
    public List<Account> selectByName(Set<String> lsAccountNames)
    {
        return lsAccounts;
    }    
}
