/**********************************************************************
Description: Test class for the SObjectDMLService
***********************************************************************/
@IsTest
private with sharing class SObjectDMLService_Test {
    @IsTest
    static void testInsert() 
	{
		Test.startTest();
		Account account = new Account();
        account.Name = 'test';
        
        SObjectDMLService dmlService = new SObjectDMLService();
        dmlservice.doInsert(new List<Account> {account});

		Test.stopTest();
        List<Account> lsAccounts = [SELECT Id FROM Account LIMIT 1];
        Assert.areEqual(1, lsAccounts.size(), '1 account was created');
	}

    @IsTest
    static void testUpdate() 
	{
		Test.startTest();
		Account account = new Account();
        account.Name = 'test';
        
        SObjectDMLService dmlService = new SObjectDMLService();
        dmlservice.doInsert(new List<Account> {account});

        account.Name = 'test2';
        dmlservice.doUpdate(new List<Account> {account});

		Test.stopTest();
        List<Account> lsAccounts = [SELECT Id FROM Account WHERE Name = 'test2' LIMIT 1];
        Assert.areEqual(1, lsAccounts.size(), 'The name of the account was updated');
	}

    @IsTest
    static void testDelete() 
	{
		Test.startTest();
		Account account = new Account();
        account.Name = 'test';
        
        SObjectDMLService dmlService = new SObjectDMLService();
        dmlservice.doInsert(new List<Account> {account});

        dmlservice.doDelete(new List<Account> {account});

		Test.stopTest();
        List<Account> lsAccounts = [SELECT Id, Name FROM Account LIMIT 1];        
        Assert.areEqual(0, lsAccounts.size(), 'The inserted account should be deleted');
	}
}