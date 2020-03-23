/**********************************************************************
 Name: SObjectSelectorPaging_Test
======================================================
Description: Test class to test the paging logic in SObjectSelectorPaging
***********************************************************************/
@IsTest
private with sharing class SObjectSelectorPaging_Test 
{
    //Test the creation of ccPaging via the default constructor
    @IsTest
	static void testPagingCreation() 
	{
		Test.startTest();
		SObjectSelectorPaging paging = new SObjectSelectorPaging();
		Test.stopTest();

		System.assertEquals(1, paging.currentPage);
		System.assertEquals(10, paging.recordsPerPage);
		System.assert(!paging.enabled);
	}	

	//Test the change of the current page to a negative number
    @IsTest
    static void testPagingNegative() 
	{
        Test.startTest();
        SObjectSelectorPaging paging = new SObjectSelectorPaging();
		paging.currentPage = -20;
		Test.stopTest();

		System.assertEquals(1, paging.currentPage);
		System.assertEquals(10, paging.recordsPerPage);
		System.assert(!paging.enabled);
	}
}
