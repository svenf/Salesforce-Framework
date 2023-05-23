/**********************************************************************
Description: Test class to test the paging logic in SObjectSelectorResult
***********************************************************************/
@IsTest
private with sharing class SObjectSelectorResult_Test 
{
    @IsTest
    static void testConstructor()
    {
        Test.startTest();
        SObjectSelectorResult objectResult = new SObjectSelectorResult(new List<Account> {new Account (Name = 'Test1')});
        Assert.areEqual(1, objectResult.data.size(), 'One account was passed, so the data property should be equal to 1');        
        Assert.areEqual(1, objectResult.paging.currentPage, 'No paging instance was passed, so it creates an instance');
        Test.stopTest();
    }

    @IsTest
    static void testConstructor2()
    {
        Test.startTest();
        SObjectSelectorResult objectResult = new SObjectSelectorResult(new List<Account> {new Account (Name = 'Test1')}, new SObjectSelectorPaging());
        Assert.areEqual(1, objectResult.data.size(), 'One account was passed, so the data property should be equal to 1');        
        Assert.areEqual(1, objectResult.paging.currentPage, 'A paging instance was passed, so it uses the instance');
        Test.stopTest();
    }
}