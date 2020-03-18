/**********************************************************************
 Name: AccountInterface
======================================================
Description: Interface to help with the mocking of queries of the account selector in test classes
***********************************************************************/
public interface AccountInterface 
{
    //Method to get the accounts by Id, to be implemented in the other classes
    List<Account> selectById(Set<String> lsAccountIds);    
} 