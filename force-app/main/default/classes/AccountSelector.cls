/**********************************************************************
 Name: AccountSelector
======================================================
Description: Selector class responsible for the Account queries. 
Use collections for parameters as much as possible to avoid queries for single and multiple Id's for instance
The implementation of the interface is needed to be able to use it for the assignment to the interface property in the service class
***********************************************************************/
public inherited sharing class AccountSelector extends SObjectSelector implements AccountInterface
{
    //Implementation of the abstract method to define the object to query on
    private Schema.SObjectType getSObjectType()
    {
        return Account.SObjectType;
    }  

    //Selector method to get the accounts based on a set of account names
    public List<Account> selectByname(Set<String> lsAccountNames)
    {
        soqlQuery = String.format(
            'SELECT {0} ' +
              'FROM {1} ' +
              'WHERE {4} ' +
              '{2} {3} ',
            new List<String> {
                getSelectString(),
                getSObjectName(),
                getOrderByString(),
                getSecurityString(),
                'Name IN :lsAccountnames'
            }
        );        
        return Database.query(soqlQuery);
    }
}
