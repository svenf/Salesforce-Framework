/**********************************************************************
 Name: SObjectSelector
======================================================
Description: Abstract class for the selector layer to do queries
***********************************************************************/
@IsTest
private with sharing class SObjectSelector_Test 
{
    @IsTest
    static void testInit() 
	{
		Test.startTest();
		//We need to use a child class to create an instance
		AccountSelector accountSelector = new AccountSelector();

        //Verify if the object name is beign returned
        System.assertEquals('Account', accountSelector.getSObjectName());
        
        //Check if the paging logic is working as expected
        System.assertNotEquals(null, accountSelector.paging);
		System.assert(!accountSelector.paging.enabled);
		System.assertEquals('LIMIT 50000', accountSelector.getPagingString());

		accountSelector.paging.enabled = true;
		System.assertEquals('LIMIT 10 OFFSET 0', accountSelector.getPagingString());		

        //Check if the select logic is working as expected
		System.assertEquals('Id', accountSelector.getSelectString());

		accountSelector.lsSelectFields = new List<String> {'Name'};
        System.assertEquals('Name', accountSelector.getSelectString());
        System.assertEquals(null, accountSelector.getSoqlQuery());

        //Check if the order by logic is working as expected
		System.assertEquals('', accountSelector.getOrderByString());
		accountSelector.lsOrderByFields = new List<String> {'Name'};
        System.assertEquals('ORDER BY Name', accountSelector.getOrderByString());
        
        //Check if the group by logic is working as expected
        System.assertEquals('', accountSelector.getGroupByString());
		accountSelector.lsGroupByFields = new List<String> {'Name'};
        System.assertEquals('GROUP BY Name', accountSelector.getGroupByString());
        
        //Check if the security logic is working as expected
        System.assertEquals('WITH SECURITY_ENFORCED', accountSelector.getSecurityString());
        accountSelector.withSecurityEnforced = false;
        System.assertEquals('', accountSelector.getSecurityString());
        accountSelector.withSecurityEnforced = true;
        System.assertEquals('WITH SECURITY_ENFORCED', accountSelector.getSecurityString());
        
        //Check if the sobjectresult logic is working as expected
        SObjectSelectorResult objectResult = accountSelector.returnQueryresult(new List<Account> {new Account (Name = 'Test1')});
        System.assertEquals(1, objectResult.data.size());
        System.assertEquals(true, objectResult.paging.enabled);

		SObjectSelector.SObjectSelectorException exc = new SObjectSelector.SObjectSelectorException('message1');
		System.assertNotEquals(null, exc);

		Test.stopTest();
	}
}
