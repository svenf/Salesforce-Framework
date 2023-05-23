/**********************************************************************
Description: Test class for the SObjectSelector
***********************************************************************/
@IsTest
private with sharing class SObjectSelector_Test 
{
    @TestSetup
    static void makeData(){
        Account account = new Account();
        account.Name = 'test';
        insert account;
    }
    
    @IsTest
    static void testInit() 
	{
		Test.startTest();
		//We need to use a child class to create an instance
		SObjectSelectorExample exampleSelector = new SObjectSelectorExample();

        //Verify if the object name is beign returned
        Assert.areEqual('Account', exampleSelector.getSObjectName(), 'The object name should match Account');
        
        //Check if the paging logic is working as expected
        System.assertNotEquals(null, exampleSelector.paging);
		System.assert(!exampleSelector.paging.enabled);
		Assert.areEqual('LIMIT 50000', exampleSelector.getPagingString(), 'The default limit is 50000');

		exampleSelector.paging.enabled = true;
		Assert.areEqual('LIMIT 10 OFFSET 0', exampleSelector.getPagingString(), 'The default limit and offset are 10 and 0');		

        //Check if the select logic is working as expected
		Assert.areEqual('Id', exampleSelector.getSelectString(), 'The default selected field is Id');

		exampleSelector.lsSelectFields = new List<String> {'Name'};
        Assert.areEqual('Name', exampleSelector.getSelectString(), 'Name was passed as SELECT Field');
        Assert.areEqual(null, exampleSelector.soqlQuery, 'The string for the query has not been set yet');

        //Check if the order by logic is working as expected
		Assert.areEqual('', exampleSelector.getOrderByString(), 'By default there is no ordering');
		exampleSelector.lsOrderByFields = new List<String> {'Name'};
        Assert.areEqual('ORDER BY Name', exampleSelector.getOrderByString(), 'Name was set as ORDER BY field');
        
        //Check if the group by logic is working as expected
        Assert.areEqual('', exampleSelector.getGroupByString(), 'By default there is no grouping');
		exampleSelector.lsGroupByFields = new List<String> {'Name'};
        Assert.areEqual('GROUP BY Name', exampleSelector.getGroupByString(), 'Name was set as GROUP BY field');  
        
        //Check if the sobjectresult logic is working as expected
        SObjectSelectorResult objectResult = exampleSelector.returnQueryresult(new List<Account> {new Account (Name = 'Test1')});
        Assert.areEqual(1, objectResult.data.size(), '1 account should be found, so the wrapper property should indicate 1');
        Assert.areEqual(true, objectResult.paging.enabled, 'We are using the queryResult wrapper, so the paging should be enabled by default');

		SObjectSelector.SObjectSelectorException exc = new SObjectSelector.SObjectSelectorException('message1');
		System.assertNotEquals(null, exc, 'The exception was initialized');

        exampleSelector.soqlQuery = 'SELECT Id FROM Account';
        List<Account> lsAccounts = exampleSelector.doQuery();
        Assert.areEqual(1, lsAccounts.size(), '1 account should be returned');

        exampleSelector.soqlQuery = 'SELECT Id FROM Account WHERE Name = :name';
        lsAccounts = exampleSelector.doQueryWithBinds(new Map<String, Object>{'name' => 'test'});
        Assert.areEqual(1, lsAccounts.size(), '1 account should be returned');
        
        exampleSelector.soqlQuery = 'SELECT count() FROM Account';        
        Integer accountCount = exampleSelector.doCountQuery();
        Assert.areEqual(1, accountCount, 'There is 1 account, so the size should be 1');

        exampleSelector.soqlQuery = 'SELECT count() FROM Account WHERE Name = :name';          
        accountCount = exampleSelector.doCountQueryWithBinds(new Map<String, Object>{'name' => 'test'});
        Assert.areEqual(1, accountCount, 'There is 1 account, so the size should be 1');

        exampleSelector.soqlQuery = 'SELECT Name FROM Account GROUP BY Name';          
        List<AggregateResult> lsAggregates = exampleSelector.doAggregateQuery();
        Assert.areEqual(1, lsAggregates.size(), 'There is 1 account, so there should be 1 aggregate result');

        exampleSelector.soqlQuery = 'SELECT Name FROM Account WHERE Name = :name GROUP BY Name';          
        lsAggregates = exampleSelector.doAggregateQueryWithBinds(new Map<String, Object>{'name' => 'test'});
        Assert.areEqual(1, lsAggregates.size(), 'There is 1 account, so there should be 1 aggregate result');

		Test.stopTest();
	}
}