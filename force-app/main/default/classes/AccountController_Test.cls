/**********************************************************************
 Name: AccountController_Test
======================================================
Description: Test class for the account controller
 2 test methods to illustrate the performance difference between mocking and no mocking
***********************************************************************/
@IsTest
private with sharing class AccountController_Test 
{
    @IsTest
    private static void testNoMocking()
    {
        Account a1 = new Account(Name = 'Name1');
        insert a1;        
        
        List<Account> lsAccounts = AccountController.getAccounts();
        System.assertEquals(1, lsAccounts.size(), 'There should be 1 account returned.');
    }

    @IsTest
    private static void testMocking()
    {
        //Create a list of accounts without inserting them. Use the list to mock the queries.
        AccountSelectorMock mo = new AccountSelectorMock();
        mo.lsAccounts.add(new Account(Name = 'Name1'));
        AccountService.accountInstance = mo;
        
        List<Account> lsAccounts = AccountController.getAccounts();
        System.assertEquals(1, lsAccounts.size(), 'There should be 1 account returned.');
    }
}
